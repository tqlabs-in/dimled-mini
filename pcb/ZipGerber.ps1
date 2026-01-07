$gerberPath = Join-Path (Get-Location) "output/gerber"
$manufacturingPath = Join-Path (Get-Location) "manufacturing"

# Ensure source folder exists
if (-not (Test-Path $gerberPath)) {
    Write-Error "No 'output/gerber' folder found in the current directory."
    exit 1
}

# Ensure manufacturing output folder exists
if (-not (Test-Path $manufacturingPath)) {
    New-Item -ItemType Directory -Path $manufacturingPath | Out-Null
}

# Get the name of the current directory (used as zip name)
$parentDir = Split-Path (Get-Location) -Leaf
$zipName = "$parentDir.zip"

# Full output path for the zip
$zipPath = Join-Path $manufacturingPath $zipName

# Remove existing zip if it exists
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}

# Create the zip from the contents of ./output/gerber
Compress-Archive -Path (Join-Path $gerberPath '*') -DestinationPath $zipPath

Write-Host "Created archive: $zipPath"

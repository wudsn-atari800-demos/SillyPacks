echo off
cd /D "%~dp0"
set LATEST=SillyPack2k22SE
rem Older packs before SillyPack2k22SE use a different structure and cannot be updated from the LATEST
rem call :make_pack SillyPack2k12
rem call :make_pack SillyPack2k13
rem call :make_pack SillyPack2k14
rem call :make_pack SillyPack2k16
rem call :make_pack SillyPack2k17
rem call :make_pack SillyPack2k18
rem call :make_pack SillyPack2k19
rem call :make_pack SillyPack2k20_1SE
rem call :make_pack SillyPack2k21WE

rem call :make_pack SillyPack2k22SE
call :make_pack SillyPack2k22WE
call :make_pack SillyPack2k23SE
pause
goto :eof


:make_pack
cd ..
set PACK=%1
echo Making %PACK% with menu from %LATEST%.
if not %PACK%==%LATEST% (
  call :copy %LATEST%\.gitignore %PACK%
  call :copy %LATEST%\Make-Settings.bat %PACK%
  call :copy %LATEST%\Make-Images.bat %PACK%
  call :copy %LATEST%\images\Template.png %PACK%\images
  call :copy %LATEST%\site\Makefile-Site.bat %PACK%\site
  call :copy %LATEST%\asm\*.asm %PACK%\asm
  call :copy %LATEST%\atr\hias\*.* %PACK%\atr\hias
)

cd %PACK%\site
call Makefile-Site.bat
cd ..\..\SillyPacks
goto :eof

:copy
  set SOURCE_FILE=%1
  set TARGET_FILE=%2
  echo Copying %1 to %2.
  copy /Y /B  %SOURCE_FILE% %TARGET_FILE% >NUL
  if ERRORLEVEL 1 goto :copy_error
goto :eof

:copy_error
echo ERROR: During copying %SOURCE_FILE% to %TARGET_FILE%.
pause
exit


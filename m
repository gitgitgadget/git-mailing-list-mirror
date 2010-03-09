From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Tue, 9 Mar 2010 19:24:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 19:25:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np471-0006QW-Mr
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 19:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab0CISYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 13:24:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:39857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751319Ab0CISYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 13:24:53 -0500
Received: (qmail invoked by alias); 09 Mar 2010 18:24:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 09 Mar 2010 19:24:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DjeReHMhDqesuRFHoeioyMpSnUQsG/77WOOCayq
	QUL3qCFBmiCrab
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46000000000000002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141839>

Git Release Notes (Git-1.7.0.2-preview20100309)
Last update: 9 March 2010

Known issues

- Some commands are not yet supported on Windows and excluded from the 
  installation; namely: git archimport, git cvsexportcommit, git 
  cvsimport, git cvsserver, git instaweb, git shell.

- The Logitec QuickCam software can cause spurious crashes. See "Why does 
  make often crash creating a sh.exe.stackdump file when I try to compile 
  my source code?" on the MinGW Wiki 
  (http://www.mingw.org/wiki/Environment_issues)

- The Quick Launch icon will only be installed for the user running setup 
  (typically the Administrator). This is a technical restriction and will 
  not change.

- curl uses $HOME/_netrc instead of $HOME/.netrc.

- If you want to specify a different location for --upload-pack, you have 
  to start the absolute path with two slashes. Otherwise MSys will mangle 
  the path. git and bash have serious problems with non-ASCII file names 
  (Issue 80, 159).

- If configured to use plink, you will have to connect with putty first 
  and accept the host key.

- When run from cmd.exe instead of Git Bash, some characters seem to be 
  "swallowed" from Git's output (Issue 192).

- There are a spurious write errors during rebase (Issue 200) that seem 
  not to be reproducible on most computers.

- As merge tools are executed using the MSys bash, options starting with 
  "/" need to be handled specially: MSys would interpret that as a POSIX 
  path, so you need to double the slash (Issue 226).  Example: instead of 
  "/base", say "//base".  Also, extra care has to be paid to pass Windows 
  programs Windows paths, as they have no clue about MSys style POSIX 
  paths -- You can use something like $(cmd //c echo "$POSIXPATH").

Changes since Git-1.6.5.1-preview20091022

New Features

- Comes with official Git 1.7.0.2.

- Comes with Git-Cheetah (on 32-bit Windows only, for now).

- Comes with connect.exe, a SOCKS proxy.

- Tons of improvements in the installer, thanks to Sebastian Schuberth.

- On Vista, if possible, symlinks are used for the built-ins.

- Features Hany's dos2unix tool, thanks to Sebastian Schuberth.

- Updated Tcl/Tk to version 8.5.8 (thanks Pat Thoyts!).

- By default, only .git/ is hidden, to work around a bug in Eclipse 
  (thanks to Erik Faye-Lund).

Bugfixes

- Fixed threaded grep (thanks to Heiko Voigt).

- git gui was fixed for all kinds of worktree-related failures (thanks Pat 
  Thoyts).

- git gui now fully supports themed widgets (thanks Pat Thoyts and Heiko 
  Voigt).

- Git no longer complains about an unset RUNTIME_PREFIX (thanks Johannes 
  Sixt).

- git gui can Explore Working Copy on Windows again (thanks Markus 
  Heidelberg).

- git gui can create shortcuts again (fixes issue 425, thanks Heiko 
  Voigt).

- When "git checkout" cannot overwrite files because they are in use, it 
  will offer to try again, giving the user a chance to release the file 
  (thanks Heiko Voigt).

- Ctrl+W will close gitk (thanks Jens Lehmann).

- git gui no longer binds Ctrl+C, which caused problems when trying to use 
  said shortcut for the clipboard operation "Copy" (fixes issue 423, 
  thanks Pat Thoyts).

- gitk does not give up when the command line length limit is reached 
  (issue 387).

- The exit code is fixed when Git.cmd is called from cmd.exe (thanks 
  Alexey Borzenkov).

- When launched via the (non-Cheetah) shell extension, the window icon is 
  now correct (thanks Sebastian Schuberth).

- Uses a TrueType font for the console, to be able to render UTF-8 
  correctly.

- Clarified the installer's line ending options (issue 370).

- Substantially speeded up startup time from cmd unless NO_FSTAB_THREAD is 
  set (thanks Johannes Sixt).

- Update msys-1.0.dll yet again, to handle quoted parameters better 
  (thanks Heiko Voigt).

- Updated cURL to a version that supports SSPI.

- Updated tar to handle the pax headers generated by git archive.

- Updated sed to a version that can handle the filter-branch examples.

- .git* files can be associated with the default text editor (issue 397).

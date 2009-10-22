From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git 1.6.5.1 for Windows
Date: Fri, 23 Oct 2009 01:29:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910230117160.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 01:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1735-00061U-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 01:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbZJVX0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 19:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZJVX0R
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 19:26:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:42532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751028AbZJVX0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 19:26:16 -0400
Received: (qmail invoked by alias); 22 Oct 2009 23:26:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 23 Oct 2009 01:26:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kG6hP9oAkk6xf03757uLQFePrRzyzk8o3jHdyCB
	tM+6o+aIdr5XCB
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131076>

Git Release Notes (Git-1.6.5.1-preview20091022)
Last update: 22 October 2009

Find it at http://code.google.com/p/msysgit/downloads/list

These release notes describe issues specific to the Windows release.

General release notes covering the history of the core git commands are
included in the subdirectory doc/git/html of the installation directory.
Look for files starting with RelNotes.

Known issues

- Some commands are not yet supported on Windows and excluded from the
  installation; namely: git archimport, git cvsexportcommit, git cvsimport,
  git cvsserver, git instaweb, git shell.

- The Logitec QuickCam software can cause spurious crashes. See "Why does
  make often crash creating a sh.exe.stackdump file when I try to compile my
  source code?" on the MinGW Wiki
  (http://www.mingw.org/wiki/Environment_issues)

- The Quick Launch icon will only be installed for the user running setup
  (typically the Administrator). This is a technical restriction and will
  not change.

- Git Bash launched through the Explorer shell extension does not have the
  git icon in its taskbar. This is a technical restriction and will not
  change.

- curl uses $HOME/_netrc instead of $HOME/.netrc.

- If you want to specify a different location for --upload-pack, you have to
  start the absolute path with two slashes. Otherwise MSys will mangle the
  path.

- git and bash have serious problems with non-ASCII file names (Issue 80,
  159).

- If configured to use plink, you will have to connect with putty first and
  accept the host key.

- When run from cmd.exe instead of Git Bash, some characters seem to be
  "swallowed" from Git's output (Issue 192).

- There are a spurious write errors during rebase (Issue 200) that seem not
  to be reproducible on most computers.

- As merge tools are executed using the MSys bash, options starting with "/"
  need to be handled specially: MSys would interpret that as a POSIX path,
  so you need to double the slash (Issue 226).  Example: instead of "/base",
  say "//base".  Also, extra care has to be paid to pass Windows programs
  Windows paths, as they have no clue about MSys style POSIX paths -- You can
  use something like $(cmd //c echo "$POSIXPATH").


Changes since Git-1.6.4-preview20090729

New Features

- Comes with official git 1.6.5.1.

- Thanks to Johan 't Hart, files and directories starting with a single dot
  (such as '.git') will now be marked hidden (you can disable this setting
  with core.hideDotFiles=false in your config) (Issue 288).

- Thanks to Thorvald Natvig, Git on Windows can simulate symbolic links by
  using reparse points when available.  For technical reasons, this only
  works for symbolic links pointing to files, not directories.

- A lot of work has been put into making it possible to compile Git's source
  code (the part written in C, of course, not the scripts) with Microsoft
  Visual Studio.  This work is ongoing.

- Thanks to Sebastian Schuberth, we only offer the (Tortoise)Plink option in
  the installer if the presence of Plink was detected and at least one Putty
  session was found (Issue 319).

- Thanks to Sebastian Schuberth, the installer has a nicer icon now.


Bugfixes

- Thanks to Sebastian Schuberth, git svn picks up the SSH setting specified
  with the installer (Issue 305).

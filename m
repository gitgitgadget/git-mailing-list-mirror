From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 02:10:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sun Mar 08 02:10:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7Wz-0007Ua-O7
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZCHBIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbZCHBIu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:08:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:35328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751707AbZCHBIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:08:49 -0500
Received: (qmail invoked by alias); 08 Mar 2009 01:08:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 08 Mar 2009 02:08:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YRSF5lQFYSYrvS6s2/iC3RH4Spq+rvebMYwToTM
	tR4FuCRVXNXx07
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112602>

Hi,

I just released a new version of Git for Windows (TAFKA WinGit).  It is 
basically Git 1.6.2 plus a few patches.  Please find the installer here:

	http://msysgit.googlecode.com/

Disclaimer: Git for Windows is still in a state where I do _not_ recommend 
using it unless you have the means to fix issues.  Unlike git.git 
developer community, the msysGit team is heavily undermanned.

Known issues

- Some commands are not yet supported on Windows and excluded from the 
  installation; namely: git archimport, git cvsexportcommit, git 
  cvsimport, git cvsserver, git filter-branch, git instaweb, git 
  send-email, git shell.

- The Logitec QuickCam software can cause spurious crashes. See "Why does 
  make often crash creating a sh.exe.stackdump file when I try to compile 
  my source code?" in the MinGW FAQs 
  (http://www.mingw.org/MinGWiki/index.php/FAQ).

- The Quick Launch icon will only be installed for the user running setup 
  (typically the Administrator). This is a technical restriction and will 
  not change.

- Git Bash launched through the Explorer shell extension does not have the 
  git icon in its taskbar. This is a technical restriction and will not 
  change.

- git send-mail does not work properly (Issue 27).

- curl uses $HOME/_netrc instead of $HOME/.netrc.

- If you want to specify a different location for --upload-pack, you have 
  to start the absolute path with two slashes. Otherwise MSys will mangle 
  the path.

- git clone fails when the repository contains UTF-8 filepaths (Issue 80).

Changes since Git-1.6.1-preview20081225

New Features
- Comes with official git 1.6.2.
- Comes with upgraded vim 7.2.
- Compiled with GCC 4.3.3.
- The user can choose the preferred CR/LF behavior in the installer now.
- Peter Kodl contributed support for hardlinks on Windows.
- The bash prompt now shows information about the current repository.

Bugfixes
- If supported by the file system, pack files can grow larger than 2gb.
- Comes with updated msys-1.0.dll (should fix some Vista issues).
- Assorted fixes to support the new libexec/git-core/ layout better.
- Read-only files can be properly replaced now.
- git-svn is included again (original caveats still apply).
- Obsolete programs from previous installations are cleaned up.


So what are the next steps?

Hannes is busy sorting out the differences between the test suites in 
git.git and mingw.git.

Thanks to the awesome efforts of both Hannes and Steffen, the rest of the 
differences are really small (the biggest being Peter's hard link patch).  
I'll try to put together a patch series in the next few weeks.

Ciao,
Dscho

From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-1.2.1
Date: Sat, 24 Aug 2013 17:07:44 +0200
Message-ID: <20130824150744.GA18899@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 17:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDFRX-0002zv-Oy
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 17:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab3HXPHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 11:07:55 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:48587 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176Ab3HXPHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 11:07:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 4CF5519BCF9
	for <git@vger.kernel.org>; Sat, 24 Aug 2013 17:07:53 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13131-03 for <git@vger.kernel.org>; Sat, 24 Aug 2013 17:07:44 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id B3A9119BCF3
	for <git@vger.kernel.org>; Sat, 24 Aug 2013 17:07:44 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 0A5316DFAB2
	for <git@vger.kernel.org>; Sat, 24 Aug 2013 17:07:04 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 9DB9F2AB1F; Sat, 24 Aug 2013 17:07:44 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232886>

Hello,

Due to a bug in the handling of submodules, here is a new release of
Tig. In addition to the bug fix, this new version reduces memory usage
and startup time of the main view and shows the blob size in the tree
view.

Note to packagers: the manual and manpage documentation files now live
inside the doc/ directory and and have .asciidoc as the extension. The
SITES file has been removed as its content has been merged into README.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

Resources
---------

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://github.com/jonas/tig.git 
 - Gitweb:	http://repo.or.cz/w/tig.git
 - Q&A:		http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Incompatibilities:

 - Move manual and man pages to doc/ directory and rename AsciiDoc files
   to have .asciidoc as the extension to make them render on GitHub.

Improvements:

 - Show blob sizes in the tree view either as bytes or using binary unit
   prefixes. Example: `set show-file-size = units`. (GH #163)
 - Reduce main view memory usage and startup time, especially when revision
   graph rendering is disabled. (GH #160)

Bug fixes:

 - Fix submodule-related setup to check for non-zero return value from
   setenv(). (GH #188)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .gitignore                     |   18 +-
 BUGS                           |    4 +-
 INSTALL                        |   92 +++--
 Makefile                       |   76 ++--
 NEWS                           |   62 ++-
 README                         |   28 +-
 SITES                          |    7 -
 asciidoc.conf                  |   65 ---
 contrib/announcement.sh        |   11 +-
 contrib/aspell.dict            |   18 +-
 contrib/config.make            |   16 +
 contrib/config.make-Darwin     |    5 +
 contrib/tig.spec.in            |    6 +-
 contrib/update-release-docs.sh |    6 +-
 doc/asciidoc.conf              |   65 +++
 doc/manual.asciidoc            |  606 +++++++++++++++++++++++++
 doc/tig.1.asciidoc             |  195 ++++++++
 doc/tigmanual.7.asciidoc       |   20 +
 doc/tigrc.5.asciidoc           |  757 ++++++++++++++++++++++++++++++++
 manual.txt                     |  604 -------------------------
 tig.1.txt                      |  176 --------
 tig.c                          |  333 +++++++++++----
 tigmanual.7.txt                |   20 -
 tigrc.5.txt                    |  736 -------------------------------
 24 files changed, 2119 insertions(+), 1807 deletions(-)

Dan Church (1):
      Fix man page install

Jonas Fonseca (19):
      Move documentation to doc directory
      Rework README to include the list of online resources
      Fix submodule-related setup to properly check setenv return value
      Fix path to sysconfdir-based gitconfig in tig(1)
      Fix HTML doc installation
      Ignore *.swp files and restrict to only ignore top-level config.make
      Add work-around for building manpages with Homebrew-based xmlto
      Improve the installation instructions
      Show blob sizes in the tree view
      Ignore generated HTML files in the whole tree
      Dynamically allocate commit titles to reduce memory usage
      Postpone ref list lookup to the draw phase
      Bypass all graph calls and memory allocations when the graph is disabled
      Free graph symbols when reloading the main view
      Remove the dont_free line struct flag in favor of custom help_done
      Fix regression that skipped commits with no messages
      Simplify the install goal and rename $(PROGS) to $(EXE)
      Use capitalized Git and Tig when talking about the systems in general
      tig-1.2.1

-- 
Jonas Fonseca

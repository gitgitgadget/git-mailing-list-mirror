From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] git-gui 0.7.0-rc1
Date: Tue, 8 May 2007 00:05:51 -0400
Message-ID: <20070508040551.GJ11311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 06:06:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGxi-0005AZ-85
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967754AbXEHEF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967763AbXEHEF4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:05:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53817 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967754AbXEHEFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 00:05:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlGxI-000831-NZ; Tue, 08 May 2007 00:05:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 937E720FBAE; Tue,  8 May 2007 00:05:51 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46532>

There have been a good deal of changes in git-gui recently.
Most significantly within the inner workings.  The code has been
refactored into multiple files and I'm starting to make use of the
auto_load feature of Tcl, as well as Tcl namespaces.  As you can
see by the diffstat below I moved over 4000 lines out of git-gui.sh
and into other files.  ;-)

There were some minor tweaks to the git-gui Makefile variable
handling so I have pre-merged git-gui.git's master into git.git
master, handling those tweaks as part of the merge.  After pulling
it in you may also want to fetch from git-gui.git to grab the
gitgui-0.7.0-rc1 tag.

I'm tagging this release as rc1 as I hope to get a few more
improvements in this week, before I call it 0.7.0 final.

---

The following changes since commit 3082acfa7c626a34aa419a163585051c2df2bf09:
  Alex Riesen (1):
        Use GIT_OBJECT_DIR for temporary files of pack-objects

are available in the git repository at:

  repo.or.cz:/srv/git/git/fastimport.git gitgui-master

Shawn O. Pearce (16):
      git-gui: Include the subject in the status bar after commit
      git-gui: Warn users before making an octopus merge
      git-gui: Correct line wrapping for too many branch message
      git-gui: Cleanup common font handling for font_ui
      git-gui: Use option database defaults to set the font
      git-gui: Refactor to use our git proc more often
      git-gui: Track our own embedded values and rebuild when they change
      git-gui: Refactor into multiple files to save my sanity
      git-gui: Move console procs into their own namespace
      git-gui: Allow vi keys to scroll the diff/blame regions
      git-gui: Move merge support into a namespace
      git-gui: Show all possible branches for merge
      git-gui: Include commit id/subject in merge choices
      git-gui: Use vi-like keys in merge dialog
      Merge branch 'master' of git://repo.or.cz/git-gui
      Remove duplicate exports from Makefile

 Makefile                  |   18 +-
 git-gui/.gitignore        |    2 +
 git-gui/Makefile          |   38 +-
 git-gui/git-gui.sh        | 4121 ++-------------------------------------------
 git-gui/lib/blame.tcl     |  407 +++++
 git-gui/lib/branch.tcl    |  572 +++++++
 git-gui/lib/browser.tcl   |  263 +++
 git-gui/lib/commit.tcl    |  410 +++++
 git-gui/lib/console.tcl   |  201 +++
 git-gui/lib/database.tcl  |   89 +
 git-gui/lib/diff.tcl      |  336 ++++
 git-gui/lib/error.tcl     |  101 ++
 git-gui/lib/index.tcl     |  409 +++++
 git-gui/lib/merge.tcl     |  309 ++++
 git-gui/lib/option.tcl    |  290 ++++
 git-gui/lib/remote.tcl    |  159 ++
 git-gui/lib/shortcut.tcl  |  141 ++
 git-gui/lib/transport.tcl |  164 ++
 18 files changed, 4009 insertions(+), 4021 deletions(-)
 create mode 100644 git-gui/lib/blame.tcl
 create mode 100644 git-gui/lib/branch.tcl
 create mode 100644 git-gui/lib/browser.tcl
 create mode 100644 git-gui/lib/commit.tcl
 create mode 100644 git-gui/lib/console.tcl
 create mode 100644 git-gui/lib/database.tcl
 create mode 100644 git-gui/lib/diff.tcl
 create mode 100644 git-gui/lib/error.tcl
 create mode 100644 git-gui/lib/index.tcl
 create mode 100644 git-gui/lib/merge.tcl
 create mode 100644 git-gui/lib/option.tcl
 create mode 100644 git-gui/lib/remote.tcl
 create mode 100644 git-gui/lib/shortcut.tcl
 create mode 100644 git-gui/lib/transport.tcl
-- 
Shawn.

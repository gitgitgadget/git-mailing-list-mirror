From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.0.1
Date: Sun, 18 Feb 2007 18:07:42 -0800
Message-ID: <7vwt2ec32p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 03:07:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIxwZ-00044w-6g
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 03:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbXBSCHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 21:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbXBSCHq
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 21:07:46 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48451 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbXBSCHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 21:07:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219020744.YBBS1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 21:07:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RE7j1W00F1kojtg0000000; Sun, 18 Feb 2007 21:07:44 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40093>

The latest maintenance release GIT 1.5.0.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.0.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.0.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.0.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.0.1-1.$arch.rpm	(RPM)

GIT v1.5.0.1 Release Notes
==========================

Fixes since v1.5.0
------------------

* Documentation updates

  - Clarifications and corrections to 1.5.0 release notes.

  - The main documentation did not link to git-remote documentation.

  - Clarified introductory text of git-rebase documentation.

  - Converted remaining mentions of update-index on Porcelain
    documents to git-add/git-rm.

  - Some i18n.* configuration variables were incorrectly
    described as core.*; fixed.

* Bugfixes

  - git-add and git-update-index on a filesystem on which
    executable bits are unreliable incorrectly reused st_mode
    bits even when the path changed between symlink and regular
    file.

  - git-daemon marks the listening sockets with FD_CLOEXEC so
    that it won't be leaked into the children.

  - segfault from git-blame when the mandatory pathname
    parameter was missing was fixed; usage() message is given
    instead.

  - git-rev-list did not read $GIT_DIR/config file, which means
    that did not honor i18n.logoutputencoding correctly.

* Tweaks

  - sliding mmap() inefficiently mmaped the same region of a
    packfile with an access pattern that used objects in the
    reverse order.  This has been made more efficient.

----------------------------------------------------------------

Changes since v1.5.0 are as follows (gitk changes were already
in v1.5.0 -- listed below are the commits that came through
Paul's official gitk repository):

Alexandre Julliard (2):
      git-daemon: Avoid leaking the listening sockets into child processes.
      sha1_file.c: Round the mmap offset to half the window size.

Fredrik Kuivinen (2):
      Read the config in rev-list
      Documentation/i18n.txt: it is i18n.commitencoding not core.commitencoding

Junio C Hamano (15):
      Documentation: Drop full-stop from git-fast-import title.
      cmd-list: add git-remote
      Makefile: update check-docs target
      Clarify two backward incompatible repository options.
      Still updating 1.5.0 release notes.
      Add RelNotes 1.5.0.1
      Make sure packedgitwindowsize is multiple of (pagesize * 2)
      Make gitk work reasonably well on Cygwin.
      gitk: Use show-ref instead of ls-remote
      GIT-VERSION-FILE: check ./version first.
      pretend-sha1: grave bugfix.
      git-merge: minor fix for no_trivial_merge_strategies.
      Do not take mode bits from index after type change.
      Update draft release notes for 1.5.0.1
      GIT 1.5.0.1

Mark Levedahl (3):
      gitk - remove trailing whitespace from a few lines.
      Make gitk save and restore the user set window position.
      Make gitk save and restore window pane position on Linux and Cygwin.

Nicolas Pitre (1):
      Minor corrections to release notes

Paul Mackerras (1):
      Change git repo-config to git config

Shawn O. Pearce (2):
      Attempt to improve git-rebase lead-in description.
      Convert update-index references in docs to add.

Tommi Kyntola (1):
      git-blame: prevent argument parsing segfault

From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.17
Date: Mon, 7 Mar 2011 03:01:52 +0100
Message-ID: <20110307020152.GA29723@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 03:02:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwPm1-0002F4-Ne
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 03:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab1CGCCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 21:02:09 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:57231 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab1CGCCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 21:02:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 88E7F19BB6C
	for <git@vger.kernel.org>; Mon,  7 Mar 2011 03:02:04 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16599-11 for <git@vger.kernel.org>; Mon,  7 Mar 2011 03:01:54 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 8131C19BB06
	for <git@vger.kernel.org>; Mon,  7 Mar 2011 03:01:54 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id B52476DF845
	for <git@vger.kernel.org>; Mon,  7 Mar 2011 02:55:19 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id B1BEC180C14; Mon,  7 Mar 2011 03:01:52 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168563>

Hello,

Here's an updated tig, which fixes an incompatibility with ncurses 2.8.
I also decided to merge my side project to rewrite the revision graph
renderer. It's far from finished but nice and colorful in its current
shape, and should be more hackable too.

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://repo.or.cz/tig.git 
 - Gitweb:	http://repo.or.cz/w/tig.git

Release notes
-------------
Improvements:

 - Start rewrite of the revision graph renderer. Three modes are
   supported UTF-8, ncurses line graphics, and ASCII. Also, enable
   revision graph rendering by default.

Bug fixes:

 - Fix ncurses 2.8 issue by passing non-zero column size to newwin(1).
 - Fix opening of diffs when browsing branches.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .gitignore                |    1 +
 Makefile                  |   13 +-
 NEWS                      |   14 +
 VERSION                   |    2 +-
 config.make.in            |    2 +-
 configure.ac              |   23 +-
 contrib/aspell.dict       |   14 +-
 contrib/ax_with_curses.m4 |  122 +++
 graph.c                   |  410 +++++++++
 graph.h                   |   73 ++
 io.c                      |  441 ++++++++++
 io.h                      |   76 ++
 manual.txt                |    1 +
 test-graph.c              |  106 +++
 tig.c                     | 1746 ++++++++-----------------------------
 tig.h                     |  459 ++++++++++
 tigrc.5.txt               |   13 +-
 17 files changed, 2103 insertions(+), 1413 deletions(-)

Jonas Fonseca (13):
      Improve viewing of diffs when browsing branches
      Rename opt_*_args to opt_*_argv
      Add possiblity to pass data to io_load property reader
      Refactor option parsing error handling to use error codes
      Unify option toggling
      Use AX_WITH_CURSES from GNU autoconf archive to detect ncurses
      Reduce the number of windows to max two by sharing them between all views
      Remove unnecessary braces
      Remove draw_text()s trim parameter
      Move includes, macros and core utilities to tig.h
      Move IO API to src/io.[ch]
      Rewrite the revision graph renderer
      tig-0.17

Loui Chang (2):
      configure.ac: Set value-if-not-found, don't check for program 'false'
      Initialise views and screens with nonzero size.

-- 
Jonas Fonseca

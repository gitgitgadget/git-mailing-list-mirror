From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.15
Date: Fri, 20 Nov 2009 14:31:17 +0100
Message-ID: <20091120133117.GA26917@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 14:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBTaZ-0007AY-Co
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 14:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZKTNbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 08:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZKTNbO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 08:31:14 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:37867 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZKTNbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 08:31:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 4C2D152C3BB
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 14:31:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ba+zZeWyB7Pl for <git@vger.kernel.org>;
	Fri, 20 Nov 2009 14:31:17 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 35C6952C3BA
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 14:31:17 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 6BF1A6DF835
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 14:27:56 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 1FE81E301; Fri, 20 Nov 2009 14:31:17 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133344>

Hello,

After a long time of silence, here is a brand new version of tig with
changes that has accummulated since version 0.14.1. It mainly brings
minor improvements for tweaking tig usage via keybindings and options.

Thanks to everybody who provided patches.

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
Incompatibilities:

 - Setting the cursor color no longer automatically sets the text to
   bold. The old 'lazy' behavior was a bug.
 - Remove check for git-repo-config, which was officially deprecated in
   git version 1.5.4. The configure script no longer depends on git
   being installed.

Improvements:

 - Provide the manual as a man page named tigmanual(7).
 - Add ability to toggle between showing shorter dates (without time
   info) and relative dates. Use 'D' to toggle between date formats.
 - Show the active (instead of the default) keybindings in the help
   view. Furthermore, honor the keymap when suggesting actions in the
   help messages.
 - Add branch view for choosing which branch to display in the main
   view. Bound to 'H' by default.
 - Tree view: show entry to parent directory ('..') when running from
   subdirectory.
 - Tree view: sort entries by name, date or author. Toggling is bound to
   'i' by default, with 'I' controlling whether or not to sort in
   ascending order.
 - Make height of the lower view in a split view configurable by setting
   the 'split-view-height' variable to a number or a percentage.
   Defaults to 2/3 of the total view height.
 - Allow multiple text attributes for color commands:

	color cursor white blue underline bold

Bug fixes:

 - Blame view: fix loading of blame data when opened from the tree view
   and CWD is not the repo root. (Debian bug 540766)
 - Tree view: fix searching.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .gitignore          |    1 +
 INSTALL             |   40 +-
 Makefile            |   13 +-
 NEWS                |   39 ++
 TODO                |    3 -
 VERSION             |    2 +-
 configure.ac        |    7 -
 contrib/aspell.dict |    8 +-
 manual.txt          |  249 ++++----
 tig.1.txt           |    2 +-
 tig.c               | 1549 ++++++++++++++++++++++++++++++-------------
 tigmanual.7.txt     |   20 +
 tigrc.5.txt         |  365 +++++------
 13 files changed, 1497 insertions(+), 801 deletions(-)

Giuseppe Bilotta (2):
      Fix previous/next with branch+main view
      Predefined external command: git commit

Ingmar Vanhassel (1):
      Makefile: Fix typo in 157ebf54

Jeff King (1):
      Add missing NULL in blame_grep

Jonas Fonseca (40):
      Add small cache for author names to reduce memory foot-print
      Reduce memory and startup time by storing author times as time_t
      Simplify searching in view lines by defining grep_text utility
      Define a tree_grep and fixing searching
      Make the granular allocators more customizable using macros
      Remove the need for alloc variables
      Define an allocator for run requests
      Update the current branch information when reloading all references
      Fix a potential problem with reading tokens larger then BUFSIZ
      Add primitive branch view
      Minor fix to always sort even if allocation fails in get_refs
      Use temporary variable in refs loop in main_draw
      Branch view: fix loading to handle when two branches have same commit
      Add support for sorting tree entries by name, date or author
      Add support for sorting branch entries by name, date and author
      Fix reloading of references to not cause access to freed memory
      Restore the branch view position after refreshing
      Add simple support for showing menues and use it for showing option menu
      Use menus with the commit subject to present selectable commit parents
      Fix memory allocation check in open_commit_parent_menu
      Manual: document that :<number> jumps to the line number
      Remove macros which are only used for default option values
      Allow multiple text attributes for color commands
      Build with asciidoc-8.4.5
      Show the active (instead of the default) keybindings in the help view
      Merge remote branch 'samb/short-dates'
      NEWS: Mention date-shorten feature
      Add support for displaying relative dates
      Fix draw_date to not format anything when time arg is NULL
      Fix loading of blame data when opened from the tree view
      NEWS: Improve bug fix description
      Update asciidoc table syntax to the one supported by version 8.4.4
      tigmanual(7): provide the manual as a man page
      Remove build dependency on git from the configure script
      begin_update: simplify control flow
      run_io_dir: take dir argument
      run_io_rd_dir: obsolete by switching call sites to run_io_rd_dir
      io_open: take path as a vararg format
      Status view: special case revert of unmerged entries with no physical file
      tig-0.15

Samuel Bronson (1):
      Add an option (and toggle) for shortening the date column by skipping the time.

Sebastian Harl (1):
      Fixed some uninitialized variable warnings

Tilo Schwarz (1):
      Make height of split view configurable

bill lam (1):
      Fix whitespace

-- 
Jonas Fonseca

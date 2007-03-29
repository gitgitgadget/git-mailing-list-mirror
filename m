From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 28 Mar 2007 18:12:17 -0700
Message-ID: <7vmz1wc0pa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 03:12:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWjBe-0004W8-9r
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 03:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934295AbXC2BMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 21:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934298AbXC2BMT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 21:12:19 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52712 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934295AbXC2BMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 21:12:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329011218.RMHP28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 21:12:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gRCH1W00E1kojtg0000000; Wed, 28 Mar 2007 21:12:17 -0400
X-master-at: 7685227e973fce34340d3766b1775263751afa56
X-next-at: 060c58c3e9f277ddb40b87eba2154be6d03d0538
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43398>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

All of them are post 1.5.1, as I've tagged -rc3 already.

* fl/doc (Mon Mar 26 23:45:23 2007 -0700) 3 commits
 + Documentation: unbreak user-manual.
 + Documentation: Add version information to man pages
 + Documentation: Replace @@GIT_VERSION@@ in documentation

* post1.5.1/tcltk (Wed Mar 28 04:22:02 2007 -0700) 3 commits
 - Rewrite Tcl/Tk interpreter path for the GUI tools.
 - Add --with-tcltk and --without-tcltk to configure.
 - NO_TCLTK

* post1.5.1/p4 (Tue Mar 27 12:03:43 2007 -0400) 3 commits
 - Remove unused WITH_OWN_SUBPROCESS_PY from RPM spec
 - Added git-p4 package to the list of git RPMs.
 - Add the WITH_P4IMPORT knob to the Makefile.

I think all of the above three are good, but I do not want to
risk changes to the build/release infrastructure after -rc.

* post1.5.1/workdir (Tue Mar 27 00:15:32 2007 +0100) 1 commit
 - contrib/workdir: add a simple script to create a working directory

Nobody is clamoring to have this, although I do not think there
is anything wrong with it (and it is a contrib/ thing).  I just
haven't had time to look at it closely for 'master'/'next' yet.

* jc/bisect (Fri Mar 23 17:54:03 2007 -0700) 6 commits
 + make the previous optimization work also on path-limited rev-list
   --bisect
 + rev-list --bisect: Fix "halfway" optimization.
 + t6004: add a bit more path optimization test.
 + git-rev-list --bisect: optimization
 + git-rev-list: add --bisect-vars option.
 + t6002: minor spelling fix.

This improves "rev-list --bisect" performance, sometimes
significantly, especially in a repository with long lines of
single-parent commits.

* fl/cvsserver (Mon Mar 19 16:56:01 2007 +0100) 5 commits
 + cvsserver: Abort if connect to database fails
 + cvsserver: Make the database backend configurable
 + cvsserver: Allow to override the configuration per access method
 + cvsserver: Handle three part keys in git config correctly
 + cvsserver: Introduce new state variable 'method'

This is a beginning of supporting use of different database
backends, other than sqlite, with git-cvsserver.

* jc/read-tree-df (Thu Mar 15 23:25:22 2007 -0700) 1 commit
 - Fix switching to a branch with D/F when current branch has file D.

This is unfortunately way premature as it seems to expose other
breakages this too-strict safety measure prevents from
happening.  We need to rethink the whole unpack_trees() business
after 1.5.1.

* jc/pathattr (Thu Mar 1 01:20:21 2007 -0800) 5 commits
 - pathattr: allow piping to external program.
 - pathattr: read from git_config().
 - git-show: use pathattr to run "display"
 - pathattr: path based configuration of various attributes.
 + convert: add scaffolding for path based selection of conversion
   routines.

Stalled.  gitattributes support should be one of the focus in
the 1.5.2 cycle.

* js/fetch-progress (Sun Feb 25 13:13:17 2007 -0800) 1 commit
 + git-fetch: add --quiet
* jc/merge-subtree (Thu Feb 15 16:32:45 2007 -0800) 1 commit
 - A new merge stragety 'subtree'.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

The above are stalled.

* jc/blame (Wed Mar 28 02:06:06 2007 -0700) 3 commits
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up

This is so-far-not-so-fruitful optimization attempt to blame.
In oprofile, I see same_suspect() show up quite high; after
experimenting with these (I have another on top of it which is
not in 'pu'), I am starting to suspect that same_suspect() can
just compare the address of two origins --- we need to make sure
nobody creates two origin structure with the same address in a
single scoreboard, which is needed before that happen.  That
makes assign_blame() spend about 5% less time than it currently
does.

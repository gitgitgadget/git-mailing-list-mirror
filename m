From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 04 Mar 2007 02:32:46 -0800
Message-ID: <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 11:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNo1T-0006MI-Hx
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 11:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbXCDKcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 05:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbXCDKcs
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 05:32:48 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34947 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbXCDKcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 05:32:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304103247.BKTS2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 4 Mar 2007 05:32:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WaYm1W0041kojtg0000000; Sun, 04 Mar 2007 05:32:46 -0500
X-master-at: 102a0a2db14cd7604a8a2b6590ecbd6bf3136394
X-next-at: 38f4754b88df8a0928aec3f9376d67e10069ed8b
In-Reply-To: <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 23 Feb 2007 00:51:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41354>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* js/attach (Sun Mar 4 00:12:06 2007 +0100) 1 commit
 - format-patch: add --inline option and make --attach a true
   attachment

With this, --attach makes a mixed/multipart message with
"content-disposition: attachment"; the previous behaviour to
emit "content-disposition: inline" is available with the new
option --inline.  It is an improvement in the sense that it
makes the option name and behaviour match each other, but it
changes the behaviour, so some people may not like it.  I think
I'll merge to 'next' anyway, if only to see if anybody screams.

* js/symlink (Sat Mar 3 20:38:00 2007 +0100) 3 commits
 + Tell multi-parent diff about core.symlinks.
 + Handle core.symlinks=false case in merge-recursive.
 + Add core.symlinks to mark filesystems that do not support symbolic
   links.

This is to help the MinGW port; I think this topic is ready to
graduate to 'master'.

* js/config-rename (Fri Mar 2 21:53:33 2007 +0100) 1 commit
 + git-config: document --rename-section, provide --remove-section

This would help clean-up after removing branches and remotes.

* js/gnucl (Fri Mar 2 15:29:08 2007 +0100) 2 commits
 - --pretty=gnucl: avoid line wrapping before the comma
 - Add --pretty=gnucl

This is to output logs in the GNU ChangeLog format.

* jc/pathattr (Thu Mar 1 01:20:21 2007 -0800) 5 commits
 - pathattr: allow piping to external program.
 - pathattr: read from git_config().
 - git-show: use pathattr to run "display"
 - pathattr: path based configuration of various attributes.
 + convert: add scaffolding for path based selection of conversion
   routines.

This is a continuation of the CRLF munging topic that is already
in the 'master' branch, but I am expecting to have to redo
almost all of them.  This is left in 'pu' just as a reference.

* js/revert-cherry (Thu Mar 1 05:26:30 2007 +0100) 1 commit
 + Make git-revert & git-cherry-pick a builtin

Will cook for some time.

* jc/fetch (Wed Feb 28 17:02:18 2007 -0800) 14 commits
 + builtin-fetch--tool: fix reflog notes.
 + git-fetch: retire update-local-ref which is not used anymore.
 + builtin-fetch--tool: make sure not to overstep ls-remote-result
   buffer.
 + fetch--tool: fix uninitialized buffer when reading from stdin
 + builtin-fetch--tool: adjust to updated sha1_object_info().
 + git-fetch--tool takes flags before the subcommand.
 + Use stdin reflist passing in git-fetch.sh
 + Use stdin reflist passing in parse-remote
 + Allow fetch--tool to read from stdin
 + git-fetch: rewrite expand_ref_wildcard in C
 + git-fetch: rewrite another shell loop in C
 + git-fetch: move more code into C.
 + git-fetch--tool: start rewriting parts of git-fetch in C.
 + git-fetch: split fetch_main into fetch_dumb and fetch_native

Beginning of built-in git-fetch, primarily to speed up fetching
between repositories with insane number of refs.

* jb/per-user-exclude (Tue Feb 27 22:31:10 2007 -0500) 1 commit
 - add: Support specifying an excludes file with a configuration
   variable

I was hoping that the attribute system would make this
unnecessary (you assign 'ignored' attribute to paths, instead of
spelling them out in the additional .gitignore), but that is a
bit in the future.

* js/diff-ni (Sun Feb 25 23:36:53 2007 +0100) 4 commits
 + Get rid of the dependency to GNU diff in the tests
 + diff --no-index: support /dev/null as filename
 + diff-ni: fix the diff with standard input
 + diff: support reading a file from stdin via "-"

I've fixed up this series since it was posted, and I think it is
in a testable shape now, so it is in 'next'.

* js/fetch-progress (Sun Feb 25 13:13:17 2007 -0800) 3 commits
 . git-fetch: add --quiet
 + Fixup no-progress for fetch & clone
 + fetch & clone: do not output progress when not on a tty

The early parts that have been in 'next' should be ready to go
to 'master' now.  The last one I am not sure.

* jc/status (Thu Feb 22 02:07:56 2007 -0800) 2 commits
 - git-status: use in-core --refresh in a read-only repository.
 - git-runstatus --refresh

These two were done for the specific purpose of helping qgit,
but I haven't heard about them, so they are on hold.  If they
are not needed by qgit nor people who like to run git-status in
a read-only repository, I do not see any reason to keep them.

* jc/merge-subtree (Thu Feb 15 16:32:45 2007 -0800) 1 commit
 - A new merge stragety 'subtree'.

This is still my useful toy at this stage.  I agree with Shawn
that subtree identification needs to be improved.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

This is just a reference, waiting for a day somebody has enough
energy to rewrite diff family with a unified tree walker.

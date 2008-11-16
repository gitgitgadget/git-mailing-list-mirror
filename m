From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2008, #05; Sat, 15)
Date: Sat, 15 Nov 2008 16:53:31 -0800
Message-ID: <7vzlk04hkk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 01:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1VxA-0007c7-N4
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 01:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbYKPAxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 19:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYKPAxm
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 19:53:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbYKPAxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 19:53:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B48616C53;
	Sat, 15 Nov 2008 19:53:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BCE4716B0D; Sat,
 15 Nov 2008 19:53:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01CD1420-B379-11DD-8A2D-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101106>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* lt/preload-lstat (Thu Nov 13 16:36:30 2008 -0800) 1 commit
 - Add cache preload facility

* cb/mergetool (Thu Nov 13 12:41:15 2008 +0000) 3 commits
 - [DONTMERGE] Add -k/--keep-going option to mergetool
 - Add -y/--no-prompt option to mergetool
 - Fix some tab/space inconsistencies in git-mergetool.sh

Jeff had good comments on the last one; the discussion needs concluded,
and also waiting for comments from the original author (Ted).

* ta/quiet-pull (Sat Nov 15 01:14:24 2008 +0100) 1 commit
 - Teach/Fix pull/fetch -q/-v options

This has my fixes to preserve "fetch -v -v" behaviour squashed in.

----------------------------------------------------------------
[Graduated to "master"]

* mk/maint-cg-push (Mon Nov 10 22:47:11 2008 +0100) 1 commit
 + git push: Interpret $GIT_DIR/branches in a Cogito compatible way

Will need to further downmerge to 'maint'.

* jk/maint-commit-v-strip (Wed Nov 12 03:25:52 2008 -0500) 1 commit
 + commit: Fix stripping of patch in verbose mode.

Will need to further downmerge to 'maint'.

* st/maint-tag (Wed Nov 5 00:20:36 2008 +0100) 2 commits
 + tag: Add more tests about mixing incompatible modes and options
 + tag: Check that options are only allowed in the appropriate mode

Will need to further downmerge to 'maint'.

* jk/deny-push-to-current (Sat Nov 8 20:49:27 2008 -0500) 2 commits
 + receive-pack: detect push to current branch of non-bare repo
 + t5516: refactor oddball tests

* dl/xdiff (Fri Nov 7 21:24:33 2008 -0800) 1 commit
 + xdiff: give up scanning similar lines early

This performance fix may eventually need to be cherry-picked to 'maint'.

* lt/decorate (Wed Nov 12 11:51:28 2008 +0100) 7 commits
 + rev-list documentation: clarify the two parts of history
   simplification
 + Document "git log --simplify-by-decoration"
 + Document "git log --source"
 + revision traversal: '--simplify-by-decoration'
 + Make '--decorate' set an explicit 'show_decorations' flag
 + revision: make tree comparison functions take commits rather than
   trees
 + Add a 'source' decorator for commits

* gb/gitweb-snapshot-pathinfo (Sun Nov 2 10:21:39 2008 +0100) 3 commits
 + gitweb: embed snapshot format parameter in PATH_INFO
 + gitweb: retrieve snapshot format from PATH_INFO
 + gitweb: make the supported snapshot formats array global

* jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
 + gitweb: Better processing format string in custom links in navbar

* jk/diff-convfilter (Sun Oct 26 00:50:02 2008 -0400) 8 commits
 + enable textconv for diff in verbose status/commit
 + wt-status: load diff ui config
 + only textconv regular files
 + userdiff: require explicitly allowing textconv
 + refactor userdiff textconv code
 + add userdiff textconv tests
 + document the diff driver textconv feature
 + diff: add missing static declaration

* jk/diff-convfilter-test-fix (Fri Oct 31 01:09:13 2008 -0400) 1 commit
 + Avoid using non-portable `echo -n` in tests.

An update to the one above.

* np/pack-safer (Sun Nov 9 13:11:06 2008 -0800) 11 commits
 + t5303: fix printf format string for portability
 + t5303: work around printf breakage in dash
 + pack-objects: don't leak pack window reference when splitting
   packs
 + extend test coverage for latest pack corruption resilience
   improvements
 + pack-objects: allow "fixing" a corrupted pack without a full
   repack
 + make find_pack_revindex() aware of the nasty world
 + make check_object() resilient to pack corruptions
 + make packed_object_info() resilient to pack corruptions
 + make unpack_object_header() non fatal
 + better validation on delta base object offsets
 + close another possibility for propagating pack corruption

* mv/remote-rename (Mon Nov 10 21:43:03 2008 +0100) 4 commits
 + git-remote: document the migration feature of the rename
   subcommand
 + git-remote rename: migrate from remotes/ and branches/
 + remote: add a new 'origin' variable to the struct
 + Implement git remote rename

----------------------------------------------------------------
[Will merge to "master" soon]

* bc/maint-keep-pack (Thu Nov 13 14:11:46 2008 -0600) 1 commit
 + repack: only unpack-unreachable if we are deleting redundant packs

This makes "repack -A -d" without -d do the same thing as "repack -a -d",
which makes sense.  This does not have to go to 'maint', though.

* jk/commit-v-strip (Wed Nov 12 03:23:37 2008 -0500) 4 commits
 + status: show "-v" diff even for initial commit
 + Merge branch 'jk/maint-commit-v-strip' into jk/commit-v-strip
 + wt-status: refactor initial commit printing
 + define empty tree sha1 as a macro

----------------------------------------------------------------
[Actively Cooking]

* nd/narrow (Wed Oct 1 11:04:09 2008 +0700) 9 commits
 + grep: skip files outside sparse checkout area
 + checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 + Prevent diff machinery from examining worktree outside sparse
   checkout
 + ls-files: Add tests for --sparse and friends
 + update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 + update-index: refactor mark_valid() in preparation for new options
 + ls-files: add options to support sparse checkout
 + Introduce CE_NO_CHECKOUT bit
 + Extend index to save more flags

I think the basic idea and structure of this is sound.  Let's see if
people who try this feature can find holes in what it currently does.

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 - autoconf: Enable threaded delta search when pthreads are supported

* ph/send-email (Tue Nov 11 00:54:02 2008 +0100) 4 commits
 - git send-email: ask less questions when --compose is used.
 - git send-email: add --annotate option
 - git send-email: interpret unknown files as revision lists
 - git send-email: make the message file name more specific.

* nd/rename-cache (Sat Nov 8 18:27:33 2008 +0700) 2 commits
 - diffcore-rename: add config option to allow to cache renames
 - diffcore-rename: support rename cache

I am moderately negative on this one in its current shape.  We shouldn't
have to be storing what can be recomputed (and recomputed differently in
later software), and we shouldn't be keeping such cached result
indefinitely.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

----------------------------------------------------------------
[On Hold]

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This seems to have a deadlock during communication between the peers.
Someone needs to pick up this topic and resolve the deadlock before it can
continue.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.

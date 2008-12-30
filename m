From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2008, #04; Mon, 29)
Date: Tue, 30 Dec 2008 12:59:25 -0800
Message-ID: <7vocyt1is2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 22:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHlia-00049s-LH
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYL3U7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 15:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYL3U7d
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 15:59:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbYL3U7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 15:59:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D62D11B673;
	Tue, 30 Dec 2008 15:59:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7971A1B671; Tue,
 30 Dec 2008 15:59:27 -0500 (EST)
X-master-at: c32f76f4d220e5d4d6a599d7a12a50b1e3ceceaf
X-next-at: 6f67462436796045e0656107418221a6696bd5f2
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C03CC44C-D6B4-11DD-A21A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104204>

with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The ones marked with '.' do not appear in any of the branches,
but I am still holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* nd/grep-assume-unchanged (Sat Dec 27 15:21:03 2008 +0700) 2 commits
 - grep: grep cache entries if they are "assume unchanged"
 - grep: support --no-ext-grep to test builtin grep

* rs/diff-ihc (Sun Dec 28 19:45:32 2008 +0100) 1 commit
 + diff: add option to show context between close hunks

* as/maint-shortlog-cleanup (Wed Dec 24 17:34:44 2008 +0100) 2 commits
 - builtin-shortlog.c: do not unnecessarily strdup before insertion
   in list
 - builtin-shortlog.c: use string_list_append() instead of
   duplicating its code

* js/maint-merge-recursive-r-d-conflict (Mon Dec 22 23:10:20 2008 +0100) 1 commit
 + merge-recursive: mark rename/delete conflict as unmerged

* kk/maint-http-push (Tue Dec 23 11:31:15 2008 +0300) 1 commit
 + http-push: support full URI in handle_remote_ls_ctx()

* jc/maint-ls-tree (Thu Dec 25 16:54:23 2008 -0800) 1 commit
 + ls-tree: add --full-tree option

* mh/maint-sendmail-cc-doc (Mon Dec 29 00:37:25 2008 +0100) 1 commit
 + doc/git-send-email: mention sendemail.cc config variable

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 . In add --patch, Handle K,k,J,j slightly more gracefully.
 . Add / command in add --patch
 . git-add -i/-p: Change prompt separater from slash to comma

I am still holding onto this earlier topic to add '/' subcommand to allow
finding a hunk with given text, but I'd rather not merge/rebase it on top
of wp/add-p-goto series myself.  Waiting for a reroll.

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 . git-am: Pass the --directory option through to git-apply

A reroll of this by Simon Schubert triggered a series to fix a parameter
propagation bug, and another reroll to add "git am --directory=path/"
should be much easier now.  I am not likely to use the feature myself, so
it is up to intrested volunteers to carry it forward.

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 - autoconf: Enable threaded delta search when pthreads are supported

This automatically enables threaded delta search code when autoconf
detects pthreads are usable.  I haven't heard neither positive nor
negative comments from minority platforms that might be harmed.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

----------------------------------------------------------------
[Actively cooking]

* mk/gitweb-feature (Mon Dec 15 22:16:19 2008 -0800) 1 commit
 - gitweb: unify boolean feature subroutines

* cb/merge-recursive-fix (Mon Dec 15 02:41:24 2008 -0800) 3 commits
 + Merge branch 'cb/maint-merge-recursive-fix' into cb/merge-
   recursive-fix
 + merge-recursive: do not clobber untracked working tree garbage
 + modify/delete conflict resolution overwrites untracked file

* cb/maint-merge-recursive-fix (Sun Dec 14 19:40:09 2008 -0800) 2 commits
 + merge-recursive: do not clobber untracked working tree garbage
 + modify/delete conflict resolution overwrites untracked file

* js/notes (Sat Dec 20 13:06:03 2008 +0100) 4 commits
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* wp/add-p-goto (Thu Dec 4 10:22:40 2008 +0000) 2 commits
 + Add 'g' command to go to a hunk
 + Add subroutine to display one-line summary of hunks

* jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
 - gitweb: cache $parent_commit info in git_blame()
 - gitweb: A bit of code cleanup in git_blame()
 - gitweb: Move 'lineno' id from link to row element in git_blame

Jakub seemed to feel they are not yet ready.

* mv/um-pdf (Wed Dec 10 23:44:50 2008 +0100) 1 commit
 + Add support for a pdf version of the user manual

I do not have a new enough combination of dblatex and asciidoc myself but
this may help interested people.

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

* gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
 - gitweb: link to patch(es) view in commit(diff) and (short)log view
 - gitweb: add patches view
 - gitweb: change call pattern for git_commitdiff
 - gitweb: add patch view

----------------------------------------------------------------
[Graduated to "master"]

* js/rebase-i-p (Mon Dec 15 11:05:31 2008 +0100) 2 commits
 + rebase -i -p: Fix --continue after a merge could not be redone
 + Show a failure of rebase -p if the merge had a conflict

* np/auto-thread (Mon Dec 15 20:44:30 2008 +0100) 3 commits
 + Force t5302 to use a single thread
 + pack-objects: don't use too many threads with few objects
 + autodetect number of CPUs by default when using threads

* lt/reset-merge (Wed Dec 3 18:00:12 2008 -0800) 2 commits
 + Document "git-reset --merge"
 + Add 'merge' mode to 'git reset'

----------------------------------------------------------------
[Will merge to "master" soon]

* cb/mergetool (Fri Dec 12 21:48:41 2008 +0000) 4 commits
 + mergetool: Don't keep temporary merge files unless told to
 + mergetool: Add prompt to continue after failing to merge a file
 + Add -y/--no-prompt option to mergetool
 + Fix some tab/space inconsistencies in git-mergetool.sh

I have been waiting for comments from the original author and other
interested parties, but haven't heard anything yet.  This tool is on the
fringe from my point of view anyway, so I'll push them out to 'master'
soon.  If there is a breakage that annoys real people, we will hear from
them, and we can take it from there.

----------------------------------------------------------------
[On Hold]

* nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 17 commits
 - wt-status: show sparse checkout info
 - Introduce default sparse patterns (core.defaultsparse)
 - checkout: add new options to support sparse checkout
 - clone: support sparse checkout with --sparse-checkout option
 - unpack_trees(): add support for sparse checkout
 - unpack_trees(): keep track of unmerged entries
 - Introduce "sparse patterns"
 - Merge branch 'master' into nd/narrow
 - t2104: touch portability fix
 - grep: skip files outside sparse checkout area
 - checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 - Prevent diff machinery from examining worktree outside sparse
   checkout
 - ls-files: Add tests for --sparse and friends
 - update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 - update-index: refactor mark_valid() in preparation for new options
 - ls-files: add options to support sparse checkout
 - Introduce CE_NO_CHECKOUT bit

Kicked out of 'next' by popular demand (see recent discussion on the
interaction between the checkout area and commands such as "grep").

* jc/clone-symref-2 (Sat Nov 29 23:38:21 2008 -0800) 7 commits
 - clone: test the new HEAD detection logic
 - Merge commit 'HEAD@{2}' into HEAD
 - upload-pack: send the HEAD information
 - clone: find the current branch more explicitly
 - connect.c::read_extra_info(): find where HEAD points at
 - connect.c::read_extra_info(): prepare to receive more than server
   capabilities
 - get_remote_heads(): refactor code to read "server capabilities"

An attempt to extend the fetch protocol to make the logic to detect where
HEAD on the origin site points to more robust.

* cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
 - bisect: add "--no-replace" option to bisect without using replace
   refs
 - rev-list: make it possible to disable replacing using "--no-
   bisect-replace"
 - bisect: use "--bisect-replace" options when checking merge bases
 - merge-base: add "--bisect-replace" option to use fixed up revs
 - commit: add "bisect_replace_all" prototype to "commit.h"
 - rev-list: add "--bisect-replace" to list revisions with fixed up
   history
 - Documentation: add "git bisect replace" documentation
 - bisect: add test cases for "git bisect replace"
 - bisect: add "git bisect replace" subcommand

I think a mechanism like this should be added to replace grafts, but it
should always be enabled for normal revision traversal operation, while
always disabled for object enumeration and transfer operation (iow, fsck,
fetch and push should use the real ancestry information recorded in the
underlying objects, while rev-list, log, etc. should always use the
replaced objects).  I have a suspicion that even cat-file could honor it.

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

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

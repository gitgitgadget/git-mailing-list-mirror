From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Mon, 25 Feb 2008 00:40:46 -0800
Message-ID: <7vpruljunl.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 09:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYu3-0002MU-NO
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbYBYIlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbYBYIlB
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:41:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbYBYIlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:41:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E4DE227F;
	Mon, 25 Feb 2008 03:40:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B8C0E227E; Mon, 25 Feb 2008 03:40:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75014>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

* sp/describe (Sun Feb 24 03:07:33 2008 -0500) 5 commits
 + Use git-describe --exact-match in bash prompt on detached HEAD
 + Teach git-describe --exact-match to avoid expensive tag searches
 + Avoid accessing non-tag refs in git-describe unless --all is
   requested
 + Teach git-describe to use peeled ref information when scanning
   tags
 + Optimize peel_ref for the current ref of a for_each_ref callback

 (should go to 'master' soon)

* bc/reflog-fix (Fri Feb 22 12:47:08 2008 -0600) 1 commit
 + builtin-reflog.c: don't install new reflog on write failure

 (should go to 'master' soon)

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

* ae/pack-autothread (Fri Feb 22 20:12:58 2008 -0600) 2 commits
 + pack-objects: Print a message describing the number of threads for
   packing
 + pack-objects: Add runtime detection of online CPU's

 (should go to 'master' soon)

* jm/free (Thu Jan 31 18:26:32 2008 +0100) 1 commit
 + Avoid unnecessary "if-before-free" tests.

* jc/dirstat (Tue Feb 12 17:06:58 2008 -0800) 1 commit
 - diff: make --dirstat binary-file safe

----------------------------------------------------------------
[Graduated to "master"]

* jc/apply-whitespace (Mon Feb 11 15:32:29 2008 -0800) 14 commits

Further work on "apply --whitespace=fix".

* lt/dirstat (Tue Feb 12 17:06:58 2008 -0800) 2 commits

----------------------------------------------------------------
[Will merge to "master" soon]

* db/host-alias (Sun Feb 24 22:25:04 2008 -0800) 3 commits
 + url rewriting: take longest and first match
 + Add support for url aliases in config files
 + Use ALLOC_GROW in remote.{c,h}

Allows URLs used in pushing and fetching to be rewritten.

* db/push-single-with-HEAD (Wed Feb 20 12:54:05 2008 -0500) 1 commit
 + Resolve value supplied for no-colon push refspecs

Kills two birds with a commit by (1) fixing "git push $there +HEAD"
to force the single push, and (2) allowing you to set
"remote.$there.push = HEAD" so that "git push $there" will push
only the current branch.

* db/checkout (Sat Feb 23 15:45:19 2008 -0800) 21 commits
 + checkout: error out when index is unmerged even with -m
 + checkout: show progress when checkout takes long time while
   switching branches
 + Add merge-subtree back
 + checkout: updates to tracking report
 + builtin-checkout.c: Remove unused prefix arguments in
   switch_branches path
 + checkout: work from a subdirectory
 + checkout: tone down the "forked status" diagnostic messages
 + Clean up reporting differences on branch switch
 + builtin-checkout.c: fix possible usage segfault
 + checkout: notice when the switched branch is behind or forked
 + Build in checkout
 + Move code to clean up after a branch change to branch.c
 + Library function to check for unmerged index entries
 + Use diff -u instead of diff in t7201
 + Move create_branch into a library file
 + Build-in merge-recursive
 + Add "skip_unmerged" option to unpack_trees.
 + Discard "deleted" cache entries after using them to update the
   working tree
 + Send unpack-trees debugging output to stderr
 + Add flag to make unpack_trees() not print errors.
 + Allow callers of unpack_trees() to handle failure

Checkout rewritten in C.

* gp/hash-stdin (Thu Feb 21 10:06:47 2008 +0000) 1 commit
 + hash-object: cleanup handling of command line options

* jc/diff-relative (Wed Feb 13 00:34:39 2008 -0800) 2 commits
 + diff --relative: help working in a bare repository
 + diff --relative: output paths as relative to the current
   subdirectory

* js/run-command (Thu Feb 21 23:42:56 2008 +0100) 2 commits
 + start_command(), if .in/.out > 0, closes file descriptors, not the
   callers
 + start_command(), .in/.out/.err = -1: Callers must close the file
   descriptor

* jk/help-alias (Sun Feb 24 17:17:37 2008 -0500) 3 commits
 + help: respect aliases
 + make alias lookup a public, procedural function
 + help: use parseopt

* cw/bisect (Sat Feb 23 17:14:17 2008 -0800) 1 commit
 + Eliminate confusing "won't bisect on seeked tree" failure

* js/branch-track (Tue Feb 19 11:24:38 2008 -0500) 2 commits
 + doc: documentation update for the branch track changes
 + branch: optionally setup branch.*.merge from upstream local
   branches

This allows you to automatically set up tracking even when forking
from a local branch; it builds on top of Daniel's "checkout in C".

* js/merge (Sun Feb 17 19:07:40 2008 +0000) 2 commits
 + xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
 + xdl_merge(): make XDL_MERGE_ZEALOUS output simpler

This makes conflicting merges that have hunks separated by only
a few common lines much easier to read.

* db/cover-letter (Sat Feb 23 09:41:56 2008 +0100) 9 commits
 + t4014: Replace sed's non-standard 'Q' by standard 'q'
 + Support a --cc=<email> option in format-patch
 + Combine To: and Cc: headers
 + Fix format.headers not ending with a newline
 + Add tests for extra headers in format-patch
 + Add a --cover-letter option to format-patch
 + Export some email and pretty-printing functions
 + Improve message-id generation flow control for format-patch
 + Add more tests for format-patch

Teaches format-patch to optionally generate cover letters.
Several people on the list have had good success stories to
tell, which is very encouraging.

----------------------------------------------------------------
[Actively Cooking]

* js/reflog-delete (Fri Feb 22 16:52:50 2008 -0600) 10 commits
 + git-stash: add new 'pop' subcommand
 + git-stash: add new 'drop' subcommand
 + git-reflog: add option --updateref to write the last reflog sha1
   into the ref
 + refs.c: make close_ref() and commit_ref() non-static
 + git-reflog: add option --rewrite to update reflog entries while
   expiring
 + reflog-delete: parse standard reflog options
 + Merge branch 'bc/reflog-fix' into js/reflog-delete
 + builtin-reflog.c: don't install new reflog on write failure
 + builtin-reflog.c: fix typo that accesses an unset variable
 + Teach "git reflog" a subcommand to delete single entries

I think this needs tests for both high-level ("stash drop" and
"stash pop") and low-level ("reflog delete --rewrite" and
"reflog delete --updateref"), but otherwise the series looks in
a very good shape.

----------------------------------------------------------------
[On Hold]

* lh/git-file (Wed Feb 20 23:13:16 2008 +0100) 4 commits
 - Teach GIT-VERSION-GEN about the .git file
 - Teach git-submodule.sh about the .git file
 - Teach resolve_gitlink_ref() about the .git file
 - Add platform-independent .git "symlink"

The idea and the implementation seem Ok, but this leaves
distinct feeling that it is a solution still waiting for a user
(e.g. "git submodule" enhancements to take advantage of this
facility to preserve the subrepository while switching between a
revision with a submodule and another before the submodule was
bound to the superproject).

* jc/rename (Tue Jan 29 20:54:56 2008 -0800) 1 commit
 + Optimize rename detection for a huge diff

* jc/bulk-allocate (Wed Feb 13 18:37:27 2008 -0800) 2 commits
 - Bulk allocate diff_filepair
 - patch freeable-bulk-alloc

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.  I am not sure if we should merge this to
'next' before 1.5.5.  Most active people will be on 'next' and
if we have this there, the resulting 1.5.5 release might end up
having issues that come from differences this one introduces.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 - sha1-lookup: make selection of 'middle' less aggressive
 - sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 5 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive
 + expose a helper function peel_to_type().
 + merge-recursive: split low-level merge functions out.

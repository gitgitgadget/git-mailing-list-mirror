From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2008, #04; Sat, 18)
Date: Sat, 18 Oct 2008 13:36:14 -0700
Message-ID: <7viqrpabep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 22:37:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrIYH-0006Hz-Qt
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 22:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbYJRUgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbYJRUgV
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 16:36:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYJRUgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 16:36:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 781B98C968;
	Sat, 18 Oct 2008 16:36:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0A0D88C966; Sat, 18 Oct 2008 16:36:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B5960DC-9D54-11DD-BDCA-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98570>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

----------------------------------------------------------------
[New Topics]

* jc/gitweb-fix-cloud-tag (Tue Oct 14 21:27:12 2008 -0700) 1 commit
 + Fix reading of cloud tags

* rs/alloc-ref (Sat Oct 18 10:44:18 2008 +0200) 3 commits
 + make alloc_ref_from_str() the new alloc_ref()
 + use alloc_ref_from_str() everywhere
 + add alloc_ref_with_prefix()

* jc/maint-reset-remove-unmerged-new (Wed Oct 15 16:00:06 2008 -0700) 1=
 commit
 - reset --hard/read-tree --reset -u: remove unmerged new paths

* jk/fix-ls-files-other (Fri Oct 17 13:03:52 2008 -0700) 2 commits
 + Merge branch 'jk/maint-ls-files-other' into jk/fix-ls-files-other
 + refactor handling of "other" files in ls-files and status

* jc/maint-co-track (Fri Oct 17 15:44:39 2008 -0700) 4 commits
 - Fix checkout not to clobber the branch when using symlinked HEAD
   upon detaching
 - Enhance hold_lock_file_for_{update,append}() API
 - demonstrate breakage of detached checkout with symbolic link HEAD
 - Fix "checkout --track -b newbranch" on detached HEAD

* jk/maint-ls-files-other (Thu Oct 16 11:07:26 2008 -0400) 1 commit
 + refactor handling of "other" files in ls-files and status

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

* np/index-pack (Fri Oct 17 15:57:58 2008 -0400) 2 commits
 + index-pack: smarter memory usage during delta resolution
 + index-pack: rationalize delta resolution code

----------------------------------------------------------------
[Graduated to "master"]

* pb/commit-where (Fri Oct 3 22:13:49 2008 -0400) 4 commits
 + tutorial: update output of git commit
 + reformat informational commit message
 + git commit: Reformat output somewhat
 + builtin-commit.c: show on which branch a commit was added

----------------------------------------------------------------
[Needs review]

* nd/narrow (Wed Oct 1 11:04:09 2008 +0700) 9 commits
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
 - Extend index to save more flags

----------------------------------------------------------------
[Dropped]

* pb/submodule (Fri Sep 12 23:09:19 2008 +0200) 1 commit
 . t7400: Add short "git submodule add" testsuite

Was waiting for a reroll.

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 . git-am: Pass the --directory option through to git-apply

I think this is still buggy and drops the option when am stops with
conflicts.

----------------------------------------------------------------
[Stalled]

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 - Use xdiff caching to improve git blame performance
 - Allow xdiff machinery to cache hash results for a file
 - Always initialize xpparam_t to 0
 - Bypass textual patch generation and parsing in git blame
 - Allow alternate "low-level" emit function from xdl_diff

R=C3=A9ne had good comments on how the callback should be structured.
Waiting for a reroll.

----------------------------------------------------------------
[Will be merged to 'master' soon]

* js/maint-fetch-update-head (Tue Oct 14 15:32:20 2008 -0700) 2 commits
 + pull: allow "git pull origin $something:$current_branch" into an
   unborn branch
 + Fix fetch/pull when run without --update-head-ok

* ns/rebase-noverify (Tue Oct 14 08:17:16 2008 +0900) 2 commits
 + rebase: Document --no-verify option to bypass pre-rebase hook
 + rebase --no-verify

This adds --no-verify to git rebase, to avoid the pre-rebase hook.

* mv/merge-noff (Fri Oct 3 14:04:47 2008 +0200) 1 commit
 + builtin-commit: use reduce_heads() only when appropriate

=46ixes "git merge --no-ff --no-commit".

* ae/preservemerge (Mon Sep 29 22:28:57 2008 +0200) 1 commit
 + rebase: Support preserving merges in non-interactive mode

* pb/rename-rowin32 (Fri Oct 3 12:20:43 2008 +0200) 1 commit
 + Do not rename read-only files during a push

=46ixes pack file renames on Windows.

* sp/describe-lwtag (Mon Oct 13 07:39:46 2008 -0700) 1 commit
 + describe: Make --tags and --all match lightweight tags more often

When the user gives --tags, the request is asking to treat lightweight =
and
annotated tags at equal weight, and if lightweight ones are closer, the=
y
should be used.

* gb/formatpatch-autonbr (Thu Oct 2 16:55:39 2008 -0400) 1 commit
 + format-patch: autonumber by default

* dp/checkattr (Wed Oct 15 09:11:52 2008 +0200) 3 commits
 + git-check-attr(1): use 'verse' for multi-line synopsis sections
 + check-attr: Add --stdin option
 + check-attr: add an internal check_attr() function

Batch attr lookup via --stdin, for gitk and git-gui.

* gb/refactor-pathinfo (Fri Oct 10 20:42:26 2008 +0200) 1 commit
 + gitweb: refactor input parameters parse/validation

A major cleanup on the way gitweb parses its input arguments.
=46uture gitweb patches to add more arguments into the PATH_INFO
depend upon this initial cleanup work.

* ml/cygwin-filemode (Mon Oct 13 00:33:31 2008 -0400) 1 commit
 + compat/cygwin.c - Use cygwin's stat if core.filemode =3D=3D true

* mv/clonev (Thu Oct 9 01:40:32 2008 +0200) 1 commit
 + Implement git clone -v

Does what it says it does.  This may be ready for master soon,
its a pretty trivial change.

----------------------------------------------------------------
[Actively Cooking]

* tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
 + Documentation: Refer to git-rebase(1) to warn against rewriting
 + Documentation: new upstream rebase recovery section in git-rebase

Expecting an update.

* sh/maint-rebase3 (Sun Oct 5 23:26:52 2008 -0500) 1 commit
 + rebase--interactive: fix parent rewriting for dropped commits

* sh/rebase-i-p (Wed Oct 15 02:44:40 2008 -0500) 8 commits
 - rebase-i-p: if todo was reordered use HEAD as the rewritten parent
 - rebase-i-p: do not include non-first-parent commits touching
   UPSTREAM
 - rebase-i-p: only list commits that require rewriting in todo
 - rebase-i-p: fix 'no squashing merges' tripping up non-merges
 - rebase-i-p: delay saving current-commit to REWRITTEN if squashing
 - rebase-i-p: use HEAD for updating the ref instead of mapping
   OLDHEAD
 - rebase-i-p: test to exclude commits from todo based on its parents
 + rebase--interactive: fix parent rewriting for dropped commits

Changes the `rebase -i -p` behavior to behave like git sequencer's
rewrite of `rebase -i` would behave.

* jk/diff-convfilter (Sun Oct 5 17:43:45 2008 -0400) 4 commits
 + diff: add filter for converting binary to text
 + diff: introduce diff.<driver>.binary
 + diff: unify external diff and funcname parsing code
 + t4012: use test_cmp instead of cmp

A general cleanup on how diff drivers are implemented.  Its still
missing documentation updates and tests but doesn't break anything
current as far as I can tell.

* jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
 - gitweb: Better processing format string in custom links in navbar

Waiting for some sort of response from Pasky.

----------------------------------------------------------------
[On Hold]

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

I started making this incremental but the progress is not
so great.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This seems to have a deadlock during communication between the peers.
Someone needs to pick up this topic and resolve the deadlock before it =
can
continue.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.

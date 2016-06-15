From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's cooking in git/spearce.git (Sep 2008, #04; Mon, 22)
Date: Mon, 29 Sep 2008 11:47:09 -0700
Message-ID: <20080929184709.GB21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 20:48:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNnK-0007XY-RO
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbYI2SrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Sep 2008 14:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYI2SrM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:47:12 -0400
Received: from george.spearce.org ([209.20.77.23]:54094 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbYI2SrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:47:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 287703835F; Mon, 29 Sep 2008 18:47:09 +0000 (UTC)
Content-Disposition: inline
X-master-at: c76dc9592d1c770212d50ee7a7028a74f472f23b
X-next-at: 7f0eb98a28d41e28f6a7b72e118d72de01bab1a7
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97045>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

I'll be on vacation til Oct 08; proposal/review/discussion/improvement
cycle based on e-mails and the distributed nature of git mean that it
shouldn't keep the participants from further improving the system.  I'v=
e
asked Shawn to look after in-flight patches during the time, so hopeful=
ly
when I come back I'll see a much better git ;-).

----------------------------------------------------------------
[New Topics]

* nd/narrow (Sun Sep 14 20:07:59 2008 +0700) 9 commits
 - grep: skip files that have not been checked out
 - checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 - Prevent diff machinery from examining worktree outside narrow
   checkout
 - Add tests for updating no-checkout entries in index
 - ls-files: add --narrow-checkout option to "will checkout" entries
 - update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 - update-index: refactor mark_valid() in preparation for new options
 - Introduce CE_NO_CHECKOUT bit
 - Extend index to save more flags

This is an early half of the earlier series (I haven't had chance to lo=
ok
at the updated series yet), and should be replaced with the updated one
posted recently.

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* pb/submodule (Fri Sep 12 23:09:19 2008 +0200) 1 commit
 - t7400: Add short "git submodule add" testsuite

Waiting for a reroll.

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 - Use xdiff caching to improve git blame performance
 - Allow xdiff machinery to cache hash results for a file
 - Always initialize xpparam_t to 0
 - Bypass textual patch generation and parsing in git blame
 - Allow alternate "low-level" emit function from xdl_diff

R=C3=A9ne had good comments on how the callback should be structured.

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 - git-am: Pass the --directory option through to git-apply

I think this is still buggy and drops the option when am stops with
conflicts.

----------------------------------------------------------------
[Will be merged to 'master/maint' soon]

* mv/merge-recursive (Sat Sep 6 18:29:49 2008 +0200) 11 commits
 + builtin-merge: release the lockfile in try_merge_strategy()
 + merge-recursive: get rid of virtual_id
 + merge-recursive: move current_{file,directory}_set to struct
   merge_options
 + merge-recursive: move the global obuf to struct merge_options
 + merge-recursive: get rid of the index_only global variable
 + merge-recursive: move call_depth to struct merge_options
 + cherry-pick/revert: make direct internal call to merge_tree()
 + builtin-merge: avoid run_command_v_opt() for recursive and subtree
 + merge-recursive: introduce merge_options
 + merge-recursive.c: Add more generic merge_recursive_generic()
 + Split out merge_recursive() to merge-recursive.c

(Tip at 4271666)

* ho/dirstat-by-file (Fri Sep 5 22:27:35 2008 +0300) 1 commit
 + diff --dirstat-by-file: count changed files, not lines

(Tip at fd33777)

* jc/safe-c-l-d (Tue Sep 2 14:10:15 2008 -0700) 1 commit
 + safe_create_leading_directories(): make it about "leading"
   directories

(Tip at 5f0bdf5)

* jc/apply-include-exclude (Mon Aug 25 01:05:31 2008 -0700) 1 commit
 + git-apply:--include=3Dpathspec

(Tip at 6ecb1ee)

* mv/commit-tree (Wed Sep 10 22:10:33 2008 +0200) 3 commits
 + t7603: add new testcases to ensure builtin-commit uses
   reduce_heads()
 + builtin-commit: use commit_tree()
 + commit_tree(): add a new author parameter

(Tip at 7a172b0)

* pb/autocorrect-wrapper (Wed Sep 10 17:54:28 2008 +0200) 1 commit
 + git wrapper: also use aliases to correct mistyped commands

(Tip at 746c221)

* jc/better-conflict-resolution (Thu Sep 4 23:48:48 2008 +0200) 15 comm=
its
 + Fix AsciiDoc errors in merge documentation
 + git-merge documentation: describe how conflict is presented
 + checkout --conflict=3D<style>: recreate merge in a non-default style
 + checkout -m: recreate merge when checking out of unmerged index
 + Merge branch 'jc/maint-checkout-fix' into 'jc/better-conflict-
   resolution'
 + git-merge-recursive: learn to honor merge.conflictstyle
 + merge.conflictstyle: choose between "merge" and "diff3 -m" styles
 + rerere: understand "diff3 -m" style conflicts with the original
 + rerere.c: use symbolic constants to keep track of parsing states
 + xmerge.c: "diff3 -m" style clips merge reduction level to EAGER or
   less
 + xmerge.c: minimum readability fixups
 + xdiff-merge: optionally show conflicts in "diff3 -m" style
 + xdl_fill_merge_buffer(): separate out a too deeply nested function
 + checkout --ours/--theirs: allow checking out one side of a
   conflicting merge
 + checkout -f: allow ignoring unmerged paths when checking out of
   the index

(Tip at 3407a7a)

* jc/alternate-push (Tue Sep 9 01:27:10 2008 -0700) 4 commits
 + push: receiver end advertises refs from alternate repositories
 + push: prepare sender to receive extended ref information from the
   receiver
 + receive-pack: make it a builtin
 + is_directory(): a generic helper function

(Tip at d79796b)

* bc/master-diff-hunk-header-fix (Sat Sep 20 18:36:22 2008 -0700) 10 co=
mmits
 + Merge branch 'bc/maint-diff-hunk-header-fix' into bc/master-diff-
   hunk-header-fix
 + diff hunk pattern: fix misconverted "\{" tex macro introducers
 + diff: fix "multiple regexp" semantics to find hunk header comment
 + diff: use extended regexp to find hunk headers
 + Merge branch 'bc/maint-diff-hunk-header-fix' into bc/master-diff-
   hunk-header-fix
 + diff: use extended regexp to find hunk headers
 + Merge branch 'bc/maint-diff-hunk-header-fix' into bc/master-diff-
   hunk-header-fix
 + diff.*.xfuncname which uses "extended" regex's for hunk header
   selection
 + diff.c: associate a flag with each pattern and use it for
   compiling regex
 + diff.c: return pattern entry pointer rather than just the hunk
   header pattern

(Tip at 92bb978)

* am/status (Mon Sep 8 00:05:03 2008 +0200) 2 commits
 + wt-status: Teach how to discard changes in the working directory
 + wt-status: Split header generation into three functions

(Tip at 4d6e4c4)

I think the above are all ready for 'master'.

* mg/maint-remote-fix (Mon Sep 22 10:57:51 2008 +0200) 1 commit
 + make "git remote" report multiple URLs

(Tip at 7d20e21)

* bc/maint-diff-hunk-header-fix (Sat Sep 20 15:30:12 2008 -0700) 5 comm=
its
 + diff hunk pattern: fix misconverted "\{" tex macro introducers
 + diff: use extended regexp to find hunk headers
 + diff.*.xfuncname which uses "extended" regex's for hunk header
   selection
 + diff.c: associate a flag with each pattern and use it for
   compiling regex
 + diff.c: return pattern entry pointer rather than just the hunk
   header pattern

(Tip at 96d1a8e)

The above two are ready for 'maint'.

----------------------------------------------------------------
[Actively Cooking]

* tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
 + Documentation: Refer to git-rebase(1) to warn against rewriting
 + Documentation: new upstream rebase recovery section in git-rebase

My impression from the last round of discusson on the third patch in th=
is
series (not queued here) was that as long as we do not present it as "O=
ne
True Workflow", the description was a good starting point, possibly oth=
ers
to add other recommended flows later.

* pb/commit-where (Mon Sep 8 01:05:41 2008 +0200) 1 commit
 + builtin-commit.c: show on which branch a commit was added

Tentatively kicked back to "still cooking" status after Jeff voiced his
annoyance.  I personally do not like making this multi-line as Jeff
suggested as an alternative (the message already is too verbose to my
taste).

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 + date/time: do not get confused by fractional seconds

* jc/add-ita (Thu Aug 21 01:44:53 2008 -0700) 1 commit
 + git-add --intent-to-add (-N)

Teaches "git add" to record only the intent to add a path later.
I rerolled this without the fake empty blob object.

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

I started making this incremental but the progress is not so great.

----------------------------------------------------------------
[On Hold]

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

The one at second from the tip needs reworking.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

* jc/merge-whitespace (Sun Feb 24 23:29:36 2008 -0800) 1 commit
 - WIP: start teaching the --whitespace=3Dfix to merge machinery

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns =
out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perha=
ps
in 1.7.0, but with the loud whining about moving git-foo out of $PATH w=
e
have been hearing, it might not be a bad idea to drop this.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will=
 be
hit due to tcl/tk's limitation, so I am holding this back for now.

--=20
Shawn.

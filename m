From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's cooking in git/spearce.git (Oct 2008, #02; Sun, 12)
Date: Sun, 12 Oct 2008 14:25:43 -0700
Message-ID: <20081012212543.GG4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 23:33:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp8Yg-0007QF-Vw
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 23:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbYJLVZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 17:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbYJLVZp
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 17:25:45 -0400
Received: from george.spearce.org ([209.20.77.23]:44616 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbYJLVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 17:25:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2EEDC38360; Sun, 12 Oct 2008 21:25:43 +0000 (UTC)
Content-Disposition: inline
X-master-at: 5c283eb13c94be6ca974aa722159dc9838d10d97
X-next-at: 340fcf496c9eb7c8be7f14efdd282666a6b6a1f1
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98057>

What's cooking in git/spearce.git (Oct 2008, #02; Sun, 12)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

gitster's back and I'm expecting he will take over from here.

----------------------------------------------------------------
[New Topics]

* dp/checkattr (Tue Oct 7 04:16:52 2008 +0400) 2 commits
 + check-attr: Add --stdin option
 + check-attr: add an internal check_attr() function

Batch attr lookup via --stdin, for gitk and git-gui.

* mv/clonev (Thu Oct 9 01:40:32 2008 +0200) 1 commit
 + Implement git clone -v

Does what it says it does.  This may be ready for master soon,
its a pretty trivial change.

* gb/refactor-pathinfo (Fri Oct 10 20:42:26 2008 +0200) 1 commit
 + gitweb: refactor input parameters parse/validation

A major cleanup on the way gitweb parses its input arguments.
=46uture gitweb patches to add more arguments into the PATH_INFO
depend upon this initial cleanup work.

* ml/cygwin-filemode (Sun Oct 12 14:44:46 2008 -0400) 1 commit
 - compat/cygwin.c - Use cygwin's stat if core.filemode =3D=3D true

I think another version may be coming to reuse the core.filemode
parsing so this patch isn't in next yet.

* sh/rebase-i-p (Wed Oct 8 01:41:57 2008 -0500) 7 commits
 - rebase-i-p: if todo was reordered use HEAD as the rewritten parent
 - rebase-i-p: do not include non-first-parent commits touching
   UPSTREAM
 - rebase-i-p: only list commits that require rewriting in todo
 - rebase-i-p: fix 'no squashing merges' tripping up non-merges
 - rebase-i-p: delay saving current-commit to REWRITTEN if squashing
 - rebase-i-p: use HEAD for updating the ref instead of mapping
   OLDHEAD
 - rebase-i-p: test to exclude commits from todo based on its parents

Changes the `rebase -i -p` behavior to behave like git sequencer's
rewrite of `rebase -i` would behave.  Its parked in pu because I
have not had the time to review the series in detail.  First glance
looked OK to me.

* js/keephardlinks (Sat Oct 11 13:45:13 2008 +0200) 1 commit
 - Introduce core.keepHardLinks

The value of this change is currently in question, and the commit
message doesn't justify it very well.

* jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
 - gitweb: Better processing format string in custom links in navbar

Waiting for some sort of response from Pasky.

----------------------------------------------------------------
[Graduated to "master"]

* mw/sendemail (Sun Sep 28 07:51:21 2008 +0300) 10 commits
 + bash completion: Add --[no-]validate to "git send-email"
 + send-email: signedoffcc -> signedoffbycc, but handle both
 + Docs: send-email: Create logical groupings for man text
 + Docs: send-email: Create logical groupings for --help text
 + Docs: send-email: Remove unnecessary config variable description
 + Docs: send-email: --chain_reply_to -> --[no-]chain-reply-to
 + send-email: change --no-validate to boolean --[no-]validate
 + Docs: send-email: Man page option ordering
 + Docs: send-email usage text much sexier
 + Docs: send-email's usage text and man page mention same options

* jc/add-ita (Thu Aug 21 01:44:53 2008 -0700) 1 commit
 + git-add --intent-to-add (-N)

* mg/verboseprune (Mon Sep 29 18:49:52 2008 +0200) 1 commit
 + make prune report removed objects on -v

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 + date/time: do not get confused by fractional seconds

* dp/cywginstat (Tue Sep 30 17:53:47 2008 +0400) 3 commits
 + cygwin: Use native Win32 API for stat
 + mingw: move common functionality to win32.h
 + add have_git_dir() function

Performance improvement for Cygwin, bypassing the Cygwin stat
function and using one more like MinGW uses.  Probably ready for
master on the next round.  Several Cygwin users have given praise
to the series.

* js/objc-funchdr (Wed Oct 1 00:46:34 2008 +0100) 1 commit
 + Teach git diff about Objective-C syntax

Adds support for Objective-C function headers.

* dm/svn-branch (Sat Oct 4 19:35:17 2008 -0700) 1 commit
 + Add git-svn branch to allow branch creation in SVN repositories

Adds "git svn branch" to build branches remotely in SVN.

* pb/gitweb (Fri Oct 3 07:41:25 2008 -0700) 7 commits
 + Merge branch 'pb/gitweb-tagcloud' into pb/gitweb
 + gitweb: Support for simple project search form
 + gitweb: Make the by_tag filter delve in forks as well
 + gitweb: Support for tag clouds
 + gitweb: Add support for extending the action bar with custom links
 + gitweb: Sort the list of forks on the summary page by age
 + gitweb: Clean-up sorting of project list

* ph/parseopt (Thu Oct 2 14:59:20 2008 +0200) 3 commits
 + parse-opt: migrate builtin-merge-file.
 + parse-opt: migrate git-merge-base.
 + parse-opt: migrate fmt-merge-msg.

* rz/grepz (Wed Oct 1 18:11:15 2008 +0200) 1 commit
 + git grep: Add "-z/--null" option as in GNU's grep.

* mv/merge-refresh (Fri Oct 3 15:02:31 2008 +0200) 1 commit
 + builtin-merge: refresh the index before calling a strategy

* bc/xdiffnl (Wed Oct 1 14:28:26 2008 -0500) 1 commit
 + xdiff-interface.c: strip newline (and cr) from line before pattern
   matching

* jk/maint-soliconv (Fri Oct 3 02:39:36 2008 -0400) 1 commit
 + Makefile: do not set NEEDS_LIBICONV for Solaris 8

* sg/maint-intrebase-msghook (Fri Oct 3 11:33:20 2008 +0200) 2 commits
 + rebase -i: remove leftover debugging
 + rebase -i: proper prepare-commit-msg hook argument when squashing

* bc/maint-stashref (Thu Oct 2 18:52:11 2008 -0500) 1 commit
 + git-stash.sh: fix flawed fix of invalid ref handling (commit
   da65e7c1)

The latter three were merged to 'maint' first.

----------------------------------------------------------------
[Old New Topics]

* ns/rebase-noverify (Mon Oct 6 14:14:29 2008 +0900) 1 commit
 + rebase --no-verify

This adds --no-verify to git rebase, to avoid the pre-rebase hook.
Lacks documentation but otherwise looks sound.

* mv/merge-noff (Fri Oct 3 14:04:47 2008 +0200) 1 commit
 + builtin-commit: use reduce_heads() only when appropriate

=46ixes "git merge --no-ff --no-commit".

* ae/preservemerge (Mon Sep 29 22:28:57 2008 +0200) 1 commit
 + rebase: Support preserving merges in non-interactive mode

* sh/maint-rebase3 (Sun Oct 5 23:26:52 2008 -0500) 1 commit
 - rebase--interactive: fix parent rewriting for dropped commits

A prior version of sh/rebase-i-p.  This should be dropped.

* pb/rename-rowin32 (Fri Oct 3 12:20:43 2008 +0200) 1 commit
 - Do not rename read-only files during a push

Supposedly fixes pack file renames on Windows, but it makes the
test suite fail on Linux.  I haven't debugged why yet.  Its very
likely we need a replacement patch before this can move forward.

* sp/describe-lwtag (Tue Sep 30 12:03:41 2008 -0700) 1 commit
 - describe: Make --tags and --all match lightweight tags more often

Based on feedback from the list this needs another spin.  I will
post a replacement patch soon.

* gb/formatpatch-autonbr (Thu Oct 2 16:55:39 2008 -0400) 1 commit
 - format-patch: autonumber by default

=46ails the test suite; some of the test vectors need to be updated
to account for the new default.  Someone who cares about this
change should follow through on the test suite update, or this may
get dropped.

* jc/merge-whitespace (Sun Feb 24 23:29:36 2008 -0800) 1 commit
 . WIP: start teaching the --whitespace=3Dfix to merge machinery

This has a merge conflict with `next` and isn't even in pu right now.

* jk/diff-convfilter (Sun Oct 5 17:43:45 2008 -0400) 4 commits
 - diff: add filter for converting binary to text
 - diff: introduce diff.<driver>.binary
 - diff: unify external diff and funcname parsing code
 - t4012: use test_cmp instead of cmp

A general cleanup on how diff drivers are implemented.  Its still
missing documentation updates and tests but doesn't break anything
current as far as I can tell.  It needs more review before it can
be slated for 'next'.

----------------------------------------------------------------
[Stuck Topics]

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

Recently updated with a repost.  I've been too swamped at day-job
to actively review the series.  There has been some discussion on
list about it so its not stalled, but it needs more eyeballs.

* gb/gitweb-pathinfo (Thu Oct 2 02:10:34 2008 +0200) 6 commits
 . gitweb: generate parent..current URLs
 . gitweb: parse parent..current syntax from pathinfo
 . gitweb: use_pathinfo filenames start with /
 . gitweb: generate project/action/hash URLs
 . gitweb: refactor input parameters parse/validation
 . gitweb: parse project/action/hash_base:filename PATH_INFO

Still going through revisions on the git ML.  Its great work and
is heading in the right direction.  But the discussion and patch
generation rate is too high to merge the topic into next just yet.

So its waiting for a re-roll of the series once discussion settles
down and there is a final patch series available.

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* pb/submodule (Fri Sep 12 23:09:19 2008 +0200) 1 commit
 - t7400: Add short "git submodule add" testsuite

Still waiting for a reroll.  Should be dropped next week if we
don't get one during this coming week.

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 - Use xdiff caching to improve git blame performance
 - Allow xdiff machinery to cache hash results for a file
 - Always initialize xpparam_t to 0
 - Bypass textual patch generation and parsing in git blame
 - Allow alternate "low-level" emit function from xdl_diff

(jc: R=C3=A9ne had good comments on how the callback should be
 structured.)

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 - git-am: Pass the --directory option through to git-apply

(jc: I think this is still buggy and drops the option when am stops
 with conflicts.)

----------------------------------------------------------------
[Will be merged to 'master/maint' soon]

* pb/commit-where (Fri Oct 3 22:13:49 2008 -0400) 4 commits
 + tutorial: update output of git commit
 + reformat informational commit message
 + git commit: Reformat output somewhat
 + builtin-commit.c: show on which branch a commit was added

I think this topic is settled for now.

----------------------------------------------------------------
[Actively Cooking]

* tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
 + Documentation: Refer to git-rebase(1) to warn against rewriting
 + Documentation: new upstream rebase recovery section in git-rebase

(jc: My impression from the last round of discusson on the third
 patch in this series (not queued here) was that as long as we
 do not present it as "One True Workflow", the description was
 a good starting point, possibly others to add other recommended
 flows later.)

An update came in recently, but I haven't applied it.

----------------------------------------------------------------
[On Hold]

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

(jc: I started making this incremental but the progress is not
 so great.)

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

(jc: The one at second from the tip needs reworking.)

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This is a great idea, but IIRC its implementation has a deadlock
during communication between the peers.  Someone needs to pick up
this topic and resolve the deadlock before it can continue.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

(jc: This would be the right thing to do for command line use,
 but gitk will be hit due to tcl/tk's limitation, so I am holding
 this back for now.)
--=20
Shawn.

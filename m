From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2008, #09; Sun, 31)
Date: Sun, 31 Aug 2008 23:16:57 -0700
Message-ID: <7vd4jo1jc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 08:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka2k1-0004XK-93
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 08:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbYIAGRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 02:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYIAGRG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 02:17:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbYIAGRE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 02:17:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 043B1696A2;
	Mon,  1 Sep 2008 02:17:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 87D0A696A1; Mon,  1 Sep 2008 02:17:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97DAA044-77ED-11DD-8843-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94531>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

----------------------------------------------------------------
[New Topics]

Most of them are expected to spend only short amount of time on 'next'
before graduating to 'master'.

* jc/maint-checkout-fix (Fri Aug 29 13:40:36 2008 -0700) 1 commit
 + checkout: do not check out unmerged higher stages randomly

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 - git-am: Pass the --directory option through to git-apply

* np/safer-pack (Fri Aug 29 16:08:02 2008 -0400) 5 commits
 + fixup_pack_header_footer(): use nicely aligned buffer sizes
 + index-pack: use fixup_pack_header_footer()'s validation mode
 + pack-objects: use fixup_pack_header_footer()'s validation mode
 + improve reliability of fixup_pack_header_footer()
 + pack-objects: improve returned information from write_one()

* jc/hide-cr-in-diff-from-less (Wed Aug 27 19:48:01 2008 -0700) 1 commi=
t
 + diff: Help "less" hide ^M from the output

* jc/better-conflict-resolution (Sun Aug 31 20:36:32 2008 -0700) 15 com=
mits
 . git-merge documentation: describe how conflict is presented
 . checkout --conflict=3D<style>: recreate merge in a non-default style
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
 + checkout: do not check out unmerged higher stages randomly

* tr/rev-list-reverse (Mon Sep 1 00:31:37 2008 +0200) 5 commits
 + t6013: replace use of 'tac' with equivalent Perl
 + rev-list: fix --reverse interaction with --parents
 + Topo-sort before --simplify-merges
 + revision traversal: show full history with merge simplification
 + revision.c: whitespace fix

* rf/man-env (Fri Aug 29 17:00:43 2008 +0200) 1 commit
 + builtin-help: fallback to GIT_MAN_VIEWER before man

* ar/autospell (Sun Aug 31 15:54:58 2008 +0200) 2 commits
 + Add help.autocorrect to enable/disable autocorrecting
 + git wrapper: DWIM mistyped commands

* ho/dashless (Sun Aug 31 09:39:19 2008 -0700) 2 commits
 + 'git foo' program identifies itself without dash in die() messages
 + Start conforming code to "git subcmd" style

* jc/author-nickname (Tue Aug 26 23:13:13 2008 -0700) 1 commit
 + git commit --author=3D$name: look $name up in existing commits

* dp/pid-uintmax (Sun Aug 31 14:09:39 2008 +0200) 1 commit
 + cast pid_t's to uintmax_t to improve portability

* nd/worktree (Sat Aug 30 16:15:32 2008 +0700) 5 commits
 - setup_git_directory(): fix move to worktree toplevel directory
 - update-index: fix worktree setup
 + read-tree: setup worktree if merge is required
 + grep: fix worktree setup
 + diff*: fix worktree setup

The last two fail test suite.

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 - Use xdiff caching to improve git blame performance
 - Allow xdiff machinery to cache hash results for a file
 - Always initialize xpparam_t to 0
 - Bypass textual patch generation and parsing in git blame
 - Allow alternate "low-level" emit function from xdl_diff

R=C3=A9ne had good comments on how the callback should be structured.

* jc/cc-ld-dynpath (Sat Aug 16 15:01:23 2008 +0200) 2 commits
 - configure: auto detect dynamic library path switches
 - Makefile: Allow CC_LD_DYNPATH to be overriden

Needs success reports from people who do use user-defined dynamic libra=
ry
path when they build their "git" before this series can go anywhere.

----------------------------------------------------------------
[Will be merged to "master" soon]

* tr/filter-branch (Sun Aug 31 10:41:01 2008 -0700) 14 commits
 + Merge branch 'tr/rev-list-docs' into tr/filter-branch
 + Merge branch 'jc/post-simplify' (early part) into tr/filter-branch
 + revision --simplify-merges: make it a no-op without pathspec
 + revision --simplify-merges: do not leave commits unprocessed
 + revision --simplify-merges: use decoration instead of commit->util
   field
 + Documentation: rev-list-options: move --simplify-merges
   documentation
 + Merge branch 'jc/post-simplify' into tr/rev-list-docs
 + filter-branch: use --simplify-merges
 + Merge branch 'jc/post-simplify' into tr/filter-branch
 + filter-branch: fix ref rewriting with --subdirectory-filter
 + filter-branch: Extend test to show rewriting bug
 + Topo-sort before --simplify-merges
 + revision traversal: show full history with merge simplification
 + revision.c: whitespace fix

This now merges up all (and only) the necessary pieces from the
post-simplify topic and the documentation updates, ready to be merged t=
o
"master".

----------------------------------------------------------------
[Actively Cooking]

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 + date/time: do not get confused by fractional seconds

* jc/maint-name-hash-clear (Sat Aug 23 13:05:10 2008 -0700) 1 commit
 + discard_cache: reset lazy name_hash bit

I spotted this by accident while working on something unrelated.

When a program calls discard_cache() to read the index again, we do not
properly re-initialize the name_hash structure that is used by the case
insensitivitly logic.  This _might_ improve issues people may be having=
 on
case insensitive filesystems.  I dunno.

* jc/add-ita (Thu Aug 21 01:44:53 2008 -0700) 1 commit
 + git-add --intent-to-add (-N)

Teaches "git add" to record only the intent to add a path later.
I rerolled this without the fake empty blob object.

* cc/bisect (Fri Aug 22 05:52:29 2008 +0200) 2 commits
 + bisect: only check merge bases when needed
 + bisect: test merge base if good rev is not an ancestor of bad rev

* mv/merge-recursive (Thu Aug 28 15:43:00 2008 +0200) 4 commits
 - builtin-merge: avoid run_command_v_opt() for recursive and subtree
 - merge-recursive: introduce merge_options
 - merge-recursive.c: Add more generic merge_recursive_generic()
 - Split out merge_recursive() to merge-recursive.c

* jc/diff-prefix (Mon Aug 18 20:08:09 2008 -0700) 1 commit
 + diff: vary default prefix depending on what are compared

As some people may have noticed, I've been running with this one when
sending out "How about this" patches to the discussion threads.

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

I started making this incremental but the progress is not so great.

----------------------------------------------------------------
[On Hold]

* dk/emacs (Tue Aug 26 22:24:40 2008 -0500) 2 commits
 - Teach git.el to mark/unmark files by regexp
 - git.el: Diff only file at point by default

These are still queued but Alexandre had improvement requests so these
will likely be dropped.

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

----------------------------------------------------------------
[Graduated to "master"]

* tl/p4 (Thu Aug 28 00:36:12 2008 +0200) 1 commit
 + git-p4: Fix checkout bug when using --import-local.

* sb/daemon (Sun Aug 24 13:27:10 2008 -0700) 5 commits
 + daemon.c: minor style fixup
 + git-daemon: rewrite kindergarden, new option --max-connections
 + git-daemon: Simplify dead-children reaping logic
 + git-daemon: use LOG_PID, simplify logging code
 + git-daemon: call logerror() instead of error()

* sp/missing-thin-base (Tue Aug 12 11:31:06 2008 -0700) 1 commit
 + pack-objects: Allow missing base objects when creating thin packs

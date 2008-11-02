From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2008, #01; Sun, 02)
Date: Sun, 02 Nov 2008 13:34:49 -0800
Message-ID: <7vbpwx3j7q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>, pasky@suse.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 22:36:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwkcg-0005AT-4z
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 22:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbYKBVfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 16:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbYKBVfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 16:35:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbYKBVfH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 16:35:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92A12770FD;
	Sun,  2 Nov 2008 16:35:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 95C61770F7; Sun,  2 Nov 2008 16:34:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1CAC20A4-A926-11DD-80A4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99876>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

There are backlog patches I'm planning to deal with later today; they d=
o
not appear in this list.

----------------------------------------------------------------
[New Topics]

* mv/maint-branch-m-symref (Sat Nov 1 00:25:44 2008 +0100) 5 commits
 + update-ref --no-deref -d: handle the case when the pointed ref is
   packed
 + git branch -m: forbid renaming of a symref
 + Fix git update-ref --no-deref -d.
 + rename_ref(): handle the case when the reflog of a ref does not
   exist
 + Fix git branch -m for symrefs.

* rs/blame (Sat Oct 25 15:31:36 2008 +0200) 5 commits
 - blame: use xdi_diff_hunks(), get rid of struct patch
 - add xdi_diff_hunks() for callers that only need hunk lengths
 - Allow alternate "low-level" emit function from xdl_diff
 - Always initialize xpparam_t to 0
 - blame: inline get_patch()

* ds/uintmax-config (Sun Oct 26 03:52:47 2008 -0800) 2 commits
 - Add Makefile check for FreeBSD 4.9-SECURITY
 - Build: add NO_UINTMAX_T to support ancient systems

I amended the topmost one to widen the applicability of this new featur=
e
to all FreeBSD 4.*, not limited to 4.9-SECURITY; testing before this hi=
ts
'next' is appreciated.

* ds/autoconf (Sun Nov 2 01:04:46 2008 -0700) 2 commits
 - DONTMERGE: fixup with a convenience macro
 - autoconf: Add link tests to each AC_CHECK_FUNC() test

The topmost one is my attempt to simplify the new way of checking; the
resulting configure.ac produces the identical configure script with or
without it, so I think it is Ok, but testing before this hits 'next' is
appreciated.  If all goes well, I think the two should be squashed into
one patch.

* jk/diff-convfilter-test-fix (Fri Oct 31 01:09:13 2008 -0400) 4 commit=
s
 + Avoid using non-portable `echo -n` in tests.
 + add userdiff textconv tests
 + document the diff driver textconv feature
 + diff: add missing static declaration

* ar/maint-mksnpath (Mon Oct 27 11:22:09 2008 +0100) 7 commits
 + Use git_pathdup instead of xstrdup(git_path(...))
 + git_pathdup: returns xstrdup-ed copy of the formatted path
 + Fix potentially dangerous use of git_path in ref.c
 + Add git_snpath: a .git path formatting routine with output buffer
 + Fix potentially dangerous uses of mkpath and git_path
 + Fix mkpath abuse in dwim_ref and dwim_log of sha1_name.c
 + Add mksnpath which allows you to specify the output buffer

* ar/mksnpath (Thu Oct 30 18:08:58 2008 -0700) 10 commits
 + Merge branch 'ar/maint-mksnpath' into ar/mksnpath
 + Use git_pathdup instead of xstrdup(git_path(...))
 + git_pathdup: returns xstrdup-ed copy of the formatted path
 + Fix potentially dangerous use of git_path in ref.c
 + Add git_snpath: a .git path formatting routine with output buffer
 + Fix potentially dangerous uses of mkpath and git_path
 + Merge branch 'ar/maint-mksnpath' into HEAD
 + Fix potentially dangerous uses of mkpath and git_path
 + Fix mkpath abuse in dwim_ref and dwim_log of sha1_name.c
 + Add mksnpath which allows you to specify the output buffer

----------------------------------------------------------------
[Will be merged to 'master' soon]

* cj/maint-gitpm-fix-maybe-self (Sat Oct 18 20:25:12 2008 +0200) 1 comm=
it
 + Git.pm: do not break inheritance

Looked Ok; will be in 'master' soon.

* gb/gitweb-pathinfo (Tue Oct 21 21:34:54 2008 +0200) 5 commits
 + gitweb: generate parent..current URLs
 + gitweb: parse parent..current syntax from PATH_INFO
 + gitweb: use_pathinfo filenames start with /
 + gitweb: generate project/action/hash URLs
 + gitweb: parse project/action/hash_base:filename PATH_INFO

Seventh iteration.

* ag/blame-encoding (Wed Oct 22 00:55:57 2008 +0400) 1 commit
 + builtin-blame: Reencode commit messages according to git-log
   rules.

Looked Ok; will be in 'master' soon.

* mv/parseopt-checkout-index (Sat Oct 18 03:17:23 2008 +0200) 1 commit
 + parse-opt: migrate builtin-checkout-index.

Looked Ok; will be in 'master' soon.

* sh/rebase-i-p (Wed Oct 22 11:59:30 2008 -0700) 9 commits
 + git-rebase--interactive.sh: comparision with =3D=3D is bashism
 + rebase-i-p: minimum fix to obvious issues
 + rebase-i-p: if todo was reordered use HEAD as the rewritten parent
 + rebase-i-p: do not include non-first-parent commits touching
   UPSTREAM
 + rebase-i-p: only list commits that require rewriting in todo
 + rebase-i-p: fix 'no squashing merges' tripping up non-merges
 + rebase-i-p: delay saving current-commit to REWRITTEN if squashing
 + rebase-i-p: use HEAD for updating the ref instead of mapping
   OLDHEAD
 + rebase-i-p: test to exclude commits from todo based on its parents

Changes the `rebase -i -p` behavior to behave like git sequencer's
rewrite of `rebase -i` would behave.

* np/index-pack (Thu Oct 23 15:05:59 2008 -0400) 5 commits
 + index-pack: don't leak leaf delta result
 + improve index-pack tests
 + fix multiple issues in index-pack
 + index-pack: smarter memory usage during delta resolution
 + index-pack: rationalize delta resolution code

The buglets that caused people on 'next' some surprises are quickly
killed.  Thanks.

----------------------------------------------------------------
[Stalled]

* jk/diff-convfilter (Sun Oct 26 00:50:02 2008 -0400) 8 commits
 - enable textconv for diff in verbose status/commit
 - wt-status: load diff ui config

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

Needs review.

* jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
 - gitweb: Better processing format string in custom links in navbar

Waiting for some sort of response from Pasky.

* jc/gitweb-fix-cloud-tag (Tue Oct 14 21:27:12 2008 -0700) 1 commit
 + Fix reading of cloud tags

Request-for-review-and-ack sent; still waiting for response.

----------------------------------------------------------------
[Dropped]

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 . Use xdiff caching to improve git blame performance
 . Allow xdiff machinery to cache hash results for a file
 . Always initialize xpparam_t to 0
 . Bypass textual patch generation and parsing in git blame
 . Allow alternate "low-level" emit function from xdl_diff

R=C3=A9ne started code restructuring, which is queued to 'pu'; this ser=
ies is
dropped.

----------------------------------------------------------------
[On Hold]

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

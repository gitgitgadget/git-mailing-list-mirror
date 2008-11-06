From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2008, #02; Wed, 05)
Date: Wed, 05 Nov 2008 17:11:33 -0800
Message-ID: <7v1vxplku2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 02:13:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxtQi-0004Eg-81
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 02:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYKFBLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 20:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYKFBLq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 20:11:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbYKFBLo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 20:11:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D310C932CB;
	Wed,  5 Nov 2008 20:11:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EE10F932C8; Wed, 
 5 Nov 2008 20:11:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DEE2F438-AB9F-11DD-8E28-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100205>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* gb/gitweb-snapshot-pathinfo (Sun Nov 2 10:21:39 2008 +0100) 3 commits
 - gitweb: embed snapshot format parameter in PATH_INFO
 - gitweb: retrieve snapshot format from PATH_INFO
 - gitweb: make the supported snapshot formats array global

Waiting for re-Ack.

* bc/maint-keep-pack (Mon Nov 3 14:43:22 2008 -0600) 3 commits
 - pack-objects: honor '.keep' files
 - packed_git: convert pack_local flag into a bitfield and add
   pack_keep
 - t7700: demonstrate mishandling of objects in packs with a .keep
   file

* st/tag (Wed Nov 5 00:20:36 2008 +0100) 2 commits
 - tag: Add more tests about mixing incompatible modes and options
 - tag: Check that options are only allowed in the appropriate mode

Still needs fix not to update unchanged refs.

* np/pack-safer (Wed Oct 29 19:02:52 2008 -0400) 9 commits
 - pack-objects: don't leak pack window reference when splitting
   packs
 - extend test coverage for latest pack corruption resilience
   improvements
 - pack-objects: allow "fixing" a corrupted pack without a full
   repack
 - make find_pack_revindex() aware of the nasty world
 - make check_object() resilient to pack corruptions
 - make packed_object_info() resilient to pack corruptions
 - make unpack_object_header() non fatal
 - better validation on delta base object offsets
 - close another possibility for propagating pack corruption

* mv/remote-rename (Mon Nov 3 19:26:18 2008 +0100) 1 commit
 . Implement git remote rename

* lt/decorate (Mon Nov 3 11:25:46 2008 -0800) 4 commits
 + revision traversal: '--simplify-by-decoration'
 + Make '--decorate' set an explicit 'show_decorations' flag
 + revision: make tree comparison functions take commits rather than
   trees
 + Add a 'source' decorator for commits

* cb/maint-update-ref-fix (Wed Nov 5 21:55:54 2008 +0100) 2 commits
 + push: fix local refs update if already up-to-date
 + do not force write of packed refs

----------------------------------------------------------------
[Graduated to "master"]

* mv/maint-branch-m-symref (Sat Nov 1 00:25:44 2008 +0100) 5 commits
 + update-ref --no-deref -d: handle the case when the pointed ref is
   packed
 + git branch -m: forbid renaming of a symref
 + Fix git update-ref --no-deref -d.
 + rename_ref(): handle the case when the reflog of a ref does not
   exist
 + Fix git branch -m for symrefs.

Will merge down to 'maint' in the next round.

* ar/maint-mksnpath (Mon Oct 27 11:22:09 2008 +0100) 7 commits
 + Use git_pathdup instead of xstrdup(git_path(...))
 + git_pathdup: returns xstrdup-ed copy of the formatted path
 + Fix potentially dangerous use of git_path in ref.c
 + Add git_snpath: a .git path formatting routine with output buffer
 + Fix potentially dangerous uses of mkpath and git_path
 + Fix mkpath abuse in dwim_ref and dwim_log of sha1_name.c
 + Add mksnpath which allows you to specify the output buffer

Will merge down to 'maint' in the next round.

* cj/maint-gitpm-fix-maybe-self (Sat Oct 18 20:25:12 2008 +0200) 1 commit
 + Git.pm: do not break inheritance

Will merge down to 'maint' in the next round.

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

* mv/parseopt-checkout-index (Sat Oct 18 03:17:23 2008 +0200) 1 commit
 + parse-opt: migrate builtin-checkout-index.

* sh/rebase-i-p (Wed Oct 22 11:59:30 2008 -0700) 9 commits
 + git-rebase--interactive.sh: comparision with == is bashism
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

* jc/gitweb-fix-cloud-tag (Tue Oct 14 21:27:12 2008 -0700) 1 commit
 + Fix reading of cloud tags

Got tired of waiting for an Ack.

----------------------------------------------------------------
[Actively Cooking]

* rs/blame (Sat Oct 25 15:31:36 2008 +0200) 5 commits
 + blame: use xdi_diff_hunks(), get rid of struct patch
 + add xdi_diff_hunks() for callers that only need hunk lengths
 + Allow alternate "low-level" emit function from xdl_diff
 + Always initialize xpparam_t to 0
 + blame: inline get_patch()

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 4 commits
 . [WaitForResponse] Add autoconf tests for pthreads
 + Make Pthread link flags configurable
 + Add Makefile check for FreeBSD 4.9-SECURITY
 + Build: add NO_UINTMAX_T to support ancient systems

The topmost one unconditionally enables threaded delta search on any
platform on which Pthread library is detected to be available, which
may not be what we want.

* ds/autoconf (Sun Oct 26 03:52:19 2008 -0800) 1 commit
 + autoconf: Add link tests to each AC_CHECK_FUNC() test

Attempts to help FreeBSD whose compiler does not error out when told to
compile a program that calls unavailable functions.

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

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

----------------------------------------------------------------
[Stalled]

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

From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #05; Sun, 15)
Date: Sun, 15 Jul 2012 22:33:29 -0700
Message-ID: <7vobng46dy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 07:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqdwH-0003GQ-KK
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 07:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab2GPFdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 01:33:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab2GPFdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 01:33:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A7E35083;
	Mon, 16 Jul 2012 01:33:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	AN47JC4hysCKBHjXJzvs7NWxYo=; b=lMTyWmH/j+DqtsrQE52K2iONNfCFuRjd+
	2Cdy+65ITn4d+pr/Zbu53pNpKNto8DYTcrVN79gGlbVZsRF3ulfHSDLQd4zSSEEO
	H1KGBmmsX/KBVgG8p1CcOfb62SBhmShlbxZMz27P7TFf5GwvicAShewqvRZUnfCa
	Agx0otn4m4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fGZ
	9Qk4mCQJfHwX6Di6LBfdNK7B2liFX8O9Pin+gI8R1kzy2hqEvi6/HVjD3UDrBM3x
	IMlsUsMWPxdviTNWv8NsdfTsA3u6EurzHEcKNpI3REeO44CqfoimL47IlVhujyHd
	/7HEhnR7M3ee6zJt0xI99L4MpCewSaYAKCd/iyUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E675F5082;
	Mon, 16 Jul 2012 01:33:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 781375074; Mon, 16 Jul 2012
 01:33:34 -0400 (EDT)
X-master-at: 31c79549b85c6393be4f40432f5b86ebc097fc7e
X-next-at: fdb3850c586fd1eced5e0456ef599f9c0c9191d9
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9312E40-CF07-11E1-BB59-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201494>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The sixth batch of topics are now in 'master'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* sn/doc-typofix (2012-07-14) 1 commit
 - doc: A few minor copy edits.

--------------------------------------------------
[Graduated to "master"]

* ar/clone-honor-umask-at-top (2012-07-09) 3 commits
  (merged to 'next' on 2012-07-10 at 680bc22)
 + add: create ADD_EDIT.patch with mode 0666
 + rerere: make rr-cache fanout directory honor umask
 + Restore umasks influence on the permissions of work tree created by clone

A handful of files and directories we create had tighter than
necessary permission bits when the user wanted to have group
writability (e.g. by setting "umask 002").

* cw/amend-commit-without-message (2012-07-09) 1 commit
  (merged to 'next' on 2012-07-10 at e7c75d5)
 + Allow edit of empty message with commit --amend

"commit --amend" used to refuse amending a commit with an empty log
message, with or without "--allow-empty-message".

* cw/rebase-i-root (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-05 at aeb4c56)
 + t3404: make test 57 work with dash and others
  (merged to 'next' on 2012-07-03 at 231c0a4)
 + Add tests for rebase -i --root without --onto
 + rebase -i: support --root without --onto

"git rebase [-i] --root $tip" can now be used to rewrite all the
history down to the root.

* jc/apply-3way (2012-07-09) 19 commits
  (merged to 'next' on 2012-07-10 at fb5c872)
 + apply: tests for the --3way option
 + apply: document --3way option
 + apply: allow rerere() to work on --3way results
 + apply: register conflicted stages to the index
 + apply: --3way with add/add conflict
 + apply: move verify_index_match() higher
 + apply: plug the three-way merge logic in
 + apply: fall back on three-way merge
 + apply: accept -3/--3way command line option
 + apply: move "already exists" logic to check_to_create()
 + apply: move check_to_create_blob() closer to its sole caller
 + apply: further split load_preimage()
 + apply: refactor "previous patch" logic
 + apply: split load_preimage() helper function out
 + apply: factor out checkout_target() helper function
 + apply: refactor read_file_or_gitlink()
 + apply: clear_image() clears things a bit more
 + apply: a bit more comments on PATH_TO_BE_DELETED
 + apply: fix an incomplete comment in check_patch()

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

* jk/index-pack-streaming-fix (2012-07-10) 1 commit
  (merged to 'next' on 2012-07-13 at c575338)
 + index-pack: loop while inflating objects in unpack_data

The streaming index-pack introduced in 1.7.11 had a data corruption
bug, and this should fix it.

* jk/maint-commit-amend-only-no-paths (2012-07-10) 1 commit
  (merged to 'next' on 2012-07-10 at 1c650c2)
 + commit: fix "--amend --only" with no pathspec

"git commit --amend --only --" was meant to allow "Clever" people to
rewrite the commit message without making any change even when they
have already changes for the next commit added to their index, but
it never worked as advertised since it was introduced in 1.3.0 era.

* jk/push-delete-ref-error-message (2012-07-03) 1 commit
  (merged to 'next' on 2012-07-09 at 82c6bd2)
 + push: don't guess at qualifying remote refs on deletion

The error message from "git push $there :bogo" mentioned we tried
and failed to guess what ref is being deleted based on the LHS of
the refspec, which we don't.

* jn/makefile-cleanup (2012-07-09) 14 commits
  (merged to 'next' on 2012-07-10 at f55e6a1)
 + Makefile: document ground rules for target-specific dependencies
 + Makefile: move GIT-VERSION-FILE dependencies closer to use
 + Makefile: build instaweb similar to other scripts
 + Makefile: update scripts when build-time parameters change
 + Makefile: do not replace @@GIT_VERSION@@ in shell scripts
 + Makefile: split prefix flags from GIT-CFLAGS
 + Makefile: be silent when only GIT_USER_AGENT changes
 + Makefile: split GIT_USER_AGENT from GIT-CFLAGS
 + Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
 + Makefile: apply dependencies consistently to sparse/asm targets
 + Makefile: do not have git.o depend on common-cmds.h
 + Makefile: fold XDIFF_H and VCSSVN_H into LIB_H
 + Makefile: fold MISC_H into LIB_H
 + Makefile: sort LIB_H list

Tightens dependency rules to avoid unnecessary recompilation.

* pw/git-p4-jobs (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-10 at c6ef8f9)
 + git p4: notice Jobs lines in git commit messages
 + git p4 test: refactor marshal_dump
 + git p4: remove unused P4Submit interactive setting

Teach "git p4" to notice "Jobs:" in the log message and relay it to
Perforce to trigger its "jobs" support.

* pw/git-p4-move (2012-07-12) 2 commits
  (merged to 'next' on 2012-07-13 at 648a8ad)
 + git p4: add support for 'p4 move' in P4Submit
 + git p4: refactor diffOpts calculation

* tg/maint-cache-name-compare (2012-07-11) 1 commit
  (merged to 'next' on 2012-07-13 at 0d07ddc)
 + cache_name_compare(): do not truncate while comparing paths
 (this branch is used by tg/ce-namelen-field.)

Even though the index can record pathnames longer than 1<<12 bytes,
in some places we were not comparing them in full, potentially
replacing index entries instead of adding.

Will merge down to older maintenance releases.

--------------------------------------------------
[Stalled]

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
There still seem to be other bugs hiding (e.g. try pushing twice).

Not ready.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* as/t4012-style-updates (2012-07-12) 7 commits
 - t4012: use 'printf' instead of 'dd' to generate a binary file
 - t4012: Re-indent test snippets
 - t4012: Make --shortstat test more robust
 - t4012: Break up pipe into serial redirections
 - t4012: Actually quote the sed script
 - t4012: Unquote git command fragment in test title
 - t4012: modernize style for quoting

Expecting a reroll.

* jl/maint-1.7.10-recurse-submodules-with-symlink (2012-07-12) 1 commit
 - submodules: don't stumble over symbolic links when cloning recursively

When "git submodule add" clones a submodule repository, it can get
confused where to store the resulting submodule repository in the
superproject's .git/ directory when there is a symbolic link in the
path to the current directory.

Will merge to 'next'.

* mm/config-xdg (2012-07-12) 2 commits
 - fixup! config: fix several access(NULL) calls
 - config: fix several access(NULL) calls

Either we do the stupid literal conversion (shown in fixup!), or the
reason why we special case missing HOME needs to be better explained.

* jk/revision-walk-stop-at-max-count (2012-07-13) 1 commit
 - revision: avoid work after --max-count is reached

"git log -n 1 -- rarely-touched-path" was spending unnecessary
cycles after showing the first change to find the next one, only to
discard it.

Will merge to 'next'.

* pg/maint-1.7.9-am-where-is-patch (2012-07-13) 1 commit
 - am: indicate where a failed patch is to be found

When "git am" failed, old timers knew to check .git/rebase-apply/patch
to see what went wrong, but we never told the users about it.

Will merge to 'next'.

* jc/maint-filter-branch-epoch-date (2012-07-12) 3 commits
  (merged to 'next' on 2012-07-13 at d144342)
 + t7003: add test to filter a branch with a commit at epoch
 + date.c: Fix off by one error in object-header date parsing
  (merged to 'next' on 2012-07-10 at f9774ca)
 + filter-branch: do not forget the '@' prefix to force git-timestamp

In 1.7.9 era, we taught "git rebase" about the raw timestamp format
but we did not teach the same trick to "filter-branch", which rolled
a similar logic on its own.

Will merge to 'master'.

* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

When the user does not specify what remote to interact with, we
often attempt to use 'origin'.  This can now be customized via a
configuration variable.

Expecting a reroll.
"The first remote becomes the default" bit is better done as a
separate step.

* tg/ce-namelen-field (2012-07-11) 2 commits
 - Strip namelen out of ce_flags into a ce_namelen field
 - Merge branch 'tg/maint-cache-name-compare' into tg/ce-namelen-field

Split lower bits of ce_flags field and creates a new ce_namelen
field in the in-core index structure.

* jl/submodule-rm (2012-07-05) 2 commits
 - rm: remove submodules from the index and the .gitmodules file
 - rm: don't fail when removing populated submodules

Expecting a reroll.

* mh/maint-revisions-doc (2012-07-05) 2 commits
 - Document rev^! and rev^@ as revision specifiers
 - Make <refname> documentation more consistent.

Expecting a reroll of the tip one.

* nk/maint-gitweb-log-by-lines (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-13 at 780e16a)
 + gitweb: Add support to Link: tag
 + gitweb: Handle other types of tag in git_print_log
 + gitweb: Cleanup git_print_log()

Teach gitweb to pay attention to various forms of credits that are
similar to "Signed-off-by:" lines.

Needs to be eyeballed for the correctness of the esc_html() in the tip one.

* ph/stash-rerere (2012-07-08) 2 commits
 - stash: invoke rerere in case of conflict
 - test: git-stash conflict sets up rerere

Will be rerolled but is going in the right direction.

* lt/commit-tree-guess-utf-8 (2012-06-28) 1 commit
 - commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

A draft from Linus received privately without a log message.
Expecting a reroll.

* jc/test-lib-source-build-options-early (2012-06-24) 1 commit
 - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier

Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
records the shell and Perl the user told us to use with Git a lot
early, so that test-lib.sh script itself can use "$PERL_PATH" in
one of its early operations.

Needs to be eyeballed by people who run tests with exotic options
like valgrind, --root=/dev/shm/somewhere, etc.

Will merge to 'next'.

* jc/sha1-name-more (2012-07-13) 27 commits
  (merged to 'next' on 2012-07-13 at 534e6fe)
 + t1512: match the "other" object names
  (merged to 'next' on 2012-07-11 at d30ef51)
 + t1512: ignore whitespaces in wc -l output
  (merged to 'next' on 2012-07-10 at 669dd92)
 + rev-parse --disambiguate=<prefix>
 + rev-parse: A and B in "rev-parse A..B" refer to committish
 + reset: the command takes committish
 + commit-tree: the command wants a tree and commits
 + apply: --build-fake-ancestor expects blobs
 + sha1_name.c: add support for disambiguating other types
 + revision.c: the "log" family, except for "show", takes committish
 + revision.c: allow handle_revision_arg() to take other flags
 + sha1_name.c: introduce get_sha1_committish()
 + sha1_name.c: teach lookup context to get_sha1_with_context()
 + sha1_name.c: many short names can only be committish
 + sha1_name.c: get_sha1_1() takes lookup flags
 + sha1_name.c: get_describe_name() by definition groks only commits
 + sha1_name.c: teach get_short_sha1() a commit-only option
 + sha1_name.c: allow get_short_sha1() to take other flags
 + get_sha1(): fix error status regression
 + sha1_name.c: restructure disambiguation of short names
 + sha1_name.c: correct misnamed "canonical" and "res"
 + sha1_name.c: refactor find_short_packed_object()
 + sha1_name.c: rename "now" to "current"
 + sha1_name.c: clarify what "fake" is for in find_short_object_filename()
 + sha1_name.c: get rid of get_sha1_with_mode()
 + sha1_name.c: get rid of get_sha1_with_mode_1()
 + sha1_name.c: hide get_sha1_with_context_1() ugliness
 + sha1_name.c: indentation fix

Teaches the object name parser things like a "git describe" output
is always a commit object, "A" in "git log A" must be a committish,
and "A" and "B" in "git log A...B" both must be committish, etc., to
prolong the lifetime of abbreviated object names.

Will merge to 'master'.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.

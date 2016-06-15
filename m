From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2011, #05; Thu, 15)
Date: Thu, 15 Dec 2011 16:11:59 -0800
Message-ID: <7vd3bpl6i8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 01:12:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbLPG-0007jw-ED
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 01:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759878Ab1LPAMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 19:12:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247Ab1LPAMC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 19:12:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CDDC69D5;
	Thu, 15 Dec 2011 19:12:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	qcrKran4cqV8Nh2NuxhSu2nHjc=; b=htMRC7nVeCnYP7fw/wfHkSB4jZihIxiHf
	JPLvTLH7bWEBjGw5P95piYvWHe7nNrtCU8rzvGkV1RFme0+by6HDScTqCcUE49GQ
	NejX92raCOJ/XOhttSb31S5HSUdFTgga/Bi3cbjhbPL81+ivbrn7Qy5nA/fpb05D
	oRZfUbTksg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=A2T
	8tgCYYv4ROtHgroLoxQYbK3F3kq8AIdrSJNa+YR/qeHpeIf/srjeFgGRGj2zIw+h
	XkPuMAfCRRdbIzXcSuffuHj+DJP7Ql4PEDDcaeYFQ7T6btMLdhWA0nfu6yUE2nPC
	PEX19TL+NEzOBC8vXxHdEGIoqpzk0P46TO0YCrnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24A2E69D4;
	Thu, 15 Dec 2011 19:12:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4327A69D2; Thu, 15 Dec 2011
 19:12:01 -0500 (EST)
X-master-at: 10f4eb652ee4e592f91f638e579d1afcb96c0408
X-next-at: d65a830db872dde05a0cb8e8d289f4f5a50b7818
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 938DA2DA-277A-11E1-8FE0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187259>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

With only maint and master:

        git://git.sourceforge.jp/gitroot/git-core/git.git
        git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches:

        https://github.com/gitster/git

The preformatted documentation in HTML and man format are found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[New Topics]

* ef/setenv-putenv (2011-12-14) 2 commits
 - compat/setenv.c: error if name contains '='
 - compat/setenv.c: update errno when erroring out
 (this branch is used by ef/x-setenv-putenv.)

* jk/maint-do-not-feed-stdin-to-tests (2011-12-15) 1 commit
 - test-lib: redirect stdin of tests

* jn/test-cleanup-7006 (2011-12-14) 1 commit
 - test: errors preparing for a test are not special

* nd/war-on-nul-in-commit (2011-12-15) 3 commits
 - commit_tree(): refuse commit messages that contain NULs
 - Convert commit_tree() to take strbuf as message
 - merge: abort if fails to commit

* jk/git-prompt (2011-12-12) 10 commits
 - contrib: add credential helper for OS X Keychain
 - Makefile: OS X has /dev/tty
 - Makefile: linux has /dev/tty
 - credential: use git_prompt instead of git_getpass
 - prompt: use git_terminal_prompt
 - add generic terminal prompt function
 - refactor git_getpass into generic prompt function
 - move git_getpass to its own source file
 - imap-send: don't check return value of git_getpass
 - imap-send: avoid buffer overflow
 (this branch uses jk/credentials.)

Will merge to 'next' after taking another look.

* mh/ref-api-rest (2011-12-12) 35 commits
 - repack_without_ref(): call clear_packed_ref_cache()
 - read_packed_refs(): keep track of the directory being worked in
 - is_refname_available(): query only possibly-conflicting references
 - refs: read loose references lazily
 - read_loose_refs(): take a (ref_entry *) as argument
 - struct ref_dir: store a reference to the enclosing ref_cache
 - sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - do_for_each_ref_in_dir*(): take (ref_entry *) instead of (ref_dir *)
 - add_entry(): take (ref_entry *) instead of (ref_dir *)
 - search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
 - add_ref(): take (ref_entry *) instead of (ref_dir *)
 - read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
 - find_ref(): take (ref_entry *) instead of (ref_dir *)
 - is_refname_available(): take (ref_entry *) instead of (ref_dir *)
 - get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
 - get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
 - refs: wrap top-level ref_dirs in ref_entries
 - get_ref_dir(): keep track of the current ref_dir
 - do_for_each_ref(): only iterate over the subtree that was requested
 - refs: sort ref_dirs lazily
 - sort_ref_dir(): do not sort if already sorted
 - refs: store references hierarchically
 - refs.c: rename ref_array -> ref_dir
 - struct ref_entry: nest the value part in a union
 - check_refname_component(): return 0 for zero-length components
 - free_ref_entry(): new function
 - refs.c: reorder definitions more logically
 - is_refname_available(): reimplement using do_for_each_ref_in_array()
 - names_conflict(): simplify implementation
 - names_conflict(): new function, extracted from is_refname_available()
 - repack_without_ref(): reimplement using do_for_each_ref_in_array()
 - do_for_each_ref_in_arrays(): new function
 - do_for_each_ref_in_array(): new function
 - do_for_each_ref(): correctly terminate while processesing extra_refs
 (this branch uses mh/ref-api.)

The API for extra anchoring points may require rethought first; that would
hopefully make the "ref" part a lot simpler.

--------------------------------------------------
[Graduated to "master"]

* bc/maint-apply-check-no-patch (2011-12-05) 2 commits
  (merged to 'next' on 2011-12-09 at fc780cd)
 + builtin/apply.c: report error on failure to recognize input
 + t/t4131-apply-fake-ancestor.sh: fix broken test

* cn/maint-lf-to-crlf-filter (2011-11-28) 1 commit
  (merged to 'next' on 2011-12-09 at c374d14)
 + convert: track state in LF-to-CRLF filter

* jk/maint-1.6.2-upload-archive (2011-11-21) 1 commit
 + archive: don't let remote clients get unreachable commits
 (this branch is used by jk/maint-upload-archive.)

* jk/maint-fetch-status-table (2011-12-09) 1 commit
  (merged to 'next' on 2011-12-09 at 159415e)
 + fetch: create status table using strbuf

* jk/maint-upload-archive (2011-11-21) 1 commit
  (merged to 'next' on 2011-12-09 at 03deb16)
 + Merge branch 'jk/maint-1.6.2-upload-archive' into jk/maint-upload-archive
 (this branch uses jk/maint-1.6.2-upload-archive.)

* jl/submodule-status-failure-report (2011-12-08) 1 commit
  (merged to 'next' on 2011-12-09 at 53eb3b3)
 + diff/status: print submodule path when looking for changes fails

* jn/branch-move-to-self (2011-11-28) 2 commits
  (merged to 'next' on 2011-12-09 at 7d27260)
 + Allow checkout -B <current-branch> to update the current branch
 + branch: allow a no-op "branch -M <current-branch> HEAD"

* jn/gitweb-side-by-side-diff (2011-10-31) 8 commits
  (merged to 'next' on 2011-12-09 at 7662e58)
 + gitweb: Add navigation to select side-by-side diff
 + gitweb: Use href(-replay=>1,...) for formats links in "commitdiff"
 + t9500: Add basic sanity tests for side-by-side diff in gitweb
 + t9500: Add test for handling incomplete lines in diff by gitweb
 + gitweb: Give side-by-side diff extra CSS styling
 + gitweb: Add a feature to show side-by-side diff
 + gitweb: Extract formatting of diff chunk header
 + gitweb: Refactor diff body line classification

Replaces a series from Kato Kazuyoshi on the same topic.

* ks/tag-cleanup (2011-12-09) 1 commit
  (merged to 'next' on 2011-12-09 at cbea045)
 + git-tag: introduce --cleanup option

* nd/ignore-might-be-precious (2011-11-28) 2 commits
  (merged to 'next' on 2011-12-09 at 1a94553)
 + checkout,merge: disallow overwriting ignored files with --no-overwrite-ignore
 + Merge branch 'nd/maint-ignore-exclude' into nd/ignore-might-be-precious

* tj/maint-imap-send-remove-unused (2011-11-23) 2 commits
  (merged to 'next' on 2011-12-09 at 877cc11)
 + Merge branch 'maint' into tj/imap-send-remove-unused
 + imap-send: Remove unused 'use_namespace' variable

* tr/userdiff-c-returns-pointer (2011-12-06) 1 commit
  (merged to 'next' on 2011-12-09 at 0b6a092)
 + userdiff: allow * between cpp funcname words

--------------------------------------------------
[Cooking]

* ci/stripspace-docs (2011-12-12) 1 commit
  (merged to 'next' on 2011-12-13 at 35b2cdf)
 + Update documentation for stripspace

* jk/maint-mv (2011-12-12) 5 commits
  (merged to 'next' on 2011-12-13 at 58caedb)
 + mv: be quiet about overwriting
 + mv: improve overwrite warning
 + mv: make non-directory destination error more clear
 + mv: honor --verbose flag
 + docs: mention "-k" for both forms of "git mv"

* jk/maint-snprintf-va-copy (2011-12-12) 1 commit
  (merged to 'next' on 2011-12-13 at d37a7e1)
 + compat/snprintf: don't look at va_list twice

* jn/maint-sequencer-fixes (2011-12-12) 7 commits
  (merged to 'next' on 2011-12-13 at 5b3950c)
 + revert: stop creating and removing sequencer-old directory
 + Revert "reset: Make reset remove the sequencer state"
 + revert: do not remove state until sequence is finished
 + revert: allow single-pick in the middle of cherry-pick sequence
 + revert: pass around rev-list args in already-parsed form
 + revert: allow cherry-pick --continue to commit before resuming
 + revert: give --continue handling its own function
 (this branch is used by rr/revert-cherry-pick.)

* mh/ref-api (2011-12-12) 16 commits
  (merged to 'next' on 2011-12-15 at d65a830)
 + add_ref(): take a (struct ref_entry *) parameter
 + create_ref_entry(): extract function from add_ref()
 + repack_without_ref(): remove temporary
 + resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 + Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 + resolve_gitlink_ref(): improve docstring
 + get_ref_dir(): change signature
 + refs: change signatures of get_packed_refs() and get_loose_refs()
 + is_dup_ref(): extract function from sort_ref_array()
 + add_ref(): add docstring
 + parse_ref_line(): add docstring
 + is_refname_available(): remove the "quiet" argument
 + clear_ref_array(): rename from free_ref_array()
 + refs: rename parameters result -> sha1
 + refs: rename "refname" variables
 + struct ref_entry: document name member
 (this branch is used by mh/ref-api-rest.)

Later part split out to expedite moving the earlier good bits forward.

* nd/resolve-ref (2011-12-13) 3 commits
  (merged to 'next' on 2011-12-13 at c7002e9)
 + Rename resolve_ref() to resolve_ref_unsafe()
 + Convert resolve_ref+xstrdup to new resolve_refdup function
 + revert: convert resolve_ref() to read_ref_full()

* tr/grep-threading (2011-12-12) 3 commits
 - grep: disable threading in non-worktree case
 - grep: enable threading with -p and -W using lazy attribute lookup
 - grep: load funcname patterns for -W

Will merge to 'next' after taking another look.

* tr/pty-all (2011-12-12) 3 commits
 - t/lib-terminal: test test-terminal's sanity
 - test-terminal: set output terminals to raw mode
 - test-terminal: give the child an empty stdin TTY

* jc/push-ignore-stale (2011-12-14) 2 commits
 - push: --ignore-stale option
 - set_ref_status_for_push(): use transport-flags abstraction

* jk/fetch-no-tail-match-refs (2011-12-13) 4 commits
  (merged to 'next' on 2011-12-13 at 805c018)
 + connect.c: drop path_match function
 + fetch-pack: match refs exactly
 + t5500: give fully-qualified refs to fetch-pack
 + drop "match" parameter from get_remote_heads

* jk/maint-push-over-dav (2011-12-13) 2 commits
  (merged to 'next' on 2011-12-13 at 45e376c)
 + http-push: enable "proactive auth"
 + t5540: test DAV push with authentication

* rr/revert-cherry-pick (2011-12-15) 6 commits
 - t3502, t3510: clarify cherry-pick -m failure
 - t3510 (cherry-pick-sequencer): use exit status
 - revert: simplify getting commit subject in format_todo()
 - revert: tolerate extra spaces, tabs in insn sheet
 - revert: make commit subjects in insn sheet optional
 - revert: free msg in format_todo()
 (this branch uses jn/maint-sequencer-fixes.)

Picked up only the earlier bits that are reasonably clear for now.

* ew/keepalive (2011-12-05) 1 commit
  (merged to 'next' on 2011-12-13 at 1b5d5c4)
 + enable SO_KEEPALIVE for connected TCP sockets

* jc/checkout-m-twoway (2011-12-15) 3 commits
  (merged to 'next' on 2011-12-15 at cc64fed)
 + checkout_merged(): squelch false warning from some gcc
  (merged to 'next' on 2011-12-11 at b61057f)
 + Test 'checkout -m -- path'
  (merged to 'next' on 2011-12-09 at c946009)
 + checkout -m: no need to insist on having all 3 stages

* tr/cache-tree (2011-12-06) 5 commits
  (merged to 'next' on 2011-12-13 at e0da64d)
 + reset: update cache-tree data when appropriate
 + commit: write cache-tree data when writing index anyway
 + Refactor cache_tree_update idiom from commit
 + Test the current state of the cache-tree optimization
 + Add test-scrap-cache-tree

* jc/commit-amend-no-edit (2011-12-08) 5 commits
  (merged to 'next' on 2011-12-09 at b9cfa4e)
 + test: commit --amend should honor --no-edit
 + commit: honour --no-edit
 + t7501 (commit): modernize style
 + test: remove a porcelain test that hard-codes commit names
 + test: add missing "&&" after echo command

Will merge to 'master'.

* rr/test-chaining (2011-12-11) 7 commits
  (merged to 'next' on 2011-12-13 at b08445e)
 + t3401: use test_commit in setup
 + t3401: modernize style
 + t3040 (subprojects-basic): fix '&&' chaining, modernize style
 + t1510 (worktree): fix '&&' chaining
 + t3030 (merge-recursive): use test_expect_code
 + test: fix '&&' chaining
 + t3200 (branch): fix '&&' chaining

* aw/rebase-i-stop-on-failure-to-amend (2011-11-30) 1 commit
  (merged to 'next' on 2011-12-09 at a117e83)
 + rebase -i: interrupt rebase when "commit --amend" failed during "reword"

Will merge to 'master'.

* jc/split-blob (2011-12-01) 6 commits
 . WIP (streaming chunked)
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding
 (this branch uses jc/stream-to-pack.)

Not ready. At least pack-objects and fsck need to learn the new encoding
for the series to be usable locally, and then index-pack/unpack-objects
needs to learn it to be used remotely.

* jh/fast-import-notes (2011-11-28) 3 commits
  (merged to 'next' on 2011-12-09 at 2b01132)
 + fast-import: Fix incorrect fanout level when modifying existing notes refs
 + t9301: Add 2nd testcase exposing bugs in fast-import's notes fanout handling
 + t9301: Fix testcase covering up a bug in fast-import's notes fanout handling

Will merge to 'master'.

* jk/credentials (2011-12-12) 14 commits
  (merged to 'next' on 2011-12-12 at 7a6d658)
 + t: add test harness for external credential helpers
 + credentials: add "store" helper
 + strbuf: add strbuf_add*_urlencode
 + Makefile: unix sockets may not available on some platforms
 + credentials: add "cache" helper
 + docs: end-user documentation for the credential subsystem
 + credential: make relevance of http path configurable
 + credential: add credential.*.username
 + credential: apply helper config
 + http: use credential API to get passwords
 + credential: add function for parsing url components
 + introduce credentials API
 + t5550: fix typo
 + test-lib: add test_config_global variant
 (this branch is used by jk/git-prompt.)

Later part split out to expedite moving the earlier good bits forward.

* jk/upload-archive-use-start-command (2011-11-21) 1 commit
  (merged to 'next' on 2011-12-09 at 88cb83a)
 + upload-archive: use start_command instead of fork

Will merge to 'master'.

* ab/enable-i18n (2011-12-05) 1 commit
  (merged to 'next' on 2011-12-13 at 65af8cd)
 + i18n: add infrastructure for translating Git with gettext

* jc/signed-commit (2011-11-29) 5 commits
 - gpg-interface: allow use of a custom GPG binary
 - pretty: %G[?GS] placeholders
 - test "commit -S" and "log --show-signature"
 - log: --show-signature
 - commit: teach --gpg-sign option

Not exactly urgent.

* jc/stream-to-pack (2011-12-01) 5 commits
  (merged to 'next' on 2011-12-09 at d0fd605)
 + bulk-checkin: replace fast-import based implementation
 + csum-file: introduce sha1file_checkpoint
 + finish_tmp_packfile(): a helper function
 + create_tmp_packfile(): a helper function
 + write_pack_header(): a helper function
 (this branch is used by jc/split-blob.)

Teaches "git add" to send large-ish blob data straight to a packfile.
This is a continuation to the "large file support" topic. The codepath to
move data from worktree to repository is made aware of streaming, just
like the checkout codepath that goes the other way, which was done in the
previous "large file support" topic in the 1.7.7 cycle.

Will merge to 'master'.

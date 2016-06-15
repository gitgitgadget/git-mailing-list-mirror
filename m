From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2011, #06; Sun, 18)
Date: Sun, 18 Dec 2011 21:57:34 -0800
Message-ID: <7v62hdnlwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 06:57:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcWEO-0003bJ-8G
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 06:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab1LSF5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 00:57:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1LSF5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 00:57:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 241636F43;
	Mon, 19 Dec 2011 00:57:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	/+E7kEeVQaTmgmAWLRoyITUKvU=; b=DP51/U7KcD/TRgbL77dF7olHWSR25c9Q7
	xbsUM+RPvts4m62Ebrz+2rT55fr9aSLk6ZARKHL3Y65zfL33N1Sw8UXp8RhjsIoo
	mtrlMJJiHI8UhJnnATo/T0869EkM56vhcI/VYpwOUgRTJ5Wf9ubVN0loABBaM4bV
	diWuPJzvjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=K0j
	pXf4gltCYVyIaz3xRIlHO48KAzuSVWeY71Uk/qTwQnG3ZptqcKZ+MgJ44WRpM96F
	e+iHRrQISJOba87PrR4mPUGu9/hluW/InnVZnhaeX6R59O3DxXb7DhRTBq0QG9gc
	BgEVkWSDUc9vlmRBSIWWt83PnHw9B/swCeOpkU7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A7CE6F42;
	Mon, 19 Dec 2011 00:57:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C8D76F3E; Mon, 19 Dec 2011
 00:57:36 -0500 (EST)
X-master-at: d16520499d2652b5b59dfb25f9cf2d56a4c6913a
X-next-at: 03f4636270a389f701ff4d876e0535fb9fbdc969
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59B8BB24-2A06-11E1-9D12-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187438>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

A handful of topics have graduated to 'master', but they are all minor.
More important features for 1.7.9 will come in the next batch (marked as
'Will merge to "master"' below), which should happen in a couple of days;
Peff's credential series is among them.

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
[Graduated to "master"]

* aw/rebase-i-stop-on-failure-to-amend (2011-11-30) 1 commit
  (merged to 'next' on 2011-12-09 at a117e83)
 + rebase -i: interrupt rebase when "commit --amend" failed during "reword"

* jc/commit-amend-no-edit (2011-12-08) 5 commits
  (merged to 'next' on 2011-12-09 at b9cfa4e)
 + test: commit --amend should honor --no-edit
 + commit: honour --no-edit
 + t7501 (commit): modernize style
 + test: remove a porcelain test that hard-codes commit names
 + test: add missing "&&" after echo command

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

* jh/fast-import-notes (2011-11-28) 3 commits
  (merged to 'next' on 2011-12-09 at 2b01132)
 + fast-import: Fix incorrect fanout level when modifying existing notes refs
 + t9301: Add 2nd testcase exposing bugs in fast-import's notes fanout handling
 + t9301: Fix testcase covering up a bug in fast-import's notes fanout handling

* jk/upload-archive-use-start-command (2011-11-21) 1 commit
  (merged to 'next' on 2011-12-09 at 88cb83a)
 + upload-archive: use start_command instead of fork

--------------------------------------------------
[New Topics]

* cn/maint-lf-to-crlf-filter (2011-12-16) 1 commit
 - lf_to_crlf_filter(): tell the caller we added "\n" when draining
 (this branch is used by jc/maint-lf-to-crlf-keep-crlf.)

A recent fix to the codepath was not quite correct.

Will merge to "next".

* jc/maint-lf-to-crlf-keep-crlf (2011-12-18) 1 commit
 - lf_to_crlf_filter(): resurrect CRLF->CRLF hack
 (this branch uses cn/maint-lf-to-crlf-filter.)

The lf-to-crlf filter in the streaming checkout codepath forgot that we
try not to convert LF to CRLF if the repository data already has CRLF.

Will merge to "next".

* jc/request-pull-show-head-4 (2011-12-16) 1 commit
  (merged to 'next' on 2011-12-16 at bea51ac)
 + request-pull: update the "pull" command generation logic

Will merge to "master".

* jk/doc-fsck (2011-12-16) 1 commit
 - docs: brush up obsolete bits of git-fsck manpage

Will merge to "next".

* jk/follow-rename-score (2011-12-16) 1 commit
 - use custom rename score during --follow

Will merge to "next".

* jk/pretty-reglog-ent (2011-12-16) 1 commit
 - pretty: give placeholders to reflog identity

Will merge to "next".

* jk/http-push-to-empty (2011-12-17) 1 commit
 - remote-curl: don't pass back fake refs

Will merge to "next".

* jk/maint-push-v-is-verbose (2011-12-17) 1 commit
 - make "git push -v" actually verbose

Will merge to "next".

* jk/maint-strbuf-missing-init (2011-12-18) 2 commits
 - Update jk/maint-strbuf-missing-init to builtin/ rename
 - commit, merge: initialize static strbuf

Will merge to "next".

* rs/diff-tree-combined-clean-up (2011-12-17) 3 commits
 - submodule: use diff_tree_combined_merge() instead of diff_tree_combined()
 - pass struct commit to diff_tree_combined_merge()
 - use struct sha1_array in diff_tree_combined()

Will merge to "next".

* jn/maint-gitweb-utf8-fix (2011-12-18) 4 commits
 - gitweb: Fix fallback mode of to_utf8 subroutine
 - gitweb: Output valid utf8 in git_blame_common('data')
 - gitweb: esc_html() site name for title in OPML
 - gitweb: Call to_utf8() on input string in chop_and_escape_str()

Will merge to "next".

* pw/p4-docs-and-tests (2011-12-18) 11 commits
 - git-p4: document and test submit options
 - git-p4: test and document --use-client-spec
 - git-p4: test --keep-path
 - git-p4: test --max-changes
 - git-p4: document and test --import-local
 - git-p4: honor --changesfile option and test
 - git-p4: document and test clone --branch
 - git-p4: test cloning with two dirs, clarify doc
 - git-p4: clone does not use --git-dir
 - git-p4: test debug macro
 - git-p4: introduce asciidoc documentation

* jc/advise-push-default (2011-12-18) 2 commits
 - push: hint to use push.default=upstream when appropriate
 - advice: Document that they all default to true

A counter-proposal to jc/push-ignore-stale that may encourage a bad
workflow.

--------------------------------------------------
[Cooking]

* ef/setenv-putenv (2011-12-14) 2 commits
 - compat/setenv.c: error if name contains '='
 - compat/setenv.c: update errno when erroring out
 (this branch is used by ef/x-setenv-putenv.)

Will merge to "next".

* jk/maint-do-not-feed-stdin-to-tests (2011-12-15) 1 commit
 - test-lib: redirect stdin of tests

Will merge to "next".

* jn/test-cleanup-7006 (2011-12-14) 1 commit
 - test: errors preparing for a test are not special

Will merge to "next".

* nd/war-on-nul-in-commit (2011-12-15) 3 commits
 - commit_tree(): refuse commit messages that contain NULs
 - Convert commit_tree() to take strbuf as message
 - merge: abort if fails to commit

Will merge to "next".

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

* ci/stripspace-docs (2011-12-12) 1 commit
  (merged to 'next' on 2011-12-13 at 35b2cdf)
 + Update documentation for stripspace

Will merge to "master".

* jk/maint-mv (2011-12-12) 5 commits
  (merged to 'next' on 2011-12-13 at 58caedb)
 + mv: be quiet about overwriting
 + mv: improve overwrite warning
 + mv: make non-directory destination error more clear
 + mv: honor --verbose flag
 + docs: mention "-k" for both forms of "git mv"

Will merge to "master".

* jk/maint-snprintf-va-copy (2011-12-12) 1 commit
  (merged to 'next' on 2011-12-13 at d37a7e1)
 + compat/snprintf: don't look at va_list twice

Will merge to "master".

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

Will merge to "master".

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

Will merge to "master".

* nd/resolve-ref (2011-12-13) 3 commits
  (merged to 'next' on 2011-12-13 at c7002e9)
 + Rename resolve_ref() to resolve_ref_unsafe()
 + Convert resolve_ref+xstrdup to new resolve_refdup function
 + revert: convert resolve_ref() to read_ref_full()

Will merge to "master".

* tr/grep-threading (2011-12-16) 3 commits
 - grep: disable threading in non-worktree case
 - grep: enable threading with -p and -W using lazy attribute lookup
 - grep: load funcname patterns for -W

Will merge to 'next' after taking another look.

* tr/pty-all (2011-12-12) 3 commits
 - t/lib-terminal: test test-terminal's sanity
 - test-terminal: set output terminals to raw mode
 - test-terminal: give the child an empty stdin TTY

The test breakage that originally triggered interest in this topic is
fixed more cleanly with Peff's jk/maint-do-not-feed-stdin-to-tests but
this series may independently be useful.

Jonathan had good review comments, and this would need to be rerolled.

* jc/push-ignore-stale (2011-12-14) 2 commits
 - push: --ignore-stale option
 - set_ref_status_for_push(): use transport-flags abstraction

Probably solving a wrong problem and encouraging a wrong workflow while at
it. Will drop. jc/advise-push-default might be a better approach.

* jk/fetch-no-tail-match-refs (2011-12-13) 4 commits
  (merged to 'next' on 2011-12-13 at 805c018)
 + connect.c: drop path_match function
 + fetch-pack: match refs exactly
 + t5500: give fully-qualified refs to fetch-pack
 + drop "match" parameter from get_remote_heads

Will merge to "master".

* jk/maint-push-over-dav (2011-12-13) 2 commits
  (merged to 'next' on 2011-12-13 at 45e376c)
 + http-push: enable "proactive auth"
 + t5540: test DAV push with authentication

Will merge to "master".

* rr/revert-cherry-pick (2011-12-15) 6 commits
 - t3502, t3510: clarify cherry-pick -m failure
 - t3510 (cherry-pick-sequencer): use exit status
 - revert: simplify getting commit subject in format_todo()
 - revert: tolerate extra spaces, tabs in insn sheet
 - revert: make commit subjects in insn sheet optional
 - revert: free msg in format_todo()
 (this branch uses jn/maint-sequencer-fixes.)

Picked up only the earlier bits that are reasonably clear for now.

Will merge to "next".

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

Will merge to "master".

* tr/cache-tree (2011-12-06) 5 commits
  (merged to 'next' on 2011-12-13 at e0da64d)
 + reset: update cache-tree data when appropriate
 + commit: write cache-tree data when writing index anyway
 + Refactor cache_tree_update idiom from commit
 + Test the current state of the cache-tree optimization
 + Add test-scrap-cache-tree

Will merge to "master".

* rr/test-chaining (2011-12-11) 7 commits
  (merged to 'next' on 2011-12-13 at b08445e)
 + t3401: use test_commit in setup
 + t3401: modernize style
 + t3040 (subprojects-basic): fix '&&' chaining, modernize style
 + t1510 (worktree): fix '&&' chaining
 + t3030 (merge-recursive): use test_expect_code
 + test: fix '&&' chaining
 + t3200 (branch): fix '&&' chaining

Will merge to "master".

* jc/split-blob (2011-12-01) 6 commits
 . WIP (streaming chunked)
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready. At least pack-objects and fsck need to learn the new encoding
for the series to be usable locally, and then index-pack/unpack-objects
needs to learn it to be used remotely.

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

Will merge to "master".

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

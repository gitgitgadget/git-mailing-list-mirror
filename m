Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2063EC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 23:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC10B2082E
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 23:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V7kSqSXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBEXbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:31:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54944 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBEXbX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 18:31:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 554783C620;
        Wed,  5 Feb 2020 18:31:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=G
        JUptYs0BvP8SxA+hX5mB23DwDU=; b=V7kSqSXfgg7lso+MDABAjkDu6uvaG1qrr
        crCw1Ck9qGGE46qQj9cXg8UCgtgSQAod3Ob/9gmWLUosmLG2Z4q61UDG8983Vqc/
        CZDmuQv0PhlAJELh91m0yO/JLajEu1nxf5fmcfpuLjHZgy25lsaZFRer1U2UBLwK
        JQsAcbRHSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=BvJ
        KUJhVS3Umv9H0sZmH8nHch0X7x0s6Dse50WJz5LAg3hRvCcgCxIxd6dNnP8PnC04
        HlbNbqiJSLWSAtGfKZB/flPlOvw+VpnvYa+/gkBthYSbgk4LObXXLb9qWWLWI+Da
        Sv+ZISwFiP+FV7BNpStT7rbarKjEVvvB6nKS6BHE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D1DC3C61F;
        Wed,  5 Feb 2020 18:31:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AE8B3C61E;
        Wed,  5 Feb 2020 18:31:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2020, #01; Wed, 5)
X-master-at: 5b0ca878e008e82f91300091e793427205ce3544
X-next-at: 125e21ebc739270a5a8f79e34da06ce072caa338
Date:   Wed, 05 Feb 2020 15:31:11 -0800
Message-ID: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 991684A0-486F-11EA-9CBC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* am/test-pathspec-f-f-error-cases (2020-01-15) 1 commit
  (merged to 'next' on 2020-01-22 at cc526bc5ea)
 + t: add tests for error conditions with --pathspec-from-file

 More tests.


* am/update-pathspec-f-f-tests (2020-01-15) 2 commits
  (merged to 'next' on 2020-01-22 at 5d050a14df)
 + t: directly test parse_pathspec_file()
 + t: fix quotes tests for --pathspec-from-file

 Test updates.


* bc/actualmente (2020-01-21) 1 commit
  (merged to 'next' on 2020-01-22 at 6ce9cf0951)
 + docs: use "currently" for the present time

 Doc grammo fix.


* bc/author-committer-doc (2020-01-22) 3 commits
  (merged to 'next' on 2020-01-22 at 61164cc62a)
 + doc: provide guidance on user.name format
 + docs: expand on possible and recommended user config options
 + doc: move author and committer information to git-commit(1)

 Clarify documentation on committer/author identities.


* bc/misconception-doc (2020-01-22) 2 commits
  (merged to 'next' on 2020-01-22 at 6abc06b798)
 + docs: mention when increasing http.postBuffer is valuable
 + doc: dissuade users from trying to ignore tracked files

 Doc updates.


* bc/run-command-nullness-after-free-fix (2020-01-07) 1 commit
  (merged to 'next' on 2020-01-15 at 56b3148fee)
 + run-command: avoid undefined behavior in exists_in_PATH

 Originally merged to 'next' on 2020-01-09

 C pedantry ;-) fix.


* dl/credential-netrc (2019-12-20) 2 commits
  (merged to 'next' on 2020-01-15 at 768fa1c364)
 + contrib/credential/netrc: work outside a repo
 + contrib/credential/netrc: make PERL_PATH configurable

 Originally merged to 'next' on 2019-12-25

 Sample credential helper for using .netrc has been updated to work
 out of the box.


* ds/graph-horizontal-edges (2020-01-15) 2 commits
  (merged to 'next' on 2020-01-22 at 4d94d5800f)
 + graph: fix collapse of multiple edges
 + graph: add test to demonstrate horizontal line bug

 Rendering by "git log --graph" of ancestry lines leading to a merge
 commit were made suboptimal to waste vertical space a bit with a
 recent update, which has been corrected.


* ds/refmap-doc (2020-01-21) 1 commit
  (merged to 'next' on 2020-01-22 at 51d81a499b)
 + fetch: document and test --refmap=""

 "git fetch --refmap=" option has got a better documentation.


* ds/sparse-cone (2020-01-10) 1 commit
  (merged to 'next' on 2020-01-22 at bfca10dcd7)
 + unpack-trees: correctly compute result count

 The code recently added in this release to move to the entry beyond
 the ones in the same directory in the index in the sparse-cone mode
 did not count the number of entries to skip over incorrectly, which
 has been corrected.


* en/simplify-check-updates-in-unpack-trees (2020-01-07) 1 commit
  (merged to 'next' on 2020-01-15 at 586c055b69)
 + unpack-trees: exit check_updates() early if updates are not wanted

 Originally merged to 'next' on 2020-01-09

 Code simplification.


* en/string-list-can-be-custom-sorted (2020-01-07) 1 commit
  (merged to 'next' on 2020-01-15 at 2afe9536e6)
 + string-list: note in docs that callers can specify sorting function

 Originally merged to 'next' on 2020-01-09

 API-doc update.


* es/unpack-trees-oob-fix (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at 832ecf4366)
 + unpack-trees: watch for out-of-range index position

 Originally merged to 'next' on 2020-01-09

 The code that tries to skip over the entries for the paths in a
 single directory using the cache-tree was not careful enough
 against corrupt index file.


* hi/gpg-mintrustlevel (2020-01-15) 1 commit
  (merged to 'next' on 2020-01-22 at af9f594eb7)
 + gpg-interface: add minTrustLevel as a configuration option

 gpg.minTrustLevel configuration variable has been introduced to
 tell various signature verification codepaths the required minimum
 trust level.


* hi/indent-text-with-tabs-in-editorconfig (2020-01-06) 1 commit
  (merged to 'next' on 2020-01-22 at 3b567252eb)
 + editorconfig: indent text files with tabs

 Tell .editorconfig that in this project, *.txt files are indented
 with tabs.


* hw/commit-advise-while-rejecting (2019-12-19) 1 commit
  (merged to 'next' on 2020-01-15 at 4f16e5a3b6)
 + commit: honor advice.statusHints when rejecting an empty commit

 Originally merged to 'next' on 2019-12-30

 "git commit" gives output similar to "git status" when there is
 nothing to commit, but without honoring the advise.statusHints
 configuration variable, which has been corrected.


* hw/tutorial-favor-switch-over-checkout (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at 25e4fca9ec)
 + doc/gitcore-tutorial: fix prose to match example command

 Originally merged to 'next' on 2020-01-09

 Complete an update to tutorial that encourages "git switch" over
 "git checkout" that was done only half-way.


* jk/asan-build-fix (2020-01-16) 1 commit
  (merged to 'next' on 2020-01-22 at 0fc7123d8b)
 + Makefile: use compat regex with SANITIZE=address

 Work around test breakages caused by custom regex engine used in
 libasan, when address sanitizer is used with more recent versions
 of gcc and clang.


* jk/no-flush-upon-disconnecting-slrpc-transport (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at 5014feacb0)
 + transport: don't flush when disconnecting stateless-rpc helper

 Originally merged to 'next' on 2020-01-09

 Reduce unnecessary round-trip when running "ls-remote" over the
 stateless RPC mechanism.


* jk/test-fixes (2020-01-16) 2 commits
  (merged to 'next' on 2020-01-22 at fb7dbf8b85)
 + t7800: don't rely on reuse_worktree_file()
 + t4018: drop "debugging" cat from hunk-header tests

 Test fixes.


* jn/test-lint-one-shot-export-to-shell-function (2020-01-15) 3 commits
  (merged to 'next' on 2020-01-22 at 03cfc1ea0d)
 + fetch test: mark test of "skipping" haves as v0-only
 + t/check-non-portable-shell: detect "FOO= shell_func", too
 + fetch test: avoid use of "VAR= cmd" with a shell function
 (this branch is used by jn/promote-proto2-to-default.)

 The test-lint machinery knew to check "VAR=VAL shell_function"
 construct, but did not check "VAR= shell_funciton", which has been
 corrected.


* js/builtin-add-i-cmds (2020-01-16) 2 commits
  (merged to 'next' on 2020-01-22 at 3cf944ae32)
 + built-in add -i: accept open-ended ranges again
 + built-in add -i: do not try to `patch`/`diff` an empty list of files

 Minor bugfixes to "git add -i" that has recently been rewritten in C.


* jt/sha1-file-remove-oi-skip-cached (2020-01-02) 1 commit
  (merged to 'next' on 2020-01-15 at 4feaff54f3)
 + sha1-file: remove OBJECT_INFO_SKIP_CACHED

 Originally merged to 'next' on 2020-01-04

 has_object_file() said "no" given an object registered to the
 system via pretend_object_file(), making it inconsistent with
 read_object_file(), causing lazy fetch to attempt fetching an
 empty tree from promisor remotes.


* lh/bool-to-type-bool (2020-01-21) 1 commit
  (merged to 'next' on 2020-01-22 at 3c140f479f)
 + templates: fix deprecated type option `--bool`

 Replace "git config --bool" calls with "git config --type=bool" in
 sample templates.


* nd/switch-and-restore (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at ffd0b1e54e)
 + restore: invalidate cache-tree when removing entries with --staged

 Originally merged to 'next' on 2020-01-09

 "git restore --staged" did not correctly update the cache-tree
 structure, resulting in bogus trees to be written afterwards, which
 has been corrected.


* rt/submodule-i18n (2020-01-16) 1 commit
  (merged to 'next' on 2020-01-22 at 6b6a52dbe3)
 + submodule.c: mark more strings for translation

 Comments update.


* sg/completion-worktree (2020-01-15) 6 commits
  (merged to 'next' on 2020-01-22 at 9d18889fea)
 + completion: list paths and refs for 'git worktree add'
 + completion: list existing working trees for 'git worktree' subcommands
 + completion: simplify completing 'git worktree' subcommands and options
 + completion: return the index of found word from __git_find_on_cmdline()
 + completion: clean up the __git_find_on_cmdline() helper function
 + t9902-completion: add tests for the __git_find_on_cmdline() helper

 The command line completion (in contrib/) learned to complete
 subcommands and arguments to "git worktree".


* ss/t6025-modernize (2020-01-21) 2 commits
  (merged to 'next' on 2020-01-22 at 00ed0a98ee)
 + t6025: use helpers to replace test -f <path>
 + t6025: modernize style

 Test style updates.

--------------------------------------------------
[New Topics]

* bw/remote-rename-update-config (2020-01-28) 7 commits
 - SQUASH??? test_config cannot be used inside a subshell
 - remote rename/remove: gently handle remote.pushDefault config
 - config: provide access to the current line number
 - remote rename/remove: handle branch.<name>.pushRemote config values
 - remote: clean-up config callback
 - remote: clean-up by returning early to avoid one indentation
 - pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
 (this branch uses mr/show-config-scope.)

 "git remote rename X Y" needs to adjust configuration variables
 (e.g. branch.<name>.remote) whose value used to be X to Y.
 branch.<name>.pushRemote is now also updated.

 Waiting for mr/show-config-scope to stabilize.


* es/bright-colors (2020-01-23) 3 commits
 - color.c: alias RGB colors 8-15 to aixterm colors
 - color.c: support bright aixterm colors
 - color.c: refactor color_output arguments

 The basic 7 colors learned the brighter counterparts
 (e.g. "brightred").

 Expecting a reroll.
 cf. <xmqqmuagbsyw.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqo8ut3hsu.fsf@gitster-ct.c.googlers.com>


* mt/sparse-checkout-doc-update (2020-01-23) 2 commits
  (merged to 'next' on 2020-01-27 at dbd5a83613)
 + completion: add support for sparse-checkout
 + doc: sparse-checkout: mention --cone option

 Doc update.

 Will merge to 'master'.


* pk/status-of-uncloned-submodule (2020-02-04) 3 commits
 - t7400: testcase for submodule status on unregistered inner git repos
 - submodule: fix status of initialized but not cloned submodules
 - t7400: add a testcase for submodule status on empty dirs

 The way "git submodule status" reports an initialized but not yet
 populated submodule has not been reimplemented correctly when a
 part of the "git submodule" command was rewritten in C, which has
 been corrected.

 Will merge to 'next'.


* ag/rebase-avoid-unneeded-checkout (2020-01-24) 1 commit
 - rebase -i: stop checking out the tip of the branch to rebase

 "git rebase -i" (and friends) used to unnecessarily check out the
 tip of the branch to be rebased, which has been corrected.

 Will merge to 'next'.


* ds/sparse-checkout-harden (2020-01-31) 15 commits
 - sparse-checkout: fix cone mode behavior mismatch
 - sparse-checkout: improve docs around 'set' in cone mode
 - sparse-checkout: escape all glob characters on write
 - sparse-checkout: use C-style quotes in 'list' subcommand
 - sparse-checkout: unquote C-style strings over --stdin
 - sparse-checkout: write escaped patterns in cone mode
 - sparse-checkout: properly match escaped characters
 - sparse-checkout: warn on globs in cone patterns
 - sparse-checkout: detect short patterns
 - sparse-checkout: cone mode does not recognize "**"
 - sparse-checkout: fix documentation typo for core.sparseCheckoutCone
 - clone: fix --sparse option with URLs
 - sparse-checkout: create leading directories
 - t1091: improve here-docs
 - t1091: use check_files to reduce boilerplate

 Some rough edges in the sparse-checkout feature, especially around
 the cone mode, have been cleaned up.

 Will merge to 'next'.


* es/doc-mentoring (2020-01-24) 1 commit
 - MyFirstContribution: add avenues for getting help

 Doc for new contributors.

 Will merge to 'next'.


* mr/show-config-scope (2020-01-28) 6 commits
 - config: add '--show-scope' to print the scope of a config value
 - config: clarify meaning of command line scoping
 - config: split repo scope to local and worktree
 - t1300: create custom config file without special characters
 - t1300: fix over-indented HERE-DOCs
 - config: fix typo in variable name
 (this branch is used by bw/remote-rename-update-config.)

 "git config" learned to show in which "scope", in addition to in
 which file, each config setting comes from.

 Expecting a (hopefully final) reroll.
 cf. <CAOjrSZtx+Qr4HsaptaxseTa_8oCwRyVE+Jf95_z51fGmXBjsTQ@mail.gmail.com>


* bk/p4-pre-edit-changelist (2020-02-04) 4 commits
 - git-p4: add p4 submit hooks
 - git-p4: add hook p4-pre-edit-changelist
 - git-p4: create new method gitRunHook
 - git-p4: rewrite prompt to be Windows compatible

 "git p4" learned four new hooks and also "--no-verify" option to
 bypass them (and the existing "p4-pre-submit" hook).

 May want to be split better, but the endgame seemed sensible.
 cf. <xmqqmu9y6pr4.fsf@gitster-ct.c.googlers.com>
 

* dt/submodule-rm-with-stale-cache (2020-01-28) 1 commit
 - git rm submodule: succeed if .gitmodules index stat info is zero

 Running "git rm" on a submodule failed unnecessarily when
 .gitmodules is only cache-dirty, which has been corrected.

 Will merge to 'next'.


* en/fill-directory-exponential (2020-01-31) 6 commits
 - t7063: blindly accept diffs
 - dir: replace exponential algorithm with a linear one
 - dir: refactor treat_directory to clarify control flow
 - dir: fix confusion based on variable tense
 - dir: fix broken comment
 - dir: consolidate treat_path() and treat_one_path()
 (this branch uses en/fill-directory-fixes-more.)

 The directory traversal code had redundant recursive calls which
 made its performance characteristics exponential wrt the depth of
 the tree, which was corrected.

 Still RFC?
 cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>


* hw/doc-git-dir (2020-01-30) 1 commit
 - git: update documentation for --git-dir

 One effect of specifying where the GIT_DIR is (either with the
 environment variable, or with the "git --git-dir=<where> cmd"
 option) is to disable the repository discovery.  This has been
 placed a bit more stress in the documentation, as new users often
 get confused.

 Will merge to 'next'.


* jb/parse-options-message-fix (2020-02-05) 1 commit
 - parse-options: lose an unnecessary space in an error message

 Error message fix.

 Waiting for a response
 cf. <xmqqv9ok6fa1.fsf@gitster-ct.c.googlers.com>


* jc/skip-prefix (2020-01-31) 1 commit
 - C: use skip_prefix() to avoid hardcoded string length

 Code simplification.

 Will merge to 'next'.


* jh/notes-fanout-fix (2020-02-04) 2 commits
 - notes.c: fix off-by-one error when decreasing notes fanout
 - t3305: check notes fanout more carefully and robustly

 The code to automatically shrink the fan-out in the notes tree had
 an off-by-one bug, which has been killed.

 Will merge to 'next'.


* jk/alloc-cleanups (2020-02-04) 4 commits
 - tree-walk.c: break circular dependency with unpack-trees
 - traverse_trees(): use stack array for name entries
 - walker_fetch(): avoid raw array length computation
 - normalize_path_copy(): document "dst" size expectations

 Misc code clean-ups.

 Will merge to 'next'.


* jk/clang-sanitizer-fixes (2020-01-28) 5 commits
 - obstack: avoid computing offsets from NULL pointer
 - xdiff: avoid computing non-zero offset from NULL pointer
 - avoid computing zero offsets from NULL pointer
 - merge-recursive: use subtraction to flip stage
 - merge-recursive: silence -Wxor-used-as-pow warning

 C pedantry ;-) fix.

 Will merge to 'next'.


* jk/diff-honor-wserrhighlight-in-plumbing (2020-01-31) 1 commit
 - diff: move diff.wsErrorHighlight to "basic" config

 The diff-* plumbing family of subcommands now pay attention to the
 diff.wsErrorHighlight configuration, which has been ignored before;
 this allows "git add -p" to also show the whitespace problems to
 the end user.

 Will merge to 'next'.


* jk/escaped-wildcard-dwim (2020-01-27) 1 commit
 - verify_filename(): handle backslashes in "wildcards are pathspecs" rule

 Disambiguation logic to tell revisions and pathspec apart has been
 tweaked so that backslash-escaped glob special characters do not
 count in the "wildcards are pathspec" rule.

 Will merge to 'next'.


* jk/get-oid-error-message-i18n (2020-01-30) 3 commits
 - sha1-name: mark get_oid() error messages for translation
 - t1506: drop space after redirection operator
 - t1400: avoid "test" string comparisons

 A low-level API function get_oid(), that accepts various ways to
 name an object, used to issue end-user facing error messages
 without l10n, which has been updated to be translatable.

 Will merge to 'next'.


* jk/index-pack-dupfix (2020-02-04) 1 commit
 - index-pack: downgrade twice-resolved REF_DELTA to die()

 The index-pack code now diagnoses a bad input packstream that
 records the same object twice when it is used as delta base; the
 code used to declare a software bug when encountering such an
 input, but it is an input error.

 Will merge to 'next'.


* jk/push-default-doc (2020-01-29) 1 commit
 - doc: drop "explicitly given" from push.default description

 Doc update.

 Will merge to 'next'.


* jt/connectivity-check-optim-in-partial-clone (2020-01-30) 2 commits
 - fetch: forgo full connectivity check if --filter
 - connected: verify promisor-ness of partial clone

 Unneeded connectivity check is now disabled in a partial clone when
 fetching into it.

 Will merge to 'next'.


* jt/t5616-robustify (2020-01-27) 1 commit
 - t5616: make robust to delta base change

 Futureproofing a test not to depend on the current implementation
 detail.

 Will merge to 'next'.


* km/submodule-doc-use-sm-path (2020-01-31) 1 commit
 - submodule foreach: replace $path with $sm_path in example

 Docfix.

 Will merge to 'next'.


* ld/p4-cleanup-processes (2020-01-30) 7 commits
 - git-p4: avoid leak of file handle when cloning
 - git-p4: check for access to remote host earlier
 - git-p4: cleanup better on error exit
 - git-p4: create helper function importRevisions()
 - git-p4: disable some pylint warnings, to get pylint output to something manageable
 - git-p4: add P4CommandException to report errors talking to Perforce
 - git-p4: make closeStreams() idempotent

 p4 updates.

 Will merge to 'next'.


* ma/filter-branch-doc-caret (2020-02-04) 1 commit
 - git-filter-branch.txt: wrap "maths" notation in backticks

 Doc mark-up updates.

 Will merge to 'next'.


* ms/doc-bundle-format (2020-02-04) 1 commit
 - doc: describe Git bundle format

 Technical details of the bundle format has been documented.

 Will merge to 'next'?
 cf. <xmqqtv4b8bus.fsf@gitster-ct.c.googlers.com>


* mt/use-passed-repo-more-in-funcs (2020-01-31) 7 commits
 - sha1-file: allow check_object_signature() to handle any repo
 - sha1-file: pass git_hash_algo to hash_object_file()
 - sha1-file: pass git_hash_algo to write_object_file_prepare()
 - streaming: allow open_istream() to handle any repo
 - pack-check: use given repo's hash_algo at verify_packfile()
 - cache-tree: use given repo's hash_algo at verify_one()
 - diff: make diff_populate_filespec() honor its repo argument

 Some codepaths were given a repository instance as a parameter to
 work in the repository, but passed the_repository instance to its
 callees, which has been cleaned up (somewhat).

 Will merge to 'next'.


* pb/do-not-recurse-grep-no-index (2020-01-30) 1 commit
 - grep: ignore --recurse-submodules if --no-index is given

 "git grep --no-index" should not get affected by the contents of
 the .gitmodules file but when "--recurse-submodules" is given or
 the "submodule.recurse" variable is set, it did.  Now these
 settings are ignored in the "--no-index" mode.

 Will merge to 'next'.


* rs/name-rev-memsave (2020-02-05) 11 commits
 - name-rev: sort tip names before applying
 - name-rev: release unused name strings
 - name-rev: generate name strings only if they are better
 - name-rev: pre-size buffer in get_parent_name()
 - name-rev: factor out get_parent_name()
 - name-rev: put struct rev_name into commit slab
 - name-rev: don't _peek() in create_or_update_name()
 - name-rev: don't leak path copy in name_ref()
 - name-rev: respect const qualifier
 - name-rev: remove unused typedef
 - name-rev: rewrite create_or_update_name()

 Memory footprint and performance of "git name-rev" has been
 improved.


* tb/commit-graph-object-dir (2020-02-04) 5 commits
 - commit-graph.h: use odb in 'load_commit_graph_one_fd_st'
 - commit-graph.c: remove path normalization, comparison
 - commit-graph.h: store object directory in 'struct commit_graph'
 - commit-graph.h: store an odb in 'struct write_commit_graph_context'
 - t5318: don't pass non-object directory to '--object-dir'
 (this branch is used by tb/commit-graph-split-merge.)

 The code to compute the commit-graph has been taught to use a more
 robust way to tell if two object directories refer to the same
 thing.

 Will merge to 'next'.


* tb/commit-graph-split-merge (2020-02-05) 3 commits
 - builtin/commit-graph.c: support '--input=none'
 - builtin/commit-graph.c: introduce '--input=<source>'
 - builtin/commit-graph.c: support '--split[=<strategy>]'
 (this branch uses tb/commit-graph-object-dir.)

 The code to write out the commit-graph has been taught a few
 options to control if the resulting graph chains should be merged
 or a single new incremental graph is created.

 Will merge to 'next'?


--------------------------------------------------
[Stalled]

* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* pw/advise-rebase-skip (2019-12-06) 9 commits
 - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
 - rebase: fix advice when a fixup creates an empty commit
 - commit: give correct advice for empty commit during a rebase
 - commit: encapsulate determine_whence() for sequencer
 - commit: use enum value for multiple cherry-picks
 - sequencer: write CHERRY_PICK_HEAD for reword and edit
 - cherry-pick: check commit error messages
 - cherry-pick: add test for `--skip` advice in `git commit`
 - t3404: use test_cmp_rev

 The mechanism to prevent "git commit" from making an empty commit
 or amending during an interrupted cherry-pick was broken during the
 rewrite of "git rebase" in C, which has been corrected.

 What's the status of this one?
 The tip two are still RFC.


* es/pathspec-f-f-grep (2020-01-13) 1 commit
 . grep: support the --pathspec-from-file option

 "git grep" learned the "--pathspec-from-file" command line
 option.

 Getting tired of waiting for review responses.  Will discard.
 cf. <20191204203911.237056-1-emilyshaffer@google.com>


* at/rebase-fork-point-regression-fix (2019-12-09) 1 commit
 - rebase: fix --fork-point with short refname

 The "--fork-point" mode of "git rebase" regressed when the command
 was rewritten in C back in 2.20 era, which has been corrected.

 Was waiting for discussion to settle.
 cf. <CAPig+cQ-3Ds41hr91fRo_GvuFMTP7zNVJtaSqi-Yccq4Pk-8Qg@mail.gmail.com>


* ma/config-bool-valex (2019-11-14) 8 commits
 - builtin/config: die if "value_regex" doesn't canonicalize as boolean
 - builtin/config: warn if "value_regex" doesn't canonicalize as boolean
 - builtin/config: canonicalize "value_regex" with `--type=bool-or-int`
 - builtin/config: canonicalize "value_regex" with `--type=bool`
 - builtin/config: collect "value_regexp" data in a struct
 - builtin/config: extract `handle_value_regex()` from `get_value()`
 - t1300: modernize part of script
 - config: make `git_parse_maybe_bool_text()` public

 "git config" can be told to affect the existing entries that
 "match" the given value via its value_regex argument.  It learned
 to normalize the value set in the configuration and the value given
 from the command line before computing they "match", e.g. "true" in
 the configuration file can now match with "yes" given from the
 command line.

 Needs a bit more work?
 cf. <CAN0heSrtwi9V607vBX9PMSfNLQ8iGcno6_iGuR4Fs8ndGxqh8A@mail.gmail.com>


* ds/fsmonitor-testing (2019-12-09) 8 commits
 - test-lib: clear watchman watches at test completion
 - t7519: disable external GIT_TEST_FSMONITOR variable
 - t7063: disable fsmonitor with status cache
 - tests: disable fsmonitor in submodule tests
 - t3030-merge-recursive.sh: disable fsmonitor when tweaking GIT_WORK_TREE
 - t1301-shared-repo.sh: disable FSMONITOR
 - fsmonitor: do not output to stderr for tests
 - fsmonitor: disable in a bare repo

 Updates around testing fsmoitor integration.

 cf. <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 . index: offer advice for unknown index extensions
 . index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Getting tired of waiting for a reroll.  Will discard.


* js/protocol-advertise-multi (2018-12-28) 1 commit
 . protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Getting tired of waiting for a reroll.  Will discard.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* ag/edit-todo-drop-check (2020-01-28) 2 commits
 - rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
 - sequencer: move check_todo_list_from_file() to rebase-interactive.c
 (this branch uses js/rebase-i-with-colliding-hash.)

 Allow the rebase.missingCommitsCheck configuration to kick in when
 "rebase --edit-todo" and "rebase --continue" restarts the procedure.

 Will merge to 'next'.


* am/checkout-file-and-ref-ref-ambiguity (2020-01-07) 2 commits
  (merged to 'next' on 2020-01-27 at daf1dadc78)
 + checkout: don't revert file on ambiguous tracking branches
 + parse_branchname_arg(): extract part as new function

 "git checkout X" did not correctly fail when X is not a local
 branch but could name more than one remote-tracking branches
 (i.e. to be dwimmed as the starting point to create a corresponding
 local branch), which has been corrected.

 Will merge to 'master'.


* kw/fsmonitor-watchman-racefix (2020-01-23) 4 commits
 - fsmonitor: update documentation for hook version and watchman hooks
 - fsmonitor: add fsmonitor hook scripts for version 2
 - fsmonitor: handle version 2 of the hooks that will use opaque token
 - fsmonitor: change last update timestamp on the index_state to opaque token

 A new version of fsmonitor-watchman hook has been introduced, to
 avoid races.

 Will merge to 'next'.


* hw/advice-add-nothing (2020-01-15) 1 commit
  (merged to 'next' on 2020-01-22 at 3fe4494fa6)
 + add: use advise function to display hints

 Two help messages given when "git add" notices the user gave it
 nothing to add have been updated to use advise() API.

 Expecting a follow-up
 to perform <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com>
 incrementally.


* km/submodule-add-errmsg (2020-01-15) 1 commit
  (merged to 'next' on 2020-01-27 at 0ff8378907)
 + submodule add: show 'add --dry-run' stderr when aborting

 Improve error message generation for "git submodule add".

 Will merge to 'master'.


* en/fill-directory-fixes-more (2020-01-16) 4 commits
  (merged to 'next' on 2020-01-27 at 9a27e1495b)
 + dir: point treat_leading_path() warning to the right place
 + dir: restructure in a way to avoid passing around a struct dirent
 + dir: treat_leading_path() and read_directory_recursive(), round 2
 + clean: demonstrate a bug with pathspecs
 (this branch is used by en/fill-directory-exponential.)

 Corner case bugs in "git clean" that stems from a (necessarily for
 performance reasons) awkward calling convention in the directory
 enumeration API has been corrected.

 Will merge to 'master'.


* es/fetch-show-failed-submodules-atend (2020-01-17) 1 commit
  (merged to 'next' on 2020-01-27 at 7b41163881)
 + fetch: emphasize failure during submodule fetch

 A fetch that is told to recursively fetch updates in submodules
 inevitably produces reams of output, and it becomes hard to spot
 error messages.  The command has been taught to enumerate
 submodules that had errors at the end of the operation.

 Will merge to 'master'.


* am/pathspec-f-f-more (2020-01-21) 8 commits
 - stash push: support the --pathspec-from-file option
 - stash: eliminate crude option parsing
 - doc: stash: synchronize <pathspec> description
 - doc: stash: document more options
 - doc: stash: split options from description (2)
 - doc: stash: split options from description (1)
 - rm: support the --pathspec-from-file option
 - doc: rm: synchronize <pathspec> description

 "git rm" and "git stash" learns the new "--pathspec-from-file"
 option.

 Waiting for review response.
 cf. <xmqqftg8a9fp.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqblqwa7d3.fsf@gitster-ct.c.googlers.com>


* js/rebase-i-with-colliding-hash (2020-01-23) 3 commits
 - rebase -i: also avoid SHA-1 collisions with missingCommitsCheck
 - rebase -i: re-fix short SHA-1 collision
 - parse_insn_line(): improve error message when parsing failed
 (this branch is used by ag/edit-todo-drop-check.)

 "git rebase -i" identifies existing commits in its todo file with
 their abbreviated object name, which could become ambigous as it
 goes to create new commits, and has a mechanism to avoid ambiguity
 in the main part of its execution.  A few other cases however were
 not covered by the protection against ambiguity, which has been
 corrected.

 Will merge to 'next'.


* pb/recurse-submodule-in-worktree-fix (2020-01-22) 4 commits
  (merged to 'next' on 2020-01-27 at e4cb1e376a)
 + submodule.c: use get_git_dir() instead of get_git_common_dir()
 + t2405: clarify test descriptions and simplify test
 + t2405: use git -C and test_commit -C instead of subshells
 + t7410: rename to t2405-worktree-submodule.sh

 The "--recurse-submodules" option of various subcommands did not
 work well when run in an alternate worktree, which has been
 corrected.

 Will merge to 'master'.


* mt/threaded-grep-in-object-store (2020-01-17) 12 commits
 - grep: use no. of cores as the default no. of threads
 - grep: move driver pre-load out of critical section
 - grep: re-enable threads in non-worktree case
 - grep: protect packed_git [re-]initialization
 - grep: allow submodule functions to run in parallel
 - submodule-config: add skip_if_read option to repo_read_gitmodules()
 - grep: replace grep_read_mutex by internal obj read lock
 - object-store: allow threaded access to object reading
 - replace-object: make replace operations thread-safe
 - grep: fix racy calls in grep_objects()
 - grep: fix race conditions at grep_submodule()
 - grep: fix race conditions on userdiff calls

 Traditionally, we avoided threaded grep while searching in objects
 (as opposed to files in the working tree) as accesses to the object
 layer is not thread-safe.  This limitation is getting lifted.

 Will merge to 'next'.


* jn/pretend-object-doc (2020-01-06) 1 commit
 - sha1-file: document how to use pretend_object_file

 Warn programmers about pretend_object_file() that allows the code
 to tentatively use in-core objects.

 Will merge to 'next'.



* dl/merge-autostash (2020-01-13) 17 commits
 - pull: pass --autostash to merge
 - t5520: make test_pull_autostash() accept expect_parent_num
 - merge: teach --autostash option
 - sequencer: unlink autostash in apply_autostash()
 - sequencer: extract perform_autostash() from rebase
 - rebase: generify create_autostash()
 - rebase: extract create_autostash()
 - reset: extract reset_head() from rebase
 - rebase: generify reset_head()
 - rebase: use apply_autostash() from sequencer.c
 - sequencer: make apply_rebase() accept a path
 - rebase: use read_oneliner()
 - sequencer: make read_oneliner() extern
 - sequencer: configurably warn on non-existent files
 - sequencer: use file strbuf for read_oneliner()
 - t7600: use test_write_lines()
 - Makefile: alphabetically sort += lists

 "git merge" learns the "--autostash" option.

 Expecting a reroll.
 cf. <20200123042906.GA29009@generichostname>


* dl/test-must-fail-fixes-2 (2020-01-27) 16 commits
 - t4124: only mark git command with test_must_fail
 - t3507: use test_path_is_missing()
 - t3507: fix indentation
 - t3504: do check for conflict marker after failed cherry-pick
 - t3419: stop losing return code of git command
 - t3415: increase granularity of test_auto_{fixup,squash}()
 - t3415: stop losing return codes of git commands
 - t3310: extract common notes_merge_files_gone()
 - t3030: use test_path_is_missing()
 - t2018: replace "sha" with "oid"
 - t2018: don't lose return code of git commands
 - t2018: teach do_checkout() to accept `!` arg
 - t2018: be more discerning when checking for expected exit codes
 - t2018: improve style of if-statement
 - t2018: add space between function name and ()
 - t2018: remove trailing space from test description

 Test updates.

 Will merge to 'next'.


* jn/promote-proto2-to-default (2020-01-15) 5 commits
 - fetch: default to protocol version 2
 - protocol test: let protocol.version override GIT_TEST_PROTOCOL_VERSION
 - test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate
 - config doc: protocol.version is not experimental
 - fetch test: use more robust test for filtered objects

 The transport protocol version 2 becomes the default one.

 Will merge to 'next'.


* yz/p4-py3 (2020-01-15) 14 commits
 . ci: also run linux-gcc pipeline with python3.5 environment
 - git-p4: use python3's input() everywhere
 - git-p4: simplify regex pattern generation for parsing diff-tree
 - git-p4: use dict.items() iteration for python3 compatibility
 - git-p4: use functools.reduce instead of reduce
 - git-p4: fix freezing while waiting for fast-import progress
 - git-p4: use marshal format version 2 when sending to p4
 - git-p4: open .gitp4-usercache.txt in text mode
 - git-p4: convert path to unicode before processing them
 - git-p4: encode/decode communication with git for python3
 - git-p4: encode/decode communication with p4 for python3
 - git-p4: remove string type aliasing
 - git-p4: change the expansion test from basestring to list
 - git-p4: make python2.7 the oldest supported version

 Update "git p4" to work with Python 3.

 Hold.
 The last step is too wasteful to run full tests twice.
 cf. <20200122235333.GA6837@szeder.dev>
 cf. <20200123175645.GF6837@szeder.dev>


* dl/test-must-fail-fixes (2019-12-20) 15 commits
  (merged to 'next' on 2020-01-27 at ed382cd096)
 + t1507: inline full_name()
 + t1507: run commands within test_expect_success
 + t1507: stop losing return codes of git commands
 + t1501: remove use of `test_might_fail cp`
 + t1409: use test_path_is_missing()
 + t1409: let sed open its own input file
 + t1307: reorder `nongit test_must_fail`
 + t1306: convert `test_might_fail rm` to `rm -f`
 + t0020: use ! check_packed_refs_marked
 + t0020: don't use `test_must_fail has_cr`
 + t0003: don't use `test_must_fail attr_check`
 + t0003: use test_must_be_empty()
 + t0003: use named parameters in attr_check()
 + t0000: replace test_must_fail with run_sub_test_lib_test_err()
 + t/lib-git-p4: use test_path_is_missing()

 Test clean-up.

 Will merge to 'master'.


* en/rebase-backend (2020-01-17) 19 commits
 - rebase: change the default backend from "am" to "merge"
 - rebase: make the backend configurable via config setting
 - rebase tests: repeat some tests using the merge backend instead of am
 - rebase tests: mark tests specific to the am-backend with --am
 - rebase: drop '-i' from the reflog for interactive-based rebases
 - git-prompt: change the prompt for interactive-based rebases
 - rebase: add an --am option
 - rebase: move incompatibility checks between backend options a bit earlier
 - git-rebase.txt: add more details about behavioral differences of backends
 - rebase: allow more types of rebases to fast-forward
 - t3432: make these tests work with either am or merge backends
 - rebase: fix handling of restrict_revision
 - rebase: make sure to pass along the quiet flag to the sequencer
 - rebase, sequencer: remove the broken GIT_QUIET handling
 - t3406: simplify an already simple test
 - rebase (interactive-backend): fix handling of commits that become empty
 - rebase (interactive-backend): make --keep-empty the default
 - t3404: directly test the behavior of interest
 - git-rebase.txt: update description of --allow-empty-message

 "git rebase" has learned to use the sequencer backend by default,
 while allowing "--am" option to go back to the traditional "am"
 backend.

 Waiting for reviews and/or Acks.
 cf. <CABPp-BHONuRyt8VJqRuoCF2rGYZ5EhH9KJXQZ3NO69rYwA5J3g@mail.gmail.com>


* bc/hash-independent-tests-part-7 (2020-01-15) 20 commits
  (merged to 'next' on 2020-01-27 at a519c8fae4)
 + t5604: make hash independent
 + t5601: switch into repository to hash object
 + t5562: use $ZERO_OID
 + t5540: make hash size independent
 + t5537: make hash size independent
 + t5530: compute results based on object length
 + t5512: abstract away SHA-1-specific constants
 + t5510: make hash size independent
 + t5504: make hash algorithm independent
 + t5324: make hash size independent
 + t5319: make test work with SHA-256
 + t5319: change invalid offset for SHA-256 compatibility
 + t5318: update for SHA-256
 + t4300: abstract away SHA-1-specific constants
 + t4204: make hash size independent
 + t4202: abstract away SHA-1-specific constants
 + t4200: make hash size independent
 + t4134: compute appropriate length constant
 + t4066: compute index line in diffs
 + t4054: make hash-size independent

 Preparation of test scripts for the day when the object names will
 use SHA-256 continues.

 Will merge to 'master'.


* js/add-p-leftover-bits (2020-01-15) 10 commits
  (merged to 'next' on 2020-01-27 at ec5021a1bd)
 + ci: include the built-in `git add -i` in the `linux-gcc` job
 + built-in add -p: handle Escape sequences more efficiently
 + built-in add -p: handle Escape sequences in interactive.singlekey mode
 + built-in add -p: respect the `interactive.singlekey` config setting
 + terminal: add a new function to read a single keystroke
 + terminal: accommodate Git for Windows' default terminal
 + terminal: make the code of disable_echo() reusable
 + built-in add -p: handle diff.algorithm
 + built-in add -p: support interactive.diffFilter
 + t3701: adjust difffilter test
 (this branch uses js/patch-mode-in-others-in-c.)

 The final leg of rewriting "add -i/-p" in C.

 Will merge to 'master'.


* js/patch-mode-in-others-in-c (2019-12-21) 7 commits
  (merged to 'next' on 2020-01-27 at 36f6756aae)
 + commit --interactive: make it work with the built-in `add -i`
 + built-in add -p: implement the "worktree" patch modes
 + built-in add -p: implement the "checkout" patch modes
 + built-in stash: use the built-in `git add -p` if so configured
 + legacy stash -p: respect the add.interactive.usebuiltin setting
 + built-in add -p: implement the "stash" and "reset" patch modes
 + built-in add -p: prepare for patch modes other than "stage"
 (this branch is used by js/add-p-leftover-bits.)

 The effort to move "git-add--interactive" to C continues.

 Will merge to 'master'.


* jk/packfile-reuse-cleanup (2020-01-23) 12 commits
 - pack-bitmap: don't rely on bitmap_git->reuse_objects
 - pack-objects: add checks for duplicate objects
 - pack-objects: improve partial packfile reuse
 - builtin/pack-objects: introduce obj_is_packed()
 - pack-objects: introduce pack.allowPackReuse
 - csum-file: introduce hashfile_total()
 - pack-bitmap: simplify bitmap_has_oid_in_uninteresting()
 - pack-bitmap: uninteresting oid can be outside bitmapped packfile
 - pack-bitmap: introduce bitmap_walk_contains()
 - ewah/bitmap: introduce bitmap_word_alloc()
 - packfile: expose get_delta_base()
 - builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.

 Will merge to 'next'?

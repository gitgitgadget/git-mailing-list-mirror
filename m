Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B113AC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC1F22276
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bzW73VH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgJSSNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 14:13:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57634 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgJSSNb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 14:13:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7C439A06B;
        Mon, 19 Oct 2020 14:13:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=u
        OWW/U83TsVoAY0MGVpOXrXjx7c=; b=bzW73VH7yGorQx2gzgTSZpBSohIP1xhIg
        XsQaw3zzVCcqfmLoJe6Sxq9uHPiQYokn1kfqUa9dGcm5MUNG/SFprwHsRobtiQ4+
        SdoM/ULiNtlSpAWaXyjtaqT7MUJRgoaTxKElEyC9wODlzj237kt3UWU0rtiSWx0a
        3rcvOaYuho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=g2H
        YrYvlV8fEN9fF4iEBHoI+SurU2TOyuGRiXy00HYmmPUJXdPqD7e4wqIR+Iwu2h+R
        ailCw/lEatHfRBfNCSzOtaEk+tdrspjUYAD9ImcJPF4f50cy4qvSwwWPzxBw86Bc
        IxY8hdZIk6LVIB7a6KofvzsxHs0SICd5egK3B3dk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFA7F9A06A;
        Mon, 19 Oct 2020 14:13:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38AB49A069;
        Mon, 19 Oct 2020 14:13:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2020, #03; Mon, 19)
X-master-at: 2a809eccbc6099183176b3c4760f857d09a50599
X-next-at: 2f331ef7c587c4f07226542c52ca9977814df1a5
Date:   Mon, 19 Oct 2020 11:13:22 -0700
Message-ID: <xmqqr1put77h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C67C885E-1236-11EB-BEAF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.29 final has been tagged.  We will hopefully either (1) not
see brown-paper-bag breakages at all, or (2) will see some but can
immediately deal with them, in coming couple of days.  After that,
the 2.30 cycle will gain steam, starting next week.  Let's see.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into.  Some repositories have
only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[New Topics]

* cw/ci-ghwf-check-ws-errors (2020-10-09) 1 commit
  (merged to 'next' on 2020-10-15 at 159e0f0277)
 + ci: github action - add check for whitespace errors

 Dev support.

 Will cook in 'next'.


* en/strmap (2020-10-13) 10 commits
 - strmap: enable allocations to come from a mem_pool
 - strmap: add a strset sub-type
 - strmap: add functions facilitating use as a string->int map
 - strmap: enable faster clearing and reusing of strmaps
 - strmap: add more utility functions
 - strmap: new utility functions
 - hashmap: introduce a new hashmap_partial_clear()
 - hashmap: allow re-use after hashmap_free()
 - hashmap: adjust spacing to fix argument alignment
 - hashmap: add usage documentation explaining hashmap_free[_entries]()

 A speciailization of hashmap that uses a string as key has been
 introduced.  Hopefully it will see wider use over time.

 Will merge to 'next'.


* en/test-selector (2020-10-18) 3 commits
 - test-lib: reduce verbosity of skipped tests
 - t6006, t6012: adjust tests to use 'setup' instead of synonyms
 - test-lib: allow selecting tests by substring/glob with --run

 Our test scripts can be told to run only individual pieces while
 skipping others with the "--run=..." option; they were taught to
 take a substring of test title, in addition to numbers, to name the
 test pices to run.

 Will merge to 'next'.


* jk/report-fn-typedef (2020-10-16) 1 commit
 - usage: define a type for a reporting function

 Code clean-up.

 Needs to get its log message updated.


* mr/bisect-in-c-3 (2020-10-16) 7 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C

 Rewriting "git bisect" in C continues.

 How ready is this one?


* rs/dist-doc-with-git-archive (2020-10-12) 2 commits
  (merged to 'next' on 2020-10-15 at cb1029e046)
 + Makefile: remove the unused variable TAR_DIST_EXTRA_OPTS
 + Makefile: use git init/add/commit/archive for dist-doc

 Use "git archive" more to produce the release tarball.

 Will cook in 'next'.


* rs/tighten-callers-of-deref-tag (2020-10-12) 3 commits
  (merged to 'next' on 2020-10-15 at a0df4a45cb)
 + line-log: handle deref_tag() returning NULL
 + blame: handle deref_tag() returning NULL
 + grep: handle deref_tag() returning NULL

 Code clean-up.

 Will cook in 'next'.


* rs/worktree-list-show-locked (2020-10-12) 1 commit
  (merged to 'next' on 2020-10-15 at 3917e61c28)
 + worktree: teach `list` to annotate locked worktree

 "git worktree list" now shows if each worktree is locked.  This
 possibly may open us to show other kinds of states in the future.

 Will cook in 'next'.


* sc/sequencer-gpg-octopus (2020-10-18) 3 commits
 - t3435: add tests for rebase -r GPG signing
 - sequencer: pass explicit --no-gpg-sign to merge
 - sequencer: fix gpg option passed to merge subcommand

 "git rebase --rebase-merges" did not correctly pass --gpg-sign
 command line option to underying "git merge" when replaying a merge
 using non-default merge strategy or when replaying an octopus merge
 (because replaying a two-head merge with the default strategy was
 done in a separate codepath, the problem did not trigger for most
 users), which has been corrected.

 Will merge to 'next'.


* sm/curl-retry (2020-10-13) 3 commits
 - http: automatically retry some requests
 - replace CURLOPT_FILE With CURLOPT_WRITEDATA
 - remote-curl: add testing for intelligent retry for HTTP

 The http transport has been taught to retry a failed request that
 may reasonably be retried.

 Need to pick up reroll.


* as/sample-push-to-checkout-hook (2020-10-16) 1 commit
 - hook: add sample template for push-to-checkout

 Add a sample 'push-to-checkout' hook, that performs the same as
 what the built-in default action does.

 Will merge to 'next'.


* as/tests-cleanup (2020-10-18) 1 commit
 - t2200,t9832: avoid using 'git' upstream in a pipe

 Micro clean-up of a couple of test scripts.

 Will merge to 'next'.


* bk/sob-dco (2020-10-18) 3 commits
 - SubmittingPatches: clarify DCO is our --signoff rule
 - Documentation: clarify and expand description of --signoff
 - doc: preparatory clean-up of description on the sign-off option

 Document that the meaning of a Signed-off-by trailer can vary from
 project to project in the end-user documentation, and clarify what
 it means to this project.


* ct/t0000-use-test-path-is-file (2020-10-18) 1 commit
 - t0000: use test_path_is_file instead of "test -f"

 Micro clean-up of a test script.


* en/dir-rename-tests (2020-10-16) 4 commits
 - t6423: more involved rules for renaming directories into each other
 - t6423: update directory rename detection tests with new rule
 - t6423: more involved directory rename test
 - directory-rename-detection.txt: update references to regression tests

 More preliminary tests have been added to document desired outcome
 of various "directory rename" situations.

 Will merge to 'next'.


* en/t7518-unflake (2020-10-18) 1 commit
 - t7518: fix flaky grep invocation

 Work around flakiness in a test.

 Will merge to 'next'.


* es/test-cmp-typocatcher (2020-10-16) 1 commit
 - Revert "test_cmp: diagnose incorrect arguments"

 A test helper "test_cmp A B" was taught to diagnose missing files A
 or B as a bug in test, but some tests legitimately wanted to notice
 a failure to even create file B as an error, in addition to leaving
 the expected result in it, and were misdiagnosed as a bug.  This
 has been corrected.

 Will merge to 'next'.


* es/tutorial-mention-asciidoc-early (2020-10-16) 1 commit
 - MyFirstContribution: clarify asciidoc dependency

 Doc update.

 Will merge to 'next'.


* jk/fast-import-marks-alloc-fix (2020-10-15) 1 commit
 - fast-import: fix over-allocation of marks storage

 "git fast-import" wasted a lot of memory when many marks were in use.

 Will merge to 'next'.


* jk/fast-import-marks-cleanup (2020-10-16) 1 commit
 - fast-import: remove duplicated option-parsing line

 Code clean-up.

 Will merge to 'next'.


* jk/no-common (2020-10-16) 1 commit
 - config.mak.dev: build with -fno-common

 Dev support to catch a tentative definition of a variable in our C
 code as an error.

 Will merge to 'next'.


* js/ci-ghwf-dedup-tests (2020-10-12) 2 commits
 - ci: make the "skip-if-redundant" check more defensive
 - ci: work around old records of GitHub runs

 GitHub Actions automated test improvement to skip tests on a tree
 identical to what has already been tested.

 Will merge to 'next'.


* lo/zsh-completion (2020-10-16) 1 commit
 - completion: fix zsh installation instructions

 Update instructions for command line completion (in contrib/) for zsh.

 Will merge to 'next'.


* nk/diff-files-vs-fsmonitor (2020-10-18) 4 commits
 - t/perf: add fsmonitor perf test for git diff
 - t/perf/p7519-fsmonitor.sh: warm cache on first git status
 - t/perf/README: elaborate on output format
 - fsmonitor: use fsmonitor data in `git diff`

 "git diff" and other commands that share the same machinery to
 compare with working tree files have been taught to take advantage
 of the fsmonitor data when available.

 Will merge to 'next'.


* nk/dir-c-comment-update (2020-10-16) 1 commit
 - dir.c: fix comments to agree with argument name

 Update stale in-code comment.

 Will merge to 'next'.


* tk/credential-config (2020-10-16) 1 commit
 - credential: load default config

 "git credential' didn't honor the core.askPass configuration
 variable (among other things), which has been corrected.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* sv/t7001-modernize (2020-09-25) 11 commits
 - t7001: move cleanup code from outside the tests into them
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use ': >' rather than 'touch'
 - t7001: change (cd <path> && git foo) to (git -C <path> foo)
 - t7001: remove whitespace after redirect operators
 - t7001: change the style for cd according to subshell
 - t7001: remove unnecessary blank lines
 - t7001: use TAB instead of spaces
 - t7001: convert tests from the old style to the current style

 Test script modernization.

 Expecting a reroll.
 cf. <20200925170256.11490-1-shubhunic@gmail.com>


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* bc/rev-parse-path-format (2020-10-09) 2 commits
 - rev-parse: add option for absolute or relative path formatting
 - abspath: add a function to resolve paths with missing components

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might need to enable.

 Doc update.

 Expecting a reroll.
 cf. <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
 cf. <xmqqft85i72s.fsf@gitster.c.googlers.com>


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Discard for now.
 cf. <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
 cf. <20200911214358.acl3hy2e763begoo@feanor>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* ag/merge-strategies-in-c (2020-10-06) 11 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-index: don't fork if the requested program is `git-merge-one-file'
 - merge-index: libify merge_one_path() and merge_all()
 - merge-one-file: rewrite in C
 - t6027: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.


* jk/symlinked-dotgitx-files (2020-10-06) 8 commits
  (merged to 'next' on 2020-10-08 at b9e128a280)
 + fsck: complain when .gitattributes or .gitignore is a symlink
 + verify_path(): disallow symlinks in .gitattributes and .gitignore
 + t0060: test obscured .gitattributes and .gitignore matching
 + t7450: test .gitmodules symlink matching against obscured names
 + t7450: test verify_path() handling of gitmodules
 + t7415: rename to expand scope
 + fsck_tree(): wrap some long lines
 + fsck_tree(): fix shadowed variable

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 Will cook in 'next'.


* dl/checkout-guess (2020-10-08) 2 commits
  (merged to 'next' on 2020-10-08 at c9a6bc9a54)
 + checkout: learn to respect checkout.guess
 + Documentation/config/checkout: replace sq with backticks

 "git checkout" learned to use checkout.guess configuration variable
 and enable/disable its "--[no-]guess" option accordingly.

 Will cook in 'next'.


* dl/checkout-p-merge-base (2020-10-07) 4 commits
  (merged to 'next' on 2020-10-08 at 807e047d68)
 + t2016: add a NEEDSWORK about the PERL prerequisite
 + add-patch: add NEEDSWORK about comparing commits
 + Doc: document "A...B" form for <tree-ish> in checkout and switch
 + builtin/checkout: fix `git checkout -p HEAD...` bug

 "git checkout -p A...B [-- <path>]" did not work, even though the
 same command without "-p" correctly used the merge-base between
 commits A and B.

 Will cook in 'next'.


* dl/resurrect-update-for-sha256 (2020-10-08) 2 commits
 - contrib/git-resurrect.sh: use hash-agnostic OID pattern
 - contrib/git-resurrect.sh: indent with tabs

 "git resurrect" script (in contrib/) learned that the object names
 may be longer than 40-hex depending on the hash function in use.


* ds/commit-graph-merging-fix (2020-10-09) 2 commits
 - commit-graph: don't write commit-graph when disabled
 - commit-graph: ignore duplicates when merging layers

 When "git commit-graph" detects the same commit recorded more than
 once while it is merging the layers, it used to die.  The code now
 ignores all but one of them and continues.

 Will merge to 'next'.


* ds/maintenance-commit-graph-auto-fix (2020-10-12) 2 commits
 - maintenance: core.commitGraph=false prevents writes
 - maintenance: test commit-graph auto condition

 Test-coverage enhancement of running commit-graph task "git
 maintenance" as needed led to discovery and fix of a bug.

 Will merge to 'next'.


* js/userdiff-php (2020-10-07) 1 commit
  (merged to 'next' on 2020-10-08 at 988c7ea068)
 + userdiff: PHP: catch "abstract" and "final" functions

 Userdiff for PHP update.

 Will cook in 'next'.


* kb/userdiff-rust-macro-rules (2020-10-07) 1 commit
  (merged to 'next' on 2020-10-08 at 949063bcae)
 + userdiff: recognize 'macro_rules!' as starting a Rust function block

 Userdiff for Rust update.

 Will cook in 'next'.


* rk/completion-stash (2020-10-07) 2 commits
  (merged to 'next' on 2020-10-08 at ad60933f40)
 + git-completion.bash: stash-show: complete $__git_diff_common_options
 + git-completion.bash: __git_diff_common_options: add --[no-]patch

 The command line completion script (in contrib/) learned that "git
 stash show" takes the options "git diff" takes.

 Will cook in 'next'.


* sd/userdiff-css-update (2020-10-08) 1 commit
  (merged to 'next' on 2020-10-08 at 69b7e9df5d)
 + userdiff: expand detected chunk headers for css

 Userdiff for CSS update.

 Will cook in 'next'.


* ss/submodule-add-in-c (2020-10-07) 3 commits
 - t7400: add test to check 'submodule add' for tracked paths
 - submodule: port submodule subcommand 'add' from shell to C
 - dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.


* ak/corrected-commit-date (2020-10-08) 10 commits
 - doc: add corrected commit date info
 - commit-reach: use corrected commit dates in paint_down_to_common()
 - commit-graph: use generation v2 only if entire chain does
 - commit-graph: implement generation data chunk
 - commit-graph: implement corrected commit date
 - commit-graph: add a slab to store topological levels
 - commit-graph: return 64-bit generation number
 - commit-graph: consolidate fill_commit_graph_info
 - revision: parse parent in indegree_walk_step()
 - commit-graph: fix regression when computing Bloom filters

 The commit-graph learned to use corrected commit dates instead of
 the generation number to help topological revision traversal.

 How ready is this?


* mk/diff-ignore-regex (2020-10-16) 2 commits
 - diff: add -I<regex> that ignores matching changes
 - merge-base, xdiff: zero out xpparam_t structures

 "git diff" family of commands learned the "-I<regex>" option to
 ignore hunks whose changed lines all match the given pattern.

 Expecting a reroll.


* mt/parallel-checkout-part-1 (2020-10-05) 20 commits
  (merged to 'next' on 2020-10-05 at 571e16d68a)
 + parallel-checkout: drop unused checkout state parameter
  (merged to 'next' on 2020-10-04 at 20438c1143)
 + ci: run test round with parallel-checkout enabled
 + parallel-checkout: add tests related to .gitattributes
 + parallel-checkout: add tests related to clone collisions
 + parallel-checkout: add tests for basic operations
 + checkout-index: add parallel checkout support
 + builtin/checkout.c: complete parallel checkout support
 + make_transient_cache_entry(): optionally alloc from mem_pool
 + parallel-checkout: support progress displaying
 + parallel-checkout: make it truly parallel
 + unpack-trees: add basic support for parallel checkout
 + entry: add checkout_entry_ca() which takes preloaded conv_attrs
 + entry: move conv_attrs lookup up to checkout_entry()
 + entry: extract cache_entry update from write_entry()
 + entry: make fstat_output() and read_blob_entry() public
 + entry: extract a header file for entry.c functions
 + convert: add conv_attrs classification
 + convert: add get_stream_filter_ca() variant
 + convert: add [async_]convert_to_working_tree_ca() variants
 + convert: make convert_attrs() and convert structs public

 Parallel checkout.

 Will cook in 'next'.


* dl/diff-merge-base (2020-09-21) 10 commits
 - contrib/completion: complete `git diff --merge-base`
 - builtin/diff-tree: learn --merge-base
 - builtin/diff-index: learn --merge-base
 - t4068: add --merge-base tests
 - diff-lib: define diff_get_merge_base()
 - diff-lib: accept option flags in run_diff_index()
 - contrib/completion: extract common diff/difftool options
 - git-diff.txt: backtick quote command text
 - git-diff-index.txt: make --cached description a proper sentence
 - t4068: remove unnecessary >tmp

 "git diff A...B" learned "git diff --merge-base A B", which is a
 longer short-hand to say the same thing.


* sb/clone-origin (2020-09-30) 7 commits
  (merged to 'next' on 2020-10-06 at 7178c9af9c)
 + clone: allow configurable default for `-o`/`--origin`
 + clone: read new remote name from remote_name instead of option_origin
 + clone: validate --origin option before use
 + refs: consolidate remote name validation
 + remote: add tests for add and rename with invalid names
 + clone: use more conventional config/option layering
 + clone: add tests for --template and some disallowed option pairs

 "git clone" learned clone.defaultremotename configuration variable
 to customize what nickname to use to call the remote the repository
 was cloned from.

 Will cook in 'next'.


* sk/force-if-includes (2020-10-03) 4 commits
  (merged to 'next' on 2020-10-04 at 09c4c1e088)
 + t, doc: update tests, reference for "--force-if-includes"
 + push: parse and set flag for "--force-if-includes"
 + push: add reflog check for "--force-if-includes"
 + Merge branch 'ds/in-merge-bases-many-optim-bug' into sk/force-if-includes

 "git push --force-with-lease[=<ref>]" can easily be misused to lose
 commits unless the user takes good care of their own "git fetch".
 A new option "--force-if-includes" attempts to ensure that what is
 being force-pushed was created after examining the commit at the
 tip of the remote ref that is about to be force-replaced.

 Will cook in 'next'.


* hn/reftable (2020-10-01) 13 commits
 . reftable: "test-tool dump-reftable" command.
 . reftable: rest of library
 . reftable: file level tests
 . reftable: read reftable files
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: utility functions
 . reftable: add a barebones unittest framework
 . vcxproj: adjust for the reftable changes
 . reftable: define the public API
 . reftable: add LICENSE

 The reftable backend for the refs API.

 Expecting a reroll.
 Seems not to build for Windows folks.
 cf. <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
 cf. <nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet>


* ds/maintenance-part-3 (2020-10-16) 8 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: use 'incremental' strategy by default
 - maintenance: create maintenance.strategy config
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch uses ds/maintenance-part-2.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.


* es/config-hooks (2020-10-16) 8 commits
 - hook: replace find_hook() with hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: include hookdir hook in list
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.


* mt/grep-sparse-checkout (2020-09-10) 9 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - config: make do_git_config_sequence receive a 'struct repository'
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: diagnose missing arguments
 - t/helper/test-config: be consistent with exit codes
 - t1308-config-set: avoid false positives when using test-config
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.


* ds/maintenance-part-2 (2020-09-25) 8 commits
  (merged to 'next' on 2020-10-04 at c2a46f390c)
 + maintenance: add incremental-repack auto condition
 + maintenance: auto-size incremental-repack batch
 + maintenance: add incremental-repack task
 + midx: use start_delayed_progress()
 + midx: enable core.multiPackIndex by default
 + maintenance: create auto condition for loose-objects
 + maintenance: add loose-objects task
 + maintenance: add prefetch task
 (this branch is used by ds/maintenance-part-3.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.

 Will cook in 'next'.

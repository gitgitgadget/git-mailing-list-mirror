Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8534C64E8A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 05:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0AB2085B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 05:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qoGxLes9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLAFQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 00:16:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52786 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgLAFQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 00:16:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E89E9ABA6;
        Tue,  1 Dec 2020 00:15:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
        n3Qs8rhPurcuCKTVv6jTJoiCOg=; b=qoGxLes9lICl+iB3KdD0j+PlxlWwyY1aV
        SaZncz5pO2zfzE7ELoREHIOyU+b5kJga6ykyovFogmLhgW25QNHTw+ZFF537J0kr
        PwngkT7FEFojpPVTnxJChaPWehhUzp2VZXXYyn1cgnwQNAHAK43VKTqwB2YSD3Qe
        zVpFwIxN/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=g18
        IQh48xmEekgamdQyJIt1mfnT+GvUbUf4m301V8WKWoIpeaaE9g7Qr4KZYub7xLkm
        LIMoRX/A4iV+TPc6CnoDNAS6gmLcVDm1dJiFnmJg8qAHZ7IeOquc+80lJpDMc9dz
        4BZRFTxXkyZfMzLVZKHEZDfxRad6UfjvdjMWLFHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40E359ABA5;
        Tue,  1 Dec 2020 00:15:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1D139ABA4;
        Tue,  1 Dec 2020 00:15:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2020, #06; Mon, 30)
X-master-at: 72ffeb997eaf999f6938b2a7e0d9a75dcceaa311
X-next-at: 1209160524d6229d60c3301df9152cf1aa58ff6d
Date:   Mon, 30 Nov 2020 21:15:37 -0800
Message-ID: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F70AF96-3394-11EB-8A2E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

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
[Graduated to 'master']

* ab/gc-keep-base-option (2020-11-21) 2 commits
  (merged to 'next' on 2020-11-25 at ac76ddcfe7)
 + gc: rename keep_base_pack variable for --keep-largest-pack
 + gc docs: change --keep-base-pack to --keep-largest-pack

 Fix an option name in "gc" documentation.


* hn/sleep-millisec-decl (2020-11-24) 1 commit
  (merged to 'next' on 2020-11-25 at d11de8b987)
 + move sleep_millisec to git-compat-util.h

 Move a definition of compatibility wrapper from cache.h to
 git-compat-util.h


* jc/do-not-just-explain-but-update-your-patch (2020-11-24) 1 commit
  (merged to 'next' on 2020-11-25 at 1f5235d4e1)
 + MyFirstContribition: answering questions is not the end of the story

 Expectation for the original contributor after responding to a
 review comment to use the explanation in a patch update has been
 described.


* js/pull-rebase-use-advise (2020-11-19) 1 commit
  (merged to 'next' on 2020-11-25 at 05db775119)
 + pull: colorize the hint about setting `pull.rebase`

 UI improvement.


* js/t1309-master-to-topic (2020-11-19) 1 commit
  (merged to 'next' on 2020-11-25 at 044da285ef)
 + t1309: use a neutral branch name in the `onbranch` test cases

 Test preparation.


* js/t2106-cleanup (2020-11-18) 3 commits
  (merged to 'next' on 2020-11-23 at b1bcd5d8b2)
 + t2106: ensure that the checkout fails for the expected reason
 + t2106: make test independent of the current main branch name
 + t2106: adjust style to the current conventions

 A test script got cleaned up and then made not to depend on the
 value of init.defaultBranch.


* js/t3040-cleanup (2020-11-18) 1 commit
  (merged to 'next' on 2020-11-23 at 88951eae2f)
 + t3040: remove stale note

 Cleanup.


* js/t3404-master-to-primary (2020-11-24) 1 commit
  (merged to 'next' on 2020-11-25 at c2959cc831)
 + t3404: do not depend on any specific default branch name

 A test script got cleaned up and then made not to depend on the
 value of init.defaultBranch.


* js/t4015-wo-master (2020-11-19) 1 commit
  (merged to 'next' on 2020-11-23 at b85c36ffb4)
 + t4015: let the test pass with any default branch name

 A test script got cleaned up not to depend on the value of
 init.defaultBranch.


* km/stash-error-message-fix (2020-11-24) 1 commit
  (merged to 'next' on 2020-11-25 at 9ef82d6aa7)
 + stash: add missing space to an error message

 Error message fix.


* mt/worktree-error-message-fix (2020-11-21) 1 commit
  (merged to 'next' on 2020-11-25 at bc887168ff)
 + worktree: fix order of arguments in error message

 Fix formulation of an error message with two placeholders in "git
 worktree add" subcommand.


* na/notes-displayref-is-not-boolean (2020-11-23) 2 commits
  (merged to 'next' on 2020-11-25 at b0dda46b56)
 + t3301: test proper exit response to no-value notes.displayRef.
 + notes.c: fix a segfault in notes_display_config()

 Config parser fix for "git notes".


* sa/credential-store-timeout (2020-11-25) 1 commit
  (merged to 'next' on 2020-11-25 at 7a9a4b68fd)
 + crendential-store: use timeout when locking file

 Multiple "credential-store" backends can race to lock the same
 file, causing everybody else but one to fail---reattempt locking
 with some timeout to reduce the rate of the failure.

--------------------------------------------------
[New Topics]

* nk/perf-fsmonitor-cleanup (2020-11-30) 1 commit
 - perf/fsmonitor: use test_must_be_empty helper

 Test clean-up.

 Will merge to 'next'.


* rs/fetch-pack-invalid-lockfile (2020-11-30) 1 commit
 - fetch-pack: disregard invalid pack lockfiles

 "fetch-pack" could pass NULL pointer to unlink(2) when it sees an
 invalid filename; the error checking has been tightened to make
 this impossible.

 Will merge to 'next'.


* rs/maintenance-run-outside-repo (2020-11-30) 1 commit
 - maintenance: fix SEGFAULT when no repository

 "git maintenance run/start/stop" needed to be run in a repository
 to hold the lockfile they use, but didn't make sure they are
 actually in a repository, which has been corrected.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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
 (this branch is used by mt/rm-sparse-checkout.)

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.


* mt/rm-sparse-checkout (2020-11-16) 1 commit
 - rm: honor sparse checkout patterns
 (this branch uses mt/grep-sparse-checkout.)

 "git rm" follows suit to "git grep" to ignore paths outside the
 sparsity pattern when the sparse checkout feature is in use.

 Need to wait for how these fit in larger picture.
 cf. <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>


* jk/symlinked-dotgitx-files (2020-10-23) 9 commits
  (merged to 'next' on 2020-10-26 at c1dd37b024)
 + docs: document symlink restrictions for .git* files
 + fsck: complain when .gitattributes or .gitignore is a symlink
 + verify_path(): disallow symlinks in .gitattributes and .gitignore
 + t0060: test obscured .gitattributes and .gitignore matching
 + t7450: test .gitmodules symlink matching against obscured names
 + t7450: test verify_path() handling of gitmodules
 + t7415: rename to expand scope
 + fsck_tree(): wrap some long lines
 + fsck_tree(): fix shadowed variable

 Originally merged to 'next' on 2020-10-23

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 It seems that there are real projects with .gitignore recorded as
 symlinks, which may need to loosen the fsck setting.  Do we need to
 introduce a class that is separate from symlinked .gitmodules that
 probably is with potential consequences that is more/less grave?


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


* sm/curl-retry (2020-10-13) 3 commits
 - http: automatically retry some requests
 - replace CURLOPT_FILE With CURLOPT_WRITEDATA
 - remote-curl: add testing for intelligent retry for HTTP

 The http transport has been taught to retry a failed request that
 may reasonably be retried.

 Expecting a reroll.
 cf. <20201015000410.GB328643@google.com>
 cf. <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>


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
[Needs Review]

* ss/submodule-add-in-c (2020-10-07) 3 commits
 . t7400: add test to check 'submodule add' for tracked paths
 . submodule: port submodule subcommand 'add' from shell to C
 . dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.

 Needs review.


* mt/parallel-checkout-part-1 (2020-11-04) 19 commits
 - ci: run test round with parallel-checkout enabled
 - parallel-checkout: add tests related to .gitattributes
 - parallel-checkout: add tests related to clone collisions
 - parallel-checkout: add tests for basic operations
 - checkout-index: add parallel checkout support
 - builtin/checkout.c: complete parallel checkout support
 - make_transient_cache_entry(): optionally alloc from mem_pool
 - parallel-checkout: support progress displaying
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout
 - entry: add checkout_entry_ca() which takes preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract cache_entry update from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add conv_attrs classification
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public

 Parallel checkout.

 Needs review.


* fc/bash-completion-post-2.29 (2020-11-10) 26 commits
 - completion: bash: shuffle __gitcomp functions
 - completion: bash: cleanup __gitcomp* invocations
 - completion: bash: add __gitcomp_opts
 - completion: bash: improve __gitcomp description
 - completion: bash: rename _get_comp_words_by_ref()
 - completion: bash: trivial cleanup
 - completion: bash: cleanup _get_comp_words_by_ref()
 - completion: bash: refactor _get_comp_words_by_ref()
 - completion: bash: simplify _get_comp_words_by_ref()
 - test: completion: switch __gitcomp_nl prefix test
 - completion: bash: simplify config_variable_name
 - completion: bash: improve __gitcomp suffix code
 - completion: bash: change suffix check in __gitcomp
 - completion: bash: simplify __gitcomp
 - completion: bash: refactor __gitcomp
 - completion: bash: simplify equal suffix check
 - completion: bash: factor out check in __gitcomp
 - completion: bash: get rid of any non-append code
 - completion: bash: get rid of _append() functions
 - completion: bash: remove non-append functionality
 - test: completion: add run_func() helper
 - test: completion: fix currently typed words
 - completion: bash: do not modify COMP_WORDBREAKS
 - completion: bash: fix for suboptions with value
 - completion: bash: add correct suffix in variables
 - completion: bash: fix prefix detection in branch.*

 Needs review.


* so/log-diff-merge (2020-11-09) 27 commits
 - doc/git-show: include --diff-merges description
 - doc/rev-list-options: document --first-parent implies --diff-merges=first-parent
 - doc/diff-generate-patch: mention new --diff-merges option
 - doc/git-log: describe new --diff-merges options
 - t4013: add test for --diff-merges=first-parent
 - diff-merges: implement new values for --diff-merges
 - diff-merges: make -m/-c/--cc explicitly mutually exclusive
 - diff-merges: refactor opt settings into separate functions
 - diff-merges: get rid of now empty diff_merges_init_revs()
 - diff-merges: group diff-merge flags next to each other inside 'rev_info'
 - diff-merges: split 'ignore_merges' field
 - diff-merges: fix -m to properly override -c/--cc
 - t4013: add tests for -m failing to override -c/--cc
 - t4013: support test_expect_failure through ':failure' magic
 - diff-merges: revise revs->diff flag handling
 - diff-merges: introduce revs->first_parent_merges flag
 - diff-merges: new function diff_merges_set_dense_combined_if_unset()
 - diff-merges: new function diff_merges_suppress()
 - diff-merges: re-arrange functions to match the order they are called in
 - diff-merges: rename diff_merges_default_to_enable() to match semantics
 - diff-merges: move checks for first_parent_only out of the module
 - diff-merges: rename all functions to have common prefix
 - revision: move diff merges functions to its own diff-merges.c
 - revision: provide implementation for diff merges tweaks
 - revision: factor out initialization of diff-merge related settings
 - revision: factor out setup of diff-merge related settings
 - revision: factor out parsing of diff-merge related options

 "git log" learned a new "--diff-merges=<how>" option.

 Needs review.


* en/merge-ort-impl (2020-11-11) 21 commits
 - merge-ort: free data structures in merge_finalize()
 - merge-ort: add implementation of record_unmerged_index_entries()
 - tree: enable cmp_cache_name_compare() to be used elsewhere
 - merge-ort: add implementation of checkout()
 - merge-ort: basic outline for merge_switch_to_result()
 - merge-ort: step 3 of tree writing -- handling subdirectories as we go
 - merge-ort: step 2 of tree writing -- function to create tree object
 - merge-ort: step 1 of tree writing -- record basenames, modes, and oids
 - merge-ort: have process_entries operate in a defined order
 - merge-ort: add a preliminary simple process_entries() implementation
 - merge-ort: avoid recursing into identical trees
 - merge-ort: record stage and auxiliary info for every path
 - merge-ort: compute a few more useful fields for collect_merge_info
 - merge-ort: avoid repeating fill_tree_descriptor() on the same tree
 - merge-ort: implement a very basic collect_merge_info()
 - merge-ort: add an err() function similar to one from merge-recursive
 - merge-ort: use histogram diff
 - merge-ort: port merge_start() from merge-recursive
 - merge-ort: add some high-level algorithm structure
 - merge-ort: setup basic internal data structures
 - Merge branch 'en/strmap' into en/merge-ort-impl

 Needs review.
 A reroll exists.
 cf. <pull.923.git.git.1606635803.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* en/stash-apply-sparse-checkout (2020-11-21) 3 commits
 - stash: fix stash application in sparse-checkouts
 - stash: remove unnecessary process forking
 - t7012: add a testcase demonstrating stash apply bugs in sparse checkouts


* jk/stop-pack-objects-when-push-is-killed (2020-11-21) 1 commit
  (merged to 'next' on 2020-11-25 at f73fb999cd)
 + send-pack: kill pack-objects helper on signal or exit

 Receiving "git push" that is killed may leave zombie pack-objects
 process behind, which has been corrected.

 Will merge to 'master'.


* ma/grep-init-default (2020-11-30) 4 commits
 - MyFirstObjectWalk: drop `init_walken_defaults()`
 - grep: copy struct in one fell swoop
 - grep: use designated initializers for `grep_defaults`
 - grep: don't set up a "default" repo for grep

 Code clean-up.

 Will merge to 'next'.


* fc/atmark-in-refspec (2020-11-30) 3 commits
 - refspec: make @ a synonym of HEAD
 - tests: push: trivial cleanup
 - tests: push: improve cleanup of HEAD tests

 "@" sometimes worked (e.g. "git push origin @:there") as a part of
 a refspec element, but "git push orign @" did not work, which has
 been corrected.


* js/init-defaultbranch-advice (2020-11-24) 4 commits
 - init: provide useful advice about init.defaultBranch
 - get_default_branch_name(): prepare for showing some advice
 - branch -m: allow renaming a yet-unborn branch
 - init: document `init.defaultBranch` better

 Our users are going to be trained to prepare for future change of
 init.defaultBranch configuration variable.


* jt/trace-error-on-warning (2020-11-24) 1 commit
  (merged to 'next' on 2020-11-30 at 1ab8a970f8)
 + usage: add trace2 entry upon warning()

 Like die() and error(), a call to warning() will also trigger a
 trace2 event.

 Will merge to 'master'.


* ps/config-env-pairs (2020-11-24) 2 commits
 - config: allow specifying config entries via envvar pairs
 - config: extract function to parse config pairs

 Introduce a way to feed configuration variable-value pairs via
 environment variables.

 Getting there.
 cf. <X74CigYS7AUtMo9Q@tanuki>


* tb/idx-midx-race-fix (2020-11-25) 2 commits
  (merged to 'next' on 2020-11-30 at 493ded178e)
 + midx.c: protect against disappearing packs
 + packfile.c: protect against disappearing indexes

 Processes that access packdata while the .idx file gets removed
 (e.g. while repacking) did not fail or fall back gracefully as they
 could.

 Will merge to 'master'.


* rs/stop-pack-objects-when-fetch-is-killed (2020-11-25) 1 commit
 - upload-pack: kill pack-objects helper on signal or exit

 "git upload-pack" that is killed may leave zombie pack-objects
 process behind, which has been corrected.

 Needs to be replaced with signed-off and/or improved version.


* tb/pack-bitmap (2020-11-21) 24 commits
 - pack-bitmap-write: better reuse bitmaps
 - pack-bitmap-write: relax unique rewalk condition
 - pack-bitmap-write: use existing bitmaps
 - pack-bitmap: factor out 'add_commit_to_bitmap()'
 - pack-bitmap: factor out 'bitmap_for_commit()'
 - pack-bitmap-write: ignore BITMAP_FLAG_REUSE
 - pack-bitmap-write: build fewer intermediate bitmaps
 - pack-bitmap.c: check reads more aggressively when loading
 - pack-bitmap-write: rename children to reverse_edges
 - t5310: add branch-based checks
 - commit: implement commit_list_contains()
 - bitmap: add bitmap_diff_nonzero()
 - pack-bitmap-write: fill bitmap with commit history
 - pack-bitmap-write: pass ownership of intermediate bitmaps
 - pack-bitmap-write: reimplement bitmap writing
 - ewah: add bitmap_dup() function
 - ewah: implement bitmap_or()
 - ewah: make bitmap growth less aggressive
 - ewah: factor out bitmap growth
 - rev-list: die when --test-bitmap detects a mismatch
 - t5310: drop size of truncated ewah bitmap
 - pack-bitmap: bounds-check size of cache extension
 - pack-bitmap: fix header size check
 - ewah/ewah_bitmap.c: grow buffer past 1

 Various improvement to the codepath that writes out pack bitmaps.

 Needs a bit of reshuffling?
 cf. <X7xzWClGr3bM3wcg@coredump.intra.peff.net>


* ab/retire-parse-remote (2020-11-24) 4 commits
  (merged to 'next' on 2020-11-25 at 644484d7df)
 + submodule: fix fetch_in_submodule logic
  (merged to 'next' on 2020-11-18 at 80d4d8290c)
 + parse-remote: remove this now-unused library
 + submodule: remove sh function in favor of helper
 + submodule: use "fetch" logic instead of custom remote discovery

 "git-parse-remote" shell script library outlived its usefulness.

 Will merge to 'master'.


* pb/pull-rebase-recurse-submodules (2020-11-16) 4 commits
  (merged to 'next' on 2020-11-25 at 9837b50d7f)
 + pull: check for local submodule modifications with the right range
 + t5572: describe '--rebase' tests a little more
 + t5572: add notes on a peculiar test
 + pull --rebase: compute rebase arguments in separate function

 "git pull --rebase --recurse-submodules" checked for local changes
 in a wrong range and failed to run correctly when it should.

 Will merge to 'master'.


* tb/repack-simplify (2020-11-17) 3 commits
  (merged to 'next' on 2020-11-25 at 79a98f2403)
 + builtin/repack.c: don't move existing packs out of the way
 + builtin/repack.c: keep track of what pack-objects wrote
 + repack: make "exts" array available outside cmd_repack()

 Simplify the logic to deal with a repack operation that ended up
 creating the same packfile.

 Will merge to 'master'.


* dd/help-autocorrect-never (2020-11-25) 1 commit
 - help.c: help.autocorrect=never means "do not compute suggestions"

 "git $cmd $args", when $cmd is not a recognised subcommand, by
 default tries to see if $cmd is a typo of an existing subcommand
 and optionally executes the corrected command if there is only one
 possibility, depending on the setting of help.autocorrect; the
 users can now disable the whole thing, including the cycles spent
 to find a likely typo, by setting the configuration variable to
 'never'.

 Getting there.
 cf. <xmqqft4xdubq.fsf_-_@gitster.c.googlers.com>


* js/default-branch-name-tests-final-stretch (2020-11-19) 29 commits
 - tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where no longer needed
 - t99*: adjust the references to the default branch name "main"
 - tests(git-p4): transition to the default branch name `main`
 - t9[5-7]*: adjust the references to the default branch name "main"
 - t9[0-4]*: adjust the references to the default branch name "main"
 - t8*: adjust the references to the default branch name "main"
 - t7[5-9]*: adjust the references to the default branch name "main"
 - t7[0-4]*: adjust the references to the default branch name "main"
 - t6[4-9]*: adjust the references to the default branch name "main"
 - t64*: preemptively adjust alignment to prepare for `master` -> `main`
 - t6[0-3]*: adjust the references to the default branch name "main"
 - t5[6-9]*: adjust the references to the default branch name "main"
 - t55[4-9]*: adjust the references to the default branch name "main"
 - t55[23]*: adjust the references to the default branch name "main"
 - t551*: adjust the references to the default branch name "main"
 - t550*: adjust the references to the default branch name "main"
 - t5503: prepare aligned comment for replacing `master` with `main`
 - t5[0-4]*: adjust the references to the default branch name "main"
 - t5323: prepare centered comment for `master` -> `main`
 - t4*: adjust the references to the default branch name "main"
 - t3[5-9]*: adjust the references to the default branch name "main"
 - t34*: adjust the references to the default branch name "main"
 - t3416: preemptively adjust alignment in a comment
 - t3[0-3]*: adjust the references to the default branch name "main"
 - t2*: adjust the references to the default branch name "main"
 - t[01]*: adjust the references to the default branch name "main"
 - t0060: preemptively adjust alignment
 - tests: mark tests relying on the current default for `init.defaultBranch`
 - Merge 'jk/diff-release-filespec-fix' into js/default-branch-name-tests-final-stretch

 Prepare tests not to be affected by the name of the default branch
 "git init" creates.


* ds/config-literal-value (2020-11-25) 8 commits
 - config doc: value-pattern is not necessarily a regexp
 - config: implement --fixed-value with --get*
 - config: plumb --fixed-value into config API
 - config: add --fixed-value option, un-implemented
 - t1300: add test for --replace-all with value-pattern
 - t1300: test "set all" mode with value-pattern
 - config: replace 'value_regex' with 'value_pattern'
 - config: convert multi_replace to flags
 (this branch is used by ds/maintenance-part-3.)

 Various subcommands of "git config" that takes value_regex
 learn the "--literal-value" option to take the value_regex option
 as a literal string.

 Expecting a (hopefully final) reroll.


* ds/maintenance-part-3 (2020-11-25) 2 commits
 - maintenance: use 'git config --fixed-value'
 - Merge branch 'ds/config-literal-value' into ds/maintenance-part-3
 (this branch uses ds/config-literal-value.)

 "git maintenance" command had trouble working in a directory whose
 pathname contained an ERE metacharacter like '+'.

 Blocked by ds/config-literal-value.


* ag/merge-strategies-in-c (2020-11-24) 13 commits
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
 - update-index: move add_cacheinfo() to read-cache.c
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Needs review.


* ps/update-ref-multi-transaction (2020-11-16) 4 commits
  (merged to 'next' on 2020-11-30 at c1c3e23374)
 + update-ref: disallow "start" for ongoing transactions
 + p1400: use `git-update-ref --stdin` to test multiple transactions
 + update-ref: allow creation of multiple transactions
 + t1400: avoid touching refs on filesystem

 "git update-ref --stdin" learns to take multiple transactions in a
 single session.

 Will merge to 'master'.


* js/add-i-color-fix (2020-11-16) 11 commits
  (merged to 'next' on 2020-11-30 at 5cb8202cd4)
 + add -i: verify in the tests that colors can be overridden
 + add -p: prefer color.diff.context over color.diff.plain
 + add -i (Perl version): color header to match the C version
 + add -i (built-in): use the same indentation as the Perl version
 + add -p (built-in): do not color the progress indicator separately
 + add -i (built-in): use correct names to load color.diff.* config
 + add -i (built-in): prevent the `reset` "color" from being configured
 + add -i: use `reset_color` consistently
 + add -p (built-in): imitate `xdl_format_hunk_hdr()` generating hunk headers
 + add -i (built-in): send error messages to stderr
 + add -i (built-in): do show an error message for incorrect inputs

 "git add -i" failed to honor custom colors configured to show
 patches, which has been corrected.

 Will merge to 'master'.
 cf. <20201117015149.GC19433@coredump.intra.peff.net>


* js/trace2-session-id (2020-11-11) 11 commits
 - receive-pack: log received client session ID
 - send-pack: advertise session ID in capabilities
 - upload-pack, serve: log received client session ID
 - fetch-pack: advertise session ID in capabilities
 - transport: log received server session ID
 - serve: advertise session ID in v2 capabilities
 - receive-pack: advertise session ID in v0 capabilities
 - upload-pack: advertise session ID in v0 capabilities
 - trace2: add a public function for getting the SID
 - docs: new transfer.advertiseSID option
 - docs: new capability to advertise session IDs

 The transport layer was taught to optionally exchange the session
 ID assigned by the trace2 subsystem during fetch/push transactions.

 Will merge to 'next'.


* ds/maintenance-part-4 (2020-11-24) 4 commits
 - maintenance: use Windows scheduled tasks
 - maintenance: use launchctl on macOS
 - maintenance: include 'cron' details in docs
 - maintenance: extract platform-specific scheduling

 Follow-up on the "maintenance part-3" which introduced scheduled
 maintenance tasks to support platforms whose native scheduling
 methods are not 'cron'.


* sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 commit
 - diff: do not show submodule with untracked files as "-dirty"

 "git diff" showed a submodule working tree with untracked cruft as
 "Submodule commit <objectname>-dirty", but a natural expectation is
 that the "-dirty" indicator would align with "git describe --dirty",
 which does not consider having untracked files in the working tree
 as source of dirtiness.  The inconsistency has been fixed.

 Needs doc update and also adjusting "git status".


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

 Getting there.
 cf. <85y2jiqq3c.fsf@gmail.com>
 cf. <685afed6-f01f-5d22-80d4-00fdc11caf0a@gmail.com>
 cf. <20201103053629.GA13228@Abhishek-Arch>

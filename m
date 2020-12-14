Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37C9C2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5688C2247F
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502993AbgLNUFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:05:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54825 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502880AbgLNUFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 15:05:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2627010CEE5;
        Mon, 14 Dec 2020 15:04:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=G
        47/T/8DI6rL3fB7a6i4ze3eyBo=; b=u+Lcx5FYD4bUYZZrzW9BB8ZHbVCXM1UJp
        Bh9wqUFN5mq1B3o3PxLW3B1usXM969E5d/nMJhuA01TAnwO18gYTJIiZFJRC2QoA
        44QXvlLtKFKECmRMbUUbO+a9170pFPDgL6Kj7GHOjjap7pNxSd8kaDL8NAnfJhiA
        mkZ5icXfvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=OZu
        iir5RUdqyXYtxcUELygwXlYQXk7KKNQ1K1R0WL7cFejmrAEhR3mfJ+KzQ7v4QAkb
        bEZG44WCIVbEY1vmqYCnkQj/F6+i+78JI13ilaq65ms8OfC6g+5wSHFVsoMUf+lf
        P656abBVgBp51H/uKmeeAs8TDDfxZZx9gvb/r0oI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DEF710CEE4;
        Mon, 14 Dec 2020 15:04:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B99510CEE3;
        Mon, 14 Dec 2020 15:04:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2020, #02; Mon, 14)
X-master-at: 1c52ecf4ba0f4f7af72775695fee653f50737c71
X-next-at: 06539567b223ae3441fad75ce47b72db03708628
Date:   Mon, 14 Dec 2020 12:04:50 -0800
Message-ID: <xmqq3608duhp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A09E64F8-3E47-11EB-B2E4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A preview release 2.30-rc0 has been tagged; there are too many
topics in flight, sadly many of which haven't been adequately
reviewed.  I wish we had half the number of topics that had been
reviewed twice as better, but such is life.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

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

* ae/doc-reproducible-html (2020-12-02) 1 commit
  (merged to 'next' on 2020-12-08 at 263232f371)
 + doc: make HTML manual reproducible

 Newer versions of xsltproc can assign IDs in HTML documents it
 generates in a consistent manner.  Use the feature to help format
 HTML version of the user manual reproducibly.


* da/vs-build-iconv-fix (2020-12-04) 1 commit
  (merged to 'next' on 2020-12-08 at 4c6c5054a3)
 + ci(vs-build): stop passing the iconv library location explicitly

 Build update.


* dd/help-autocorrect-never (2020-11-25) 1 commit
  (merged to 'next' on 2020-12-08 at f1531ab641)
 + help.c: help.autocorrect=never means "do not compute suggestions"

 "git $cmd $args", when $cmd is not a recognised subcommand, by
 default tries to see if $cmd is a typo of an existing subcommand
 and optionally executes the corrected command if there is only one
 possibility, depending on the setting of help.autocorrect; the
 users can now disable the whole thing, including the cycles spent
 to find a likely typo, by setting the configuration variable to
 'never'.


* fc/atmark-in-refspec (2020-11-30) 3 commits
  (merged to 'next' on 2020-12-08 at bfded23c1c)
 + refspec: make @ a synonym of HEAD
 + tests: push: trivial cleanup
 + tests: push: improve cleanup of HEAD tests

 "@" sometimes worked (e.g. "git push origin @:there") as a part of
 a refspec element, but "git push origin @" did not work, which has
 been corrected.


* jk/check-config-parsing-error-in-upload-pack (2020-12-03) 1 commit
  (merged to 'next' on 2020-12-08 at b618c7d956)
 + upload-pack: propagate return value from object filter config callback

 Tighten error checking in the codepath that responds to "git fetch".


* jk/multi-line-indent-style-fix (2020-12-03) 1 commit
  (merged to 'next' on 2020-12-08 at e6d1026437)
 + style: indent multiline "if" conditions to align

 Style fix.


* js/cmake-extra-built-ins-fix (2020-12-04) 1 commit
  (merged to 'next' on 2020-12-08 at f29945cb35)
 + cmake: determine list of extra built-ins dynamically

 VSbuild fix.


* js/t5526-with-no-particular-primary-branch-name (2020-12-04) 2 commits
  (merged to 'next' on 2020-12-08 at b16af9417c)
 + t5526: drop the prereq expecting the default branch name `main`
 + t5526: avoid depending on a specific default branch name

 Test update.


* so/glossary-branch-is-not-necessarily-active (2020-12-02) 1 commit
  (merged to 'next' on 2020-12-08 at 01805f8ab6)
 + glossary: improve "branch" definition

 The glossary described a branch as an "active" line of development,
 which is misleading---a stale and non-moving branch is still a
 branch.

--------------------------------------------------
[New Topics]

* en/merge-ort-3 (2020-12-14) 11 commits
 - merge-ort: add implementation of type-changed rename handling
 - merge-ort: add implementation of normal rename handling
 - merge-ort: add implementation of rename/delete conflicts
 - merge-ort: add implementation of rename collisions
 - merge-ort: add implementation of both sides renaming differently
 - merge-ort: add implementation of both sides renaming identically
 - merge-ort: add basic outline for process_renames()
 - merge-ort: implement compare_pairs() and collect_renames()
 - merge-ort: implement detect_regular_renames()
 - merge-ort: add initial outline for basic rename detection
 - merge-ort: add basic data structures for handling renames
 (this branch uses en/merge-ort-2 and en/merge-ort-impl.)

 Rename detection is added to the "ORT" merge strategy.


* jk/disambiguate-equal-in-config-param (2020-12-09) 3 commits
 - config: store "git -c" variables using more robust format
 - config: parse more robust format in GIT_CONFIG_PARAMETERS
 - quote: make sq_dequote_step() a public function
 (this branch uses ps/config-env-pairs.)

 The quoting rules used to pass "git -c var=val" configuration
 across processes have been updated in a backward compatible way, so
 that the value read from an environment variable can contain an
 equal sign when using the "git --config-env var=env" feature.

 We may want to make this just a part of the ps/config-env-pairs
 topic with a bit of patch shuffling.


* js/t7900-protect-pwd-in-config-get (2020-12-09) 1 commit
  (merged to 'next' on 2020-12-14 at 61ff5e9b5b)
 + t7900: use --fixed-value in git-maintenance tests

 Hotfix for test breakage.

 Will merge to 'master'.


* bc/hashed-mailmap (2020-12-12) 1 commit
 - mailmap: support hashed entries in mailmaps

 The mailmap database learned to take hashed value as the original
 side of mapping.

 Expecting a reroll.


* jb/midx-doc-update (2020-12-14) 1 commit
  (merged to 'next' on 2020-12-14 at 880b50e89d)
 + docs: multi-pack-index: remove note about future 'verify' work

 Doc update.

 Will merge to 'next' and to 'master'.


* jh/index-v2-doc-on-fsmn (2020-12-14) 1 commit
  (merged to 'next' on 2020-12-14 at bd3507ccc8)
 + index-format.txt: document v2 format of file system monitor extension

 Doc update.

 Will merge to 'next' and to 'master'.

--------------------------------------------------
[Stalled]

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


* mt/grep-sparse-checkout (2020-12-06) 10 commits
 - t7817: do not depend on any specific default branch name
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


* mt/rm-sparse-checkout (2020-12-08) 1 commit
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

--------------------------------------------------
[Cooking]

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

 Expecting a reroll.


* bc/rev-parse-path-format (2020-12-12) 2 commits
 - rev-parse: add option for absolute or relative path formatting
 - abspath: add a function to resolve paths with missing components

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.


* en/merge-ort-impl (2020-12-13) 21 commits
 - merge-ort: free data structures in merge_finalize()
 - merge-ort: add implementation of record_conflicted_index_entries()
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
 (this branch is used by en/merge-ort-2 and en/merge-ort-3.)

 The merge backend "done right" starts to emerge.


* es/config-hooks (2020-12-07) 34 commits
 . run-command: stop thinking about hooks
 . receive-pack: convert receive hooks to hook.h
 . post-update: use hook.h library
 . proc-receive: acquire hook list from hook.h
 . receive-pack: convert 'update' hook to hook.h
 . reference-transaction: look for hooks in config
 . transport: convert pre-push hook to use config
 . hook: convert 'post-rewrite' hook to config
 . hooks: convert 'post-checkout' hook to hook library
 . git-p4: use 'git hook' to run hooks
 . receive-pack: convert push-to-checkout hook to hook.h
 . read-cache: convert post-index-change hook to use config
 . rebase: teach pre-rebase to use hook.h
 . gc: use hook library for pre-auto-gc hook
 . merge: use config-based hooks for post-merge hook
 . am: convert applypatch hooks to use config
 . commit: use config-based hooks
 . hooks: allow callers to capture output
 . run-command: allow capturing of collated output
 . hook: provide stdin by string_list or callback
 . run-command: add stdin callback for parallelization
 . hook: allow specifying working directory for hooks
 . hook: allow parallel hook execution
 . run-command: allow stdin for run_processes_parallel
 . hook: support passing stdin to hooks
 . hook: replace find_hook() with hook_exists()
 . hook: add 'run' subcommand
 . parse-options: parse into strvec
 . hook: implement hookcmd.<name>.skip
 . hook: respect hook.runHookDir
 . hook: include hookdir hook in list
 . hook: add list command
 . hook: scaffolding for git-hook subcommand
 . doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Ejected for now, as it has been breaking the tip of 'seen' for too
 long.


* hn/reftable (2020-12-09) 15 commits
 . Add "test-tool dump-reftable" command.
 . git-prompt: prepare for reftable refs backend
 . Reftable support for git-core
 . reftable: rest of library
 . reftable: reftable file level tests
 . reftable: read reftable files
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: add blocksource, an abstraction for random access reads
 . reftable: utility functions
 . reftable: add error related functionality
 . reftable: add LICENSE
 . init-db: set the_repository->hash_algo early on

 The "reftable" backend for the refs API.


* ab/mktag (2020-12-09) 11 commits
 - SQUASH???
 - mktag: allow turning off fsck.extraHeaderEntry
 - fsck: make fsck_config() re-usable
 - mktag doc: update to explain why to use this
 - mktag: use fsck instead of custom verify_tag()
 - mktag tests: improve verify_object() test coverage
 - mktag tests: remove needless SHA-1 hardcoding
 - mktag tests: don't needlessly use a subshell
 - mktag: remove redundant braces in one-line body "if"
 - mktag: use default strbuf_read() hint
 - mktag doc: say <hash> not <sha1>

 "git mktag" validates its input using its own rules before writing
 a tag object---it has been updated to share the logic with "git
 fsck".

 Expecting a reroll, but it seems getting closer.


* ab/trailers-extra-format (2020-12-09) 5 commits
  (merged to 'next' on 2020-12-14 at 9fc731944e)
 + pretty format %(trailers): add a "key_value_separator"
 + pretty format %(trailers): add a "keyonly"
 + pretty-format %(trailers): fix broken standalone "valueonly"
 + pretty format %(trailers) doc: avoid repetition
 + pretty format %(trailers) test: split a long line

 The "--format=%(trailers)" mechanism gets enhanced to make it
 easier to design output for machine consumption.

 Will cook in 'next'.


* en/diffcore-rename (2020-12-14) 9 commits
 - diffcore-rename: remove unneccessary duplicate entry checks
 - diffcore-rename: accelerate rename_dst setup
 - diffcore-rename: simplify and accelerate register_rename_src()
 - t4058: explore duplicate tree entry handling in a bit more detail
 - t4058: add more tests and documentation for duplicate tree entry handling
 - diffcore-rename: reduce jumpiness in progress counters
 - diffcore-rename: simplify limit check
 - diffcore-rename: avoid usage of global in too_many_rename_candidates()
 - diffcore-rename: rename num_create to num_destinations

 File-level rename detection updates.


* en/merge-ort-2 (2020-12-13) 7 commits
 - merge-ort: add modify/delete handling and delayed output processing
 - merge-ort: add die-not-implemented stub handle_content_merge() function
 - merge-ort: add function grouping comments
 - merge-ort: add a paths_to_free field to merge_options_internal
 - merge-ort: add a path_conflict field to merge_options_internal
 - merge-ort: add a clear_internal_opts helper
 - merge-ort: add a few includes
 (this branch is used by en/merge-ort-3; uses en/merge-ort-impl.)

 More "ORT" merge strategy.

 Looking good.
 cf. <2ea0aab8-934f-3eaa-e3d0-9ae35a278748@gmail.com>


* fc/pull-merge-rebase (2020-12-14) 5 commits
 - pull: display default warning only when non-ff
 - pull: correct condition to trigger non-ff advice
 - pull: get rid of unnecessary global variable
 - pull: give the advice for choosing rebase/merge much later
 - pull: refactor fast-forward check

 When a user does not tell "git pull" to use rebase or merge, the
 command gives a loud message telling a user to choose between
 rebase or merge but creates a merge anyway, forcing users who would
 want to rebase to redo the operation.  Fix an early part of this
 problem by tightening the condition to give the message---there is
 no reason to stop or force the user to choose between rebase or
 merge if the history fast-forwards.


* jk/oid-array-cleanup (2020-12-07) 9 commits
  (merged to 'next' on 2020-12-14 at 362f6f2618)
 + commit-graph: use size_t for array allocation and indexing
 + commit-graph: replace packed_oid_list with oid_array
 + commit-graph: drop count_distinct_commits() function
 + oid-array: provide a for-loop iterator
 + oid-array: make sort function public
 + cache.h: move hash/oid functions to hash.h
 + t0064: make duplicate tests more robust
 + t0064: drop sha1 mention from filename
 + oid-array.h: drop sha1 mention from header guard

 Code clean-up.

 Will merge to 'master'.


* js/t6300-hardcode-main (2020-12-07) 1 commit
  (merged to 'next' on 2020-12-14 at 4eed7c6a8b)
 + t6300: avoid using the default name of the initial branch

 Test update.

 Will merge to 'master'.


* js/t7064-master-to-initial (2020-12-08) 1 commit
  (merged to 'next' on 2020-12-14 at b75529f792)
 + t7064: avoid relying on a specific default branch name

 Test update.

 Will merge to 'master'.


* pk/subsub-fetch-fix-take-2 (2020-12-09) 1 commit
  (merged to 'next' on 2020-12-14 at ccc01a5f66)
 + submodules: fix of regression on fetching of non-init subsub-repo

 "git fetch --recurse-submodules" fix (second attempt).

 Will cook in 'next'.


* rj/make-clean (2020-12-08) 5 commits
  (merged to 'next' on 2020-12-14 at 767b1398d7)
 + Makefile: don't use a versioned temp distribution directory
 + Makefile: don't try to clean old debian build product
 + gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
 + Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
 + Documentation/Makefile: conditionally include doc.dep

 Build optimization.

 Will merge to 'master'.


* tb/partial-clone-filters-fix (2020-12-03) 2 commits
  (merged to 'next' on 2020-12-14 at d44e5942da)
 + upload-pack.c: don't free allowed_filters util pointers
 + builtin/clone.c: don't ignore transport_fetch_refs() errors

 Fix potential server side resource deallocation issues when
 responding to a partial clone request.

 Will merge to 'master'.


* en/stash-apply-sparse-checkout (2020-12-01) 3 commits
 - stash: fix stash application in sparse-checkouts
 - stash: remove unnecessary process forking
 - t7012: add a testcase demonstrating stash apply bugs in sparse checkouts

 "git stash" did not work well in a sparsely checked out working
 tree.


* js/init-defaultbranch-advice (2020-12-13) 4 commits
 - init: provide useful advice about init.defaultBranch
 - get_default_branch_name(): prepare for showing some advice
 - branch -m: allow renaming a yet-unborn branch
 - init: document `init.defaultBranch` better

 Our users are going to be trained to prepare for future change of
 init.defaultBranch configuration variable.


* ps/config-env-pairs (2020-12-09) 6 commits
 - config: allow specifying config entries via envvar pairs
 - config: refactor parsing of GIT_CONFIG_PARAMETERS
 - config: extract function to parse config pairs
 - environment: make `getenv_safe()` non-static
 - config: add new way to pass config via `--config-env`
 - git: add `--super-prefix` to usage string
 (this branch is used by jk/disambiguate-equal-in-config-param.)

 Introduce two new ways to feed configuration variable-value pairs
 via environment variables.


* tb/pack-bitmap (2020-12-08) 24 commits
 - pack-bitmap-write: better reuse bitmaps
 - pack-bitmap-write: relax unique revwalk condition
 - pack-bitmap-write: use existing bitmaps
 - pack-bitmap: factor out 'add_commit_to_bitmap()'
 - pack-bitmap: factor out 'bitmap_for_commit()'
 - pack-bitmap-write: ignore BITMAP_FLAG_REUSE
 - pack-bitmap-write: build fewer intermediate bitmaps
 - pack-bitmap.c: check reads more aggressively when loading
 - pack-bitmap-write: rename children to reverse_edges
 - t5310: add branch-based checks
 - commit: implement commit_list_contains()
 - bitmap: implement bitmap_is_subset()
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
 - ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()

 Various improvement to the codepath that writes out pack bitmaps.

 Will merge to 'next'.


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


* ds/maintenance-part-4 (2020-12-09) 6 commits
 - t7900: make macOS-specific test work on Windows
 - t7900: fix test failures when invoked individually via --run
 - maintenance: use Windows scheduled tasks
 - maintenance: use launchctl on macOS
 - maintenance: include 'cron' details in docs
 - maintenance: extract platform-specific scheduling

 Follow-up on the "maintenance part-3" which introduced scheduled
 maintenance tasks to support platforms whose native scheduling
 methods are not 'cron'.


* sj/untracked-files-in-submodule-directory-is-not-dirty (2020-12-08) 1 commit
 - diff: do not show submodule with untracked files as "-dirty"

 "git diff" showed a submodule working tree with untracked cruft as
 "Submodule commit <objectname>-dirty", but a natural expectation is
 that the "-dirty" indicator would align with "git describe --dirty",
 which does not consider having untracked files in the working tree
 as source of dirtiness.  The inconsistency has been fixed.

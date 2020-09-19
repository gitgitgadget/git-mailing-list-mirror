Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC0C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3B220DD4
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 01:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="em2a7hBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgISBle (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 21:41:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58267 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISBle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 21:41:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 983076B498;
        Fri, 18 Sep 2020 21:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=t
        keH0RjhxxunSD+AODxjPOmaN/0=; b=em2a7hBwYYjLt9k32tRQdBd8xsUiiT9ET
        4CucaE1TlNTJ5XFGW4lmcaFl2wuleNqdczZbJfiaZhOsta7TJ6ulxsjbxlUt8Su8
        zF92GCk652Cjeq1K3G5SeqM5cXxYsQ29jea1ukhuOoLalM0MnYu7vlfHLh6z94As
        /qfd37FOrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=TZ1
        ZIWDtddVTx6/VO+DySjAYexyuilxjNdHJ8i6toUplxgZQukz9RTB+jctnMT0uptq
        e3xfa5P4N+PPrAyhKFxUqoYMlXXSkABWwppJoJcPC7F7YlYePPMkZ5tY5UM4zVTm
        AJGJqarlpz5BAiwceMBvWPgRWs09quWh7b7lzOe8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F7A96B497;
        Fri, 18 Sep 2020 21:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF58F6B496;
        Fri, 18 Sep 2020 21:41:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2020, #05; Fri, 18)
X-master-at: 385c171a018f2747b329bcfa6be8eda1709e5abd
X-next-at: 8d73e042082d7476596b06e00a6c3d1828fa6b49
Date:   Fri, 18 Sep 2020 18:41:23 -0700
Message-ID: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39C67DE6-FA19-11EA-B324-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* al/t3200-back-on-a-branch (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at 833e2fc60c)
 + t3200: clean side effect of git checkout --orphan

 Test fix.


* ea/blame-use-oideq (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at babefe4727)
 + blame.c: replace instance of !oidcmp for oideq

 Code cleanup.


* es/wt-add-detach (2020-09-06) 3 commits
  (merged to 'next' on 2020-09-10 at abd83f90e7)
 + git-worktree.txt: discuss branch-based vs. throwaway worktrees
 + worktree: teach `add` to recognize -d as shorthand for --detach
 + git-checkout.txt: document -d short option for --detach

 "git worktree add" learns that the "-d" is a synonym to "--detach"
 option to create a new worktree without being on a branch.


* hn/refs-ref-log-only-bit (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at f729cb2c81)
 + refs: move REF_LOG_ONLY to refs-internal.h

 A bit of API reshuffling to make sure stuff common to all backends
 are not defined only in files backend.


* jc/add-i-use-builtin-experimental (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at abcb7515dc)
 + add -i: use the built-in version when feature.experimental is set

 The "add -i/-p" machinery has been written in C but it is not used
 by default yet.  It is made default to those who are participating
 in feature.experimental experiment.


* jc/dist-tarball-tweak (2020-09-09) 1 commit
  (merged to 'next' on 2020-09-10 at 36cbe7ee9e)
 + Makefile: allow extra tweaking of distribution tarball

 Allow maintainers to tweak $(TAR) invocations done while making
 distribution tarballs.


* jc/quote-path-cleanup (2020-09-10) 7 commits
  (merged to 'next' on 2020-09-10 at 3bfde81846)
 + quote: turn 'nodq' parameter into a set of flags
 + quote: rename misnamed sq_lookup[] to cq_lookup[]
 + wt-status: consistently quote paths in "status --short" output
 + quote_path: code clarification
 + quote_path: optionally allow quoting a path with SP in it
 + quote_path: give flags parameter to quote_path()
 + quote_path: rename quote_path_relative() to quote_path()

 "git status --short" quoted a path with SP in it when tracked, but
 not those that are untracked, ignored or unmerged.  They are all
 shown quoted consistently.


* jk/add-i-fixes (2020-09-08) 2 commits
  (merged to 'next' on 2020-09-09 at 46ea071a7a)
 + add--interactive.perl: specify --no-color explicitly
 + add-patch: fix inverted return code of repo_read_index()

 "add -i/-p" fixes.


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
  (merged to 'next' on 2020-09-10 at 7853fe7e12)
 + submodule: use submodule repository when preparing summary
 + revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.
 cf. <xmqqzh667ca4.fsf@gitster.c.googlers.com>


* mt/config-fail-nongit-early (2020-09-09) 1 commit
  (merged to 'next' on 2020-09-10 at 6f77f65b4e)
 + config: complain about --worktree outside of a git repo

 Unlike "git config --local", "git config --worktree" did not fail
 early and cleanly when started outside a git repository.


* os/collect-changed-submodules-optim (2020-09-06) 1 commit
  (merged to 'next' on 2020-09-10 at b6d9ed060e)
 + submodule: suppress checking for file name and ref ambiguity for object ids

 Optimization around submodule handling.


* pb/clang-json-compilation-database (2020-09-06) 1 commit
  (merged to 'next' on 2020-09-09 at 9f5ea136f1)
 + Makefile: add support for generating JSON compilation database

 Developer support.


* pw/add-p-leakfix (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at 4206d0503c)
 + add -p: fix memory leak

 Leakfix.


* rs/misc-cleanups (2020-09-06) 3 commits
  (merged to 'next' on 2020-09-09 at 4a19ea9672)
 + pack-bitmap-write: use hashwrite_be32() in write_hash_cache()
 + midx: use hashwrite_u8() in write_midx_header()
 + fast-import: use write_pack_header()

 Misc cleanups.


* rs/parallel-read-cache-fix (2020-09-06) 1 commit
  (merged to 'next' on 2020-09-09 at 92953a75c4)
 + read-cache: fix mem-pool allocation for multi-threaded index loading

 A follow-up fix to a topic already in 'master'.


* rs/refspec-leakfix (2020-09-06) 2 commits
  (merged to 'next' on 2020-09-09 at 10741e90a5)
 + refspec: add and use refspec_appendf()
 + push: release strbufs used for refspec formatting

 Leakfix.


* so/log-tree-diff-cleanup (2020-09-06) 2 commits
  (merged to 'next' on 2020-09-09 at f8744b8e8a)
 + log_tree_diff: get rid of extra check for NULL
 + log_tree_diff: get rid of code duplication for first_parent_only

 Code cleanup.

--------------------------------------------------
[New Topics]

* cs/don-t-pretend-a-failed-remote-set-head-succeeded (2020-09-17) 1 commit
  (merged to 'next' on 2020-09-18 at 51f73ca6dc)
 + remote: don't show success message when set-head fails

 "git remote set-head" that failed still said something that hints
 the operation went through, which was misleading.

 Will merge to 'master'.


* dl/diff-merge-base (2020-09-17) 10 commits
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

 Expecting a reroll.
 cf. <20200917181303.GA108156@coredump.intra.peff.net>,
 <xmqqh7rws5hm.fsf@gitster.c.googlers.com>, etc.


* jk/dont-count-existing-objects-twice (2020-09-17) 1 commit
  (merged to 'next' on 2020-09-18 at 73b30558b9)
 + packfile: actually set approximate_object_count_valid

 There is a logic to estimate how many objects are in the
 repository, which is mean to run once per process invocation, but
 it ran every time the estimated value was requested.

 Will merge to 'master'.


* dl/complete-format-patch-recent-features (2020-09-17) 1 commit
  (merged to 'next' on 2020-09-18 at c0ec1f7569)
 + contrib/completion: complete options that take refs for format-patch

 Update to command line completion (in contrib/)

 Will merge to 'master'.


* js/ignore-cmake-build-artifacts (2020-09-17) 1 commit
 - cmake: ignore generated files

 Running CMake based build with VS (in contrib/) from the top-level
 of the working tree leaves extra build crufts behind.  Add patterns
 to .gitignore

 Expecting a resolution in a better way.
 cf. <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
 It turns out that these crufts are visible only when the CMake
 based build procedure is used against the best practice.  A better
 alternative may be to prominently describe the recommended way to
 use the CMake-based build procedure.


* hx/push-atomic-with-cert (2020-09-18) 1 commit
 - send-pack: run GPG after atomic push checking

 "git push" that wants to be atomic and wants to send push
 certificate learned not to prepare and sign the push certificate
 when it fails the local check (hence due to atomicity it is known
 that no certificate is needed).

 Expecting a reroll.
 cf. <xmqqft7eljkz.fsf@gitster.c.googlers.com>

--------------------------------------------------
[Stalled]

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

* kk/build-portability-fix (2020-09-09) 1 commit
  (merged to 'next' on 2020-09-16 at 63f2672632)
 + Fit to Plan 9's ANSI/POSIX compatibility layer

 Portability tweak for some shell scripts used while building.

 Will merge to 'master'.


* al/ref-filter-merged-and-no-merged (2020-09-18) 5 commits
  (merged to 'next' on 2020-09-18 at cc2a0039f3)
 + Doc: prefer more specific file name
 + ref-filter: make internal reachable-filter API more precise
  (merged to 'next' on 2020-09-16 at b04e306660)
 + ref-filter: allow merged and no-merged filters
 + Doc: cover multiple contains/no-contains filters
 + t3201: test multiple branch filter combinations

 "git for-each-ref" and friends that list refs used to allow only
 one --merged or --no-merged to filter them; they learned to take
 combination of both kind of filtering.

 Will merge to 'master'.


* bc/faq-misc (2020-09-14) 3 commits
 - docs: explain how to deal with files that are always modified
 - docs: explain why reverts are not always applied on merge
 - docs: explain why squash merges are broken with long-running branches

 More FAQ entries.

 Expecting a reroll.
 cf. <20200913171206.GO241078@camp.crustytoothpaste.net>


* sb/clone-origin (2020-09-11) 4 commits
 - clone: allow configurable default for `-o`/`--origin`
 - clone: validate --origin option before use
 - clone: call git_config before parse_options
 - clone: add tests for --template and some disallowed option pairs

 "git clone" learned clone.defaultremotename configuration variable
 to customize what nickname to use to call the remote the repository
 was cloned from.

 Expecting an update.


* sk/force-if-includes (2020-09-14) 8 commits
 - SQUASH???
 - t: add tests for "force-if-includes"
 - doc: add reference for "--[no-]force-if-includes"
 - builtin/push: add option "--[no-]force-if-includes"
 - transport-helper: update ref status for "force-if-includes"
 - send-pack: check ref status for "force-if-includes"
 - transport: add flag for "--[no-]force-if-includes"
 - remote: add reflog check for "force-if-includes"


* ab/mediawiki-fixes (2020-09-16) 15 commits
 - remote-mediawiki tests: annotate failing tests
 - remote-mediawiki: fix duplicate revisions being imported
 - remote-mediawiki tests: use CLI installer
 - remote-mediawiki tests: use inline PerlIO for readability
 - remote-mediawiki tests: replace deprecated Perl construct
 - remote-mediawiki tests: use a more idiomatic dispatch table
 - remote-mediawiki tests: use "$dir/" instead of "$dir."
 - remote-mediawiki tests: change `[]` to `test`
 - remote-mediawiki tests: guard test_cmp with test_path_is_file
 - remote-mediawiki tests: use test_cmp in tests
 - remote-mediawiki tests: use a 10 character password
 - remote-mediawiki tests: use the login/password variables
 - remote-mediawiki doc: bump recommended PHP version to 7.3
 - remote-mediawiki doc: link to MediaWiki's current version
 - remote-mediawiki doc: correct link to GitHub project

 Modernization and fixes to MediaWiki remote backend.

 Expecting a reroll.


* ar/fetch-ipversion-in-all (2020-09-15) 1 commit
 - fetch: pass --ipv4 and --ipv6 options to sub-fetches

 "git fetch --all --ipv4/--ipv6" forgot to pass the protocol options
 to instances of the "git fetch" that talk to individual remotes,
 which has been corrected.

 Will merge to 'next'.


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* bc/clone-with-git-default-hash-fix (2020-09-15) 1 commit
 - builtin/clone: avoid failure with GIT_DEFAULT_HASH

 "git clone" that clones from SHA-1 repository, while
 GIT_DEFAULT_HASH set to use SHA-256 already, resulted in an
 unusable repository that half-claims to be SHA-256 repository
 with SHA-1 objects and refs.  This has been corrected.

 Expecting a reroll.


* cd/commit-graph-doc (2020-09-15) 1 commit
  (merged to 'next' on 2020-09-16 at b0816b6eb0)
 + commit-graph-format.txt: fix no-parent value

 Doc update.

 Will merge to 'master'.


* hn/reftable (2020-09-16) 13 commits
 - reftable: "test-tool dump-reftable" command.
 - reftable: rest of library
 - reftable: file level tests
 - reftable: read reftable files
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: utility functions
 - reftable: add a barebones unittest framework
 - vcxproj: adjust for the reftable changes
 - reftable: define the public API
 - reftable: add LICENSE


* bc/rev-parse-path-format (2020-09-08) 1 commit
 - rev-parse: add option for absolute or relative path formatting

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.


* ds/maintenance-part-3 (2020-09-17) 7 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: recommended schedule in register/start
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch uses ds/maintenance-part-1 and ds/maintenance-part-2.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.


* es/format-patch-interdiff-cleanup (2020-09-08) 3 commits
  (merged to 'next' on 2020-09-16 at d919bb3d1f)
 + format-patch: use 'origin' as start of current-series-range when known
 + diff-lib: tighten show_interdiff()'s interface
 + diff: move show_interdiff() from its own file to diff-lib

 Code cleanup and teach "format-patch --range-diff=<prev>
 <origin>..HEAD" not ignore <origin> when <prev> is a single
 version.

 Will merge to 'master'.


* os/fetch-submodule-optim (2020-09-06) 1 commit
  (merged to 'next' on 2020-09-16 at fa39e3f211)
 + fetch: do not look for submodule changes in unchanged refs

 Optimization around submodule handling.

 Will merge to 'master'.


* pw/add-p-edit-ita-path (2020-09-09) 1 commit
  (merged to 'next' on 2020-09-16 at 7540ed3c0e)
 + add -p: fix editing of intent-to-add paths

 "add -p" did not allow editing paths that were only added in
 intent.

 Will merge to 'master'.


* hn/refs-trace-backend (2020-09-09) 1 commit
  (merged to 'next' on 2020-09-16 at f2e065ec17)
 + refs: add GIT_TRACE_REFS debugging mechanism

 Developer support.

 Will merge to 'master'.


* tb/bloom-improvements (2020-09-18) 13 commits
 - commit-graph: introduce 'commitGraph.maxNewFilters'
 - builtin/commit-graph.c: introduce '--max-new-filters=<n>'
 - commit-graph: rename 'split_commit_graph_opts'
 - bloom: encode out-of-bounds filters as non-empty
 - bloom/diff: properly short-circuit on max_changes
 - bloom: use provided 'struct bloom_filter_settings'
 - bloom: split 'get_bloom_filter()' in two
 - commit-graph.c: store maximum changed paths
 - commit-graph: respect 'commitGraph.readChangedPaths'
 - t/helper/test-read-graph.c: prepare repo settings
 - commit-graph: pass a 'struct repository *' in more places
 - t4216: use an '&&'-chain
 - commit-graph: introduce 'get_bloom_filter_settings()'

 "git commit-graph write" learned to limit the number of bloom
 filters that are computed from scratch with the --max-new-filters
 option.

 Will merge to 'next'.


* es/config-hooks (2020-09-09) 9 commits
 - run_commit_hook: take strvec instead of varargs
 - commit: use config-based hooks
 - hook: replace run-command.h:find_hook
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.


* ls/mergetool-meld-auto-merge (2020-09-16) 1 commit
  (merged to 'next' on 2020-09-16 at 01985a671b)
 + mergetool: allow auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Will merge to 'master'.


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


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* mr/bisect-in-c-2 (2020-08-31) 13 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 - bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the "git bisect" script in C continues.

 At v7; getting close
 cf. <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>


* js/no-builtins-on-disk-option (2020-08-24) 3 commits
 - ci: stop linking built-ins to the dashed versions
 - install: optionally skip linking/copying the built-ins
 - msvc: copy the correct `.pdb` files in the Makefile target `install`

 The installation procedure learned to optionally omit "git-foo"
 executable files for each 'foo' built-in subcommand, which are only
 required by old timers that still rely on the age old promise that
 prepending "git --exec-path" output to PATH early in their script
 will keep the "git-foo" calls they wrote working.

 The old attempt to remove these executables from the disk failed in
 the 1.6 era; it may be worth attempting again, but I think it is
 worth to keep this topic separate from such a policy change to help
 it graduate early.

 Expecting a reroll to update log message for the last one.
 as it confused at least two reviewers.
 cf. <xmqqwo1baop3.fsf@gitster.c.googlers.com>
 cf. <20200903104537.GA27325@szeder.dev>


* jt/threaded-index-pack (2020-09-08) 7 commits
  (merged to 'next' on 2020-09-16 at 8542385cc0)
 + index-pack: make quantum of work smaller
 + index-pack: make resolve_delta() assume base data
 + index-pack: calculate {ref,ofs}_{first,last} early
 + index-pack: remove redundant child field
 + index-pack: unify threaded and unthreaded code
 + index-pack: remove redundant parameter
 + Documentation: deltaBaseCacheLimit is per-thread

 "git index-pack" learned to resolve deltified objects with greater
 parallelism.

 Will merge to 'master'.


* jk/refspecs-negative (2020-09-18) 2 commits
 - SQUASH???
 - refspec: add support for negative refspecs

 "negative refspecs"

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.2008221528170.56@tvgsbejvaqbjf.bet>
 cf. <xmqqzh5onea1.fsf@gitster.c.googlers.com>


* jx/proc-receive-hook (2020-08-27) 10 commits
  (merged to 'next' on 2020-09-18 at 344c89be7e)
 + doc: add documentation for the proc-receive hook
 + transport: parse report options for tracking refs
 + t5411: test updates of remote-tracking branches
 + receive-pack: new config receive.procReceiveRefs
 + doc: add document for capability report-status-v2
 + New capability "report-status-v2" for git-push
 + receive-pack: feed report options to post-receive
 + receive-pack: add new proc-receive hook
 + t5411: add basic test cases for proc-receive hook
 + transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Will merge to 'master'.


* ds/maintenance-part-2 (2020-09-17) 8 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 (this branch is used by ds/maintenance-part-3; uses ds/maintenance-part-1.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.


* ds/maintenance-part-1 (2020-09-17) 11 commits
  (merged to 'next' on 2020-09-18 at 4c367d3cf6)
 + maintenance: add trace2 regions for task execution
 + maintenance: add auto condition for commit-graph task
 + maintenance: use pointers to check --auto
 + maintenance: create maintenance.<task>.enabled config
 + maintenance: take a lock on the objects directory
 + maintenance: add --task option
 + maintenance: add commit-graph task
 + maintenance: initialize task array
 + maintenance: replace run_auto_gc()
 + maintenance: add --quiet option
 + maintenance: create basic maintenance runner
 (this branch is used by ds/maintenance-part-2 and ds/maintenance-part-3.)

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.

 Will merge to 'master'.

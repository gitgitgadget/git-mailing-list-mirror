Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D5C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFD921775
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aFS0kUla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgIYW5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:57:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54854 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIYW5T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 18:57:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BC667303C;
        Fri, 25 Sep 2020 18:57:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=O
        ZWJWsLO375q+oVtlZbo1gUsXoM=; b=aFS0kUla7hSOG9KR1xQTIjzlgljzYfqSy
        RzUHSymjU2Y61bRXwW45agrjFAcIPjLBxYJ9OHvYofsCcPeYfFPH6amVAESKGkbv
        P2EFQ8Bkpz8ZNINERuio9C6nCu/cSPX6PooCA6O3JbLLbMlgLvwknVX3lS2ibhLe
        C3JvFTQCjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=P9L
        GsLaNCdAPwPMQ7/JXaQoCdMeJTBg63wtKCRAvtX7CJ48HUnbok9UnfEqys+prRRZ
        1nj1BHPNbISF9hWlK6kSXGO4qgJTHfn9rj+98yoIS9VFOqonhu1JNdaOfVMjX7jC
        vz3lsDmhMV5oTqJq38xbUkUrImSugD07U+vJ+9RE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80EBA7303A;
        Fri, 25 Sep 2020 18:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F27773033;
        Fri, 25 Sep 2020 18:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2020, #07; Fri, 25)
X-master-at: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
X-next-at: 665beee440013dbe19c071d4645a0311b5a18ec2
Date:   Fri, 25 Sep 2020 15:57:01 -0700
Message-ID: <xmqq3635jwhu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D8256DC-FF82-11EA-8A7F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
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


* hx/push-atomic-with-cert (2020-09-19) 1 commit
  (merged to 'next' on 2020-09-22 at 64561eea5b)
 + send-pack: run GPG after atomic push checking

 "git push" that wants to be atomic and wants to send push
 certificate learned not to prepare and sign the push certificate
 when it fails the local check (hence due to atomicity it is known
 that no certificate is needed).


* jk/diff-highlight-blank-match-fix (2020-09-21) 1 commit
  (merged to 'next' on 2020-09-22 at 03ac708501)
 + diff-highlight: correctly match blank lines for flush

 "diff-highlight" (in contrib/) had a logic to flush its output upon
 seeing a blank line but the way it detected a blank line was broken.


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


* ld/p4-unshelve-fix (2020-09-19) 2 commits
  (merged to 'next' on 2020-09-22 at c7709a34ec)
 + git-p4: use HEAD~$n to find parent commit for unshelve
 + git-p4 unshelve: adding a commit breaks git-p4 unshelve

 The "unshelve" subcommand of "git p4" used incorrectly used
 commit^N where it meant to say commit~N to name the Nth generation
 ancestor, which has been corrected.


* rs/misc-cleanups (2020-09-19) 1 commit
  (merged to 'next' on 2020-09-22 at d034fbfab0)
 + pack-write: use hashwrite_be32() in write_idx_file()

 Code cleanup.

--------------------------------------------------
[New Topics]

* cc/bisect-start-fix (2020-09-25) 1 commit
 - bisect: don't use invalid oid as rev when starting

 "git bisect start X Y", when X and Y are not valid committish
 object names, should take X and Y as pathspec, but didn't.

 Will merge to 'next'.


* dl/zero-oid-in-hooks (2020-09-23) 3 commits
  (merged to 'next' on 2020-09-25 at 3c7d03d61a)
 + hooks--update.sample: use hash-agnostic zero OID
 + hooks--pre-push.sample: use hash-agnostic zero OID
 + hooks--pre-push.sample: modernize script

 Adjust sample hooks for hash algorithm other than SHA-1.

 Will merge to 'master'.


* mt/parallel-checkout-part-1 (2020-09-22) 19 commits
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


* jk/drop-unaligned-loads (2020-09-24) 2 commits
 - Revert "fast-export: use local array to store anonymized oid"
 - bswap.h: drop unaligned loads

 Compilation fix around type punning.

 Will merge to 'next'.


* tg/range-diff-same-file-fix (2020-09-24) 1 commit
  (merged to 'next' on 2020-09-25 at c2078e5505)
 + diff: fix modified lines stats with --stat and --numstat

 "git range-diff" showed incorrect diffstat, which has been
 corrected.

 Will merge to 'master'.


* ah/pull (2020-09-24) 1 commit
  (merged to 'next' on 2020-09-25 at b5ddf0cf8b)
 + pull: don't warn if pull.ff has been set

 Earlier we taught "git pull" to warn when the user does not say the
 histories need to be merged, rebased or accepts only fast-
 forwarding, but the warning triggered for those who have set the
 pull.ff configuration variable.

 Will merge to 'master'.


* jc/blame-ignore-fix (2020-09-24) 2 commits
 - blame: validate and peel the object names on the ignore list
 - t8013: minimum preparatory clean-up

 "git blame --ignore-rev/--ignore-revs-file" failed to validate
 their input are valid revision, and failed to take into account
 that the user may want to give an annotated tag instead of a
 commit, which has been corrected.

 Will merge to 'next'.


* jk/make-protocol-v2-the-default (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-25 at 21a5f9e880)
 + protocol: re-enable v2 protocol by default

 The transport protocol v2 has become the default again.

 Will merge to 'master'.


* jk/shortlog-group-by-trailer (2020-09-25) 8 commits
 - shortlog: allow multiple groups to be specified
 - shortlog: parse trailer idents
 - shortlog: rename parse_stdin_ident()
 - shortlog: de-duplicate trailer values
 - shortlog: match commit trailers with --group
 - trailer: add interface for iterating over commit trailers
 - shortlog: refactor committer/author grouping
 - shortlog: change "author" variables to "ident"

 "git shortlog" has been taught to group commits by the contents of
 the trailer lines, like "Reviewed-by:", "Coauthored-by:", etc.

 Will merge to 'next'.


* js/cmake-vs (2020-09-25) 10 commits
 - hashmap_for_each_entry(): work around MSVC's run-time check failure #3
 - cmake (Windows): recommend using Visual Studio's built-in CMake support
 - cmake (Windows): initialize vcpkg/build dependencies automatically
 - cmake (Windows): complain when encountering an unknown compiler
 - cmake (Windows): let the `.dll` files are found when running the tests
 - cmake: quote the path accurately when editing `test-lib.sh`
 - cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
 - cmake: ensure that the `vcpkg` packages are found on Windows
 - cmake: do find Git for Windows' shell interpreter
 - cmake: ignore files generated by CMake as run in Visual Studio

 Using the CMake support we added some time ago for real with Visual
 Studio build revealed there were lot of usability improvements
 possible, which have been carried out.

 Expecting a reroll.
 cf. <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com>
 cf. <CAPig+cTPi1yi7WQf_eWa+bFRJEdtULFO3yYqJh3nm=_CtEe6CQ@mail.gmail.com>
 cf. <xmqq8scxln10.fsf@gitster.c.googlers.com>


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


* jc/sequencer-stopped-sha-simplify (2020-09-25) 1 commit
 - sequencer: stop abbreviating stopped-sha file


* jc/t1506-rev-parse-leaves-range-endpoint-unpeeled (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-25 at e5233774ba)
 + t1506: rev-parse A..B and A...B

 Test update.

 Will merge to 'master'.


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

* rs/archive-add-file (2020-09-19) 3 commits
 - Makefile: use git-archive --add-file
 - archive: add --add-file
 - archive: read short blobs in archive.c::write_archive_entry()

 "git archive" learns the "--add-file" option to include untracked
 files into a snapshot from a tree-ish.


* js/default-branch-name-part-2 (2020-09-21) 5 commits
 - t9902: avoid using the branch name `master`
 - tests: avoid variations of the `master` branch name
 - t3200: avoid variations of the `master` branch name
 - fast-export: avoid using unnecessary language in a code comment
 - t/test-terminal: avoid non-inclusive language

 Update the tests to drop word 'master' from them


* jt/keep-partial-clone-filter-upon-lazy-fetch (2020-09-21) 2 commits
 - fetch: do not override partial clone filter
 - promisor-remote: remove unused variable

 The lazy fetching done internally to make missing objects available
 in a partial clone incorrectly made permanent damate to the partial
 clone filter in the repository, which has been corrected.


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

 Expecting a reroll.
 cf. <xmqqblhyepup.fsf@gitster.c.googlers.com>


* bc/faq-misc (2020-09-20) 3 commits
  (merged to 'next' on 2020-09-22 at a81b728010)
 + docs: explain how to deal with files that are always modified
 + docs: explain why reverts are not always applied on merge
 + docs: explain why squash merges are broken with long-running branches

 More FAQ entries.

 Will merge to 'master'.


* sb/clone-origin (2020-09-11) 4 commits
 - clone: allow configurable default for `-o`/`--origin`
 - clone: validate --origin option before use
 - clone: call git_config before parse_options
 - clone: add tests for --template and some disallowed option pairs

 "git clone" learned clone.defaultremotename configuration variable
 to customize what nickname to use to call the remote the repository
 was cloned from.

 Expecting an update.


* sk/force-if-includes (2020-09-23) 3 commits
 - t, doc: update tests, reference for "--force-if-includes"
 - push: parse and set flag for "--force-if-includes"
 - push: add reflog check for "--force-if-includes"

 "git push --force-with-lease[=<ref>]" can easily be misused to lose
 commits unless the user takes good care of their own "git fetch".
 A new option "--force-if-includes" attempts to ensure that what is
 being force-pushed was created after examining the commit at the
 tip of the remote ref that is about to be force-replaced.

 Expecting a reroll.
 cf. <20200923112606.GA71705@mail.clickyotomy.dev>


* ab/mediawiki-fixes (2020-09-21) 18 commits
  (merged to 'next' on 2020-09-25 at 878693716e)
 + remote-mediawiki: use "sh" to eliminate unquoted commands
 + remote-mediawiki: annotate unquoted uses of run_git()
 + remote-mediawiki: convert to quoted run_git() invocation
 + remote-mediawiki: provide a list form of run_git()
 + remote-mediawiki tests: annotate failing tests
 + remote-mediawiki: fix duplicate revisions being imported
 + remote-mediawiki tests: use CLI installer
 + remote-mediawiki tests: use inline PerlIO for readability
 + remote-mediawiki tests: replace deprecated Perl construct
 + remote-mediawiki tests: use a more idiomatic dispatch table
 + remote-mediawiki tests: use "$dir/" instead of "$dir."
 + remote-mediawiki tests: change `[]` to `test`
 + remote-mediawiki tests: use test_cmp in tests
 + remote-mediawiki tests: use a 10 character password
 + remote-mediawiki tests: use the login/password variables
 + remote-mediawiki doc: don't hardcode Debian PHP versions
 + remote-mediawiki doc: link to MediaWiki's current version
 + remote-mediawiki doc: correct link to GitHub project

 Modernization and fixes to MediaWiki remote backend.

 Will merge to 'master'.


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* bc/clone-with-git-default-hash-fix (2020-09-22) 1 commit
  (merged to 'next' on 2020-09-22 at 62ea45c20e)
 + builtin/clone: avoid failure with GIT_DEFAULT_HASH

 "git clone" that clones from SHA-1 repository, while
 GIT_DEFAULT_HASH set to use SHA-256 already, resulted in an
 unusable repository that half-claims to be SHA-256 repository
 with SHA-1 objects and refs.  This has been corrected.

 Will merge to 'master'.


* hn/reftable (2020-09-22) 14 commits
 - reftable: fix some sparse warnings
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

 Expecting a reroll.
 cf. <20200909222333.GH241078@camp.crustytoothpaste.net>


* ds/maintenance-part-3 (2020-09-25) 7 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: recommended schedule in register/start
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch uses ds/maintenance-part-2.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.


* tb/bloom-improvements (2020-09-18) 13 commits
  (merged to 'next' on 2020-09-22 at 520d531ad8)
 + commit-graph: introduce 'commitGraph.maxNewFilters'
 + builtin/commit-graph.c: introduce '--max-new-filters=<n>'
 + commit-graph: rename 'split_commit_graph_opts'
 + bloom: encode out-of-bounds filters as non-empty
 + bloom/diff: properly short-circuit on max_changes
 + bloom: use provided 'struct bloom_filter_settings'
 + bloom: split 'get_bloom_filter()' in two
 + commit-graph.c: store maximum changed paths
 + commit-graph: respect 'commitGraph.readChangedPaths'
 + t/helper/test-read-graph.c: prepare repo settings
 + commit-graph: pass a 'struct repository *' in more places
 + t4216: use an '&&'-chain
 + commit-graph: introduce 'get_bloom_filter_settings()'

 "git commit-graph write" learned to limit the number of bloom
 filters that are computed from scratch with the --max-new-filters
 option.

 Will merge to 'master'.


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


* mr/bisect-in-c-2 (2020-09-24) 6 commits
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 - bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the "git bisect" script in C continues.

 Will merge to 'next'.
 At v9.  Looking good so far.


* js/no-builtins-on-disk-option (2020-09-21) 3 commits
  (merged to 'next' on 2020-09-25 at 6b976da4d2)
 + ci: stop linking built-ins to the dashed versions
 + Optionally skip linking/copying the built-ins
 + msvc: copy the correct `.pdb` files in the Makefile target `install`

 The installation procedure learned to optionally omit "git-foo"
 executable files for each 'foo' built-in subcommand, which are only
 required by old timers that still rely on the age old promise that
 prepending "git --exec-path" output to PATH early in their script
 will keep the "git-foo" calls they wrote working.

 The old attempt to remove these executables from the disk failed in
 the 1.6 era; it may be worth attempting again, but I think it is
 worth to keep this topic separate from such a policy change to help
 it graduate early.

 Will merge to 'master'.


* jk/refspecs-negative (2020-09-25) 1 commit
 - refspec: add support for negative refspecs

 "git fetch" and "git push" support negative refspecs.


* ds/maintenance-part-2 (2020-09-25) 8 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 (this branch is used by ds/maintenance-part-3.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.

--------------------------------------------------
[Discarded]

* js/ignore-cmake-build-artifacts (2020-09-23) 1 commit
 . cmake: ignore generated files

 Running CMake based build with VS (in contrib/) from the top-level
 of the working tree leaves extra build crufts behind.  Add patterns
 to .gitignore

 Retracted.
 cf. <pull.738.git.1601044118.gitgitgadget@gmail.com>

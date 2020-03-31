Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D179C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B599B20787
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AaWsr5f3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgCaXEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:04:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64740 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgCaXEl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 19:04:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1A53B8F88;
        Tue, 31 Mar 2020 19:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=s
        qSQd82mZfCYie3FvUseetaOXkE=; b=AaWsr5f3mG479gsjib/aFJn7pFBSjPGDq
        NxOkZvklArO6IYMLV2HpEd/jKT+gZTYmevk93QRyHrPFm9HXnUKa2AikZiVTyigY
        XZ4u+kKZ/fDDfdTPe6+Oyc1JAZtGeO4vYv04iVzAKsjrad+Rh/dv+1z5hnoirqM5
        l2pDWmXW+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=IZZ
        6NiAiaxZolT3WCSIe0Meru/ZAjijcVOzm0/ZftIP//M3eSi8M/iX9J+Jk6NhWsMT
        jG53npA7Hf3PCuxDT1rt/8PI9VzsAfsCYFfnGCQFxLR/EXxhRBmglP2WO56vPMe2
        uQ2/bwCAIQ9Hyg23JcLt8PtjL4T8iUhRsO9oaj8I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9ADCB8F87;
        Tue, 31 Mar 2020 19:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1784CB8F86;
        Tue, 31 Mar 2020 19:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2020, #10; Tue, 31)
X-master-at: 9fadedd637b312089337d73c3ed8447e9f0aa775
X-next-at: 2183baf09cb5d1e1dd473e6d197893cd5e1c99ca
Date:   Tue, 31 Mar 2020 16:04:28 -0700
Message-ID: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA1A6EB0-73A3-11EA-99C5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 'next' branch has been rewound and rebuilt.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ag/rebase-merge-allow-ff-under-abbrev-command (2020-03-30) 2 commits
 - t3432: test `--merge' with `rebase.abbreviateCommands = true', too
 - sequencer: don't abbreviate a command if it doesn't have a short form

 "git rebase" with the merge backend did not work well when the
 rebase.abbreviateCommands configuration was set.

 Will merge to 'next'.


* jk/oid-array-cleanups (2020-03-30) 7 commits
 - oidset: stop referring to sha1-array
 - ref-filter: stop referring to "sha1 array"
 - bisect: stop referring to sha1_array
 - test-tool: rename sha1-array to oid-array
 - oid_array: rename source file from sha1-array
 - oid_array: use size_t for iteration
 - oid_array: use size_t for count and allocation

 Code cleanup.

 Will merge to 'next'.


* jx/proc-receive-hook (2020-03-31) 7 commits
 - SQUASH???
 - doc: add documentation for the proc-receive hook
 - receive-pack: refactor report for proc-receive
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - receive-pack: add new proc-receive hook
 - transport: not report a non-head push as a branch

--------------------------------------------------
[Stalled]

* gs/commit-graph-path-filter (2020-03-30) 16 commits
 - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
 - t4216: add end to end tests for git log with Bloom filters
 - revision.c: add trace2 stats around Bloom filter usage
 - revision.c: use Bloom filters to speed up path based revision walks
 - commit-graph: add --changed-paths option to write subcommand
 - commit-graph: reuse existing Bloom filters during write
 - commit-graph: write Bloom filters to commit graph file
 - diff: skip batch object download when possible
 - commit-graph: examine commits by generation number
 - commit-graph: examine changed-path objects in pack order
 - commit-graph: compute Bloom filters for changed paths
 - diff: halt tree-diff early after max_changes
 - bloom.c: core Bloom filter implementation for changed paths.
 - bloom.c: introduce core Bloom filter constructs
 - bloom.c: add the murmur3 hash implementation
 - commit-graph: define and use MAX_NUM_CHUNKS

 Introduce an extension to the commit-graph to make it efficient to
 check for the paths that were modified at each commit using Bloom
 filters.

 Expecting a reroll.
 cf. <fdcbd793-57c2-f5ea-ccb9-cf34e911b669@gmail.com>
 Breakage due to byte-order dependency reported.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* dr/midx-avoid-int-underflow (2020-03-28) 1 commit
 - midx.c: fix an integer underflow

 When fed a midx that records no objects, some codepaths tried to
 loop from 0 through (num_objects-1), which, due to integer
 arithmetic wrapping around, made it nonsense operation with out of
 bounds array accesses.  The code has been corrected to reject such
 an midx file.

 Will merge to 'next'.


* ak/run-command-on-cygwin-fix (2020-03-27) 1 commit
 - run-command: trigger PATH lookup properly on Cygwin

 Utitiles run via the run_command() API were not spawned correctly
 on Cygwin, when the paths to them are given as a full path with
 backslashes.

 Will merge to 'next'.


* dd/ci-musl-libc (2020-03-29) 3 commits
 - travis: build and test on Linux with musl libc and busybox
 - ci: refactor docker runner script
 - ci: libify logic for usage and checking CI_USER

 A new CI job to build and run test suite on linux with musl libc
 has been added.


* dr/doc-recurse-submodules (2020-03-27) 5 commits
 - doc: --recurse-submodules mostly applies to active submodules
 - doc: be more precise on (fetch|push).recurseSubmodules
 - doc: explain how to deactivate submodule.recurse completely
 - doc: document --recurse-submodules for reset and restore
 - doc: list all commands affected by submodule.recurse

 Documentation updates around the "--recurse-submodules" option.

 Getting there...
 cf. <F03FAA2F-EDFB-4497-A4E8-3AC267C779FC@gmail.com>
 cf. <1EA4CEB1-D329-4916-A9AC-2F64A7A4F6D0@gmail.com>


* dr/push-remoteref-fix (2020-03-27) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200328222546.gvrtzkcazf3bhjno@doriath>


* jc/doc-test-leaving-early (2020-03-29) 1 commit
 - t/README: suggest how to leave test early with failure

 Document the recommended way to abort a failing test early (e.g. by
 exiting a loop), which is to say "return 1".

 Will merge to 'next'.


* jk/build-with-right-curl (2020-03-27) 2 commits
 - Makefile: use curl-config --cflags
 - Makefile: avoid running curl-config multiple times

 The build procedure did not use the libcurl library and its include
 files correctly for a custom-built installation.

 Will merge to 'next'.


* jk/harden-protocol-v2-delim-handling (2020-03-29) 3 commits
 - test-lib-functions: simplify packetize() stdin code
 - upload-pack: handle unexpected delim packets
 - test-lib-functions: make packetize() more efficient

 The server-end of the v2 protocol to serve "git clone" and "git
 fetch" was not prepared to see a delim packets at unexpected
 places, which led to a crash.

 Will merge to 'next'.


* jk/p5310-drop-non-bitmap-timing (2020-03-27) 1 commit
 - p5310: stop timing non-bitmap pack-to-disk

 Perf-test update.

 Will merge to 'next'.


* jk/test-cleanup (2020-03-27) 2 commits
 - t/lib-*.sh: drop executable bit
 - t/lib-credential.sh: drop shebang line

 Test cleanup.

 Will merge to 'next'.


* ps/transactional-update-ref-stdin (2020-03-30) 9 commits
 - update-ref: implement interactive transaction handling
 - update-ref: read commands in a line-wise fashion
 - update-ref: move transaction handling into `update_refs_stdin()`
 - update-ref: pass end pointer instead of strbuf
 - update-ref: drop unused argument for `parse_refname`
 - update-ref: organize commands in an array
 - strbuf: provide function to append whole lines
 - git-update-ref.txt: add missing word
 - refs: fix segfault when aborting empty transaction

 "git update-ref --stdin" learned a handful of new verbs to let the
 user control ref update transactions more explicitly, which helps
 as an ingredient to implement two-phase commit-style atomic
 ref-updates across multiple repositories.

 Good start, but suspect not quite there yet.
 cf. <xmqqo8she9yp.fsf@gitster.c.googlers.com>


* ag/sequencer-i18n-messages (2020-03-28) 1 commit
 - sequencer: mark messages for translation

 Message fix.

 Will merge to 'next'.


* dl/wrapper-fix-indentation (2020-03-28) 1 commit
 - wrapper: indent with tabs

 Coding style fix.

 Will merge to 'next'.


* en/pull-do-not-rebase-after-fast-forwarding (2020-03-27) 1 commit
 - pull: avoid running both merge and rebase

 "git pull --rebase" tried to run a rebase even after noticing that
 the pull results in a fast-forward and no rebase is needed nor
 sensible, for the past few years due to a mistake nobody noticed.

 Will merge to 'next'.


* jc/allow-strlen-substitution-in-shell-scripts (2020-03-29) 1 commit
 - CodingGuidelines: allow ${#posix} == strlen($posix)

 Coding guideline update.


* jm/gitweb-fastcgi-utf8 (2020-03-29) 1 commit
 - gitweb: fix UTF-8 encoding when using CGI::Fast

 Gitweb update.


* js/walk-doc-optim (2020-03-30) 1 commit
 - MyFirstObjectWalk: remove unnecessary conditional statement

 Code cleanup.

 Will merge to 'next'.


* jx/atomic-push (2020-03-29) 4 commits
 - transport-helper: new method reject_atomic_push()
 - transport-helper: mark failure for atomic push
 - send-pack: mark failure of atomic push properly
 - t5543: never report what we do not push

 "git push --atomic" used to show failures for refs that weren't
 even pushed, which has been corrected.

 Will merge to 'next'.


* ma/doc-discard-docbook-xsl-1.73 (2020-03-29) 6 commits
 - INSTALL: drop support for docbook-xsl before 1.74
 - manpage-normal.xsl: fold in manpage-base.xsl
 - manpage-bold-literal.xsl: stop using git.docbook.backslash
 - Doc: drop support for docbook-xsl before 1.73.0
 - Doc: drop support for docbook-xsl before 1.72.0
 - Doc: drop support for docbook-xsl before 1.71.1

 Raise the minimum required version of docbook-xsl package to 1.74,
 as 1.74.0 was from late 2008, which is more than 10 years old, and
 drop compatibility cruft from our documentation suite.

 Will merge to 'next'.


* pb/rebase-doc-typofix (2020-03-28) 1 commit
 - git-rebase.txt: fix typo

 Typofix.

 Will merge to 'next'.


* rs/pull-options-sync-code-and-doc (2020-03-28) 2 commits
 - pull: pass documented fetch options on
 - pull: remove --update-head-ok from documentation

 "git pull" shares many options with underlying "git fetch", but
 some of them were not documented and some of those that would make
 sense to pass down were not passed down.

 Will merge to 'next'.


* en/fill-directory-exponential (2020-03-26) 7 commits
 - dir: replace exponential algorithm with a linear one
 - dir: refactor treat_directory to clarify control flow
 - dir: fix confusion based on variable tense
 - dir: fix broken comment
 - dir: consolidate treat_path() and treat_one_path()
 - dir: fix simple typo in comment
 - t7063: more thorough status checking

 The directory traversal code had redundant recursive calls which
 made its performance characteristics exponential with respect to
 the depth of the tree, which was corrected.

 Expecting a reroll.
 cf. <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com> (v4)
 cf. <CABPp-BFXWx_MPL1Z0-X5hHf0N1T_13TEbAhVTKh6-atO1+g90Q@mail.gmail.com>


* dd/test-with-busybox (2020-03-26) 8 commits
 - t5703: feed raw data into test-tool unpack-sideband
 - t4124: tweak test so that non-compliant diff(1) can also be used
 - t7063: drop non-POSIX argument "-ls" from find(1)
 - t5616: use rev-parse instead to get HEAD's object_id
 - t5003: skip conversion test if unzip -a is unavailable
 - t5003: drop the subshell in test_lazy_prereq
 - test-lib-functions: test_cmp: eval $GIT_TEST_CMP
 - t4061: use POSIX compliant regex(7)

 Various tests have been updated to work around issues found with
 shell utilities that come with busybox etc.

 Will merge to 'next'.


* dl/libify-a-few (2020-03-24) 2 commits
 - Lib-ify prune-packed
 - Lib-ify fmt-merge-msg

 Code in builtin/*, i.e. those can only be called from within
 built-in subcommands, that implements bulk of a couple of
 subcommands have been moved to libgit.a so that they could be used
 by others.

 Will merge to 'next'.


* dl/test-must-fail-fixes-3 (2020-03-27) 8 commits
 - t5801: teach compare_refs() to accept !
 - t5612: stop losing return codes of git commands
 - t5612: don't use `test_must_fail test_cmp`
 - t5607: reorder `nongit test_must_fail`
 - t5550: simplify no matching line check
 - t5512: stop losing return codes of git commands
 - t5512: stop losing git exit code in here-docs
 - t5512: don't use `test_must_fail test_cmp`

 Test clean-up continues.

 Will merge to 'next'.


* en/sparse-checkout (2020-03-27) 18 commits
 - sparse-checkout: provide a new reapply subcommand
 - unpack-trees: failure to set SKIP_WORKTREE bits always just a warning
 - unpack-trees: provide warnings on sparse updates for unmerged paths too
 - unpack-trees: make sparse path messages sound like warnings
 - unpack-trees: split display_error_msgs() into two
 - unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
 - unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
 - sparse-checkout: use improved unpack_trees porcelain messages
 - sparse-checkout: use new update_sparsity() function
 - unpack-trees: add a new update_sparsity() function
 - unpack-trees: pull sparse-checkout pattern reading into a new function
 - unpack-trees: do not mark a dirty path with SKIP_WORKTREE
 - unpack-trees: allow check_updates() to work on a different index
 - t1091: make some tests a little more defensive against failures
 - unpack-trees: simplify pattern_list freeing
 - unpack-trees: simplify verify_absent_sparse()
 - unpack-trees: remove unused error type
 - unpack-trees: fix minor typo in comment

 "sparse-checkout" UI improvements.

 Will merge to 'next'.


* js/import-tars-do-not-make-phony-files-from-pax-headers (2020-03-24) 1 commit
 - import-tars: ignore the global PAX header

 The import-tars importer (in contrib/fast-import/) used to create
 phony files at the top-level of the repository when the archive
 contains global PAX headers, which made its own logic to detect and
 omit the common leading directory ineffective, which has been
 corrected.

 Will merge to 'next'.


* js/test-junit-finalization-fix (2020-03-23) 1 commit
 - tests(junit-xml): avoid invalid XML

 Test fix.

 Will merge to 'next'.


* js/tests-gpg-integration-on-windows (2020-03-26) 5 commits
 - tests: increase the verbosity of the GPG-related prereqs
 - tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
 - tests: do not let lazy prereqs inside `test_expect_*` turn off tracing
 - t/lib-gpg.sh: stop pretending to be a stand-alone script
 - tests(gpg): allow the gpg-agent to start on Windows

 Enable tests that require GnuPG on Windows.

 Will merge to 'next'.


* dl/merge-autostash (2020-03-24) 19 commits
 - pull: pass --autostash to merge
 - t5520: make test_pull_autostash() accept expect_parent_num
 - merge: teach --autostash option
 - sequencer: implement save_autostash()
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
 - sequencer: make read_oneliner() accept flags
 - sequencer: use file strbuf for read_oneliner()
 - t7600: use test_write_lines()
 - Makefile: ASCII-sort += lists

 "git merge" learns the "--autostash" option.

 Will merge to 'next'.


* js/trace2-env-vars (2020-03-23) 1 commit
 - trace2: teach Git to log environment variables

 Trace2 enhancement to allow logging of the environment variables.

 Will merge to 'next'.


* ar/test-style-fixes (2020-03-22) 2 commits
 - t: fix whitespace around &&
 - t9500: remove spaces after redirect operators

 Style fixes.

 Will merge to 'next'.


* ds/doc-clone-filter (2020-03-22) 1 commit
 - clone: document --filter options

 Doc update.

 Will merge to 'next'.


* jk/t3419-drop-expensive-tests (2020-03-22) 1 commit
 - t3419: drop EXPENSIVE tests

 Test update.

 Will merge to 'next'.


* jt/connectivity-check-optim-in-partial-clone (2020-03-29) 1 commit
 - connected: always use partial clone optimization

 Simplify the commit ancestry connectedness check in a partial clone
 repository in which "promised" objects are assumed to be obtainable
 lazily on-demand from promisor remote repositories.

 Will merge to 'next'.


* mt/test-lib-bundled-short-options (2020-03-25) 1 commit
 - test-lib: allow short options to be bundled

 Minor test usability improvement.

 Will merge to 'next'.


* bk/p4-pre-edit-changelist (2020-02-14) 7 commits
 - git-p4: add RCS keyword status message
 - git-p4: add p4 submit hooks
 - git-p4: restructure code in submit
 - git-p4: add --no-verify option
 - git-p4: add p4-pre-submit exit text
 - git-p4: create new function run_git_hook
 - git-p4: rewrite prompt to be Windows compatible

 "git p4" learned four new hooks and also "--no-verify" option to
 bypass them (and the existing "p4-pre-submit" hook).

 Will merge to 'next'.
 Getting tired of waiting for response to RFH from Windows/Python folks.
 cf. <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>


* jt/rebase-allow-duplicate (2020-03-31) 1 commit
 - rebase --merge: optionally skip upstreamed commits

 Allow "git rebase" to reapply all local commits, even if the may be
 already in the upstream, without checking first.

 Waiting for discussion to settle, possibly followed by a reroll.
 cf. <20200318192821.43808-1-jonathantanmy@google.com>


* bc/faq (2020-03-30) 1 commit
 - docs: add a FAQ

 Doc update.

 Will merge to 'next'.


* jc/log-no-mailmap (2020-03-16) 3 commits
 - log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap
 - clone: reorder --recursive/--recurse-submodules
 - parse-options: teach "git cmd -h" to show alias as alias

 "git log" learns "--[no-]mailmap" as a synonym to "--[no-]use-mailmap"

 Will merge to 'next'.


* tb/commit-graph-split-merge (2020-03-24) 3 commits
  (merged to 'next' on 2020-03-31 at 2183baf09c)
 + builtin/commit-graph.c: support '--input=graphed'
 + builtin/commit-graph.c: introduce '--input=<source>'
 + builtin/commit-graph.c: support '--split[=<strategy>]'

 The code to write out the commit-graph has been taught a few
 options to control if the resulting graph chains should be merged
 or a single new incremental graph is created.

 Will merge to 'master'.


* hn/reftable (2020-02-26) 6 commits
 . Reftable support for git-core
 . Add reftable library
 . reftable: file format documentation
 . refs: document how ref_iterator_advance_fn should handle symrefs
 . create .git/refs in files-backend.c
 . refs.h: clarify reflog iteration order

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Temporarily ejected as this unfortunately conflicts with the
 SHA-256 topic.


* es/bugreport (2020-03-26) 5 commits
 - bugreport: add compiler info
 - bugreport: add uname info
 - bugreport: gather git version and build info
 - bugreport: add tool to generate debugging info
 - help: move list_config_help to builtin/help

 The "bugreport" tool.

 Ready for 'next' to be improved/enhanced on top?  As the scope of
 the topic got trimmed, hopefully these early parts can be polished
 quickly enough to be merged down.

--------------------------------------------------
[Discarded]

* jc/rebase-backend-keep-old-default (2020-03-10) 1 commit
 . rebase: do not switch the default to 'merge' just yet

 The "merge" backend of "git rebase" still has a few bugs and
 unexpected behaviour that need to be ironed out before it becomes
 the default.  Let's switch the default back to the "apply" backend
 for now.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 . reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

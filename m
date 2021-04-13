Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF96C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF71B611CE
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 00:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhDMABN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 20:01:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50982 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhDMABN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 20:01:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A07913135C;
        Mon, 12 Apr 2021 20:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=1
        kX9jVnIrYAZGoPaT8tXZZrgaRM=; b=H7oATKNNVEF0tfRy3Pbkt2EV6bMU8UL/C
        Tp5R+eNJLT4L2yiPCGs61R0V2dyOeTKMwdyAMXq8oRHAZwKi7imFj2t51jworedb
        AXPmhKbV8aBv/WT6ev+GGPMdLidVn14pkb4itoDt0rk9+lx6NgzJ/eGLNfJGCgwN
        kjAqvXH3Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=ufc
        R2RdwIyoI4bktpoNn/qZKDI4uTHBXpBRmPWy/tnzTrWn4gjBETYM2PvgzgNHcWzA
        c3tm5SB14KcmESStcWBqs+s+gh7h0I3QJZthOe7SrclpIL/VhcqRgx9d0Mgz5gYM
        jlmOpOwJJL+45w9V1FmUel3mNB6xUYScGxHvi3r4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52C1D131359;
        Mon, 12 Apr 2021 20:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F9E2131355;
        Mon, 12 Apr 2021 20:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2021, #03; Mon, 12)
X-master-at: 89b43f80a514aee58b662ad606e6352e03eaeee4
X-next-at: 7d1e84936f59976b1fce260a447d8781a07cd620
Date:   Mon, 12 Apr 2021 17:00:49 -0700
Message-ID: <xmqqfszvm4su.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F48F382-9BEB-11EB-BC2D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'seen' is known to be broken today (without the top two
topics, it passes tests for me locally).  There are too many topics
that are not adequately reviewed.

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
[New Topics]

* jt/fetch-pack-request-fix (2021-04-08) 1 commit
 - fetch-pack: buffer object-format with other args
 (this branch is used by jt/push-negotiation.)

 Will merge to 'next'.


* jt/push-negotiation (2021-04-08) 6 commits
 - send-pack: support push negotiation
 - fetch: teach independent negotiation (no packfile)
 - fetch-pack: refactor command and capability write
 - fetch-pack: refactor add_haves()
 - fetch-pack: refactor process_acks()
 - Merge branch 'jt/fetch-pack-request-fix' into jt/push-negotiation
 (this branch uses jt/fetch-pack-request-fix.)

 "git push" learns to discover common ancestor with the receiving
 end over protocol v2.

 Waiting for reviews.

* ab/doc-lint (2021-04-10) 7 commits
 - docs: fix linting issues due to incorrect relative section order
 - doc lint: lint relative section order
 - doc lint: lint and fix missing "GIT" end sections
 - doc lint: fix bugs in, simplify and improve lint script
 - doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
 - Documentation/Makefile: make doc.dep dependencies a variable again
 - Documentation/Makefile: make $(wildcard howto/*.txt) a var

 Dev support.

 Waiting for reviews to conclude.


* ab/rebase-no-reschedule-failed-exec (2021-04-10) 2 commits
 - rebase: don't override --no-reschedule-failed-exec with config
 - rebase tests: camel-case rebase.rescheduleFailedExec consistently

 "git rebase --[no-]reschedule-failed-exec" did not work well with
 its configuration variable, which has been corrected.

 Waiting for reviews to conclude.


* ah/plugleaks (2021-04-10) 9 commits
 - builtin/rm: avoid leaking pathspec and seen
 - builtin/rebase: release git_format_patch_opt too
 - builtin/for-each-ref: free filter and UNLEAK sorting.
 - builtin/checkout: clear pending objects after diffing
 - builtin/check-ignore: clear_pathspec before returning
 - builtin/bugreport: don't leak prefixed filename
 - branch: FREE_AND_NULL instead of NULL'ing real_ref
 - bloom: clear each bloom_key after use
 - wt-status: fix multiple small leaks

 Plug various leans reported by LSAN.

 Waiting for reroll.
 What is queued here is a subset of the original series that
 looked (at least to me) to be obviously correct.


* bc/hash-transition-interop-part-1 (2021-04-10) 16 commits
 - fixup! hash: provide per-algorithm null OIDs
 - hex: print objects using the hash algorithm member
 - hex: default to the_hash_algo on zero algorithm value
 - builtin/pack-objects: avoid using struct object_id for pack hash
 - commit-graph: don't store file hashes as struct object_id
 - builtin/show-index: set the algorithm for object IDs
 - hash: provide per-algorithm null OIDs
 - hash: set and copy algo field in struct object_id
 - cache: compare the entire buffer for struct object_id
 - builtin/pack-redundant: avoid casting buffers to struct object_id
 - Use the final_oid_fn to finalize hashing of object IDs
 - hash: add a function to finalize object IDs
 - Always use oidread to read into struct object_id
 - cache: add an algo member to struct object_id
 - builtin/hash-object: allow literally hashing with a given algorithm
 - sha1-file: allow hashing objects literally with any algorithm

 SHA-256 transition.

 Seems to break the tests when merged to 'seen'.


* ps/rev-list-object-type-filter (2021-04-12) 8 commits
 - rev-list: allow filtering of provided items
 - pack-bitmap: implement combined filter
 - pack-bitmap: implement object type filter
 - list-objects: implement object type filter
 - list-objects: support filtering by tag and commit
 - list-objects: move tag processing into its own function
 - revision: mark commit parents as NOT_USER_GIVEN
 - uploadpack.txt: document implication of `uploadpackfilter.allow`

 "git rev-list" learns the "--filter=object:type=<type>" option,
 which can be used to exclude objects of the given kind from the
 packfile generated by pack-objects.

 Waiting for reviews to conclude.
 cf. <cover.1618234575.git.ps@pks.im>


* tb/multi-pack-bitmaps (2021-04-10) 23 commits
 - p5326: perf tests for MIDX bitmaps
 - p5310: extract full and partial bitmap tests
 - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - t7700: update to work with MIDX bitmap test knob
 - t5319: don't write MIDX bitmaps in t5319
 - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t5326: test multi-pack bitmap behavior
 - t/helper/test-read-midx.c: add --checksum mode
 - t5310: move some tests to lib-bitmap.sh
 - pack-bitmap: write multi-pack bitmaps
 - pack-bitmap: read multi-pack bitmaps
 - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 - pack-bitmap.c: introduce 'bitmap_num_objects()'
 - midx: respect 'core.multiPackIndex' when writing
 - midx: clear auxiliary .rev after replacing the MIDX
 - midx: make a number of functions non-static
 - Documentation: describe MIDX-based bitmaps
 - Documentation: build 'technical/bitmap-format' by default
 - pack-bitmap-write.c: free existing bitmaps
 - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
 - Merge branch 'tb/pack-preferred-tips-to-give-bitmap' into tb/multi-pack-bitmaps
 (this branch uses tb/pack-preferred-tips-to-give-bitmap.)

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Waiting for reviews.
 cf. <cover.1617991824.git.me@ttaylorr.com>


* ab/svn-tests-set-e-fix (2021-04-12) 2 commits
 - svn tests: refactor away a "set -e" in test body
 - svn tests: remove legacy re-setup from init-clone test

 Test clean-up.

 Waiting for reviews.


* ab/test-lib-updates (2021-04-12) 16 commits
 - test-lib-functions: remove last two parameter count assertions
 - Revert and amend "test-lib-functions: assert correct parameter count"
 - test-lib-functions: use "return 1" instead of "false"
 - test-lib-functions: normalize test_path_is_missing() debugging
 - test-lib: modernize test_create_repo() function
 - test-lib: do not show advice about init.defaultBranch under --verbose
 - test-lib: reformat argument list in test_create_repo()
 - submodule tests: use symbolic-ref --short to discover branch name
 - test-lib functions: add --printf option to test_commit
 - describe tests: convert setup to use test_commit
 - test-lib functions: add an --annotated-tag option to "test_commit"
 - test-lib-functions: document test_commit --no-tag
 - test-lib-functions: reword "test_commit --append" docs
 - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 - test-lib: bring $remove_trash out of retirement
 - check-non-portable-shell: complain about "test" a/-o instead of &&/||
 (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)

 Test clean-up.

 Waiting for reviews.


* ah/merge-ort-ubsan-fix (2021-04-12) 1 commit
 - merge-ort: only do pointer arithmetic for non-empty lists

 Code clean-up for merge-ort backend.

 Will merge to 'next'?


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* hn/refs-trace-errno (2021-04-12) 1 commit
 - refs: print errno for read_raw_ref if GIT_TRACE_REFS is set

 Show errno in the trace output in the error codepath that calls
 read_raw_ref method.

 Waiting for reviews to conclude.
 cf. <xmqq4kgbb2ic.fsf@gitster.g>


* hn/reftable-tables-doc-update (2021-04-12) 1 commit
 - reftable: document an alternate cleanup method on Windows

 Doc updte.

 Will merge to 'next'.


* jk/pack-objects-bitmap-progress-fix (2021-04-12) 1 commit
 - pack-objects: update "nr_seen" progress based on pack-reused count

 When "git pack-objects" makes a literal copy of a part of existing
 packfile using the reachability bitmaps, its update to the progress
 meter was broken.

 Will merge to 'next'.


* ma/t0091-bugreport-fix (2021-04-12) 1 commit
 - t0091-bugreport.sh: actually verify some content of report

 Test fix.

 Waiting for an Ack.


* ps/config-global-override (2021-04-12) 3 commits
 - config: allow overriding of global and system configuration
 - config: unify code paths to get global config paths
 - config: rename `git_etc_config()`

 Replace GIT_CONFIG_NOSYSTEM mechanism to decline from reading the
 system-wide configuration file with GIT_CONFIG_SYSTEM that lets
 users specify from which file to read the system-wide configuration
 (setting it to an empty file would essentially be the same as
 setting NOSYSTEM), and introduce GIT_CONFIG_GLOBAL to override the
 per-user configuration in $HOME/.gitconfig.

 Expecting a (hopefully final) reroll.
 cf. <xmqq4kgbfn8o.fsf@gitster.g>

--------------------------------------------------
[Stalled]

* dl/complete-stash (2021-03-24) 3 commits
  (merged to 'next' on 2021-03-24 at ce573a99cc)
 + git-completion.bash: use __gitcomp_builtin() in _git_stash()
 + git-completion.bash: extract from else in _git_stash()
 + git-completion.bash: pass $__git_subcommand_idx from __git_main()

 Update "git stash branch<TAB>" command line completion (in contrib/).

 On hold.  Probably needs either a reroll or incremental refinements.
 cf. <20210327183554.GD2271@szeder.dev>


* ag/merge-strategies-in-c (2021-03-17) 15 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Expecting a (hopefully final) reroll.
 cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>


* ab/unexpected-object-type (2021-03-27) 10 commits
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - object.c: add and use oid_is_type_or_die_msg() function
 - object.c: add a utility function for "expected type X, got Y"
 - tree.c: fix misindentation in parse_tree_gently()
 - object-name.c: make dependency on object_type order more obvious
 - object-file.c: make oid_object_info() return "enum object_type"
 - object.c: make type_from_string() return "enum object_type"
 - object.c: refactor type_from_string_gently()
 - object.c: stop supporting len == -1 in type_from_string_gently()

 Error reporting upon object type mismatch has been improved

 Expecting a reroll.
 cf. <YGBL88lYheyFmwCg@coredump.intra.peff.net>
 ... we would be much better off to say something like "somebody
 expected X to be a commit, but now somebody else expects it to be a
 blob", which is all that we can reliably say.


* ab/describe-tests-fix (2021-04-12) 5 commits
 - describe tests: support -C in "check_describe"
 - describe tests: fix nested "test_expect_success" call
 - describe tests: don't rely on err.actual from "check_describe"
 - describe tests: refactor away from glob matching
 - describe tests: improve test for --work-tree & --dirty
 (this branch uses ab/test-lib-updates.)

 Various updates to tests around "git describe"


* ab/pickaxe-pcre2 (2021-04-12) 22 commits
 - xdiff-interface: replace discard_hunk_line() with a flag
 - xdiff users: use designated initializers for out_line
 - pickaxe -G: don't special-case create/delete
 - pickaxe -G: terminate early on matching lines
 - xdiff-interface: allow early return from xdiff_emit_line_fn
 - xdiff-interface: prepare for allowing early return
 - pickaxe -S: slightly optimize contains()
 - pickaxe: rename variables in has_changes() for brevity
 - pickaxe -S: support content with NULs under --pickaxe-regex
 - pickaxe: assert that we must have a needle under -G or -S
 - pickaxe: refactor function selection in diffcore-pickaxe()
 - perf: add performance test for pickaxe
 - pickaxe/style: consolidate declarations and assignments
 - diff.h: move pickaxe fields together again
 - pickaxe: die when --find-object and --pickaxe-all are combined
 - pickaxe: die when -G and --pickaxe-regex are combined
 - pickaxe tests: add missing test for --no-pickaxe-regex being an error
 - pickaxe tests: test for -G, -S and --find-object incompatibility
 - pickaxe tests: add test for "log -S" not being a regex
 - pickaxe tests: add test for diffgrep_consume() internals
 - pickaxe tests: refactor to use test_commit --append --printf
 - grep/pcre2 tests: reword comments referring to kwset
 (this branch uses ab/test-lib-updates.)

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.


* es/config-hooks (2021-03-10) 36 commits
 . run-command: stop thinking about hooks
 . git-send-email: use 'git hook run' for 'sendemail-validate'
 . bugreport: use hook_exists instead of find_hook
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
 . hook: introduce hook_exists()
 . hook: add 'run' subcommand
 . parse-options: parse into strvec
 . hook: implement hookcmd.<name>.skip
 . hook: teach hook.runHookDir
 . hook: include hookdir hook in list
 . hook: add list command
 . hook: scaffolding for git-hook subcommand
 . doc: propose hooks managed by the config

 The "hooks defined in config" topic.

--------------------------------------------------
[Cooking]

* cc/test-helper-bloom-usage-fix (2021-04-05) 1 commit
  (merged to 'next' on 2021-04-06 at 4895f33fee)
 + test-bloom: fix missing 'bloom' from usage string

 Usage message fix for a test helper.

 Will merge to 'master'.


* jz/apply-run-3way-first (2021-04-06) 1 commit
  (merged to 'next' on 2021-04-08 at f826bcc6b8)
 + git-apply: try threeway first when "--3way" is used
 (this branch is used by jz/apply-3way-cached.)

 "git apply --3way" has always been "to fall back to 3-way merge
 only when straight application fails". Swap the order of falling
 back so that 3-way is always attempted first (only when the option
 is given, of course) and then straight patch application is used as
 a fallback when it fails.

 Will merge to 'master'.


* ds/maintenance-prefetch-fix (2021-04-10) 3 commits
 - maintenance: use 'git fetch --prefetch'
 - fetch: add --prefetch option
 - maintenance: simplify prefetch logic

 The prefetch task in "git maintenance" assumed that "git fetch"
 from any remote would fetch all its local branches, which would
 fetch too much if the user is interested in only a subset of
 branches there.

 Expecting a reroll.
 cf. <e7f09182-3b75-f2a3-c9c7-0055cc377a32@gmail.com>


* ab/complete-cherry-pick-head (2021-04-07) 1 commit
  (merged to 'next' on 2021-04-09 at 5810d0e2c2)
 + bash completion: complete CHERRY_PICK_HEAD

 The command line completion (in contrib/) has learned that
 CHERRY_PICK_HEAD is a possible pseudo-ref.

 Will merge to 'master'.


* mr/bisect-in-c-4 (2021-04-11) 4 commits
 - bisect--helper: retire `--bisect-next-check` subcommand
 - bisect--helper: reimplement `bisect_run` shell function in C
 - bisect--helper: reimplement `bisect_visualize()`shell function in C
 - run-command: make `exists_in_PATH()` non-static

 The codepaths involved in running "git bisect visualize" and "git
 bisect run" has been rewritten in C.

 
 cf. <xmqq35vwh8qk.fsf@gitster.g>, <xmqqy2doftrj.fsf@gitster.g>


* ab/detox-config-gettext (2021-04-08) 1 commit
  (merged to 'next' on 2021-04-08 at 01d6ff5069)
 + config.c: remove last remnant of GIT_TEST_GETTEXT_POISON

 The last remnant of gettext-poison has been removed.

 Will merge to 'master'.


* jz/apply-3way-cached (2021-04-07) 1 commit
  (merged to 'next' on 2021-04-09 at 7d1e84936f)
 + git-apply: allow simultaneous --cached and --3way options
 (this branch uses jz/apply-run-3way-first.)

 "git apply" now takes "--3way" and "--cached" at the same time, and
 work and record results only in the index.

 Will merge to 'master'.


* vs/completion-with-set-u (2021-04-08) 1 commit
  (merged to 'next' on 2021-04-08 at b9b8bde89d)
 + completion: audit and guard $GIT_* against unset use

 The command-line completion script (in contrib/) had a couple of
 references that would have given a warning under the "-u" (nounset)
 option.

 Will merge to 'master'.


* sg/bugreport-fixes (2021-04-08) 1 commit
 - Makefile: add missing dependencies of 'config-list.h'

 The dependencies for config-list.h and command-list.h were broken
 when the former was split out of the latter, which has been
 corrected.

 Expecting a reroll.
 cf. <20210409212044.GD2947267@szeder.dev>


* mt/add-rm-in-sparse-checkout (2021-04-08) 7 commits
 - rm: honor sparse checkout patterns
 - add: warn when asked to update SKIP_WORKTREE entries
 - refresh_index(): add flag to ignore SKIP_WORKTREE entries
 - pathspec: allow to ignore SKIP_WORKTREE entries on index matching
 - add: make --chmod and --renormalize honor sparse checkouts
 - t3705: add tests for `git add` in sparse checkouts
 - add: include magic part of pathspec on --refresh error

 "git add" and "git rm" learned not to touch those paths that are
 outside of sparse checkout.


* jh/rfc-builtin-fsmonitor (2021-04-08) 23 commits
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - p7519: add fsmonitor--daemon
 - t7527: create test for fsmonitor--daemon
 - fsmonitor: force update index when fsmonitor token advances
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon:: introduce client delay for testing
 - fsmonitor--daemon: periodically truncate list of modified files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement daemon command options
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - fsmonitor--daemon: implement client command options
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
 - config: FSMonitor is repository-specific
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor


* jk/ref-filter-segfault-fix (2021-04-01) 1 commit
  (merged to 'next' on 2021-04-02 at 03596563b7)
 + ref-filter: fix NULL check for parse object failure

 A NULL-dereference bug has been corrected in an error codepath in
 "git for-each-ref", "git branch --list" etc.

 Will merge to 'master'.


* tb/pack-preferred-tips-to-give-bitmap (2021-03-31) 3 commits
  (merged to 'next' on 2021-04-03 at cd7024ecd8)
 + builtin/pack-objects.c: respect 'pack.preferBitmapTips'
 + t/helper/test-bitmap.c: initial commit
 + pack-bitmap: add 'test_bitmap_commits()' helper
 (this branch is used by tb/multi-pack-bitmaps.)

 A configuration variable has been added to force tips of certain
 refs to be given a reachability bitmap.

 Will merge to 'master'.


* ab/perl-do-not-abuse-map (2021-04-02) 1 commit
  (merged to 'next' on 2021-04-03 at 4eaf558557)
 + git-send-email: replace "map" in void context with "for"
 (this branch is used by ab/send-email-validate-errors.)

 Perl critique.

 Will merge to 'master'.


* zh/trailer-cmd (2021-04-12) 2 commits
 - trailer: add new .cmd config option
 - docs: correct descript of trailer.<token>.command

 The way the command line specified by the trailer.<token>.command
 configuration variable receives the end-user supplied value was
 both error prone and misleading.  An alternative to achieve the
 same goal in a safer and more intuitive way has been added, as
 the trailer.<token>.cmd configuration variable, to replace it.

 Waiting for reviews.
 I doubt it is a good idea to copy the "run once even without being
 asked" from .command interface.
 cf. <xmqqwnt7b5fg.fsf@gitster.g>


* fm/user-manual-use-preface (2021-04-03) 1 commit
  (merged to 'next' on 2021-04-05 at 0ae8f63207)
 + user-manual.txt: assign preface an id and a title

 Doc update to improve git.info

 Will merge to 'master'.


* ab/send-email-validate-errors (2021-04-06) 3 commits
  (merged to 'next' on 2021-04-06 at d7fb1dbde0)
 + git-send-email: improve --validate error output
 + git-send-email: refactor duplicate $? checks into a function
 + git-send-email: test full --validate output
 (this branch uses ab/perl-do-not-abuse-map.)

 Clean-up codepaths that implements "git send-email --validate"
 option and improves the message from it.

 Will merge to 'master'.


* tb/precompose-prefix-simplify (2021-04-05) 2 commits
  (merged to 'next' on 2021-04-05 at 78e8ed11b7)
 + macOS: precompose startup_info->prefix
 + precompose_utf8: make precompose_string_if_needed() public

 Streamline the codepath to fix the UTF-8 encoding issues in the
 argv[] and the prefix on macOS.

 Will merge to 'master'.


* ab/userdiff-tests (2021-04-08) 9 commits
 - blame tests: simplify userdiff driver test
 - blame tests: don't rely on t/t4018/ directory
 - userdiff: remove support for "broken" tests
 - userdiff tests: list builtin drivers via test-tool
 - userdiff tests: explicitly test "default" pattern
 - userdiff: add and use for_each_userdiff_driver()
 - userdiff style: normalize pascal regex declaration
 - userdiff style: declare patterns with consistent style
 - userdiff style: re-order drivers in alphabetical order

 A bit of code clean-up and a lot of test clean-up around userdiff
 area.

 Will merge to 'next'?


* ar/userdiff-scheme (2021-04-08) 1 commit
 - userdiff: add support for Scheme

 Userdiff patterns for "Scheme" has been added.

 Will merge to 'next'?


* gk/gitweb-redacted-email (2021-04-08) 1 commit
  (merged to 'next' on 2021-04-08 at 8a19c3cd6e)
 + gitweb: add "e-mail privacy" feature to redact e-mail addresses

 "gitweb" learned "e-mail privacy" feature to redact strings that
 look like e-mail addresses on various pages.

 Waiting for reviews.
 cf. <xmqq5z19k9wu.fsf@gitster.g>


* ds/sparse-index (2021-03-30) 21 commits
  (merged to 'next' on 2021-04-07 at f1290a7929)
 + p2000: add sparse-index repos
 + sparse-index: loose integration with cache_tree_verify()
 + cache-tree: integrate with sparse directory entries
 + sparse-checkout: disable sparse-index
 + sparse-checkout: toggle sparse index from builtin
 + sparse-index: add index.sparse config option
 + sparse-index: check index conversion happens
 + unpack-trees: allow sparse directories
 + submodule: sparse-index should not collapse links
 + sparse-index: convert from full to sparse
 + sparse-index: add 'sdir' index extension
 + sparse-checkout: hold pattern list in index
 + unpack-trees: ensure full index
 + test-tool: don't force full index
 + test-read-cache: print cache entries with --table
 + t1092: compare sparse-checkout to sparse-index
 + sparse-index: implement ensure_full_index()
 + sparse-index: add guard to ensure full index
 + t1092: clean up script quoting
 + t/perf: add performance test for sparse operations
 + sparse-index: design doc and format update
 (this branch is used by ds/sparse-index-protections.)

 Both in-core and on-disk index has been updated to optionally omit
 individual entries and replace them with the tree object that
 corresponds to the directory that contains them when the "cone"
 mode of sparse checkout is in use.

 On hold, waiting for the "protections" topic to stablize.


* en/ort-perf-batch-10 (2021-03-18) 8 commits
  (merged to 'next' on 2021-04-07 at 9826d89311)
 + diffcore-rename: determine which relevant_sources are no longer relevant
 + merge-ort: record the reason that we want a rename for a file
 + diffcore-rename: add computation of number of unknown renames
 + diffcore-rename: check if we have enough renames for directories early on
 + diffcore-rename: only compute dir_rename_count for relevant directories
 + merge-ort: record the reason that we want a rename for a directory
 + merge-ort, diffcore-rename: tweak dirs_removed and relevant_source type
 + diffcore-rename: take advantage of "majority rules" to skip more renames
 (this branch is used by en/ort-perf-batch-11 and en/ort-readiness.)

 Various rename detection optimization to help "ort" merge strategy
 backend.

 Will merge to 'master'.


* mt/parallel-checkout-part-2 (2021-04-08) 5 commits
 - parallel-checkout: add design documentation
 - parallel-checkout: support progress displaying
 - parallel-checkout: add configuration options
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout


* ds/sparse-index-protections (2021-04-12) 26 commits
 - name-hash: use expand_to_path()
 - sparse-index: expand_to_path()
 - name-hash: don't add directories to name_hash
 - revision: ensure full index
 - resolve-undo: ensure full index
 - read-cache: ensure full index
 - pathspec: ensure full index
 - merge-recursive: ensure full index
 - entry: ensure full index
 - dir: ensure full index
 - update-index: ensure full index
 - stash: ensure full index
 - rm: ensure full index
 - merge-index: ensure full index
 - ls-files: ensure full index
 - grep: ensure full index
 - fsck: ensure full index
 - difftool: ensure full index
 - commit: ensure full index
 - checkout: ensure full index
 - checkout-index: ensure full index
 - add: ensure full index
 - cache: move ensure_full_index() to cache.h
 - read-cache: expand on query into sparse-directory entry
 - *: remove 'const' qualifier for struct index_state
 - sparse-index: API protection strategy
 (this branch uses ds/sparse-index.)

 Builds on top of the sparse-index infrastructure to mark operations
 that are not ready to mark with the sparse index, causing them to
 fall back on fully-populated index that they always have worked with.


* en/ort-readiness (2021-03-20) 13 commits
  (merged to 'next' on 2021-04-08 at 20283a3f10)
 + Add testing with merge-ort merge strategy
 + t6423: mark remaining expected failure under merge-ort as such
 + Revert "merge-ort: ignore the directory rename split conflict for now"
 + merge-recursive: add a bunch of FIXME comments documenting known bugs
 + merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
 + t: mark several submodule merging tests as fixed under merge-ort
 + merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
 + t6428: new test for SKIP_WORKTREE handling and conflicts
 + merge-ort: support subtree shifting
 + merge-ort: let renormalization change modify/delete into clean delete
 + merge-ort: have ll_merge() use a special attr_index for renormalization
 + merge-ort: add a special minimal index just for renormalization
 + merge-ort: use STABLE_QSORT instead of QSORT where required
 (this branch is used by en/ort-perf-batch-11; uses en/ort-perf-batch-10.)

 Plug the ort merge backend throughout the rest of the system, and
 start testing it as a replacement for the recursive backend.

 Will merge to 'next'.


* hn/reftable (2021-04-12) 20 commits
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - Reftable support for git-core
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: add LICENSE
 - init-db: set the_repository->hash_algo early on

 The "reftable" backend for the refs API.

 Waiting for reviews.

--------------------------------------------------
[Discarded]

* ab/make-cocci-dedup (2021-03-22) 4 commits
 . Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
 . Makefile/coccicheck: allow for setting xargs concurrency
 . Makefile/coccicheck: speed up and fix bug with duplicate hunks
 . Makefile/coccicheck: add comment heading for all SPATCH flags

 Coccicheck update.

 Retracted.
 cf. <cover.1616414951.git.avarab@gmail.com>
 cf. <87k0psnzv5.fsf@evledraar.gmail.com>


* ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
 - tests: get rid of $_x05 from the test suite
 - shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
 - test-lib: remove unused $_x40 and $_z40 variables
 - git-bisect: remove unused SHA-1 $x40 shell variable

 Remove variables that hold regexp and glob that match fixed number
 of hexadecimal digits from the test suite.

 Retracted, to be replaced by another series.
 cf. <878s67o09v.fsf@evledraar.gmail.com>

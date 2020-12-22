Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7653C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6EB21D81
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgLVUIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 15:08:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52118 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgLVUIP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 15:08:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66DBB102483;
        Tue, 22 Dec 2020 15:07:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=V
        fagXyWm4qJei2umwki/8Tq/a9w=; b=RigyM6r7JHEQzdrHUkXJkywptwq4h6NoU
        IH5UJnFpFd2NxJR+Mv8NTJPFBG4loLvW/WYoxR6wzPvALCSKFHoZ0LQxFHAlsMuZ
        rQBxPUrHXrI7mYgvsIqUlN7mS2h+sT+YB+vgQmy8nphThaMnjWTPoc5XdI1kPLzL
        SFY2bAEl0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=NxI
        oTjsgMSbseNpaGPSsZBivjguKvNQSdvBG4lSrl8a1r75pbBBZR3eDTPCLqxybDFZ
        AgKKysDiTcEPaCEAiHVGtUOfxfTMpSqoIOqjWIpwi94PGLSc9wdDHl40nwVaWSH0
        a05FiWdbj0i/TvryhYp+kG35+AQhu9Q4lmjDE/qk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BB5F102482;
        Tue, 22 Dec 2020 15:07:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 605C4102481;
        Tue, 22 Dec 2020 15:07:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2020, #04; Tue, 22)
X-master-at: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
X-next-at: acce13e5c41814e6303336cb470967b5b6cc9211
Date:   Tue, 22 Dec 2020 12:07:21 -0800
Message-ID: <xmqqo8ilhafa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DF9C1CA-4491-11EB-B848-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Hopefully, the second release candidate -rc2 can be tagged tomorrow.

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

* dl/checkout-p-merge-base (2020-12-21) 1 commit
  (merged to 'next' on 2020-12-21 at 595dd32b56)
 + checkout -p: handle tree arguments correctly again

 Fix to a regression introduced during this cycle.

 Will merge to 'master'.


* es/worktree-repair-both-moved (2020-12-21) 1 commit
 - worktree: teach `repair` to fix multi-directional breakage

 "git worktree repair" learned to take advantage of the fact that it
 knows both ends (i.e. the main repository is found in the location
 the command runs, the worktrees are given as arguments) to deal
 with the case where both the repository and the worktree moved.

 Will merge to 'next'.


* fc/t6030-bisect-reset-removes-auxiliary-files (2020-12-21) 1 commit
 - test: bisect-porcelain: fix location of files

 A 3-year old test that was not testing anything useful has been
 corrected.

 Will merge to 'next'.


* ma/maintenance-crontab-fix (2020-12-21) 3 commits
  (merged to 'next' on 2020-12-21 at 8cd8cc04f9)
 + t7900-maintenance: test for magic markers
 + gc: fix handling of crontab magic markers
 + git-maintenance.txt: add missing word

 Hotfix for a topic of this cycle.

 Will merge to 'master'.


* mr/bisect-in-c-4 (2020-12-21) 7 commits
 - bisect--helper: retire `--check-and-set-terms` subcommand
 - bisect--helper: reimplement `bisect_skip` shell function in C
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: use `res` instead of return in BISECT_RESET case option
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: reimplement `bisect_replay` shell function in C
 - bisect--helper: reimplement `bisect_log` shell function in C

 Piecemeal of rewrite of "git bisect" in C continues.


* jt/clone-unborn-head (2020-12-21) 3 commits
 . clone: respect remote unborn HEAD
 . connect, transport: add no-op arg for future patch
 . ls-refs: report unborn targets of symrefs

 "git clone" tries to locally check out the branch pointed at by
 HEAD of the remote repository after it is done, but the protocol
 did not convey the information necessary to do so when copying an
 empty repository.  The protocol v2 learned how to do so.

 Seems to break tests when merged to 'seen'.


* nk/refspecs-negative-fix (2020-12-21) 2 commits
  (merged to 'next' on 2020-12-21 at 7d88169236)
 + negative-refspec: improve comment on query_matches_negative_refspec
 + negative-refspec: fix segfault on : refspec

 Hotfix for recent regression.

 Will merge to 'master'.

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
 cf. <20200901144323.GA14554@dcvr>


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


* jc/war-on-dashed-git (2020-12-21) 2 commits
 - fixup??? git: catch an attempt to run "git-foo"
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Needs Review]

* ss/submodule-add-in-c (2020-12-15) 3 commits
 - t7400: add test to check 'submodule add' for tracked paths
 - submodule: port submodule subcommand 'add' from shell to C
 - dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.

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

* fc/bash-completion-post-2.29 (2020-12-19) 4 commits
 - completion: bash: fix for multiple dash commands
 - completion: bash: fix for suboptions with value
 - completion: bash: add correct suffix in variables
 - completion: bash: fix prefix detection in branch.*

 Needs review.


* jc/config-pretend-gitdir (2020-12-15) 1 commit
 - config: --pretend-git-dir for includeIf:gitdir

 WIP


* jc/deprecate-pack-redundant (2020-12-15) 1 commit
 - pack-redundant: gauge the usage before proposing its removal

 Warn loudly when the "pack-redundant" command, which has been left
 stale with almost unusable performance issues, gets used, as we no
 longer want to recommend its use (instead just "repack -d" instead).


* en/merge-ort-recursive (2020-12-16) 4 commits
 - merge-ort: implement merge_incore_recursive()
 - merge-ort: make clear_internal_opts() aware of partial clearing
 - merge-ort: copy a few small helper functions from merge-recursive.c
 - commit: move reverse_commit_list() from merge-recursive
 (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-3.)

 The ORT merge strategy learned to synthesize virtual ancestor tree
 by recursively merging multiple merge bases together, just like the
 recursive backend has done for years.

 Will merge to 'next'.


* js/no-more-prepare-for-main-in-test (2020-12-16) 11 commits
  (merged to 'next' on 2020-12-18 at d15a382d4d)
 + tests: drop the `PREPARE_FOR_MAIN_BRANCH` prereq
 + t9902: use `main` as initial branch name
 + t6302: use `main` as initial branch name
 + t5703: use `main` as initial branch name
 + t5510: use `main` as initial branch name
 + t5505: finalize transitioning to using the branch name `main`
 + t3205: finalize transitioning to using the branch name `main`
 + t3203: complete the transition to using the branch name `main`
 + t3201: finalize transitioning to using the branch name `main`
 + t3200: finish transitioning to the initial branch name `main`
 + t1400: use `main` as initial branch name

 Test coverage fix.

 Will merge to 'master'.


* jx/pack-redundant-on-single-pack (2020-12-16) 1 commit
  (merged to 'next' on 2020-12-18 at b819311529)
 + pack-redundant: fix crash when one packfile in repo

 "git pack-redandant" when there is only one packfile used to crash,
 which has been corrected.

 Will merge to 'master'.


* mt/parallel-checkout-part-1 (2020-12-16) 9 commits
 - entry: add checkout_entry_ca() taking preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract update_ce_after_write() from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add classification for conv_attrs struct
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public

 Parallel checkout.

 Looking good.


* en/merge-ort-3 (2020-12-15) 11 commits
 - merge-ort: add implementation of type-changed rename handling
 - merge-ort: add implementation of normal rename handling
 - merge-ort: add implementation of rename collisions
 - merge-ort: add implementation of rename/delete conflicts
 - merge-ort: add implementation of both sides renaming differently
 - merge-ort: add implementation of both sides renaming identically
 - merge-ort: add basic outline for process_renames()
 - merge-ort: implement compare_pairs() and collect_renames()
 - merge-ort: implement detect_regular_renames()
 - merge-ort: add initial outline for basic rename detection
 - merge-ort: add basic data structures for handling renames
 (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-recursive.)

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

 We may want to make this just a middle part of the
 ps/config-env-pairs topic with a bit of patch shuffling.


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


* bc/hashed-mailmap (2020-12-12) 1 commit
 - mailmap: support hashed entries in mailmaps

 The mailmap database learned to take hashed value as the original
 side of mapping.

 Expecting a reroll.


* so/log-diff-merge (2020-12-21) 32 commits
 - t4013: add tests for --diff-merges=first-parent
 - doc/git-show: include --diff-merges description
 - doc/rev-list-options: document --first-parent changes merges format
 - doc/diff-generate-patch: mention new --diff-merges option
 - doc/git-log: describe new --diff-merges options
 - diff-merges: add '--diff-merges=1' as synonym for 'first-parent'
 - diff-merges: add old mnemonic counterparts to --diff-merges
 - diff-merges: let new options enable diff without -p
 - diff-merges: do not imply -p for new options
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
 - diff-merges: handle imply -p on -c/--cc logic for log.c
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

 Rerolled.


* bc/rev-parse-path-format (2020-12-12) 2 commits
 - rev-parse: add option for absolute or relative path formatting
 - abspath: add a function to resolve paths with missing components

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.


* en/merge-ort-impl (2020-12-13) 21 commits
  (merged to 'next' on 2020-12-21 at c551d7bda9)
 + merge-ort: free data structures in merge_finalize()
 + merge-ort: add implementation of record_conflicted_index_entries()
 + tree: enable cmp_cache_name_compare() to be used elsewhere
 + merge-ort: add implementation of checkout()
 + merge-ort: basic outline for merge_switch_to_result()
 + merge-ort: step 3 of tree writing -- handling subdirectories as we go
 + merge-ort: step 2 of tree writing -- function to create tree object
 + merge-ort: step 1 of tree writing -- record basenames, modes, and oids
 + merge-ort: have process_entries operate in a defined order
 + merge-ort: add a preliminary simple process_entries() implementation
 + merge-ort: avoid recursing into identical trees
 + merge-ort: record stage and auxiliary info for every path
 + merge-ort: compute a few more useful fields for collect_merge_info
 + merge-ort: avoid repeating fill_tree_descriptor() on the same tree
 + merge-ort: implement a very basic collect_merge_info()
 + merge-ort: add an err() function similar to one from merge-recursive
 + merge-ort: use histogram diff
 + merge-ort: port merge_start() from merge-recursive
 + merge-ort: add some high-level algorithm structure
 + merge-ort: setup basic internal data structures
 + Merge branch 'en/strmap' into en/merge-ort-impl
 (this branch is used by en/merge-ort-2, en/merge-ort-3 and en/merge-ort-recursive.)

 The merge backend "done right" starts to emerge.

 Will cook in 'next'.


* es/config-hooks (2020-12-21) 34 commits
 - run-command: stop thinking about hooks
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - proc-receive: acquire hook list from hook.h
 - receive-pack: convert 'update' hook to hook.h
 - reference-transaction: look for hooks in config
 - transport: convert pre-push hook to use config
 - hook: convert 'post-rewrite' hook to config
 - hooks: convert 'post-checkout' hook to hook library
 - git-p4: use 'git hook' to run hooks
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change hook to use config
 - rebase: teach pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - merge: use config-based hooks for post-merge hook
 - am: convert applypatch hooks to use config
 - commit: use config-based hooks
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - hook: allow specifying working directory for hooks
 - hook: allow parallel hook execution
 - run-command: allow stdin for run_processes_parallel
 - hook: support passing stdin to hooks
 - hook: replace find_hook() with hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: respect hook.runHookDir
 - hook: include hookdir hook in list
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Expecting doc updates, but otherwise seems to be progressing nicely.


* hn/reftable (2020-12-21) 16 commits
 - SQUASH??? allow t0031 to run with any default branch name
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - Reftable support for git-core
 - reftable: rest of library
 - reftable: reftable file level tests
 - reftable: read reftable files
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
  (merged to 'next' on 2020-12-21 at ef5b184349)
 + merge-ort: add modify/delete handling and delayed output processing
 + merge-ort: add die-not-implemented stub handle_content_merge() function
 + merge-ort: add function grouping comments
 + merge-ort: add a paths_to_free field to merge_options_internal
 + merge-ort: add a path_conflict field to merge_options_internal
 + merge-ort: add a clear_internal_opts helper
 + merge-ort: add a few includes
 (this branch is used by en/merge-ort-3 and en/merge-ort-recursive; uses en/merge-ort-impl.)

 More "ORT" merge strategy.

 Will cook in 'next'.


* fc/pull-merge-rebase (2020-12-15) 5 commits
  (merged to 'next' on 2020-12-21 at acce13e5c4)
 + pull: display default warning only when non-ff
 + pull: correct condition to trigger non-ff advice
 + pull: get rid of unnecessary global variable
 + pull: give the advice for choosing rebase/merge much later
 + pull: refactor fast-forward check

 When a user does not tell "git pull" to use rebase or merge, the
 command gives a loud message telling a user to choose between
 rebase or merge but creates a merge anyway, forcing users who would
 want to rebase to redo the operation.  Fix an early part of this
 problem by tightening the condition to give the message---there is
 no reason to stop or force the user to choose between rebase or
 merge if the history fast-forwards.

 Will cook in 'next'.


* pk/subsub-fetch-fix-take-2 (2020-12-09) 1 commit
  (merged to 'next' on 2020-12-14 at ccc01a5f66)
 + submodules: fix of regression on fetching of non-init subsub-repo

 "git fetch --recurse-submodules" fix (second attempt).

 Will cook in 'next'.


* en/stash-apply-sparse-checkout (2020-12-01) 3 commits
 - stash: fix stash application in sparse-checkouts
 - stash: remove unnecessary process forking
 - t7012: add a testcase demonstrating stash apply bugs in sparse checkouts

 "git stash" did not work well in a sparsely checked out working
 tree.


* tb/pack-bitmap (2020-12-08) 24 commits
  (merged to 'next' on 2020-12-15 at 773268c2fb)
 + pack-bitmap-write: better reuse bitmaps
 + pack-bitmap-write: relax unique revwalk condition
 + pack-bitmap-write: use existing bitmaps
 + pack-bitmap: factor out 'add_commit_to_bitmap()'
 + pack-bitmap: factor out 'bitmap_for_commit()'
 + pack-bitmap-write: ignore BITMAP_FLAG_REUSE
 + pack-bitmap-write: build fewer intermediate bitmaps
 + pack-bitmap.c: check reads more aggressively when loading
 + pack-bitmap-write: rename children to reverse_edges
 + t5310: add branch-based checks
 + commit: implement commit_list_contains()
 + bitmap: implement bitmap_is_subset()
 + pack-bitmap-write: fill bitmap with commit history
 + pack-bitmap-write: pass ownership of intermediate bitmaps
 + pack-bitmap-write: reimplement bitmap writing
 + ewah: add bitmap_dup() function
 + ewah: implement bitmap_or()
 + ewah: make bitmap growth less aggressive
 + ewah: factor out bitmap growth
 + rev-list: die when --test-bitmap detects a mismatch
 + t5310: drop size of truncated ewah bitmap
 + pack-bitmap: bounds-check size of cache extension
 + pack-bitmap: fix header size check
 + ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()

 Various improvements to the codepath that writes out pack bitmaps.

 Will cook in 'next'.


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


--------------------------------------------------
[Discarded]

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


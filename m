Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4E8C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2B023A9B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbhAHTXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:23:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51711 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbhAHTXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 14:23:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95993106384;
        Fri,  8 Jan 2021 14:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=K
        sz7NKs3vhbefYTVo6MJfZaKP20=; b=kjxuZZ9KZx3fFkzyU/R3m2RBPIyOBaShd
        05mDccp/J5qxuwAvZhohgCgc8R2KeeS2Gs1If6i2w+Pu2iouTlMVXcXM5TpDWEPB
        mWI8CQO/KlY5Imk/OjZ04aUUyPswFjF57bj4Cg2WNVEPOuwXGMvL6ju4/PVA0xxL
        nL8nJ3yf4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=t6S
        HXEk0sH6H0WX2LA3y7gONdXuu0jzP1yq8SqLo3SpMw9JP1OZovnfwidHYlqF/ksV
        1nl4GQvdBqpyiAh5tciKunwU1ojF5KNmpXavFb2BKHDsbRNGDu6v07CxnXVjHJiq
        ueYmUaBBkGjS5kaRN1pGXhtW70NVRbskfKRm1UFw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D867106381;
        Fri,  8 Jan 2021 14:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3F0510637C;
        Fri,  8 Jan 2021 14:22:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2021, #02; Fri, 8)
X-master-at: 72c4083ddf91b489b7b7b812df67ee8842177d98
X-next-at: b2714ff1a467d5c50f82988d2216cb7d091f5c2b
Date:   Fri, 08 Jan 2021 11:22:23 -0800
Message-ID: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D711E3FE-51E6-11EB-9949-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Many topics that have been cooking in the 'next' branch during the
pre-release freeze at the year end have now been merged to the
'master' branch, and the tip of the 'next' branch has been rewound.

The ".gitignore or .gitattributes cannot be a symlink" topic has
been ejected out of 'next' for now.  We do want to resurrect it
possibly with some opt-in loosening of the rule.

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

* en/ort-directory-rename (2021-01-07) 18 commits
 - merge-ort: fix a directory rename detection bug
 - merge-ort: process_renames() now needs more defensiveness
 - merge-ort: implement apply_directory_rename_modifications()
 - merge-ort: add a new toplevel_dir field
 - merge-ort: implement handle_path_level_conflicts()
 - merge-ort: implement check_for_directory_rename()
 - merge-ort: implement apply_dir_rename() and check_dir_renamed()
 - merge-ort: implement compute_collisions()
 - merge-ort: modify collect_renames() for directory rename handling
 - merge-ort: implement handle_directory_level_conflicts()
 - merge-ort: implement compute_rename_counts()
 - merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
 - merge-ort: add outline of get_provisional_directory_renames()
 - merge-ort: add outline for computing directory renames
 - merge-ort: collect which directories are removed in dirs_removed
 - merge-ort: initialize and free new directory rename data structures
 - merge-ort: add new data structures for directory rename detection
 - Merge branch 'en/merge-ort-3' into en/ort-directory-rename
 (this branch uses en/merge-ort-3.)

 ORT merge strategy learns to infer "renamed directory" while
 merging.


* jk/forbid-lf-in-git-url (2021-01-07) 2 commits
 - fsck: reject .gitmodules git:// urls with newlines
 - git_connect_git(): forbid newlines in host and path

 Newline characters in the host and path part of git:// URL are
 now forbidden.

 Will merge to 'next'.


* ps/fetch-atomic (2021-01-07) 2 commits
 - fetch: implement support for atomic reference updates
 - fetch: allow passing a transaction to `s_update_ref()`

 "git fetch" learns to treat ref updates atomically in all-or-none
 fashion, just like "git push" does, with the new "--atomic" option.


* jc/sign-off (2021-01-07) 1 commit
 - SubmittingPatches: tighten wording on "sign-off" procedure

 Doc update.

 Will merge to 'next'.

--------------------------------------------------
[Graduated to 'master']

* ab/trailers-extra-format (2020-12-09) 5 commits
  (merged to 'next' on 2020-12-14 at 9fc731944e)
 + pretty format %(trailers): add a "key_value_separator"
 + pretty format %(trailers): add a "keyonly"
 + pretty-format %(trailers): fix broken standalone "valueonly"
 + pretty format %(trailers) doc: avoid repetition
 + pretty format %(trailers) test: split a long line

 The "--format=%(trailers)" mechanism gets enhanced to make it
 easier to design output for machine consumption.


* en/merge-ort-2 (2020-12-13) 7 commits
  (merged to 'next' on 2020-12-21 at ef5b184349)
 + merge-ort: add modify/delete handling and delayed output processing
 + merge-ort: add die-not-implemented stub handle_content_merge() function
 + merge-ort: add function grouping comments
 + merge-ort: add a paths_to_free field to merge_options_internal
 + merge-ort: add a path_conflict field to merge_options_internal
 + merge-ort: add a clear_internal_opts helper
 + merge-ort: add a few includes
 (this branch is used by en/merge-ort-3, en/merge-ort-recursive and en/ort-conflict-handling; uses en/merge-ort-impl.)

 More "ORT" merge strategy.


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
 (this branch is used by en/merge-ort-2, en/merge-ort-3, en/merge-ort-recursive and en/ort-conflict-handling.)

 The merge backend "done right" starts to emerge.


* en/merge-ort-recursive (2020-12-16) 4 commits
  (merged to 'next' on 2020-12-22 at 0dbf60011f)
 + merge-ort: implement merge_incore_recursive()
 + merge-ort: make clear_internal_opts() aware of partial clearing
 + merge-ort: copy a few small helper functions from merge-recursive.c
 + commit: move reverse_commit_list() from merge-recursive
 (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-3 and en/ort-conflict-handling.)

 The ORT merge strategy learned to synthesize virtual ancestor tree
 by recursively merging multiple merge bases together, just like the
 recursive backend has done for years.


* es/perf-export-fix (2020-12-22) 1 commit
  (merged to 'next' on 2020-12-22 at d06b0379d9)
 + t/perf: avoid unnecessary test_export() recursion

 Tweak unneeded recursion from a test framework helper function.


* es/worktree-repair-both-moved (2020-12-21) 1 commit
  (merged to 'next' on 2020-12-22 at 9eaae4f5c0)
 + worktree: teach `repair` to fix multi-directional breakage

 "git worktree repair" learned to deal with the case where both the
 repository and the worktree moved.


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


* fc/t6030-bisect-reset-removes-auxiliary-files (2020-12-21) 1 commit
  (merged to 'next' on 2020-12-22 at 2ab78ef1e1)
 + test: bisect-porcelain: fix location of files

 A 3-year old test that was not testing anything useful has been
 corrected.


* pk/subsub-fetch-fix-take-2 (2020-12-09) 1 commit
  (merged to 'next' on 2020-12-14 at ccc01a5f66)
 + submodules: fix of regression on fetching of non-init subsub-repo

 "git fetch --recurse-submodules" fix (second attempt).


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

--------------------------------------------------
[Stalled]

* ss/submodule-add-in-c (2020-12-15) 3 commits
 . t7400: add test to check 'submodule add' for tracked paths
 . submodule: port submodule subcommand 'add' from shell to C
 . dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.

 Expecting a reroll.
 The patches are split incorrectly; part of 1/3 belongs to 2/3
 cf. <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet>
 It seems to introduce a segfault on 'seen'.
 cf. <xmqqft3xflw7.fsf@gitster.c.googlers.com>


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

 Break out and fast-track bugfix from the remainder of the topic.
 cf. <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>


* mt/rm-sparse-checkout (2020-12-08) 1 commit
 - rm: honor sparse checkout patterns
 (this branch uses mt/grep-sparse-checkout.)

 "git rm" follows suit to "git grep" to ignore paths outside the
 sparsity pattern when the sparse checkout feature is in use.

 Need to wait for how these fit in larger picture.
 cf. <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
 cf. <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>


* jk/symlinked-dotgitx-files (2020-10-23) 9 commits
 - docs: document symlink restrictions for .git* files
 - fsck: complain when .gitattributes or .gitignore is a symlink
 - verify_path(): disallow symlinks in .gitattributes and .gitignore
 - t0060: test obscured .gitattributes and .gitignore matching
 - t7450: test .gitmodules symlink matching against obscured names
 - t7450: test verify_path() handling of gitmodules
 - t7415: rename to expand scope
 - fsck_tree(): wrap some long lines
 - fsck_tree(): fix shadowed variable

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 It seems that there are real projects with .gitignore recorded as
 symlinks, which may need to loosen the fsck setting.  Do we need to
 introduce a class that is separate from symlinked .gitmodules that
 has potential consequences that is more/less grave, so that these
 projects can opt out of the new checks?


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


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


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

 Got enough review comments to get updated.

--------------------------------------------------
[Cooking]

* vv/send-email-with-less-secure-apps-access (2021-01-07) 1 commit
 - git-send-email.txt: mention less secure app access with Gmail

 Doc update.

 Will merge to 'next'.


* ab/branch-sort (2021-01-07) 7 commits
 - branch: show "HEAD detached" first under reverse sort
 - branch: sort detached HEAD based on a flag
 - ref-filter: move ref_sorting flags to a bitfield
 - ref-filter: move "cmp_fn" assignment into "else if" arm
 - ref-filter: add braces to if/else if/else chain
 - branch tests: add to --sort tests
 - branch: change "--local" to "--list" in comment

 The implementation of "git branch --sort" wrt the detached HEAD
 display has always been hacky, which has been cleaned up.

 Will merge to 'next'.


* ab/coc-update-to-2.0 (2021-01-07) 3 commits
 - CoC: update to version 2.0 + local changes
 - CoC: explicitly take any whitespace breakage
 - CoC: Update word-wrapping to match upstream

 Update the Code-of-conduct to version 2.0 from the upstream (we've
 been using version 1.4).

 The first step needs to be signed off by the author, and like the
 original discussion thread back in Sep 2019, it also needs to
 collect acks from list regulars to show support.


* ar/t6016-modernise (2021-01-04) 1 commit
  (merged to 'next' on 2021-01-08 at 45f1b43e88)
 + t6016: move to lib-log-graph.sh framework

 Test update.

 Will merge to 'master'.


* dl/reflog-with-single-entry (2021-01-07) 2 commits
 - refs: allow @{n} to work with n-sized reflog
 - refs: factor out set_read_ref_cutoffs()

 After expiring a reflog and making a single commit, the reflog for
 the branch would record a single entry that knows both @{0} and
 @{1}, but we failed to answer "what commit were we on?", i.e. @{1}


* ds/cache-tree-basics (2021-01-07) 10 commits
 - cache-tree: speed up consecutive path comparisons
 - cache-tree: use ce_namelen() instead of strlen()
 - index-format: discuss recursion of cached-tree better
 - index-format: update preamble to cache tree extension
 - index-format: use 'cache tree' over 'cached tree'
 - cache-tree: trace regions for prime_cache_tree
 - cache-tree: trace regions for I/O
 - cache-tree: use trace2 in cache_tree_update()
 - unpack-trees: add trace2 regions
 - tree-walk: report recursion counts

 Document, clean-up and optimize the code around the cache-tree
 extension in the index.


* ds/for-each-repo-noopfix (2021-01-07) 1 commit
 - for-each-repo: do nothing on empty config

 "git for-each-repo --config=<var> <cmd>" should not run <cmd> for
 any repository when the configuration variable <var> is not defined
 even once.

 Will merge to 'next'.


* ds/trace2-topo-walk (2021-01-04) 1 commit
  (merged to 'next' on 2021-01-08 at 794c8f37ee)
 + revision: trace topo-walk statistics

 The topological walk codepath is covered by new trace2 stats.

 Will merge to 'master'.


* en/ort-conflict-handling (2021-01-04) 10 commits
 - merge-ort: add handling for different types of files at same path
 - merge-ort: copy find_first_merges() implementation from merge-recursive.c
 - merge-ort: implement format_commit()
 - merge-ort: copy and adapt merge_submodule() from merge-recursive.c
 - merge-ort: copy and adapt merge_3way() from merge-recursive.c
 - merge-ort: flesh out implementation of handle_content_merge()
 - merge-ort: handle book-keeping around two- and three-way content merge
 - merge-ort: implement unique_path() helper
 - merge-ort: handle directory/file conflicts that remain
 - merge-ort: handle D/F conflict where directory disappears due to merge

 ORT merge strategy learns more support for merge conflicts.


* fc/completion-aliases-support (2021-01-04) 4 commits
  (merged to 'next' on 2021-01-08 at b2714ff1a4)
 + completion: add proper public __git_complete
 + test: completion: add tests for __git_complete
 + completion: bash: improve function detection
 + completion: bash: add __git_have_func helper

 Bash completion (in contrib/) update to make it easier for
 end-users to add completion for their custom "git" subcommands.

 Will merge to 'master'.


* ma/doc-pack-format-varint-for-sizes (2021-01-04) 1 commit
  (merged to 'next' on 2021-01-08 at 8a448c50dd)
 + pack-format.txt: document sizes at start of delta data

 Doc update.

 Will merge to 'master'.


* ma/more-opaque-lock-file (2021-01-06) 5 commits
 - read-cache: try not to peek into `struct {lock_,temp}file`
 - refs/files-backend: don't peek into `struct lock_file`
 - midx: don't peek into `struct lock_file`
 - commit-graph: don't peek into `struct lock_file`
 - builtin/gc: don't peek into `struct lock_file`

 Code clean-up.

 Will merge to 'next'.


* ma/sha1-is-a-hash (2021-01-04) 4 commits
  (merged to 'next' on 2021-01-08 at a25537f7c3)
 + hash-lookup: rename from sha1-lookup
 + sha1-lookup: rename `sha1_pos()` as `hash_pos()`
 + object-file.c: rename from sha1-file.c
 + object-name.c: rename from sha1-name.c

 Retire more names with "sha1" in it.

 Will merge to 'master'.


* ma/t1300-cleanup (2021-01-04) 3 commits
  (merged to 'next' on 2021-01-08 at 51aaae39a1)
 + t1300: don't needlessly work with `core.foo` configs
 + t1300: remove duplicate test for `--file no-such-file`
 + t1300: remove duplicate test for `--file ../foo`

 Code clean-up.

 Will merge to 'master'.


* mt/t4129-with-setgid-dir (2021-01-06) 1 commit
 - t4129: don't fail if setgid is set in the test directory

 Some tests expect that "ls -l" output has either '-' or 'x' for
 group executable bit, but setgid bit can be inherited from parent
 directory and make these fields 'S' or 's' instead, causing test
 failures.

 Will merge to 'next'.


* nk/perf-fsmonitor-cleanup (2021-01-06) 1 commit
  (merged to 'next' on 2021-01-08 at 1837d6c30b)
 + p7519: allow running without watchman prereq

 Test fix.

 Will merge to 'master'.


* pb/doc-modules-git-work-tree-typofix (2021-01-04) 1 commit
  (merged to 'next' on 2021-01-08 at a67ab3e96a)
 + gitmodules.txt: fix 'GIT_WORK_TREE' variable name

 Doc fix.

 Will merge to 'master'.


* pb/mergetool-tool-help-fix (2021-01-06) 1 commit
 - mergetool--lib: fix '--tool-help' to correctly show available tools

 Fix 2.29 regression where "git mergetool --tool-help" fails to list
 all the available tools.

 Will merge to 'next'.


* rs/rebase-commit-validation (2021-01-04) 1 commit
  (merged to 'next' on 2021-01-08 at 2c63eb1cc8)
 + rebase: verify commit parameter

 Diagnose command line error early.

 Will merge to 'master'.


* sg/t7800-difftool-robustify (2021-01-04) 1 commit
 . t7800-difftool: don't accidentally match tmp dirs

 Test fix.

 Not working on Windows.
 cf. https://github.com/git/git/runs/1660588243?check_suite_focus=true#step:7:4186


* ta/doc-typofix (2021-01-04) 1 commit
  (merged to 'next' on 2021-01-08 at 1e579ef94f)
 + doc: fix some typos

 Doc fix.

 Will merge to 'master'.


* zh/arg-help-format (2021-01-06) 2 commits
  (merged to 'next' on 2021-01-08 at 208c98620c)
 + builtin/*: update usage format
 + parse-options: format argh like error messages

 Clean up option descriptions in "git cmd --help".

 Will merge to 'master'.


* ak/corrected-commit-date (2021-01-04) 11 commits
 - doc: add corrected commit date info
 - commit-reach: use corrected commit dates in paint_down_to_common()
 - commit-graph: use generation v2 only if entire chain does
 - commit-graph: implement generation data chunk
 - commit-graph: implement corrected commit date
 - commit-graph: return 64-bit generation number
 - commit-graph: add a slab to store topological levels
 - t6600-test-reach: generalize *_three_modes
 - commit-graph: consolidate fill_commit_graph_info
 - revision: parse parent in indegree_walk_step()
 - commit-graph: fix regression when computing Bloom filters

 The commit-graph learned to use corrected commit dates instead of
 the generation number to help topological revision traversal.

 Getting there, but not needs more help to find and resolve segv.
 cf. <1adabda6-b80b-d543-f6c0-570dadbe589b@gmail.com>


* dl/p4-encode-after-kw-expansion (2020-12-23) 1 commit
 - git-p4: fix syncing file types with pattern

 Text encoding fix for "git p4".


* fc/mergetool-automerge (2021-01-06) 5 commits
 . mergetool: add automerge_enabled tool-specific override function
 . mergetool: break setup_tool out into separate initialization function
 . mergetool: add per-tool support for the autoMerge flag
 . mergetool: alphabetize the mergetool config docs
 . mergetool: add automerge configuration

 "git mergetool" feeds three versions (base, local and remote) of
 a conflicted path unmodified.  The command learned to optionally
 prepare these files with unconflicted parts already resolved.

 Breaks tests on macOS.
 cf. https://github.com/git/git/runs/1659807735?check_suite_focus=true#step:4:1641


* ew/decline-core-abbrev (2020-12-23) 1 commit
  (merged to 'next' on 2021-01-08 at 630dd186a4)
 + core.abbrev=no disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

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

 What's the status of this thing?


* jt/clone-unborn-head (2020-12-22) 3 commits
 - clone: respect remote unborn HEAD
 - connect, transport: add no-op arg for future patch
 - ls-refs: report unborn targets of symrefs

 "git clone" tries to locally check out the branch pointed at by
 HEAD of the remote repository after it is done, but the protocol
 did not convey the information necessary to do so when copying an
 empty repository.  The protocol v2 learned how to do so.

 What's the status of this thing?


* fc/bash-completion-post-2.29 (2020-12-23) 4 commits
 - completion: bash: add correct suffix in variables
 - completion: bash: fix for multiple dash commands
 - completion: bash: fix for suboptions with value
 - completion: bash: fix prefix detection in branch.*

 Seems to break tests on Windows


* jc/deprecate-pack-redundant (2020-12-15) 1 commit
 - pack-redundant: gauge the usage before proposing its removal

 Warn loudly when the "pack-redundant" command, which has been left
 stale with almost unusable performance issues, gets used, as we no
 longer want to recommend its use (instead just "repack -d" instead).

 Will merge to 'next'.


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
  (merged to 'next' on 2021-01-08 at fe481b9627)
 + merge-ort: add implementation of type-changed rename handling
 + merge-ort: add implementation of normal rename handling
 + merge-ort: add implementation of rename collisions
 + merge-ort: add implementation of rename/delete conflicts
 + merge-ort: add implementation of both sides renaming differently
 + merge-ort: add implementation of both sides renaming identically
 + merge-ort: add basic outline for process_renames()
 + merge-ort: implement compare_pairs() and collect_renames()
 + merge-ort: implement detect_regular_renames()
 + merge-ort: add initial outline for basic rename detection
 + merge-ort: add basic data structures for handling renames
 (this branch is used by en/ort-directory-rename.)

 Rename detection is added to the "ORT" merge strategy.

 Will merge to 'master'.


* ps/config-env-pairs (2021-01-06) 8 commits
 - config: allow specifying config entries via envvar pairs
 - environment: make `getenv_safe()` a public function
 - config: parse more robust format in GIT_CONFIG_PARAMETERS
 - config: store "git -c" variables using more robust format
 - config: extract function to parse config pairs
 - quote: make sq_dequote_step() a public function
 - config: add new way to pass config via `--config-env`
 - git: add `--super-prefix` to usage string

 Introduce two new ways to feed configuration variable-value pairs
 via environment variables, and tweak the way GIT_CONFIG_PARAMETERS
 encodes variable/value pairs to make it more robust.

 Ready for 'next'?


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
  (merged to 'next' on 2021-01-08 at 7d51587b7f)
 + rev-parse: add option for absolute or relative path formatting
 + abspath: add a function to resolve paths with missing components

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.

 Will merge to 'master'.


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


* ab/mktag (2021-01-06) 23 commits
  (merged to 'next' on 2021-01-08 at 6f9e11ad97)
 + mktag: add a --[no-]strict option
 + mktag: mark strings for translation
 + mktag: convert to parse-options
 + mktag: allow omitting the header/body \n separator
 + mktag: allow turning off fsck.extraHeaderEntry
 + fsck: make fsck_config() re-usable
 + mktag: use fsck instead of custom verify_tag()
 + mktag: use puts(str) instead of printf("%s\n", str)
 + mktag: remove redundant braces in one-line body "if"
 + mktag: use default strbuf_read() hint
 + mktag tests: test verify_object() with replaced objects
 + mktag tests: improve verify_object() test coverage
 + mktag tests: test "hash-object" compatibility
 + mktag tests: stress test whitespace handling
 + mktag tests: run "fsck" after creating "mytag"
 + mktag tests: don't create "mytag" twice
 + mktag tests: don't redirect stderr to a file needlessly
 + mktag tests: remove needless SHA-1 hardcoding
 + mktag tests: use "test_commit" helper
 + mktag tests: don't needlessly use a subshell
 + mktag doc: update to explain why to use this
 + mktag doc: grammar fix, when exists -> when it exists
 + mktag doc: say <hash> not <sha1>

 "git mktag" validates its input using its own rules before writing
 a tag object---it has been updated to share the logic with "git
 fsck".

 Will merge to 'master'.


* en/diffcore-rename (2021-01-04) 9 commits
 - diffcore-rename: remove unnecessary duplicate entry checks
 - diffcore-rename: accelerate rename_dst setup
 - diffcore-rename: simplify and accelerate register_rename_src()
 - t4058: explore duplicate tree entry handling in a bit more detail
 - t4058: add more tests and documentation for duplicate tree entry handling
 - diffcore-rename: reduce jumpiness in progress counters
 - diffcore-rename: simplify limit check
 - diffcore-rename: avoid usage of global in too_many_rename_candidates()
 - diffcore-rename: rename num_create to num_destinations

 File-level rename detection updates.

 Will merge to 'next'.


* en/stash-apply-sparse-checkout (2020-12-01) 3 commits
  (merged to 'next' on 2021-01-08 at cae5b73d99)
 + stash: fix stash application in sparse-checkouts
 + stash: remove unnecessary process forking
 + t7012: add a testcase demonstrating stash apply bugs in sparse checkouts

 "git stash" did not work well in a sparsely checked out working
 tree.

 Will merge to 'master'.


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

 Will merge to 'next'.


* ds/maintenance-part-4 (2021-01-05) 4 commits
  (merged to 'next' on 2021-01-08 at 1f98c859ea)
 + maintenance: use Windows scheduled tasks
 + maintenance: use launchctl on macOS
 + maintenance: include 'cron' details in docs
 + maintenance: extract platform-specific scheduling

 Follow-up on the "maintenance part-3" which introduced scheduled
 maintenance tasks to support platforms whose native scheduling
 methods are not 'cron'.

 Will merge to 'master'.


* sj/untracked-files-in-submodule-directory-is-not-dirty (2020-12-08) 1 commit
 - diff: do not show submodule with untracked files as "-dirty"

 "git diff" showed a submodule working tree with untracked cruft as
 "Submodule commit <objectname>-dirty", but a natural expectation is
 that the "-dirty" indicator would align with "git describe --dirty",
 which does not consider having untracked files in the working tree
 as source of dirtiness.  The inconsistency has been fixed.

 Will merge to 'next'.

--------------------------------------------------
[Discarded]

* jc/config-pretend-gitdir (2020-12-15) 1 commit
 . config: --pretend-git-dir for includeIf:gitdir

 It turns out that the original "problem" that inspired the feature
 was working as designed.
 cf. <CAPQE4+rhWT9kgusNXOw5cnJ-oFq++4G1FMaXvQ3wppQ0GE0hSA@mail.gmail.com>

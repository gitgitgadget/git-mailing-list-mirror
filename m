Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD9AC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 00:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F97611C6
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 00:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhHGARm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 20:17:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50992 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhHGARm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 20:17:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A3DF066F;
        Fri,  6 Aug 2021 20:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=vaIYIQaeUCXlbNjjVemOsnzKp
        loYskXdNASvw48lmmM=; b=ZZ3PB1r9JAiYPDdUJdYYyRnVwLpAOHIYP/2PhEg6a
        a853Jb8ahl9SXBDnESxdUFFj5gXMhsp350oLq7AMaN/deiGhZaLaEeZ6acDEEQ04
        GDZs4xusnb4VLPFMR+TI7aY58tPAy5y6npdTpGpxn0s84zbpgtD7Sd3Xl5A5JWj/
        bk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A69DF066E;
        Fri,  6 Aug 2021 20:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8ED6F066D;
        Fri,  6 Aug 2021 20:17:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2021, #03; Fri, 6)
X-master-at: 2d755dfac9aadab25c3e025b849252b8c0a61465
X-next-at: 0d66db33f37daf054bbe20901c0ccadbc4558854
Date:   Fri, 06 Aug 2021 17:17:23 -0700
Message-ID: <xmqqzgtuf6r0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D73722EE-F714-11EB-BDAF-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen',
which means nothing more than that I have found them of interest for
some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful").  Do not read too much into a topic being in (or not in)
'seen'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.

Git 2.33-rc1 has been tagged.  The much less invasive "shopt -u
checkwinsize" approach will be used to address the COLUMNS issue at
least for the final release.  I do not know what we want to do with
the "log -m" means "log -m -p" issue yet (we haven't heard from the
other camp), so it is in a "broken" state in -rc1.

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

* ab/getcwd-test (2021-07-30) 1 commit
  (merged to 'next' on 2021-08-02 at 22ecd02929)
 + t0001: fix broken not-quite getcwd(3) test in bed67874e2

 Portability test update.


* ab/pickaxe-pcre2 (2021-08-04) 1 commit
  (merged to 'next' on 2021-08-05 at 2c90b51f76)
 + diff: --pickaxe-all typofix

 Documentation update.


* ab/update-submitting-patches (2021-07-22) 2 commits
  (merged to 'next' on 2021-07-30 at 9ae2de7f7a)
 + SubmittingPatches: replace discussion of Travis with GitHub Actions
 + SubmittingPatches: move discussion of Signed-off-by above "send"

 Reorganize and update the SubmitingPatches document.


* ah/plugleaks (2021-07-26) 12 commits
  (merged to 'next' on 2021-07-28 at fa15f6d1f4)
 + reset: clear_unpack_trees_porcelain to plug leak
 + builtin/rebase: fix options.strategy memory lifecycle
 + builtin/merge: free found_ref when done
 + builtin/mv: free or UNLEAK multiple pointers at end of cmd_mv
 + convert: release strbuf to avoid leak
 + read-cache: call diff_setup_done to avoid leak
 + ref-filter: also free head for ATOM_HEAD to avoid leak
 + diffcore-rename: move old_dir/new_dir definition to plug leak
 + builtin/for-each-repo: remove unnecessary argv copy to plug leak
 + builtin/submodule--helper: release unused strbuf to avoid leak
 + environment: move strbuf into block to plug leak
 + fmt-merge-msg: free newly allocated temporary strings when done

 Leak plugging.


* ar/doc-markup-fix (2021-07-30) 1 commit
  (merged to 'next' on 2021-08-02 at b99073fa75)
 + Documentation: render special characters correctly

 Doc mark-up fix.


* ar/submodule-add (2021-07-26) 5 commits
  (merged to 'next' on 2021-07-28 at 7d315a0f67)
 + submodule: drop unused sm_name parameter from show_fetch_remotes()
  (merged to 'next' on 2021-07-22 at b8b636c9a1)
 + submodule--helper: introduce add-clone subcommand
 + submodule--helper: refactor module_clone()
 + submodule: prefix die messages with 'fatal'
 + t7400: test failure to add submodule in tracked path
 (this branch is used by ar/submodule-add-config.)

 Rewrite of "git submodule" in C continues.


* cb/t7508-regexp-fix (2021-08-02) 1 commit
  (merged to 'next' on 2021-08-04 at 87e2b70ba1)
 + t7508: avoid non POSIX BRE

 Test fix.


* ds/commit-and-checkout-with-sparse-index (2021-07-20) 7 commits
  (merged to 'next' on 2021-07-30 at 52ed1b0091)
 + unpack-trees: resolve sparse-directory/file conflicts
 + t1092: document bad 'git checkout' behavior
 + checkout: stop expanding sparse indexes
 + sparse-index: recompute cache-tree
 + commit: integrate with sparse-index
 + p2000: compress repo names
 + p2000: add 'git checkout -' test and decrease depth
 (this branch is used by ds/add-with-sparse-index.)

 "git checkout" and "git commit" learn to work without unnecessarily
 expanding sparse indexes.


* en/ort-perf-batch-14 (2021-07-20) 7 commits
  (merged to 'next' on 2021-07-30 at 89cfdc4513)
 + merge-ort: restart merge with cached renames to reduce process entry c=
ost
 + merge-ort: avoid recursing into directories when we don't need to
 + merge-ort: defer recursing into directories when merge base is matched
 + merge-ort: add a handle_deferred_entries() helper function
 + merge-ort: add data structures for allowable trivial directory resolve=
s
 + merge-ort: add some more explanations in collect_merge_info_callback()
 + merge-ort: resolve paths early when we have sufficient information
 (this branch is used by en/ort-perf-batch-15.)

 Further optimization on "merge -sort" backend.


* pb/merge-autostash-more (2021-07-23) 4 commits
  (merged to 'next' on 2021-07-30 at bfc8b41932)
 + merge: apply autostash if merge strategy fails
 + merge: apply autostash if fast-forward fails
 + Documentation: define 'MERGE_AUTOSTASH'
 + merge: add missing word "strategy" to a message

 The local changes stashed by "git merge --autostash" were lost when
 the merge failed in certain ways, which has been corrected.


* rs/use-fspathhash (2021-07-30) 1 commit
  (merged to 'next' on 2021-08-02 at 72c388e867)
 + use fspathhash() everywhere

 Code simplification.


* tb/mingw-rmdir-symlink-to-directory (2021-08-02) 1 commit
  (merged to 'next' on 2021-08-03 at a027d43cca)
 + mingw: align symlinks-related rmdir() behavior with Linux

 Windows rmdir() equivalent behaves differently from POSIX ones in
 that when used on a symbolic link that points at a directory, the
 target directory gets removed, which has been corrected.

--------------------------------------------------
[New Topics]

* ps/fetch-pack-load-refs-optim (2021-08-04) 1 commit
 - fetch-pack: speed up loading of refs via commit graph

 Loading of ref tips to prepare for common ancestry negotiation in
 "git fetch-pack" has been optimized by taking advantage of the
 commit graph when available.

 Will merge to 'next'.


* ps/connectivity-optim (2021-08-05) 6 commits
 - revision: avoid hitting packfiles when commits are in commit-graph
 - commit-graph: split out function to search commit position
 - revision: avoid loading object headers multiple times
 - revision: stop retrieving reference twice
 - connected: do not sort input revisions
 - revision: separate walk and unsorted flags

 The revision traversal API has been optimized by taking advanrage
 of the commit-graph, when available, to determine if a commit is
 reachable from any of the existing refs.

 Looking good.


* ar/submodule-add-more (2021-08-06) 9 commits
 - submodule--helper: remove resolve-relative-url subcommand
 - submodule--helper: remove add-config subcommand
 - submodule--helper: remove add-clone subcommand
 - submodule--helper: convert the bulk of cmd_add() to C
 - dir: libify and export helper functions from clone.c
 - submodule--helper: remove repeated code in sync_submodule()
 - submodule--helper: refactor resolve_relative_url() helper
 - submodule--helper: add options for compute_submodule_clone_url()
 - Merge branch 'ar/submodule-add-config' into ar/submodule-add
 (this branch uses ar/submodule-add-config.)

 More parts of "git submoudle add" has been rewritten in C.


* cb/makefile-apple-clang (2021-08-06) 3 commits
 - build: catch clang that identifies itself as "$VENDOR clang"
 - build: clang version may not be followed by extra words
 - build: update detect-compiler for newer Xcode version

 Build update.


* jk/refs-files-cleanup-cleanup (2021-08-06) 1 commit
 - refs: drop unused "flags" parameter to lock_ref_oid_basic()
 (this branch uses ab/refs-files-cleanup.)

 Code cleanup.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* gh/gitweb-branch-sort (2021-06-10) 1 commit
 - gitweb: use HEAD as secondary sort key in git_get_heads_list()

 Tie-break branches that point at the same object in the list of
 branches on GitWeb to show the one pointed at by HEAD early.

 Waiting for reviews.


* lh/systemd-timers (2021-07-02) 3 commits
 - maintenance: add support for systemd timers on Linux
 - maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>`
 - cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" function

 "git maintenance" scheduler learned to use systemd timers as a
 possible backend.

 Waiting for reviews.


* fc/completion-updates (2021-06-07) 4 commits
 - completion: bash: add correct suffix in variables
 - completion: bash: fix for multiple dash commands
 - completion: bash: fix for suboptions with value
 - completion: bash: fix prefix detection in branch.*

 Command line completion updates.

 Expecting a reroll.
 cf. <60be6f7fa4435_db80d208f2@natae.notmuch>


* es/superproject-aware-submodules (2021-06-16) 5 commits
 - SQUASH???
 - submodule: cache superproject gitdir during 'update'
 - submodule: cache superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir cache
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Waiting for reviews.


* en/zdiff3 (2021-06-15) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.

 Expecting a reroll.
 cf. <CABPp-BE7-E03+x38EK-=3DAE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.co=
m>


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.

 Waiting for reviews.

--------------------------------------------------
[Cooking]

* cb/reftable-fixup (2021-08-02) 3 commits
 - openbsd: allow reftable building with zlib 1.2.3
 - reftable: clarify zlib version dependency
 - fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
 (this branch uses hn/reftable.)

 Fixes to another topic.

 Will discard after they are picked up by the target topic.


* en/merge-strategy-docs (2021-08-05) 10 commits
 - Update error message and code comment
 - merge-strategies.txt: add coverage of the `ort` merge strategy
 - git-rebase.txt: correct out-of-date and misleading text about renames
 - merge-strategies.txt: fix simple capitalization error
 - merge-strategies.txt: avoid giving special preference to patience algo=
rithm
 - merge-strategies.txt: do not imply using copy detection is desired
 - merge-strategies.txt: update wording for the resolve strategy
 - Documentation: edit awkward references to `git merge-recursive`
 - directory-rename-detection.txt: small updates due to merge-ort optimiz=
ations
 - git-rebase.txt: correct antiquated claims about --rebase-merges
 (this branch is used by en/ort-becomes-the-default.)

 Documentation updates.

 Expecting a (hopefully final) reroll.


* en/ort-becomes-the-default (2021-08-05) 2 commits
 - Update docs for change of default merge backend
 - Change default merge backend from recursive to ort
 (this branch uses en/merge-strategy-docs.)

 Use `ort` instead of `recursive` as the default merge strategy.

 Waiting for the base topic to settle.


* js/log-protocol-version (2021-08-03) 1 commit
 - connect, protocol: log negotiated protocol version

 Debugging aid.

 Expecting a reroll.


* ow/clone-bare-origin (2021-08-03) 1 commit
 - clone: Allow combining --bare and --origin

 "git clone" did not like to take "--bare" and "--origin=3DX" at the
 same time; loosen the restriction.

 Under discussion.  This may require some follow-on work.
 cf. <20210802174944.53745-1-oystwa@gmail.com>


* jc/bisect-sans-show-branch (2021-07-28) 2 commits
  (merged to 'next' on 2021-08-02 at 89a8d9a47b)
 + bisect: simplify return code from bisect_checkout()
 + bisect: do not run show-branch just to show the current commit

 "git bisect" spawned "git show-branch" only to pretty-print the
 title of the commit after checking out the next version to be
 tested; this has been rewritten in C.

 Will cook in 'next'.


* jc/trivial-threeway-binary-merge (2021-07-28) 1 commit
 - ll-merge: teach ll_binary_merge() a trivial three-way merge

 The built-in merge driver for binary files learned to resolve
 trivial three-way merges (e.g. apply change, which turns A into B,
 to content A) by itself, which would help "git apply --3way" used
 when there is no need to use "--3way".

 Will discard.
 Replace with a trivial-merge logic in apply.c::try_treeway() or
 apply.c::three_way_merge().


* ab/http-drop-old-curl (2021-07-30) 5 commits
  (merged to 'next' on 2021-08-02 at b382ac042f)
 + http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
 + http: drop support for curl < 7.19.3 and < 7.17.0 (again)
 + http: drop support for curl < 7.19.4
 + http: drop support for curl < 7.16.0
 + http: drop support for curl < 7.11.1

 Support for ancient versions of cURL library has been dropped.

 Will cook in 'next'.


* ab/lib-subtest (2021-08-05) 11 commits
 - test-lib tests: assert 1 exit code, not non-zero
 - test-lib tests: refactor common part of check_sub_test_lib_test*()
 - test-lib tests: avoid subshell for "test_cmp" for readability
 - test-lib tests: assert no copy/pasted mock test code
 - test-lib tests: get rid of copy/pasted mock test code
 - test-lib tests: don't provide a description for the sub-tests
 - test-lib tests: stop using a subshell in write_sub_test_lib_test()
 - test-lib tests: split up "write and run" into two functions
 - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
 - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest

 Updates to the tests in t0000 to test the test framework.


* ds/add-with-sparse-index (2021-07-29) 5 commits
  (merged to 'next' on 2021-08-02 at ee3e1323bb)
 + add: remove ensure_full_index() with --renormalize
 + add: ignore outside the sparse-checkout in refresh()
 + pathspec: stop calling ensure_full_index
 + add: allow operating on a sparse-only index
 + t1092: test merge conflicts outside cone

 "git add" can work better with the sparse index.

 Will cook in 'next'.


* ab/only-single-progress-at-once (2021-07-23) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - pack-bitmap-write.c: add a missing stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: stop eagerly fflush(stderr) when not a terminal
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin

 Further tweaks on progress API.


* ab/progress-users-adjust-counters (2021-08-05) 3 commits
 - entry: show finer-grained counter in "Filtering content" progress line
 - midx: don't provide a total for QSORT() progress
 - commit-graph: fix bogus counter in "Scanning merged commits" progress =
line

 The code to show progress indicator in a few codepaths did not
 cover between 0-100%, which has been corrected.


* ar/submodule-add-config (2021-08-05) 1 commit
 - submodule--helper: introduce add-config subcommand
 (this branch is used by ar/submodule-add-more.)

 Large part of "git submodule add" gets rewritten in C.


* en/ort-perf-batch-15 (2021-08-03) 9 commits
  (merged to 'next' on 2021-08-04 at 87fc290e71)
 + merge-ort: remove compile-time ability to turn off usage of memory poo=
ls
 + merge-ort: reuse path strings in pool_alloc_filespec
 + merge-ort: store filepairs and filespecs in our mem_pool
 + diffcore-rename, merge-ort: add wrapper functions for filepair alloc/d=
ealloc
 + merge-ort: switch our strmaps over to using memory pools
 + merge-ort: set up a memory pool
 + merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
 + diffcore-rename: use a mem_pool for exact rename detection's hashmap
 + merge-ort: rename str{map,intmap,set}_func()

 Final batch for "merge -sort" optimization.

 Will cook in 'next'.


* js/expand-runtime-prefix (2021-07-26) 6 commits
  (merged to 'next' on 2021-08-04 at b95a81a004)
 + expand_user_path: allow in-flight topics to keep using the old name
 + interpolate_path(): allow specifying paths relative to the runtime pre=
fix
 + Use a better name for the function interpolating paths
 + expand_user_path(): clarify the role of the `real_home` parameter
 + expand_user_path(): remove stale part of the comment
 + tests: exercise the RUNTIME_PREFIX feature

 Pathname expansion (like "~username/") learned a way to specify a
 location relative to Git installation (e.g. its $sharedir which is
 $(prefix)/share), with "%(prefix)".

 Will cook in 'next'.


* zh/cherry-pick-help-is-only-for-sequencer (2021-08-03) 2 commits
  (merged to 'next' on 2021-08-04 at 9ea14ed106)
 + cherry-pick: use better advice message
 + cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP

 "git cherry-pick" loses its state file when a stray
 GIT_CHERRY_PICK_HELP environment is present, which has been
 corrected.

 Will cook in 'next'.


* dt/submodule-diff-fixes (2021-08-02) 3 commits
 - diff --submodule=3Ddiff: Don't print failure message twice
 - diff --submodule=3Ddiff: do not fail on ever-initialied deleted submod=
ules
 - t4060: remove unused variable

 "git diff --submodule=3Ddiff" showed failure from run_command() when
 trying to run diff inside a submodule, when the user manually
 removes the submodule directory.

 Seems to break CI when merged to 'seen'
 cf. https://github.com/git/git/runs/3259477809?check_suite_focus=3Dtrue#=
step:4:2618


* fs/ssh-signing (2021-08-03) 9 commits
 - ssh signing: test that gpg fails for unkown keys
 - ssh signing: tests for logs, tags & push certs
 - ssh signing: duplicate t7510 tests for commits
 - ssh signing: verify signatures using ssh-keygen
 - ssh signing: provide a textual signing_key_id
 - ssh signing: retrieve a default key from ssh-agent
 - ssh signing: add ssh key format and signing code
 - ssh signing: add test prereqs
 - ssh signing: preliminary refactoring and clean-up

 Use ssh public crypto for object and push-cert signing.

 Comments?


* hn/refs-test-cleanup (2021-08-02) 11 commits
  (merged to 'next' on 2021-08-04 at 5651c32f4b)
 + t6001: avoid direct file system access
 + t6500: use "ls -1" to snapshot ref database state
 + t7064: use update-ref -d to remove upstream branch
 + t1410: mark test as REFFILES
 + t1405: mark test for 'git pack-refs' as REFFILES
 + t1405: use 'git reflog exists' to check reflog existence
 + t2402: use ref-store test helper to create broken symlink
 + t3320: use git-symbolic-ref rather than filesystem access
 + t6120: use git-update-ref rather than filesystem access
 + t1503: mark symlink test as REFFILES
 + t6050: use git-update-ref rather than filesystem access

 A handful of tests that assumed implementation details of files
 backend for refs have been cleaned up.

 Will cook in 'next'.


* hn/reftable (2021-07-20) 26 commits
 - t7004: avoid direct filesystem access
 - t1404: annotate test cases with REFFILES
 - t1401,t2011: parameterize HEAD.lock for REFFILES
 - t1301: document what needs to be done for reftable
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - refs: RFC: Reftable support for git-core
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
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: RFC: add LICENSE
 - init-db: set the_repository->hash_algo early on
 - hash.h: provide constants for the hash IDs
 (this branch is used by cb/reftable-fixup.)

 The "reftable" backend for the refs API.

 Seems to break CI jobs in 'seen'.
 cf. https://github.com/git/git/runs/3257622953?check_suite_focus=3Dtrue#=
step:4:1685


* ab/refs-files-cleanup (2021-08-02) 11 commits
  (merged to 'next' on 2021-08-04 at 8ca0ef1b6e)
 + refs/files: remove unused "errno !=3D ENOTDIR" condition
 + refs/files: remove unused "errno =3D=3D EISDIR" code
 + refs/files: remove unused "oid" in lock_ref_oid_basic()
 + reflog expire: don't lock reflogs using previously seen OID
 + refs/files: add a comment about refs_reflog_exists() call
 + refs: make repo_dwim_log() accept a NULL oid
 + refs/debug: re-indent argument list for "prepare"
 + refs/files: remove unused "skip" in lock_raw_ref() too
 + refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 + refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 + refs/packet: add missing BUG() invocations to reflog callbacks
 (this branch is used by hn/refs-errno-cleanup and jk/refs-files-cleanup-=
cleanup.)

 Will cook in 'next'.


* en/pull-conflicting-options (2021-07-22) 8 commits
 - pull: fix handling of multiple heads
 - pull: update docs & code for option compatibility with rebasing
 - pull: abort by default when fast-forwarding is not possible
 - pull: make --rebase and --no-rebase override pull.ff=3Donly
 - pull: since --ff-only overrides, handle it first
 - pull: abort if --ff-only is given and fast-forwarding is impossible
 - t7601: add tests of interactions with multiple merge heads and config
 - t7601: test interaction of merge/rebase/fast-forward flags and options

 "git pull" had various corner cases that were not well thought out
 around its --rebase backend, e.g. "git pull --ff-only" did not stop
 but went ahead and rebased when the history on other side is not a
 descendant of our history.  The series tries to fix them up.

 Comments?


* bc/inactive-submodules (2021-07-02) 1 commit
 - submodule: mark submodules with update=3Dnone as inactive

 Usability update for inactive submodules.

 Comments?
 cf. <fc5ec100-1d42-4199-236e-7a99c9218f38@gmail.com>
 cf. <bf1893ee-6973-d8b2-659e-bb239a0a9ae2@gmail.com>


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 cf. <xmqqsg0ri5mq.fsf@gitster.g>


* ab/bundle-doc (2021-08-02) 4 commits
  (merged to 'next' on 2021-08-04 at b3b3b0fa98)
 + bundle doc: replace "basis" with "prerequsite(s)"
 + bundle doc: elaborate on rev<->ref restriction
 + bundle doc: elaborate on object prerequisites
 + bundle doc: rewrite the "DESCRIPTION" section

 Doc update.

 Will cook in 'next'.


* ab/pack-stdin-packs-fix (2021-07-09) 2 commits
  (merged to 'next' on 2021-08-04 at f464b74a6f)
 + pack-objects: fix segfault in --stdin-packs option
 + pack-objects tests: cover blindspots in stdin handling

 Input validation of "git pack-objects --stdin-packs" has been
 corrected.

 Will cook in 'next'.


* jt/push-negotiation-fixes (2021-07-15) 3 commits
 - fetch: die on invalid --negotiation-tip hash
 - send-pack: fix push nego. when remote has refs
 - send-pack: fix push.negotiate with remote helper

 Bugfix for common ancestor negotiation recently introduced in "git
 push" codepath.

 Needs review.


* ab/make-tags-cleanup (2021-08-05) 5 commits
 - Makefile: normalize clobbering & xargs for tags targets
 - Makefile: remove "cscope.out", not "cscope*" in cscope.out target
 - Makefile: don't use "FORCE" for tags targets
 - Makefile: add QUIET_GEN to "cscope" target
 - Makefile: move ".PHONY: cscope" near its target

 Build clean-up for "make tags" and friends.

 Expecting a reroll.
 4/5 may want a minor tweak to the log and the patch text but otherwise l=
ooks good.


* tb/multi-pack-bitmaps (2021-07-27) 25 commits
 - p5326: perf tests for MIDX bitmaps
 - p5310: extract full and partial bitmap tests
 - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - t7700: update to work with MIDX bitmap test knob
 - t5319: don't write MIDX bitmaps in t5319
 - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t5326: test multi-pack bitmap behavior
 - t/helper/test-read-midx.c: add --checksum mode
 - t5310: move some tests to lib-bitmap.sh
 - pack-bitmap: write multi-pack bitmaps
 - pack-bitmap: read multi-pack bitmaps
 - pack-bitmap.c: avoid redundant calls to try_partial_reuse
 - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 - pack-bitmap.c: introduce 'bitmap_num_objects()'
 - midx: avoid opening multiple MIDXs when writing
 - midx: close linked MIDXs, avoid leaking memory
 - midx: infer preferred pack when not given one
 - midx: reject empty `--preferred-pack`'s
 - midx: clear auxiliary .rev after replacing the MIDX
 - Documentation: describe MIDX-based bitmaps
 - pack-bitmap-write.c: free existing bitmaps
 - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Comments?


* ab/config-based-hooks-base (2021-08-03) 36 commits
 - hooks: fix a TOCTOU in "did we run a hook?" heuristic
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - receive-pack: convert 'update' hook to hook.h
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - reference-transaction: use hook.h to run hooks
 - hook tests: use a modern style for "pre-push" tests
 - hook tests: test for exact "pre-push" hook input
 - transport: convert pre-push hook to hook.h
 - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - am: convert 'post-rewrite' hook to hook.h
 - hook: support passing stdin to hooks
 - run-command: allow stdin for run_processes_parallel
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change to use hook.h
 - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - merge: convert post-merge to use hook.h
 - hooks: convert 'post-checkout' hook to hook library
 - am: convert applypatch to use hook.h
 - rebase: convert pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook: add 'run' subcommand
 - hook-list.h: add a generated list of hooks, like config-list.h
 - hook.c users: use "hook_exists()" insted of "find_hook()"
 - hook.c: add a hook_exists() wrapper and use it in bugreport.c
 - hook.[ch]: move find_hook() to this new library
 - Makefile: remove an out-of-date comment
 - Makefile: stop hardcoding {command,config}-list.h
 - Makefile: mark "check" target as .PHONY

 Restructuring of (a subset of) Emily's config-based-hooks series,
 to demonstrate that a series can be presented as a more logical and
 focused progression.

 Waiting for reviews.


* ab/serve-cleanup (2021-08-05) 10 commits
 - upload-pack: document and rename --advertise-refs
 - serve.[ch]: remove "serve_options", split up --advertise-refs code
 - {upload,receive}-pack tests: add --advertise-refs tests
 - serve.c: move version line to advertise_capabilities()
 - serve: move transfer.advertiseSID check into session_id_advertise()
 - serve.[ch]: don't pass "struct strvec *keys" to commands
 - serve: use designated initializers
 - transport: use designated initializers
 - transport: rename "fetch" in transport_vtable to "fetch_refs"
 - serve: mark has_capability() as static

 Code clean-up around "git serve".

 Expecting a reroll.


* pw/diff-color-moved-fix (2021-08-05) 13 commits
  (merged to 'next' on 2021-08-05 at 7b5e312aac)
 + diff: drop unused options parameter from cmp_in_block_with_wsd()
  (merged to 'next' on 2021-08-04 at 4de4a451e0)
 + diff --color-moved: intern strings
 + diff: use designated initializers for emitted_diff_symbol
 + diff --color-moved-ws=3Dallow-indentation-change: improve hash lookups
 + diff --color-moved: stop clearing potential moved blocks
 + diff --color-moved: shrink potential moved blocks as we go
 + diff --color-moved: unify moved block growth functions
 + diff --color-moved: call comparison function directly
 + diff --color-moved-ws=3Dallow-indentation-change: simplify and optimiz=
e
 + diff: simplify allow-indentation-change delta calculation
 + diff --color-moved: avoid false short line matches and bad zerba color=
ing
 + diff --color-moved=3Dzebra: fix alternate coloring
 + diff --color-moved: add perf tests

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Will cook in 'next'.


* hn/refs-errno-cleanup (2021-08-02) 7 commits
  (merged to 'next' on 2021-08-04 at 7fe3c31e7f)
 + refs: make errno output explicit for refs_resolve_ref_unsafe
 + refs: explicitly return failure_errno from parse_loose_ref_contents
 + refs: add failure_errno to refs_read_raw_ref() signature
 + refs: make errno output explicit for read_raw_ref_fn
 + refs/files-backend: stop setting errno from lock_ref_oid_basic
 + refs: remove EINVAL errno output from specification of read_raw_ref_fn
 + refs file backend: move raceproof_create_file() here
 (this branch uses ab/refs-files-cleanup.)

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

 Will cook in 'next'.


* ab/test-tool-cache-cleanup (2021-06-08) 4 commits
 - read-cache perf: add a perf test for refresh_index()
 - test-tool: migrate read-cache-again to parse_options()
 - test-tool: migrate read-cache-perf to parse_options()
 - test-tool: split up test-tool read-cache

 Test code shuffling.

 Expecting a reroll.


* ab/pack-objects-stdin (2021-07-09) 5 commits
 - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 - pack-objects.c: do stdin parsing via revision.c's API
 - revision.[ch]: add a "handle_stdin_line" API
 - revision.h: refactor "disable_stdin" and "read_from_stdin"
 - upload-pack: run is_repository_shallow() before setup_revisions()

 Introduce handle_stdin_line callback to revision API and uses it.

 Waiting for reviews.


* zh/ref-filter-raw-data (2021-07-26) 6 commits
  (merged to 'next' on 2021-08-04 at 4c4529d8d0)
 + ref-filter: add %(rest) atom
 + ref-filter: use non-const ref_format in *_atom_parser()
 + ref-filter: --format=3D%(raw) support --perl
 + ref-filter: add %(raw) atom
 + ref-filter: add obj-type check in grab contents
 + Merge branch 'zh/cat-file-batch-fix' into zh/ref-filter-raw-data

 Prepare the "ref-filter" machinery that drives the "--format"
 option of "git for-each-ref" and its friends to be used in "git
 cat-file --batch".

 Will cook in 'next'.


* jh/builtin-fsmonitor (2021-07-12) 35 commits
 - BANDAID: sparse fixes
 - t7527: test FS event reporing on MacOS WRT case and Unicode
 - fsmonitor: handle shortname for .git
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor: enhance existing comments
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - t7527: create test for fsmonitor--daemon
 - t/perf/p7519: add fsmonitor--daemon test cases
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t/perf/p7519: speed up test using "test-tool touch"
 - t/helper/test-touch: add helper to touch a series of files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor: do not try to operate on bare repos
 - fsmonitor--daemon: implement 'start' command
 - fsmonitor--daemon: implement 'run' command
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - fsmonitor--daemon: implement 'stop' and 'status' commands
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: use IPC to query the builtin FSMonitor daemon
 - fsmonitor: config settings are repository-specific
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor--daemon: update fsmonitor documentation
 - fsmonitor--daemon: man page
 - simple-ipc: preparations for supporting binary messages.

 An attempt to write and ship with a watchman equivalent tailored
 for our use.

 Expecting a reroll post 2.33 release.


* es/trace2-log-parent-process-name (2021-07-22) 2 commits
  (merged to 'next' on 2021-08-04 at 47e35c31b0)
 + tr2: log parent process name
 + tr2: make process info collection platform-generic

 trace2 logs learned to show parent process name to see in what
 context Git was invoked.

 Will cook in 'next'.


* ab/fsck-unexpected-type (2021-07-12) 21 commits
 - fsck: report invalid object type-path combinations
 - fsck: report invalid types recorded in objects
 - object-store.h: move read_loose_object() below 'struct object_info'
 - fsck: don't hard die on invalid object types
 - object-file.c: return -2 on "header too long" in unpack_loose_header()
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: guard against future bugs in loose_object_info()
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: split up ternary in parse_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: add missing braces to loose_object_info()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: don't set "typep" when returning non-zero
 - cache.h: move object functions to object-store.h
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - rev-list tests: test for behavior with invalid object types
 - cat-file tests: test that --allow-unknown-type isn't on by default
 - cat-file tests: test for missing object with -t and -s
 - fsck tests: add test for fsck-ing an unknown type
 - fsck tests: refactor one test to use a sub-repo

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Needs review.

--------------------------------------------------
[Discarded]

* ab/test-columns (2021-08-05) 3 commits
 - test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
 - test-lib-functions.sh: add a test_with_columns function
 - test-lib-functions.sh: rename test_must_fail_acceptable()

 Shells that adjust COLUMNS (e.g. bash with checkwinsize shell
 option), affect and break tests on progress meters and anything
 that depends on term_columns().  An test-only environment variable
 has been introduced as a workaround.

 Seems too involved for a last-minute fix.
 cf. <20210804212825.GH23408@szeder.dev>



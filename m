Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6AEB20756
	for <e@80x24.org>; Tue, 10 Jan 2017 23:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbdAJXtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 18:49:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55505 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758596AbdAJXtE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 18:49:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2821A5FB0B;
        Tue, 10 Jan 2017 18:48:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=K
        oPot7t+RdaMHPeHegmJAJTOubc=; b=h7eaRMLmdTWxI8nRXx+XZf8Y0j7CKrpCm
        eku7U6MalThj5JL48Eq5OoqqcHxr96c3N5S+yQjOE+tftydviyqFxHPwIBdPdWjH
        C7JuFdDl34VEjg8ST1d2tOsP58uEB070AShfxYi5PdxX3G2K7VRyJ58+ZEUslHlC
        ABb75kN1Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Y+b
        qIO9yhS0K0qnJ6K6fWYQwgryjalkBcsQmXUwC9RQHqBk2H/u5QQ6Q0/c3sYHOp3h
        PNxvixrnRjLlnvpf+pOn25njb8CHsnUaYUsPIXD++tzsIBmCjHWMbu8du4rOHW8k
        y4drP/ncVSo+siqkzDvDl34tzHZkntpqyQiDcq5g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DA9B5FB0A;
        Tue, 10 Jan 2017 18:48:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BF4C5FB09;
        Tue, 10 Jan 2017 18:48:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2017, #01; Tue, 10)
X-master-at: d7dffce1cebde29a0c4b309a79e4345450bf352a
X-next-at: 087da7b7c1bc403d36120b5e97c342e00ebbf16a
Date:   Tue, 10 Jan 2017 15:48:55 -0800
Message-ID: <xmqqd1fupjbs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A04CBB8-D78F-11E6-BFE4-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bw/grep-recurse-submodules (2016-12-22) 12 commits
  (merged to 'next' on 2016-12-22 at 1ede815b8d)
 + grep: search history of moved submodules
 + grep: enable recurse-submodules to work on <tree> objects
 + grep: optionally recurse into submodules
 + grep: add submodules as a grep source type
 + submodules: load gitmodules file from commit sha1
 + submodules: add helper to determine if a submodule is initialized
 + submodules: add helper to determine if a submodule is populated
  (merged to 'next' on 2016-12-22 at fea8fa870f)
 + real_path: canonicalize directory separators in root parts
 + real_path: have callers use real_pathdup and strbuf_realpath
 + real_path: create real_pathdup
 + real_path: convert real_path_internal to strbuf_realpath
 + real_path: resolve symlinks by hand
 (this branch is tangled with bw/realpath-wo-chdir.)

 "git grep" learns to optionally recurse into submodules.


* dt/smart-http-detect-server-going-away (2016-11-18) 2 commits
  (merged to 'next' on 2016-12-05 at 3ea70d01af)
 + upload-pack: optionally allow fetching any sha1
 + remote-curl: don't hang when a server dies before any output

 Originally merged to 'next' on 2016-11-21

 When the http server gives an incomplete response to a smart-http
 rpc call, it could lead to client waiting for a full response that
 will never come.  Teach the client side to notice this condition
 and abort the transfer.

 An improvement counterproposal has failed.
 cf. <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>


* jc/abbrev-autoscale-config (2016-12-22) 1 commit
  (merged to 'next' on 2016-12-27 at 631e4200e2)
 + config.abbrev: document the new default that auto-scales

 Recent update to the default abbreviation length that auto-scales
 lacked documentation update, which has been corrected.


* jc/compression-config (2016-11-15) 1 commit
  (merged to 'next' on 2016-12-05 at 323769ca07)
 + compression: unify pack.compression configuration parsing

 Originally merged to 'next' on 2016-11-23

 Compression setting for producing packfiles were spread across
 three codepaths, one of which did not honor any configuration.
 Unify these so that all of them honor core.compression and
 pack.compression variables the same way.


* jc/git-open-cloexec (2016-11-02) 3 commits
  (merged to 'next' on 2016-12-27 at 487682eb6e)
 + sha1_file: stop opening files with O_NOATIME
 + git_open_cloexec(): use fcntl(2) w/ FD_CLOEXEC fallback
 + git_open(): untangle possible NOATIME and CLOEXEC interactions

 The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
 opens has been simplified.
 We may want to drop the tip one, but we'll see.


* jc/latin-1 (2016-09-26) 2 commits
  (merged to 'next' on 2016-12-05 at fb549caa12)
 + utf8: accept "latin-1" as ISO-8859-1
 + utf8: refactor code to decide fallback encoding

 Originally merged to 'next' on 2016-09-28

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.


* jc/retire-compaction-heuristics (2016-12-23) 1 commit
  (merged to 'next' on 2016-12-27 at c69c2f50cf)
 + diff: retire "compaction" heuristics

 "git diff" and its family had two experimental heuristics to shift
 the contents of a hunk to make the patch easier to read.  One of
 them turns out to be better than the other, so leave only the
 "--indent-heuristic" option and remove the other one.


* jt/fetch-no-redundant-tag-fetch-map (2016-11-11) 1 commit
  (merged to 'next' on 2016-12-05 at 432f9469a7)
 + fetch: do not redundantly calculate tag refmap

 Originally merged to 'next' on 2016-11-16

 Code cleanup to avoid using redundant refspecs while fetching with
 the --tags option.


* mh/fast-import-notes-fix-new (2016-12-20) 1 commit
  (merged to 'next' on 2016-12-27 at b63805e6f6)
 + fast-import: properly fanout notes when tree is imported

 "git fast-import" sometimes mishandled while rebalancing notes
 tree, which has been fixed.


* mm/gc-safety-doc (2016-11-16) 1 commit
  (merged to 'next' on 2016-12-05 at 031ecc1886)
 + git-gc.txt: expand discussion of races with other processes

 Originally merged to 'next' on 2016-11-17

 Doc update.


* mm/push-social-engineering-attack-doc (2016-11-14) 1 commit
  (merged to 'next' on 2016-12-05 at 9a2b5bd1a9)
 + doc: mention transfer data leaks in more places

 Originally merged to 'next' on 2016-11-16

 Doc update on fetching and pushing.


* nd/config-misc-fixes (2016-12-22) 3 commits
  (merged to 'next' on 2016-12-27 at 6be64a8671)
 + config.c: handle lock file in error case in git_config_rename_...
 + config.c: rename label unlock_and_out
 + config.c: handle error case for fstat() calls

 Leakage of lockfiles in the config subsystem has been fixed.


* sb/submodule-embed-gitdir (2016-12-27) 7 commits
  (merged to 'next' on 2016-12-27 at 2b43c15479)
 + worktree: initialize return value for submodule_uses_worktrees
  (merged to 'next' on 2016-12-21 at e6cdbcf013)
 + submodule: add absorb-git-dir function
 + move connect_work_tree_and_git_dir to dir.h
 + worktree: check if a submodule uses worktrees
 + test-lib-functions.sh: teach test_commit -C <dir>
 + submodule helper: support super prefix
 + submodule: use absolute path for computing relative path connecting
 (this branch is used by sb/submodule-rm-absorb.)

 A new submodule helper "git submodule embedgitdirs" to make it
 easier to move embedded .git/ directory for submodules in a
 superproject to .git/modules/ (and point the latter with the former
 that is turned into a "gitdir:" file) has been added.

--------------------------------------------------
[New Topics]

* ls/p4-retry-thrice (2016-12-29) 1 commit
  (merged to 'next' on 2017-01-10 at c733e27410)
 + git-p4: do not pass '-r 0' to p4 commands

 A recent updates to "git p4" was not usable for older p4 but it
 could be made to work with minimum changes.  Do so.

 Will merge to 'master'.


* mh/ref-remove-empty-directory (2017-01-07) 23 commits
 - files_transaction_commit(): clean up empty directories
 - try_remove_empty_parents(): teach to remove parents of reflogs, too
 - try_remove_empty_parents(): don't trash argument contents
 - try_remove_empty_parents(): rename parameter "name" -> "refname"
 - delete_ref_loose(): inline function
 - delete_ref_loose(): derive loose reference path from lock
 - log_ref_write_1(): inline function
 - log_ref_setup(): manage the name of the reflog file internally
 - log_ref_write_1(): don't depend on logfile argument
 - log_ref_setup(): pass the open file descriptor back to the caller
 - log_ref_setup(): improve robustness against races
 - log_ref_setup(): separate code for create vs non-create
 - log_ref_write(): inline function
 - rename_tmp_log(): improve error reporting
 - rename_tmp_log(): use raceproof_create_file()
 - lock_ref_sha1_basic(): use raceproof_create_file()
 - lock_ref_sha1_basic(): inline constant
 - raceproof_create_file(): new function
 - safe_create_leading_directories(): set errno on SCLD_EXISTS
 - safe_create_leading_directories_const(): preserve errno
 - t5505: use "for-each-ref" to test for the non-existence of references
 - refname_is_safe(): correct docstring
 - files_rename_ref(): tidy up whitespace

 Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
 once there no longer is any other branch whose name begins with
 "foo/", but we didn't do so so far.  Now we do.

 Expecting a reroll.
 cf. <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>


* pb/test-must-fail-is-for-git (2017-01-09) 2 commits
  (merged to 'next' on 2017-01-10 at 5f24a98779)
 + t9813: avoid using pipes
 + don't use test_must_fail with grep

 Test cleanup.

 Will merge to 'master'.


* jk/archive-zip-userdiff-config (2017-01-07) 1 commit
  (merged to 'next' on 2017-01-10 at ac42e4958c)
 + archive-zip: load userdiff config

 "git archive" did not read the standard configuration files, and
 failed to notice a file that is marked as binary via the userdiff
 driver configuration.

 Will merge to 'master'.


* jk/blame-fixes (2017-01-07) 3 commits
  (merged to 'next' on 2017-01-10 at 18f909da61)
 + blame: output porcelain "previous" header for each file
 + blame: handle --no-abbrev
 + blame: fix alignment with --abbrev=40

 "git blame --porcelain" misidentified the "previous" <commit, path>
 pair (aka "source") when contents came from two or more files.

 Will merge to 'master'.


* jk/rebase-i-squash-count-fix (2017-01-07) 1 commit
  (merged to 'next' on 2017-01-10 at d6cfc6ace2)
 + rebase--interactive: count squash commits above 10 correctly

 "git rebase -i" with a recent update started showing an incorrect
 count when squashing more than 10 commits.

 Will merge to 'master'.


* js/asciidoctor-tweaks (2017-01-07) 1 commit
  (merged to 'next' on 2017-01-10 at 087da7b7c1)
 + giteveryday: unbreak rendering with AsciiDoctor

 Adjust documentation to help AsciiDoctor render better while not
 breaking the rendering done by AsciiDoc.

 Will merge to 'master'.


* km/branch-get-push-while-detached (2017-01-07) 1 commit
  (merged to 'next' on 2017-01-10 at a7f8af8c55)
 + branch_get_push: do not segfault when HEAD is detached

 "git <cmd> @{push}" on a detached HEAD used to segfault; it has
 been corrected to error out with a message.

 Will merge to 'master'.


* sb/remove-gitview (2017-01-07) 1 commit
  (merged to 'next' on 2017-01-10 at dcb3abd146)
 + contrib: remove gitview

 Will merge to 'master'.


* sb/submodule-cleanup-export-git-dir-env (2017-01-07) 1 commit
  (merged to 'next' on 2017-01-10 at 2d5db6821e)
 + submodule.c: use GIT_DIR_ENVIRONMENT consistently

 Code cleanup.

 Will merge to 'master'.


* sb/pathspec-errors (2017-01-09) 1 commit
  (merged to 'next' on 2017-01-10 at 432375cb62)
 + pathspec: give better message for submodule related pathspec error
 (this branch uses bw/pathspec-cleanup.)

 Running "git add a/b" when "a" is a submodule correctly errored
 out, but without a meaningful error message.

 Will merge to 'master'.


* ls/filter-process-delayed (2017-01-08) 1 commit
 . convert: add "status=delayed" to filter process protocol

 Ejected, as does not build when merged to 'pu'.


* sp/cygwin-build-fixes (2017-01-09) 2 commits
  (merged to 'next' on 2017-01-10 at 2010fb6c03)
 + Makefile: put LIBS after LDFLAGS for imap-send
 + Makefile: POSIX windres

 Build updates for Cygwin.

 Will merge to 'master'.


* jk/execv-dashed-external (2017-01-09) 3 commits
  (merged to 'next' on 2017-01-10 at 117b506cb0)
 + execv_dashed_external: wait for child on signal death
 + execv_dashed_external: stop exiting with negative code
 + execv_dashed_external: use child_process struct

 Typing ^C to pager, which usually does not kill it, killed Git and
 took the pager down as a collateral damage in certain process-tree
 structure.  This has been fixed.

 Will merge to 'master'.


* rh/mergetool-regression-fix (2017-01-10) 14 commits
  (merged to 'next' on 2017-01-10 at e8e00c798b)
 + mergetool: fix running in subdir when rerere enabled
 + mergetool: take the "-O" out of $orderfile
 + t7610: add test case for rerere+mergetool+subdir bug
 + t7610: spell 'git reset --hard' consistently
 + t7610: don't assume the checked-out commit
 + t7610: always work on a test-specific branch
 + t7610: delete some now-unnecessary 'git reset --hard' lines
 + t7610: run 'git reset --hard' after each test to clean up
 + t7610: don't rely on state from previous test
 + t7610: use test_when_finished for cleanup tasks
 + t7610: move setup code to the 'setup' test case
 + t7610: update branch names to match test number
 + rev-parse doc: pass "--" to rev-parse in the --prefix example
 + .mailmap: record canonical email for Richard Hansen

 "git mergetool" without any pathspec on the command line that is
 run from a subdirectory became no-op in Git v2.11 by mistake, which
 has been fixed.

 Will merge to 'master'.


* sb/unpack-trees-cleanup (2017-01-10) 3 commits
  (merged to 'next' on 2017-01-10 at 95a5f3127c)
 + unpack-trees: factor progress setup out of check_updates
 + unpack-trees: remove unneeded continue
 + unpack-trees: move checkout state into check_updates

 Code cleanup.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* jk/nofollow-attr-ignore (2016-11-02) 5 commits
 - exclude: do not respect symlinks for in-tree .gitignore
 - attr: do not respect symlinks for in-tree .gitattributes
 - exclude: convert "check_index" into a flags field
 - attr: convert "macro_ok" into a flags field
 - add open_nofollow() helper

 As we do not follow symbolic links when reading control files like
 .gitignore and .gitattributes from the index, match the behaviour
 and not follow symbolic links when reading them from the working
 tree.  This also tightens security a bit by not leaking contents of
 an unrelated file in the error messages when it is pointed at by
 one of these files that is a symbolic link.

 Perhaps we want to cover .gitmodules too with the same mechanism?


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  It is likely that to support a "prime clone from CDN", it
 would need a lot more than just "these are the heads and the pack
 data is over there", so this may not be sufficient.

 Will discard.


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* nd/worktree-move (2017-01-09) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.


* dt/disable-bitmap-in-auto-gc (2016-12-29) 2 commits
  (merged to 'next' on 2017-01-10 at 9f4e89e15d)
 + repack: die on incremental + write-bitmap-index
 + auto gc: don't write bitmaps for incremental repacks

 It is natural that "git gc --auto" may not attempt to pack
 everything into a single pack, and there is no point in warning
 when the user has configured the system to use the pack bitmap,
 leading to disabling further "gc".

 Will merge to 'master'.


* js/mingw-test-push-unc-path (2017-01-07) 1 commit
  (merged to 'next' on 2017-01-10 at 249d9f26f3)
 + mingw: add a regression test for pushing to UNC paths

 "git push \\server\share\dir" has recently regressed and then
 fixed.  A test has retroactively been added for this breakage.

 Will merge to 'master'.


* nd/log-graph-configurable-colors (2017-01-08) 1 commit
 - log --graph: customize the graph lines with config log.graphColors

 Some people feel the default set of colors used by "git log --graph"
 rather limiting.  A mechanism to customize the set of colors has
 been introduced.

 Waiting for review comments to be addressed.
 cf. <20170109103258.25341-1-pclouds@gmail.com>


* sb/submodule-rm-absorb (2016-12-27) 4 commits
  (merged to 'next' on 2017-01-10 at 1fc2000a92)
 + rm: absorb a submodules git dir before deletion
 + submodule: rename and add flags to ok_to_remove_submodule
 + submodule: modernize ok_to_remove_submodule to use argv_array
 + submodule.h: add extern keyword to functions

 "git rm" used to refuse to remove a submodule when it has its own
 git repository embedded in its working tree.  It learned to move
 the repository away to $GIT_DIR/modules/ of the superproject
 instead, and allow the submodule to be deleted (as long as there
 will be no loss of local modifications, that is).

 Will merge to 'master'.


* cc/split-index-config (2016-12-26) 21 commits
 - Documentation/git-update-index: explain splitIndex.*
 - Documentation/config: add splitIndex.sharedIndexExpire
 - read-cache: use freshen_shared_index() in read_index_from()
 - read-cache: refactor read_index_from()
 - t1700: test shared index file expiration
 - read-cache: unlink old sharedindex files
 - config: add git_config_get_expiry() from gc.c
 - read-cache: touch shared index files when used
 - sha1_file: make check_and_freshen_file() non static
 - Documentation/config: add splitIndex.maxPercentChange
 - t1700: add tests for splitIndex.maxPercentChange
 - read-cache: regenerate shared index if necessary
 - config: add git_config_get_max_percent_split_change()
 - Documentation/git-update-index: talk about core.splitIndex config var
 - Documentation/config: add information for core.splitIndex
 - t1700: add tests for core.splitIndex
 - update-index: warn in case of split-index incoherency
 - read-cache: add and then use tweak_split_index()
 - split-index: add {add,remove}_split_index() functions
 - config: add git_config_get_split_index()
 - config: mark an error message up for translation

 The experimental "split index" feature has gained a few
 configuration variables to make it easier to use.

 Waiting for review comments to be addressed.
 cf. <20161226102222.17150-1-chriscool@tuxfamily.org>
 cf. <a1a44640-ff6c-2294-72ac-46322eff8505@ramsayjones.plus.com>


* bw/push-submodule-only (2016-12-20) 3 commits
 - push: add option to push only submodules
 - submodules: add RECURSE_SUBMODULES_ONLY value
 - transport: reformat flag #defines to be more readable

 "git submodule push" learned "--recurse-submodules=only option to
 push submodules out without pushing the top-level superproject.


* ls/p4-path-encoding (2016-12-18) 1 commit
 - git-p4: fix git-p4.pathEncoding for removed files

 When "git p4" imports changelist that removes paths, it failed to
 convert pathnames when the p4 used encoding different from the one
 used on the Git side.  This has been corrected.

 Will be rerolled.
 cf. <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>


* bw/pathspec-cleanup (2017-01-08) 16 commits
  (merged to 'next' on 2017-01-10 at 79291ff506)
 + pathspec: rename prefix_pathspec to init_pathspec_item
 + pathspec: small readability changes
 + pathspec: create strip submodule slash helpers
 + pathspec: create parse_element_magic helper
 + pathspec: create parse_long_magic function
 + pathspec: create parse_short_magic function
 + pathspec: factor global magic into its own function
 + pathspec: simpler logic to prefix original pathspec elements
 + pathspec: always show mnemonic and name in unsupported_magic
 + pathspec: remove unused variable from unsupported_magic
 + pathspec: copy and free owned memory
 + pathspec: remove the deprecated get_pathspec function
 + ls-tree: convert show_recursive to use the pathspec struct interface
 + dir: convert fill_directory to use the pathspec struct interface
 + dir: remove struct path_simplify
 + mv: remove use of deprecated 'get_pathspec()'
 (this branch is used by sb/pathspec-errors.)

 Code clean-up in the pathspec API.

 Will merge to 'master'.


* js/prepare-sequencer-more (2017-01-09) 38 commits
 - sequencer (rebase -i): write out the final message
 - sequencer (rebase -i): write the progress into files
 - sequencer (rebase -i): show the progress
 - sequencer (rebase -i): suggest --edit-todo upon unknown command
 - sequencer (rebase -i): show only failed cherry-picks' output
 - sequencer (rebase -i): show only failed `git commit`'s output
 - sequencer: use run_command() directly
 - sequencer: make reading author-script more elegant
 - sequencer (rebase -i): differentiate between comments and 'noop'
 - sequencer (rebase -i): implement the 'drop' command
 - sequencer (rebase -i): allow rescheduling commands
 - sequencer (rebase -i): respect strategy/strategy_opts settings
 - sequencer (rebase -i): respect the rebase.autostash setting
 - sequencer (rebase -i): run the post-rewrite hook, if needed
 - sequencer (rebase -i): record interrupted commits in rewritten, too
 - sequencer (rebase -i): copy commit notes at end
 - sequencer (rebase -i): set the reflog message consistently
 - sequencer (rebase -i): refactor setting the reflog message
 - sequencer (rebase -i): allow fast-forwarding for edit/reword
 - sequencer (rebase -i): implement the 'reword' command
 - sequencer (rebase -i): leave a patch upon error
 - sequencer (rebase -i): update refs after a successful rebase
 - sequencer (rebase -i): the todo can be empty when continuing
 - sequencer (rebase -i): skip some revert/cherry-pick specific code path
 - sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
 - sequencer (rebase -i): allow continuing with staged changes
 - sequencer (rebase -i): write an author-script file
 - sequencer (rebase -i): implement the short commands
 - sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
 - sequencer (rebase -i): write the 'done' file
 - sequencer (rebase -i): learn about the 'verbose' mode
 - sequencer (rebase -i): implement the 'exec' command
 - sequencer (rebase -i): implement the 'edit' command
 - sequencer (rebase -i): implement the 'noop' command
 - sequencer: support a new action: 'interactive rebase'
 - sequencer: use a helper to find the commit message
 - sequencer: move "else" keyword onto the same line as preceding brace
 - sequencer: avoid unnecessary curly braces

 The sequencer has further been extended in preparation to act as a
 back-end for "rebase -i".

 Waiting for review comments to be addressed.


* bw/realpath-wo-chdir (2017-01-09) 7 commits
  (merged to 'next' on 2017-01-10 at ed315a40c8)
 + real_path: set errno when max number of symlinks is exceeded
 + real_path: prevent redefinition of MAXSYMLINKS
  (merged to 'next' on 2016-12-22 at fea8fa870f)
 + real_path: canonicalize directory separators in root parts
 + real_path: have callers use real_pathdup and strbuf_realpath
 + real_path: create real_pathdup
 + real_path: convert real_path_internal to strbuf_realpath
 + real_path: resolve symlinks by hand
 (this branch is tangled with bw/grep-recurse-submodules.)

 The implementation of "real_path()" was to go there with chdir(2)
 and call getcwd(3), but this obviously wouldn't be usable in a
 threaded environment.  Rewrite it to manually resolve relative
 paths including symbolic links in path components.

 Will merge to 'master'.


* js/difftool-builtin (2017-01-09) 5 commits
 - t7800: run both builtin and scripted difftool, for now
 - difftool: implement the functionality in the builtin
 - difftool: add a skeleton for the upcoming builtin
 - git_exec_path: do not return the result of getenv()
 - git_exec_path: avoid Coverity warning about unfree()d result

 Rewrite a scripted porcelain "git difftool" in C.

 Expecting a reroll.
 cf. <alpine.DEB.2.20.1701091228460.3469@virtualbox>


* sb/push-make-submodule-check-the-default (2016-11-29) 2 commits
  (merged to 'next' on 2016-12-12 at 1863e05af5)
 + push: change submodule default to check when submodules exist
 + submodule add: extend force flag to add existing repos

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Will cook in 'next'.


* kn/ref-filter-branch-list (2017-01-10) 21 commits
 - SQUASH???
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
 - ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
 - ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
 - ref-filter: rename the 'strip' option to 'lstrip'
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 I think this is almost ready.  Will wait for a few days, squash
 fixes in if needed and merge to 'next'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-12-05 at 0c77e39cd5)
 + setup_git_env: avoid blind fall-back to ".git"

 Originally merged to 'next' on 2016-10-26

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* pb/bisect (2016-10-18) 27 commits
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>


* st/verify-tag (2016-10-10) 7 commits
 - t/t7004-tag: Add --format specifier tests
 - t/t7030-verify-tag: Add --format specifier tests
 - builtin/tag: add --format argument for tag -v
 - builtin/verify-tag: add --format to verify-tag
 - tag: add format specifier to gpg_verify_tag
 - ref-filter: add function to print single ref_array_item
 - gpg-interface, tag: add GPG_VERIFY_QUIET flag

 "git tag" and "git verify-tag" learned to put GPG verification
 status in their "--format=<placeholders>" output format.

 Waiting for a reroll.
 cf. <20161007210721.20437-1-santiago@nyu.edu>


* sb/attr (2016-11-11) 35 commits
 . completion: clone can initialize specific submodules
 . clone: add --init-submodule=<pathspec> switch
 . submodule update: add `--init-default-path` switch
 . pathspec: allow escaped query values
 . pathspec: allow querying for attributes
 . pathspec: move prefix check out of the inner loop
 . pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 - attr: keep attr stack for each check
 - attr: convert to new threadsafe API
 - attr: make git_check_attr_counted static
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.
 Building on top of the updated API, the pathspec machinery learned
 to select only paths with given attributes set.

 The parts near the tip about pathspec would need to work better
 with bw/pathspec-cleanup topic and has been dropped for now.


* sg/fix-versioncmp-with-common-suffix (2016-12-08) 8 commits
 - versioncmp: generalize version sort suffix reordering
 - squash! versioncmp: use earliest-longest contained suffix to determine sorting order
 - versioncmp: use earliest-longest contained suffix to determine sorting order
 - versioncmp: cope with common part overlapping with prerelease suffix
 - versioncmp: pass full tagnames to swap_prereleases()
 - t7004-tag: add version sort tests to show prerelease reordering issues
 - t7004-tag: use test_config helper
 - t7004-tag: delete unnecessary tags with test_when_finished

 The prereleaseSuffix feature of version comparison that is used in
 "git tag -l" did not correctly when two or more prereleases for the
 same release were present (e.g. when 2.0, 2.0-beta1, and 2.0-beta2
 are there and the code needs to compare 2.0-beta1 and 2.0-beta2).

 Will merge to 'next' after squashing.
 cf. <20161208142401.1329-1-szeder.dev@gmail.com>


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-12-05 at 041946dae0)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2016-10-11

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* rs/unpack-trees-reduce-file-scope-global (2016-12-31) 1 commit
 . unpack-trees: move checkout state into check_updates

 Code cleanup.

 Superseded by sb/unpack-trees-cleanup


* jc/reset-unmerge (2016-10-24) 1 commit
 . reset: --unmerge

 After "git add" is run prematurely during a conflict resolution,
 "git diff" can no longer be used as a way to sanity check by
 looking at the combined diff.  "git reset" learned a new
 "--unmerge" option to recover from this situation.

 This may not be needed, given that update-index has a similar
 option.


* jc/merge-base-fp-only (2016-10-19) 8 commits
 . merge-base: fp experiment
 . merge: allow to use only the fp-only merge bases
 . merge-base: limit the output to bases that are on first-parent chain
 . merge-base: mark bases that are on first-parent chain
 . merge-base: expose get_merge_bases_many_0() a bit more
 . merge-base: stop moving commits around in remove_redundant()
 . sha1_name: remove ONELINE_SEEN bit
 . commit: simplify fastpath of merge-base

 An experiment of merge-base that ignores common ancestors that are
 not on the first parent chain.

 The whole premise feels wrong.


* tb/convert-stream-check (2016-10-27) 2 commits
 . convert.c: stream and fast search for binary
 . read-cache: factor out get_sha1_from_index() helper

 End-of-line conversion sometimes needs to see if the current blob
 in the index has NULs and CRs to base its decision.  We used to
 always get a full statistics over the blob, but in many cases we
 can return early when we have seen "enough" (e.g. if we see a
 single NUL, the blob will be handled as binary).  The codepaths
 have been optimized by using streaming interface.

 Retracted.
 cf. <20161102071646.GA5094@tb-raspi>


* mh/connect (2016-06-06) 10 commits
 . connect: [host:port] is legacy for ssh
 . connect: move ssh command line preparation to a separate function
 . connect: actively reject git:// urls with a user part
 . connect: change the --diag-url output to separate user and host
 . connect: make parse_connect_url() return the user part of the url as a separate value
 . connect: group CONNECT_DIAG_URL handling code
 . connect: make parse_connect_url() return separated host and port
 . connect: re-derive a host:port string from the separate host and port variables
 . connect: call get_host_and_port() earlier
 . connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 It has been months without any support.


* ec/annotate-deleted (2015-11-20) 1 commit
 . annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Has been waiting for a review for too long without seeing anything.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 . gc: clean garbage .bitmap files from pack dir
 . t5304: ensure non-garbage files are not deleted
 . t5304: test .bitmap garbage files
 . prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Has been waiting for a reroll for too long.
 cf. <xmqq60ypbeng.fsf@gitster.mtv.corp.google.com>

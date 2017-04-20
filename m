Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9BA1FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 05:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941493AbdDTFh3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 01:37:29 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:61100 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941484AbdDTFhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 01:37:25 -0400
Received: from pb-sasl-trial3.pobox.com (ro.sql.listbox.com [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id BC976192E8;
        Thu, 20 Apr 2017 01:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=D
        0AGkNKHnLUlbB0yOJEthWBT8fA=; b=n+sbnuunaXMbT1wR6crJ01tTKTFnnmeDR
        feDDxMKDR5zRPhHWzNK1IbBuFrvMN2NUvx+FNA8fs0aVqF/57DauOCiQJ2gtVGGU
        x5Gq9bHUnp9C/1RMIGnTxMGfU7T6CE4WnC1HMJ4T381lCvIOVmJ8+Ba5TsR0lFWN
        V3VxL/w15Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=ADC
        9xCCUR3k2Q+SlBDzHehom+jgyNarDm6v0HCO/DhYukQVc3FEcVOXYUPhaEh/rGyh
        WGwXynDTNEbAQaJo0aejf6zL4EBiJKi+f+uPJ1NDF5L4ax2xkkq0DRPP1jAx8noi
        xZt2P6HUgQt70ONgiOCRJXX/SZABEYmwDzdWhHCw=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 98A51192E7;
        Thu, 20 Apr 2017 01:37:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B50A56F1EF;
        Thu, 20 Apr 2017 01:37:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2017, #04; Wed, 19)
X-master-at: 6a2c2f8d34fa1e8f3bb85d159d354810ed63692e
X-next-at: b4426549316a3855d2b022fb331e7173b26879d0
Date:   Wed, 19 Apr 2017 22:37:21 -0700
Message-ID: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DA42296-258B-11E7-8CA7-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

An early preview for the upcoming 2.13 release has been tagged,
almost a full day earlier than I planned.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/grep-plug-pathspec-leak (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-18 at d8f00b5e44)
 + grep: plug a trivial memory leak

 Call clear_pathspec() to release resources immediately before the
 cmd_grep() function returns.


* ah/diff-files-ours-theirs-doc (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-18 at a4f80f0c3f)
 + diff-files: document --ours etc.

 The diff options "--ours", "--theirs" exist for quite some time.
 But so far they were not documented. Now they are.


* bc/object-id (2017-03-31) 20 commits
  (merged to 'next' on 2017-04-16 at b16f1899dd)
 + Documentation: update and rename api-sha1-array.txt
 + Rename sha1_array to oid_array
 + Convert sha1_array_for_each_unique and for_each_abbrev to object_id
 + Convert sha1_array_lookup to take struct object_id
 + Convert remaining callers of sha1_array_lookup to object_id
 + Make sha1_array_append take a struct object_id *
 + sha1-array: convert internal storage for struct sha1_array to object_id
 + builtin/pull: convert to struct object_id
 + submodule: convert check_for_new_submodule_commits to object_id
 + sha1_name: convert disambiguate_hint_fn to take object_id
 + sha1_name: convert struct disambiguate_state to object_id
 + test-sha1-array: convert most code to struct object_id
 + parse-options-cb: convert sha1_array_append caller to struct object_id
 + fsck: convert init_skiplist to struct object_id
 + builtin/receive-pack: convert portions to struct object_id
 + builtin/pull: convert portions to struct object_id
 + builtin/diff: convert to struct object_id
 + Convert GIT_SHA1_RAWSZ used for allocation to GIT_MAX_RAWSZ
 + Convert GIT_SHA1_HEXSZ used for allocation to GIT_MAX_HEXSZ
 + Define new hash-size constants for allocating memory

 Conversion from unsigned char [40] to struct object_id continues.


* bw/attr-pathspec (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-18 at 2644ca1269)
 + pathspec: fix segfault in clear_pathspec

 Hotfix for a topic already in 'master'.


* bw/push-options-recursively-to-submodules (2017-04-11) 5 commits
  (merged to 'next' on 2017-04-16 at d4d657724b)
 + push: propagate remote and refspec with --recurse-submodules
 + submodule--helper: add push-check subcommand
 + remote: expose parse_push_refspec function
 + push: propagate push-options with --recurse-submodules
 + push: unmark a local variable as static

 "git push --recurse-submodules --push-option=<string>" learned to
 propagate the push option recursively down to pushes in submodules.


* bw/submodule-is-active (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-18 at 25b05ec29e)
 + submodule--helper: fix typo in is_active error message

 Error message fix.


* dt/gc-ignore-old-gc-logs (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-18 at caadf4ff66)
 + t6500: wait for detached auto gc at the end of the test script

 Hotfix for a topic already in 'master'.


* jh/memihash-opt (2017-04-18) 4 commits
  (merged to 'next' on 2017-04-18 at 6555be6bab)
 + p0004: make perf test executable
  (merged to 'next' on 2017-04-15 at 6bfc58e19a)
 + t3008: skip lazy-init test on a single-core box
 + test-online-cpus: helper to return cpu count
  (merged to 'next' on 2017-04-11 at ec5a6f2818)
 + name-hash: fix buffer overrun

 Hotfix for a topic that is already in 'master'.


* jk/no-looking-at-dotgit-outside-repo (2017-04-16) 2 commits
  (merged to 'next' on 2017-04-18 at 68260787ad)
 + test-read-cache: setup git dir
 + has_sha1_file: don't bother if we are not in a repository

 Clean up fallouts from recent tightening of the set-up sequence,
 where Git barfs when repository information is accessed without
 first ensuring that it was started in a repository.


* ld/p4-current-branch-fix (2017-04-16) 3 commits
  (merged to 'next' on 2017-04-18 at 9e74a2609e)
 + git-p4: don't use name-rev to get current branch
 + git-p4: add read_pipe_text() internal function
 + git-p4: add failing test for name-rev rather than symbolic-ref

 "git p4" used "name-rev HEAD" when it wants to learn what branch is
 checked out; it should use "symbolic-ref HEAD".


* lt/mailinfo-in-body-header-continuation (2017-04-11) 1 commit
  (merged to 'next' on 2017-04-16 at b2f51f0780)
 + mailinfo: fix in-body header continuations

 If a patch e-mail had its first paragraph after an in-body header
 indented (even after a blank line after the in-body header line),
 the indented line was mistook as a continuation of the in-body
 header.  This has been fixed.


* nd/files-backend-git-dir (2017-04-14) 28 commits
  (merged to 'next' on 2017-04-18 at 79292aac69)
 + refs.h: add a note about sorting order of for_each_ref_*
 + t1406: new tests for submodule ref store
 + t1405: some basic tests on main ref store
 + t/helper: add test-ref-store to test ref-store functions
 + refs: delete pack_refs() in favor of refs_pack_refs()
 + files-backend: avoid ref api targeting main ref store
 + refs: new transaction related ref-store api
 + refs: add new ref-store api
 + refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 + files-backend: replace submodule_allowed check in files_downcast()
 + refs: move submodule code out of files-backend.c
 + path.c: move some code out of strbuf_git_path_submodule()
 + refs.c: make get_main_ref_store() public and use it
 + refs.c: kill register_ref_store(), add register_submodule_ref_store()
 + refs.c: flatten get_ref_store() a bit
 + refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 + refs.c: introduce get_main_ref_store()
 + files-backend: remove the use of git_path()
 + files-backend: add and use files_ref_path()
 + files-backend: add and use files_reflog_path()
 + files-backend: move "logs/" out of TMP_RENAMED_LOG
 + files-backend: convert git_path() to strbuf_git_path()
 + files-backend: make sure files_rename_ref() always reach the end
 + files-backend: add and use files_packed_refs_path()
 + files-backend: delete dead code in files_init_db()
 + files-backend.c: delete dead code in files_ref_iterator_begin()
 + files-backend: make files_log_ref_write() static
 + refs.h: add forward declaration for structs used in this file
 (this branch is used by mh/separate-ref-cache, nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.


* sb/submodule-rm-absorb (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-18 at 179081f848)
 + submodule.c: add missing ' in error messages

 Error message fix.


* sb/submodule-short-status (2017-03-29) 7 commits
  (merged to 'next' on 2017-04-16 at 24e18f4a4a)
 + submodule.c: correctly handle nested submodules in is_submodule_modified
 + short status: improve reporting for submodule changes
 + submodule.c: stricter checking for submodules in is_submodule_modified
 + submodule.c: port is_submodule_modified to use porcelain 2
 + submodule.c: convert is_submodule_modified to use strbuf_getwholeline
 + submodule.c: factor out early loop termination in is_submodule_modified
 + submodule.c: use argv_array in is_submodule_modified

 The output from "git status --short" has been extended to show
 various kinds of dirtyness in submodules differently; instead of to
 "M" for modified, 'm' and '?' can be shown to signal changes only
 to the working tree of the submodule but not the commit that is
 checked out.


* sf/putty-w-args (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-18 at cbf042088c)
 + connect.c: handle errors from split_cmdline

 Hotfix for a topic already in 'master'.


* va/i18n-perl-scripts (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-18 at 89f1c77091)
 + git-add--interactive.perl: add missing dot in a message

 Message fix.


* vn/revision-shorthand-for-side-branch-log (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-18 at 9fbe55bfef)
 + doc/revisions: remove brackets from rev^-n shorthand

 Doc cleanup.

--------------------------------------------------
[New Topics]

* ab/push-cas-doc-n-test (2017-04-19) 1 commit
 - push: document & test --force-with-lease with multiple remotes

 Doc update.

 Will merge to 'next'.


* jk/parse-options-no-no-no (2017-04-19) 2 commits
 - SQUASH???
 - parse-options: disallow double-negations of options starting with no-

 Command line options that begin with "--no-" (e.g. "--no-checkout"
 option of "git clone") can be negated by removing "--no-"; we
 historically also allowed prefixing an extra "no" to the option
 (e.g. "--no-no-checkout"), which made the command line look ugly
 and unusual.  This proposes to forbid it.

 While I agree there is no need to support "--no-no-checkout", this
 looks more like "if it looks ugly and unusual, you do not have to
 use it".  Perhaps we can drop it?


* ss/gitmodules-ignore-doc (2017-04-19) 1 commit
 - gitmodules: clarify the ignore option values

 Doc update.

 Will merge to 'next'.


* ss/submodule-shallow-doc (2017-04-19) 1 commit
 - gitmodules: clarify what history depth a shallow clone has

 Doc update.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 Some nits but looks ok.


* sk/dash-is-previous (2017-03-01) 5 commits
 - revert.c: delegate handling of "-" shorthand to setup_revisions
 - sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 - revision.c: args starting with "-" might be a revision
 - revision.c: swap if/else blocks
 - revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Needs review.
 cf. <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* nd/worktree-move (2017-01-27) 7 commits
 . fixup! worktree move: new command
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Tentatively ejected as it seems to break 'pu' when merged.


* pb/bisect (2017-02-18) 28 commits
 - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
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
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 - grep: use '/' delimiter for paths
 - grep: only add delimiter if there isn't one already

 "git grep", when fed a tree-ish as an input, shows each hit
 prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
 almost always either a commit or a tag that points at a commit, the
 early part of the output "<tree-ish>:<path>" can be used as the
 name of the blob and given to "git show".  When <tree-ish> is a
 tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
 "<commit>:<dir>"), however, this results in a string that does not
 name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
 "git grep" has been taught to be a bit more intelligent about these
 cases and omit a colon (in the former case) or use slash (in the
 latter case) to produce "<commit>:<path>" and
 "<commit>:<dir>/<path>" that can be used as the name of a blob.

 Expecting a reroll?  Is this good enough with known limitations?


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

* df/dir-iter-remove-subtree (2017-04-19) 5 commits
 - remove_subtree(): reimplement using iterators
 - dir_iterator: rewrite state machine model
 - dir_iterator: refactor dir_iterator_advance
 - remove_subtree(): test removing nested directories
 - dir_iterator: add tests for dir_iterator API

 Update the dir-iterator API and use it to reimplement
 remove_subtree().

 Almost there except for a minor nit.
 GSoC microproject.


* jk/ls-files-recurse-submodules-fix (2017-04-18) 2 commits
  (merged to 'next' on 2017-04-19 at d4682ceaae)
 + ls-files: fix path used when recursing into submodules
 + ls-files: fix recurse-submodules with nested submodules

 "ls-files --recurse-submodules" did not quite work well in a
 project with nested submodules.

 Will merge to 'master'.


* jt/fetch-pack-error-reporting (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at 6da61f7236)
 + fetch-pack: show clearer error message upon ERR

 "git fetch-pack" was not prepared to accept ERR packet that the
 upload-pack can send with a human-readable error message.  It
 showed the packet contents with ERR prefix, so there was no data
 loss, but it was redundant to say "ERR" in an error message.

 Will merge to 'master'.


* nd/conditional-config-in-early-config (2017-04-19) 3 commits
 - config: correct file reading order in read_early_config()
 - config: handle conditional include when $GIT_DIR is not set up
 - config: prepare to pass more info in git_config_with_options()

 The recently introduced conditional inclusion of configuration did
 not work well when early-config mechanism was involved.

 Will merge to 'next'.


* sb/checkout-recurse-submodules (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at 414e18fd9b)
 + submodule: remove a superfluous second check for the "new" variable

 Code cleanup.

 Will merge to 'master'.


* xy/format-patch-base (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at c10723d486)
 + doc: trivial typo in git-format-patch.txt

 Doc cleanup.

 Will merge to 'master'.


* jk/snprintf-cleanups (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at 4a18ea9971)
 + replace: plug a memory leak

 Hotfix for a topic that is already in 'master'.

 Will merge to 'master'.


* ab/clone-no-tags (2017-04-19) 1 commit
 - clone: add a --no-tags option to clone without tags

 "git clone" learned the "--no-tags" option not to fetch all tags
 initially, and also set up the tagopt not to follow any tags in
 subsequent fetches.

 Will merge to 'next'.


* ab/completion-push-delete-ref (2017-04-18) 1 commit
 - completion: expand "push --delete <remote> <ref>" for refs on that <remote>

 The completion script (in contrib/) learned to complete "git push
 --delete b<TAB>" to complete branch name to be deleted.

 Will merge to 'next'.


* bw/forking-and-threading (2017-04-19) 11 commits
 - run-command: block signals between fork and execve
 - run-command: add note about forking and threading
 - run-command: handle dup2 and close errors in child
 - run-command: eliminate calls to error handling functions in child
 - run-command: don't die in child when duping /dev/null
 - run-command: prepare child environment before forking
 - string-list: add string_list_remove function
 - run-command: use the async-signal-safe execv instead of execvp
 - run-command: prepare command before forking
 - t0061: run_command executes scripts without a #! line
 - t5550: use write_script to generate post-update hook

 The "run-command" APIimplementation has been made more robust
 against dead-locking in a threaded environment.

 Will merge to 'next'.


* sb/reset-recurse-submodules (2017-04-18) 4 commits
 - builtin/reset: add --recurse-submodules switch
 - submodule.c: submodule_move_head works with broken submodules
 - submodule.c: uninitialized submodules are ignored in recursive commands
 - entry.c: submodule recursing: respect force flag correctly

 "git reset" learned "--recurse-submodules" option.


* dt/xgethostname-nul-termination (2017-04-18) 2 commits
  (merged to 'next' on 2017-04-19 at 4035f442cc)
 + xgethostname: handle long hostnames
 + use HOST_NAME_MAX to size buffers for gethostname(2)

 gethostname(2) may not NUL terminate the buffer if hostname does
 not fit; unfortunately there is no easy way to see if our buffer
 was too small, but at least this will make sure we will not end up
 using garbage past the end of the buffer.

 Will merge to 'master'.


* jh/string-list-micro-optim (2017-04-15) 1 commit
  (merged to 'next' on 2017-04-19 at 2a5e339df9)
 + string-list: use ALLOC_GROW macro when reallocing string_list

 The string-list API used a custom reallocation strategy that was
 very inefficient, instead of using the usual ALLOC_GROW() macro,
 which has been fixed.

 Will merge to 'master'.


* jh/unpack-trees-micro-optim (2017-04-15) 1 commit
  (merged to 'next' on 2017-04-19 at 970c47a2f9)
 + unpack-trees: avoid duplicate ODB lookups during checkout

 In a 2- and 3-way merge of trees, more than one source trees often
 end up sharing an identical subtree; optimize by not reading the
 same tree multiple times in such a case.

 Will merge to 'master'.


* jh/verify-index-checksum-only-in-fsck (2017-04-15) 1 commit
  (merged to 'next' on 2017-04-19 at a089b97d34)
 + read-cache: force_verify_index_checksum

 The index file has a trailing SHA-1 checksum to detect file
 corruption, and historically we checked it every time the index
 file is used.  Omit the validation during normal use, and instead
 verify only in "git fsck".

 Will merge to 'master'.


* ls/travis-doc-asciidoctor (2017-04-16) 3 commits
  (merged to 'next' on 2017-04-19 at 359c32953b)
 + travis-ci: unset compiler for jobs that do not need one
 + travis-ci: parallelize documentation build
 + travis-ci: build documentation with AsciiDoc and Asciidoctor

 Have Travis CI format the documentation with both AsciiDoc and
 AsciiDoctor.

 Will merge to 'master'.


* mg/status-in-progress-info (2017-04-14) 1 commit
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 Waiting for final confirmation.
 cf. <xmqqwpajikd2.fsf@gitster.mtv.corp.google.com>


* nd/conditional-config-include (2017-04-14) 2 commits
  (merged to 'next' on 2017-04-19 at 2e94c40b46)
 + config: resolve symlinks in conditional include's patterns
 + path.c: and an option to call real_path() in expand_user_path()

 $GIT_DIR may in some cases be normalized with all symlinks resolved
 while "gitdir" path expansion in the pattern does not receive the
 same treatment, leading to incorrect mismatch.  This has been fixed.

 Will merge to 'master'.


* nd/worktree-add-lock (2017-04-16) 2 commits
 - SQUASH???
 - worktree add: add --lock option

 Allow to lock a worktree immediately after it's created. This helps
 prevent a race between "git worktree add; git worktree lock" and
 "git worktree prune".

 Waiting for a response to SQUASH???


* ps/pathspec-empty-prefix-origin (2017-04-14) 1 commit
 - pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty prefix

 A recent update broke "git add -p ../foo" from a subdirectory.

 Will merge to 'next'.


* sr/http-proxy-configuration-fix (2017-04-13) 2 commits
  (merged to 'next' on 2017-04-19 at d8f507e951)
 + http: fix the silent ignoring of proxy misconfiguraion
 + http: honor empty http.proxy option to bypass proxy

 "http.proxy" set to an empty string is used to disable the usage of
 proxy.  We broke this early last year.

 Will merge to 'master'.


* tb/doc-eol-normalization (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-19 at fe15d04d0a)
 + gitattributes.txt: document how to normalize the line endings

 Doc update.

 Will merge to 'master'.


* gb/rebase-signoff (2017-04-18) 3 commits
  (merged to 'next' on 2017-04-19 at c3c04e6a71)
 + rebase: pass --[no-]signoff option to git am
 + builtin/am: fold am_signoff() into am_append_signoff()
 + builtin/am: honor --signoff also when --rebasing

 "git rebase" learns "--signoff" option.

 Will merge to 'master'.


* jh/add-index-entry-optim (2017-04-19) 5 commits
 - read-cache: speed up has_dir_name (part 2)
 - read-cache: speed up has_dir_name (part 1)
 - read-cache: speed up add_index_entry during checkout
 - p0006-read-tree-checkout: perf test to time read-tree
 - read-cache: add strcmp_offset function

 "git checkout" that handles a lot of paths has been optimized by
 reducing the number of unnecessary checks of paths in the
 has_dir_name() function.

 Will merge to 'next'.


* ab/grep-threading-cleanup (2017-04-16) 8 commits
 - grep: given --threads with NO_PTHREADS=YesPlease, warn
 - pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
 - pack-object & index-pack: add test for --threads warning under NO_PTHREADS
 - tests: add a PTHREADS prerequisite
 - grep: skip pthreads overhead when using one thread
 - grep: don't redundantly compile throwaway patterns under threading
 - grep: add tests for --threads=N and grep.threads
 - grep: assert that threading is enabled when calling grep_{lock,unlock}


* bw/submodule-with-bs-path (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-19 at 692775477b)
 + submodule: prevent backslash expantion in submodule names

 "git submodule" script does not work well with strange pathnames.
 Protect it from a path with slashes in them, at least.

 Will merge to 'master'.


* jk/loose-object-fsck (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-19 at 0cc7810018)
 + sha1_file: remove an used fd variable

 Code cleanup.

 Will merge to 'master'.


* jk/quarantine-received-objects (2017-04-16) 3 commits
  (merged to 'next' on 2017-04-19 at 2c6fcf1d6d)
 + refs: reject ref updates while GIT_QUARANTINE_PATH is set
 + receive-pack: document user-visible quarantine effects
 + receive-pack: drop tmp_objdir_env from run_update_hook

 Add finishing touches to a recent topic.

 Will merge to 'master'.


* ls/travis-coccicheck (2017-04-16) 1 commit
 - travis-ci: add static analysis build job to run coccicheck

 Travis CI learns to run coccicheck.

 Will merge to 'next'.


* rs/misc-cppcheck-fixes (2017-04-17) 3 commits
  (merged to 'next' on 2017-04-19 at e8fca7f593)
 + server-info: avoid calling fclose(3) twice in update_info_file()
 + files_for_each_reflog_ent_reverse(): close stream and free strbuf on error
 + am: close stream on error, but not stdin

 Various small fixes.

 Will merge to 'master'.


* km/t1400-modernization (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-19 at 7490be39bf)
 + t1400: use consistent style for test_expect_success calls

 Code cleanup.

 Will merge to 'master'.


* dt/http-postbuffer-can-be-large (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-19 at dc9de26fc9)
 + http.postbuffer: allow full range of ssize_t values

 Allow the http.postbuffer configuration variable to be set to a
 size that can be expressed in size_t, which can be larger than
 ulong on some platforms.

 Will merge to 'master'.


* pc/t2027-git-to-pipe-cleanup (2017-04-14) 1 commit
 - t2027: avoid using pipes

 Having a git command on the upstream side of a pipe in a test
 script will hide the exit status from the command, which may cause
 us to fail to notice a breakage; rewrite tests in a script to avoid
 this issue.

 Will merge to 'next'.


* bp/sub-process-convert-filter (2017-03-30) 8 commits
 - convert: update subprocess_read_status to not die on EOF
 - sub-process: move sub-process functions into separate files
 - convert: rename reusable sub-process functions
 - convert: update generic functions to only use generic data structures
 - convert: separate generic structures and variables from the filter specific ones
 - convert: split start_multi_file_filter() into two separate functions
 - convert: move packet_write_list() into pkt-line.c as packet_writel()
 - pkt-line: add packet_read_line_gently()

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.

 Reroll exists but needs more work.
 cf. <20170407120354.17736-1-benpeart@microsoft.com>


* cc/split-index-config (2017-03-30) 1 commit
 - read-cache: avoid using git_path() in freshen_shared_index()

 The split-index code configuration code used an unsafe git_path()
 function without copying its result out.

 Needs to be explained better.
 The code looked OK, though.


* mg/name-rev-debug (2017-03-31) 4 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Expecting a reroll of the tip two.
 cf. <xmqqshltxnwt.fsf@gitster.mtv.corp.google.com>


* mh/separate-ref-cache (2017-04-16) 20 commits
 - do_for_each_entry_in_dir(): delete function
 - files_pack_refs(): use reference iteration
 - commit_packed_refs(): use reference iteration
 - cache_ref_iterator_begin(): make function smarter
 - get_loose_ref_cache(): new function
 - get_loose_ref_dir(): function renamed from get_loose_refs()
 - do_for_each_entry_in_dir(): eliminate `offset` argument
 - refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
 - ref-cache: use a callback function to fill the cache
 - refs: record the ref_store in ref_cache, not ref_dir
 - ref-cache: introduce a new type, ref_cache
 - refs: split `ref_cache` code into separate files
 - ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
 - ref-cache: rename `find_ref()` to `find_ref_entry()`
 - ref-cache: rename `add_ref()` to `add_ref_entry()`
 - refs_verify_refname_available(): use function in more places
 - refs_verify_refname_available(): implement once for all backends
 - refs_ref_iterator_begin(): new function
 - refs_read_raw_ref(): new function
 - get_ref_dir(): don't call read_loose_refs() for "refs/bisect"

 The internals of the refs API around the cached refs has been
 streamlined.

 Will merge to 'next'.


* ja/doc-l10n (2017-03-20) 3 commits
 - SQUASH???
 - l10n: add git-add.txt to localized man pages
 - l10n: introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.


* nd/prune-in-worktree (2017-04-19) 12 commits
 - rev-list: expose and document --single-worktree
 - revision.c: --reflog add HEAD reflog from all worktrees
 - files-backend: make reflog iterator go through per-worktree reflog
 - revision.c: --all adds HEAD from all worktrees
 - refs: remove dead for_each_*_submodule()
 - revision.c: use refs_for_each*() instead of for_each_*_submodule()
 - refs: add refs_head_ref()
 - refs: move submodule slash stripping code to get_submodule_ref_store
 - refs.c: refactor get_submodule_ref_store(), share common free block
 - revision.c: --indexed-objects add objects from all worktrees
 - revision.c: refactor add_index_objects_to_pending()
 - revision.h: new flag in struct rev_info wrt. worktree-related refs
 (this branch uses nd/worktree-kill-parse-ref.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Waiting for nd/worktree-kill-parse-ref to settle.


* nd/worktree-kill-parse-ref (2017-04-16) 5 commits
 - refs: kill set_worktree_head_symref()
 - worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 - refs: introduce get_worktree_ref_store()
 - refs.c: make submodule ref store hashmap generic
 - environment.c: fix potential segfault by get_git_common_dir()
 (this branch is used by nd/prune-in-worktree.)

 "git gc" did not interact well with "git worktree"-managed
 per-worktree refs.

 Will merge to 'next'.


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

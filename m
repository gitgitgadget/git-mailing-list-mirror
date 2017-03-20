Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6168820958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbdCTWxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:53:31 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:55960 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbdCTWxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 18:53:30 -0400
Received: from pb-sasl-trial2.pobox.com (ro.sql.pobox.com [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id E28DE17578;
        Mon, 20 Mar 2017 18:43:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=e
        3J+iGFP3Lw6NzbBp82Mn3kzxkk=; b=aCs+AtKQ6MFdoNwgE/lcyNOXEPPaADwSx
        hNvZbOtZ77F44XvM/rz0KwFNCoiv4pcoCfqglYm39c+i25/nvZoX0UJc1tAvxHem
        oIWu+QSRDjESdGhzLpxnTdIUHnnmxPIXci7n3ysBYVF35hikYUV2uPDNRiMJjxAi
        tc5K8k8hKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=EQ2
        xfnpLa/cFElOyVb908ZX/PLgiBIkT8bj4nkbQZtZRELBtPvxaFDn8a+Nd3mNM4T+
        jal7zExlfg5+WZ9qhaOZpqdZMUTmcEiZIfYAMaankpLdn0fLctgrnXm6CSOILdLS
        cfUMdKJWhnPee3Q+xiF7hZVOKj/MzyztHBpdk5lo=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id AF45C17577;
        Mon, 20 Mar 2017 18:43:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B404B81776;
        Mon, 20 Mar 2017 18:43:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2017, #08; Mon, 20)
X-master-at: c0f9c705890ac30871c70219c4b08d740fb40e2e
X-next-at: ab5fba24ee0096b15bf4e814f5ebf1f0cc20c7a5
Date:   Mon, 20 Mar 2017 15:43:41 -0700
Message-ID: <xmqqefxrtvqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB5DDEB8-0DBE-11E7-A01F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.12.1 has been tagged with minimum fixups post 2.12; there is a
larger batch being prepared for 2.12.2 to sweep other fixes that have
been in 'master' for issues identified since 2.12 was released.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* js/difftool-builtin (2017-03-15) 3 commits
  (merged to 'next' on 2017-03-16 at 3fccb60a07)
 + difftool: handle modified symlinks in dir-diff mode
 + t7800: cleanup cruft left behind by tests
 + t7800: remove whitespace before redirect

 "git difftool --dir-diff" used to die a controlled death giving a
 "fatal" message when encountering a locally modified symbolic link,
 but it started segfaulting since v2.12.  This has been fixed.

--------------------------------------------------
[New Topics]

* ab/doc-submitting (2017-03-18) 2 commits
 - doc/SubmittingPatches: show how to get a CLI commit summary
 - doc/SubmittingPatches: clarify the casing convention for "area: change..."

 Doc update.

 The example added by the second one may want to be shortened.


* bw/grep-recurse-submodules (2017-03-18) 2 commits
 - grep: fix builds with with no thread support
 - grep: set default output method

 Build fix for NO_PTHREADS build.

 Will merge to 'next'.


* ja/doc-l10n (2017-03-18) 2 commits
 . l10n: Add git-add.txt to localized man pages
 . l10n: Introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.


* jk/execv-dashed-external (2017-03-18) 1 commit
  (merged to 'next' on 2017-03-20 at 62119fa314)
 + run-command: fix segfault when cleaning forked async process

 Fix for NO_PTHREADS build.

 Will merge to 'master'.


* js/regexec-buf (2017-03-18) 1 commit
  (merged to 'next' on 2017-03-20 at 7381595eb7)
 + pickaxe: fix segfault with '-S<...> --pickaxe-regex'

 Fix for potential segv introduced in v2.11.0 and later (also
 v2.10.2).

 Will merge to 'master'.


* rs/http-push-cleanup (2017-03-18) 1 commit
  (merged to 'next' on 2017-03-20 at fcf8d30bc0)
 + http-push: don't check return value of lookup_unknown_object()

 Code clean-up.

 Will merge to 'master'.


* rs/path-name-safety-cleanup (2017-03-18) 1 commit
  (merged to 'next' on 2017-03-20 at 78ea574469)
 + revision: remove declaration of path_name()

 Code clean-up.

 Will merge to 'master'.


* rs/shortlog-cleanup (2017-03-18) 1 commit
  (merged to 'next' on 2017-03-20 at a826dff5cf)
 + shortlog: don't set after_subject to an empty string

 Code clean-up.

 Will merge to 'master'.


* rs/update-hook-optim (2017-03-18) 1 commit
  (merged to 'next' on 2017-03-20 at f36ede55be)
 + receive-pack: simplify run_update_post_hook()

 Code clean-up.

 Will merge to 'master'.


* sg/test-with-stdin (2017-03-18) 2 commits
  (merged to 'next' on 2017-03-20 at a66fec5692)
 + tests: make the 'test_pause' helper work in non-verbose mode
 + tests: create an interactive gdb session with the 'debug' helper

 Teach the "debug" helper used in the test framework that allows a
 command to run under "gdb" to make the session interactive.

 Will merge to 'master'.


* ab/doc-no-option-notation-fix (2017-03-20) 1 commit
  (merged to 'next' on 2017-03-20 at a6afe78ab4)
 + doc: change erroneous --[no]-whatever into --[no-]whatever

 Doc fix.

 Will merge to 'master'.


* ab/push-default-doc-fix (2017-03-20) 1 commit
  (merged to 'next' on 2017-03-20 at 0f4d4470de)
 + push: mention "push.default=tracking" in the documentation

 Doc fix.

 Will merge to 'master'.


* nd/commit-hook-doc-fix (2017-03-20) 1 commit
  (merged to 'next' on 2017-03-20 at 7ab46d99f4)
 + git-commit.txt: list post-rewrite in HOOKS section

 Doc fix.

 Will merge to 'master'.


* tg/stash-push-fixup (2017-03-20) 3 commits
 - stash: pass the pathspec argument to git reset
 - stash: make push -p -q --no-keep-index quiet
 - stash: show less information for stash push -- <pathspec>

 Recent enhancement to "git stash push" command to support pathspec
 to allow only a subset of working tree changes to be stashed away
 was found to be too chatty and exposed the internal implementation
 detail (e.g. when it uses reset to match the index to HEAD before
 doing other things, output from reset seeped out).  These, and
 other chattyness has been fixed.

 Looked alright.
 cf. <20170317145039.dmcb3qyqbzfvtmgz@sigill.intra.peff.net>

--------------------------------------------------
[Stalled]

* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>


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


* jh/memihash-opt (2017-02-17) 5 commits
 - name-hash: remember previous dir_entry during lazy_init_name_hash
 - name-hash: specify initial size for istate.dir_hash table
 - name-hash: precompute hash values during preload-index
 - hashmap: allow memihash computation to be continued
 - name-hash: eliminate duplicate memihash call

 Expecting an update for perf.
 cf. <MWHPR03MB29581B0EDDEDCA7D51EC396F8A280@MWHPR03MB2958.namprd03.prod.outlook.com>


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* sg/completion-refs-speedup (2017-02-13) 13 commits
 - squash! completion: fill COMPREPLY directly when completing refs
 - completion: fill COMPREPLY directly when completing refs
 - completion: list only matching symbolic and pseudorefs when completing refs
 - completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' strip the remote name from remote branches
 - completion: let 'for-each-ref' and 'ls-remote' filter matching refs
 - completion: don't disambiguate short refs
 - completion: don't disambiguate tags and branches
 - completion: support excluding full refs
 - completion: support completing full refs after '--option=refs/<TAB>'
 - completion: wrap __git_refs() for better option parsing
 - completion: remove redundant __gitcomp_nl() options from _git_commit()

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 What's the donness of this topic?


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

* nd/prune-in-worktree (2017-03-18) 12 commits
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
 (this branch uses nd/files-backend-git-dir and nd/worktree-kill-parse-ref.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Waiting for nd/files-backend-git-dir to settle.


* nd/worktree-kill-parse-ref (2017-03-18) 4 commits
 - refs: kill set_worktree_head_symref()
 - worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 - refs: introduce get_worktree_ref_store()
 - environment.c: fix potential segfault by get_git_common_dir()
 (this branch is used by nd/prune-in-worktree; uses nd/files-backend-git-dir.)

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Waiting for nd/files-backend-git-dir to settle.


* nd/files-backend-git-dir (2017-03-18) 27 commits
 - refs.h: add a note about sorting order of for_each_ref_*
 - t1406: new tests for submodule ref store
 - t1405: some basic tests on main ref store
 - t/helper: add test-ref-store to test ref-store functions
 - refs: delete pack_refs() in favor of refs_pack_refs()
 - files-backend: avoid ref api targetting main ref store
 - refs: new transaction related ref-store api
 - refs: add new ref-store api
 - refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 - files-backend: replace submodule_allowed check in files_downcast()
 - refs: move submodule code out of files-backend.c
 - path.c: move some code out of strbuf_git_path_submodule()
 - refs.c: make get_main_ref_store() public and use it
 - refs.c: kill register_ref_store(), add register_submodule_ref_store()
 - refs.c: flatten get_ref_store() a bit
 - refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 - refs.c: introduce get_main_ref_store()
 - files-backend: remove the use of git_path()
 - files-backend: add and use files_refname_path()
 - files-backend: add and use files_reflog_path()
 - files-backend: move "logs/" out of TMP_RENAMED_LOG
 - files-backend: convert git_path() to strbuf_git_path()
 - files-backend: make sure files_rename_ref() always reach the end
 - files-backend: add and use files_packed_refs_path()
 - files-backend: delete dead code in files_init_db()
 - files-backend: make files_log_ref_write() static
 - refs.h: add forward declaration for structs used in this file
 (this branch is used by nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.

 Expecting a reroll.
 cf. <CACsJy8A6mZGjNdFbhKgWAR=XSK+2mO-HG7Vayp7VODRJwu1ixA@mail.gmail.com>
 cf. <CACsJy8CC-BDHPLnE8DAXCxpttwgEsrQU9gzzc=PGsmFnh=XNpw@mail.gmail.com>
 It is almost there; only a few minor niggles remain.


* ab/ref-filter-no-contains (2017-03-18) 8 commits
 - tag: change --point-at to default to HEAD
 - tag: add tests for --with and --without
 - ref-filter: add --no-contains option to tag/branch/for-each-ref
 - tag: implicitly supply --list given the -n option
 - tag: implicitly supply --list given another list-like option
 - tag: change misleading --list <pattern> documentation
 - tag: refactor the options handling code to be less bizarre
 - tag: remove a TODO item from the test suite

 "git tag/branch/for-each-ref" family of commands long allowed to
 filter the refs by "--contains X" (show only the refs that are
 descendants of X), "--merged X" (show only the refs that are
 ancestors of X), "--no-merged X" (show only the refs that are not
 ancestors of X).  One curious omission, "--no-contains X" (show
 only the refs that are not descendants of X) has been added to
 them.

 Expecting a reroll.
 cf. <CACBZZX5GErSBsiCz0Y2SgtvckcPE51ekfUgBpvYjNF1u44piMA@mail.gmail.com>
 Again, this is almost there and a reroll is expected to be very minor.


* jc/name-rev (2017-03-16) 2 commits
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git name-rev" penalized lightweight tags too much, making them
 almost useless especially when the command is run with "--tags".
 Give the same precedence to lightweight tags as annotated tags as
 the base for naming a commit.


* jk/pack-name-cleanups (2017-03-16) 5 commits
  (merged to 'next' on 2017-03-16 at 6aa72195f5)
 + index-pack: make pointer-alias fallbacks safer
 + replace snprintf with odb_pack_name()
 + odb_pack_keep(): stop generating keepfile name
 + sha1_file.c: make pack-name helper globally accessible
 + move odb_* declarations out of git-compat-util.h

 Code clean-up.

 Will merge to 'master'.


* jk/rev-parse-cleanup (2017-03-15) 3 commits
  (merged to 'next' on 2017-03-16 at 2799b37404)
 + rev-parse: simplify parsing of ref options
 + rev-parse: add helper for parsing "--foo/--foo="
 + rev-parse: use skip_prefix when parsing options

 Code clean-up.

 Will merge to 'master'.


* mg/prompt-describe-tags (2017-03-15) 1 commit
  (merged to 'next' on 2017-03-16 at 4de192caf4)
 + git-prompt: add a describe style for any tags

 The command line prompt (in contrib/) learned a new 'tag' style
 that can be specified with GIT_PS1_DESCRIBE_STYLE, to describe a
 detached HEAD with "git describe --tags".

 Will merge to 'master'.


* sb/submodule-config-parse-ignore-fix (2017-03-15) 1 commit
  (merged to 'next' on 2017-03-16 at 99d2524abd)
 + submodule-config: correct error reporting for invalid ignore value

 Code to read submodule.<name>.ignore config did not state the
 variable name correctly when giving an error message diagnosing
 misconfiguration.

 Will merge to 'master'.


* bw/recurse-submodules-relative-fix (2017-03-17) 5 commits
 - ls-files: fix bug when recursing with relative pathspec
 - ls-files: fix typo in variable name
 - grep: fix bug when recursing with relative pathspec
 - setup: allow for prefix to be passed to git commands
 - grep: fix help text typo

 A few commands that recently learned the "--recurse-submodule"
 option misbehaved when started from a subdirectory of the
 superproject.


* jc/p4-current-branch-fix (2017-03-17) 1 commit
 - DONTMERGE git-p4: "name-rev HEAD" is not a way to find the current branch

 "git p4" used "name-rev HEAD" when it wants to learn what branch is
 checked out; it should use "symbolic-ref HEAD".

 Waiting for git-p4 folks to send a finished patch.


* js/rebase-helper (2017-03-17) 1 commit
  (merged to 'next' on 2017-03-20 at 2b72d03e0e)
 + sequencer: drop "warning:" when stopping for edit

 Recent update to "rebase -i" started showing a message that is not
 a warning with "warning:" prefix by mistake.  This has been fixed.

 Will merge to 'master'.


* sb/wt-status-cleanup (2017-03-17) 1 commit
  (merged to 'next' on 2017-03-20 at ce800cd91b)
 + wt-status: simplify by using for_each_string_list_item

 Code clean-up.

 Will merge to 'master'.


* bw/submodule-is-active (2017-03-18) 10 commits
 - submodule add: respect submodule.active and submodule.<name>.active
 - submodule--helper init: set submodule.<name>.active
 - clone: teach --recurse-submodules to optionally take a pathspec
 - submodule init: initialize active submodules
 - submodule: decouple url and submodule interest
 - submodule--helper clone: check for configured submodules using helper
 - submodule sync: use submodule--helper is-active
 - submodule sync: skip work for inactive submodules
 - submodule status: use submodule--helper is-active
 - submodule--helper: add is-active subcommand

 "what URL do we want to update this submodule?" and "are we
 interested in this submodule?" are split into two distinct
 concepts, and then the way used to express the latter got extended,
 paving a way to make it easier to manage a project with many
 submodules and make it possible to later extend use of multiple
 worktrees for a project with submodules.

 This looks almost ready for 'next'.  Any more comments?


* dl/credential-cache-socket-in-xdg-cache (2017-03-17) 3 commits
  (merged to 'next' on 2017-03-20 at 9de71bcce8)
 + credential-cache: add tests for XDG functionality
 + credential-cache: use XDG_CACHE_HOME for socket
 + path.c: add xdg_cache_home

 The default location "~/.git-credential-cache/socket" for the
 socket used to communicate with the credential-cache daemon has
 been moved to "~/.cache/git/credential/socket".

 Will merge to 'master'.


* jk/sha1dc (2017-03-17) 6 commits
  (merged to 'next' on 2017-03-20 at 3455b6c19f)
 + Makefile: make DC_SHA1 the default
 + t0013: add a basic sha1 collision detection test
 + Makefile: add DC_SHA1 knob
 + sha1dc: disable safe_hash feature
 + sha1dc: adjust header includes for git
 + sha1dc: add collision-detecting sha1 implementation

 The "detect attempt to create collisions" variant of SHA-1
 implementation by Marc Stevens (CWI) and Dan Shumow (Microsoft)
 has been integrated and made the default.

 Will merge to 'master'.


* nd/conditional-config-include (2017-03-11) 3 commits
  (merged to 'next' on 2017-03-17 at 788a931e39)
 + config: add conditional include
 + config.txt: reflow the second include.path paragraph
 + config.txt: clarify multiple key values in include.path

 The configuration file learned a new "includeIf.<condition>.path"
 that includes the contents of the given path only when the
 condition holds.  This allows you to say "include this work-related
 bit only in the repositories under my ~/work/ directory".

 Will merge to 'master'.


* sb/checkout-recurse-submodules (2017-03-16) 19 commits
 - builtin/read-tree: add --recurse-submodules switch
 - builtin/checkout: add --recurse-submodules switch
 - entry.c: create submodules when interesting
 - unpack-trees: check if we can perform the operation for submodules
 - unpack-trees: pass old oid to verify_clean_submodule
 - update submodules: add submodule_move_head
 - submodule.c: get_super_prefix_or_empty
 - update submodules: move up prepare_submodule_repo_env
 - submodules: introduce check to see whether to touch a submodule
 - update submodules: add a config option to determine if submodules are updated
 - update submodules: add submodule config parsing
 - make is_submodule_populated gently
 - lib-submodule-update.sh: define tests for recursing into submodules
 - lib-submodule-update.sh: replace sha1 by hash
 - lib-submodule-update: teach test_submodule_content the -C <dir> flag
 - lib-submodule-update.sh: do not use ./. as submodule remote
 - lib-submodule-update.sh: reorder create_lib_submodule_repo
 - submodule--helper.c: remove duplicate code
 - connect_work_tree_and_git_dir: safely create leading directories

 "git checkout" is taught --recurse-submodules option.

 This looks almost ready for 'next'.  Any more comments?


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2017-02-27 at 7373a1b73d)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2017-02-27 at 2c0f5f73d8)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.


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

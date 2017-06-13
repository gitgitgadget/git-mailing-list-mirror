Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BF31FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdFMVkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:40:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36389 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdFMVkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:40:19 -0400
Received: by mail-it0-f68.google.com with SMTP id 185so13011312itv.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=1VhTGDnocyQVIrrc+VM3f/GlT+cUwkq2CAD3CZyqv1c=;
        b=uClLqKVJP44bkUGb0palFSczDVU88fcWMwatz7yEE2ZpSRhFOG1Acn60G8TSmIR9eJ
         YLV7be2iOQzwWgRgXrEtOUa9tqIoSLat1goliixVuF0CTi/QBAah5Wn6BQHMkc/B4Mx6
         rdDqEPjlo0iCkA55aTM1ErIn1L0JZInl4Tavjc5Fa2YNAbjprJL7HPphLsazpymf+oYi
         oGtUCprNpsfUae7Rgfdpi11+7lVmILQ23Mj3MFJ0frQB/3cC/4Zvdn0+mSe2vNzWLR5W
         rTDMjf1Tf9iD75uDK/i5cmnIWme2MNgtZwGqcF7lKh6reFtWT9ydP6G0bpteGetuZIcj
         U4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=1VhTGDnocyQVIrrc+VM3f/GlT+cUwkq2CAD3CZyqv1c=;
        b=U5tAXDLyN2AllyMDOGYxk/RsNntXH4Y0Mx+e6eqETc/AjvXTLc/cZu0J7qTRjQjc6S
         M5LCjBJM0CxHtdVe8Nscbm9Lyl7WlOHD7PMJugWrpYkJPDg8OM+qvt13CFW2LWAb1Qhs
         xkX/mCUvF1YB821GxgUwQ+ELPII434BLIQNAs3RYU5MKPcQAt6SZ2547O+ICWxtsF67Y
         3LTfMdP0DxeVTjIwGL/uetvxGuGbtYtTdVZiB3q/AC1Xf/pOHL8+B2QdUzSZPNWpybVk
         sMNBNEUAJvpa9L3beh0vso2vikHKYhRrgfU2tEQOKwUHBG6rQVb9y2EsOfZ9I7u9eeD+
         NH2A==
X-Gm-Message-State: AKS2vOxWFeV6U6FxIzP3p8LeUQVaiC2Irwu40LFjBSqqUih80xvMGfMk
        W+89uJ4BLUVmu8+GxWs=
X-Received: by 10.36.92.203 with SMTP id q194mr2603901itb.1.1497390018308;
        Tue, 13 Jun 2017 14:40:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 197sm2497723ity.5.2017.06.13.14.40.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:40:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2017, #04; Tue, 13)
X-master-at: 02a2850ad58eff6de70eb2dc5f96345c463857ac
X-next-at: 1d7a3356d075f99e85512d28ce621fe2de69778c
Date:   Tue, 13 Jun 2017 14:40:16 -0700
Message-ID: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

* jc/diff-tree-stale-comment (2017-06-02) 1 commit
  (merged to 'next' on 2017-06-04 at bffae281d2)
 + diff-tree: update stale in-code comments

 Comment fix.


* jc/noent-notdir (2017-05-30) 2 commits
  (merged to 'next' on 2017-06-04 at 7cb4efbc3c)
 + treewide: use is_missing_file_error() where ENOENT and ENOTDIR are checked
 + compat-util: is_missing_file_error()

 Our code often opens a path to an optional file, to work on its
 contents when we can successfully open it.  We can ignore a failure
 to open if such an optional file does not exist, but we do want to
 report a failure in opening for other reasons (e.g. we got an I/O
 error, or the file is there, but we lack the permission to open).

 The exact errors we need to ignore are ENOENT (obviously) and
 ENOTDIR (less obvious).  Instead of repeating comparison of errno
 with these two constants, introduce a helper function to do so.


* jk/pack-idx-corruption-safety (2017-06-07) 1 commit
  (merged to 'next' on 2017-06-07 at 31f94e174d)
 + t5313: make extended-table test more deterministic

 A flaky test has been corrected.


* nd/fopen-errors (2017-06-02) 13 commits
  (merged to 'next' on 2017-06-04 at 7a755e73bb)
 + mingw_fopen: report ENOENT for invalid file names
 + mingw: verify that paths are not mistaken for remote nicknames
 + log: fix memory leak in open_next_file()
 + rerere.c: move error_errno() closer to the source system call
 + print errno when reporting a system call error
 + wrapper.c: make warn_on_inaccessible() static
 + wrapper.c: add and use fopen_or_warn()
 + wrapper.c: add and use warn_on_fopen_errors()
 + config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
 + config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 + clone: use xfopen() instead of fopen()
 + use xfopen() in more places
 + git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.


* rf/completion (2017-06-02) 6 commits
  (merged to 'next' on 2017-06-04 at dde1e34703)
 + completion: add git config credentialCache.ignoreSIGHUP
 + completion: add git config credential completions
 + completion: add git config advice completions
 + completion: add git config am.threeWay completion
 + completion: add git config core completions
 + completion: add git config gc completions

 Completion updates.


* sb/submodule-blanket-recursive (2017-06-01) 9 commits
  (merged to 'next' on 2017-06-04 at 418bb03032)
 + builtin/fetch.c: respect 'submodule.recurse' option
 + builtin/push.c: respect 'submodule.recurse' option
 + builtin/grep.c: respect 'submodule.recurse' option
 + Introduce 'submodule.recurse' option for worktree manipulators
 + submodule loading: separate code path for .gitmodules and config overlay
 + reset/checkout/read-tree: unify config callback for submodule recursion
 + submodule test invocation: only pass additional arguments
 + submodule recursing: do not write a config variable twice
 + Merge branch 'ab/grep-preparatory-cleanup' into sb/submodule-blanket-recursive

 Many commands learned to pay attention to submodule.recurse
 configuration.

 It is not known if a simple "yes/no" is sufficient in the longer
 term, and what should happen when --recurse-submodules option starts
 taking "recurse into them how?" parameter, though.

--------------------------------------------------
[New Topics]

* js/alias-early-config (2017-06-13) 6 commits
 - Use the early config machinery to expand aliases
 - t7006: demonstrate a problem with aliases in subdirectories
 - t1308: relax the test verifying that empty alias values are disallowed
 - help: use early config when autocorrecting aliases
 - config: report correct line number upon error
 - discover_git_directory(): avoid setting invalid git_dir

 The code to pick up and execute command alias definition from the
 configuration used to switch to the top of the working tree and
 then come back when the expanded alias was executed, which was
 unnecessarilyl complex.  Attempt to simplify the logic by using the
 early-config mechanism that does not chdir around.

 Waiting for discussion to settle.


* pc/dir-count-slashes (2017-06-12) 1 commit
 - dir: create function count_slashes()

 Three instances of the same helper function have been consolidated
 to one.

 Will merge to 'next'.


* sb/t4005-modernize (2017-06-10) 1 commit
 - t4005: modernize style and drop hard coded sha1

 Test clean-up.

 Will merge to 'next'.


* ah/filter-branch-setup (2017-06-12) 2 commits
 - filter-branch: add [--] to usage
 - filter-branch: add `--setup` step

 "filter-branch" learned a pseudo filter "--setup" that can be used
 to define a common function/variable that can be used by other
 filters.

 Will merge to 'next'.


* bw/config-h (2017-06-13) 4 commits
 - config: don't implicitly use gitdir
 - config: don't include config.h by default
 - config: remove git_config_iter
 - config: create config.h

 Code clean-up.


* bw/ls-files-sans-the-index (2017-06-13) 17 commits
 - ls-files: factor out tag calculation
 - ls-files: factor out debug info into a function
 - ls-files: convert show_files to take an index
 - ls-files: convert show_ce_entry to take an index
 - ls-files: convert prune_cache to take an index
 - ls-files: convert ce_excluded to take an index
 - ls-files: convert show_ru_info to take an index
 - ls-files: convert show_other_files to take an index
 - ls-files: convert show_killed_files to take an index
 - ls-files: convert write_eolinfo to take an index
 - ls-files: convert overlay_tree_on_cache to take an index
 - tree: convert read_tree to take an index parameter
 - convert: convert renormalize_buffer to take an index
 - convert: convert convert_to_git to take an index
 - convert: convert convert_to_git_filter_fd to take an index
 - convert: convert crlf_to_git to take an index
 - convert: convert get_cached_convert_stats_ascii to take an index

 Code clean-up.


* jc/pretty-add-again (2017-06-13) 1 commit
 - add_again() off-by-one error in custom format


* jk/warn-add-gitlink (2017-06-13) 2 commits
 - t: move "git add submodule" into test blocks
 - add: warn when adding an embedded repository

 Using "git add d/i/r" when d/i/r is the top of the working tree of
 a separate repository would create a gitlink in the index, which
 would appear as a not-quite-initialized submodule to others.  We
 learned to give warnings when this happens.


* km/test-mailinfo-b-failure (2017-06-12) 1 commit
 - t5100: add some more mailinfo tests

 New tests.

 Will merge to 'next'.


* ls/github (2017-06-13) 1 commit
 - Configure Git contribution guidelines for github.com

 Help contributors that visit us at GitHub.

 Will merge to 'next'.


* mh/fast-import-raise-default-depth (2017-06-12) 1 commit
 - fast-import: increase the default pack depth to 50

 "fast-import" uses a default pack chain depth that is consistent
 with other parts of the system.

 Will merge to 'next'.


* mh/packed-ref-store-prep (2017-06-12) 1 commit
 - lock_packed_refs(): fix cache validity check

 Bugfix for a topic that is (only) in 'master'.

 Will merge to 'next'.


* ps/stash-push-pathspec-fix (2017-06-13) 1 commit
 - git-stash: fix pushing stash with pathspec from subdir

 "git stash push <pathspec>" did not work from a subdirectory at all.
 Bugfix for a topic in v2.13

 Will merge to 'next'.


* sb/submodule-doc (2017-06-13) 1 commit
 - submodules: overhaul documentation

 Doc update.


* sd/t3200-branch-m-test (2017-06-13) 1 commit
 - t3200: add test for single parameter passed to -m option

 New test.

 Will merge to 'next'.


* sd/branch-copy (2017-06-13) 3 commits
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.


--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* mg/name-rev-debug (2017-03-31) 2 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Will discard for now.
 cf. <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>


* sk/dash-is-previous (2017-03-01) 5 commits
 . revert.c: delegate handling of "-" shorthand to setup_revisions
 . sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 . revision.c: args starting with "-" might be a revision
 . revision.c: swap if/else blocks
 . revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Ejected, as it seems that making -.. to mean @{-1}..HEAD etc. are
 going too far.

--------------------------------------------------
[Cooking]

* bw/object-id (2017-06-05) 33 commits
  (merged to 'next' on 2017-06-13 at 0582278759)
 + diff: rename diff_fill_sha1_info to diff_fill_oid_info
 + diffcore-rename: use is_empty_blob_oid
 + tree-diff: convert path_appendnew to object_id
 + tree-diff: convert diff_tree_paths to struct object_id
 + tree-diff: convert try_to_follow_renames to struct object_id
 + builtin/diff-tree: cleanup references to sha1
 + diff-tree: convert diff_tree_sha1 to struct object_id
 + notes-merge: convert write_note_to_worktree to struct object_id
 + notes-merge: convert verify_notes_filepair to struct object_id
 + notes-merge: convert find_notes_merge_pair_ps to struct object_id
 + notes-merge: convert merge_from_diffs to struct object_id
 + notes-merge: convert notes_merge* to struct object_id
 + tree-diff: convert diff_root_tree_sha1 to struct object_id
 + combine-diff: convert find_paths_* to struct object_id
 + combine-diff: convert diff_tree_combined to struct object_id
 + diff: convert diff_flush_patch_id to struct object_id
 + patch-ids: convert to struct object_id
 + diff: finish conversion for prepare_temp_file to struct object_id
 + diff: convert reuse_worktree_file to struct object_id
 + diff: convert fill_filespec to struct object_id
 + diff: convert diff_change to struct object_id
 + diff: convert run_diff_files to struct object_id
 + diff: convert diff_addremove to struct object_id
 + diff: convert diff_index_show_file to struct object_id
 + diff: convert get_stat_data to struct object_id
 + grep: convert to struct object_id
 + notes: convert some accessor functions to struct object_id
 + builtin/notes: convert to struct object_id
 + notes: convert format_display_notes to struct object_id
 + notes: make get_note return pointer to struct object_id
 + notes: convert for_each_note to struct object_id
 + notes: convert internal parts to struct object_id
 + notes: convert internal structures to struct object_id

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'master'.


* rs/strbuf-addftime-zZ (2017-06-10) 2 commits
 - date: use localtime() for "-local" time formats
 - strbuf: let strbuf_addftime handle %z and %Z itself

 As there is no portable way to pass timezone information to
 strftime, some output format from "git log" and friends are
 impossible to produce.  Teach our own strbuf_addftime to replace %z
 and %Z with caller-supplied values to help working around this.

 Will merge to 'next'.


* sb/submodule-rm-absorb (2017-06-04) 1 commit
  (merged to 'next' on 2017-06-13 at ed902e8fb4)
 + Documentation/git-rm: correct submodule description

 Doc update to a recently graduated topic.

 Will merge to 'master'.


* sg/revision-parser-skip-prefix (2017-06-12) 5 commits
 - revision.c: use skip_prefix() in handle_revision_pseudo_opt()
 - revision.c: use skip_prefix() in handle_revision_opt()
 - revision.c: stricter parsing of '--early-output'
 - revision.c: stricter parsing of '--no-{min,max}-parents'
 - revision.h: turn rev_info.early_output back into an unsigned int

 Code clean-up.

 Will merge to 'next'.


* ab/perf-remove-index-lock (2017-06-05) 1 commit
  (merged to 'next' on 2017-06-13 at c532e59233)
 + perf: work around the tested repo having an index.lock

 When an existing repository is used for t/perf testing, we first
 create bit-for-bit copy of it, which may grab a transient state of
 the repository and freeze it into the repository used for testing,
 which then may cause Git operations to fail.  Single out "the index
 being locked" case and forcibly drop the lock from the copy.

 Will merge to 'master'.


* ls/filter-process-delayed (2017-06-01) 5 commits
 - convert: add "status=delayed" to filter process protocol
 - convert: move multiple file filter error handling to separate function
 - t0021: write "OUT" only on success
 - t0021: make debug log file name configurable
 - t0021: keep filter log files on comparison

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.

 Needs review.


* jk/consistent-h (2017-06-05) 8 commits
  (merged to 'next' on 2017-06-13 at e09c1fe968)
 + t0012: test "-h" with builtins
 + git: add hidden --list-builtins option
 + version: convert to parse-options
 + diff- and log- family: handle "git cmd -h" early
 + submodule--helper: show usage for "-h"
 + remote-{ext,fd}: print usage message on invalid arguments
 + upload-archive: handle "-h" option early
 + credential: handle invalid arguments earlier

 "git $cmd -h" for builtin commands calls the implementation of the
 command (i.e. cmd_$cmd() function) without doing any repository
 set-up, and the commands that expect RUN_SETUP is done by the Git
 potty needs to be prepared to show the help text without barfing.

 Will merge to 'master'.


* pw/rebase-i-regression-fix-tests (2017-06-01) 1 commit
 - rebase -i: add test for reflog message

 Just the first one of three? new tests that follows up a regression
 fix.

 Expecting a portable update.


* ab/pcre-v2 (2017-06-02) 8 commits
  (merged to 'next' on 2017-06-13 at 34bf49ee44)
 + grep: add support for PCRE v2
 + grep: un-break building with PCRE >= 8.32 without --enable-jit
 + grep: un-break building with PCRE < 8.20
 + grep: un-break building with PCRE < 8.32
 + grep: add support for the PCRE v1 JIT API
 + log: add -P as a synonym for --perl-regexp
 + grep: skip pthreads overhead when using one thread
 + grep: don't redundantly compile throwaway patterns under threading

 Update "perl-compatible regular expression" support to enable JIT
 and also allow linking with the newer PCRE v2 library.

 Will merge to 'master'.


* jk/pathspec-magic-disambiguation (2017-05-29) 6 commits
  (merged to 'next' on 2017-06-13 at 088987f033)
 + verify_filename(): flip order of checks
 + verify_filename(): treat ":(magic)" as a pathspec
 + check_filename(): handle ":^" path magic
 + check_filename(): use skip_prefix
 + check_filename(): refactor ":/" handling
 + t4208: add check for ":/" without matching file

 The convention for a command line is to follow "git cmdname
 --options" with revisions followed by an optional "--"
 disambiguator and then finally pathspecs.  When "--" is not there,
 we make sure early ones are all interpretable as revs (and do not
 look like paths) and later ones are the other way around.  A
 pathspec with "magic" (e.g. ":/p/a/t/h" that matches p/a/t/h from
 the top-level of the working tree, no matter what subdirectory you
 are working from) are conservatively judged as "not a path", which
 required disambiguation more often.  The command line parser
 learned to say "it's a pathspec" a bit more often when the syntax
 looks like so.

 Will merge to 'master'.


* ab/sha1dc (2017-06-07) 2 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.

 Will keep in 'pu'.
 Impact to the various build and release infrastructure of using
 submodule is not yet fully known, but this lets us dip our toes.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Waiting for discussion to settle.


* sb/diff-color-move (2017-06-01) 17 commits
 - diff.c: color moved lines differently
 - diff: buffer all output if asked to
 - diff.c: emit_line includes whitespace highlighting
 - diff.c: convert diff_summary to use emit_line_*
 - diff.c: convert diff_flush to use emit_line_*
 - diff.c: convert word diffing to use emit_line_*
 - diff.c: convert show_stats to use emit_line_*
 - diff.c: convert emit_binary_diff_body to use emit_line_*
 - submodule.c: convert show_submodule_summary to use emit_line_fmt
 - diff.c: convert emit_rewrite_lines to use emit_line_*
 - diff.c: convert emit_rewrite_diff to use emit_line_*
 - diff.c: convert builtin_diff to use emit_line_*
 - diff.c: convert fn_out_consume to use emit_line
 - diff: introduce more flexible emit function
 - diff.c: factor out diff_flush_patch_all_file_pairs
 - diff: move line ending check into emit_hunk_header
 - diff: readability fix

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.

 Are we happy with these changes?


* xz/send-email-batch-size (2017-05-23) 1 commit
 - send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

 Waiting for response.
 cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>


* sg/clone-refspec-from-command-line-config (2017-06-01) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Are we happy with these two?


* js/rebase-i-final (2017-05-02) 10 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper
 - t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Expecting a reroll.
 This is at its v4.
 cf. <cover.1493414945.git.johannes.schindelin@gmx.de>


* nd/prune-in-worktree (2017-04-24) 12 commits
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

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Expecting a reroll.
 Has been waiting for nd/worktree-kill-parse-ref to settle.
 cf. <CACsJy8ADCVBiLoPg_Tz0L6CMdh_eFmK4RYzfQ-PmUgBK7w9e=A@mail.gmail.com>

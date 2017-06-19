Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971E81FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdFSUNK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:13:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34763 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdFSUNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:13:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id d5so19093842pfe.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=0zTjpidPuI99OuCVurZjHWF6+O4Cx9nkvg6HDEHOpU0=;
        b=jv+V3A06SMKo5ic4nOzogEVKXzY65gLi8XzIX73CdSACrOToiwKxY/UkAz/mrdBXuL
         Y/96PUqvqbkusUaXfNo+NHv+mUkBkItPfcai+FG3jQgTKFJcwLlnNzSmy7fRAzKTtLtC
         QwYr48zczdQrJbSWBxIGQHp4QnFfxT0rRqRTySAKaVFv8fCSOE7LbOKceoYoNOxzV7hk
         Yi5IIpOQXUiPnB/pSZLkyHKHlFNwPOlJ1Gn/Nf1yjRbrAUYuFK2Hoxk9QiG7zbP2Ba+Q
         HTk8VT4VYFuQAbPKdMUDa6MBBRtLnti5Ktf07MFQoHK0UWESCbxwFISbw60OL/Z+VuwC
         A3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=0zTjpidPuI99OuCVurZjHWF6+O4Cx9nkvg6HDEHOpU0=;
        b=HXe967GPL/qqA7M6DP1cJYJ/duB1untneSXPvR7+kv/eOjZFTG610fNzjjceq6gsKG
         vd7L/J5iORsILJFlR710binmxEFp1hSy9rYJtN68JxhHZlWTcC+x1Rl+/VrItRta8FOC
         Vvu8ZrexGfI4J/jTnTqInuPdWXqrLKf7BfKNs5f90zUVb65IHQrWADlryR3iQeu3WPp7
         NNPt2umjU99rmD9qGOJPnOih3RpfnRoBWZYHnVEushYJqHShEifzxbQnBYlb2yE09gzH
         EQmWBXUWLk5Qpu8rbvArZvG+JIU/ZocXtd7HQEETl5WRxmm+ApgUEhoODeYGPoRdT8Nm
         BX1A==
X-Gm-Message-State: AKS2vOzfBkt/UbGCGWpF9ZyrrhTKK+TnTiV7mcl12ROzVdHuGWTKUGGc
        OCc8hpBLmFfWNYIEV+fkiSB9
X-Received: by 10.84.139.67 with SMTP id 61mr31036710plq.19.1497903186651;
        Mon, 19 Jun 2017 13:13:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id 71sm10090436pge.45.2017.06.19.13.13.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 13:13:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2017, #05; Mon, 19)
X-master-at: 05ec6e13aaf33b6a647e1321203a770e697eea9a
X-next-at: 0b547a2794f32e58c5c5c23c1b30b5e3920b2855
Date:   Mon, 19 Jun 2017 13:13:04 -0700
Message-ID: <xmqqh8zbspm7.fsf@gitster.mtv.corp.google.com>
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


* ab/perf-remove-index-lock (2017-06-05) 1 commit
  (merged to 'next' on 2017-06-13 at c532e59233)
 + perf: work around the tested repo having an index.lock

 When an existing repository is used for t/perf testing, we first
 create bit-for-bit copy of it, which may grab a transient state of
 the repository and freeze it into the repository used for testing,
 which then may cause Git operations to fail.  Single out "the index
 being locked" case and forcibly drop the lock from the copy.


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


* sb/submodule-rm-absorb (2017-06-04) 1 commit
  (merged to 'next' on 2017-06-13 at ed902e8fb4)
 + Documentation/git-rm: correct submodule description

 Doc update to a recently graduated topic.

--------------------------------------------------
[New Topics]

* ab/free-and-null (2017-06-16) 6 commits
 - *.[ch] refactoring: make use of the FREE_AND_NULL() macro
 - coccinelle: make use of the "expression" FREE_AND_NULL() rule
 - coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
 - coccinelle: make use of the "type" FREE_AND_NULL() rule
 - coccinelle: add a rule to make "type" code use FREE_AND_NULL()
 - git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); ptr = NULL

 A common pattern to free a piece of memory and assign NULL to the
 pointer that used to point at it has been replaced with a new
 FREE_AND_NULL() macro.

 Will merge to 'next'.


* ab/wildmatch-glob-slash-test (2017-06-15) 1 commit
 - wildmatch test: cover a blind spot in "/" matching

 A new test to show the interaction between the pattern [^a-z]
 (which matches '/') and a slash in a path has been added.  The
 pattern should not match the slash with "pathmatch", but should
 with "wildmatch".

 Will merge to 'next'.


* ah/doc-gitattributes-empty-index (2017-06-15) 1 commit
 - doc: do not use `rm .git/index` when normalizing line endings

 An example in documentation that does not work in multi worktree
 configuration has been corrected.

 Will merge to 'next'.


* jk/diff-highlight-module (2017-06-15) 1 commit
 - diff-highlight: split code into module

 The 'diff-highlight' program (in contrib/) has been restructured
 for easier reuse by an external project 'diff-so-fancy'.

 Will merge to 'next'.


* jt/unify-object-info (2017-06-15) 4 commits
 - sha1_file, fsck: add missing blob support
 - sha1_file: consolidate storage-agnostic object fns
 - sha1_file: move delta base cache code up
 - sha1_file: teach packed_object_info about typename

 Code clean-ups.

 I seem to have made a mistake during my review of the previous
 one, and took this one in a wrong direction.  A better organization
 was suggested.
 cf. <20170617121934.a6onn7f2luhkuuym@sigill.intra.peff.net>


* rs/pretty-add-again (2017-06-15) 1 commit
 - pretty: recalculate duplicate short hashes

 The pretty-format specifiers like '%h', '%t', etc. had an
 optimization that no longer works correctly.  In preparation/hope
 of getting it correctly implemented, first discard the optimization
 that is broken.

 Will merge to 'next'.


* sg/doc-pretty-formats (2017-06-15) 1 commit
 - docs/pretty-formats: stress that %- removes all preceding line-feeds

 Doc update.

 Will merge to 'next'.


* sn/reset-doc-typofix (2017-06-15) 1 commit
 - doc: git-reset: fix a trivial typo

 Doc update.

 Will merge to 'next'.


* nd/fopen-errors (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-15 at 86bcb7c082)
 + configure.ac: loosen FREAD_READS_DIRECTORIES test program

 Hotfix for a topic that is already in 'master'.

 Will merge to 'next'.


* da/mergetools-meld-output-opt-on-macos (2017-06-18) 1 commit
 - mergetools/meld: improve compatibiilty with Meld on macOS X

 "git mergetool" learned to work around a wrapper MacOS X adds
 around underlying meld.

 Will merge to 'next'.


* ks/status-initial-commit (2017-06-18) 4 commits
 - SQUASH???
 - Add test for the new status message
 - SQUASH???
 - Contextually notify user about an initial commit

 "git status" has long shown essentially the same message as "git
 commit"; the message it gives while preparing for the root commit,
 i.e. "Initial commit", was hard to understand for some new users.
 Now it says "No commits yet" to stress more on the current status
 (rather than the commit the user is preparing for, which is more in
 line with the focus of "git commit").

 Expecting a reroll.
 cf. <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>


* lb/status-stash-count (2017-06-18) 3 commits
 - glossary: define 'stash entry'
 - status: add optional stash count information
 - stash: update documentation to use 'stash entry'

 "git status" learned to optionally give how many stash entries the
 user has in its output.

 Will merge to 'next'.


* mh/packed-ref-store (2017-06-18) 28 commits
 - read_packed_refs(): die if `packed-refs` contains bogus data
 - repack_without_refs(): don't lock or unlock the packed refs
 - commit_packed_refs(): remove call to `packed_refs_unlock()`
 - clear_packed_ref_cache(): don't protest if the lock is held
 - packed_refs_unlock(), packed_refs_is_locked(): new functions
 - packed_refs_lock(): report errors via a `struct strbuf *err`
 - packed_refs_lock(): function renamed from lock_packed_refs()
 - commit_packed_refs(): use a staging file separate from the lockfile
 - commit_packed_refs(): report errors rather than dying
 - packed_ref_store: make class into a subclass of `ref_store`
 - packed-backend: new module for handling packed references
 - packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
 - packed_ref_store: support iteration
 - packed_peel_ref(): new function, extracted from `files_peel_ref()`
 - repack_without_refs(): take a `packed_ref_store *` parameter
 - get_packed_ref(): take a `packed_ref_store *` parameter
 - rollback_packed_refs(): take a `packed_ref_store *` parameter
 - commit_packed_refs(): take a `packed_ref_store *` parameter
 - lock_packed_refs(): take a `packed_ref_store *` parameter
 - add_packed_ref(): take a `packed_ref_store *` parameter
 - get_packed_refs(): take a `packed_ref_store *` parameter
 - get_packed_ref_cache(): take a `packed_ref_store *` parameter
 - validate_packed_ref_cache(): take a `packed_ref_store *` parameter
 - clear_packed_ref_cache(): take a `packed_ref_store *` parameter
 - packed_ref_store: move `packed_refs_lock` member here
 - packed_ref_store: move `packed_refs_path` here
 - packed_ref_store: new struct
 - add_packed_ref(): teach function to overwrite existing refs
 (this branch uses mh/packed-ref-store-prep.)

 The "ref-store" code reorganization continues.

 Seems to break the promise that packed-refs are covered by loose
 refs and the former that points at a missing garbage is not an
 error.
 cf. <20170619195330.fhjlfiqmcwhgttaa@sigill.intra.peff.net>

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


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

--------------------------------------------------
[Cooking]

* js/alias-early-config (2017-06-15) 6 commits
 - alias: use the early config machinery to expand aliases
 - t7006: demonstrate a problem with aliases in subdirectories
 - t1308: relax the test verifying that empty alias values are disallowed
 - help: use early config when autocorrecting aliases
 - config: report correct line number upon error
 - discover_git_directory(): avoid setting invalid git_dir
 (this branch is used by bw/config-h.)

 The code to pick up and execute command alias definition from the
 configuration used to switch to the top of the working tree and
 then come back when the expanded alias was executed, which was
 unnecessarilyl complex.  Attempt to simplify the logic by using the
 early-config mechanism that does not chdir around.

 Will merge to 'next'.


* pc/dir-count-slashes (2017-06-12) 1 commit
  (merged to 'next' on 2017-06-19 at 57351a2771)
 + dir: create function count_slashes()

 Three instances of the same helper function have been consolidated
 to one.

 Will merge to 'master'.


* sb/t4005-modernize (2017-06-10) 1 commit
  (merged to 'next' on 2017-06-19 at beedeb757b)
 + t4005: modernize style and drop hard coded sha1

 Test clean-up.

 Will merge to 'master'.


* ah/filter-branch-setup (2017-06-12) 2 commits
  (merged to 'next' on 2017-06-19 at f3440f2c1a)
 + filter-branch: add [--] to usage
 + filter-branch: add `--setup` step

 "filter-branch" learned a pseudo filter "--setup" that can be used
 to define a common function/variable that can be used by other
 filters.

 Will merge to 'master'.


* bw/config-h (2017-06-15) 6 commits
 - config: don't implicitly use gitdir or commondir
 - config: respect commondir
 - setup: teach discover_git_directory to respect the commondir
 - config: don't include config.h by default
 - config: remove git_config_iter
 - config: create config.h
 (this branch uses js/alias-early-config.)

 Fix configuration codepath to pay proper attention to commondir
 that is used in multi-worktree situation, and isolate config API
 into its own header file.

 Will merge to 'next'.


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

 Will merge to 'next'.


* jk/warn-add-gitlink (2017-06-15) 2 commits
 - t: move "git add submodule" into test blocks
 - add: warn when adding an embedded repository

 Using "git add d/i/r" when d/i/r is the top of the working tree of
 a separate repository would create a gitlink in the index, which
 would appear as a not-quite-initialized submodule to others.  We
 learned to give warnings when this happens.

 Will merge to 'next'.


* km/test-mailinfo-b-failure (2017-06-12) 1 commit
  (merged to 'next' on 2017-06-19 at badc2c2337)
 + t5100: add some more mailinfo tests

 New tests.

 Will merge to 'master'.


* ls/github (2017-06-13) 1 commit
  (merged to 'next' on 2017-06-19 at 4d2024615f)
 + Configure Git contribution guidelines for github.com

 Help contributors that visit us at GitHub.

 Will merge to 'master'.


* mh/fast-import-raise-default-depth (2017-06-12) 1 commit
  (merged to 'next' on 2017-06-19 at 7093c07b8e)
 + fast-import: increase the default pack depth to 50

 "fast-import" uses a default pack chain depth that is consistent
 with other parts of the system.

 Will merge to 'master'.


* mh/packed-ref-store-prep (2017-06-18) 3 commits
 - prefix_ref_iterator_advance(): relax the check of trim length
 - for_each_bisect_ref(): don't trim refnames
 - lock_packed_refs(): fix cache validity check
 (this branch is used by mh/packed-ref-store.)

 Bugfix for a topic that is (only) in 'master'.

 Will merge the first two to 'next'.


* ps/stash-push-pathspec-fix (2017-06-13) 1 commit
  (merged to 'next' on 2017-06-19 at 866c9035e0)
 + git-stash: fix pushing stash with pathspec from subdir

 "git stash push <pathspec>" did not work from a subdirectory at all.
 Bugfix for a topic in v2.13

 Will merge to 'master'.


* sb/submodule-doc (2017-06-13) 1 commit
 - submodules: overhaul documentation

 Doc update.

 Waiting for discussion to settle.


* sd/t3200-branch-m-test (2017-06-13) 1 commit
  (merged to 'next' on 2017-06-19 at 0fd712c46e)
 + t3200: add test for single parameter passed to -m option

 New test.

 Will merge to 'master'.


* sd/branch-copy (2017-06-18) 3 commits
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Has a bit of interaction with two other topics, so perhaps needs to
 wait for them to stabilize a bit more.


* rs/strbuf-addftime-zZ (2017-06-15) 3 commits
  (merged to 'next' on 2017-06-19 at 77480669f0)
 + date: use localtime() for "-local" time formats
 + t0006: check --date=format zone offsets
 + strbuf: let strbuf_addftime handle %z and %Z itself

 As there is no portable way to pass timezone information to
 strftime, some output format from "git log" and friends are
 impossible to produce.  Teach our own strbuf_addftime to replace %z
 and %Z with caller-supplied values to help working around this.

 Will merge to 'master'.


* sg/revision-parser-skip-prefix (2017-06-12) 5 commits
  (merged to 'next' on 2017-06-19 at 0a90bec767)
 + revision.c: use skip_prefix() in handle_revision_pseudo_opt()
 + revision.c: use skip_prefix() in handle_revision_opt()
 + revision.c: stricter parsing of '--early-output'
 + revision.c: stricter parsing of '--no-{min,max}-parents'
 + revision.h: turn rev_info.early_output back into an unsigned int

 Code clean-up.

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


* pw/rebase-i-regression-fix-tests (2017-06-19) 4 commits
 - rebase: add more regression tests for console output
 - rebase: add regression tests for console output
 - rebase -i: add test for reflog message
 - sequencer: print autostash messages to stderr

 Fix a recent regression to "git rebase -i" and add tests that would
 have caught it and others.

 Will merge to 'next'.


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

 Is any more update coming?


* xz/send-email-batch-size (2017-05-23) 1 commit
 - send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

 Waiting for response.
 cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Are we happy with these two?
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>


* js/rebase-i-final (2017-06-15) 10 commits
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
 This is at its v5.
 cf. <cover.1497444257.git.johannes.schindelin@gmx.de>

--------------------------------------------------
[Discarded]

* nd/prune-in-worktree (2017-04-24) 12 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add refs_head_ref()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . refs.c: refactor get_submodule_ref_store(), share common free block
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.


* jc/pretty-add-again (2017-06-13) 1 commit
 . add_again() off-by-one error in custom format


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


* mg/name-rev-debug (2017-03-31) 2 commits
 . describe: pass --debug down to name-rev
 . name-rev: provide debug output

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Will discard for now.
 cf. <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu>

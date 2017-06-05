Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FA120D09
	for <e@80x24.org>; Mon,  5 Jun 2017 03:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdFED7G (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 23:59:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36104 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdFED7F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 23:59:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so621251pfd.3
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=rjpUXfZS2RZV7Dwqc5449niMDDPfWzkfbQSppKDdKog=;
        b=qTV2RGP1yNZGq+7xDAJwKPhZxUKAT4u+tutAwnVsfAig5OutG1FwMeWe4+g8bCX1ul
         ksp3CgL8t+P2ZPlmnUudBgWtvCpV5PLGHp4VH9/QkTcB3QFt7iQRa/CJCA00hHADnsgG
         lxJxpQDbJbGA+wkkhJte8khvA0nZFLkgL2YoeeMetRiJK+BZjOH+VkUCyHR8ewmAVPOu
         adeirE5/IqIjGyFLkHLgjJidCy6dwdeeKkc06zriHnCPSOZB5otXPowQ7z3zGF1T2MCW
         3g8OeKnhHbmwS5AKSrFVAC1KGcsCrG4GFwvoOduts/XbtyBEopMpsFr+1EMeyHjyD4mN
         +yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=rjpUXfZS2RZV7Dwqc5449niMDDPfWzkfbQSppKDdKog=;
        b=iO3pRmhfMAiSUsncZO0/GME1pZAQI1RdWEdYCTNyQroWKVsW3uR/LvnSDGYY8p7vb7
         F7SNvVGKEaM0vcQhCfdK8RDJPvnTC+tbLq2a6VOeQDEZIxDfB8ZuFzdvuik7mpke+aCc
         r3IB7Oa8tPv7X+rFoZHpU4gahHDznY+7sIpJfl5PxbR1mjfFCchnW14Y/PECb5FWHr58
         1E/x9tY+9IegoeV0lrDrcWjfG2A6Sif4f825z/9/KNj7wgD9H2hg4qh0TQU9z48b35D6
         niZ8i+wdgvgh6NFueZAq6Pw62WmjZ6fQ0j7WqKT9SvcgAtYN2kR0Jp7rTLIBJeZMpoSH
         MLJw==
X-Gm-Message-State: AODbwcBbDhvnSPqfoVNtQG0qPThnNnuVcldBpUsP+Tz7S9eO7axDv/J/
        xrpeRRJWxHraVunt4R8=
X-Received: by 10.84.232.8 with SMTP id h8mr12764807plk.278.1496635143694;
        Sun, 04 Jun 2017 20:59:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a83a:973:bb14:324a])
        by smtp.gmail.com with ESMTPSA id y28sm4068842pfd.32.2017.06.04.20.59.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 20:59:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2017, #03; Mon, 5)
X-master-at: 69e6b9b4f4a91ce90f2c38ed2fa89686f8aff44f
X-next-at: b3defc5cc2fce0752a80d6af33c0598a2e1a01f4
Date:   Mon, 05 Jun 2017 12:59:01 +0900
Message-ID: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com>
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

With many fixes accumulated since v2.13.0, the first maintenance
release v2.13.1 has been tagged.  Thanks for all the help.  I'll be
mostly offline in the later part of this week, so please expect slow
response.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/c-translators-comment-style (2017-05-31) 1 commit
  (merged to 'next' on 2017-06-01 at df7fb9199a)
 + C style: use standard style for "TRANSLATORS" comments

 Update the C style recommendation for notes for translators, as
 recent versions of gettext tools can work with our style of
 multi-line comments.


* ab/sha1dc-maint (2017-05-22) 1 commit
  (merged to 'next' on 2017-05-30 at 9eb40bf912)
 + sha1dc: update from upstream
 (this branch is used by ab/sha1dc.)

 The "collision detecting" SHA-1 implementation shipped with 2.13
 was quite broken on some big-endian platforms and/or platforms that
 do not like unaligned fetches.  Update to the upstream code which
 has already fixed these issues.


* ab/t3070-test-dedup (2017-05-29) 1 commit
  (merged to 'next' on 2017-05-30 at 71eadec33b)
 + wildmatch test: remove redundant duplicate test

 Test cleanup.


* ad/pull-remote-doc (2017-06-02) 1 commit
  (merged to 'next' on 2017-06-02 at 32915e88db)
 + docs: fix formatting and grammar

 Docfix.


* ah/doc-filter-branch-export-env (2017-05-29) 1 commit
  (merged to 'next' on 2017-05-30 at a62168bf77)
 + doc: filter-branch does not require re-export of vars

 Docfix.


* ah/doc-rev-parse-short-default (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at f64fcc2a26)
 + doc: rewrite description for rev-parse --short

 Doc update.


* jh/close-index-before-stat (2017-04-28) 1 commit
  (merged to 'next' on 2017-05-16 at 0c0372eb02)
 + read-cache: close index.lock in do_write_index

 Originally merged to 'next' on 2017-04-30

 The timestamp of the index file is now taken after the file is
 closed, to help Windows, on which a stale timestamp is reported by
 fstat() on a file that is opened for writing and data was written
 but not yet closed.


* jk/connect-symref-info-leak-fix (2017-05-26) 1 commit
  (merged to 'next' on 2017-05-30 at d8b75d2dd9)
 + connect.c: fix leak in parse_one_symref_info()

 Leakfix.


* jk/drop-free-refspecs (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at 8f455319fc)
 + remote: drop free_refspecs() function

 Code clean-up.


* jk/unbreak-am-h (2017-05-30) 1 commit
  (merged to 'next' on 2017-06-01 at ee2233d409)
 + am: handle "-h" argument earlier
 (this branch is used by jk/consistent-h.)

 "git am -h" triggered a BUG().


* jk/url-insteadof-config (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at e7ea6032c2)
 + docs/config: mention protocol implications of url.insteadOf

 The interaction of "url.*.insteadOf" and custom URL scheme's
 whitelisting is now documented better.


* js/blame-lib (2017-05-25) 29 commits
  (merged to 'next' on 2017-05-30 at b4678b36a7)
 + blame: move entry prepend to libgit
 + blame: move scoreboard setup to libgit
 + blame: move scoreboard-related methods to libgit
 + blame: move fake-commit-related methods to libgit
 + blame: move origin-related methods to libgit
 + blame: move core structures to header
 + blame: create entry prepend function
 + blame: create scoreboard setup function
 + blame: create scoreboard init function
 + blame: rework methods that determine 'final' commit
 + blame: wrap blame_sort and compare_blame_final
 + blame: move progress updates to a scoreboard callback
 + blame: make sanity_check use a callback in scoreboard
 + blame: move no_whole_file_rename flag to scoreboard
 + blame: move xdl_opts flags to scoreboard
 + blame: move show_root flag to scoreboard
 + blame: move reverse flag to scoreboard
 + blame: move contents_from to scoreboard
 + blame: move copy/move thresholds to scoreboard
 + blame: move stat counters to scoreboard
 + blame: rename nth_line function
 + blame: rename ent_score function
 + blame: rename coalesce function
 + blame: rename origin-related functions
 + blame: rename scoreboard structure to blame_scoreboard
 + blame: rename origin structure to blame_origin
 + blame: remove unused parameters
 + blame: move textconv_object with related functions
 + blame: remove unneeded dependency on blob.h

 The internal logic used in "git blame" has been libified to make it
 easier to use by cgit.


* mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
  (merged to 'next' on 2017-05-29 at 7645575e21)
 + add--interactive: drop diff.indentHeuristic handling
 + diff: enable indent heuristic by default
 + diff: have the diff-* builtins configure diff before initializing revisions
 + diff: make the indent heuristic part of diff's basic configuration

 Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
 configuration variable an escape hatch for those who do no want it.
 Looks like there may be follow-on work possible, but the topic
 itself is in good order.
 cf. <20170509033258.q7auj5p5lxs4tggd@sigill.intra.peff.net>


* mh/packed-ref-store-prep (2017-05-24) 26 commits
  (merged to 'next' on 2017-05-29 at e4f5e06b4c)
 + cache_ref_iterator_begin(): avoid priming unneeded directories
 + ref-filter: limit traversal to prefix
 + create_ref_entry(): remove `check_name` option
 + refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
 + read_packed_refs(): report unexpected fopen() failures
 + read_packed_refs(): do more of the work of reading packed refs
 + get_packed_ref_cache(): assume "packed-refs" won't change while locked
 + should_pack_ref(): new function, extracted from `files_pack_refs()`
 + ref_update_reject_duplicates(): add a sanity check
 + ref_update_reject_duplicates(): use `size_t` rather than `int`
 + ref_update_reject_duplicates(): expose function to whole refs module
 + ref_transaction_prepare(): new optional step for reference updates
 + ref_transaction_commit(): check for valid `transaction->state`
 + files_transaction_cleanup(): new helper function
 + files_ref_store: put the packed files lock directly in this struct
 + files-backend: move `lock` member to `files_ref_store`
 + lockfile: add a new method, is_lock_file_locked()
 + ref_store: take a `msg` parameter when deleting references
 + refs: use `size_t` indexes when iterating over ref transaction updates
 + refs_ref_iterator_begin(): don't check prefixes redundantly
 + prefix_ref_iterator: don't trim too much
 + files-backend: use `die("BUG: ...")`, not `die("internal error: ...")`
 + ref_iterator_begin_fn(): fix docstring
 + refs.h: clarify docstring for the ref_transaction_update()-related fns
 + t3600: clean up permissions test properly
 + Merge branch 'bc/object-id'

 The implementation of "ref" API around the "packed refs" have been
 cleaned up, in preparation for further changes.


* rf/completion-config-commit (2017-05-30) 1 commit
  (merged to 'next' on 2017-06-01 at cea32e0486)
 + completion: add completions for git config commit
 (this branch is used by rf/completion.)

 Completion update.


* sd/t3200-typofix (2017-05-29) 1 commit
  (merged to 'next' on 2017-05-30 at 784e5e73f8)
 + branch test: fix invalid config key access

 Test fix.


* tb/pull-ff-rebase-autostash (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at b5e676d57e)
 + pull: ff --rebase --autostash works in dirty repo

 "git pull --rebase --autostash" didn't auto-stash when the local history
 fast-forwards to the upstream.

--------------------------------------------------
[New Topics]

* bw/object-id (2017-06-05) 33 commits
 - diff: rename diff_fill_sha1_info to diff_fill_oid_info
 - diffcore-rename: use is_empty_blob_oid
 - tree-diff: convert path_appendnew to object_id
 - tree-diff: convert diff_tree_paths to struct object_id
 - tree-diff: convert try_to_follow_renames to struct object_id
 - builtin/diff-tree: cleanup references to sha1
 - diff-tree: convert diff_tree_sha1 to struct object_id
 - notes-merge: convert write_note_to_worktree to struct object_id
 - notes-merge: convert verify_notes_filepair to struct object_id
 - notes-merge: convert find_notes_merge_pair_ps to struct object_id
 - notes-merge: convert merge_from_diffs to struct object_id
 - notes-merge: convert notes_merge* to struct object_id
 - tree-diff: convert diff_root_tree_sha1 to struct object_id
 - combine-diff: convert find_paths_* to struct object_id
 - combine-diff: convert diff_tree_combined to struct object_id
 - diff: convert diff_flush_patch_id to struct object_id
 - patch-ids: convert to struct object_id
 - diff: finish conversion for prepare_temp_file to struct object_id
 - diff: convert reuse_worktree_file to struct object_id
 - diff: convert fill_filespec to struct object_id
 - diff: convert diff_change to struct object_id
 - diff: convert run_diff_files to struct object_id
 - diff: convert diff_addremove to struct object_id
 - diff: convert diff_index_show_file to struct object_id
 - diff: convert get_stat_data to struct object_id
 - grep: convert to struct object_id
 - notes: convert some accessor functions to struct object_id
 - builtin/notes: convert to struct object_id
 - notes: convert format_display_notes to struct object_id
 - notes: make get_note return pointer to struct object_id
 - notes: convert for_each_note to struct object_id
 - notes: convert internal parts to struct object_id
 - notes: convert internal structures to struct object_id

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'next'.


* rs/strbuf-addftime-zZ (2017-06-04) 1 commit
 - strbuf: let strbuf_addftime handle %z and %Z itself

 As there is no portable way to pass timezone information to
 strftime, some output format from "git log" and friends are
 impossible to produce.  Teach our own strbuf_addftime to replace %z
 and %Z with caller-supplied values to help working around this.

 Will merge to 'next'.


* sb/submodule-rm-absorb (2017-06-04) 1 commit
 - Documentation/git-rm: correct submodule description

 Doc update to a recently graduated topic.

 Will merge to 'next'.


* sg/revision-parser-skip-prefix (2017-06-04) 3 commits
 - revision.c: use skip_prefix() in handle_revision_pseudo_opt()
 - revision.c: use skip_prefix() in handle_revision_opt()
 - revision.c: stricter parsing of '--no-{min,max}-parents'

 Code clean-up.

 Will merge to 'next'.


* ab/perf-remove-index-lock (2017-06-05) 1 commit
 - perf: work around the tested repo having an index.lock

 When an existing repository is used for t/perf testing, we first
 create bit-for-bit copy of it, which may grab a transient state of
 the repository and freeze it into the repository used for testing,
 which then may cause Git operations to fail.  Single out "the index
 being locked" case and forcibly drop the lock from the copy.

 Will merge to 'next'.


* ab/wip-fsmonitor (2017-06-04) 7 commits
 - perf: add a performance test for core.fsmonitor
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

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

* jc/diff-tree-stale-comment (2017-06-02) 1 commit
  (merged to 'next' on 2017-06-04 at bffae281d2)
 + diff-tree: update stale in-code comments

 Comment fix.

 Will merge to 'master'.


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

 Will merge to 'master'.


* rf/completion (2017-06-02) 6 commits
  (merged to 'next' on 2017-06-04 at dde1e34703)
 + completion: add git config credentialCache.ignoreSIGHUP
 + completion: add git config credential completions
 + completion: add git config advice completions
 + completion: add git config am.threeWay completion
 + completion: add git config core completions
 + completion: add git config gc completions

 Completion updates.

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
 - t0012: test "-h" with builtins
 - git: add hidden --list-builtins option
 - version: convert to parse-options
 - diff- and log- family: handle "git cmd -h" early
 - submodule--helper: show usage for "-h"
 - remote-{ext,fd}: print usage message on invalid arguments
 - upload-archive: handle "-h" option early
 - credential: handle invalid arguments earlier

 "git $cmd -h" for builtin commands calls the implementation of the
 command (i.e. cmd_$cmd() function) without doing any repository
 set-up, and the commands that expect RUN_SETUP is done by the Git
 potty needs to be prepared to show the help text without barfing.

 Will merge to 'next'.


* pw/rebase-i-regression-fix-tests (2017-06-01) 1 commit
 - rebase -i: add test for reflog message

 Just the first one of three? new tests that follows up a regression
 fix.

 Expecting a portable update.


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

 Will merge to 'master'.

 It is not known if a simple "yes/no" is sufficient in the longer
 term, and what should happen when --recurse-submodules option starts
 taking "recurse into them how?" parameter, though.


* ab/pcre-v2 (2017-06-02) 8 commits
 - grep: add support for PCRE v2
 - grep: un-break building with PCRE >= 8.32 without --enable-jit
 - grep: un-break building with PCRE < 8.20
 - grep: un-break building with PCRE < 8.32
 - grep: add support for the PCRE v1 JIT API
 - log: add -P as a synonym for --perl-regexp
 - grep: skip pthreads overhead when using one thread
 - grep: don't redundantly compile throwaway patterns under threading

 Update "perl-compatible regular expression" support to enable JIT
 and also allow linking with the newer PCRE v2 library.

 Will merge to 'next'.


* jk/pathspec-magic-disambiguation (2017-05-29) 6 commits
 - verify_filename(): flip order of checks
 - verify_filename(): treat ":(magic)" as a pathspec
 - check_filename(): handle ":^" path magic
 - check_filename(): use skip_prefix
 - check_filename(): refactor ":/" handling
 - t4208: add check for ":/" without matching file

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

 Will merge to 'next'.


* ab/sha1dc (2017-05-22) 2 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.

 Will keep in 'pu' for a few CI cycles.
 Impact to the various build and release infrastructure of using
 submodule is not yet fully known, but this lets us dip our toes.


* bp/fsmonitor (2017-06-04) 7 commits
 - perf: add a performance test for core.fsmonitor
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Waiting for discussion to settle.
 cf. <20170601155105.28356-1-benpeart@microsoft.com>


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

 Will merge to 'master'.


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

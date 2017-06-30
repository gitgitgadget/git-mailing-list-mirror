Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F223201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 21:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbdF3Vvb (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 17:51:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33869 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbdF3Vv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 17:51:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so3761318pfe.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=CHhF2Rb5Qb+GzfefFNDkVLOLkIR8FC4ymZSjDLjBCxs=;
        b=uyiKffWPvLYE4VSOYhM9Z7IlAQNhj1GMARkxXb/ZzfNxH4eyrcALCVC8j1Mn+WE1ek
         zUASQYcNIj1iScfeOZ5eAenhECWGxYdFTHP2ZncP7v5D21m9iEpy9FAT6RpTFYSRuehT
         EZG1swqfe4iXcxRyoTcXgJL+vjSBJMNRQfLqi+l02LgIDUrQm8F5kr69Giupmvv6yB36
         vQqHzr0SNXhTTQpsgsDNzfjN2kMThd1NRTwZHJxLtLXa/8TGx1YK0cbkh/I50qtaIUGB
         hqM7miuXMG8l+CREoSBnGg/UZQ+8sYYE9Uu43LtbQapq93Cp+jwJsDaAxdAoizpmOxpA
         eMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=CHhF2Rb5Qb+GzfefFNDkVLOLkIR8FC4ymZSjDLjBCxs=;
        b=CoWFuqcZdQGYhIJXxbdLzbP+P9spQVANhxSVCcrVcIBM2W8H2bZWTcSxmpQ78KpwFn
         N4nAW3JSmZJcUfiKf9audeHw3wuGyXk4WamSfck4ZkILxw+z5Iil7HMWTaW1LwhxGgEq
         94ey3QMkZTT6NV0wzvQo9Zm77g2cJnbhbrheTfHLu65X5OPP/fQiGsJ6rDpqXUi4tx1D
         oL09bMNw8xvsPonB9P7LFsn0/g2UzfXzVshVn9beirpCmHB0Ab/njsRQ3BJJZ75UIucL
         eSwJyrYEQ0tsUmETrUmpMVyy28GMG+cLDfi7lupybH5u/VZdAdj2tgTZCFZV+Z4eNzs+
         ma2Q==
X-Gm-Message-State: AKS2vOx0bDytIi+20vqUMtys+NS7a1wYcRzjHFOwcYH4fj1OAQCViWS+
        qHwrIwbdH9bUKW0k1wBgVfp8
X-Received: by 10.84.231.143 with SMTP id g15mr26353701plk.259.1498859488653;
        Fri, 30 Jun 2017 14:51:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id i67sm19351531pfc.122.2017.06.30.14.51.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 14:51:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2017, #09; Fri, 30)
X-master-at: 5116f791c12dda6b6c22fa85b600a8e30dfa168a
X-next-at: 7f5404b183d51b3e3066c995608b78ea314ee660
Date:   Fri, 30 Jun 2017 14:51:27 -0700
Message-ID: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
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

* ab/die-errors-in-threaded (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-24 at 135fc4b963)
 + die(): stop hiding errors due to overzealous recursion guard

 Traditionally, the default die() routine had a code to prevent it
 from getting called multiple times, which interacted badly when a
 threaded program used it (one downside is that the real error may
 be hidden and instead the only error message given to the user may
 end up being "die recursion detected", which is not very useful).


* ah/doc-pretty-color-auto-prefix (2017-06-24) 1 commit
  (merged to 'next' on 2017-06-26 at d7489fc831)
 + doc: clarify syntax for %C(auto,...) in pretty formats

 Doc update.


* jc/pack-bitmap-unaligned (2017-06-26) 1 commit
  (merged to 'next' on 2017-06-28 at ad026b12a3)
 + pack-bitmap: don't perform unaligned memory access

 An unaligned 32-bit access in pack-bitmap code ahs been corrected.


* ks/status-initial-commit (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-24 at 940ffd5816)
 + status: contextually notify user about an initial commit

 "git status" has long shown essentially the same message as "git
 commit"; the message it gives while preparing for the root commit,
 i.e. "Initial commit", was hard to understand for some new users.
 Now it says "No commits yet" to stress more on the current status
 (rather than the commit the user is preparing for, which is more in
 line with the focus of "git commit").


* ks/submodule-add-doc (2017-06-22) 1 commit
  (merged to 'next' on 2017-06-24 at 26309b38f2)
 + Documentation/git-submodule: cleanup "add" section

 Doc update.


* pw/rebase-i-regression-fix-tests (2017-06-23) 5 commits
  (merged to 'next' on 2017-06-23 at 835ae762f5)
 + t3420: fix under GETTEXT_POISON build
  (merged to 'next' on 2017-06-22 at d1dde1672a)
 + rebase: add more regression tests for console output
 + rebase: add regression tests for console output
 + rebase -i: add test for reflog message
 + sequencer: print autostash messages to stderr

 Fix a recent regression to "git rebase -i" and add tests that would
 have caught it and others.


* rs/apply-validate-input (2017-06-27) 3 commits
  (merged to 'next' on 2017-06-28 at 81e006b50e)
 + apply: check git diffs for mutually exclusive header lines
 + apply: check git diffs for invalid file modes
 + apply: check git diffs for missing old filenames

 Tighten error checks for invalid "git apply" input.


* vs/typofixes (2017-06-27) 1 commit
  (merged to 'next' on 2017-06-28 at 3d11e0b3fa)
 + Spelling fixes

 Many typofixes.

--------------------------------------------------
[New Topics]

* ab/grep-lose-opt-regflags (2017-06-30) 6 commits
 - grep: remove redundant REG_NEWLINE when compiling fixed regex
 - grep: remove regflags from the public grep_opt API
 - grep: remove redundant and verbose re-assignments to 0
 - grep: remove redundant "fixed" field re-assignment to 0
 - grep: adjust a redundant grep pattern type assignment
 - grep: remove redundant double assignment to 0

 Code cleanup.

 Will merge to 'next'.


* ks/commit-assuming-only-warning-removal (2017-06-30) 2 commits
 - commit-template: distinguish status information unconditionally
 - commit-template: remove outdated notice about explicit paths

 An old message shown in the commit log template was removed, as it
 has outlived its usefulness.

 Will merge to 'next'.


* sb/hashmap-customize-comparison (2017-06-30) 3 commits
 - hashmap: migrate documentation from Documentation/technical into header
 - patch-ids.c: use hashmap correctly
 - hashmap.h: compare function has access to a data field
 (this branch is used by sb/diff-color-move.)

 Update the hashmap API so that data to customize the behaviour of
 the comparison function can be specified at the time a hashmap is
 initialized.  This fixes a bug in patch-ids that may have caused
 segfault.


* sb/merge-recursive-code-cleanup (2017-06-30) 1 commit
 - merge-recursive: use DIFF_XDL_SET macro

 Code clean-up.

 Will merge to 'next'.

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


* xz/send-email-batch-size (2017-05-23) 1 commit
 - send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

 Waiting for a response.
 cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
 cf. <xmqqo9tfff2w.fsf@gitster.mtv.corp.google.com>

 """I thought your wish (which I found reasonable) was to record
 whatever information that would help us in the future in the log
 message?  I was waiting for that to happen."""


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>


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
[Cooking]

* ab/strbuf-addftime-tzname-boolify (2017-06-24) 3 commits
 - REWORD ONLY SQUASH
 - strbuf: change an always NULL/"" strbuf_addftime() param to bool
 - strbuf.h comment: discuss strbuf_addftime() arguments in order

 strbuf_addftime() is further getting tweaked.

 Waiting for a response.
 cf. <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>


* mt/p4-parse-G-output (2017-06-27) 1 commit
 . git-p4: parse marshal output "p4 -G" in p4 changes

 Use "p4 -G" to make "p4 changes" output more Python-friendly
 to parse.

 Needs review/ack from git-p4 folks.


* aw/contrib-subtree-doc-asciidoctor (2017-06-27) 1 commit
  (merged to 'next' on 2017-06-30 at af23bd111b)
 + subtree: honour USE_ASCIIDOCTOR when set

 The Makefile rule in contrib/subtree for building documentation
 learned to honour USE_ASCIIDOCTOR just like the main documentation
 set does.

 Will merge to 'master'.


* js/fsck-name-object (2017-06-28) 1 commit
  (merged to 'next' on 2017-06-30 at 9a08514cf2)
 + t1450: use egrep for regexp "alternation"

 Test fix.

 Will merge to 'master'.


* jc/utf8-fprintf (2017-06-28) 1 commit
  (merged to 'next' on 2017-06-30 at a8cc490818)
 + submodule--helper: do not call utf8_fprintf() unnecessarily

 Code cleanup.

 Will merge to 'master'.


* rs/free-and-null (2017-06-29) 1 commit
 - coccinelle: polish FREE_AND_NULL rules

 Code cleanup.


* ab/wildmatch (2017-06-23) 1 commit
 - wildmatch: remove unused wildopts parameter

 Prepare the wildmatch API for future enhancements to allow a
 pattern that is repeatedly matched against many strings to be
 precompiled.


* cc/shared-index-permfix (2017-06-25) 3 commits
  (merged to 'next' on 2017-06-26 at bb41584bf0)
 + t1700: make sure split-index respects core.sharedrepository
 + t1301: move modebits() to test-lib-functions.sh
 + read-cache: use shared perms when writing shared index

 The split index code did not honor core.sharedrepository setting
 correctly.

 Will merge to 'master'.


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-06-26 at d026281517)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.


* sb/pull-rebase-submodule (2017-06-27) 4 commits
 - builtin/fetch cleanup: always set default value for submodule recursing
 - pull: optionally rebase submodules (remote submodule changes only)
 - builtin/fetch: parse recurse-submodules-default at default options parsing
 - builtin/fetch: factor submodule recurse parsing out to submodule config

 "git pull --rebase --recurse-submodules" learns to rebase the
 branch in the submodules to an updated base.


* bw/repo-object (2017-06-23) 21 commits
  (merged to 'next' on 2017-06-26 at ed9c0b77c3)
 + ls-files: use repository object
 + repository: enable initialization of submodules
 + submodule: convert is_submodule_initialized to work on a repository
 + submodule: add repo_read_gitmodules
 + submodule-config: store the_submodule_cache in the_repository
 + repository: add index_state to struct repo
 + config: read config from a repository object
 + path: add repo_worktree_path and strbuf_repo_worktree_path
 + path: add repo_git_path and strbuf_repo_git_path
 + path: worktree_git_path() should not use file relocation
 + path: convert do_git_path to take a 'struct repository'
 + path: convert strbuf_git_common_path to take a 'struct repository'
 + path: always pass in commondir to update_common_dir
 + path: create path.h
 + environment: store worktree in the_repository
 + environment: place key repository state in the_repository
 + repository: introduce the repository object
 + environment: remove namespace_len variable
 + setup: add comment indicating a hack
 + setup: don't perform lazy initialization of repository state
 + Merge branches 'bw/ls-files-sans-the-index' and 'bw/config-h' into bw/repo-object

 Introduce a "repository" object to eventually make it easier to
 work in multiple repositories (the primary focus is to work with
 the superproject and its submodules) in a single process.

 Will merge to 'master'.


* pw/unquote-path-in-git-pm (2017-06-30) 4 commits
 - t9700: add tests for Git::unquote_path()
 - Git::unquote_path(): throw an exception on bad path
 - Git::unquote_path(): handle '\a'
 - add -i: move unquote_path() to Git.pm

 Code refactoring.

 Will merge to 'next'.


* rs/sha1-name-readdir-optim (2017-06-24) 4 commits
  (merged to 'next' on 2017-06-26 at a70587f2b9)
 + sha1_file: guard against invalid loose subdirectory numbers
 + sha1_file: let for_each_file_in_obj_subdir() handle subdir names
 + p4205: add perf test script for pretty log formats
 + sha1_name: cache readdir(3) results in find_short_object_filename()

 Optimize "what are the object names already taken in an alternate
 object database?" query that is used to derive the length of prefix
 an object name is uniquely abbreviated to.

 Will merge to 'master'.


* jt/unify-object-info (2017-06-26) 8 commits
  (merged to 'next' on 2017-06-26 at 540ea81983)
 + sha1_file: refactor has_sha1_file_with_flags
 + sha1_file: do not access pack if unneeded
 + sha1_file: teach sha1_object_info_extended more flags
 + sha1_file: refactor read_object
 + sha1_file: move delta base cache code up
 + sha1_file: rename LOOKUP_REPLACE_OBJECT
 + sha1_file: rename LOOKUP_UNKNOWN_OBJECT
 + sha1_file: teach packed_object_info about typename

 Code clean-ups.

 Will merge to 'master'.


* mh/packed-ref-store (2017-06-23) 29 commits
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
 - t1408: add a test of stale packed refs covered by loose refs

 The "ref-store" code reorganization continues.

 Is this now ready for 'next'?


* sb/submodule-doc (2017-06-22) 1 commit
 - submodules: overhaul documentation

 Doc update.

 Waiting for discussion to settle.


* sd/branch-copy (2017-06-18) 3 commits
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Has a bit of interaction with mh/packed-ref-store and bw/config-h,
 so perhaps needs to wait for the former to stabilize a bit more
 and possibly rebasing on them.


* ls/filter-process-delayed (2017-06-30) 7 commits
 - convert: add "status=delayed" to filter process protocol
 - convert: refactor capabilities negotiation
 - convert: move multiple file filter error handling to separate function
 - convert: put the flags field before the flag itself for consistent style
 - t0021: write "OUT <size>" only on success
 - t0021: make debug log file name configurable
 - t0021: keep filter log files on comparison

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.

 Will merge to 'next'.


* ab/sha1dc (2017-06-27) 3 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule
 - sha1dc: correct endian detection for Solaris (and others?)

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.  Glitches on minority platforms are still being worked out.

 Will keep in 'pu'.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 No more comments or updates?


* sb/diff-color-move (2017-06-30) 26 commits
 - diff: document the new --color-moved setting
 - diff.c: add dimming to moved line detection
 - diff.c: color moved lines differently, plain mode
 - diff.c: color moved lines differently
 - diff.c: buffer all output if asked to
 - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
 - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
 - diff.c: convert word diffing to use emit_diff_symbol
 - diff.c: convert show_stats to use emit_diff_symbol
 - diff.c: convert emit_binary_diff_body to use emit_diff_symbol
 - submodule.c: migrate diff output to use emit_diff_symbol
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
 - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
 - diff.c: migrate emit_line_checked to use emit_diff_symbol
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
 - diff.c: introduce emit_diff_symbol
 - diff.c: factor out diff_flush_patch_all_file_pairs
 - diff.c: move line ending check into emit_hunk_header
 - diff.c: readability fix
 - Merge branch 'sb/hashmap-customize-comparison' into sb/diff-color-move
 (this branch uses sb/hashmap-customize-comparison.)

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.

 Looking good.
 cf. <CAGZ79kaK00CpXOtXnx_u7_KHbZq4Mz8vWHKy2a8p1gQ8ogE-OA@mail.gmail.com>

--------------------------------------------------
[Discarded]

* mh/packed-ref-store-prep-extra (2017-06-18) 1 commit
 . prefix_ref_iterator_advance(): relax the check of trim length

 Split out of mh/packed-ref-store-prep.


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


* ab/free-and-null (2017-06-28) 2 commits
  (merged to 'next' on 2017-06-28 at 1cf373c61a)
 + Revert "coccinelle: add a rule to make "expression" code use FREE_AND_NULL()"
  (merged to 'next' on 2017-06-28 at 1785f88122)
 + coccinelle: add a rule to make "expression" code use FREE_AND_NULL()

 The coccinelle rule for free-and-null refactoring got simplified.

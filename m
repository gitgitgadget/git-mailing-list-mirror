Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4663820401
	for <e@80x24.org>; Sat, 24 Jun 2017 23:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755194AbdFXX17 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 19:27:59 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34955 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755192AbdFXX15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 19:27:57 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so10706544pgc.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=PVNnYPjDXd6DBOmGAwy3x8Avr3uHhws6W9g8W3oirXI=;
        b=S1XCl8eGNYtPXjC/29NgUqULWhix5GPVxMScwAJQwraKoKPEASaa5dj3Vp8+DAPWCE
         jJeOJoViXEV7KYj1qpcil+rGrDlcOf8mh16aXYVidfgaPukVWpdXDx+gt1Soe4Wd1mmY
         zD6TM2fxi549BDABpUp5Jblxdwy164inV+uBuQsiLldv2j5eGQJAfFp98TkGpeqkLBuG
         B+fqHM7d286r3qINVjbe4+whSwrvj3Mz28Gjbg5JDQEdMlVKJwzBBtrlXalfTDQuwwDv
         DOxQIs87QuJTkFgbj+IBLtYr4tex78ae7uDJZbm8aKbYqQgsjI1qCUGH9wLjmvpVEKcM
         UTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=PVNnYPjDXd6DBOmGAwy3x8Avr3uHhws6W9g8W3oirXI=;
        b=X7nURcJ7T4dsGPpCxzT3iNzzWuIK5wLo7U4NJhtajw3NyVesueWCCqr964LIyfhCER
         cHaLFWQC+wTBAEdSe9vMNvkrpRqwW7hKNdjWD/9vUdj3LyHz7duq45fdXvjIl5HEtWcL
         t4Vv4b3zamuObHD46+5CJ7/RKoBrjWHmQdVM13KUKWfRc4OBwbUbIREofxJ1k0t2eWJh
         s/y2BEJAov+FLYyMWgn3S4kbKct3q5DDT7TNzdKNdBbsAviS42YY2aNPZLR1sfd9KHLT
         ZueI+3tmZBNt4vjfaZbZnN3FSBpkPQi39nG8NOaMytQLsHZJcuz81KmU/QyVt3KCRWrV
         j+Kw==
X-Gm-Message-State: AKS2vOx5fwB1RMGPnq4eyFikdWKh8HubZkmmPiCPgawz3z9SO8t+kdHE
        C3tUFIPHeUmVqZFb3WDQ4aEm
X-Received: by 10.99.95.6 with SMTP id t6mr14856993pgb.141.1498346876201;
        Sat, 24 Jun 2017 16:27:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id o8sm16863356pgn.52.2017.06.24.16.27.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 16:27:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2017, #07; Sat, 24)
Date:   Sat, 24 Jun 2017 16:25:13 -0700
X-master-at: e629a7d28a405e48fae6b064a781a10e885159fc
X-next-at: dfeb3b8721fab9939e46c1aea15c813423fe1de3
Message-ID: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com>
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

A new maintenance release v2.13.2 has been tagged with various fixes
that have been already in the 'master' branch.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/free-and-null (2017-06-16) 6 commits
  (merged to 'next' on 2017-06-21 at a1825fabd8)
 + *.[ch] refactoring: make use of the FREE_AND_NULL() macro
 + coccinelle: make use of the "expression" FREE_AND_NULL() rule
 + coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
 + coccinelle: make use of the "type" FREE_AND_NULL() rule
 + coccinelle: add a rule to make "type" code use FREE_AND_NULL()
 + git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); ptr = NULL

 A common pattern to free a piece of memory and assign NULL to the
 pointer that used to point at it has been replaced with a new
 FREE_AND_NULL() macro.


* ab/pcre-v2 (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-21 at fb6320213c)
 + grep: fix erroneously copy/pasted variable in check/assert pattern

 Hotfix for a topic already in 'master'.


* ab/wildmatch-glob-slash-test (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 8f4a056f5f)
 + wildmatch test: cover a blind spot in "/" matching

 A new test to show the interaction between the pattern [^a-z]
 (which matches '/') and a slash in a path has been added.  The
 pattern should not match the slash with "pathmatch", but should
 with "wildmatch".


* ah/doc-gitattributes-empty-index (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at f1dc92557b)
 + doc: do not use `rm .git/index` when normalizing line endings

 An example in documentation that does not work in multi worktree
 configuration has been corrected.


* bw/config-h (2017-06-15) 6 commits
  (merged to 'next' on 2017-06-21 at 15c5f34034)
 + config: don't implicitly use gitdir or commondir
 + config: respect commondir
 + setup: teach discover_git_directory to respect the commondir
 + config: don't include config.h by default
 + config: remove git_config_iter
 + config: create config.h
 (this branch is used by bw/repo-object; uses js/alias-early-config.)

 Fix configuration codepath to pay proper attention to commondir
 that is used in multi-worktree situation, and isolate config API
 into its own header file.


* bw/ls-files-sans-the-index (2017-06-13) 17 commits
  (merged to 'next' on 2017-06-21 at 39ce64f6c7)
 + ls-files: factor out tag calculation
 + ls-files: factor out debug info into a function
 + ls-files: convert show_files to take an index
 + ls-files: convert show_ce_entry to take an index
 + ls-files: convert prune_cache to take an index
 + ls-files: convert ce_excluded to take an index
 + ls-files: convert show_ru_info to take an index
 + ls-files: convert show_other_files to take an index
 + ls-files: convert show_killed_files to take an index
 + ls-files: convert write_eolinfo to take an index
 + ls-files: convert overlay_tree_on_cache to take an index
 + tree: convert read_tree to take an index parameter
 + convert: convert renormalize_buffer to take an index
 + convert: convert convert_to_git to take an index
 + convert: convert convert_to_git_filter_fd to take an index
 + convert: convert crlf_to_git to take an index
 + convert: convert get_cached_convert_stats_ascii to take an index
 (this branch is used by bw/repo-object.)

 Code clean-up.


* da/mergetools-meld-output-opt-on-macos (2017-06-18) 1 commit
  (merged to 'next' on 2017-06-21 at de00cce3c0)
 + mergetools/meld: improve compatibiilty with Meld on macOS X

 "git mergetool" learned to work around a wrapper MacOS X adds
 around underlying meld.


* jk/diff-highlight-module (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at e418062ad2)
 + diff-highlight: split code into module

 The 'diff-highlight' program (in contrib/) has been restructured
 for easier reuse by an external project 'diff-so-fancy'.


* jk/warn-add-gitlink (2017-06-15) 2 commits
  (merged to 'next' on 2017-06-21 at 7210ddbb2e)
 + t: move "git add submodule" into test blocks
 + add: warn when adding an embedded repository

 Using "git add d/i/r" when d/i/r is the top of the working tree of
 a separate repository would create a gitlink in the index, which
 would appear as a not-quite-initialized submodule to others.  We
 learned to give warnings when this happens.


* js/alias-early-config (2017-06-15) 6 commits
  (merged to 'next' on 2017-06-21 at ca4995aac2)
 + alias: use the early config machinery to expand aliases
 + t7006: demonstrate a problem with aliases in subdirectories
 + t1308: relax the test verifying that empty alias values are disallowed
 + help: use early config when autocorrecting aliases
 + config: report correct line number upon error
 + discover_git_directory(): avoid setting invalid git_dir
 (this branch is used by bw/config-h and bw/repo-object.)

 The code to pick up and execute command alias definition from the
 configuration used to switch to the top of the working tree and
 then come back when the expanded alias was executed, which was
 unnecessarilyl complex.  Attempt to simplify the logic by using the
 early-config mechanism that does not chdir around.


* rs/pretty-add-again (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 5128ad3632)
 + pretty: recalculate duplicate short hashes

 The pretty-format specifiers like '%h', '%t', etc. had an
 optimization that no longer works correctly.  In preparation/hope
 of getting it correctly implemented, first discard the optimization
 that is broken.


* sg/doc-pretty-formats (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 011df65cf5)
 + docs/pretty-formats: stress that %- removes all preceding line-feeds

 Doc update.


* sn/reset-doc-typofix (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 3e629ac2cb)
 + doc: git-reset: fix a trivial typo

 Doc update.

--------------------------------------------------
[New Topics]

* ab/wildmatch (2017-06-23) 4 commits
 - SQUASH???
 - wildmatch: make use of the interface for precompiling wildmatch() patterns
 - wildmatch: add interface for precompiling wildmatch() patterns
 - wildmatch: remove unused wildopts parameter

 Prepare the wildmatch API for future enhancements to allow a
 pattern that is repeatedly matched against many strings to be
 precompiled.


* ah/doc-pretty-color-auto-prefix (2017-06-24) 1 commit
 - doc: clarify syntax for %C(auto,...) in pretty formats

 Doc update.

 Will merge to 'next'.


* cc/shared-index-permfix (2017-06-23) 3 commits
 - t1700: make sure split-index respects core.sharedrepository
 - t1301: move modebits() to test-lib-functions.sh
 - read-cache: use shared perms when writing shared index

 The split index code did not honor core.sharedrepository setting
 correctly.

 Expecting a reroll.
 cf. <xmqqwp82bb39.fsf@gitster.mtv.corp.google.com>
 The test looked flakey.


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
 - pathspec: die on empty strings as pathspec
 - t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will merge to 'next.


* sb/pull-rebase-submodule (2017-06-23) 3 commits
 - pull: optionally rebase submodules (remote submodule changes only)
 - builtin/fetch: parse recurse-submodules-default at default options parsing
 - builtin/fetch: factor submodule recurse parsing out to submodule config

 "git pull --rebase --recurse-submodules" learns to rebase the
 branch in the submodules to an updated base.

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

* ab/die-errors-in-threaded (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-24 at 135fc4b963)
 + die(): stop hiding errors due to overzealous recursion guard

 Traditionally, the default die() routine had a code to prevent it
 from getting called multiple times, which interacted badly when a
 threaded program used it (one downside is that the real error may
 be hidden and instead the only error message given to the user may
 end up being "die recursion detected", which is not very useful).

 Will merge to 'master'.


* bw/repo-object (2017-06-23) 21 commits
 - ls-files: use repository object
 - repository: enable initialization of submodules
 - submodule: convert is_submodule_initialized to work on a repository
 - submodule: add repo_read_gitmodules
 - submodule-config: store the_submodule_cache in the_repository
 - repository: add index_state to struct repo
 - config: read config from a repository object
 - path: add repo_worktree_path and strbuf_repo_worktree_path
 - path: add repo_git_path and strbuf_repo_git_path
 - path: worktree_git_path() should not use file relocation
 - path: convert do_git_path to take a 'struct repository'
 - path: convert strbuf_git_common_path to take a 'struct repository'
 - path: always pass in commondir to update_common_dir
 - path: create path.h
 - environment: store worktree in the_repository
 - environment: place key repository state in the_repository
 - repository: introduce the repository object
 - environment: remove namespace_len variable
 - setup: add comment indicating a hack
 - setup: don't perform lazy initialization of repository state
 - Merge branches 'bw/ls-files-sans-the-index' and 'bw/config-h' into bw/repo-object

 Introduce a "repository" object to eventually make it easier to
 work in multiple repositories (the primary focus is to work with
 the superproject and its submodules) in a single process.

 Will merge to 'next'.


* dt/raise-core-packed-git-limit (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-22 at bc1a90f077)
 + docs: update 64-bit core.packedGitLimit default

 Doc update for a topic already in 'master'.

 Will merge to 'master'.


* jk/add-p-commentchar-fix (2017-06-21) 2 commits
  (merged to 'next' on 2017-06-22 at 5a1d464e6d)
 + add--interactive: quote commentChar regex
 + add--interactive: handle EOF in prompt_yesno

 "git add -p" were updated in 2.12 timeframe to cope with custom
 core.commentchar but the implementation was buggy and a
 metacharacter like $ and * did not work.

 Will merge to 'master'.


* ks/t7508-indent-fix (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-22 at d12526967b)
 + t7508: fix a broken indentation

 Cosmetic update to a test.

 Will merge to 'master'.


* mb/reword-autocomplete-message (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-22 at 878888a743)
 + auto-correct: tweak phrasing

 Message update.

 Will merge to 'master'.


* ks/submodule-add-doc (2017-06-22) 1 commit
  (merged to 'next' on 2017-06-24 at 26309b38f2)
 + Documentation/git-submodule: cleanup "add" section

 Doc update.

 Will merge to 'master'.


* pw/unquote-path-in-git-pm (2017-06-24) 5 commits
 - git-add--interactive.perl: Use unquote_path() from Git.pm
 - Add tests for Git::unquote_path()
 - Git::unquote_path() throw an exception on bad path
 - Git::unquote_path() Handle '\a'
 - Git.pm: add unquote_path()

 Code refactoring.

 Expecting a reroll.
 The structure of the series has a bit to be desired, but the end
 result looked mostly OK.


* rs/sha1-name-readdir-optim (2017-06-24) 4 commits
 - sha1_file: guard against invalid loose subdirectory numbers
 - sha1_file: let for_each_file_in_obj_subdir() handle subdir names
 - p4205: add perf test script for pretty log formats
 - sha1_name: cache readdir(3) results in find_short_object_filename()

 Optimize "what are the object names already taken in an alternate
 object database?" query that is used to derive the length of prefix
 an object name is uniquely abbreviated to.

 Will merge to 'next'.


* jt/unify-object-info (2017-06-21) 8 commits
 - sha1_file: refactor has_sha1_file_with_flags
 - sha1_file: do not access pack if unneeded
 - sha1_file: improve sha1_object_info_extended
 - sha1_file: refactor read_object
 - sha1_file: move delta base cache code up
 - sha1_file: rename LOOKUP_REPLACE_OBJECT
 - sha1_file: rename LOOKUP_UNKNOWN_OBJECT
 - sha1_file: teach packed_object_info about typename

 Code clean-ups.

 Looked sensible to me.  Any further comments?
 cf. <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net>


* ks/status-initial-commit (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-24 at 940ffd5816)
 + status: contextually notify user about an initial commit

 "git status" has long shown essentially the same message as "git
 commit"; the message it gives while preparing for the root commit,
 i.e. "Initial commit", was hard to understand for some new users.
 Now it says "No commits yet" to stress more on the current status
 (rather than the commit the user is preparing for, which is more in
 line with the focus of "git commit").

 Will merge to 'master'.


* lb/status-stash-count (2017-06-18) 3 commits
  (merged to 'next' on 2017-06-22 at 86bc2f2213)
 + glossary: define 'stash entry'
 + status: add optional stash count information
 + stash: update documentation to use 'stash entry'

 "git status" learned to optionally give how many stash entries the
 user has in its output.

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
 (this branch uses mh/packed-ref-store-prep; is tangled with mh/packed-ref-store-prep-extra.)

 The "ref-store" code reorganization continues.


* mh/packed-ref-store-prep (2017-06-18) 2 commits
  (merged to 'next' on 2017-06-22 at 3f7a4da1e8)
 + for_each_bisect_ref(): don't trim refnames
 + lock_packed_refs(): fix cache validity check
 (this branch is used by mh/packed-ref-store and mh/packed-ref-store-prep-extra.)

 Bugfix for a topic that is (only) in 'master'.

 Will merge to 'master'.


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

 Has a bit of interaction with two other topics, so perhaps needs to
 wait for them to stabilize a bit more.


* ls/filter-process-delayed (2017-06-01) 5 commits
 - convert: add "status=delayed" to filter process protocol
 - convert: move multiple file filter error handling to separate function
 - t0021: write "OUT" only on success
 - t0021: make debug log file name configurable
 - t0021: keep filter log files on comparison

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.

 Getting reviewed.
 cf. <20170624142301.c5jl7xxf4ici3cug@sigill.intra.peff.net>


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

 Will merge to 'master'.


* ab/sha1dc (2017-06-07) 2 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.

 Will keep in 'pu'.
 cf. <xmqqefuab571.fsf@gitster.mtv.corp.google.com>

 The only nit I may have is that we may possibly want to turn this
 on in .travis.yml on MacOS before we move it forward (otherwise
 we'd be shipping bundled one and submodule one without doing any
 build on that platform)?  Other than that, the topic seems ready to
 be merged down.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 No more comments or updates?


* sb/diff-color-move (2017-06-23) 25 commits
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

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.


* xz/send-email-batch-size (2017-05-23) 1 commit
 - send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

 Waiting for response.
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
[Discarded]

* mh/packed-ref-store-prep-extra (2017-06-18) 1 commit
 . prefix_ref_iterator_advance(): relax the check of trim length
 (this branch uses mh/packed-ref-store-prep; is tangled with mh/packed-ref-store.)

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

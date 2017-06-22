Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4E020802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbdFVWf2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:35:28 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35410 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdFVWf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:35:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so4056484pgc.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=nrRbSQ9OW5tkAOjLzKczn+zPbgLyjR6cv3F/rFJ91Tc=;
        b=qjzMVjevIstUAlTZoY9ULDEmIA31mZENP05Dljxhuoy9+Xj2VJdnPyVXkQ7uJSS9mp
         ysla4TWtwdwVSW71U23OfGjEl4GnOZy9+PEySD/B8tACRBMOtpXnv59CasheFHUujKjg
         Td1iKsgR85kSjp7Ll7ugw4tcKY4orJx77eJykbV+XNHkn7njE0h5BwPHjcFUEf+A6o8x
         h4oRNjfD+RaWM+ULdiOOLn1pNvfQfozC7JT7ZKGksnModdJpqYjA8w3Uh7h2oz8mxotN
         Tu9JU9r5ccM24rOUcYvsaD7C5M9rV3gC9XezPn0rcwZqNKxcC7kiz+KKhpOkmtNwJX7u
         vBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=nrRbSQ9OW5tkAOjLzKczn+zPbgLyjR6cv3F/rFJ91Tc=;
        b=LW5JjSzkIpPADnX79JVAXVkBEzapeHxkO2uVgzaP1ydsNChq9Pd1CJNxVWvrJMFyft
         8j5621g6bv+Mbf/TQS/J0i7G7swBRva+ysIst1ack38q/vEF8kzuJt2KRBMoSXjPT9T+
         iYOqMkvHtmnvTxWkY8ndXmg4EHV0tBHqtE7vdGid6NMmEPPSvVDBRuZXEYdjanPPYtcz
         IF6xnf9ufDprFvAlH+CPurAnhYS0t8GKyGu3mHM4MyLqIu1fGcqShZLqAmNt9odnGlHB
         u73qh15d7zACyLvs+dpi/MGR6YgBLWDBVdS31JMpPx45e0O62AbY7Yz75F0tSP0oPO1Q
         5n1Q==
X-Gm-Message-State: AKS2vOzBxHBnUN+OfzvkYLWeVILtsO113C9qcE7v34kZg0gXVEBYMMA9
        XkaD8jDUIVgUFK2p+MiS1XD/
X-Received: by 10.99.44.201 with SMTP id s192mr4889344pgs.84.1498170925142;
        Thu, 22 Jun 2017 15:35:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id b86sm6186110pfc.27.2017.06.22.15.35.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 15:35:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2017, #06; Thu, 22)
X-master-at: 5402b1352f5181247405fbff1887008a0cb3b04a
X-next-at: bc1a90f0778b337f20670d4cbce0a6e2c034cbf5
Date:   Thu, 22 Jun 2017 15:35:23 -0700
Message-ID: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
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

* ah/filter-branch-setup (2017-06-12) 2 commits
  (merged to 'next' on 2017-06-19 at f3440f2c1a)
 + filter-branch: add [--] to usage
 + filter-branch: add `--setup` step

 "filter-branch" learned a pseudo filter "--setup" that can be used
 to define a common function/variable that can be used by other
 filters.


* km/test-mailinfo-b-failure (2017-06-12) 1 commit
  (merged to 'next' on 2017-06-19 at badc2c2337)
 + t5100: add some more mailinfo tests

 New tests.


* ls/github (2017-06-13) 1 commit
  (merged to 'next' on 2017-06-19 at 4d2024615f)
 + Configure Git contribution guidelines for github.com

 Help contributors that visit us at GitHub.


* mh/fast-import-raise-default-depth (2017-06-12) 1 commit
  (merged to 'next' on 2017-06-19 at 7093c07b8e)
 + fast-import: increase the default pack depth to 50

 "fast-import" uses a default pack chain depth that is consistent
 with other parts of the system.


* nd/fopen-errors (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-15 at 86bcb7c082)
 + configure.ac: loosen FREAD_READS_DIRECTORIES test program

 Hotfix for a topic that is already in 'master'.


* pc/dir-count-slashes (2017-06-12) 1 commit
  (merged to 'next' on 2017-06-19 at 57351a2771)
 + dir: create function count_slashes()

 Three instances of the same helper function have been consolidated
 to one.


* ps/stash-push-pathspec-fix (2017-06-13) 1 commit
  (merged to 'next' on 2017-06-19 at 866c9035e0)
 + git-stash: fix pushing stash with pathspec from subdir

 "git stash push <pathspec>" did not work from a subdirectory at all.
 Bugfix for a topic in v2.13


* rs/strbuf-addftime-zZ (2017-06-15) 3 commits
  (merged to 'next' on 2017-06-19 at 77480669f0)
 + date: use localtime() for "-local" time formats
 + t0006: check --date=format zone offsets
 + strbuf: let strbuf_addftime handle %z and %Z itself

 As there is no portable way to pass timezone information to
 strftime, some output format from "git log" and friends are
 impossible to produce.  Teach our own strbuf_addftime to replace %z
 and %Z with caller-supplied values to help working around this.


* sb/t4005-modernize (2017-06-10) 1 commit
  (merged to 'next' on 2017-06-19 at beedeb757b)
 + t4005: modernize style and drop hard coded sha1

 Test clean-up.


* sd/t3200-branch-m-test (2017-06-13) 1 commit
  (merged to 'next' on 2017-06-19 at 0fd712c46e)
 + t3200: add test for single parameter passed to -m option

 New test.


* sg/revision-parser-skip-prefix (2017-06-12) 5 commits
  (merged to 'next' on 2017-06-19 at 0a90bec767)
 + revision.c: use skip_prefix() in handle_revision_pseudo_opt()
 + revision.c: use skip_prefix() in handle_revision_opt()
 + revision.c: stricter parsing of '--early-output'
 + revision.c: stricter parsing of '--no-{min,max}-parents'
 + revision.h: turn rev_info.early_output back into an unsigned int

 Code clean-up.

--------------------------------------------------
[New Topics]

* mh/packed-ref-store-prep-extra (2017-06-18) 1 commit
 - prefix_ref_iterator_advance(): relax the check of trim length
 (this branch uses mh/packed-ref-store-prep; is tangled with mh/packed-ref-store.)

 Split out of mh/packed-ref-store-prep; will drop.


* ab/die-errors-in-threaded (2017-06-21) 1 commit
 - die(): stop hiding errors due to overzealous recursion guard

 Traditionally, the default die() routine had a code to prevent it
 from getting called multiple times, which interacted badly when a
 threaded program used it (one downside is that the real error may
 be hidden and instead the only error message given to the user may
 end up being "die recursion detected", which is not very useful).

 Will merge to 'next'.


* ab/pcre-v2 (2017-06-21) 1 commit
  (merged to 'next' on 2017-06-21 at fb6320213c)
 + grep: fix erroneously copy/pasted variable in check/assert pattern

 Hotfix for a topic already in 'master'.

 Will merge to 'master'.


* bw/repo-object (2017-06-22) 21 commits
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
 - Merge branches 'bw/ls-files-sans-the-index' and 'bw/config-h' into HEAD
 (this branch uses bw/config-h, bw/ls-files-sans-the-index and js/alias-early-config.)

 Introduce a "repository" object to eventually make it easier to
 work in multiple repositories (the primary focus is to work with
 the superproject and its submodules) in a single process.


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
 - Documentation/git-submodule: cleanup "add" section

 Doc update.

 Will merge to 'next'.


* pw/unquote-path-in-git-pm (2017-06-22) 5 commits
 - git-add--interactive.perl: Use unquote_path() from Git.pm
 - Add tests for Git::unquote_path()
 - Git::unquote_path() throw an exception on bad path
 - Git::unquote_path() Handle '\a'
 - Git.pm: add unquote_path()
 (this branch uses rs/sha1-name-readdir-optim.)

 Code refactoring.

 Expecting a reroll.
 The structure of the series has a bit to be desired, but the end
 result looked mostly OK.


* rs/sha1-name-readdir-optim (2017-06-22) 1 commit
 - sha1_name: cache readdir(3) results in find_short_object_filename()
 (this branch is used by pw/unquote-path-in-git-pm.)

 Optimize "what are the object names already taken in an alternate
 object database?" query that is used to derive the length of prefix
 an object name is uniquely abbreviated to.

 It would be nice to have some numbers, though.

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

 Will merge to 'master'.


* ab/wildmatch-glob-slash-test (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 8f4a056f5f)
 + wildmatch test: cover a blind spot in "/" matching

 A new test to show the interaction between the pattern [^a-z]
 (which matches '/') and a slash in a path has been added.  The
 pattern should not match the slash with "pathmatch", but should
 with "wildmatch".

 Will merge to 'master'.


* ah/doc-gitattributes-empty-index (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at f1dc92557b)
 + doc: do not use `rm .git/index` when normalizing line endings

 An example in documentation that does not work in multi worktree
 configuration has been corrected.

 Will merge to 'master'.


* jk/diff-highlight-module (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at e418062ad2)
 + diff-highlight: split code into module

 The 'diff-highlight' program (in contrib/) has been restructured
 for easier reuse by an external project 'diff-so-fancy'.

 Will merge to 'master'.


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


* rs/pretty-add-again (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 5128ad3632)
 + pretty: recalculate duplicate short hashes

 The pretty-format specifiers like '%h', '%t', etc. had an
 optimization that no longer works correctly.  In preparation/hope
 of getting it correctly implemented, first discard the optimization
 that is broken.

 Will merge to 'master'.


* sg/doc-pretty-formats (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 011df65cf5)
 + docs/pretty-formats: stress that %- removes all preceding line-feeds

 Doc update.

 Will merge to 'master'.


* sn/reset-doc-typofix (2017-06-15) 1 commit
  (merged to 'next' on 2017-06-21 at 3e629ac2cb)
 + doc: git-reset: fix a trivial typo

 Doc update.

 Will merge to 'master'.


* da/mergetools-meld-output-opt-on-macos (2017-06-18) 1 commit
  (merged to 'next' on 2017-06-21 at de00cce3c0)
 + mergetools/meld: improve compatibiilty with Meld on macOS X

 "git mergetool" learned to work around a wrapper MacOS X adds
 around underlying meld.

 Will merge to 'master'.


* ks/status-initial-commit (2017-06-21) 1 commit
 - status: contextually notify user about an initial commit

 "git status" has long shown essentially the same message as "git
 commit"; the message it gives while preparing for the root commit,
 i.e. "Initial commit", was hard to understand for some new users.
 Now it says "No commits yet" to stress more on the current status
 (rather than the commit the user is preparing for, which is more in
 line with the focus of "git commit").

 Will merge to 'next'.


* lb/status-stash-count (2017-06-18) 3 commits
  (merged to 'next' on 2017-06-22 at 86bc2f2213)
 + glossary: define 'stash entry'
 + status: add optional stash count information
 + stash: update documentation to use 'stash entry'

 "git status" learned to optionally give how many stash entries the
 user has in its output.

 Will merge to 'master'.


* mh/packed-ref-store (2017-06-19) 29 commits
 - SQUASH???
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
 (this branch uses mh/packed-ref-store-prep; is tangled with mh/packed-ref-store-prep-extra.)

 The "ref-store" code reorganization continues.

 Seems to break the promise that packed-refs are covered by loose
 refs and the former that points at a missing garbage is not an
 error.
 cf. <20170619195330.fhjlfiqmcwhgttaa@sigill.intra.peff.net>


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

 Will merge to 'master'.


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

 Will merge to 'master'.


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

 Will merge to 'master'.


* jk/warn-add-gitlink (2017-06-15) 2 commits
  (merged to 'next' on 2017-06-21 at 7210ddbb2e)
 + t: move "git add submodule" into test blocks
 + add: warn when adding an embedded repository

 Using "git add d/i/r" when d/i/r is the top of the working tree of
 a separate repository would create a gitlink in the index, which
 would appear as a not-quite-initialized submodule to others.  We
 learned to give warnings when this happens.

 Will merge to 'master'.


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

 Needs review.


* pw/rebase-i-regression-fix-tests (2017-06-19) 4 commits
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


* sb/diff-color-move (2017-06-21) 25 commits
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
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS{_PORCELAIN}
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
 (this branch is used by sg/remote-no-string-refspecs.)

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

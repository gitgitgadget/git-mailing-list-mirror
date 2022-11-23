Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F0DC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 07:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiKWHZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiKWHZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 02:25:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF0F2C33
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:25:10 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s196so16098977pgs.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bg9dPs8xhl5VgyKg453cTsyWpBbrcyHPBn+gqLrnHyk=;
        b=HtqRreYmUeMJ87mUEkRd0qE5rZmgafifa2Lhj2XDKcS4alfhBxTx6exKpp7PTKXg9S
         EOtGx5jXrn4ZjeZxEy831i6wsOmfeIBEI6q8USeWrnvVi5585sQImhGIQ6V42L6dQHUT
         t1G3vNtB5w7Q/x9k0kmiuCl93m9z1aXVRcMxKjjj61ZesHMnVt0FDfAvYadAZ6CMmBJW
         ZNKAGDK75g3noXnAy/3vE3zOymzV1vHs0Fdi9fOH4HHClYMcXbNRC5HaFQcVFESrz7V3
         5RmdSxnQrF+yFb5aDEa5LwAiBdI+UgL1Dn6XvbVCMpZauKVgVjzPLodkJpC7rGQLmnSh
         JWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bg9dPs8xhl5VgyKg453cTsyWpBbrcyHPBn+gqLrnHyk=;
        b=JDzRSyL6M/+3+kRP9B9cwch7DKXfoDIp+8/xJO3AHhnoDHrZ9vSw6FTBrOW7T5sVWt
         WjnsfVazwcCQgY7aLxTYmioes1ZBmPNqpy+d5AE815tfGOdgjpVYUpvGD+tJBI99xijK
         BEVQbMOItBArfqwlyM6rWLkRgXfnFSTG+ZXZ2uRd0uyxFb9sPdvZUmGuf4Ku7bfZAOyK
         Rl83UMRu7rnlO9YtYGkkRuTpePmao4jMisFSePY+qv+x+6Mk6hV+MsIgu4T5pwM/uhBH
         MTweyFLBrqZOV3AXeZsM6jcOLe8uvj6A/C/i9RWI2ukG8PY3rO/NprJ0Sr+Jn3z3uSXk
         2cDA==
X-Gm-Message-State: ANoB5pk8L4hI16HTRPANcvXhRtHNesgjoemHzt7vqxBTanPsRiiRwlKn
        Yosg3UWATdKkv9P6RSalQnfqb31mOsVXoQ==
X-Google-Smtp-Source: AA0mqf7WZVBxeg1+ln44btqG86WVrXBspGLYcj6OwD12ZGVJXVpfHOCPlOJSb++kyRnKkmx/FW/lzA==
X-Received: by 2002:aa7:9293:0:b0:56b:9bf4:c1c4 with SMTP id j19-20020aa79293000000b0056b9bf4c1c4mr18631040pfa.67.1669188309233;
        Tue, 22 Nov 2022 23:25:09 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902bd4800b00188fc33e96dsm11705342plx.198.2022.11.22.23.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:25:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, lwn@lwn.net
Subject: [ANNOUNCE] Git v2.39.0-rc0
Date:   Wed, 23 Nov 2022 16:25:08 +0900
Message-ID: <xmqqr0xum8tn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early preview release Git v2.39.0-rc0 is now available for
testing at the usual places.  It is comprised of 423 non-merge
commits since v2.38.0, contributed by 67 people, 28 of which are
new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.39.0-rc0' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.38.0 are as follows.
Welcome to the Git development community!

  Alexander Meshcheryakov, Anh Le, Arthur Chan, Daniel
  Sonbolian, Debra Obondo, Diomidis Spinellis, Erik Cervin
  Edin, Hank Leininger, herr.kaste, John A. Leuenhagen, Julia
  Ramer, Kevin Backhouse, Kousik Sanagavarapu, Lukáš Doktor,
  Martin Englund, M Hickford, Michael V. Scovetta, Noah Betzen,
  Nsengiyumva Wilberforce, orygaw, Ronan Pigott, Rubén Justo,
  Sotir Danailov, srz_zumix, Stefano Rivera, Tim Jaacks, Vincent
  Bernat, and Vlad-Stefan Harbuz.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  정재우, Ævar Arnfjörð Bjarmason, Alejandro R. Sedeño,
  Alex Henrie, Derrick Stolee, Đoàn Trần Công Danh, Elijah
  Newren, Emily Shaffer, Eric DeCosta, Eric Sunshine, Eric Wong,
  Glen Choo, Han-Wen Nienhuys, Jan Pokorný, Jeff Hostetler, Jeff
  King, Jerry Zhang, Johannes Altmanninger, Johannes Schindelin,
  John Cai, Jonathan Tan, Julien Moutinho, Junio C Hamano, Martin
  Ågren, Martin von Zweigbergk, Matthew John Cheetham, Michael
  J Gruber, Michael McClimon, Patrick Steinhardt, Philip Oakley,
  Philippe Blain, Phillip Wood, René Scharfe, Sergey Organov,
  Shaoxuan Yuan, SZEDER Gábor, Taylor Blau, Torsten Bögershausen,
  and Victoria Dye.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.39 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * "git grep" learned to expand the sparse-index more lazily and on
   demand in a sparse checkout.

 * By default, use of fsmonitor on a repository on networked
   filesystem is disabled. Add knobs to make it workable on macOS.

 * After checking out a "branch" that is a symbolic-ref that points at
   another branch, "git symbolic-ref HEAD" reports the underlying
   branch, not the symbolic-ref the user gave checkout as argument.
   The command learned the "--no-recurse" option to stop after
   dereferencing a symbolic-ref only once.

 * "git branch --edit-description @{-1}" is now a way to edit branch
   description of the branch you were on before switching to the
   current branch.

 * "git merge-tree --stdin" is a new way to request a series of merges
   and report the merge results.

 * "git shortlog" learned to group by the "format" string.

 * A new "--include-whitespace" option is added to "git patch-id", and
   existing bugs in the internal patch-id logic that did not match
   what "git patch-id" produces have been corrected.

 * Enable gc.cruftpacks by default for those who opt into
   feature.experimental setting.

 * "git repack" learns to send cruft objects out of the way into
   packfiles outside the repository.

 * 'scalar reconfigure -a' is taught to automatically remove
   scalar.repo entires which no longer exist.

 * Redact headers from cURL's h2h3 module in GIT_CURL_VERBOSE and
   others.

 * 'git maintenance register' is taught to write configuration to an
   arbitrary path, and 'git for-each-repo' is taught to expand tilde
   characters in paths.

 * When creating new notes, the template used to get a stray empty
   newline, which has been removed.

 * "git receive-pack" used to use all the local refs as the boundary for
   checking connectivity of the data "git push" sent, but now it uses
   only the refs that it advertised to the pusher. In a repository with
   the .hideRefs configuration, this reduces the resources needed to
   perform the check.

 * With '--recurse-submodules=on-demand', all submodules are
   recursively pushed.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * With a bit of header twiddling, use the native regexp library on
   macOS instead of the compat/ one.

 * Prepare for GNU [ef]grep that throw warning of their uses.

 * Sources related to fuzz testing have been moved down to their own
   directory.

 * Most credential helpers ignored unknown entries in a credential
   description, but a few died upon seeing them.  The latter were
   taught to ignore them, too

 * "scalar unregister" in a repository that is already been
   unregistered reported an error.

 * Remove error detection from a function that fetches from promisor
   remotes, and make it die when such a fetch fails to bring all the
   requested objects, to give an early failure to various operations.

 * Update CodingGuidelines to clarify what features to use and avoid
   in C99.

 * Avoid false-positive from LSan whose assumption may be broken with
   higher optimization levels.

 * Enable address and undefined sanitizer tasks at GitHub Actions CI.

 * More UNUSED annotation to help using -Wunused option with the
   compiler.
   (merge 4b992f0a24 jk/unused-anno-more later to maint).

 * Rewrite a deep recursion in the skipping negotiator to use a loop
   with on-heap prio queue to avoid stack wastage.

 * Add documentation for message IDs in fsck error messages.

 * Define the logical elements of a "bundle list", data structure to
   store them in-core, format to transfer them, and code to parse
   them.

 * The role the security mailing list plays in an embargoed release
   has been documented.

 * Two new facilities, "timer" and "counter", are introduced to the
   trace2 API.

 * Code simplification by using strvec_pushf() instead of building an
   argument in a separate strbuf.

 * Make sure generated dependency file is stably sorted to help
   developers debugging their build issues.

 * The glossary entries for "commit-graph file" and "reachability
   bitmap" have been added.

 * Various tests exercising the transfer.credentialsInUrl
   configuration are taught to avoid making requests which require
   resolving localhost to reduce CI-flakiness.

 * A redundant diagnostic message is dropped from test_path_is_missing().

 * Simplify the run-command API.

 * Update the actions/github-script dependency in CI to avoid a
   deprecation warning.

 * Progress on being able to initialize a rev_info struct with a
   macro.

 * Add trace2 counters to the region to clear skip worktree bits in a
   sparse checkout.

 * Modernize test script to avoid "test -f" and friends.

 * Avoid calling 'cache_tree_update()' when doing so would be
   redundant.

 * Update the credential-cache documentation to provide a more
   realistic example.

 * Makefile comments updates and reordering to clarify knobs used to
   choose SHA implementations.

 * A design document for sparse-checkout's future directions has been
   added.

 * Teach chainlint.pl to annotate the original test definition instead
   of the token stream.

 * "make coccicheck" is time consuming. It has been made to run more
   incrementally.


Fixes since v2.38
-----------------

 * The codepath that reads from the index v4 had unaligned memory
   accesses, which has been corrected.

 * Fix messages incorrectly marked for translation.

 * "git fsck" failed to release contents of tree objects already used
   from the memory, which has been fixed.

 * "git clone" did not like to see the "--bare" and the "--origin"
   options used together without a good reason.

 * "git remote rename" failed to rename a remote without fetch
   refspec, which has been corrected.

 * Documentation on various Boolean GIT_* environment variables have
   been clarified.

 * "git rebase -i" can mistakenly attempt to apply a fixup to a commit
   itself, which has been corrected.

 * "git multi-pack-index repack/expire" used to repack unreachable
   cruft into a new pack, which have been corrected.

 * In read-only repositories, "git merge-tree" tried to come up with a
   merge result tree object, which it failed (which is not wrong) and
   led to a segfault (which is bad), which has been corrected.

 * Force C locale while running tests around httpd to make sure we can
   find expected error messages in the log.

 * Fix a logic in "mailinfo -b" that miscomputed the length of a
   substring, which lead to an out-of-bounds access.

 * The codepath to sign learned to report errors when it fails to read
   from "ssh-keygen".

 * Code clean-up that results in plugging a leak.

 * "GIT_EDITOR=: git branch --edit-description" resulted in failure,
   which has been corrected.

 * The code to clean temporary object directories (used for
   quarantine) tried to remove them inside its signal handler, which
   was a no-no.

 * Update comment in the Makefile about the RUNTIME_PREFIX config knob.

 * Clarify that "the sentence after <area>: prefix does not begin with
   a capital letter" rule applies only to the commit title.

 * "git branch --edit-description" on an unborh branch misleadingly
   said that no such branch exists, which has been corrected.

 * Work around older clang that warns against C99 zero initialization
   syntax for struct.

 * Giving "--invert-grep" and "--all-match" without "--grep" to the
   "git log" command resulted in an attempt to access grep pattern
   expression structure that has not been allocated, which has been
   corrected.
   (merge db84376f98 ab/grep-simplify-extended-expression later to maint).

 * "git diff rev^!" did not show combined diff to go to the rev from
   its parents.
   (merge a79c6b6081 rs/diff-caret-bang-with-parents later to maint).

 * Allow configuration files in "protected" scopes to include other
   configuration files.
   (merge ecec57b3c9 gc/bare-repo-discovery later to maint).

 * Give a bit more diversity to macOS CI by using sha1dc in one of the
   jobs (the other one tests Apple Common Crypto).
   (merge 1ad5c3df35 jc/ci-osx-with-sha1dc later to maint).

 * A bugfix with tracing support in midx codepath
   (merge e9c3839944 tb/midx-bitmap-selection-fix later to maint).

 * When geometric repacking feature is in use together with the
   --pack-kept-objects option, we lost packs marked with .keep files.
   (merge 197443e80a tb/save-keep-pack-during-geometric-repack later to maint).

 * Move a global variable added as a hack during regression fixes to
   its proper place in the API.
   (merge 0b0ab95f17 ab/run-hook-api-cleanup later to maint).

 * Update to build procedure with VS using CMake/CTest.
   (merge c858750b41 js/cmake-updates later to maint).

 * The short-help text shown by "git cmd -h" and the synopsis text
   shown at the beginning of "git help cmd" have been made more
   consistent.

 * When creating a multi-pack bitmap, remove per-pack bitmap files
   unconditionally as they will never be consulted.
   (merge 55d902cd61 tb/remove-unused-pack-bitmap later to maint).

 * Fix a longstanding syntax error in Git.pm error codepath.

 * "git diff --stat" etc. were invented back when everything was ASCII
   and strlen() was a way to measure the display width of a string;
   adjust them to compute the display width assuming UTF-8 pathnames.
   (merge ce8529b2bb tb/diffstat-with-utf8-strwidth later to maint).

 * "git branch --edit-description" can exit with status -1 which is
   not a good practice; it learned to use 1 as everybody else instead.

 * "git apply" limits its input to a bit less than 1 GiB.

 * Merging a branch with directory renames into a branch that changes
   the directory to a symlink was mishandled by the ort merge
   strategy, which has been corrected.

 * A bugfix to "git subtree" in its split and merge features.

 * Fix some bugs in the reflog messages when rebasing and changes the
   reflog messages of "rebase --apply" to match "rebase --merge" with
   the aim of making the reflog easier to parse.

 * "git rebase --keep-base" used to discard the commits that are
   already cherry-picked to the upstream, even when "keep-base" meant
   that the base, on top of which the history is being rebuilt, does
   not yet include these cherry-picked commits.  The --keep-base
   option now implies --reapply-cherry-picks and --no-fork-point
   options.

 * The way "git repack" creared temporary files when it received a
   signal was prone to deadlocking, which has been corrected.

 * Various tests exercising the transfer.credentialsInUrl
   configuration are taught to avoid making requests which require
   resolving localhost to reduce CI-flakiness.

 * The adjust_shared_perm() helper function learned to refrain from
   setting the "g+s" bit on directories when it is not necessary.

 * "git archive" mistakenly complained twice about a missing
   executable, which has been corrected.

 * Fix a bug where `git branch -d` did not work on an orphaned HEAD.

 * `git rebase --update-refs` would delete references when all
   `update-ref` commands in the sequencer were removed, which has been
   corrected.

 * Fix a regression in the bisect-helper which mistakenly treats
   arguments to the command given to 'git bisect run' as arguments to
   the helper.

 * Correct an error where `git rebase` would mistakenly use a branch or
   tag named "refs/rewritten/xyz" when missing a rebase label.

 * Other code cleanup, docfix, build fix, etc.
   (merge 413bc6d20a ds/cmd-main-reorder later to maint).
   (merge 8d2863e4ed nw/t1002-cleanup later to maint).

----------------------------------------------------------------

Changes since v2.38.0 are as follows:

Alejandro R. Sedeño (1):
      git-compat-util.h: GCC deprecated message arg only in GCC 4.5+

Alex Henrie (2):
      fsmonitor--daemon: don't translate literal commands
      push: improve grammar of branch.autoSetupMerge advice

Anh Le (2):
      index: add trace2 region for clear skip worktree
      index: raise a bug if the index is materialised more than once

Arthur Chan (1):
      fuzz: reorganise the path for existing oss-fuzz fuzzers

Daniel Sonbolian (1):
      git.c: improve code readability in cmd_main()

Debra Obondo (1):
      t7001-mv.sh: modernizing test script using functions

Derrick Stolee (15):
      maintenance: add 'unregister --force'
      scalar: make 'unregister' idempotent
      gc: replace config subprocesses with API calls
      string-list: document iterator behavior on NULL input
      bundle-uri: fix technical doc issues
      bundle-uri: use plain string in find_temp_filename()
      bundle-uri: create bundle_list struct and helpers
      bundle-uri: create base key-value pair parsing
      bundle-uri: parse bundle list in config format
      bundle-uri: limit recursion depth for bundle lists
      bundle: properly clear all revision flags
      bundle-uri: fetch a list of bundles
      bundle: add flags to verify_bundle()
      bundle-uri: quiet failed unbundlings
      bundle-uri: suppress stderr from remote-https

Diomidis Spinellis (1):
      grep: fix multibyte regex handling under macOS

Elijah Newren (4):
      merge-ort: fix bug with dir rename vs change dir to symlink
      merge-tree: update documentation for differences in -z output
      merge-tree: support multiple batched merges with --stdin
      sparse-checkout.txt: new document with sparse-checkout directions

Emily Shaffer (2):
      gc: add tests for --cruft and friends
      config: let feature.experimental imply gc.cruftPacks=true

Eric DeCosta (6):
      fsmonitor: refactor filesystem checks to common interface
      fsmonitor: relocate socket file if .git directory is remote
      fsmonitor: avoid socket location check if using hook
      fsmonitor: deal with synthetic firmlinks on macOS
      fsmonitor: check for compatability before communicating with fsmonitor
      fsmonitor: add documentation for allowRemote and socketDir options

Eric Sunshine (8):
      check-non-portable-shell: detect obsolescent egrep/fgrep
      chainlint: add explanatory comments
      chainlint: tighten accuracy when consuming input stream
      chainlint: latch start/end position of each token
      chainlint: annotate original test definition rather than token stream
      chainlint: sidestep impoverished macOS "terminfo"
      chainlint: latch line numbers at which each token starts and ends
      chainlint: prefix annotated test definition with line numbers

Eric Wong (1):
      delta-islands: free island-related data after use

Glen Choo (2):
      config: respect includes in protected config
      http: redact curl h2h3 headers in info

Han-Wen Nienhuys (1):
      refs: unify parse_worktree_ref() and ref_type()

Jeff Hostetler (9):
      config.mak.dev: disable suggest braces error on old clang versions
      trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
      tr2tls: clarify TLS terminology
      api-trace2.txt: elminate section describing the public trace2 API
      trace2: rename the thread_name argument to trace2_thread_start
      trace2: improve thread-name documentation in the thread-context
      trace2: convert ctx.thread_name from strbuf to pointer
      trace2: add stopwatch timers
      trace2: add global counter mechanism

Jeff King (41):
      fsck: free tree buffers after walking unreachable objects
      fsck: turn off save_commit_buffer
      parse_object_buffer(): respect save_commit_buffer
      clone: allow "--bare" with "-o"
      remote: handle rename of remote without fetch refspec
      shell: add basic tests
      shell: limit size of interactive commands
      sequencer: detect author name errors in read_author_script()
      test-submodule: inline resolve_relative_url() function
      multi-pack-index: avoid writing to global in option callback
      commit: avoid writing to global in option callback
      attr: drop DEBUG_ATTR code
      dir: use fspathncmp() in pl_hashmap_cmp()
      fsmonitor: fix leak of warning message
      diffstat_consume(): assert non-zero length
      submodule--helper: drop unused argc from module_list_compute()
      update-index: drop unused argc from do_reupdate()
      mark unused parameters in trivial compat functions
      object-file: mark unused parameters in hash_unknown functions
      string-list: mark unused callback parameters
      date: mark unused parameters in handler functions
      apply: mark unused parameters in handlers
      apply: mark unused parameters in noop error/warning routine
      convert: mark unused parameter in null stream filter
      diffcore-pickaxe: mark unused parameters in pickaxe functions
      ll-merge: mark unused parameters in callbacks
      Makefile: force -O0 when compiling with SANITIZE=leak
      repack: convert "names" util bitfield to array
      repack: populate extension bits incrementally
      repack: expand error message for missing pack files
      repack: use tempfiles for signal cleanup
      repack: drop remove_temporary_files()
      Git.pm: trust rev-parse to find bare repositories
      t7700: annotate cruft-pack failure with ok=sigpipe
      shortlog: accept `--date`-related options
      Makefile: force -O0 when compiling with SANITIZE=leak
      t5516: move plaintext-password tests from t5601 and t5516
      ref-filter: fix parsing of signatures without blank lines
      ref-filter: fix parsing of signatures with CRLF and no body
      branch: gracefully handle '-d' on orphan HEAD
      t: run t5551 tests with both HTTP and HTTP/2

Jerry Zhang (6):
      patch-id: fix stable patch id for binary / header-only
      patch-id: use stable patch-id for rebases
      builtin: patch-id: fix patch-id with binary diffs
      patch-id: fix patch-id for mode changes
      builtin: patch-id: add --verbatim as a command mode
      builtin: patch-id: remove unused diff-tree prefix

Johannes Altmanninger (1):
      sequencer: avoid dropping fixup commit that targets self via commit-ish

Johannes Schindelin (11):
      merge-ort: fix segmentation fault in read-only repositories
      merge-ort: return early when failing to write a blob
      cmake: make it easier to diagnose regressions in CTest runs
      cmake: copy the merge tools for testing
      add -p: avoid ambiguous signed/unsigned comparison
      cmake: avoid editing t/test-lib.sh
      cmake: increase time-out for a long-running test
      t5516/t5601: be less strict about the number of credential warnings
      scalar reconfigure -a: remove stale `scalar.repo` entries
      ci: use a newer `github-script` version
      tests(scalar): tighten the stale `scalar.repo` test some

John Cai (3):
      tmp-objdir: skip clean up when handling a signal
      fsck: remove the unused BAD_TAG_OBJECT
      fsck: document msg-id

Jonathan Tan (4):
      promisor-remote: remove a return value
      promisor-remote: die upon failing fetch
      negotiator/skipping: avoid stack overflow
      Doc: document push.recurseSubmodules=only

Julia Ramer (1):
      embargoed releases: also describe the git-security list and the process

Junio C Hamano (26):
      environ: document GIT_SSL_NO_VERIFY
      environ: explain Boolean environment variables
      environ: GIT_FLUSH should be made a usual Boolean
      environ: simplify description of GIT_INDEX_FILE
      environ: GIT_INDEX_VERSION affects not just a new repository
      branch: do not fail a no-op --edit-desc
      SubmittingPatches: use usual capitalization in the log message body
      Start 2.39 cycle
      symbolic-ref: teach "--[no-]recurse" option
      The (real) first batch for 2.39
      The second batch
      The third batch
      The fourth batch
      ci: add address and undefined sanitizer tasks
      ci: use DC_SHA1=YesPlease on osx-clang job for CI
      The fifth batch
      diff: leave NEEDWORK notes in show_stats() function
      fsck: remove the unused MISSING_TREE_OBJECT
      Documentation: add lint-fsck-msgids
      Downmerge a handful of topics for 2.38.2
      The sixth batch
      Downmerge a bit more for 2.38.2
      The seventh batch
      The eighth batch
      adjust_shared_perm(): leave g+s alone when the group does not matter
      Git 2.39-rc0

Kevin Backhouse (1):
      alias.c: reject too-long cmdline strings in split_cmdline()

Kousik Sanagavarapu (1):
      repository-version.txt: partialClone casing change

M Hickford (4):
      Documentation/gitcredentials.txt: mention password alternatives
      Documentation: increase example cache timeout to 1 hour
      docs: clarify that credential discards unrecognised attributes
      Docs: describe how a credential-generating helper works

Martin Ågren (1):
      test-lib-functions: drop redundant diagnostic print

Matthew John Cheetham (3):
      wincred: ignore unknown lines (do not die)
      netrc: ignore unknown lines (do not die)
      osxkeychain: clarify that we ignore unknown lines

Michael J Gruber (1):
      notes: avoid empty line in template

Michael McClimon (1):
      Git.pm: add semicolon after catch statement

Noah Betzen (1):
      mergetool.txt: typofix 'overwriten' -> 'overwritten'

Nsengiyumva Wilberforce (1):
      t1002: modernize outdated conditional

Patrick Steinhardt (7):
      refs: fix memory leak when parsing hideRefs config
      refs: get rid of global list of hidden refs
      revision: move together exclusion-related functions
      revision: introduce struct to handle exclusions
      revision: add new parameter to exclude hidden refs
      rev-parse: add `--exclude-hidden=` option
      receive-pack: only use visible refs for connectivity check

Philip Oakley (4):
      doc: use "commit-graph" hyphenation consistently
      doc: use 'object database' not ODB or abbreviation
      glossary: add "commit graph" description
      glossary: add reachability bitmap description

Philippe Blain (9):
      test-lib-functions: mark 'test_commit' variables as 'local'
      subtree: use 'git rev-parse --verify [--quiet]' for better error messages
      subtree: add 'die_incompatible_opt' function to reduce duplication
      subtree: prefix die messages with 'fatal'
      subtree: define a variable before its first use in 'find_latest_squash'
      subtree: use named variables instead of "$@" in cmd_pull
      subtree: process 'git-subtree-split' trailer in separate function
      subtree: fix squash merging after annotated tag was squashed merged
      subtree: fix split after annotated tag was squashed merged

Phillip Wood (23):
      mailinfo -b: fix an out of bounds access
      ssh signing: return an error when signature cannot be read
      t3435: remove redundant test case
      t3416: tighten two tests
      t3416: set $EDITOR in subshell
      rebase: be stricter when reading state files containing oids
      rebase: store orig_head as a commit
      rebase: rename merge_base to branch_base
      rebase: factor out branch_base calculation
      rebase --keep-base: imply --reapply-cherry-picks
      rebase --keep-base: imply --no-fork-point
      rebase --apply: remove duplicated code
      t3406: rework rebase reflog tests
      rebase --merge: fix reflog when continuing
      rebase --merge: fix reflog message after skipping
      rebase --apply: respect GIT_REFLOG_ACTION
      rebase --apply: make reflog messages match rebase --merge
      rebase --abort: improve reflog message
      rebase: cleanup action handling
      sequencer: stop exporting GIT_REFLOG_ACTION
      rebase: stop exporting GIT_REFLOG_ACTION
      sequencer: unify label lookup
      sequencer: tighten label lookups

René Scharfe (20):
      revision: use strtol_i() for exclude_parent
      revisions.txt: unspecify order of resolved parts of ^!
      diff: support ^! for merges
      gc: simplify maintenance_task_pack_refs()
      t/lib-httpd: pass LANG and LC_ALL to Apache
      bisect--helper: plug strvec leak
      archive: deduplicate verbose printing
      submodule: use strvec_pushf() for --super-prefix
      run-command: fix return value comment
      am: simplify building "show" argument list
      bisect: simplify building "checkout" argument list
      bisect--helper: factor out do_bisect_run()
      sequencer: simplify building argument list in do_exec()
      use child_process member "args" instead of string array variable
      use child_process members "args" and "env" directly
      replace and remove run_command_v_opt_cd_env()
      replace and remove run_command_v_opt_tr2()
      replace and remove run_command_v_opt_cd_env_tr2()
      replace and remove run_command_v_opt()
      archive-tar: report filter start error only once

Ronan Pigott (2):
      for-each-repo: interpolate repo path arguments
      maintenance: add option to register in a specific config

Rubén Justo (5):
      ref-filter.c: fix a leak in get_head_description
      branch: description for non-existent branch errors
      branch: support for shortcuts like @{-1}, completed
      branch: error copying or renaming a detached HEAD
      branch: error code with --edit-description

SZEDER Gábor (1):
      Documentation/build-docdep.perl: generate sorted output

Sergey Organov (3):
      diff-merges: cleanup func_by_opt()
      diff-merges: cleanup set_diff_merges()
      diff-merges: clarify log.diffMerges documentation

Shaoxuan Yuan (1):
      builtin/grep.c: integrate with sparse index

Sotir Danailov (1):
      docs: git-send-email: difference between ssl and tls smtp-encryption

Taylor Blau (64):
      Documentation/git-multi-pack-index.txt: fix typo
      Documentation/git-multi-pack-index.txt: clarify expire behavior
      midx.c: prevent `expire` from removing the cruft pack
      midx.c: avoid cruft packs with `repack --batch-size=0`
      midx.c: replace `xcalloc()` with `CALLOC_ARRAY()`
      midx.c: remove unnecessary loop condition
      midx.c: avoid cruft packs with non-zero `repack --batch-size`
      builtin/clone.c: disallow `--local` clones with symlinks
      t/lib-submodule-update.sh: allow local submodules
      t/t1NNN: allow local submodules
      t/2NNNN: allow local submodules
      t/t3NNN: allow local submodules
      t/t4NNN: allow local submodules
      t/t5NNN: allow local submodules
      t/t6NNN: allow local submodules
      t/t7NNN: allow local submodules
      t/t9NNN: allow local submodules
      transport: make `protocol.file.allow` be "user" by default
      t1092: prepare for changing protocol.file.allow
      t2080: prepare for changing protocol.file.allow
      t1092: prepare for changing protocol.file.allow
      t2080: prepare for changing protocol.file.allow
      t3207: prepare for changing protocol.file.allow
      t5516: prepare for changing protocol.file.allow
      t5537: prepare for changing protocol.file.allow
      t7814: prepare for changing protocol.file.allow
      t3206: prepare for changing protocol.file.allow
      t5537: prepare for changing protocol.file.allow
      Git 2.30.6
      Git 2.31.5
      Git 2.32.4
      Git 2.33.5
      Git 2.34.5
      Git 2.35.5
      Git 2.36.3
      t7527: prepare for changing protocol.file.allow
      Git 2.37.4
      Git 2.38.1
      midx.c: fix whitespace typo
      midx.c: consider annotated tags during bitmap selection
      midx.c: instrument MIDX and bitmap generation with trace2 regions
      pack-bitmap-write.c: instrument number of reused bitmaps
      builtin/repack.c: remove redundant pack-based bitmaps
      repack: don't remove .keep packs with `--pack-kept-objects`
      builtin/repack.c: pass "out" to `prepare_pack_objects`
      builtin/repack.c: pass "cruft_expiration" to `write_cruft_pack`
      builtin/repack.c: write cruft packs to arbitrary locations
      builtin/repack.c: implement `--expire-to` for storing pruned objects
      shortlog: make trailer insertion a noop when appropriate
      shortlog: extract `--group` fragment for translation
      shortlog: support arbitrary commit format `--group`s
      shortlog: extract `shortlog_finish_setup()`
      shortlog: implement `--group=author` in terms of `--group=<format>`
      shortlog: implement `--group=committer` in terms of `--group=<format>`
      apply: reject patches larger than ~1 GiB
      Documentation/howto/maintain-git.txt: fix Meta/redo-jch.sh invocation
      The ninth batch
      Documentation: build redo-jch.sh from master..jch
      Documentation: build redo-seen.sh from jch..seen
      The tenth batch
      The eleventh batch
      The twelfth batch
      builtin/gc.c: fix use-after-free in maintenance_unregister()
      The thirteenth batch

Torsten Bögershausen (1):
      diff.c: use utf8_strwidth() to count display width

Victoria Dye (7):
      read-cache: avoid misaligned reads in index v4
      rebase --update-refs: avoid unintended ref deletion
      cache-tree: add perf test comparing update and prime
      unpack-trees: add 'skip_cache_tree_update' option
      reset: use 'skip_cache_tree_update' option
      read-tree: use 'skip_cache_tree_update' option
      rebase: use 'skip_cache_tree_update' option

Vincent Bernat (1):
      ls-files: fix --ignored and --killed flags in synopsis

Vlad-Stefan Harbuz (1):
      Documentation: fix typo

srz_zumix (1):
      fsmonitor--daemon: on macOS support symlink

Ævar Arnfjörð Bjarmason (100):
      test-lib: have SANITIZE=leak imply TEST_NO_MALLOC_CHECK
      CodingGuidelines: update for C99
      CodingGuidelines: mention dynamic C99 initializer elements
      CodingGuidelines: allow declaring variables in for loops
      CodingGuidelines: mention C99 features we can't use
      grep.c: remove "extended" in favor of "pattern_expression", fix segfault
      CodingGuidelines: recommend against unportable C99 struct syntax
      bundle-uri: create "key=value" line parsing
      bundle-uri: unit test "key=value" parsing
      run-command test helper: use "else if" pattern
      run-command API: have "run_processes_parallel{,_tr2}()" return void
      run-command tests: use "return", not "exit"
      run-command API: make "n" parameter a "size_t"
      run-command API: don't fall back on online_cpus()
      run-command.c: use designated init for pp_init(), add "const"
      run-command API: have run_process_parallel() take an "opts" struct
      run-command API: move *_tr2() users to "run_processes_parallel()"
      run-command.c: make "struct parallel_processes" const if possible
      run-command.c: don't copy *_fn to "struct parallel_processes"
      run-command.c: don't copy "ungroup" to "struct parallel_processes"
      run-command.c: don't copy "data" to "struct parallel_processes"
      run-command.c: use "opts->processes", not "pp->max_processes"
      run-command.c: pass "opts" further down, and use "opts->processes"
      run-command.c: remove "max_processes", add "const" to signal() handler
      tests: assert *.txt SYNOPSIS and -h output
      CodingGuidelines: update and clarify command-line conventions
      builtin/bundle.c: indent with tabs
      bundle: define subcommand -h in terms of command -h
      doc SYNOPSIS: don't use ' for subcommands
      doc SYNOPSIS: consistently use ' for commands
      built-ins: consistently add "\n" between "usage" and options
      doc txt & -h consistency: word-wrap
      doc txt & -h consistency: fix incorrect alternates syntax
      doc txt & -h consistency: add "-z" to cat-file "-h"
      doc txt & -h consistency: balance unbalanced "[" and "]"
      doc txt & -h consistency: correct padding around "[]()"
      stash doc SYNOPSIS & -h: correct padding around "[]()"
      doc txt & -h consistency: use "<options>", not "<options>..."
      doc SYNOPSIS & -h: use "-" to separate words in labels, not "_"
      doc txt & -h consistency: fix mismatching labels
      doc txt & -h consistency: add or fix optional "--" syntax
      doc txt & -h consistency: make output order consistent
      doc txt & -h consistency: add missing options and labels
      doc txt & -h consistency: make "rerere" consistent
      doc txt & -h consistency: make "read-tree" consistent
      doc txt & -h consistency: make "bundle" consistent
      doc txt & -h consistency: use "git foo" form, not "git-foo"
      doc txt & -h consistency: add missing options
      doc txt & -h consistency: make "stash" consistent
      doc txt & -h consistency: make "annotate" consistent
      doc txt & -h consistency: use "[<label>...]" for "zero or more"
      doc txt & -h consistency: make "diff-tree" consistent
      doc txt & -h consistency: make "commit" consistent
      reflog doc: list real subcommands up-front
      worktree: define subcommand -h in terms of command -h
      doc txt & -h consistency: make "worktree" consistent
      tests: start asserting that *.txt SYNOPSIS matches -h output
      tests: assert consistent whitespace in -h output
      fsmonitor OSX: compile with DC_SHA1=YesPlease
      merge: remove always-the-same "verbose" arguments
      hook tests: fix redirection logic error in 96e7225b310
      submodule tests: reset "trace.out" between "grep" invocations
      run-command tests: test stdout of run_command_parallel()
      Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
      cocci rules: remove unused "F" metavariable from pending rule
      Makefile: add ability to TAB-complete cocci *.patch rules
      Makefile: have "coccicheck" re-run if flags change
      Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
      cocci: split off include-less "tests" from SPATCH_FLAGS
      cocci: split off "--all-includes" from SPATCH_FLAGS
      cocci: make "coccicheck" rule incremental
      cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
      Makefile: copy contrib/coccinelle/*.cocci to build/
      cocci rules: remove <id>'s from rules that don't need them
      cocci: run against a generated ALL.cocci
      spatchcache: add a ccache-alike for "spatch"
      Makefile: always (re)set DC_SHA1 on fallback
      INSTALL: remove discussion of SHA-1 backends
      Makefile: correct DC_SHA1 documentation
      Makefile: create and use sections for "define" flag listing
      Makefile: rephrase the discussion of *_SHA1 knobs
      Makefile: document default SHA-256 backend
      Makefile: document SHA-1 and SHA-256 default and selection order
      Makefile & test-tool: replace "DC_SHA1" variable with a "define"
      Makefile: document default SHA-1 backend on OSX
      Makefile: discuss SHAttered in *_SHA{1,256} discussion
      submodule--helper: move "config" to a test-tool
      submodule tests: add tests for top-level flag output
      submodule--helper: fix a memory leak in "status"
      submodule tests: test for a "foreach" blind-spot
      submodule.c: refactor recursive block out of absorb function
      submodule API & "absorbgitdirs": remove "----recursive" option
      submodule--helper: remove --prefix from "absorbgitdirs"
      submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
      submodule--helper: use OPT_SUBCOMMAND() API
      revisions API: extend the nascent REV_INFO_INIT macro
      t7610: fix flaky timeout issue, don't clone from example.com
      Makefile: don't create a ".build/.build/" for cocci, fix output
      maintenance --unregister: fix uninit'd data use & -Wdeclaration-after-statement
      t7610: use "file:///dev/null", not "/dev/null", fixes MinGW

Đoàn Trần Công Danh (8):
      CodingGuidelines: allow grep -E
      t: remove \{m,n\} from BRE grep usage
      t: convert egrep usage to "grep -E"
      t: convert fgrep usage to "grep -F"
      Makefile: clarify runtime relative gitexecdir
      bisect--helper: remove unused options
      bisect--helper: move all subcommands into their own functions
      bisect--helper: parse subcommand with OPT_SUBCOMMAND


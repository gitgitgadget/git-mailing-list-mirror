Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB081F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeC3Uin (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:38:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54953 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeC3Uil (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:38:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id h76so17124090wme.4
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=zlUsuSuP/QnyMQFSHrMcLxB3HPkpqx0u/xHPgrohwPg=;
        b=EdFbkXYHR9iQ1y9JwfQzd1phFYbKnsHmbs64xx9vGvoXDYa1nibFkqx7pwPECJOOCh
         oTUrookxdNtXRYg1Q4CS66NPx3XpdWPFPLNOJ3uMMUZgTGAWQTpv0G4Ylh1uPNpGv5rr
         Oq9HNk8fYmw9aiYDcdGd9A7k1bPP11RghRqQRnAcNj2NrtAEjWf9IG/EanQS2u0Ue5D1
         2fNmMlNL7us5yFUOX2uA92ktkwFLKPWe4tTcyk3axhkGvuXpQloRzi7BbEJm8W7J7ViT
         yhD0QzciqMpMLajEybB8Mk/FkDgUyYs/3IE3bxz/Dl/m4NJkVAvhA38HRjT5KU741q2j
         a8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=zlUsuSuP/QnyMQFSHrMcLxB3HPkpqx0u/xHPgrohwPg=;
        b=uFckx34ftckyi4GWb0fAqBPRK95Tedl7bWk5a7dTozOPs7LDuELWyFDmPZDO+6GWKw
         y9ktXETvQdVrEk7X7Tjlcfj1KruIennckPy/zsjQ3Rk+VbOOJcMZUjwNlOLshUtzDOmX
         IkjSSeWug+utufqPWnazhGK0Ba6R63NuuMUjEaeMkLJSfKoUwJJMI/0iBsfUKg7YNT/P
         IeLJd7Nrjs6gAJ4VBTRaAh98IyTJD9gvnQuSz8PfvOlYC/P8Ns2W3qVBG15oIc4EowLy
         NclX898+5Tucfk8QmvH7+hvpSShvsFUsIfqAiyccTsfg4YFXC6Ur5FRP/YzfIGlBrJEI
         qWeg==
X-Gm-Message-State: ALQs6tChavauAyT8Dm2LBZyBfkuiyrLFwXHV8dpeLHzqg5UarQI46CFo
        XIs7QBQdNqLl5yIyjMTxGCyn9mLS
X-Google-Smtp-Source: AIpwx49KvoaUmQ/n2nylhMHfoioynQgGTehs6PojWGRQl/Qb+1JAZKvUsWPZbTV0x7XyH0eXmVWUMA==
X-Received: by 10.28.136.4 with SMTP id k4mr3308434wmd.133.1522442317974;
        Fri, 30 Mar 2018 13:38:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m7sm8196451wrb.61.2018.03.30.13.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 13:38:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2018, #06; Fri, 30)
X-master-at: c2a499e6c31ed613a606ffdeb5bb74ab41e9a586
X-next-at: caa68db14db9f582fb6802d6d3c880bb7760ad52
Date:   Fri, 30 Mar 2018 13:38:36 -0700
Message-ID: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
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

Git 2.17 final is expected to be tagged by early next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jh/partial-clone (2018-03-25) 1 commit
  (merged to 'next' on 2018-03-28 at 2a0a7aef8e)
 + unpack-trees: release oid_array after use in check_updates()

 Hotfix.

--------------------------------------------------
[New Topics]

* rs/status-with-removed-submodule (2018-03-28) 1 commit
  (merged to 'next' on 2018-03-30 at 8a7b618bc1)
 + submodule: check for NULL return of get_submodule_ref_store()

 "git submodule status" misbehaved on a submodule that has been
 removed from the working tree.

 Will cook in 'next'.


* lv/tls-1.3 (2018-03-29) 1 commit
  (merged to 'next' on 2018-03-30 at 4f13731408)
 + http: allow use of TLS 1.3

 When built with more recent cURL, GIT_SSL_VERSION can now specify
 "tlsv1.3" as its value.

 Will cook in 'next'.


* nd/warn-more-for-devs (2018-03-29) 3 commits
 - Makefile: add EAGER_DEVELOPER mode
 - Makefile: detect compiler and enable more warnings in DEVELOPER=1
 - connect.c: mark die_initial_contact() NORETURN

 The build procedure "make DEVELOPER=YesPlease" learned to enable a
 bit more warning options depending on the compiler used to help
 developers more.  There also is "make EAGER_DEVELOPER=YesPlease"
 available now, for those who want to help fixing warnings we
 usually ignore.

 Will merge to 'next'.


* sb/submodule-move-nested (2018-03-29) 6 commits
 - submodule: fixup nested submodules after moving the submodule
 - submodule-config: remove submodule_from_cache
 - submodule-config: add repository argument to submodule_from_{name, path}
 - submodule-config: allow submodule_free to handle arbitrary repositories
 - grep: remove "repo" arg from non-supporting funcs
 - submodule.h: drop declaration of connect_work_tree_and_git_dir
 (this branch uses nd/remove-ignore-env-field and sb/object-store; is tangled with sb/packfiles-in-repository.)

 Moving a submodule that itself has submodule in it with "git mv"
 forgot to make necessary adjustment to the nested sub-submodules;
 now the codepath learned to recurse into the submodules.


* tb/config-type (2018-03-29) 1 commit
 - builtin/config.c: prefer `--type=bool` over `--bool`, etc.
 (this branch is used by tb/config-default.)

 The "git config" command uses separate options e.g. "--int",
 "--bool", etc. to specify what type the caller wants the value to
 be interpreted as.  A new "--type=<typename>" option has been
 introduced, which would make it cleaner to define new types.

 Will merge to 'next'.


* tb/config-default (2018-03-29) 3 commits
 - builtin/config: introduce `color` type specifier
 - config.c: introduce 'git_config_color' to parse ANSI colors
 - builtin/config: introduce `--default`
 (this branch uses tb/config-type.)

 "git config --get" learned the "--default" option, to help the
 calling script.  Building on top of the tb/config-type topic, the
 "git config" learns "--type=color" type.  Taken together, you can
 do things like "git config --get foo.color --default blue" and get
 the ANSI color sequence for the color given to foo.color variable,
 or "blue" if the variable does not exist.


* eb/cred-helper-ignore-sigpipe (2018-03-29) 1 commit
  (merged to 'next' on 2018-03-30 at c48e98c1b1)
 + credential: ignore SIGPIPE when writing to credential helpers

 When credential helper exits very quickly without reading its
 input, it used to cause Git to die with SIGPIPE, which has been
 fixed.

 Will cook in 'next'.


* jk/flockfile-stdio (2018-03-30) 1 commit
 - config: move flockfile() closer to unlocked functions


* jk/relative-directory-fix (2018-03-30) 5 commits
 - refs: use chdir_notify to update cached relative paths
 - set_work_tree: use chdir_notify
 - add chdir-notify API
 - trace.c: export trace_setup_key
 - set_git_dir: die when setenv() fails

--------------------------------------------------
[Stalled]

* sb/blame-color (2018-02-13) 3 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata

 Expecting a reroll.
 cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
 error messages are funny, can segfault, ...


* av/fsmonitor-updates (2018-01-04) 6 commits
 - fsmonitor: use fsmonitor data in `git diff`
 - fsmonitor: remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
 - dir.c: update comments to match argument name

 Code clean-up on fsmonitor integration, plus optional utilization
 of the fsmonitor data in diff-files.

 Waiting for an update.
 cf. <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>


* pb/bisect-helper-2 (2017-10-28) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 Expecting a reroll.
 cf. <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>


* mk/http-backend-content-length (2017-11-27) 4 commits
 - SQUASH???
 - t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
 - SQUASH???
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.

 Expecting a reroll.
 Suggested fixes to be used when rerolling is queued, but I'd
 prefer _not_ squashing them myself.

 Also, it may be too complex solution for the problem.
 cf. <20171204171308.GA13332@sigill.intra.peff.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).

--------------------------------------------------
[Cooking]

* ds/bsearch-hash (2018-03-25) 4 commits
  (merged to 'next' on 2018-03-29 at 561d5577a7)
 + sha1_name: use bsearch_pack() in unique_in_pack()
 + sha1_name: use bsearch_pack() for abbreviations
 + packfile: define and use bsearch_pack()
 + sha1_name: convert struct min_abbrev_data to object_id
 (this branch uses bc/object-id.)

 Code to find the length to uniquely abbreviate object names based
 on packfile content, which is a relatively recent addtion, has been
 optimized to use the same fan-out table.

 Will cook in 'next'.


* jh/json-writer (2018-03-28) 1 commit
 - json_writer: new routines to create data in JSON format

 Is this ready for 'next'?


* jk/diff-highlight-graph-fix (2018-03-21) 7 commits
  (merged to 'next' on 2018-03-29 at eb995f66e3)
 + diff-highlight: detect --graph by indent
 + diff-highlight: use flush() helper consistently
 + diff-highlight: test graphs with --color
 + diff-highlight: test interleaved parallel lines of history
 + diff-highlight: prefer "echo" to "cat" in tests
 + diff-highlight: use test_tick in graph test
 + diff-highlight: correct test graph diagram

 "diff-highlight" filter (in contrib/) learned to undertand "git log
 --graph" output better.

 Will cook in 'next'.


* ot/libify-get-ref-atom-value (2018-03-29) 6 commits
 - ref-filter: libify get_ref_atom_value()
 - ref-filter: add return value to parsers
 - ref-filter: change parsing function error handling
 - ref-filter: add return value && strbuf to handlers
 - ref-filter: start adding strbufs with errors
 - ref-filter: add shortcut to work with strbufs

 Code restructuring, in preparation for further work.

 Will merge to 'next'.


* ab/doc-hash-brokenness (2018-03-27) 2 commits
  (merged to 'next' on 2018-03-29 at e9b2f5cf4a)
 + doc hash-function-transition: clarify what SHAttered means
 + doc hash-function-transition: clarify how older gits die on NewHash

 Doc updates.

 Will cook in 'next'.


* ab/drop-contrib-examples (2018-03-26) 1 commit
  (merged to 'next' on 2018-03-29 at 9d8a7603b5)
 + Remove contrib/examples/*

 Will cook in 'next'.


* bc/hash-independent-tests (2018-03-26) 10 commits
  (merged to 'next' on 2018-03-29 at 11179d9b71)
 + t2107: abstract away SHA-1-specific constants
 + t2101: abstract away SHA-1-specific constants
 + t2101: modernize test style
 + t2020: abstract away SHA-1 specific constants
 + t1507: abstract away SHA-1-specific constants
 + t1411: abstract away SHA-1-specific constants
 + t1405: sort reflog entries in a hash-independent way
 + t1300: abstract away SHA-1-specific constants
 + t1304: abstract away SHA-1-specific constants
 + t1011: abstract away SHA-1-specific constants

 Tests that rely on the exact hardcoded values of object names have
 been updated in preparation for hash function migration.

 Will cook in 'next'.


* cc/perf-aggregate-sort (2018-03-27) 2 commits
  (merged to 'next' on 2018-03-29 at 0251068bac)
 + perf/aggregate: add --sort-by=regression option
 + perf/aggregate: add display_dir()

 Perf-test update.

 Will cook in 'next'.


* jc/test-must-be-empty (2018-03-27) 1 commit
  (merged to 'next' on 2018-03-29 at 2e64650f23)
 + test_must_be_empty: simplify file existence check

 Test helper update.

 Will cook in 'next'.


* jk/branch-l-0-deprecation (2018-03-26) 3 commits
  (merged to 'next' on 2018-03-29 at 552cef7913)
 + branch: deprecate "-l" option
 + t: switch "branch -l" to "branch --create-reflog"
 + t3200: unset core.logallrefupdates when testing reflog creation
 (this branch is used by jk/branch-l-1-removal and jk/branch-l-2-reincarnation.)

 The "-l" option in "git branch -l" is an unfortunate short-hand for
 "--create-reflog", but many users, both old and new, somehow expect
 it to be something else, perhaps "--list".  This step deprecates
 the short-hand and warns about the future removal of the it when it
 is used.

 Will cook in 'next'.


* jk/branch-l-1-removal (2018-03-26) 1 commit
 - branch: drop deprecated "-l" option
 (this branch is used by jk/branch-l-2-reincarnation; uses jk/branch-l-0-deprecation.)

 Following the "git branch -l" deprecation, the short-hand is removed.

 Will keep in 'pu'.


* jk/branch-l-2-reincarnation (2018-03-26) 1 commit
 - branch: make "-l" a synonym for "--list"
 (this branch uses jk/branch-l-0-deprecation and jk/branch-l-1-removal.)

 Following the "git branch -l" removal, "-l" is resurrected as a
 short-hand for "--list".

 Will keep in 'pu'.


* jm/mem-pool (2018-03-27) 3 commits
  (merged to 'next' on 2018-03-29 at bfce05db6e)
 + Move reusable parts of memory pool into its own file
 + fast-import: introduce mem_pool type
 + fast-import: rename mem_pool type to mp_block

 An reusable "memory pool" implementation has been extracted from
 fast-import.c, which in turn has become the first user of the
 mem-pool API.

 Will cook in 'next'.


* js/runtime-prefix-windows (2018-03-27) 2 commits
 - mingw/msvc: use the new-style RUNTIME_PREFIX helper
 - exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 (this branch uses dj/runtime-prefix.)

 The Windows port was the first that allowed Git to be installed
 anywhere by having its components refer to each other with relative
 pathnames.  The recent dj/runtime-prefix topic extends the idea to
 other platforms, and its approach has been adopted back in the
 Windows port.

 Is this, together with the dj/runtime-prefix topic, ready for
 'next'?


* nd/combined-test-helper (2018-03-27) 36 commits
  (merged to 'next' on 2018-03-30 at ea73d57c30)
 + t/helper: merge test-write-cache into test-tool
 + t/helper: merge test-wildmatch into test-tool
 + t/helper: merge test-urlmatch-normalization into test-tool
 + t/helper: merge test-subprocess into test-tool
 + t/helper: merge test-submodule-config into test-tool
 + t/helper: merge test-string-list into test-tool
 + t/helper: merge test-strcmp-offset into test-tool
 + t/helper: merge test-sigchain into test-tool
 + t/helper: merge test-sha1-array into test-tool
 + t/helper: merge test-scrap-cache-tree into test-tool
 + t/helper: merge test-run-command into test-tool
 + t/helper: merge test-revision-walking into test-tool
 + t/helper: merge test-regex into test-tool
 + t/helper: merge test-ref-store into test-tool
 + t/helper: merge test-read-cache into test-tool
 + t/helper: merge test-prio-queue into test-tool
 + t/helper: merge test-path-utils into test-tool
 + t/helper: merge test-online-cpus into test-tool
 + t/helper: merge test-mktemp into test-tool
 + t/helper: merge (unused) test-mergesort into test-tool
 + t/helper: merge (unused) test-match-trees into test-tool
 + t/helper: merge test-index-version into test-tool
 + t/helper: merge test-hashmap into test-tool
 + t/helper: merge test-genrandom into test-tool
 + t/helper: merge test-example-decorate into test-tool
 + t/helper: merge test-dump-split-index into test-tool
 + t/helper: merge test-dump-cache-tree into test-tool
 + t/helper: merge test-drop-caches into test-tool
 + t/helper: merge (unused) test-delta into test-tool
 + t/helper: merge test-date into test-tool
 + t/helper: merge test-ctype into test-tool
 + t/helper: merge test-config into test-tool
 + t/helper: merge test-lazy-init-name-hash into test-tool
 + t/helper: merge test-sha1 into test-tool
 + t/helper: merge test-chmtime into test-tool
 + t/helper: add an empty test-tool program

 Small test-helper programs have been consolidated into a single
 binary.

 Will cook in 'next'.


* nd/parseopt-completion-more (2018-03-25) 8 commits
  (merged to 'next' on 2018-03-29 at 9007b165e2)
 + completion: use __gitcomp_builtin in _git_cherry
 + completion: use __gitcomp_builtin in _git_ls_tree
 + completion: delete option-only completion commands
 + completion: add --option completion for most builtin commands
 + completion: factor out _git_xxx calling code
 + completion: mention the oldest version we need to support
 + git.c: add hidden option --list-parseopt-builtins
 + git.c: move cmd_struct declaration up

 The mechanism to use parse-options API to automate the command line
 completion continues to get extended and polished.

 Will cook in 'next'.


* nd/trace-with-env (2018-03-25) 1 commit
  (merged to 'next' on 2018-03-29 at 6890e2c39b)
 + run-command: use strbuf_addstr() for adding a string to a strbuf

 Code cleanup.

 Will cook in 'next'.


* pk/test-avoid-pipe-hiding-exit-status (2018-03-28) 1 commit
  (merged to 'next' on 2018-03-30 at 4f3df09139)
 + test: avoid pipes in git related commands for test

 Test cleanup.

 Will cook in 'next'.


* ws/rebase-p (2018-03-23) 8 commits
  (merged to 'next' on 2018-03-29 at d20ae8510e)
 + rebase: remove merges_option and a blank line
 + rebase: remove unused code paths from git_rebase__interactive__preserve_merges
 + rebase: remove unused code paths from git_rebase__interactive
 + rebase: add and use git_rebase__interactive__preserve_merges
 + rebase: extract functions out of git_rebase__interactive
 + rebase: reindent function git_rebase__interactive
 + rebase: update invocation of rebase dot-sourced scripts
 + rebase-interactive: simplify pick_on_preserving_merges

 Code clean-up.

 Will cook in 'next'.


* yk/filter-branch-non-committish-refs (2018-03-25) 1 commit
  (merged to 'next' on 2018-03-29 at 8ac3806bcf)
 + filter-branch: fix errors caused by refs that point at non-committish

 when refs that do not point at committish are given, "git
 filter-branch" gave a misleading error messages.  This has been
 corrected.

 Will cook in 'next'.


* ys/bisect-object-id-missing-conversion-fix (2018-03-25) 1 commit
  (merged to 'next' on 2018-03-29 at 7d988b57d4)
 + bisect: use oid_to_hex() for converting object_id hashes to hex strings

 Code clean-up.

 Will cook in 'next'.


* ml/filter-branch-no-op-error (2018-03-15) 1 commit
  (merged to 'next' on 2018-03-15 at ba8ac48dec)
 + filter-branch: return 2 when nothing to rewrite

 "git filter-branch" learned to use a different exit code to allow
 the callers to tell the case where there was no new commits to
 rewrite from other error cases.

 Will cook in 'next'.


* ab/install-symlinks (2018-03-15) 3 commits
  (merged to 'next' on 2018-03-15 at 99d6bd6cb3)
 + Makefile: optionally symlink libexec/git-core binaries to bin/git
 + Makefile: add a gitexecdir_relative variable
 + Makefile: fix broken bindir_relative variable

 The build procedure learned to optionally use symbolic links
 (instead of hardlinks and copies) to install "git-foo" for built-in
 commands, whose binaries are all identical.

 Will cook in 'next'.


* tg/stash-untracked-with-pathspec-fix (2018-03-21) 4 commits
  (merged to 'next' on 2018-03-22 at 73c4bef74f)
 + stash: drop superfluos pathspec parameter
  (merged to 'next' on 2018-03-21 at 8f5b5ab131)
 + stash push -u: don't create empty stash
 + stash push: avoid printing errors
 + stash: fix nonsense pipeline

 "git stash push -u -- <pathspec>" gave an unnecessary and confusing
 error message when there was no tracked files that match the
 <pathspec>, which has been fixed.

 Will cook in 'next'.


* pw/rebase-keep-empty-fixes (2018-03-29) 3 commits
 - rebase: respect --no-keep-empty
 - rebase -i --keep-empty: don't prune empty commits
 - rebase --root: stop assuming squash_onto is unset
 (this branch is used by pw/rebase-signoff.)

 "git rebase --keep-empty" still removed an empty commit if the
 other side contained an empty commit (due to the "does an
 equivalent patch exist already?" check), which has been corrected.

 Will merge to 'next'.


* pw/rebase-signoff (2018-03-29) 4 commits
 - rebase --keep-empty: always use interactive rebase
 - rebase -p: error out if --signoff is given
 - rebase: extend --signoff support
 - Merge branch 'pw/rebase-keep-empty-fixes' into pw/rebase-signoff
 (this branch uses pw/rebase-keep-empty-fixes.)

 "git rebase" has learned to honor "--signoff" option when using
 backends other than "am" (but not "--preserve-merges").

 Will merge to 'next'.


* dj/runtime-prefix (2018-03-25) 3 commits
 - exec_cmd: RUNTIME_PREFIX on some POSIX systems
 - Makefile: add Perl runtime prefix support
 - Makefile: generate Perl header from template file
 (this branch is used by js/runtime-prefix-windows.)

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.

 Is this, together with the js/runtime-prefix-windows topic, ready
 for 'next'?


* ti/fetch-everything-local-optim (2018-03-14) 1 commit
  (merged to 'next' on 2018-03-15 at 2be87aa7a7)
 + fetch-pack.c: use oidset to check existence of loose object

 A "git fetch" from a repository with insane number of refs into a
 repository that is already up-to-date still wasted too many cycles
 making many lstat(2) calls to see if these objects at the tips
 exist as loose objects locally.  These lstat(2) calls are optimized
 away by enumerating all loose objects beforehand.

 It is unknown if the new strategy negatively affects existing use
 cases, fetching into a repository with many loose objects from a
 repository with small number of refs.

 Will cook in 'next'.


* ab/nuke-emacs-contrib (2018-03-13) 1 commit
  (merged to 'next' on 2018-03-15 at 13eb4e2d8b)
 + git{,-blame}.el: remove old bitrotting Emacs code

 The scripts in contrib/emacs/ have outlived their usefulness and
 have been removed.

 Will cook in 'next'.


* bc/object-id (2018-03-14) 36 commits
  (merged to 'next' on 2018-03-20 at f1800a33ff)
 + convert: convert to struct object_id
 + sha1_file: introduce a constant for max header length
 + Convert lookup_replace_object to struct object_id
 + sha1_file: convert read_sha1_file to struct object_id
 + sha1_file: convert read_object_with_reference to object_id
 + tree-walk: convert tree entry functions to object_id
 + streaming: convert istream internals to struct object_id
 + tree-walk: convert get_tree_entry_follow_symlinks internals to object_id
 + builtin/notes: convert static functions to object_id
 + builtin/fmt-merge-msg: convert remaining code to object_id
 + sha1_file: convert sha1_object_info* to object_id
 + Convert remaining callers of sha1_object_info_extended to object_id
 + packfile: convert unpack_entry to struct object_id
 + sha1_file: convert retry_bad_packed_offset to struct object_id
 + sha1_file: convert assert_sha1_type to object_id
 + builtin/mktree: convert to struct object_id
 + streaming: convert open_istream to use struct object_id
 + sha1_file: convert check_sha1_signature to struct object_id
 + sha1_file: convert read_loose_object to use struct object_id
 + builtin/index-pack: convert struct ref_delta_entry to object_id
 + archive: convert sha1_file_to_archive to struct object_id
 + archive: convert write_archive_entry_fn_t to object_id
 + builtin/mktag: convert to struct object_id
 + replace_object: convert struct replace_object to object_id
 + send-pack: convert remaining functions to struct object_id
 + http-walker: convert struct object_request to use struct object_id
 + Convert find_unique_abbrev* to struct object_id
 + wt-status: convert struct wt_status_state to object_id
 + strbuf: convert strbuf_add_unique_abbrev to use struct object_id
 + ref-filter: convert grab_objectname to struct object_id
 + tree: convert read_tree_recursive to struct object_id
 + resolve-undo: convert struct resolve_undo_info to object_id
 + cache-tree: convert remnants to struct object_id
 + cache-tree: convert write_*_as_tree to object_id
 + builtin/write-tree: convert to struct object_id
 + bulk-checkin: convert index_bulk_checkin to struct object_id
 (this branch is used by ds/bsearch-hash.)

 Conversion from uchar[20] to struct object_id continues.

 Will cook in 'next'.


* ma/shortlog-revparse (2018-03-15) 3 commits
  (merged to 'next' on 2018-03-15 at 2c2de7eb95)
 + shortlog: disallow left-over arguments outside repo
 + shortlog: add usage-string for stdin-reading
 + git-shortlog.txt: reorder usages

 "git shortlog cruft" aborted with a BUG message when run outside a
 Git repository.  The command has been taught to complain about
 extra and unwanted arguments on its command line instead in such a
 case.

 Will cook in 'next'.


* ab/pcre-v2 (2018-03-14) 3 commits
  (merged to 'next' on 2018-03-15 at e77b116903)
 + Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1
 + configure: detect redundant --with-libpcre & --with-libpcre1
 + configure: fix a regression in PCRE v1 detection

 Git can be built to use either v1 or v2 of the PCRE library, and so
 far, the build-time configuration USE_LIBPCRE=YesPlease instructed
 the build procedure to use v1, but now it means v2.  USE_LIBPCRE1
 and USE_LIBPCRE2 can be used to explicitly choose which version to
 use, as before.

 Will cook in 'next'.


* bb/git-gui-ssh-key-files (2018-03-02) 2 commits
 - Merge branch 'bb/ssh-key-files' of git-gui into bb/git-gui-ssh-key-files
 - git-gui: search for all current SSH key types

 "git gui" learned that "~/.ssh/id_ecdsa.pub" and
 "~/.ssh/id_ed25519.pub" are also possible SSH key files.


* bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
 - Merge branch 'bp/bind-kp-enter' of git-gui into bp/git-gui-bind-kp-enter
 - git-gui: bind CTRL/CMD+numpad ENTER to do_commit

 "git gui" performs commit upon CTRL/CMD+ENTER but the
 CTRL/CMD+KP_ENTER (i.e. enter key on the numpad) did not have the
 same key binding.  It now does.


* cb/git-gui-ttk-style (2018-03-05) 2 commits
 - Merge branch 'cb/ttk-style' of git-gui into cb/git-gui-ttk-style
 - git-gui: workaround ttk:style theme use

 "git gui" has been taught to work with old versions of tk (like
 8.5.7) that do not support "ttk::style theme use" as a way to query
 the current theme.


* nd/pack-objects-pack-struct (2018-03-26) 13 commits
 - pack-objects: reorder members to shrink struct object_entry
 - pack-objects: shrink delta_size field in struct object_entry
 - pack-objects: shrink size field in struct object_entry
 - pack-objects: clarify the use of object_entry::size
 - pack-objects: don't check size when the object is bad
 - pack-objects: shrink z_delta_size field in struct object_entry
 - pack-objects: refer to delta objects by index instead of pointer
 - pack-objects: move in_pack out of struct object_entry
 - pack-objects: move in_pack_pos out of struct object_entry
 - pack-objects: use bitfield for object_entry::depth
 - pack-objects: use bitfield for object_entry::dfs_state
 - pack-objects: turn type and in_pack_type to bitfields
 - pack-objects: a bit of document about struct object_entry

 "git pack-objects" needs to allocate tons of "struct object_entry"
 while doing its work, and shrinking its size helps the performance
 quite a bit.


* nd/repack-keep-pack (2018-03-26) 7 commits
 - pack-objects: show some progress when counting kept objects
 - gc --auto: exclude base pack if not enough mem to "repack -ad"
 - gc: handle a corner case in gc.bigPackThreshold
 - gc: add gc.bigPackThreshold config
 - gc: add --keep-largest-pack option
 - repack: add --keep-pack option
 - t7700: have closing quote of a test at the beginning of line

 "git gc" in a large repository takes a lot of time as it considers
 to repack all objects into one pack by default.  The command has
 been taught to pretend as if the largest existing packfile is
 marked with ".keep" so that it is left untouched while objects in
 other packs and loose ones are repacked.

 Reroll exists, but it seems to be still slushy.
 cf. <20180316192745.19557-1-pclouds@gmail.com>


* nd/worktree-prune (2018-03-15) 3 commits
  (merged to 'next' on 2018-03-20 at e2d9677b20)
 + worktree prune: improve prune logic when worktree is moved
 + worktree: delete dead code
 + gc.txt: more details about what gc does

 The way "git worktree prune" worked internally has been simplified,
 by assuming how "git worktree move" moves an existing worktree to a
 different place.

 Will cook in 'next'.


* pw/add-p-select (2018-03-16) 3 commits
  (merged to 'next' on 2018-03-30 at eae69f5ded)
 + add -p: optimize line selection for short hunks
 + add -p: allow line selection to be inverted
 + add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will cook in 'next'.


* ld/p4-unshelve (2018-02-22) 1 commit
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Will hold, perhaps drop and use format-change that uses a proper "diff".
 cf. <CAE5ih7_ooDMqVtTMoQ70s5XCkncr04HY0JkqSp1UmKQeG81oaA@mail.gmail.com>


* ps/contains-id-error-message (2018-03-22) 1 commit
  (merged to 'next' on 2018-03-22 at 3bb1dcd506)
 + parse-options: do not show usage upon invalid option value

 "git tag --contains no-such-commit" gave a full list of options
 after giving an error message.

 Will cook in 'next'.


* nd/remove-ignore-env-field (2018-03-23) 6 commits
  (merged to 'next' on 2018-03-23 at ba9d0f2565)
 + repository.h: add comment and clarify repo_set_gitdir
  (merged to 'next' on 2018-03-15 at 802b6ea1cb)
 + repository: delete ignore_env member
 + sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
 + repository.c: delete dead functions
 + repository.c: move env-related setup code back to environment.c
 + repository: initialize the_repository in main()
 (this branch is used by sb/object-store, sb/packfiles-in-repository and sb/submodule-move-nested.)

 Code clean-up for the "repository" abstraction.

 Will cook in 'next'.


* sb/object-store (2018-03-26) 27 commits
  (merged to 'next' on 2018-03-30 at 93e3475178)
 + sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
 + sha1_file: allow map_sha1_file to handle arbitrary repositories
 + sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
 + sha1_file: allow open_sha1_file to handle arbitrary repositories
 + sha1_file: allow stat_sha1_file to handle arbitrary repositories
 + sha1_file: allow sha1_file_name to handle arbitrary repositories
 + sha1_file: add repository argument to sha1_loose_object_info
 + sha1_file: add repository argument to map_sha1_file
 + sha1_file: add repository argument to map_sha1_file_1
 + sha1_file: add repository argument to open_sha1_file
 + sha1_file: add repository argument to stat_sha1_file
 + sha1_file: add repository argument to sha1_file_name
 + sha1_file: allow prepare_alt_odb to handle arbitrary repositories
 + sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
 + sha1_file: add repository argument to prepare_alt_odb
 + sha1_file: add repository argument to link_alt_odb_entries
 + sha1_file: add repository argument to read_info_alternates
 + sha1_file: add repository argument to link_alt_odb_entry
 + sha1_file: add raw_object_store argument to alt_odb_usable
 + pack: move approximate object count to object store
 + pack: move prepare_packed_git_run_once to object store
 + object-store: close all packs upon clearing the object store
 + object-store: move packed_git and packed_git_mru to object store
 + object-store: free alt_odb_list
 + object-store: move alt_odb_list and alt_odb_tail to object store
 + object-store: migrate alternates struct and functions from cache.h
 + repository: introduce raw object store field
 (this branch is used by sb/packfiles-in-repository and sb/submodule-move-nested; uses nd/remove-ignore-env-field.)

 Refactoring the internal global data structure to make it possible
 to open multiple repositories, work with and then close them.

 Rerolled by Duy on top of a separate preliminary clean-up topic.
 The resulting structure of the topics looked very sensible.

 Will cook in 'next'.


* sb/packfiles-in-repository (2018-03-26) 12 commits
  (merged to 'next' on 2018-03-30 at caa68db14d)
 + packfile: keep prepare_packed_git() private
 + packfile: allow find_pack_entry to handle arbitrary repositories
 + packfile: add repository argument to find_pack_entry
 + packfile: allow reprepare_packed_git to handle arbitrary repositories
 + packfile: allow prepare_packed_git to handle arbitrary repositories
 + packfile: allow prepare_packed_git_one to handle arbitrary repositories
 + packfile: add repository argument to reprepare_packed_git
 + packfile: add repository argument to prepare_packed_git
 + packfile: add repository argument to prepare_packed_git_one
 + packfile: allow install_packed_git to handle arbitrary repositories
 + packfile: allow rearrange_packed_git to handle arbitrary repositories
 + packfile: allow prepare_packed_git_mru to handle arbitrary repositories
 (this branch uses nd/remove-ignore-env-field and sb/object-store; is tangled with sb/submodule-move-nested.)

 Refactoring of the internal global data structure continues.

 Will cook in 'next'.


* ds/commit-graph (2018-03-14) 17 commits
 - SQUASH??? sparse fixes
 - commit-graph: implement "--additive" option
 - commit-graph: build graph from starting commits
 - commit-graph: read only from specific pack-indexes
 - commit: integrate commit graph with commit parsing
 - commit-graph: close under reachability
 - commit-graph: add core.commitGraph setting
 - commit-graph: implement git commit-graph read
 - commit-graph: implement 'git-commit-graph write'
 - commit-graph: implement write_commit_graph()
 - commit-graph: create git-commit-graph builtin
 - graph: add commit graph design document
 - commit-graph: add format document
 - csum-file: refactor finalize_hashfile() method
 - csum-file: rename hashclose() to finalize_hashfile()
 - Merge branch 'jk/cached-commit-buffer' into HEAD
 - Merge branch 'jt/binsearch-with-fanout' into HEAD

 Precompute and store information necessary for ancestry traversal
 in a separate file to optimize graph walking.

 Expecting a reroll.
 cf. <d76442f9-5f06-998b-8b2a-84b5ca118aaa@gmail.com>
 cf. <0c2f17fa-5c0e-9539-a081-7827a6678bf1@gmail.com>
 It seems that this topic is getting there.


* pc/submodule-helper-foreach (2018-02-02) 5 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: clarify the '$toplevel' variable documentation
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 Expecting a response to review comments
 e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>


* tg/worktree-add-existing-branch (2018-03-27) 6 commits
 - t2025: rename now outdated branch name
 - worktree: teach "add" to check out existing branches
 - worktree: factor out dwim_branch function
 - worktree: remove force_new_branch from struct add_opts
 - worktree: be clearer when "add" dwim-ery kicks in
 - worktree: improve message when creating a new worktree

 "git worktree add" learned to check out an existing branch.

 Is this ready for 'next'?


* js/rebase-recreate-merge (2018-02-23) 12 commits
  (merged to 'next' on 2018-03-15 at 3d1671756f)
 + rebase -i: introduce --recreate-merges=[no-]rebase-cousins
 + pull: accept --rebase=recreate to recreate the branch topology
 + sequencer: handle post-rewrite for merge commands
 + sequencer: make refs generated by the `label` command worktree-local
 + rebase: introduce the --recreate-merges option
 + rebase-helper --make-script: introduce a flag to recreate merges
 + sequencer: fast-forward merge commits, if possible
 + sequencer: introduce the `merge` command
 + sequencer: introduce new commands to reset the revision
 + git-rebase--interactive: clarify arguments
 + sequencer: make rearrange_squash() a bit more obvious
 + sequencer: avoid using errno clobbered by rollback_lock_file()

 "git rebase" learned "--recreate-merges" to transplant the whole
 topology of commit graph elsewhere.

 This serise has been reverted out of 'next', expecting that it will
 be replaced by a reroll on top of a couple of topics by Phillip.


* bw/protocol-v2 (2018-03-15) 35 commits
  (merged to 'next' on 2018-03-29 at be7f998712)
 + remote-curl: don't request v2 when pushing
 + remote-curl: implement stateless-connect command
 + http: eliminate "# service" line when using protocol v2
 + http: don't always add Git-Protocol header
 + http: allow providing extra headers for http requests
 + remote-curl: store the protocol version the server responded with
 + remote-curl: create copy of the service name
 + pkt-line: add packet_buf_write_len function
 + transport-helper: introduce stateless-connect
 + transport-helper: refactor process_connect_service
 + transport-helper: remove name parameter
 + connect: don't request v2 when pushing
 + connect: refactor git_connect to only get the protocol version once
 + fetch-pack: support shallow requests
 + fetch-pack: perform a fetch using v2
 + upload-pack: introduce fetch server command
 + push: pass ref prefixes when pushing
 + fetch: pass ref prefixes when fetching
 + ls-remote: pass ref prefixes when requesting a remote's refs
 + transport: convert transport_get_remote_refs to take a list of ref prefixes
 + transport: convert get_refs_list to take a list of ref prefixes
 + connect: request remote refs using v2
 + ls-refs: introduce ls-refs server command
 + serve: introduce git-serve
 + test-pkt-line: introduce a packet-line test helper
 + protocol: introduce enum protocol_version value protocol_v2
 + transport: store protocol version
 + connect: discover protocol version outside of get_remote_heads
 + connect: convert get_remote_heads to use struct packet_reader
 + transport: use get_refs_via_connect to get refs
 + upload-pack: factor out processing lines
 + upload-pack: convert to a builtin
 + pkt-line: add delim packet support
 + pkt-line: allow peeking a packet line without consuming it
 + pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.

 Will cook in 'next'.


* ls/checkout-encoding (2018-03-16) 10 commits
 - convert: add round trip check based on 'core.checkRoundtripEncoding'
 - convert: add tracing for 'working-tree-encoding' attribute
 - convert: check for detectable errors in UTF encodings
 - convert: add 'working-tree-encoding' attribute
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - utf8: teach same_encoding() alternative UTF encoding names
 - strbuf: add a case insensitive starts_with()
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).

 Expecting a reroll.
 cf. <B86BE818-A385-4E0C-9AE1-1E974471CEB9@gmail.com>


* en/rename-directory-detection (2018-02-27) 29 commits
  (merged to 'next' on 2018-03-06 at d42470f86e)
 + merge-recursive: ensure we write updates for directory-renamed file
 + merge-recursive: avoid spurious rename/rename conflict from dir renames
 + directory rename detection: new testcases showcasing a pair of bugs
 + merge-recursive: fix remaining directory rename + dirty overwrite cases
 + merge-recursive: fix overwriting dirty files involved in renames
 + merge-recursive: avoid clobbering untracked files with directory renames
 + merge-recursive: apply necessary modifications for directory renames
 + merge-recursive: when comparing files, don't include trees
 + merge-recursive: check for file level conflicts then get new name
 + merge-recursive: add computation of collisions due to dir rename & merging
 + merge-recursive: check for directory level conflicts
 + merge-recursive: add get_directory_renames()
 + merge-recursive: make a helper function for cleanup for handle_renames
 + merge-recursive: split out code for determining diff_filepairs
 + merge-recursive: make !o->detect_rename codepath more obvious
 + merge-recursive: fix leaks of allocated renames and diff_filepairs
 + merge-recursive: introduce new functions to handle rename logic
 + merge-recursive: move the get_renames() function
 + directory rename detection: tests for handling overwriting dirty files
 + directory rename detection: tests for handling overwriting untracked files
 + directory rename detection: miscellaneous testcases to complete coverage
 + directory rename detection: testcases exploring possibly suboptimal merges
 + directory rename detection: more involved edge/corner testcases
 + directory rename detection: testcases checking which side did the rename
 + directory rename detection: files/directories in the way of some renames
 + directory rename detection: partially renamed directory testcase/discussion
 + directory rename detection: testcases to avoid taking detection too far
 + directory rename detection: directory splitting testcases
 + directory rename detection: basic testcases

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.

 Will cook in 'next'.

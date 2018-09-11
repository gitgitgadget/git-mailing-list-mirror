Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88291F404
	for <e@80x24.org>; Tue, 11 Sep 2018 22:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeILDVw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 23:21:52 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35195 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILDVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 23:21:51 -0400
Received: by mail-wm0-f48.google.com with SMTP id o18-v6so263288wmc.0
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=A9ZIoN9K71gdk5IsTKrJIqh7Rerpstx4tLntnz5I3zw=;
        b=D3K5+EYQSM8+8607oavJXSn9v18fdbBIu1C/GqRURUJGhFL4C/M++xjfX+DXw8EH3v
         VYoeLV22DEyH9bBcz5xzP3e0OXMGKkxmjQnYWYW9jYFxCvdKO+R76BNvTFTXcm498/AB
         m2gCE2q+iKuO71NNMXYxzWILF/T41RaXcqH5qcS3VL2Nj+CZkcW+2wjJJ9pUt3EbMbfI
         VaohsupI0sphc4A2384LcjUSeKgAqPGngJXaTp1QRbtl+vCl+pC+uETz43exKCXPmRwJ
         m3Yv1ee5shWrBvdLsaO8xAwPuC8mD550u62S2+QUksMcXJyKIEhUWp8ratFY7iYQgLqV
         S0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=A9ZIoN9K71gdk5IsTKrJIqh7Rerpstx4tLntnz5I3zw=;
        b=WKgr8Yiwhfe41gzNw8AuCK/pJh3ecjikjv005AV36Y25fBfzm+PsWhh5cPF9ZlaRyY
         I8SKl2+QYZKqy9ioh22bVSVye6uavpxaRylrYeHktqoPYiurOQi+k5PAxwG5pXZJ1p/2
         m5LdoNdrb/KlCMEF5MLhzVI+2rZofo2jxyxbheNKPyMf24O308diRkUrps61LSOra0ML
         afC0qDG3jlNb62fHisMhdJlD9iQxkuK9ghrc5wsw2jS+8RMIy1nm8VTzUqf5H9s8gl7E
         UHUhsb5pwuiXBKEF59Hf2XPr9S40/VNo8vSvpRLJN8mO98ifkRybs04/+f08sYi+8MaW
         QJYA==
X-Gm-Message-State: APzg51BomsYtwC71lTocVCd4oZSOixw6tmSVmYIlUob4NwmRuTrfS4wL
        gw7e2hVpXf19Pi4SsKinBnMhdKKL
X-Google-Smtp-Source: ANB0VdbZobYRJPcDoUW1joQJHthzQm9f3mBg4dtISagT6FGNw+YL/8lQQC4zs5i01ZICU4C2moaRfA==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr2714977wma.101.1536704422754;
        Tue, 11 Sep 2018 15:20:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c10-v6sm38425046wrb.17.2018.09.11.15.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 15:20:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2018, #02; Tue, 11)
X-master-at: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
X-next-at: e8095fc6352aeb4e2deee7c9f2e1aeda5253cc31
Date:   Tue, 11 Sep 2018 15:20:19 -0700
Message-ID: <xmqqsh2fn0bg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Git 2.19 is out.  The tip of 'next' has not been rewound yet; it is
a rare occasion for topics that would want to restart from a clean
slate to do so, so please raise your hand if you think that a topic
that is in 'next' should be ejected and given a chance to restart.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ab/commit-graph-progress (2018-09-11) 2 commits
 - commit-graph verify: add progress output
 - commit-graph write: add progress output


* bw/protocol-v2 (2018-09-10) 1 commit
 - config: document value 2 for protocol.version


* en/double-semicolon-fix (2018-09-05) 1 commit
 - Remove superfluous trailing semicolons


* en/rerere-multi-stage-1-fix (2018-09-11) 2 commits
 - rerere: avoid buffer overrun
 - t4200: demonstrate rerere segfault on specially crafted merge


* jc/wt-status-state-cleanup (2018-09-07) 1 commit
 - WIP: roll wt_status_state into wt_status and populate in the collect phase
 (this branch uses ss/wt-status-committable.)


* jk/dev-build-format-security (2018-09-11) 1 commit
 - config.mak.dev: add -Wformat-security


* jk/reopen-tempfile-truncate (2018-09-05) 1 commit
 - reopen_tempfile(): truncate opened file


* jn/http-backend-content-length (2018-09-11) 2 commits
 - SQUASH???? perhaps after reflowing
 - http-backend: treat empty CONTENT_LENGTH as zero


* js/mingw-o-append (2018-09-11) 2 commits
 - mingw: fix mingw_open_append to work with named pipes
 - t0051: test GIT_TRACE to a windows named pipe


* mk/http-backend-content-length (2018-09-11) 1 commit
  (merged to 'next' on 2018-09-11 at e8095fc635)
 + http-backend test: make empty CONTENT_LENGTH test more realistic


* nd/test-tool (2018-09-11) 6 commits
 - Makefile: add a hint about TEST_BUILTINS_OBJS
 - t/helper: merge test-dump-fsmonitor into test-tool
 - t/helper: merge test-parse-options into test-tool
 - t/helper: merge test-pkt-line into test-tool
 - t/helper: merge test-dump-untracked-cache into test-tool
 - t/helper: keep test-tool command list sorted


* sb/diff-color-move-more (2018-09-11) 1 commit
 - diff: fix --color-moved-ws=allow-indentation-change


* sb/string-list-remove-unused (2018-09-11) 1 commit
 - string-list: remove unused function print_string_list


* sg/t3701-tighten-trace (2018-09-11) 1 commit
 - t3701-add-interactive: tighten the check of trace output


* ss/wt-status-committable (2018-09-07) 4 commits
 - wt-status.c: set the committable flag in the collect phase
 - t7501: add test of "commit --dry-run --short"
 - wt-status: rename commitable to committable
 - wt-status.c: move has_unmerged earlier in the file
 (this branch is used by jc/wt-status-state-cleanup.)


* tz/t5551-with-curl-7.61.1 (2018-09-11) 1 commit
 - t5551-http-fetch-smart.sh: sort cookies before comparing

--------------------------------------------------
[Stalled]

* sl/commit-dry-run-with-short-output-fix (2018-07-30) 4 commits
 . commit: fix exit code when doing a dry run
 . wt-status: teach wt_status_collect about merges in progress
 . wt-status: rename commitable to committable
 . t7501: add coverage for flags which imply dry runs

 "git commit --dry-run" gave a correct exit status even during a
 conflict resolution toward a merge, but it did not with the
 "--short" option, which has been corrected.

 Seems to break 7512, 3404 and 7060 in 'pu'.


* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Will discard and wait for a cleaned-up rewrite.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>


* hn/bisect-first-parent (2018-04-21) 1 commit
 - bisect: create 'bisect_flags' parameter in find_bisection()
 (this branch is used by tb/bisect-first-parent.)

 Preliminary code update to allow passing more flags down the
 bisection codepath in the future.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


* pb/bisect-helper-2 (2018-07-23) 8 commits
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

 I just rebased the topic to a newer base as it did not build
 standalone with the base I originally queued the topic on, but
 otherwise there is no update to address any of the review comments
 in the thread above---we are still waiting for a reroll.


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

* ab/fetch-tags-noclobber (2018-08-31) 9 commits
 - fetch: stop clobbering existing tags without --force
 - fetch: document local ref updates with/without --force
 - push doc: correct lies about how push refspecs work
 - push doc: move mention of "tag <tag>" later in the prose
 - push doc: remove confusing mention of remote merger
 - fetch tests: add a test for clobbering tag behavior
 - push tests: use spaces in interpolated string
 - push tests: make use of unused $1 in test description
 - fetch: change "branch" to "reference" in --force -h output

 The rules used by "git push" and "git fetch" to determine if a ref
 can or cannot be updated were inconsistent; specifically, fetching
 to update existing tags were allowed even though tags are supposed
 to be unmoving anchoring points.  "git fetch" was taught to forbid
 updates to existing tags without the "--force" option.

 Will merge to and cook in 'next'.
 This is a backward incompatible change but in a good way; it may
 still need to be treated carefully.


* es/worktree-forced-ops-fix (2018-09-05) 10 commits
 - doc-diff: force worktree add
 - worktree: delete .git/worktrees if empty after 'remove'
 - worktree: teach 'remove' to override lock when --force given twice
 - worktree: teach 'move' to override lock when --force given twice
 - worktree: teach 'add' to respect --force for registered but missing path
 - worktree: disallow adding same path multiple times
 - worktree: prepare for more checks of whether path can become worktree
 - worktree: generalize delete_git_dir() to reduce code duplication
 - worktree: move delete_git_dir() earlier in file for upcoming new callers
 - worktree: don't die() in library function find_worktree()

 Fix a bug in which the same path could be registered under multiple
 worktree entries if the path was missing (for instance, was removed
 manually).  Also, as a convenience, expand the number of cases in
 which --force is applicable.

 Will merge to 'next'.


* jk/patch-corrupted-delta-fix (2018-08-30) 6 commits
 - t5303: use printf to generate delta bases
 - patch-delta: handle truncated copy parameters
 - patch-delta: consistently report corruption
 - patch-delta: fix oob read
 - t5303: test some corrupt deltas
 - test-delta: read input into a heap buffer

 Malformed or crafted data in packstream can make our code attempt
 to read or write past the allocated buffer and abort, instead of
 reporting an error, which has been fixed.

 Will merge to 'next'.


* jk/pack-objects-with-bitmap-fix (2018-09-04) 4 commits
 - pack-bitmap: drop "loaded" flag
 - traverse_bitmap_commit_list(): don't free result
 - t5310: test delta reuse with bitmaps
 - bitmap_has_sha1_in_uninteresting(): drop BUG check
 (this branch uses jk/pack-delta-reuse-with-bitmap.)

 Hotfix of the base topic.  It may not be a bad idea to squash these
 in when the next development cycle opens.


* js/rebase-i-autosquash-fix (2018-09-04) 2 commits
 - rebase -i: be careful to wrap up fixup/squash chains
 - rebase -i --autosquash: demonstrate a problem skipping the last squash

 "git rebase -i" did not clear the state files correctly when a run
 of "squash/fixup" is aborted and then the user manually amended the
 commit instead, which has been corrected.

 Will merge to 'next'.


* nd/bisect-show-list-fix (2018-09-04) 1 commit
 - bisect.c: make show_list() build again

 Debugging aid update.

 Will merge to and cook in 'next'.


* nd/optim-reading-index-v4 (2018-09-04) 1 commit
 - read-cache.c: optimize reading index format v4

 The v4 format of the index file uses prefix compression to store
 the pathnames to save file size.  The codepath to read such a file
 has been optimized.

 Will merge to and cook in 'next'.


* sg/doc-trace-appends (2018-09-04) 1 commit
 - Documentation/git.txt: clarify that GIT_TRACE=/path appends

 Docfix.

 Will merge to 'next'.


* ds/format-commit-graph-docs (2018-08-21) 2 commits
 - commit-graph.txt: improve formatting for asciidoc
 - Docs: Add commit-graph tech docs to Makefile

 Design docs for the commit-graph machinery is now made into HTML as
 well as text.


* jk/diff-rendered-docs (2018-08-31) 5 commits
 - doc/Makefile: drop doc-diff worktree and temporary files on "make clean"
 - doc-diff: add --clean mode to remove temporary working gunk
 - doc-diff: fix non-portable 'man' invocation
 - doc-diff: always use oids inside worktree
  (merged to 'next' on 2018-08-22 at dd7a2b71cd)
 + SubmittingPatches: mention doc-diff

 Dev doc update.

 Will merge to 'next'.


* jk/pack-delta-reuse-with-bitmap (2018-08-21) 6 commits
  (merged to 'next' on 2018-08-22 at fc50b59dab)
 + pack-objects: reuse on-disk deltas for thin "have" objects
 + pack-bitmap: save "have" bitmap from walk
 + t/perf: add perf tests for fetches from a bitmapped server
 + t/perf: add infrastructure for measuring sizes
 + t/perf: factor out percent calculations
 + t/perf: factor boilerplate out of test_perf
 (this branch is used by jk/pack-objects-with-bitmap-fix.)

 When creating a thin pack, which allows objects to be made into a
 delta against another object that is not in the resulting pack but
 is known to be present on the receiving end, the code learned to
 take advantage of the reachability bitmap; this allows the server
 to send a delta against a base beyond the "boundary" commit.

 Will cook in 'next'.


* jk/rev-list-stdin-noop-is-ok (2018-08-22) 1 commit
  (merged to 'next' on 2018-08-27 at d5916f7bc1)
 + rev-list: make empty --stdin not an error

 "git rev-list --stdin </dev/null" used to be an error; it now shows
 no output without an error.  "git rev-list --stdin --default HEAD"
 still falls back to the given default when nothing is given on the
 standard input.

 Will cook in 'next'.


* js/rebase-in-c-5.5-work-with-rebase-i-in-c (2018-09-06) 2 commits
 - builtin rebase: prepare for builtin rebase -i
 - Merge branch 'ag/rebase-i-in-c' into js/rebase-in-c-5.5-work-with-rebase-i-in-c
 (this branch is used by pk/rebase-in-c-6-final; uses ag/rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test.)

 "rebase" that has been rewritten learns the new calling convention
 used by "rebase -i" that was rewritten in C, tying the loose end
 between two GSoC topics that stomped on each other's toes.


* jk/trailer-fixes (2018-08-23) 8 commits
  (merged to 'next' on 2018-08-27 at 93b671b8c6)
 + append_signoff: use size_t for string offsets
 + sequencer: ignore "---" divider when parsing trailers
 + pretty, ref-filter: format %(trailers) with no_divider option
 + interpret-trailers: allow suppressing "---" divider
 + interpret-trailers: tighten check for "---" patch boundary
 + trailer: pass process_trailer_opts to trailer_info_get()
 + trailer: use size_t for iterating trailer list
 + trailer: use size_t for string offsets

 "git interpret-trailers" and its underlying machinery had a buggy
 code that attempted to ignore patch text after commit log message,
 which triggered in various codepaths that will always get the log
 message alone and never get such an input.

 Will cook in 'next'.


* tg/rerere-doc-updates (2018-08-29) 2 commits
  (merged to 'next' on 2018-08-31 at ce4fef1a97)
 + rerere: add note about files with existing conflict markers
 + rerere: mention caveat about unmatched conflict markers
 (this branch uses tg/rerere.)

 Clarify a part of technical documentation for rerere.

 Will cook in 'next'.


* ds/commit-graph-tests (2018-08-29) 1 commit
 - commit-graph: define GIT_TEST_COMMIT_GRAPH

 We can now optionally run tests with commit-graph enabled.

 Will merge to 'next'.


* jk/cocci (2018-08-29) 9 commits
  (merged to 'next' on 2018-08-31 at 914b4f17ce)
 + show_dirstat: simplify same-content check
 + read-cache: use oideq() in ce_compare functions
 + convert hashmap comparison functions to oideq()
 + convert "hashcmp() != 0" to "!hasheq()"
 + convert "oidcmp() != 0" to "!oideq()"
 + convert "hashcmp() == 0" to hasheq()
 + convert "oidcmp() == 0" to oideq()
 + introduce hasheq() and oideq()
 + coccinelle: use <...> for function exclusion

 spatch transformation to replace boolean uses of !hashcmp() to
 newly introduced oideq() is added, and applied, to regain
 performance lost due to support of multiple hash algorithms.

 Will cook in 'next'.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* rs/mailinfo-format-flowed (2018-08-29) 1 commit
  (merged to 'next' on 2018-08-31 at 9e8b92176c)
 + mailinfo: support format=flowed

 "git mailinfo" used in "git am" learned to make a best-effort
 recovery of a patch corrupted by MUA that sends text/plain with
 format=flawed option.

 Will cook in 'next'.


* sb/submodule-move-head-with-corruption (2018-08-28) 2 commits
 - submodule.c: warn about missing submodule git directories
 - t2013: add test for missing but active submodule

 cf. <20180905191849.GB120842@aiede.svl.corp.google.com>


* tg/conflict-marker-size (2018-08-29) 1 commit
  (merged to 'next' on 2018-08-31 at 12099161f0)
 + .gitattributes: add conflict-marker-size for relevant files

 Developer aid.

 Will cook in 'next'.


* ts/doc-build-manpage-xsl-quietly (2018-08-29) 1 commit
  (merged to 'next' on 2018-08-31 at 7527e0f8d3)
 + Documentation/Makefile: make manpage-base-url.xsl generation quieter

 Build tweak.

 Will cook in 'next'.


* bp/checkout-new-branch-optim (2018-08-16) 1 commit
  (merged to 'next' on 2018-08-27 at e69bfd115f)
 + checkout: optimize "git checkout -b <new_branch>"

 "git checkout -b newbranch [HEAD]" should not have to do as much as
 checking out a commit different from HEAD.  An attempt is made to
 optimize this special case.

 Will cook in 'next'.


* ao/submodule-wo-gitmodules-checked-out (2018-08-14) 7 commits
 - submodule: support reading .gitmodules even when it's not checked out
 - t7506: clean up .gitmodules properly before setting up new scenario
 - submodule: use the 'submodule--helper config' command
 - submodule--helper: add a new 'config' subcommand
 - t7411: be nicer to future tests and really clean things up
 - submodule: factor out a config_set_in_gitmodules_file_gently function
 - submodule: add a print_config_from_gitmodules() helper

 The submodule support has been updated to read from the blob at
 HEAD:.gitmodules when the .gitmodules file is missing from the
 working tree.

 Expecting a reroll.

 I find the design a bit iffy in that our usual "missing in the
 working tree?  let's use the latest blob" fallback is to take it
 from the index, not from the HEAD.


* bw/submodule-name-to-dir (2018-08-10) 2 commits
  (merged to 'next' on 2018-08-22 at c17f83be24)
 + submodule: munge paths to submodule git directories
 + submodule: create helper to build paths to submodule gitdirs

 In modern repository layout, the real body of a cloned submodule
 repository is held in .git/modules/ of the superproject, indexed by
 the submodule name.  URLencode the submodule name before computing
 the name of the directory to make sure they form a flat namespace.

 Expecting further work on the topic.
 cf. <CAGZ79kYnbjaPoWdda0SM_-_X77mVyYC7JO61OV8nm2yj3Q1OvQ@mail.gmail.com>


* cc/delta-islands (2018-08-16) 7 commits
  (merged to 'next' on 2018-08-27 at cf3d7bd93f)
 + pack-objects: move 'layer' into 'struct packing_data'
 + pack-objects: move tree_depth into 'struct packing_data'
 + t5320: tests for delta islands
 + repack: add delta-islands support
 + pack-objects: add delta-islands support
 + pack-objects: refactor code into compute_layer_order()
 + Add delta-islands.{c,h}

 Lift code from GitHub to restrict delta computation so that an
 object that exists in one fork is not made into a delta against
 another object that does not appear in the same forked repository.

 Will cook in 'next'.


* md/filter-trees (2018-09-04) 7 commits
 - list-objects-filter: implement filter tree:0
 - list-objects-filter: use BUG rather than die
 - revision: mark non-user-given objects instead
 - rev-list: handle missing tree objects properly
 - list-objects: always parse trees gently
 - list-objects: refactor to process_tree_contents
 - list-objects: store common func args in struct

 The "rev-list --filter" feature learned to exclude all trees via
 "tree:0" filter.

 Will merge to 'next'.


* ng/status-i-short-for-ignored (2018-08-09) 1 commit
 - status: -i shorthand for --ignored command line option

 "git status --ignored" gained a shorthand "git status -i".

 What's the list opinion on this one?  It is Meh to me, but
 obviously the author cared enough to write a patch, so...


* pk/rebase-in-c-2-basic (2018-09-06) 11 commits
 - builtin rebase: support `git rebase <upstream> <switch-to>`
 - builtin rebase: only store fully-qualified refs in `options.head_name`
 - builtin rebase: start a new rebase only if none is in progress
 - builtin rebase: support --force-rebase
 - builtin rebase: try to fast forward when possible
 - builtin rebase: require a clean worktree
 - builtin rebase: support the `verbose` and `diffstat` options
 - builtin rebase: support --quiet
 - builtin rebase: handle the pre-rebase hook and --no-verify
 - builtin rebase: support `git rebase --onto A...B`
 - builtin rebase: support --onto
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c.)


* pk/rebase-in-c-3-acts (2018-09-06) 7 commits
 - builtin rebase: stop if `git am` is in progress
 - builtin rebase: actions require a rebase in progress
 - builtin rebase: support --edit-todo and --show-current-patch
 - builtin rebase: support --quit
 - builtin rebase: support --abort
 - builtin rebase: support --skip
 - builtin rebase: support --continue
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c and pk/rebase-in-c-2-basic.)


* pk/rebase-in-c-4-opts (2018-09-06) 18 commits
 - builtin rebase: support --root
 - builtin rebase: add support for custom merge strategies
 - builtin rebase: support `fork-point` option
 - merge-base --fork-point: extract libified function
 - builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
 - builtin rebase: support `--allow-empty-message` option
 - builtin rebase: support `--exec`
 - builtin rebase: support `--autostash` option
 - builtin rebase: support `-C` and `--whitespace=<type>`
 - builtin rebase: support `--gpg-sign` option
 - builtin rebase: support `--autosquash`
 - builtin rebase: support `keep-empty` option
 - builtin rebase: support `ignore-date` option
 - builtin rebase: support `ignore-whitespace` option
 - builtin rebase: support --committer-date-is-author-date
 - builtin rebase: support --rerere-autoupdate
 - builtin rebase: support --signoff
 - builtin rebase: allow selecting the rebase "backend"
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic and pk/rebase-in-c-3-acts.)


* pk/rebase-in-c-5-test (2018-09-06) 6 commits
 - builtin rebase: error out on incompatible option/mode combinations
 - builtin rebase: use no-op editor when interactive is "implied"
 - builtin rebase: show progress when connected to a terminal
 - builtin rebase: fast-forward to onto if it is a proper descendant
 - builtin rebase: optionally pass custom reflogs to reset_head()
 - builtin rebase: optionally auto-detect the upstream
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts and pk/rebase-in-c-4-opts.)


* pk/rebase-in-c-6-final (2018-09-06) 1 commit
 - rebase: default to using the builtin rebase
 (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test.)


* ps/stash-in-c (2018-08-31) 20 commits
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert `stash--helper.c` into `stash.c`
 - stash: convert save to builtin
 - stash: make push -q quiet
 - stash: convert push to builtin
 - stash: convert create to builtin
 - stash: convert store to builtin
 - stash: mention options in `show` synopsis
 - stash: convert show to builtin
 - stash: convert list to builtin
 - stash: convert pop to builtin
 - stash: convert branch to builtin
 - stash: convert drop and clear to builtin
 - stash: convert apply to builtin
 - stash: add tests for `git stash show` config
 - stash: rename test cases to be more descriptive
 - stash: update test cases conform to coding guidelines
 - stash: improve option parsing test coverage
 - sha1-name.c: add `get_oidf()` which acts like `get_oid()`


* nd/clone-case-smashing-warning (2018-08-17) 1 commit
  (merged to 'next' on 2018-08-22 at eedae40a8d)
 + clone: report duplicate entries on case-insensitive filesystems

 Running "git clone" against a project that contain two files with
 pathnames that differ only in cases on a case insensitive
 filesystem would result in one of the files lost because the
 underlying filesystem is incapable of holding both at the same
 time.  An attempt is made to detect such a case and warn.

 Will cook in 'next'.


* nd/unpack-trees-with-cache-tree (2018-08-27) 8 commits
  (merged to 'next' on 2018-08-27 at b1d841d034)
 + Document update for nd/unpack-trees-with-cache-tree
  (merged to 'next' on 2018-08-22 at 138b902673)
 + cache-tree: verify valid cache-tree in the test suite
 + unpack-trees: add missing cache invalidation
 + unpack-trees: reuse (still valid) cache-tree from src_index
 + unpack-trees: reduce malloc in cache-tree walk
 + unpack-trees: optimize walking same trees with cache-tree
 + unpack-trees: add performance tracing
 + trace.h: support nested performance tracing

 The unpack_trees() API used in checking out a branch and merging
 walks one or more trees along with the index.  When the cache-tree
 in the index tells us that we are walking a tree whose flattened
 contents is known (i.e. matches a span in the index), as linearly
 scanning a span in the index is much more efficient than having to
 open tree objects recursively and listing their entries, the walk
 can be optimized, which is done in this topic.

 Will cook in 'next'.


* sb/range-diff-colors (2018-08-20) 11 commits
  (merged to 'next' on 2018-08-22 at eb7ed4fca3)
 + range-diff: indent special lines as context
 + range-diff: make use of different output indicators
 + diff.c: add --output-indicator-{new, old, context}
 + diff.c: rewrite emit_line_0 more understandably
 + diff.c: omit check for line prefix in emit_line_0
 + diff: use emit_line_0 once per line
 + diff.c: add set_sign to emit_line_0
 + diff.c: reorder arguments for emit_line_ws_markup
 + diff.c: simplify caller of emit_line_0
 + t3206: add color test for range-diff --dual-color
 + test_decode_color: understand FAINT and ITALIC

 The color output support for recently introduced "range-diff"
 command got tweaked a bit.

 Will cook in 'next'.


* sg/t1404-update-ref-test-timeout (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-22 at f3cd37b5ea)
 + t1404: increase core.packedRefsTimeout to avoid occasional test failure

 An attempt to unflake a test a bit.

 Will cook in 'next'.


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will hold.
 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.


* ds/commit-graph-with-grafts (2018-08-21) 8 commits
 - commit-graph: close_commit_graph before shallow walk
 - commit-graph: not compatible with uninitialized repo
 - commit-graph: not compatible with grafts
 - commit-graph: not compatible with replace objects
 - test-repository: properly init repo
 - commit-graph: update design document
 - refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
 - refs.c: migrate internal ref iteration to pass thru repository argument

 The recently introduced commit-graph auxiliary data is incompatible
 with mechanisms such as replace & grafts that "breaks" immutable
 nature of the object reference relationship.  Disable optimizations
 based on its use (and updating existing commit-graph) when these
 incompatible features are in use in the repository.

 Replaced with a newer version.


* ds/reachable (2018-08-28) 19 commits
  (merged to 'next' on 2018-08-28 at b1634b371d)
 + commit-reach: correct accidental #include of C file
  (merged to 'next' on 2018-08-22 at 17f3275afb)
 + commit-reach: use can_all_from_reach
 + commit-reach: make can_all_from_reach... linear
 + commit-reach: replace ref_newer logic
 + test-reach: test commit_contains
 + test-reach: test can_all_from_reach_with_flags
 + test-reach: test reduce_heads
 + test-reach: test get_merge_bases_many
 + test-reach: test is_descendant_of
 + test-reach: test in_merge_bases
 + test-reach: create new test tool for ref_newer
 + commit-reach: move can_all_from_reach_with_flags
 + upload-pack: generalize commit date cutoff
 + upload-pack: refactor ok_to_give_up()
 + upload-pack: make reachable() more generic
 + commit-reach: move commit_contains from ref-filter
 + commit-reach: move ref_newer from remote.c
 + commit.h: remove method declarations
 + commit-reach: move walk methods from commit.c

 The code for computing history reachability has been shuffled,
 obtained a bunch of new tests to cover them, and then being
 improved.

 Will cook in 'next'.


* es/format-patch-interdiff (2018-07-23) 6 commits
  (merged to 'next' on 2018-08-31 at 63927e0227)
 + format-patch: allow --interdiff to apply to a lone-patch
 + log-tree: show_log: make commentary block delimiting reusable
 + interdiff: teach show_interdiff() to indent interdiff
 + format-patch: teach --interdiff to respect -v/--reroll-count
 + format-patch: add --interdiff option to embed diff in cover letter
 + format-patch: allow additional generated content in make_cover_letter()
 (this branch is used by es/format-patch-rangediff.)

 "git format-patch" learned a new "--interdiff" option to explain
 the difference between this version and the previous atttempt in
 the cover letter (or after the tree-dashes as a comment).

 Will cook in 'next'.


* es/format-patch-rangediff (2018-08-14) 10 commits
  (merged to 'next' on 2018-08-31 at 65627afece)
 + format-patch: allow --range-diff to apply to a lone-patch
 + format-patch: add --creation-factor tweak for --range-diff
 + format-patch: teach --range-diff to respect -v/--reroll-count
 + format-patch: extend --range-diff to accept revision range
 + format-patch: add --range-diff option to embed diff in cover letter
 + range-diff: relieve callers of low-level configuration burden
 + range-diff: publish default creation factor
 + range-diff: respect diff_option.file rather than assuming 'stdout'
 + Merge branch 'es/format-patch-interdiff' into es/format-patch-rangediff
 + Merge branch 'js/range-diff' into es/format-patch-rangediff
 (this branch uses es/format-patch-interdiff.)

 "git format-patch" learned a new "--range-diff" option to explain
 the difference between this version and the previous attempt in
 the cover letter (or after the tree-dashes as a comment).

 Will cook in 'next'.


* jn/gc-auto (2018-07-17) 3 commits
 - gc: do not return error for prior errors in daemonized mode
 - gc: exit with status 128 on failure
 - gc: improve handling of errors reading gc.log

 "gc --auto" ended up calling exit(-1) upon error, which has been
 corrected to use exit(1).  Also the error reporting behaviour when
 daemonized has been updated to exit with zero status when stopping
 due to a previously discovered error (which implies there is no
 point running gc to improve the situation); we used to exit with
 failure in such a case.

 What's the donness of this one?
 cf. <20180717201348.GD26218@sigill.intra.peff.net>


* sb/submodule-update-in-c (2018-08-14) 7 commits
  (merged to 'next' on 2018-08-17 at 23c81e5ff7)
 + submodule--helper: introduce new update-module-mode helper
 + submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
 + builtin/submodule--helper: factor out method to update a single submodule
 + builtin/submodule--helper: store update_clone information in a struct
 + builtin/submodule--helper: factor out submodule updating
 + git-submodule.sh: rename unused variables
 + git-submodule.sh: align error reporting for update mode to use path

 "git submodule update" is getting rewritten piece-by-piece into C.

 Will cook in 'next'.


* tg/rerere (2018-08-06) 11 commits
  (merged to 'next' on 2018-08-17 at 919a958cdc)
 + rerere: recalculate conflict ID when unresolved conflict is committed
 + rerere: teach rerere to handle nested conflicts
 + rerere: return strbuf from handle path
 + rerere: factor out handle_conflict function
 + rerere: only return whether a path has conflicts or not
 + rerere: fix crash with files rerere can't handle
 + rerere: add documentation for conflict normalization
 + rerere: mark strings for translation
 + rerere: wrap paths in output in sq
 + rerere: lowercase error messages
 + rerere: unify error messages when read_cache fails
 (this branch is used by tg/rerere-doc-updates.)

 Fixes to "git rerere" corner cases, especially when conflict
 markers cannot be parsed in the file.

 Will cook in 'next'.


* ag/rebase-i-in-c (2018-08-29) 20 commits
 - rebase -i: move rebase--helper modes to rebase--interactive
 - rebase -i: remove git-rebase--interactive.sh
 - rebase--interactive2: rewrite the submodes of interactive rebase in C
 - rebase -i: implement the main part of interactive rebase as a builtin
 - rebase -i: rewrite init_basic_state() in C
 - rebase -i: rewrite write_basic_state() in C
 - rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
 - rebase -i: implement the logic to initialize $revisions in C
 - rebase -i: remove unused modes and functions
 - rebase -i: rewrite complete_action() in C
 - t3404: todo list with commented-out commands only aborts
 - sequencer: change the way skip_unnecessary_picks() returns its result
 - sequencer: refactor append_todo_help() to write its message to a buffer
 - rebase -i: rewrite checkout_onto() in C
 - rebase -i: rewrite setup_reflog_action() in C
 - sequencer: add a new function to silence a command, except if it fails
 - rebase -i: rewrite the edit-todo functionality in C
 - editor: add a function to launch the sequence editor
 - rebase -i: rewrite append_todo_help() in C
 - sequencer: make three functions and an enum from sequencer.c public
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Rewrite of the remaining "rebase -i" machinery in C.


* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.


* pk/rebase-in-c (2018-08-06) 3 commits
 - builtin/rebase: support running "git rebase <upstream>"
 - rebase: refactor common shell functions into their own file
 - rebase: start implementing it as a builtin
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

 Rewrite of the "rebase" machinery in C.


* jk/branch-l-1-repurpose (2018-08-30) 2 commits
  (merged to 'next' on 2018-08-31 at cfa73bbfcb)
 + doc/git-branch: remove obsolete "-l" references
  (merged to 'next' on 2018-08-08 at d2a08dd08e)
 + branch: make "-l" a synonym for "--list"

 Updated plan to repurpose the "-l" option to "git branch".

 Will cook in 'next'.


* ds/multi-pack-index (2018-08-20) 33 commits
  (merged to 'next' on 2018-08-21 at d15e8cadd4)
 + pack-objects: consider packs in multi-pack-index
 + midx: test a few commands that use get_all_packs
 + treewide: use get_all_packs
 + packfile: add all_packs list
 + midx: fix bug that skips midx with alternates
 + midx: stop reporting garbage
 + midx: mark bad packed objects
 + multi-pack-index: store local property
 + multi-pack-index: provide more helpful usage info
 + Sync 'ds/multi-pack-index' to v2.19.0-rc0
  (merged to 'next' on 2018-08-08 at 1a56c52967)
 + midx: clear midx on repack
 + packfile: skip loading index if in multi-pack-index
 + midx: prevent duplicate packfile loads
 + midx: use midx in approximate_object_count
 + midx: use existing midx when writing new one
 + midx: use midx in abbreviation calculations
 + midx: read objects from multi-pack-index
 + config: create core.multiPackIndex setting
 + midx: write object offsets
 + midx: write object id fanout chunk
 + midx: write object ids in a chunk
 + midx: sort and deduplicate objects from packfiles
 + midx: read pack names into array
 + multi-pack-index: write pack names in chunk
 + multi-pack-index: read packfile list
 + packfile: generalize pack directory list
 + t5319: expand test data
 + multi-pack-index: load into memory
 + midx: write header information to lockfile
 + multi-pack-index: add 'write' verb
 + multi-pack-index: add builtin
 + multi-pack-index: add format details
 + multi-pack-index: add design document

 When there are too many packfiles in a repository (which is not
 recommended), looking up an object in these would require
 consulting many pack .idx files; a new mechanism to have a single
 file that consolidates all of these .idx files is introduced.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* am/sequencer-author-script-fix (2018-07-18) 1 commit
 . sequencer.c: terminate the last line of author-script properly

 The author-script that records the author information created by
 the sequencer machinery lacked the closing single quote on the last
 entry.

 Superseded by another topic.


* jc/push-cas-opt-comment (2018-08-01) 1 commit
 . push: comment on a funny unbalanced option help

 Code clarification.

 Superseded by another topic.


* cc/remote-odb (2018-08-02) 9 commits
 . Documentation/config: add odb.<name>.promisorRemote
 . t0410: test fetching from many promisor remotes
 . Use odb.origin.partialclonefilter instead of core.partialclonefilter
 . Use remote_odb_get_direct() and has_remote_odb()
 . remote-odb: add remote_odb_reinit()
 . remote-odb: implement remote_odb_get_many_direct()
 . remote-odb: implement remote_odb_get_direct()
 . Add initial remote odb support
 . fetch-object: make functions return an error code

 Implement lazy fetches of missing objects to complement the
 experimental partial clone feature.

 Ejected; seems to break existing repositories that use partialclone
 repository extension.

 I haven't seen much interest in this topic on list.  What's the
 doneness of this thing?

 I do not particularly mind adding code to support a niche feature
 as long as it is cleanly made and it is clear that the feature
 won't negatively affect those who do not use it, so a review from
 that point of view may also be appropriate.


* jh/structured-logging (2018-08-28) 26 commits
 . SQUASH??? spatch fix
 . structured-logging: add config data facility
 . structured-logging: t0420 tests for interacitve child_summary
 . structured-logging: t0420 tests for child process detail events
 . structured-logging: add child process classification
 . structured-logging: add detail-events for child processes
 . structured-logging: add structured logging to remote-curl
 . structured-logging: t0420 tests for aux-data
 . structured-logging: add aux-data for size of sparse-checkout file
 . structured-logging: add aux-data for index size
 . structured-logging: add aux-data facility
 . structured-logging: t0420 tests for timers
 . structured-logging: add timer around preload_index
 . structured-logging: add timer around wt-status functions
 . structured-logging: add timer around do_write_index
 . structured-logging: add timer around do_read_index
 . structured-logging: add timer facility
 . structured-logging: add detail-event for lazy_init_name_hash
 . structured-logging: add detail-event facility
 . structured-logging: t0420 basic tests
 . structured-logging: set sub_command field for checkout command
 . structured-logging: set sub_command field for branch command
 . structured-logging: add session-id to log events
 . structured-logging: add structured logging framework
 . structured-logging: add STRUCTURED_LOGGING=1 to Makefile
 . structured-logging: design document

 Being rerolled with an updated tracing API.


* av/fsmonitor-updates (2018-01-04) 6 commits
 . fsmonitor: use fsmonitor data in `git diff`
 . fsmonitor: remove debugging lines from t/t7519-status-fsmonitor.sh
 . fsmonitor: make output of test-dump-fsmonitor more concise
 . fsmonitor: update helper tool, now that flags are filled later
 . fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
 . dir.c: update comments to match argument name

 Code clean-up on fsmonitor integration, plus optional utilization
 of the fsmonitor data in diff-files.

 Tired of waiting for an update.
 cf. <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>

 Also there were backward incompatible API changes brought by other
 topics in flight; having to keep up with those disruptive changes
 is not worth the maintenance effort for a stale topic.


* jc/rebase-in-c-9-fixes (2018-09-04) 1 commit
 . rebase: re-add forgotten -k that stands for --keep-empty
 (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

 The fix has been rolled into the original topic that introduced the
 issue, hence this topic is no longer necessary.
 

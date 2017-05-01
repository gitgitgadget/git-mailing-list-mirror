Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328571F829
	for <e@80x24.org>; Mon,  1 May 2017 05:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642662AbdEAFfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 01:35:43 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34490 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S642659AbdEAFfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 01:35:39 -0400
Received: by mail-pg0-f43.google.com with SMTP id v1so41428507pgv.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=jjDyID/3hneAnt4rPKLfZ8xIvM3+iTx6XeUx5Rl0rVQ=;
        b=o9pyt2uZ9G6FpOhFHqDHBmiFiliAMmxPVh/OzUfBpQ4MsGELK5mALdafHHXX2os1yy
         cIxURnWtL7//jTDE9KzU4CHM8wUBcCzCxNfZ9FxjNv/rk0s7X/jnm9VRaZfQiC4jqCWF
         sus9+IjO9q5F3Jj7u+62DiIO+/g58jA+QNqNKecdNneDnase9r5Etdxag0s1Nrolt+xT
         6a6X0K74GbQrvBgfhHwHwPWW1QnM3+tWZsQSMpqaP19tcvrShhpVIkKMgiJvmwkcteRO
         6U2u8JK/LY7t8mKJh5cxe0WHd6B9D/2CBBVC2ibVnsw/bgded2N1JKFnF2T+L2retQmY
         zWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=jjDyID/3hneAnt4rPKLfZ8xIvM3+iTx6XeUx5Rl0rVQ=;
        b=CvIS+hlsvf8Lj5pq2iDx/R4sREW0fmWRkf0+kXorRKzSe+6pCPE8cb6BqpeeGig0h+
         +YJwvpt/qVTPwOh6TbsEUmWRC+DE1MwLNALaEhNPfRgS8b5ZjhObG2nFkY9AQr7R4pwx
         NMRD73VVXiqNvDhDfyzKk91topf5SQKl6uJPW5OUAjfazu0H8pUr0zW4H5dF+XgEaz5Z
         Q2fcQDOTc9fSldH85UhoBE/WpWF4mYrgLUoou4nuBeAcwsAJOIq5+DJ+TujUWweH6qba
         MIcs4zYsMfexhkG2LNmlJouzx+ViMasd0/Y3cfuEX/EltTsfuQpWOTLFnOuzLg+bcPiK
         Wm/Q==
X-Gm-Message-State: AN3rC/7YNFlW8CcDIExblmc7NBTdjgYntL57pzaMfB5rpVnCmCfS2A7N
        KWp1MijnBHc9xw==
X-Received: by 10.84.192.129 with SMTP id c1mr31630443pld.170.1493616938280;
        Sun, 30 Apr 2017 22:35:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id h89sm23441552pfh.45.2017.04.30.22.35.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 22:35:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2017, #01; Mon, 1)
X-master-at: d2bbb7c2bcf6e77ebfcabf4e12110fe6d5c91de6
X-next-at: 07d810a77faeacef1f1f4c78e6e47457d65ebbe0
Date:   Sun, 30 Apr 2017 22:35:37 -0700
Message-ID: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
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

2.13-rc1 was tagged and we are now in a pre-release freeze.  The
topics marked to be merged to 'next' in the list below may be merged
to 'next' as usual, but the ones marked for 'master' may stay in
'next' until the final release, unless they are small bug/doc fixes
or hotfixes to topics that are already in -rc1 from now on.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/align-perf-descriptions (2017-04-23) 1 commit
  (merged to 'next' on 2017-04-26 at 7d66e7019e)
 + t/perf: correctly align non-ASCII descriptions in output

 Output from perf tests have been updated to align their titles.


* jk/complete-checkout-sans-dwim-remote (2017-04-23) 1 commit
  (merged to 'next' on 2017-04-26 at 0c69cff69f)
 + completion: optionally disable checkout DWIM

 Completion for "git checkout <branch>" that auto-creates the branch
 out of a remote tracking branch can now be disabled, as this
 completion often gets in the way when completing to checkout an
 existing local branch that happens to share the same prefix with
 bunch of remote tracking branches.


* jk/prio-queue-avoid-swap-with-self (2017-04-24) 1 commit
  (merged to 'next' on 2017-04-26 at 6a55996734)
 + prio_queue_reverse: don't swap elements with themselves

 Code clean-up.


* jk/submodule-init-segv-fix (2017-04-24) 1 commit
  (merged to 'next' on 2017-04-26 at 9a6eaaff89)
 + submodule_init: die cleanly on submodules without url defined

 Fix a segv in 'submodule init' when url is not given for a submodule.


* ls/travis-stricter-linux32-builds (2017-04-27) 1 commit
  (merged to 'next' on 2017-04-28 at b0a56aec83)
 + travis-ci: set DEVELOPER knob for Linux32 build

 32-bit Linux build on Travis CI uses stricter compilation options.


* ls/travis-win-fix-status (2017-04-26) 1 commit
  (merged to 'next' on 2017-04-28 at 5c5e4d3278)
 + travis-ci: printf $STATUS as string

 Relaying status from Windows build by Travis CI was done with an
 unsafe invocation of printf.


* sh/rebase-i-reread-todo-after-exec (2017-04-27) 1 commit
  (merged to 'next' on 2017-04-28 at 1ea7e62026)
 + rebase -i: reread the todo list if `exec` touched it

 "git rebase -i" failed to re-read the todo list file when the
 command specified with the `exec` instruction updated it.

--------------------------------------------------
[New Topics]

* bw/submodule-with-bs-path (2017-05-01) 1 commit
 - t7400: add !CYGWIN prerequisite to 'add with \\ in path'

 A hotfix to a topic that is already in 'master'.

 Wait for a few days for Acks and then merge to 'master'.


* jk/am-leakfix (2017-04-27) 3 commits
  (merged to 'next' on 2017-04-30 at 78becd7a96)
 + am: shorten ident_split variable name in get_commit_info()
 + am: simplify allocations in get_commit_info()
 + am: fix commit buffer leak in get_commit_info()

 The codepath in "git am" that is used when running "git rebase"
 leaked memory held for the log message of the commits being rebased.

 Will cook in 'next'.


* js/plug-leaks (2017-04-27) 13 commits
 - checkout: fix memory leak
 - cat-file: fix memory leak
 - mailinfo & mailsplit: check for EOF while parsing mails
 - status: close file descriptor after reading git-rebase-todo
 - difftool: close file descriptors after reading
 - http-backend: avoid memory leaks
 - SQUASH???
 - get_mail_commit_oid(): avoid resource leak
 - git_config_rename_section_in_file(): avoid resource leak
 - add_commit_patch_id(): avoid allocating memory unnecessarily
 - winansi: avoid buffer overrun
 - winansi: avoid use of uninitialized value
 - mingw: avoid memory leak when splitting PATH

 An attempt to fix memory leaks pointed out by Coverity.

 A reroll exists and needs to be picked up.  What's queued here is
 just an early parts of the first iteration.


* sk/status-short-branch-color-config (2017-04-28) 2 commits
  (merged to 'next' on 2017-04-30 at 2a7eb05d7b)
 + status: add color config slots for branch info in "--short --branch"
 + status: fix missing newline when comment chars are disabled

 The colors in which "git status --short --branch" showed the names
 of the current branch and its remote-tracking branch are now
 configurable.

 Will cook in 'next'.


* jh/close-index-before-stat (2017-04-28) 1 commit
  (merged to 'next' on 2017-04-30 at 918d4f3378)
 + read-cache: close index.lock in do_write_index

 The timestamp of the index file is now taken after the file is
 closed, to help Windows, on which a stale timestamp is reported by
 fstat() on a file that is opened for writing and data was written
 but not yet closed.

 Will cook in 'next'.


* bw/submodule-has-commits-update (2017-05-01) 6 commits
 - submodule: refactor logic to determine changed submodules
 - submodule: improve submodule_has_commits
 - submodule: change string_list changed_submodule_paths
 - submodule: remove add_oid_to_argv()
 - submodule: rename free_submodules_sha1s()
 - submodule: rename add_sha1_to_array()


* ja/i18n-cleanup (2017-05-01) 2 commits
  (merged to 'next' on 2017-04-30 at 8002e53820)
 + i18n: read-cache: typofix
 + i18n: remove i18n from tag reflog message

 Will merge to 'master'.


* ls/travis-relays-for-windows-ci (2017-05-01) 2 commits
 - travis-ci: handle Git for Windows CI status "failed" explicitly
 - travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503

 Will merge to 'next' after a few CI run in 'pu'.


* mb/diff-default-to-indent-heuristics (2017-05-01) 5 commits
 - add--interactive: drop diff.indentHeuristic handling
 - SQUASH
 - diff: enable indent heuristic by default
 - diff: have the diff-* builtins configure diff before initializing revisions
 - diff: make the indent heuristic part of diff's basic configuration

 Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
 configuration variable an escape hatch for those who do no want it.

 The fix-up needs to be squashed in.


* rg/doc-pull-typofix (2017-05-01) 1 commit
  (merged to 'next' on 2017-04-30 at c2edb4d813)
 + doc: git-pull.txt use US spelling, fix minor typo

 Will merge to 'master'.


* rg/doc-submittingpatches-wordfix (2017-05-01) 1 commit
  (merged to 'next' on 2017-04-30 at 4065036588)
 + doc: update SubmittingPatches

 Will merge to 'master'.


* sr/hooks-cwd-doc (2017-05-01) 1 commit
  (merged to 'next' on 2017-04-30 at 063dd5cb02)
 + githooks.txt: clarify push hooks are always executed in $GIT_DIR

 Will merge to 'master'.


* tb/dedup-crlf-tests (2017-05-01) 1 commit
 - t0027: Some tests are not expensive

 Will be rerolled.

--------------------------------------------------
[Stalled]

* ja/doc-l10n (2017-03-20) 3 commits
 - SQUASH???
 - l10n: add git-add.txt to localized man pages
 - l10n: introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.


* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 Some nits but looks ok.


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


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* pb/bisect (2017-02-18) 28 commits
 . fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: remove the dequote in bisect_start()
 . bisect--helper: retire `--bisect-auto-next` subcommand
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--bisect-write` subcommand
 . bisect--helper: `bisect_replay` shell function in C
 . bisect--helper: `bisect_log` shell function in C
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: `bisect_state` & `bisect_head` shell function in C
 . bisect--helper: `bisect_autostart` shell function in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 . t6030: no cleanup with bad merge base
 . bisect--helper: `bisect_start` shell function partially in C
 . bisect--helper: `get_terms` & `bisect_terms` shell function in C
 . bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: `check_and_set_terms` shell function in C
 . bisect--helper: `bisect_write` shell function in C
 . bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 . bisect--helper: `bisect_reset` shell function in C
 . wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 . t6030: explicitly test for bisection cleanup
 . bisect--helper: `bisect_clean_state` shell function in C
 . bisect--helper: `write_terms` shell function in C
 . bisect: rewrite `check_term_format` shell function in C
 . bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Ejected from 'pu', as it overlaps and gets in the way of bc/object-id topic.
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

* jc/repack-threads (2017-04-27) 1 commit
 - repack: accept --threads=<n> and pass it down to pack-objects

 "git repack" learned to accept the --threads=<n> option and pass it
 to pack-objects.


* jh/verify-index-checksum-only-in-fsck (2017-04-27) 1 commit
  (merged to 'next' on 2017-04-28 at afb4c70061)
 + t1450: avoid use of "sed" on the index, which is a binary file

 Update an unportable constructin a new test.

 Will cook in 'next'.


* dt/gc-ignore-old-gc-logs (2017-04-24) 3 commits
  (merged to 'next' on 2017-04-26 at 4f4cab8368)
 + test-lib: retire $remove_trash variable
 + test-lib.sh: do not barf under --debug at the end of the test
 + test-lib: abort when can't remove trash directory

 An attempt to allow us notice "fishy" situation where we fail to
 remove the temporary directory used during the test.

 Will cook in 'next'.


* nd/fopen-errors (2017-04-23) 17 commits
 - warn_failure_to_open_read_optional_path(): a new helper
 - t1308: add a test case on open a config directory
 - config.c: handle error on failing to fopen()
 - xdiff-interface.c: report errno on failure to stat() or fopen()
 - wt-status.c: report error on failure to fopen()
 - server-info: report error on failure to fopen()
 - sequencer.c: report error on failure to fopen()
 - rerere.c: report correct errno
 - rerere.c: report error on failure to fopen()
 - remote.c: report error on failure to fopen()
 - commit.c: report error on failure to fopen() the graft file
 - log: report errno on failure to fopen() a file
 - clone: use xfopen() instead of fopen()
 - blame: report error on open if graft_file is a directory
 - bisect: report on fopen() error
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 - git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.

 Expecting a reroll that would be much simplified thanks to a higher
 level helper.

 cf. <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com>
 cf. <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com>


* dt/raise-core-packed-git-limit (2017-04-20) 1 commit
  (merged to 'next' on 2017-04-26 at c72dd8c62f)
 + Increase core.packedGitLimit

 Raise the default packed-git limit value on larger platforms to
 avoid "git fetch" from a (recoverable) failure while "gc" is
 running in parallel.

 Will cook in 'next'.


* js/larger-timestamps (2017-04-27) 8 commits
  (merged to 'next' on 2017-04-28 at b56a0d38cd)
 + use uintmax_t for timestamps
 + date.c: abort if the system time cannot handle one of our timestamps
 + timestamp_t: a new data type for timestamps
 + PRItime: introduce a new "printf format" for timestamps
 + parse_timestamp(): specify explicitly where we parse timestamps
 + t0006 & t5000: skip "far in the future" test when time_t is too limited
 + t0006 & t5000: prepare for 64-bit timestamps
 + ref-filter: avoid using `unsigned long` for catch-all data type

 Some platforms have ulong that is smaller than time_t, and our
 historical use of ulong for timestamp would mean they cannot
 represent some timestamp that the platform allows.  Invent a
 separate and dedicated timestamp_t (so that we can distingiuish
 timestamps and a vanilla ulongs, which along is already a good
 move), and then declare uintmax_t is the type to be used as the
 timestamp_t

 Will cook in 'next'.


* ab/grep-pcre-v2 (2017-04-25) 20 commits
 - SQUASH???
 - Makefile & configure: make PCRE v2 the default PCRE implementation
 - grep: remove support for concurrent use of both PCRE v1 & v2
 - grep: add support for PCRE v2
 - grep: add support for the PCRE v1 JIT API
 - perf: add a performance comparison test of grep -E and -P
 - grep: change the internal PCRE code & header names to be PCRE1
 - grep: change the internal PCRE macro names to be PCRE1
 - test-lib: rename the LIBPCRE prerequisite to PCRE
 - grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
 - grep & rev-list doc: stop promising libpcre for --perl-regexp
 - log: add -P as a synonym for --perl-regexp
 - log: add exhaustive tests for pattern style options & config
 - grep: add a test for backreferences in PCRE patterns
 - Makefile & configure: reword outdated comment about PCRE
 - grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
 - grep: remove redundant regflags assignment under PCRE
 - grep: submodule-related case statements should die if new fields are added
 - grep: add tests for grep pattern types being passed to submodules
 - grep: amend submodule recursion test in preparation for rx engine testing

 PCRE2, which has an API different from and incompatible with PCRE,
 can now be chosen to support "grep -P -e '<pattern>'" and friends.


* bc/object-id (2017-04-23) 53 commits
 - object: convert parse_object* to take struct object_id
 - tree: convert parse_tree_indirect to struct object_id
 - sequencer: convert do_recursive_merge to struct object_id
 - diff-lib: convert do_diff_cache to struct object_id
 - builtin/ls-tree: convert to struct object_id
 - merge: convert checkout_fast_forward to struct object_id
 - sequencer: convert fast_forward_to to struct object_id
 - builtin/ls-files: convert overlay_tree_on_cache to object_id
 - builtin/read-tree: convert to struct object_id
 - sha1_name: convert internals of peel_onion to object_id
 - upload-pack: convert remaining parse_object callers to object_id
 - revision: convert remaining parse_object callers to object_id
 - revision: rename add_pending_sha1 to add_pending_oid
 - http-push: convert process_ls_object and descendants to object_id
 - refs/files-backend: convert many internals to struct object_id
 - refs: convert struct ref_update to use struct object_id
 - ref-filter: convert some static functions to struct object_id
 - Convert struct ref_array_item to struct object_id
 - Convert the verify_pack callback to struct object_id
 - Convert lookup_tag to struct object_id
 - log-tree: convert to struct object_id
 - Convert lookup_tree to struct object_id
 - builtin/reflog: convert tree_is_complete to take struct object_id
 - tree: convert read_tree_1 to use struct object_id internally
 - Convert lookup_blob to struct object_id
 - Convert remaining callers of lookup_blob to object_id
 - builtin/unpack-objects: convert to struct object_id
 - pack: convert struct pack_idx_entry to struct object_id
 - Convert lookup_commit* to struct object_id
 - Convert remaining callers of lookup_commit_reference* to object_id
 - builtin/tag: convert to struct object_id
 - sequencer: convert some functions to struct object_id
 - shallow: convert shallow registration functions to object_id
 - revision: convert prepare_show_merge to struct object_id
 - notes-utils: convert internals to struct object_id
 - http-push: convert some static functions to struct object_id
 - tag: convert parse_tag_buffer to struct object_id
 - builtin/verify-commit: convert to struct object_id
 - reflog_expire: convert to struct object_id
 - parse-options-cb: convert to struct object_id
 - notes-cache: convert to struct object_id
 - submodule: convert merge_submodule to use struct object_id
 - fast-import: convert to struct object_id
 - fast-import: convert internal structs to struct object_id
 - builtin/rev-parse: convert to struct object_id
 - builtin/blame: convert static function to struct object_id
 - branch: convert to struct object_id
 - bundle: convert to struct object_id
 - builtin/prune: convert to struct object_id
 - builtin/name-rev: convert to struct object_id
 - Convert struct cache_tree to use struct object_id
 - Clean up outstanding object_id transforms.
 - fetch-pack: convert to struct object_id

 Conversion from uchar[20] to struct object_id continues.

 Reroll exists and needs to be picked up.


* jk/no-null-sha1-in-cache-tree (2017-04-23) 1 commit
  (merged to 'next' on 2017-04-26 at 45fbe9d57d)
 + cache-tree: reject entries with null sha1

 Tighten code to update cache-tree so that we won't accidentally
 write out any 0{40} entry in the tree object.

 Will cook in 'next'.


* rg/a-the-typo (2017-05-01) 1 commit
  (merged to 'next' on 2017-04-30 at a648cf2961)
 + fix minor typos

 Typofix.

 Will merge to 'master'.


* rs/large-zip (2017-05-01) 7 commits
 - t5004: require 64-bit support for big ZIP tests
 - archive-zip: set version field for big files correctly
  (merged to 'next' on 2017-04-26 at a6beab60f2)
 + archive-zip: support files bigger than 4GB
 + archive-zip: support archives bigger than 4GB
 + archive-zip: write ZIP dir entry directly to strbuf
 + archive-zip: use strbuf for ZIP directory
 + archive-zip: add tests for big ZIP archives

 "git archive --format=zip" learned to use zip64 extension when
 necessary to go beyond the 4GB limit.

 Will cook in 'next'.


* jc/checkout-working-tree-only (2017-04-27) 1 commit
 - checkout: add --working-tree-only option

 "git checkout <tree-ish> <pathspec>" learned a variant that does
 not update the index when doing its thing.


* js/rebase-i-final (2017-04-27) 9 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Needs review.


* jt/use-trailer-api-in-commands (2017-04-26) 1 commit
  (merged to 'next' on 2017-04-30 at 006c8d7ebd)
 + sequencer: add newline before adding footers

 "git cherry-pick" and other uses of the sequencer machinery
 mishandled a trailer block whose last line is an incomplete line.
 This has been fixed so that an additional sign-off etc. are added
 after completing the existing incomplete line.

 Will cook in 'next'.


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


* jk/parse-options-no-no-no (2017-04-25) 2 commits
 - SQUASH???
 - parse-options: disallow double-negations of options starting with no-

 Command line options that begin with "--no-" (e.g. "--no-checkout"
 option of "git clone") can be negated by removing "--no-"; we
 historically also allowed prefixing an extra "no" to the option
 (e.g. "--no-no-checkout"), which made the command line look ugly
 and unusual.  This proposes to forbid it.

 While I agree there is no need to support "--no-no-checkout", this
 looks more like "if it looks ugly and unusual, you do not have to
 use it".  Perhaps we can drop it?

 Will discard.


* df/dir-iter-remove-subtree (2017-04-19) 5 commits
 - remove_subtree(): reimplement using iterators
 - dir_iterator: rewrite state machine model
 - dir_iterator: refactor dir_iterator_advance
 - remove_subtree(): test removing nested directories
 - dir_iterator: add tests for dir_iterator API

 Update the dir-iterator API and use it to reimplement
 remove_subtree().

 A reroll exists that is based on the updated 'master', but I ran
 out of time trying to get it to work with other topics in flight
 in 'pu'.
 GSoC microproject.


* ab/clone-no-tags (2017-05-01) 3 commits
  (merged to 'next' on 2017-04-30 at 601649896a)
 + tests: rename a test having to do with shallow submodules
 + clone: add a --no-tags option to clone without tags
 + tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"

 "git clone" learned the "--no-tags" option not to fetch all tags
 initially, and also set up the tagopt not to follow any tags in
 subsequent fetches.

 Will cook in 'next'.


* bw/forking-and-threading (2017-04-25) 13 commits
  (merged to 'next' on 2017-04-26 at 89c495e37f)
 + run-command: restrict PATH search to executable files
 + run-command: expose is_executable function
  (merged to 'next' on 2017-04-23 at 7754b5ebc3)
 + run-command: block signals between fork and execve
 + run-command: add note about forking and threading
 + run-command: handle dup2 and close errors in child
 + run-command: eliminate calls to error handling functions in child
 + run-command: don't die in child when duping /dev/null
 + run-command: prepare child environment before forking
 + string-list: add string_list_remove function
 + run-command: use the async-signal-safe execv instead of execvp
 + run-command: prepare command before forking
 + t0061: run_command executes scripts without a #! line
 + t5550: use write_script to generate post-update hook

 The "run-command" API implementation has been made more robust
 against dead-locking in a threaded environment.

 Will cook in 'next'.


* sb/reset-recurse-submodules (2017-04-23) 4 commits
 - builtin/reset: add --recurse-submodules switch
 - submodule.c: submodule_move_head works with broken submodules
 - submodule.c: uninitialized submodules are ignored in recursive commands
 - entry.c: submodule recursing: respect force flag correctly

 "git reset" learned "--recurse-submodules" option.


* ls/travis-doc-asciidoctor (2017-04-26) 4 commits
 - travis-ci: check AsciiDoc/AsciiDoctor stderr output
  (merged to 'next' on 2017-04-19 at 359c32953b)
 + travis-ci: unset compiler for jobs that do not need one
 + travis-ci: parallelize documentation build
 + travis-ci: build documentation with AsciiDoc and Asciidoctor

 Have Travis CI format the documentation with both AsciiDoc and
 AsciiDoctor.

 Will merge to 'next' after a few CI run in 'pu'.


* mg/status-in-progress-info (2017-04-14) 1 commit
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 It is still unclear if the participants decided that it is OK to
 spell "--inprogress" as a single word.


* ab/grep-threading-cleanup (2017-04-16) 8 commits
 - grep: given --threads with NO_PTHREADS=YesPlease, warn
 - pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
 - pack-object & index-pack: add test for --threads warning under NO_PTHREADS
 - tests: add a PTHREADS prerequisite
 - grep: skip pthreads overhead when using one thread
 - grep: don't redundantly compile throwaway patterns under threading
 - grep: add tests for --threads=N and grep.threads
 - grep: assert that threading is enabled when calling grep_{lock,unlock}

 Code cleanup.

 Needs review.


* bp/sub-process-convert-filter (2017-04-23) 8 commits
 - convert: update subprocess_read_status() to not die on EOF
 - sub-process: move sub-process functions into separate files
 - convert: rename reusable sub-process functions
 - convert: update generic functions to only use generic data structures
 - convert: separate generic structures and variables from the filter specific ones
 - convert: split start_multi_file_filter into two separate functions
 - convert: move packet_write_list() into pkt-line as packet_writel()
 - pkt-line: add packet_read_line_gently()

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.

 Reroll exists but needs a bit more work.
 cf. <20170407120354.17736-1-benpeart@microsoft.com>


* mg/name-rev-debug (2017-03-31) 4 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Expecting a reroll of the tip two.
 cf. <xmqqshltxnwt.fsf@gitster.mtv.corp.google.com>


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
 (this branch uses nd/worktree-kill-parse-ref.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Expecting a reroll.
 Waiting for nd/worktree-kill-parse-ref to settle.
 cf. <CACsJy8ADCVBiLoPg_Tz0L6CMdh_eFmK4RYzfQ-PmUgBK7w9e=A@mail.gmail.com>


* nd/worktree-kill-parse-ref (2017-04-24) 6 commits
  (merged to 'next' on 2017-04-26 at b8e40da709)
 + refs: kill set_worktree_head_symref()
 + worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 + refs: introduce get_worktree_ref_store()
 + refs: add REFS_STORE_ALL_CAPS
 + refs.c: make submodule ref store hashmap generic
 + environment.c: fix potential segfault by get_git_common_dir()
 (this branch is used by nd/prune-in-worktree.)

 "git gc" did not interact well with "git worktree"-managed
 per-worktree refs.

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

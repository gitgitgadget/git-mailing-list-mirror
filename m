Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DBA2018D
	for <e@80x24.org>; Wed, 10 May 2017 05:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdEJFSY (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 01:18:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36600 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdEJFSX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 01:18:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id 64so2647278pgb.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=8RWlDW6yXrBJ/mi10LaZUH3K6uU9SWsfSynANntbMcs=;
        b=krOfw59Cm/TrBcBn+LH/9366wWoMexajSDlPOSAR45mE46L9WowG5d3jNfTDinNsXP
         +JAb5dxY+Z+vKea91x68iotzhAOhJgB1YLn3WuU7SSLiNsEDpGetw8baWvkGKTAfec6j
         gfxP6RU9BuKlovKLS6tU7zEfc1Og8S1Hrv1xF8BzLPOUruQVBBS728ekjfgdGWmLRsZM
         QyUu/8Lh1gy2kNljLcngwb9UomjETyKmCM5EJrecCDzwVXM9HoZfeZggeU/xQqYkyI5M
         uSmScwMeBGaXKLxiQmN1o/6HpMIIyCfNfhGXGhrqSzTwdqVDuV70p5GWtc1339jF1mrn
         nsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=8RWlDW6yXrBJ/mi10LaZUH3K6uU9SWsfSynANntbMcs=;
        b=TU5yowgrpa8eTyipMY14VPqsju/yfGf2DpTp5MbT/UnW/DAPLapjX2Z/INumN0uJ4A
         ZtJTtWRLRgwPIRTsU0+SV/lkVoiaT6pFKV4KImI0o5Br3u6DrUg1iqAjJQzBzmwoRaHf
         CpbFoS/DrqsY39JCQI2l5WiotgPIoCBRdkOv32QM3kpHNLTP/wrr1A4KB7u1Pd+EmOJ4
         gVtdiMa6TSjkTNO8NM01v/1s507SanZPi5vopHm6c4/j6T4YYsMLOIZst8nvW8Q1AsmI
         dBFCNTWcikzoYanhAgmUX18CGuoYqNTuTKwdKl+1wqUXhe1natqK8NFzcGvGSVxoVDAy
         oFxQ==
X-Gm-Message-State: AODbwcBh2PRf9wnv+4aIUo1b3ZKyw7rMO1JbBsnEaedOMyy/rQbTO1Tb
        dxy3Cat4+rAnKQ==
X-Received: by 10.98.129.3 with SMTP id t3mr4150523pfd.130.1494393501387;
        Tue, 09 May 2017 22:18:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id q82sm3040944pfl.28.2017.05.09.22.18.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 22:18:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2017, #03; Wed, 10)
X-master-at: b06d3643105c8758ed019125a4399cb7efdcce2c
X-next-at: 4ebf3021692df4cb51da8d806fbb8b909ee7e111
Date:   Wed, 10 May 2017 14:18:19 +0900
Message-ID: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
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

Git 2.13, together with maintenance releases for 9 maintenance
tracks, has been tagged.  Let's wait for a few days to see if users
find embarrassing regressions and then start the next cycle.  In the
meantime, please pay closer attention to the topics that have been
stalled or waiting to be reviewed for too long and think of ways to
help moving them forward, before you start sending your new shiny
toys to the list.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jh/verify-index-checksum-only-in-fsck (2017-04-27) 1 commit
  (merged to 'next' on 2017-04-28 at afb4c70061)
 + t1450: avoid use of "sed" on the index, which is a binary file

 Update an unportable constructin a new test.

--------------------------------------------------
[New Topics]

* ab/compat-regex-update (2017-05-09) 2 commits
 - compat/regex: update the gawk regex engine from upstream
 - compat/regex: add a README with a maintenance guide

 Will merge to 'next'.


* jc/apply-fix-mismerge (2017-05-08) 1 commit
  (merged to 'next' on 2017-05-09 at e0b89532d0)
 + apply.c: fix whitespace-only mismerge

 Will merge to 'master'.


* jt/push-options-doc (2017-05-10) 2 commits
 - receive-pack: verify push options in cert
 - docs: correct receive.advertisePushOptions default

 The receive-pack program now makes sure that the push certificate
 records the same set of push options used for pushing.

 Will merge to 'next'.


* dt/unpack-save-untracked-cache-extension (2017-05-09) 1 commit
 - DONTMERGE: unpack-trees: preserve index extensions

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-04-14) 1 commit
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 It is still unclear if the participants decided that it is OK to
 spell "--inprogress" as a single word.


* mg/name-rev-debug (2017-03-31) 4 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Have been expecting a reroll of the tip two, but it has not seen
 any activity for too long.
 cf. <xmqqshltxnwt.fsf@gitster.mtv.corp.google.com>


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

 This was surrected from a "to be discarded" pile, as from time to
 time people wonder about resumable clone that can be primed without
 bothering Git servers with dynamic packfile creation, and some
 people seem to think that the topic could serve as a useful
 building block for that goal.  But nothing seem to have happend.
 Unless people really want it, I am inclined to discard this topic.
 Opinions?


* ja/doc-l10n (2017-03-20) 3 commits
 . SQUASH???
 . l10n: add git-add.txt to localized man pages
 . l10n: introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.

 Will discard.
 Has been stalled for too long.


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* jk/parse-options-no-no-no (2017-04-25) 2 commits
 . SQUASH???
 . parse-options: disallow double-negations of options starting with no-

 Command line options that begin with "--no-" (e.g. "--no-checkout"
 option of "git clone") can be negated by removing "--no-"; we
 historically also allowed prefixing an extra "no" to the option
 (e.g. "--no-no-checkout"), which made the command line look ugly
 and unusual.  This proposes to forbid it.

 While I agree there is no need to support "--no-no-checkout", this
 looks more like "if it looks ugly and unusual, you do not have to
 use it".  Perhaps we can drop it?

 Will discard.


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

 Will discard.
 It has been in the stalled state for too long.
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

 Will discard.
 Nobody seems to be championing this change, after asked in all
 recent "What's cooking" report:
 "Is this good enough with known limitations?"


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 . diffcore-rename: allow easier debugging
 . diffcore-rename.c: add locate_rename_src()
 . diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* sg/clone-refspec-from-command-line-config (2017-05-09) 2 commits
 - git-clone --config order & fetching extra refs during initial clone
 - clone: respect configured fetch respecs during initial fetch

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Will merge to 'next'.


* jn/clone-add-empty-config-from-command-line (2017-05-02) 1 commit
  (merged to 'next' on 2017-05-09 at c56ac3f782)
 + clone: handle empty config values in -c

 "git clone --config var=val" is a way to populate the
 per-repository configuration file of the new repository, but it did
 not work well when val is an empty string.  This has been fixed.

 Will merge to 'master'.


* jn/credential-doc-on-clear (2017-05-02) 1 commit
  (merged to 'next' on 2017-05-09 at 96fa65d122)
 + credential doc: make multiple-helper behavior more prominent

 Doc update.

 Will merge to 'master'.


* sb/checkout-recurse-submodules (2017-05-04) 3 commits
 - submodule: properly recurse for read-tree and checkout
 - submodule: avoid auto-discovery in new working tree manipulator code
 - submodule_move_head: reuse child_process structure for futher commands

 "git checkout --recurse-submodules" did not quite work with a
 submodule that itself has submodules.

 Will merge to 'next'.


* ab/aix-needs-compat-regex (2017-05-04) 1 commit
  (merged to 'next' on 2017-05-09 at 881202b6bb)
 + config.mak.uname: set NO_REGEX=NeedsStartEnd on AIX

 Build fix.

 Will merge to 'master'.


* ja/do-not-ask-needless-questions (2017-05-04) 3 commits
 - git-filter-branch: make the error msg when missing branch more open
 - read-tree -m: make error message for merging 0 trees less smart aleck
 - usability: don't ask questions if no reply is required

 Git sometimes gives an advice in a rhetorical question that does
 not require an answer, which can confuse new users and non native
 speakers.  Attempt to rephrase them.

 I lost track of the discussion on this topic.  Did we decide that
 this is not a good idea?


* ab/doc-replace-gmane-links (2017-05-09) 2 commits
 - doc: replace more gmane links
 - doc: replace a couple of broken gmane links

 The Web interface to gmane news archive is long gone, even though
 the articles are still accessible via NTTP.  Replace the links with
 ones to public-inbox.org.  Because their message identification is
 based on the actual message-id, it is likely that it will be easier
 to migrate away from it if/when necessary.

 Will merge to 'next'.


* ab/fix-poison-tests (2017-05-08) 3 commits
 - travis-ci: add job to run tests with GETTEXT_POISON
 - travis-ci: setup "prove cache" in "script" step
 - tests: fix tests broken under GETTEXT_POISON=YesPlease

 Update tests to pass under GETTEXT_POISON (a mechanism to ensure
 that output strings that should not be translated are not
 translated by mistake), and tell TravisCI to run them.

 Will merge to 'next' after a few rounds on 'pu'.


* bw/dir-c-stops-relying-on-the-index (2017-05-06) 14 commits
 - dir: convert fill_directory to take an index
 - dir: convert read_directory to take an index
 - dir: convert read_directory_recursive to take an index
 - dir: convert open_cached_dir to take an index
 - dir: convert is_excluded to take an index
 - dir: convert prep_exclude to take an index
 - dir: convert add_excludes to take an index
 - dir: convert is_excluded_from_list to take an index
 - dir: convert last_exclude_matching_from_list to take an index
 - dir: convert dir_add* to take an index
 - dir: convert get_dtype to take index
 - dir: convert directory_exists_in_index to take index
 - dir: convert read_skip_worktree_file_from_index to take an index
 - dir: stop using the index compatibility macros

 API update.

 Will merge to 'next'.


* jk/diff-submodule-diff-inline (2017-05-08) 1 commit
 - diff: recurse into nested submodules for inline diff

 "git diff --submodule=diff" now recurses into nested submodules.

 Will merge to 'next'.


* jk/disable-pack-reuse-when-broken (2017-05-09) 2 commits
 - t5310: fix "; do" style
 - pack-objects: disable pack reuse for object-selection options

 "pack-objects" can stream a slice of an existing packfile out when
 the pack bitmap can tell that the reachable objects are all needed
 in the output, without inspecting individual objects.  This
 strategy however would not work well when "--local" and other
 options are in use, and need to be disabled.

 Will merge to 'next'.


* js/eol-on-ourselves (2017-05-10) 6 commits
 - t4051: mark supporting files as requiring LF-only line endings
 - Fix the remaining tests that failed with core.autocrlf=true
 - t3901: move supporting files into t/t3901/
 - completion: mark bash script as LF-only
 - git-new-workdir: mark script as LF-only
 - Fix build with core.autocrlf=true

 Make sure our tests would pass when the sources are checked out
 with "platform native" line ending convention by default on
 Windows.  Some "text" files out tests use and the test scripts
 themselves that are meant to be run with /bin/sh, ought to be
 checked out with eol=LF even on Windows.

 Will merge to 'next'.


* nd/split-index-unshare (2017-05-08) 2 commits
 - p3400: add perf tests for rebasing many changes
 - split-index: add and use unshare_split_index()

 Plug some leaks and updates internal API used to implement the
 split index feature to make it easier to avoid such a leak in the
 future.

 Will merge to 'next'.


* rs/checkout-am-fix-unborn (2017-05-08) 2 commits
 - am: check return value of resolve_refdup before using hash
 - checkout: check return value of resolve_refdup before using hash

 A few codepaths in "checkout" and "am" working on an unborn branch
 tried to access an uninitialized piece of memory.

 Will merge to 'next'.


* bw/submodule-with-bs-path (2017-05-01) 1 commit
 - t7400: add !CYGWIN prerequisite to 'add with \\ in path'

 A hotfix to a topic that is already in v2.13.

 Will merge to 'next'.


* jk/am-leakfix (2017-04-27) 3 commits
  (merged to 'next' on 2017-04-30 at 78becd7a96)
 + am: shorten ident_split variable name in get_commit_info()
 + am: simplify allocations in get_commit_info()
 + am: fix commit buffer leak in get_commit_info()

 The codepath in "git am" that is used when running "git rebase"
 leaked memory held for the log message of the commits being rebased.

 Will merge to 'master'.


* js/plug-leaks (2017-05-09) 26 commits
 - checkout: fix memory leak
 - submodule_uses_worktrees(): plug memory leak
 - show_worktree(): plug memory leak
 - name-rev: avoid leaking memory in the `deref` case
 - remote: plug memory leak in match_explicit()
 - add_reflog_for_walk: avoid memory leak
 - shallow: avoid memory leak
 - line-log: avoid memory leak
 - receive-pack: plug memory leak in update()
 - fast-export: avoid leaking memory in handle_tag()
 - mktree: plug memory leaks reported by Coverity
 - pack-redundant: plug memory leak
 - setup_discovered_git_dir(): plug memory leak
 - setup_bare_git_dir(): help static analysis
 - split_commit_in_progress(): simplify & fix memory leak
 - checkout: fix memory leak
 - cat-file: fix memory leak
 - mailinfo & mailsplit: check for EOF while parsing
 - status: close file descriptor after reading git-rebase-todo
 - difftool: address a couple of resource/memory leaks
 - get_mail_commit_oid(): avoid resource leak
 - git_config_rename_section_in_file(): avoid resource leak
 - add_commit_patch_id(): avoid allocating memory unnecessarily
 - winansi: avoid buffer overrun
 - winansi: avoid use of uninitialized value
 - mingw: avoid memory leak when splitting PATH

 Fix memory leaks pointed out by Coverity (and people).

 Will merge to 'next'.


* sk/status-short-branch-color-config (2017-04-28) 2 commits
  (merged to 'next' on 2017-04-30 at 2a7eb05d7b)
 + status: add color config slots for branch info in "--short --branch"
 + status: fix missing newline when comment chars are disabled

 The colors in which "git status --short --branch" showed the names
 of the current branch and its remote-tracking branch are now
 configurable.

 Will merge to 'master'.


* jh/close-index-before-stat (2017-04-28) 1 commit
  (merged to 'next' on 2017-04-30 at 918d4f3378)
 + read-cache: close index.lock in do_write_index

 The timestamp of the index file is now taken after the file is
 closed, to help Windows, on which a stale timestamp is reported by
 fstat() on a file that is opened for writing and data was written
 but not yet closed.

 Will cook in 'next'.


* bw/submodule-has-commits-update (2017-05-02) 6 commits
  (merged to 'next' on 2017-05-08 at 57267f2277)
 + submodule: refactor logic to determine changed submodules
 + submodule: improve submodule_has_commits()
 + submodule: change string_list changed_submodule_paths
 + submodule: remove add_oid_to_argv()
 + submodule: rename free_submodules_sha1s()
 + submodule: rename add_sha1_to_array()

 Code clean-up and duplicate removal.

 Will merge to 'master'.


* ls/travis-relays-for-windows-ci (2017-05-04) 2 commits
 - travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
 - travis-ci: handle Git for Windows CI status "failed" explicitly

 Will merge to 'next'.


* mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
 - add--interactive: drop diff.indentHeuristic handling
 - diff: enable indent heuristic by default
 - diff: have the diff-* builtins configure diff before initializing revisions
 - diff: make the indent heuristic part of diff's basic configuration

 Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
 configuration variable an escape hatch for those who do no want it.

 Kicked out of next; it seems it is still getting review suggestions?


* tb/dedup-crlf-tests (2017-05-01) 1 commit
 - t0027: Some tests are not expensive

 Will be rerolled.


* jc/repack-threads (2017-04-27) 1 commit
 - repack: accept --threads=<n> and pass it down to pack-objects

 "git repack" learned to accept the --threads=<n> option and pass it
 to pack-objects.

 Will merge to 'next'.


* dt/gc-ignore-old-gc-logs (2017-04-24) 3 commits
  (merged to 'next' on 2017-04-26 at 4f4cab8368)
 + test-lib: retire $remove_trash variable
 + test-lib.sh: do not barf under --debug at the end of the test
 + test-lib: abort when can't remove trash directory

 An attempt to allow us notice "fishy" situation where we fail to
 remove the temporary directory used during the test.

 Will merge to 'master'.


* nd/fopen-errors (2017-05-09) 23 commits
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
 - log: fix memory leak in open_next_file()
 - log: report errno on failure to fopen() a file
 - blame: report error on open if graft_file is a directory
 - bisect: report on fopen() error
 - ident.c: use fopen_or_warn()
 - attr.c: use fopen_or_warn()
 - wrapper.c: add fopen_or_warn()
 - wrapper.c: add warn_on_fopen_errors()
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 - clone: use xfopen() instead of fopen()
 - Use xfopen() in more places
 - git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.


* dt/raise-core-packed-git-limit (2017-04-20) 1 commit
  (merged to 'next' on 2017-04-26 at c72dd8c62f)
 + Increase core.packedGitLimit

 Raise the default packed-git limit value on larger platforms to
 avoid "git fetch" from a (recoverable) failure while "gc" is
 running in parallel.

 Will merge to 'master'.


* js/larger-timestamps (2017-05-09) 9 commits
  (merged to 'next' on 2017-05-09 at ae0603fd3e)
 + archive-tar: fix a sparse 'constant too large' warning
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

 Will merge to 'master'.


* ab/grep-pcre-v2 (2017-05-02) 19 commits
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

 Need to make sure that fallback for those without pcre2 works
 without causing build failure.


* bc/object-id (2017-05-08) 53 commits
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

 Will merge to 'next'.


* jk/no-null-sha1-in-cache-tree (2017-04-23) 1 commit
  (merged to 'next' on 2017-04-26 at 45fbe9d57d)
 + cache-tree: reject entries with null sha1

 Tighten code to update cache-tree so that we won't accidentally
 write out any 0{40} entry in the tree object.

 Will merge to 'master'.


* rs/large-zip (2017-05-01) 7 commits
  (merged to 'next' on 2017-05-02 at a03574e49b)
 + t5004: require 64-bit support for big ZIP tests
 + archive-zip: set version field for big files correctly
  (merged to 'next' on 2017-04-26 at a6beab60f2)
 + archive-zip: support files bigger than 4GB
 + archive-zip: support archives bigger than 4GB
 + archive-zip: write ZIP dir entry directly to strbuf
 + archive-zip: use strbuf for ZIP directory
 + archive-zip: add tests for big ZIP archives

 "git archive --format=zip" learned to use zip64 extension when
 necessary to go beyond the 4GB limit.

 Will merge to 'master'.


* jc/checkout-working-tree-only (2017-04-27) 1 commit
 - checkout: add --working-tree-only option

 "git checkout <tree-ish> <pathspec>" learned a variant that does
 not update the index when doing its thing.

 This was more of "the world could have been like this" illustration
 rather than a "let's make this change" proposal.  Unless people
 really want it, I am inclined to discard this topic.  Opinions?


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

 Needs review.


* jt/use-trailer-api-in-commands (2017-04-26) 1 commit
  (merged to 'next' on 2017-04-30 at 006c8d7ebd)
 + sequencer: add newline before adding footers

 "git cherry-pick" and other uses of the sequencer machinery
 mishandled a trailer block whose last line is an incomplete line.
 This has been fixed so that an additional sign-off etc. are added
 after completing the existing incomplete line.

 Will merge to 'master'.


* ab/clone-no-tags (2017-05-01) 3 commits
  (merged to 'next' on 2017-04-30 at 601649896a)
 + tests: rename a test having to do with shallow submodules
 + clone: add a --no-tags option to clone without tags
 + tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"

 "git clone" learned the "--no-tags" option not to fetch all tags
 initially, and also set up the tagopt not to follow any tags in
 subsequent fetches.

 Will merge to 'master'.


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

 Will merge to 'master'.


* sb/reset-recurse-submodules (2017-04-23) 4 commits
 - builtin/reset: add --recurse-submodules switch
 - submodule.c: submodule_move_head works with broken submodules
 - submodule.c: uninitialized submodules are ignored in recursive commands
 - entry.c: submodule recursing: respect force flag correctly

 "git reset" learned "--recurse-submodules" option.

 Will merge to 'next'.


* ls/travis-doc-asciidoctor (2017-04-26) 4 commits
  (merged to 'next' on 2017-05-04 at 813ba54fc3)
 + travis-ci: check AsciiDoc/AsciiDoctor stderr output
  (merged to 'next' on 2017-04-19 at 359c32953b)
 + travis-ci: unset compiler for jobs that do not need one
 + travis-ci: parallelize documentation build
 + travis-ci: build documentation with AsciiDoc and Asciidoctor

 Have Travis CI format the documentation with both AsciiDoc and
 AsciiDoctor.

 Will merge to 'master'.


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


* bp/sub-process-convert-filter (2017-05-08) 10 commits
 - convert: update subprocess_read_status() to not die on EOF
 - sub-process: move sub-process functions into separate files
 - convert: rename reusable sub-process functions
 - convert: update generic functions to only use generic data structures
 - convert: separate generic structures and variables from the filter specific ones
 - convert: split start_multi_file_filter() into two separate functions
 - convert: move packet_write_line() into pkt-line as packet_writel()
 - pkt-line: add packet_read_line_gently()
 - pkt-line: fix packet_read_line() to handle len < 0 errors
 - convert: remove erroneous tests for errno == EPIPE

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.

 Will merge to 'next'.


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

 Will merge to 'master'.

Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3444DC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF74820652
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 23:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pTecZ56Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLJXnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:43:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60144 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLJXnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 18:43:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DA272EA1E;
        Tue, 10 Dec 2019 18:42:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
        AQLVZTKa6lHFhBAD5fhD+qEO0c=; b=pTecZ56Y0rsP8mMh8bQ3kJLA9+ixmh9il
        xZb1AGGw7D0d5E5lzAe0o0UFskpc4ACZFkWrJeq00kRUGg9vd7DQd/jynDJvRqBu
        Lnuwg7ZjyKrx92mx7gg6wDlJg8eDdxu3gnc3JYTTz4TxLIvaBCOb1ncXvThNkwA6
        lge60jM8BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Al6
        nutcMwPIkcxRLu+wcSDihpM/c5faKUw4+wh+5i2Mg3F4Kc4A5YuQaL9uzVpFeJpL
        Kp47C6PC6eoer+ohCuKcRdEtXUWpyJ/XoEuZilw7oSDyMAxzitBgR9caoMey69sH
        lmfPLEgMj2cLGAdtdckotVoMFowvwnkK3C/PqjZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 456AB2EA1B;
        Tue, 10 Dec 2019 18:42:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 944962EA1A;
        Tue, 10 Dec 2019 18:42:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2019, #03; Tue, 10)
X-master-at: 83f90b8666dffdc13ddedebd3c91bf4ae7307d24
X-next-at: c3465028122a735d0278f138f606ef64549fd8a8
Date:   Tue, 10 Dec 2019 15:42:47 -0800
Message-ID: <xmqqa77zrbm0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5DB4DFE-1BA6-11EA-90E2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The fifth batch of topics are now in 'master', on top of merging the
big security-related updates to the older maintenance tracks.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ag/sequencer-continue-leakfix (2019-11-30) 1 commit
  (merged to 'next' on 2019-12-05 at 923a6a7ab6)
 + sequencer: fix a memory leak in sequencer_continue()

 Leakfix.


* am/pathspec-from-file (2019-11-20) 6 commits
  (merged to 'next' on 2019-11-27 at ee131b80fb)
 + commit: support the --pathspec-from-file option
 + doc: commit: synchronize <pathspec> description
 + reset: support the `--pathspec-from-file` option
 + doc: reset: synchronize <pathspec> description
 + pathspec: add new function to parse file
 + parse-options.h: add new options `--pathspec-from-file`, `--pathspec-file-nul`
 (this branch is used by am/pathspec-f-f-checkout and es/pathspec-f-f-grep.)

 A few commands learned to take the pathspec from the
 standard input or a named file, instead of taking it as the command
 line arguments.


* as/t7812-missing-redirects-fix (2019-12-01) 2 commits
  (merged to 'next' on 2019-12-05 at aa89a7945f)
 + t7812: expect failure for grep -i with invalid UTF-8 data
 + t7812: add missing redirects

 Test fix.


* bc/t9001-zsh-in-posix-emulation-mode (2019-11-30) 1 commit
  (merged to 'next' on 2019-12-05 at d0ce4bcc90)
 + t9001: avoid including non-trailing NUL bytes in variables

 Test portability fix.


* dl/lore-is-the-archive (2019-12-04) 3 commits
  (merged to 'next' on 2019-12-05 at c87e168cd6)
 + doc: replace LKML link with lore.kernel.org
 + RelNotes: replace Gmane with real Message-IDs
 + doc: replace MARC links with lore.kernel.org
 (this branch uses jk/lore-is-the-archive.)

 Publicize lore.kernel.org mailing list archive and use URLs
 pointing into it to refer to notable messages in the documentation.


* dl/pretty-reference (2019-11-20) 11 commits
  (merged to 'next' on 2019-12-05 at 0972133ad2)
 + SubmittingPatches: use `--pretty=reference`
 + pretty: implement 'reference' format
 + pretty: add struct cmt_fmt_map::default_date_mode_type
 + pretty: provide short date format
 + t4205: cover `git log --reflog -z` blindspot
 + pretty.c: inline initalize format_context
 + revision: make get_revision_mark() return const pointer
 + completion: complete `tformat:` pretty format
 + SubmittingPatches: remove dq from commit reference
 + pretty-formats.txt: use generic terms for hash
 + SubmittingPatches: use generic terms for hash

 "git log" family learned "--pretty=reference" that gives the name
 of a commit in the format that is often used to refer to it in log
 messages.


* dl/submodule-set-url (2019-10-30) 1 commit
  (merged to 'next' on 2019-12-05 at a164eccad1)
 + submodule: teach set-url subcommand

 "git submodule" learned a subcommand "set-url".


* ds/commit-graph-delay-gen-progress (2019-11-27) 2 commits
  (merged to 'next' on 2019-12-05 at 9252a4b1b6)
 + commit-graph: use start_delayed_progress()
 + progress: create GIT_PROGRESS_DELAY

 One kind of progress messages were always given during commit-graph
 generation, instead of following the "if it takes more than two
 seconds, show progress" pattern, which has been corrected.


* em/test-skip-regex-illseq (2019-11-30) 1 commit
  (merged to 'next' on 2019-12-05 at 85c7940aeb)
 + t4210: skip i18n tests that don't work on FreeBSD

 Test portability fix.


* hi/gpg-use-check-signature (2019-11-30) 1 commit
  (merged to 'next' on 2019-12-05 at 35fc8e839a)
 + gpg-interface: prefer check_signature() for GPG verification

 Hide lower-level verify_signed-buffer() API as a pure helper to
 implement the public check_signature() function, in order to
 encourage new callers to use the correct and more strict
 validation.


* hi/grep-do-not-return-void (2019-11-30) 1 commit
  (merged to 'next' on 2019-12-02 at 4409c73cfa)
 + grep: don't return an expression from pcre2_free()

 Code cleanup.


* jk/lore-is-the-archive (2019-11-30) 2 commits
  (merged to 'next' on 2019-12-02 at 603a2b0105)
 + doc: replace public-inbox links with lore.kernel.org
 + doc: recommend lore.kernel.org over public-inbox.org
 (this branch is used by dl/lore-is-the-archive.)

 Doc update for the mailing list archiving and nntp service.


* jk/perf-wo-git-dot-pm (2019-11-27) 1 commit
  (merged to 'next' on 2019-12-05 at 6d9e3930ec)
 + t/perf: don't depend on Git.pm

 Test cleanup.


* jk/send-pack-check-negative-with-quick (2019-11-30) 1 commit
  (merged to 'next' on 2019-12-02 at 2b01214601)
 + send-pack: use OBJECT_INFO_QUICK to check negative objects

 Performance tweak on "git push" into a repository with many refs
 that point at objects we have never heard of.


* js/mingw-inherit-only-std-handles (2019-12-02) 6 commits
  (merged to 'next' on 2019-12-05 at 289f13054b)
 + mingw: forbid translating ERROR_SUCCESS to an errno value
  (merged to 'next' on 2019-12-02 at 798a952eca)
 + mingw: do set `errno` correctly when trying to restrict handle inheritance
  (merged to 'next' on 2019-11-27 at 4736894af6)
 + mingw: restrict file handle inheritance only on Windows 7 and later
 + mingw: spawned processes need to inherit only standard handles
 + mingw: work around incorrect standard handles
 + mingw: demonstrate that all file handles are inherited by child processes

 Work around a issue where a FD that is left open when spawning a
 child process and is kept open in the child can interfere with the
 operation in the parent process on Windows.


* jt/clone-recursesub-ref-advise (2019-12-03) 2 commits
  (merged to 'next' on 2019-12-05 at fc071dddfe)
 + submodule--helper: advise on fatal alternate error
 + Doc: explain submodule.alternateErrorStrategy

 The interaction between "git clone --recurse-submodules" and
 alternate object store was ill-designed.  The documentation and
 code have been taught to make more clear recommendations when the
 users see failures.


* po/bundle-doc-clonable (2019-10-21) 1 commit
  (merged to 'next' on 2019-12-02 at bd7fa24ad6)
 + Doc: Bundle file usage

 Doc update.


* ra/rebase-i-more-options (2019-11-25) 7 commits
  (merged to 'next' on 2019-11-27 at e8a6d1e281)
 + rebase -i: finishing touches to --reset-author-date
 + rebase: add --reset-author-date
 + rebase -i: support --ignore-date
 + sequencer: rename amend_author to author_to_rename
 + rebase -i: support --committer-date-is-author-date
 + sequencer: allow callers of read_author_script() to ignore fields
 + rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.


* rs/simplify-prepare-cmd (2019-11-27) 1 commit
  (merged to 'next' on 2019-12-02 at 12e1a9e935)
 + run-command: use prepare_git_cmd() in prepare_cmd()

 Code cleanup.


* rs/test-cleanup (2019-11-30) 7 commits
  (merged to 'next' on 2019-12-02 at eabc2e30f5)
 + t7811: don't create unused file
 + t9300: don't create unused file
 + test: use test_must_be_empty F instead of test_cmp empty F
 + test: use test_must_be_empty F instead of test -z $(cat F)
 + t1400: use test_must_be_empty
 + t1410: use test_line_count
 + t1512: use test_line_count

 Test cleanup.


* rs/use-skip-prefix-more (2019-11-27) 5 commits
  (merged to 'next' on 2019-12-02 at a2124db23e)
 + name-rev: use skip_prefix() instead of starts_with()
 + push: use skip_prefix() instead of starts_with()
 + shell: use skip_prefix() instead of starts_with()
 + fmt-merge-msg: use skip_prefix() instead of starts_with()
 + fetch: use skip_prefix() instead of starts_with()

 Code cleanup.


* sg/assume-no-todo-update-in-cherry-pick (2019-11-24) 1 commit
  (merged to 'next' on 2019-11-27 at 6908186f85)
 + sequencer: don't re-read todo for revert and cherry-pick

 While running "revert" or "cherry-pick --edit" for multiple
 commits, a recent regression incorrectly detected "nothing to
 commit, working tree clean", instead of replaying the commits,
 which has been corrected.


* sg/osx-force-gcc-9 (2019-11-29) 1 commit
  (merged to 'next' on 2019-12-02 at 4916f80e5e)
 + ci: build Git with GCC 9 in the 'osx-gcc' build job

 TravisCI update.


* sg/test-squelch-noise-in-commit-bulk (2019-11-27) 1 commit
  (merged to 'next' on 2019-12-05 at 7819efee07)
 + test-lib-functions: suppress a 'git rev-parse' error in 'test_commit_bulk'

 Code cleanup.


* tg/perf-remove-stale-result (2019-11-27) 1 commit
  (merged to 'next' on 2019-12-05 at 466f07fb63)
 + perf-lib: use a single filename for all measurement types

 PerfTest fix to avoid stale result mixed up with the latest round
 of test results.

--------------------------------------------------
[New Topics]

* at/rebase-fork-point-regression-fix (2019-12-09) 1 commit
 - rebase: fix --fork-point with short refname

 The "--fork-point" mode of "git rebase" regressed when the command
 was rewritten in C back in 2.20 era, which has been corrected.

 Waiting for discussion to settle.


* dl/range-diff-with-notes (2019-12-06) 3 commits
  (merged to 'next' on 2019-12-10 at af8f441807)
 + range-diff: clear `other_arg` at end of function
 + range-diff: mark pointers as const
 + t3206: fix incorrect test name

 Code clean-up.

 Will merge to 'master'.


* js/add-i-a-bit-more-tests (2019-12-06) 7 commits
  (merged to 'next' on 2019-12-10 at d7ffb75a43)
 + apply --allow-overlap: fix a corner case
 + git add -p: use non-zero exit code when the diff generation failed
 + t3701: verify that the diff.algorithm config setting is handled
 + t3701: verify the shown messages when nothing can be added
 + t3701: add a test for the different `add -p` prompts
 + t3701: avoid depending on the TTY prerequisite
 + t3701: add a test for advanced split-hunk editing
 (this branch uses js/builtin-add-i-cmds.)

 Test coverage update in preparation for further work on "git add -i".

 Will merge to 'master'.


* pw/advise-rebase-skip (2019-12-06) 9 commits
 - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
 - rebase: fix advice when a fixup creates an empty commit
 - commit: give correct advice for empty commit during a rebase
 - commit: encapsulate determine_whence() for sequencer
 - commit: use enum value for multiple cherry-picks
 - sequencer: write CHERRY_PICK_HEAD for reword and edit
 - cherry-pick: check commit error messages
 - cherry-pick: add test for `--skip` advice in `git commit`
 - t3404: use test_cmp_rev

 The mechanism to prevent "git commit" from making an empty commit
 or amending during an interrupted cherry-pick was broken during the
 rewrite of "git rebase" in C, which has been corrected.

 Needs review.
 The tip two are still RFC.


* sg/t9300-robustify (2019-12-06) 2 commits
  (merged to 'next' on 2019-12-10 at dee7a9a945)
 + t9300-fast-import: don't hang if background fast-import exits too early
 + t9300-fast-import: store the PID in a variable instead of pidfile

 The test on "fast-import" used to get stuck when "fast-import" died
 in the middle.

 Will merge to 'master'.


* dl/format-patch-notes-config-fixup (2019-12-09) 5 commits
  (merged to 'next' on 2019-12-10 at 2d8830090f)
 + format-patch: move git_config() before repo_init_revisions()
 + format-patch: use --notes behavior for format.notes
 + notes: extract logic into set_display_notes()
 + notes: create init_display_notes() helper
 + notes: rename to load_display_notes()

 "git format-patch" can take a set of configured format.notes values
 to specify which notes refs to use in the log message part of the
 output.  The behaviour of this was not consistent with multiple
 --notes command line options, which has been corrected.

 Will merge to 'master'.


* dr/branch-usage-casefix (2019-12-09) 1 commit
  (merged to 'next' on 2019-12-10 at ad8a629fc6)
 + l10n: minor case fix in 'git branch' '--unset-upstream' description

 Message fix.

 Will merge to 'master'.


* js/t3404-indent-fix (2019-12-09) 1 commit
  (merged to 'next' on 2019-12-10 at 3a705a40d6)
 + t3404: fix indentation

 Test cleanup.

 Will merge to 'master'.


* rs/archive-zip-code-cleanup (2019-12-09) 1 commit
  (merged to 'next' on 2019-12-10 at 5a0b530805)
 + archive-zip: use enum for compression method

 Code cleanup.

 Will merge to 'master'.


* rs/commit-export-env-simplify (2019-12-09) 1 commit
  (merged to 'next' on 2019-12-10 at 591b24162c)
 + commit: use strbuf_add() to add a length-limited string

 Code cleanup.

 Will merge to 'master'.


* rs/patch-id-use-oid-to-hex (2019-12-09) 1 commit
  (merged to 'next' on 2019-12-10 at cf403a83da)
 + patch-id: use oid_to_hex() to print multiple object IDs

 Code cleanup.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* ma/config-bool-valex (2019-11-14) 8 commits
 - builtin/config: die if "value_regex" doesn't canonicalize as boolean
 - builtin/config: warn if "value_regex" doesn't canonicalize as boolean
 - builtin/config: canonicalize "value_regex" with `--type=bool-or-int`
 - builtin/config: canonicalize "value_regex" with `--type=bool`
 - builtin/config: collect "value_regexp" data in a struct
 - builtin/config: extract `handle_value_regex()` from `get_value()`
 - t1300: modernize part of script
 - config: make `git_parse_maybe_bool_text()` public

 "git config" can be told to affect the existing entries that
 "match" the given value via its value_regex argument.  It learned
 to normalize the value set in the configuration and the value given
 from the command line before computing they "match", e.g. "true" in
 the configuration file can now match with "yes" given from the
 command line.

 Needs a bit more work?
 cf. <CAN0heSrtwi9V607vBX9PMSfNLQ8iGcno6_iGuR4Fs8ndGxqh8A@mail.gmail.com>


* ds/fsmonitor-testing (2019-12-09) 8 commits
 - test-lib: clear watchman watches at test completion
 - t7519: disable external GIT_TEST_FSMONITOR variable
 - t7063: disable fsmonitor with status cache
 - tests: disable fsmonitor in submodule tests
 - t3030-merge-recursive.sh: disable fsmonitor when tweaking GIT_WORK_TREE
 - t1301-shared-repo.sh: disable FSMONITOR
 - fsmonitor: do not output to stderr for tests
 - fsmonitor: disable in a bare repo

 Updates around testing fsmoitor integration.

 cf. <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>


* mt/threaded-grep-in-object-store (2019-10-02) 11 commits
 - grep: move driver pre-load out of critical section
 - grep: re-enable threads in non-worktree case
 - grep: protect packed_git [re-]initialization
 - grep: allow submodule functions to run in parallel
 - submodule-config: add skip_if_read option to repo_read_gitmodules()
 - grep: replace grep_read_mutex by internal obj read lock
 - object-store: allow threaded access to object reading
 - replace-object: make replace operations thread-safe
 - grep: fix racy calls in grep_objects()
 - grep: fix race conditions at grep_submodule()
 - grep: fix race conditions on userdiff calls

 Traditionally, we avoided threaded grep while searching in objects
 (as opposed to files in the working tree) as accesses to the object
 layer is not thread-safe.  This limitation is getting lifted.

 Expecting a reroll.
 cf. <CAHd-oW7UPSSExyLtfLMCObWogKrBOctYabrFrOdf9-4Q2PZmMg@mail.gmail.com>


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* ra/t5150-depends-on-perl (2019-11-27) 1 commit
 . t5150: skip request-pull test if Perl is disabled

 Some Porcelain commands are written in Perl, and tests on them are
 expected not to work when the platform lacks a working perl.

 Redo.


* am/pathspec-f-f-checkout (2019-12-04) 7 commits
  (merged to 'next' on 2019-12-10 at 6b018bd997)
 + checkout, restore: support the --pathspec-from-file option
 + doc: restore: synchronize <pathspec> description
 + doc: checkout: synchronize <pathspec> description
 + doc: checkout: fix broken text reference
 + doc: checkout: remove duplicate synopsis
 + add: support the --pathspec-from-file option
 + cmd_add: prepare for next patch

 A few more commands learned the "--pathspec-from-file" command line
 option.

 Will merge to 'master'.


* dl/rebase-with-autobase (2019-12-05) 5 commits
  (merged to 'next' on 2019-12-06 at 2d72b8cffe)
 + rebase: fix format.useAutoBase breakage
 + format-patch: teach --no-base
 + t4014: use test_config()
 + format-patch: fix indentation
 + t3400: demonstrate failure with format.useAutoBase

 "git rebase" did not work well when format.useAutoBase
 configuration variable is set, which has been corrected.

 Will merge to 'master'.


* es/pathspec-f-f-grep (2019-12-06) 1 commit
 - grep: support the --pathspec-from-file option

 "git grep" learned the "--pathspec-from-file" command line
 option.

 Waiting for review responses.
 cf. <20191204203911.237056-1-emilyshaffer@google.com>


* rs/xdiff-ignore-ws-w-func-context (2019-12-05) 1 commit
  (merged to 'next' on 2019-12-06 at e0522318ac)
 + xdiff: unignore changes in function context

 The "diff" machinery learned not to lose added/removed blank lines
 in the context when --ignore-blank-lines and --function-context are
 used at the same time.

 Will merge to 'master'.


* ag/edit-todo-drop-check (2019-12-06) 2 commits
 - rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
 - sequencer: move check_todo_list_from_file() to rebase-interactive.c
 (this branch uses ag/sequencer-todo-updates.)

 Allow the rebase.missingCommitsCheck configuration to kick in when
 "rebase --edit-todo" and "rebase --continue" restarts the procedure.

 Broken.
 cf. <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>


* ds/sparse-cone (2019-11-22) 19 commits
 - sparse-checkout: check for dirty status
 - sparse-checkout: update working directory in-process for 'init'
 - sparse-checkout: cone mode should not interact with .gitignore
 - sparse-checkout: write using lockfile
 - sparse-checkout: use in-process update for disable subcommand
 - sparse-checkout: update working directory in-process
 - sparse-checkout: sanitize for nested folders
 - unpack-trees: add progress to clear_ce_flags()
 - unpack-trees: hash less in cone mode
 - sparse-checkout: init and set in cone mode
 - sparse-checkout: use hashmaps for cone patterns
 - sparse-checkout: add 'cone' mode
 - trace2: add region in clear_ce_flags
 - sparse-checkout: create 'disable' subcommand
 - sparse-checkout: add '--stdin' option to set subcommand
 - sparse-checkout: 'set' subcommand
 - clone: add --sparse mode
 - sparse-checkout: create 'init' subcommand
 - sparse-checkout: create builtin with 'list' subcommand

 Management of sparsely checked-out working tree has gained a
 dedicated "sparse-checkout" command.

 Possibly wait for Szeder?
 cf. <bea26b66-ac52-8f0e-9557-c958db7be628@gmail.com>


* dl/test-cleanup (2019-12-04) 26 commits
  (merged to 'next' on 2019-12-06 at 9129e71939)
 + t7700: stop losing return codes of git commands
 + t7700: make references to SHA-1 generic
 + t7700: replace egrep with grep
 + t7700: consolidate code into test_has_duplicate_object()
 + t7700: consolidate code into test_no_missing_in_packs()
 + t7700: s/test -f/test_path_is_file/
 + t7700: move keywords onto their own line
 + t7700: remove spaces after redirect operators
 + t7700: drop redirections to /dev/null
 + t7501: stop losing return codes of git commands
 + t7501: remove spaces after redirect operators
 + t5703: stop losing return codes of git commands
 + t5703: simplify one-time-sed generation logic
 + t5317: use ! grep to check for no matching lines
 + t5317: stop losing return codes of git commands
 + t4138: stop losing return codes of git commands
 + t4015: use test_write_lines()
 + t4015: stop losing return codes of git commands
 + t3600: comment on inducing SIGPIPE in `git rm`
 + t3600: stop losing return codes of git commands
 + t3600: use test_line_count() where possible
 + t3301: stop losing return codes of git commands
 + t0090: stop losing return codes of git commands
 + t0014: remove git command upstream of pipe
 + apply-one-time-sed.sh: modernize style
 + lib-bash.sh: move `then` onto its own line

 Test cleanup.

 Will merge to 'master'.


* cs/store-packfiles-in-hashmap (2019-12-03) 1 commit
  (merged to 'next' on 2019-12-05 at 887d5559bb)
 + packfile.c: speed up loading lots of packfiles

 In a repository with many packfiles, the cost of the procedure that
 avoids registering the same packfile twice was unnecessarily high
 by using an inefficient search algorithm, which has been corrected.

 Will merge to 'master'.


* dd/time-reentrancy (2019-12-01) 3 commits
  (merged to 'next' on 2019-12-05 at d0c91f4d1b)
 + mingw: use {gm,local}time_s as backend for {gm,local}time_r
 + archive-zip.c: switch to reentrant localtime_r
 + date.c: switch to reentrant {gm,local}time_r

 Avoid gmtime() and localtime() and prefer their reentrant
 counterparts.

 Will merge to 'master'.


* hw/doc-in-header (2019-11-18) 20 commits
  (merged to 'next' on 2019-12-10 at 75ae310f9a)
 + trace2: move doc to trace2.h
 + submodule-config: move doc to submodule-config.h
 + tree-walk: move doc to tree-walk.h
 + trace: move doc to trace.h
 + run-command: move doc to run-command.h
 + parse-options: add link to doc file in parse-options.h
 + credential: move doc to credential.h
 + argv-array: move doc to argv-array.h
 + cache: move doc to cache.h
 + sigchain: move doc to sigchain.h
 + pathspec: move doc to pathspec.h
 + revision: move doc to revision.h
 + attr: move doc to attr.h
 + refs: move doc to refs.h
 + remote: move doc to remote.h and refspec.h
 + sha1-array: move doc to sha1-array.h
 + merge: move doc to ll-merge.h
 + graph: move doc to graph.h and graph.c
 + dir: move doc to dir.h
 + diff: move doc to diff.h and diffcore.h

 Move material from Documentation/technical/api-*.txt to header
 files.

 Will merge to 'master'.


* js/builtin-add-i-cmds (2019-12-01) 9 commits
  (merged to 'next' on 2019-12-05 at 30cfe5c15d)
 + built-in add -i: offer the `quit` command
 + built-in add -i: re-implement the `diff` command
 + built-in add -i: implement the `patch` command
 + built-in add -i: re-implement `add-untracked` in C
 + built-in add -i: re-implement `revert` in C
 + built-in add -i: implement the `update` command
 + built-in add -i: prepare for multi-selection commands
 + built-in add -i: allow filtering the modified files list
 + add-interactive: make sure to release `rev.prune_data`
 (this branch is used by js/add-i-a-bit-more-tests.)

 "git add -i" that is getting rewritten in C has been extended to
 cover subcommands other than the "patch".

 Will merge to 'master'.


* sg/name-rev-wo-recursion (2019-12-09) 14 commits
 - name-rev: cleanup name_ref()
 - name-rev: eliminate recursion in name_rev()
 - name-rev: use 'name->tip_name' instead of 'tip_name'
 - name-rev: drop name_rev()'s 'generation' and 'distance' parameters
 - name-rev: restructure creating/updating 'struct rev_name' instances
 - name-rev: restructure parsing commits and applying date cutoff
 - name-rev: pull out deref handling from the recursion
 - name-rev: extract creating/updating a 'struct name_rev' into a helper
 - t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
 - name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
 - name-rev: avoid unnecessary cast in name_ref()
 - name-rev: use strbuf_strip_suffix() in get_rev_name()
 - t6120-describe: modernize the 'check_describe' helper
 - t6120-describe: correct test repo history graph in comment

 Redo "git name-rev" to avoid recursive calls.

 Will merge to 'next'.
 cf. <20191209115258.9281-1-szeder.dev@gmail.com>


* ag/sequencer-todo-updates (2019-11-25) 5 commits
  (merged to 'next' on 2019-11-27 at 3258d51dfc)
 + sequencer: directly call pick_commits() from complete_action()
 + rebase: fill `squash_onto' in get_replay_opts()
 + sequencer: move the code writing total_nr on the disk to a new function
 + sequencer: update `done_nr' when skipping commands in a todo list
 + sequencer: update `total_nr' when adding an item to a todo list
 (this branch is used by ag/edit-todo-drop-check.)

 Reduce unnecessary reading of state variables back from the disk
 during sequencer operation.

 Will merge to 'master'.


* jk/packfile-reuse-cleanup (2019-10-23) 9 commits
  (merged to 'next' on 2019-11-19 at 9683853939)
 + pack-objects: improve partial packfile reuse
 + builtin/pack-objects: introduce obj_is_packed()
 + pack-objects: introduce pack.allowPackReuse
 + csum-file: introduce hashfile_total()
 + pack-bitmap: introduce bitmap_walk_contains()
 + pack-bitmap: don't rely on bitmap_git->reuse_objects
 + ewah/bitmap: introduce bitmap_word_alloc()
 + packfile: expose get_delta_base()
 + builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.

 Hold.  There is an update to these patches that currently are on 'next'.
 cf. <20191115180319.113991-1-jonathantanmy@google.com>

--------------------------------------------------
[Discarded]

* js/advise-rebase-skip (2019-10-23) 3 commits
 . commit: give correct advice for empty commit during a rebase
 . sequencer: export the function to get the path of `.git/rebase-merge/`
 . cherry-pick: add test for `--skip` advice in `git commit`

 The logic used in "git commit" to give hints and errors depending
 on what operation was in progress learned to distinguish rebase and
 cherry-pick better.

 Superseded by pw/advise-rebase-skip

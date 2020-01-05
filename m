Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB0C32767
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 01:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D78215A4
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 01:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b95UH99h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEBWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 20:22:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53659 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEBWy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 20:22:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58CBB3E499;
        Sat,  4 Jan 2020 20:22:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=y
        D1nlMiSUUZb3b76r1u+/UdZ+HY=; b=b95UH99hd8sXcU66Us1G9nok46gqDuEKd
        CKcwGNmn4klTlJ6L0NnMkv4lhgNstrSmwj9NltAofjdyCWxi3QxJwVm5jrrS/2Ie
        +DCiZC31p4kTCtalSXJK4fMBXC7NvoEX16ydrczYqMq33WE+lwQOL3guKRbqly5Z
        BN7za2kNQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=u8k
        PafYrsIczNM0Q2NXbMt0f0Dr+cTqWU/gl15yokysxToPYfpBc+MtYsqq5RA7wf/W
        nEMaZDtrO0abF0AOrsKwSysFPFEEv+vCS0m0jSyBCTudXfy/vyXVhBd+gIqAR5OT
        zv+X6tmGh4io8S8VhMlltG1xj9hSjOSfOi85UtxY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5058F3E497;
        Sat,  4 Jan 2020 20:22:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACB973E496;
        Sat,  4 Jan 2020 20:22:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2020, #02; Sat, 4)
X-master-at: 8679ef24ed64018bb62170c43ce73e0261c0600a
X-next-at: 71ea739a6cfbb938bae4fd7453c913c984f66f90
Date:   Sat, 04 Jan 2020 17:22:48 -0800
Message-ID: <xmqqa772bst3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E31E4742-2F59-11EA-B722-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

After the topics marked to be merged to 'master' go in, the tip of
the master will hopefully be very close to the final release.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* do/gitweb-typofix-in-comments (2020-01-04) 1 commit
 - gitweb: fix a couple spelling errors in comments

 Typofix.

 Will merge to 'next' and then to 'master'.


* en/unpack-trees-check-updates-simplify (2020-01-04) 1 commit
 - unpack-trees: exit check_updates() early if updates are not wanted

 Code simplification.


* jb/doc-multi-pack-idx-fix (2020-01-04) 1 commit
 - multi-pack-index: correct configuration in documentation

 Typofix.

 Will merge to 'next' and then to 'master'.


* pm/am-in-body-header-doc-update (2020-01-04) 1 commit
 - am: document that Date: can appear as an in-body header

 Doc update.

 Will merge to 'next' and then to 'master'.

--------------------------------------------------
[Stalled]

* ag/edit-todo-drop-check (2019-12-06) 2 commits
 - rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
 - sequencer: move check_todo_list_from_file() to rebase-interactive.c

 Allow the rebase.missingCommitsCheck configuration to kick in when
 "rebase --edit-todo" and "rebase --continue" restarts the procedure.

 Broken.
 cf. <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>


* es/pathspec-f-f-grep (2019-12-13) 1 commit
 - grep: support the --pathspec-from-file option

 "git grep" learned the "--pathspec-from-file" command line
 option.

 Waiting for review responses.
 cf. <20191204203911.237056-1-emilyshaffer@google.com>


* at/rebase-fork-point-regression-fix (2019-12-09) 1 commit
 - rebase: fix --fork-point with short refname

 The "--fork-point" mode of "git rebase" regressed when the command
 was rewritten in C back in 2.20 era, which has been corrected.

 Was waiting for discussion to settle.
 cf. <CAPig+cQ-3Ds41hr91fRo_GvuFMTP7zNVJtaSqi-Yccq4Pk-8Qg@mail.gmail.com>


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

* dl/merge-autostash (2019-12-26) 17 commits
 - pull: pass --autostash to merge
 - t5520: make test_pull_autostash() accept expect_parent_num
 - merge: teach --autostash option
 - sequencer: unlink autostash in apply_autostash()
 - sequencer: extract perform_autostash() from rebase
 - rebase: generify create_autostash()
 - rebase: extract create_autostash()
 - reset: extract reset_head() from rebase
 - rebase: generify reset_head()
 - rebase: use apply_autostash() from sequencer.c
 - sequencer: make apply_rebase() accept a path
 - rebase: use read_oneliner()
 - sequencer: make read_oneliner() extern
 - sequencer: configurably warn on non-existent files
 - sequencer: use file strbuf for read_oneliner()
 - t7600: use test_write_lines()
 - Makefile: alphabetically sort += lists

 "git merge" learns the "--autostash" option.


* dl/test-must-fail-fixes-2 (2019-12-27) 16 commits
 - t4124: let sed open its own files
 - t4124: only mark git command with test_must_fail
 - t3507: use test_path_is_missing()
 - t3507: fix indentation
 - t3504: do check for conflict marker after failed cherry-pick
 - t3419: stop losing return code of git command
 - t3415: increase granularity of test_auto_{fixup,squash}()
 - t3415: stop losing return codes of git commands
 - t3310: extract common no_notes_merge_left()
 - t3030: use test_path_is_missing()
 - t2018: replace "sha" with "oid"
 - t2018: don't lose return code of git commands
 - t2018: teach do_checkout() to accept `!` arg
 - t2018: use test_must_fail for failing git commands
 - t2018: add space between function name and ()
 - t2018: remove trailing space from test description

 Test updates.

 Not quite.
 cf. <CAPig+cQo1nbRo=n8-XOtycGijj3k1y_Zozu7VW-WTSBB9LncqQ@mail.gmail.com>
 cf. <86lfqt36ah.fsf@gmail.com>


* jn/promote-proto2-to-default (2019-12-27) 5 commits
 - fetch: default to protocol version 2
 - protocol test: let protocol.version override GIT_TEST_PROTOCOL_VERSION
 - test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate
 - config doc: protocol.version is not experimental
 - fetch test: use more robust test for filtered objects
 (this branch uses jn/test-lint-one-shot-export-to-shell-function.)

 The transport protocol version 2 becomes the default one.

 Will merge to 'next'.


* ds/sparse-list-in-cone-mode (2019-12-30) 2 commits
  (merged to 'next' on 2020-01-04 at e1a174647e)
 + sparse-checkout: document interactions with submodules
 + sparse-checkout: list directories in cone mode

 "git sparse-checkout list" subcommand learned to give its output in
 a more concise form when the "cone" mode is in effect.

 Will merge to 'master'.


* am/test-pathspec-f-f-error-cases (2020-01-02) 1 commit
  (merged to 'next' on 2020-01-04 at 73ac7e77fb)
 + t: add tests for error conditions with --pathspec-from-file

 More tests.

 Will cook in 'next'.


* ds/sparse-cone (2020-01-04) 2 commits
  (merged to 'next' on 2020-01-04 at cc4b6fbb41)
 + Documentation/git-sparse-checkout.txt: fix a typo
 + sparse-checkout: use extern for global variables

 Code cleanup.

 Will merge to 'master'.


* en/merge-recursive-oid-eq-simplify (2020-01-02) 1 commit
  (merged to 'next' on 2020-01-04 at 623ecf4f16)
 + merge-recursive: remove unnecessary oid_eq function

 Code cleanup.

 Will merge to 'master'.


* jt/sha1-file-remove-oi-skip-cached (2020-01-02) 1 commit
  (merged to 'next' on 2020-01-04 at fab9964f10)
 + sha1-file: remove OBJECT_INFO_SKIP_CACHED

 has_object_file() said "no" given an object registered to the
 system via pretend_object_file(), making it inconsistent with
 read_object_file(), causing lazy fetch to attempt fetching an
 empty tree from promisor remotes.

 Will cook in 'next'.


* ds/commit-graph-set-size-mult (2020-01-02) 1 commit
  (merged to 'next' on 2020-01-04 at 71ea739a6c)
 + commit-graph: prefer default size_mult when given zero

 The code to write split commit-graph file(s) upon fetching computed
 bogus value for the parameter used in splitting the resulting
 files, which has been corrected.

 Will merge to 'master'.


* hw/commit-advise-while-rejecting (2019-12-19) 1 commit
  (merged to 'next' on 2019-12-30 at e26700d582)
 + commit: honor advice.statusHints when rejecting an empty commit

 "git commit" gives output similar to "git status" when there is
 nothing to commit, but without honoring the advise.statusHints
 configuration variable, which has been corrected.

 Will cook in 'next'.


* yz/p4-py3 (2019-12-17) 14 commits
  (merged to 'next' on 2019-12-30 at cd67de932d)
 + ci: also run linux-gcc pipeline with python3.5 environment
 + git-p4: use python3's input() everywhere
 + git-p4: simplify regex pattern generation for parsing diff-tree
 + git-p4: use dict.items() iteration for python3 compatibility
 + git-p4: use functools.reduce instead of reduce
 + git-p4: fix freezing while waiting for fast-import progress
 + git-p4: use marshal format version 2 when sending to p4
 + git-p4: open .gitp4-usercache.txt in text mode
 + git-p4: convert path to unicode before processing them
 + git-p4: encode/decode communication with git for python3
 + git-p4: encode/decode communication with p4 for python3
 + git-p4: remove string type aliasing
 + git-p4: change the expansion test from basestring to list
 + git-p4: make python2.7 the oldest supported version

 Update "git p4" to work with Python 3.

 Will cook in 'next'.


* hi/gpg-mintrustlevel (2019-12-27) 1 commit
  (merged to 'next' on 2019-12-30 at 6c790280d2)
 + gpg-interface: add minTrustLevel as a configuration option

 gpg.minTrustLevel configuration variable has been introduced to
 tell various signature verification codepaths the required minimum
 trust level.

 Will cook in 'next'.


* sg/completion-worktree (2019-12-19) 6 commits
  (merged to 'next' on 2019-12-25 at 42c895ab3b)
 + completion: list paths and refs for 'git worktree add'
 + completion: list existing working trees for 'git worktree' subcommands
 + completion: simplify completing 'git worktree' subcommands and options
 + completion: return the index of found word from __git_find_on_cmdline()
 + completion: clean up the __git_find_on_cmdline() helper function
 + t9902-completion: add tests for the __git_find_on_cmdline() helper

 The command line completion (in contrib/) learned to complete
 subcommands and arguments to "git worktree".

 Will cook in 'next'.


* dl/credential-netrc (2019-12-20) 2 commits
  (merged to 'next' on 2019-12-25 at 1fd27f81ac)
 + contrib/credential/netrc: work outside a repo
 + contrib/credential/netrc: make PERL_PATH configurable

 Sample credential helper for using .netrc has been updated to work
 out of the box.

 Will cook in 'next'.


* dl/test-must-fail-fixes (2019-12-20) 15 commits
  (merged to 'next' on 2019-12-25 at 3ef7c70bc5)
 + t1507: inline full_name()
 + t1507: run commands within test_expect_success
 + t1507: stop losing return codes of git commands
 + t1501: remove use of `test_might_fail cp`
 + t1409: use test_path_is_missing()
 + t1409: let sed open its own input file
 + t1307: reorder `nongit test_must_fail`
 + t1306: convert `test_might_fail rm` to `rm -f`
 + t0020: use ! check_packed_refs_marked
 + t0020: don't use `test_must_fail has_cr`
 + t0003: don't use `test_must_fail attr_check`
 + t0003: use test_must_be_empty()
 + t0003: use named parameters in attr_check()
 + t0000: replace test_must_fail with run_sub_test_lib_test_err()
 + t/lib-git-p4: use test_path_is_missing()

 Test clean-up.

 Will cook in 'next'.


* en/rebase-backend (2019-12-26) 15 commits
  (merged to 'next' on 2019-12-30 at 5b58e268d6)
 + rebase: change the default backend from "am" to "merge"
 + rebase: make the backend configurable via config setting
 + rebase tests: repeat some tests using the merge backend instead of am
 + rebase tests: mark tests specific to the am-backend with --am
 + git-prompt: change the prompt for interactive-based rebases
 + rebase: add an --am option
 + rebase: move incompatibility checks between backend options a bit earlier
 + git-rebase.txt: add more details about behavioral differences of backends
 + rebase: allow more types of rebases to fast-forward
 + t3432: make these tests work with either am or merge backends
 + rebase: fix handling of restrict_revision
 + rebase: make sure to pass along the quiet flag to the sequencer
 + rebase, sequencer: remove the broken GIT_QUIET handling
 + t3406: simplify an already simple test
 + rebase: extend the options for handling of empty commits

 "git rebase" has learned to use the sequencer backend by default,
 while allowing "--am" option to go back to the traditional "am"
 backend.

 Will cook in 'next'.


* bc/hash-independent-tests-part-7 (2019-12-24) 20 commits
  (merged to 'next' on 2019-12-30 at 0eedb894ba)
 + t5604: make hash independent
 + t5601: switch into repository to hash object
 + t5562: use $ZERO_OID
 + t5540: make hash size independent
 + t5537: make hash size independent
 + t5530: compute results based on object length
 + t5512: abstract away SHA-1-specific constants
 + t5510: make hash size independent
 + t5504: make hash algorithm independent
 + t5324: make hash size independent
 + t5319: make test work with SHA-256
 + t5319: change invalid offset for SHA-256 compatibility
 + t5318: update for SHA-256
 + t4300: abstract away SHA-1-specific constants
 + t4204: make hash size independent
 + t4202: abstract away SHA-1-specific constants
 + t4200: make hash size independent
 + t4134: compute appropriate length constant
 + t4066: compute index line in diffs
 + t4054: make hash-size independent

 Preparation of test scripts for the day when the object names will
 use SHA-256 continues.

 Will cook in 'next'.


* ew/packfile-syscall-optim (2019-12-26) 2 commits
  (merged to 'next' on 2019-12-30 at ada15abf22)
 + packfile: replace lseek+read with pread
 + packfile: remove redundant fcntl F_GETFD/F_SETFD

 Code cleanup.

 Will merge to 'master'.


* jn/test-lint-one-shot-export-to-shell-function (2019-12-27) 3 commits
  (merged to 'next' on 2019-12-30 at d08f039473)
 + fetch test: mark test of "skipping" haves as v0-only
 + t/check-non-portable-shell: detect "FOO= shell_func", too
 + fetch test: avoid use of "VAR= cmd" with a shell function
 (this branch is used by jn/promote-proto2-to-default.)

 The test-lint machinery knew to check "VAR=VAL shell_function"
 construct, but did not check "VAR= shell_funciton", which has been
 corrected.

 Will cook in 'next'.


* js/add-p-leftover-bits (2019-12-24) 9 commits
 - ci: include the built-in `git add -i` in the `linux-gcc` job
 - built-in add -p: handle Escape sequences more efficiently
 - built-in add -p: handle Escape sequences in interactive.singlekey mode
 - built-in add -p: respect the `interactive.singlekey` config setting
 - terminal: add a new function to read a single keystroke
 - terminal: accommodate Git for Windows' default terminal
 - terminal: make the code of disable_echo() reusable
 - built-in add -p: handle diff.algorithm
 - built-in add -p: support interactive.diffFilter
 (this branch uses js/patch-mode-in-others-in-c.)

 The final leg of rewriting "add -i/-p" in C.

 Will merge to 'next'.


* js/mingw-loosen-overstrict-tree-entry-checks (2020-01-02) 1 commit
  (merged to 'next' on 2020-01-02 at 3088a0ccf1)
 + mingw: only test index entries for backslashes, not tree entries

 An earlier update to Git for Windows declared that a tree object is
 invalid if it has a path component with backslash in it, which was
 overly strict, which has been corrected.  The only protection the
 Windows users need is to prevent such path (or any path that their
 filesystem cannot check out) from entering the index.

 Will merge to 'master'.


* pb/clarify-line-log-doc (2019-12-26) 2 commits
  (merged to 'next' on 2019-12-30 at 7a4e15a436)
 + doc: log, gitk: line-log arguments must exist in starting revision
 + doc: log, gitk: document accepted line-log diff formats

 Doc update.

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

 What's the status of this one?
 The tip two are still RFC.


* js/patch-mode-in-others-in-c (2019-12-21) 7 commits
  (merged to 'next' on 2019-12-30 at a767b89288)
 + commit --interactive: make it work with the built-in `add -i`
 + built-in add -p: implement the "worktree" patch modes
 + built-in add -p: implement the "checkout" patch modes
 + built-in stash: use the built-in `git add -p` if so configured
 + legacy stash -p: respect the add.interactive.usebuiltin setting
 + built-in add -p: implement the "stash" and "reset" patch modes
 + built-in add -p: prepare for patch modes other than "stage"
 (this branch is used by js/add-p-leftover-bits.)

 The effort to move "git-add--interactive" to C continues.

 Will cook in 'next'.


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


* bk/p4-exception-cleanup (2019-12-16) 2 commits
 . git-p4: failure because of RCS keywords should show help
 . git-p4: wrap patchRCSKeywords test to revert changes on failure

 Discarded for now without prejudice.




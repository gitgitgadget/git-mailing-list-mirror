Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E29C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE21624673
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SnN5f/wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAVWSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:18:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56980 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 17:18:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5132641333;
        Wed, 22 Jan 2020 17:18:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=a
        yDX2wytl0gnwzh8luKEUZ5DqhU=; b=SnN5f/wiTTRlShucu/k93QDjxFMCx61bG
        q+qRwk9ANBgVY2/0qv28eO9eg37/u6f8rPJWBO7adX7LWjA7WYKDzlTIdXAv9TA9
        vReXvl6uC48ZWdWW8GIrlUoqJYW9BEmpPJFHoxeLHbTrpq3f1B+vkk2JfxHvYAnj
        q8Eyn4qx/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=mtD
        AObrvA8FNqns0VE0MjzuMAoQ3Emr03MiS045waPyKHhxe36sj1DB5AKpu8WHIhKv
        VVZq+uD3cUvQZbaLIWFGumYWZXQjbVMLujTaM7xvCM8qunXEDCj49krlVX2Q9tl8
        WCwFY/d+nlmop0rOdpwgmC0AQni6t/YSyAhdGVUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4359141332;
        Wed, 22 Jan 2020 17:18:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 497DB41331;
        Wed, 22 Jan 2020 17:18:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2020, #04; Wed, 22)
X-master-at: 232378479ee6c66206d47a9be175e3a39682aea6
X-next-at: 3f081b084b0e55662871946d66dab3696a46a22a
Date:   Wed, 22 Jan 2020 14:18:05 -0800
Message-ID: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10ED0082-3D65-11EA-8337-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.25 is out.  The tip of 'next' has been rewound and a handful
of topics have been rebased to avoid the premature merge of
ra/rebase-i-more-options which has been reverted.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* do/gitweb-typofix-in-comments (2020-01-04) 1 commit
  (merged to 'next' on 2020-01-06 at 66ce6539c4)
 + gitweb: fix a couple spelling errors in comments

 Typofix.


* ds/graph-assert-fix (2020-01-08) 2 commits
  (merged to 'next' on 2020-01-08 at 4b896fb9b5)
 + graph: fix lack of color in horizontal lines
 + graph: drop assert() for merge with two collapsing parents
 (this branch is used by ds/graph-horizontal-edges.)

 Since recent updates to the log graph rendering code, drawing
 certain merges started triggering an assert on a condition that
 would no longer hold true, which has been corrected.


* jb/doc-multi-pack-idx-fix (2020-01-04) 1 commit
  (merged to 'next' on 2020-01-06 at f19f7d1016)
 + multi-pack-index: correct configuration in documentation

 Typofix.


* js/mingw-loosen-overstrict-tree-entry-checks (2020-01-10) 1 commit
  (merged to 'next' on 2020-01-10 at f43f0fe74b)
 + mingw: safeguard better against backslashes in file names

 Further tweak to a "no backslash in indexed paths" for Windows port
 we applied earlier.


* ma/config-advice-markup-fix (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-09 at 1c4b540795)
 + config/advice.txt: fix description list separator

 Documentation markup fix.


* pm/am-in-body-header-doc-update (2020-01-04) 1 commit
  (merged to 'next' on 2020-01-06 at 73b0a3a49c)
 + am: document that Date: can appear as an in-body header

 Doc update.


* tm/doc-submodule-absorb-fix (2020-01-06) 1 commit
  (merged to 'next' on 2020-01-07 at cee89422db)
 + doc: submodule: fix typo for command absorbgitdirs

 Typofix.

--------------------------------------------------
[New Topics]

* en/simplify-check-updates-in-unpack-trees (2020-01-07) 1 commit
  (merged to 'next' on 2020-01-15 at 586c055b69)
 + unpack-trees: exit check_updates() early if updates are not wanted

 Originally merged to 'next' on 2020-01-09

 Code simplification.

 Will merge to 'master'.


* en/string-list-can-be-custom-sorted (2020-01-07) 1 commit
  (merged to 'next' on 2020-01-15 at 2afe9536e6)
 + string-list: note in docs that callers can specify sorting function

 Originally merged to 'next' on 2020-01-09

 API-doc update.

 Will merge to 'master'.


* am/checkout-file-and-ref-ref-ambiguity (2020-01-07) 2 commits
 - checkout: don't revert file on ambiguous tracking branches
 - parse_branchname_arg(): extract part as new function

 "git checkout X" did not correctly fail when X is not a local
 branch but could name more than one remote-tracking branches
 (i.e. to be dwimmed as the starting point to create a corresponding
 local branch), which has been corrected.

 Will merge to 'next'.


* am/update-pathspec-f-f-tests (2020-01-15) 2 commits
 - t: directly test parse_pathspec_file()
 - t: fix quotes tests for --pathspec-from-file

 Test updates.

 Will merge to 'next'.


* bc/run-command-nullness-after-free-fix (2020-01-07) 1 commit
  (merged to 'next' on 2020-01-15 at 56b3148fee)
 + run-command: avoid undefined behavior in exists_in_PATH

 Originally merged to 'next' on 2020-01-09

 C pedantry ;-) fix.

 Will merge to 'master'.


* kw/fsmonitor-watchman-racefix (2020-01-13) 4 commits
 - fsmonitor: update documentation for hook version and watchman hooks
 - fsmonitor: add fsmonitor hook scripts for version 2
 - fsmonitor: handle version 2 of the hooks that will use opaque token
 - fsmonitor: change last update timestamp on the index_state to opaque token

 A new version of fsmonitor-watchman hook has been introduced, to
 avoid races.

 Will merge to 'next'.


* es/unpack-trees-oob-fix (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at 832ecf4366)
 + unpack-trees: watch for out-of-range index position

 Originally merged to 'next' on 2020-01-09

 The code that tries to skip over the entries for the paths in a
 single directory using the cache-tree was not careful enough
 against corrupt index file.

 Will merge to 'master'.


* hw/advice-add-nothing (2020-01-15) 1 commit
 - add: use advise function to display hints

 Two help messages given when "git add" notices the user gave it
 nothing to add have been updated to use advise() API.

 Will merge to 'next'.


* hw/tutorial-favor-switch-over-checkout (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at 25e4fca9ec)
 + doc/gitcore-tutorial: fix prose to match example command

 Originally merged to 'next' on 2020-01-09

 Complete an update to tutorial that encourages "git switch" over
 "git checkout" that was done only half-way.

 Will merge to 'master'.


* jk/no-flush-upon-disconnecting-slrpc-transport (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at 5014feacb0)
 + transport: don't flush when disconnecting stateless-rpc helper

 Originally merged to 'next' on 2020-01-09

 Reduce unnecessary round-trip when running "ls-remote" over the
 stateless RPC mechanism.

 Will merge to 'master'.


* nd/switch-and-restore (2020-01-08) 1 commit
  (merged to 'next' on 2020-01-15 at ffd0b1e54e)
 + restore: invalidate cache-tree when removing entries with --staged

 Originally merged to 'next' on 2020-01-09

 "git restore --staged" did not correctly update the cache-tree
 structure, resulting in bogus trees to be written afterwards, which
 has been corrected.

 Will merge to 'master'.


* ds/graph-horizontal-edges (2020-01-15) 2 commits
 - graph: fix collapse of multiple edges
 - graph: add test to demonstrate horizontal line bug

 Rendering by "git log --graph" of ancestry lines leading to a merge
 commit were made suboptimal to waste vertical space a bit with a
 recent update, which has been corrected.

 Will merge to 'next'.


* ds/sparse-cone (2020-01-10) 1 commit
 - unpack-trees: correctly compute result count

 The code recently added in this release to move to the entry beyond
 the ones in the same directory in the index in the sparse-cone mode
 did not count the number of entries to skip over incorrectly, which
 has been corrected.

 Will merge to 'next'.


* km/submodule-add-errmsg (2020-01-15) 1 commit
 - submodule add: show 'add --dry-run' stderr when aborting

 Improve error message generation for "git submodule add".

 Will merge to 'next'.


* en/fill-directory-fixes-more (2020-01-16) 4 commits
 - dir: point treat_leading_path() warning to the right place
 - dir: restructure in a way to avoid passing around a struct dirent
 - dir: treat_leading_path() and read_directory_recursive(), round 2
 - clean: demonstrate a bug with pathspecs

 Corner case bugs in "git clean" that stems from a (necessarily for
 performance reasons) awkward calling convention in the directory
 enumeration API has been corrected.

 Will merge to 'next'.


* es/fetch-show-failed-submodules-atend (2020-01-17) 1 commit
 - fetch: emphasize failure during submodule fetch

 A fetch that is told to recursively fetch updates in submodules
 inevitably produces reams of output, and it becomes hard to spot
 error messages.  The command has been taught to enumerate
 submodules that had errors at the end of the operation.

 Will merge to 'next'.


* jk/asan-build-fix (2020-01-16) 1 commit
 - Makefile: use compat regex with SANITIZE=address

 Work around test breakages caused by custom regex engine used in
 libasan, when address sanitizer is used with more recent versions
 of gcc and clang.

 Will merge to 'next'.


* jk/test-fixes (2020-01-16) 2 commits
 - t7800: don't rely on reuse_worktree_file()
 - t4018: drop "debugging" cat from hunk-header tests

 Test fixes.

 Will merge to 'next'.


* js/builtin-add-i-cmds (2020-01-16) 2 commits
 - built-in add -i: accept open-ended ranges again
 - built-in add -i: do not try to `patch`/`diff` an empty list of files

 Minor bugfixes to "git add -i" that has recently been rewritten in C.

 Will merge to 'next'.


* rt/submodule-i18n (2020-01-16) 1 commit
 - submodule.c: mark more strings for translation

 Comments update.

 Will merge to 'next'.


* am/pathspec-f-f-more (2020-01-21) 8 commits
 - stash push: support the --pathspec-from-file option
 - stash: eliminate crude option parsing
 - doc: stash: synchronize <pathspec> description
 - doc: stash: document more options
 - doc: stash: split options from description (2)
 - doc: stash: split options from description (1)
 - rm: support the --pathspec-from-file option
 - doc: rm: synchronize <pathspec> description

 "git rm" and "git stash" learns the new "--pathspec-from-file"
 option.


* bc/actualmente (2020-01-21) 1 commit
 - docs: use "currently" for the present time

 Doc grammo fix.

 Will merge to 'next'.


* bc/author-committer-doc (2020-01-22) 3 commits
 - doc: provide guidance on user.name format
 - docs: expand on possible and recommended user config options
 - doc: move author and committer information to git-commit(1)

 Clarify documentation on committer/author identities.

 Will merge to 'next'.


* bc/misconception-doc (2020-01-22) 2 commits
 - docs: mention when increasing http.postBuffer is valuable
 - doc: dissuade users from trying to ignore tracked files

 Doc updates.

 Will merge to 'next'.


* ds/refmap-doc (2020-01-21) 1 commit
 - fetch: document and test --refmap=""

 "git fetch --refmap=" option has got a better documentation.

 Will merge to 'next'.


* js/rebase-i-with-colliding-hash (2020-01-21) 3 commits
 - rebase -i: also avoid SHA-1 collisions with missingCommitsCheck
 - rebase -i: re-fix short SHA-1 collision
 - parse_insn_line(): improve error message when parsing failed


* lh/bool-to-type-bool (2020-01-21) 1 commit
 - templates: fix deprecated type option `--bool`

 Replace "git config --bool" calls with "git config --type=bool" in
 sample templates.

 Will merge to 'next'.


* pb/recurse-submodule-in-worktree-fix (2020-01-22) 4 commits
 - submodule.c: use get_git_dir() instead of get_git_common_dir()
 - t2405: clarify test descriptions and simplify test
 - t2405: use git -C and test_commit -C instead of subshells
 - t7410: rename to t2405-worktree-submodule.sh

 The "--recurse-submodules" option of various subcommands did not
 work well when run in an alternate worktree, which has been
 corrected.

 Will merge to 'next'.


* ss/t6025-modernize (2020-01-21) 2 commits
 - t6025: use helpers to replace test -f <path>
 - t6025: modernize style

 Test style updates.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ag/edit-todo-drop-check (2019-12-06) 2 commits
 - rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
 - sequencer: move check_todo_list_from_file() to rebase-interactive.c

 Allow the rebase.missingCommitsCheck configuration to kick in when
 "rebase --edit-todo" and "rebase --continue" restarts the procedure.

 Broken.
 cf. <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>


* es/pathspec-f-f-grep (2020-01-13) 1 commit
 - grep: support the --pathspec-from-file option

 "git grep" learned the "--pathspec-from-file" command line
 option.

 Getting tired of waiting for review responses.  Will discard.
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

* mt/threaded-grep-in-object-store (2020-01-17) 12 commits
 - grep: use no. of cores as the default no. of threads
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


* hi/indent-text-with-tabs-in-editorconfig (2020-01-06) 1 commit
 - editorconfig: indent text files with tabs

 Tell .editorconfig that in this project, *.txt files are indented
 with tabs.

 Will merge to 'next'.


* jn/pretend-object-doc (2020-01-06) 1 commit
 - sha1-file: document how to use pretend_object_file

 Warn programmers about pretend_object_file() that allows the code
 to tentatively use in-core objects.


* en/unpack-trees-check-updates-simplify (2020-01-04) 1 commit
 - unpack-trees: exit check_updates() early if updates are not wanted

 Code simplification.

 Will merge to 'next'.


* dl/merge-autostash (2020-01-13) 17 commits
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

 What's the status of this one?  Are people happy with the shape of
 the code?


* dl/test-must-fail-fixes-2 (2020-01-07) 16 commits
 - t4124: only mark git command with test_must_fail
 - t3507: use test_path_is_missing()
 - t3507: fix indentation
 - t3504: do check for conflict marker after failed cherry-pick
 - t3419: stop losing return code of git command
 - t3415: increase granularity of test_auto_{fixup,squash}()
 - t3415: stop losing return codes of git commands
 - t3310: extract common notes_merge_files_gone()
 - t3030: use test_path_is_missing()
 - t2018: replace "sha" with "oid"
 - t2018: don't lose return code of git commands
 - t2018: teach do_checkout() to accept `!` arg
 - t2018: use test_expect_code for failing git commands
 - t2018: improve style of if-statement
 - t2018: add space between function name and ()
 - t2018: remove trailing space from test description

 Test updates.

 Will merge to 'next'.


* jn/promote-proto2-to-default (2020-01-15) 5 commits
 - fetch: default to protocol version 2
 - protocol test: let protocol.version override GIT_TEST_PROTOCOL_VERSION
 - test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate
 - config doc: protocol.version is not experimental
 - fetch test: use more robust test for filtered objects
 (this branch uses jn/test-lint-one-shot-export-to-shell-function.)

 The transport protocol version 2 becomes the default one.

 Will merge to 'next'.


* am/test-pathspec-f-f-error-cases (2020-01-15) 1 commit
 - t: add tests for error conditions with --pathspec-from-file

 More tests.

 Will merge to 'next'.


* jt/sha1-file-remove-oi-skip-cached (2020-01-02) 1 commit
  (merged to 'next' on 2020-01-15 at 4feaff54f3)
 + sha1-file: remove OBJECT_INFO_SKIP_CACHED

 Originally merged to 'next' on 2020-01-04

 has_object_file() said "no" given an object registered to the
 system via pretend_object_file(), making it inconsistent with
 read_object_file(), causing lazy fetch to attempt fetching an
 empty tree from promisor remotes.

 Will merge to 'master'.


* hw/commit-advise-while-rejecting (2019-12-19) 1 commit
  (merged to 'next' on 2020-01-15 at 4f16e5a3b6)
 + commit: honor advice.statusHints when rejecting an empty commit

 Originally merged to 'next' on 2019-12-30

 "git commit" gives output similar to "git status" when there is
 nothing to commit, but without honoring the advise.statusHints
 configuration variable, which has been corrected.

 Will merge to 'master'.


* yz/p4-py3 (2020-01-15) 14 commits
 - ci: also run linux-gcc pipeline with python3.5 environment
 - git-p4: use python3's input() everywhere
 - git-p4: simplify regex pattern generation for parsing diff-tree
 - git-p4: use dict.items() iteration for python3 compatibility
 - git-p4: use functools.reduce instead of reduce
 - git-p4: fix freezing while waiting for fast-import progress
 - git-p4: use marshal format version 2 when sending to p4
 - git-p4: open .gitp4-usercache.txt in text mode
 - git-p4: convert path to unicode before processing them
 - git-p4: encode/decode communication with git for python3
 - git-p4: encode/decode communication with p4 for python3
 - git-p4: remove string type aliasing
 - git-p4: change the expansion test from basestring to list
 - git-p4: make python2.7 the oldest supported version

 Update "git p4" to work with Python 3.

 Will merge to 'next'.


* hi/gpg-mintrustlevel (2020-01-15) 1 commit
 - gpg-interface: add minTrustLevel as a configuration option

 gpg.minTrustLevel configuration variable has been introduced to
 tell various signature verification codepaths the required minimum
 trust level.

 Will merge to 'next'.


* sg/completion-worktree (2020-01-15) 6 commits
 - completion: list paths and refs for 'git worktree add'
 - completion: list existing working trees for 'git worktree' subcommands
 - completion: simplify completing 'git worktree' subcommands and options
 - completion: return the index of found word from __git_find_on_cmdline()
 - completion: clean up the __git_find_on_cmdline() helper function
 - t9902-completion: add tests for the __git_find_on_cmdline() helper

 The command line completion (in contrib/) learned to complete
 subcommands and arguments to "git worktree".

 Will merge to 'next'.


* dl/credential-netrc (2019-12-20) 2 commits
  (merged to 'next' on 2020-01-15 at 768fa1c364)
 + contrib/credential/netrc: work outside a repo
 + contrib/credential/netrc: make PERL_PATH configurable

 Originally merged to 'next' on 2019-12-25

 Sample credential helper for using .netrc has been updated to work
 out of the box.

 Will merge to 'master'.


* dl/test-must-fail-fixes (2019-12-20) 15 commits
 - t1507: inline full_name()
 - t1507: run commands within test_expect_success
 - t1507: stop losing return codes of git commands
 - t1501: remove use of `test_might_fail cp`
 - t1409: use test_path_is_missing()
 - t1409: let sed open its own input file
 - t1307: reorder `nongit test_must_fail`
 - t1306: convert `test_might_fail rm` to `rm -f`
 - t0020: use ! check_packed_refs_marked
 - t0020: don't use `test_must_fail has_cr`
 - t0003: don't use `test_must_fail attr_check`
 - t0003: use test_must_be_empty()
 - t0003: use named parameters in attr_check()
 - t0000: replace test_must_fail with run_sub_test_lib_test_err()
 - t/lib-git-p4: use test_path_is_missing()

 Test clean-up.

 Will merge to 'next'.


* en/rebase-backend (2020-01-17) 19 commits
 - rebase: change the default backend from "am" to "merge"
 - rebase: make the backend configurable via config setting
 - rebase tests: repeat some tests using the merge backend instead of am
 - rebase tests: mark tests specific to the am-backend with --am
 - rebase: drop '-i' from the reflog for interactive-based rebases
 - git-prompt: change the prompt for interactive-based rebases
 - rebase: add an --am option
 - rebase: move incompatibility checks between backend options a bit earlier
 - git-rebase.txt: add more details about behavioral differences of backends
 - rebase: allow more types of rebases to fast-forward
 - t3432: make these tests work with either am or merge backends
 - rebase: fix handling of restrict_revision
 - rebase: make sure to pass along the quiet flag to the sequencer
 - rebase, sequencer: remove the broken GIT_QUIET handling
 - t3406: simplify an already simple test
 - rebase (interactive-backend): fix handling of commits that become empty
 - rebase (interactive-backend): make --keep-empty the default
 - t3404: directly test the behavior of interest
 - git-rebase.txt: update description of --allow-empty-message

 "git rebase" has learned to use the sequencer backend by default,
 while allowing "--am" option to go back to the traditional "am"
 backend.


* bc/hash-independent-tests-part-7 (2020-01-15) 20 commits
 - t5604: make hash independent
 - t5601: switch into repository to hash object
 - t5562: use $ZERO_OID
 - t5540: make hash size independent
 - t5537: make hash size independent
 - t5530: compute results based on object length
 - t5512: abstract away SHA-1-specific constants
 - t5510: make hash size independent
 - t5504: make hash algorithm independent
 - t5324: make hash size independent
 - t5319: make test work with SHA-256
 - t5319: change invalid offset for SHA-256 compatibility
 - t5318: update for SHA-256
 - t4300: abstract away SHA-1-specific constants
 - t4204: make hash size independent
 - t4202: abstract away SHA-1-specific constants
 - t4200: make hash size independent
 - t4134: compute appropriate length constant
 - t4066: compute index line in diffs
 - t4054: make hash-size independent

 Preparation of test scripts for the day when the object names will
 use SHA-256 continues.

 Will merge to 'next'.


* jn/test-lint-one-shot-export-to-shell-function (2020-01-15) 3 commits
 - fetch test: mark test of "skipping" haves as v0-only
 - t/check-non-portable-shell: detect "FOO= shell_func", too
 - fetch test: avoid use of "VAR= cmd" with a shell function
 (this branch is used by jn/promote-proto2-to-default.)

 The test-lint machinery knew to check "VAR=VAL shell_function"
 construct, but did not check "VAR= shell_funciton", which has been
 corrected.

 Will merge to 'next'.


* js/add-p-leftover-bits (2020-01-15) 10 commits
 - ci: include the built-in `git add -i` in the `linux-gcc` job
 - built-in add -p: handle Escape sequences more efficiently
 - built-in add -p: handle Escape sequences in interactive.singlekey mode
 - built-in add -p: respect the `interactive.singlekey` config setting
 - terminal: add a new function to read a single keystroke
 - terminal: accommodate Git for Windows' default terminal
 - terminal: make the code of disable_echo() reusable
 - built-in add -p: handle diff.algorithm
 - built-in add -p: support interactive.diffFilter
 - t3701: adjust difffilter test
 (this branch uses js/patch-mode-in-others-in-c.)

 The final leg of rewriting "add -i/-p" in C.

 Will merge to 'next'.


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
 - commit --interactive: make it work with the built-in `add -i`
 - built-in add -p: implement the "worktree" patch modes
 - built-in add -p: implement the "checkout" patch modes
 - built-in stash: use the built-in `git add -p` if so configured
 - legacy stash -p: respect the add.interactive.usebuiltin setting
 - built-in add -p: implement the "stash" and "reset" patch modes
 - built-in add -p: prepare for patch modes other than "stage"
 (this branch is used by js/add-p-leftover-bits.)

 The effort to move "git-add--interactive" to C continues.

 Will merge to 'next'.


* jk/packfile-reuse-cleanup (2019-10-23) 9 commits
 - pack-objects: improve partial packfile reuse
 - builtin/pack-objects: introduce obj_is_packed()
 - pack-objects: introduce pack.allowPackReuse
 - csum-file: introduce hashfile_total()
 - pack-bitmap: introduce bitmap_walk_contains()
 - pack-bitmap: don't rely on bitmap_git->reuse_objects
 - ewah/bitmap: introduce bitmap_word_alloc()
 - packfile: expose get_delta_base()
 - builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.

 Needs further clarification?
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

Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721C5C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E66206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VJ3PiruJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfLZVjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:39:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61622 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 16:39:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13D57A8EA6;
        Thu, 26 Dec 2019 16:39:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
        /oU+CkwC7dCIdAtoHc+rS0enDQ=; b=VJ3PiruJY/Ozdvl6M3kmRIlCSxtVZKtHH
        JJUe3bB9pOmvuFNEJPOm2F6INL7STNKMUsDGfVgTJN4c/5t7D+EtKiR6rLurXgDP
        KIZhfP5ZFDBS1fnmrWKmqepqUOgYN05lA5f6FT79daM7Z1bBux97yl//zp4MG4sE
        iCmz9NStJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Jlz
        IeSXuH0Qh9ebLALbWm3c++8I0VqZP1wdZ0wB9nRfF/HSIniloKdutj4tzan5nmlr
        MsbXlHpt1iaSzmJtqhkgt73gYd7K5tkxjewgZ6Tz+qapN7yiM+F7CSWjyqTGHSDl
        gn9nguNnwZ9FcxDVS3S9eX+oLbSJETz36SSsES1Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B769A8EA5;
        Thu, 26 Dec 2019 16:39:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 04E2AA8EA3;
        Thu, 26 Dec 2019 16:39:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2019, #05; Thu, 26)
X-master-at: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
X-next-at: ca9f1ec99ff3ed584eec58c085a342c9c37d2919
Date:   Thu, 26 Dec 2019 13:39:16 -0800
Message-ID: <xmqqk16ikbqz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C021D6E-2828-11EA-B921-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The early preview for the upcoming Git 2.25 has been tagged.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

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


* am/pathspec-from-file (2019-12-18) 1 commit
  (merged to 'next' on 2019-12-19 at e250cc9b88)
 + commit: forbid --pathspec-from-file --all

 An earlier series to teach "--pathspec-from-file" to "git commit"
 forgot to make the option incompatible with "--all", which has been
 corrected.


* dl/format-patch-notes-config-fixup (2019-12-18) 8 commits
  (merged to 'next' on 2019-12-19 at 1abc6941e0)
 + notes.h: fix typos in comment
  (merged to 'next' on 2019-12-16 at e4da5b93bb)
 + notes: break set_display_notes() into smaller functions
 + config/format.txt: clarify behavior of multiple format.notes
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


* ds/sparse-cone (2019-12-20) 21 commits
  (merged to 'next' on 2019-12-20 at 4f33a10613)
 + sparse-checkout: improve OS ls compatibility
  (merged to 'next' on 2019-12-16 at c840c1d816)
 + sparse-checkout: respect core.ignoreCase in cone mode
 + sparse-checkout: check for dirty status
 + sparse-checkout: update working directory in-process for 'init'
 + sparse-checkout: cone mode should not interact with .gitignore
 + sparse-checkout: write using lockfile
 + sparse-checkout: use in-process update for disable subcommand
 + sparse-checkout: update working directory in-process
 + sparse-checkout: sanitize for nested folders
 + unpack-trees: add progress to clear_ce_flags()
 + unpack-trees: hash less in cone mode
 + sparse-checkout: init and set in cone mode
 + sparse-checkout: use hashmaps for cone patterns
 + sparse-checkout: add 'cone' mode
 + trace2: add region in clear_ce_flags
 + sparse-checkout: create 'disable' subcommand
 + sparse-checkout: add '--stdin' option to set subcommand
 + sparse-checkout: 'set' subcommand
 + clone: add --sparse mode
 + sparse-checkout: create 'init' subcommand
 + sparse-checkout: create builtin with 'list' subcommand

 Management of sparsely checked-out working tree has gained a
 dedicated "sparse-checkout" command.


* en/fill-directory-fixes (2019-12-20) 9 commits
  (merged to 'next' on 2019-12-20 at 671cf755f4)
 + dir.c: use st_add3() for allocation size
  (merged to 'next' on 2019-12-19 at 80ad3150d6)
 + dir: consolidate similar code in treat_directory()
 + dir: synchronize treat_leading_path() and read_directory_recursive()
 + dir: fix checks on common prefix directory
 + dir: break part of read_directory_recursive() out for reuse
 + dir: exit before wildcard fall-through if there is no wildcard
 + dir: remove stray quote character in comment
 + Revert "dir.c: make 'git-status --ignored' work within leading directories"
 + t3011: demonstrate directory traversal failures

 Assorted fixes to the directory traversal API.


* ja/doc-markup-cleanup (2019-12-13) 2 commits
  (merged to 'next' on 2019-12-19 at 61abb4a06d)
 + doc: indent multi-line items in list
 + doc: remove non pure ASCII characters

 Doc cleanup.


* jc/drop-gen-hdrs (2019-12-13) 1 commit
  (merged to 'next' on 2019-12-19 at 4867cc601b)
 + Makefile: drop GEN_HDRS

 Code cleanup.


* js/add-p-in-c (2019-12-13) 19 commits
  (merged to 'next' on 2019-12-19 at c0deed90ab)
 + built-in add -p: show helpful hint when nothing can be staged
 + built-in add -p: only show the applicable parts of the help text
 + built-in add -p: implement the 'q' ("quit") command
 + built-in add -p: implement the '/' ("search regex") command
 + built-in add -p: implement the 'g' ("goto") command
 + built-in add -p: implement hunk editing
 + strbuf: add a helper function to call the editor "on an strbuf"
 + built-in add -p: coalesce hunks after splitting them
 + built-in add -p: implement the hunk splitting feature
 + built-in add -p: show different prompts for mode changes and deletions
 + built-in app -p: allow selecting a mode change as a "hunk"
 + built-in add -p: handle deleted empty files
 + built-in add -p: support multi-file diffs
 + built-in add -p: offer a helpful error message when hunk navigation failed
 + built-in add -p: color the prompt and the help text
 + built-in add -p: adjust hunk headers as needed
 + built-in add -p: show colored hunks by default
 + built-in add -i: wire up the new C code for the `patch` command
 + built-in add -i: start implementing the `patch` functionality in C
 (this branch is used by js/patch-mode-in-others-in-c.)

 The effort to move "git-add--interactive" to C continues.


* ln/userdiff-elixir (2019-12-13) 1 commit
  (merged to 'next' on 2019-12-17 at fcd1f5f18b)
 + userdiff: remove empty subexpression from elixir regex

 Hotfix.


* mr/bisect-save-pointer-to-const-string (2019-12-17) 1 commit
  (merged to 'next' on 2019-12-19 at 03bb33ae74)
 + bisect--helper: convert `*_warning` char pointers to char arrays.

 Code cleanup.


* mr/bisect-use-after-free (2019-12-11) 1 commit
  (merged to 'next' on 2019-12-17 at 64cd5c4622)
 + bisect--helper: avoid use-after-free

 Use-after-free fix.


* pb/submodule-doc-xref (2019-12-11) 1 commit
  (merged to 'next' on 2019-12-19 at 3b52089f77)
 + gitmodules: link to gitsubmodules guide

 Doc update.


* ra/t5150-depends-on-perl (2019-11-27) 1 commit
  (merged to 'next' on 2019-12-16 at 69bb280692)
 + t5150: skip request-pull test if Perl is disabled

 Some Porcelain commands are written in Perl, and tests on them are
 expected not to work when the platform lacks a working perl.


* rb/p4-lfs (2019-12-11) 1 commit
  (merged to 'next' on 2019-12-19 at 0e6e76a524)
 + git-p4: honor lfs.storage configuration variable

 "git p4" used to ignore lfs.storage configuration variable, which
 has been corrected.


* rs/ref-read-cleanup (2019-12-11) 2 commits
  (merged to 'next' on 2019-12-19 at 9eb61e8d53)
 + remote: pass NULL to read_ref_full() because object ID is not needed
 + refs: pass NULL to refs_read_ref_full() because object ID is not needed

 Code cleanup.


* rs/test-cleanup (2019-12-18) 5 commits
  (merged to 'next' on 2019-12-19 at 116f80bacd)
 + t6030: don't create unused file
 + t5580: don't create unused file
 + t3501: don't create unused file
 + t7004: don't create unused file
 + t4256: don't create unused file

 Test cleanup.


* rs/xdiff-ignore-ws-w-func-context (2019-12-19) 1 commit
  (merged to 'next' on 2019-12-19 at 9e0cb7aa55)
 + t4015: improve coverage of function context test

 Extend test coverage for a recent fix.


* sg/name-rev-wo-recursion (2019-12-09) 14 commits
  (merged to 'next' on 2019-12-16 at ce57cd054f)
 + name-rev: cleanup name_ref()
 + name-rev: eliminate recursion in name_rev()
 + name-rev: use 'name->tip_name' instead of 'tip_name'
 + name-rev: drop name_rev()'s 'generation' and 'distance' parameters
 + name-rev: restructure creating/updating 'struct rev_name' instances
 + name-rev: restructure parsing commits and applying date cutoff
 + name-rev: pull out deref handling from the recursion
 + name-rev: extract creating/updating a 'struct name_rev' into a helper
 + t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
 + name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
 + name-rev: avoid unnecessary cast in name_ref()
 + name-rev: use strbuf_strip_suffix() in get_rev_name()
 + t6120-describe: modernize the 'check_describe' helper
 + t6120-describe: correct test repo history graph in comment

 Redo "git name-rev" to avoid recursive calls.

--------------------------------------------------
[New Topics]

* hw/commit-advise-while-rejecting (2019-12-19) 1 commit
 - commit: honor advice.statusHints when rejecting an empty commit

 "git commit" gives output similar to "git status" when there is
 nothing to commit, but without honoring the advise.statusHints
 configuration variable, which has been corrected.


* yz/p4-py3 (2019-12-17) 14 commits
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


* hi/gpg-mintrustlevel (2019-12-24) 1 commit
 - gpg-interface: add minTrustLevel as a configuration option

 gpg.minTrustLevel configuration variable has been introduced to
 tell various signature verification codepaths the required minimum
 trust level.

 Will merge to 'next'.


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


* em/freebsd-cirrus-ci (2019-12-20) 1 commit
  (merged to 'next' on 2019-12-25 at b6b609fbf0)
 + CI: add FreeBSD CI support via Cirrus-CI

 Will merge to 'master'.


* en/rebase-backend (2019-12-26) 15 commits
 - rebase: change the default backend from "am" to "merge"
 - rebase: make the backend configurable via config setting
 - rebase tests: repeat some tests using the merge backend instead of am
 - rebase tests: mark tests specific to the am-backend with --am
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
 - rebase: extend the options for handling of empty commits

 "git rebase" has learned to use the sequencer backend by default,
 while allowing "--am" option to go back to the traditional "am"
 backend.


* en/rebase-signoff-fix (2019-12-20) 1 commit
  (merged to 'next' on 2019-12-25 at 96d84920b5)
 + rebase: fix saving of --signoff state for am-based rebases

 "git rebase --signoff" stopped working when the command was written
 in C, which has been corrected.

 Will merge to 'master'.


* bc/hash-independent-tests-part-7 (2019-12-24) 20 commits
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


* js/mingw-reserved-filenames (2019-12-21) 2 commits
 - mingw: refuse paths containing reserved names
 - mingw: short-circuit the conversion of `/dev/null` to UTF-16

 Forbid pathnames that the platform's filesystem cannot represent on
 MinGW.

 Will merge to 'next' and then to 'master'.


* bk/p4-exception-cleanup (2019-12-16) 2 commits
 - git-p4: failure because of RCS keywords should show help
 - git-p4: wrap patchRCSKeywords test to revert changes on failure
 (this branch uses bk/p4-misc-usability.)


* ew/packfile-syscall-optim (2019-12-26) 2 commits
 - packfile: replace lseek+read with pread
 - packfile: remove redundant fcntl F_GETFD/F_SETFD

 Code cleanup.

 Will merge to 'next'.


* jn/test-lint-one-shot-export-to-shell-function (2019-12-26) 2 commits
 - t/check-non-portable-shell: detect "FOO= shell_func", too
 - fetch test: avoid use of "VAR= cmd" with a shell function
 (this branch is used by jn/promote-proto2-to-default.)

 The test-lint machinery knew to check "VAR=VAL shell_function"
 construct, but did not check "VAR= shell_funciton", which has been
 corrected.

 Will merge to 'next'.


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


* js/mingw-loosen-overstrict-tree-entry-checks (2019-12-26) 1 commit
 - mingw: only test index entries for backslashes, not tree entries

 An earlier update to Git for Windows declared that a tree object is
 invalid if it has a path component with backslash in it, which was
 overly strict, which has been corrected.  The only protection the
 Windows users need is to prevent such path (or any path that their
 filesystem cannot check out) from entering the index.



* pb/clarify-line-log-doc (2019-12-26) 2 commits
 - doc: log, gitk: line-log arguments must exist in starting revision
 - doc: log, gitk: document accepted line-log diff formats

 Doc update.

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


* bk/p4-misc-usability (2019-12-16) 2 commits
  (merged to 'next' on 2019-12-25 at b4789bcb08)
 + git-p4: show detailed help when parsing options fail
 + git-p4: yes/no prompts should sanitize user text
 (this branch is used by bk/p4-exception-cleanup.)

 Miscellaneous small UX improvements on "git-p4".

 Will merge to 'master'.


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

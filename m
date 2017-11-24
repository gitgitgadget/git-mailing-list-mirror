Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD7C2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 14:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbdKXODq (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 09:03:46 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:56883 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753710AbdKXODn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 09:03:43 -0500
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 46E4C16D66;
        Fri, 24 Nov 2017 09:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=P
        e05vyF215uwNSSldV9AHwxwM0g=; b=Qu6TPgsSGYjnPHY9Huh4YN496JAbA7sXP
        E5ugQaqIr71r+g5PBA9Xdo5rjNKq4R83QK7uvpVNhkXEy+c37IC72PwqVZumqC3c
        Gvw7kH3wxxddtwcD0HnWACPlzl4zOtXI37LoL2/DC23nCNCakRMI478ZlRryCIrO
        WDB6mH4DKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=v7n
        IC9X5RyfBPGrAwOcYCE0Q8QRxMiMJXhcU22fsHaYHqHV4+8XCIptbcO89QEyjUT5
        H6NVNe2W9Mb86y5UnuMC4JoSg5ycCBkSV6ddMhNhvj80nyne19erCkLJ+Dve0W5L
        cq6LKxBbLIOigmLcFGtir2yqsJNi1jZbY+bGW13M=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 229B416D65;
        Fri, 24 Nov 2017 09:03:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2460FB2080;
        Fri, 24 Nov 2017 09:03:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2017, #07; Fri, 24)
X-master-at: 14c63a9dc093d6738454f6369a4f5663ca732cf7
X-next-at: b06021eebab0504f6c8e11598ad9be6115ba037d
Date:   Fri, 24 Nov 2017 23:03:36 +0900
Message-ID: <xmqq7eufn58n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44D8B250-D120-11E7-8EC2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Quite a few "fixes" have been accumulated on 'master' and already
merged to 'maint' in preparation for 2.15.1; perhaps we can tag it
near the end of the month--no fix in the mix is an ultra urgent one.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* en/rename-directory-detection (2017-11-21) 33 commits
 - merge-recursive: ensure we write updates for directory-renamed file
 - merge-recursive: avoid spurious rename/rename conflict from dir renames
 - directory rename detection: new testcases showcasing a pair of bugs
 - merge-recursive: fix remaining directory rename + dirty overwrite cases
 - merge-recursive: fix overwriting dirty files involved in renames
 - merge-recursive: avoid clobbering untracked files with directory renames
 - merge-recursive: apply necessary modifications for directory renames
 - merge-recursive: when comparing files, don't include trees
 - merge-recursive: check for file level conflicts then get new name
 - merge-recursive: add computation of collisions due to dir rename & merging
 - merge-recursive: add a new hashmap for storing file collisions
 - merge-recursive: check for directory level conflicts
 - merge-recursive: add get_directory_renames()
 - merge-recursive: add a new hashmap for storing directory renames
 - merge-recursive: split out code for determining diff_filepairs
 - merge-recursive: make !o->detect_rename codepath more obvious
 - merge-recursive: fix leaks of allocated renames and diff_filepairs
 - merge-recursive: introduce new functions to handle rename logic
 - merge-recursive: move the get_renames() function
 - directory rename detection: tests for handling overwriting dirty files
 - directory rename detection: tests for handling overwriting untracked files
 - directory rename detection: miscellaneous testcases to complete coverage
 - directory rename detection: testcases exploring possibly suboptimal merges
 - directory rename detection: more involved edge/corner testcases
 - directory rename detection: testcases checking which side did the rename
 - directory rename detection: files/directories in the way of some renames
 - directory rename detection: partially renamed directory testcase/discussion
 - directory rename detection: testcases to avoid taking detection too far
 - directory rename detection: directory splitting testcases
 - directory rename detection: basic testcases
 - merge-recursive: add explanation for src_entry and dst_entry
 - merge-recursive: fix logic ordering issue
 - Tighten and correct a few testcases for merging and cherry-picking

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.

 Needs review.


* ac/complete-pull-autostash (2017-11-22) 1 commit
 - completion: add --autostash and --no-autostash to pull

 The shell completion (in contrib/) learned that "git pull" can take
 the "--autostash" option.

 Will merge to 'next'.


* cc/git-packet-pm (2017-11-22) 2 commits
 - Git/Packet.pm: use 'if' instead of 'unless'
 - Git/Packet: clarify that packet_required_key_val_read allows EOF

 Code clean-up.

 Will merge to 'next'.


* jn/reproducible-build (2017-11-22) 3 commits
 - Merge branch 'jn/reproducible-build' of ../git-gui into jn/reproducible-build
 - git-gui: sort entries in optimized tclIndex
 - generate-cmdlist: avoid non-deterministic output

 The build procedure has been taught to avoid some unnecessary
 instability in the build products.

 Will merge to 'next'.


* jt/submodule-tests-cleanup (2017-11-22) 1 commit
 - Tests: clean up submodule recursive helpers

 Further test clean-up.

 Will merge to 'next'.


* rd/man-prune-progress (2017-11-22) 1 commit
 - prune: add "--progress" to man page and usage msg

 Doc update.

 Will merge to 'next'.


* rd/man-reflog-add-n (2017-11-22) 1 commit
 - doc: add missing "-n" (dry-run) option to reflog man page

 Doc update.

 Will merge to 'next'.


* ph/stash-save-m-option-fix (2017-11-24) 1 commit
 - stash: learn to parse -m/--message like commit does

 In addition to "git stash -m message", the command learned to
 accept "git stash -mmessage" form.

 Will merge to 'next'.


* ra/decorate-limit-refs (2017-11-22) 1 commit
 - log: add option to choose which refs to decorate

 The tagnames "git log --decorate" uses to annotate the commits can
 now be limited to subset of available refs with the two additional
 options, --decorate-refs[-exclude]=<pattern>.

 Will merge to 'next'.


* rd/doc-notes-prune-fix (2017-11-22) 1 commit
 - notes: correct 'git notes prune' options to '[-n] [-v]'

 Doc update.

 Will merge to 'next'.


* tg/deprecate-stash-save (2017-11-22) 1 commit
 - doc: prefer 'stash push' over 'stash save'

 Doc update.

 Will merge to 'next'.


* ab/pcre2-grep (2017-11-24) 2 commits
 - grep: fix segfault under -P + PCRE2 <=10.30 + (*NO_JIT)
 - test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites

 "git grep" compiled with libpcre2 sometimes triggered a segfault,
 which is being fixed.

 Will merge to 'next'.


* jc/receive-pack-hook-doc (2017-11-24) 1 commit
 - hooks doc: clarify when receive-pack invokes its hooks

 Doc update.

 Will merge to 'next'.


* sb/diff-blobfind (2017-11-24) 1 commit
 - diff: add a new diffcore transformation to find a specific blob

 "git diff" family of commands learned --blobfind=<object-name> that
 allows you to limit the output only to a change that involves the
 named blob object (either changing the contents from or to it).

 Needs review.


* sp/doc-info-attributes (2017-11-24) 1 commit
 - doc: Mention info/attributes in gitrepository-layout

 Doc update.

 Will merge to 'next'.


* tg/worktree-create-tracking (2017-11-24) 4 commits
 - worktree: make add <path> dwim
 - worktree: make add <path> <branch> dwim
 - worktree: add --[no-]track option to the add subcommand
 - checkout: factor out functions to new lib file

 The way "git worktree add" determines what branch to create from
 where and checkout in the new worktree has been updated a bit.

 Needs review.

--------------------------------------------------
[Stalled]

* jc/merge-symlink-ours-theirs (2017-09-26) 1 commit
 - merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Needs review.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


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

* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Will merge to 'next'.


* pw/sequencer-in-process-commit (2017-11-24) 9 commits
 - t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 - sequencer: try to commit without forking 'git commit'
 - sequencer: load commit related config
 - sequencer: simplify adding Signed-off-by: trailer
 - commit: move print_commit_summary() to libgit
 - commit: move post-rewrite code to libgit
 - Add a function to update HEAD after creating a commit
 - commit: move empty message checks to libgit
 - t3404: check intermediate squash messages

 The sequencer infrastructure is shared across "git cherry-pick",
 "git rebase -i", etc., and has always spawned "git commit" when it
 needs to create a commit.  It has been taught to do so internally,
 when able, by reusing the codepath "git commit" itself uses, which
 gives performance boost for a few tens of percents in some sample
 scenarios.

 Will merge to and cook in 'next'.


* ew/rebase-mboxrd (2017-11-18) 1 commit
  (merged to 'next' on 2017-11-21 at 88eaaac334)
 + rebase: use mboxrd format to avoid split errors

 When "git rebase" prepared an mailbox of changes and fed it to "git
 am" to replay them, it was confused when a stray "From " happened
 to be in the log message of one of the replayed changes.  This has
 been corrected.

 Will merge to 'master'.


* rs/config-write-section-fix (2017-11-18) 1 commit
  (merged to 'next' on 2017-11-21 at a7f3f93e0c)
 + config: flip return value of write_section()

 There was a recent semantic mismerge in the codepath to write out a
 section of a configuration section, which has been corrected.

 Will merge to 'master'.


* ma/branch-list-paginate (2017-11-20) 3 commits
  (merged to 'next' on 2017-11-22 at eecd7f2369)
 + branch: change default of `pager.branch` to "on"
 + branch: respect `pager.branch` in list-mode only
 + t7006: add tests for how git branch paginates

 "git branch --list" learned to show its output through the pager by
 default when the output is going to a terminal, which is controlled
 by the pager.branch configuration variable.  This is similar to a
 recent change to "git tag --list".

 Will merge to 'master'.


* rs/include-comments-before-the-function-header (2017-11-21) 6 commits
  (merged to 'next' on 2017-11-22 at d7255a836f)
 + grep: show non-empty lines before functions with -W
 + grep: update boundary variable for pre-context
 + t7810: improve check of -W with user-defined function lines
 + xdiff: show non-empty lines before functions with -W
 + xdiff: factor out is_func_rec()
 + t4051: add test for comments preceding function lines

 "git grep -W", "git diff -W" and their friends learned a heuristic
 to extend a pre-context beyond the line that matches the "function
 pattern" (aka "diff.*.xfuncname") to include a comment block, if
 exists, that immediately precedes it.

 Will merge to 'master'.


* jk/fewer-pack-rescan (2017-11-22) 5 commits
 - sha1_file: fast-path null sha1 as a missing object
 - everything_local: use "quick" object existence check
 - p5551: add a script to test fetch pack-dir rescans
 - t/perf/lib-pack: use fast-import checkpoint to create packs
 - p5550: factor out nonsense-pack creation

 Internaly we use 0{40} as a placeholder object name to signal the
 codepath that there is no such object (e.g. the fast-forward check
 while "git fetch" stores a new remote-tracking ref says "we know
 there is no 'old' thing pointed at by the ref, as we are creating
 it anew" by passing 0{40} for the 'old' side), and expect that a
 codepath to locate an in-core object to return NULL as a sign that
 the object does not exist.  A look-up for an object that does not
 exist however is quite costly with a repository with large number
 of packfiles.  This access pattern has been optimized.

 Will merge to 'next'.


* ks/rebase-no-git-foo (2017-11-21) 1 commit
  (merged to 'next' on 2017-11-22 at 336552dbb7)
 + git-rebase: clean up dashed-usages in messages

 Mentions of "git-rebase" and "git-am" (dashed form) still remained
 in end-user visible strings emitted by the "git rebase" command;
 they have been corrected.

 Will merge to 'master'.


* sw/pull-ipv46-passthru (2017-11-21) 1 commit
  (merged to 'next' on 2017-11-22 at b06021eeba)
 + pull: pass -4/-6 option to 'git fetch'

 Contrary to the documentation, "git pull -4/-6 other-args" did not
 ask the underlying "git fetch" to go over IPv4/IPv6, which has been
 corrected.

 Will merge to 'master'.


* jn/ssh-wrappers (2017-11-21) 9 commits
 - connect: correct style of C-style comment
 - ssh: 'simple' variant does not support --port
 - ssh: 'simple' variant does not support -4/-6
 - ssh: 'auto' variant to select between 'ssh' and 'simple'
 - connect: split ssh option computation to its own function
 - connect: split ssh command line options into separate function
 - connect: split git:// setup into a separate function
 - connect: move no_fork fallback to git_tcp_connect
 - ssh test: make copy_ssh_wrapper_as clean up after itself
 (this branch uses bw/protocol-v1.)

 The ssh-variant 'simple' introduced earlier broke existing
 installations by not passing --port/-4/-6 and not diagnosing an
 attempt to pass these as an error.  Instead, default to
 automatically detect how compatible the GIT_SSH/GIT_SSH_COMMAND is
 to OpenSSH convention and then error out an invocation to make it
 easier to diagnose connection errors.

 Will merge to 'next'.


* rv/sendemail-tocmd-in-config-and-completion (2017-11-14) 2 commits
  (merged to 'next' on 2017-11-20 at 75cf6e2fc3)
 + completion: add git config sendemail.tocmd
 + Documentation/config: add sendemail.tocmd to list preceding "See git-send-email(1)"

 Teach "sendemail.tocmd" to places that know about "sendemail.to",
 like documentation and shell completion (in contrib/).

 Will merge to 'master'.


* tz/notes-error-to-stderr (2017-11-15) 1 commit
  (merged to 'next' on 2017-11-20 at a45d441ee2)
 + notes: send "Automatic notes merge failed" messages to stderr

 "git notes" sent its error message to its standard output stream,
 which was corrected.

 Will merge to 'master'.


* hm/config-parse-expiry-date (2017-11-18) 1 commit
 - config: add --expiry-date

 "git config --expiry-date gc.reflogexpire" can read "2.weeks" from
 the configuration and report it as a timestamp, just like "--int"
 would read "1k" and report 1024, to help consumption by scripts.

 Will merge to 'next'.


* sd/branch-copy (2017-11-16) 1 commit
  (merged to 'next' on 2017-11-20 at e33bcc460a)
 + config: avoid "write_in_full(fd, buf, len) != len" pattern

 Code clean-up.

 Will merge to 'master'.


* pw/sequencer-recover-from-unlockable-index (2017-11-16) 1 commit
  (merged to 'next' on 2017-11-20 at 36f0ed26ce)
 + sequencer: reschedule pick if index can't be locked

 The sequencer machinery (used by "git cherry-pick A..B", and "git
 rebase -i", among other things) would have lost a commit if stopped
 due to an unlockable index file, which has been fixed.

 Will merge to 'master'.


* dj/runtime-prefix (2017-11-20) 1 commit
 - exec_cmd: RUNTIME_PREFIX on some POSIX systems

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.

 A part of this that deals with Perl is still being discussed.


* jc/editor-waiting-message (2017-11-17) 1 commit
 - launch_editor(): indicate that Git waits for user input

 Git shows a message to tell the user that it is waiting for the
 user to finish editing when spawning an editor, in case the editor
 opens to a hidden window or somewhere obscure and the user gets
 lost.

 Will merge to 'next'.


* rs/apply-inaccurate-eof-with-incomplete-line (2017-11-17) 1 commit
  (merged to 'next' on 2017-11-20 at c8aee1d135)
 + apply: update line lengths for --inaccurate-eof

 "git apply --inaccurate-eof" when used with "--ignore-space-change"
 triggered an internal sanity check, which has been fixed.

 Will merge to 'master'.


* tz/branch-doc-remove-set-upstream (2017-11-17) 1 commit
 - branch doc: remove --set-upstream from synopsis

 "git branch --set-upstream" has been deprecated and (sort of)
 removed, as "--set-upstream-to" is the preferred one these days.
 The documentation still had "--set-upstream" listed on its
 synopsys section, which has been corrected.

 Will merge to 'next'.


* tz/complete-branch-copy (2017-11-17) 1 commit
  (merged to 'next' on 2017-11-20 at 6d22384fcd)
 + completion: add '--copy' option to 'git branch'

 Command line completion (in contrib/) has been taught about the
 "--copy" option of "git branch".

 Will merge to 'master'.


* jc/branch-name-sanity (2017-11-15) 4 commits
  (merged to 'next' on 2017-11-20 at 7236b0dde3)
 + builtin/branch: remove redundant check for HEAD
 + branch: correctly reject refs/heads/{-dash,HEAD}
 + branch: split validate_new_branchname() into two
 + branch: streamline "attr_only" handling in validate_new_branchname()

 "git branch" and "git checkout -b" are now forbidden from creating
 a branch whose name is "HEAD".

 Will merge to 'master'.


* jc/merge-base-fork-point-doc (2017-11-09) 1 commit
  (merged to 'next' on 2017-11-20 at 199b9255b4)
 + merge-base --fork-point doc: clarify the example and failure modes

 Clarify and enhance documentation for "merge-base --fork-point", as
 it was clear what it computed but not why/what for.

 Will merge to 'master'.


* sb/test-cherry-pick-submodule-getting-in-a-way (2017-11-15) 2 commits
  (merged to 'next' on 2017-11-20 at fe7016689e)
 + merge-recursive: handle addition of submodule on our side of history
 + t/3512: demonstrate unrelated submodule/file conflict as cherry-pick failure

 The three-way merge performed by "git cherry-pick" was confused
 when a new submodule was added in the meantime, which has been
 fixed (or "papered over").

 Will merge to 'master'.


* en/rename-progress (2017-11-15) 4 commits
  (merged to 'next' on 2017-11-20 at 77a2e0ddd9)
 + sequencer: show rename progress during cherry picks
 + diff: remove silent clamp of renameLimit
 + progress: fix progress meters when dealing with lots of work
 + sequencer: warn when internal merge may be suboptimal due to renameLimit

 Historically, the diff machinery for rename detection had a
 hardcoded limit of 32k paths; this is being lifted to allow users
 trade cycles with a (possibly) easier to read result.

 Will cook in 'next'.


* tz/redirect-fix (2017-11-14) 2 commits
  (merged to 'next' on 2017-11-20 at 5b13f7026e)
 + rebase: fix stderr redirect in apply_autostash()
 + t/lib-gpg: fix gpgconf stderr redirect to /dev/null

 A few scripts (both in production and tests) incorrectly redirected
 their error output.  These have been corrected.

 Will merge to 'master'.


* ar/unconfuse-three-dots (2017-11-20) 5 commits
 - Testing: provide tests requiring them with ellipses after SHA-1 values
 - Documentation: revisions: fix typo: "three dot" ---> "three-dot" (in line with "two-dot").
 - Documentation: user-manual: limit usage of ellipsis
 - diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
 - checkout: describe_detached_head: remove ellipsis after committish

 Ancient part of codebase still shows dots after an abbreviated
 object name just to show that it is not a full object name, but
 these ellipses are confusing to people who newly discovered Git
 who are used to seeing abbreviated object names and find them
 confusing with the range syntax.

 Will merge to 'next'.
 The tests may need to be updated to cover both old and new output,
 but that can happen in follow-up series.
 cf. <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>


* jh/object-filtering (2017-11-22) 6 commits
 - pack-objects: add list-objects filtering
 - rev-list: add list-objects filtering support
 - list-objects: filter objects in traverse_commit_list
 - oidset: add iterator methods to oidset
 - oidmap: add oidmap iterator methods
 - dir: allow exclusions from blob in addition to file
 (this branch is used by jh/fsck-promisors and jh/partial-clone.)

 In preparation for implementing narrow/partial clone, the object
 walking machinery has been taught a way to tell it to "filter" some
 objects from enumeration.

 Will merge to 'next'.


* jh/fsck-promisors (2017-11-22) 10 commits
 - gc: do not repack promisor packfiles
 - rev-list: support termination at promisor objects
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension
 - extension.partialclone: introduce partial clone extension
 (this branch is used by jh/partial-clone; uses jh/object-filtering.)

 In preparation for implementing narrow/partial clone, the machinery
 for checking object connectivity used by gc and fsck has been
 taught that a missing object is OK when it is referenced by a
 packfile specially marked as coming from trusted repository that
 promises to make them available on-demand and lazily.


* jh/partial-clone (2017-11-22) 14 commits
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - t5500: more tests for partial clone and fetch
 - t5601: test for partial clone
 - t5500: add fetch-pack tests for partial clone
 - fetch: add from_promisor and exclude-promisor-objects parameters
 - partial-clone: define partial clone settings in config
 - fetch-pack: test support excluding large blobs
 - pack-objects: test support for blob filtering
 - remote-curl: add object filtering for partial clone
 - fetch: add object filtering for partial fetch
 - fetch: refactor calculation of remote list
 - clone, fetch-pack, index-pack, transport: partial clone
 - upload-pack: add object filtering for partial clone
 (this branch uses jh/fsck-promisors and jh/object-filtering.)

 The machinery to clone & fetch, which in turn involves packing and
 unpacking objects, have been told how to omit certain objects using
 the filtering mechanism introduced by the jh/object-filtering
 topic, and also mark the resulting pack as a promisor pack to
 tolerate missing objects, taking advantage of the mechanism
 introduced by the jh/fsck-promisors topic.


* sb/describe-blob (2017-11-16) 7 commits
 - builtin/describe.c: describe a blob
 - builtin/describe.c: factor out describe_commit
 - builtin/describe.c: print debug statements earlier
 - builtin/describe.c: rename `oid` to avoid variable shadowing
 - revision.h: introduce blob/tree walking in order of the commits
 - list-objects.c: factor out traverse_trees_and_blobs
 - t6120: fix typo in test name

 "git describe" was taught to dig trees deeper to find a
 <commit-ish>:<path> that refers to a given blob object.


* tb/add-renormalize (2017-11-17) 1 commit
  (merged to 'next' on 2017-11-20 at e302f3591f)
 + add: introduce "--renormalize"

 "git add --renormalize ." is a new and safer way to record the fact
 that you are correcting the end-of-line convention and other
 "convert_to_git()" glitches in the in-repository data.

 Will merge to 'master'.


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


* jc/ignore-cr-at-eol (2017-11-08) 2 commits
  (merged to 'next' on 2017-11-20 at 9f7bae7cbd)
 + diff: --ignore-cr-at-eol
 + xdiff: reassign xpparm_t.flags bits

 The "diff" family of commands learned to ignore differences in
 carriage return at the end of line.

 Will merge to 'master'.


* ot/mru-on-list (2017-10-01) 1 commit
 - mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Is there any remaining issues on this one?


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.

 Will merge to 'next'.


* bw/protocol-v1 (2017-10-17) 11 commits
 - Documentation: document Extra Parameters
 - ssh: introduce a 'simple' ssh variant
 - i5700: add interop test for protocol transition
 - http: tell server that the client understands v1
 - connect: tell server that the client understands v1
 - connect: teach client to recognize v1 server response
 - upload-pack, receive-pack: introduce protocol version 1
 - daemon: recognize hidden request arguments
 - protocol: introduce protocol extension mechanisms
 - pkt-line: add packet_write function
 - connect: in ref advertisement, shallows are last
 (this branch is used by jn/ssh-wrappers.)

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.

 Will merge to 'next'.


* bc/hash-algo (2017-11-13) 4 commits
 - Switch empty tree and blob lookups to use hash abstraction
 - Integrate hash algorithm support with repo setup
 - Add structure representing hash algorithm
 - setup: expose enumerated repo info

 An infrastructure to define what hash function is used in Git is
 introduced, and an effort to plumb that throughout various
 codepaths has been started.

 Will merge to 'next'.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Will merge to 'next'.

--------------------------------------------------
[Discarded]

* jk/ui-color-always-to-auto-maint (2017-10-13) 2 commits
 . color: document that "git -c color.*=always" is a bit special
 . color: downgrade "always" to "auto" only for on-disk configuration

 It turns out that "git -c color.ui=always cmd" is relied on by many
 third-party tools as a way to force coloured output no matter what
 the end-user configuration is, and a recent attempt to downgrade
 'always' to 'auto' to fix the regression to "git add -p" broke it.

 This has been reverted from 'next'.


* jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
 . fetch-pack: restore save_commit_buffer after use
 . unpack-trees: batch fetching of missing blobs
 . clone: configure blobmaxbytes in created repos
 . clone: support excluding large blobs
 . fetch: support excluding large blobs
 . fetch: refactor calculation of remote list
 . fetch-pack: support excluding large blobs
 . pack-objects: support --blob-max-bytes
 . pack-objects: rename want_.* to ignore_.*
 . gc: do not repack promisor packfiles
 . rev-list: support termination at promisor objects
 . sha1_file: support lazily fetching missing objects
 . introduce fetch-object: fetch one promisor object
 . index-pack: refactor writing of .keep files
 . fsck: support promisor objects as CLI argument
 . fsck: support referenced promisor objects
 . fsck: support refs pointing to promisor objects
 . fsck: introduce partialclone extension

 A journey for "git clone" and "git fetch" to become "lazier" by
 depending more on its remote repository---this is the beginning of
 it.

 Superseded by three topics that end with jh/partial-clone.


* jh/dir-add-exclude-from-blob (2017-10-27) 1 commit
 . dir: allow exclusions from blob in addition to file

 The code to read exclusion list from a blob, which is used when the
 .gitignore file is outside a sparse checkout area, has been
 refactored so that other codepath can later use it to do the same
 outside the context of "sparse checkout".

 Now part of jh/object-filtering topic.


* bp/fastindex (2017-11-11) 5 commits
 . SQUASH???
 . fastindex: add documentation for the fastindex extension
 . fastindex: add test tools and a test script
 . update-index: add fastindex support to update-index
 . fastindex: speed up index load through parallelization

 Retracted for now.

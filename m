Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5514B202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 05:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbdKUFkp (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 00:40:45 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:63270 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdKUFkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 00:40:43 -0500
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id B0C80EEEE;
        Tue, 21 Nov 2017 00:40:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=R
        QpBvY2BT9KOGWNCLTUicOD3TLo=; b=MXGAoqzN0Wv0iIT+1bdhLMh9w7KvRJbOt
        SMTbKlwH55JXfXbSwDng1ElCSYQZqbPdo3b2Z4EgpvqacxRYPLgrfNZN5nHpXJSP
        3dyIYY/1GLAFRHJHhSfMjzgxmarevWIOyo2VW5gBPnL7WA802YiOpwDhjYfs4kaa
        SToJ0NDd9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=NjG
        RYvOp270ecI0752EPvEexOIUvph+Rb0pHIRWXCpaGqU7rVMYfBJdVvIeqJudvW4b
        yLZlFPDmiZk0FDRlVXQFQ5mREi6860HjU2iyVyE6DgCz0Dnm0PEbCRdG1184fpGn
        Kd14yravg6k/FLvnb3EpYA+pUi0Bjvrn+bhT3fjo=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 9B6BFEEED;
        Tue, 21 Nov 2017 00:40:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C64EBE371;
        Tue, 21 Nov 2017 00:40:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2017, #06; Tue, 21)
X-master-at: 14c63a9dc093d6738454f6369a4f5663ca732cf7
X-next-at: 466bffb3ac3fb7c740a2ea1485c5f69af6b40864
Date:   Tue, 21 Nov 2017 14:40:37 +0900
Message-ID: <xmqqshd8i3ze.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 813772E4-CE7E-11E7-9276-8EF31968708C-77302942!pb-smtp1.pobox.com
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
[Graduated to "master"]

* ad/submitting-patches-title-decoration (2017-11-11) 1 commit
  (merged to 'next' on 2017-11-15 at 99238c3537)
 + doc/SubmittingPatches: correct subject guidance

 Doc update around use of "format-patch --subject-prefix" etc.


* av/fsmonitor (2017-11-13) 7 commits
  (merged to 'next' on 2017-11-13 at db56ad7eef)
 + fsmonitor: simplify determining the git worktree under Windows
 + fsmonitor: store fsmonitor bitmap before splitting index
 + fsmonitor: read from getcwd(), not the PWD environment variable
  (merged to 'next' on 2017-11-07 at a06178754d)
 + fsmonitor: delay updating state until after split index is merged
 + fsmonitor: document GIT_TRACE_FSMONITOR
 + fsmonitor: don't bother pretty-printing JSON from watchman
 + fsmonitor: set the PWD to the top of the working tree
 (this branch uses bp/fsmonitor.)

 Various fixes to bp/fsmonitor topic.

 Waiting for follow-on fixes to settle.


* bp/fsmonitor (2017-10-05) 15 commits
  (merged to 'next' on 2017-11-07 at b08d44ba60)
 + fsmonitor: preserve utf8 filenames in fsmonitor-watchman log
 + fsmonitor: read entirety of watchman output
 + fsmonitor: MINGW support for watchman integration
 + fsmonitor: add a performance test
 + fsmonitor: add a sample integration script for Watchman
 + fsmonitor: add test cases for fsmonitor extension
 + split-index: disable the fsmonitor extension when running the split index test
 + fsmonitor: add a test tool to dump the index extension
 + update-index: add fsmonitor support to update-index
 + ls-files: Add support in ls-files to display the fsmonitor valid bit
 + fsmonitor: add documentation for the fsmonitor extension.
 + fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 + update-index: add a new --force-write-index option
 + preload-index: add override to enable testing preload-index
 + bswap: add 64 bit endianness helper get_be64
 (this branch is used by av/fsmonitor.)

 Originally merged to 'next' on 2017-10-05

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.

 Waiting for follow-on fixes to settle.


* rs/apply-fuzzy-match-fix (2017-11-12) 1 commit
  (merged to 'next' on 2017-11-15 at 2d724fa63b)
 + apply: avoid out-of-bounds access in fuzzy_matchlines()

 A fix for an ancient bug in "git apply --ignore-space-change" codepath.

--------------------------------------------------
[New Topics]

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
 - branch: change default of `pager.branch` to "on"
 - branch: respect `pager.branch` in list-mode only
 - t7006: add tests for how git branch paginates

 "git branch --list" learned to show its output through the pager by
 default when the output is going to a terminal, which is controlled
 by the pager.branch configuration variable.  This is similar to a
 recent change to "git tag --list".

 Will merge to 'next'.


* rs/include-comments-before-the-function-header (2017-11-21) 6 commits
 - grep: show non-empty lines before functions with -W
 - grep: update boundary variable for pre-context
 - t7810: improve check of -W with user-defined function lines
 - xdiff: show non-empty lines before functions with -W
 - xdiff: factor out is_func_rec()
 - t4051: add test for comments preceding function lines

 "git grep -W", "git diff -W" and their friends learned a heuristic
 to extend a pre-context beyond the line that matches the "function
 pattern" (aka "diff.*.xfuncname") to include a comment block, if
 exists, that immediately precedes it.

 Will merge to 'next'.


* jk/fewer-pack-rescan (2017-11-21) 5 commits
 - sha1_file: don't re-scan pack directory for null sha1
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

 Undecided.

 While resolving a conflict with jh/fsck-promisors topic, I ended up
 with a code that rejects 0{40} a lot earlier, before we try to see
 if a pack entry for 0{40} exists, even though the patch that is
 queued on this topic is more conservative.  Perhaps we would want
 to use the alternate version that declares the 0{40} is a sentinel
 that signals that there is no such object.


* ks/rebase-no-git-foo (2017-11-21) 1 commit
 - git-rebase: clean up dashed-usages in messages

 Mentions of "git-rebase" and "git-am" (dashed form) still remained
 in end-user visible strings emitted by the "git rebase" command;
 they have been corrected.

 Will merge to 'next'.


* sw/pull-ipv46-passthru (2017-11-21) 1 commit
 - pull: pass -4/-6 option to 'git fetch'

 Contrary to the documentation, "git pull -4/-4 other-args" did not
 ask the underlying "git fetch" to go over IPv4/IPv6, which has been
 corrected.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* pw/sequencer-in-process-commit (2017-11-18) 9 commits
 - SQUASH???
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

 Needs review.


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


* jc/editor-waiting-message (2017-11-17) 1 commit
 - launch_editor(): indicate that Git waits for user input

 Git shows a message to tell the user that it is waiting for the
 user to finish editing when spawning an editor, in case the editor
 opens to a hidden window or somewhere obscure and the user gets
 lost.


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

 Will merge to 'master'.


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

 This may become a new default someday, but the way to tentatively
 get the original behaviour back would probably want to be an
 environment variable, not a configuration.

 Expecting a reroll.


* jh/fsck-promisors (2017-11-17) 10 commits
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


* jh/object-filtering (2017-11-17) 6 commits
 - pack-objects: add list-objects filtering
 - rev-list: add list-objects filtering support
 - list-objects: filter objects in traverse_commit_list
 - oidset: add iterator methods to oidset
 - oidmap: add oidmap iterator methods
 - dir: allow exclusions from blob in addition to file
 (this branch is used by jh/fsck-promisors and jh/partial-clone.)


* jh/partial-clone (2017-11-17) 15 commits
 . fetch-pack: restore save_commit_buffer after use
 . unpack-trees: batch fetching of missing blobs
 . t5500: more tests for partial clone and fetch
 . t5601: test for partial clone
 . t5500: add fetch-pack tests for partial clone
 . fetch: add from_promisor and exclude-promisor-objects parameters
 . fetch-pack: test support excluding large blobs
 . partial-clone: define partial clone settings in config
 . fetch-pack: test support excluding large blobs
 . pack-objects: test support for blob filtering
 . remote-curl: add object filtering for partial clone
 . fetch: add object filtering for partial fetch
 . fetch: refactor calculation of remote list
 . clone, fetch-pack, index-pack, transport: partial clone
 . upload-pack: add object filtering for partial clone
 (this branch uses jh/fsck-promisors and jh/object-filtering.)


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

 Waiting for jn/ssh-wrappers topic.


* bc/hash-algo (2017-11-13) 4 commits
 - Switch empty tree and blob lookups to use hash abstraction
 - Integrate hash algorithm support with repo setup
 - Add structure representing hash algorithm
 - setup: expose enumerated repo info

 An infrastructure to define what hash function is used in Git is
 introduced, and an effort to plumb that throughout various
 codepaths has been started.

 Looked more or less OK to me.  Ready to merge to 'next'?  Further
 comments?


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Expecting a reroll.

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

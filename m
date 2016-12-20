Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF521FF40
	for <e@80x24.org>; Tue, 20 Dec 2016 00:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbcLTAV1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 19:21:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51890 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752043AbcLTAVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 19:21:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A62B5AD75;
        Mon, 19 Dec 2016 19:21:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=K
        3CjOoXWZxcOkkVWYYZKhjeo7b8=; b=cwUWG+KmNAAMDCh4PXBgqOon9ctqk0RNM
        Dqo3CWjUxxcGJyJCCpsyg+sqI/R0HzwtniWfTG59zMWvvhXMnWyO1/UdKLtpVoHP
        Led2uMR9/dEbBj7r2NoNOeYmTItmIE6DFjzqjcXKL3pEwagNIrkV0+WKfuDcxJ7S
        F0r9mNPq64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=oFj
        gKKzjIzEj2awcOhq3cmDRcQtG8qYu5VpPfqE/iZv5x+1ihhi3bb93y/fkwCZ6bLR
        27RXgTmLD+rRqxORE/lpb3ewC8jmvlTdYMYPpD2xxYiRCCjOe/KMBkuZHco/WAND
        jLJtW0Mt/PkpFRyWkBWv40q4pp1aHKC3EZr/4KgM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80BAC5AD74;
        Mon, 19 Dec 2016 19:21:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B222C5AD73;
        Mon, 19 Dec 2016 19:21:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2016, #05; Mon, 19)
X-master-at: 6610af872f6494a061780ec738c8713a034b848b
X-next-at: 4f4050513f839a9c6e56bdec20cbd1a1cb924ef8
Date:   Mon, 19 Dec 2016 16:21:19 -0800
Message-ID: <xmqq37hjmow0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B607348-C64A-11E6-94CB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The second (rather large) batch of topics have been merged to
'master'.  Please test and catch possible regressions early.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ah/grammos (2016-12-05) 3 commits
  (merged to 'next' on 2016-12-12 at 13ad487b28)
 + clone,fetch: explain the shallow-clone option a little more clearly
 + receive-pack: improve English grammar of denyCurrentBranch message
 + bisect: improve English grammar of not-ancestors message

 A few messages have been fixed for their grammatical errors.


* ak/commit-only-allow-empty (2016-12-09) 2 commits
  (merged to 'next' on 2016-12-12 at 54188ab23c)
 + commit: remove 'Clever' message for --only --amend
 + commit: make --only --allow-empty work without paths

 "git commit --allow-empty --only" (no pathspec) with dirty index
 ought to be an acceptable way to create a new commit that does not
 change any paths, but it was forbidden, perhaps because nobody
 needed it so far.


* bb/unicode-9.0 (2016-12-14) 6 commits
  (merged to 'next' on 2016-12-16 at be2531431a)
 + unicode_width.h: update the width tables to Unicode 9.0
 + update_unicode.sh: remove the plane filter
 + update_unicode.sh: automatically download newer definition files
 + update_unicode.sh: pin the uniset repo to a known good commit
 + update_unicode.sh: remove an unnecessary subshell level
 + update_unicode.sh: move it into contrib/update-unicode

 The character width table has been updated to match Unicode 9.0


* da/difftool-dir-diff-fix (2016-12-08) 1 commit
  (merged to 'next' on 2016-12-12 at fd31a92ad6)
 + difftool: fix dir-diff index creation when in a subdirectory

 "git difftool --dir-diff" had a minor regression when started from
 a subdirectory, which has been fixed.


* da/mergetool-xxdiff-hotkey (2016-12-11) 1 commit
  (merged to 'next' on 2016-12-13 at a08f375c81)
 + mergetools: fix xxdiff hotkeys

 The way to specify hotkeys to "xxdiff" that is used by "git
 mergetool" has been modernized to match recent versions of xxdiff.


* jb/diff-no-index-no-abbrev (2016-12-08) 1 commit
  (merged to 'next' on 2016-12-12 at 959981ef50)
 + diff: handle --no-abbrev in no-index case

 "git diff --no-index" did not take "--no-abbrev" option.


* jc/lock-report-on-error (2016-12-07) 3 commits
  (merged to 'next' on 2016-12-13 at cb6c07ee92)
 + lockfile: LOCK_REPORT_ON_ERROR
 + hold_locked_index(): align error handling with hold_lockfile_for_update()
 + wt-status: implement opportunisitc index update correctly

 Git 2.11 had a minor regression in "merge --ff-only" that competed
 with another process that simultanously attempted to update the
 index. We used to explain what went wrong with an error message,
 but the new code silently failed.  The error message has been
 resurrected.


* jc/pull-rebase-ff (2016-11-29) 1 commit
  (merged to 'next' on 2016-12-16 at c1a0cedd9e)
 + pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.


* jc/renormalize-merge-kill-safer-crlf (2016-12-01) 4 commits
  (merged to 'next' on 2016-12-12 at 041b834f81)
 + convert: git cherry-pick -Xrenormalize did not work
 + Merge branch 'tb/t0027-raciness-fix' into jc/renormalize-merge-kill-safer-crlf
 + merge-recursive: handle NULL in add_cacheinfo() correctly
 + cherry-pick: demonstrate a segmentation fault

 Fix a corner case in merge-recursive regression that crept in
 during 2.10 development cycle.


* jk/http-walker-limit-redirect (2016-12-06) 2 commits
  (merged to 'next' on 2016-12-12 at 8b58025e3a)
 + http-walker: complain about non-404 loose object errors
 + Merge branch 'ew/http-walker' into jk/http-walker-limit-redirect
 (this branch is used by bw/transport-protocol-policy; uses jk/http-walker-limit-redirect-2.9.)

 Update the error messages from the dumb-http client when it fails
 to obtain loose objects; we used to give sensible error message
 only upon 404 but we now forbid unexpected redirects that needs to
 be reported with something sensible.


* jk/http-walker-limit-redirect-2.9 (2016-12-06) 5 commits
  (merged to 'next' on 2016-12-12 at 3e4bcd7bca)
 + http: treat http-alternates like redirects
 + http: make redirects more obvious
 + remote-curl: rename shadowed options variable
 + http: always update the base URL for redirects
 + http: simplify update_url_from_redirect
 (this branch is used by bw/transport-protocol-policy and jk/http-walker-limit-redirect.)

 Transport with dumb http can be fooled into following foreign URLs
 that the end user does not intend to, especially with the server
 side redirects and http-alternates mechanism, which can lead to
 security issues.  Tighten the redirection and make it more obvious
 to the end user when it happens.


* jk/make-tags-find-sources-tweak (2016-12-14) 4 commits
  (merged to 'next' on 2016-12-16 at 06d0b0fbfd)
 + Makefile: exclude contrib from FIND_SOURCE_FILES
 + Makefile: match shell scripts in FIND_SOURCE_FILES
 + Makefile: exclude test cruft from FIND_SOURCE_FILES
 + Makefile: reformat FIND_SOURCE_FILES

 Update the procedure to generate "tags" for developer support.


* jk/readme-gmane-is-no-more (2016-12-15) 1 commit
  (merged to 'next' on 2016-12-16 at 44ad5c5205)
 + README: replace gmane link with public-inbox


* jk/stash-disable-renames-internally (2016-12-06) 1 commit
  (merged to 'next' on 2016-12-12 at e2b97aae68)
 + stash: prefer plumbing over git-diff

 When diff.renames configuration is on (and with Git 2.9 and later,
 it is enabled by default, which made it worse), "git stash"
 misbehaved if a file is removed and another file with a very
 similar content is added.


* jk/trailers-placeholder-in-pretty (2016-12-11) 2 commits
  (merged to 'next' on 2016-12-12 at 57de4e699a)
 + ref-filter: add support to display trailers as part of contents
 + pretty: add %(trailers) format for displaying trailers of a commit message
 (this branch uses jt/use-trailer-api-in-commands.)

 In addition to %(subject), %(body), "log --pretty=format:..."
 learned a new placeholder %(trailers).


* jk/xdiff-drop-xdl-fast-hash (2016-12-06) 1 commit
  (merged to 'next' on 2016-12-13 at 914e306217)
 + xdiff: drop XDL_FAST_HASH

 Retire the "fast hash" that had disastrous performance issues in
 some corner cases.


* js/normalize-path-copy-ceil (2016-12-16) 1 commit
  (merged to 'next' on 2016-12-16 at 634ba4debc)
 + normalize_path_copy(): fix pushing to //server/share/dir on Windows

 A pathname that begins with "//" or "\\" on Windows is special but
 path normalization logic was unaware of it.


* jt/use-trailer-api-in-commands (2016-11-29) 5 commits
  (merged to 'next' on 2016-12-12 at da1f140ad4)
 + sequencer: use trailer's trailer layout
 + trailer: have function to describe trailer layout
 + trailer: avoid unnecessary splitting on lines
 + commit: make ignore_non_trailer take buf/len
 + trailer: be stricter in parsing separators
 (this branch is used by jk/trailers-placeholder-in-pretty.)

 Commands that operate on a log message and add lines to the trailer
 blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
 "commit -s", have been taught to use the logic of and share the
 code with "git interpret-trailer".


* kh/tutorial-grammofix (2016-12-09) 4 commits
  (merged to 'next' on 2016-12-13 at a951db78bc)
 + doc: omit needless "for"
 + doc: make the intent of sentence clearer
 + doc: add verb in front of command to run
 + doc: add articles (grammar)


* ld/p4-worktree (2016-12-13) 1 commit
  (merged to 'next' on 2016-12-16 at 5210ab9973)
 + git-p4: support git worktrees

 "git p4" didn't interact with the internal of .git directory
 correctly in the modern "git-worktree"-enabled world.


* lr/doc-fix-cet (2016-12-12) 1 commit
  (merged to 'next' on 2016-12-13 at dbc9e07e57)
 + date-formats.txt: Typo fix


* ls/t0021-fixup (2016-12-05) 1 commit
  (merged to 'next' on 2016-12-12 at db652e691a)
 + t0021: minor filter process test cleanup


* ls/travis-update-p4-and-lfs (2016-12-05) 1 commit
  (merged to 'next' on 2016-12-12 at 5496caa048)
 + travis-ci: update P4 to 16.2 and GitLFS to 1.5.2 in Linux build

 The default Travis-CI configuration specifies newer P4 and GitLFS.


* nd/for-each-ref-ignore-case (2016-12-05) 1 commit
  (merged to 'next' on 2016-12-12 at 527cc4f275)
 + tag, branch, for-each-ref: add --ignore-case for sorting and filtering

 "git branch --list" and friends learned "--ignore-case" option to
 optionally sort branches and tags case insensitively.


* nd/rebase-forget (2016-12-11) 1 commit
  (merged to 'next' on 2016-12-12 at 50b5d28af4)
 + rebase: add --quit to cleanup rebase, leave everything else untouched

 "git rebase" learned "--quit" option, which allows a user to
 remove the metadata left by an earlier "git rebase" that was
 manually aborted without using "git rebase --abort".


* rj/git-version-gen-do-not-force-abbrev (2016-12-06) 1 commit
  (merged to 'next' on 2016-12-12 at e37970c3f5)
 + GIT-VERSION-GEN: do not force abbreviation length used by 'describe'

 A minor build update.


* sb/t3600-cleanup (2016-12-12) 2 commits
  (merged to 'next' on 2016-12-13 at e06e6e702f)
 + t3600: slightly modernize style
  (merged to 'next' on 2016-12-12 at d9996af5e8)
 + t3600: remove useless redirect

 Code cleanup.


* sb/unpack-trees-grammofix (2016-12-05) 1 commit
  (merged to 'next' on 2016-12-12 at 29e536f590)
 + unpack-trees: fix grammar for untracked files in directories

--------------------------------------------------
[New Topics]

* gv/p4-multi-path-commit-fix (2016-12-19) 1 commit
 - git-p4: fix multi-path changelist empty commits

 "git p4" that tracks multile p4 paths imported a single changelist
 that touches files in these multiple paths as one commit, followed
 by many empty commits.  This has been fixed.

 Will merge to 'next'.


* js/mingw-isatty (2016-12-18) 1 commit
 - winansi_isatty(): fix when Git is used from CMD

 Update the isatty() emulation for Windows to make it interact
 better with the cmd.exe console.

 Waiting for an ack.


* jt/mailinfo-fold-in-body-headers (2016-12-19) 1 commit
 - mailinfo.c: move side-effects outside of assert

 Fix for NDEBUG builds.

 Will merge to 'next'.


* ls/p4-lfs (2016-12-18) 1 commit
 - git-p4: add diff/merge properties to .gitattributes for GitLFS files

 Update GitLFS integration with "git p4".

 Waiting for an ack.


* ls/p4-path-encoding (2016-12-18) 1 commit
 - git-p4: fix git-p4.pathEncoding for removed files

 When "git p4" imports changelist that removes paths, it failed to
 convert pathnames when the p4 used encoding different from the one
 used on the Git side.  This has been corrected.

 Waiting for an ack.


* mh/fast-import-notes-fix-new (2016-12-19) 1 commit
 - fast-import: properly fanout notes when tree is imported

 "git fast-import" sometimes mishandled while rebalancing notes
 tree, which has been fixed.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jc/retire-compaction-heuristics (2016-11-02) 3 commits
 - SQUASH???
 - SQUASH???
 - diff: retire the original experimental "compaction" heuristics

 Waiting for a reroll.


* jc/abbrev-autoscale-config (2016-11-01) 1 commit
 - config.abbrev: document the new default that auto-scales

 Waiting for a reroll.


* jk/nofollow-attr-ignore (2016-11-02) 5 commits
 - exclude: do not respect symlinks for in-tree .gitignore
 - attr: do not respect symlinks for in-tree .gitattributes
 - exclude: convert "check_index" into a flags field
 - attr: convert "macro_ok" into a flags field
 - add open_nofollow() helper

 As we do not follow symbolic links when reading control files like
 .gitignore and .gitattributes from the index, match the behaviour
 and not follow symbolic links when reading them from the working
 tree.  This also tightens security a bit by not leaking contents of
 an unrelated file in the error messages when it is pointed at by
 one of these files that is a symbolic link.

 Perhaps we want to cover .gitmodules too with the same mechanism?


* nd/worktree-move (2016-11-28) 11 commits
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()
 . copy.c: convert copy_file() to copy_dir_recursively()
 . copy.c: style fix
 . copy.c: convert bb_(p)error_msg to error(_errno)
 . copy.c: delete unused code in copy_file()
 . copy.c: import copy_file() from busybox

 "git worktree" learned move and remove subcommands.

 Reported to break builds on Windows.


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

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  It is likely that to support a "prime clone from CDN", it
 would need a lot more than just "these are the heads and the pack
 data is over there", so this may not be sufficient.

 Will discard.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 It has been two months without any support.  We may want to discard
 this.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Has been waiting for a review for too long without seeing anything.

 Will discard.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Has been waiting for a reroll for too long.
 cf. <xmqq60ypbeng.fsf@gitster.mtv.corp.google.com>

 Will discard.


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

* bw/pathspec-cleanup (2016-12-14) 16 commits
 - pathspec: rename prefix_pathspec to init_pathspec_item
 - pathspec: small readability changes
 - pathspec: create strip submodule slash helpers
 - pathspec: create parse_element_magic helper
 - pathspec: create parse_long_magic function
 - pathspec: create parse_short_magic function
 - pathspec: factor global magic into its own function
 - pathspec: simpler logic to prefix original pathspec elements
 - pathspec: always show mnemonic and name in unsupported_magic
 - pathspec: remove unused variable from unsupported_magic
 - pathspec: copy and free owned memory
 - pathspec: remove the deprecated get_pathspec function
 - ls-tree: convert show_recursive to use the pathspec struct interface
 - dir: convert fill_directory to use the pathspec struct interface
 - dir: remove struct path_simplify
 - mv: remove use of deprecated 'get_pathspec()'

 Code clean-up in the pathspec API.

 Waiting for the (hopefully) final round of review before 'next'.


* cp/merge-continue (2016-12-15) 4 commits
  (merged to 'next' on 2016-12-19 at 8ba0094f45)
 + merge: mark usage error strings for translation
 + merge: ensure '--abort' option takes no arguments
 + completion: add --continue option for merge
 + merge: add '--continue' option as a synonym for 'git commit'

 "git merge --continue" has been added as a synonym to "git commit"
 to conclude a merge that has stopped due to conflicts.

 Will merge to 'master'.


* jk/parseopt-usage-msg-opt (2016-12-14) 1 commit
  (merged to 'next' on 2016-12-19 at c488c7c6e1)
 + parse-options: print "fatal:" before usage_msg_opt()

 The function usage_msg_opt() has been updated to say "fatal:"
 before the custom message programs give, when they want to die
 with a message about wrong command line options followed by the
 standard usage string.

 Will merge to 'master'.


* ld/p4-compare-dir-vs-symlink (2016-12-18) 1 commit
 - git-p4: avoid crash adding symlinked directory

 "git p4" misbehaved when swapping a directory and a symbolic link.

 Will merge to 'next'.


* js/prepare-sequencer-more (2016-12-14) 34 commits
 - sequencer (rebase -i): write out the final message
 - sequencer (rebase -i): write the progress into files
 - sequencer (rebase -i): show the progress
 - sequencer (rebase -i): suggest --edit-todo upon unknown command
 - sequencer (rebase -i): show only failed cherry-picks' output
 - sequencer (rebase -i): show only failed `git commit`'s output
 - run_command_opt(): optionally hide stderr when the command succeeds
 - sequencer (rebase -i): differentiate between comments and 'noop'
 - sequencer (rebase -i): implement the 'drop' command
 - sequencer (rebase -i): allow rescheduling commands
 - sequencer (rebase -i): respect strategy/strategy_opts settings
 - sequencer (rebase -i): respect the rebase.autostash setting
 - sequencer (rebase -i): run the post-rewrite hook, if needed
 - sequencer (rebase -i): record interrupted commits in rewritten, too
 - sequencer (rebase -i): copy commit notes at end
 - sequencer (rebase -i): set the reflog message consistently
 - sequencer (rebase -i): refactor setting the reflog message
 - sequencer (rebase -i): allow fast-forwarding for edit/reword
 - sequencer (rebase -i): implement the 'reword' command
 - sequencer (rebase -i): leave a patch upon error
 - sequencer (rebase -i): update refs after a successful rebase
 - sequencer (rebase -i): the todo can be empty when continuing
 - sequencer (rebase -i): skip some revert/cherry-pick specific code path
 - sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
 - sequencer (rebase -i): allow continuing with staged changes
 - sequencer (rebase -i): write an author-script file
 - sequencer (rebase -i): implement the short commands
 - sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
 - sequencer (rebase -i): write the 'done' file
 - sequencer (rebase -i): learn about the 'verbose' mode
 - sequencer (rebase -i): implement the 'exec' command
 - sequencer (rebase -i): implement the 'edit' command
 - sequencer (rebase -i): implement the 'noop' command
 - sequencer: support a new action: 'interactive rebase'

 The sequencer has further been extended in preparation to act as a
 back-end for "rebase -i".

 Waiting for review.


* jk/index-pack-wo-repo-from-stdin (2016-12-16) 4 commits
  (merged to 'next' on 2016-12-19 at 9a88221347)
 + index-pack: skip collision check when not in repository
 + t: use nongit() function where applicable
 + index-pack: complain when --stdin is used outside of a repo
 + t5000: extract nongit function to test-lib-functions.sh

 "git index-pack --stdin" needs an access to an existing repository,
 but "git index-pack file.pack" to generate an .idx file that
 corresponds to a packfile does not.

 Will merge to 'master'.


* lt/shortlog-by-committer (2016-12-16) 2 commits
  (merged to 'next' on 2016-12-19 at 555976fc0a)
 + shortlog: test and document --committer option
 + shortlog: group by committer information

 "git shortlog" learned "--committer" option to group commits by
 committer, instead of author.

 Will merge to 'master'.


* bw/realpath-wo-chdir (2016-12-12) 4 commits
 - real_path: have callers use real_pathdup and strbuf_realpath
 - real_path: create real_pathdup
 - real_path: convert real_path_internal to strbuf_realpath
 - real_path: resolve symlinks by hand
 (this branch is used by bw/grep-recurse-submodules.)

 The implementation of "real_path()" was to go there with chdir(2)
 and call getcwd(3), but this obviously wouldn't be usable in a
 threaded environment.  Rewrite it to manually resolve relative
 paths including symbolic links in path components.

 Will merge to 'next'.


* jk/quote-env-path-list-component (2016-12-13) 4 commits
  (merged to 'next' on 2016-12-16 at d2cd6008b9)
 + t5547-push-quarantine: run the path separator test on Windows, too
 + tmp-objdir: quote paths we add to alternates
 + alternates: accept double-quoted paths
 + Merge branch 'jk/alt-odb-cleanup' into jk/quote-env-path-list-component

 A recent update to receive-pack to make it easier to drop garbage
 objects made it clear that GIT_ALTERNATE_OBJECT_DIRECTORIES cannot
 have a pathname with a colon in it (no surprise!), and this in turn
 made it impossible to push into a repository at such a path.  This
 has been fixed by introducing a quoting mechanism used when
 appending such a path to the colon-separated list.

 Will merge to 'master'.


* nd/shallow-fixup (2016-12-07) 6 commits
  (merged to 'next' on 2016-12-13 at 1a3edb8bce)
 + shallow.c: remove useless code
 + shallow.c: bit manipulation tweaks
 + shallow.c: avoid theoretical pointer wrap-around
 + shallow.c: make paint_alloc slightly more robust
 + shallow.c: stop abusing COMMIT_SLAB_SIZE for paint_info's memory pools
 + shallow.c: rename fields in paint_info to better express their purposes

 Code cleanup in shallow boundary computation.

 Will merge to 'master'.


* sb/sequencer-abort-safety (2016-12-14) 6 commits
  (merged to 'next' on 2016-12-16 at ec71fb1217)
 + Revert "sequencer: remove useless get_dir() function"
  (merged to 'next' on 2016-12-13 at 6107e43d65)
 + sequencer: remove useless get_dir() function
 + sequencer: make sequencer abort safer
 + t3510: test that cherry-pick --abort does not unsafely change HEAD
 + am: change safe_to_abort()'s not rewinding error into a warning
 + am: fix filename in safe_to_abort() error message

 Unlike "git am --abort", "git cherry-pick --abort" moved HEAD back
 to where cherry-pick started while picking multiple changes, when
 the cherry-pick stopped to ask for help from the user, and the user
 did "git reset --hard" to a different commit in order to re-attempt
 the operation.

 Will merge to 'master'.


* jk/difftool-in-subdir (2016-12-11) 4 commits
 - difftool: rename variables for consistency
 - difftool: chdir as early as possible
 - difftool: sanitize $workdir as early as possible
 - difftool: fix dir-diff index creation when in a subdirectory

 Even though an fix was attempted in Git 2.9.3 days, but running
 "git difftool --dir-diff" from a subdirectory never worked. This
 has been fixed.

 Will merge to 'next'.


* vs/submodule-clone-nested-submodules-alternates (2016-12-12) 1 commit
  (merged to 'next' on 2016-12-13 at 8a317ab745)
 + submodule--helper: set alternateLocation for cloned submodules

 "git clone --reference $there --recurse-submodules $super" has been
 taught to guess repositories usable as references for submodules of
 $super that are embedded in $there while making a clone of the
 superproject borrow objects from $there; extend the mechanism to
 also allow submodules of these submodules to borrow repositories
 embedded in these clones of the submodules embedded in the clone of
 the superproject.

 Will merge to 'master'.


* ls/filter-process (2016-12-18) 2 commits
  (merged to 'next' on 2016-12-19 at 5ed29656db)
 + t0021: fix flaky test
  (merged to 'next' on 2016-12-12 at 8ed1f9eb02)
 + docs: warn about possible '=' in clean/smudge filter process values

 Doc update.

 Will merge to 'master'.


* js/difftool-builtin (2016-11-28) 2 commits
 - difftool: implement the functionality in the builtin
 - difftool: add a skeleton for the upcoming builtin

 Rewrite a scripted porcelain "git difftool" in C.

 What's the doneness of this topic?


* sb/push-make-submodule-check-the-default (2016-11-29) 2 commits
  (merged to 'next' on 2016-12-12 at 1863e05af5)
 + push: change submodule default to check when submodules exist
 + submodule add: extend force flag to add existing repos

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Will cook in 'next'.


* sb/submodule-embed-gitdir (2016-12-12) 6 commits
 - submodule: add absorb-git-dir function
 - move connect_work_tree_and_git_dir to dir.h
 - worktree: check if a submodule uses worktrees
 - test-lib-functions.sh: teach test_commit -C <dir>
 - submodule helper: support super prefix
 - submodule: use absolute path for computing relative path connecting

 A new submodule helper "git submodule embedgitdirs" to make it
 easier to move embedded .git/ directory for submodules in a
 superproject to .git/modules/ (and point the latter with the former
 that is turned into a "gitdir:" file) has been added.

 Will merge to 'next'.


* bw/grep-recurse-submodules (2016-12-16) 7 commits
 - grep: search history of moved submodules
 - grep: enable recurse-submodules to work on <tree> objects
 - grep: optionally recurse into submodules
 - grep: add submodules as a grep source type
 - submodules: load gitmodules file from commit sha1
 - submodules: add helper to determine if a submodule is initialized
 - submodules: add helper to determine if a submodule is populated
 (this branch uses bw/realpath-wo-chdir.)

 "git grep" learns to optionally recurse into submodules

 Will merge to 'next'.


* dt/smart-http-detect-server-going-away (2016-11-18) 2 commits
  (merged to 'next' on 2016-12-05 at 3ea70d01af)
 + upload-pack: optionally allow fetching any sha1
 + remote-curl: don't hang when a server dies before any output

 Originally merged to 'next' on 2016-11-21

 When the http server gives an incomplete response to a smart-http
 rpc call, it could lead to client waiting for a full response that
 will never come.  Teach the client side to notice this condition
 and abort the transfer.

 An improvement counterproposal has failed.
 cf. <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>

 Will cook in 'next'.


* mm/push-social-engineering-attack-doc (2016-11-14) 1 commit
  (merged to 'next' on 2016-12-05 at 9a2b5bd1a9)
 + doc: mention transfer data leaks in more places

 Originally merged to 'next' on 2016-11-16

 Doc update on fetching and pushing.

 Will cook in 'next'.


* jc/compression-config (2016-11-15) 1 commit
  (merged to 'next' on 2016-12-05 at 323769ca07)
 + compression: unify pack.compression configuration parsing

 Originally merged to 'next' on 2016-11-23

 Compression setting for producing packfiles were spread across
 three codepaths, one of which did not honor any configuration.
 Unify these so that all of them honor core.compression and
 pack.compression variables the same way.

 Will cook in 'next'.


* mm/gc-safety-doc (2016-11-16) 1 commit
  (merged to 'next' on 2016-12-05 at 031ecc1886)
 + git-gc.txt: expand discussion of races with other processes

 Originally merged to 'next' on 2016-11-17

 Doc update.

 Will cook in 'next'.


* kn/ref-filter-branch-list (2016-12-08) 20 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
 - ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
 - ref-filter: rename the 'strip' option to 'lstrip'
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms
 - for-each-ref: do not segv with %(HEAD) on an unborn branch

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 What's the doneness of the topic?  I recall discussing die vs empty
 and also saw a "squash this in when you reroll", but I lost track.


* bw/transport-protocol-policy (2016-12-15) 6 commits
  (merged to 'next' on 2016-12-19 at 166168205c)
 + http: respect protocol.*.allow=user for http-alternates
 + transport: add from_user parameter to is_transport_allowed
 + http: create function to get curl allowed protocols
 + transport: add protocol policy config option
 + http: always warn if libcurl version is too old
 + lib-proto-disable: variable name fix

 Finer-grained control of what protocols are allowed for transports
 during clone/fetch/push have been enabled via a new configuration
 mechanism.

 Will merge to 'master'.


* jt/fetch-no-redundant-tag-fetch-map (2016-11-11) 1 commit
  (merged to 'next' on 2016-12-05 at 432f9469a7)
 + fetch: do not redundantly calculate tag refmap

 Originally merged to 'next' on 2016-11-16

 Code cleanup to avoid using redundant refspecs while fetching with
 the --tags option.

 Will cook in 'next'.


* sb/submodule-config-cleanup (2016-11-22) 3 commits
  (merged to 'next' on 2016-12-05 at 658b8764bf)
 + submodule-config: clarify parsing of null_sha1 element
 + submodule-config: rename commit_sha1 to treeish_name
 + submodule config: inline config_from_{name, path}

 Originally merged to 'next' on 2016-11-23

 Minor code clean-up.

 Will cook in 'next'.


* jc/push-default-explicit (2016-10-31) 2 commits
  (merged to 'next' on 2016-12-05 at d63f3777af)
 + push: test pushing ambiguously named branches
 + push: do not use potentially ambiguous default refspec

 Originally merged to 'next' on 2016-11-01

 A lazy "git push" without refspec did not internally use a fully
 specified refspec to perform 'current', 'simple', or 'upstream'
 push, causing unnecessary "ambiguous ref" errors.

 Will cook in 'next'.


* jc/git-open-cloexec (2016-11-02) 3 commits
 - sha1_file: stop opening files with O_NOATIME
 - git_open_cloexec(): use fcntl(2) w/ FD_CLOEXEC fallback
 - git_open(): untangle possible NOATIME and CLOEXEC interactions

 The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
 opens has been simplified.

 We may want to drop the tip one.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-12-05 at 0c77e39cd5)
 + setup_git_env: avoid blind fall-back to ".git"

 Originally merged to 'next' on 2016-10-26

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/reset-unmerge (2016-10-24) 1 commit
 - reset: --unmerge

 After "git add" is run prematurely during a conflict resolution,
 "git diff" can no longer be used as a way to sanity check by
 looking at the combined diff.  "git reset" learned a new
 "--unmerge" option to recover from this situation.

 Will discard.
 This may not be needed, given that update-index has a similar
 option.


* jc/merge-base-fp-only (2016-10-19) 8 commits
 . merge-base: fp experiment
 - merge: allow to use only the fp-only merge bases
 - merge-base: limit the output to bases that are on first-parent chain
 - merge-base: mark bases that are on first-parent chain
 - merge-base: expose get_merge_bases_many_0() a bit more
 - merge-base: stop moving commits around in remove_redundant()
 - sha1_name: remove ONELINE_SEEN bit
 - commit: simplify fastpath of merge-base

 An experiment of merge-base that ignores common ancestors that are
 not on the first parent chain.

 Will discard.
 The whole premise feels wrong.


* tb/convert-stream-check (2016-10-27) 2 commits
 - convert.c: stream and fast search for binary
 - read-cache: factor out get_sha1_from_index() helper

 End-of-line conversion sometimes needs to see if the current blob
 in the index has NULs and CRs to base its decision.  We used to
 always get a full statistics over the blob, but in many cases we
 can return early when we have seen "enough" (e.g. if we see a
 single NUL, the blob will be handled as binary).  The codepaths
 have been optimized by using streaming interface.

 Will discard.
 Retracted.
 cf. <20161102071646.GA5094@tb-raspi>


* pb/bisect (2016-10-18) 27 commits
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Waiting for review.


* st/verify-tag (2016-10-10) 7 commits
 - t/t7004-tag: Add --format specifier tests
 - t/t7030-verify-tag: Add --format specifier tests
 - builtin/tag: add --format argument for tag -v
 - builtin/verify-tag: add --format to verify-tag
 - tag: add format specifier to gpg_verify_tag
 - ref-filter: add function to print single ref_array_item
 - gpg-interface, tag: add GPG_VERIFY_QUIET flag

 "git tag" and "git verify-tag" learned to put GPG verification
 status in their "--format=<placeholders>" output format.

 Waiting for a reroll.
 cf. <20161007210721.20437-1-santiago@nyu.edu>


* sb/attr (2016-11-11) 35 commits
 . completion: clone can initialize specific submodules
 . clone: add --init-submodule=<pathspec> switch
 . submodule update: add `--init-default-path` switch
 . pathspec: allow escaped query values
 . pathspec: allow querying for attributes
 . pathspec: move prefix check out of the inner loop
 . pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 - attr: keep attr stack for each check
 - attr: convert to new threadsafe API
 - attr: make git_check_attr_counted static
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.
 Building on top of the updated API, the pathspec machinery learned
 to select only paths with given attributes set.

 The parts near the tip about pathspec would need to work better
 with bw/pathspec-cleanup topic and has been dropped for now.


* va/i18n-perl-scripts (2016-12-14) 16 commits
  (merged to 'next' on 2016-12-19 at ec800aba9f)
 + i18n: difftool: mark warnings for translation
 + i18n: send-email: mark composing message for translation
 + i18n: send-email: mark string with interpolation for translation
 + i18n: send-email: mark warnings and errors for translation
 + i18n: send-email: mark strings for translation
 + i18n: add--interactive: mark status words for translation
 + i18n: add--interactive: remove %patch_modes entries
 + i18n: add--interactive: mark edit_hunk_manually message for translation
 + i18n: add--interactive: i18n of help_patch_cmd
 + i18n: add--interactive: mark patch prompt for translation
 + i18n: add--interactive: mark plural strings
 + i18n: clean.c: match string with git-add--interactive.perl
 + i18n: add--interactive: mark strings with interpolation for translation
 + i18n: add--interactive: mark simple here-documents for translation
 + i18n: add--interactive: mark strings for translation
 + Git.pm: add subroutines for commenting lines

 Porcelain scripts written in Perl are getting internationalized.

 Will merge to 'master'.


* jc/latin-1 (2016-09-26) 2 commits
  (merged to 'next' on 2016-12-05 at fb549caa12)
 + utf8: accept "latin-1" as ISO-8859-1
 + utf8: refactor code to decide fallback encoding

 Originally merged to 'next' on 2016-09-28

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.

 Will cook in 'next'.


* sg/fix-versioncmp-with-common-suffix (2016-12-08) 8 commits
 - versioncmp: generalize version sort suffix reordering
 - squash! versioncmp: use earliest-longest contained suffix to determine sorting order
 - versioncmp: use earliest-longest contained suffix to determine sorting order
 - versioncmp: cope with common part overlapping with prerelease suffix
 - versioncmp: pass full tagnames to swap_prereleases()
 - t7004-tag: add version sort tests to show prerelease reordering issues
 - t7004-tag: use test_config helper
 - t7004-tag: delete unnecessary tags with test_when_finished

 The prereleaseSuffix feature of version comparison that is used in
 "git tag -l" did not correctly when two or more prereleases for the
 same release were present (e.g. when 2.0, 2.0-beta1, and 2.0-beta2
 are there and the code needs to compare 2.0-beta1 and 2.0-beta2).

 Waiting for review.
 cf. <20161208142401.1329-1-szeder.dev@gmail.com>


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-12-05 at 041946dae0)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2016-10-11

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.

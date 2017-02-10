Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144AC1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdBJWY1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:24:27 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32857 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdBJWY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:24:26 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so4010912pgd.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=djmd2TIGAh7jfLOQa78DPaYCvf9mEuwghj3xd887qTo=;
        b=QTba4qIDTwtFF1sADm38pF5nXR/tFu1k7BR0NFMSkahcUmV+GpXx5LQ9MNMglNHAeI
         DI1s/dbbtq+QTGjVC5I+OQhaZ1HCk5ezqpqI67MnnPwg3xRck7dBoZvibS7yFqZFGmzW
         exPK5FtK6+iQ+Kpfut0PPvGfceBRiDLdA6DocEFZ3t3YNzfE3qY39IHva6yZimUl+TFK
         T6fnANHu7H6/ozGWgIaUUP2FERz3fvt8db2CAaqaeWSyWBqnzCtUuhzcuG3Mi1N9frpQ
         ruD/VgmHyvnEuVcruMeFqw/B28GGG3Tkro5Z+JejXnrPi2qHQfMCk2HhVK3qJK/Zatg5
         1vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=djmd2TIGAh7jfLOQa78DPaYCvf9mEuwghj3xd887qTo=;
        b=cMtdsH7ycqx8xSlYNcCn/K87jwkhFlzYXTUq8lVmfwYryaWakv01JKJ1gMa/VSFfQw
         zQmz//+r0Cw7rpw5C6QCIZIm0jRG1RB8oGDLqvOSchchO0k48zYPSdfBoqtJWsEP8tzh
         R/W0OXpOM1t9byRfOgFACEh17Ya69mkKNxp/xgmvDGoPhlWAB9zlOnBLMhtlcIlAyOMi
         ZBMiRUjt8Iz6WSwkghK3wf0/yD/i9QQu4hzM0K5ICDGceiCbMGKTJG2MVrjdmpX6ri41
         XfdVEKKOPbAuR2Ezbfd4pYp5F7hoCTI0FmaN3pOIiod/au21TkY0VpHpOv6F0UHlKEGD
         oaWg==
X-Gm-Message-State: AMke39naLcsSD6gGfcw68LwAtigure1lsGGayWEyB/c6YmIf3cndAP+pJw9RMDWoed7Syw==
X-Received: by 10.99.121.195 with SMTP id u186mr13536982pgc.96.1486765464635;
        Fri, 10 Feb 2017 14:24:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id p6sm7484644pfg.6.2017.02.10.14.24.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 14:24:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: What's cooking in git.git (Feb 2017, #03; Fri, 10)
X-master-at: 5588dbffbd61e4906e453808c6ad32f792fea521
X-next-at: 8ea7874076a995b24efb1d735d9d27a7709c3ecb
Date:   Fri, 10 Feb 2017 14:24:23 -0800
Message-ID: <xmqq37flk7l4.fsf@gitster.mtv.corp.google.com>
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

2.12-rc1 has been tagged and most of the big things are behind us (I
am reluctant to merge anything large-ish after -rc0 and that was why
-rc0 preview had topics that cooked in 'next' only for a few days
in---usually my rule is to keep any non-trivial topic for about a
week in 'next').  There still are interesting and/or exciting things
coming into 'next', hopefully they will be the "killer" additions
for the release after the upcoming 2.12.  In the meantime, lets make
sure that we catch regressions in -rc1 and the tip of 'master'.

Oh, also I'd like to get pull requests for gitk and git-gui updates
soonish, if we are to have one during this cycle.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bw/push-submodule-only (2017-02-01) 2 commits
  (merged to 'next' on 2017-02-06 at 851edafb14)
 + completion: add completion for --recurse-submodules=only
 + doc: add doc for git-push --recurse-submodules=only

 Add missing documentation update to a recent topic.


* da/t7800-cleanup (2017-02-08) 2 commits
  (merged to 'next' on 2017-02-10 at c983b65d33)
 + t7800: replace "wc -l" with test_line_count
 + Merge branch 'da/difftool-dir-diff-fix' into da/t7800-cleanup
 (this branch uses js/difftool-builtin.)

 Test updates.


* dl/difftool-doc-no-gui-option (2017-02-08) 1 commit
  (merged to 'next' on 2017-02-10 at 3a3496a740)
 + Document the --no-gui option in difftool

 Doc update.


* ew/complete-svn-authorship-options (2017-02-06) 1 commit
  (merged to 'next' on 2017-02-06 at dca324db7c)
 + completion: fix git svn authorship switches

 Correct command line completion (in contrib/) on "git svn"


* jk/log-graph-name-only (2017-02-08) 1 commit
  (merged to 'next' on 2017-02-10 at 2ab7ed99f4)
 + diff: print line prefix for --name-only output

 "git log --graph" did not work well with "--name-only", even though
 other forms of "diff" output were handled correctly.


* jk/reset-to-break-a-commit-doc (2017-02-03) 1 commit
  (merged to 'next' on 2017-02-06 at 7f571e62e9)
 + reset: add an example of how to split a commit into two

 A minor doc update.


* js/difftool-builtin (2017-02-08) 2 commits
  (merged to 'next' on 2017-02-10 at 30b3f383e8)
 + t7800: simplify basic usage test
  (merged to 'next' on 2017-02-06 at 6a90549f38)
 + difftool: fix bug when printing usage
 (this branch is used by da/t7800-cleanup.)

 A few hot-fixes to C-rewrite of "git difftool".


* nd/rev-list-all-includes-HEAD-doc (2017-02-08) 1 commit
  (merged to 'next' on 2017-02-10 at 5df8b81b57)
 + rev-list-options.txt: update --all about HEAD

 Doc update.


* ps/worktree-prune-help-fix (2017-02-06) 1 commit
  (merged to 'next' on 2017-02-06 at eeb96f1677)
 + worktree: fix option descriptions for `prune`

 Incorrect usage help message for "git worktree prune" has been fixed.


* rs/fill-directory-optim (2017-02-08) 1 commit
  (merged to 'next' on 2017-02-10 at 71047464df)
 + dir: avoid allocation in fill_directory()

 Code clean-up.


* rs/p5302-create-repositories-before-tests (2017-02-06) 1 commit
  (merged to 'next' on 2017-02-06 at f93bd2ed47)
 + p5302: create repositories for index-pack results explicitly

 Adjust a perf test to new world order where commands that do
 require a repository are really strict about having a repository.

--------------------------------------------------
[New Topics]

* jk/alternate-ref-optim (2017-02-08) 11 commits
  (merged to 'next' on 2017-02-10 at f26f32cff6)
 + receive-pack: avoid duplicates between our refs and alternates
 + receive-pack: treat namespace .have lines like alternates
 + receive-pack: fix misleading namespace/.have comment
 + receive-pack: use oidset to de-duplicate .have lines
 + add oidset API
 + fetch-pack: cache results of for_each_alternate_ref
 + for_each_alternate_ref: replace transport code with for-each-ref
 + for_each_alternate_ref: pass name/oid instead of ref struct
 + for_each_alternate_ref: use strbuf for path allocation
 + for_each_alternate_ref: stop trimming trailing slashes
 + for_each_alternate_ref: handle failure from real_pathdup()

 Optimizes resource usage while enumerating refs from alternate
 object store, to help receiving end of "push" that hosts a
 repository with many "forks".

 Will cook in 'next'.


* lt/pathspec-negative (2017-02-10) 2 commits
  (merged to 'next' on 2017-02-10 at 8ea7874076)
 + pathspec: don't error out on all-exclusionary pathspec patterns
 + pathspec magic: add '^' as alias for '!'

 The "negative" pathspec feature was somewhat more cumbersome to use
 than necessary in that its short-hand used "!" which needed to be
 escaped from shells, and it required "exclude from what?" specified.

 Will cook in 'next'.


* nd/worktree-gc-protection (2017-02-08) 2 commits
 - worktree.c: use submodule interface to access refs from another worktree
 - refs.c: add resolve_ref_submodule()

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Michael had a suggestion for a (hopefully) better alternative way
 to do this.  Expecting a reroll (either a tenative but quicker way,
 or a better but slower way).
 cf. <CACsJy8Diy92CNbJ1OBn893VFFrSsxBFWSyQHjt_Dzq9x7jfibQ@mail.gmail.com>


* sb/push-options-via-transport (2017-02-08) 1 commit
  (merged to 'next' on 2017-02-10 at 3e2d08e1fa)
 + push options: pass push options to the transport helper

 The push-options given via the "--push-options" option were not
 passed through to external remote helpers such as "smart HTTP" that
 are invoked via the transport helper.

 Will merge to 'master'.


* js/rebase-helper (2017-02-09) 2 commits
 - rebase -i: use the rebase--helper builtin
 - rebase--helper: add a builtin helper for interactive rebases

 "git rebase -i" starts using the recently updated "sequencer" code.

 Will merge to and then cook in 'next'.
 The change itself is small, but what it enables is rather a large
 body of new code.  We are getting there ;-)


* mh/submodule-hash (2017-02-10) 9 commits
 - read_loose_refs(): read refs using resolve_ref_recursively()
 - files_ref_store::submodule: use NULL for the main repository
 - base_ref_store_init(): remove submodule argument
 - refs: push the submodule attribute down
 - refs: store submodule ref stores in a hashmap
 - register_ref_store(): new function
 - refs: remove some unnecessary handling of submodule == ""
 - refs: make some ref_store lookup functions private
 - refs: reorder some function definitions

 Code and design clean-up for the refs API.

 Will merge to and then cook in 'next'.


* jh/mingw-openssl-sha1 (2017-02-09) 1 commit
  (merged to 'next' on 2017-02-10 at 084b3d8503)
 + mingw: use OpenSSL's SHA-1 routines

 Windows port wants to use OpenSSL's implementation of SHA-1
 routines, so let them.

 Will merge to 'master'.


* sb/doc-unify-bottom (2017-02-09) 1 commit
  (merged to 'next' on 2017-02-10 at 7229c4c1f7)
 + Documentation: unify bottom "part of git suite" lines

 Doc clean-up.

 Will merge to 'master'.


* dt/gc-ignore-old-gc-logs (2017-02-10) 2 commits
 - SQUASH???
 - gc: ignore old gc.log files

 A "gc.log" file left by a backgrounded "gc --auto" disables further
 automatic gc; it has been taught to run at least once a day (by
 default) by ignoring a stale "gc.log" file that is too old.

 Waiting for the discussion and reroll to quiet down (this one is v3
 or so and I saw v5 posted).


* js/git-path-in-subdir (2017-02-10) 2 commits
 - rev-parse: fix several options when running in a subdirectory
 - rev-parse tests: add tests executed from a subdirectory

 The "--git-path", "--git-common-dir", and "--shared-index-path"
 options of "git rev-parse" did not produce usable output.  They are
 now updated to show the path to the correct file, relative to where
 the caller is.

 Waiting for Review/Ack.
 cf. <cover.1486740772.git.johannes.schindelin@gmx.de>

--------------------------------------------------
[Stalled]

* vn/xdiff-func-context (2017-01-15) 1 commit
 - xdiff -W: relax end-of-file function detection

 "git diff -W" has been taught to handle the case where a new
 function is added at the end of the file better.

 Will hold.
 Discussion on an follow-up change to go back from the line that
 matches the funcline to show comments before the function
 definition has not resulted in an actionable conclusion.


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

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>


* ls/filter-process-delayed (2017-01-08) 1 commit
 . convert: add "status=delayed" to filter process protocol

 Ejected, as does not build when merged to 'pu'.


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

 Waiting for the review discussion to settle, followed by a reroll.


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

* ls/p4-path-encoding (2017-02-09) 1 commit
 - git-p4: fix git-p4.pathEncoding for removed files

 When "git p4" imports changelist that removes paths, it failed to
 convert pathnames when the p4 used encoding different from the one
 used on the Git side.  This has been corrected.

 Waiting for Review/Ack.
 cf. <20170209150656.9070-1-larsxschneider@gmail.com>


* mh/ref-remove-empty-directory (2017-01-07) 23 commits
  (merged to 'next' on 2017-02-10 at bcfd359e95)
 + files_transaction_commit(): clean up empty directories
 + try_remove_empty_parents(): teach to remove parents of reflogs, too
 + try_remove_empty_parents(): don't trash argument contents
 + try_remove_empty_parents(): rename parameter "name" -> "refname"
 + delete_ref_loose(): inline function
 + delete_ref_loose(): derive loose reference path from lock
 + log_ref_write_1(): inline function
 + log_ref_setup(): manage the name of the reflog file internally
 + log_ref_write_1(): don't depend on logfile argument
 + log_ref_setup(): pass the open file descriptor back to the caller
 + log_ref_setup(): improve robustness against races
 + log_ref_setup(): separate code for create vs non-create
 + log_ref_write(): inline function
 + rename_tmp_log(): improve error reporting
 + rename_tmp_log(): use raceproof_create_file()
 + lock_ref_sha1_basic(): use raceproof_create_file()
 + lock_ref_sha1_basic(): inline constant
 + raceproof_create_file(): new function
 + safe_create_leading_directories(): set errno on SCLD_EXISTS
 + safe_create_leading_directories_const(): preserve errno
 + t5505: use "for-each-ref" to test for the non-existence of references
 + refname_is_safe(): correct docstring
 + files_rename_ref(): tidy up whitespace

 Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
 once there no longer is any other branch whose name begins with
 "foo/", but we didn't do so so far.  Now we do.

 Will cook in 'next'.


* cw/completion (2017-02-03) 7 commits
  (merged to 'next' on 2017-02-10 at b3a5cbf39c)
 + completion: recognize more long-options
 + completion: teach remote subcommands to complete options
 + completion: teach replace to complete options
 + completion: teach ls-remote to complete options
 + completion: improve bash completion for git-add
 + completion: add subcommand completion for rerere
 + completion: teach submodule subcommands to complete options

 More command line completion (in contrib/) for recent additions.

 Will merge to 'master'.


* cw/tag-reflog-message (2017-02-08) 1 commit
  (merged to 'next' on 2017-02-10 at 3968b3a58b)
 + tag: generate useful reflog message

 "git tag", because refs/tags/* doesn't keep reflog by default, did
 not leave useful message when adding a new entry to reflog.

 Will cook in 'next'.


* sg/completion (2017-02-03) 21 commits
  (merged to 'next' on 2017-02-10 at 55b2785d89)
 + completion: cache the path to the repository
 + completion: extract repository discovery from __gitdir()
 + completion: don't guard git executions with __gitdir()
 + completion: consolidate silencing errors from git commands
 + completion: don't use __gitdir() for git commands
 + completion: respect 'git -C <path>'
 + rev-parse: add '--absolute-git-dir' option
 + completion: fix completion after 'git -C <path>'
 + completion: don't offer commands when 'git --opt' needs an argument
 + completion: list short refs from a remote given as a URL
 + completion: don't list 'HEAD' when trying refs completion outside of a repo
 + completion: list refs from remote when remote's name matches a directory
 + completion: respect 'git --git-dir=<path>' when listing remote refs
 + completion: fix most spots not respecting 'git --git-dir=<path>'
 + completion: ensure that the repository path given on the command line exists
 + completion tests: add tests for the __git_refs() helper function
 + completion tests: check __gitdir()'s output in the error cases
 + completion tests: consolidate getting path of current working directory
 + completion tests: make the $cur variable local to the test helper functions
 + completion tests: don't add test cruft to the test repository
 + completion: improve __git_refs()'s in-code documentation
 (this branch is used by sg/completion-refs-speedup.)

 Clean-up and updates to command line completion (in contrib/).

 Will merge to 'master'.


* sg/completion-refs-speedup (2017-02-06) 13 commits
 - squash! completion: fill COMPREPLY directly when completing refs
 - completion: fill COMPREPLY directly when completing refs
 - completion: list only matching symbolic and pseudorefs when completing refs
 - completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' strip the remote name from remote branches
 - completion: let 'for-each-ref' and 'ls-remote' filter matching refs
 - completion: don't disambiguate short refs
 - completion: don't disambiguate tags and branches
 - completion: support excluding full refs
 - completion: support completing full refs after '--option=refs/<TAB>'
 - completion: wrap __git_refs() for better option parsing
 - completion: remove redundant __gitcomp_nl() options from _git_commit()
 (this branch uses sg/completion.)

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 Will hold.


* sk/parse-remote-cleanup (2017-02-06) 1 commit
  (merged to 'next' on 2017-02-06 at 6ec89f72d5)
 + parse-remote: remove reference to unused op_prep

 Code clean-up.

 Undecided.  There may be third-party scripts that are dot-sourcing
 this one.


* jk/delta-chain-limit (2017-01-27) 2 commits
  (merged to 'next' on 2017-02-06 at 9ff36ae9b2)
 + pack-objects: convert recursion to iteration in break_delta_chain()
 + pack-objects: enforce --depth limit in reused deltas

 "git repack --depth=<n>" for a long time busted the specified depth
 when reusing delta from existing packs.  This has been corrected.

 Will cook in 'next'.


* mm/merge-rename-delete-message (2017-01-30) 1 commit
  (merged to 'next' on 2017-02-10 at 8bf8146029)
 + merge-recursive: make "CONFLICT (rename/delete)" message show both paths

 When "git merge" detects a path that is renamed in one history
 while the other history deleted (or modified) it, it now reports
 both paths to help the user understand what is going on in the two
 histories being merged.

 Will cook in 'next'.


* rs/swap (2017-01-30) 5 commits
  (merged to 'next' on 2017-02-10 at 5253797d0a)
 + graph: use SWAP macro
 + diff: use SWAP macro
 + use SWAP macro
 + apply: use SWAP macro
 + add SWAP macro

 Code clean-up.

 Will merge to 'master'.


* ps/urlmatch-wildcard (2017-02-01) 5 commits
  (merged to 'next' on 2017-02-10 at 2ed9ea48ee)
 + urlmatch: allow globbing for the URL host part
 + urlmatch: include host in urlmatch ranking
 + urlmatch: split host and port fields in `struct url_info`
 + urlmatch: enable normalization of URLs with globs
 + mailmap: add Patrick Steinhardt's work address

 The <url> part in "http.<url>.<variable>" configuration variable
 can now be spelled with '*' that serves as wildcard.
 E.g. "http.https://*.example.com.proxy" can be used to specify the
 proxy used for https://a.example.com, https://b.example.com, etc.,
 i.e. any host in the example.com domain.

 Will cook in 'next'.


* sf/putty-w-args (2017-02-10) 5 commits
 - connect.c: stop conflating ssh command names and overrides
 - connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
 - git_connect(): factor out SSH variant handling
 - connect: rename tortoiseplink and putty variables
 - connect: handle putty/plink also in GIT_SSH_COMMAND

 The command line options for ssh invocation needs to be tweaked for
 some implementations of SSH (e.g. PuTTY plink wants "-P <port>"
 while OpenSSH wants "-p <port>" to specify port to connect to), and
 the variant was guessed when GIT_SSH environment variable is used
 to specify it.  Extend the guess to the command specified by the
 newer GIT_SSH_COMMAND and also core.sshcommand configuration
 variable, and give an escape hatch for users to deal with
 misdetected cases.

 Will merge to 'next' and then to 'master'.


* jk/describe-omit-some-refs (2017-01-23) 5 commits
  (merged to 'next' on 2017-01-23 at f8a14b4996)
 + describe: teach describe negative pattern matches
 + describe: teach --match to accept multiple patterns
 + name-rev: add support to exclude refs by pattern match
 + name-rev: extend --refs to accept multiple patterns
 + doc: add documentation for OPT_STRING_LIST

 "git describe" and "git name-rev" have been taught to take more
 than one refname patterns to restrict the set of refs to base their
 naming output on, and also learned to take negative patterns to
 name refs not to be used for naming via their "--exclude" option.

 Will cook in 'next'.


* sb/submodule-doc (2017-01-12) 2 commits
  (merged to 'next' on 2017-02-10 at 5bfad5f30e)
 + submodule update documentation: don't repeat ourselves
 + submodule documentation: add options to the subcommand

 Doc updates.

 Will merge to 'master'.


* bw/attr (2017-02-01) 27 commits
 - attr: reformat git_attr_set_direction() function
 - attr: push the bare repo check into read_attr()
 - attr: store attribute stack in attr_check structure
 - attr: tighten const correctness with git_attr and match_attr
 - attr: remove maybe-real, maybe-macro from git_attr
 - attr: eliminate global check_all_attr array
 - attr: use hashmap for attribute dictionary
 - attr: change validity check for attribute names to use positive logic
 - attr: pass struct attr_check to collect_some_attrs
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct attr_check"
 - attr: (re)introduce git_check_attr() and struct attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: outline the future plans by heavily commenting
 - Documentation: fix a typo
 - attr.c: add push_stack() helper
 - attr: support quoting pathname patterns in C style
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line

 The gitattributes machinery is being taught to work better in a
 multi-threaded environment.

 Will merge to and then cook in 'next'.


* nd/worktree-move (2017-01-27) 7 commits
 . fixup! worktree move: new command
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Tentatively ejected as it seems to break 'pu' when merged.


* cc/split-index-config (2016-12-26) 21 commits
 - Documentation/git-update-index: explain splitIndex.*
 - Documentation/config: add splitIndex.sharedIndexExpire
 - read-cache: use freshen_shared_index() in read_index_from()
 - read-cache: refactor read_index_from()
 - t1700: test shared index file expiration
 - read-cache: unlink old sharedindex files
 - config: add git_config_get_expiry() from gc.c
 - read-cache: touch shared index files when used
 - sha1_file: make check_and_freshen_file() non static
 - Documentation/config: add splitIndex.maxPercentChange
 - t1700: add tests for splitIndex.maxPercentChange
 - read-cache: regenerate shared index if necessary
 - config: add git_config_get_max_percent_split_change()
 - Documentation/git-update-index: talk about core.splitIndex config var
 - Documentation/config: add information for core.splitIndex
 - t1700: add tests for core.splitIndex
 - update-index: warn in case of split-index incoherency
 - read-cache: add and then use tweak_split_index()
 - split-index: add {add,remove}_split_index() functions
 - config: add git_config_get_split_index()
 - config: mark an error message up for translation

 The experimental "split index" feature has gained a few
 configuration variables to make it easier to use.

 Waiting for review comments to be addressed.
 cf. <20161226102222.17150-1-chriscool@tuxfamily.org>
 cf. <a1a44640-ff6c-2294-72ac-46322eff8505@ramsayjones.plus.com>


* kn/ref-filter-branch-list (2017-02-07) 21 commits
  (merged to 'next' on 2017-02-10 at 794bb8284d)
 + ref-filter: resurrect "strip" as a synonym to "lstrip"
  (merged to 'next' on 2017-01-31 at e7592a5461)
 + branch: implement '--format' option
 + branch: use ref-filter printing APIs
 + branch, tag: use porcelain output
 + ref-filter: allow porcelain to translate messages in the output
 + ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
 + ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
 + ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
 + ref-filter: rename the 'strip' option to 'lstrip'
 + ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 + ref-filter: introduce refname_atom_parser()
 + ref-filter: introduce refname_atom_parser_internal()
 + ref-filter: make "%(symref)" atom work with the ':short' modifier
 + ref-filter: add support for %(upstream:track,nobracket)
 + ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 + ref-filter: introduce format_ref_array_item()
 + ref-filter: move get_head_description() from branch.c
 + ref-filter: modify "%(objectname:short)" to take length
 + ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 + ref-filter: include reference to 'used_atom' within 'atom_value'
 + ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Will cook in 'next'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-12-05 at 0c77e39cd5)
 + setup_git_env: avoid blind fall-back to ".git"

 Originally merged to 'next' on 2016-10-26

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-12-05 at 041946dae0)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2016-10-11

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

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

--------------------------------------------------
[Discarded]

* jk/nofollow-attr-ignore (2016-11-02) 5 commits
 . exclude: do not respect symlinks for in-tree .gitignore
 . attr: do not respect symlinks for in-tree .gitattributes
 . exclude: convert "check_index" into a flags field
 . attr: convert "macro_ok" into a flags field
 . add open_nofollow() helper

 As we do not follow symbolic links when reading control files like
 .gitignore and .gitattributes from the index, match the behaviour
 and not follow symbolic links when reading them from the working
 tree.  This also tightens security a bit by not leaking contents of
 an unrelated file in the error messages when it is pointed at by
 one of these files that is a symbolic link.

 Perhaps we want to cover .gitmodules too with the same mechanism?


* sb/push-make-submodule-check-the-default (2017-01-26) 2 commits
  (merged to 'next' on 2017-01-26 at 5f4715cea6)
 + Revert "push: change submodule default to check when submodules exist"
  (merged to 'next' on 2016-12-12 at 1863e05af5)
 + push: change submodule default to check when submodules exist

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Retracted.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F62B1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbeKNBRV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:17:21 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:50832 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733211AbeKNBRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:17:20 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 20:17:14 EST
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 87E112E3B2;
        Tue, 13 Nov 2018 10:11:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=r
        hBNKA8ed/kILc1DoW1GA0g4+TI=; b=JSTUaiR9b3c6Ams3huNQHwJRiZZZAMAqu
        tC87WyeMoyQPfif8neFcO4+mbf5dth4hRALwSj65/EenHUux7T7MuSAI8NqCVvpM
        jjfj6IxFbcIM6w+mFlAfZzDBE1DPIJuMmAWxootWk4MtQeyt4/fO8kqPk+2eqNEW
        dqn2Pwke4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=kRC
        YdPjQzu9CCNBVFxA7kvHKLhsHtjqqIFNfHO5MvS5wCdIJxNYrEs56m5c8Dkv81DO
        r0ASHOT01GcoIdYDhxZbbnQNmPtDZlyOTfvqlRK47W25d9CK76ndenygaUGLlaoU
        /nilzqO8gFkiYP78Rqi5N7gWjc1vmzD2CAZxHpok=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 620F82E3B1;
        Tue, 13 Nov 2018 10:11:18 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E729A11183C;
        Tue, 13 Nov 2018 09:12:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2018, #04; Tue, 13)
X-master-at: d166e6afe5f257217836ef24a73764eba390c58d
X-next-at: 17fedb746fde9e40924a6ce11c0976a097eb126b
Date:   Tue, 13 Nov 2018 23:12:13 +0900
Message-ID: <xmqq8t1xukw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F1ECEA6-E74E-11E8-8F47-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/pack-tests-cleanup (2018-10-31) 3 commits
  (merged to 'next' on 2018-11-03 at b4a39595bb)
 + index-pack tests: don't leave test repo dirty at end
 + pack-objects tests: don't leave test .git corrupt at end
 + pack-objects test: modernize style

 A couple of tests used to leave the repository in a state that is
 deliberately corrupt, which have been corrected.


* ag/rebase-i-in-c (2018-11-05) 1 commit
  (merged to 'next' on 2018-11-06 at 8fa9d64898)
 + sequencer.c: remove a stray semicolon

 Code clean-up for a topic already in 'master'.


* ag/rev-parse-all-exclude-fix (2018-11-01) 1 commit
  (merged to 'next' on 2018-11-03 at 49730558fa)
 + rev-parse: clear --exclude list after 'git rev-parse --all'

 "git rev-parse --exclude=* --branches --branches"  (i.e. first
 saying "add only things that do not match '*' out of all branches"
 and then adding all branches, without any exclusion this time")
 worked as expected, but "--exclude=* --all --all" did not work the
 same way, which has been fixed.


* al/send-email-auto-cte-fixup (2018-11-02) 1 commit
  (merged to 'next' on 2018-11-05 at 4ecb1133ce)
 + send-email: avoid empty transfer encoding header

 "git send-email --transfer-encoding=..." in recent versions of Git
 sometimes produced an empty "Content-Transfer-Encoding:" header,
 which has been corrected.


* ao/submodule-wo-gitmodules-checked-out (2018-10-31) 10 commits
  (merged to 'next' on 2018-11-03 at 00c3377ef0)
 + t/helper: add test-submodule-nested-repo-config
 + submodule: support reading .gitmodules when it's not in the working tree
 + submodule: add a helper to check if it is safe to write to .gitmodules
 + t7506: clean up .gitmodules properly before setting up new scenario
 + submodule: use the 'submodule--helper config' command
 + submodule--helper: add a new 'config' subcommand
 + t7411: be nicer to future tests and really clean things up
 + t7411: merge tests 5 and 6
 + submodule: factor out a config_set_in_gitmodules_file_gently function
 + submodule: add a print_config_from_gitmodules() helper
 (this branch is used by sb/submodule-recursive-fetch-gets-the-tip.)

 The submodule support has been updated to read from the blob at
 HEAD:.gitmodules when the .gitmodules file is missing from the
 working tree.


* bp/add-diff-files-optim (2018-11-03) 1 commit
  (merged to 'next' on 2018-11-06 at cdaeb7924a)
 + add: speed up cmd_add() by utilizing read_cache_preload()

 "git add" needs to internally run "diff-files" equivalent, and the
 codepath learned the same optimization as "diff-files" has to run
 lstat(2) in parallel to find which paths have been updated in the
 working tree.


* bp/refresh-index-using-preload (2018-11-06) 2 commits
  (merged to 'next' on 2018-11-06 at d9b9d8f559)
 + refresh_index: remove unnecessary calls to preload_index()
  (merged to 'next' on 2018-11-01 at 289e6bcece)
 + speed up refresh_index() by utilizing preload_index()

 The helper function to refresh the cached stat information in the
 in-core index has learned to perform the lstat() part of the
 operation in parallel on multi-core platforms.


* bp/reset-quiet (2018-10-24) 3 commits
  (merged to 'next' on 2018-10-29 at 71f4fbc802)
 + reset: warn when refresh_index() takes more than 2 seconds
 + reset: add new reset.quiet config setting
 + reset: don't compute unstaged changes after reset when --quiet
 (this branch is used by nd/config-split.)

 "git reset --quiet" no longer runs "update-index --refresh"
 internally, which shifts the refresh cost away from the command.


* ds/add-missing-tags (2018-11-03) 3 commits
  (merged to 'next' on 2018-11-05 at 8388baf76d)
 + remote: make add_missing_tags() linear
 + test-reach: test get_reachable_subset
 + commit-reach: implement get_reachable_subset

 The history traversal used to implement the tag-following has been
 optimized by introducing a new helper.


* ds/test-multi-pack-index (2018-10-26) 4 commits
  (merged to 'next' on 2018-11-03 at 624c415a45)
 + packfile: close multi-pack-index in close_all_packs
 + multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
 + midx: close multi-pack-index on repack
 + midx: fix broken free() in close_midx()

 Tests for the recently introduced multi-pack index machinery.


* jc/war-on-string-list (2018-11-01) 1 commit
  (merged to 'next' on 2018-11-03 at 2ff65073f1)
 + fetch: replace string-list used as a look-up table with a hashmap

 Replace three string-list instances used as look-up tables in "git
 fetch" with hashmaps.


* jk/detect-truncated-zlib-input (2018-10-31) 4 commits
  (merged to 'next' on 2018-11-03 at 4952b4412b)
 + Adjust for 2.19.x series
 + cat-file: handle streaming failures consistently
 + check_stream_sha1(): handle input underflow
 + t1450: check large blob in trailing-garbage test

 A regression in Git 2.12 era made "git fsck" fall into an infinite
 loop while processing truncated loose objects.


* jk/misc-unused-fixes (2018-11-07) 4 commits
  (merged to 'next' on 2018-11-07 at 8438c0b245)
 + approxidate: fix NULL dereference in date_time()
  (merged to 'next' on 2018-11-05 at 03429f23c4)
 + pathspec: handle non-terminated strings with :(attr)
 + approxidate: handle pending number for "specials"
 + rev-list: handle flags for --indexed-objects

 Assorted fixes for bugs found while auditing -Wunused-parameter
 warnings.


* jk/proto-v2-ref-prefix-fix (2018-10-31) 2 commits
  (merged to 'next' on 2018-11-03 at 3a203db692)
 + ls-remote: pass heads/tags prefixes to transport
 + ls-remote: do not send ref prefixes for patterns

 "git ls-remote $there foo" was broken by recent update for the
 protocol v2 and stopped showing refs that match 'foo' that are not
 refs/{heads,tags}/foo, which has been fixed.


* jk/stream-pack-non-delta-clarification (2018-10-31) 1 commit
  (merged to 'next' on 2018-11-03 at bd386692c8)
 + read_istream_pack_non_delta(): document input handling

 Additional comment on a tricky piece of code to help developers.


* jk/xdiff-interface (2018-11-05) 9 commits
  (merged to 'next' on 2018-11-05 at 0edd69cdad)
 + xdiff-interface: drop parse_hunk_header()
 + range-diff: use a hunk callback
 + diff: convert --check to use a hunk callback
 + combine-diff: use an xdiff hunk callback
 + diff: use hunk callback for word-diff
 + diff: discard hunk headers for patch-ids earlier
 + diff: avoid generating unused hunk header lines
 + xdiff-interface: provide a separate consume callback for hunks
 + xdiff: provide a separate emit callback for hunks

 The interface into "xdiff" library used to discover the offset and
 size of a generated patch hunk by first formatting it into the
 textual hunk header "@@ -n,m +k,l @@" and then parsing the numbers
 out.  A new interface has been introduced to allow callers a more
 direct access to them.


* js/mingw-isatty-and-dup2 (2018-10-31) 1 commit
  (merged to 'next' on 2018-11-03 at 0616899d9e)
 + mingw: fix isatty() after dup2()

 Windows fix.


* js/mingw-perl5lib (2018-10-31) 4 commits
  (merged to 'next' on 2018-11-03 at 2fa516f3ae)
 + mingw: unset PERL5LIB by default
 + config: move Windows-specific config settings into compat/mingw.c
 + config: allow for platform-specific core.* config settings
 + config: rename `dummy` parameter to `cb` in git_default_config()

 Windows fix.


* js/mingw-utf8-env (2018-10-31) 2 commits
  (merged to 'next' on 2018-11-03 at f6c5a8b609)
 + mingw: reencode environment variables on the fly (UTF-16 <-> UTF-8)
 + t7800: fix quoting

 Windows fix.


* js/rebase-p-tests (2018-11-02) 3 commits
  (merged to 'next' on 2018-11-03 at fc8d97465f)
 + tests: optionally skip `git rebase -p` tests
 + t3418: decouple test cases from a previous `rebase -p` test case
 + t3404: decouple some test cases from outcomes of previous test cases

 In preparation to the day when we can deprecate and remove the
 "rebase -p", make sure we can skip and later remove tests for
 it.


* jt/tighten-fetch-proto-v2-response (2018-11-01) 1 commit
  (merged to 'next' on 2018-11-03 at 310fe3f2c3)
 + fetch-pack: be more precise in parsing v2 response

 "git fetch" was a bit loose in parsing resposes from the other side
 when talking over the protocol v2.


* ma/sequencer-do-reset-saner-loop-termination (2018-10-31) 1 commit
  (merged to 'next' on 2018-11-03 at 99da78997d)
 + sequencer: break out of loop explicitly

 Code readability fix.


* nb/worktree-api-doc (2018-10-31) 2 commits
  (merged to 'next' on 2018-11-03 at de9befb1f3)
 + worktree: rename is_worktree_locked to worktree_lock_reason
 + worktree: update documentation for lock_reason and lock_reason_valid

 Code readability fix.


* nd/complete-format-patch (2018-11-06) 1 commit
  (merged to 'next' on 2018-11-06 at 7f4c58c9d0)
 + completion: use __gitcomp_builtin for format-patch

 The support for format-patch (and send-email) by the command-line
 completion script (in contrib/) has been simplified a bit.


* nd/config-split (2018-10-29) 79 commits
  (merged to 'next' on 2018-11-03 at a336559101)
 + config.txt: remove config/dummy.txt
 + config.txt: move worktree.* to a separate file
 + config.txt: move web.* to a separate file
 + config.txt: move versionsort.* to a separate file
 + config.txt: move user.* to a separate file
 + config.txt: move url.* to a separate file
 + config.txt: move uploadpack.* to a separate file
 + config.txt: move uploadarchive.* to a separate file
 + config.txt: move transfer.* to a separate file
 + config.txt: move tag.* to a separate file
 + config.txt: move submodule.* to a separate file
 + config.txt: move stash.* to a separate file
 + config.txt: move status.* to a separate file
 + config.txt: move splitIndex.* to a separate file
 + config.txt: move showBranch.* to a separate file
 + config.txt: move sequencer.* to a separate file
 + config.txt: move sendemail-config.txt to config/
 + config.txt: move reset.* to a separate file
 + config.txt: move rerere.* to a separate file
 + config.txt: move repack.* to a separate file
 + config.txt: move remotes.* to a separate file
 + config.txt: move remote.* to a separate file
 + config.txt: move receive-config.txt to config/
 + config.txt: move rebase-config.txt to config/
 + config.txt: move push-config.txt to config/
 + config.txt: move pull-config.txt to config/
 + config.txt: move protocol.* to a separate file
 + config.txt: move pretty.* to a separate file
 + config.txt: move pager.* to a separate file
 + config.txt: move pack.* to a separate file
 + config.txt: move notes.* to a separate file
 + config.txt: move mergetool.* to a separate file
 + config.txt: move merge-config.txt to config/
 + config.txt: move man.* to a separate file
 + config.txt: move mailmap.* to a separate file
 + config.txt: move mailinfo.* to a separate file
 + config.txt: move log.* to a separate file
 + config.txt: move interactive.* to a separate file
 + config.txt: move instaweb.* to a separate file
 + config.txt: move init.* to a separate file
 + config.txt: move index.* to a separate file
 + git-imap-send.txt: move imap.* to a separate file
 + config.txt: move i18n.* to a separate file
 + config.txt: move http.* to a separate file
 + config.txt: move ssh.* to a separate file
 + config.txt: move help.* to a separate file
 + config.txt: move guitool.* to a separate file
 + config.txt: move gui-config.txt to config/
 + config.txt: move gpg.* to a separate file
 + config.txt: move grep.* to a separate file
 + config.txt: move gitweb.* to a separate file
 + config.txt: move gitcvs-config.txt to config/
 + config.txt: move gc.* to a separate file
 + config.txt: move fsck.* to a separate file
 + config.txt: move fmt-merge-msg-config.txt to config/
 + config.txt: move format-config.txt to config/
 + config.txt: move filter.* to a separate file
 + config.txt: move fetch-config.txt to config/
 + config.txt: move fastimport.* to a separate file
 + config.txt: move difftool.* to a separate file
 + config.txt: move diff-config.txt to config/
 + config.txt: move completion.* to a separate file
 + config.txt: move credential.* to a separate file
 + config.txt: move commit.* to a separate file
 + config.txt: move column.* to a separate file
 + config.txt: move color.* to a separate file
 + config.txt: move clean.* to a separate file
 + config.txt: move checkout.* to a separate file
 + config.txt: move browser.* to a separate file
 + config.txt: move branch.* to a separate file
 + config.txt: move blame.* to a separate file
 + config.txt: move apply.* to a separate file
 + config.txt: move am.* to a separate file
 + config.txt: move alias.* to a separate file
 + config.txt: move add.* to a separate file
 + config.txt: move core.* to a separate file
 + config.txt: move advice.* to a separate file
 + Update makefile in preparation for Documentation/config/*.txt
 + Merge branches 'bp/reset-quiet' and 'js/mingw-http-ssl' into nd/config-split
 (this branch uses bp/reset-quiet.)

 Split the overly large Documentation/config.txt file into million
 little pieces.  This potentially allows each individual piece
 included into the manual page of the command it affects more easily.

 This is a painful conversions while many other topics in flight
 wants to add to or edit the documentation of configuration
 variables.


* nd/per-worktree-config (2018-10-22) 2 commits
  (merged to 'next' on 2018-11-01 at 3746343ca8)
 + worktree: add per-worktree config files
 + t1300: extract and use test_cmp_config()

 A fourth class of configuration files (in addition to the
 traditional "system wide", "per user in the $HOME directory" and
 "per repository in the $GIT_DIR/config") has been introduced so
 that different worktrees that share the same repository (hence the
 same $GIT_DIR/config file) can use different customization.


* nd/per-worktree-ref-iteration (2018-11-05) 9 commits
  (merged to 'next' on 2018-11-06 at 53803cedf3)
 + git-worktree.txt: correct linkgit command name
  (merged to 'next' on 2018-11-03 at 4cbe49a704)
 + reflog expire: cover reflog from all worktrees
 + fsck: check HEAD and reflog from other worktrees
 + fsck: move fsck_head_link() to get_default_heads() to avoid some globals
 + revision.c: better error reporting on ref from different worktrees
 + revision.c: correct a parameter name
 + refs: new ref types to make per-worktree refs visible to all worktrees
 + Add a place for (not) sharing stuff between worktrees
 + refs.c: indent with tabs, not spaces

 The code to traverse objects for reachability, used to decide what
 objects are unreferenced and expendable, have been taught to also
 consider per-worktree refs of other worktrees as starting points to
 prevent data loss.


* nd/tree-walk-path-exclusion (2018-11-05) 1 commit
  (merged to 'next' on 2018-11-06 at 6499b2d327)
 + tree-walk.c: fix overoptimistic inclusion in :(exclude) matching

 Pathspec matching against a tree object were buggy when negative
 pathspec elements were involved, which has been fixed.


* nd/wildmatch-double-asterisk (2018-10-29) 1 commit
  (merged to 'next' on 2018-11-01 at 627186d020)
 + wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode

 A pattern with '**' that does not have a slash on either side used
 to be an invalid one, but the code now treats such double-asterisks
 the same way as two normal asterisks that happen to be adjacent to
 each other.


* pw/am-rebase-read-author-script (2018-11-01) 5 commits
  (merged to 'next' on 2018-11-03 at bb6c32fe16)
 + sequencer: use read_author_script()
 + add read_author_script() to libgit
 + am: rename read_author_script()
 + am: improve author-script error reporting
 + am: don't die in read_author_script()

 Unify code to read the author-script used in "git am" and the
 commands that use the sequencer machinery, e.g. "git rebase -i".


* sg/travis-install-dependencies (2018-11-02) 1 commit
  (merged to 'next' on 2018-11-06 at b86e3a2792)
 + travis-ci: install packages in 'ci/install-dependencies.sh'

 The procedure to install dependencies before testing at Travis CI
 is getting revamped for both simplicity and flexibility, taking
 advantage of the recent move to the vm-based environment.


* sh/mingw-safer-compat-poll (2018-11-05) 1 commit
  (merged to 'next' on 2018-11-05 at 933a940a68)
 + poll: use GetTickCount64() to avoid wrap-around issues

 Windows fix.

--------------------------------------------------
[New Topics]

* js/rebase-autostash-detach-fix (2018-11-08) 2 commits
 - built-in rebase --autostash: leave the current branch alone if possible
 - built-in rebase: demonstrate regression with --autostash

 "git rebase --autostash" did not correctly re-attach the HEAD at times.

 Will merge to 'next'.


* en/rebase-merge-on-sequencer (2018-11-08) 2 commits
 - rebase: implement --merge via git-rebase--interactive
 - git-rebase, sequencer: extend --quiet option for the interactive machinery

 "git rebase --merge" as been reimplemented by reusing the internal
 machinery used for "git rebase -i".


* js/mailmap (2018-11-12) 1 commit
 - Update .mailmap

 Update the mailmap to unify multiple entries for the authors with
 commits since v2.10.

 Will merge to 'next'.


* fc/http-version (2018-11-09) 1 commit
 - http: add support selecting http version

 The "http.version" configuration variable can be used with recent
 enough cURL library to force the version of HTTP used to talk when
 fetching and pushing.

 Will merge to 'next'.


* ag/p3400-force-checkout (2018-11-12) 1 commit
 - p3400: replace calls to `git checkout -b' by `git checkout -B'

 Perf test tweak.

 Will merge to 'next'.


* cb/notes-freeing-always-null-fix (2018-11-13) 1 commit
 - builtin/notes: remove unnecessary free

 Code cleanup.

 Will merge to 'next'.


* dl/remote-save-to-push (2018-11-13) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Undecided.


* jk/loose-object-cache (2018-11-13) 9 commits
 - fetch-pack: drop custom loose object cache
 - sha1-file: use loose object cache for quick existence check
 - object-store: provide helpers for loose_objects_cache
 - sha1-file: use an object_directory for the main object dir
 - handle alternates paths the same as the main object dir
 - sha1_file_name(): overwrite buffer instead of appending
 - rename "alternate_object_database" to "object_directory"
 - submodule--helper: prefer strip_suffix() to ends_with()
 - fsck: do not reuse child_process structs

 Code clean-up with optimization for the codepath that checks
 (non-)existence of loose objects.

 Will merge to 'next'.


* js/apply-recount-allow-noop (2018-11-13) 1 commit
 - apply --recount: allow "no-op hunks"

 When editing a patch in a "git add -i" session, a hunk could be
 made to no-op.  The "git apply" program used to reject a patch with
 such a no-op hunk to catch user mistakes, but it is now updated to
 explicitly allow a no-op hunk in an edited patch.

 Will merge to 'next'.


* js/builtin-rebase-perf-fix (2018-11-13) 3 commits
 - built-in rebase: reinstate `checkout -q` behavior where appropriate
 - rebase: prepare reset_head() for more flags
 - rebase: consolidate clean-up code before leaving reset_head()

 Code clean-up with correction to make the reimplemented "git
 rebase" a more faithful rewrite of the original, which also regains
 performance.

 Will merge to 'next'.


* js/protocol-advertise-multi (2018-11-13) 2 commits
 - SQUASH??? apply cocci fix
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.


* js/rebase-r-and-merge-head (2018-11-13) 5 commits
 - status: rebase and merge can be in progress at the same time
 - built-in rebase --skip/--abort: clean up stale .git/<name> files
 - rebase -i: include MERGE_HEAD into files to clean up
 - rebase -r: do not write MERGE_HEAD unless needed
 - rebase -r: demonstrate bug with conflicting merges

 Bugfix for the recently graduated "git rebase --rebase-merges".

 Will merge to 'next'.


* js/smart-http-detect-remote-error (2018-11-13) 1 commit
 - remote-curl: die on server-side errors

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.

 Will merge to 'next'.


* nb/branch-show-other-worktrees-head (2018-11-12) 2 commits
 - branch: mark and colorize a branch differently if it is checked out in a linked worktree
 - ref-filter: add worktree atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Expecting a reroll.


* nd/command-list-gen-fix (2018-11-12) 1 commit
 - build: fix broken command-list.h generation with core.autocrlf

 Build tweak.

 Will merge to 'next'.


* nd/format-patch-cover-letter-stat-width (2018-11-13) 1 commit
 - format-patch: respect --stat in cover letter's diffstat

 "git format-patch --stat=<width>" can be used to specify the width
 used by the diffstat (shown in the cover letter).

 Will merge to 'next'.


* nd/the-index (2018-11-12) 22 commits
 - rebase-interactive.c: remove the_repository references
 - rerere.c: remove the_repository references
 - pack-*.c: remove the_repository references
 - pack-check.c: remove the_repository references
 - notes-cache.c: remove the_repository references
 - line-log.c: remove the_repository reference
 - diff-lib.c: remove the_repository references
 - delta-islands.c: remove the_repository references
 - cache-tree.c: remove the_repository references
 - bundle.c: remove the_repository references
 - branch.c: remove the_repository reference
 - bisect.c: remove the_repository reference
 - blame.c: remove implicit dependency the_repository
 - sequencer.c: remove implicit dependency on the_repository
 - sequencer.c: remove implicit dependency on the_index
 - transport.c: remove implicit dependency on the_index
 - notes-merge.c: remove implicit dependency the_repository
 - notes-merge.c: remove implicit dependency on the_index
 - list-objects.c: reduce the_repository references
 - list-objects-filter.c: remove implicit dependency on the_index
 - wt-status.c: remove implicit dependency the_repository
 - wt-status.c: remove implicit dependency on the_index

 More codepaths become aware of working with in-core repository
 instance other than the default "the_repository".

 Will merge to 'next'.


* ot/ref-filter-object-info (2018-11-12) 5 commits
 - ref-filter: add docs for new options
 - ref-filter: add tests for deltabase
 - ref-filter: add deltabase option
 - ref-filter: add tests for objectsize:disk
 - ref-filter: add objectsize:disk option

 The "--format=<placeholder>" option of for-each-ref, branch and tag
 learned to show a few more traits of objects that can be learned by
 the object_info API.

 Will merge to 'next'.


* ra/rev-parse-exclude-glob (2018-11-13) 2 commits
 - refs: fix some exclude patterns being ignored
 - refs: show --exclude failure with --branches/tags/remotes=glob

 "rev-parse --exclude=<pattern> --branches=<pattern>" etc. did not
 quite work, which has been corrected.

 Will merge to 'next'.


* sb/cocci-pending (2018-11-11) 1 commit
 - coccicheck: introduce 'pending' semantic patches

 A coding convention around the Coccinelle semantic patches to have
 two classes to ease code migration process has been proposed and
 its support has been added to the Makefile.

 Will merge to 'next'.


* tb/print-size-t-with-uintmax-format (2018-11-12) 1 commit
 - Upcast size_t variables to uintmax_t when printing

 Code preparation to replace ulong vars with size_t vars where
 appropriate.

 Will merge to 'next'.


* tb/xcurl-off-t (2018-11-12) 1 commit
 - remote-curl.c: xcurl_off_t is not portable (on 32 bit platfoms)

 The xcurl_off_t() helper function is used to cast size_t to
 curl_off_t, but some compilers gave warnings against the code to
 ensure the casting is done without wraparound, when size_t is
 narrower than curl_off_t.  This warning has been squelched.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.

--------------------------------------------------
[Cooking]

* jk/curl-ldflags (2018-11-05) 1 commit
  (merged to 'next' on 2018-11-13 at d1387a3aa0)
 + build: link with curl-defined linker flags

 The way -lcurl library gets linked has been simplified by taking
 advantage of the fact that we can just ask curl-config command how.

 Will merge to 'master'.


* mg/gpg-fingerprint-test (2018-11-05) 2 commits
  (merged to 'next' on 2018-11-13 at 71f11020c4)
 + t/t7510-signed-commit.sh: add signing subkey to Eris Discordia key
 + t/t7510-signed-commit.sh: Add %GP to custom format checks

 Add a few tests for a topic already in 'master'.

 Will merge to 'master'.


* sb/diff-color-moved-config-option-fixup (2018-11-05) 1 commit
 - diff: differentiate error handling in parse_color_moved_ws


* ab/range-diff-no-patch (2018-11-12) 4 commits
 - SQUASH???
 - range-diff: make diff option behavior (e.g. --stat) consistent
 - range-diff: fix regression in passing along diff options
 - range-diff doc: add a section about output stability

 The "--no-patch" option, which can be used to get a high-level
 overview without the actual line-by-line patch difference shown, of
 the "range-diff" command was earlier broken, which has been
 corrected.

 Waiting for a response to squashable fix.


* jk/unused-parameter-fixes (2018-11-06) 14 commits
  (merged to 'next' on 2018-11-13 at 8d3625b4ae)
 + midx: double-check large object write loop
 + assert NOARG/NONEG behavior of parse-options callbacks
 + parse-options: drop OPT_DATE()
 + apply: return -1 from option callback instead of calling exit(1)
 + cat-file: report an error on multiple --batch options
 + tag: mark "--message" option with NONEG
 + show-branch: mark --reflog option as NONEG
 + format-patch: mark "--no-numbered" option with NONEG
 + status: mark --find-renames option with NONEG
 + cat-file: mark batch options with NONEG
 + pack-objects: mark index-version option as NONEG
 + ls-files: mark exclude options as NONEG
 + am: handle --no-patch-format option
 + apply: mark include/exclude options as NONEG

 Various functions have been audited for "-Wunused-parameter" warnings
 and bugs in them got fixed.

 Will merge to 'master'.


* ds/push-squelch-ambig-warning (2018-11-07) 1 commit
 - pack-objects: ignore ambiguous object warnings

 "git push" used to check ambiguities between object-names and
 refnames while processing the list of refs' old and new values,
 which was unnecessary (as it knew that it is feeding raw object
 names).  This has been optimized out.

 Will merge to 'next'.


* jk/verify-sig-merge-into-void (2018-11-07) 3 commits
  (merged to 'next' on 2018-11-13 at a207be60ed)
 + pull: handle --verify-signatures for unborn branch
 + merge: handle --verify-signatures for unborn branch
 + merge: extract verify_merge_signature() helper

 "git merge" and "git pull" that merges into an unborn branch used
 to completely ignore "--verify-signatures", which has been
 corrected.

 Will merge to 'master'.


* js/mingw-res-rebuild (2018-11-07) 1 commit
  (merged to 'next' on 2018-11-13 at fb736827d1)
 + Windows: force-recompile git.res for differing architectures

 Windows build update.

 Will merge to 'master'.


* ab/dynamic-gettext-poison (2018-11-09) 2 commits
 - Makefile: ease dynamic-gettext-poison transition
 - i18n: make GETTEXT_POISON a runtime option

 On hold.
 The tip one may be controversial, but at least it would get me going.
 cf. <xmqqpnvg8d5z.fsf@gitster-ct.c.googlers.com>


* ab/push-dwim-dst (2018-10-29) 9 commits
 - SQUASH???
 - push doc: document the DWYM behavior pushing to unqualified <dst>
 - push: add DWYM support for "git push refs/remotes/...:<dst>"
 - push: test that <src> doesn't DWYM if <dst> is unqualified
 - push: add an advice on unqualified <dst> push
 - push: move unqualified refname error into a function
 - push: improve the error shown on unqualified <dst> push
 - i18n: remote.c: mark error(...) messages for translation
 - remote.c: add braces in anticipation of a follow-up change

 "git push $there $src:$dst" rejects when $dst is not a fully
 qualified refname and not clear what the end user meant.  The
 codepath has been taught to give a clearer error message, and also
 guess where the push should go by taking the type of the pushed
 object into account (e.g. a tag object would want to go under
 refs/tags/).

 The last few steps are questionable.
 cf. <87in1lkw54.fsf@evledraar.gmail.com>


* md/list-lazy-objects-fix (2018-10-29) 1 commit
 - list-objects.c: don't segfault for missing cmdline objects

 "git rev-list --exclude-promissor-objects" had to take an object
 that does not exist locally (and is lazily available) from the
 command line without barfing, but the code dereferenced NULL.

 That sympotom may be worth addressing, but I think the "fix" is
 overly broad and is wrong.  Giving a missing object should be
 diagnosed as an error, not swept under the rug silently.


* nd/i18n (2018-11-12) 16 commits
 - fsck: mark strings for translation
 - fsck: reduce word legos to help i18n
 - parse-options.c: mark more strings for translation
 - parse-options.c: turn some die() to BUG()
 - parse-options: replace opterror() with optname()
 - repack: mark more strings for translation
 - remote.c: mark messages for translation
 - remote.c: turn some error() or die() to BUG()
 - reflog: mark strings for translation
 - read-cache.c: add missing colon separators
 - read-cache.c: mark more strings for translation
 - read-cache.c: turn die("internal error") to BUG()
 - attr.c: mark more string for translation
 - archive.c: mark more strings for translation
 - alias.c: mark split_cmdline_strerror() strings for translation
 - git.c: mark more strings for translation

 More _("i18n") markings.

 Will merge to 'next'.


* nd/pthreads (2018-11-05) 14 commits
  (merged to 'next' on 2018-11-13 at bb6914b3f8)
 + Clean up pthread_create() error handling
 + read-cache.c: initialize copy_len to shut up gcc 8
 + read-cache.c: reduce branching based on HAVE_THREADS
 + read-cache.c: remove #ifdef NO_PTHREADS
 + pack-objects: remove #ifdef NO_PTHREADS
 + preload-index.c: remove #ifdef NO_PTHREADS
 + grep: clean up num_threads handling
 + grep: remove #ifdef NO_PTHREADS
 + attr.c: remove #ifdef NO_PTHREADS
 + name-hash.c: remove #ifdef NO_PTHREADS
 + index-pack: remove #ifdef NO_PTHREADS
 + send-pack.c: move async's #ifdef NO_PTHREADS back to run-command.c
 + run-command.h: include thread-utils.h instead of pthread.h
 + thread-utils: macros to unconditionally compile pthreads API

 The codebase has been cleaned up to reduce "#ifndef NO_PTHREADS".

 Will merge to 'master'.


* sb/more-repo-in-api (2018-10-19) 19 commits
 - submodule: don't add submodule as odb for push
 - submodule: use submodule repos for object lookup
 - pretty: prepare format_commit_message to handle arbitrary repositories
 - commit: prepare logmsg_reencode to handle arbitrary repositories
 - commit: prepare repo_unuse_commit_buffer to handle arbitrary repositories
 - commit: prepare get_commit_buffer to handle arbitrary repositories
 - commit-reach: prepare in_merge_bases[_many] to handle arbitrary repositories
 - commit-reach: prepare get_merge_bases to handle arbitrary repositories
 - commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary repositories
 - commit-reach.c: allow remove_redundant to handle arbitrary repositories
 - commit-reach.c: allow merge_bases_many to handle arbitrary repositories
 - commit-reach.c: allow paint_down_to_common to handle arbitrary repositories
 - commit: allow parse_commit* to handle arbitrary repositories
 - object: parse_object to honor its repository argument
 - object-store: prepare has_{sha1, object}_file[_with_flags] to handle arbitrary repositories
 - object-store: prepare read_object_file to deal with arbitrary repositories
 - object-store: allow read_object_file_extended to read from arbitrary repositories
 - packfile: allow has_packed_and_bad to handle arbitrary repositories
 - sha1_file: allow read_object to read objects in arbitrary repositories

 The in-core repository instances are passed through more codepaths.

 On hold.
 Not quite correct?
 cf. <20181025091406.GK30222@szeder.dev>
 Reroll being worked on.
 cf. <20181030220817.61691-1-sbeller@google.com>


* en/merge-path-collision (2018-11-08) 10 commits
 - merge-recursive: combine error handling
 - t6036, t6043: increase code coverage for file collision handling
 - merge-recursive: improve rename/rename(1to2)/add[/add] handling
 - merge-recursive: use handle_file_collision for add/add conflicts
 - merge-recursive: improve handling for rename/rename(2to1) conflicts
 - merge-recursive: fix rename/add conflict handling
 - merge-recursive: new function for better colliding conflict resolutions
 - merge-recursive: increase marker length with depth of recursion
 - t6036, t6042: testcases for rename collision of already conflicting files
 - t6042: add tests for consistency in file collision conflict handling

 Updates for corner cases in merge-recursive.

 Will merge to 'next'.


* sd/stash-wo-user-name (2018-11-02) 1 commit
 - t3903-stash: test without configured user.name and user.email

 An early part of a wip.


* bc/sha-256 (2018-11-05) 12 commits
 - hash: add an SHA-256 implementation using OpenSSL
 - sha256: add an SHA-256 implementation using libgcrypt
 - Add a base implementation of SHA-256 support
 - commit-graph: convert to using the_hash_algo
 - t/helper: add a test helper to compute hash speed
 - sha1-file: add a constant for hash block size
 - t: make the sha1 test-tool helper generic
 - t: add basic tests for our SHA-1 implementation
 - cache: make hashcmp and hasheq work with larger hashes
 - hex: introduce functions to print arbitrary hashes
 - sha1-file: provide functions to look up hash algorithms
 - sha1-file: rename algorithm to "sha1"

 Add sha-256 hash and plug it through the code to allow building Git
 with the "NewHash".


* js/vsts-ci (2018-10-16) 13 commits
 . travis: fix skipping tagged releases
 . README: add a build badge (status of the Azure Pipelines build)
 . tests: record more stderr with --write-junit-xml in case of failure
 . tests: include detailed trace logs with --write-junit-xml upon failure
 . git-p4: use `test_atexit` to kill the daemon
 . git-daemon: use `test_atexit` in the tests
 . tests: introduce `test_atexit`
 . ci: add a build definition for Azure DevOps
 . ci/lib.sh: add support for Azure Pipelines
 . tests: optionally write results as JUnit-style .xml
 . test-date: add a subcommand to measure times in shell scripts
 . ci/lib.sh: encapsulate Travis-specific things
 . ci: rename the library of common functions

 Prepare to run test suite on Azure DevOps.

 Ejected out of 'pu', as doing so seems to help other topics get
 tested at TravisCI.

 https://travis-ci.org/git/git/builds/452713184 is a sample of a
 build whose tests on 4 hang (with this series in).  Ejecting it
 gave us https://travis-ci.org/git/git/builds/452778963 which still
 shows breakages from other topics not yet in 'next', but at least
 the tests do not stall.


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 On hold, monitoring the discussion.
 cf. <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* js/remote-archive-v2 (2018-09-28) 4 commits
  (merged to 'next' on 2018-10-12 at 5f34377f60)
 + archive: allow archive over HTTP(S) with proto v2
 + archive: implement protocol v2 archive command
 + archive: use packet_reader for communications
 + archive: follow test standards around assertions

 The original implementation of "git archive --remote" more or less
 bypassed the transport layer and did not work over http(s).  The
 version 2 of the protocol is defined to allow going over http(s) as
 well as Git native transport.

 Will hold.
 cf. <20181016212008.GA249669@google.com>
 Breaks interoperability.


* ag/sequencer-reduce-rewriting-todo (2018-11-12) 16 commits
 . rebase--interactive: move transform_todo_file() to rebase--interactive.c
 . sequencer: fix a call to error() in transform_todo_file()
 . sequencer: use edit_todo_list() in complete_action()
 . rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 . rebase-interactive: append_todo_help() changes
 . rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 . sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 . sequencer: change complete_action() to use the refactored functions
 . sequencer: make sequencer_make_script() write its script to a strbuf
 . sequencer: refactor rearrange_squash() to work on a todo_list
 . sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 . sequencer: refactor check_todo_list() to work on a todo_list
 . sequencer: introduce todo_list_write_to_file()
 . sequencer: refactor transform_todos() to work on a todo_list
 . sequencer: make the todo_list structure public
 . sequencer: changes in parse_insn_buffer()

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 With too many topics in-flight that touch sequencer and rebaser,
 this need to wait giving precedence to other topics that fix bugs.


* ds/reachable-topo-order (2018-11-02) 7 commits
  (merged to 'next' on 2018-11-13 at 4155d01aee)
 + t6012: make rev-list tests more interesting
 + revision.c: generation-based topo-order algorithm
 + commit/revisions: bookkeeping before refactoring
 + revision.c: begin refactoring --topo-order logic
 + test-reach: add rev-list tests
 + test-reach: add run_three_modes method
 + prio-queue: add 'peek' operation

 The revision walker machinery learned to take advantage of the
 commit generation numbers stored in the commit-graph file.

 Will merge to 'master'.


* sb/submodule-recursive-fetch-gets-the-tip (2018-10-31) 11 commits
 - builtin/fetch: check for submodule updates in any ref update
 - fetch: try fetching submodules if needed objects were not fetched
 - submodule.c: fetch in submodules git directory instead of in worktree
 - submodule: migrate get_next_submodule to use repository structs
 - repository: repo_submodule_init to take a submodule struct
 - submodule: store OIDs in changed_submodule_names
 - submodule.c: tighten scope of changed_submodule_names struct
 - submodule.c: sort changed_submodule_names before searching it
 - submodule.c: fix indentation
 - sha1-array: provide oid_array_filter
 - Merge branch 'ao/submodule-wo-gitmodules-checked-out' into sb/submodule-recursive-fetch-gets-the-tip

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.

 On hold, monitoring the discussion.
 cf. <20181025233231.102245-1-sbeller@google.com>


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2018-10-15) 21 commits
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert `stash--helper.c` into `stash.c`
 - stash: convert save to builtin
 - stash: make push -q quiet
 - stash: convert push to builtin
 - stash: convert create to builtin
 - stash: convert store to builtin
 - stash: convert show to builtin
 - stash: convert list to builtin
 - stash: convert pop to builtin
 - stash: convert branch to builtin
 - stash: convert drop and clear to builtin
 - stash: convert apply to builtin
 - stash: mention options in `show` synopsis
 - stash: add tests for `git stash show` config
 - stash: rename test cases to be more descriptive
 - t3903: modernize style
 - stash: improve option parsing test coverage
 - strbuf.c: add `strbuf_join_argv()`
 - sha1-name.c: add `get_oidf()` which acts like `get_oid()`

 "git stash" rewritten in C.

 Almost there.
 cf. <20181015221040.GD4883@hank.intra.tgummerer.com>


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will discard.
 No further feedbacks on the topic for quite some time.

 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.

--------------------------------------------------
[Discarded]

* ab/reject-alias-loop (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at bc213f1bef)
 + alias: detect loops in mixed execution mode

 Two (or more) aliases that mutually refer to each other can form an
 infinite loop; we now attempt to notice and stop.

 Discarded.
 Reverted out of 'next'.
 cf. <87sh0slvxm.fsf@evledraar.gmail.com>

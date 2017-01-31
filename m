Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06F71F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbdAaWpp (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:45:45 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34113 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdAaWpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:45:43 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so30096367pfb.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=xf5Tkgbv/XzCvDG+5hJf4LR/9yVFKMghVz+xp2E4VYY=;
        b=U9WHrqdC2HqhhCW3X5ZPFElAhlQZvB6ctRy6wfehqXv115yqCWjhH1q2dwgXYaRSqj
         9YDc9sfYS4NDwn3SPsCHgGXQhiDBLKdurK1Ts2s12+uQUuhUbQNjSxrZpGfoLD0EGG5e
         B491UtBXHb1wSZVepd7R8gRTDqcsUWpk/9YL/qVXnLM09DRCzwfLk+NscVNfo4H72pIE
         tlB8NGWa7w29I1izmtXoCHF37fMl7/jOyUM+nbQEh/QHUpMtLrmKX4/xZzaMJ4iJnLrz
         M1zABEBi/2GgVW5txEEk3P/pWol9fYep7DPxkYu2+c3rBDUIocxYOaD7tapAyfjjoA9u
         6+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=xf5Tkgbv/XzCvDG+5hJf4LR/9yVFKMghVz+xp2E4VYY=;
        b=dCA04kO9mITcH7sSkQNK89QXTx1rAxHLFi1H8QzcOANtpdkvkL+ht5ykhbEuDXzr9u
         cf0chlyngOFYleLyjXiCdaZu3ek54j9ltVbSo72WTLEpyfUX6DmTuoDZsgLSAF2jN4zO
         GaeECEhZ474E+nh906oGJmVLHYTmLcXqTs7h4H/B2j+aGQpFOYwjWEKfMXb6vpAswqdO
         +qRLrLam2du20Qb1pMlOQTE0GEL1rDmNzaUnrZP92C7CTTUa/DiWn3JyELt70TeuuI8u
         NTUZH1hPGGL7OP5AdzoaHvypQuCcYm4Ud6aMWz3hMFaMsPTsg8YYELZVPtPwhTETmUFe
         bc5A==
X-Gm-Message-State: AIkVDXJo051HYvG72WiQxiOleEGoDJMlR+YpA6ANB7jdCLm2Tu3J5RjJOV4acg22O7Korw==
X-Received: by 10.98.80.146 with SMTP id g18mr32318272pfj.74.1485902742077;
        Tue, 31 Jan 2017 14:45:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id c64sm43654915pfa.45.2017.01.31.14.45.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 14:45:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2017, #06; Tue, 31)
X-master-at: 8f60064c1f538f06e1c579cbd9840b86b10bcd3d
X-next-at: d13081a61a6c1d42f310f616f74992dc2def6583
Date:   Tue, 31 Jan 2017 14:45:40 -0800
Message-ID: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What's cooking in git.git (Jan 2017, #06; Tue, 31)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Two biggies from Dscho are now in 'master'.  Another thanks goes to
him for pointing out that I had a wrong version of isatty() fix
earlier in 'maint' and 'master', which is now fixed by merging the
updated one in both of these branches.  Please give the tip of
'maint' a quick look, as I want to tag and push out 2.11.1 later
this week, probably at the same time as 2.12-rc0 goes out.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bw/push-submodule-only (2016-12-20) 3 commits
  (merged to 'next' on 2017-01-23 at d6cd1c60ae)
 + push: add option to push only submodules
 + submodules: add RECURSE_SUBMODULES_ONLY value
 + transport: reformat flag #defines to be more readable

 "git submodule push" learned "--recurse-submodules=only option to
 push submodules out without pushing the top-level superproject.


* jk/clear-delta-base-cache-fix (2017-01-19) 1 commit
  (merged to 'next' on 2017-01-23 at 5f4af2b0a5)
 + clear_delta_base_cache(): don't modify hashmap while iterating

 A crashing bug introduced in v2.11 timeframe has been found (it is
 triggerable only in fast-import) and fixed.


* jk/coding-guidelines-update (2017-01-17) 1 commit
  (merged to 'next' on 2017-01-23 at 8c57afa288)
 + CodingGuidelines: clarify multi-line brace style

 Developer doc update.


* jk/fsck-connectivity-check-fix (2017-01-26) 9 commits
  (merged to 'next' on 2017-01-26 at dd03f7a17f)
 + fsck: lazily load types under --connectivity-only
 + fsck: move typename() printing to its own function
  (merged to 'next' on 2017-01-25 at f3d7d93785)
 + t1450: use "mv -f" within loose object directory
  (merged to 'next' on 2017-01-23 at e8e9b76b84)
 + fsck: check HAS_OBJ more consistently
 + fsck: do not fallback "git fsck <bogus>" to "git fsck"
 + fsck: tighten error-checks of "git fsck <head>"
 + fsck: prepare dummy objects for --connectivity-check
 + fsck: report trees as dangling
 + t1450: clean up sub-objects in duplicate-entry test

 "git fsck --connectivity-check" was not working at all.


* jk/loose-object-fsck (2017-01-15) 6 commits
  (merged to 'next' on 2017-01-23 at 4302ad090d)
 + fsck: detect trailing garbage in all object types
 + fsck: parse loose object paths directly
 + sha1_file: add read_loose_object() function
 + t1450: test fsck of packed objects
 + sha1_file: fix error message for alternate objects
 + t1450: refactor loose-object removal

 "git fsck" inspects loose objects more carefully now.


* jk/vreport-sanitize (2017-01-11) 2 commits
  (merged to 'next' on 2017-01-18 at 4bbf370981)
 + vreport: sanitize ASCII control chars
 + Revert "vreportf: avoid intermediate buffer"

 An error message with an ASCII control character like '\r' in it
 can alter the message to hide its early part, which is problematic
 when a remote side gives such an error message that the local side
 will relay with a "remote: " prefix.


* js/difftool-builtin (2017-01-25) 4 commits
  (merged to 'next' on 2017-01-25 at 87d2a0976a)
 + difftool: hack around -Wzero-length-format warning
  (merged to 'next' on 2017-01-23 at 6f4810dbd9)
 + difftool: retire the scripted version
 + difftool: implement the functionality in the builtin
 + difftool: add a skeleton for the upcoming builtin

 Rewrite a scripted porcelain "git difftool" in C.


* js/exec-path-coverity-workaround (2017-01-09) 2 commits
  (merged to 'next' on 2017-01-23 at bf5dfbf860)
 + git_exec_path: do not return the result of getenv()
 + git_exec_path: avoid Coverity warning about unfree()d result

 Code cleanup.
 Split out of another topic.


* js/mingw-isatty (2017-01-18) 1 commit
  (merged to 'next' on 2017-01-23 at ae0f80e058)
 + mingw: follow-up to "replace isatty() hack"

 An update to a topic that is already in 'master'.


* js/remote-rename-with-half-configured-remote (2017-01-19) 2 commits
  (merged to 'next' on 2017-01-23 at a1b655dbac)
 + remote rename: more carefully determine whether a remote is configured
 + remote rename: demonstrate a bogus "remote exists" bug

 With anticipatory tweaking for remotes defined in ~/.gitconfig
 (e.g. "remote.origin.prune" set to true, even though there may or
 may not actually be "origin" remote defined in a particular Git
 repository), "git remote rename" and other commands misinterpreted
 and behaved as if such a non-existing remote actually existed.


* js/sequencer-i-countdown-3 (2017-01-17) 38 commits
  (merged to 'next' on 2017-01-23 at 251dd15139)
 + sequencer (rebase -i): write out the final message
 + sequencer (rebase -i): write the progress into files
 + sequencer (rebase -i): show the progress
 + sequencer (rebase -i): suggest --edit-todo upon unknown command
 + sequencer (rebase -i): show only failed cherry-picks' output
 + sequencer (rebase -i): show only failed `git commit`'s output
 + sequencer: use run_command() directly
 + sequencer: update reading author-script
 + sequencer (rebase -i): differentiate between comments and 'noop'
 + sequencer (rebase -i): implement the 'drop' command
 + sequencer (rebase -i): allow rescheduling commands
 + sequencer (rebase -i): respect strategy/strategy_opts settings
 + sequencer (rebase -i): respect the rebase.autostash setting
 + sequencer (rebase -i): run the post-rewrite hook, if needed
 + sequencer (rebase -i): record interrupted commits in rewritten, too
 + sequencer (rebase -i): copy commit notes at end
 + sequencer (rebase -i): set the reflog message consistently
 + sequencer (rebase -i): refactor setting the reflog message
 + sequencer (rebase -i): allow fast-forwarding for edit/reword
 + sequencer (rebase -i): implement the 'reword' command
 + sequencer (rebase -i): leave a patch upon error
 + sequencer (rebase -i): update refs after a successful rebase
 + sequencer (rebase -i): the todo can be empty when continuing
 + sequencer (rebase -i): skip some revert/cherry-pick specific code path
 + sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
 + sequencer (rebase -i): allow continuing with staged changes
 + sequencer (rebase -i): write an author-script file
 + sequencer (rebase -i): implement the short commands
 + sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
 + sequencer (rebase -i): write the 'done' file
 + sequencer (rebase -i): learn about the 'verbose' mode
 + sequencer (rebase -i): implement the 'exec' command
 + sequencer (rebase -i): implement the 'edit' command
 + sequencer (rebase -i): implement the 'noop' command
 + sequencer: support a new action: 'interactive rebase'
 + sequencer: use a helper to find the commit message
 + sequencer: move "else" keyword onto the same line as preceding brace
 + sequencer: avoid unnecessary curly braces

 The sequencer machinery has been further enhanced so that a later
 set of patches can start using it to reimplement "rebase -i".
 I think I've said everything that needs to be said on this topic.


* ls/travis-p4-on-macos (2017-01-23) 1 commit
  (merged to 'next' on 2017-01-23 at 2d51987faa)
 + travis-ci: fix Perforce install on macOS

 Update the definition of the MacOSX test environment used by
 TravisCI.


* rs/qsort-s (2017-01-23) 5 commits
  (merged to 'next' on 2017-01-23 at 7e2813848b)
 + ref-filter: use QSORT_S in ref_array_sort()
 + string-list: use QSORT_S in string_list_sort()
 + perf: add basic sort performance test
 + add QSORT_S
 + compat: add qsort_s()

 A few codepaths had to rely on a global variable when sorting
 elements of an array because sort(3) API does not allow extra data
 to be passed to the comparison function.  Use qsort_s() when
 natively available, and a fallback implementation of it when not,
 to eliminate the need, which is a prerequisite for making the
 codepath reentrant.


* sb/in-core-index-doc (2017-01-19) 4 commits
  (merged to 'next' on 2017-01-23 at 30224463e8)
 + documentation: retire unfinished documentation
 + cache.h: document add_[file_]to_index
 + cache.h: document remove_index_entry_at
 + cache.h: document index_name_pos

 Documentation and in-code comments updates.


* sb/retire-convert-objects-from-contrib (2017-01-19) 1 commit
  (merged to 'next' on 2017-01-23 at decc1e237d)
 + contrib: remove git-convert-objects

 Remove an ancient tool left in contrib/.


* st/verify-tag (2017-01-18) 6 commits
  (merged to 'next' on 2017-01-23 at 2810959427)
 + t/t7004-tag: Add --format specifier tests
 + t/t7030-verify-tag: Add --format specifier tests
 + builtin/tag: add --format argument for tag -v
 + builtin/verify-tag: add --format to verify-tag
 + ref-filter: add function to print single ref_array_item
 + gpg-interface, tag: add GPG_VERIFY_OMIT_STATUS flag

 "git tag" and "git verify-tag" learned to put GPG verification
 status in their "--format=<placeholders>" output format.


* vp/show-ref-verify-head (2017-01-23) 6 commits
  (merged to 'next' on 2017-01-23 at af6dd9d239)
 + show-ref: remove a stale comment
 + show-ref: remove dead `if (verify)' check
 + show-ref: detect dangling refs under --verify as well
 + show-ref: move --quiet handling into show_one()
 + show-ref: allow -d to work with --verify
 + show-ref: accept HEAD with --verify

 "git show-ref HEAD" used with "--verify" because the user is not
 interested in seeing refs/remotes/origin/HEAD, and used with
 "--head" because the user does not want HEAD to be filtered out,
 i.e. "git show-ref --head --verify HEAD", did not work as expected.

--------------------------------------------------
[New Topics]

* cw/doc-sign-off (2017-01-27) 1 commit
 - doc: clarify distinction between sign-off and pgp-signing

 Doc update.

 Will merge to 'next'.


* jk/delta-chain-limit (2017-01-27) 2 commits
 - pack-objects: convert recursion to iteration in break_delta_chain()
 - pack-objects: enforce --depth limit in reused deltas

 "git repack --depth=<n>" for a long time busted the specified depth
 when reusing delta from existing packs.  This has been corrected.

 Will merge to 'next'.


* js/re-running-failed-tests (2017-01-27) 1 commit
 - t/Makefile: add a rule to re-run previously-failed tests

 "make -C t failed" will now run only the tests that failed in the
 previous run.  This is usable only when prove is not use, and gives
 a useless error message when run after "make clean".

 Will merge to 'next'.


* js/unzip-in-usr-bin-workaround (2017-01-27) 1 commit
 - test-lib: on FreeBSD, look for unzip(1) in /usr/local/bin/

 Test tweak for FreeBSD where /usr/bin/unzip is unsuitable to run
 our tests but /usr/local/bin/unzip is usable.

 Will merge to 'next'.


* gv/mingw-p4-mapuser (2017-01-30) 1 commit
 - git-p4: fix git-p4.mapUser on Windows

 "git p4" did not work well with multiple git-p4.mapUser entries on
 Windows.

 Will merge to 'next'.


* hv/mingw-help-is-executable (2017-01-30) 1 commit
 - help: improve is_executable() on Windows

 "git help" enumerates executable files in $PATH; the implementation
 of "is this file executable?" on Windows has been optimized.

 Will merge to 'next'.


* cw/log-updates-for-all-refs-really (2017-01-31) 3 commits
 - update-ref: add test cases for bare repository
 - refs: add option core.logAllRefUpdates = always
 - config: add markup to core.logAllRefUpdates doc

 The "core.logAllRefUpdates" that used to be boolean has been
 enhanced to take 'always' as well, to record ref updates to refs
 other than the ones that are expected to be updated (i.e. branches,
 remote-tracking branches and notes).

 Will merge to 'next'.


* mm/merge-rename-delete-message (2017-01-30) 1 commit
 - merge-recursive: make "CONFLICT (rename/delete)" message show both paths


* mm/reset-facl-before-umask-test (2017-01-30) 1 commit
 - t0001: don't let a default ACL interfere with the umask test

 Test tweaks for those who have default ACL in their git source tree
 that interfere with the umask test.

 Will merge to 'next'.


* rs/object-id (2017-01-30) 3 commits
 - checkout: convert post_checkout_hook() to struct object_id
 - use oidcpy() for copying hashes between instances of struct object_id
 - use oid_to_hex_r() for converting struct object_id hashes to hex strings

 "uchar [40]" to "struct object_id" conversion continues.

 Will merge to 'next'.


* rs/swap (2017-01-30) 5 commits
 - graph: use SWAP macro
 - diff: use SWAP macro
 - use SWAP macro
 - apply: use SWAP macro
 - add SWAP macro

 Code clean-up.

 Will merge to 'next'.


* pl/complete-diff-submodule-diff (2017-01-30) 1 commit
 - Completion: Add support for --submodule=diff

 The command line completion (in contrib/) learned that
 "git diff --submodule=" can take "diff" as a recently added option.

 Will merge to 'next'.


* rs/receive-pack-cleanup (2017-01-30) 1 commit
 - receive-pack: call string_list_clear() unconditionally

 Code clean-up.

 Will merge to 'next'.


* sb/submodule-add-force (2016-11-29) 1 commit
 + submodule add: extend force flag to add existing repos
 (this branch is used by sb/push-make-submodule-check-the-default.)

 "git submodule add" used to be confused and refused to add a
 locally created repository; users can now use "--force" option
 to add them.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ls/p4-path-encoding (2016-12-18) 1 commit
 - git-p4: fix git-p4.pathEncoding for removed files

 When "git p4" imports changelist that removes paths, it failed to
 convert pathnames when the p4 used encoding different from the one
 used on the Git side.  This has been corrected.

 Will be rerolled.
 cf. <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>


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


* mh/ref-remove-empty-directory (2017-01-07) 23 commits
 - files_transaction_commit(): clean up empty directories
 - try_remove_empty_parents(): teach to remove parents of reflogs, too
 - try_remove_empty_parents(): don't trash argument contents
 - try_remove_empty_parents(): rename parameter "name" -> "refname"
 - delete_ref_loose(): inline function
 - delete_ref_loose(): derive loose reference path from lock
 - log_ref_write_1(): inline function
 - log_ref_setup(): manage the name of the reflog file internally
 - log_ref_write_1(): don't depend on logfile argument
 - log_ref_setup(): pass the open file descriptor back to the caller
 - log_ref_setup(): improve robustness against races
 - log_ref_setup(): separate code for create vs non-create
 - log_ref_write(): inline function
 - rename_tmp_log(): improve error reporting
 - rename_tmp_log(): use raceproof_create_file()
 - lock_ref_sha1_basic(): use raceproof_create_file()
 - lock_ref_sha1_basic(): inline constant
 - raceproof_create_file(): new function
 - safe_create_leading_directories(): set errno on SCLD_EXISTS
 - safe_create_leading_directories_const(): preserve errno
 - t5505: use "for-each-ref" to test for the non-existence of references
 - refname_is_safe(): correct docstring
 - files_rename_ref(): tidy up whitespace

 Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
 once there no longer is any other branch whose name begins with
 "foo/", but we didn't do so so far.  Now we do.

 Expecting a reroll.
 cf. <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>


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

* js/mingw-hooks-with-exe-suffix (2017-01-30) 1 commit
 - mingw: allow hooks to be .exe files

 Names of the various hook scripts must be spelled exactly, but on
 Windows, an .exe binary must be named with .exe suffix; notice
 $GIT_DIR/hooks/<hookname>.exe as a valid <hookname> hook.

 Will merge to 'next'.


* js/retire-relink (2017-01-25) 2 commits
 - relink: really remove the command
 - relink: retire the command

 Cruft removal.

 Will merge to 'next'.


* js/status-pre-rebase-i (2017-01-26) 1 commit
  (merged to 'next' on 2017-01-31 at 09e51b2e39)
 + status: be prepared for not-yet-started interactive rebase

 After starting "git rebase -i", which first opens the user's editor
 to edit the series of patches to apply, but before saving the
 contents of that file, "git status" failed to show the current
 state (i.e. you are in an interactive rebase session, but you have
 applied no steps yet) correctly.

 Will merge to 'master'.


* ps/urlmatch-wildcard (2017-01-31) 5 commits
 . urlmatch: allow globbing for the URL host part
 . urlmatch: include host in urlmatch ranking
 . urlmatch: split host and port fields in `struct url_info`
 . urlmatch: enable normalization of URLs with globs
 . mailmap: add Patrick Steinhardt's work address

 The <url> part in "http.<url>.<variable>" configuration variable
 can now be spelled with '*' that serves as wildcard.
 E.g. "http.https://*.example.com.proxy" can be used to specify the
 proxy used for https://a.example.com, https://b.example.com, etc.,
 i.e. any host in the example.com domain.

 With the update it still seems to fail the same t5551#31
 cf. <cover.1485853153.git.ps@pks.im>


* rs/absolute-pathdup (2017-01-27) 2 commits
  (merged to 'next' on 2017-01-31 at f751f64876)
 + use absolute_pathdup()
 + abspath: add absolute_pathdup()

 Code cleanup.

 Will merge to 'master'.


* sb/submodule-recursive-absorb (2017-01-26) 3 commits
  (merged to 'next' on 2017-01-31 at 0a24cfd06b)
 + submodule absorbing: fix worktree/gitdir pointers recursively for non-moves
 + cache.h: expose the dying procedure for reading gitlinks
 + setup: add gentle version of resolve_git_dir

 When a submodule "sub", which has another submodule "module" nested
 within it, is "absorbed" into the top-level superproject, the inner
 submodule "module" is left in a strange state.

 Will merge to 'master'.


* sb/submodule-update-initial-runs-custom-script (2017-01-26) 1 commit
  (merged to 'next' on 2017-01-31 at d794f894c6)
 + submodule update: run custom update script for initial populating as well

 The user can specify a custom update method that is run when
 "submodule update" updates an already checked out submodule.  This
 was ignored when checking the submodule out for the first time and
 we instead always just checked out the commit that is bound to the
 path in the superproject's index.

 Will merge to 'master'.


* sf/putty-w-args (2017-01-26) 3 commits
 - connect: support GIT_SSH_VARIANT and ssh.variant
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

 Expecting a reroll of the last step to plug new memory leak.
 cf. <xmqqpoj8z7su.fsf@gitster.mtv.corp.google.com>


* bc/use-asciidoctor-opt (2017-01-31) 8 commits
 - Documentation: implement linkgit macro for Asciidoctor
 - Makefile: add a knob to enable the use of Asciidoctor
 - Documentation: move dblatex arguments into variable
 - Documentation: add XSLT to fix DocBook for Texinfo
 - Documentation: sort sources for gitman.texi
 - Documentation: remove unneeded argument in cat-texi.perl
 - Documentation: modernize cat-texi.perl
 - Documentation: fix warning in cat-texi.perl

 Asciidoctor, an alternative reimplementation of AsciiDoc, still
 needs some changes to work with documents meant to be formatted
 with AsciiDoc.  "make USE_ASCIIDOCTOR=YesPlease" to use it out of
 the box to document our pages is getting closer to reality.

 Will merge to 'next'.


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


* ep/commit-static-buf-cleanup (2017-01-31) 2 commits
  (merged to 'next' on 2017-01-31 at 02d3c25219)
 + builtin/commit.c: switch to strbuf, instead of snprintf()
 + builtin/commit.c: remove the PATH_MAX limitation via dynamic allocation

 Code clean-up.

 Will merge to 'master'.


* sb/unpack-trees-super-prefix (2017-01-25) 4 commits
  (merged to 'next' on 2017-01-31 at dabe6ca2b1)
 + unpack-trees: support super-prefix option
 + t1001: modernize style
 + t1000: modernize style
 + read-tree: use OPT_BOOL instead of OPT_SET_INT

 "git read-tree" and its underlying unpack_trees() machinery learned
 to report problematic paths prefixed with the --super-prefix option.

 Will merge to 'master'.


* sb/submodule-doc (2017-01-12) 3 commits
 - submodules: add a background story
 - submodule update documentation: don't repeat ourselves
 - submodule documentation: add options to the subcommand

 Needs review.


* bw/attr (2017-01-23) 27 commits
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
 - Documentation/gitattributes.txt: fix a typo
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

 Expecting a reroll.


* vn/xdiff-func-context (2017-01-15) 1 commit
 - xdiff -W: relax end-of-file function detection

 "git diff -W" has been taught to handle the case where a new
 function is added at the end of the file better.

 Will hold.
 An follow-up change to go back from the line that matches the
 funcline to show comments before the function definition is still
 being discussed.


* ls/filter-process-delayed (2017-01-08) 1 commit
 . convert: add "status=delayed" to filter process protocol

 Ejected, as does not build when merged to 'pu'.


* nd/worktree-move (2017-01-27) 7 commits
 - fixup! worktree move: new command
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Needs review.


* nd/log-graph-configurable-colors (2017-01-23) 3 commits
  (merged to 'next' on 2017-01-23 at c369982ad8)
 + log --graph: customize the graph lines with config log.graphColors
 + color.c: trim leading spaces in color_parse_mem()
 + color.c: fix color_parse_mem() with value_len == 0

 Some people feel the default set of colors used by "git log --graph"
 rather limiting.  A mechanism to customize the set of colors has
 been introduced.

 Reported to break "add -p".
 cf. <20170128040709.tqx4u45ktgpkbfm4@sigill.intra.peff.net>


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


* sb/push-make-submodule-check-the-default (2017-01-26) 2 commits
  (merged to 'next' on 2017-01-26 at 5f4715cea6)
 + Revert "push: change submodule default to check when submodules exist"
  (merged to 'next' on 2016-12-12 at 1863e05af5)
 + push: change submodule default to check when submodules exist
 (this branch uses sb/submodule-add-force.)

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Retracted.


* kn/ref-filter-branch-list (2017-01-31) 20 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
 - ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
 - ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
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

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Will merge to 'next'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-12-05 at 0c77e39cd5)
 + setup_git_env: avoid blind fall-back to ".git"

 Originally merged to 'next' on 2016-10-26

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


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


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-12-05 at 041946dae0)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2016-10-11

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* jc/bundle (2016-03-03) 6 commits
 . index-pack: --clone-bundle option
 . Merge branch 'jc/index-pack' into jc/bundle
 . bundle v3: the beginning
 . bundle: keep a copy of bundle file name in the in-core bundle header
 . bundle: plug resource leak
 . bundle doc: 'verify' is not about verifying the bundle

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

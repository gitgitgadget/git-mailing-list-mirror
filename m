Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBFE3202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbdGEWfw (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 18:35:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35645 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdGEWfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 18:35:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so313591pgc.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=z8/ixH/mQ+PFcb5pFQWcuHWmsWVj0ZB+t3OjCDIyhfI=;
        b=V8APS4OzBiFP+zCFYwUq7LakbImlxxmVCmDRMdISU96CEGNCHgtmrG7U1tuHNzAfNt
         E2G12ZkLpjKkY9mfVfZ5275UUCE4owVXZEUcfunoSAfOF8QRQKD6KChYanoh8Vyv+O+g
         9pjco4UkhU+qiXoiIse+ov5moLTkdm6hfAfjibVQzO8LJlPbEivvKLshkTU+6Lp9RRwM
         NJAT0oFs4xD9uhVQEAeZZEdPAvuLwiaNyUMd9wuoiZdfmAKGe7NzDe18p3hp35a+cv6i
         S2nxdqoB2JXxJM1/Kejzg2FNOj8TwaauzK6Jo41eafUZLls9FVuRFrcDfdZcJQFmh4ab
         6ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=z8/ixH/mQ+PFcb5pFQWcuHWmsWVj0ZB+t3OjCDIyhfI=;
        b=TMwmfiFZcV3vxyXbwj239UzWofIY/MG/EA5/YxSrJFbSU5sf9rfdxXVRCwDXf1ygj8
         rdI62403SB2I7immb9oNXCXG7bk+3KunRsZWYvOsImhR4pLW+vifvIUH8jOtvxIOp/Vv
         CH7pKV5X10kJdN/NFtsJMwun50R6/Jmq6FAv++I+Nsr4VaJgs0zjYfw/1aN27fKSk1Og
         lWrjLwrrgJiceiVA4VthxXCEIO5a6AHRaMcrK+SMWxXt3N437XhoDENtIBmvmCL9A9Ih
         OPum/m/m4Oxh2wmBZCpC5qJm3N9KhkWn+BJQkOy8epnit3igJzy7b3NCYBzBidiuAFtW
         dEkg==
X-Gm-Message-State: AIVw111AzApy/cFnbLOUoHfpVd6aOJZW/CheK1zdkmaMNokR5klYPrPv
        SWEOsBzm/otbpux+od5sRMyb
X-Received: by 10.99.94.70 with SMTP id s67mr22756222pgb.82.1499294147876;
        Wed, 05 Jul 2017 15:35:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id s88sm289730pfk.16.2017.07.05.15.35.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 15:35:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2017, #01; Wed, 5)
X-master-at: 50ff9ea4a0770c8b1bfe3f98f09728427c0c6cc7
X-next-at: b4debfe1a1bbbf047b7c2b69802448ce45df5f2f
Date:   Wed, 05 Jul 2017 15:35:44 -0700
Message-ID: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
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

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bw/repo-object (2017-06-23) 21 commits
  (merged to 'next' on 2017-06-26 at ed9c0b77c3)
 + ls-files: use repository object
 + repository: enable initialization of submodules
 + submodule: convert is_submodule_initialized to work on a repository
 + submodule: add repo_read_gitmodules
 + submodule-config: store the_submodule_cache in the_repository
 + repository: add index_state to struct repo
 + config: read config from a repository object
 + path: add repo_worktree_path and strbuf_repo_worktree_path
 + path: add repo_git_path and strbuf_repo_git_path
 + path: worktree_git_path() should not use file relocation
 + path: convert do_git_path to take a 'struct repository'
 + path: convert strbuf_git_common_path to take a 'struct repository'
 + path: always pass in commondir to update_common_dir
 + path: create path.h
 + environment: store worktree in the_repository
 + environment: place key repository state in the_repository
 + repository: introduce the repository object
 + environment: remove namespace_len variable
 + setup: add comment indicating a hack
 + setup: don't perform lazy initialization of repository state
 + Merge branches 'bw/ls-files-sans-the-index' and 'bw/config-h' into bw/repo-object

 Introduce a "repository" object to eventually make it easier to
 work in multiple repositories (the primary focus is to work with
 the superproject and its submodules) in a single process.


* cc/shared-index-permfix (2017-06-25) 3 commits
  (merged to 'next' on 2017-06-26 at bb41584bf0)
 + t1700: make sure split-index respects core.sharedrepository
 + t1301: move modebits() to test-lib-functions.sh
 + read-cache: use shared perms when writing shared index

 The split index code did not honor core.sharedrepository setting
 correctly.


* jt/unify-object-info (2017-06-26) 8 commits
  (merged to 'next' on 2017-06-26 at 540ea81983)
 + sha1_file: refactor has_sha1_file_with_flags
 + sha1_file: do not access pack if unneeded
 + sha1_file: teach sha1_object_info_extended more flags
 + sha1_file: refactor read_object
 + sha1_file: move delta base cache code up
 + sha1_file: rename LOOKUP_REPLACE_OBJECT
 + sha1_file: rename LOOKUP_UNKNOWN_OBJECT
 + sha1_file: teach packed_object_info about typename

 Code clean-ups.


* rs/sha1-name-readdir-optim (2017-06-24) 4 commits
  (merged to 'next' on 2017-06-26 at a70587f2b9)
 + sha1_file: guard against invalid loose subdirectory numbers
 + sha1_file: let for_each_file_in_obj_subdir() handle subdir names
 + p4205: add perf test script for pretty log formats
 + sha1_name: cache readdir(3) results in find_short_object_filename()

 Optimize "what are the object names already taken in an alternate
 object database?" query that is used to derive the length of prefix
 an object name is uniquely abbreviated to.

--------------------------------------------------
[New Topics]

* bc/object-id (2017-07-04) 12 commits
 - sha1_name: convert GET_SHA1* flags to GET_OID*
 - sha1_name: convert get_sha1* to get_oid*
 - Convert remaining callers of get_sha1 to get_oid.
 - builtin/verify-tag: convert to struct object_id
 - builtin/unpack-file: convert to struct object_id
 - bisect: convert bisect_checkout to struct object_id
 - builtin/update_ref: convert to struct object_id
 - sequencer: convert to struct object_id
 - remote: convert struct push_cas to struct object_id
 - submodule: convert submodule config lookup to use object_id
 - builtin/merge-tree: convert remaining caller of get_sha1 to object_id
 - builtin/fsck: convert remaining caller of get_sha1 to object_id

 Conversion from uchar[20] to struct object_id continues.


* jk/reflog-walk (2017-07-05) 7 commits
 - reflog-walk: stop using fake parents
 - rev-list: check reflog_info before showing usage
 - get_revision_1(): replace do-while with an early return
 - log: do not free parents when walking reflog
 - [SQUASH LOG MESSAGE ONLY] t1414: document some reflog-walk oddities
 - t1414: document some reflog-walk oddities
 - Merge branch 'jk/reflog-walk-maint' into jk/reflog-walk
 (this branch uses jk/reflog-walk-maint.)

 Numerous bugs in walking of reflogs via "log -g" and friends have
 been fixed.


* jk/reflog-walk-maint (2017-07-05) 1 commit
 - reflog-walk: skip over double-null oid due to HEAD rename
 (this branch is used by jk/reflog-walk.)

 After "git branch --move" of the currently checked out branch, the
 code to walk the reflog of HEAD via "log -g" and friends
 incorrectly stopped at the reflog entry that records the renaming
 of the branch.


* js/t5534-rev-parse-gives-multi-line-output-fix (2017-07-05) 1 commit
  (merged to 'next' on 2017-07-05 at 5f964c44ba)
 + t5534: fix misleading grep invocation

 A few tests that tried to verify the contents of push certificates
 did not use 'git rev-parse' to formulate the line to look for in
 the certificate correctly.

 Will merge to 'master'.


* rs/apply-avoid-over-reading (2017-07-01) 1 commit
  (merged to 'next' on 2017-07-05 at 35730f3a47)
 + apply: use starts_with() in gitdiff_verify_name()

 Code clean-up to fix possible buffer over-reading.

 Will merge to 'master'.


* sb/hashmap-cleanup (2017-07-05) 10 commits
 - t/helper/test-hashmap: use custom data instead of duplicate cmp functions
 - name-hash.c: drop hashmap_cmp_fn cast
 - submodule-config.c: drop hashmap_cmp_fn cast
 - remote.c: drop hashmap_cmp_fn cast
 - patch-ids.c: drop hashmap_cmp_fn cast
 - convert/sub-process: drop cast to hashmap_cmp_fn
 - config.c: drop hashmap_cmp_fn cast
 - builtin/describe: drop hashmap_cmp_fn cast
 - builtin/difftool.c: drop hashmap_cmp_fn cast
 - attr.c: drop hashmap_cmp_fn cast
 (this branch uses sb/hashmap-customize-comparison; is tangled with sb/diff-color-move.)

 Many uses of comparision callback function the hashmap API uses
 cast the callback function type when registering it to
 hashmap_init(), which defeats the compile time type checking when
 the callback interface changes (e.g. gaining more parameters).
 The callback implementations have been updated to take "void *"
 pointers and cast them to the type they expect instead.

 Will wait for feedback, then merge to and cook in 'next'.


* tb/push-to-cygwin-unc-path (2017-07-05) 1 commit
 - cygwin: allow pushing to UNC paths

 On Cygwin, similar to Windows, "git push //server/share/repository"
 ought to mean a repository on a network share that can be accessed
 locally, but this did not work correctly due to stripping the double
 slashes at the beginning.

 This may need to be heavily tested before it gets unleashed to the
 wild, as the change is at a fairly low-level code and would affect
 not just the code to decide if the push destination is local.  There
 may be unexpected fallouts in the path normalization.

 Will wait for feedback, then merge to and cook in 'next'.


* ab/sha1dc-maint (2017-07-03) 1 commit
  (merged to 'next' on 2017-07-05 at ac69c90b7e)
 + sha1dc: update from upstream
 (this branch is used by ab/sha1dc.)

 Update the sha1dc again to fix portability glitches.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

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


* xz/send-email-batch-size (2017-07-05) 1 commit
  (merged to 'next' on 2017-07-05 at 92f3c31fbd)
 + send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

 Will merge to 'master'.


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>


* js/rebase-i-final (2017-06-15) 10 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper
 - t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Expecting a reroll.
 This is at its v5.
 cf. <cover.1497444257.git.johannes.schindelin@gmx.de>

--------------------------------------------------
[Cooking]

* ab/grep-lose-opt-regflags (2017-06-30) 6 commits
  (merged to 'next' on 2017-07-05 at 375c0b92ea)
 + grep: remove redundant REG_NEWLINE when compiling fixed regex
 + grep: remove regflags from the public grep_opt API
 + grep: remove redundant and verbose re-assignments to 0
 + grep: remove redundant "fixed" field re-assignment to 0
 + grep: adjust a redundant grep pattern type assignment
 + grep: remove redundant double assignment to 0

 Code cleanup.

 Will merge to 'master'.


* ks/commit-assuming-only-warning-removal (2017-06-30) 2 commits
  (merged to 'next' on 2017-07-05 at 462a72df95)
 + commit-template: distinguish status information unconditionally
 + commit-template: remove outdated notice about explicit paths

 An old message shown in the commit log template was removed, as it
 has outlived its usefulness.

 Will merge to 'master'.


* sb/hashmap-customize-comparison (2017-06-30) 3 commits
 - hashmap: migrate documentation from Documentation/technical into header
 - patch-ids.c: use hashmap correctly
 - hashmap.h: compare function has access to a data field
 (this branch is used by sb/diff-color-move and sb/hashmap-cleanup.)

 Update the hashmap API so that data to customize the behaviour of
 the comparison function can be specified at the time a hashmap is
 initialized.

 Will merge to 'next'.


* sb/merge-recursive-code-cleanup (2017-06-30) 1 commit
  (merged to 'next' on 2017-07-05 at 4228240520)
 + merge-recursive: use DIFF_XDL_SET macro

 Code clean-up.

 Will merge to 'master'.


* ab/strbuf-addftime-tzname-boolify (2017-07-01) 2 commits
  (merged to 'next' on 2017-07-05 at 81e6795eb3)
 + strbuf: change an always NULL/"" strbuf_addftime() param to bool
 + strbuf.h comment: discuss strbuf_addftime() arguments in order

 strbuf_addftime() is further getting tweaked.

 Will merge to 'master'.


* mt/p4-parse-G-output (2017-07-05) 1 commit
 - git-p4: parse marshal output "p4 -G" in p4 changes

 Use "p4 -G" to make "p4 changes" output more Python-friendly
 to parse.

 Needs review/ack from git-p4 folks.


* aw/contrib-subtree-doc-asciidoctor (2017-06-27) 1 commit
  (merged to 'next' on 2017-06-30 at af23bd111b)
 + subtree: honour USE_ASCIIDOCTOR when set

 The Makefile rule in contrib/subtree for building documentation
 learned to honour USE_ASCIIDOCTOR just like the main documentation
 set does.

 Will merge to 'master'.


* js/fsck-name-object (2017-06-28) 1 commit
  (merged to 'next' on 2017-06-30 at 9a08514cf2)
 + t1450: use egrep for regexp "alternation"

 Test fix.

 Will merge to 'master'.


* jc/utf8-fprintf (2017-06-28) 1 commit
  (merged to 'next' on 2017-06-30 at a8cc490818)
 + submodule--helper: do not call utf8_fprintf() unnecessarily

 Code cleanup.

 Will merge to 'master'.


* rs/free-and-null (2017-06-29) 1 commit
 - coccinelle: polish FREE_AND_NULL rules

 Code cleanup.


* ab/wildmatch (2017-06-23) 1 commit
 - wildmatch: remove unused wildopts parameter

 Prepare the wildmatch API for future enhancements to allow a
 pattern that is repeatedly matched against many strings to be
 precompiled.


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-06-26 at d026281517)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.


* sb/pull-rebase-submodule (2017-06-27) 4 commits
 - builtin/fetch cleanup: always set default value for submodule recursing
 - pull: optionally rebase submodules (remote submodule changes only)
 - builtin/fetch: parse recurse-submodules-default at default options parsing
 - builtin/fetch: factor submodule recurse parsing out to submodule config

 "git pull --rebase --recurse-submodules" learns to rebase the
 branch in the submodules to an updated base.


* pw/unquote-path-in-git-pm (2017-06-30) 4 commits
  (merged to 'next' on 2017-07-05 at 538ab4d599)
 + t9700: add tests for Git::unquote_path()
 + Git::unquote_path(): throw an exception on bad path
 + Git::unquote_path(): handle '\a'
 + add -i: move unquote_path() to Git.pm

 Code refactoring.

 Will merge to 'master'.


* mh/packed-ref-store (2017-07-03) 30 commits
  (merged to 'next' on 2017-07-05 at 6c68c603cc)
 + read_packed_refs(): die if `packed-refs` contains bogus data
 + t3210: add some tests of bogus packed-refs file contents
 + repack_without_refs(): don't lock or unlock the packed refs
 + commit_packed_refs(): remove call to `packed_refs_unlock()`
 + clear_packed_ref_cache(): don't protest if the lock is held
 + packed_refs_unlock(), packed_refs_is_locked(): new functions
 + packed_refs_lock(): report errors via a `struct strbuf *err`
 + packed_refs_lock(): function renamed from lock_packed_refs()
 + commit_packed_refs(): use a staging file separate from the lockfile
 + commit_packed_refs(): report errors rather than dying
 + packed_ref_store: make class into a subclass of `ref_store`
 + packed-backend: new module for handling packed references
 + packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
 + packed_ref_store: support iteration
 + packed_peel_ref(): new function, extracted from `files_peel_ref()`
 + repack_without_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref(): take a `packed_ref_store *` parameter
 + rollback_packed_refs(): take a `packed_ref_store *` parameter
 + commit_packed_refs(): take a `packed_ref_store *` parameter
 + lock_packed_refs(): take a `packed_ref_store *` parameter
 + add_packed_ref(): take a `packed_ref_store *` parameter
 + get_packed_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref_cache(): take a `packed_ref_store *` parameter
 + validate_packed_ref_cache(): take a `packed_ref_store *` parameter
 + clear_packed_ref_cache(): take a `packed_ref_store *` parameter
 + packed_ref_store: move `packed_refs_lock` member here
 + packed_ref_store: move `packed_refs_path` here
 + packed_ref_store: new struct
 + add_packed_ref(): teach function to overwrite existing refs
 + t1408: add a test of stale packed refs covered by loose refs

 The "ref-store" code reorganization continues.

 Will merge to 'master'.


* sb/submodule-doc (2017-06-22) 1 commit
 - submodules: overhaul documentation

 Doc update.

 What's the status of this thing?


* sd/branch-copy (2017-06-18) 3 commits
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Has a bit of interaction with mh/packed-ref-store and bw/config-h,
 so perhaps needs to wait for the former to stabilize a bit more
 and possibly rebasing on them.


* ls/filter-process-delayed (2017-06-30) 7 commits
  (merged to 'next' on 2017-07-05 at a35e644082)
 + convert: add "status=delayed" to filter process protocol
 + convert: refactor capabilities negotiation
 + convert: move multiple file filter error handling to separate function
 + convert: put the flags field before the flag itself for consistent style
 + t0021: write "OUT <size>" only on success
 + t0021: make debug log file name configurable
 + t0021: keep filter log files on comparison

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.

 Will merge to 'master'.


* ab/sha1dc (2017-07-03) 2 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule
 (this branch uses ab/sha1dc-maint.)

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.  Glitches on minority platforms are still being worked out.

 Will merge to 'next'.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 No more comments or updates?


* sb/diff-color-move (2017-06-30) 26 commits
 - diff: document the new --color-moved setting
 - diff.c: add dimming to moved line detection
 - diff.c: color moved lines differently, plain mode
 - diff.c: color moved lines differently
 - diff.c: buffer all output if asked to
 - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
 - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
 - diff.c: convert word diffing to use emit_diff_symbol
 - diff.c: convert show_stats to use emit_diff_symbol
 - diff.c: convert emit_binary_diff_body to use emit_diff_symbol
 - submodule.c: migrate diff output to use emit_diff_symbol
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
 - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
 - diff.c: migrate emit_line_checked to use emit_diff_symbol
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
 - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
 - diff.c: introduce emit_diff_symbol
 - diff.c: factor out diff_flush_patch_all_file_pairs
 - diff.c: move line ending check into emit_hunk_header
 - diff.c: readability fix
 - Merge branch 'sb/hashmap-customize-comparison' into sb/diff-color-move
 (this branch uses sb/hashmap-customize-comparison; is tangled with sb/hashmap-cleanup.)

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.

 Will merge to 'next'.

--------------------------------------------------
[Discarded]

* mh/packed-ref-store-prep-extra (2017-06-18) 1 commit
 . prefix_ref_iterator_advance(): relax the check of trim length

 Split out of mh/packed-ref-store-prep.


* nd/prune-in-worktree (2017-04-24) 12 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add refs_head_ref()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . refs.c: refactor get_submodule_ref_store(), share common free block
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.


* ab/free-and-null (2017-06-28) 2 commits
  (merged to 'next' on 2017-06-28 at 1cf373c61a)
 + Revert "coccinelle: add a rule to make "expression" code use FREE_AND_NULL()"
  (merged to 'next' on 2017-06-28 at 1785f88122)
 + coccinelle: add a rule to make "expression" code use FREE_AND_NULL()

 The coccinelle rule for free-and-null refactoring got simplified.

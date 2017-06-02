Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758CB20D12
	for <e@80x24.org>; Fri,  2 Jun 2017 06:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdFBGit (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 02:38:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36600 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdFBGiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 02:38:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so11653204pfb.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=jb5l/qI0cHjhue9nUGETwEhYfjMaVu3kt0VO2YDYXT0=;
        b=N1w8ltwqFbTXOkIpx9B7qjKqtrexkeezPwSwKoZZ9NPUhhusi+0xA1hzObqxyX+KUZ
         4Pn9xDzCDRjXbYz7PkTalHzf68VBHE/d6giy9UQpx0C+caoVqLJfV1UdHTs1ZMg7uNFl
         di77aSQjaorUF5YXveAy4iYZrhzursG6QhTslq/Wi8Zd5IHtDZhCAywp7MsT9s49X9br
         mDnyYrgVV9jV26Sq8Ekc82gc2oIGpPwtScuI9LyKSbSsvoA6dQswmowGny2NqyqekWx7
         QHq3g+YMp3givPMT2zaRS+r6F56WdsRkTGb8OQaBktP1nZw5/e5ibcCymK6lCw2cav0f
         ZMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=jb5l/qI0cHjhue9nUGETwEhYfjMaVu3kt0VO2YDYXT0=;
        b=dPXsYpLSuLb/j5RmS5gNlu8OsqBkmoT2c16196yGaVLXCN+ITc8tmvxYZXKMt01Fry
         RecCu0IxL1FEkd7D/cdq4hWjlEIq0EH9ytUyZ3BADlcmvjGSj+paJQl+PLHc3hMstJu+
         4WDktubj+x0JtWPCgDjjv1QEys2fpHhGfNvPekTq35BhJWkaJ12Fr1EOKSFtl02dULtU
         B6NJ31ao3d0kSepmUiJtQI78LeprKmZ7dYAvb02lfSquYJwYpdCwuRD157gvhssVLYaJ
         l+cQuBN+JJ+Zhx3di13LxqOnKnO/PMOCN0y/Glv6LzgS2lie8x/JcN861cCN7GYd5Igs
         MbwA==
X-Gm-Message-State: AODbwcDZ6uAsB8IOeNFyu9eE0U5bmDJ8TpRCdNwBeWR30yUBZrcfc8Y3
        rdcdVCCuXYUdkgIMZC++2gU/
X-Received: by 10.99.60.6 with SMTP id j6mr5566754pga.18.1496385524911;
        Thu, 01 Jun 2017 23:38:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id w67sm17891892pgb.7.2017.06.01.23.38.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 23:38:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2017, #02; Fri, 2)
X-master-at: 826c06412e429a091d32d0e1b26e77da33fc1ce9
X-next-at: 4b9c06c7d442bdd2a0056b5372cc385eaee2012e
Date:   Fri, 02 Jun 2017 15:38:43 +0900
Message-ID: <xmqq8tlazyfg.fsf@gitster.mtv.corp.google.com>
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

As much I hate to send a new issue of "What's cooking" report in
quick successions, quite a lot has happened on the 'master' front to
prepare topics that wants to eventually go to 'maint'.  I am aiming
to tag v2.13.1 very early next week, as I expect to be offline in
the latter half of the week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/grep-preparatory-cleanup (2017-05-26) 31 commits
  (merged to 'next' on 2017-05-29 at f2cfa89d3e)
 + grep: assert that threading is enabled when calling grep_{lock,unlock}
 + grep: given --threads with NO_PTHREADS=YesPlease, warn
 + pack-objects: fix buggy warning about threads
 + pack-objects & index-pack: add test for --threads warning
 + test-lib: add a PTHREADS prerequisite
 + grep: move is_fixed() earlier to avoid forward declaration
 + grep: change internal *pcre* variable & function names to be *pcre1*
 + grep: change the internal PCRE macro names to be PCRE1
 + grep: factor test for \0 in grep patterns into a function
 + grep: remove redundant regflags assignments
 + grep: catch a missing enum in switch statement
 + perf: add a comparison test of log --grep regex engines with -F
 + perf: add a comparison test of log --grep regex engines
 + perf: add a comparison test of grep regex engines with -F
 + perf: add a comparison test of grep regex engines
 + perf: emit progress output when unpacking & building
 + perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
 + grep: add tests to fix blind spots with \0 patterns
 + grep: prepare for testing binary regexes containing rx metacharacters
 + grep: add a test helper function for less verbose -f \0 tests
 + grep: add tests for grep pattern types being passed to submodules
 + grep: amend submodule recursion test for regex engine testing
 + grep: add tests for --threads=N and grep.threads
 + grep: change non-ASCII -i test to stop using --debug
 + grep: add a test for backreferences in PCRE patterns
 + grep: add a test asserting that --perl-regexp dies when !PCRE
 + log: make --regexp-ignore-case work with --perl-regexp
 + log: add exhaustive tests for pattern style options & config
 + test-lib: rename the LIBPCRE prerequisite to PCRE
 + grep & rev-list doc: stop promising libpcre for --perl-regexp
 + Makefile & configure: reword inaccurate comment about PCRE
 (this branch is used by ab/pcre-v2 and sb/submodule-blanket-recursive.)

 The internal implementation of "git grep" has seen some clean-up.


* ab/ref-filter-no-contains (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 5d39fd2961)
 + tag: duplicate mention of --contains should mention --no-contains

 Doc update to a recent topic.


* ah/doc-interpret-trailers-ifexists (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at cb353c1d21)
 + Documentation: fix reference to ifExists for interpret-trailers

 Documentation fix.


* ah/doc-pretty-format-fix (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 6e3e8fd80d)
 + Documentation: fix formatting typo in pretty-formats.txt

 Documentation fix.


* dk/send-email-avoid-net-smtp-ssl-when-able (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at 3ff3ddfac7)
 + send-email: Net::SMTP::starttls was introduced in v2.34

 A hotfix to a topic in 'master'.


* jk/diff-blob (2017-05-24) 15 commits
  (merged to 'next' on 2017-05-29 at 5ecc979cc7)
 + diff: use blob path for blob/file diffs
 + diff: use pending "path" if it is available
 + diff: use the word "path" instead of "name" for blobs
 + diff: pass whole pending entry in blobinfo
 + handle_revision_arg: record paths for pending objects
 + handle_revision_arg: record modes for "a..b" endpoints
 + t4063: add tests of direct blob diffs
 + get_sha1_with_context: dynamically allocate oc->path
 + get_sha1_with_context: always initialize oc->symlink_path
 + sha1_name: consistently refer to object_context as "oc"
 + handle_revision_arg: add handle_dotdot() helper
 + handle_revision_arg: hoist ".." check out of range parsing
 + handle_revision_arg: stop using "dotdot" as a generic pointer
 + handle_revision_arg: simplify commit reference lookups
 + handle_revision_arg: reset "dotdot" consistently

 The result from "git diff" that compares two blobs, e.g. "git diff
 $commit1:$path $commit2:$path", used to be shown with the full
 object name as given on the command line, but it is more natural to
 use the $path in the output and use it to look up .gitattributes.


* js/bs-is-a-dir-sep-on-windows (2017-05-26) 2 commits
  (merged to 'next' on 2017-05-26 at 450b39f726)
 + Windows: do not treat a path with backslashes as a remote's nick name
 + mingw.h: permit arguments with side effects for is_dir_sep

 "foo\bar\baz" in "git fetch foo\bar\baz", even though there is no
 slashes in it, cannot be a nickname for a remote on Windows, as
 that is likely to be a pathname on a local filesystem.


* jt/send-email-validate-hook (2017-06-02) 1 commit
  (merged to 'next' on 2017-06-02 at 32055bc433)
 + send-email: check for repo before invoking hook

 A hotfix for a topic already in 'master'.


* rs/mingw-path-lookup-simplify (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 4365139a7f)
 + mingw: simplify PATH handling

 Code simplification.


* sb/t5531-update-desc (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 67a91db3cf)
 + t5531: fix test description

 The description strings for a few tests have been updated.


* sl/clean-d-ignored-fix (2017-05-24) 6 commits
  (merged to 'next' on 2017-05-29 at 837c255ae8)
 + clean: teach clean -d to preserve ignored paths
 + dir: expose cmp_name() and check_contains()
 + dir: hide untracked contents of untracked dirs
 + dir: recurse into untracked dirs for ignored files
 + t7061: status --ignored should search untracked dirs
 + t7300: clean -d should skip dirs with ignored files

 "git clean -d" used to clean directories that has ignored files,
 even though the command should not lose ignored ones without "-x".
 "git status --ignored"  did not list ignored and untracked files
 without "-uall".  These have been corrected.

--------------------------------------------------
[New Topics]

* ad/pull-remote-doc (2017-06-02) 1 commit
  (merged to 'next' on 2017-06-02 at 32915e88db)
 + docs: fix formatting and grammar

 Docfix.

 Will merge to 'master'.


* jc/diff-tree-stale-comment (2017-06-02) 1 commit
 - diff-tree: update stale in-code comments

 Comment fix.

 Will merge to 'next'.


* jc/noent-notdir (2017-05-30) 2 commits
 - treewide: use is_missing_file_error() where ENOENT and ENOTDIR are checked
 - compat-util: is_missing_file_error()

 Our code often opens a path to an optional file, to work on its
 contents when we can successfully open it.  We can ignore a failure
 to open if such an optional file does not exist, but we do want to
 report a failure in opening for other reasons (e.g. we got an I/O
 error, or the file is there, but we lack the permission to open).

 The exact errors we need to ignore are ENOENT (obviously) and
 ENOTDIR (less obvious).  Instead of repeating comparison of errno
 with these two constants, introduce a helper function to do so.

 Will merge to 'next'.


* rf/completion (2017-06-02) 6 commits
 - completion: add git config credentialCache.ignoreSIGHUP
 - completion: add git config credential completions
 - completion: add git config advice completions
 - completion: add git config am.threeWay completion
 - completion: add git config core completions
 - completion: add git config gc completions
 (this branch uses rf/completion-config-commit.)

 Completion updates.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* mg/name-rev-debug (2017-03-31) 2 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Will discard for now.
 cf. <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu>


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


* sk/dash-is-previous (2017-03-01) 5 commits
 . revert.c: delegate handling of "-" shorthand to setup_revisions
 . sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 . revision.c: args starting with "-" might be a revision
 . revision.c: swap if/else blocks
 . revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Ejected, as it seems that making -.. to mean @{-1}..HEAD etc. are
 going too far.

--------------------------------------------------
[Cooking]

* ls/filter-process-delayed (2017-06-01) 5 commits
 - convert: add "status=delayed" to filter process protocol
 - convert: move multiple file filter error handling to separate function
 - t0021: write "OUT" only on success
 - t0021: make debug log file name configurable
 - t0021: keep filter log files on comparison

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.

 Needs review.


* ah/doc-rev-parse-short-default (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at f64fcc2a26)
 + doc: rewrite description for rev-parse --short

 Doc update.

 Will merge to 'master'.


* rf/completion-config-commit (2017-05-30) 1 commit
  (merged to 'next' on 2017-06-01 at cea32e0486)
 + completion: add completions for git config commit
 (this branch is used by rf/completion.)

 Completion update.

 Will merge to 'master'.


* ab/c-translators-comment-style (2017-05-31) 1 commit
  (merged to 'next' on 2017-06-01 at df7fb9199a)
 + C style: use standard style for "TRANSLATORS" comments

 Update the C style recommendation for notes for translators, as
 recent versions of gettext tools can work with our style of
 multi-line comments.

 Will merge to 'master'.


* jc/diff-log-help (2017-06-01) 1 commit
 - diff- and log- family: handle "git cmd -h" early
 (this branch is used by jc/wip-check-help-option.)

 The continuation of jk/consistent-h topic; the plumbing commands in
 the diff- and log- family were calling into the revision machinery
 without repository set-up upon "git $cmd -h", which is fixed.

 Will squeeze into jk/consistent-h topic.


* jk/consistent-h (2017-05-30) 7 commits
 - t0012: test "-h" with builtins
 - git: add hidden --list-builtins option
 - version: convert to parse-options
 - submodule--helper: show usage for "-h"
 - remote-{ext,fd}: print usage message on invalid arguments
 - upload-archive: handle "-h" option early
 - credential: handle invalid arguments earlier
 (this branch uses jk/unbreak-am-h.)

 "git $cmd -h" for builtin commands calls the implementation of the
 command (i.e. cmd_$cmd() function) without doing any repository
 set-up, and the commands that expect RUN_SETUP is done by the Git
 potty needs to be prepared to show the help text without barfing.


* jk/drop-free-refspecs (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at 8f455319fc)
 + remote: drop free_refspecs() function

 Code clean-up.

 Will merge to 'master'.


* jk/unbreak-am-h (2017-05-30) 1 commit
  (merged to 'next' on 2017-06-01 at ee2233d409)
 + am: handle "-h" argument earlier
 (this branch is used by jk/consistent-h.)

 "git am -h" triggered a BUG().

 Will merge to 'master'.


* jk/url-insteadof-config (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at e7ea6032c2)
 + docs/config: mention protocol implications of url.insteadOf

 The interaction of "url.*.insteadOf" and custom URL scheme's
 whitelisting is now documented better.

 Will merge to 'master'.


* pw/rebase-i-regression-fix-tests (2017-06-01) 1 commit
 - rebase -i: add test for reflog message

 Just the first one of three? new tests that follows up a regression
 fix.

 Expecting a portable update.


* sb/submodule-blanket-recursive (2017-06-01) 9 commits
 - builtin/fetch.c: respect 'submodule.recurse' option
 - builtin/push.c: respect 'submodule.recurse' option
 - builtin/grep.c: respect 'submodule.recurse' option
 - Introduce 'submodule.recurse' option for worktree manipulators
 - submodule loading: separate code path for .gitmodules and config overlay
 - reset/checkout/read-tree: unify config callback for submodule recursion
 - submodule test invocation: only pass additional arguments
 - submodule recursing: do not write a config variable twice
 - Merge branch 'ab/grep-preparatory-cleanup' into sb/submodule-blanket-recursive

 Many commands learned to pay attention to submodule.recurse
 configuration.

 Will merge to 'next'.

 It is not known if a simple "yes/no" is sufficient in the longer
 term, and what should happen when --recurse-submodules option starts
 taking "recurse into them how?" parameter, though.


* tb/pull-ff-rebase-autostash (2017-06-01) 1 commit
  (merged to 'next' on 2017-06-01 at b5e676d57e)
 + pull: ff --rebase --autostash works in dirty repo

 "git pull --rebase --autostash" didn't auto-stash when the local history
 fast-forwards to the upstream.

 Will merge to 'master'.


* ab/pcre-v2 (2017-06-02) 8 commits
 - grep: add support for PCRE v2
 - grep: un-break building with PCRE >= 8.32 without --enable-jit
 - grep: un-break building with PCRE < 8.20
 - grep: un-break building with PCRE < 8.32
 - grep: add support for the PCRE v1 JIT API
 - log: add -P as a synonym for --perl-regexp
 - grep: skip pthreads overhead when using one thread
 - grep: don't redundantly compile throwaway patterns under threading

 Update "perl-compatible regular expression" support to enable JIT
 and also allow linking with the newer PCRE v2 library.

 Will merge to 'next'.


* ab/sha1dc-maint (2017-05-22) 1 commit
  (merged to 'next' on 2017-05-30 at 9eb40bf912)
 + sha1dc: update from upstream
 (this branch is used by ab/sha1dc.)

 The "collision detecting" SHA-1 implementation shipped with 2.13
 was quite broken on some big-endian platforms and/or platforms that
 do not like unaligned fetches.  Update to the upstream code which
 has already fixed these issues.

 Will merge to 'master'.


* ab/t3070-test-dedup (2017-05-29) 1 commit
  (merged to 'next' on 2017-05-30 at 71eadec33b)
 + wildmatch test: remove redundant duplicate test

 Test cleanup.

 Will merge to 'master'.


* ah/doc-filter-branch-export-env (2017-05-29) 1 commit
  (merged to 'next' on 2017-05-30 at a62168bf77)
 + doc: filter-branch does not require re-export of vars

 Docfix.

 Will merge to 'master'.


* jk/connect-symref-info-leak-fix (2017-05-26) 1 commit
  (merged to 'next' on 2017-05-30 at d8b75d2dd9)
 + connect.c: fix leak in parse_one_symref_info()

 Leakfix.

 Will merge to 'master'.


* jk/pathspec-magic-disambiguation (2017-05-29) 6 commits
 - verify_filename(): flip order of checks
 - verify_filename(): treat ":(magic)" as a pathspec
 - check_filename(): handle ":^" path magic
 - check_filename(): use skip_prefix
 - check_filename(): refactor ":/" handling
 - t4208: add check for ":/" without matching file

 The convention for a command line is to follow "git cmdname
 --options" with revisions followed by an optional "--"
 disambiguator and then finally pathspecs.  When "--" is not there,
 we make sure early ones are all interpretable as revs (and do not
 look like paths) and later ones are the other way around.  A
 pathspec with "magic" (e.g. ":/p/a/t/h" that matches p/a/t/h from
 the top-level of the working tree, no matter what subdirectory you
 are working from) are conservatively judged as "not a path", which
 required disambiguation more often.  The command line parser
 learned to say "it's a pathspec" a bit more often when the syntax
 looks like so.


* sd/t3200-typofix (2017-05-29) 1 commit
  (merged to 'next' on 2017-05-30 at 784e5e73f8)
 + branch test: fix invalid config key access

 Test fix.

 Will merge to 'master'.


* mh/packed-ref-store-prep (2017-05-24) 26 commits
  (merged to 'next' on 2017-05-29 at e4f5e06b4c)
 + cache_ref_iterator_begin(): avoid priming unneeded directories
 + ref-filter: limit traversal to prefix
 + create_ref_entry(): remove `check_name` option
 + refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
 + read_packed_refs(): report unexpected fopen() failures
 + read_packed_refs(): do more of the work of reading packed refs
 + get_packed_ref_cache(): assume "packed-refs" won't change while locked
 + should_pack_ref(): new function, extracted from `files_pack_refs()`
 + ref_update_reject_duplicates(): add a sanity check
 + ref_update_reject_duplicates(): use `size_t` rather than `int`
 + ref_update_reject_duplicates(): expose function to whole refs module
 + ref_transaction_prepare(): new optional step for reference updates
 + ref_transaction_commit(): check for valid `transaction->state`
 + files_transaction_cleanup(): new helper function
 + files_ref_store: put the packed files lock directly in this struct
 + files-backend: move `lock` member to `files_ref_store`
 + lockfile: add a new method, is_lock_file_locked()
 + ref_store: take a `msg` parameter when deleting references
 + refs: use `size_t` indexes when iterating over ref transaction updates
 + refs_ref_iterator_begin(): don't check prefixes redundantly
 + prefix_ref_iterator: don't trim too much
 + files-backend: use `die("BUG: ...")`, not `die("internal error: ...")`
 + ref_iterator_begin_fn(): fix docstring
 + refs.h: clarify docstring for the ref_transaction_update()-related fns
 + t3600: clean up permissions test properly
 + Merge branch 'bc/object-id'

 The implementation of "ref" API around the "packed refs" have been
 cleaned up, in preparation for further changes.

 Will merge to 'master'.


* ab/sha1dc (2017-05-22) 2 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule
 (this branch uses ab/sha1dc-maint.)

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.

 Will keep in 'pu' for a few CI cycles.
 Impact to the various build and release infrastructure of using
 submodule is not yet fully known, but this lets us dip our toes.


* bp/fsmonitor (2017-06-02) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Waiting for discussion to settle.
 cf. <20170601155105.28356-1-benpeart@microsoft.com>


* sb/diff-color-move (2017-06-01) 17 commits
 - diff.c: color moved lines differently
 - diff: buffer all output if asked to
 - diff.c: emit_line includes whitespace highlighting
 - diff.c: convert diff_summary to use emit_line_*
 - diff.c: convert diff_flush to use emit_line_*
 - diff.c: convert word diffing to use emit_line_*
 - diff.c: convert show_stats to use emit_line_*
 - diff.c: convert emit_binary_diff_body to use emit_line_*
 - submodule.c: convert show_submodule_summary to use emit_line_fmt
 - diff.c: convert emit_rewrite_lines to use emit_line_*
 - diff.c: convert emit_rewrite_diff to use emit_line_*
 - diff.c: convert builtin_diff to use emit_line_*
 - diff.c: convert fn_out_consume to use emit_line
 - diff: introduce more flexible emit function
 - diff.c: factor out diff_flush_patch_all_file_pairs
 - diff: move line ending check into emit_hunk_header
 - diff: readability fix

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.


* xz/send-email-batch-size (2017-05-23) 1 commit
 - send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

 Waiting for response.
 cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>


* js/blame-lib (2017-05-25) 29 commits
  (merged to 'next' on 2017-05-30 at b4678b36a7)
 + blame: move entry prepend to libgit
 + blame: move scoreboard setup to libgit
 + blame: move scoreboard-related methods to libgit
 + blame: move fake-commit-related methods to libgit
 + blame: move origin-related methods to libgit
 + blame: move core structures to header
 + blame: create entry prepend function
 + blame: create scoreboard setup function
 + blame: create scoreboard init function
 + blame: rework methods that determine 'final' commit
 + blame: wrap blame_sort and compare_blame_final
 + blame: move progress updates to a scoreboard callback
 + blame: make sanity_check use a callback in scoreboard
 + blame: move no_whole_file_rename flag to scoreboard
 + blame: move xdl_opts flags to scoreboard
 + blame: move show_root flag to scoreboard
 + blame: move reverse flag to scoreboard
 + blame: move contents_from to scoreboard
 + blame: move copy/move thresholds to scoreboard
 + blame: move stat counters to scoreboard
 + blame: rename nth_line function
 + blame: rename ent_score function
 + blame: rename coalesce function
 + blame: rename origin-related functions
 + blame: rename scoreboard structure to blame_scoreboard
 + blame: rename origin structure to blame_origin
 + blame: remove unused parameters
 + blame: move textconv_object with related functions
 + blame: remove unneeded dependency on blob.h

 The internal logic used in "git blame" has been libified to make it
 easier to use by cgit.

 Will merge to 'master'.


* sg/clone-refspec-from-command-line-config (2017-06-01) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Are we happy with these two?


* jh/close-index-before-stat (2017-04-28) 1 commit
  (merged to 'next' on 2017-05-16 at 0c0372eb02)
 + read-cache: close index.lock in do_write_index

 Originally merged to 'next' on 2017-04-30

 The timestamp of the index file is now taken after the file is
 closed, to help Windows, on which a stale timestamp is reported by
 fstat() on a file that is opened for writing and data was written
 but not yet closed.

 Will merge to 'master'.


* mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
  (merged to 'next' on 2017-05-29 at 7645575e21)
 + add--interactive: drop diff.indentHeuristic handling
 + diff: enable indent heuristic by default
 + diff: have the diff-* builtins configure diff before initializing revisions
 + diff: make the indent heuristic part of diff's basic configuration

 Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
 configuration variable an escape hatch for those who do no want it.

 Will merge to 'master'.
 Looks like there may be follow-on work possible, but the topic
 itself is in good order.
 cf. <20170509033258.q7auj5p5lxs4tggd@sigill.intra.peff.net>


* nd/fopen-errors (2017-06-02) 13 commits
 - mingw_fopen: report ENOENT for invalid file names
 - mingw: verify that paths are not mistaken for remote nicknames
 - log: fix memory leak in open_next_file()
 - rerere.c: move error_errno() closer to the source system call
 - print errno when reporting a system call error
 - wrapper.c: make warn_on_inaccessible() static
 - wrapper.c: add and use fopen_or_warn()
 - wrapper.c: add and use warn_on_fopen_errors()
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 - clone: use xfopen() instead of fopen()
 - use xfopen() in more places
 - git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.

 Will merge to 'next'.


* js/rebase-i-final (2017-05-02) 10 commits
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

 Undecided; expecting a reroll.
 This is at its v4.
 cf. <cover.1493414945.git.johannes.schindelin@gmx.de>


* nd/prune-in-worktree (2017-04-24) 12 commits
 - rev-list: expose and document --single-worktree
 - revision.c: --reflog add HEAD reflog from all worktrees
 - files-backend: make reflog iterator go through per-worktree reflog
 - revision.c: --all adds HEAD from all worktrees
 - refs: remove dead for_each_*_submodule()
 - revision.c: use refs_for_each*() instead of for_each_*_submodule()
 - refs: add refs_head_ref()
 - refs: move submodule slash stripping code to get_submodule_ref_store
 - refs.c: refactor get_submodule_ref_store(), share common free block
 - revision.c: --indexed-objects add objects from all worktrees
 - revision.c: refactor add_index_objects_to_pending()
 - revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Expecting a reroll.
 Has been waiting for nd/worktree-kill-parse-ref to settle.
 cf. <CACsJy8ADCVBiLoPg_Tz0L6CMdh_eFmK4RYzfQ-PmUgBK7w9e=A@mail.gmail.com>

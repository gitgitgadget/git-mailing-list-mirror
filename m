Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8C7201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbdEPErH (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:47:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34464 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdEPErF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:47:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so18471504pfk.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=4WWXU+ErkDRbDnfAoMxdmz9tsboXMaCIail2NLHnQn8=;
        b=PTlrbIGh9/FZ+pCGd5QEA3fV2U2xN/aCxySN+q13+bHlpdcPBk6hjIvIxeepDNAjpu
         sGKOatGQCkpgLZqMRaQ5EX7VCtJt3+sWKTNnwRdPeU97GZ7cjCz6BffLxKlKOcZglEjS
         Fnrai8Py3R2qQVIDf4EqIPZaq+qikWqeKMcUCcL69gIbrsRZBFrmbHNTZo4zBTx9WR2C
         sqpaxIfyIWNF91fbOqjG1z7KAdXra5UMqvSNPw8Cn/3bCk/yM3QOa2i/OPZf8t/T5DXb
         qBIfz7f88fc8033nBG6ASBrZnrCE460TN5xoKBJAYyJLTDDMMgN7vwEh7z1tNNoOInRY
         DELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=4WWXU+ErkDRbDnfAoMxdmz9tsboXMaCIail2NLHnQn8=;
        b=pv/HOCAtBdx6nE1n3dLfvcdJjW5EiLl7tfFGEVQybzg+lDaE4YvR9p/P2kNXLxQfrX
         DLaljg2jvoS+TdhqpY1FisV0BrMmsP997dJo5wOujoyhHrh7IhYLXsRKOY2uhVujJTn2
         pXdeYE5RXBQqP3j3IqmPRVI0rDvZKNjTGJWIu97esBY/TH3kU5Qe3c9vx+kCG0gWbkkN
         4gLYNLCBiXpUr6pJU7O9YNMdkrhdIsakotEWAh43e/blaDcT4jYGirYpaiV8/sgOjBr4
         YCHVQbOGIxpZA1x0jw/js0af8t+UPSI4ZDYig7wmZG4fnD1z0E/jdGJvRbQy0iSjonKD
         VBjw==
X-Gm-Message-State: AODbwcAVI43qPD8CJnhWl8hGXHr8o7nu1gtwWuEg4jHGTdvCG/VOHrQr
        O8EGQl2xqf2Law==
X-Received: by 10.98.34.203 with SMTP id p72mr10186737pfj.118.1494910023405;
        Mon, 15 May 2017 21:47:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id j21sm22596198pfj.80.2017.05.15.21.47.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:47:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2017, #05; Tue, 16)
X-master-at: 10c78a162fa821ee85203165b805ff46be454091
X-next-at: 0c0372eb028443d4e8877a833f6afee01c842345
Date:   Tue, 16 May 2017 13:47:01 +0900
Message-ID: <xmqqa86d2yt6.fsf@gitster.mtv.corp.google.com>
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

The tip of 'next' has been rewound, and the first batch of topics
for the next release have been merged to 'master'.  I tentatively
wrote doen that this cycle will last for 11 weeks, completing at the
end of July.

Many topics are marked for 'next', but it is very possible that I
missed some recent discussions that should stop their current
incarnation to be merged and instead a replacement should be
queued.  Please holler if you see such entries.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/aix-needs-compat-regex (2017-05-04) 1 commit
  (merged to 'next' on 2017-05-09 at 881202b6bb)
 + config.mak.uname: set NO_REGEX=NeedsStartEnd on AIX

 Build fix.


* ab/clone-no-tags (2017-05-01) 3 commits
  (merged to 'next' on 2017-04-30 at 601649896a)
 + tests: rename a test having to do with shallow submodules
 + clone: add a --no-tags option to clone without tags
 + tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"

 "git clone" learned the "--no-tags" option not to fetch all tags
 initially, and also set up the tagopt not to follow any tags in
 subsequent fetches.


* bw/submodule-has-commits-update (2017-05-02) 6 commits
  (merged to 'next' on 2017-05-08 at 57267f2277)
 + submodule: refactor logic to determine changed submodules
 + submodule: improve submodule_has_commits()
 + submodule: change string_list changed_submodule_paths
 + submodule: remove add_oid_to_argv()
 + submodule: rename free_submodules_sha1s()
 + submodule: rename add_sha1_to_array()

 Code clean-up and duplicate removal.


* dt/gc-ignore-old-gc-logs (2017-04-24) 3 commits
  (merged to 'next' on 2017-04-26 at 4f4cab8368)
 + test-lib: retire $remove_trash variable
 + test-lib.sh: do not barf under --debug at the end of the test
 + test-lib: abort when can't remove trash directory

 Attempt to allow us notice "fishy" situation where we fail to
 remove the temporary directory used during the test.


* dt/raise-core-packed-git-limit (2017-04-20) 1 commit
  (merged to 'next' on 2017-04-26 at c72dd8c62f)
 + Increase core.packedGitLimit

 The default packed-git limit value has been raised on larger
 platforms to save "git fetch" from a (recoverable) failure while
 "gc" is running in parallel.


* jc/apply-fix-mismerge (2017-05-08) 1 commit
  (merged to 'next' on 2017-05-09 at e0b89532d0)
 + apply.c: fix whitespace-only mismerge

 Mismerge fix.


* jk/am-leakfix (2017-04-27) 3 commits
  (merged to 'next' on 2017-04-30 at 78becd7a96)
 + am: shorten ident_split variable name in get_commit_info()
 + am: simplify allocations in get_commit_info()
 + am: fix commit buffer leak in get_commit_info()

 The codepath in "git am" that is used when running "git rebase"
 leaked memory held for the log message of the commits being rebased.


* jk/no-null-sha1-in-cache-tree (2017-04-23) 1 commit
  (merged to 'next' on 2017-04-26 at 45fbe9d57d)
 + cache-tree: reject entries with null sha1

 Code to update the cache-tree has been tightened so that we won't
 accidentally write out any 0{40} entry in the tree object.


* jn/clone-add-empty-config-from-command-line (2017-05-02) 1 commit
  (merged to 'next' on 2017-05-09 at c56ac3f782)
 + clone: handle empty config values in -c

 "git clone --config var=val" is a way to populate the
 per-repository configuration file of the new repository, but it did
 not work well when val is an empty string.  This has been fixed.


* jn/credential-doc-on-clear (2017-05-02) 1 commit
  (merged to 'next' on 2017-05-09 at 96fa65d122)
 + credential doc: make multiple-helper behavior more prominent

 Doc update.


* js/larger-timestamps (2017-05-09) 9 commits
  (merged to 'next' on 2017-05-09 at ae0603fd3e)
 + archive-tar: fix a sparse 'constant too large' warning
  (merged to 'next' on 2017-04-28 at b56a0d38cd)
 + use uintmax_t for timestamps
 + date.c: abort if the system time cannot handle one of our timestamps
 + timestamp_t: a new data type for timestamps
 + PRItime: introduce a new "printf format" for timestamps
 + parse_timestamp(): specify explicitly where we parse timestamps
 + t0006 & t5000: skip "far in the future" test when time_t is too limited
 + t0006 & t5000: prepare for 64-bit timestamps
 + ref-filter: avoid using `unsigned long` for catch-all data type

 Some platforms have ulong that is smaller than time_t, and our
 historical use of ulong for timestamp would mean they cannot
 represent some timestamp that the platform allows.  Invent a
 separate and dedicated timestamp_t (so that we can distingiuish
 timestamps and a vanilla ulongs, which along is already a good
 move), and then declare uintmax_t is the type to be used as the
 timestamp_t.


* jt/use-trailer-api-in-commands (2017-04-26) 1 commit
  (merged to 'next' on 2017-04-30 at 006c8d7ebd)
 + sequencer: add newline before adding footers

 "git cherry-pick" and other uses of the sequencer machinery
 mishandled a trailer block whose last line is an incomplete line.
 This has been fixed so that an additional sign-off etc. are added
 after completing the existing incomplete line.


* ls/travis-doc-asciidoctor (2017-04-26) 4 commits
  (merged to 'next' on 2017-05-04 at 813ba54fc3)
 + travis-ci: check AsciiDoc/AsciiDoctor stderr output
  (merged to 'next' on 2017-04-19 at 359c32953b)
 + travis-ci: unset compiler for jobs that do not need one
 + travis-ci: parallelize documentation build
 + travis-ci: build documentation with AsciiDoc and Asciidoctor

 Travis CI gained a task to format the documentation with both
 AsciiDoc and AsciiDoctor.


* nd/worktree-kill-parse-ref (2017-04-24) 6 commits
  (merged to 'next' on 2017-04-26 at b8e40da709)
 + refs: kill set_worktree_head_symref()
 + worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 + refs: introduce get_worktree_ref_store()
 + refs: add REFS_STORE_ALL_CAPS
 + refs.c: make submodule ref store hashmap generic
 + environment.c: fix potential segfault by get_git_common_dir()
 (this branch is used by nd/prune-in-worktree.)

 "git gc" did not interact well with "git worktree"-managed
 per-worktree refs.


* rs/large-zip (2017-05-01) 7 commits
  (merged to 'next' on 2017-05-02 at a03574e49b)
 + t5004: require 64-bit support for big ZIP tests
 + archive-zip: set version field for big files correctly
  (merged to 'next' on 2017-04-26 at a6beab60f2)
 + archive-zip: support files bigger than 4GB
 + archive-zip: support archives bigger than 4GB
 + archive-zip: write ZIP dir entry directly to strbuf
 + archive-zip: use strbuf for ZIP directory
 + archive-zip: add tests for big ZIP archives

 "git archive --format=zip" learned to use zip64 extension when
 necessary to go beyond the 4GB limit.


* sk/status-short-branch-color-config (2017-04-28) 2 commits
  (merged to 'next' on 2017-04-30 at 2a7eb05d7b)
 + status: add color config slots for branch info in "--short --branch"
 + status: fix missing newline when comment chars are disabled

 The colors in which "git status --short --branch" showed the names
 of the current branch and its remote-tracking branch are now
 configurable.

--------------------------------------------------
[New Topics]

* ah/log-decorate-default-to-auto (2017-05-15) 1 commit
 - builtin/log: honor log.decorate

 Setting "log.decorate=false" in the configuration file did not take
 effect in v2.13, which has been corrected.

 Will merge to 'next'.


* jh/memihash-opt (2017-05-16) 5 commits
 - p0004: don't error out if test repo is too small
 - p0004: don't abort if multi-threaded is too slow
 - p0004: use test_perf
 - p0004: avoid using pipes
 - p0004: simplify calls of test-lazy-init-name-hash

 perf-test update.

 Will merge to 'next'.


* jk/bug-to-abort (2017-05-15) 3 commits
 - config: complain about --local outside of a git repo
 - setup_git_env: convert die("BUG") to BUG()
 - usage.c: add BUG() function

 Introduce the BUG() macro to improve die("BUG: ...").

 Will merge to 'next'.


* jk/no-looking-at-dotgit-outside-repo (2017-05-15) 1 commit
 - config: complain about --local outside of a git repo

 Will discard.
 Superseded by jk/bug-to-abort.


* jk/update-links-in-docs (2017-05-15) 1 commit
 - doc: use https links to Wikipedia to avoid http redirects

 A few http:// links that are redirected to https:// in the
 documentation have been updated to https:// links.

 Will merge to 'next'.


* js/blame-lib (2017-05-15) 22 commits
 - blame: create entry prepend function in libgit
 - blame: create scoreboard setup function in libgit
 - blame: create scoreboard init function in libgit
 - blame: move scoreboard-related methods to libgit
 - blame: move fake-commit-related methods to libgit
 - blame: move origin-related methods to libgit
 - blame: rework methods that determine 'final' commit
 - blame: wrap blame_sort and compare_blame_final
 - blame: move progess updates to a scoreboard callback
 - blame: make sanity_check use a callback in scoreboard
 - blame: move no_whole_file_rename flag to scoreboard
 - blame: move xdl_opts flags to scoreboard
 - blame: move show_root flag to scoreboard
 - blame: move reverse flag to scoreboard
 - blame: move contents_from to scoreboard
 - blame: move copy/move thresholds to scoreboard
 - blame: move stat counters to scoreboard
 - blame: move scoreboard structure to header
 - blame: move origin and entry structures to header
 - blame: remove unused parameters
 - blame: move textconv_object with related functions
 - blame: remove unneeded dependency on blob.h

 The internal logic used in "git blame" has been libified to make it
 easier to use by cgit.


* jt/send-email-validate-hook (2017-05-16) 1 commit
 - send-email: support validate hook

 "git send-email" learned to run sendemail-validate hook to inspect
 and reject a message before sending it out.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* mg/name-rev-debug (2017-03-31) 4 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Have been expecting a reroll of the tip two, but it has not seen
 any activity for too long.
 cf. <xmqqshltxnwt.fsf@gitster.mtv.corp.google.com>


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


* df/dir-iter-remove-subtree (2017-04-19) 5 commits
 - remove_subtree(): reimplement using iterators
 - dir_iterator: rewrite state machine model
 - dir_iterator: refactor dir_iterator_advance
 - remove_subtree(): test removing nested directories
 - dir_iterator: add tests for dir_iterator API

 Update the dir-iterator API and use it to reimplement
 remove_subtree().

 A reroll exists that is based on the updated 'master', but I ran
 out of time trying to get it to work with other topics in flight
 in 'pu'.
 GSoC microproject.


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 Expecting a reroll.


* sk/dash-is-previous (2017-03-01) 5 commits
 - revert.c: delegate handling of "-" shorthand to setup_revisions
 - sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 - revision.c: args starting with "-" might be a revision
 - revision.c: swap if/else blocks
 - revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Needs review.
 cf. <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>


--------------------------------------------------
[Cooking]

* bw/pathspec-sans-the-index (2017-05-12) 6 commits
 - pathspec: convert find_pathspecs_matching_against_index to take an index
 - pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
 - ls-files: prevent prune_cache from overeagerly pruning submodules
 - pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
 - submodule: add die_in_unpopulated_submodule function
 - pathspec: provide a more descriptive die message

 Simplify parse_pathspec() codepath and stop it from looking at the
 default in-core index.

 Will merge to 'next'.


* jt/fetch-allow-tip-sha1-implicitly (2017-05-16) 1 commit
 - fetch-pack: always allow fetching of literal SHA1s

 There is no good reason why "git fetch $there $sha1" should fail
 when the $sha1 names an object at the tip of an advertised ref,
 even when the other side hasn't enabled allowTipSHA1InWant.

 Will merge to 'next'.


* jc/read-tree-empty-with-m (2017-05-10) 1 commit
 - read-tree: "read-tree -m --empty" does not make sense

 "git read-tree -m" (no tree-ish) gave a nonsense suggestion "use
 --empty if you want to clear the index".  With "-m", such a request
 will still fail anyway, as you'd need to name at least one tree-ish
 to be merged.

 Will merge to 'next'.


* ab/perf-wildmatch (2017-05-12) 2 commits
 - perf: add test showing exponential growth in path globbing
 - perf: add function to setup a fresh test repo

 Add perf-test for wildmatch.

 Will merge to 'next'.


* jk/doc-config-include (2017-05-12) 4 commits
 - docs/config: consistify include.path examples
 - docs/config: avoid the term "expand" for includes
 - docs/config: give a relative includeIf example
 - docs/config: clarify include/includeIf relationship

 Clarify documentation for include.path and includeIf.<condition>.path
 configuration variables.

 Will merge to 'next'.


* js/retire-old-remote-spec (2017-05-12) 11 commits
 - PREVIEW: remove support for .git/remotes/ and .git/branches/
 - PREVIEW: t0060: stop testing support for .git/remotes/ and .git/branches/
 - PREVIEW: t5515: remove .git/remotes/ and .git/branches/ tests
 - PREVIEW: remote: remove support for migrating ancient remotes
 - PREVIEW: t5516: stop testing .git/branches/ functionality
 - PREVIEW: t5510: convert .git/remotes/ test to use a regular remote
 - Revert "Revert "Don't create the $GIT_DIR/branches directory on init""
 - remote: warn loud and clear when .git/remotes/ is *still* used
 - remote: warn loud and clear when .git/branches/ is *still* used
 - Documentation: really deprecate .git/remotes/ and .git/branches/
 - git-parse-remote: fix highly misleading man page

 Stop reading from .git/remotes/ and .git/branches/, two old ways
 that we have been supporting to configure short-hands for fetching
 from remote repositories.


* ab/grep-preparatory-cleanup (2017-05-15) 29 commits
 - grep: assert that threading is enabled when calling grep_{lock,unlock}
 - grep: given --threads with NO_PTHREADS=YesPlease, warn
 - pack-objects: fix buggy warning about threads
 - pack-objects & index-pack: add test for --threads warning
 - test-lib: add a PTHREADS prerequisite
 - grep: move is_fixed() earlier to avoid forward declaration
 - grep: change internal *pcre* variable & function names to be *pcre1*
 - grep: change the internal PCRE macro names to be PCRE1
 - grep: factor test for \0 in grep patterns into a function
 - grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
 - grep: remove redundant regflags assignment under PCRE
 - grep: catch a missing enum in switch statement
 - perf: add a performance comparison of fixed-string grep
 - perf: add a performance comparison test of grep -G, -E and -P
 - perf: emit progress output when unpacking & building
 - perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
 - grep: add tests to fix blind spots with \0 patterns
 - grep: prepare for testing binary regexes containing rx metacharacters
 - grep: add a test helper function for less verbose -f \0 tests
 - grep: add tests for grep pattern types being passed to submodules
 - grep: amend submodule recursion test for regex engine testing
 - grep: add tests for --threads=N and grep.threads
 - grep: change non-ASCII -i test to stop using --debug
 - grep: add a test for backreferences in PCRE patterns
 - grep: add a test asserting that --perl-regexp dies when !PCRE
 - log: add exhaustive tests for pattern style options & config
 - test-lib: rename the LIBPCRE prerequisite to PCRE
 - grep & rev-list doc: stop promising libpcre for --perl-regexp
 - Makefile & configure: reword inaccurate comment about PCRE

 The internal implementation of "git grep" has seen some clean-up.


* ab/compat-regex-update (2017-05-12) 3 commits
 - DONTMERGE compat/regex: make it compile with -Werror=int-to-pointer-cast
 - compat/regex: update the gawk regex engine from upstream
 - compat/regex: add a README with a maintenance guide

 Update compat/regex we borrowed from gawk.  It seems that some
 customizations we made to the older one were dropped by mistake.

 Will discard.
 cf. <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>


* jt/push-options-doc (2017-05-10) 2 commits
 - receive-pack: verify push options in cert
 - docs: correct receive.advertisePushOptions default

 The receive-pack program now makes sure that the push certificate
 records the same set of push options used for pushing.

 Will merge to 'next'.


* dt/unpack-save-untracked-cache-extension (2017-05-09) 1 commit
 - DONTMERGE: unpack-trees: preserve index extensions


* sg/clone-refspec-from-command-line-config (2017-05-16) 4 commits
 - clone: use free_refspec() to free refspec list
 - remote: drop free_refspecs() function
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.


* sb/checkout-recurse-submodules (2017-05-04) 3 commits
 - submodule: properly recurse for read-tree and checkout
 - submodule: avoid auto-discovery in new working tree manipulator code
 - submodule_move_head: reuse child_process structure for futher commands

 "git checkout --recurse-submodules" did not quite work with a
 submodule that itself has submodules.

 Will merge to 'next'.


* ja/do-not-ask-needless-questions (2017-05-12) 3 commits
 - git-filter-branch: be more direct in an error message
 - read-tree -m: make error message for merging 0 trees less smart aleck
 - usability: don't ask questions if no reply is required

 Git sometimes gives an advice in a rhetorical question that does
 not require an answer, which can confuse new users and non native
 speakers.  Attempt to rephrase them.

 Will merge to 'next'.


* ab/doc-replace-gmane-links (2017-05-09) 2 commits
 - doc: replace more gmane links
 - doc: replace a couple of broken gmane links

 The Web interface to gmane news archive is long gone, even though
 the articles are still accessible via NTTP.  Replace the links with
 ones to public-inbox.org.  Because their message identification is
 based on the actual message-id, it is likely that it will be easier
 to migrate away from it if/when necessary.

 Will merge to 'next'.


* ab/fix-poison-tests (2017-05-11) 3 commits
 - travis-ci: add job to run tests with GETTEXT_POISON
 - travis-ci: setup "prove cache" in "script" step
 - tests: fix tests broken under GETTEXT_POISON=YesPlease

 Update tests to pass under GETTEXT_POISON (a mechanism to ensure
 that output strings that should not be translated are not
 translated by mistake), and tell TravisCI to run them.

 Will merge to 'next'.


* bw/dir-c-stops-relying-on-the-index (2017-05-06) 14 commits
 - dir: convert fill_directory to take an index
 - dir: convert read_directory to take an index
 - dir: convert read_directory_recursive to take an index
 - dir: convert open_cached_dir to take an index
 - dir: convert is_excluded to take an index
 - dir: convert prep_exclude to take an index
 - dir: convert add_excludes to take an index
 - dir: convert is_excluded_from_list to take an index
 - dir: convert last_exclude_matching_from_list to take an index
 - dir: convert dir_add* to take an index
 - dir: convert get_dtype to take index
 - dir: convert directory_exists_in_index to take index
 - dir: convert read_skip_worktree_file_from_index to take an index
 - dir: stop using the index compatibility macros

 API update.

 Will merge to 'next'.


* jk/diff-submodule-diff-inline (2017-05-08) 1 commit
 - diff: recurse into nested submodules for inline diff

 "git diff --submodule=diff" now recurses into nested submodules.

 Will merge to 'next'.


* jk/disable-pack-reuse-when-broken (2017-05-09) 2 commits
 - t5310: fix "; do" style
 - pack-objects: disable pack reuse for object-selection options

 "pack-objects" can stream a slice of an existing packfile out when
 the pack bitmap can tell that the reachable objects are all needed
 in the output, without inspecting individual objects.  This
 strategy however would not work well when "--local" and other
 options are in use, and need to be disabled.

 Will merge to 'next'.


* js/eol-on-ourselves (2017-05-10) 6 commits
 - t4051: mark supporting files as requiring LF-only line endings
 - Fix the remaining tests that failed with core.autocrlf=true
 - t3901: move supporting files into t/t3901/
 - completion: mark bash script as LF-only
 - git-new-workdir: mark script as LF-only
 - Fix build with core.autocrlf=true

 Make sure our tests would pass when the sources are checked out
 with "platform native" line ending convention by default on
 Windows.  Some "text" files out tests use and the test scripts
 themselves that are meant to be run with /bin/sh, ought to be
 checked out with eol=LF even on Windows.

 Will merge to 'next'.


* nd/split-index-unshare (2017-05-08) 2 commits
 - p3400: add perf tests for rebasing many changes
 - split-index: add and use unshare_split_index()

 Plug some leaks and updates internal API used to implement the
 split index feature to make it easier to avoid such a leak in the
 future.

 Will merge to 'next'.


* rs/checkout-am-fix-unborn (2017-05-08) 2 commits
 - am: check return value of resolve_refdup before using hash
 - checkout: check return value of resolve_refdup before using hash

 A few codepaths in "checkout" and "am" working on an unborn branch
 tried to access an uninitialized piece of memory.

 Will merge to 'next'.


* bw/submodule-with-bs-path (2017-05-01) 1 commit
 - t7400: add !CYGWIN prerequisite to 'add with \\ in path'

 A hotfix to a topic that is already in v2.13.

 Will merge to 'next'.


* js/plug-leaks (2017-05-09) 26 commits
 - checkout: fix memory leak
 - submodule_uses_worktrees(): plug memory leak
 - show_worktree(): plug memory leak
 - name-rev: avoid leaking memory in the `deref` case
 - remote: plug memory leak in match_explicit()
 - add_reflog_for_walk: avoid memory leak
 - shallow: avoid memory leak
 - line-log: avoid memory leak
 - receive-pack: plug memory leak in update()
 - fast-export: avoid leaking memory in handle_tag()
 - mktree: plug memory leaks reported by Coverity
 - pack-redundant: plug memory leak
 - setup_discovered_git_dir(): plug memory leak
 - setup_bare_git_dir(): help static analysis
 - split_commit_in_progress(): simplify & fix memory leak
 - checkout: fix memory leak
 - cat-file: fix memory leak
 - mailinfo & mailsplit: check for EOF while parsing
 - status: close file descriptor after reading git-rebase-todo
 - difftool: address a couple of resource/memory leaks
 - get_mail_commit_oid(): avoid resource leak
 - git_config_rename_section_in_file(): avoid resource leak
 - add_commit_patch_id(): avoid allocating memory unnecessarily
 - winansi: avoid buffer overrun
 - winansi: avoid use of uninitialized value
 - mingw: avoid memory leak when splitting PATH

 Fix memory leaks pointed out by Coverity (and people).

 Will merge to 'next'.


* jh/close-index-before-stat (2017-04-28) 1 commit
  (merged to 'next' on 2017-05-16 at 0c0372eb02)
 + read-cache: close index.lock in do_write_index

 Originally merged to 'next' on 2017-04-30

 The timestamp of the index file is now taken after the file is
 closed, to help Windows, on which a stale timestamp is reported by
 fstat() on a file that is opened for writing and data was written
 but not yet closed.

 Will cook in 'next'.


* ls/travis-relays-for-windows-ci (2017-05-04) 2 commits
 - travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
 - travis-ci: handle Git for Windows CI status "failed" explicitly

 Will merge to 'next'.


* mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
 - add--interactive: drop diff.indentHeuristic handling
 - diff: enable indent heuristic by default
 - diff: have the diff-* builtins configure diff before initializing revisions
 - diff: make the indent heuristic part of diff's basic configuration

 Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
 configuration variable an escape hatch for those who do no want it.

 Kicked out of next; it seems it is still getting review suggestions?


* tb/dedup-crlf-tests (2017-05-10) 1 commit
 - t0027: tests are not expensive; remove t0025

 Will merge to 'next'.


* jc/repack-threads (2017-04-27) 1 commit
 - repack: accept --threads=<n> and pass it down to pack-objects

 "git repack" learned to accept the --threads=<n> option and pass it
 to pack-objects.

 Will merge to 'next'.


* nd/fopen-errors (2017-05-09) 23 commits
 - t1308: add a test case on open a config directory
 - config.c: handle error on failing to fopen()
 - xdiff-interface.c: report errno on failure to stat() or fopen()
 - wt-status.c: report error on failure to fopen()
 - server-info: report error on failure to fopen()
 - sequencer.c: report error on failure to fopen()
 - rerere.c: report correct errno
 - rerere.c: report error on failure to fopen()
 - remote.c: report error on failure to fopen()
 - commit.c: report error on failure to fopen() the graft file
 - log: fix memory leak in open_next_file()
 - log: report errno on failure to fopen() a file
 - blame: report error on open if graft_file is a directory
 - bisect: report on fopen() error
 - ident.c: use fopen_or_warn()
 - attr.c: use fopen_or_warn()
 - wrapper.c: add fopen_or_warn()
 - wrapper.c: add warn_on_fopen_errors()
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 - clone: use xfopen() instead of fopen()
 - Use xfopen() in more places
 - git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.


* bc/object-id (2017-05-08) 53 commits
 - object: convert parse_object* to take struct object_id
 - tree: convert parse_tree_indirect to struct object_id
 - sequencer: convert do_recursive_merge to struct object_id
 - diff-lib: convert do_diff_cache to struct object_id
 - builtin/ls-tree: convert to struct object_id
 - merge: convert checkout_fast_forward to struct object_id
 - sequencer: convert fast_forward_to to struct object_id
 - builtin/ls-files: convert overlay_tree_on_cache to object_id
 - builtin/read-tree: convert to struct object_id
 - sha1_name: convert internals of peel_onion to object_id
 - upload-pack: convert remaining parse_object callers to object_id
 - revision: convert remaining parse_object callers to object_id
 - revision: rename add_pending_sha1 to add_pending_oid
 - http-push: convert process_ls_object and descendants to object_id
 - refs/files-backend: convert many internals to struct object_id
 - refs: convert struct ref_update to use struct object_id
 - ref-filter: convert some static functions to struct object_id
 - Convert struct ref_array_item to struct object_id
 - Convert the verify_pack callback to struct object_id
 - Convert lookup_tag to struct object_id
 - log-tree: convert to struct object_id
 - Convert lookup_tree to struct object_id
 - builtin/reflog: convert tree_is_complete to take struct object_id
 - tree: convert read_tree_1 to use struct object_id internally
 - Convert lookup_blob to struct object_id
 - Convert remaining callers of lookup_blob to object_id
 - builtin/unpack-objects: convert to struct object_id
 - pack: convert struct pack_idx_entry to struct object_id
 - Convert lookup_commit* to struct object_id
 - Convert remaining callers of lookup_commit_reference* to object_id
 - builtin/tag: convert to struct object_id
 - sequencer: convert some functions to struct object_id
 - shallow: convert shallow registration functions to object_id
 - revision: convert prepare_show_merge to struct object_id
 - notes-utils: convert internals to struct object_id
 - http-push: convert some static functions to struct object_id
 - tag: convert parse_tag_buffer to struct object_id
 - builtin/verify-commit: convert to struct object_id
 - reflog_expire: convert to struct object_id
 - parse-options-cb: convert to struct object_id
 - notes-cache: convert to struct object_id
 - submodule: convert merge_submodule to use struct object_id
 - fast-import: convert to struct object_id
 - fast-import: convert internal structs to struct object_id
 - builtin/rev-parse: convert to struct object_id
 - builtin/blame: convert static function to struct object_id
 - branch: convert to struct object_id
 - bundle: convert to struct object_id
 - builtin/prune: convert to struct object_id
 - builtin/name-rev: convert to struct object_id
 - Convert struct cache_tree to use struct object_id
 - Clean up outstanding object_id transforms.
 - fetch-pack: convert to struct object_id

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'next'.


* jc/checkout-working-tree-only (2017-04-27) 1 commit
 - checkout: add --working-tree-only option

 "git checkout <tree-ish> <pathspec>" learned a variant that does
 not update the index when doing its thing.

 This was more of "the world could have been like this" illustration
 rather than a "let's make this change" proposal.  Unless people
 really want it, I am inclined to discard this topic.  Opinions?


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

 Needs review.


* bw/forking-and-threading (2017-05-15) 14 commits
 - usage.c: drop set_error_handle()
 - run-command: restrict PATH search to executable files
 - run-command: expose is_executable function
 - run-command: block signals between fork and execve
 - run-command: add note about forking and threading
 - run-command: handle dup2 and close errors in child
 - run-command: eliminate calls to error handling functions in child
 - run-command: don't die in child when duping /dev/null
 - run-command: prepare child environment before forking
 - string-list: add string_list_remove function
 - run-command: use the async-signal-safe execv instead of execvp
 - run-command: prepare command before forking
 - t0061: run_command executes scripts without a #! line
 - t5550: use write_script to generate post-update hook

 The "run-command" API implementation has been made more robust
 against dead-locking in a threaded environment.

 Will merge to 'next'.


* sb/reset-recurse-submodules (2017-04-23) 4 commits
 - builtin/reset: add --recurse-submodules switch
 - submodule.c: submodule_move_head works with broken submodules
 - submodule.c: uninitialized submodules are ignored in recursive commands
 - entry.c: submodule recursing: respect force flag correctly

 "git reset" learned "--recurse-submodules" option.

 Will merge to 'next'.


* bp/sub-process-convert-filter (2017-05-15) 11 commits
 - convert: update subprocess_read_status() to not die on EOF
 - sub-process: move sub-process functions into separate files
 - convert: rename reusable sub-process functions
 - convert: update generic functions to only use generic data structures
 - convert: separate generic structures and variables from the filter specific ones
 - convert: split start_multi_file_filter() into two separate functions
 - pkt-line: annotate packet_writel with LAST_ARG_MUST_BE_NULL
 - convert: move packet_write_line() into pkt-line as packet_writel()
 - pkt-line: add packet_read_line_gently()
 - pkt-line: fix packet_read_line() to handle len < 0 errors
 - convert: remove erroneous tests for errno == EPIPE

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.

 Will merge to 'next'.


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

--------------------------------------------------
[Discarded]

* ja/doc-l10n (2017-03-20) 3 commits
 . SQUASH???
 . l10n: add git-add.txt to localized man pages
 . l10n: introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.


* ab/grep-pcre-v2 (2017-05-02) 19 commits
 . Makefile & configure: make PCRE v2 the default PCRE implementation
 . grep: remove support for concurrent use of both PCRE v1 & v2
 . grep: add support for PCRE v2
 . grep: add support for the PCRE v1 JIT API
 . perf: add a performance comparison test of grep -E and -P
 . grep: change the internal PCRE code & header names to be PCRE1
 . grep: change the internal PCRE macro names to be PCRE1
 . test-lib: rename the LIBPCRE prerequisite to PCRE
 . grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
 . grep & rev-list doc: stop promising libpcre for --perl-regexp
 . log: add -P as a synonym for --perl-regexp
 . log: add exhaustive tests for pattern style options & config
 . grep: add a test for backreferences in PCRE patterns
 . Makefile & configure: reword outdated comment about PCRE
 . grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
 . grep: remove redundant regflags assignment under PCRE
 . grep: submodule-related case statements should die if new fields are added
 . grep: add tests for grep pattern types being passed to submodules
 . grep: amend submodule recursion test in preparation for rx engine testing

 PCRE2, which has an API different from and incompatible with PCRE,
 can now be chosen to support "grep -P -e '<pattern>'" and friends.

 Will be rerolled.


* ab/grep-threading-cleanup (2017-04-16) 8 commits
 . grep: given --threads with NO_PTHREADS=YesPlease, warn
 . pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
 . pack-object & index-pack: add test for --threads warning under NO_PTHREADS
 . tests: add a PTHREADS prerequisite
 . grep: skip pthreads overhead when using one thread
 . grep: don't redundantly compile throwaway patterns under threading
 . grep: add tests for --threads=N and grep.threads
 . grep: assert that threading is enabled when calling grep_{lock,unlock}

 Will be rerolled.


* pb/bisect (2017-02-18) 28 commits
 . fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: remove the dequote in bisect_start()
 . bisect--helper: retire `--bisect-auto-next` subcommand
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--bisect-write` subcommand
 . bisect--helper: `bisect_replay` shell function in C
 . bisect--helper: `bisect_log` shell function in C
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: `bisect_state` & `bisect_head` shell function in C
 . bisect--helper: `bisect_autostart` shell function in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 . t6030: no cleanup with bad merge base
 . bisect--helper: `bisect_start` shell function partially in C
 . bisect--helper: `get_terms` & `bisect_terms` shell function in C
 . bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: `check_and_set_terms` shell function in C
 . bisect--helper: `bisect_write` shell function in C
 . bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 . bisect--helper: `bisect_reset` shell function in C
 . wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 . t6030: explicitly test for bisection cleanup
 . bisect--helper: `bisect_clean_state` shell function in C
 . bisect--helper: `write_terms` shell function in C
 . bisect: rewrite `check_term_format` shell function in C
 . bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 It has been in the stalled state for too long.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


* jk/parse-options-no-no-no (2017-04-25) 2 commits
 . SQUASH???
 . parse-options: disallow double-negations of options starting with no-

 Command line options that begin with "--no-" (e.g. "--no-checkout"
 option of "git clone") can be negated by removing "--no-"; we
 historically also allowed prefixing an extra "no" to the option
 (e.g. "--no-no-checkout"), which made the command line look ugly
 and unusual.  This proposes to forbid it.

 While I agree there is no need to support "--no-no-checkout", this
 looks more like "if it looks ugly and unusual, you do not have to
 use it".


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

 This was surrected from a "to be discarded" pile, as from time to
 time people wonder about resumable clone that can be primed without
 bothering Git servers with dynamic packfile creation, and some
 people seem to think that the topic could serve as a useful
 building block for that goal.  But nothing seem to have happend.


* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 . grep: use '/' delimiter for paths
 . grep: only add delimiter if there isn't one already

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

 Nobody seems to be championing this change, after asked in all
 recent "What's cooking" report:
 "Is this good enough with known limitations?"


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 . diffcore-rename: allow easier debugging
 . diffcore-rename.c: add locate_rename_src()
 . diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

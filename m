Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E691F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 05:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJOFda (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 01:33:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63981 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfJOFda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 01:33:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5F3297D18;
        Tue, 15 Oct 2019 01:33:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=/
        x/VfP4PW6vKdn8hEos82JVZwbI=; b=Lm3aPML8jAgWAJ21OYyXMIgkNlIG9h+/z
        5E0acd1H6enXbmQIglzHP9uvdAF1/uZ6pXTQdaHokMByo58UrvXYE20QSjGJb9/a
        tyOyOojESEwOiPYSyzyNw6O5BFf+jirbMT49GDm4jCG0QlaFAlyPfIwSjNZqcgsa
        vsQEmWWPB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=PmC
        oGmBEu3mK1nQ3J8IrQ00zfkWJD37h15uMCJ16nTbdZZUunKOKIV/dHW0z3fnEpMt
        SVpNJ8kEC0yUFjk4VG7AmWod9c47KiBipnMx/xP9VuvjVBp/GP+Almq/zwJYfke+
        61mQUqCJke9YL80ExYyaibqWp8K3NmSfDTowYfBM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EB3697D17;
        Tue, 15 Oct 2019 01:33:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E3C697D15;
        Tue, 15 Oct 2019 01:33:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2019, #04; Tue, 15)
X-master-at: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
X-next-at: 75c0f4853af2bb694809b26e5840ced649a83e49
Date:   Tue, 15 Oct 2019 14:33:17 +0900
Message-ID: <xmqqh84abmjm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BC988F2-EF0D-11E9-ABF1-8D86F504CC47-77302942!pb-smtp21.pobox.com
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

* ab/pcre-jit-fixes (2019-08-19) 18 commits
  (merged to 'next' on 2019-10-04 at 2d55f2b470)
 + grep: under --debug, show whether PCRE JIT is enabled
 + grep: do not enter PCRE2_UTF mode on fixed matching
 + grep: stess test PCRE v2 on invalid UTF-8 data
 + grep: create a "is_fixed" member in "grep_pat"
 + grep: consistently use "p->fixed" in compile_regexp()
 + grep: stop using a custom JIT stack with PCRE v1
 + grep: stop "using" a custom JIT stack with PCRE v2
 + grep: remove overly paranoid BUG(...) code
 + grep: use PCRE v2 for optimized fixed-string search
 + grep: remove the kwset optimization
 + grep: drop support for \0 in --fixed-strings <pattern>
 + grep: make the behavior for NUL-byte in patterns sane
 + grep tests: move binary pattern tests into their own file
 + grep tests: move "grep binary" alongside the rest
 + grep: inline the return value of a function call used only once
 + t4210: skip more command-line encoding tests on MinGW
 + grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
 + log tests: test regex backends in "--encode=<enc>" tests
 (this branch is used by cb/pcre1-cleanup.)

 A few simplification and bugfixes to PCRE interface.


* ah/cleanups (2019-10-03) 4 commits
  (merged to 'next' on 2019-10-04 at 1345f09afb)
 + git_mkstemps_mode(): replace magic numbers with computed value
 + wrapper: use a loop instead of repetitive statements
 + diffcore-break: use a goto instead of a redundant if statement
 + commit-graph: remove a duplicate assignment

 Miscellaneous code clean-ups.


* am/t0028-utf16-tests (2019-09-28) 2 commits
  (merged to 'next' on 2019-10-09 at 453900a4e8)
 + t0028: add more tests
 + t0028: fix test for UTF-16-LE-BOM

 Test fixes.


* am/visual-studio-config-fix (2019-09-28) 1 commit
  (merged to 'next' on 2019-10-04 at 135d93143b)
 + contrib/buildsystems: fix Visual Studio Debug configuration

 Dev support.


* as/shallow-slab-use-fix (2019-10-02) 1 commit
  (merged to 'next' on 2019-10-04 at f3a22d2b18)
 + shallow.c: don't free unallocated slabs

 Correct code that tried to reference all entries in a sparse array
 of pointers by mistake.


* bc/object-id-part17 (2019-08-19) 26 commits
  (merged to 'next' on 2019-10-04 at b0460b0db2)
 + midx: switch to using the_hash_algo
 + builtin/show-index: replace sha1_to_hex
 + rerere: replace sha1_to_hex
 + builtin/receive-pack: replace sha1_to_hex
 + builtin/index-pack: replace sha1_to_hex
 + packfile: replace sha1_to_hex
 + wt-status: convert struct wt_status to object_id
 + cache: remove null_sha1
 + builtin/worktree: switch null_sha1 to null_oid
 + builtin/repack: write object IDs of the proper length
 + pack-write: use hash_to_hex when writing checksums
 + sequencer: convert to use the_hash_algo
 + bisect: switch to using the_hash_algo
 + sha1-lookup: switch hard-coded constants to the_hash_algo
 + config: use the_hash_algo in abbrev comparison
 + combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
 + bundle: switch to use the_hash_algo
 + connected: switch GIT_SHA1_HEXSZ to the_hash_algo
 + show-index: switch hard-coded constants to the_hash_algo
 + blame: remove needless comparison with GIT_SHA1_HEXSZ
 + builtin/rev-parse: switch to use the_hash_algo
 + builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
 + builtin/receive-pack: switch to use the_hash_algo
 + fetch-pack: use parse_oid_hex
 + patch-id: convert to use the_hash_algo
 + builtin/replace: make hash size independent

 Preparation for SHA-256 upgrade continues.


* cb/pcre1-cleanup (2019-08-26) 2 commits
  (merged to 'next' on 2019-10-04 at a2dd896ee8)
 + grep: refactor and simplify PCRE1 support
 + grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
 (this branch uses ab/pcre-jit-fixes.)

 PCRE fixes.


* dl/format-patch-doc-test-cleanup (2019-10-09) 1 commit
  (merged to 'next' on 2019-10-11 at 992da06f37)
 + t4014: treat rev-list output as the expected value
 (this branch is used by dl/format-patch-cover-from-desc.)

 test cleanup.


* dl/octopus-graph-bug (2019-10-04) 5 commits
  (merged to 'next' on 2019-10-07 at c6bc2fe4a0)
 + t4214: demonstrate octopus graph coloring failure
 + t4214: explicitly list tags in log
 + t4214: generate expect in their own test cases
 + t4214: use test_merge
 + test-lib: let test_merge() perform octopus merges

 "git log --graph" for an octopus merge is sometimes colored
 incorrectly, which is demonstrated and documented but not yet
 fixed.


* dl/rev-list-doc-cleanup (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 712594feb1)
 + git-rev-list.txt: prune options in synopsis

 Doc update.


* dl/t0000-skip-test-test (2019-10-09) 1 commit
  (merged to 'next' on 2019-10-11 at b210c1d1fa)
 + t0000: cover GIT_SKIP_TESTS blindspots

 test update.


* en/clean-nested-with-ignored (2019-10-02) 13 commits
  (merged to 'next' on 2019-10-03 at 969ec06cc7)
 + dir: special case check for the possibility that pathspec is NULL
  (merged to 'next' on 2019-09-30 at 778cc31eac)
 + clean: fix theoretical path corruption
 + clean: rewrap overly long line
 + clean: avoid removing untracked files in a nested git repository
 + clean: disambiguate the definition of -d
 + git-clean.txt: do not claim we will delete files with -n/--dry-run
 + dir: add commentary explaining match_pathspec_item's return value
 + dir: if our pathspec might match files under a dir, recurse into it
 + dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
 + dir: also check directories for matching pathspecs
 + dir: fix off-by-one error in match_pathspec_item
 + dir: fix typo in comment
 + t7300: add testcases showing failure to clean specified pathspecs

 "git clean" fixes.


* en/fast-imexport-nested-tags (2019-10-04) 8 commits
  (merged to 'next' on 2019-10-07 at 3e75779e10)
 + fast-export: handle nested tags
 + t9350: add tests for tags of things other than a commit
 + fast-export: allow user to request tags be marked with --mark-tags
 + fast-export: add support for --import-marks-if-exists
 + fast-import: add support for new 'alias' command
 + fast-import: allow tags to be identified by mark labels
 + fast-import: fix handling of deleted tags
 + fast-export: fix exporting a tag and nothing else

 Updates to fast-import/export.


* en/merge-recursive-cleanup (2019-10-08) 26 commits
  (merged to 'next' on 2019-10-09 at aab23cae2e)
 + merge-recursive: fix the fix to the diff3 common ancestor label
  (merged to 'next' on 2019-10-03 at 7b5a32726b)
 + merge-recursive: fix the diff3 common ancestor label for virtual commits
  (merged to 'next' on 2019-09-18 at f52cb08a14)
 + merge-recursive: alphabetize include list
 + merge-recursive: add sanity checks for relevant merge_options
 + merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
 + merge-recursive: split internal fields into a separate struct
 + merge-recursive: avoid losing output and leaking memory holding that output
 + merge-recursive: comment and reorder the merge_options fields
 + merge-recursive: consolidate unnecessary fields in merge_options
 + merge-recursive: move some definitions around to clean up the header
 + merge-recursive: rename merge_options argument to opt in header
 + merge-recursive: rename 'mrtree' to 'result_tree', for clarity
 + merge-recursive: use common name for ancestors/common/base_list
 + merge-recursive: fix some overly long lines
 + cache-tree: share code between functions writing an index as a tree
 + merge-recursive: don't force external callers to do our logging
 + merge-recursive: remove useless parameter in merge_trees()
 + merge-recursive: exit early if index != head
 + Ensure index matches head before invoking merge machinery, round N
 + merge-recursive: remove another implicit dependency on the_repository
 + merge-recursive: future-proof update_file_flags() against memory leaks
 + merge-recursive: introduce an enum for detect_directory_renames values
 + merge-recursive: provide a better label for diff3 common ancestor
 + merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
 + checkout: provide better conflict hunk description with detached HEAD
 + merge-recursive: be consistent with assert

 The merge-recursive machiery is one of the most complex parts of
 the system that accumulated cruft over time.  This large series
 cleans up the implementation quite a bit.


* ew/hashmap (2019-10-07) 20 commits
  (merged to 'next' on 2019-10-09 at 9b75b4ce73)
 + hashmap_entry: remove first member requirement from docs
 + hashmap: remove type arg from hashmap_{get,put,remove}_entry
 + OFFSETOF_VAR macro to simplify hashmap iterators
 + hashmap: introduce hashmap_free_entries
 + hashmap: hashmap_{put,remove} return hashmap_entry *
 + hashmap: use *_entry APIs for iteration
 + hashmap_cmp_fn takes hashmap_entry params
 + hashmap_get{,_from_hash} return "struct hashmap_entry *"
 + hashmap: use *_entry APIs to wrap container_of
 + hashmap_get_next returns "struct hashmap_entry *"
 + introduce container_of macro
 + hashmap_put takes "struct hashmap_entry *"
 + hashmap_remove takes "const struct hashmap_entry *"
 + hashmap_get takes "const struct hashmap_entry *"
 + hashmap_add takes "struct hashmap_entry *"
 + hashmap_get_next takes "const struct hashmap_entry *"
 + hashmap_entry_init takes "struct hashmap_entry *"
 + packfile: use hashmap_entry in delta_base_cache_entry
 + coccicheck: detect hashmap_entry.hash assignment
 + diff: use hashmap_entry_init on moved_entry.ent

 Code clean-up of the hashmap API, both users and implementation.


* gs/commit-graph-trace-with-cmd (2019-10-02) 1 commit
  (merged to 'next' on 2019-10-07 at 369df0e5cd)
 + commit-graph: emit trace2 cmd_mode for each sub-command

 Dev support.


* gs/sq-quote-buf-pretty (2019-10-08) 1 commit
  (merged to 'next' on 2019-10-11 at 2f7c00612b)
 + sq_quote_buf_pretty: don't drop empty arguments

 Pretty-printed command line formatter (used in e.g. reporting the
 command being run by the tracing API) had a bug that lost an
 argument that is an empty string, which has been corrected.


* jk/coc (2019-10-10) 2 commits
  (merged to 'next' on 2019-10-11 at 9765fd29c3)
 + CODE_OF_CONDUCT: mention individual project-leader emails
 + add a Code of Conduct document

 Code-of-conduct document.


* js/azure-pipelines-msvc (2019-10-06) 13 commits
  (merged to 'next' on 2019-10-07 at d5a3604dc6)
 + ci: also build and test with MS Visual Studio on Azure Pipelines
 + ci: really use shallow clones on Azure Pipelines
 + tests: let --immediate and --write-junit-xml play well together
 + test-tool run-command: learn to run (parts of) the testsuite
 + vcxproj: include more generated files
 + vcxproj: only copy `git-remote-http.exe` once it was built
 + msvc: work around a bug in GetEnvironmentVariable()
 + msvc: handle DEVELOPER=1
 + msvc: ignore some libraries when linking
 + compat/win32/path-utils.h: add #include guards
 + winansi: use FLEX_ARRAY to avoid compiler warning
 + msvc: avoid using minus operator on unsigned types
 + push: do not pretend to return `int` from `die_push_simple()`

 CI updates.


* js/diff-rename-force-stable-sort (2019-10-02) 2 commits
  (merged to 'next' on 2019-10-04 at e02d882510)
 + diffcore_rename(): use a stable sort
 + Move git_sort(), a stable sort, into into libgit.a

 The rename detection logic sorts a list of rename source candidates
 by similarity to pick the best candidate, which means that a tie
 between sources with the same similarity is broken by the original
 location in the original candidate list (which is sorted by path).
 Force the sorting by similarity done with a stable sort, which is
 not promised by system supplied qsort(3), to ensure consistent
 results across platforms.


* js/fetch-jobs (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at e798bac35d)
 + fetch: let --jobs=<n> parallelize --multiple, too

 "git fetch --jobs=<n>" allowed <n> parallel jobs when fetching
 submodules, but this did not apply to "git fetch --multiple" that
 fetches from multiple remote repositories.  It now does.


* js/mingw-spawn-with-spaces-in-path (2019-10-02) 1 commit
  (merged to 'next' on 2019-10-04 at 0fdb87dd53)
 + t0061: fix test for argv[0] with spaces (MINGW only)

 Test fix.


* js/range-diff-noprefix (2019-10-03) 1 commit
  (merged to 'next' on 2019-10-04 at 56cf767bdb)
 + range-diff: internally force `diff.noprefix=true`

 "git range-diff" segfaulted when diff.noprefix configuration was
 used, as it blindly expected the patch it internally generates to
 have the standard a/ and b/ prefixes.  The command now forces the
 internal patch to be built without any prefix, not to be affected
 by any end-user configuration.


* js/stash-apply-in-secondary-worktree (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at b3474c9c3d)
 + stash apply: report status correctly even in a worktree's subdirectory

 "git stash apply" in a subdirectory of a secondary worktree failed
 to access the worktree correctly, which has been corrected.


* js/trace2-cap-max-output-files (2019-10-05) 4 commits
  (merged to 'next' on 2019-10-09 at e8a126d880)
 + trace2: write discard message to sentinel files
 + trace2: discard new traces if target directory has too many files
 + docs: clarify trace2 version invariants
 + docs: mention trace2 target-dir mode in git-config

 The trace2 output, when sending them to files in a designated
 directory, can populate the directory with too many files; a
 mechanism is introduced to set the maximum number of files and
 discard further logs when the maximum is reached.


* js/trace2-fetch-push (2019-10-08) 3 commits
  (merged to 'next' on 2019-10-11 at 3a2bb143f8)
 + transport: push codepath can take arbitrary repository
  (merged to 'next' on 2019-10-04 at 1d63701064)
 + push: add trace2 instrumentation
 + fetch: add trace2 instrumentation

 Dev support.


* js/xdiffi-comment-updates (2019-10-09) 1 commit
  (merged to 'next' on 2019-10-11 at 157226cf3a)
 + xdiffi: fix typos and touch up comments

 Comment update.


* jt/push-avoid-lazy-fetch (2019-10-09) 1 commit
  (merged to 'next' on 2019-10-11 at b5efe1634a)
 + send-pack: never fetch when checking exclusions

 Performance hack.


* kt/add-i-progress (2019-10-04) 1 commit
  (merged to 'next' on 2019-10-07 at 00cf8fe076)
 + add -i: show progress counter in the prompt

 "git add -i" has been taught to show the total number of hunks and
 the hunks that has been processed so far when showing prompts.


* pm/p4-auto-delete-named-temporary (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 4f45be70f5)
 + git-p4: auto-delete named temporary file


* pw/rebase-i-show-HEAD-to-reword (2019-08-19) 3 commits
  (merged to 'next' on 2019-10-04 at ab3d7eeb72)
 + sequencer: simplify root commit creation
 + rebase -i: check for updated todo after squash and reword
 + rebase -i: always update HEAD before rewording
 (this branch is used by ra/rebase-i-more-options.)

 "git rebase -i" showed a wrong HEAD while "reword" open the editor.


* py/git-gui-has-maintainer (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 0945190c4c)
 + Documentation: update the location of the git-gui repo

 Doc update.


* rs/convert-fix-utf-without-dash (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 9d0e27b5c3)
 + convert: fix handling of dashless UTF prefix in validate_encoding()

 The code to skip "UTF" and "UTF-" prefix, when computing an advice
 message, did not work correctly when the prefix was "UTF", which
 has been fixed.


* rs/dedup-includes (2019-10-04) 1 commit
  (merged to 'next' on 2019-10-07 at 5a4fc44657)
 + treewide: remove duplicate #include directives

 Code cleanup.


* rs/test-remove-useless-debugging-cat (2019-10-07) 1 commit
  (merged to 'next' on 2019-10-07 at 6d8cb22a4f)
 + tests: remove "cat foo" before "test_i18ngrep bar foo"

 Code cleanup.


* sg/name-rev-cutoff-underflow-fix (2019-09-28) 1 commit
  (merged to 'next' on 2019-10-04 at 25e4436b3d)
 + name-rev: avoid cutoff timestamp underflow

 Integer arithmetic fix.


* tg/range-diff-output-update (2019-10-09) 1 commit
  (merged to 'next' on 2019-10-11 at fd8c5d7ec5)
 + range-diff: don't segfault with mode-only changes

 "git range-diff" failed to handle mode-only change, which has been
 corrected.


* tk/git-svn-trim-author-name (2019-09-28) 1 commit
  (merged to 'next' on 2019-10-04 at c1c619f7c4)
 + git-svn: trim leading and trailing whitespaces in author name

 The author names taken from SVN repositories may have extra leading
 or trailing whitespaces, which are now munged away.

--------------------------------------------------
[New Topics]

* ds/sparse-cone (2019-10-08) 17 commits
 . sparse-checkout: cone mode should not interact with .gitignore
 . sparse-checkout: write using lockfile
 . sparse-checkout: update working directory in-process
 . sparse-checkout: sanitize for nested folders
 . read-tree: show progress by default
 . unpack-trees: add progress to clear_ce_flags()
 . unpack-trees: hash less in cone mode
 . sparse-checkout: init and set in cone mode
 . sparse-checkout: use hashmaps for cone patterns
 . sparse-checkout: add 'cone' mode
 . trace2: add region in clear_ce_flags
 . sparse-checkout: create 'disable' subcommand
 . sparse-checkout: add '--stdin' option to set subcommand
 . sparse-checkout: 'set' subcommand
 . clone: add --sparse mode
 . sparse-checkout: create 'init' subcommand
 . sparse-checkout: create builtin with 'list' subcommand

 Management of sparsely checked-out working tree has gained a
 dedicated "sparse-checkout" command.

 Expecting a reroll on top of we/hashmap.
 The use of hashmap API does not work well with ew/hashmap updates
 and breaks build.


* wb/fsmonitor-bitmap-fix (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 1cc4091346)
 + fsmonitor: don't fill bitmap with entries to be removed

 A segfault fix.

 Will merge to 'master'.


* dl/compat-cleanup (2019-10-11) 1 commit
  (merged to 'next' on 2019-10-15 at 1ed99770ba)
 + pthread.h: manually align parameter lists

 Code formatting micronit fix.

 Will merge to 'master'.


* jj/stash-reset-only-toplevel (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 28f398daab)
 + stash: avoid recursive hard reset on submodules

 "git stash save" lost local changes to submodules, which has been
 corrected.

 Will merge to 'master'.


* js/doc-stash-save (2019-10-11) 1 commit
  (merged to 'next' on 2019-10-15 at e588bff32c)
 + doc(stash): clarify the description of `save`

 Doc clarification.

 Will merge to 'master'.


* ta/t1308-typofix (2019-10-11) 1 commit
  (merged to 'next' on 2019-10-15 at 0228b44688)
 + t1308-config-set: fix a test that has a typo

 Test fix.

 Will merge to 'master'.


* bb/compat-util-comment-fix (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at c15e45fe28)
 + git-compat-util: fix documentation syntax

 Code cleanup.

 Will merge to 'master'.


* bb/utf8-wcwidth-cleanup (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 92ba59e1d6)
 + utf8: use ARRAY_SIZE() in git_wcwidth()

 Code cleanup.

 Will merge to 'master'.


* bc/smart-http-atomic-push (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at effe020c20)
 + remote-curl: pass on atomic capability to remote side

 The atomic push over smart HTTP transport did not work, which has
 been corrected.

 Will merge to 'master'.


* dl/allow-running-cocci-verbosely (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 474dc9f86e)
 + Makefile: respect $(V) in %.cocci.patch target

 Dev support update.

 Will merge to 'master'.


* dl/format-patch-cover-from-desc (2019-10-15) 3 commits
 - format-patch: teach --cover-from-description option
 - format-patch: use enum variables
 - format-patch: change erroneous and condition

 The branch description ("git branch --edit-description") has been
 used to fill the body of the cover letters by the format-patch
 command; this has been enhanced so that the subject can also be
 filled.

 Expecting a reroll.


* en/merge-recursive-directory-rename-fixes (2019-10-12) 2 commits
  (merged to 'next' on 2019-10-15 at ebfdc3ff7b)
 + merge-recursive: fix merging a subdirectory into the root directory
 + merge-recursive: clean up get_renamed_dir_portion()

 A few glitches in the heuristic in merge-recursive to infer file
 movements based on movements of other files in the same directory
 have been corrected.

 Will merge to 'master'.


* jt/fetch-pack-record-refs-in-the-dot-promisor (2019-10-15) 1 commit
 - fetch-pack: write fetched refs to .promisor

 Debugging support for lazy cloning has been a bit improved.

 Will merge to 'next'.


* mb/clarify-zsh-completion-doc (2019-10-12) 1 commit
 - doc: Change zsh git completion file name

 The installation instruction for zsh completion script (in
 contrib/) has been a bit improved.

 Expecting a reroll.


* rs/column-use-utf8-strnwidth (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 3be15b4478)
 + column: use utf8_strnwidth() to strip out ANSI color escapes

 Code cleanup.

 Will merge to 'master'.


* rs/http-push-simplify (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 4abc29286c)
 + http-push: simplify deleting a list item

 Code cleanup.

 Will merge to 'master'.


* rs/remote-curl-use-argv-array (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 8d0375a874)
 + remote-curl: use argv_array in parse_push()

 Code cleanup.

 Will merge to 'master'.


* nr/diff-highlight-indent-fix (2019-10-15) 1 commit
 - diff-highlight: fix a whitespace nit

--------------------------------------------------
[Stalled]

* cb/pcre2-chartables-leakfix (2019-08-06) 3 commits
 - grep: avoid leak of chartables in PCRE2
 - grep: make PCRE2 aware of custom allocator
 - grep: make PCRE1 aware of custom allocator

 WIP (this is v3 which is rather old, where the last message in the
 discussion talks about v6 that has never been sent to the list).
 cf. <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>


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

* es/walken-tutorial (2019-10-12) 1 commit
 - documentation: add tutorial for object walking

 A tutorial on object enumeration.

 Will merge to 'next'.


* bc/hash-independent-tests-part-6 (2019-10-06) 15 commits
 - t4048: abstract away SHA-1-specific constants
 - t4045: make hash-size independent
 - t4044: update test to work with SHA-256
 - t4039: abstract away SHA-1-specific constants
 - t4038: abstract away SHA-1 specific constants
 - t4034: abstract away SHA-1-specific constants
 - t4027: make hash-size independent
 - t4015: abstract away SHA-1-specific constants
 - t4011: abstract away SHA-1-specific constants
 - t4010: abstract away SHA-1-specific constants
 - t3429: remove SHA1 annotation
 - t1305: avoid comparing extensions
 - rev-parse: add an --object-format option
 - t/oid-info: add empty tree and empty blob values
 - t/oid-info: allow looking up hash algorithm name

 Test updates to prepare for SHA-2 transition continues.

 May be rerolled.
 cf. <20191008194012.4s35pbwbh25rblhb@camp.crustytoothpaste.net>


* bw/format-patch-o-create-leading-dirs (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 93c9949b6a)
 + format-patch: create leading components of output directory

 "git format-patch -o <outdir>" did an equivalent of "mkdir <outdir>"
 not "mkdir -p <outdir>", which is being corrected.

 Will merge to 'master'.


* ag/sequencer-todo-updates (2019-10-08) 5 commits
 - sequencer: directly call pick_commits() from complete_action()
 - rebase: fill `squash_onto' in get_replay_opts()
 - sequencer: move the code writing total_nr on the disk to a new function
 - sequencer: update `done_nr' when skipping commands in a todo list
 - sequencer: update `total_nr' when adding an item to a todo list

 Reduce unnecessary reading of state variables back from the disk
 during sequener operation.

 Will merge to 'next'.


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


* jk/packfile-reuse-cleanup (2019-09-13) 10 commits
  (merged to 'next' on 2019-09-30 at dc60b31833)
 + pack-objects: improve partial packfile reuse
 + builtin/pack-objects: introduce obj_is_packed()
 + pack-objects: introduce pack.allowPackReuse
 + csum-file: introduce hashfile_total()
 + pack-bitmap: introduce bitmap_walk_contains()
 + pack-bitmap: don't rely on bitmap_git->reuse_objects
 + ewah/bitmap: always allocate 2 more words
 + ewah/bitmap: introduce bitmap_word_alloc()
 + packfile: expose get_delta_base()
 + builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.

 On hold until we give it a more thorough review.
 cf. <20191002155721.GD6116@sigill.intra.peff.net>


* js/builtin-add-i (2019-08-30) 11 commits
 . built-in add -i: implement the `help` command
 . built-in add -i: use color in the main loop
 . built-in add -i: support `?` (prompt help)
 . built-in add -i: show unique prefixes of the commands
 . Add a function to determine unique prefixes for a list of strings
 . built-in add -i: implement the main loop
 . built-in add -i: color the header in the `status` command
 . built-in add -i: refresh the index before running `status`
 . built-in add -i: implement the `status` command
 . diff: export diffstat interface
 . Start to implement a built-in version of `git add --interactive`

 The beginning of rewriting "git add -i" in C.

 On hold, waiting for tg/stash-refresh-index to work well with this.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* ra/rebase-i-more-options (2019-09-09) 6 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: allow callers of read_author_script() to ignore fields
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Needs to consider existing GIT_COMMITTER_DATE environment, etc.
 cf. <5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>

--------------------------------------------------
[Discarded]

* dl/remote-save-to-push (2018-12-11) 1 commit
 . remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.


* js/trace2-json-schema (2019-07-25) 3 commits
 . ci: run trace2 schema validation in the CI suite
 . trace2: add a schema validator for trace2 events
 . trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 Abandoned, at least for now.
 cf. <20190910182305.GA11186@google.com>


* pd/fetch-jobs (2019-08-13) 5 commits
 . fetch: make --jobs control submodules and remotes
 . fetch: add the --submodule-fetch-jobs option
 . fetch: add the fetch.jobs config key
 . fetch: add the "--fetch-jobs" option
 . fetch: rename max_children to max_children_for_submodules

 "git fetch --jobs" is getting taught to also run fetch jobs in
 parallel when fetching from multiple remote repositories.

 cf. <nycvar.QRO.7.76.6.1909111359150.5377@tvgsbejvaqbjf.bet>


* js/honor-cflags-in-hdr-check (2019-08-26) 1 commit
  (merged to 'next' on 2019-09-09 at fcd9ee9f1b)
 + hdr-check: make it work on Windows

 Build fix to make sure hdr-check is run with the same preprocessor
 macros predefined by the $(MAKE) procedure.

 Superseded by dl/honor-cflags-in-hdr-check series.


* dl/format-patch-cover-letter-subject (2019-09-05) 1 commit
 . format-patch: learn --infer-cover-subject option

 "git format-patch --cover-letter" learned to optionally use the
 first paragraph (typically a single-liner) of branch.*.description
 as the subject of the cover letter.

 Superseded by the dl/format-patch-cover-from desc topic.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 . SQUASH???
 . upload-pack: send part of packfile response as uri
 . fetch-pack: support more than one pack lockfile
 . upload-pack: refactor reading of pack-objects out
 . Documentation: add Packfile URIs design doc
 . Documentation: order protocol v2 sections
 . http-fetch: support fetching packfiles by URL
 . http: improve documentation of http_pack_request
 . http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).


* jc/format-patch-noclobber (2019-02-22) 1 commit
 . format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

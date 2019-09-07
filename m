Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F211F461
	for <e@80x24.org>; Sat,  7 Sep 2019 17:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405198AbfIGR1G (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 13:27:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58356 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404839AbfIGR1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 13:27:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2ED11974F;
        Sat,  7 Sep 2019 13:26:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=OQCeG67Wv9CMdSxi9CysUxNY8
        AY=; b=ayhTzWg3Q6I0P1lrn6Y6KBHdtDgPTKV166hHbtQrOheehS4bjr0g5vr4w
        5vKiefLr4/RctN8a1LGNwktXJKvHYljUukLQJTFaIMfqZhxtlHxSF732q7B7wuCk
        v9LMLgdCGWaS4kQHs3XqPM6WMTulG4x0vukC6NJ3/irN/CluSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=MJ9buAGGrraTMbUXr/F
        0nw4znSXjqm6na9w49tQDCxXy4H6byCDOKXjamf4x0Bhf/8TN+D56rSNn5YPNIkZ
        izcK0mntJm9TewcW2aa/kJySTz10Q5fNBqu/Bps7KIaX1czkoy0VNavjm6cPerCd
        CE+5cSlzaQYUZoh/l1BVU24Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA8C21974E;
        Sat,  7 Sep 2019 13:26:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F29E1974D;
        Sat,  7 Sep 2019 13:26:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2019, #01; Sat, 7)
X-master-at: 745f6812895b31c02b29bdfe4ae8e5498f776c26
X-next-at: c6a4ce50a0d24c7b512b564eacb00d0bf92b22e4
Date:   Sat, 07 Sep 2019 10:26:53 -0700
Message-ID: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF8CC444-D194-11E9-ACA1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'next' has been rewound.  A handful of topics that have
been in the stalled state need to be woken up, now the release is
over (or they can be dropped without prejudice, just to unclutter
the tree).  As I said in an earlier message somewhere, I'd prefer to
see the PCRE/JIT topics sorted out soonish.  =C3=86var?  Carlo?

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ar/mingw-run-external-with-non-ascii-path (2019-08-26) 1 commit
 - mingw: fix launching of externals from Unicode paths

 Windows update.

 Will merge to 'next'.


* cb/pcre1-cleanup (2019-08-26) 2 commits
 - grep: refactor and simplify PCRE1 support
 - grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
 (this branch uses ab/pcre-jit-fixes.)

 PCRE fixes.


* dl/complete-cherry-pick-revert-skip (2019-08-27) 3 commits
 - status: mention --skip for revert and cherry-pick
 - completion: add --skip for cherry-pick and revert
 - completion: merge options for cherry-pick and revert

 The command line completion support (in contrib/) learned about the
 "--skip" option of "git revert" and "git cherry-pick".

 Will merge to 'next'.


* ew/hashmap (2019-08-26) 11 commits
 - hashmap_get_next returns "struct hashmap_entry *"
 - introduce container_of macro
 - hashmap_put takes "struct hashmap_entry *"
 - hashmap_remove takes "const struct hashmap_entry *"
 - hashmap_get takes "const struct hashmap_entry *"
 - hashmap_add takes "struct hashmap_entry *"
 - hashmap_get_next takes "const struct hashmap_entry *"
 - hashmap_entry: detect improper initialization
 - hashmap_entry_init takes "struct hashmap_entry *"
 - packfile: use hashmap_entry in delta_base_cache_entry
 - diff: use hashmap_entry_init on moved_entry.ent

 Code clean-up of the hashmap API, both users and implementation.

 Will merge to 'next'.


* jk/fast-import-history-bugfix (2019-08-27) 2 commits
 - fast-import: duplicate into history rather than passing ownership
 - fast-import: duplicate parsed encoding string

 The memory ownership model of the "git fast-import" got
 straightened out.

 Will merge to 'next'.


* js/gitdir-at-unc-root (2019-08-26) 3 commits
 - setup_git_directory(): handle UNC root paths correctly
 - Fix .git/ discovery at the root of UNC shares
 - setup_git_directory(): handle UNC paths correctly

 On Windows, the root level of UNC share is now allowed to be used
 just like any other directory.

 Will merge to 'next'.


* js/honor-cflags-in-hdr-check (2019-08-26) 1 commit
 - hdr-check: make it work on Windows

 Build fix to make sure hdr-check is run with the same preprocessor
 macros predefined by the $(MAKE) procedure.

 Will merge to 'next'.


* mh/http-urlmatch-cleanup (2019-08-26) 1 commit
 - http: don't leak urlmatch_config.vars

 Leakfix.

 Will merge to 'next'.


* mh/notes-duplicate-entries (2019-08-26) 2 commits
 - notes: avoid potential use-after-free during insertion
 - notes: avoid leaking duplicate entries

 A few implementation fixes in the notes API.

 Will merge to 'next'.


* mh/release-commit-memory-fix (2019-08-26) 1 commit
 - commit: free the right buffer in release_commit_memory

 Leakfix.

 Will merge to 'next'.


* rs/strbuf-detach (2019-08-26) 2 commits
 - grep: use return value of strbuf_detach()
 - log-tree: always use return value of strbuf_detach()

 Straighten out the use of strbuf_detach() API function.

 Will merge to 'next'.


* rs/trace2-dst-warning (2019-08-26) 1 commit
 - trace2: use warning() directly in tr2_dst_malformed_warning()

 Code cleanup.

 Will merge to 'next'.


* sg/clean-nested-repo-with-ignored (2019-08-26) 1 commit
 - t7300-clean: demonstrate deleting nested repo with an ignored file bre=
akage

 A bug documentation.

 Will merge to 'next'.


* tb/banned-vsprintf-namefix (2019-08-26) 1 commit
 - banned.h: fix vsprintf()'s ban message

 Error message fix.

 Will merge to 'next'.


* tb/file-url-to-unc-path (2019-08-26) 1 commit
 - mingw: support UNC in git clone file://server/share/repo

 Windows update.

 Will merge to 'next'.


* dl/compat-cleanup (2019-09-05) 2 commits
 - compat/*.[ch]: remove extern from function declarations using spatch
 - mingw: apply array.cocci rule

 Code cleanup.

 Will merge to 'next'.


* dl/use-sq-from-test-lib (2019-09-06) 1 commit
 - t: use common $SQ variable

 Code cleanup.

 Will merge to 'next'.


* ds/commit-graph-on-fetch (2019-09-03) 1 commit
 - fetch: add fetch.writeCommitGraph config setting
 (this branch uses ds/feature-macros.)

 A configuration variable tells "git fetch" to write the commit
 graph after finishing.

 Will merge to 'next'.


* ds/include-exclude (2019-09-05) 5 commits
 - unpack-trees: rename 'is_excluded_from_list()'
 - treewide: rename 'exclude' methods to 'pattern'
 - treewide: rename 'EXCL_FLAG_' to 'PATTERN_FLAG_'
 - treewide: rename 'struct exclude_list' to 'struct pattern_list'
 - treewide: rename 'struct exclude' to 'struct path_pattern'
 (this branch uses md/list-objects-filter-combo.)

 The internal code originally invented for ".gitignore" processing
 got reshuffled and renamed to make it less tied to "excluding" and
 stress more that it is about "matching", as it has been reused for
 things like sparse checkout specification that want to check if a
 path is "included".

 Will merge to 'next'.


* dt/remote-helper-doc-re-lock-option (2019-08-30) 1 commit
 - clarify documentation for remote helpers

 Doc update.

 Will merge to 'next'.


* en/filter-branch-deprecation (2019-09-05) 3 commits
 - t9902: use a non-deprecated command for testing
 - Recommend git-filter-repo instead of git-filter-branch
 - t6006: simplify, fix, and optimize empty message test

 Start discouraging the use of "git filter-branch".

 Will merge to 'next'.


* en/merge-options-ff-and-friends (2019-09-01) 1 commit
 - merge-options.txt: clarify meaning of various ff-related options

 Doc update.

 Will merge to 'next'.


* jc/test-cleanup (2019-09-05) 2 commits
 - t3005: remove unused variable
 - t: use LF variable defined in the test harness

 Code cleanup.

 Will merge to 'next'.


* jk/misc-uninitialized-fixes (2019-09-06) 6 commits
 - pack-objects: drop packlist index_pos optimization
 - test-read-cache: drop namelen variable
 - diff-delta: set size out-parameter to 0 for NULL delta
 - bulk-checkin: zero-initialize hashfile_checkpoint
 - pack-objects: use object_id in packlist_alloc()
 - git-am: handle missing "author" when parsing commit

 Various fixes to codepaths gcc 9 had trouble following dataflow.

 Will merge to 'next'.


* js/partial-clone-sparse-blob (2019-08-30) 2 commits
 - list-objects-filter: handle unresolved sparse filter OID
 - list-objects-filter: only parse sparse OID when 'have_git_dir'

 Band-aid on "git clone --sparse:oid=3DX" that would hit BUG().

 Will merge to 'next'.


* js/visual-studio (2019-09-05) 1 commit
 - .gitignore: stop ignoring `.manifest` files

 Adjust .gitignore to unignore a path that we started to track.

 Will merge to 'next'.


* jt/cache-tree-avoid-lazy-fetch-during-merge (2019-09-03) 1 commit
 - cache-tree: do not lazy-fetch merge tree

 The cache-tree code has been taught to be less aggressive in
 attempting to see if a tree object it computed already exists in
 the repository.

 Expecting a clearified log message.


* ma/asciidoctor-refmiscinfo (2019-09-03) 2 commits
 - doc-diff: replace --cut-header-footer with --cut-footer
 - asciidoctor-extensions: provide `<refmiscinfo/>`

 Update support for Asciidoctor documentation toolchain.

 Will merge to 'next'.


* nd/switch-and-restore (2019-08-30) 1 commit
 - checkout: add simple check for 'git checkout -b'

 Resurrect a performance hack.

 Will merge to 'next'.


* rs/get-tagged-oid (2019-09-05) 2 commits
 - use get_tagged_oid()
 - tag: factor out get_tagged_oid()

 Code cleanup.

 Will merge to 'next'.


* rs/help-unknown-ref-does-not-return (2019-08-30) 1 commit
 - help: make help_unknown_ref() NORETURN

 Code cleanup.

 Will merge to 'next'.


* rs/parse-tree-indirect (2019-09-03) 1 commit
 - tree: simplify parse_tree_indirect()

 Code cleanup.

 Will merge to 'next'.


* sg/git-test-boolean (2019-09-06) 2 commits
 - ci: restore running httpd tests
 - t/lib-git-svn.sh: check GIT_TEST_SVN_HTTPD when running SVN HTTP tests

 Fix an earlier regression in the test suite, which mistakenly
 stopped running HTTPD tests.

 Will merge to 'next'.


* tg/push-all-in-mirror-forbidden (2019-09-03) 1 commit
 - push: disallow --all and refspecs when remote.<name>.mirror is set

 Fix an earlier regression to "git push --all" which should have
 been forbidden when the target remote repository is set to be a
 mirror.

 Will merge to 'next'.


* tg/stash-refresh-index (2019-09-05) 3 commits
 - stash: make sure to write refreshed cache
 - merge: use refresh_and_write_cache
 - factor out refresh_and_write_cache function

 "git stash" learned to write refreshed index back to disk.

 Needs coordination with js/builtin-add-i topic, as they both wants
 the same kind of enhancement to the same API function.

--------------------------------------------------
[Stalled]

* es/walken-tutorial (2019-08-07) 1 commit
 - documentation: add tutorial for revision walking

 A tutorial on object enumeration.

 Perhaps take the thing with as little tweaks as possible, retitling
 it to "my first object enumeration" or something?
 cf. <20190814183328.GA40797@google.com>


* dl/format-patch-cover-letter-subject (2019-09-05) 1 commit
 - format-patch: learn --infer-cover-subject option
 (this branch uses dl/format-patch-doc-test-cleanup.)

 "git format-patch --cover-letter" learned to optionally use the
 first paragraph (typically a single-liner) of branch.*.description
 as the subject of the cover letter.

 Reroll with a redesign with less emphasis on "subject" coming?


* bc/object-id-part17 (2019-08-19) 26 commits
 - midx: switch to using the_hash_algo
 - builtin/show-index: replace sha1_to_hex
 - rerere: replace sha1_to_hex
 - builtin/receive-pack: replace sha1_to_hex
 - builtin/index-pack: replace sha1_to_hex
 - packfile: replace sha1_to_hex
 - wt-status: convert struct wt_status to object_id
 - cache: remove null_sha1
 - builtin/worktree: switch null_sha1 to null_oid
 - builtin/repack: write object IDs of the proper length
 - pack-write: use hash_to_hex when writing checksums
 - sequencer: convert to use the_hash_algo
 - bisect: switch to using the_hash_algo
 - sha1-lookup: switch hard-coded constants to the_hash_algo
 - config: use the_hash_algo in abbrev comparison
 - combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
 - bundle: switch to use the_hash_algo
 - connected: switch GIT_SHA1_HEXSZ to the_hash_algo
 - show-index: switch hard-coded constants to the_hash_algo
 - blame: remove needless comparison with GIT_SHA1_HEXSZ
 - builtin/rev-parse: switch to use the_hash_algo
 - builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
 - builtin/receive-pack: switch to use the_hash_algo
 - fetch-pack: use parse_oid_hex
 - patch-id: convert to use the_hash_algo
 - builtin/replace: make hash size independent

 Preparation for SHA-256 upgrade continues.

 Looked mostly OK, with a possible update.
 cf. <20190820223606.GJ365197@genre.crustytoothpaste.net>


* mt/threaded-grep-in-object-store (2019-08-13) 4 commits
 - grep: re-enable threads in some non-worktree cases
 - grep: disable grep_read_mutex when possible
 - grep: allow locks to be enabled individually
 - object-store: add lock to read_object_file_extended()

 Traditionally, we avoided threaded grep while searching in objects
 (as opposed to files in the working tree) as accesses to the object
 layer is not thread-safe.  This limitation is getting lifted.

 Comments?
 cf. <cover.1565468806.git.matheus.bernardino@usp.br>




* pd/fetch-jobs (2019-08-13) 5 commits
 . fetch: make --jobs control submodules and remotes
 . fetch: add the --submodule-fetch-jobs option
 . fetch: add the fetch.jobs config key
 . fetch: add the "--fetch-jobs" option
 . fetch: rename max_children to max_children_for_submodules

 "git fetch --jobs" is getting taught to also run fetch jobs in
 parallel when fetching from multiple remote repositories.

 Comments?


* js/trace2-json-schema (2019-07-25) 3 commits
 . ci: run trace2 schema validation in the CI suite
 . trace2: add a schema validator for trace2 events
 . trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 The CI integration may be a bit too heavy-handed.


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
 <CAHk-=3DwhP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=3Dj3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.co=
m>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.

--------------------------------------------------
[Cooking]

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


* jt/avoid-ls-refs-with-http (2019-08-22) 2 commits
  (merged to 'next' on 2019-09-07 at c6a4ce50a0)
 + transport: teach all vtables to allow fetch first
 + transport-helper: skip ls-refs if unnecessary

 The http transport lacked some optimization the native transports
 learned to avoid unnecessary ref advertisement, which has been
 corrected.

 Will merge to 'master'.


* cb/curl-use-xmalloc (2019-08-15) 1 commit
  (merged to 'next' on 2019-09-07 at 07da24f51c)
 + http: use xmalloc with cURL
 (this branch uses jk/drop-release-pack-memory.)

 Tell cURL library to use the same malloc() implementation, with the
 xmalloc() wrapper, as the rest of the system, for consistency.

 Will merge to 'master'.


* sg/diff-indent-heuristic-non-experimental (2019-08-15) 1 commit
  (merged to 'next' on 2019-08-23 at faab5e2a1e)
 + diff: 'diff.indentHeuristic' is no longer experimental

 We promoted the "indent heuristics" that decides where to split
 diff hunks from experimental to the default a few years ago, but
 some stale documentation still marked it as experimental, which has
 been corrected.

 Will merge to 'master'.


* en/checkout-mismerge-fix (2019-08-16) 1 commit
  (merged to 'next' on 2019-08-23 at 8ecb69414a)
 + checkout: remove duplicate code

 Fix a mismerge that happened in 2.22 timeframe.

 Will merge to 'master'.


* en/merge-recursive-cleanup (2019-08-19) 24 commits
 - merge-recursive: alphabetize include list
 - merge-recursive: add sanity checks for relevant merge_options
 - merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
 - merge-recursive: split internal fields into a separate struct
 - merge-recursive: avoid losing output and leaking memory holding that o=
utput
 - merge-recursive: comment and reorder the merge_options fields
 - merge-recursive: consolidate unnecessary fields in merge_options
 - merge-recursive: move some definitions around to clean up the header
 - merge-recursive: rename merge_options argument to opt in header
 - merge-recursive: rename 'mrtree' to 'result_tree', for clarity
 - merge-recursive: use common name for ancestors/common/base_list
 - merge-recursive: fix some overly long lines
 - cache-tree: share code between functions writing an index as a tree
 - merge-recursive: don't force external callers to do our logging
 - merge-recursive: remove useless parameter in merge_trees()
 - merge-recursive: exit early if index !=3D head
 - Ensure index matches head before invoking merge machinery, round N
 - merge-recursive: remove another implicit dependency on the_repository
 - merge-recursive: future-proof update_file_flags() against memory leaks
 - merge-recursive: introduce an enum for detect_directory_renames values
 - merge-recursive: provide a better label for diff3 common ancestor
 - merge-recursive: enforce opt->ancestor !=3D NULL when calling merge_tr=
ees()
 - checkout: provide better conflict hunk description with detached HEAD
 - merge-recursive: be consistent with assert

 The merge-recursive machiery is one of the most complex parts of
 the system that accumulated cruft over time.  This large series
 cleans up the implementation quite a bit.

 Will merge to 'next'.


* bc/hash-independent-tests-part-5 (2019-08-26) 14 commits
 - t4009: make hash size independent
 - t4002: make hash independent
 - t4000: make hash size independent
 - t3903: abstract away SHA-1-specific constants
 - t3800: make hash-size independent
 - t3600: make hash size independent
 - t3506: make hash independent
 - t3430: avoid hard-coded object IDs
 - t3404: abstract away SHA-1-specific constants
 - t3306: abstract away SHA-1-specific constants
 - t3305: make hash size independent
 - t3301: abstract away SHA-1-specific constants
 - t3206: abstract away hash size constants
 - t3201: abstract away SHA-1-specific constants

 Preparation for SHA-256 upgrade continues in the test department.

 Will merge to 'next'.


* bm/repository-layout-typofix (2019-08-19) 1 commit
  (merged to 'next' on 2019-08-23 at 7b1fffbaea)
 + repository-layout.txt: correct pluralization of 'object'

 Typofix.

 Will merge to 'master'.


* bw/rebase-autostash-keep-current-branch (2019-09-07) 2 commits
 - builtin/rebase.c: Remove pointless message
 - builtin/rebase.c: make sure the active branch isn't moved when autosta=
shing

 "git rebase --autostash <upstream> <branch>", when <branch> is
 different from the current branch, incorrectly moved the tip of the
 current branch, which has been corrected.

 Will merge to 'next'.


* dl/format-patch-doc-test-cleanup (2019-09-05) 13 commits
 - config/format.txt: specify default value of format.coverLetter
 - Doc: add more detail for git-format-patch
 - t4014: stop losing return codes of git commands
 - t4014: remove confusing pipe in check_threading()
 - t4014: use test_line_count() where possible
 - t4014: let sed open its own files
 - t4014: drop redirections to /dev/null
 - t4014: use indentable here-docs
 - t4014: remove spaces after redirect operators
 - t4014: use sq for test case names
 - t4014: move closing sq onto its own line
 - t4014: s/expected/expect/
 - t4014: drop unnecessary blank lines from test cases
 (this branch is used by dl/format-patch-cover-letter-subject.)

 The documentation and tests for "git format-patch" have been
 cleaned up.

 Will merge to 'next'.


* ds/midx-expire-repack (2019-08-20) 1 commit
  (merged to 'next' on 2019-08-23 at a998356b3b)
 + packfile.h: drop extern from function declaration

 Code cleanup.

 Will merge to 'master'.


* jt/diff-lazy-fetch-submodule-fix (2019-08-20) 1 commit
  (merged to 'next' on 2019-08-23 at 16997cac26)
 + diff: skip GITLINK when lazy fetching missing objs

 On-demand object fetching in lazy clone incorrectly tried to fetch
 commits from submodule projects, while still working in the
 superproject, which has been corrected.

 Will merge to 'master'.


* mp/for-each-ref-missing-name-or-email (2019-08-22) 1 commit
  (merged to 'next' on 2019-08-23 at d257cb2138)
 + ref-filter: initialize empty name or email fields

 "for-each-ref" and friends that shows refs did not protect themselves
 against ancient tags that did not record tagger names when asked to
 show "%(taggername)", which have been corrected.

 Will merge to 'master'.


* nd/diff-parseopt (2019-08-20) 1 commit
  (merged to 'next' on 2019-08-23 at d80a83b1e4)
 + parseopt: move definition of enum parse_opt_result up

 Compilation fix.

 Will merge to 'master'.


* pw/rebase-i-show-HEAD-to-reword (2019-08-19) 3 commits
 - sequencer: simplify root commit creation
 - rebase -i: check for updated todo after squash and reword
 - rebase -i: always update HEAD before rewording

 "git rebase -i" showed a wrong HEAD while "reword" open the editor.

 May want to split out the last one into a separate topic.
 Will merge to 'next'.


* rs/pax-extended-header-length-fix (2019-08-19) 4 commits
  (merged to 'next' on 2019-08-23 at de88e8e58a)
 + archive-tar: turn length miscalculation warning into BUG
 + archive-tar: use size_t in strbuf_append_ext_header()
 + archive-tar: fix pax extended header length calculation
 + archive-tar: report wrong pax extended header length

 "git archive" recorded incorrect length in extended pax header in
 some corner cases, which has been corrected.

 Will merge to 'master'.


* rs/sort-oid-array-thread-safe (2019-08-20) 1 commit
  (merged to 'next' on 2019-08-23 at 5ce3126af2)
 + sha1-name: make sort_ambiguous_oid_array() thread-safe

 Prepare get_short_oid() codepath to be thread-safe.

 Will merge to 'master'.


* sb/userdiff-dts (2019-08-21) 1 commit
  (merged to 'next' on 2019-08-23 at 2bce0b8f91)
 + userdiff: add a builtin pattern for dts files

 Device-tree files learned their own userdiff patterns.

 Will merge to 'master'.


* sg/line-log-tree-diff-optim (2019-08-21) 2 commits
  (merged to 'next' on 2019-09-07 at 8d5b7053fd)
 + line-log: avoid unnecessary full tree diffs
 + line-log: extract pathspec parsing from line ranges into a helper func=
tion

 Optimize unnecessary full-tree diff away from "git log -L" machinery.

 Will merge to 'master'.


* tg/t0021-racefix (2019-08-22) 1 commit
  (merged to 'next' on 2019-08-23 at 0a3290393f)
 + t0021: make sure clean filter runs

 A test fix.

 Will merge to 'master'.


* py/git-gui-do-quit (2019-08-07) 2 commits
  (merged to 'next' on 2019-08-23 at 6544c9dbb3)
 + Merge branch 'py/call-do-quit-before-exit' of github.com:gitster/git-g=
ui into py/git-gui-do-quit
 + git-gui: call do_quit before destroying the main window

 "git gui" learned to call the clean-up procedure before exiting.

 Will merge to 'master'.


* bc/reread-attributes-during-rebase (2019-09-03) 2 commits
  (merged to 'next' on 2019-09-07 at 9f5e5db0b0)
 + am: reload .gitattributes after patching it
 + path: add a function to check for path suffix

 The "git am" based backend of "git rebase" ignored the result of
 updating ".gitattributes" done in one step when replaying
 subsequent steps.

 Will merge to 'master'.


* jk/drop-release-pack-memory (2019-08-13) 1 commit
  (merged to 'next' on 2019-09-07 at 30f841c42d)
 + packfile: drop release_pack_memory()
 (this branch is used by cb/curl-use-xmalloc.)

 xmalloc() used to have a mechanism to ditch memory and address
 space resources as the last resort upon seeing an allocation
 failure from the underlying malloc(), which made the code complex
 and thread-unsafe with dubious benefit, as major memory resource
 users already do limit their uses with various other mechanisms.
 It has been simplified away.

 Will merge to 'master'.


* sg/complete-configuration-variables (2019-08-13) 11 commits
  (merged to 'next' on 2019-09-07 at 9921f0e536)
 + completion: complete config variables and values for 'git clone --conf=
ig=3D'
 + completion: complete config variables names and values for 'git clone =
-c'
 + completion: complete values of configuration variables after 'git -c v=
ar=3D'
 + completion: complete configuration sections and variable names for 'gi=
t -c'
 + completion: split _git_config()
 + completion: simplify inner 'case' pattern in __gitcomp()
 + completion: use 'sort -u' to deduplicate config variable names
 + completion: deduplicate configuration sections
 + completion: add tests for 'git config' completion
 + completion: complete more values of more 'color.*' configuration varia=
bles
 + completion: fix a typo in a comment

 Command line completion updates for "git -c var.name=3Dval"

 Will merge to 'master'.


* cb/fetch-set-upstream (2019-08-19) 1 commit
  (merged to 'next' on 2019-08-23 at cf8c2ea0a0)
 + pull, fetch: add --set-upstream option

 "git fetch" learned "--set-upstream" option to help those who first
 clone from their private fork they intend to push to, add the true
 upstream via "git remote add" and then "git fetch" from it.

 Will merge to 'master'.


* js/pre-merge-commit-hook (2019-08-07) 4 commits
  (merged to 'next' on 2019-09-07 at 0c9f25399c)
 + merge: --no-verify to bypass pre-merge-commit hook
 + git-merge: honor pre-merge-commit hook
 + merge: do no-verify like commit
 + t7503: verify proper hook execution

 A new "pre-merge-commit" hook has been introduced.

 Will merge to 'master'.


* jk/eoo (2019-08-06) 3 commits
  (merged to 'next' on 2019-08-23 at 217e97127a)
 + gitcli: document --end-of-options
 + parse-options: allow --end-of-options as a synonym for "--"
 + revision: allow --end-of-options to end option parsing

 The command line parser learned "--end-of-options" notation; the
 standard convention for scripters to have hardcoded set of options
 first on the command line, and force the command to treat end-user
 input as non-options, has been to use "--" as the delimiter, but
 that would not work for commands that use "--" as a delimiter
 between revs and pathspec.

 Will merge to 'master'.


* jk/repo-init-cleanup (2019-08-06) 3 commits
  (merged to 'next' on 2019-08-23 at 1a5e4c4f06)
 + config: stop checking whether the_repository is NULL
 + common-main: delay trace2 initialization
 + t1309: use short branch name in includeIf.onbranch test

 Further clean-up of the initialization code.

 Will merge to 'master'.


* cb/pcre2-chartables-leakfix (2019-08-06) 3 commits
 - grep: avoid leak of chartables in PCRE2
 - grep: make PCRE2 aware of custom allocator
 - grep: make PCRE1 aware of custom allocator

 WIP.


* jh/trace2-pretty-output (2019-08-09) 7 commits
 - trace2: cleanup whitespace in perf format
 - trace2: cleanup whitespace in normal format
 - quote: add sq_append_quote_argv_pretty()
 - trace2: trim trailing whitespace in normal format error message
 - trace2: remove dead code in maybe_add_string_va()
 - trace2: trim whitespace in region messages in perf target format
 - trace2: cleanup column alignment in perf target format

 Output from trace2 subsystem is formatted more prettily now.

 Will merge to 'next'.


* ds/feature-macros (2019-08-13) 6 commits
  (merged to 'next' on 2019-08-23 at 115f0c8df9)
 + repo-settings: create feature.experimental setting
 + repo-settings: create feature.manyFiles setting
 + repo-settings: parse core.untrackedCache
 + commit-graph: turn on commit-graph by default
 + t6501: use 'git gc' in quiet mode
 + repo-settings: consolidate some config settings
 (this branch is used by ds/commit-graph-on-fetch.)

 A mechanism to affect the default setting for a (related) group of
 configuration variables is introduced.

 Will merge to 'master'.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* ra/rebase-i-more-options (2019-08-20) 6 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: add NULL checks under read_author_script
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Looking good.


* js/rebase-r-strategy (2019-09-05) 17 commits
  (merged to 'next' on 2019-09-07 at 71e2451f6c)
 + t3427: accelerate this test by using fast-export and fast-import
 + rebase -r: do not (re-)generate root commits with `--root` *and* `--on=
to`
 + t3418: test `rebase -r` with merge strategies
 + t/lib-rebase: prepare for testing `git rebase --rebase-merges`
 + rebase -r: support merge strategies other than `recursive`
 + t3427: fix another incorrect assumption
 + t3427: accommodate for the `rebase --merge` backend having been replac=
ed
 + t3427: fix erroneous assumption
 + t3427: condense the unnecessarily repetitive test cases into three
 + t3427: move the `filter-branch` invocation into the `setup` case
 + t3427: simplify the `setup` test case significantly
 + t3427: add a clarifying comment
 + rebase: fold git-rebase--common into the -p backend
 + sequencer: the `am` and `rebase--interactive` scripts are gone
 + .gitignore: there is no longer a built-in `git-rebase--interactive`
 + t3400: stop referring to the scripted rebase
 + Drop unused git-rebase--am.sh

 "git rebase --rebase-merges" learned to drive different merge
 strategies and pass strategy specific options to them.

 Will merge to 'master'.


* ab/pcre-jit-fixes (2019-08-19) 18 commits
 - grep: under --debug, show whether PCRE JIT is enabled
 - grep: do not enter PCRE2_UTF mode on fixed matching
 - grep: stess test PCRE v2 on invalid UTF-8 data
 - grep: create a "is_fixed" member in "grep_pat"
 - grep: consistently use "p->fixed" in compile_regexp()
 - grep: stop using a custom JIT stack with PCRE v1
 - grep: stop "using" a custom JIT stack with PCRE v2
 - grep: remove overly paranoid BUG(...) code
 - grep: use PCRE v2 for optimized fixed-string search
 - grep: remove the kwset optimization
 - grep: drop support for \0 in --fixed-strings <pattern>
 - grep: make the behavior for NUL-byte in patterns sane
 - grep tests: move binary pattern tests into their own file
 - grep tests: move "grep binary" alongside the rest
 - grep: inline the return value of a function call used only once
 - t4210: skip more command-line encoding tests on MinGW
 - grep: don't use PCRE2?_UTF8 with "log --encoding=3D<non-utf8>"
 - log tests: test regex backends in "--encode=3D<enc>" tests
 (this branch is used by cb/pcre1-cleanup.)

 A few simplification and bugfixes to PCRE interface.


* md/list-objects-filter-combo (2019-06-28) 10 commits
  (merged to 'next' on 2019-09-07 at 076a48aa57)
 + list-objects-filter-options: make parser void
 + list-objects-filter-options: clean up use of ALLOC_GROW
 + list-objects-filter-options: allow mult. --filter
 + strbuf: give URL-encoding API a char predicate fn
 + list-objects-filter-options: make filter_spec a string_list
 + list-objects-filter-options: move error check up
 + list-objects-filter: implement composite filters
 + list-objects-filter-options: always supply *errbuf
 + list-objects-filter: put omits set in filter struct
 + list-objects-filter: encapsulate filter components
 (this branch is used by ds/include-exclude.)

 The list-objects-filter API (used to create a sparse/lazy clone)
 learned to take a combined filter specification.

 Will merge to 'master'.


* cc/multi-promisor (2019-06-25) 15 commits
  (merged to 'next' on 2019-09-07 at 46faa86955)
 + Move core_partial_clone_filter_default to promisor-remote.c
 + Move repository_format_partial_clone to promisor-remote.c
 + Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 + remote: add promisor and partial clone config to the doc
 + partial-clone: add multiple remotes in the doc
 + t0410: test fetching from many promisor remotes
 + builtin/fetch: remove unique promisor remote limitation
 + promisor-remote: parse remote.*.partialclonefilter
 + Use promisor_remote_get_direct() and has_promisor_remote()
 + promisor-remote: use repository_format_partial_clone
 + promisor-remote: add promisor_remote_reinit()
 + promisor-remote: implement promisor_remote_get_direct()
 + Add initial support for many promisor remotes
 + fetch-object: make functions return an error code
 + t0410: remove pipes after git commands

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 Will merge to 'master'.


* dl/rebase-i-keep-base (2019-08-27) 9 commits
 - rebase: teach rebase --keep-base
 - rebase tests: test linear branch topology
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test for --no-ff's interaction with fast-forward
 - t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 Will merge to 'next'.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will discard.



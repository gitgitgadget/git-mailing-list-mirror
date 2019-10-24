Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C99E1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 06:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437668AbfJXGBR (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 02:01:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56108 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437663AbfJXGBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 02:01:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21EDE1E31F;
        Thu, 24 Oct 2019 02:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=I
        2w02bvUZ0gqebF/AqOiebUjAAk=; b=HjwkjugjdpCmFV97yeES+npeKiV2iV6sk
        U4omlerIhA+9Z5qFGoo1CLr7Ct19N1FbFP+2c2RP1PnPirOdnumQtODrp7MobiN3
        RFyobQRvBDcl5/flGUdVfiGJs1UPHOkQXKADeJj3RothfTpyRSg3xR4qt7fIwYLW
        YTd2Kdr7AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=on/
        1uTQwwhrn1Ct/X9E3qJAeKVVyEXhDnZ+M+uJ+YUE2JeBZtc9eC7nIOvpGSgifS8M
        IzqG0sjZNNS1k/ZlF2ktF9wKjmNC/XQKzE4twu88wieUWG76JmWE4Rhl+W3TN/w5
        G7k7Ss98UaThVYyXhPG7sdISFJyp6UNck2TfkgT0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13FB01E31A;
        Thu, 24 Oct 2019 02:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 323891E318;
        Thu, 24 Oct 2019 02:01:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2019, #06; Thu, 24)
X-master-at: 566a1439f6f56c2171b8853ddbca0ad3f5098770
X-next-at: b1bccd3e3df55f279f5b5f202ffa7149543587de
Date:   Thu, 24 Oct 2019 15:01:08 +0900
Message-ID: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD407844-F623-11E9-9E9D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The first release candidate has been tagged on the 'master' front.
We probably would want to include ds/commit-graph-on-fetch fixup
(which is not in 'next' yet) in the upcoming release, but other than
that, this should be very close to the final one, I hope ;-)

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/smart-http-atomic-push (2019-10-17) 1 commit
  (merged to 'next' on 2019-10-18 at 7729d13f51)
 + remote-curl: pass on atomic capability to remote side

 The atomic push over smart HTTP transport did not work, which has
 been corrected.


* bw/format-patch-o-create-leading-dirs (2019-10-23) 1 commit
  (merged to 'next' on 2019-10-23 at 9204e1b2b9)
 + t4014: make output-directory tests self-contained

 Test update.


* cb/pcre2-chartables-leakfix (2019-10-18) 3 commits
  (merged to 'next' on 2019-10-18 at 5bc67c64fd)
 + grep: avoid leak of chartables in PCRE2
 + grep: make PCRE2 aware of custom allocator
 + grep: make PCRE1 aware of custom allocator

 Leakfix.


* dl/submodule-set-branch (2019-10-23) 1 commit
  (merged to 'next' on 2019-10-23 at bb485c040f)
 + t7419: change test_must_fail to ! for grep

 Test update.


* ds/feature-macros (2019-10-24) 1 commit
  (merged to 'next' on 2019-10-24 at 9c74bfb14c)
 + repo-settings: read an int for index.version

 The codepath that reads the index.version configuration was broken
 with a recent update, which has been corrected.


* js/azure-ci-osx-fix (2019-10-23) 1 commit
  (merged to 'next' on 2019-10-23 at c7fcd4f8b6)
 + ci(osx): use new location of the `perforce` cask

 Update installation procedure for Perforce on MacOS in the CI jobs
 running on Azure pipelines, which was failing.


* mb/clarify-zsh-completion-doc (2019-10-18) 1 commit
  (merged to 'next' on 2019-10-21 at 21a4eb2fe8)
 + completion: clarify installation instruction for zsh

 The installation instruction for zsh completion script (in
 contrib/) has been a bit improved.


* nr/diff-highlight-indent-fix (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-21 at 8ce6000ec5)
 + diff-highlight: fix a whitespace nit

 Code cleanup.


* sb/userdiff-dts (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-21 at eafa01fb62)
 + userdiff: fix some corner cases in dts regex

 Tweak userdiff patterns for dts.
 As adding finishing touches to the new feature in the upcoming
 release, this is fast-tracked.


* sg/ci-osx-gcc8-fix (2019-10-24) 1 commit
  (merged to 'next' on 2019-10-24 at 58039e24ec)
 + ci: fix GCC install in the Travis CI GCC OSX job

 CI build fix.


* sg/progress-fix (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-21 at 678e344b22)
 + test-progress: fix test failures on big-endian systems

 Byte-order fix the recent update to progress display code.
 The breakage being fixed is a regression since the last relesae.


* wb/fsmonitor-bitmap-fix (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 1cc4091346)
 + fsmonitor: don't fill bitmap with entries to be removed

 A segfault fix.

--------------------------------------------------
[New Topics]

* hv/bitshift-constants-in-blame (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-24 at bc84aae4d4)
 + builtin/blame.c: constants into bit shift format

 Move the definition of a set of bitmask constants from 0ctal
 literal to (1U<<count) notation.

 Will cook in 'next'.


* jk/cleanup-object-parsing-and-fsck (2019-10-21) 23 commits
 - fsck: accept an oid instead of a "struct tree" for fsck_tree()
 - fsck: accept an oid instead of a "struct commit" for fsck_commit()
 - fsck: accept an oid instead of a "struct tag" for fsck_tag()
 - fsck: rename vague "oid" local variables
 - fsck: don't require an object struct in verify_headers()
 - fsck: don't require an object struct for fsck_ident()
 - fsck: drop blob struct from fsck_finish()
 - fsck: accept an oid instead of a "struct blob" for fsck_blob()
 - fsck: don't require an object struct for report()
 - fsck: only require an oid for skiplist functions
 - fsck: only provide oid/type in fsck_error callback
 - fsck: don't require object structs for display functions
 - fsck: use oids rather than objects for object_name API
 - fsck_describe_object(): build on our get_object_name() primitive
 - fsck: unify object-name code
 - fsck: require an actual buffer for non-blobs
 - fsck: stop checking tag->tagged
 - fsck: stop checking commit->parent counts
 - fsck: stop checking commit->tree value
 - remember commit/tag parse failures
 - parse_tag_buffer(): treat NULL tag pointer as parse error
 - parse_commit_buffer(): treat lookup_tree() failure as parse error
 - parse_commit_buffer(): treat lookup_commit() failure as parse error

 Crufty code and logic accumulated over time around the object
 parsing and low-level object access used in "git fsck" have been
 cleaned up.


* js/rebase-deprecate-preserve-merges (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-24 at 82fa49bbf2)
 + rebase: hide --preserve-merges option

 "git rebase --preserve-merges" has been marked as deprecated; this
 release stops advertising it in the "git rebase -h" output.

 Will cook in 'next'.


* po/bundle-doc-clonable (2019-10-21) 1 commit
 - Doc: Bundle file usage

 Doc update.

 Expecting a reroll.


* ds/commit-graph-on-fetch (2019-10-24) 2 commits
 - commit-graph: fix writing first commit-graph during fetch
 - t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug

 "git commit-grph write" hit BUG() in corner cases.

 Expecting a final fix-up.
 cf. <a9ba6007-aeb9-96b4-9436-8e956798be59@gmail.com> <20191023150402.GB26017@szeder.dev>


* jc/am-show-current-patch-docfix (2019-10-23) 1 commit
  (merged to 'next' on 2019-10-24 at 31fa6081f2)
 + doc: am --show-current-patch gives an entire e-mail message

 Doc update.

 Will cook in 'next'.


* js/advise-rebase-skip (2019-10-23) 3 commits
  (merged to 'next' on 2019-10-24 at e2edd2df2d)
 + commit: give correct advice for empty commit during a rebase
 + sequencer: export the function to get the path of `.git/rebase-merge/`
 + cherry-pick: add test for `--skip` advice in `git commit`

 The logic used in "git commit" to give hints and errors depending
 on what operation was in progress learned to distinguish rebase and
 cherry-pick better.

 Will cook in 'next'.


* sg/dir-trie-fixes (2019-10-23) 5 commits
  (merged to 'next' on 2019-10-24 at 06d60a7fb0)
 + path.c: don't call the match function without value in trie_find()
 + path.c: clarify two field names in 'struct common_dir'
 + path.c: mark 'logs/HEAD' in 'common_list' as file
 + path.c: clarify trie_find()'s in-code comment
 + Documentation: mention more worktree-specific exceptions

 Code clean-up and a bugfix in the logic used to tell worktree local
 and repository global refs apart.

 Will cook in 'next'.


* wb/midx-progress (2019-10-23) 6 commits
  (merged to 'next' on 2019-10-24 at 95c3e3ab3a)
 + multi-pack-index: add [--[no-]progress] option.
 + midx: honor the MIDX_PROGRESS flag in midx_repack
 + midx: honor the MIDX_PROGRESS flag in verify_midx_file
 + midx: add progress to expire_midx_packs
 + midx: add progress to write_midx_file
 + midx: add MIDX_PROGRESS flag

 The code to generate multi-pack index learned to show (or not to
 show) progress indicators.

 Will cook in 'next'.


* dl/apply-3way-diff3 (2019-10-24) 5 commits
  (merged to 'next' on 2019-10-24 at 84e27d28b6)
 + apply: respect merge.conflictStyle in --3way
 + t4108: demonstrate bug in apply
 + t4108: use `test_config` instead of `git config`
 + t4108: remove git command upstream of pipe
 + t4108: replace create_file with test_write_lines

 "git apply --3way" learned to honor merge.conflictsStyle
 configuration variable, like merges would.

 Will cook in 'next'.


* hw/config-doc-in-header (2019-10-24) 1 commit
 - config: move documentation to config.h

 Follow recent push to move API docs from Documentation/ to header
 files and update config.h

 Will merge to 'next'.


* jt/delay-fetch-if-missing (2019-10-24) 1 commit
 - fetch: delay fetch_if_missing=0 until after config

 Work-around a lazy fetch glitch.

--------------------------------------------------
[Stalled]

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


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


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

* dd/notes-copy-default-dst-to-head (2019-10-18) 2 commits
  (merged to 'next' on 2019-10-18 at 2588a175ec)
 + notes: fix minimum number of parameters to "copy" subcommand
 + t3301: test diagnose messages for too few/many paramters

 "git notes copy $original" ought to copy the notes attached to the
 original object to HEAD, but a mistaken tightening to command line
 parameter validation made earlier disabled that feature by mistake.

 Will cook in 'next'.


* jc/log-graph-simplify (2019-10-16) 13 commits
  (merged to 'next' on 2019-10-24 at 190b88709e)
 + graph: fix coloring of octopus dashes
 + graph: flatten edges that fuse with their right neighbor
 + graph: smooth appearance of collapsing edges on commit lines
 + graph: rename `new_mapping` to `old_mapping`
 + graph: commit and post-merge lines for left-skewed merges
 + graph: tidy up display of left-skewed merges
 + graph: example of graph output that can be simplified
 + graph: extract logic for moving to GRAPH_PRE_COMMIT state
 + graph: remove `mapping_idx` and `graph_update_width()`
 + graph: reduce duplication in `graph_insert_into_new_columns()`
 + graph: reuse `find_new_column_by_commit()`
 + graph: handle line padding in `graph_next_line()`
 + graph: automatically track display width of graph lines

 The implementation of "git log --graph" got refactored and then its
 output got simplified.

 Will cook in 'next'.


* js/git-path-head-dot-lock-fix (2019-10-24) 2 commits
  (merged to 'next' on 2019-10-24 at 3a7533c171)
 + git_path(): handle `.lock` files correctly
 + t1400: wrap setup code in test case

 "git rev-parse --git-path HEAD.lock" did not give the right path
 when run in a secondary worktree.

 Will cook in 'next'.


* pw/post-commit-from-sequencer (2019-10-16) 6 commits
  (merged to 'next' on 2019-10-18 at 15b41a097d)
 + sequencer: run post-commit hook
 + move run_commit_hook() to libgit and use it there
 + sequencer.h fix placement of #endif
 + t3404: remove uneeded calls to set_fake_editor
 + t3404: set $EDITOR in subshell
 + t3404: remove unnecessary subshell

 "rebase -i" ceased to run post-commit hook by mistake in an earlier
 update, which has been corrected.

 Will cook in 'next'.


* ds/sparse-cone (2019-10-23) 17 commits
 - sparse-checkout: cone mode should not interact with .gitignore
 - sparse-checkout: write using lockfile
 - sparse-checkout: update working directory in-process
 - sparse-checkout: sanitize for nested folders
 - read-tree: show progress by default
 - unpack-trees: add progress to clear_ce_flags()
 - unpack-trees: hash less in cone mode
 - sparse-checkout: init and set in cone mode
 - sparse-checkout: use hashmaps for cone patterns
 - sparse-checkout: add 'cone' mode
 - trace2: add region in clear_ce_flags
 - sparse-checkout: create 'disable' subcommand
 - sparse-checkout: add '--stdin' option to set subcommand
 - sparse-checkout: 'set' subcommand
 - clone: add --sparse mode
 - sparse-checkout: create 'init' subcommand
 - sparse-checkout: create builtin with 'list' subcommand

 Management of sparsely checked-out working tree has gained a
 dedicated "sparse-checkout" command.

 Will merge to 'next'.


* dl/format-patch-cover-from-desc (2019-10-16) 3 commits
  (merged to 'next' on 2019-10-18 at 40e992b6f5)
 + format-patch: teach --cover-from-description option
 + format-patch: use enum variables
 + format-patch: replace erroneous and condition

 The branch description ("git branch --edit-description") has been
 used to fill the body of the cover letters by the format-patch
 command; this has been enhanced so that the subject can also be
 filled.

 Will cook in 'next'.
 No need for rush, as this is a new feature.


* en/merge-recursive-directory-rename-fixes (2019-10-23) 3 commits
  (merged to 'next' on 2019-10-24 at 82e64029a8)
 + t604[236]: do not run setup in separate tests
 + merge-recursive: fix merging a subdirectory into the root directory
 + merge-recursive: clean up get_renamed_dir_portion()

 When all files from some subdirectory were renamed to the root
 directory, the directory rename heuristics would fail to detect that
 as a rename/merge of the subdirectory to the root directory, which has
 been corrected.

 Will cook in 'next'.


* jt/fetch-pack-record-refs-in-the-dot-promisor (2019-10-16) 1 commit
  (merged to 'next' on 2019-10-18 at 4ead52e59a)
 + fetch-pack: write fetched refs to .promisor

 Debugging support for lazy cloning has been a bit improved.

 Will cook in 'next'.
 No need for rush, as this is a new feature.


* es/walken-tutorial (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-18 at 59160e59e9)
 + documentation: add tutorial for object walking

 A tutorial on object enumeration.

 Will cook in 'next'.


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


* ag/sequencer-todo-updates (2019-10-08) 5 commits
  (merged to 'next' on 2019-10-18 at 8dac803e49)
 + sequencer: directly call pick_commits() from complete_action()
 + rebase: fill `squash_onto' in get_replay_opts()
 + sequencer: move the code writing total_nr on the disk to a new function
 + sequencer: update `done_nr' when skipping commands in a todo list
 + sequencer: update `total_nr' when adding an item to a todo list

 Reduce unnecessary reading of state variables back from the disk
 during sequener operation.

 Will cook in 'next'.
 No need for rush, as this does not fix anything nor adds any new feature.


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


* jk/packfile-reuse-cleanup (2019-10-23) 9 commits
 - pack-objects: improve partial packfile reuse
 - builtin/pack-objects: introduce obj_is_packed()
 - pack-objects: introduce pack.allowPackReuse
 - csum-file: introduce hashfile_total()
 - pack-bitmap: introduce bitmap_walk_contains()
 - pack-bitmap: don't rely on bitmap_git->reuse_objects
 - ewah/bitmap: introduce bitmap_word_alloc()
 + packfile: expose get_delta_base()
 + builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.


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

 Expecting a reroll on top of a base with the tg/stash-refresh-index
 topic that defines an updated repo_refresh_and_write_index() helper.
 cf. <20190911175201.GA11444@cat>

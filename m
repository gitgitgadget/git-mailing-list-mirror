Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18EDB20281
	for <e@80x24.org>; Wed,  4 Oct 2017 07:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdJDHUA (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 03:20:00 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:58319 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdJDHT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 03:19:58 -0400
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id A581C28DB6;
        Wed,  4 Oct 2017 03:19:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=j
        kz+kCdN1kN+nL4g0SXDp4m28n0=; b=tnt4QvSVgGwEvYa53Eo1DyqbfCKD/urzW
        0oJswee68FV6Nv93gRgwIQM4cJHP/7IngbyCmv53DiUiqSn8y+xHf2gsFk3VmB3X
        A2Da/RAU6B8s5qojakRgAvEniKGOtmdfXlEsa4pkWDVYwVptiAKQ0qGYPa1239si
        Wi0fFoMcJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=UjV
        ttgatUd0o7cqDxOe9CqIosdIJiIA2TU4XXyHSfUhIqVxRQVBC7v1FLnHSouIGPDK
        e/H+o2dAm3VvWS4oG1TgALUUJwpT5p+FlCCTN7ZlAV2ySHfrddhABJ1Ve+FE31o5
        Ootogr3yuDMknsW+EwSNq3oW65feoqCWHsubWIGQ=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 90C3228DB5;
        Wed,  4 Oct 2017 03:19:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B17299754A;
        Wed,  4 Oct 2017 03:19:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2017, #01; Wed, 4)
X-master-at: 8fb8a945bc2dea2bb04249213ad8dacffbfc604f
X-next-at: 6663358d3414aff4d7dac0c6f06cbfcc2cb48ddb
Importance: high
Date:   Wed, 04 Oct 2017 16:19:52 +0900
Message-ID: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AE61B00-A8D4-11E7-828D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

I wanted to do v2.15-rc0 today but it seems that this has to slip,
with too many topics still in flight in 'next' among which many are
fixes, one is even a fix for a recent regression.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ad/doc-markup-fix (2017-09-29) 1 commit
  (merged to 'next' on 2017-10-02 at fdf600e8f3)
 + doc: correct command formatting

 Docfix.


* bc/rev-parse-parseopt-fix (2017-09-25) 7 commits
  (merged to 'next' on 2017-09-26 at f3e013eaa4)
 + parse-options: only insert newline in help text if needed
 + parse-options: write blank line to correct output stream
 + t0040,t1502: Demonstrate parse_options bugs
  (merged to 'next' on 2017-09-24 at e479bce0ff)
 + git-rebase: don't ignore unexpected command line arguments
 + rev-parse parseopt: interpret any whitespace as start of help text
 + rev-parse parseopt: do not search help text for flag chars
 + t1502: demonstrate rev-parse --parseopt option mis-parsing

 Recent versions of "git rev-parse --parseopt" did not parse the
 option specification that does not have the optional flags (*=?!)
 correctly, which has been corrected.


* bw/git-clang-format (2017-10-01) 1 commit
  (merged to 'next' on 2017-10-02 at ee84c89b07)
 + clang-format: adjust line break penalties
 (this branch is used by sb/git-clang-format.)

 Adjust clang-format penalty parameters.


* hn/path-ownership-comment (2017-09-27) 2 commits
  (merged to 'next' on 2017-09-28 at 7cf8481c29)
 + read_gitfile_gently: clarify return value ownership.
 + real_path: clarify return value ownership

 Add comment to a few functions that use a short-lived buffer the
 caller can peek and copy out of.


* hn/string-list-doc (2017-09-27) 1 commit
  (merged to 'next' on 2017-09-28 at ffc8f65f4a)
 + string-list.h: move documentation from Documentation/api/ into header

 Doc reorg.


* hn/submodule-comment (2017-09-26) 1 commit
  (merged to 'next' on 2017-09-28 at a071ca3fde)
 + submodule.c: describe submodule_to_gitdir() in a new comment


* jk/no-optional-locks (2017-09-27) 1 commit
  (merged to 'next' on 2017-09-28 at eaffe9c638)
 + git: add --no-optional-locks option

 Some commands (most notably "git status") makes an opportunistic
 update when performing a read-only operation to help optimize later
 operations in the same repository.  The new "--no-optional-locks"
 option can be passed to Git to disable them.


* jk/read-in-full (2017-09-27) 7 commits
  (merged to 'next' on 2017-09-28 at 9d109b9233)
 + worktree: check the result of read_in_full()
 + worktree: use xsize_t to access file size
 + distinguish error versus short read from read_in_full()
 + avoid looking at errno for short read_in_full() returns
 + prefer "!=" when checking read_in_full() result
 + notes-merge: drop dead zero-write code
 + files-backend: prefer "0" for write_in_full() error check

 Code clean-up to prevent future mistakes by copying and pasting
 code that checks the result of read_in_full() function.


* jk/validate-headref-fix (2017-09-27) 3 commits
  (merged to 'next' on 2017-09-28 at dcea9d16f9)
 + validate_headref: use get_oid_hex for detached HEADs
 + validate_headref: use skip_prefix for symref parsing
 + validate_headref: NUL-terminate HEAD buffer

 Code clean-up.


* js/rebase-i-final (2017-07-27) 10 commits
  (merged to 'next' on 2017-09-26 at ea3f8f5e11)
 + rebase -i: rearrange fixup/squash lines using the rebase--helper
 + t3415: test fixup with wrapped oneline
 + rebase -i: skip unnecessary picks using the rebase--helper
 + rebase -i: check for missing commits in the rebase--helper
 + t3404: relax rebase.missingCommitsCheck tests
 + rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 + rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 + rebase -i: remove useless indentation
 + rebase -i: generate the script via rebase--helper
 + t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.


* mh/mmap-packed-refs (2017-09-25) 21 commits
  (merged to 'next' on 2017-09-29 at 3639417666)
 + packed-backend.c: rename a bunch of things and update comments
 + mmapped_ref_iterator: inline into `packed_ref_iterator`
 + ref_cache: remove support for storing peeled values
 + packed_ref_store: get rid of the `ref_cache` entirely
 + ref_store: implement `refs_peel_ref()` generically
 + packed_read_raw_ref(): read the reference from the mmapped buffer
 + packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
 + read_packed_refs(): ensure that references are ordered when read
 + packed_ref_cache: keep the `packed-refs` file mmapped if possible
 + packed-backend.c: reorder some definitions
 + mmapped_ref_iterator_advance(): no peeled value for broken refs
 + mmapped_ref_iterator: add iterator over a packed-refs file
 + packed_ref_cache: remember the file-wide peeling state
 + read_packed_refs(): read references with minimal copying
 + read_packed_refs(): make parsing of the header line more robust
 + read_packed_refs(): only check for a header at the top of the file
 + read_packed_refs(): use mmap to read the `packed-refs` file
 + die_unterminated_line(), die_invalid_line(): new functions
 + packed_ref_cache: add a backlink to the associated `packed_ref_store`
 + prefix_ref_iterator: break when we leave the prefix
 + ref_iterator: keep track of whether the iterator output is ordered

 Operations that do not touch (majority of) packed refs have been
 optimized by making accesses to packed-refs file lazy; we no longer
 pre-parse everything, and an access to a single ref in the
 packed-refs does not touch majority of irrelevant refs, either.


* mr/doc-negative-pathspec (2017-09-25) 1 commit
  (merged to 'next' on 2017-09-29 at 147bb7ef8b)
 + docs: improve discoverability of exclude pathspec

 Doc updates.


* sb/diff-color-move (2017-09-28) 1 commit
  (merged to 'next' on 2017-09-28 at cbdbc741be)
 + diff: correct newline in summary for renamed files

 The output from "git diff --summary" was broken in a recent topic
 that has been merged to 'master' and lost a LF after reporting of
 mode change.  This has been fixed.


* sb/submodule-diff-header-fix (2017-09-28) 1 commit
  (merged to 'next' on 2017-09-28 at 10e0f59303)
 + submodule: correct error message for missing commits

 Error message tweak.


* sb/test-submodule-update-config (2017-09-27) 1 commit
  (merged to 'next' on 2017-09-28 at 497214603c)
 + t7406: submodule.<name>.update command must not be run from .gitmodules


* sd/branch-copy (2017-09-24) 4 commits
  (merged to 'next' on 2017-09-28 at a6eceefa02)
 + branch: fix "copy" to never touch HEAD
 + branch: add a --copy (-c) option to go with --move (-m)
 + branch: add test for -m renaming multiple config sections
 + config: create a function to format section headers

 "git branch" learned "-c/-C" to create a new branch by copying an
 existing one.

--------------------------------------------------
[New Topics]

* jc/merge-symlink-ours-theirs (2017-09-26) 1 commit
 - merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Needs review.


* jt/oidmap (2017-10-01) 1 commit
 - oidmap: map with OID as key

 Introduce a new "oidmap" API and rewrite oidset to use it.

 Will merge to 'next'.


* jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - clone: configure blobmaxbytes in created repos
 - clone: support excluding large blobs
 - fetch: support excluding large blobs
 - fetch: refactor calculation of remote list
 - fetch-pack: support excluding large blobs
 - pack-objects: support --blob-max-bytes
 - pack-objects: rename want_.* to ignore_.*
 - gc: do not repack promisor packfiles
 - rev-list: support termination at promisor objects
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension

 A journey for "git clone" and "git fetch" to become "lazier" by
 depending more on its remote repository---this is the beginning of
 it.

 Needs review.


* ma/builtin-unleak (2017-10-02) 1 commit
 - builtin/: add UNLEAKs

 Many variables that points at a region of memory that will live
 throughout the life of the program have been marked with UNLEAK
 marker to help the leak checkers concentrate on real leaks..


* ma/lockfile-fixes (2017-10-02) 11 commits
 - read-cache: roll back lock on error with `COMMIT_LOCK`
 - read-cache: don't leave dangling pointer in `do_write_index()`
 - read-cache: require flags for `write_locked_index()`
 - cache.h: document `write_locked_index()`
 - apply: remove `newfd` from `struct apply_state`
 - apply: move lockfile into `apply_state`
 - cache-tree: simplify locking logic
 - tempfile: fix documentation on `delete_tempfile()`
 - lockfile: fix documentation on `close_lock_file_gently()`
 - treewide: prefer lockfiles on the stack
 - sha1_file: do not leak `lock_file`

 An earlier update made it possible to use an on-stack in-core
 lockfile structure (as opposed to having to deliberately leak an
 on-heap one).  Many codepaths have been updated to take advantage
 of this new facility.


* rs/cleanup-strbuf-users (2017-10-02) 3 commits
  (merged to 'next' on 2017-10-03 at 322ec33ad8)
 + graph: use strbuf_addchars() to add spaces
 + use strbuf_addstr() for adding strings to strbufs
 + path: use strbuf_add_real_path()

 Code clean-up.

 Will merge to 'master'.


* rs/cocci-de-paren-call-params (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at ee97fe5c24)
 + coccinelle: remove parentheses that become unnecessary

 Code clean-up.

 Will merge to 'master'.


* rs/run-command-use-alloc-array (2017-10-03) 1 commit
  (merged to 'next' on 2017-10-03 at e3869b6c32)
 + run-command: use ALLOC_ARRAY

 Code clean-up.

 Will merge to 'master'.


* rs/tag-null-pointer-arith-fix (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at e05d92fec9)
 + tag: avoid NULL pointer arithmetic

 Code clean-up.

 Will merge to 'master'.


* rs/use-free-and-null (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at 6340234d67)
 + repository: use FREE_AND_NULL

 Code clean-up.

 Will merge to 'master'.


* sb/git-clang-format (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at b40d47b9d5)
 + clang-format: add a comment about the meaning/status of the

 Add comment to clarify that the style file is meant to be used with
 clang-5 and the rules are still work in progress.

 Will merge to 'master'.


* rs/resolve-ref-optional-result (2017-10-01) 2 commits
  (merged to 'next' on 2017-10-03 at f129d4b0e9)
 + refs: pass NULL to resolve_refdup() if hash is not needed
 + refs: pass NULL to refs_resolve_refdup() if hash is not needed

 Code clean-up.

 Will merge to 'master'.


* ar/request-pull-phrasofix (2017-10-03) 1 commit
  (merged to 'next' on 2017-10-03 at 07807bba90)
 + request-pull: capitalise "Git" to make it a proper noun

 Spell the name of our system as "Git" in the output from
 request-pull script.

 Will merge to 'master'.


* tb/show-trailers-in-ref-filter (2017-10-02) 7 commits
 - ref-filter.c: parse trailers arguments with %(contents) atom
 - ref-filter.c: use trailer_opts to format trailers
 - t6300: refactor %(trailers) tests
 - doc: use "`<literal>`"-style quoting for literal strings
 - doc: 'trailers' is the preferred way to format trailers
 - t4205: unfold across multiple lines
 - pretty.c: delimit "%(trailers)" arguments with ","

 "git for-each-ref --format=..." learned a new format element,
 %(trailers), to show only the commit log trailer part of the log
 message.

 Will merge to 'next'.


* jk/ui-color-always-to-auto (2017-10-04) 3 commits
 - Merge branch 'jk/ui-color-always-to-auto-maint' into jk/ui-color-always-to-auto
 - t7301: use test_terminal to check color
 - t4015: use --color with --color-moved
 (this branch uses jk/ui-color-always-to-auto-maint.)


* jk/ui-color-always-to-auto-maint (2017-10-04) 10 commits
 - color: make "always" the same as "auto" in config
 - provide --color option for all ref-filter users
 - t3205: use --color instead of color.branch=always
 - t3203: drop "always" color test
 - t6006: drop "always" color config tests
 - t7502: use diff.noprefix for --verbose test
 - t7508: use test_terminal for color output
 - t3701: use test-terminal to collect color output
 - t4015: prefer --color to -c color.diff=always
 - test-terminal: set TERM=vt100
 (this branch is used by jk/ui-color-always-to-auto.)


* jn/strbuf-doc-re-reuse (2017-10-04) 1 commit
 - strbuf doc: reuse after strbuf_release is fine

 Will merge to 'next'.


* ks/branch-tweak-error-message-for-extra-args (2017-10-04) 1 commit
 - branch: change the error messages to be more meaningful

 Error message tweak.


* ks/verify-filename-non-option-error-message-tweak (2017-10-04) 1 commit
 - setup: update error message to be more meaningful

 Error message tweak.


* rs/qsort-s (2017-10-04) 1 commit
 - test-stringlist: avoid buffer underrun when sorting nothing

 Will merge to 'next'.


* sb/branch-avoid-repeated-strbuf-release (2017-10-04) 1 commit
 - branch: reset instead of release a strbuf

 Will merge to 'next'.


* tg/memfixes (2017-10-04) 3 commits
 - sub-process: use child_process.args instead of child_process.argv
 - http-push: fix construction of hex value from path
 - path.c: fix uninitialized memory access

 Fixes for a handful memory access issues identified by valgrind.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


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

--------------------------------------------------
[Cooking]

* er/fast-import-dump-refs-on-checkpoint (2017-09-29) 1 commit
  (merged to 'next' on 2017-10-03 at 4e7b0e7ec1)
 + fast-import: checkpoint: dump branches/tags/marks even if object_count==0

 The checkpoint command "git fast-import" did not flush updates to
 refs and marks unless at least one object was created since the
 last checkpoint, which has been corrected, as these things can
 happen without any new object getting created.

 Will merge to 'master'.


* jr/hash-migration-plan-doc (2017-09-28) 1 commit
 - technical doc: add a design doc for hash function transition

 Lay out plans for weaning us off of SHA-1.

 Will merge to 'next'.


* ot/mru-on-list (2017-10-01) 1 commit
 - mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Needs review.
 Outreachy.


* rb/compat-poll-fix (2017-09-29) 1 commit
 - poll.c: always set revents, even if to zero

 Backports a moral equivalent of 2015 fix to the poll emulation from
 the upstream gnulib to fix occasional breakages on HPE NonStop.

 Needs review.


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


* ds/find-unique-abbrev-optim (2017-10-03) 5 commits
 - sha1_name: minimize OID comparisons during disambiguation
 - sha1_name: parse less while finding common prefix
 - sha1_name: unroll len loop in find_unique_abbrev_r()
 - p0008-abbrev.sh: test find_unique_abbrev() perf
 - test-list-objects: list a subset of object ids


* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Needs review.


* mg/merge-pre-merge-hook (2017-09-24) 4 commits
 - t7503: add tests for pre-merge-hook
 - merge: --no-verify to bypass pre-merge hook
 - merge: do no-verify like commit
 - git-merge: honor pre-merge hook

 "git merge" learned a 'pre-merge' hook, that would be triggered
 before the merge commit is created by a clean auto-merge.

 Waiting for review to conclude.


* bp/fsmonitor (2017-10-04) 13 commits
 - fsmonitor: MINGW support for watchman integration
  (merged to 'next' on 2017-10-02 at cf0c67979c)
 + fsmonitor: add a performance test
 + fsmonitor: add a sample integration script for Watchman
 + fsmonitor: add test cases for fsmonitor extension
 + split-index: disable the fsmonitor extension when running the split index test
 + fsmonitor: add a test tool to dump the index extension
 + update-index: add fsmonitor support to update-index
 + ls-files: Add support in ls-files to display the fsmonitor valid bit
 + fsmonitor: add documentation for the fsmonitor extension.
 + fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 + update-index: add a new --force-write-index option
 + preload-index: add override to enable testing preload-index
 + bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.


* bw/protocol-v1 (2017-10-04) 10 commits
 - ssh: introduce a 'simple' ssh variant
 - i5700: add interop test for protocol transition
 - http: tell server that the client understands v1
 - connect: tell server that the client understands v1
 - connect: teach client to recognize v1 server response
 - upload-pack, receive-pack: introduce protocol version 1
 - daemon: recognize hidden request arguments
 - protocol: introduce protocol extention mechanisms
 - pkt-line: add packet_write function
 - connect: in ref advertisement, shallows are last

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.


* pc/submodule-helper (2017-10-02) 3 commits
 - submodule: port submodule subcommand 'status' from shell to C
 - submodule--helper: introduce for_each_listed_submodule()
 - submodule--helper: introduce get_submodule_displaypath()

 GSoC.
 Is this ready for 'next'?


* bc/hash-algo (2017-08-20) 5 commits
 - hash-algo: switch empty tree and blob lookups to use hash abstraction
 - hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: add structure representing hash algorithm
 - setup: expose enumerated repo info
 - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo

 RFC
 cf. <20170821000022.26729-1-sandals@crustytoothpaste.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Undecided.
 This needs justification in a larger picture; it is unclear why
 this is better than rejecting recursive checkout, for example.


* jk/check-ref-format-oor-fix (2017-07-14) 1 commit
 - check-ref-format: require a repository for --branch

 Discussion slowly continues...
 cf. <20170717172709.GL93855@aiede.mtv.corp.google.com>
 cf. <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 - SQUASH???
 - sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* jc/allow-lazy-cas (2017-07-06) 1 commit
 - push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Will discard.
 Independent from disabling the feature by default, this stirred up
 a discussion to replace the DWIM heuristics with a better one, which
 deserves to be its own topic.
 cf. <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-08-14 at 24db08a6e8)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.
 As the draft RelNotes says, let's merge this to 'master' after
 this release cycle.


--------------------------------------------------
[Discarded]

* jc/ref-filter-colors-fix (2017-10-03) 2 commits
 . colors: git_default_config() does not read color.ui
 . Revert "color: check color.ui in git_default_config()"

 Recent tip of 'master' and 'maint' (at least as of v2.14.2) has a
 regression in "git add -p" for those who set ui.color=always in
 their configuration, caused by us being overly aggressive in
 allowing plumbing commands to honor the configuration to fix a
 fallout from an earlier change that made everybody, even the
 plumbing commands, to automatically color its output by default.
 Revert it for now from the released version (and to be released
 one) until we come up with a different fix to the problem.



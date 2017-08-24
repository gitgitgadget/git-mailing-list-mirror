Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391AD208DC
	for <e@80x24.org>; Thu, 24 Aug 2017 18:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbdHXSuM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 14:50:12 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:54822 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbdHXSuK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 14:50:10 -0400
Received: from pb-sasl-trial3.pobox.com (localhost [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id C3932166E9;
        Thu, 24 Aug 2017 14:50:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=8
        wwxQOPVHZ3LC8gtGdVUwxQWv+w=; b=C9ErTvnCibV/9h9r4ofUAaNr1teQPKDNg
        l4DQZU6GaolcUMpzwd7u4vGhGaLJ5opXiwCqSTPC7U8CG1gpZ+qAkqlZP3eIsP/r
        9Acb9k8mjF0q4lxkix5aZ9FcP7kzjV2oMz/SkuYz4KXQbsP9rjM7YBdeH6triwtf
        lkhQGLx2A4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=VGY
        zhppxv9UVPDdRuLbHL7lHEF25MABXs7LLmcO5WD6WrUfCkM+91uPHxDJD0wsNIOv
        2a1QnUrpeJxCteDEPEH5Gdm44gyCh+iEUKUP/wD0E8fCsIewRuKOkfgKyVz7ZH3J
        wGeRZcDZOun3KXzmBvEOwX7jqnih22eTgSfo9+t0=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 61603166E8;
        Thu, 24 Aug 2017 14:50:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EF279BD8E;
        Thu, 24 Aug 2017 14:50:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2017, #06; Thu, 24)
X-master-at: 3dc57ebfbd1bf30b9a6987f551af9b74641382a9
X-next-at: eb51544efa2177e71821426b32f8c0299705a996
Date:   Thu, 24 Aug 2017 11:50:03 -0700
Message-ID: <xmqqlgm8x0kk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B3276DC-88FD-11E7-A1EE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

As I am preparing to go offline next week for about a week, a
handful of topics have been merged to 'master' and 'next' is getting
thinner.  There are a few topics of importance that are still only
on the mailing list archive and not in my tree that I'd like to
review them and help them get into a reasonable shape, but that
hasn't happened yet.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ah/doc-empty-string-is-false (2017-08-14) 1 commit
  (merged to 'next' on 2017-08-19 at df47ffeffa)
 + doc: clarify "config --bool" behaviour with empty string

 Doc update.


* as/grep-quiet-no-match-exit-code-fix (2017-08-17) 1 commit
  (merged to 'next' on 2017-08-19 at 362f88fb41)
 + git-grep: correct exit code with --quiet and -L

 "git grep -L" and "git grep --quiet -L" reported different exit
 codes; this has been corrected.


* cc/subprocess-handshake-missing-capabilities (2017-08-16) 1 commit
  (merged to 'next' on 2017-08-19 at c512710fda)
 + sub-process: print the cmd when a capability is unsupported

 When handshake with a subprocess filter notices that the process
 asked for an unknown capability, Git did not report what program
 the offending subprocess was running.  This has been corrected.

 We may want a follow-up fix to tighten the error checking, though.


* hv/t5526-andand-chain-fix (2017-08-17) 1 commit
  (merged to 'next' on 2017-08-19 at fa95053653)
 + t5526: fix some broken && chains

 Test fix.


* jc/diff-sane-truncate-no-more (2017-08-17) 1 commit
  (merged to 'next' on 2017-08-19 at 3ba3980eed)
 + diff: retire sane_truncate_fn

 Code clean-up.


* jc/simplify-progress (2017-08-19) 1 commit
  (merged to 'next' on 2017-08-22 at 9077ff6912)
 + progress: simplify "delayed" progress API

 The API to start showing progress meter after a short delay has
 been simplified.


* jk/doc-the-this (2017-08-20) 1 commit
  (merged to 'next' on 2017-08-22 at 6625e50025)
 + doc: fix typo in sendemail.identity

 Doc clean-up.


* jt/sha1-file-cleanup (2017-08-11) 2 commits
  (merged to 'next' on 2017-08-19 at 93f4c94578)
 + sha1_file: remove read_packed_sha1()
 + sha1_file: set whence in storage-specific info fn
 (this branch is used by jt/packmigrate.)

 Preparatory code clean-up.


* kd/stash-with-bash-4.4 (2017-08-14) 1 commit
  (merged to 'next' on 2017-08-19 at 79b2c4b052)
 + stash: prevent warning about null bytes in input

 bash 4.4 or newer gave a warning on NUL byte in command
 substitution done in "git stash"; this has been squelched.


* ks/prepare-commit-msg-sample-fix (2017-08-14) 1 commit
  (merged to 'next' on 2017-08-19 at e75c30de64)
 + hook: use correct logical variable

 An "oops" fix to a topic that is already in 'master'.


* kw/commit-keep-index-when-pre-commit-is-not-run (2017-08-16) 1 commit
  (merged to 'next' on 2017-08-19 at 2b5a25e5ae)
 + commit: skip discarding the index if there is no pre-commit hook

 "git commit" used to discard the index and re-read from the filesystem
 just in case the pre-commit hook has updated it in the middle; this
 has been optimized out when we know we do not run the pre-commit hook.


* kw/rebase-progress (2017-08-14) 2 commits
  (merged to 'next' on 2017-08-19 at 1958f378dd)
 + rebase: turn on progress option by default for format-patch
 + format-patch: have progress option while generating patches

 "git rebase", especially when it is run by mistake and ends up
 trying to replay many changes, spent long time in silence.  The
 command has been taught to show progress report when it spends
 long time preparing these many changes to replay (which would give
 the user a chance to abort with ^C).


* lg/merge-signoff (2017-07-25) 1 commit
  (merged to 'next' on 2017-08-19 at cb53d7b026)
 + merge: add a --signoff flag

 "git merge" learned a "--signoff" option to add the Signed-off-by:
 trailer with the committer's name.


* mg/format-ref-doc-fix (2017-08-18) 2 commits
  (merged to 'next' on 2017-08-19 at 6490525c54)
 + Documentation/git-for-each-ref: clarify peeling of tags for --format
 + Documentation: use proper wording for ref format strings

 Doc fix.


* nm/stash-untracked (2017-08-11) 1 commit
  (merged to 'next' on 2017-08-19 at 70990d7eb3)
 + stash: clean untracked files before reset

 "git stash -u" used the contents of the committed version of the
 ".gitignore" file to decide which paths are ignored, even when the
 file has local changes.  The command has been taught to instead use
 the locally modified contents.


* rs/commit-h-single-parent-cleanup (2017-08-19) 1 commit
  (merged to 'next' on 2017-08-22 at 7db01c4035)
 + commit: remove unused inline function single_parent()

 Code clean-up.


* rs/object-id (2017-08-14) 1 commit
  (merged to 'next' on 2017-08-19 at 0f7283cd19)
 + tree-walk: convert fill_tree_descriptor() to object_id

 Conversion from uchar[20] to struct object_id continues.


* rs/t1002-do-not-use-sum (2017-08-15) 1 commit
  (merged to 'next' on 2017-08-19 at 15b2a5f21b)
 + t1002: stop using sum(1)

 Test simplification.


* sb/sha1-file-cleanup (2017-08-15) 1 commit
  (merged to 'next' on 2017-08-19 at 85898d1e7c)
 + sha1_file: make read_info_alternates static

 Code clean-up.


* sb/submodule-parallel-update (2017-08-17) 1 commit
  (merged to 'next' on 2017-08-19 at c023a834f0)
 + submodule.sh: remove unused variable

 Code clean-up.


* tc/curl-with-backports (2017-08-11) 2 commits
  (merged to 'next' on 2017-08-22 at 06c21e1eb9)
 + http: use a feature check to enable GSSAPI delegation control
 + http: fix handling of missing CURLPROTO_*

 Updates to the HTTP layer we made recently unconditionally used
 features of libCurl without checking the existence of them, causing
 compilation errors, which has been fixed.  Also migrate the code to
 check feature macros, not version numbers, to cope better with
 libCurl that vendor ships with backported features.

--------------------------------------------------
[New Topics]

* js/gitweb-raw-blob-link-in-history (2017-08-22) 1 commit
  (merged to 'next' on 2017-08-23 at 16258266e2)
 + gitweb: add 'raw' blob_plain link in history overview

 "gitweb" shows a link to visit the 'raw' contents of blbos in the
 history overview page.

 Will merge to 'master'.


* jn/vcs-svn-cleanup (2017-08-23) 4 commits
  (merged to 'next' on 2017-08-24 at c184f08f5f)
 + vcs-svn: move remaining repo_tree functions to fast_export.h
 + vcs-svn: remove repo_delete wrapper function
 + vcs-svn: remove custom mode constants
 + vcs-svn: remove more unused prototypes and declarations
 (this branch uses bc/vcs-svn-cleanup; is tangled with bc/hash-algo.)

 Code clean-up.

 Will merge to 'master'.


* jt/doc-pack-objects-fix (2017-08-23) 1 commit
  (merged to 'next' on 2017-08-24 at 7e4c3c0c9f)
 + Doc: clarify that pack-objects makes packs, plural

 Doc updates.

 Will merge to 'master'.


* ma/ts-cleanups (2017-08-23) 4 commits
 - ThreadSanitizer: add suppressions
 - strbuf_setlen: don't write to strbuf_slopbuf
 - pack-objects: take lock before accessing `remaining`
 - convert: always initialize attr_action in convert_attrs

 Assorted bugfixes and clean-ups.

 Will merge to 'next'.


* ma/up-to-date (2017-08-23) 2 commits
 - treewide: correct several "up-to-date" to "up to date"
 - Documentation/user-manual: update outdated example output

 Message and doc updates.

 Will merge to 'next'.


* mh/ref-lock-entry (2017-08-23) 1 commit
  (merged to 'next' on 2017-08-24 at 67760267f4)
 + refs: retry acquiring reference locks for 100ms

 The code to acquire a lock on a reference (e.g. while accepting a
 push from a client) used to immediately fail when the reference is
 already locked---now it waits for a very short while and retries,
 which can make it succeed if the lock holder was holding it during
 a read-only operation.

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


* js/rebase-i-final (2017-07-27) 10 commits
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


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Expecting a reroll.
 cf. <bade1166-e646-b05a-f65b-adb8da8ba0a7@gmail.com>

--------------------------------------------------
[Cooking]

* jt/packmigrate (2017-08-23) 23 commits
  (merged to 'next' on 2017-08-24 at 34a628ae6c)
 + pack: move for_each_packed_object()
 + pack: move has_pack_index()
 + pack: move has_sha1_pack()
 + pack: move find_pack_entry() and make it global
 + pack: move find_sha1_pack()
 + pack: move find_pack_entry_one(), is_pack_valid()
 + pack: move check_pack_index_ptr(), nth_packed_object_offset()
 + pack: move nth_packed_object_{sha1,oid}
 + pack: move clear_delta_base_cache(), packed_object_info(), unpack_entry()
 + pack: move unpack_object_header()
 + pack: move get_size_from_delta()
 + pack: move unpack_object_header_buffer()
 + pack: move {,re}prepare_packed_git and approximate_object_count
 + pack: move install_packed_git()
 + pack: move add_packed_git()
 + pack: move unuse_pack()
 + pack: move use_pack()
 + pack: move pack-closing functions
 + pack: move release_pack_memory()
 + pack: move open_pack_index(), parse_pack_index()
 + pack: move pack_report()
 + pack: move static state variables
 + pack: move pack name-related functions

 Code movement to make it easier to hack later.

 Will merge to 'master'.


* jc/cutoff-config (2017-08-22) 6 commits
  (merged to 'next' on 2017-08-24 at 2dcbf9ae04)
 + rerere: allow approxidate in gc.rerereResolved/gc.rerereUnresolved
 + rerere: represent time duration in timestamp_t internally
 + t4200: parameterize "rerere gc" custom expiry test
 + t4200: gather "rerere gc" together
 + t4200: make "rerere gc" test more robust
 + t4200: give us a clean slate after "rerere gc" tests

 "[gc] rerereResolved = 5.days" used to be invalid, as the variable
 is defined to take an integer counting the number of days.  It now
 is allowed.

 Will merge to 'master'.


* jt/stash-tests (2017-08-19) 3 commits
  (merged to 'next' on 2017-08-22 at 0b022697aa)
 + stash: add a test for stashing in a detached state
 + stash: add a test for when apply fails during stash branch
 + stash: add a test for stash create with no files

 Test update to improve coverage for "git stash" operations.

 Will merge to 'master'.


* rs/archive-excluded-directory (2017-08-19) 3 commits
  (merged to 'next' on 2017-08-22 at 1853597c35)
 + archive: don't queue excluded directories
 + archive: factor out helper functions for handling attributes
 + t5001: add tests for export-ignore attributes and exclude pathspecs

 "git archive" did not work well with pathspecs and the
 export-ignore attribute.

 Will merge to 'master'.

 We may want to resurrect the "we don't archive an empty directory"
 bonus patch, but I do not mind merging the above early to 'next'
 and leave it as a separate follow-up enhancement.
 cf. <20170820090629.tumvqwzkromcykjf@sigill.intra.peff.net>


* bc/hash-algo (2017-08-20) 5 commits
 - hash-algo: switch empty tree and blob lookups to use hash abstraction
 - hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: add structure representing hash algorithm
 - setup: expose enumerated repo info
 - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo
 (this branch uses bc/vcs-svn-cleanup; is tangled with jn/vcs-svn-cleanup.)


* bc/vcs-svn-cleanup (2017-08-20) 2 commits
  (merged to 'next' on 2017-08-22 at d8494b5d5b)
 + vcs-svn: rename repo functions to "svn_repo"
 + vcs-svn: remove unused prototypes
 (this branch is used by bc/hash-algo and jn/vcs-svn-cleanup.)

 Code clean-up.

 Will merge to 'master'.


* kw/write-index-reduce-alloc (2017-08-21) 3 commits
  (merged to 'next' on 2017-08-24 at 29f7daad85)
 + read-cache: avoid allocating every ondisk entry when writing
 + read-cache: fix memory leak in do_write_index
 + perf: add test for writing the index

 We used to spend more than necessary cycles allocating and freeing
 piece of memory while writing each index entry out.  This has been
 optimized.

 Will merge to 'master'.


* mg/killed-merge (2017-08-23) 4 commits
  (merged to 'next' on 2017-08-24 at 5db37fc192)
 + merge: save merge state earlier
 + merge: split write_merge_state in two
 + merge: clarify call chain
 + Documentation/git-merge: explain --continue

 Killing "git merge --edit" before the editor returns control left
 the repository in a state with MERGE_MSG but without MERGE_HEAD,
 which incorrectly tells the subsequent "git commit" that there was
 a squash merge in progress.  This has been fixed.

 Will merge to 'master'.


* po/object-id (2017-08-20) 6 commits
  (merged to 'next' on 2017-08-23 at 0faff383a8)
 + sha1_file: convert index_stream to struct object_id
 + sha1_file: convert hash_sha1_file_literally to struct object_id
 + sha1_file: convert index_fd to struct object_id
 + sha1_file: convert index_path to struct object_id
 + read-cache: convert to struct object_id
 + builtin/hash-object: convert to struct object_id

 Will merge to 'master'.


* tb/apply-with-crlf (2017-08-19) 2 commits
  (merged to 'next' on 2017-08-22 at f92bf67061)
 + apply: file commited with CRLF should roundtrip diff and apply
 + convert: add SAFE_CRLF_KEEP_CRLF
 (this branch is tangled with jc/apply-with-crlf.)

 "git apply" that is used as a better "patch -p1" failed to apply a
 taken from a file with CRLF line endings to a file with CRLF line
 endings.  The root cause was because it misused convert_to_git()
 that tried to do "safe-crlf" processing by looking at the index
 entry at the same path, which is a nonsense---in that mode, "apply"
 is not working on the data in (or derived from) the index at all.
 This has been fixed.

 Will merge to 'master'.


* ks/branch-set-upstream (2017-08-17) 3 commits
  (merged to 'next' on 2017-08-22 at 10fd938390)
 + branch: quote branch/ref names to improve readability
 + builtin/branch: stop supporting the "--set-upstream" option
 + t3200: cleanup cruft of a test

 "branch --set-upstream" that has been deprecated in Git 1.8 has
 finally been retired.

 Will merge to 'master'.


* po/read-graft-line (2017-08-18) 4 commits
  (merged to 'next' on 2017-08-22 at 1e3fe0d3a1)
 + commit: rewrite read_graft_line
 + commit: allocate array using object_id size
 + commit: replace the raw buffer with strbuf in read_graft_line
 + sha1_file: fix definition of null_sha1

 Conversion from uchar[20] to struct object_id continues; this is to
 ensure that we do not assume sizeof(struct object_id) is the same
 as the length of SHA-1 hash (or length of longest hash we support).

 Will merge to 'master'.


* mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
 . diff-delta: fix encoding size that would not fit in "unsigned int"

 The machinery to create xdelta used in pack files received the
 sizes of the data in size_t, but lost the higher bits of them by
 storing them in "unsigned int" during the computation, which is
 fixed.

 Dropped, as it was rerolled for review as part of a larger series.
 cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* jk/trailers-parse (2017-08-20) 9 commits
  (merged to 'next' on 2017-08-22 at 2d4d937141)
 + doc/interpret-trailers: fix "the this" typo
  (merged to 'next' on 2017-08-19 at faa63f8196)
 + pretty: support normalization options for %(trailers)
 + t4205: refactor %(trailers) tests
 + pretty: move trailer formatting to trailer.c
 + interpret-trailers: add --parse convenience option
 + interpret-trailers: add an option to unfold values
 + interpret-trailers: add an option to show only existing trailers
 + interpret-trailers: add an option to show only the trailers
 + trailer: put process_trailers() options into a struct

 "git interpret-trailers" has been taught a "--parse" and a few
 other options to make it easier for scripts to grab existing
 trailer lines from a commit log message.

 Will merge to 'master'.
 Possible leftover bits are mentioned in
 cf. <20170820094009.z23wclpku35txflg@sigill.intra.peff.net>


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Dropped, as it was rerolled for review as part of a larger series.
 cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>


* mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
 . diff-delta: do not allow delta offset truncation

 The delta format used in the packfile cannot reference data at
 offset larger than what can be expressed in 4-byte, but the
 generator for the data failed to make sure the offset does not
 overflow.  This has been corrected.

 Dropped, as it was rerolled for review as part of a larger series.
 cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>


* jt/diff-color-move-fix (2017-08-16) 3 commits
  (merged to 'next' on 2017-08-19 at 6ae3831c8c)
 + diff: define block by number of alphanumeric chars
 + diff: respect MIN_BLOCK_LENGTH for last block
 + diff: avoid redundantly clearing a flag
 (this branch uses sb/diff-color-move.)

 A handful of bugfixes and an improvement to "diff --color-moved".

 Will merge to 'master'.


* bw/git-clang-format (2017-08-14) 2 commits
 - Makefile: add style build rule
 - clang-format: outline the git project's coding style

 "make style" runs git-clang-format to help developers by pointing
 out coding style issues.


* pb/trailers-from-command-line (2017-08-14) 4 commits
  (merged to 'next' on 2017-08-19 at b12342e49e)
 + interpret-trailers: fix documentation typo
 + interpret-trailers: add options for actions
 + trailers: introduce struct new_trailer_item
 + trailers: export action enums and corresponding lookup functions

 "git interpret-trailers" learned to take the trailer specifications
 from the command line that overrides the configured values.

 Will merge to 'master'.


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


* ti/external-sha1dc (2017-08-16) 2 commits
 - sha1dc: allow building with the external sha1dc library
 - sha1dc: build git plumbing code more explicitly

 Platforms that ship with a separate sha1 with collision detection
 library can link to it instead of using the copy we ship as part of
 our source tree.

 Waiting for reviews.
 cf. <20170815120417.31616-1-tiwai@suse.de>


* bw/submodule-config-cleanup (2017-08-03) 17 commits
  (merged to 'next' on 2017-08-24 at e35d58c4c6)
 + submodule: remove gitmodules_config
 + unpack-trees: improve loading of .gitmodules
 + submodule-config: lazy-load a repository's .gitmodules file
 + submodule-config: move submodule-config functions to submodule-config.c
 + submodule-config: remove support for overlaying repository config
 + diff: stop allowing diff to have submodules configured in .git/config
 + submodule: remove submodule_config callback routine
 + unpack-trees: don't respect submodule.update
 + submodule: don't rely on overlayed config when setting diffopts
 + fetch: don't overlay config with submodule-config
 + submodule--helper: don't overlay config in update-clone
 + submodule--helper: don't overlay config in remote_submodule_branch
 + add, reset: ensure submodules can be added or reset
 + submodule: don't use submodule_from_name
 + t7411: check configuration parsing errors
 + Merge branch 'bc/object-id' into bw/submodule-config-cleanup
 + Merge branch 'bw/grep-recurse-submodules' into bw/submodule-config-cleanup

 Code clean-up to avoid mixing values read from the .gitmodules file
 and values read from the .git/config file.

 Will merge to 'master'.
 So, after the recent discussion around submodule.<name>.update (and
 its resolution "use submodule.<name>.active; "reset --hard" must
 ignore the .update thing"), this is now good to go, I presume?
 Please yell at me that I am clueless if that is not the case ;-)


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


* sd/branch-copy (2017-06-18) 3 commits
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 I personally do not think "branch --copy master backup" while on
 "master" that switches to "backup" is a good UI, and I *will* say
 "I told you so" when users complain after we merge this down to
 'master'.


* sb/diff-color-move (2017-06-30) 26 commits
  (merged to 'next' on 2017-08-19 at a239d031bc)
 + diff: document the new --color-moved setting
 + diff.c: add dimming to moved line detection
 + diff.c: color moved lines differently, plain mode
 + diff.c: color moved lines differently
 + diff.c: buffer all output if asked to
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
 + diff.c: convert word diffing to use emit_diff_symbol
 + diff.c: convert show_stats to use emit_diff_symbol
 + diff.c: convert emit_binary_diff_body to use emit_diff_symbol
 + submodule.c: migrate diff output to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
 + diff.c: migrate emit_line_checked to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
 + diff.c: introduce emit_diff_symbol
 + diff.c: factor out diff_flush_patch_all_file_pairs
 + diff.c: move line ending check into emit_hunk_header
 + diff.c: readability fix
 + Merge branch 'sb/hashmap-customize-comparison' into sb/diff-color-move
 (this branch is used by jt/diff-color-move-fix.)

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

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


* jc/apply-with-crlf (2017-08-16) 6 commits
 . apply: clarify read_old_data() is about no-index case
 . apply: localize the CRLF business to read_old_data()
 . apply: only pay attention to CRLF in the preimage
 . apply: remove unused field apply_state.flags
 . apply: file commited with CRLF should roundtrip diff and apply
 + convert: add SAFE_CRLF_KEEP_CRLF
 (this branch is tangled with tb/apply-with-crlf.)

 This served as an input to updated tb/apply-with-crlf.

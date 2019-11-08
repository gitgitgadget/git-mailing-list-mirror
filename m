Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0831F454
	for <e@80x24.org>; Fri,  8 Nov 2019 08:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfKHIk4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 03:40:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51290 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHIk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 03:40:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7253E98C6B;
        Fri,  8 Nov 2019 03:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=N
        3ylbpwzJh8/4Ck1Or/KnAZqoq4=; b=Kb6X6ms+25Y0IA29xuVh+GiZwfmqFpHHV
        IeX9iY2/3vVG7irH28PFxdwk265lkNBv9ePX6CbY4pF/bmrswLcOCuOK9WwgICdS
        CQzYiQPYTMBFozTABWyt2mkl00F+5EtGNIYqMJ6KRyloWr3L5D9qHZ9uNZ9ofpe2
        JssiZpiQ8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Zs1
        DDp4C4NxIcW/Ao4Qy8OuR+naGlhtsmdvlSO4YYVMbe3nOqjS9jiYkZFWrQaw5MOO
        KUP7DpWKk0kGJ0g9UouN0yptCndj8MRuuklcoGh2HpcDAcBR1Ml4T48LB7lsquGY
        dNBLzxvgrkwPQfHqTWk2cOmBKYlK+OP00Iq2qQoE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6025098C6A;
        Fri,  8 Nov 2019 03:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5215A98C69;
        Fri,  8 Nov 2019 03:40:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2019, #02; Fri, 8)
X-master-at: da72936f544fec5a335e66432610e4cef4430991
X-next-at: 68dc17040922b37729d89a2dbc01e41fbefdea8f
Date:   Fri, 08 Nov 2019 17:40:46 +0900
Message-ID: <xmqqeeyin4kx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76716792-0203-11EA-9FA7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.24 has been tagged.  Hopefully there needs no immediate brown
paper bag fixes needed for the 'master' branch. The next cycle will
start perhaps early next week by first rewinding the 'next' branch,
after the dust settles. Topics marked as "will cook in next" can be
given a fresh start by ejecting them from 'next' and queueing a new
version (please just ask). Topics currently not in 'next' will then
start getting merged down after all that.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* am/pathspec-from-file (2019-11-07) 6 commits
 - commit: support the --pathspec-from-file option
 - doc: commit: unify <pathspec> description
 - reset: support the `--pathspec-from-file` option
 - doc: reset: unify <pathspec> description
 - pathspec: add new function to parse file
 - parse-options.h: add new options `--pathspec-from-file`, `--pathspec-file-nul`

 A few commands learned to take the pathspec from the
 standard input or a named file, instead of taking it as the command
 line arguments.

 Will merge to 'next'.


* cb/curl-use-xmalloc (2019-11-07) 1 commit
 - remote-curl: unbreak http.extraHeader with custom allocators

 HTTP transport had possible allocator/deallocator mismatch, which
 has been corrected.

 Will merge to 'next'.


* ds/commit-graph-delay-gen-progress (2019-11-07) 1 commit
 - commit-graph: use start_delayed_progress()

 One kind of progress messages were always given during commit-graph
 generation, instead of following the "if it takes more than two
 seconds, show progress" pattern, which has been corrected.

 Will merge to 'next'.


* ec/fetch-mark-common-refs-trace2 (2019-11-07) 1 commit
 - fetch: add trace2 instrumentation

 Trace2 annotation.

 Expecting a response to review.


* en/misc-doc-fixes (2019-11-07) 3 commits
 - name-hash.c: remove duplicate word in comment
 - hashmap: fix documentation misuses of -> versus .
 - git-filter-branch.txt: correct argument name typo

 Misc doc fixes.

 Will merge to 'next'.


* en/t6024-style (2019-11-07) 1 commit
 - t6024: modernize style

 Test updates.

 Will merge to 'next'.


* ep/guard-kset-tar-headers (2019-11-07) 1 commit
 - kset.h, tar.h: add missing header guard to prevent multiple inclusion

 Code clean-up.

 Will merge to 'next'.


* js/fetch-multi-lockfix (2019-11-06) 2 commits
 - fetch: avoid locking issues between fetch.jobs/fetch.writeCommitGraph
 - fetch: add the command-line option `--write-commit-graph`

 Fetching from multiple remotes into the same repository in parallel
 had a bad interaction with the recent change to (optionally) update
 the commit-graph after a fetch job finishes, as these parallel
 fetches compete with each other.  Which has been corrected.

 Will merge to 'next'.


* jt/fetch-remove-lazy-fetch-plugging (2019-11-06) 1 commit
 - fetch: remove fetch_if_missing=0

 "git fetch" codepath had a big "do not lazily fetch missing objects
 when I ask if something exists" switch.  This has been corrected by
 marking the "does this thing exist?" calls with "if not please do not
 lazily fetch it" flag.

 Will merge to 'next'.


* kw/fsmonitor-watchman-fix (2019-11-06) 1 commit
 - fsmonitor: fix watchman integration

 The watchman integration for fsmonitor was racy, which has been
 corrected to be more conservative.

 Will merge to 'next'.


* ln/userdiff-elixir (2019-11-08) 1 commit
 - userdiff: add Elixir to supported languages

 The patterns to detect function boundary for Elixir language has
 been added.

 Will merge to 'next'.


* ns/test-desc-typofix (2019-11-07) 1 commit
 - t: fix typo in test descriptions

 Typofix.

 Will merge to 'next'.


* py/shortlog-list-options-for-log (2019-11-06) 1 commit
 - git-shortlog.txt: include commit limiting options

 Documentation pages for "git shortlog" now lists commit limiting
 options explicitly.

 Expecting a reroll.  
 It excludes too much (e.g. the section for pathspec based history
 simplification) in a way that makes future shuffling of sections
 in rev-list-options.txt error prone.


* rs/trace2-dots (2019-11-06) 1 commit
 - trace2: add dots directly to strbuf in perf_fmt_prepare()

 Code cleanup.

 Will merge to 'next'.


* dd/sequencer-utf8 (2019-11-07) 8 commits
 - sequencer: reencode commit message for am/rebase --show-current-patch
 - sequencer: reencode old merge-commit message
 - sequencer: reencode squashing commit's message
 - sequencer: reencode revert/cherry-pick's todo list
 - sequencer: reencode to utf-8 before arrange rebase's todo list
 - t3900: demonstrate git-rebase problem with multi encoding
 - configure.ac: define ICONV_OMITS_BOM if necessary
 - t0028: eliminate non-standard usage of printf

 Handling of commit objects that use non UTF-8 encoding during
 "rebase -i" has been improved.


* dl/t5520-cleanup (2019-11-08) 14 commits
 - t5520: replace `! git` with `test_must_fail git`
 - t5520: remove redundant lines in test cases
 - t5520: replace subshell cat comparison with test_cmp
 - t5520: don't put git in upstream of pipe
 - t5520: test single-line files by git with test_cmp
 - t5520: use test_cmp_rev where possible
 - t5520: replace test -{n,z} with test-lib functions
 - t5520: use test_line_count where possible
 - t5520: remove spaces after redirect operator
 - t5520: replace test -f with test-lib functions
 - t5520: let sed open its own input
 - t5520: use sq for test case names
 - t5520: improve test style
 - t: teach test_cmp_rev to accept ! for not-equals

 Test cleanup.

 Expecting a response to review.

--------------------------------------------------
[Stalled]

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

* js/builtin-add-i (2019-11-08) 9 commits
 - built-in add -i: implement the `help` command
 - built-in add -i: use color in the main loop
 - built-in add -i: support `?` (prompt help)
 - built-in add -i: show unique prefixes of the commands
 - built-in add -i: implement the main loop
 - built-in add -i: color the header in the `status` command
 - built-in add -i: implement the `status` command
 - diff: export diffstat interface
 - Start to implement a built-in version of `git add --interactive`

 The beginning of rewriting "git add -i" in C.


* es/myfirstcontrib-updates (2019-11-02) 3 commits
 - myfirstcontrib: hint to find gitgitgadget allower
 - myfirstcontrib: add dependency installation step
 - myfirstcontrib: add 'psuh' to command-list.txt

 Doc updates.

 Will merge to 'next'.


* rt/fetch-message-fix (2019-11-02) 1 commit
 - fetch.c: fix typo in a warning message

 A small message update.

 Will merge to 'next'.


* ra/rebase-i-more-options (2019-11-02) 6 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: allow callers of read_author_script() to ignore fields
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.


* en/doc-typofix (2019-11-07) 11 commits
 - Fix spelling errors in no-longer-updated-from-upstream modules
 - multimail: fix a few simple spelling errors
 - sha1dc: fix trivial comment spelling error
 - Fix spelling errors in test commands
 - Fix spelling errors in messages shown to users
 - Fix spelling errors in names of tests
 - Fix spelling errors in comments of testcases
 - Fix spelling errors in code comments
 - Prefer 'up-to-date' spelling
 - Fix spelling errors in documentation outside of Documentation/
 - Documentation: fix a bunch of typos, both old and new

 Docfix.

 Will merge to 'next'.


* hw/remove-api-docs-placeholder (2019-10-25) 1 commit
  (merged to 'next' on 2019-10-30 at c99fe16682)
 + documentation: remove empty doc files

 Docfix.

 Will merge to 'master'.


* js/update-index-ignore-removal-for-skip-worktree (2019-11-02) 2 commits
  (merged to 'next' on 2019-11-02 at 57f7fb885f)
 + stash: handle staged changes in skip-worktree files correctly
 + update-index: optionally leave skip-worktree entries alone

 "git stash save" in a working tree that is sparsely checked out
 mistakenly removed paths that are outside the area of interest.

 Will merge to 'master'.


* pb/pretty-email-without-domain-part (2019-10-30) 3 commits
  (merged to 'next' on 2019-10-30 at 06f719efa5)
 + pretty: add "%aL" etc. to show local-part of email addresses
 + t4203: use test-lib.sh definitions
 + t6006: use test-lib.sh definitions

 The custom format for "git log --format=<format>" learned the l/L
 placeholder that is similar to e/E that fills in the e-mail
 address, but only the local part on the left side of '@'.

 Will merge to 'master'.


* sg/commit-graph-usage-fix (2019-10-28) 1 commit
  (merged to 'next' on 2019-10-28 at 13d01506dd)
 + builtin/commit-graph.c: remove subcommand-less usage string

 Message fix.

 Will merge to 'master'.


* dl/doc-diff-no-index-implies-exit-code (2019-11-02) 1 commit
 - git-diff.txt: document return code of `--no-index`

 Doc update.

 Will merge to 'next'.


* dl/submodule-set-url (2019-10-30) 1 commit
 - submodule: teach set-url subcommand

 "git submodule" learned a subcommand "set-url".


* js/vreportf-wo-buffering (2019-11-02) 1 commit
 - vreportf(): avoid relying on stdio buffering

 Messages from die() etc. can be mixed up from multiple processes
 without even line buffering on Windows, which has been worked
 around.

 Will merge to 'next'.


* ma/bisect-doc-sample-update (2019-10-29) 1 commit
 - Documentation/git-bisect.txt: add --no-ff to merge command

 "git merge --no-commit" needs "--no-ff" if you do not want to move
 HEAD, which has been corrected in the manual page for "git bisect".

 Will merge to 'next'.


* mr/clone-dir-exists-to-path-exists (2019-10-29) 1 commit
 - clone: rename static function `dir_exists()`.

 Code cleanup.

 Will merge to 'next'.


* pb/help-list-gitsubmodules-among-guides (2019-10-29) 1 commit
 - help: add gitsubmodules to the list of guides

 Help update.

 Will merge to 'next'.


* pb/no-recursive-reset-hard-in-worktree-add (2019-10-30) 1 commit
 - worktree: teach "add" to ignore submodule.recurse config

 "git worktree add" internally calls "reset --hard" that should not
 descend into submodules, even when submodule.recurse configuration
 is set, but it was affected.  This has been correct.

 Will merge to 'next'.


* sg/blame-indent-heuristics-is-now-the-default (2019-10-29) 1 commit
 - builtin/blame.c: remove '--indent-heuristic' from usage string

 Message update.

 Will merge to 'next'.


* hv/bitshift-constants-in-blame (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-24 at bc84aae4d4)
 + builtin/blame.c: constants into bit shift format

 Move the definition of a set of bitmask constants from 0ctal
 literal to (1U<<count) notation.

 Will merge to 'master'.


* jk/cleanup-object-parsing-and-fsck (2019-10-28) 23 commits
  (merged to 'next' on 2019-10-30 at 6e8b84557e)
 + fsck: accept an oid instead of a "struct tree" for fsck_tree()
 + fsck: accept an oid instead of a "struct commit" for fsck_commit()
 + fsck: accept an oid instead of a "struct tag" for fsck_tag()
 + fsck: rename vague "oid" local variables
 + fsck: don't require an object struct in verify_headers()
 + fsck: don't require an object struct for fsck_ident()
 + fsck: drop blob struct from fsck_finish()
 + fsck: accept an oid instead of a "struct blob" for fsck_blob()
 + fsck: don't require an object struct for report()
 + fsck: only require an oid for skiplist functions
 + fsck: only provide oid/type in fsck_error callback
 + fsck: don't require object structs for display functions
 + fsck: use oids rather than objects for object_name API
 + fsck_describe_object(): build on our get_object_name() primitive
 + fsck: unify object-name code
 + fsck: require an actual buffer for non-blobs
 + fsck: stop checking tag->tagged
 + fsck: stop checking commit->parent counts
 + fsck: stop checking commit->tree value
 + commit, tag: don't set parsed bit for parse failures
 + parse_tag_buffer(): treat NULL tag pointer as parse error
 + parse_commit_buffer(): treat lookup_tree() failure as parse error
 + parse_commit_buffer(): treat lookup_commit() failure as parse error

 Crufty code and logic accumulated over time around the object
 parsing and low-level object access used in "git fsck" have been
 cleaned up.

 Will cook in 'next'.


* js/rebase-deprecate-preserve-merges (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-24 at 82fa49bbf2)
 + rebase: hide --preserve-merges option

 "git rebase --preserve-merges" has been marked as deprecated; this
 release stops advertising it in the "git rebase -h" output.

 Will merge to 'master'.


* po/bundle-doc-clonable (2019-10-21) 1 commit
 - Doc: Bundle file usage

 Doc update.

 Expecting a reroll.


* jc/am-show-current-patch-docfix (2019-10-23) 1 commit
  (merged to 'next' on 2019-10-24 at 31fa6081f2)
 + doc: am --show-current-patch gives an entire e-mail message

 Doc update.

 Will merge to 'master'.


* js/advise-rebase-skip (2019-10-23) 3 commits
  (merged to 'next' on 2019-10-24 at e2edd2df2d)
 + commit: give correct advice for empty commit during a rebase
 + sequencer: export the function to get the path of `.git/rebase-merge/`
 + cherry-pick: add test for `--skip` advice in `git commit`

 The logic used in "git commit" to give hints and errors depending
 on what operation was in progress learned to distinguish rebase and
 cherry-pick better.

 Perhaps discard and expect a reroll.
 cf. <9d550cd9-08a2-eee5-7d7f-63678285accc@gmail.com>


* sg/dir-trie-fixes (2019-10-23) 5 commits
  (merged to 'next' on 2019-10-24 at 06d60a7fb0)
 + path.c: don't call the match function without value in trie_find()
 + path.c: clarify two field names in 'struct common_dir'
 + path.c: mark 'logs/HEAD' in 'common_list' as file
 + path.c: clarify trie_find()'s in-code comment
 + Documentation: mention more worktree-specific exceptions

 Code clean-up and a bugfix in the logic used to tell worktree local
 and repository global refs apart.

 Will merge to 'master'.


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

 Will merge to 'master'.


* dl/apply-3way-diff3 (2019-10-24) 5 commits
  (merged to 'next' on 2019-10-24 at 84e27d28b6)
 + apply: respect merge.conflictStyle in --3way
 + t4108: demonstrate bug in apply
 + t4108: use `test_config` instead of `git config`
 + t4108: remove git command upstream of pipe
 + t4108: replace create_file with test_write_lines

 "git apply --3way" learned to honor merge.conflictStyle
 configuration variable, like merges would.

 Will merge to 'master'.


* hw/config-doc-in-header (2019-10-24) 1 commit
 - config: move documentation to config.h

 Follow recent push to move API docs from Documentation/ to header
 files and update config.h

 Will merge to 'next'.


* dd/notes-copy-default-dst-to-head (2019-10-18) 2 commits
  (merged to 'next' on 2019-10-18 at 2588a175ec)
 + notes: fix minimum number of parameters to "copy" subcommand
 + t3301: test diagnose messages for too few/many paramters

 "git notes copy $original" ought to copy the notes attached to the
 original object to HEAD, but a mistaken tightening to command line
 parameter validation made earlier disabled that feature by mistake.

 Will merge to 'master'.


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


* js/git-path-head-dot-lock-fix (2019-10-29) 2 commits
 - git_path(): handle `.lock` files correctly
 - t1400: wrap setup code in test case

 "git rev-parse --git-path HEAD.lock" did not give the right path
 when run in a secondary worktree.

 Will merge to 'next'.


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

 Will merge to 'master'.


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

 Will merge to 'master'.


* en/merge-recursive-directory-rename-fixes (2019-10-23) 3 commits
  (merged to 'next' on 2019-10-24 at 82e64029a8)
 + t604[236]: do not run setup in separate tests
 + merge-recursive: fix merging a subdirectory into the root directory
 + merge-recursive: clean up get_renamed_dir_portion()

 When all files from some subdirectory were renamed to the root
 directory, the directory rename heuristics would fail to detect that
 as a rename/merge of the subdirectory to the root directory, which has
 been corrected.

 Will merge to 'master'.


* jt/fetch-pack-record-refs-in-the-dot-promisor (2019-10-16) 1 commit
  (merged to 'next' on 2019-10-18 at 4ead52e59a)
 + fetch-pack: write fetched refs to .promisor

 Debugging support for lazy cloning has been a bit improved.

 Will merge to 'master'.


* es/walken-tutorial (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-18 at 59160e59e9)
 + documentation: add tutorial for object walking

 A tutorial on object enumeration.

 Will merge to 'master'.


* bc/hash-independent-tests-part-6 (2019-10-28) 15 commits
  (merged to 'next' on 2019-10-30 at 70037a3839)
 + t4048: abstract away SHA-1-specific constants
 + t4045: make hash-size independent
 + t4044: update test to work with SHA-256
 + t4039: abstract away SHA-1-specific constants
 + t4038: abstract away SHA-1 specific constants
 + t4034: abstract away SHA-1-specific constants
 + t4027: make hash-size independent
 + t4015: abstract away SHA-1-specific constants
 + t4011: abstract away SHA-1-specific constants
 + t4010: abstract away SHA-1-specific constants
 + t3429: remove SHA1 annotation
 + t1305: avoid comparing extensions
 + rev-parse: add a --show-object-format option
 + t/oid-info: add empty tree and empty blob values
 + t/oid-info: allow looking up hash algorithm name

 Test updates to prepare for SHA-2 transition continues.

 Will merge to 'master'.


* ag/sequencer-todo-updates (2019-10-28) 6 commits
  (merged to 'next' on 2019-10-28 at 85f694d9d3)
 + SQUASH??? tentative leakfix
  (merged to 'next' on 2019-10-18 at 8dac803e49)
 + sequencer: directly call pick_commits() from complete_action()
 + rebase: fill `squash_onto' in get_replay_opts()
 + sequencer: move the code writing total_nr on the disk to a new function
 + sequencer: update `done_nr' when skipping commands in a todo list
 + sequencer: update `total_nr' when adding an item to a todo list

 Reduce unnecessary reading of state variables back from the disk
 during sequener operation.

 Kick back to 'pu' before squashing the leakfix.


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

 What's the current status of this one?


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

 Will merge to 'next'.

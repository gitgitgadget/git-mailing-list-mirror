Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD301F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfDYKPa (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:15:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54909 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfDYKP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:15:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B64760C90;
        Thu, 25 Apr 2019 06:15:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=if2IOx4mKtyMFUsUOOme7/Sp8
        2w=; b=gIS+/7VF+6lRUzJvoQqOVezd3FXQuF4uqHQ4Mz5VRgx6Oabfcl/2xWtRV
        8BDSxmAbxlhVWICTq93eAzDiNZt5+JMoKpwIlUDCwpRi5UPSjkPlYfeee0CoF21e
        k31L5LE6bzpPG19usHCyR74W/776id5lmlOzxQqrUNiySUqJUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=qUKwzxJIXFexyjt3a2+
        +21kfvGTQ1qIDwr0jQs0ZFqemPvyrtu4GfwxHM6ebSxxBsjVVRccPQY5KhhfXePa
        8ooo6AHlH+lUpqAywtXzpKCVdK33aEgPKxdf1fUxUFzUpnX3gfPvK+l6cRZh/MS2
        vLB9aPK1PCBeoHlbCYz0vUkc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63C8760C8F;
        Thu, 25 Apr 2019 06:15:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3B0B060C8E;
        Thu, 25 Apr 2019 06:15:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2019, #05; Thu, 25)
X-master-at: 83232e38648b51abbcbdb56c94632b6906cc85a6
X-next-at: f2820cf01acf778d953a46357a6160ba42711eb1
Date:   Thu, 25 Apr 2019 19:15:06 +0900
Message-ID: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00A197FE-6743-11E9-96AC-D01F9763A999-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
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

* ab/commit-graph-fixes (2019-04-01) 8 commits
  (merged to 'next' on 2019-04-16 at 97f4ba02f0)
 + commit-graph: improve & i18n error messages
 + commit-graph write: don't die if the existing graph is corrupt
 + commit-graph verify: detect inability to read the graph
 + commit-graph: don't pass filename to load_commit_graph_one_fd_st()
 + commit-graph: don't early exit(1) on e.g. "git status"
 + commit-graph: fix segfault on e.g. "git status"
 + commit-graph tests: test a graph that's too small
 + commit-graph tests: split up corrupt_graph_and_verify()
 (this branch is used by ds/commit-graph-format-v2.)

 Code cleanup with more careful error checking before using data
 read from the commit-graph file.


* ab/gc-docs (2019-04-08) 11 commits
  (merged to 'next' on 2019-04-22 at 02785d40f5)
 + gc docs: remove incorrect reference to gc.auto=3D0
 + gc docs: clarify that "gc" doesn't throw away referenced objects
 + gc docs: note "gc --aggressive" in "fast-import"
 + gc docs: downplay the usefulness of --aggressive
 + gc docs: note how --aggressive impacts --window & --depth
 + gc docs: fix formatting for "gc.writeCommitGraph"
 + gc docs: re-flow the "gc.*" section in "config"
 + gc docs: include the "gc.*" section from "config" in "gc"
 + gc docs: clean grammar for "gc.bigPackThreshold"
 + gc docs: stop noting "repack" flags
 + gc docs: modernize the advice for manually running "gc"

 Update docs around "gc".


* ab/gc-reflog (2019-04-01) 7 commits
  (merged to 'next' on 2019-04-16 at aa27f951a8)
 + gc: handle & check gc.reflogExpire config
 + reflog tests: assert lack of early exit with expiry=3D"never"
 + reflog tests: test for the "points nowhere" warning
 + reflog tests: make use of "test_config" idiom
 + gc: refactor a "call me once" pattern
 + gc: convert to using the_hash_algo
 + gc: remove redundant check for gc_auto_threshold

 Fix various glitches in "git gc" around reflog handling.


* ab/test-lib-pass-trace2-env (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at 4dad6d6d7a)
 + test-lib: whitelist GIT_TR2_* in the environment

 Allow tracing of Git executable while running the testsuite.


* ag/sequencer-reduce-rewriting-todo (2019-03-07) 18 commits
  (merged to 'next' on 2019-04-10 at 7eab7c7800)
 + rebase--interactive: move transform_todo_file()
 + sequencer: use edit_todo_list() in complete_action()
 + rebase-interactive: rewrite edit_todo_list() to handle the initial edi=
t
 + rebase-interactive: append_todo_help() changes
 + rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 + sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 + rebase--interactive: move rearrange_squash_in_todo_file()
 + rebase--interactive: move sequencer_add_exec_commands()
 + sequencer: change complete_action() to use the refactored functions
 + sequencer: make sequencer_make_script() write its script to a strbuf
 + sequencer: refactor rearrange_squash() to work on a todo_list
 + sequencer: refactor sequencer_add_exec_commands() to work on a todo_li=
st
 + sequencer: refactor check_todo_list() to work on a todo_list
 + sequencer: introduce todo_list_write_to_file()
 + sequencer: refactor transform_todos() to work on a todo_list
 + sequencer: remove the 'arg' field from todo_item
 + sequencer: make the todo_list structure public
 + sequencer: changes in parse_insn_buffer()
 (this branch is used by pw/rebase-i-internal.)

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.
 cf. <20190305191805.13561-1-alban.gruin@gmail.com> (v8)


* bc/hash-transition-16 (2019-04-01) 35 commits
  (merged to 'next' on 2019-04-16 at 8227fea6fa)
 + gitweb: make hash size independent
 + Git.pm: make hash size independent
 + read-cache: read data in a hash-independent way
 + dir: make untracked cache extension hash size independent
 + builtin/difftool: use parse_oid_hex
 + refspec: make hash size independent
 + archive: convert struct archiver_args to object_id
 + builtin/get-tar-commit-id: make hash size independent
 + get-tar-commit-id: parse comment record
 + hash: add a function to lookup hash algorithm by length
 + remote-curl: make hash size independent
 + http: replace sha1_to_hex
 + http: compute hash of downloaded objects using the_hash_algo
 + http: replace hard-coded constant with the_hash_algo
 + http-walker: replace sha1_to_hex
 + http-push: remove remaining uses of sha1_to_hex
 + http-backend: allow 64-character hex names
 + http-push: convert to use the_hash_algo
 + builtin/pull: make hash-size independent
 + builtin/am: make hash size independent
 + fast-import: replace sha1_to_hex
 + fast-import: make hash-size independent
 + builtin/name-rev: make hash-size independent
 + object-store: rename and expand packed_git's sha1 member
 + notes: replace sha1_to_hex
 + notes: make hash size independent
 + notes-merge: switch to use the_hash_algo
 + submodule: avoid hard-coded constants
 + pack-bitmap: switch hash tables to use struct object_id
 + pack-bitmap: switch hard-coded constants to the_hash_algo
 + pack-bitmap: replace sha1_to_hex
 + pack-bitmap: convert struct stored_bitmap to object_id
 + pack-bitmap: make bitmap header handling hash agnostic
 + khash: move oid hash table definition
 + t/lib-submodule-update: use appropriate length constant

 Conversion from unsigned char[20] to struct object_id continues.


* bc/send-email-qp-cr (2019-04-14) 1 commit
  (merged to 'next' on 2019-04-22 at 69398b0ea8)
 + send-email: default to quoted-printable when CR is present

 "git send-email" has been taught to use quoted-printable when the
 payload contains carriage-return.  The use of the mechanism is in
 line with the design originally added the codepath that chooses QP
 when the payload has overly long lines.


* bp/post-index-change-hook (2019-02-15) 1 commit
  (merged to 'next' on 2019-03-11 at cb96d1d7c4)
 + read-cache: add post-index-change hook

 Originally merged to 'next' on 2019-02-23

 A new hook "post-index-change" is called when the on-disk index
 file changes, which can help e.g. a virtualized working tree
 implementation.


* bs/sendemail-tighten-anything-by (2019-04-04) 1 commit
  (merged to 'next' on 2019-04-22 at 0a0680f234)
 + send-email: don't cc *-by lines with '-' prefix

 The recently added feature to add addresses that are on
 anything-by: trailers in 'git send-email' was found to be way too
 eager and considered nonsense strings as if they can be legitimate
 beginning of *-by: trailer.  This has been tightened.


* dk/blame-keep-origin-blob (2019-04-03) 1 commit
  (merged to 'next' on 2019-04-16 at 39679dde8b)
 + blame.c: don't drop origin blobs as eagerly

 Performance fix around "git blame", especially in a linear history
 (which is the norm we should optimize for).


* dl/submodule-set-branch (2019-04-10) 3 commits
  (merged to 'next' on 2019-04-22 at 3b640715ae)
 + submodule: teach set-branch subcommand
 + submodule--helper: teach config subcommand --unset
 + git-submodule.txt: "--branch <branch>" option defaults to 'master'

 "git submodule" learns "set-branch" subcommand that allows the
 submodule.*.branch settings to be modified.


* en/fast-import-parsing-fix (2019-04-01) 5 commits
  (merged to 'next' on 2019-04-16 at b318831bde)
 + fast-import: fix erroneous handling of get-mark with empty orphan comm=
its
 + fast-import: only allow cat-blob requests where it makes sense
 + fast-import: check most prominent commands first
 + git-fast-import.txt: fix wording about where ls command can appear
 + t9300: demonstrate bug with get-mark and empty orphan commits

 "git fast-import" update.


* jc/gettext-test-fix (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at 7c57deeb04)
 + gettext tests: export the restored GIT_TEST_GETTEXT_POISON

 The GETTEXT_POISON test option has been quite broken ever since it
 was made runtime-tunable, which has been fixed.


* jk/fetch-reachability-error-fix (2019-04-15) 7 commits
  (merged to 'next' on 2019-04-22 at b4ce8375c0)
 + fetch: do not consider peeled tags as advertised tips
 + remote.c: make singular free_ref() public
 + fetch: use free_refs()
 + pkt-line: prepare buffer before handling ERR packets
 + upload-pack: send ERR packet for non-tip objects
 + t5530: check protocol response for "not our ref"
 + t5516: drop ok=3Dsigpipe from unreachable-want tests

 Code clean-up and a fix for "git fetch" by an explicit object name
 (as opposed to fetching refs by name).


* jk/revision-rewritten-parents-in-prio-queue (2019-04-04) 1 commit
  (merged to 'next' on 2019-04-16 at bdc1465128)
 + revision: use a prio_queue to hold rewritten parents

 Performance fix for "rev-list --parents -- pathspec".


* jk/server-info-rabbit-hole (2019-04-16) 13 commits
  (merged to 'next' on 2019-04-16 at 3dded8be9a)
 + update_info_refs(): drop unused force parameter
 + server-info: drop objdirlen pointer arithmetic
 + server-info: drop nr_alloc struct member
 + server-info: use strbuf to read old info/packs file
 + server-info: simplify cleanup in parse_pack_def()
 + server-info: fix blind pointer arithmetic
 + http: simplify parsing of remote objects/info/packs
 + packfile: fix pack basename computation
 + midx: check both pack and index names for containment
 + t5319: drop useless --buffer from cat-file
 + t5319: fix bogus cat-file argument
 + pack-revindex: open index if necessary
 + packfile.h: drop extern from function declarations

 Code clean-up around a much-less-important-than-it-used-to-be
 update_server_info() funtion.


* jk/unused-params-even-more (2019-03-21) 13 commits
  (merged to 'next' on 2019-04-10 at 12edf8872f)
 + parse_opt_ref_sorting: always use with NONEG flag
 + pretty: drop unused strbuf from parse_padding_placeholder()
 + pretty: drop unused "type" parameter in needs_rfc2047_encoding()
 + parse-options: drop unused ctx parameter from show_gitcomp()
 + fetch_pack(): drop unused parameters
 + report_path_error(): drop unused prefix parameter
 + unpack-trees: drop unused error_type parameters
 + unpack-trees: drop name_entry from traverse_by_cache_tree()
 + test-date: drop unused "now" parameter from parse_dates()
 + update-index: drop unused prefix_length parameter from do_reupdate()
 + log: drop unused "len" from show_tagger()
 + log: drop unused rev_info from early output
 + revision: drop some unused "revs" parameters

 Code cleanup.


* jk/xmalloc (2019-04-12) 4 commits
  (merged to 'next' on 2019-04-22 at 1a907289fa)
 + progress: use xmalloc/xcalloc
 + xdiff: use xmalloc/xrealloc
 + xdiff: use git-compat-util
 + test-prio-queue: use xmalloc

 The code is updated to check the result of memory allocation before
 it is used in more places, by using xmalloc and/or xcalloc calls.


* js/difftool-no-index (2019-03-18) 3 commits
  (merged to 'next' on 2019-04-16 at 7313f9ff18)
 + difftool: allow running outside Git worktrees with --no-index
 + parse-options: make OPT_ARGUMENT() more useful
 + difftool: remove obsolete (and misleading) comment

 "git difftool" can now run outside a repository.


* js/iso8895-test-on-apfs (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at c2fadead33)
 + t9822: skip tests if file names cannot be ISO-8859-1 encoded

 Test fix on APFS that is incapable of store paths in Latin-1.


* js/macos-gettext-build (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at de4cbb1431)
 + macOS: make sure that gettext is found

 Build with gettext breaks on recent macOS w/ Homebrew when
 /usr/local/bin is not on PATH, which has been corrected.


* js/t3301-unbreak-notes-test (2019-04-09) 1 commit
  (merged to 'next' on 2019-04-22 at a015b00bd9)
 + t3301: fix false negative

 Test fix.


* js/untracked-cache-allocfix (2019-04-12) 1 commit
  (merged to 'next' on 2019-04-22 at 004a544075)
 + untracked cache: fix off-by-one
 (this branch is used by jk/untracked-cache-more-fixes.)

 An underallocation in the code to read the untracked cache
 extension has been corrected.


* jt/batch-fetch-blobs-in-diff (2019-04-08) 2 commits
  (merged to 'next' on 2019-04-22 at 0598bae567)
 + diff: batch fetching of missing blobs
 + sha1-file: support OBJECT_INFO_FOR_PREFETCH
 (this branch is used by cc/multi-promisor.)

 While running "git diff" in a lazy clone, we can upfront know which
 missing blobs we will need, instead of waiting for the on-demand
 machinery to discover them one by one.  Aim to achieve better
 performance by batching the request for these promised blobs.


* jt/fetch-no-update-shallow-in-proto-v2 (2019-04-01) 3 commits
  (merged to 'next' on 2019-04-16 at 05c5ebe471)
 + fetch-pack: respect --no-update-shallow in v2
 + fetch-pack: call prepare_shallow_info only if v0
 + Merge branch 'jt/test-protocol-version' into jt/fetch-no-update-shallo=
w-in-proto-v2

 Fix for protocol v2 support in "git fetch-pack" of shallow clones.


* jt/fetch-pack-wanted-refs-optim (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at 051f6bd38a)
 + fetch-pack: binary search when storing wanted-refs

 Performance fix around "git fetch" that grabs many refs.


* km/t3000-retitle (2019-04-12) 1 commit
  (merged to 'next' on 2019-04-22 at 2d5aa01ca6)
 + t3000 (ls-files -o): widen description to reflect current tests

 A test update.


* nd/checkout-m (2019-03-24) 4 commits
  (merged to 'next' on 2019-04-16 at 4d7c322bed)
 + checkout: prevent losing staged changes with --merge
 + read-tree: add --quiet
 + unpack-trees: rename "gently" flag to "quiet"
 + unpack-trees: keep gently check inside add_rejected_path

 "git checkout -m <other>" was about carrying the differences
 between HEAD and the working-tree files forward while checking out
 another branch, and ignored the differences between HEAD and the
 index.  The command has been taught to abort when the index and the
 HEAD are different.


* nd/commit-a-with-paths-msg-update (2019-03-22) 1 commit
  (merged to 'next' on 2019-04-16 at a36c712b39)
 + commit: improve error message in "-a <paths>" case

 The message given when "git commit -a <paths>" errors out has been
 updated.


* nd/diff-parseopt-4 (2019-03-24) 20 commits
  (merged to 'next' on 2019-04-10 at 893b135f10)
 + am: avoid diff_opt_parse()
 + diff --no-index: use parse_options() instead of diff_opt_parse()
 + range-diff: use parse_options() instead of diff_opt_parse()
 + diff.c: allow --no-color-moved-ws
 + diff-parseopt: convert --color-moved-ws
 + diff-parseopt: convert --[no-]color-moved
 + diff-parseopt: convert --inter-hunk-context
 + diff-parseopt: convert --no-prefix
 + diff-parseopt: convert --line-prefix
 + diff-parseopt: convert --[src|dst]-prefix
 + diff-parseopt: convert --[no-]abbrev
 + diff-parseopt: convert --diff-filter
 + diff-parseopt: convert --find-object
 + diff-parseopt: convert -O
 + diff-parseopt: convert --pickaxe-all|--pickaxe-regex
 + diff-parseopt: convert -S|-G
 + diff-parseopt: convert -l
 + diff-parseopt: convert -z
 + diff-parseopt: convert --ita-[in]visible-in-index
 + diff-parseopt: convert --ws-error-highlight

 Fourth batch to teach the diff machinery to use the parse-options
 API.


* nd/submodule-foreach-quiet (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at bf982bca7b)
 + submodule foreach: fix "<command> --quiet" not being respected

 "git submodule foreach <command> --quiet" did not pass the option
 down correctly, which has been corrected.


* po/describe-not-necessarily-7 (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at 65b47ca73f)
 + describe doc: remove '7-char' abbreviation reference

 Docfix.


* po/rerere-doc-fmt (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at 780c0d2450)
 + rerere doc: quote `rerere.enabled`

 Docfix.


* pw/cherry-pick-continue (2019-03-18) 3 commits
  (merged to 'next' on 2019-04-16 at 1bfd7a7179)
 + cherry-pick --continue: remember options
 + cherry-pick: demonstrate option amnesia
 + sequencer: break some long lines

 "git cherry-pick --options A..B", after giving control back to the
 user to ask help resolving a conflicted step, did not honor the
 options it originally received, which has been corrected.


* sg/blame-in-bare-start-at-head (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at 159777c280)
 + blame: default to HEAD in a bare repo when no start commit is given

 "git blame -- path" in a non-bare repository starts blaming from
 the working tree, and the same command in a bare repository errors
 out because there is no working tree by definition.  The command
 has been taught to instead start blaming from the commit at HEAD,
 which is more useful.


* sg/index-pack-progress (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at a10bfdd950)
 + index-pack: show progress while checking objects

 A progress indicator has been added to the "index-pack" step, which
 often makes users wait for completion during "git clone".


* sg/overlong-progress-fix (2019-04-15) 4 commits
  (merged to 'next' on 2019-04-22 at 69921cdf09)
 + progress: break too long progress bar lines
 + progress: clear previous progress update dynamically
 + progress: assemble percentage and counters in a strbuf before printing
 + progress: make display_progress() return void

 Updating the display with progress message has been cleaned up to
 deal better with overlong messages.


* sg/test-atexit (2019-03-14) 11 commits
  (merged to 'next' on 2019-04-10 at 7839135291)
 + t9811-git-p4-label-import: fix pipeline negation
 + git p4 test: disable '-x' tracing in the p4d watchdog loop
 + git p4 test: simplify timeout handling
 + git p4 test: clean up the p4d cleanup functions
 + git p4 test: use 'test_atexit' to kill p4d and the watchdog process
 + t0301-credential-cache: use 'test_atexit' to stop the credentials help=
er
 + tests: use 'test_atexit' to stop httpd
 + git-daemon: use 'test_atexit` to stop 'git-daemon'
 + test-lib: introduce 'test_atexit'
 + t/lib-git-daemon: make sure to kill the 'git-daemon' process
 + test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'

 Test framework update to more robustly clean up leftover files and
 processes after tests are done.


* tg/ls-files-debug-format-fix (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at a5ac1ca49f)
 + ls-files: use correct format string

 Debugging code fix.


* tz/doc-apostrophe-no-longer-needed (2019-04-10) 1 commit
  (merged to 'next' on 2019-04-22 at 8ff03863ce)
 + Documentation/git-show-branch: avoid literal {apostrophe}

 Doc formatting fix.

--------------------------------------------------
[New Topics]

* jc/make-dedup-ls-files-output (2019-04-22) 1 commit
 - Makefile: dedup list of files obtained from ls-files

 A "ls-files" that emulates "find" to enumerate files in the working
 tree resulted in duplicated Makefile rules that caused the build to
 issue an unnecessary warning during a trial build after merge
 conflicts are resolved in working tree *.h files but before the
 resolved results are added to the index.  This has been corrected.

 Will merge to 'next'.
 A not-so-low hanging fruit to teach ls-files to dedup either optionally
 or always has also been discussed, which probably is a good idea,
 to prevent mistakes similar to the bug this topic fixes in the future.


* jk/ls-files-doc-markup-fix (2019-04-23) 1 commit
 - doc/ls-files: put nested list for "-t" option into block

 Docfix.

 Will merge to 'next'.


* jk/p5302-avoid-collision-check-cost (2019-04-23) 1 commit
 - p5302: create the repo in each index-pack test

 Fix index-pack perf test so that the repeated invocations always
 run in an empty repository, which emulates the initial clone
 situation better.

 Will merge to 'next'.


* dl/rev-tilde-doc-clarify (2019-04-24) 1 commit
 - revisions.txt: mention <rev>~ form

 Docfix.

 Will merge to 'next'.


* en/unicode-in-refnames (2019-04-24) 1 commit
 - Honor core.precomposeUnicode in more places

 The names of the refs stored as filesystem entities may become
 different from what the end-user expects, just like files in the
 working tree gets "renamed", on a filesystem like HFS+.  Work it
 around by paying attemption to the core.precomposeUnicode
 configuration.

 Looked sensible.  Ready for next?


* jk/perf-aggregate-wo-libjson (2019-04-24) 1 commit
 - t/perf: depend on perl JSON only when using --codespeed

 The script to aggregate perf result unconditionally depended on
 libjson-perl even though it did not have to, which has been
 corrected.

 Will merge to 'next'.


* cc/access-on-aix-workaround (2019-04-25) 1 commit
 - git-compat-util: work around for access(X_OK) under root
 (this branch uses cc/aix-has-fileno-as-a-macro.)


* dl/difftool-mergetool (2019-04-25) 6 commits
 - difftool: fallback on merge.guitool
 - difftool: make --gui, --tool and --extcmd mutually exclusive
 - mergetool: fallback to tool when guitool unavailable
 - mergetool: use get_merge_tool function
 - t7610: add mergetool --gui tests
 - t7610: unsuppress output

--------------------------------------------------
[Stalled]

* nb/branch-show-other-worktrees-head (2019-03-18) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Getting there...
 cf. <20190316013807.38756-1-nbelakovski@gmail.com> (v9)
 cf. <20190318121054.GC24175@szeder.dev>


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

 Still being discussed.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


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

* ds/midx-expire-repack (2019-04-25) 11 commits
 - t5319-multi-pack-index.sh: test batch size zero
 - midx: add test that 'expire' respects .keep files
 - multi-pack-index: test expire while adding packs
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' subcommand
 - midx: refactor permutation logic and pack sorting
 - midx: simplify computation of pack name lengths
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use

 "git multi-pack-index expire/repack" are new subcommands that
 consult midx file and are used to drop unused pack files and
 coalesce small pack files that are still in use.

 cf. <20190424151428.170316-1-dstolee@microsoft.com> (v5)


* es/first-contrib-tutorial (2019-04-25) 1 commit
 - documentation: add tutorial for first contribution

 A new tutorial targetting specifically aspiring git-core
 developers.

 cf. <20190423193410.101803-1-emilyshaffer@google.com> (v4)


* pw/clean-sequencer-state-upon-final-commit (2019-04-17) 2 commits
 - fix cherry-pick/revert status after commit
 - commit/reset: try to clean up sequencer state

 "git chery-pick" (and "revert" that shares the same runtime engine)
 that deals with multiple commits got confused when the final step
 gets stopped with a conflict and the user concluded the sequence
 with "git commit".  Attempt to fix it by cleaning up the state
 files used by these commands in such a situation.

 Will merge to 'next'.


* pw/sequencer-cleanup-with-signoff-x-fix (2019-04-18) 1 commit
  (merged to 'next' on 2019-04-25 at cc587fb2b9)
 + sequencer: fix cleanup with --signoff and -x
 (this branch is used by dl/merge-cleanup-scissors-fix.)

 "git cherry-pick" run with the "-x" or the "--signoff" option used
 to (and more importantly, ought to) clean up the commit log message
 with the --cleanup=3Dspace option by default, but this has been
 broken since late 2017.  This has been fixed.

 Will merge to 'master'.


* dr/ref-filter-push-track-fix (2019-04-18) 1 commit
  (merged to 'next' on 2019-04-25 at 07db067adc)
 + ref-filter: use correct branch for %(push:track)

 %(push:track) token used in the --format option to "git
 for-each-ref" and friends was not showing the right branch, which
 has been fixed.

 Will merge to 'master'.


* cc/aix-has-fileno-as-a-macro (2019-04-25) 1 commit
  (merged to 'next' on 2019-04-25 at f1d6464f98)
 + Makefile: use fileno macro work around on AIX
 (this branch is used by cc/access-on-aix-workaround.)

 AIX shared the same build issues with other BSDs around fileno(fp),
 which has been corrected.

 Will merge to 'master'.


* jk/prune-optim (2019-04-19) 1 commit
  (merged to 'next' on 2019-04-25 at c50353b27f)
 + t5304: add a test for pruning with bitmaps

 A follow-up test for an earlier "git prune" improvements.

 Will merge to 'master'.


* jk/untracked-cache-more-fixes (2019-04-19) 3 commits
  (merged to 'next' on 2019-04-25 at a6037ddd54)
 + untracked-cache: simplify parsing by dropping "len"
 + untracked-cache: simplify parsing by dropping "next"
 + untracked-cache: be defensive about missing NULs in index

 Code clean-up.

 Will merge to 'master'.


* jt/submodule-repo-is-with-worktree (2019-04-21) 1 commit
  (merged to 'next' on 2019-04-25 at da2c6d684d)
 + worktree: update is_bare heuristics

 The logic to tell if a Git repository has a working tree protects
 "git branch -D" from removing the branch that is currently checked
 out by mistake.  The implementation of this logic was broken for
 repositories with unusual name, which unfortunately is the norm for
 submodules these days.  This has been fixed.

 Will merge to 'master'.


* vk/autoconf-gettext (2019-04-19) 1 commit
  (merged to 'next' on 2019-04-25 at 918870cbc2)
 + autoconf: #include <libintl.h> when checking for gettext()

 The autoconf generated configure script failed to use the right
 gettext() implementations from -libintl by ignoring useless stub
 implementations shipped in some C library, which has been
 corrected.

 Will merge to 'master'.


* dl/no-extern-in-func-decl (2019-04-24) 4 commits
 - cocci: prevent extern function declarations
 - *.[ch]: manually align parameter lists
 - *.[ch]: remove extern from function declarations using sed
 - *.[ch]: remove extern from function declarations using spatch

 Mechanically and systematically drop "extern" from function
 declarlation.

 Will merge to 'next'.

 This is the kind of code churn patch that causes heavy conflicts
 with multiple topics in flight, which causes conflicts in slightly
 different shape when it gets merged with them in different order.
 I've queued it moderately early in 'pu' for the night, and I am
 reasonably sure the merge of the topic itself is OK, but I do not
 have much confidence in the resolutions of conflicts with other
 topics later merged to 'pu'.


* js/partial-clone-connectivity-check (2019-04-21) 1 commit
  (merged to 'next' on 2019-04-25 at ebd8b4bffd)
 + clone: do faster object check for partial clones

 During an initial "git clone --depth=3D..." partial clone, it is
 pointless to spend cycles for a large portion of the connectivity
 check that enumerates and skips promisor objects (which by
 definition is all objects fetched from the other side).  This has
 been optimized out.

 Will merge to 'master'.


* hs/send-email-transferencoding-fix (2019-04-10) 1 commit
 - send-email: honor transferencoding config option again

 Since "git send-email" learned to take 'auto' as the value for the
 transfer-encoding, it by mistake stopped honoring the values given
 to the configuration variables sendemail.transferencoding and/or
 sendemail.<ident>.transferencoding.  Attempt to correct this.

 Not quite.
 cf. <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>


* jk/pack-objects-reports-num-objects-to-trace2 (2019-04-12) 1 commit
  (merged to 'next' on 2019-04-25 at e79464c054)
 + pack-objects: write objects packed to trace2

 The "git pack-objects" command learned to report the number of
 objects it packed via the trace2 mechanism.

 Will merge to 'master'.


* js/misc-doc-fixes (2019-04-19) 8 commits
  (merged to 'next' on 2019-04-25 at 6898f709d0)
 + Turn `git serve` into a test helper
 + test-tool: handle the `-C <directory>` option just like `git`
 + check-docs: do not bother checking for legacy scripts' documentation
 + docs: exclude documentation for commands that have been excluded
 + check-docs: allow command-list.txt to contain excluded commands
 + help -a: do not list commands that are excluded from the build
 + Makefile: drop the NO_INSTALL variable
 + remote-testgit: move it into the support directory for t5801

 "make check-docs", "git help -a", etc. did not account for cases
 where a particular build may deliberately omit some subcommands,
 which has been corrected.

 Will merge to 'master'.


* dl/warn-tagging-a-tag (2019-04-12) 2 commits
  (merged to 'next' on 2019-04-25 at 8b966d7fe8)
 + tag: advise on nested tags
 + tag: fix formatting

 "git tag" learned to give an advice suggesting it might be a
 mistake when creating an annotated or signed tag that points at
 another tag.

 Will merge to 'master'.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=3DwhP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* tb/unexpected (2019-04-10) 7 commits
  (merged to 'next' on 2019-04-25 at c49927fca0)
 + rev-list: detect broken root trees
 + rev-list: let traversal die when --missing is not in use
 + get_commit_tree(): return NULL for broken tree
 + list-objects.c: handle unexpected non-tree entries
 + list-objects.c: handle unexpected non-blob entries
 + t: introduce tests for unexpected object types
 + t: move 'hex2oct' into test-lib-functions.sh

 Code tightening against a "wrong" object appearing where an object
 of a different type is expected, instead of blindly assuming that
 the connection between objects are correctly made.

 Will merge to 'master'.


* en/merge-directory-renames (2019-04-08) 15 commits
  (merged to 'next' on 2019-04-25 at fd5b4f57b4)
 + merge-recursive: switch directory rename detection default
 + merge-recursive: give callers of handle_content_merge() access to cont=
ents
 + merge-recursive: track information associated with directory renames
 + t6043: fix copied test description to match its purpose
 + merge-recursive: switch from (oid,mode) pairs to a diff_filespec
 + merge-recursive: cleanup handle_rename_* function signatures
 + merge-recursive: track branch where rename occurred in rename struct
 + merge-recursive: remove ren[12]_other fields from rename_conflict_info
 + merge-recursive: shrink rename_conflict_info
 + merge-recursive: move some struct declarations together
 + merge-recursive: use 'ci' for rename_conflict_info variable name
 + merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
 + merge-recursive: rename diff_filespec 'one' to 'o'
 + merge-recursive: rename merge_options argument from 'o' to 'opt'
 + Use 'unsigned short' for mode, like diff_filespec does

 "git merge-recursive" backend recently learned a new heuristics to
 infer file movement based on how other files in the same directory
 moved.  As this is inherently less robust heuristics than the one
 based on the content similarity of the file itself (rather than
 based on what its neighbours are doing), it sometimes gives an
 outcome unexpected by the end users.  This has been toned down to
 leave the renamed paths in higher/conflicted stages in the index so
 that the user can examine and confirm the result.

 Will merge to 'master'.


* jt/clone-server-option (2019-04-18) 2 commits
  (merged to 'next' on 2019-04-25 at 21f07cc85d)
 + clone: send server options when using protocol v2
 + transport: die if server options are unsupported

 "git clone" learned a new --server-option option when talking over
 the protocol version 2.

 Will merge to 'master'.


* tz/git-svn-doc-markup-fix (2019-04-10) 1 commit
  (merged to 'next' on 2019-04-25 at 3efaa6285c)
 + Documentation/git-svn: improve asciidoctor compatibility

 Doc formatting fix.

 Will merge to 'master'.


* ss/msvc-path-utils-fix (2019-04-09) 1 commit
  (merged to 'next' on 2019-04-25 at ee2850da18)
 + MSVC: include compat/win32/path-utils.h for MSVC, too, for real_path()

 An earlier update for MinGW and Cygwin accidentally broke MSVC build,
 which has been fixed.

 Will merge to 'master'.


* cc/multi-promisor (2019-04-15) 17 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - diff: use promisor-remote.h instead of fetch-object.h
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands
 - Merge branch 'jt/batch-fetch-blobs-in-diff' into cc/multi-promisor

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 Needs review.


* nd/switch-and-restore (2019-04-12) 43 commits
 - help: move git-diff and git-reset to different groups
 - rm: add --staged as alias for --cached
 - doc: promote "git restore"
 - user-manual.txt: prefer 'merge --abort' over 'reset --hard'
 - completion: support restore
 - t: add tests for restore
 - restore: support --patch
 - restore: replace --force with --ignore-unmerged
 - restore: default to --source=3DHEAD when only --staged is specified
 - restore: reject invalid combinations with --staged
 - restore: add --worktree and --staged
 - checkout: factor out worktree checkout code
 - restore: disable overlay mode by default
 - restore: make pathspec mandatory
 - restore: take tree-ish from --source option instead
 - checkout: split part of it to new command 'restore'
 - doc: promote "git switch"
 - completion: support switch
 - t: add tests for switch
 - switch: make --orphan switch to an empty tree
 - switch: reject if some operation is in progress
 - switch: no worktree status unless real branch switch happens
 - switch: implicit dwim, use --no-guess to disable it
 - switch: add short option for --detach
 - switch: only allow explicit detached HEAD
 - switch: reject "do nothing" case
 - switch: stop accepting pathspec
 - switch: remove -l
 - switch: add --discard-changes
 - switch: better names for -b and -B
 - checkout: split part of it to new command 'switch'
 - checkout: split options[] array in three pieces
 - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 - checkout: make "opts" in cmd_checkout() a pointer
 - checkout: factor out some code in parse_branchname_arg()
 - checkout: keep most #include sorted
 - checkout: inform the user when removing branch state
 - checkout: advice how to get out of detached HEAD mode
 - t: rename t2014-switch.sh to t2014-checkout-switch.sh
 - git-checkout.txt: fix monospace typeset
 - doc: document --overwrite-ignore
 - git-checkout.txt: fix one syntax line
 - git-checkout.txt: spell out --no-option

 Two new commands "git switch" and "git restore" are introduced to
 split "checking out a branch to work on advancing its history" and
 "checking out paths out of the index and/or a tree-ish to work on
 advancing the current history" out of the single "git checkout"
 command.

 The "switch" part seems more or less ready for testing.  Perhaps
 we should split this back into two topics and merge it to 'next'.
 cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
 cf. <20190411131218.19195-1-pclouds@gmail.com> (restore v2)


* ew/repack-with-bitmaps-by-default (2019-03-18) 3 commits
 - pack-objects: default to writing bitmap hash-cache
 - t5310: correctly remove bitmaps for jgit test
 - repack: enable bitmaps by default on bare repos

 The connectivity bitmaps are created by default in bare
 repositories now; also the pathname hash-cache is created by
 default to avoid making crappy deltas when repacking.

 Will merge to 'next'.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Undecided but inclined to discard.


* am/p4-branches-excludes (2019-04-02) 8 commits
 - git-p4: respect excluded paths when detecting branches
 - git-p4: add failing test for "git-p4: respect excluded paths when dete=
cting branches"
 - git-p4: don't exclude other files with same prefix
 - git-p4: add failing test for "don't exclude other files with same pref=
ix"
 - git-p4: don't groom exclude path list on every commit
 - git-p4: match branches case insensitively if configured
 - git-p4: add failing test for "git-p4: match branches case insensitivel=
y if configured"
 - git-p4: detect/prevent infinite loop in gitCommitByP4Change()

 "git p4" update.

 Is this ready for 'next'?


* cc/replace-graft-peel-tags (2019-04-15) 4 commits
  (merged to 'next' on 2019-04-25 at f8d0db27ba)
 + replace: peel tag when passing a tag first to --graft
 + replace: peel tag when passing a tag as parent to --graft
 + t6050: redirect expected error output to a file
 + t6050: use test_line_count instead of wc -l

 When given a tag that points at a commit-ish, "git replace --graft"
 failed to peel the tag before writing a replace ref, which did not
 make sense because the old graft mechanism the feature wants to
 mimick only allowed to replace one commit object with another.
 This has been fixed.

 Will merge to 'master'.


* dl/rebase-i-keep-base (2019-04-25) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 Will merge to 'next'.


* jh/trace2-sid-fix (2019-04-16) 10 commits
  (merged to 'next' on 2019-04-25 at a5c08f1226)
 + trace2: update docs to describe system/global config settings
 + trace2: make SIDs more unique
 + trace2: clarify UTC datetime formatting
 + trace2: report peak memory usage of the process
 + trace2: use system/global config for default trace2 settings
 + config: add read_very_early_config()
 + trace2: find exec-dir before trace2 initialization
 + trace2: add absolute elapsed time to start event
 + trace2: refactor setting process starting time
 + config: initialize opts structure in repo_read_config()

 Polishing of the new trace2 facility continues.  The system-level
 configuration can specify site-wide trace2 settings, which can be
 overridden with per-user configuration and environment variables.

 Will merge to 'master'.
 cf. <pull.169.v4.git.gitgitgadget@gmail.com> (v4)


* js/trace2-to-directory (2019-03-22) 1 commit
  (merged to 'next' on 2019-04-25 at 53adf71c41)
 + trace2: write to directory targets

 The trace2 tracing facility learned to auto-generate a filename
 when told to log to a directory.

 Will merge to 'master'.


* km/empty-repo-is-still-a-repo (2019-04-10) 3 commits
  (merged to 'next' on 2019-04-25 at bb3d4406a5)
 + add: error appropriately on repository with no commits
 + dir: do not traverse repositories with no commits
 + submodule: refuse to add repository with no commits

 Running "git add" on a repository created inside the current
 repository is an explicit indication that the user wants to add it
 as a submodule, but when the HEAD of the inner repository is on an
 unborn branch, it cannot be added as a submodule.  Worse, the files
 in its working tree can be added as if they are a part of the outer
 repository, which is not what the user wants.  These problems are
 being addressed.

 Will merge to 'master'.


* nd/precious (2019-04-09) 1 commit
 - Introduce "precious" file concept

 "git clean" learned to pay attention to the 'precious' attributes
 and keep untracked paths with the attribute instead of removing
 when the "--keep-precious" is given.

 Retracted.
 cf. <CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie2xtfc9w@mail.gmail.com>

 I am not sure what aspect of this longer-term "precious" vision,
 which gets taught to various commands and use cases individually
 and incrementally, =C3=86var finds problematic, which I understand is
 the reason of redtraction.


* nd/sha1-name-c-wo-the-repository (2019-04-16) 34 commits
  (merged to 'next' on 2019-04-25 at d826918329)
 + sha1-name.c: remove the_repo from get_oid_mb()
 + sha1-name.c: remove the_repo from other get_oid_*
 + sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
 + submodule-config.c: use repo_get_oid for reading .gitmodules
 + sha1-name.c: add repo_get_oid()
 + sha1-name.c: remove the_repo from get_oid_with_context_1()
 + sha1-name.c: remove the_repo from resolve_relative_path()
 + sha1-name.c: remove the_repo from diagnose_invalid_index_path()
 + sha1-name.c: remove the_repo from handle_one_ref()
 + sha1-name.c: remove the_repo from get_oid_1()
 + sha1-name.c: remove the_repo from get_oid_basic()
 + sha1-name.c: remove the_repo from get_describe_name()
 + sha1-name.c: remove the_repo from get_oid_oneline()
 + sha1-name.c: add repo_interpret_branch_name()
 + sha1-name.c: remove the_repo from interpret_branch_mark()
 + sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
 + sha1-name.c: remove the_repo from get_short_oid()
 + sha1-name.c: add repo_for_each_abbrev()
 + sha1-name.c: store and use repo in struct disambiguate_state
 + sha1-name.c: add repo_find_unique_abbrev_r()
 + sha1-name.c: remove the_repo from find_abbrev_len_packed()
 + sha1-name.c: remove the_repo from sort_ambiguous()
 + commit.c: add repo_get_commit_tree()
 + commit.cocci: refactor code, avoid double rewrite
 + refs.c: remove the_repo from read_ref_at()
 + refs.c: add repo_dwim_log()
 + refs.c: add repo_dwim_ref()
 + refs.c: remove the_repo from expand_ref()
 + refs.c: remove the_repo from substitute_branch_name()
 + refs.c: add refs_shorten_unambiguous_ref()
 + refs.c: add refs_ref_exists()
 + packfile.c: add repo_approximate_object_count()
 + builtin rebase: use oideq()
 + builtin rebase: use FREE_AND_NULL

 Further code clean-up to allow the lowest level of name-to-object
 mapping layer to work with a passed-in repository other than the
 default one.

 Will merge to 'master'.


* pw/rebase-i-internal (2019-04-19) 13 commits
 - rebase -i: run without forking rebase--interactive
 - rebase: use a common action enum
 - rebase -i: use struct rebase_options in do_interactive_rebase()
 - rebase -i: use struct rebase_options to parse args
 - rebase -i: use struct object_id for squash_onto
 - rebase -i: use struct commit when parsing options
 - rebase -i: remove duplication
 - rebase -i: combine rebase--interactive.c with rebase.c
 - rebase: use OPT_RERERE_AUTOUPDATE()
 - rebase: rename write_basic_state()
 - rebase: don't translate trace strings
 - sequencer: always discard index after checkout
 - Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-int=
ernal

 The internal implementation of "git rebase -i" has been updated to
 avoid forking a separate "rebase--interactive" process.

 Will merge to 'next'.


* nd/worktree-name-sanitization (2019-03-20) 2 commits
 - SQUASH???
 - worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are well-formed.

 I am inclined to squash the fix at the tip in and merge the result
 to 'next'.  Opinions?


* dm/some-stdio-functions-are-macro-on-freebsd (2019-02-01) 1 commit
 - http: cast result to FILE *

 Variants of BSD define fileno(fh) as a macro, breaking a program
 that passes a "void *" to it.

 Expecting a reroll.
 cf. <49B9198C-53E5-42BD-8834-B1EDEB3332CB@usask.ca>


* ds/commit-graph-format-v2 (2019-04-25) 5 commits
 - commit-graph: implement file format version 2
 - commit-graph: add --version=3D<n> option
 - commit-graph: create new version flags
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write

 Introduce version 2 of the commit-graph format to correct
 deficiency in the initial version.

 cf. <pull.112.v2.git.gitgitgadget@gmail.com> (v2)


* br/blame-ignore (2019-04-14) 6 commits
 - blame: use a fingerprint heuristic to match ignored lines
 - blame: optionally track line fingerprints during fill_blame_origin()
 - blame: add config options to handle output for ignored lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Expecting a reroll.
 cf. <20190410162409.117264-1-brho@google.com> (v6)
 cf. <a742dd62-c84e-1f85-0663-4a3aa4d14989@google.com>
 cf. <3db6bad3-e7a5-af1d-3fe2-321bd17db2c6@google.com>


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* dl/merge-cleanup-scissors-fix (2019-04-19) 10 commits
  (merged to 'next' on 2019-04-25 at 2014eef6b1)
 + cherry-pick/revert: add scissors line on merge conflict
 + sequencer.c: save and restore cleanup mode
 + merge: add scissors line on merge conflict
 + merge: cleanup messages like commit
 + parse-options.h: extract common --cleanup option
 + commit: extract cleanup_mode functions to sequencer
 + t7502: clean up style
 + t7604: clean up style
 + t3507: clean up style
 + t7600: clean up style
 (this branch uses pw/sequencer-cleanup-with-signoff-x-fix.)

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Will merge to 'master'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.

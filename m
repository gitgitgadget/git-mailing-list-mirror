Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B53C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9C821852
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="em/YESNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgFRGfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:35:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59584 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgFRGf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 02:35:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52C27CD19C;
        Thu, 18 Jun 2020 02:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=v
        Gn1+xbswSxBzpHCVFjSCl0SEkU=; b=em/YESNRV5Njs4uuesM6ibA6C5YKlQxnH
        M00kFqO7nBkj6p2qq8MyAnGlpCWx7JaYYwG1Vm61WWr1Wv5F000C6lDNQdC/tTtH
        JgPfiT7nampR+G4+uVYoHE+56xFZhuw2fh3xPR1fQSmUadPwSrsYqdLxbt3LzTIt
        RD4Mpdxb6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=PyP
        tB6HC/PSiWS6eFaJU3iykF2hcN5eObQ7aExaMkwRey5TVNh5TXCKWMkRDUoG7eL8
        KQ0JkncQF4ktDMJqulEgd4FwABZfjaKDPna4VuVGbvce1l54KMFMrc1bUPedQ+Qn
        v00D9XNyvcLo2z/eAVM1LJPxoPjyWx0Zmj2OFMPs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37272CD19B;
        Thu, 18 Jun 2020 02:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73325CD19A;
        Thu, 18 Jun 2020 02:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2020, #03; Wed, 17)
X-master-at: 101b3204f37606972b40fc17dec84560c22f69f6
X-next-at: f2d1464379e7567b01b55fbf8432e75d72aa537f
Date:   Wed, 17 Jun 2020 23:35:18 -0700
Message-ID: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E19AB206-B12D-11EA-A2AC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The third batch of topics are now in 'master'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* dl/python-2.7-is-the-floor-version (2020-06-08) 1 commit
  (merged to 'next' on 2020-06-10 at ad3269ff40)
 + CodingGuidelines: specify Python 2.7 is the oldest version

 Document that we do not support Python 2.6 or older.


* dl/t-readme-spell-git-correctly (2020-06-08) 1 commit
  (merged to 'next' on 2020-06-10 at 60144a59ed)
 + t/README: avoid poor-man's small caps GIT

 Doc updates.


* en/do-match-pathspec-fix (2020-06-05) 1 commit
  (merged to 'next' on 2020-06-10 at 2e63c8c0fc)
 + dir: fix treatment of negated pathspecs

 Use of negative pathspec, while collecting paths including
 untracked ones in the working tree, was broken.


* en/sparse-checkout (2020-06-05) 1 commit
  (merged to 'next' on 2020-06-10 at 697a10b031)
 + sparse-checkout: avoid staging deletions of all files

 The behaviour of "sparse-checkout" in the state "git clone
 --no-checkout" left was changed accidentally in 2.27, which has
 been corrected.


* es/advertise-contribution-doc (2020-06-08) 1 commit
  (merged to 'next' on 2020-06-10 at c72c7da667)
 + docs: mention MyFirstContribution in more places

 Doc updates.


* hn/refs-cleanup (2020-06-09) 6 commits
  (merged to 'next' on 2020-06-09 at abb59f83a2)
 + reftable: define version 2 of the spec to accomodate SHA256
 + reftable: clarify how empty tables should be written
 + reftable: file format documentation
 + refs: improve documentation for ref iterator
 + t: use update-ref and show-ref to reading/writing refs
 + refs.h: clarify reflog iteration order
 (this branch is used by hn/reftable.)

 Preliminary clean-ups around refs API, plus file format
 specification documentation for the reftable backend.


* jk/diff-memuse-optim-with-stat-unmatch (2020-06-02) 1 commit
  (merged to 'next' on 2020-06-10 at 4cea3bfaac)
 + diff: discard blob data from stat-unmatched pairs

 Reduce memory usage during "diff --quiet" in a worktree with too
 many stat-unmatched paths.


* js/fuzz-commit-graph-leakfix (2020-06-08) 1 commit
  (merged to 'next' on 2020-06-10 at 92944ed7f6)
 + fuzz-commit-graph: properly free graph struct

 Leakfix.


* js/msvc-build-fix (2020-06-04) 1 commit
  (merged to 'next' on 2020-06-10 at 167a629359)
 + msvc: fix "REG_STARTEND" issue

 Workaround breakage in MSVC build, where "curl-config --cflags"
 gives settings appropriate for GCC build.


* js/reflog-anonymize-for-clone-and-fetch (2020-06-04) 1 commit
  (merged to 'next' on 2020-06-10 at 2901ff943e)
 + clone/fetch: anonymize URLs in the reflog

 The reflog entries for "git clone" and "git fetch" did not
 anonymize the URL they operated on.


* tb/t5318-cleanup (2020-06-04) 2 commits
  (merged to 'next' on 2020-06-10 at 5a72620cbe)
 + t5318: test that '--stdin-commits' respects '--[no-]progress'
 + t5318: use 'test_must_be_empty'

 Code cleanup.

--------------------------------------------------
[New Topics]

* cc/upload-pack-data-3 (2020-06-11) 14 commits
  (merged to 'next' on 2020-06-17 at 393eff577a)
 + upload-pack: refactor common code into do_got_oid()
 + upload-pack: move oldest_have to upload_pack_data
 + upload-pack: pass upload_pack_data to got_oid()
 + upload-pack: pass upload_pack_data to ok_to_give_up()
 + upload-pack: pass upload_pack_data to send_acks()
 + upload-pack: pass upload_pack_data to process_haves()
 + upload-pack: change allow_unadvertised_object_request to an enum
 + upload-pack: move allow_unadvertised_object_request to upload_pack_data
 + upload-pack: move extra_edge_obj to upload_pack_data
 + upload-pack: move shallow_nr to upload_pack_data
 + upload-pack: pass upload_pack_data to send_unshallow()
 + upload-pack: pass upload_pack_data to deepen_by_rev_list()
 + upload-pack: pass upload_pack_data to deepen()
 + upload-pack: pass upload_pack_data to send_shallow_list()
 (this branch uses cc/upload-pack-data-2)

 Code clean-up in the codepath that serves "git fetch" continues.

 Will merge to 'master'.


* ct/diff-with-merge-base-clarification (2020-06-12) 3 commits
  (merged to 'next' on 2020-06-17 at e0b54a001c)
 + Documentation: usage for diff combined commits
 + git diff: improve range handling
 + t/t3430: avoid undefined git diff behavior

 "git diff" used to take arguments in random and nonsense range
 notation, e.g. "git diff A..B C", "git diff A..B C...D", etc.,
 which has been cleaned up.

 Will merge to 'master'.


* js/default-branch-name (2020-06-10) 9 commits
 - Document how the default branch name can be overridden
 - fast-export: respect the possibly-overridden default branch name
 - fmt-merge-msg: learn about the possibly-configured default branch name
 - clone: learn about the possibly-configured default branch name
 - submodule: use the (possibly overridden) default branch name
 - testsvn: respect `core.defaultBranchName`
 - send-pack/transport-helper: respect `core.defaultBranchName`
 - remote: respect `core.defaultBranchName`
 - init: allow overriding the default branch name for new repositories

 The name of the primary branch in existing repositories, and the
 default name used for the first branch in newly created
 repositories, is made configurable, so that we can eventually wean
 ourselves off of the hardcoded 'master'.

 Expecting a reroll.


* jt/cdn-offload (2020-06-17) 10 commits
 - upload-pack: fix a sparse '0 as NULL pointer' warning
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http-fetch: refactor into function
 - http: refactor finish_http_pack_request()
 - http: use --stdin when indexing dumb HTTP pack
 (this branch uses cc/upload-pack-data-2)

 The "fetch/clone" protocol has been updated to allow the server to
 instruct the clients to grab pre-packaged packfile(s) in addition
 to the packed object data coming over the wire.

 Will merge to 'next'.


* ss/cmake-build (2020-06-12) 8 commits
 - ci: modification of main.yml to use cmake for vs-build job
 - cmake: support for building git on windows with msvc and clang.
 - cmake: support for building git on windows with mingw
 - cmake: support for testing git when building out of the source tree
 - cmake: support for testing git with ctest
 - cmake: installation support for git
 - cmake: generate the shell/perl/python scripts and templates, translations
 - Introduce CMake support for configuring Git

 CMake support to build with MSVC for Windows bypassing the Makefile.

 Almost there.


* ak/commit-graph-to-slab (2020-06-17) 4 commits
 - commit-graph: minimize commit_graph_data_slab access
 - commit: move members graph_pos, generation to a slab
 - commit-graph: introduce commit_graph_data_slab
 - object: drop parsed_object_pool->commit_count

 A few fields in "struct commit" that do not have to always be
 present have been moved to commit slabs.


* en/clean-cleanups (2020-06-12) 4 commits
  (merged to 'next' on 2020-06-17 at 2c4ec990a6)
 + clean: optimize and document cases where we recurse into subdirectories
 + clean: consolidate handling of ignored parameters
 + dir, clean: avoid disallowed behavior
 + dir: fix a few confusing comments

 "git clean" code clean-up that resulted in a fix of recent
 performance regression.

 Will merge to 'master'.


* dl/branch-cleanup (2020-06-17) 3 commits
 - branch: don't mix --edit-description
 - t3200: test for specific errors
 - t3200: rename "expected" to "expect"

 Code clean-up around "git branch" with a minor bugfix.

 Will merge to 'next'.


* ds/merge-base-is-ancestor-optim (2020-06-17) 2 commits
 - commit-reach: use fast logic in repo_in_merge_base
 - commit-reach: create repo_is_descendant_of()

 "git merge-base --is-ancestor" is taught to take advantage of the
 commit graph.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* mr/bisect-in-c-2 (2020-04-23) 12 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: fix `cmd_*()` function switch default return

 Rewrite of the remainder of "git bisect" script in C continues.

 Expecting a response to reviews.
 cf. <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* dl/test-must-fail-fixes-5 (2020-06-12) 4 commits
 - lib-submodule-update: use callbacks in test_submodule_switch_common()
 - lib-submodule-update: prepend "git" to $command
 - lib-submodule-update: consolidate --recurse-submodules
 - lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.

 Ready???


* jt/redact-all-cookies (2020-06-05) 1 commit
  (merged to 'next' on 2020-06-12 at 912c337d63)
 + http: redact all cookies, teach GIT_TRACE_REDACT=0

 The interface to redact sensitive information in the trace output
 has been simplified.

 Will merge to 'master'.


* es/worktree-duplicate-paths (2020-06-10) 7 commits
  (merged to 'next' on 2020-06-12 at 5f7c822a9d)
 + worktree: make "move" refuse to move atop missing registered worktree
 + worktree: generalize candidate worktree path validation
 + worktree: prune linked worktree referencing main worktree path
 + worktree: prune duplicate entries referencing same worktree path
 + worktree: make high-level pruning re-usable
 + worktree: give "should be pruned?" function more meaningful name
 + worktree: factor out repeated string literal

 The same worktree directory must be registered only once, but
 "git worktree move" allowed this invariant to be violated, which
 has been corrected.

 Will merge to 'master'.


* sg/commit-graph-cleanups (2020-06-17) 18 commits
 - commit-graph: persist existence of changed-paths
 - commit-graph: change test to die on parse, not load
 - bloom: enforce a minimum size of 8 bytes
 - commit-graph: check all leading directories in changed path Bloom filters
 - commit-graph: check chunk sizes after writing
 - commit-graph: simplify chunk writes into loop
 - commit-graph: unify the signatures of all write_graph_chunk_*() functions
 - commit-graph: place bloom_settings in context
 - commit-graph: simplify write_commit_graph_file() #2
 - commit-graph: simplify write_commit_graph_file() #1
 - commit-graph: simplify parse_commit_graph() #2
 - commit-graph: simplify parse_commit_graph() #1
 - commit-graph: clean up #includes
 - diff.h: drop diff_tree_oid() & friends' return value
 - commit-slab: add a function to deep free entries on the slab
 - commit-graph-format.txt: all multi-byte numbers are in network byte order
 - commit-graph: fix parsing the Chunk Lookup table
 - tree-walk.c: don't match submodule entries for 'submod/anything'

 Code cleanup.


* cc/upload-pack-data-2 (2020-06-04) 13 commits
  (merged to 'next' on 2020-06-12 at ee63b70dc2)
 + upload-pack: move pack_objects_hook to upload_pack_data
 + upload-pack: move allow_sideband_all to upload_pack_data
 + upload-pack: move allow_ref_in_want to upload_pack_data
 + upload-pack: move allow_filter to upload_pack_data
 + upload-pack: move keepalive to upload_pack_data
 + upload-pack: pass upload_pack_data to upload_pack_config()
 + upload-pack: change multi_ack to an enum
 + upload-pack: move multi_ack to upload_pack_data
 + upload-pack: move filter_capability_requested to upload_pack_data
 + upload-pack: move use_sideband to upload_pack_data
 + upload-pack: move static vars to upload_pack_data
 + upload-pack: annotate upload_pack_data fields
 + upload-pack: actually use some upload_pack_data bitfields
 (this branch is used by cc/upload-pack-data-3 and jt/cdn-offload.)

 Further code clean-up.

 Will merge to 'master'.


* xl/upgrade-repo-format (2020-06-05) 4 commits
 - check_repository_format_gently(): refuse extensions for old repositories
 - sparse-checkout: upgrade repository to version 1 when enabling extension
 - fetch: allow adding a filter after initial clone
 - repository: add a helper function to perform repository format upgrade

 Allow runtime upgrade of the repository format version, which needs
 to be done carefully.

 There is a rather unpleasant backward compatibility worry with the
 last step of this series, but it is the right thing to do in the
 longer term.

 Will merge to 'next'.


* jk/complete-git-switch (2020-05-28) 16 commits
  (merged to 'next' on 2020-06-17 at 5b31140c0a)
 + completion: improve handling of --orphan option of switch/checkout
 + completion: improve handling of -c/-C and -b/-B in switch/checkout
 + completion: improve handling of --track in switch/checkout
 + completion: improve handling of --detach in checkout
 + completion: improve completion for git switch with no options
 + completion: improve handling of DWIM mode for switch/checkout
 + completion: perform DWIM logic directly in __git_complete_refs
 + completion: extract function __git_dwim_remote_heads
 + completion: replace overloaded track term for __git_complete_refs
 + completion: add tests showing subpar switch/checkout --orphan logic
 + completion: add tests showing subpar -c/C argument completion
 + completion: add tests showing subpar -c/-C startpoint completion
 + completion: add tests showing subpar switch/checkout --track logic
 + completion: add tests showing subar checkout --detach logic
 + completion: add tests showing subpar DWIM logic for switch/checkout
 + completion: add test showing subpar git switch completion

 The command line completion (in contrib/) learned to complete
 options that the "git switch" command takes.

 Will merge to 'master'.


* en/sparse-with-submodule-doc (2020-06-12) 1 commit
  (merged to 'next' on 2020-06-17 at 3521be3834)
 + git-sparse-checkout: clarify interactions with submodules

 The effect of sparse checkout settings on submodules is documented.

 Will merge to 'master'.


* ss/submodule-set-branch-in-c (2020-06-02) 1 commit
 - submodule: port subcommand 'set-branch' from shell to C

 Rewrite of parts of the scripted "git submodule" Porcelain command
 continues; this time it is "git submodule set-branch" subcommand's
 turn.

 Will merge to 'next'.


* es/config-hooks (2020-05-21) 4 commits
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Ready???


* pw/rebase-i-more-options (2020-05-27) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Not quite.
 cf. <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>


* mt/grep-sparse-checkout (2020-06-12) 6 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: facilitate addition of new cli options
 - t/helper/test-config: return exit codes consistently
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Review needed on 4/6; otherwise looking sane.
 cf. <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>


* bc/sha-256-part-2 (2020-05-27) 44 commits
 - remote-testgit: adapt for object-format
 - bundle: detect hash algorithm when reading refs
 - t5300: pass --object-format to git index-pack
 - t5704: send object-format capability with SHA-256
 - t5703: use object-format serve option
 - t5702: offer an object-format capability in the test
 - t/helper: initialize the repository for test-sha1-array
 - remote-curl: avoid truncating refs with ls-remote
 - t1050: pass algorithm to index-pack when outside repo
 - builtin/index-pack: add option to specify hash algorithm
 - remote-curl: detect algorithm for dumb HTTP by size
 - builtin/ls-remote: initialize repository based on fetch
 - t5500: make hash independent
 - serve: advertise object-format capability for protocol v2
 - connect: parse v2 refs with correct hash algorithm
 - connect: pass full packet reader when parsing v2 refs
 - Documentation/technical: document object-format for protocol v2
 - t1302: expect repo format version 1 for SHA-256
 - builtin/show-index: provide options to determine hash algo
 - t5302: modernize test formatting
 - packfile: compute and use the index CRC offset
 - t3200: mark assertion with SHA1 prerequisite
 - setup: set the_repository's hash algo when checking format
 - fetch-pack: parse and advertise the object-format capability
 - t5562: pass object-format in synthesized test data
 - builtin/clone: initialize hash algorithm properly
 - remote-curl: implement object-format extensions
 - transport-helper: implement object-format extensions
 - docs: update remote helper docs for object-format extensions
 - builtin/receive-pack: detect when the server doesn't support our hash
 - connect: detect algorithm when fetching refs
 - fetch-pack: detect when the server doesn't support our hash
 - connect: make parse_feature_value extern
 - send-pack: detect when the server doesn't support our hash
 - connect: add function to detect supported v1 hash functions
 - transport: add a hash algorithm member
 - pkt-line: add a member for hash algorithm
 - connect: add function to fetch value of a v2 server capability
 - connect: add function to parse multiple v1 capability values
 - remote: advertise the object-format capability on the server side
 - wrapper: add function to compare strings with different NUL termination
 - connect: have ref processing code take struct packet_reader
 - Documentation: document v1 protocol object-format capability
 - t1050: match object ID paths in a hash-insensitive way

 SHA-256 migration work continues.

 Ready???


* jx/proc-receive-hook (2020-05-18) 11 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - receive-pack: feed report options to post-receive
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Needs review.


* hn/reftable (2020-06-17) 18 commits
 . SQUASH??? whitespace breakage fix
 . Add "test-tool dump-reftable" command.
 . Add reftable testing infrastructure
 . vcxproj: adjust for the reftable changes
 . Add GIT_DEBUG_REFS debugging mechanism
 . Hookup unittests for the reftable library.
 . Reftable support for git-core
 . Add reftable library
 . Add .gitattributes for the reftable/ directory
 . Iterate over the "refs/" namespace in for_each_[raw]ref
 . Move REF_LOG_ONLY to refs-internal.h
 . Treat REVERT_HEAD as a pseudo ref
 . Treat CHERRY_PICK_HEAD as a pseudo ref
 . Treat BISECT_HEAD as a pseudo ref
 . Make refs_ref_exists public
 . Write pseudorefs through ref backends.
 . checkout: add '\n' to reflog message
 . lib-t6000.sh: write tag using git-update-ref

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Tentatively omitted from tonight's pushout but will push out 'pu'
 again with this merged in (which will break the tests,
 unfortunately).

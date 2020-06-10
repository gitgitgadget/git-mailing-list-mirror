Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3901CC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18622074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P9cGqzaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgFJXgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:36:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51749 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgFJXgj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:36:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FA8861FE1;
        Wed, 10 Jun 2020 19:36:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=D
        SyAbL3ezOytBodSgn0Zrk4YqdY=; b=P9cGqzaOc8vmyH5TnVHK66Jf3Ht/1Za3S
        2OsNZQx13SEhMRGDOe3PgFLTehGS39elFM0MqFtgMGSeR6x66UZlc2RsX3L2/ZmU
        dH9ip/7dH8WCsFA9wa9BGSS/+fG8rpgNYhF40LFboYfPNwv3dVD1ZM6UnqWUx6jQ
        27mhEUuJiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Scd
        ihIR5YcrlSBaHA5/CRAgHdYnzkgJ24YBpqvCNY3gF3C7mdmPEW3VSNvtr+nUJ+Qx
        QfLa0SIo7SuD3Z/QAaOT5mpi+u8NhpxAuZ8lPz4knv1hnq6FDY7y4pjHU8dMGoKW
        rXuXvCjfWRqp4synp+d1YqcCIYoMiDUzm38UlCx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07D3861FE0;
        Wed, 10 Jun 2020 19:36:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DF2261FDF;
        Wed, 10 Jun 2020 19:36:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2020, #02; Wed, 10)
X-master-at: 0313f36c6ebecb3bffe6f15cf25a4883100f0214
X-next-at: abb59f83a216876869f6c88d32485dc740ada78d
Date:   Wed, 10 Jun 2020 16:36:30 -0700
Message-ID: <xmqq7dweebnl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36AFDDE0-AB73-11EA-845A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'next' has been rewound and rebuilt.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/filter-process (2020-05-21) 2 commits
  (merged to 'next' on 2020-05-24 at 3d51328096)
 + t2060: add a test for switch with --orphan and --discard-changes
 + builtin/checkout: simplify metadata initialization

 Code simplification and test coverage enhancement.


* cb/bisect-helper-parser-fix (2020-05-24) 1 commit
  (merged to 'next' on 2020-05-24 at d30e10fa86)
 + bisect--helper: avoid segfault with bad syntax in `start --term-*`

 The code to parse "git bisect start" command line was lax in
 validating the arguments.


* cb/t4210-illseq-auto-detect (2020-05-18) 2 commits
  (merged to 'next' on 2020-05-24 at c03b4095fa)
 + t4210: detect REG_ILLSEQ dynamically and skip affected tests
 + t/helper: teach test-regex to report pattern errors (like REG_ILLSEQ)

 As FreeBSD is not the only platform whose regexp library reports
 a REG_ILLSEQ error when fed invalid UTF-8, add logic to detect that
 automatically and skip the affected tests.


* cc/upload-pack-data (2020-05-18) 13 commits
  (merged to 'next' on 2020-05-29 at 66008d9209)
 + upload-pack: use upload_pack_data fields in receive_needs()
 + upload-pack: pass upload_pack_data to create_pack_file()
 + upload-pack: remove static variable 'stateless_rpc'
 + upload-pack: pass upload_pack_data to check_non_tip()
 + upload-pack: pass upload_pack_data to send_ref()
 + upload-pack: move symref to upload_pack_data
 + upload-pack: use upload_pack_data writer in receive_needs()
 + upload-pack: pass upload_pack_data to receive_needs()
 + upload-pack: pass upload_pack_data to get_common_commits()
 + upload-pack: use 'struct upload_pack_data' in upload_pack()
 + upload-pack: move 'struct upload_pack_data' around
 + upload-pack: move {want,have}_obj to upload_pack_data
 + upload-pack: remove unused 'wants' from upload_pack_data
 (this branch is used by cc/upload-pack-data-2.)

 Code clean-up.


* dl/remote-curl-deadlock-fix (2020-05-24) 7 commits
  (merged to 'next' on 2020-05-26 at 072714ca7f)
 + stateless-connect: send response end packet
 + pkt-line: define PACKET_READ_RESPONSE_END
 + remote-curl: error on incomplete packet
 + pkt-line: extern packet_length()
 + transport: extract common fetch_pack() call
 + remote-curl: remove label indentation
 + remote-curl: fix typo

 On-the-wire protocol v2 easily falls into a deadlock between the
 remote-curl helper and the fetch-pack process when the server side
 prematurely throws an error and disconnects.  The communication has
 been updated to make it more robust.


* ds/line-log-on-bloom (2020-05-11) 5 commits
  (merged to 'next' on 2020-05-11 at 046d49d455)
 + line-log: integrate with changed-path Bloom filters
 + line-log: try to use generation number-based topo-ordering
 + line-log: more responsive, incremental 'git log -L'
 + t4211-line-log: add tests for parent oids
 + line-log: remove unused fields from 'struct line_log_data'
 (this branch is used by sg/commit-graph-cleanups.)

 "git log -L..." now takes advantage of the "which paths are touched
 by this commit?" info stored in the commit-graph system.


* es/bugreport-shell (2020-05-12) 2 commits
  (merged to 'next' on 2020-05-24 at 79c5c8308b)
 + bugreport: include user interactive shell
 + help: add shell-path to --build-options

 "git bugreport" learns to report what shell is in use.
 We may want to learn more details than just the path, but
 that can come later.
 cf. <20200512235924.GC6605@camp.crustytoothpaste.net>


* js/checkout-p-new-file (2020-05-27) 1 commit
  (merged to 'next' on 2020-05-31 at 017c325bf6)
 + checkout -p: handle new files correctly

 "git checkout -p" did not handle a newly added path at all.


* jt/curl-verbose-on-trace-curl (2020-05-11) 2 commits
  (merged to 'next' on 2020-05-11 at 814e31b9d4)
 + http, imap-send: stop using CURLOPT_VERBOSE
 + t5551: test that GIT_TRACE_CURL redacts password
 (this branch is used by jt/redact-all-cookies.)

 Rewrite support for GIT_CURL_VERBOSE in terms of GIT_TRACE_CURL.


* rs/fsck-duplicate-names-in-trees (2020-05-21) 4 commits
  (merged to 'next' on 2020-05-24 at 6e1d6ba087)
 + fsck: detect more in-tree d/f conflicts
 + t1450: demonstrate undetected in-tree d/f conflict
 + t1450: increase test coverage of in-tree d/f detection
 + fsck: fix a typo in a comment

 The check in "git fsck" to ensure that the tree objects are sorted
 still had corner cases it missed unsorted entries.


* tb/commit-graph-no-check-oids (2020-05-18) 8 commits
  (merged to 'next' on 2020-05-24 at 72bd1063ca)
 + commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
 + t5318: reorder test below 'graph_read_expect'
 + commit-graph.c: simplify 'fill_oids_from_commits'
 + builtin/commit-graph.c: dereference tags in builtin
 + builtin/commit-graph.c: extract 'read_one_commit()'
 + commit-graph.c: peel refs in 'add_ref_to_set'
 + commit-graph.c: show progress of finding reachable commits
 + commit-graph.c: extract 'refs_cb_data'

 Clean-up the commit-graph codepath.


* vs/complete-stash-show-p-fix (2020-05-21) 1 commit
  (merged to 'next' on 2020-05-24 at fcbff29a0f)
 + completion: don't override given stash subcommand with -p

 The command line completion script (in contrib/) tried to complete
 "git stash -p" as if it were "git stash push -p", but it was too
 aggressive and also affected "git stash show -p", which has been
 corrected.

--------------------------------------------------
[New Topics]

* en/sparse-checkout (2020-06-05) 1 commit
 - sparse-checkout: avoid staging deletions of all files

 The behaviour of "sparse-checkout" in the state "git clone
 --no-checkout" left was changed accidentally in 2.27, which has
 been corrected.

 Will merge to 'next'.


* js/msvc-build-fix (2020-06-04) 1 commit
 - msvc: fix "REG_STARTEND" issue

 Workaround breakage in MSVC build, where "curl-config --cflags"
 gives settings appropriate for GCC build.

 Will merge to 'next'.


* en/do-match-pathspec-fix (2020-06-05) 1 commit
 - dir: fix treatment of negated pathspecs

 Use of negative pathspec, while collecting paths including
 untracked ones in the working tree, was broken.

 Will merge to 'next'.


* jt/redact-all-cookies (2020-06-05) 1 commit
 - http: redact all cookies, teach GIT_TRACE_REDACT=0

 The interface to redact sensitive information in the trace output
 has been simplified.

 Will merge to 'next'.


* dl/python-2.7-is-the-floor-version (2020-06-08) 1 commit
 - CodingGuidelines: specify Python 2.7 is the oldest version

 Document that we do not support Python 2.6 or older.

 Will merge to 'next'.


* dl/t-readme-spell-git-correctly (2020-06-08) 1 commit
 - t/README: avoid poor-man's small caps GIT

 Doc updates.

 Will merge to 'next'.


* es/advertise-contribution-doc (2020-06-08) 1 commit
 - docs: mention MyFirstContribution in more places

 Doc updates.

 Will merge to 'next'.


* es/worktree-duplicate-paths (2020-06-10) 7 commits
 - worktree: make "move" refuse to move atop missing registered worktree
 - worktree: generalize candidate worktree path validation
 - worktree: prune linked worktree referencing main worktree path
 - worktree: prune duplicate entries referencing same worktree path
 - worktree: make high-level pruning re-usable
 - worktree: give "should be pruned?" function more meaningful name
 - worktree: factor out repeated string literal

 The same worktree directory must be registered only once, but
 "git worktree move" allowed this invariant to be violated, which
 has been corrected.

 Will merge to 'next'.


* js/fuzz-commit-graph-leakfix (2020-06-08) 1 commit
 - fuzz-commit-graph: properly free graph struct

 Leakfix.

 Will merge to 'next'.


* sg/commit-graph-cleanups (2020-06-08) 10 commits
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


* dl/test-must-fail-fixes-5 (2020-05-21) 5 commits
 - lib-submodule-update: pass OVERWRITING_FAIL
 - SQUASH???  <20200521112545.GB581643@generichostname>
 - lib-submodule-update: prepend "git" to $command
 - lib-submodule-update: consolidate --recurse-submodules
 - lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.

 Expecting a reroll.
 cf. <20200521182928.GA1308647@coredump.intra.peff.net>
 The last step is a bit too ugly to live; Peff seems to have better
 ideas.


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

* jk/diff-memuse-optim-with-stat-unmatch (2020-06-02) 1 commit
 - diff: discard blob data from stat-unmatched pairs

 Reduce memory usage during "diff --quiet" in a worktree with too
 many stat-unmatched paths.

 Will merge to 'next'.


* js/reflog-anonymize-for-clone-and-fetch (2020-06-04) 1 commit
 - clone/fetch: anonymize URLs in the reflog

 The reflog entries for "git clone" and "git fetch" did not
 anonymize the URL they operated on.

 Will merge to 'next'.


* tb/t5318-cleanup (2020-06-04) 2 commits
 - t5318: test that '--stdin-commits' respects '--[no-]progress'
 - t5318: use 'test_must_be_empty'

 Code cleanup.

 Will merge to 'next'.


* cc/upload-pack-data-2 (2020-06-04) 13 commits
 - upload-pack: move pack_objects_hook to upload_pack_data
 - upload-pack: move allow_sideband_all to upload_pack_data
 - upload-pack: move allow_ref_in_want to upload_pack_data
 - upload-pack: move allow_filter to upload_pack_data
 - upload-pack: move keepalive to upload_pack_data
 - upload-pack: pass upload_pack_data to upload_pack_config()
 - upload-pack: change multi_ack to an enum
 - upload-pack: move multi_ack to upload_pack_data
 - upload-pack: move filter_capability_requested to upload_pack_data
 - upload-pack: move use_sideband to upload_pack_data
 - upload-pack: move static vars to upload_pack_data
 - upload-pack: annotate upload_pack_data fields
 - upload-pack: actually use some upload_pack_data bitfields

 Further code clean-up.

 Will merge to 'next'.


* xl/upgrade-repo-format (2020-06-05) 4 commits
 - check_repository_format_gently(): refuse extensions for old repositories
 - sparse-checkout: upgrade repository to version 1 when enabling extension
 - fetch: allow adding a filter after initial clone
 - repository: add a helper function to perform repository format upgrade

 Allow runtime upgrade of the repository format version, which needs
 to be done carefully.

 Almost there.  It does not seem to play well with hn/reftable


* jk/complete-git-switch (2020-05-28) 16 commits
 - completion: improve handling of --orphan option of switch/checkout
 - completion: improve handling of -c/-C and -b/-B in switch/checkout
 - completion: improve handling of --track in switch/checkout
 - completion: improve handling of --detach in checkout
 - completion: improve completion for git switch with no options
 - completion: improve handling of DWIM mode for switch/checkout
 - completion: perform DWIM logic directly in __git_complete_refs
 - completion: extract function __git_dwim_remote_heads
 - completion: replace overloaded track term for __git_complete_refs
 - completion: add tests showing subpar switch/checkout --orphan logic
 - completion: add tests showing subpar -c/C argument completion
 - completion: add tests showing subpar -c/-C startpoint completion
 - completion: add tests showing subpar switch/checkout --track logic
 - completion: add tests showing subar checkout --detach logic
 - completion: add tests showing subpar DWIM logic for switch/checkout
 - completion: add test showing subpar git switch completion

 The command line completion (in contrib/) learned to complete
 options that the "git switch" command takes.

 Is this ready?


* en/sparse-with-submodule-doc (2020-05-25) 1 commit
 - git-sparse-checkout: clarify interactions with submodules

 The effect of sparse checkout settings on submodules is documented.

 Needs review.


* ss/submodule-set-branch-in-c (2020-06-02) 1 commit
 - submodule: port subcommand 'set-branch' from shell to C

 Rewrite of parts of the scripted "git submodule" Porcelain command
 continues; this time it is "git submodule set-branch" subcommand's
 turn.

 Almost there.
 cf. <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>


* es/config-hooks (2020-05-21) 4 commits
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.


* pw/rebase-i-more-options (2020-05-27) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Not quite.
 cf. <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>


* mt/grep-sparse-checkout (2020-06-02) 6 commits
 - git.c: fix sparse warning
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: return exit codes consistently
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Expecting a reroll.
 cf. <cover.1590627264.git.matheus.bernardino@usp.br>
 cf. <CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com>


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

 Will merge to 'master'.


* hn/reftable (2020-06-09) 14 commits
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
 (this branch uses hn/refs-cleanup.)

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Does not seem to build from the source.

--------------------------------------------------
[Discarded]

* jc/credential-store-file-format-doc (2020-04-27) 1 commit
 . credential-store: document the file format a bit more

 Now has become a part of Carlo's credential-store fix patches.


* js/ci-skip-on-github-workflow (2020-05-02) 1 commit
 . ci: respect the [skip ci] convention in our GitHub workflow "CI/PR"

 Allow contributors to mark a branch/push that it does not have to
 be built via GitHub actions, in a way similar to how Travis lets
 them mark the commits with an embedded "[skip ci]" string.

 Superseded by dd/ci-only-on-selective-branches topic.


* dd/ci-only-on-selective-branches (2020-05-05) 2 commits
 - CI: limit GitHub Actions to designated branches
 - SubmittingPatches: advertise GitHub Actions CI

 Instead of always building all branches of all forks of our project
 at GitHub via GitHub Actions, only build when branches with known
 and specific names are updated, and also a pull request.

 Superseded by jk/ci-only-on-selected-branches

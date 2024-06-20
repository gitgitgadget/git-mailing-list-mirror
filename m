Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561B7CF39
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927809; cv=none; b=P7g1pdnlFObvG1Y3iBIHDZGAQBgEVFldCmNKKaLdLhANQYYYlKqj+Sdl5OPUpihDSZVb70l6y1Q9KFCLOSGYZTzLrMN1VPog2Q5fJgp9Ft3sFf8o9Nk6BFqpOvcMvC2okyVtf+v1GiyE8s+e2ReouIwLoR6J2mzOOGfQu7IrZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927809; c=relaxed/simple;
	bh=7LP3rBfJZHFUTGmuV3eO+ajS+Bl9QcmmUylzuykwn+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3UVL5qLsTmk/ZVljOHYwA8ODsb97UGmYkSiVh01tFlypzsYfqEkLu79tpqBSVf801DHPkdKqud/1r1Y2weBbDpzlou8eVfF8Ewx/1nMDXrygWe3QBPf8eUEYZkVhI97j1/99YzREhvnRgecznBAT6z+uEgjwKs/RVtubBPMTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RngEmrNL; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RngEmrNL"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B45F11B0AF;
	Thu, 20 Jun 2024 19:56:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	LP3rBfJZHFUTGmuV3eO+ajS+Bl9QcmmUylzuykwn+A=; b=RngEmrNL21SsmDSwD
	4Z9fXendCjpg73CeuqmjlMpl+U1DmcYDZdgtli6LVapS+ytKkuQ3s/H87wizCB7d
	ob/FqkRgHAbfIXSeqTQI8oD4Uc9aIQBxt0Xt4xh5EhJ/aqWQ2w7km6EgJEZ4d8k+
	1LkKYHlbsbY6hEDGk/eLMUnvJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC26C1B0AE;
	Thu, 20 Jun 2024 19:56:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 015901B0AD;
	Thu, 20 Jun 2024 19:56:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2024, #07; Thu, 20)
X-master-at: 9005149a4a77e2d3409c6127bf4fd1a0893c3495
X-next-at: 4e1b14247adedf68e1c01a595e53106096e867db
Date: Thu, 20 Jun 2024 16:56:41 -0700
Message-ID: <xmqqfrt7p3ra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE71E9BA-2F60-11EF-88E3-965B910A682E-77302942!pb-smtp2.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* ds/ahead-behind-fix (2024-06-12) 1 commit
  (merged to 'next' on 2024-06-13 at df378ec81e)
 + commit-graph: increment progress indicator

 Fix for a progress bar.
 source: <pull.1743.git.1718118555197.gitgitgadget@gmail.com>


* ds/doc-add-interactive-singlekey (2024-06-07) 1 commit
  (merged to 'next' on 2024-06-12 at cf3de70246)
 + doc: interactive.singleKey is disabled by default

 Doc update.
 source: <xmqq4ja4e6d6.fsf@gitster.g>


* gt/unit-test-oidtree (2024-06-12) 1 commit
  (merged to 'next' on 2024-06-13 at eb3700b002)
 + t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
 (this branch is used by ps/use-the-repository.)

 "oidtree" tests were rewritten to use the unit test framework.
 cf. <7o6fuymnfn6b6buyw3yyctjd4dlwlrazspv3xgxvys6djjivxh@qbhyurorgbtt>
 source: <20240608165731.29467-1-shyamthakkar001@gmail.com>


* jc/heads-are-branches (2024-06-04) 3 commits
  (merged to 'next' on 2024-06-14 at b56b59d1d7)
 + show-ref: introduce --branches and deprecate --heads
 + ls-remote: introduce --branches and deprecate --heads
 + refs: call branches branches

 The "--heads" option of "ls-remote" and "show-ref" has been been
 deprecated; "--branches" replaces "--heads".
 source: <20240604220145.3260714-1-gitster@pobox.com>


* kn/update-ref-symref (2024-06-07) 8 commits
  (merged to 'next' on 2024-06-13 at 5cf8d7513e)
 + update-ref: add support for 'symref-update' command
 + reftable: pick either 'oid' or 'target' for new updates
 + update-ref: add support for 'symref-create' command
 + update-ref: add support for 'symref-delete' command
 + update-ref: add support for 'symref-verify' command
 + refs: specify error for regular refs with `old_target`
 + refs: create and use `ref_update_expects_existing_old_ref()`
 + Merge branch 'kn/ref-transaction-symref' into kn/update-ref-symref

 "git update-ref --stdin" learned to handle transactional updates of
 symbolic-refs.
 source: <20240607133304.2333280-1-knayak@gitlab.com>


* ps/abbrev-length-before-setup-fix (2024-06-12) 3 commits
  (merged to 'next' on 2024-06-13 at e5d17f7da2)
 + object-name: don't try to abbreviate to lengths greater than hexsz
 + parse-options-cb: stop clamping "--abbrev=" to hash length
 + config: fix segfault when parsing "core.abbrev" without repo

 Setting core.abbrev too early before the repository set-up
 (typically in "git clone") caused segfault, which as been
 corrected.
 source: <cover.1718178996.git.ps@pks.im>


* ps/document-breaking-changes (2024-06-14) 4 commits
  (merged to 'next' on 2024-06-14 at 8089bf6f81)
 + BreakingChanges: document that we do not plan to deprecate git-checkout
 + BreakingChanges: document removal of grafting
 + BreakingChanges: document upcoming change from "sha1" to "sha256"
 + docs: introduce document to announce breaking changes

 The structure of the document that records longer-term project
 decisions to deprecate/remove/update various behaviour has been
 outlined.
 source: <cover.1718345026.git.ps@pks.im>


* ps/make-append-to-cflags (2024-06-11) 1 commit
  (merged to 'next' on 2024-06-12 at d57b04bf16)
 + Makefile: add ability to append to CFLAGS and LDFLAGS

 To help developers, the build procedure now allows builders to use
 CFLAGS_APPEND to specify additional CFLAGS.
 source: <8120ddaf0bdfd50e0fc4cf9a04f833102630b639.1718001244.git.ps@pks.im>


* pw/rebase-i-error-message (2024-05-30) 2 commits
  (merged to 'next' on 2024-06-13 at dbec12cfda)
 + rebase -i: improve error message when picking merge
 + rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.
 source: <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>


* rj/format-patch-auto-cover-with-interdiff (2024-06-07) 2 commits
  (merged to 'next' on 2024-06-13 at 3fad4afcfd)
 + format-patch: assume --cover-letter for diff in multi-patch series
 + t4014: cleanups in a few tests

 "git format-patch --interdiff" for multi-patch series learned to
 turn on cover letters automatically (unless told never to enable
 cover letter with "--no-cover-letter" and such).


* rs/diff-exit-code-with-external-diff (2024-06-10) 3 commits
  (merged to 'next' on 2024-06-12 at 9ce495b6cc)
 + diff: let external diffs report that changes are uninteresting
 + userdiff: add and use struct external_diff
 + t4020: test exit code with external diffs

 "git diff --exit-code --ext-diff" learned to take the exit status
 of the external diff driver into account when deciding the exit
 status of the overall "git diff" invocation when configured to do
 so.
 source: <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>


* tb/multi-pack-reuse-fix (2024-06-11) 3 commits
  (merged to 'next' on 2024-06-13 at 1cd0259667)
 + pack-revindex.c: guard against out-of-bounds pack lookups
 + pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
 + midx-write.c: do not read existing MIDX with `packs_to_include`

 Assorted fixes to multi-pack-index code paths.
 source: <cover.1718126886.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* kz/merge-fail-early-upon-refresh-failure (2024-06-18) 1 commit
  (merged to 'next' on 2024-06-20 at 01d4bdd019)
 + merge: avoid write merge state when unable to write index

 When "git merge" sees that the index cannot be refreshed (e.g. due
 to another process doing the same in the background), it died but
 after writing MERGE_HEAD etc. files, which was useless for the
 purpose to recover from the failure.

 Will merge to 'master'.
 source: <pull.1731.v6.git.1718593717745.gitgitgadget@gmail.com>


* ds/sparse-lstat-caching (2024-06-20) 5 commits
 - sparse-index: improve lstat caching of sparse paths
 - sparse-index: count lstat() calls
 - sparse-index: use strbuf in path_found()
 - sparse-index: refactor path_found()
 - sparse-index: refactor skip worktree retry logic

 The code to deal with modified paths that are out-of-cone in a
 sparsely checked out working tree has been optimized.

 Needs review.
 source: <pull.1754.git.1718899877.gitgitgadget@gmail.com>


* jk/fetch-pack-fsck-wo-lock-pack (2024-06-20) 1 commit
  (merged to 'next' on 2024-06-20 at c8c41abe07)
 + fetch-pack: fix segfault when fscking without --lock-pack

 "git fetch-pack -k -k" without passing "--lock-pack" (which we
 never do ourselves) did not work at all, which has been corrected.

 Will merge to 'master'.
 source: <20240619130256.GA228005@coredump.intra.peff.net>


* jk/t5500-typofix (2024-06-20) 1 commit
  (merged to 'next' on 2024-06-20 at cf953645e3)
 + t5500: fix mistaken $SERVER reference in helper function

 A helper function shared between two tests had a copy-paste bug,
 which has been corrected.

 Will merge to 'master'.
 source: <20240619125255.GA346466@coredump.intra.peff.net>


* js/mingw-remove-unused-extern-decl (2024-06-20) 1 commit
  (merged to 'next' on 2024-06-20 at 65b323930f)
 + mingw: drop bogus (and unneeded) declaration of `_pgmptr`

 An unused extern declaration for mingw has been removed to prevent
 it from causing build failure.

 Will merge to 'master'.
 source: <pull.1752.git.1718777398765.gitgitgadget@gmail.com>


* rb/build-options-w-openssl (2024-06-20) 1 commit
  (merged to 'next' on 2024-06-20 at b75df251ae)
 + version: --build-options reports OpenSSL version information

 "git version --build-options" reports the version information of
 OpenSSL (if used) in the build.

 Will merge to 'master'.
 source: <20240619172421.33548-2-randall.becker@nexbridge.ca>


* rj/pager-die-upon-exec-failure (2024-06-20) 1 commit
 - pager: die when paging to non-existing command

 When GIT_PAGER failed to spawn, depending on the code path taken,
 we failed immediately (correct) or just spew the payload to the
 standard output (incorrect).  The code now always fail immediately
 when GIT_PAGER fails.

 Will merge to 'next'?
 source: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>


* rs/remove-unused-find-header-mem (2024-06-20) 1 commit
  (merged to 'next' on 2024-06-20 at 068c785d77)
 + commit: remove find_header_mem()

 Code clean-up.

 Will merge to 'master'.
 source: <0d85712c-5beb-4a64-a7f4-797782c26694@web.de>

--------------------------------------------------
[Cooking]

* ew/cat-file-unbuffered-tests (2024-06-20) 2 commits
 - t1006: ensure cat-file info isn't buffered by default
 - Git.pm: use array in command_bidi_pipe example

 The output from "git cat-file --batch-check" and "--batch-command
 (info)" should not be unbuffered, for which some tests have been
 added.

 Will merge to 'next'.
 source: <20240617104326.3522535-1-e@80x24.org>
 source: <20240618213041.M462972@dcvr>


* kl/attr-read-attr-fromindex-msan-workaround (2024-06-17) 1 commit
  (merged to 'next' on 2024-06-18 at eebafb2d71)
 + attr: fix msan issue in read_attr_from_index

 Code clarification to avoid an appearance of using an uninitialized
 variable.

 Will merge to 'master'.
 source: <pull.1747.git.1718654424683.gitgitgadget@gmail.com>


* cp/unit-test-reftable-tree (2024-06-13) 5 commits
 - t-reftable-tree: improve the test for infix_walk()
 - t-reftable-tree: add test for non-existent key
 - t-reftable-tree: split test_tree() into two sub-test functions
 - t: move reftable/tree_test.c to the unit testing framework
 - reftable: remove unnecessary curly braces in reftable/tree.c

 A test in reftable library has been rewritten using the unit test
 framework.

 Needs review.
 source: <20240612130217.8877-1-chandrapratap3519@gmail.com>


* ps/use-the-repository (2024-06-14) 22 commits
 - hex: guard declarations with `USE_THE_REPOSITORY_VARIABLE`
 - t/helper: remove dependency on `the_repository` in "proc-receive"
 - t/helper: fix segfault in "oid-array" command without repository
 - t/helper: use correct object hash in partial-clone helper
 - compat/fsmonitor: fix socket path in networked SHA256 repos
 - replace-object: use hash algorithm from passed-in repository
 - protocol-caps: use hash algorithm from passed-in repository
 - oidset: pass hash algorithm when parsing file
 - http-fetch: don't crash when parsing packfile without a repo
 - hash-ll: merge with "hash.h"
 - refs: avoid include cycle with "repository.h"
 - global: introduce `USE_THE_REPOSITORY_VARIABLE` macro
 - hash: require hash algorithm in `empty_tree_oid_hex()`
 - hash: require hash algorithm in `is_empty_{blob,tree}_oid()`
 - hash: make `is_null_oid()` independent of `the_repository`
 - hash: convert `oidcmp()` and `oideq()` to compare whole hash
 - global: ensure that object IDs are always padded
 - hash: require hash algorithm in `oidread()` and `oidclr()`
 - hash: require hash algorithm in `hasheq()`, `hashcmp()` and `hashclr()`
 - hash: drop (mostly) unused `is_empty_{blob,tree}_sha1()` functions
 - Merge branch 'gt/unit-test-oidtree' into ps/use-the-repository
 - Merge branch 'ps/ref-storage-migration' into ps/use-the-repository

 A CPP macro USE_THE_REPOSITORY_VARIABLE is introduced to help
 transition the codebase to rely less on the availability of the
 singleton the_repository instance.

 Will merge to 'next'.
 source: <cover.1718347699.git.ps@pks.im>


* sj/ref-fsck (2024-06-20) 7 commits
 - fsck: add ref content check for files backend
 - fsck: add ref name check for files backend
 - files-backend: add unified interface for refs scanning
 - builtin/fsck: add `git-refs verify` child process
 - builtin/refs: add verify subcommand
 - refs: set up ref consistency check infrastructure
 - fsck: add refs check interfaces to interact with fsck error levels

 "git fsck" infrastructure has been taught to also check the sanity
 of the ref database, in addition to the object database.

 Needs review.
 source: <ZnKKy52QFO2UhqM6@ArchLinux>


* en/ort-inner-merge-error-fix (2024-06-20) 7 commits
 - merge-ort: convert more error() cases to path_msg()
 - merge-ort: upon merge abort, only show messages causing the abort
 - merge-ort: loosen commented requirements
 - merge-ort: clearer propagation of failure-to-function from merge_submodule
 - merge-ort: fix type of local 'clean' var in handle_content_merge ()
 - merge-ort: maintain expected invariant for priv member
 - merge-ort: extract handling of priv member into reusable function

 The "ort" merge backend saw one bugfix for a crash that happens
 when inner merge gets killed, and assorted code clean-ups.

 Needs review.
 source: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>


* cp/unit-test-reftable-pq (2024-06-14) 7 commits
 - t-reftable-pq: add tests for merged_iter_pqueue_top()
 - t-reftable-pq: add test for index based comparison
 - t-reftable-pq: make merged_iter_pqueue_check() callable by reference
 - t-reftable-pq: make merged_iter_pqueue_check() static
 - t: move reftable/pq_test.c to the unit testing framework
 - reftable: change the type of array indices to 'size_t' in reftable/pq.c
 - reftable: remove unncessary curly braces in reftable/pq.c

 The tests for "pq" part of reftable library got rewritten to use
 the unit test framework.

 Needs review.
 source: <20240614095136.12052-1-chandrapratap3519@gmail.com>


* jc/archive-prefix-with-add-virtual-file (2024-06-14) 1 commit
 - archive: document that --add-virtual-file takes full path

 "git archive --add-virtual-file=<path>:<contents>" never paid
 attention to the --prefix=<prefix> option but the documentation
 said it would. The documentation has been corrected.

 Waiting for comments.
 source: <xmqq5xubfjuu.fsf_-_@gitster.g>


* jk/remote-wo-url (2024-06-14) 11 commits
 - remote: drop checks for zero-url case
 - remote: always require at least one url in a remote
 - t5801: test remote.*.vcs config
 - t5801: make remote-testgit GIT_DIR setup more robust
 - remote: allow resetting url list
 - config: document remote.*.url/pushurl interaction
 - remote: simplify url/pushurl selection
 - remote: use strvecs to store remote url/pushurl
 - remote: transfer ownership of memory in add_url(), etc
 - remote: refactor alias_url() memory ownership
 - archive: fix check for missing url

 Memory ownership rules for the in-core representation of
 remote.*.url configuration values have been straightened out, which
 resulted in a few leak fixes and code clarification.

 Waiting for comments.
 source: <20240614102439.GA222287@coredump.intra.peff.net>


* db/date-underflow-fix (2024-06-13) 4 commits
 - SQUASH??? skip "near the end-of-git-time" tests on 32-bit systems
 - SQUASH??? t0006: simplify prerequisite
 - SQUASH??? the git-end-of-time is beyond time_t on 32-bit systems
 - date: detect underflow/overflow when parsing dates with timezone offset

 date parser updates to be more careful about underflowing epoch
 based timestamp.

 Expecting a reroll.
 cf. <xmqq1q58ejnw.fsf@gitster.g>
 cf. <xmqqtthzrraw.fsf@gitster.g>
 source: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>


* tb/commit-graph-use-tempfile (2024-06-07) 2 commits
  (merged to 'next' on 2024-06-17 at e0baebe6b3)
 + server-info.c: remove temporary info files on exit
 + commit-graph.c: remove temporary graph layers on exit

 "git update-server-info" and "git commit-graph --write" have been
 updated to use the tempfile API to avoid leaving cruft after
 failing.

 Will merge to 'master'.
 source: <cover.1717712358.git.me@ttaylorr.com>


* tb/incremental-midx-part-1 (2024-06-07) 19 commits
 - midx: implement support for writing incremental MIDX chains
 - t/t5313-pack-bounds-checks.sh: prepare for sub-directories
 - t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - midx: implement verification support for incremental MIDXs
 - midx: support reading incremental MIDX chains
 - midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
 - midx: teach `midx_preferred_pack()` about incremental MIDXs
 - midx: teach `midx_contains_pack()` about incremental MIDXs
 - midx: remove unused `midx_locate_pack()`
 - midx: teach `fill_midx_entry()` about incremental MIDXs
 - midx: teach `nth_midxed_offset()` about incremental MIDXs
 - midx: teach `bsearch_midx()` about incremental MIDXs
 - midx: introduce `bsearch_one_midx()`
 - midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 - midx: teach `prepare_midx_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 - midx: add new fields for incremental MIDX chains
 - Documentation: describe incremental MIDX format

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1717715060.git.me@ttaylorr.com>


* jc/worktree-git-path (2024-06-08) 1 commit
  (merged to 'next' on 2024-06-17 at a87c318e45)
 + worktree_git_path(): move the declaration to path.h

 Code cleanup.

 Will merge to 'master'.
 source: <20240608183901.2084546-1-gitster@pobox.com>


* vd/mktree (2024-06-20) 17 commits
 - mktree: remove entries when mode is 0
 - mktree: allow deeper paths in input
 - mktree: optionally add to an existing tree
 - mktree: add directory-file conflict hashmap
 - mktree: use iterator struct to add tree entries to index
 - mktree: create tree using an in-core index
 - mktree: overwrite duplicate entries
 - mktree: validate paths more carefully
 - mktree: add a --literally option
 - mktree.c: do not fail on mismatched submodule type
 - mktree: use read_index_info to read stdin lines
 - index-info.c: parse object type in provided in read_index_info
 - index-info.c: return unrecognized lines to caller
 - update-index: generalize 'read_index_info'
 - mktree: use non-static tree_entry array
 - mktree: rename treeent to tree_entry
 - mktree: use OPT_BOOL

 "git mktree" has been rewritten, taking advantage of the cache-tree
 API.

 Needs review.
 source: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>


* xx/bundie-uri-fixes (2024-06-20) 3 commits
 - unbundle: extend object verification for fetches
 - fetch-pack: expose fsckObjects configuration logic
 - bundle-uri: verify oid before writing refs

 When bundleURI interface fetches multiple bundles, Git failed to
 take full advantage of all bundles and ended up slurping duplicated
 objects.

 Will merge to 'next'?
 source: <pull.1730.v8.git.1718770053.gitgitgadget@gmail.com>


* jc/add-i-retire-usebuiltin-config (2024-06-05) 1 commit
  (merged to 'next' on 2024-06-17 at e1fc71db3a)
 + add-i: finally retire add.interactive.useBuiltin

 For over a year, setting add.interactive.useBuiltin configuration
 variable did nothing but giving a "this does not do anything"
 warning.  Finally remove it.

 Will merge to 'master'.
 source: <xmqqikynqdvq.fsf@gitster.g>


* jc/no-default-attr-tree-in-bare (2024-06-05) 1 commit
  (merged to 'next' on 2024-06-17 at 6bfacc9102)
 + attr.tree: HEAD:.gitattributes is no longer the default in a bare repo

 Earlier we stopped using the tree of HEAD as the default source of
 attributes in a bare repository, but failed to document it.  This
 has been corrected.

 Will merge to 'master'.
 source: <xmqqa5jzqd5k.fsf_-_@gitster.g>


* ps/leakfixes-more (2024-06-11) 30 commits
 - builtin/blame: fix leaking ignore revs files
 - builtin/blame: fix leaking prefixed paths
 - blame: fix leaking data for blame scoreboards
 - line-range: plug leaking find functions
 - merge: fix leaking merge bases
 - builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
 - sequencer: fix memory leaks in `make_script_with_merges()`
 - builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
 - apply: fix leaking string in `match_fragment()`
 - sequencer: fix leaking string buffer in `commit_staged_changes()`
 - commit: fix leaking parents when calling `commit_tree_extended()`
 - config: fix leaking "core.notesref" variable
 - rerere: fix various trivial leaks
 - builtin/stash: fix leak in `show_stash()`
 - revision: free diff options
 - builtin/log: fix leaking commit list in git-cherry(1)
 - merge-recursive: fix memory leak when finalizing merge
 - builtin/merge-recursive: fix leaking object ID bases
 - builtin/difftool: plug memory leaks in `run_dir_diff()`
 - object-name: free leaking object contexts
 - builtin/rev-list: fix leaking bitmap index when calculating disk usage
 - notes: fix memory leak when pruning notes
 - revision: fix leaking display notes
 - merge-recursive: fix leaking rename conflict info
 - biultin/rev-parse: fix memory leaks in `--parseopt` mode
 - bundle: plug leaks in `create_bundle()`
 - notes-utils: free note trees when releasing copied notes
 - parse-options: fix leaks for users of OPT_FILENAME
 - revision: fix memory leak when reversing revisions
 - Merge branch 'ps/leakfixes' into ps/leakfixes-more

 More memory leaks have been plugged.

 Needs review.
 source: <cover.1718095906.git.ps@pks.im>


* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>


* tb/pseudo-merge-reachability-bitmap (2024-06-14) 27 commits
  (merged to 'next' on 2024-06-14 at 447d99e1c3)
 + pack-bitmap.c: ensure pseudo-merge offset reads are bounded
 + Documentation/technical/bitmap-format.txt: add missing position table
  (merged to 'next' on 2024-06-03 at fcaa39de12)
 + t/perf: implement performance tests for pseudo-merge bitmaps
 + pseudo-merge: implement support for finding existing merges
 + ewah: `bitmap_equals_ewah()`
 + pack-bitmap: extra trace2 information
 + pack-bitmap.c: use pseudo-merges during traversal
 + t/test-lib-functions.sh: support `--notick` in `test_commit_bulk()`
 + pack-bitmap: implement test helpers for pseudo-merge
 + ewah: implement `ewah_bitmap_popcount()`
 + pseudo-merge: implement support for reading pseudo-merge commits
 + pack-bitmap.c: read pseudo-merge extension
 + pseudo-merge: scaffolding for reads
 + pack-bitmap: extract `read_bitmap()` function
 + pack-bitmap-write.c: write pseudo-merge table
 + pseudo-merge: implement support for selecting pseudo-merge commits
 + config: introduce `git_config_double()`
 + pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 + pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 + pack-bitmap-write: support storing pseudo-merge commits
 + pseudo-merge.ch: initial commit
 + pack-bitmap: move some initialization to `bitmap_writer_init()`
 + ewah: implement `ewah_bitmap_is_subset()`
 + Documentation/technical: describe pseudo-merge bitmaps format
 + Documentation/gitpacking.txt: describe pseudo-merge bitmaps
 + Documentation/gitpacking.txt: initial commit
 + Merge branch 'tb/pack-bitmap-write-cleanups' into tb/pseudo-merge-reachability-bitmap

 The pseudo-merge reachability bitmap to help more efficient storage
 of the reachability bitmap in a repository with too many refs has
 been added.

 Will merge to 'master'.
 source: <cover.1716499565.git.me@ttaylorr.com>
 source: <cover.1718392943.git.me@ttaylorr.com>


* tb/precompose-getcwd (2024-05-31) 1 commit
  (merged to 'next' on 2024-06-17 at 7596abec9f)
 + macOS: ls-files path fails if path of workdir is NFD

 We forgot to normalize the result of getcwd() to NFC on macOS where
 all other paths are normalized, which has been corrected.  This still
 does not address the case where core.precomposeUnicode configuration
 is not defined globally.

 Will merge to 'master'.
 source: <20240531193156.28046-1-tboegi@web.de>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* cw/git-std-lib (2024-02-28) 4 commits
 . SQUASH??? get rid of apparent debugging crufts
 . test-stdlib: show that git-std-lib is independent
 . git-std-lib: introduce Git Standard Library
 . pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>

--------------------------------------------------
[Discarded]

* rj/add-p-pager (2024-06-04) 6 commits
 . add-patch: introduce the command '|'
 . test-terminal: introduce --no-stdin-pty
 . pager: introduce setup_custom_pager
 . pager: introduce wait_for_pager
 . pager: do not close fd 2 unnecessarily
 . add-patch: test for 'p' command

 "git add -i" and friends learned a new '|' command that sends the
 current hunk to the pager, instead of dumping it to the terminal.

 Expecting a reroll to work well with jk/am-retry
 source: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>

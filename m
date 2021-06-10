Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50043C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 06:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D9D613CB
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 06:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFJGmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:42:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64918 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGmW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 02:42:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92E10CB17D;
        Thu, 10 Jun 2021 02:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=r8/R/VhjfV8h9HCXeUvafpC66
        08BRMds5NXEPJqMbHY=; b=v/n6cvxEtNjG5ZPlzVpSBnIrrWYyRYt0CmtRw+N8p
        zI0Nn8cMI5uvahUD9TkvEflhNxRtwASvFVjcVUcfds1tJ2pMoPvLNWXiWaeuXBFA
        Soxr4AUcShVbtXSKjh5KCSunHLQcxBCo9U7NzI8YUsDckt+GiWOzvcZiilld6DWF
        68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 886A7CB17C;
        Thu, 10 Jun 2021 02:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B93A5CB17B;
        Thu, 10 Jun 2021 02:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2021, #04; Thu, 10)
X-master-at: 211eca0895794362184da2be2a2d812d070719d3
X-next-at: 62a8d224e6203d9d3d2d1d63a01cf5647ec312c9
Date:   Thu, 10 Jun 2021 15:40:25 +0900
Message-ID: <xmqqmtrydxye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD0A516A-C9B6-11EB-9BAE-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '-' are only in 'seen' while commits prefixed with '+'
are in 'next'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.  Generally,
being in 'next' is a sign that a topic is stable enough to be used
and are candidate to be in a future release, while being in 'seen'
means nothing more than that the maintainer has found it interesting
for some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful")---do not read too much into a topic being in (or not in)
'seen'.

The first batch of topics that have been cooking in 'next' are now
in 'master'.  They are all simple and obvious improvements.  The
next batch is expected to be more extensive.  Also those topics that
are not yet in 'next' but are marked to be merged to 'next' would
stay out until the tip of 'next' gets rewound.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

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

* ah/doc-describe (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-22 at 8f3925fd41)
 + describe-doc: clarify default length of abbreviation

 Doc update.


* ah/fetch-reject-warning-grammofix (2021-05-20) 1 commit
  (merged to 'next' on 2021-05-28 at 09820da41b)
 + fetch: improve grammar of "shallow roots" message

 Message update.


* ah/merge-usage-i18n-fix (2021-05-16) 1 commit
  (merged to 'next' on 2021-05-20 at e26a60d624)
 + merge: don't translate literal commands

 i18n update.


* ah/setup-extensions-message-i18n-fix (2021-05-20) 1 commit
  (merged to 'next' on 2021-05-28 at 562b4e6f10)
 + setup: split "extensions found" messages into singular and plural

 Message update.


* ah/stash-usage-i18n-fix (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-20 at 68e6a46117)
 + stash: don't translate literal commands

 i18n update.


* ah/submodule-helper-module-summary-parseopt (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-20 at 928e72b83f)
 + submodule: use the imperative mood to describe the --files option

 Message update.


* ef/mailinfo-short-name (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-20 at 5ee67911ea)
 + mailinfo: don't discard names under 3 characters

 We historically rejected a very short string as an author name
 while accepting a patch e-mail, which has been loosened.


* jc/clarify-revision-range (2021-05-18) 1 commit
  (merged to 'next' on 2021-05-22 at 83a689d8ad)
 + revisions(7): clarify that most commands take a single revision range

 Doc update.


* jk/doc-color-pager (2021-05-20) 1 commit
  (merged to 'next' on 2021-05-28 at 52e4aa77df)
 + doc: explain the use of color.pager

 The documentation for "color.pager" configuration variable has been
 updated.


* jn/size-t-casted-to-off-t-fix (2021-05-19) 1 commit
  (merged to 'next' on 2021-05-20 at bbde7e6616)
 + xsize_t: avoid implementation defined behavior when len < 0

 Rewrite code that triggers undefined behaiour warning.


* mt/parallel-checkout-with-padded-oidcpy (2021-05-18) 1 commit
  (merged to 'next' on 2021-05-20 at 016cab0381)
 + parallel-checkout: send the new object_id algo field to the workers

 The parallel checkout codepath did not initialize object ID field
 used to talk to the worker processes in a futureproof way.


* ry/clarify-fast-forward-in-glossary (2021-05-19) 1 commit
  (merged to 'next' on 2021-05-22 at 97a851d59f)
 + docs: improve fast-forward in glossary content

 The description of "fast-forward" in the glossary has been updated.


* tl/fix-packfile-uri-doc (2021-05-25) 1 commit
  (merged to 'next' on 2021-05-25 at d047277014)
 + packfile-uri.txt: fix blobPackfileUri description

 Doc fix.


* wm/rev-parse-die-i18n (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-22 at 65c256d92b)
 + rev-parse: mark die() messages for translation

 Quite a many die() messages in rev-parse haven't been marked for
 translation.

--------------------------------------------------
[New Topics]

* ab/cmd-foo-should-return (2021-06-09) 1 commit
 - builtins + test helpers: use return instead of exit() in cmd_*

 Code clean-up.

 Will merge to 'next'.


* ab/progress-cleanup (2021-06-08) 1 commit
 - read-cache.c: don't guard calls to progress.c API

 Code clean-up.

 Will merge to 'next'.


* ab/test-tool-cache-cleanup (2021-06-08) 4 commits
 - read-cache perf: add a perf test for refresh_index()
 - test-tool: migrate read-cache-again to parse_options()
 - test-tool: migrate read-cache-perf to parse_options()
 - test-tool: split up test-tool read-cache

 Test code shuffling.

 Comments?


* ab/xdiff-bug-cleanup (2021-06-08) 1 commit
 - xdiff: use BUG(...), not xdl_bug(...)

 Code clean-up.

 Will merge to 'next'.


* ar/test-code-cleanup (2021-06-08) 1 commit
 - t: fix whitespace around &&

 Test code clean-up.

 Will merge to 'next'.


* ba/object-info (2021-06-08) 1 commit
 - protocol-caps.h: add newline at end of file

 Code clean-up.

 Will merge to 'next'.


* dd/document-log-decorate-default (2021-06-08) 1 commit
 - doc/log: correct default for --decorate

 Doc clean-up.

 Will merge to 'next'.


* fc/doc-default-to-upstream-config (2021-06-08) 1 commit
 - doc: merge: mention default of defaulttoupstream

 Doc clean-up.

 Will merge to 'next'.


* ms/mergetools-kdiff3-on-windows (2021-06-08) 1 commit
 - mergetools/kdiff3: make kdiff3 work on Windows too

 On Windows, mergetool has been taught to find kdiff3.exe just like
 it finds winmerge.exe.

 Will merge to 'next'.


* ab/pack-objects-stdin (2021-06-09) 4 commits
 - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 - pack-objects.c: do stdin parsing via revision.c's API
 - revision.h: unify "disable_stdin" and "read_from_stdin"
 - upload-pack: run is_repository_shallow() before setup_revisions()

 Code clean-up.

 Comments?


* ar/doc-libera-chat-in-my-first-contrib (2021-06-09) 1 commit
 - MyFirstContribution: link #git-devel to Libera Chat

 Update MyFirst document.

 Will merge to 'next'.


* ar/mailinfo-memcmp-to-skip-prefix (2021-06-09) 1 commit
 - mailinfo: use starts_with() when checking scissors

 Code clean-up.

 Will merge to 'next'.


* ar/submodule-add (2021-06-09) 2 commits
 - submodule--helper: introduce add-config subcommand
 - submodule--helper: introduce add-clone subcommand

 Rewrite of "git submodule" in C continues.

 Comments?


* ds/gender-neutral-doc (2021-06-10) 4 commits
 - CodingGuidelines: recommend singular they
 - *: fix typos
 - *: use singular they in comments
 - Documentation: use singular they when appropriate

 Attempt to update the documentation not to assume users are of
 certain gender and adds to guidelines to do so.

 Will wait for conclusion of the on-list discussion.


* gh/gitweb-branch-sort (2021-06-10) 1 commit
 - gitweb: use HEAD as secondary sort key in git_get_heads_list()

 Tie-break branches that point at the same object in the list of
 branches on GitWeb to show the one pointed at by HEAD early.

 Comments?


* jk/doc-max-pack-size (2021-06-09) 1 commit
 - doc: warn people against --max-pack-size

 Doc update.

 Will merge to 'next'.


* lh/systemd-timers (2021-06-09) 3 commits
 - maintenance: add support for systemd timers on Linux
 - maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>`
 - cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" function

 "git maintenance" scheduler learned to use systemd timers as a
 possible backend.

 Expecting a reroll.
 cf. <YMCLQ5pOyg+SSKhD@coredump.intra.peff.net>

--------------------------------------------------
[Stalled]

* mr/bisect-in-c-4 (2021-04-11) 4 commits
 - bisect--helper: retire `--bisect-next-check` subcommand
 - bisect--helper: reimplement `bisect_run` shell function in C
 - bisect--helper: reimplement `bisect_visualize()`shell function in C
 - run-command: make `exists_in_PATH()` non-static

 The codepaths involved in running "git bisect visualize" and "git
 bisect run" has been rewritten in C.

 Expecting a reroll.
 cf. <xmqq35vwh8qk.fsf@gitster.g>, <xmqqy2doftrj.fsf@gitster.g>,
 <CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj7ciavCVQ@mail.gmail.com>
 May want to boost the test coverage.


* hn/reftable (2021-05-20) 28 commits
 . t1404: annotate test cases with REFFILES
 . t1401,t2011: parameterize HEAD.lock for REFTABLE
 . t1301: document what needs to be done for REFTABLE
 . Add "test-tool dump-reftable" command.
 . git-prompt: prepare for reftable refs backend
 . Reftable support for git-core
 . reftable: add dump utility
 . reftable: implement stack, a mutable database of reftable files.
 . reftable: implement refname validation
 . reftable: add merged table view
 . reftable: add a heap-based priority queue for reftable records
 . reftable: reftable file level tests
 . reftable: read reftable files
 . reftable: generic interface to tables
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . Provide zlib's uncompress2 from compat/zlib-compat.c
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: add blocksource, an abstraction for random access reads
 . reftable: utility functions
 . reftable: add error related functionality
 . reftable: add LICENSE
 . init-db: set the_repository->hash_algo early on
 . hash.h: provide constants for the hash IDs
 . refs/debug: trace into reflog expiry too
 . refs: document reflog_expire_fn's flag argument
 . refs: make explicit that ref_iterator_peel returns boolean

 The "reftable" backend for the refs API.

 Waiting for reviews.
 Seems to break tests when merged to 'seen'.


* ma/t0091-bugreport-fix (2021-04-12) 1 commit
 - t0091-bugreport.sh: actually verify some content of report

 Test fix.

 Expecting a reroll.
 cf. <YHYZTLl90rkWWVOr@google.com>, <87a6q22dei.fsf@evledraar.gmail.com>


* ls/fast-export-signed (2021-05-03) 5 commits
 - fast-export, fast-import: add support for signed-commits
 - fast-export: do not modify memory from get_commit_buffer
 - git-fast-export.txt: clarify why 'verbatim' may not be a good idea
 - fast-export: rename --signed-tags=3D'warn' to 'warn-verbatim'
 - git-fast-import.txt: add missing LF in the BNF

 "git fast-export" offers a way to control how signed tags are
 handled; the mechanism has been extended to allow specifying how
 signed commits are handled as well.

 Expecting a reroll.
 cf. <xmqqa6pca0pv.fsf@gitster.g>, <xmqq1rao9zev.fsf@gitster.g>


* tb/multi-pack-bitmaps (2021-04-10) 23 commits
 . p5326: perf tests for MIDX bitmaps
 . p5310: extract full and partial bitmap tests
 . midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 . t7700: update to work with MIDX bitmap test knob
 . t5319: don't write MIDX bitmaps in t5319
 . t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 . t5326: test multi-pack bitmap behavior
 . t/helper/test-read-midx.c: add --checksum mode
 . t5310: move some tests to lib-bitmap.sh
 . pack-bitmap: write multi-pack bitmaps
 . pack-bitmap: read multi-pack bitmaps
 . pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 . pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 . pack-bitmap.c: introduce 'bitmap_num_objects()'
 . midx: respect 'core.multiPackIndex' when writing
 . midx: clear auxiliary .rev after replacing the MIDX
 . midx: make a number of functions non-static
 . Documentation: describe MIDX-based bitmaps
 . Documentation: build 'technical/bitmap-format' by default
 . pack-bitmap-write.c: free existing bitmaps
 . pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 . pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
 . Merge branch 'tb/pack-preferred-tips-to-give-bitmap' into tb/multi-pac=
k-bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Waiting for reviews.
 cf. <cover.1617991824.git.me@ttaylorr.com>
 Seems to break tests when merged to 'seen'.


* hn/refs-errno-cleanup (2021-04-30) 8 commits
 - refs: explicitly propagate errno from refs_read_raw_ref
 - refs: stop setting EINVAL and ELOOP in symref resolution
 - refs: clear errno return in refs_resolve_ref_unsafe()
 - refs: add failure_errno to refs_read_raw_ref() signature
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL specification from the errno sideband in read_raw_=
ref_fn

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

 Waiting for reviews.


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* ag/merge-strategies-in-c (2021-03-17) 15 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-ind=
ex
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Expecting a (hopefully final) reroll.
 cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.


* ds/status-with-sparse-index (2021-05-22) 14 commits
 - fsmonitor: integrate with sparse index
 - wt-status: expand added sparse directory entries
 - status: use sparse-index throughout
 - status: skip sparse-checkout percentage with sparse-index
 - dir.c: accept a directory as part of cone-mode patterns
 - unpack-trees: be careful around sparse directory entries
 - unpack-trees: compare sparse directories correctly
 - unpack-trees: preserve cache_bottom
 - t1092: add tests for status/add and sparse files
 - t1092: expand repository data shape
 - sparse-index: include EXTENDED flag when expanding
 - sparse-index: skip indexes with unmerged entries
 - Merge branch 'mt/add-rm-in-sparse-checkout' into ds/status-with-sparse=
-index
 - Merge branch 'ds/sparse-index-protections' into ds/status-with-sparse-=
index

 "git status" codepath learned to work with sparsely populated index
 without hydrating it fully.


* ab/describe-tests-fix (2021-05-11) 5 commits
 - describe tests: support -C in "check_describe"
 - describe tests: fix nested "test_expect_success" call
 - describe tests: don't rely on err.actual from "check_describe"
 - describe tests: refactor away from glob matching
 - describe tests: improve test for --work-tree & --dirty
 (this branch uses ab/test-lib-updates.)

 Various updates to tests around "git describe"

 Waiting for the base topic to solidify.


* ab/pickaxe-pcre2 (2021-05-11) 22 commits
 - xdiff-interface: replace discard_hunk_line() with a flag
 - xdiff users: use designated initializers for out_line
 - pickaxe -G: don't special-case create/delete
 - pickaxe -G: terminate early on matching lines
 - xdiff-interface: allow early return from xdiff_emit_line_fn
 - xdiff-interface: prepare for allowing early return
 - pickaxe -S: slightly optimize contains()
 - pickaxe: rename variables in has_changes() for brevity
 - pickaxe -S: support content with NULs under --pickaxe-regex
 - pickaxe: assert that we must have a needle under -G or -S
 - pickaxe: refactor function selection in diffcore-pickaxe()
 - perf: add performance test for pickaxe
 - pickaxe/style: consolidate declarations and assignments
 - diff.h: move pickaxe fields together again
 - pickaxe: die when --find-object and --pickaxe-all are combined
 - pickaxe: die when -G and --pickaxe-regex are combined
 - pickaxe tests: add missing test for --no-pickaxe-regex being an error
 - pickaxe tests: test for -G, -S and --find-object incompatibility
 - pickaxe tests: add test for "log -S" not being a regex
 - pickaxe tests: add test for diffgrep_consume() internals
 - pickaxe tests: refactor to use test_commit --append --printf
 - grep/pcre2 tests: reword comments referring to kwset
 (this branch uses ab/test-lib-updates.)

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.

 Waiting for the base topic to solidify.

--------------------------------------------------
[Cooking]

* dd/svn-test-wo-locale-a (2021-06-08) 1 commit
 - t: use user-specified utf-8 locale for testing svn

 "git-svn" tests assumed that "locale -a", which is used to pick an
 available UTF-8 locale, is available everywhere.  A knob has been
 introduced to allow testers to specify a suitable locale to use.

 Will merge to 'next'.


* fc/completion-updates (2021-06-07) 4 commits
 - completion: bash: add correct suffix in variables
 - completion: bash: fix for multiple dash commands
 - completion: bash: fix for suboptions with value
 - completion: bash: fix prefix detection in branch.*

 Command line completion updates.

 Expecting a reroll.
 cf. <60be6f7fa4435_db80d208f2@natae.notmuch>


* mr/cmake (2021-06-07) 3 commits
 - cmake: add warning for ignored MSGFMT_EXE
 - cmake: create compile_commands.json by default
 - cmake: add knob to disable vcpkg

 CMake update.

 Will merge to 'next'.


* ab/update-submitting-patches (2021-06-08) 3 commits
 - SubmittingPatches: remove pine-specific hints from MUA hints
 - SubmittingPatches: replace discussion of Travis with GitHub Actions
 - SubmittingPatches: move discussion of Signed-off-by above "send"

 Reorganize and update the SubmitingPatches document.

 Expecting a reroll.
 cf. <20210607172542.GA6312@szeder.dev>
 cf. <nycvar.QRO.7.76.6.2106072346560.55@tvgsbejvaqbjf.bet>


* hn/prep-tests-for-reftable (2021-06-02) 22 commits
 - t1415: set REFFILES for test specific to storage format
 - t4202: mark bogus head hash test with REFFILES
 - t7003: check reflog existence only for REFFILES
 - t7900: stop checking for loose refs
 - t1404: mark tests that muck with .git directly as REFFILES.
 - t2017: mark --orphan/logAllRefUpdates=3Dfalse test as REFFILES
 - t1414: mark corruption test with REFFILES
 - t1407: require REFFILES for for_each_reflog test
 - test-lib: provide test prereq REFFILES
 - t5304: use "reflog expire --all" to clear the reflog
 - t5304: restyle: trim empty lines, drop ':' before >
 - t7003: use rev-parse rather than FS inspection
 - t5000: inspect HEAD using git-rev-parse
 - t5000: reformat indentation to the latest fashion
 - t1301: fix typo in error message
 - t1413: use tar to save and restore entire .git directory
 - t1401-symbolic-ref: avoid direct filesystem access
 - t1401: use tar to snapshot and restore repo state
 - t5601: read HEAD using rev-parse
 - t9300: check ref existence using test-helper rather than a file system=
 check
 - t/helper/ref-store: initialize oid in resolve-ref
 - t4202: split testcase for invalid HEAD symref and HEAD hash

 Preliminary clean-up of tests before the main reftable changes
 hits the codebase.

 Will merge to 'next'.


* js/trace2-discard-event-docfix (2021-06-04) 1 commit
 - docs: fix api-trace2 doc for "too_many_files" event

 Docfix.

 Will merge to 'next'.


* tk/partial-clone-repack-doc (2021-06-04) 1 commit
 - Remove warning that repack only works on non-promisor packfiles

 Docfix.

 Will merge to 'next'.


* zh/cat-file-batch-fix (2021-06-04) 2 commits
 - cat-file: merge two block into one
 - cat-file: handle trivial --batch format with --batch-all-objects

 "git cat-file --batch-all-objects"" misbehaved when "--batch" is in
 use and did not ask for certain object traits.

 Will merge to 'next'.


* fc/push-simple-updates (2021-06-02) 7 commits
 - doc: push: explain default=3Dsimple correctly
 - push: remove unused code in setup_push_upstream()
 - push: simplify setup_push_simple()
 - push: reorganize setup_push_simple()
 - push: copy code to setup_push_simple()
 - push: hedge code of default=3Dsimple
 - push: rename !triangular to same_remote
 (this branch is used by fc/push-simple-updates-cleanup.)

 Some code and doc clarification around "git push".

 Will merge to 'next'.


* fc/push-simple-updates-cleanup (2021-06-02) 13 commits
 - push: don't get a full remote object
 - push: only check same_remote when needed
 - push: remove trivial function
 - push: remove redundant check
 - push: factor out the typical case
 - push: get rid of all the setup_push_* functions
 - push: trivial simplifications
 - push: make setup_push_* return the dst
 - push: only get the branch when needed
 - push: factor out null branch check
 - push: split switch cases
 - push: return immediately in trivial switch case
 - push: create new get_upstream_ref() helper
 (this branch uses fc/push-simple-updates.)

 Some more code and doc clarification around "git push".

 Will merge to 'next'.


* tb/complete-diff-anchored (2021-05-31) 1 commit
 - completion: add --anchored to diff's options

 The command line completion (in contrib/) learned that "git diff"
 takes the "--anchored" option.

 Will merge to 'next'.


* en/ort-perf-batch-12 (2021-06-09) 4 commits
 - merge-ort: miscellaneous touch-ups
 - Fix various issues found in comments
 - diffcore-rename: avoid unnecessary strdup'ing in break_idx
 - merge-ort: replace string_list_df_name_compare with faster alternative
 (this branch uses en/ort-perf-batch-11.)


* zh/ref-filter-raw-data (2021-06-10) 4 commits
 . ref-filter: add %(rest) atom
 . ref-filter: use non-const ref_format in *_atom_parser()
 . ref-filter: add %(raw) atom
 . ref-filter: add obj-type check in grab contents
 (this branch uses zh/ref-filter-atom-type.)

 Prepare the "ref-filter" machinery that drives the "--format"
 option of "git for-each-ref" and its friends to be used in "git
 cat-file --batch".


* fc/doc-build-cleanup (2021-05-24) 5 commits
  (merged to 'next' on 2021-05-31 at af103e12f4)
 + doc: avoid using rm directly
 + doc: simplify Makefile using .DELETE_ON_ERROR
 + doc: remove unnecessary rm instances
 + doc: improve asciidoc dependencies
 + doc: refactor common asciidoc dependencies

 Preparatory build procedure clean-up for documentation.

 Will merge to 'master'.


* es/config-based-hooks (2021-05-27) 37 commits
 - docs: link githooks and git-hook manpages
 - doc: clarify fsmonitor-watchman specification
 - run-command: stop thinking about hooks
 - git-send-email: use 'git hook run' for 'sendemail-validate'
 - bugreport: use hook_exists instead of find_hook
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - proc-receive: acquire hook list from hook.h
 - receive-pack: convert 'update' hook to hook.h
 - reference-transaction: look for hooks in config
 - transport: convert pre-push hook to use config
 - hook: convert 'post-rewrite' hook to config
 - hooks: convert 'post-checkout' hook to hook library
 - git-p4: use 'git hook' to run hooks
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change hook to use config
 - rebase: teach pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - merge: use config-based hooks for post-merge hook
 - am: convert applypatch hooks to use config
 - commit: use config-based hooks
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - hook: allow specifying working directory for hooks
 - hook: allow parallel hook execution
 - run-command: allow stdin for run_processes_parallel
 - hook: support passing stdin to hooks
 - hook: introduce hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: teach hook.runHookDir
 - hook: include hookdir hook in list
 - hook: introduce git-hook subcommand
 - doc: propose hooks managed by the config


* jh/builtin-fsmonitor (2021-05-24) 30 commits
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - p7519: add fsmonitor--daemon
 - t7527: create test for fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor: enhance existing comments
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement daemon command options
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - fsmonitor--daemon: implement client command options
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via=
 IPC
 - config: FSMonitor is repository-specific
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor--daemon: update fsmonitor documentation
 - fsmonitor--daemon: man page
 - simple-ipc: preparations for supporting binary messages.
 - Merge branch 'jk/perf-in-worktrees' into HEAD
 - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor

 An attempt to write and ship with a watchman equivalent tailored
 for our use.


* dd/honor-users-tar-in-tests (2021-05-22) 1 commit
  (merged to 'next' on 2021-05-28 at 56961581ce)
 + t: use configured TAR instead of tar

 Test portability fix.

 Will merge to 'master'.


* jk/clone-clean-upon-transport-error (2021-05-19) 1 commit
  (merged to 'next' on 2021-05-22 at 464b1f187c)
 + clone: clean up directory after transport_fetch_refs() failure

 Recent "git clone" left a temporary directory behind when the
 transport layer returned an failure.

 Will cook in 'next'.


* jk/fetch-pack-v2-half-close-early (2021-05-20) 1 commit
  (merged to 'next' on 2021-05-28 at 56e97ec2df)
 + fetch-pack: signal v2 server that we are done making requests

 "git fetch" over protocol v2 left its side of the socket open after
 it finished speaking, which unnecessarily wasted the resource on
 the other side.

 Will cook in 'next'.


* es/trace2-log-parent-process-name (2021-06-09) 1 commit
 - tr2: log parent process name


* ps/rev-list-object-type-filter (2021-05-21) 1 commit
  (merged to 'next' on 2021-05-28 at f22e938f3e)
 + help: fix small typo in error message

 Message update.

 Will cook in 'next'.


* ab/send-email-optim (2021-05-28) 13 commits
 - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
 - send-email: move trivial config handling to Perl
 - perl: lazily load some common Git.pm setup code
 - send-email: lazily load modules for a big speedup
 - send-email: get rid of indirect object syntax
 - send-email: use function syntax instead of barewords
 - send-email: lazily shell out to "git var"
 - send-email: lazily load config for a big speedup
 - send-email: copy "config_regxp" into git-send-email.perl
 - send-email: refactor sendemail.smtpencryption config parsing
 - send-email: remove non-working support for "sendemail.smtpssl"
 - send-email tests: test for boolean variables without a value
 - send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=3Dtrue

 "git send-email" optimization.

 Will merge to 'next'.


* zh/ref-filter-atom-type (2021-05-14) 2 commits
  (merged to 'next' on 2021-05-16 at 48fd717185)
 + ref-filter: introduce enum atom_type
 + ref-filter: add objectsize to used_atom
 (this branch is used by zh/ref-filter-raw-data.)

 The code to handle the "--format" option in "for-each-ref" and
 friends made too many string comparisons on %(atom)s used in the
 format string, which has been corrected by converting them into
 enum when the format string is parsed.

 Will cook in 'next'.


* ga/send-email-sendmail-cmd (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-22 at 755df67f0e)
 + git-send-email: add option to specify sendmail command

 "git send-email" learned the "--sendmail-cmd" command line option
 and the "sendemail.sendmailCmd" configuration variable, which is a
 more sensible approach than the current way of repurposing the
 "smtp-server" that is meant to name the server to instead name the
 command to talk to the server.

 Will cook in 'next'.


* ds/write-index-with-hashfile-api (2021-05-19) 4 commits
  (merged to 'next' on 2021-05-28 at f0c51ddf7c)
 + read-cache: delete unused hashing methods
 + read-cache: use hashfile instead of git_hash_ctx
 + csum-file.h: increase hashfile buffer size
 + hashfile: use write_in_full()

 Use the hashfile API in the codepath that writes the index file to
 reduce code duplication.

 Will cook in 'next'.


* so/log-m-implies-p (2021-05-21) 10 commits
  (merged to 'next' on 2021-05-28 at 2733ec2409)
 + diff-merges: let "-m" imply "-p"
 + diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
 + stash list: stop passing "-m" to "git log"
 + git-svn: stop passing "-m" to "git rev-list"
 + diff-merges: move specific diff-index "-m" handling to diff-index
 + t4013: test "git diff-index -m"
 + t4013: test "git diff-tree -m"
 + t4013: test "git log -m --stat"
 + t4013: test "git log -m --raw"
 + t4013: test that "-m" alone has no effect in "git log"

 The "-m" option in "git log -m" that does not specify which format,
 if any, of diff is desired did not have any visible effect; it now
 implies some form of diff (by default "--patch") is produced.

 Will cook in 'next'.


* bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-14) 2 commits
 - doc: remove GNU_ROFF option
 - doc: add an option to have Asciidoctor build man pages directly

 An option to render the manual pages via AsciiDoctor bypassing
 xmlto has been introduced.


* ab/trace2-squelch-gcc-warning (2021-05-21) 1 commit
  (merged to 'next' on 2021-05-28 at 6c7a015f99)
 + trace2: refactor to avoid gcc warning under -O3

 Workaround compiler warnings.

 Will merge to 'master'.


* en/ort-perf-batch-11 (2021-05-20) 13 commits
  (merged to 'next' on 2021-05-28 at 58a8b85d6a)
 + merge-ort, diffcore-rename: employ cached renames when possible
 + merge-ort: handle interactions of caching and rename/rename(1to1) case=
s
 + merge-ort: add helper functions for using cached renames
 + merge-ort: preserve cached renames for the appropriate side
 + merge-ort: avoid accidental API mis-use
 + merge-ort: add code to check for whether cached renames can be reused
 + merge-ort: populate caches of rename detection results
 + merge-ort: add data structures for in-memory caching of rename detecti=
on
 + t6429: testcases for remembering renames
 + fast-rebase: write conflict state to working tree, index, and HEAD
 + fast-rebase: change assert() to BUG()
 + Documentation/technical: describe remembering renames optimization
 + t6423: rename file within directory that other side renamed
 (this branch is used by en/ort-perf-batch-12.)

 Optimize out repeated rename detection in a sequence of mergy
 operations.

 Will cook in 'next'.


* ab/test-lib-updates (2021-05-11) 11 commits
  (merged to 'next' on 2021-05-31 at 73bf1ecb31)
 + test-lib: split up and deprecate test_create_repo()
 + test-lib: do not show advice about init.defaultBranch under --verbose
 + test-lib: reformat argument list in test_create_repo()
 + submodule tests: use symbolic-ref --short to discover branch name
 + test-lib functions: add --printf option to test_commit
 + describe tests: convert setup to use test_commit
 + test-lib functions: add an --annotated option to "test_commit"
 + test-lib-functions: document test_commit --no-tag
 + test-lib-functions: reword "test_commit --append" docs
 + test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 + test-lib: bring $remove_trash out of retirement
 (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)

 Test clean-up.

 Will cook in 'next'.


* ab/fsck-unexpected-type (2021-05-21) 17 commits
 . fsck: report invalid object type-path combinations
 . fsck: report invalid types recorded in objects
 . object-store.h: move read_loose_object() below 'struct object_info'
 . fsck: don't hard die on invalid object types
 . object-file.c: return -1, not "status" from unpack_loose_header()
 . object-file.c: return -2 on "header too long" in unpack_loose_header()
 . object-file.c: stop dying in parse_loose_header()
 . object-file.c: add missing braces to loose_object_info()
 . object-file.c: make parse_loose_header_extended() public
 . cache.h: move object functions to object-store.h
 . cat-file tests: test for current --allow-unknown-type behavior
 . cat-file tests: add corrupt loose object test
 . rev-list tests: test for behavior with invalid object types
 . cat-file tests: test that --allow-unknown-type isn't on by default
 . cat-file tests: test for missing object with -t and -s
 . fsck tests: add test for fsck-ing an unknown type
 . fsck tests: refactor one test to use a sub-repo

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Seems to break tests when merged to 'seen'.

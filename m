Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC66EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 20:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGYU6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjGYU57 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 16:57:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67C2125
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 13:57:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56E98327E4;
        Tue, 25 Jul 2023 16:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=x
        MaE/Wac+HEIo9YZtP2xyo3cXeZ5kGvpsqzU6dnEFC0=; b=hh1Ym6cN3p4O2v5Gi
        I07vtpisbHuVitsaJc8L6eMZPYNJ+6pXhCZrGtZoqd8fA+0U6BB341ZhCpLaYo7k
        2t/rgXey31/ddptZO1XdyKrAmHlBbyMiVhdhu90lOs6iLVl+xbSEDXrOIfGsnu3P
        lbF+kNkaq8vIOtU8laUDZNnpF8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F041327E3;
        Tue, 25 Jul 2023 16:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF1F5327E2;
        Tue, 25 Jul 2023 16:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2023, #05; Tue, 25)
X-master-at: a80be152923a46f04a06bade7bcc72870e46ca09
X-next-at: 7dcf015ea4152b2113f79acb1e230aef744551f3
Date:   Tue, 25 Jul 2023 13:57:39 -0700
Message-ID: <xmqqedkvk8u4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4EC7AE8-2B2D-11EE-9AC5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

* ah/advise-force-pushing (2023-07-13) 3 commits
  (merged to 'next' on 2023-07-17 at b040e8280e)
 + push: don't imply that integration is always required before pushing
 + remote: don't imply that integration is always required before pushing
 + wt-status: don't show divergence advice when committing

 Help newbies by suggesting that there are cases where force-pushing
 is a valid and sensible thing to update a branch at a remote
 repository, rather than reconciling with merge/rebase.
 source: <20230713044128.3771818-1-alexhenrie24@gmail.com>


* dk/bundle-i18n-more (2023-07-13) 1 commit
  (merged to 'next' on 2023-07-18 at a9745efbe2)
 + i18n: mark more bundle.c strings for translation

 Update message mark-up for i18n in "git bundle".
 source: <pull.1550.git.1689285683013.gitgitgadget@gmail.com>


* dk/t4002-syntaxo-fix (2023-07-14) 1 commit
  (merged to 'next' on 2023-07-17 at 75d729ee52)
 + t4002: fix "diff can read from stdin" syntax

 Test fix.
 source: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com>


* jk/nested-points-at (2023-07-17) 4 commits
  (merged to 'next' on 2023-07-18 at cf33f44a50)
 + ref-filter: simplify return type of match_points_at
 + ref-filter: avoid parsing non-tags in match_points_at()
 + ref-filter: avoid parsing tagged objects in match_points_at()
 + ref-filter: handle nested tags in --points-at option

 "git tag --list --points-at X" showed tags that directly refers to
 object X, but did not list a tag that points at such a tag, which
 has been corrected.
 source: <20230702223342.GA1598765@coredump.intra.peff.net>


* jk/unused-parameter (2023-07-13) 14 commits
  (merged to 'next' on 2023-07-18 at 59d8f4ec1e)
 + t/helper: mark unused callback void data parameters
 + tag: mark unused parameters in each_tag_name_fn callbacks
 + rev-parse: mark unused parameter in for_each_abbrev callback
 + replace: mark unused parameter in each_mergetag_fn callback
 + replace: mark unused parameter in ref callback
 + merge-tree: mark unused parameter in traverse callback
 + fsck: mark unused parameters in various fsck callbacks
 + revisions: drop unused "opt" parameter in "tweak" callbacks
 + count-objects: mark unused parameter in alternates callback
 + am: mark unused keep_cr parameters
 + http-push: mark unused parameter in xml callback
 + http: mark unused parameters in curl callbacks
 + do_for_each_ref_helper(): mark unused repository parameter
 + test-ref-store: drop unimplemented reflog-expire command

 Mark-up unused parameters in the code so that we can eventually
 enable -Wunused-parameter by default.
 source: <20230703064347.GA3524892@coredump.intra.peff.net>


* mh/mingw-case-sensitive-build (2023-06-12) 1 commit
  (merged to 'next' on 2023-07-17 at 2c72856851)
 + mingw: use lowercase includes for some Windows headers

 Names of MinGW header files are spelled in mixed case in some
 source files, but the build host can be using case sensitive
 filesystem with header files with their name spelled in all
 lowercase.
 source: <20230604211934.1365289-1-mh@glandium.org>


* rs/ref-filter-signature-fix (2023-07-17) 1 commit
  (merged to 'next' on 2023-07-18 at e74f016a60)
 + t6300: fix setup with GPGSSH but without GPG

 Test fix.
 source: <cbc22750-af93-9274-2ed4-6dfd356568e8@web.de>


* rs/strbuf-addftime-simplify (2023-07-17) 1 commit
  (merged to 'next' on 2023-07-18 at d665b0f0e9)
 + strbuf: use skip_prefix() in strbuf_addftime()

 Code clean-up.
 source: <fccba24c-584d-6329-69a7-75cf0458af7d@web.de>


* tb/object-access-overflow-protection (2023-07-14) 20 commits
  (merged to 'next' on 2023-07-17 at 9ad8a08011)
 + commit-graph.c: prevent overflow in `verify_commit_graph()`
 + commit-graph.c: prevent overflow in `write_commit_graph()`
 + commit-graph.c: prevent overflow in `merge_commit_graph()`
 + commit-graph.c: prevent overflow in `split_graph_merge_strategy()`
 + commit-graph.c: prevent overflow in `load_tree_for_commit()`
 + commit-graph.c: prevent overflow in `fill_commit_in_graph()`
 + commit-graph.c: prevent overflow in `fill_commit_graph_info()`
 + commit-graph.c: prevent overflow in `load_oid_from_graph()`
 + commit-graph.c: prevent overflow in add_graph_to_chain()
 + commit-graph.c: prevent overflow in `write_commit_graph_file()`
 + pack-bitmap.c: ensure that eindex lookups don't overflow
 + midx.c: prevent overflow in `fill_included_packs_batch()`
 + midx.c: prevent overflow in `write_midx_internal()`
 + midx.c: store `nr`, `alloc` variables as `size_t`'s
 + midx.c: prevent overflow in `nth_midxed_offset()`
 + midx.c: prevent overflow in `nth_midxed_object_oid()`
 + midx.c: use `size_t`'s for fanout nr and alloc
 + packfile.c: use checked arithmetic in `nth_packed_object_offset()`
 + packfile.c: prevent overflow in `load_idx()`
 + packfile.c: prevent overflow in `nth_packed_object_id()`

 Various offset computation in the code that accesses the packfiles
 and other data in the object layer has been hardened against
 arithmetic overflow, especially on 32-bit systems.
 source: <ZLAJNbIBFUPHYhlt@nand.local>
 source: <cover.1689205042.git.me@ttaylorr.com>


* tb/refs-exclusion-and-packed-refs (2023-07-10) 16 commits
  (merged to 'next' on 2023-07-13 at 6d72f3e995)
 + ls-refs.c: avoid enumerating hidden refs where possible
 + upload-pack.c: avoid enumerating hidden refs where possible
 + builtin/receive-pack.c: avoid enumerating hidden references
 + refs.h: implement `hidden_refs_to_excludes()`
 + refs.h: let `for_each_namespaced_ref()` take excluded patterns
 + revision.h: store hidden refs in a `strvec`
 + refs/packed-backend.c: add trace2 counters for jump list
 + refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
 + refs/packed-backend.c: refactor `find_reference_location()`
 + refs: plumb `exclude_patterns` argument throughout
 + builtin/for-each-ref.c: add `--exclude` option
 + ref-filter.c: parameterize match functions over patterns
 + ref-filter: add `ref_filter_clear()`
 + ref-filter: clear reachable list pointers after freeing
 + ref-filter.h: provide `REF_FILTER_INIT`
 + refs.c: rename `ref_filter`

 Enumerating refs in the packed-refs file, while excluding refs that
 match certain patterns, has been optimized.
 source: <cover.1689023520.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* ah/sequencer-rewrite-todo-fix (2023-07-24) 1 commit
 - sequencer: finish parsing the todo list despite an invalid first line

 When the user edits "rebase -i" todo file so that it starts with a
 "fixup", which would make it invalid, the command truncated the
 rest of the file before giving an error and returning the control
 back to the user.  Stop truncating to make it easier to correct
 such a malformed todo file.

 Will merge to 'next'.
 cf. <https://lore.kernel.org/git/0d1c5bfd-3ae5-83f0-a333-bbb8510a973a@gmail.com/>
 source: <20230722212830.132135-2-alexhenrie24@gmail.com>


* bb/trace2-comment-fix (2023-07-19) 1 commit
  (merged to 'next' on 2023-07-21 at f77aeba1b5)
 + trace2: fix a comment

 In-code comment fix.

 Will merge to 'master'.
 source: <20230719232444.555838-1-dev+git@drbeat.li>


* ks/ref-filter-describe (2023-07-24) 2 commits
 - ref-filter: add new "describe" atom
 - ref-filter: add multiple-option parsing functions

 "git branch --list --format=<format>" and friends are taught
 a new "%(describe)" placeholder.

 Will merge to 'next'.
 source: <20230723162717.68123-1-five231003@gmail.com>


* bb/use-trace2-counters-for-fsync-stats (2023-07-20) 1 commit
 - wrapper: use trace2 counters to collect fsync stats

 Instead of inventing a custom counter variables for debugging,
 use existing trace2 facility in the fsync customization codepath.

 Will merge to 'next'.
 source: <20230720164823.625815-1-dev+git@drbeat.li>


* am/doc-sha256 (2023-07-20) 1 commit
 - doc: sha256 is no longer experimental

 Tone down the warning on SHA-256 repositories being an experimental
 curiosity.  We do not have support for them to interoperate with
 traditional SHA-1 repositories, but at this point, we do not plan
 to make breaking changes to SHA-256 repositories and there is no
 longer need for such a strongly phrased warning.

 Review comments sent.
 cf. <xmqqr0p230rj.fsf@gitster.g>
 source: <ZLlNtbAbVcYH7eFb@adams>


* hy/blame-in-bare-with-contents (2023-07-21) 1 commit
 - blame: allow --contents to work with bare repo

 "git blame --contents=file" has been taught to work in a bare
 repository.

 Will merge to 'next'?
 source: <20230721035758.61956-1-hanyang.tony@bytedance.com>


* ja/worktree-orphan-fix (2023-07-21) 4 commits
 - SQUASH???
 - t2400: rewrite regex to avoid unintentional PCRE
 - builtin/worktree.c: convert tab in advice to space
 - t2400: drop no-op `--sq` from rev-parse call

 Expecting a reroll.
 cf. <axnxvnmo6ekhhccppinji73ivlandwuqs44epmq4pdefm7ukiv@ejz7bee5xjli>
 source: <20230721044012.24360-1-jacobabel@nullpo.dev>


* rs/describe-parseopt-fix (2023-07-21) 1 commit
  (merged to 'next' on 2023-07-21 at e74749af0c)
 + describe: fix --no-exact-match

 Command line parser fix.

 Will merge to 'master'.
 source: <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>


* rs/pack-objects-parseopt-fix (2023-07-21) 2 commits
  (merged to 'next' on 2023-07-21 at acdf84416c)
 + pack-objects: fix --no-quiet
 + pack-objects: fix --no-keep-true-parents

 Command line parser fix.

 Will merge to 'master'.
 source: <xmqqo7k9fa5x.fsf@gitster.g>


* jc/retire-get-sha1-hex (2023-07-24) 1 commit
 - hex: retire get_sha1_hex()

 The implementation of "get_sha1_hex()" that reads a hexadecimal
 string that spells a full object name has been extended to cope
 with any hash function used in the repository, but the "sha1" in
 its name survived.  Rename it to get_hash_hex(), a name that is
 more consistent within its friends like get_hash_hex_algop().

 Will merge to 'next'.
 source: <xmqq1qgwoqgo.fsf_-_@gitster.g>


* rs/parse-options-negation-help (2023-07-24) 5 commits
 - parse-options: show negatability of options in short help
 - t1502: test option negation
 - t1502: move optionspec help output to a file
 - t1502, docs: disallow --no-help
 - subtree: disallow --no-{help,quiet,debug,branch,message}

 "git cmd -h" learned to signal which options can be negated by
 listing such options like "--[no-]opt".

 Comments?
 Would showing "--[[no-]no-]opt" for "no-opt" be worth it?
 cf. <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
 source: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>


* tb/commit-graph-tests (2023-07-24) 5 commits
 - t/lib-commit-graph.sh: avoid sub-shell in `graph_git_behavior()`
 - t5328: avoid top-level directory changes
 - t5318: avoid top-level directory changes
 - t/lib-commit-graph.sh: avoid directory change in `graph_git_behavior()`
 - t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories

 Test updates.

 Will merge to 'next'?
 source: <cover.1690216758.git.me@ttaylorr.com>

--------------------------------------------------
[Stalled]

* tk/cherry-pick-sequence-requires-clean-worktree (2023-06-01) 1 commit
 - cherry-pick: refuse cherry-pick sequence if index is dirty

 "git cherry-pick A" that replays a single commit stopped before
 clobbering local modification, but "git cherry-pick A..B" did not,
 which has been corrected.

 Expecting a reroll.
 cf. <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
 source: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>


* ed/fsmonitor-windows-named-pipe (2023-03-24) 1 commit
 - fsmonitor: handle differences between Windows named pipe functions

 Fix fsmonitor on Windows when the filesystem path contains certain
 characters.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
 source: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>


* rn/sparse-diff-index (2023-04-10) 1 commit
 - diff-index: enable sparse index

 "git diff-index" command has been taught to work better with the
 sparse index.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com>
 source: <20230408112342.404318-1-nanth.raghul@gmail.com>


* es/recurse-submodules-option-is-a-bool (2023-04-10) 1 commit
 - usage: clarify --recurse-submodules as a boolean

 The "--[no-]recurse-submodules" option of "git checkout" and others
 supported an undocumented syntax --recurse-submodules=<value> where
 the value can spell a Boolean in various ways.  The support for the
 syntax is being dropped.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <ZDSTFwMFO7vbj/du@google.com>
 source: <ZDSTFwMFO7vbj/du@google.com>


* cb/checkout-same-branch-twice (2023-03-22) 2 commits
 - SQUASH??? the test marked to expect failure passes from day one
 - checkout/switch: disallow checking out same branch in multiple worktrees

 "git checkout -B $branch" failed to protect against checking out
 a branch that is checked out elsewhere, unlike "git branch -f" did.

 Will discard.
 Have been expecting a hopefully minor and final reroll for too long.
 cf. <CAPUEspj_Bh+LgYLnWfeBdcq_uV5Cbou-7H51GLFjzSa5Qzby9w@mail.gmail.com>
 source: <20230120113553.24655-1-carenas@gmail.com>


* ab/tag-object-type-errors (2023-05-10) 4 commits
 - tag: don't emit potentially incorrect "object is a X, not a Y"
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - Merge branch 'jk/parse-object-type-mismatch' into ab/tag-object-type-errors

 Hardening checks around mismatched object types when one of those
 objects is a tag.

 Will discard.
 Stalled for too long.
 source: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>


* ob/revert-of-revert (2023-05-05) 1 commit
 - sequencer: beautify subject of reverts of reverts

 Instead of "Revert "Revert "original"", give "Reapply "original""
 as the title for a revert of a revert.

 Will discard.
 Have been expecting a hopefully final reroll for too long.
 Looking much better, except for minor cosmetic issues.
 cf. <xmqqmt21txid.fsf@gitster.g>
 source: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>


* pw/rebase-i-after-failure (2023-04-21) 6 commits
 - rebase -i: fix adding failed command to the todo list
 - rebase: fix rewritten list for failed pick
 - rebase --continue: refuse to commit after failed command
 - sequencer: factor out part of pick_commits()
 - rebase -i: remove patch file after conflict resolution
 - rebase -i: move unlink() calls

 Various fixes to the behaviour of "rebase -i" when the command got
 interrupted by conflicting changes.

 Will discard.
 Have been expecting a reroll for too long.
 cf. <xmqqsfcthrpb.fsf@gitster.g>
 cf. <1fd54422-b66a-c2e4-7cd7-934ea01190ad@gmail.com>
 cf. <55dd6194-25e5-1a66-9c39-27cb19bfbb3c@gmail.com>
 source: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* la/doc-choose-starting-point (2023-07-14) 5 commits
  (merged to 'next' on 2023-07-19 at 5a807cae46)
 + SubmittingPatches: simplify guidance for choosing a starting point
 + SubmittingPatches: emphasize need to communicate non-default starting points
 + SubmittingPatches: de-emphasize branches as starting points
 + SubmittingPatches: discuss subsystems separately from git.git
 + SubmittingPatches: reword awkward phrasing

 Clarify how to choose the starting point for a new topic in
 developer guidance document.

 Will merge to 'master'.
 source: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>


* jr/gitignore-doc-example-markup (2023-07-18) 1 commit
  (merged to 'next' on 2023-07-19 at 4f2ece568d)
 + gitignore.txt: use backticks instead of double quotes

 Doc update.

 Will merge to 'master'.
 source: <pull.1553.git.git.1689685982027.gitgitgadget@gmail.com>


* jc/am-parseopt-fix (2023-07-18) 1 commit
  (merged to 'next' on 2023-07-19 at eaf592531e)
 + am: simplify parsing of "--[no-]keep-cr"

 Code simplification.

 Will merge to 'master'.
 source: <xmqqr0p5gjv3.fsf@gitster.g>


* jc/branch-parseopt-fix (2023-07-18) 1 commit
  (merged to 'next' on 2023-07-19 at 738d25bbb6)
 + branch: reject "--no-all" and "--no-remotes" early

 Command line parser fixes.

 Will merge to 'master'.
 source: <xmqqjzuxgjmi.fsf@gitster.g>


* rs/ls-tree-no-full-name-fix (2023-07-18) 1 commit
  (merged to 'next' on 2023-07-19 at 86e570c084)
 + ls-tree: fix --no-full-name

 Command line parser fix.

 Will merge to 'master'.
 source: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>


* jc/doc-sent-patch-now-what (2023-07-19) 1 commit
 - MyFirstContribution: refrain from self-iterating too much

 Process document update.

 Will merge to 'next'?
 source: <xmqqzga9opdu.fsf@gitster.g>


* jc/gitignore-doc-pattern-markup (2023-07-18) 1 commit
  (merged to 'next' on 2023-07-20 at ecfc9c6118)
 + gitignore.txt: mark up explanation of patterns consistently

 Doc mark-up update.

 Will merge to 'master'.
 source: <xmqqwmyxglhg.fsf@gitster.g>


* jc/parse-options-reset (2023-07-19) 1 commit
  (merged to 'next' on 2023-07-20 at d2178a4bd4)
 + reset: reject --no-(mixed|soft|hard|merge|keep) option

 Command line parser fix.

 Will merge to 'master'.
 source: <xmqq1qh4c998.fsf@gitster.g>


* jc/parse-options-short-help (2023-07-19) 3 commits
 - short help: allow a gap smaller than USAGE_GAP
 - remote: simplify "remote add --tags" help text
 - short help: allow multi-line opthelp

 Command line parser fix, and a small parse-options API update.

 Comments?
 source: <xmqq5y6gg8fn.fsf@gitster.g>


* jc/parse-options-show-branch (2023-07-19) 2 commits
  (merged to 'next' on 2023-07-20 at 4fa809c2f2)
 + show-branch: reject --[no-](topo|date)-order
 + show-branch: --no-sparse should give dense output

 Command line parser fixes.

 Will merge to 'master'.
 source: <xmqqh6pzc15n.fsf@gitster.g>


* jc/transport-parseopt-fix (2023-07-18) 2 commits
  (merged to 'next' on 2023-07-20 at 07f0026aaa)
 + fetch: reject --no-ipv[46]
 + parse-options: introduce OPT_IPVERSION()

 Command line parser fixes.

 Will merge to 'master'.
 source: <xmqqedl4gag8.fsf@gitster.g>


* sl/sparse-check-attr (2023-07-18) 3 commits
 - check-attr: integrate with sparse-index
 - attr.c: read attributes in a sparse directory
 - t1092: add tests for 'git check-attr'

 Teach "git check-attr" work better with sparse-index.

 Expecting a reroll.
 cf. <c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@github.com>
 cf. <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
 source: <20230718232916.31660-1-cheskaqiqi@gmail.com>


* ah/autoconf-fixes (2023-07-19) 3 commits
  (merged to 'next' on 2023-07-25 at 35ff66e0cb)
 + configure.ac: always save NO_ICONV to config.status
 + configure.ac: don't overwrite NO_CURL option
 + configure.ac: don't overwrite NO_EXPAT option

 "./configure --with-expat=no" did not work as a way to refuse use
 of the expat library on a system with the library installed, which
 has been corrected.

 Will merge to 'master'.
 source: <20230719145211.17854-2-aherrmann@suse.de>


* jc/branch-in-use-error-message (2023-07-21) 1 commit
 - branch: update the message to refuse touching a branch in-use

 "git branch -f X" to repoint the branch X seid that X was "checked
 out" in another worktree, even when branch X was not and instead
 being bisected or rebased.  The message was reworded to say the
 branch was "in use".

 Will merge to 'next'?
 source: <xmqqr0p1szhz.fsf_-_@gitster.g>


* jc/doc-submodule-update-settings (2023-07-13) 1 commit
 . submodule: clarify that "!custom command" is the only oddball

 Rewrite the description of giving a custom command to the
 submodule.<name>.update configuraiton variable.

 Expecting a reroll from the original author.
 cf. <0d29ac42-4e8f-71b6-b85f-00de182e2957@imap.cc>
 source: <xmqqwmz3oacg.fsf@gitster.g>


* jc/tree-walk-drop-base-offset (2023-07-07) 2 commits
  (merged to 'next' on 2023-07-25 at cc050c60a6)
 + tree-walk: drop unused base_offset from do_match()
 + tree-walk: lose base_offset that is never used in tree_entry_interesting

 Code simplification.

 Will merge to 'master'.
 source: <20230707222116.4129415-1-gitster@pobox.com>


* mh/credential-erase-improvements-more (2023-06-24) 2 commits
 - credential/wincred: erase matching creds only
 - credential/libsecret: erase matching creds only

 Needs review.
 source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>


* cc/repack-sift-filtered-objects-to-separate-pack (2023-07-24) 8 commits
 - gc: add `gc.repackFilterTo` config option
 - repack: implement `--filter-to` for storing filtered out objects
 - gc: add `gc.repackFilter` config option
 - repack: add `--filter=<filter-spec>` option
 - repack: refactor finding pack prefix
 - repack: refactor finishing pack-objects command
 - t/helper: add 'find-pack' test-tool
 - pack-objects: allow `--filter` without `--stdout`

 "git repack" machinery learns to pay attention to the "--filter="
 option.

 Will merge to 'next'.
 source: <20230724085909.3831831-1-christian.couder@gmail.com>


* js/doc-unit-tests (2023-06-30) 1 commit
 - unit tests: Add a project plan document

 Process to add some form of low-level unit tests has started.

 Still filling in blanks.
 source: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>


* jt/path-filter-fix (2023-07-13) 4 commits
 - commit-graph: new filter ver. that fixes murmur3
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - gitformat-commit-graph: describe version 2 of BDAT

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Expecting a reroll.
 cf. <20230720202203.3816309-1-jonathantanmy@google.com>
 source: <cover.1689283789.git.jonathantanmy@google.com>


* mh/credential-libsecret-attrs (2023-06-16) 1 commit
 - credential/libsecret: store new attributes

 The way authentication related data other than passwords (e.g.
 oath token and password expiration data) are stored in libsecret
 keyrings has been rethought.

 Needs review.
 source: <pull.1469.v5.git.git.1686945306242.gitgitgadget@gmail.com>


* cc/git-replay (2023-06-03) 15 commits
 - replay: stop assuming replayed branches do not diverge
 - replay: add --contained to rebase contained branches
 - replay: add --advance or 'cherry-pick' mode
 - replay: disallow revision specific options and pathspecs
 - replay: use standard revision ranges
 - replay: make it a minimal server side command
 - replay: remove HEAD related sanity check
 - replay: remove progress and info output
 - replay: add an important FIXME comment about gpg signing
 - replay: don't simplify history
 - replay: introduce pick_regular_commit()
 - replay: die() instead of failing assert()
 - replay: start using parse_options API
 - replay: introduce new builtin
 - t6429: remove switching aspects of fast-rebase

 What's the status of this thing?
 source: <20230602102533.876905-1-christian.couder@gmail.com>

--------------------------------------------------
[Discarded]

* jc/rerere-read-rr-fix (2023-07-21) 1 commit
 . rerere: match the hash algorithm with its length

 SHA-256 fix.

 Superseded by jc/retire-get-sha1-hex
 source: <xmqqa5vou9ar.fsf@gitster.g>

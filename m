Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0DC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 19:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4E364F47
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 19:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhCOTad (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 15:30:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55759 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhCOTaR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 15:30:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D74E7B12E2;
        Mon, 15 Mar 2021 15:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=k8BV8DjUf+i2y/XNlV/Fq6m6i
        aI=; b=T2Wv0LdK8qwRWaajkWva0BFK8ujj7pxViE0/KexCjTt8WULQqiWHFylwm
        mfU1oYeLcvUCB2RUl1I4Lb0DqkDJpqaDY8MNHE0Y9isiKkn7gwAOQgKygYwPBT6g
        LeQHiTHNYz51aZYdZRtXjdxk+Dg4mvqvUVn1yRjool+/rtX5Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=F4xw7SrDNjWf66pTWLv
        XOrpQAiasHLF9UxfgRnuSNsW9dYnUwylC+oxfBkV4Q5aIC6VXxCGPFPnUsINmXkq
        /vSYGwUyGgNYnJqQE9wrDcUaRhwmvIDr7qlXM3SSC+PQxlez7MJQ9frhlfkqm4/K
        rJZxArTUVnQ2VXTpWU8UsLLA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD9CBB12E1;
        Mon, 15 Mar 2021 15:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3748CB12E0;
        Mon, 15 Mar 2021 15:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git v2.31.0
Date:   Mon, 15 Mar 2021 12:30:15 -0700
Message-ID: <xmqqwnu8z03c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DEC5173A-85C4-11EB-99A5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.31.0 is now available at the
usual places.  It is comprised of 679 non-merge commits since
v2.30.0, contributed by 85 people, 23 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.31.0'
tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.30.0 are as follows.
Welcome to the Git development community!

  Aleksey Kliger, Andreas B=C3=BChmann, Andrew Klotz, Andrzej Hunt,
  Antonio Russo, Arnaud Morin, Bagas Sanjaya, Christian Walther,
  Clement Moyroud, Daniel Levin, Daniel Troger, Harold Kim,
  Jacob Vosmaer, LeSeulArtichaut, Mikhail Klyushin, Neeraj Singh,
  Sangeeta Jain, Seth House, Shubham Verma, Utku Gultopu, Vasyl
  Vavrychuk, Vojt=C4=9Bch Knyttl, and ZheNing Hu.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Abhishek Kumar, Adam Dinwoodie, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason,
  Alexander Shopov, Alex Henrie, Arusekk, brian m. carlson,
  Christian Couder, Christopher Diaz Riveros, Dana Dahlstrom,
  Daniel Santos, Denton Liu, Derrick Stolee, Dimitriy Ryazantcev,
  Elijah Newren, Emir Sar=C4=B1, Eric Sunshine, Eric Wong, Felipe
  Contreras, Han-Wen Nienhuys, Hariom Verma, Heba Waly, Jean-No=C3=ABl
  Avila, Jeff Hostetler, Jeff King, Jiang Xin, Joey Salazar,
  Johannes Schindelin, Johannes Sixt, Jonathan Nieder, Jonathan
  Tan, Jordi Mas, Junio C Hamano, Kevin Daudt, Kevin Willford,
  Lars Schneider, Martin =C3=85gren, Martin von Zweigbergk, Matheus
  Tavares, Matthias R=C3=BCster, Michael Haggerty, Patrick Steinhardt,
  Paul Jolly, Peter Kaestle, Peter Krefting, Phil Hord, Philippe
  Blain, Phillip Szelat, Phillip Wood, Pranit Bauva, Pratyush
  Yadav, Rafael Silva, Ralf Thielow, Ren=C3=A9 Scharfe, Ross Light,
  Sergey Organov, SZEDER G=C3=A1bor, Taylor Blau, Thomas Ackermann,
  Torsten B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, and Yi-=
Jyun Pan.

[*] We are counting not just the authorship contribution but
    issue reporting, testing and reviewing that are recorded
    in the commit trailers.

----------------------------------------------------------------

Git 2.31 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v2.30
-------------------

Backward incompatible and other important changes

 * The "pack-redundant" command, which has been left stale with almost
   unusable performance issues, now warns loudly when it gets used, as
   we no longer want to recommend its use (instead just "repack -d"
   instead).

 * The development community has adopted Contributor Covenant v2.0 to
   update from v1.4 that we have been using.

 * The support for deprecated PCRE1 library has been dropped.

 * Fixes for CVE-2021-21300 in Git 2.30.2 (and earlier) is included.


UI, Workflows & Features

 * The "--format=3D%(trailers)" mechanism gets enhanced to make it
   easier to design output for machine consumption.

 * When a user does not tell "git pull" to use rebase or merge, the
   command gives a loud message telling a user to choose between
   rebase or merge but creates a merge anyway, forcing users who would
   want to rebase to redo the operation.  Fix an early part of this
   problem by tightening the condition to give the message---there is
   no reason to stop or force the user to choose between rebase or
   merge if the history fast-forwards.

 * The configuration variable 'core.abbrev' can be set to 'no' to
   force no abbreviation regardless of the hash algorithm.

 * "git rev-parse" can be explicitly told to give output as absolute
   or relative path with the `--path-format=3D(absolute|relative)` option=
.

 * Bash completion (in contrib/) update to make it easier for
   end-users to add completion for their custom "git" subcommands.

 * "git maintenance" learned to drive scheduled maintenance on
   platforms whose native scheduling methods are not 'cron'.

 * After expiring a reflog and making a single commit, the reflog for
   the branch would record a single entry that knows both @{0} and
   @{1}, but we failed to answer "what commit were we on?", i.e. @{1}

 * "git bundle" learns "--stdin" option to read its refs from the
   standard input.  Also, it now does not lose refs whey they point
   at the same object.

 * "git log" learned a new "--diff-merges=3D<how>" option.

 * "git ls-files" can and does show multiple entries when the index is
   unmerged, which is a source for confusion unless -s/-u option is in
   use.  A new option --deduplicate has been introduced.

 * `git worktree list` now annotates worktrees as prunable, shows
   locked and prunable attributes in --porcelain mode, and gained
   a --verbose option.

 * "git clone" tries to locally check out the branch pointed at by
   HEAD of the remote repository after it is done, but the protocol
   did not convey the information necessary to do so when copying an
   empty repository.  The protocol v2 learned how to do so.

 * There are other ways than ".." for a single token to denote a
   "commit range", namely "<rev>^!" and "<rev>^-<n>", but "git
   range-diff" did not understand them.

 * The "git range-diff" command learned "--(left|right)-only" option
   to show only one side of the compared range.

 * "git mergetool" feeds three versions (base, local and remote) of
   a conflicted path unmodified.  The command learned to optionally
   prepare these files with unconflicted parts already resolved.

 * The .mailmap is documented to be read only from the root level of a
   working tree, but a stray file in a bare repository also was read
   by accident, which has been corrected.

 * "git maintenance" tool learned a new "pack-refs" maintenance task.

 * The error message given when a configuration variable that is
   expected to have a boolean value has been improved.

 * Signed commits and tags now allow verification of objects, whose
   two object names (one in SHA-1, the other in SHA-256) are both
   signed.

 * "git rev-list" command learned "--disk-usage" option.

 * "git {diff,log} --{skip,rotate}-to=3D<path>" allows the user to
   discard diff output for early paths or move them to the end of the
   output.

 * "git difftool" learned "--skip-to=3D<path>" option to restart an
   interrupted session from an arbitrary path.

 * "git grep" has been tweaked to be limited to the sparse checkout
   paths.

 * "git rebase --[no-]fork-point" gained a configuration variable
   rebase.forkPoint so that users do not have to keep specifying a
   non-default setting.


Performance, Internal Implementation, Development Support etc.

 * A 3-year old test that was not testing anything useful has been
   corrected.

 * Retire more names with "sha1" in it.

 * The topological walk codepath is covered by new trace2 stats.

 * Update the Code-of-conduct to version 2.0 from the upstream (we've
   been using version 1.4).

 * "git mktag" validates its input using its own rules before writing
   a tag object---it has been updated to share the logic with "git
   fsck".

 * Two new ways to feed configuration variable-value pairs via
   environment variables have been introduced, and the way
   GIT_CONFIG_PARAMETERS encodes variable/value pairs has been tweaked
   to make it more robust.

 * Tests have been updated so that they do not to get affected by the
   name of the default branch "git init" creates.

 * "git fetch" learns to treat ref updates atomically in all-or-none
   fashion, just like "git push" does, with the new "--atomic" option.

 * The peel_ref() API has been replaced with peel_iterated_oid().

 * The .use_shell flag in struct child_process that is passed to
   run_command() API has been clarified with a bit more documentation.

 * Document, clean-up and optimize the code around the cache-tree
   extension in the index.

 * The ls-refs protocol operation has been optimized to narrow the
   sub-hierarchy of refs/ it walks to produce response.

 * When removing many branches and tags, the code used to do so one
   ref at a time.  There is another API it can use to delete multiple
   refs, and it makes quite a lot of performance difference when the
   refs are packed.

 * The "pack-objects" command needs to iterate over all the tags when
   automatic tag following is enabled, but it actually iterated over
   all refs and then discarded everything outside "refs/tags/"
   hierarchy, which was quite wasteful.

 * A perf script was made more portable.

 * Our setting of GitHub CI test jobs were a bit too eager to give up
   once there is even one failure found.  Tweak the knob to allow
   other jobs keep running even when we see a failure, so that we can
   find more failures in a single run.

 * We've carried compatibility codepaths for compilers without
   variadic macros for quite some time, but the world may be ready for
   them to be removed.  Force compilation failure on exotic platforms
   where variadic macros are not available to find out who screams in
   such a way that we can easily revert if it turns out that the world
   is not yet ready.

 * Code clean-up to ensure our use of hashtables using object names as
   keys use the "struct object_id" objects, not the raw hash values.

 * Lose the debugging aid that may have been useful in the past, but
   no longer is, in the "grep" codepaths.

 * Some pretty-format specifiers do not need the data in commit object
   (e.g. "%H"), but we were over-eager to load and parse it, which has
   been made even lazier.

 * Get rid of "GETTEXT_POISON" support altogether, which may or may
   not be controversial.

 * Introduce an on-disk file to record revindex for packdata, which
   traditionally was always created on the fly and only in-core.

 * The commit-graph learned to use corrected commit dates instead of
   the generation number to help topological revision traversal.

 * Piecemeal of rewrite of "git bisect" in C continues.

 * When a pager spawned by us exited, the trace log did not record its
   exit status correctly, which has been corrected.

 * Removal of GIT_TEST_GETTEXT_POISON continues.

 * The code to implement "git merge-base --independent" was poorly
   done and was kept from the very beginning of the feature.

 * Preliminary changes to fsmonitor integration.

 * Performance improvements for rename detection.

 * The common code to deal with "chunked file format" that is shared
   by the multi-pack-index and commit-graph files have been factored
   out, to help codepaths for both filetypes to become more robust.

 * The approach to "fsck" the incoming objects in "index-pack" is
   attractive for performance reasons (we have them already in core,
   inflated and ready to be inspected), but fundamentally cannot be
   applied fully when we receive more than one pack stream, as a tree
   object in one pack may refer to a blob object in another pack as
   ".gitmodules", when we want to inspect blobs that are used as
   ".gitmodules" file, for example.  Teach "index-pack" to emit
   objects that must be inspected later and check them in the calling
   "fetch-pack" process.

 * The logic to handle "trailer" related placeholders in the
   "--format=3D" mechanisms in the "log" family and "for-each-ref"
   family is getting unified.

 * Raise the buffer size used when writing the index file out from
   (obviously too small) 8kB to (clearly sufficiently large) 128kB.

 * It is reported that open() on some platforms (e.g. macOS Big Sur)
   can return EINTR even though our timers are set up with SA_RESTART.
   A workaround has been implemented and enabled for macOS to rerun
   open() transparently from the caller when this happens.


Fixes since v2.30
-----------------

 * Diagnose command line error of "git rebase" early.

 * Clean up option descriptions in "git cmd --help".

 * "git stash" did not work well in a sparsely checked out working
   tree.

 * Some tests expect that "ls -l" output has either '-' or 'x' for
   group executable bit, but setgid bit can be inherited from parent
   directory and make these fields 'S' or 's' instead, causing test
   failures.

 * "git for-each-repo --config=3D<var> <cmd>" should not run <cmd> for
   any repository when the configuration variable <var> is not defined
   even once.

 * Fix 2.29 regression where "git mergetool --tool-help" fails to list
   all the available tools.

 * Fix for procedure to building CI test environment for mac.

 * The implementation of "git branch --sort" wrt the detached HEAD
   display has always been hacky, which has been cleaned up.

 * Newline characters in the host and path part of git:// URL are
   now forbidden.

 * "git diff" showed a submodule working tree with untracked cruft as
   "Submodule commit <objectname>-dirty", but a natural expectation is
   that the "-dirty" indicator would align with "git describe --dirty",
   which does not consider having untracked files in the working tree
   as source of dirtiness.  The inconsistency has been fixed.

 * When more than one commit with the same patch ID appears on one
   side, "git log --cherry-pick A...B" did not exclude them all when a
   commit with the same patch ID appears on the other side.  Now it
   does.

 * Documentation for "git fsck" lost stale bits that has become
   incorrect.

 * Doc fix for packfile URI feature.

 * When "git rebase -i" processes "fixup" insn, there is no reason to
   clean up the commit log message, but we did the usual stripspace
   processing.  This has been corrected.
   (merge f7d42ceec5 js/rebase-i-commit-cleanup-fix later to maint).

 * Fix in passing custom args from "git clone" to "upload-pack" on the
   other side.
   (merge ad6b5fefbd jv/upload-pack-filter-spec-quotefix later to maint).

 * The command line completion (in contrib/) completed "git branch -d"
   with branch names, but "git branch -D" offered tagnames in addition,
   which has been corrected.  "git branch -M" had the same problem.
   (merge 27dc071b9a jk/complete-branch-force-delete later to maint).

 * When commands are started from a subdirectory, they may have to
   compare the path to the subdirectory (called prefix and found out
   from $(pwd)) with the tracked paths.  On macOS, $(pwd) and
   readdir() yield decomposed path, while the tracked paths are
   usually normalized to the precomposed form, causing mismatch.  This
   has been fixed by taking the same approach used to normalize the
   command line arguments.
   (merge 5c327502db tb/precompose-prefix-too later to maint).

 * Even though invocations of "die()" were logged to the trace2
   system, "BUG()"s were not, which has been corrected.
   (merge 0a9dde4a04 jt/trace2-BUG later to maint).

 * "git grep --untracked" is meant to be "let's ALSO find in these
   files on the filesystem" when looking for matches in the working
   tree files, and does not make any sense if the primary search is
   done against the index, or the tree objects.  The "--cached" and
   "--untracked" options have been marked as mutually incompatible.
   (merge 0c5d83b248 mt/grep-cached-untracked later to maint).

 * Fix "git fsck --name-objects" which apparently has not been used by
   anybody who is motivated enough to report breakage.
   (merge e89f89361c js/fsck-name-objects-fix later to maint).

 * Avoid individual tests in t5411 from getting affected by each other
   by forcing them to use separate output files during the test.
   (merge 822ee894f6 jx/t5411-unique-filenames later to maint).

 * Test to make sure "git rev-parse one-thing one-thing" gives
   the same thing twice (when one-thing is --since=3DX).
   (merge a5cdca4520 ew/rev-parse-since-test later to maint).

 * When certain features (e.g. grafts) used in the repository are
   incompatible with the use of the commit-graph, we used to silently
   turned commit-graph off; we now tell the user what we are doing.
   (merge c85eec7fc3 js/commit-graph-warning later to maint).

 * Objects that lost references can be pruned away, even when they
   have notes attached to it (and these notes will become dangling,
   which in turn can be pruned with "git notes prune").  This has been
   clarified in the documentation.
   (merge fa9ab027ba mz/doc-notes-are-not-anchors later to maint).

 * The error codepath around the "--temp/--prefix" feature of "git
   checkout-index" has been improved.
   (merge 3f7ba60350 mt/checkout-index-corner-cases later to maint).

 * The "git maintenance register" command had trouble registering bare
   repositories, which had been corrected.

 * A handful of multi-word configuration variable names in
   documentation that are spelled in all lowercase have been corrected
   to use the more canonical camelCase.
   (merge 7dd0eaa39c dl/doc-config-camelcase later to maint).

 * "git push $there --delete ''" should have been diagnosed as an
   error, but instead turned into a matching push, which has been
   corrected.
   (merge 20e416409f jc/push-delete-nothing later to maint).

 * Test script modernization.
   (merge 488acf15df sv/t7001-modernize later to maint).

 * An under-allocation for the untracked cache data has been corrected.
   (merge 6347d649bc jh/untracked-cache-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge e3f5da7e60 sg/t7800-difftool-robustify later to maint).
   (merge 9d336655ba js/doc-proto-v2-response-end later to maint).
   (merge 1b5b8cf072 jc/maint-column-doc-typofix later to maint).
   (merge 3a837b58e3 cw/pack-config-doc later to maint).
   (merge 01168a9d89 ug/doc-commit-approxidate later to maint).
   (merge b865734760 js/params-vs-args later to maint).

----------------------------------------------------------------

Changes since v2.30.0 are as follows:

Abhishek Kumar (11):
      commit-graph: fix regression when computing Bloom filters
      revision: parse parent in indegree_walk_step()
      commit-graph: consolidate fill_commit_graph_info
      t6600-test-reach: generalize *_three_modes
      commit-graph: add a slab to store topological levels
      commit-graph: return 64-bit generation number
      commit-graph: implement corrected commit date
      commit-graph: implement generation data chunk
      commit-graph: use generation v2 only if entire chain does
      commit-reach: use corrected commit dates in paint_down_to_common()
      doc: add corrected commit date info

Adam Dinwoodie (1):
      t4129: fix setfacl-related permissions failure

Alex Henrie (1):
      rebase: add a config option for --no-fork-point

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5104t)

Andrew Klotz (1):
      config: improve error message for boolean config

Andrzej Hunt (1):
      commit-graph: avoid leaking topo_levels slab in write_commit_graph(=
)

Antonio Russo (1):
      t6016: move to lib-log-graph.sh framework

Arusekk (1):
      l10n: pl.po: Update translation

Bagas Sanjaya (2):
      l10n: start Indonesian translation
      l10n: Add translation team info

Christian Couder (3):
      fetch-pack: rename helper to create_promisor_file()
      fetch-pack: refactor writing promisor file
      pack-write: die on error in write_promisor_file()

Christian Walther (1):
      doc: mention bigFileThreshold for packing

Christopher Diaz Riveros (1):
      l10n: es: 2.31.0 round 2

Daniel Levin (1):
      git-p4: fix syncing file types with pattern

Daniel Santos (1):
      l10n: pt_PT: add Portuguese translations part 1

Denton Liu (12):
      refs: factor out set_read_ref_cutoffs()
      refs: allow @{n} to work with n-sized reflog
      test-lib-functions.sh: fix usage for test_commit()
      t4203: stop losing return codes of git commands
      git-stash.txt: be explicit about subcommand options
      t3905: remove spaces after redirect operators
      t3905: move all commands into test cases
      t3905: remove nested git in command substitution
      t3905: replace test -s with test_file_not_empty
      t3905: use test_cmp() to check file contents
      stash: declare ref_stash as an array
      i18n.txt: camel case and monospace "i18n.commitEncoding"

Derrick Stolee (65):
      maintenance: extract platform-specific scheduling
      maintenance: include 'cron' details in docs
      pack-bitmap-write: fill bitmap with commit history
      bitmap: implement bitmap_is_subset()
      commit: implement commit_list_contains()
      t5310: add branch-based checks
      pack-bitmap-write: rename children to reverse_edges
      pack-bitmap-write: build fewer intermediate bitmaps
      pack-bitmap-write: use existing bitmaps
      pack-bitmap-write: relax unique revwalk condition
      pack-bitmap-write: better reuse bitmaps
      revision: trace topo-walk statistics
      tree-walk: report recursion counts
      unpack-trees: add trace2 regions
      cache-tree: use trace2 in cache_tree_update()
      maintenance: use launchctl on macOS
      maintenance: use Windows scheduled tasks
      for-each-repo: do nothing on empty config
      cache-tree: trace regions for I/O
      cache-tree: trace regions for prime_cache_tree
      index-format: use 'cache tree' over 'cached tree'
      index-format: update preamble to cache tree extension
      index-format: discuss recursion of cache-tree better
      cache-tree: speed up consecutive path comparisons
      maintenance: set log.excludeDecoration durin prefetch
      t7900: clean up some broken refs
      cache-tree: clean up cache_tree_update()
      cache-tree: simplify verify_cache() prototype
      cache-tree: extract subtree_pos()
      fsmonitor: de-duplicate BUG()s around dirty bits
      repository: add repo reference to index_state
      name-hash: use trace2 regions for init
      sparse-checkout: load sparse-checkout patterns
      test-lib: test_region looks for trace2 regions
      t1092: test interesting sparse-checkout scenarios
      commit-reach: reduce requirements for remove_redundant()
      commit-graph: use repo_parse_commit
      commit-graph: always parse before commit_graph_data_at()
      commit-graph: validate layers for generation data
      commit-graph: compute generations separately
      commit-graph: be extra careful about mixed generations
      commit-graph: prepare commit graph
      commit-graph: anonymize data in chunk_write_fn
      maintenance: add pack-refs task
      maintenance: incremental strategy runs pack-refs weekly
      chunk-format: create chunk format write API
      commit-graph: use chunk-format write API
      midx: rename pack_info to write_midx_context
      midx: use context in write_midx_pack_names()
      midx: add entries to write_midx_context
      midx: add pack_perm to write_midx_context
      midx: add num_large_offsets to write_midx_context
      midx: return success/failure in chunk write methods
      midx: drop chunk progress during write
      midx: use chunk-format API in write_midx_internal()
      chunk-format: create read chunk API
      commit-graph: use chunk-format read API
      midx: use chunk-format read API
      midx: use 64-bit multiplication for chunk sizes
      chunk-format: restore duplicate chunk checks
      chunk-format: add technical docs
      commit-reach: use one walk in remove_redundant()
      commit-reach: move compare_commits_by_gen
      commit-reach: use heuristic in remove_redundant()
      commit-reach: stale commits may prune generation further

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Elijah Newren (93):
      t7012: add a testcase demonstrating stash apply bugs in sparse chec=
kouts
      stash: remove unnecessary process forking
      stash: fix stash application in sparse-checkouts
      merge-ort: setup basic internal data structures
      merge-ort: add some high-level algorithm structure
      merge-ort: port merge_start() from merge-recursive
      merge-ort: use histogram diff
      merge-ort: add an err() function similar to one from merge-recursiv=
e
      merge-ort: implement a very basic collect_merge_info()
      merge-ort: avoid repeating fill_tree_descriptor() on the same tree
      merge-ort: compute a few more useful fields for collect_merge_info
      merge-ort: record stage and auxiliary info for every path
      merge-ort: avoid recursing into identical trees
      merge-ort: add a preliminary simple process_entries() implementatio=
n
      merge-ort: have process_entries operate in a defined order
      merge-ort: step 1 of tree writing -- record basenames, modes, and o=
ids
      merge-ort: step 2 of tree writing -- function to create tree object
      merge-ort: step 3 of tree writing -- handling subdirectories as we =
go
      merge-ort: basic outline for merge_switch_to_result()
      merge-ort: add implementation of checkout()
      tree: enable cmp_cache_name_compare() to be used elsewhere
      merge-ort: add implementation of record_conflicted_index_entries()
      merge-ort: free data structures in merge_finalize()
      merge-ort: add a few includes
      merge-ort: add a clear_internal_opts helper
      merge-ort: add a path_conflict field to merge_options_internal
      merge-ort: add a paths_to_free field to merge_options_internal
      merge-ort: add function grouping comments
      merge-ort: add die-not-implemented stub handle_content_merge() func=
tion
      merge-ort: add modify/delete handling and delayed output processing
      merge-ort: add basic data structures for handling renames
      merge-ort: add initial outline for basic rename detection
      merge-ort: implement detect_regular_renames()
      merge-ort: implement compare_pairs() and collect_renames()
      merge-ort: add basic outline for process_renames()
      diffcore-rename: rename num_create to num_destinations
      diffcore-rename: avoid usage of global in too_many_rename_candidate=
s()
      diffcore-rename: simplify limit check
      diffcore-rename: reduce jumpiness in progress counters
      t4058: add more tests and documentation for duplicate tree entry ha=
ndling
      t4058: explore duplicate tree entry handling in a bit more detail
      diffcore-rename: simplify and accelerate register_rename_src()
      diffcore-rename: accelerate rename_dst setup
      merge-ort: add implementation of both sides renaming identically
      merge-ort: add implementation of both sides renaming differently
      merge-ort: add implementation of rename/delete conflicts
      merge-ort: add implementation of rename collisions
      merge-ort: add implementation of normal rename handling
      merge-ort: add implementation of type-changed rename handling
      commit: move reverse_commit_list() from merge-recursive
      merge-ort: copy a few small helper functions from merge-recursive.c
      merge-ort: make clear_internal_opts() aware of partial clearing
      merge-ort: implement merge_incore_recursive()
      merge-ort: handle D/F conflict where directory disappears due to me=
rge
      merge-ort: handle directory/file conflicts that remain
      merge-ort: implement unique_path() helper
      merge-ort: handle book-keeping around two- and three-way content me=
rge
      merge-ort: flesh out implementation of handle_content_merge()
      merge-ort: copy and adapt merge_3way() from merge-recursive.c
      merge-ort: copy and adapt merge_submodule() from merge-recursive.c
      merge-ort: implement format_commit()
      merge-ort: copy find_first_merges() implementation from merge-recur=
sive.c
      merge-ort: add handling for different types of files at same path
      diffcore-rename: remove unnecessary duplicate entry checks
      merge-ort: add new data structures for directory rename detection
      merge-ort: initialize and free new directory rename data structures
      merge-ort: collect which directories are removed in dirs_removed
      merge-ort: add outline for computing directory renames
      merge-ort: add outline of get_provisional_directory_renames()
      merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
      merge-ort: implement compute_rename_counts()
      merge-ort: implement handle_directory_level_conflicts()
      merge-ort: modify collect_renames() for directory rename handling
      merge-ort: implement compute_collisions()
      merge-ort: implement apply_dir_rename() and check_dir_renamed()
      merge-ort: implement check_for_directory_rename()
      merge-ort: implement handle_path_level_conflicts()
      merge-ort: add a new toplevel_dir field
      merge-ort: implement apply_directory_rename_modifications()
      merge-ort: process_renames() now needs more defensiveness
      merge-ort: fix a directory rename detection bug
      merge-ort: fix massive leak
      merge-ort: ignore the directory rename split conflict for now
      merge-ort: begin performance work; instrument with trace2_region_* =
calls
      diffcore-rename: no point trying to find a match better than exact
      diffcore-rename: filter rename_src list when possible
      t4001: add a test comparing basename similarity and content similar=
ity
      diffcore-rename: compute basenames of source and dest candidates
      diffcore-rename: complete find_basename_matches()
      diffcore-rename: guide inexact rename detection based on basenames
      gitdiffcore doc: mention new preliminary step for rename detection
      merge-ort: call diffcore_rename() directly
      Documentation/RelNotes: improve release note for rename detection w=
ork

Emir Sar=C4=B1 (2):
      l10n: tr: v2.31.0-rc0
      l10n: tr: v2.31.0-rc1

Eric Sunshine (3):
      worktree: teach `repair` to fix multi-directional breakage
      t/perf: avoid unnecessary test_export() recursion
      maintenance: fix incorrect `maintenance.repo` path with bare reposi=
tory

Eric Wong (2):
      core.abbrev=3Dno disables abbreviations
      t1500: ensure current --since=3D behavior remains

Felipe Contreras (8):
      pull: refactor fast-forward check
      pull: give the advice for choosing rebase/merge much later
      pull: display default warning only when non-ff
      test: bisect-porcelain: fix location of files
      completion: bash: add __git_have_func helper
      completion: bash: improve function detection
      test: completion: add tests for __git_complete
      completion: add proper public __git_complete

Han-Wen Nienhuys (1):
      doc/reftable: document how to handle windows

Hariom Verma (4):
      t6300: use function to test trailer options
      pretty.c: refactor trailer logic to `format_set_trailers_options()`
      pretty.c: capture invalid trailer argument
      ref-filter: use pretty.c logic for trailers

Jacob Vosmaer (4):
      builtin/pack-objects.c: avoid iterating all refs
      ls-refs.c: initialize 'prefixes' before using it
      upload-pack.c: fix filter spec quoting bug
      t5544: clarify 'hook works with partial clone' test

Jean-No=C3=ABl Avila (2):
      l10n: fr: v2.31.0 rnd 1
      l10n: fr: v2.31 rnd 2

Jeff Hostetler (11):
      p7519: do not rely on "xargs -d" in test
      p7519: fix watchman watch-list test on Windows
      p7519: move watchman cleanup earlier in the test
      p7519: add trace logging during perf test
      preload-index: log the number of lstat calls to trace2
      read-cache: log the number of lstat calls to trace2
      read-cache: log the number of scanned files to trace2
      fsmonitor: log invocation of FSMonitor hook to trace2
      fsmonitor: log FSMN token when reading and writing the index
      fsmonitor: refactor initialization of fsmonitor_last_update token
      dir: fix malloc of root untracked_cache_dir

Jeff King (45):
      pack-bitmap: fix header size check
      pack-bitmap: bounds-check size of cache extension
      t5310: drop size of truncated ewah bitmap
      rev-list: die when --test-bitmap detects a mismatch
      ewah: factor out bitmap growth
      ewah: make bitmap growth less aggressive
      ewah: implement bitmap_or()
      ewah: add bitmap_dup() function
      pack-bitmap-write: reimplement bitmap writing
      pack-bitmap-write: pass ownership of intermediate bitmaps
      pack-bitmap-write: ignore BITMAP_FLAG_REUSE
      git_connect_git(): forbid newlines in host and path
      fsck: reject .gitmodules git:// urls with newlines
      t5516: loosen "not our ref" error check
      patch-ids: handle duplicate hashmap entries
      quote: make sq_dequote_step() a public function
      for_each_object_in_pack(): clarify pack vs index ordering
      config: parse more robust format in GIT_CONFIG_PARAMETERS
      refs: switch peel_ref() to peel_iterated_oid()
      run-command: document use_shell option
      git-svn tests: rewrite brittle tests to use "--[no-]merges".
      git-compat-util: always enable variadic macros
      commit_graft_pos(): take an oid instead of a bare hash
      rerere: check dirname format while iterating rr_cache directory
      rerere: tighten rr-cache dirname check
      rerere: use strmap to store rerere directories
      hash_pos(): convert to oid_pos()
      oid_pos(): access table through const pointers
      t0000: keep clean-up tests together
      t0000: run prereq tests inside sub-test
      t0000: run cleaning test inside sub-test
      t0000: consistently use single quotes for outer tests
      pretty: lazy-load commit data when expanding user-format
      p5303: avoid sed GNU-ism
      completion: treat "branch -D" the same way as "branch -d"
      completion: handle other variants of "branch -m"
      doc/git-branch: fix awkward wording for "-c"
      t: add --no-tag option to test_commit
      mailmap: only look for .mailmap in work tree
      rev-list: add --disk-usage option for calculating disk usage
      docs/rev-list: add an examples section
      docs/rev-list: add some examples of --disk-usage
      doc: mention approxidates for git-commit --date
      Makefile: add OPEN_RETURNS_EINTR knob
      config.mak.uname: enable OPEN_RETURNS_EINTR for macOS Big Sur

Jiang Xin (8):
      test: add helper functions for git-bundle
      bundle: lost objects when removing duplicate pendings
      bundle: arguments can be read from stdin
      t5411: use different out file to prevent overwriting
      t5411: refactor check of refs using test_cmp_refs
      l10n: git.pot: v2.31.0 round 1 (155 new, 89 removed)
      l10n: git.pot: v2.31.0 round 2 (9 new, 8 removed)
      l10n: zh_CN: for git v2.31.0 l10n round 1 and 2

Joey Salazar (1):
      doc: fix naming of response-end-pkt

Johannes Schindelin (58):
      tests: mark tests relying on the current default for `init.defaultB=
ranch`
      t0060: preemptively adjust alignment
      t[01]*: adjust the references to the default branch name "main"
      t2*: adjust the references to the default branch name "main"
      t3[0-3]*: adjust the references to the default branch name "main"
      t3416: preemptively adjust alignment in a comment
      t34*: adjust the references to the default branch name "main"
      t3[5-9]*: adjust the references to the default branch name "main"
      t4*: adjust the references to the default branch name "main"
      t5323: prepare centered comment for `master` -> `main`
      t5[0-4]*: adjust the references to the default branch name "main"
      t5503: prepare aligned comment for replacing `master` with `main`
      t550*: adjust the references to the default branch name "main"
      t551*: adjust the references to the default branch name "main"
      t55[23]*: adjust the references to the default branch name "main"
      t55[4-9]*: adjust the references to the default branch name "main"
      t5[6-9]*: adjust the references to the default branch name "main"
      t6[0-3]*: adjust the references to the default branch name "main"
      t64*: preemptively adjust alignment to prepare for `master` -> `mai=
n`
      t6[4-9]*: adjust the references to the default branch name "main"
      t7[0-4]*: adjust the references to the default branch name "main"
      t7[5-9]*: adjust the references to the default branch name "main"
      t8*: adjust the references to the default branch name "main"
      t9[0-4]*: adjust the references to the default branch name "main"
      t9[5-7]*: adjust the references to the default branch name "main"
      tests(git-p4): transition to the default branch name `main`
      t99*: adjust the references to the default branch name "main"
      tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where no longer needed
      SKIP_DASHED_BUILT_INS: respect `config.mak`
      range-diff/format-patch: refactor check for commit range
      rebase -i: do leave commit message intact in fixup! chains
      range-diff: avoid leaking memory in two error code paths
      range-diff: libify the read_patches() function again
      range-diff: simplify code spawning `git log`
      range-diff: combine all options in a single data structure
      range-diff: move the diffopt initialization down one layer
      range-diff: offer --left-only/--right-only options
      range-diff/format-patch: handle commit ranges other than A..B
      range-diff(docs): explain how to specify commit ranges
      t1450: robustify `remove_object()`
      fsck --name-objects: be more careful parsing generation numbers
      reflog expire --stale-fix: be generous about missing objects
      commit-graph: when incompatible with graphs, indicate why
      run-command: invalidate lstat cache after a command finished
      Git 2.17.6
      Git 2.18.5
      Git 2.19.6
      Git 2.20.5
      Git 2.21.4
      Git 2.22.5
      Git 2.23.4
      Git 2.24.4
      Git 2.25.5
      Git 2.26.3
      Git 2.27.1
      Git 2.28.1
      Git 2.29.3
      Git 2.30.2

Johannes Sixt (2):
      annotate-tests: quote variable expansions containing path names
      replace "parameters" by "arguments" in error messages

Jonathan Nieder (2):
      mergetool: do not enable hideResolved by default
      doc: describe mergetool configuration in git-mergetool(1)

Jonathan Tan (10):
      Doc: clarify contents of packfile sent as URI
      ls-refs: report unborn targets of symrefs
      connect, transport: encapsulate arg in struct
      clone: respect remote unborn HEAD
      usage: trace2 BUG() invocations
      http: allow custom index-pack args
      http-fetch: allow custom index-pack args
      fetch-pack: with packfile URIs, use index-pack arg
      fetch-pack: print and use dangling .gitmodules
      fetch-pack: do not mix --pack_header and packfile uri

Jordi Mas (1):
      l10n: Update Catalan translation

Junio C Hamano (32):
      pack-redundant: gauge the usage before proposing its removal
      pull: get rid of unnecessary global variable
      pull: correct condition to trigger non-ff advice
      CoC: explicitly take any whitespace breakage
      parse-options: format argh like error messages
      The first batch in 2.31 cycle
      SubmittingPatches: tighten wording on "sign-off" procedure
      ci/install-depends: attempt to fix "brew cask" stuff
      t4203: make blame output massaging more robust
      The second batch
      The third batch
      The fourth batch
      The fifth batch
      Prepare for 2.30.1
      The sixth batch
      Git 2.30.1
      The seventh batch
      The eighth batch
      diff: --{rotate,skip}-to=3D<path>
      The ninth batch
      Documentation: typofix --column description
      The tenth batch
      push: do not turn --delete '' into a matching push
      blame-options.txt: camelcase blame.blankBoundary
      index-format doc: camelCase core.excludesFile
      Git 2.31-rc0
      Revert "commit-graph: when incompatible with graphs, indicate why"
      Hopefully the last batch before -rc1
      Git 2.31-rc1
      Merged the open-eintr workaround for macOS
      Git 2.31-rc2
      Git 2.31

Kevin Willford (1):
      fsmonitor: allow all entries for a folder to be invalidated

Martin von Zweigbergk (1):
      docs: clarify that refs/notes/ do not keep the attached objects ali=
ve

Martin =C3=85gren (16):
      t1300: remove duplicate test for `--file ../foo`
      t1300: remove duplicate test for `--file no-such-file`
      t1300: don't needlessly work with `core.foo` configs
      pack-format.txt: document sizes at start of delta data
      object-name.c: rename from sha1-name.c
      object-file.c: rename from sha1-file.c
      sha1-lookup: rename `sha1_pos()` as `hash_pos()`
      hash-lookup: rename from sha1-lookup
      builtin/gc: don't peek into `struct lock_file`
      commit-graph: don't peek into `struct lock_file`
      midx: don't peek into `struct lock_file`
      refs/files-backend: don't peek into `struct lock_file`
      read-cache: try not to peek into `struct {lock_,temp}file`
      rev-list-options.txt: fix rendering of bonus paragraph
      git.txt: fix monospace rendering
      gitmailmap.txt: fix rendering of e-mail addresses

Matheus Tavares (10):
      t4129: don't fail if setgid is set in the test directory
      grep: error out if --untracked is used with --cached
      grep: honor sparse-checkout on working tree searches
      checkout: fix bug that makes checkout follow symlinks in leading pa=
th
      unpack_trees(): start with a fresh lstat cache
      write_entry(): fix misuses of `path` in error messages
      checkout-index: omit entries with no tempname from --temp output
      add --chmod: don't update index when --dry-run is used
      add: mark --chmod error string for translation
      add: propagate --chmod errors to exit status

Matthias R=C3=BCster (1):
      l10n: de.po: Update German translation for Git v2.31.0

Mikhail Klyushin (1):
      git-gui: fix typo in russian locale

Neeraj Singh (1):
      read-cache: make the index write buffer size 128K

Patrick Steinhardt (11):
      git: add `--super-prefix` to usage string
      config: add new way to pass config via `--config-env`
      config: extract function to parse config pairs
      fetch: extract writing to FETCH_HEAD
      fetch: use strbuf to format FETCH_HEAD updates
      fetch: refactor `s_update_ref` to use common exit path
      fetch: allow passing a transaction to `s_update_ref()`
      fetch: implement support for atomic reference updates
      config: store "git -c" variables using more robust format
      environment: make `getenv_safe()` a public function
      config: allow specifying config entries via envvar pairs

Peter Kaestle (1):
      submodules: fix of regression on fetching of non-init subsub-repo

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (5103t0f0u)
      l10n: sv.po: Update Swedish translation (5104t0f0u)

Phil Hord (1):
      use delete_refs when deleting tags or branches

Philippe Blain (4):
      gitmodules.txt: fix 'GIT_WORK_TREE' variable name
      mergetool--lib: fix '--tool-help' to correctly show available tools
      mailmap doc: use correct environment variable 'GIT_WORK_TREE'
      ci: do not cancel all jobs of a matrix if one fails

Pranit Bauva (7):
      bisect--helper: reimplement `bisect_log` shell function in C
      bisect--helper: reimplement `bisect_replay` shell function in C
      bisect--helper: retire `--bisect-write` subcommand
      bisect--helper: use `res` instead of return in BISECT_RESET case op=
tion
      bisect--helper: retire `--bisect-auto-next` subcommand
      bisect--helper: reimplement `bisect_skip` shell function in C
      bisect--helper: retire `--check-and-set-terms` subcommand

Pratyush Yadav (2):
      git-gui: remove lines starting with the comment character
      Revert "git-gui: remove lines starting with the comment character"

Rafael Silva (8):
      worktree: libify should_prune_worktree()
      worktree: teach worktree to lazy-load "prunable" reason
      worktree: teach worktree_lock_reason() to gently handle main worktr=
ee
      t2402: ensure locked worktree is properly cleaned up
      worktree: teach `list --porcelain` to annotate locked worktree
      worktree: teach `list` to annotate prunable worktree
      worktree: teach `list` verbose mode
      blame: remove unnecessary use of get_commit_info()

Ren=C3=A9 Scharfe (2):
      rebase: verify commit parameter
      cache-tree: use ce_namelen() instead of strlen()

SZEDER G=C3=A1bor (2):
      t7800-difftool: don't accidentally match tmp dirs
      test-lib: prevent '--stress-jobs=3DX' from being ignored

Sangeeta Jain (1):
      diff: do not show submodule with untracked files as "-dirty"

Sergey Organov (32):
      revision: factor out parsing of diff-merge related options
      revision: factor out setup of diff-merge related settings
      revision: factor out initialization of diff-merge related settings
      revision: provide implementation for diff merges tweaks
      revision: move diff merges functions to its own diff-merges.c
      diff-merges: rename all functions to have common prefix
      diff-merges: move checks for first_parent_only out of the module
      diff-merges: rename diff_merges_default_to_enable() to match semant=
ics
      diff-merges: re-arrange functions to match the order they are calle=
d in
      diff-merges: new function diff_merges_suppress()
      diff-merges: new function diff_merges_set_dense_combined_if_unset()
      diff-merges: introduce revs->first_parent_merges flag
      diff-merges: handle imply -p on -c/--cc logic for log.c
      diff-merges: revise revs->diff flag handling
      t4013: support test_expect_failure through ':failure' magic
      t4013: add tests for -m failing to override -c/--cc
      diff-merges: fix -m to properly override -c/--cc
      diff-merges: split 'ignore_merges' field
      diff-merges: group diff-merge flags next to each other inside 'rev_=
info'
      diff-merges: get rid of now empty diff_merges_init_revs()
      diff-merges: refactor opt settings into separate functions
      diff-merges: make -m/-c/--cc explicitly mutually exclusive
      diff-merges: implement new values for --diff-merges
      diff-merges: do not imply -p for new options
      diff-merges: let new options enable diff without -p
      diff-merges: add old mnemonic counterparts to --diff-merges
      diff-merges: add '--diff-merges=3D1' as synonym for 'first-parent'
      doc/git-log: describe new --diff-merges options
      doc/diff-generate-patch: mention new --diff-merges option
      doc/rev-list-options: document --first-parent changes merges format
      doc/git-show: include --diff-merges description
      t4013: add tests for --diff-merges=3Dfirst-parent

Seth House (4):
      mergetool: add hideResolved configuration
      mergetool: break setup_tool out into separate initialization functi=
on
      mergetool: add per-tool support and overrides for the hideResolved =
flag
      mergetools/vimdiff: add vimdiff1 merge tool variant

Shubham Verma (10):
      t7001: modernize test formatting
      t7001: indent with TABs instead of spaces
      t7001: remove unnecessary blank lines
      t7001: modernize subshell formatting
      t7001: remove whitespace after redirect operators
      t7001: avoid using `cd` outside of subshells
      t7001: use '>' rather than 'touch'
      t7001: put each command on a separate line
      t7001: use here-docs instead of echo
      t7001: use `test` rather than `[`

Taylor Blau (41):
      ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()
      pack-bitmap.c: check reads more aggressively when loading
      pack-bitmap: factor out 'bitmap_for_commit()'
      pack-bitmap: factor out 'add_commit_to_bitmap()'
      p7519: allow running without watchman prereq
      Documentation/git-clone.txt: document race with --local
      pack-revindex: introduce a new API
      write_reuse_object(): convert to new revindex API
      write_reused_pack_one(): convert to new revindex API
      write_reused_pack_verbatim(): convert to new revindex API
      check_object(): convert to new revindex API
      bitmap_position_packfile(): convert to new revindex API
      show_objects_for_type(): convert to new revindex API
      get_size_by_pos(): convert to new revindex API
      try_partial_reuse(): convert to new revindex API
      rebuild_existing_bitmaps(): convert to new revindex API
      get_delta_base_oid(): convert to new revindex API
      retry_bad_packed_offset(): convert to new revindex API
      packed_object_info(): convert to new revindex API
      unpack_entry(): convert to new revindex API
      for_each_object_in_pack(): convert to new revindex API
      builtin/gc.c: guess the size of the revindex
      pack-revindex: remove unused 'find_pack_revindex()'
      pack-revindex: remove unused 'find_revindex_position()'
      pack-revindex: hide the definition of 'revindex_entry'
      pack-revindex.c: avoid direct revindex access in 'offset_to_pack_po=
s()'
      refs: expose 'for_each_fullref_in_prefixes'
      ls-refs.c: traverse prefixes of disjoint "ref-prefix" sets
      packfile: prepare for the existence of '*.rev' files
      pack-write.c: prepare to write 'pack-*.rev' files
      builtin/index-pack.c: allow stripping arbitrary extensions
      builtin/index-pack.c: write reverse indexes
      builtin/pack-objects.c: respect 'pack.writeReverseIndex'
      Documentation/config/pack.txt: advertise 'pack.writeReverseIndex'
      t: prepare for GIT_TEST_WRITE_REV_INDEX
      t: support GIT_TEST_WRITE_REV_INDEX
      pack-revindex: ensure that on-disk reverse indexes are given preced=
ence
      t5325: check both on-disk and in-memory reverse index
      .github/workflows/main.yml: run static-analysis on bionic
      commit-graph.c: display correct number of chunks when writing
      pack-revindex.c: don't close unopened file descriptors

Thomas Ackermann (7):
      doc: fix some typos
      doc hash-function-transition: fix asciidoc output
      doc hash-function-transition: use SHA-1 and SHA-256 consistently
      doc hash-function-transition: use upper case consistently
      doc hash-function-transition: fix incomplete sentence
      doc hash-function-transition: move rationale upwards
      doc: use https links

Torsten B=C3=B6gershausen (1):
      MacOS: precompose_argv_prefix()

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po(5104t): for git v2.31.0 l10n round 2

Utku Gultopu (1):
      doc: remove "directory cache" from man pages

Vasyl Vavrychuk (1):
      git-send-email.txt: mention less secure app access with Gmail

Yi-Jyun Pan (1):
      l10n: zh_TW.po: v2.31.0 round 2 (15 untranslated)

ZheNing Hu (5):
      builtin/*: update usage format
      ls_files.c: bugfix for --deleted and --modified
      ls_files.c: consolidate two for loops into one
      ls-files.c: add --deduplicate option
      difftool.c: learn a new way start at specified file

brian m. carlson (9):
      abspath: add a function to resolve paths with missing components
      rev-parse: add option for absolute or relative path formatting
      docs: rephrase and clarify the git status --short format
      ref-filter: switch some uses of unsigned long to size_t
      commit: ignore additional signatures when parsing signed commits
      gpg-interface: improve interface for parsing tags
      commit: allow parsing arbitrary buffers with headers
      ref-filter: hoist signature parsing
      gpg-interface: remove other signature headers before verifying

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (100):
      pretty format %(trailers) test: split a long line
      pretty format %(trailers) doc: avoid repetition
      pretty-format %(trailers): fix broken standalone "valueonly"
      pretty format %(trailers): add a "keyonly"
      pretty format %(trailers): add a "key_value_separator"
      mktag doc: say <hash> not <sha1>
      mktag doc: grammar fix, when exists -> when it exists
      CoC: Update word-wrapping to match upstream
      mktag doc: update to explain why to use this
      mktag tests: don't needlessly use a subshell
      mktag tests: use "test_commit" helper
      mktag tests: remove needless SHA-1 hardcoding
      mktag tests: don't redirect stderr to a file needlessly
      mktag tests: don't create "mytag" twice
      mktag tests: run "fsck" after creating "mytag"
      mktag tests: stress test whitespace handling
      mktag tests: test "hash-object" compatibility
      mktag tests: improve verify_object() test coverage
      mktag tests: test verify_object() with replaced objects
      mktag: use default strbuf_read() hint
      mktag: remove redundant braces in one-line body "if"
      mktag: use puts(str) instead of printf("%s\n", str)
      mktag: use fsck instead of custom verify_tag()
      fsck: make fsck_config() re-usable
      mktag: allow turning off fsck.extraHeaderEntry
      mktag: allow omitting the header/body \n separator
      mktag: convert to parse-options
      mktag: mark strings for translation
      mktag: add a --[no-]strict option
      branch: change "--local" to "--list" in comment
      branch tests: add to --sort tests
      ref-filter: add braces to if/else if/else chain
      ref-filter: move "cmp_fn" assignment into "else if" arm
      ref-filter: move ref_sorting flags to a bitfield
      branch: sort detached HEAD based on a flag
      branch: show "HEAD detached" first under reverse sort
      Makefile: remove a warning about old GETTEXT_POISON flag
      gettext.c: remove/reword a mostly-useless comment
      mailmap doc: create a new "gitmailmap(5)" man page
      mailmap doc: quote config variables `like.this`
      check-mailmap doc: note config options
      mailmap doc: start by mentioning the comment syntax
      mailmap tests: use our preferred whitespace syntax
      mailmap tests: modernize syntax & test idioms
      mailmap tests: improve --stdin tests
      mailmap tests: remove redundant entry in test
      mailmap tests: add a test for "not a blob" error
      mailmap tests: get rid of overly complex blame fuzzing
      mailmap: test for silent exiting on missing file/blob
      test-lib functions: expand "test_commit" comment template
      test-lib functions: document arguments to test_commit
      test-lib functions: add --author support to test_commit
      test-lib functions: add an --append option to test_commit
      tests: refactor a few tests to use "test_commit --append"
      mailmap doc + tests: add better examples & test them
      mailmap tests: add a test for comment syntax
      mailmap tests: add tests for whitespace syntax
      mailmap tests: add tests for empty "<>" syntax
      mailmap doc + tests: document and test for case-insensitivity
      shortlog: remove unused(?) "repo-abbrev" feature
      CoC: update to version 2.0 + local changes
      fsck doc: remove ancient out-of-date diagnostics
      ci: remove GETTEXT_POISON jobs
      tests: remove support for GIT_TEST_GETTEXT_POISON
      tests: remove uses of GIT_TEST_GETTEXT_POISON=3Dfalse
      cache-tree tests: refactor for modern test style
      cache-tree tests: remove unused $2 parameter
      cache-tree tests: use a sub-shell with less indirection
      cache-tree tests: explicitly test HEAD and index differences
      git svn mergeinfo tests: modernize redirection & quoting style
      git svn mergeinfo tests: refactor "test -z" to use test_must_be_emp=
ty
      upload-pack tests: avoid a non-zero "grep" exit status
      archive tests: use a cheaper "zipinfo -h" invocation to get header
      rm tests: actually test for SIGPIPE in SIGPIPE test
      config.mak.uname: remove redundant NO_LIBPCRE1_JIT flag
      Remove support for v1 of the PCRE library
      grep/pcre2 tests: don't rely on invalid UTF-8 data test
      grep/pcre2: better support invalid UTF-8 haystacks
      grep/log: remove hidden --debug and --grep-debug options
      pager: refactor wait_for_pager() function
      pager: test for exit code with and without SIGPIPE
      run-command: add braces for "if" block in wait_or_whine()
      pager: properly log pager exit code when signalled
      test-lib: remove check_var_migration
      test lib: change "error" to "BUG" as appropriate
      test-lib-functions: move test_set_index_version() to its user
      test-lib-functions: remove generate_zero_bytes() wrapper
      test libs: rename bundle helper to "lib-bundle.sh"
      test libs: rename gitweb-lib.sh to lib-gitweb.sh
      test-lib-functions: move function to lib-bitmap.sh
      t/.gitattributes: sort lines
      tests: remove last uses of GIT_TEST_GETTEXT_POISON=3Dfalse
      tests: remove most uses of C_LOCALE_OUTPUT
      tests: remove last uses of C_LOCALE_OUTPUT
      tests: remove most uses of test_i18ncmp
      diff: add an API for deferred freeing
      diff: plug memory leak from regcomp() on {log,diff} -I
      test libs: rename "diff-lib" to "lib-diff"
      test-lib-functions: remove bug-inducing "diagnostics" helper param
      test-lib-functions: assert correct parameter count


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D694C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 17:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351336AbiDLRF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiDLRF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 13:05:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3EF60A82
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 10:03:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 005E5191BF1;
        Tue, 12 Apr 2022 13:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=BMGbadepN+3GiKzOExH+d8l8B
        puPao9WBaEik/N0gYY=; b=mA5xqrFkDWd3XMt4RfenOCCf2FGzVC60T/htPiEYj
        bagwWdozdICsK+bNbKhtwO+Fz/sKHbRmERHbMcHfRejYuEclik7XU8rW2J3V8y2p
        rfPTWeI+69JO5p2Ai+wuXvZ69XEyz/uvpV/Eq9YeZIXXQ8sYfOyhvv87vc4KOUcJ
        JY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC3CE191BF0;
        Tue, 12 Apr 2022 13:03:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27AE5191BEF;
        Tue, 12 Apr 2022 13:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.36.0-rc2
Date:   Tue, 12 Apr 2022 10:03:30 -0700
Message-ID: <xmqqfsmib5el.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B7A9198-BA82-11EC-8CB8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.36.0-rc2 is now available for testing at
the usual places.  It is comprised of 673 non-merge commits since
v2.35.2, contributed by 85 people, 25 of which are new faces [*].

It is a day earlier than scheduled; it contains the same fix for
CVE-2022-24765 in the maintenance releases released today.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.36.0-rc2' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.35.2 are as follows.
Welcome to the Git development community!

  Abhradeep Chakraborty, BRESSAT Jonathan, Chen Bojun,
  COGONI Guillaume, David Cantrell, Des Preston, Hongyi Zhao,
  Jason Yundt, Jayati Shrivastava, Jaydeep Das, Jaydeep P Das,
  Jose Lopes, Justin Donnelly, Kraymer, Liginity Lee, Matheus
  Felipe, Maximilian Reichel, Michael McClimon, Nihal Jere,
  Pedro Martelletto, Robert Coup, Sean Allred, Shaoxuan Yuan,
  Shubham Mishra, and Waleed Khan.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alex Henrie,
  Atharva Raykar, Bagas Sanjaya, Beat Bolli, brian m. carlson,
  Carlo Marcelo Arenas Bel=C3=B3n, Christian Couder, Daniel Hahler,
  Derrick Stolee, Elia Pinto, Elijah Newren, Emily Shaffer,
  Eric Sunshine, Fabian Stelzer, Fangyi Zhou, Glen Choo, Greg
  Hurrell, Han-Wen Nienhuys, Jacob Keller, Jean-No=C3=ABl Avila, Jeff
  Hostetler, Jeff King, Jerry Zhang, Jessica Clarke, Jiang Xin,
  Joel Holdsworth, Johannes Altmanninger, Johannes Schindelin,
  Johannes Sixt, John Cai, Jonathan Nieder, Jonathan Tan, Josh
  Steadmon, Junio C Hamano, Kevin Willford, Lessley Dennington,
  Marc Strapetz, Martin =C3=85gren, Matt Cooper, Michael J Gruber,
  Neeraj Singh, Patrick Steinhardt, Philip Oakley, Philippe Blain,
  Phillip Wood, Ramkumar Ramachandra, Randall S. Becker, Ren=C3=A9
  Scharfe, Shourya Shukla, SZEDER G=C3=A1bor, Tao Klerks, Taylor Blau,
  Teng Long, Thomas Gummerer, Thomas Koutcher, Tilman Vogel,
  Todd Zullinger, and Victoria Dye.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git 2.36 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since Git 2.35
----------------------

Backward compatibility warts

 * "git name-rev --stdin" has been deprecated and issues a warning
   when used; use "git name-rev --annotate-stdin" instead.

 * "git clone --filter=3D... --recurse-submodules" only makes the
   top-level a partial clone, while submodules are fully cloned.  This
   behaviour is changed to pass the same filter down to the submodules.


Note to those who build from the source

 * Since Git 2.31, our source assumed that the compiler you use to
   build Git supports variadic macros, with an easy-to-use escape
   hatch to allow compilation without variadic macros with an request
   to report that you had to use the escape hatch to the list.
   Because we haven't heard from anybody who actually needed to use
   the escape hatch, it has been removed, making support of variadic
   macros a hard requirement.


UI, Workflows & Features

 * Assorted updates to "git cat-file", especially "-h".

 * The command line completion (in contrib/) learns to complete
   arguments to give to "git sparse-checkout" command.

 * "git log --remerge-diff" shows the difference from mechanical merge
   result and the result that is actually recorded in a merge commit.

 * "git log" and friends learned an option --exclude-first-parent-only
   to propagate UNINTERESTING bit down only along the first-parent
   chain, just like --first-parent option shows commits that lack the
   UNINTERESTING bit only along the first-parent chain.

 * The command line completion script (in contrib/) learned to
   complete all Git subcommands, including the ones that are normally
   hidden, when GIT_COMPLETION_SHOW_ALL_COMMANDS is used.

 * "git branch" learned the "--recurse-submodules" option.

 * A not-so-common mistake is to write a script to feed "git bisect
   run" without making it executable, in which case all tests will
   exit with 126 or 127 error codes, even on revisions that are marked
   as good.  Try to recognize this situation and stop iteration early.

 * When "index-pack" dies due to incoming data exceeding the maximum
   allowed input size, include the value of the limit in the error
   message.

 * The error message given by "git switch HEAD~4" has been clarified
   to suggest the "--detach" option that is required.

 * In sparse-checkouts, files mis-marked as missing from the working tree
   could lead to later problems.  Such files were hard to discover, and
   harder to correct.  Automatically detecting and correcting the marking
   of such files has been added to avoid these problems.

 * "git cat-file" learns "--batch-command" mode, which is a more
   flexible interface than the existing "--batch" or "--batch-check"
   modes, to allow different kinds of inquiries made.

 * The level of verbose output from the ort backend during inner merge
   has been aligned to that of the recursive backend.

 * "git remote rename A B", depending on the number of remote-tracking
   refs involved, takes long time renaming them.  The command has been
   taught to show progress bar while making the user wait.

 * Bundle file format gets extended to allow a partial bundle,
   filtered by similar criteria you would give when making a
   partial/lazy clone.

 * A new built-in userdiff driver for kotlin has been added.

 * "git repack" learned a new configuration to disable triggering of
   age-old "update-server-info" command, which is rarely useful these
   days.

 * "git stash" does not allow subcommands it internally runs as its
   implementation detail, except for "git reset", to emit messages;
   now "git reset" part has also been squelched.

 * "git ls-tree" learns "--oid-only" option, similar to "--name-only",
   and more generalized "--format" option.

 * "git fetch --refetch" learned to fetch everything without telling
   the other side what we already have, which is useful when you
   cannot trust what you have in the local object store.

 * "git branch" gives hint when branch tracking cannot be established
   because fetch refspecs from multiple remote repositories overlap.

 * "git worktree list --porcelain" did not c-quote pathnames and lock
   reasons with unsafe bytes correctly, which is worked around by
   introducing NUL terminated output format with "-z".


Performance, Internal Implementation, Development Support etc.

 * "git apply" (ab)used the util pointer of the string-list to keep
   track of how each symbolic link needs to be handled, which has been
   simplified by using strset.

 * Fix a hand-rolled alloca() imitation that may have violated
   alignment requirement of data being sorted in compatibility
   implementation of qsort_s() and stable qsort().

 * Use the parse-options API in "git reflog" command.

 * The conditional inclusion mechanism of configuration files using
   "[includeIf <condition>]" learns to base its decision on the
   URL of the remote repository the repository interacts with.
   (merge 399b198489 jt/conditional-config-on-remote-url later to maint).

 * "git name-rev --stdin" does not behave like usual "--stdin" at
   all.  Start the process of renaming it to "--annotate-stdin".
   (merge a2585719b3 jc/name-rev-stdin later to maint).

 * "git update-index", "git checkout-index", and "git clean" are
   taught to work better with the sparse checkout feature.

 * Use an internal call to reset_head() helper function instead of
   spawning "git checkout" in "rebase", and update code paths that are
   involved in the change.

 * Messages "ort" merge backend prepares while dealing with conflicted
   paths were unnecessarily confusing since it did not differentiate
   inner merges and outer merges.

 * Small modernization of the rerere-train script (in contrib/).

 * Use designated initializers we started using in mid 2017 in more
   parts of the codebase that are relatively quiescent.

 * Improve failure case behaviour of xdiff library when memory
   allocation fails.

 * General clean-up in reftable implementation, including
   clarification of the API documentation, tightening the code to
   honor documented length limit, etc.

 * Remove the escape hatch we added when we introduced the weather
   balloon to use variadic macros unconditionally, to make it official
   that we now have a hard dependency on the feature.

 * Makefile refactoring with a bit of suffixes rule stripping to
   optimize the runtime overhead.

 * "git stash drop" is reimplemented as an internal call to
   reflog_delete() function, instead of invoking "git reflog delete"
   via run_command() API.

 * Count string_list items in size_t, not "unsigned int".

 * The single-key interactive operation used by "git add -p" has been
   made more robust.

 * Remove unneeded <meta http-equiv=3Dcontent-type...> from gitweb
   output.

 * "git name-rev" learned to use the generation numbers when setting
   the lower bound of searching commits used to explain the revision,
   when available, instead of committer time.

 * Replace core.fsyncObjectFiles with two new configuration variables,
   core.fsync and core.fsyncMethod.

 * Updates to refs traditionally weren't fsync'ed, but we can
   configure using core.fsync variable to do so.

 * "git reflog" command now uses parse-options API to parse its
   command line options.


Fixes since v2.35
-----------------

 * "rebase" and "stash" in secondary worktrees are broken in
   Git 2.35.0, which has been corrected.

 * "git pull --rebase" ignored the rebase.autostash configuration
   variable when the remote history is a descendant of our history,
   which has been corrected.
   (merge 3013d98d7a pb/pull-rebase-autostash-fix later to maint).

 * "git update-index --refresh" has been taught to deal better with
   racy timestamps (just like "git status" already does).
   (merge 2ede073fd2 ms/update-index-racy later to maint).

 * Avoid tests that are run under GIT_TRACE2 set from failing
   unnecessarily.
   (merge 944d808e42 js/test-unset-trace2-parents later to maint).

 * The merge-ort misbehaved when merge.renameLimit configuration is
   set too low and failed to find all renames.
   (merge 9ae39fef7f en/merge-ort-restart-optim-fix later to maint).

 * We explain that revs come first before the pathspec among command
   line arguments, but did not spell out that dashed options come
   before other args, which has been corrected.
   (merge c11f95010c tl/doc-cli-options-first later to maint).

 * "git add -p" rewritten in C regressed hunk splitting in some cases,
   which has been corrected.
   (merge 7008ddc645 pw/add-p-hunk-split-fix later to maint).

 * "git fetch --negotiate-only" is an internal command used by "git
   push" to figure out which part of our history is missing from the
   other side.  It should never recurse into submodules even when
   fetch.recursesubmodules configuration variable is set, nor it
   should trigger "gc".  The code has been tightened up to ensure it
   only does common ancestry discovery and nothing else.
   (merge de4eaae63a gc/fetch-negotiate-only-early-return later to maint)=
.

 * The code path that verifies signatures made with ssh were made to
   work better on a system with CRLF line endings.
   (merge caeef01ea7 fs/ssh-signing-crlf later to maint).

 * "git sparse-checkout init" failed to write into $GIT_DIR/info
   directory when the repository was created without one, which has
   been corrected to auto-create it.
   (merge 7f44842ac1 jt/sparse-checkout-leading-dir-fix later to maint).

 * Cloning from a repository that does not yet have any branches or
   tags but has other refs resulted in a "remote transport reported
   error", which has been corrected.
   (merge dccea605b6 jt/clone-not-quite-empty later to maint).

 * Mark in various places in the code that the sparse index and the
   split index features are mutually incompatible.
   (merge 451b66c533 js/sparse-vs-split-index later to maint).

 * Update the logic to compute alignment requirement for our mem-pool.
   (merge e38bcc66d8 jc/mem-pool-alignment later to maint).

 * Pick a better random number generator and use it when we prepare
   temporary filenames.
   (merge 47efda967c bc/csprng-mktemps later to maint).

 * Update the contributor-facing documents on proposed log messages.
   (merge cdba0295b0 jc/doc-log-messages later to maint).

 * When "git fetch --prune" failed to prune the refs it wanted to
   prune, the command issued error messages but exited with exit
   status 0, which has been corrected.
   (merge c9e04d905e tg/fetch-prune-exit-code-fix later to maint).

 * Problems identified by Coverity in the reftable code have been
   corrected.
   (merge 01033de49f hn/reftable-coverity-fixes later to maint).

 * A bug that made multi-pack bitmap and the object order out-of-sync,
   making the .midx data corrupt, has been fixed.
   (merge f8b60cf99b tb/midx-bitmap-corruption-fix later to maint).

 * The build procedure has been taught to notice older version of zlib
   and enable our replacement uncompress2() automatically.
   (merge 07564773c2 ab/auto-detect-zlib-compress2 later to maint).

 * Interaction between fetch.negotiationAlgorithm and
   feature.experimental configuration variables has been corrected.
   (merge 714edc620c en/fetch-negotiation-default-fix later to maint).

 * "git diff --diff-filter=3DaR" is now parsed correctly.
   (merge 75408ca949 js/diff-filter-negation-fix later to maint).

 * When "git subtree" wants to create a merge, it used "git merge" and
   let it be affected by end-user's "merge.ff" configuration, which
   has been corrected.
   (merge 9158a3564a tk/subtree-merge-not-ff-only later to maint).

 * Unlike "git apply", "git patch-id" did not handle patches with
   hunks that has only 1 line in either preimage or postimage, which
   has been corrected.
   (merge 757e75c81e jz/patch-id-hunk-header-parsing-fix later to maint).

 * "receive-pack" checks if it will do any ref updates (various
   conditions could reject a push) before received objects are taken
   out of the temporary directory used for quarantine purposes, so
   that a push that is known-to-fail will not leave crufts that a
   future "gc" needs to clean up.
   (merge 5407764069 cb/clear-quarantine-early-on-all-ref-update-errors l=
ater to maint).

 * Because a deletion of ref would need to remove it from both the
   loose ref store and the packed ref store, a delete-ref operation
   that logically removes one ref may end up invoking ref-transaction
   hook twice, which has been corrected.
   (merge 2ed1b64ebd ps/avoid-unnecessary-hook-invocation-with-packed-ref=
s later to maint).

 * When there is no object to write .bitmap file for, "git
   multi-pack-index" triggered an error, instead of just skipping,
   which has been corrected.
   (merge eb57277ba3 tb/midx-no-bitmap-for-no-objects later to maint).

 * "git cmd -h" outside a repository should error out cleanly for many
   commands, but instead it hit a BUG(), which has been corrected.
   (merge 87ad07d735 js/short-help-outside-repo-fix later to maint).

 * "working tree" and "per-worktree ref" were in glossary, but
   "worktree" itself wasn't, which has been corrected.
   (merge 2df5387ed0 jc/glossary-worktree later to maint).

 * L10n support for a few error messages.
   (merge 3d3c23b3a7 bs/forbid-i18n-of-protocol-token-in-fetch-pack later=
 to maint).

 * Test modernization.
   (merge d4fe066e4b sy/t0001-use-path-is-helper later to maint).

 * "git log --graph --graph" used to leak a graph structure, and there
   was no way to countermand "--graph" that appear earlier on the
   command line.  A "--no-graph" option has been added and resource
   leakage has been plugged.

 * Error output given in response to an ambiguous object name has been
   improved.
   (merge 3a73c1dfaf ab/ambiguous-object-name later to maint).

 * "git sparse-checkout" wants to work with per-worktree configuration,
   but did not work well in a worktree attached to a bare repository.
   (merge 3ce1138272 ds/sparse-checkout-requires-per-worktree-config late=
r to maint).

 * Setting core.untrackedCache to true failed to add the untracked
   cache extension to the index.

 * Workaround we have for versions of PCRE2 before their version 10.36
   were in effect only for their versions newer than 10.36 by mistake,
   which has been corrected.
   (merge 97169fc361 rs/pcre-invalid-utf8-fix-fix later to maint).

 * Document Taylor as a new member of Git PLC at SFC.  Welcome.
   (merge e8d56ca863 tb/coc-plc-update later to maint).

 * "git checkout -b branch/with/multi/level/name && git stash" only
   recorded the last level component of the branch name, which has
   been corrected.

 * "git fetch" can make two separate fetches, but ref updates coming
   from them were in two separate ref transactions under "--atomic",
   which has been corrected.

 * Check the return value from parse_tree_indirect() to turn segfaults
   into calls to die().
   (merge 8d2eaf649a gc/parse-tree-indirect-errors later to maint).

 * Newer version of GPGSM changed its output in a backward
   incompatible way to break our code that parses its output.  It also
   added more processes our tests need to kill when cleaning up.
   Adjustments have been made to accommodate these changes.
   (merge b0b70d54c4 fs/gpgsm-update later to maint).

 * The untracked cache newly computed weren't written back to the
   on-disk index file when there is no other change to the index,
   which has been corrected.

 * "git config -h" did not describe the "--type" option correctly.
   (merge 5445124fad mf/fix-type-in-config-h later to maint).

 * The way generation number v2 in the commit-graph files are
   (not) handled has been corrected.
   (merge 6dbf4b8172 ds/commit-graph-gen-v2-fixes later to maint).

 * The method to trigger malloc check used in our tests no longer work
   with newer versions of glibc.
   (merge baedc59543 ep/test-malloc-check-with-glibc-2.34 later to maint)=
.

 * When "git fetch --recurse-submodules" grabbed submodule commits
   that would be needed to recursively check out newly fetched commits
   in the superproject, it only paid attention to submodules that are
   in the current checkout of the superproject.  We now do so for all
   submodules that have been run "git submodule init" on.

 * "git rebase $base $non_branch_commit", when $base is an ancestor or
   the $non_branch_commit, modified the current branch, which has been
   corrected.

 * When "shallow" information is updated, we forgot to update the
   in-core equivalent, which has been corrected.

 * When creating a loose object file, we didn't report the exact
   filename of the file we failed to fsync, even though the
   information was readily available, which has been corrected.

 * "git am" can read from the standard input when no mailbox is given
   on the command line, but the end-user gets no indication when it
   happens, making Git appear stuck.
   (merge 7b20af6a06 jc/mailsplit-warn-on-tty later to maint).

 * "git mv" failed to refresh the cached stat information for the
   entry it moved.
   (merge b7f9130a06 vd/mv-refresh-stat later to maint).

 * Fix for CVE-2022-24765 has been merged up from 2.35.2 and others.

 * Other code cleanup, docfix, build fix, etc.
   (merge cfc5cf428b jc/find-header later to maint).
   (merge 40e7cfdd46 jh/p4-fix-use-of-process-error-exception later to ma=
int).
   (merge 727e6ea350 jh/p4-spawning-external-commands-cleanup later to ma=
int).
   (merge 0a6adc26e2 rs/grep-expr-cleanup later to maint).
   (merge 4ed7dfa713 po/readme-mention-contributor-hints later to maint).
   (merge 6046f7a91c en/plug-leaks-in-merge later to maint).
   (merge 8c591dbfce bc/clarify-eol-attr later to maint).
   (merge 518e15db74 rs/parse-options-lithelp-help later to maint).
   (merge cbac0076ef gh/doc-typos later to maint).
   (merge ce14de03db ab/no-errno-from-resolve-ref-unsafe later to maint).
   (merge 2826ffad8c rc/negotiate-only-typofix later to maint).
   (merge 0f03f04c5c en/sparse-checkout-leakfix later to maint).
   (merge 74f3390dde sy/diff-usage-typofix later to maint).
   (merge 45d0212a71 ll/doc-mktree-typofix later to maint).
   (merge e9b272e4c1 js/no-more-legacy-stash later to maint).
   (merge 6798b08e84 ab/do-not-hide-failures-in-git-dot-pm later to maint=
).
   (merge 9325285df4 po/doc-check-ignore-markup-fix later to maint).
   (merge cd26cd6c7c sy/modernize-t-lib-read-tree-m-3way later to maint).
   (merge d17294a05e ab/hash-object-leakfix later to maint).
   (merge b8403129d3 jd/t0015-modernize later to maint).
   (merge 332acc248d ds/mailmap later to maint).
   (merge 04bf052eef ab/grep-patterntype later to maint).
   (merge 6ee36364eb ab/diff-free-more later to maint).
   (merge 63a36017fe nj/read-tree-doc-reffix later to maint).
   (merge eed36fce38 sm/no-git-in-upstream-of-pipe-in-tests later to main=
t).
   (merge c614beb933 ep/t6423-modernize later to maint).
   (merge 57be9c6dee ab/reflog-prep-fix later to maint).
   (merge 5327d8982a js/in-place-reverse-in-sequencer later to maint).
   (merge 2e2c0be51e dp/worktree-repair-in-usage later to maint).
   (merge 6563706568 jc/coding-guidelines-decl-in-for-loop later to maint=
).

----------------------------------------------------------------

Changes since v2.35.2 are as follows:

Abhradeep Chakraborty (2):
      amend remaining usage strings according to style guide
      partial-clone: add a partial-clone test case

Adam Dinwoodie (2):
      configure.ac: fix HAVE_SYNC_FILE_RANGE definition
      t9902: split test to run on appropriate systems

Alex Henrie (3):
      log: fix memory leak if --graph is passed multiple times
      log: add a --no-graph option
      switch: mention the --detach option when dying due to lack of a bra=
nch

Atharva Raykar (5):
      submodule--helper: get remote names from any repository
      submodule--helper: refactor get_submodule_displaypath()
      submodule--helper: allow setting superprefix for init_submodule()
      submodule--helper: run update using child process struct
      submodule: move core cmd_update() logic to C

Bagas Sanjaya (1):
      fetch-pack: parameterize message containing 'ready' keyword

COGONI Guillaume (3):
      t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
      tests: allow testing if a path is truly a file or a directory
      tests: make the code more readable

Carlo Marcelo Arenas Bel=C3=B3n (1):
      git-compat-util: really support openssl as a source of entropy

Chen Bojun (1):
      receive-pack: purge temporary data if no command is ready to run

David Cantrell (1):
      completion: tab completion of filenames for 'git restore'

Derrick Stolee (45):
      Documentation: add extensions.worktreeConfig details
      worktree: create init_worktree_config()
      config: add repo_config_set_worktree_gently()
      sparse-checkout: set worktree-config correctly
      worktree: copy sparse-checkout patterns and config on add
      config: make git_configset_get_string_tmp() private
      mailmap: change primary address for Derrick Stolee
      dir: force untracked cache with core.untrackedCache
      worktree: combine two translatable messages
      worktree: extract copy_filtered_worktree_config()
      worktree: extract copy_sparse_checkout()
      worktree: extract checkout_worktree()
      worktree: use 'worktree' over 'working tree'
      worktree: use 'worktree' over 'working tree'
      worktree: use 'worktree' over 'working tree'
      worktree: use 'worktree' over 'working tree'
      worktree: use 'worktree' over 'working tree'
      worktree: use 'worktree' over 'working tree'
      worktree: use 'worktree' over 'working tree'
      test-read-graph: include extra post-parse info
      t5318: extract helpers to lib-commit-graph.sh
      commit-graph: fix ordering bug in generation numbers
      commit-graph: start parsing generation v2 (again)
      commit-graph: fix generation number v2 overflow values
      commit-graph: declare bankruptcy on GDAT chunks
      index-pack: document and test the --promisor option
      list-objects-filter-options: create copy helper
      revision: put object filter into struct rev_info
      pack-objects: use rev.filter when possible
      pack-bitmap: drop filter in prepare_bitmap_walk()
      list-objects: consolidate traverse_commit_list[_filtered]
      MyFirstObjectWalk: update recommended usage
      bundle: parse filter capability
      rev-list: move --filter parsing into revision.c
      bundle: create filtered bundles
      bundle: unbundle promisor packs
      clone: fail gracefully when cloning filtered bundle
      maintenance: fix synopsis in documentation
      list-objects-filter: remove CL_ARG__FILTER
      pack-objects: move revs out of get_object_list()
      pack-objects: parse --filter directly into revs.filter
      bundle: move capabilities to end of 'verify'
      bundle: output hash information in 'verify'
      t7700: check post-condition in kept-pack test
      test-lib-functions: remove test_subcommand_inexact

Des Preston (1):
      worktree: include repair cmd in usage

Elia Pinto (8):
      test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >=
=3D 2.34
      t6423-merge-rename-directories.sh: use the $(...) construct
      attr.c: delete duplicate include
      builtin/gc.c: delete duplicate include
      builtin/sparse-checkout.c: delete duplicate include
      builtin/stash.c: delete duplicate include
      t/helper/test-run-command.c: delete duplicate include
      attr.h: remove duplicate struct definition

Elijah Newren (32):
      t1011: add testcase demonstrating accidental loss of user modificat=
ions
      unpack-trees: fix accidental loss of user changes
      repo_read_index: clear SKIP_WORKTREE bit from files present in work=
tree
      Update documentation related to sparsity and the skip-worktree bit
      Accelerate clear_skip_worktree_from_present_files() by caching
      merge-ort: avoid assuming all renames detected
      merge-ort: fix memory leak in merge_ort_internal()
      merge: fix memory leaks in cmd_merge()
      sparse-checkout: fix a couple minor memory leaks
      repo-settings: fix checking for fetch.negotiationAlgorithm=3Ddefaul=
t
      repo-settings: fix error handling for unknown values
      repo-settings: rename the traditional default fetch.negotiationAlgo=
rithm
      show, log: provide a --remerge-diff capability
      log: clean unneeded objects during `log --remerge-diff`
      ll-merge: make callers responsible for showing warnings
      merge-ort: capture and print ll-merge warnings in our preferred fas=
hion
      merge-ort: mark a few more conflict messages as omittable
      merge-ort: format messages slightly different for use in headers
      diff: add ability to insert additional headers for paths
      show, log: include conflict/warning messages in --remerge-diff head=
ers
      merge-ort: mark conflict/warning messages from inner merges as omit=
table
      diff-merges: avoid history simplifications when diffing merges
      merge-ort: make informational messages from recursive merges cleare=
r
      sparse-checkout: correct reapply's handling of options
      sparse-checkout: correctly set non-cone mode when expected
      sparse-checkout: pay attention to prefix for {set, add}
      sparse-checkout: error or warn when given individual files
      sparse-checkout: reject arguments in cone-mode that look like patte=
rns
      merge-ort: fix small memory leak in detect_and_process_renames()
      merge-ort: fix small memory leak in unique_path()
      merge-ort: exclude messages from inner merges by default
      repo_read_index: add config to expect files outside sparse patterns

Emily Shaffer (14):
      hook: add 'run' subcommand
      gc: use hook library for pre-auto-gc hook
      am: convert {pre,post}-applypatch to use hook.h
      rebase: convert pre-rebase to use hook.h
      am: convert applypatch-msg to use hook.h
      merge: convert post-merge to use hook.h
      hooks: convert non-worktree 'post-checkout' hook to hook library
      hooks: convert worktree 'post-checkout' hook to hook library
      send-email: use 'git hook run' for 'sendemail-validate'
      git-p4: use 'git hook' to run hooks
      commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
      read-cache: convert post-index-change to use hook.h
      receive-pack: convert push-to-checkout hook to hook.h
      run-command: remove old run_hook_{le,ve}() hook API

Fabian Stelzer (2):
      gpg-interface: trim CR from ssh-keygen
      gpg-interface/gpgsm: fix for v2.3

Fangyi Zhou (1):
      submodule-helper: fix usage string

Glen Choo (39):
      fetch: use goto cleanup in cmd_fetch()
      fetch: skip tasks related to fetching objects
      fetch --negotiate-only: do not update submodules
      branch: move --set-upstream-to behavior to dwim_and_setup_tracking(=
)
      branch: make create_branch() always create a branch
      branch: add a dry_run parameter to create_branch()
      builtin/branch: consolidate action-picking logic in cmd_branch()
      branch: add --recurse-submodules option for branch creation
      branch.c: use 'goto cleanup' in setup_tracking() to fix memory leak=
s
      stash: strip "refs/heads/" with skip_prefix
      checkout, clone: die if tree cannot be parsed
      submodule--helper: remove update-module-mode
      submodule--helper: reorganize code for sh to C conversion
      submodule--helper run-update-procedure: remove --suboid
      submodule--helper run-update-procedure: learn --remote
      submodule--helper update-clone: learn --init
      submodule--helper: remove ensure-core-worktree
      submodule update: add tests for --filter
      submodule--helper update-clone: check for --filter and --init
      t5526: introduce test helper to assert on fetches
      t5526: stop asserting on stderr literally
      t5526: create superproject commits with test helper
      submodule: make static functions read submodules from commits
      submodule: inline submodule_commits() into caller
      submodule: store new submodule commits oid_array in a struct
      submodule: extract get_fetch_task()
      submodule: move logic into fetch_task_create()
      submodule update: use die_message()
      submodule--helper: teach update_data more options
      submodule--helper: reduce logic in run_update_procedure()
      submodule--helper: remove forward declaration
      fetch: fetch unpopulated, changed submodules
      submodule: fix latent check_has_commit() bug
      branch: support more tracking modes when recursing
      branch: give submodule updating advice before exit
      branch --set-upstream-to: be consistent when advising
      branch: remove negative exit code
      branch: rework comments for future developers
      branch.c: simplify advice-and-die sequence

Greg Hurrell (2):
      Documentation/config/pgp.txt: replace stray <TAB> character with <S=
PC>
      Documentation/config/pgp.txt: add missing apostrophe

Han-Wen Nienhuys (27):
      reftable: fix OOB stack write in print functions
      reftable: fix resource leak in block.c error path
      reftable: fix resource leak blocksource.c
      reftable: check reftable_stack_auto_compact() return value
      reftable: ignore remove() return value in stack_test.c
      reftable: fix resource warning
      reftable: all xxx_free() functions accept NULL arguments
      reftable: order unittests by complexity
      reftable: drop stray printf in readwrite_test
      reftable: handle null refnames in reftable_ref_record_equal
      reftable: make reftable-record.h function signatures const correct
      reftable: implement record equality generically
      reftable: remove outdated file reftable.c
      reftable: make reftable_record a tagged union
      reftable: add print functions to the record types
      t1405: explictly delete reflogs for reftable
      t1405: mark test that checks existence as REFFILES
      t5312: prepare for reftable
      t1410: use test-tool ref-store to inspect reflogs
      t1410: mark bufsize boundary test as REFFILES
      Documentation: object_id_len goes up to 31
      reftable: reject 0 object_id_len
      reftable: add a test that verifies that writing empty keys fails
      reftable: avoid writing empty keys at the block layer
      reftable: ensure that obj_id_len is >=3D 2 on writing
      reftable: add test for length of disambiguating prefix
      reftable: rename writer_stats to reftable_writer_stats

Jacob Keller (1):
      name-rev: use generation numbers if available

Jason Yundt (2):
      comment: fix typo
      gitweb: remove invalid http-equiv=3D"content-type"

Jayati Shrivastava (1):
      sequencer: use reverse_commit_list() helper

Jaydeep Das (1):
      t/t0015-hash.sh: remove unnecessary '\' at line end

Jaydeep P Das (1):
      userdiff: add builtin diff driver for kotlin language.

Jean-No=C3=ABl Avila (5):
      i18n: factorize more 'incompatible options' messages
      i18n: factorize "invalid value" messages
      i18n: remove from i18n strings that do not hold translatable parts
      i18n: fix some misformated placeholders in command synopsis
      i18n: fix some badly formatted i18n strings

Jeff Hostetler (30):
      fsmonitor: enhance existing comments, clarify trivial response hand=
ling
      fsmonitor-ipc: create client routines for git-fsmonitor--daemon
      fsmonitor: config settings are repository-specific
      fsmonitor: use IPC to query the builtin FSMonitor daemon
      fsmonitor: document builtin fsmonitor
      fsmonitor--daemon: add a built-in fsmonitor daemon
      fsmonitor--daemon: implement 'stop' and 'status' commands
      compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
      compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
      fsmonitor--daemon: implement 'run' command
      fsmonitor--daemon: implement 'start' command
      fsmonitor--daemon: add pathname classification
      fsmonitor--daemon: define token-ids
      fsmonitor--daemon: create token-based changed path cache
      compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on W=
indows
      compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEv=
ent
      compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on M=
acOS
      fsmonitor--daemon: implement handle_client callback
      help: include fsmonitor--daemon feature flag in version info
      t/helper/fsmonitor-client: create IPC client to talk to FSMonitor D=
aemon
      t7527: create test for fsmonitor--daemon
      t/perf: avoid copying builtin fsmonitor files into test repo
      t/helper/test-chmtime: skip directories on Windows
      t/perf/p7519: fix coding style
      t/perf/p7519: speed up test on Windows
      t/perf/p7519: add fsmonitor--daemon test cases
      fsmonitor--daemon: periodically truncate list of modified files
      fsmonitor--daemon: use a cookie file to sync with file system
      fsmonitor: force update index after large responses
      t7527: test status with untracked-cache and fsmonitor--daemon

Jerry Zhang (3):
      git-rev-list: add --exclude-first-parent-only flag
      patch-id: fix antipatterns in tests
      patch-id: fix scan_hunk_header on diffs with 1 line of before/after

Jessica Clarke (1):
      mem-pool: don't assume uintmax_t is aligned enough for all types

Joel Holdsworth (4):
      git-p4: don't select shell mode using the type of the command argum=
ent
      git-p4: pass command arguments as lists instead of using shell
      git-p4: don't print shell commands as python lists
      git-p4: fix instantiation of CalledProcessError

Johannes Schindelin (14):
      sparse-index: sparse index is disallowed when split index is active
      t1091: disable split index
      split-index: it really is incompatible with the sparse index
      git-sh-setup: remove remnant bits referring to `git-legacy-stash`
      add: remove support for `git-legacy-stash`
      stash: remove documentation for `stash.useBuiltin`
      stash: stop warning about the obsolete `stash.useBuiltin` config se=
tting
      docs(diff): lose incorrect claim about `diff-files --diff-filter=3D=
A`
      diff.c: move the diff filter bits definitions up a bit
      diff-filter: be more careful when looking for negative bits
      scalar: accept -C and -c options before the subcommand
      checkout/fetch/pull/pack-objects: allow `-h` outside a repository
      t0012: verify that built-ins handle `-h` even without gitdir
      cocci: allow padding with `strbuf_addf()`

John Cai (15):
      receive-pack.c: consolidate find header logic
      name-rev: deprecate --stdin in favor of --annotate-stdin
      name-rev.c: use strbuf_getline instead of limited size buffer
      builtin/reflog.c: use parse-options api for expire, delete subcomma=
nds
      name-rev: replace --stdin with --annotate-stdin in synopsis
      cat-file: rename cmdmode to transform_mode
      cat-file: introduce batch_mode enum to replace print_contents
      cat-file: add remove_timestamp helper
      cat-file: add --batch-command mode
      stash: add tests to ensure reflog --rewrite --updatref behavior
      reflog: libify delete reflog function and helpers
      stash: call reflog_delete() in reflog.c
      cat-file: skip expanding default format
      rebase: use test_commit helper in setup
      rebase: set REF_HEAD_DETACH in checkout_up_to_date()

Jonathan Tan (6):
      config: make git_config_include() static
      config: include file if remote URL matches a glob
      sparse-checkout: create leading directory
      clone: support unusual remote ref configurations
      ls-files: support --recurse-submodules --stage
      shallow: reset commit grafts when shallow is reset

Josh Steadmon (3):
      test-lib: unset trace2 parent envvars
      clone, submodule: pass partial clone filters to submodules
      ls-tree: `-l` should not imply recursive listing

Junio C Hamano (32):
      compat/qsort_s.c: avoid using potentially unaligned access
      fetch: help translators by reusing the same message template
      Start post 2.35 cycle
      SubmittingPatches: write problem statement in the log in the presen=
t tense
      CodingGuidelines: hint why we value clearly written log messages
      SubmittingPatches: explain why we care about log messages
      Name the next one 2.36 to prepare for 2.35.1
      The first batch
      The second batch for 2.36
      glossary: describe "worktree"
      The third batch
      The fourth batch
      The fifth batch
      The sixth batch
      The seventh batch
      The eighth batch
      rerere-train: two fixes to the use of "git show -s"
      am/apply: warn if we end up reading patches from terminal
      The ninth batch
      The tenth batch
      The eleventh batch
      The twelfth batch
      The thirteenth batch
      The 14th batch
      reset: show --no-refresh in the short-help
      The 15th batch
      The 16th batch
      The 17th batch
      CodingGuidelines: give deadline for "for (int i =3D 0; ..."
      Git 2.36-rc0
      Git 2.36-rc1
      Git 2.36-rc2

Justin Donnelly (4):
      git-prompt: rename `upstream` to `upstream_type`
      git-prompt: make upstream state indicator location consistent
      git-prompt: make long upstream state indicator consistent
      git-prompt: put upstream comments together

Lessley Dennington (3):
      completion: address sparse-checkout issues
      completion: improve sparse-checkout cone mode directory completion
      completion: handle unusual characters for sparse-checkout

Liginity Lee (1):
      fix typo in git-mktree.txt

Marc Strapetz (4):
      test-lib: introduce API for verifying file mtime
      t7508: fix bogus mtime verification
      t7508: add tests capturing racy timestamp handling
      update-index: refresh should rewrite index in case of racy timestam=
ps

Martin =C3=85gren (1):
      git-ls-tree.txt: fix the name of "%(objectsize:padded)"

Matheus Felipe (1):
      config: correct "--type" option in "git config -h" output

Matt Cooper (1):
      index-pack: clarify the breached limit

Michael J Gruber (2):
      test-lib: declare local variables as local
      tests: demonstrate "show --word-diff --color-moved" regression

Neeraj Singh (10):
      wrapper: make inclusion of Windows csprng header tightly scoped
      core.fsyncmethod: add writeout-only mode
      core.fsync: introduce granular fsync control infrastructure
      core.fsync: add configuration parsing
      core.fsync: new option to harden the index
      core.fsync: documentation and user-friendly aggregate options
      core.fsync: fix incorrect expression for default configuration
      trace2: add stats for fsync operations
      core.fsyncmethod: correctly camel-case warning message
      object-file: pass filename to fsync_or_die

Nihal Jere (1):
      Documentation: git-read-tree: separate links using commas

Patrick Steinhardt (24):
      refs: extract packed_refs_delete_refs() to allow control of transac=
tion
      refs: allow passing flags when beginning transactions
      refs: allow skipping the reference-transaction hook
      refs: demonstrate excessive execution of the reference-transaction =
hook
      refs: do not execute reference-transaction hook on packing refs
      refs: skip hooks when deleting uncovered packed refs
      fetch-pack: use commit-graph when computing cutoff
      fetch: skip computing output width when not printing anything
      fetch: increase test coverage of fetches
      fetch: backfill tags before setting upstream
      fetch: control lifecycle of FETCH_HEAD in a single place
      fetch: report errors when backfilling tags fails
      refs: add interface to iterate over queued transactional updates
      fetch: make `--atomic` flag cover backfilling of tags
      fetch: make `--atomic` flag cover pruning of refs
      upload-pack: look up "want" lines via commit-graph
      fetch: avoid lookup of commits when not appending to FETCH_HEAD
      refs: add ability for backends to special-case reading of symbolic =
refs
      remote: read symbolic refs via `refs_read_symbolic_ref()`
      refs/files-backend: optimize reading of symbolic refs
      t5503: simplify setup of test which exercises failure of backfill
      repack: refactor to avoid double-negation of update-server-info
      repack: add config to skip updating server info
      core.fsync: new option to harden references

Philip Oakley (2):
      README.md: add CodingGuidelines and a link for Translators
      doc: check-ignore: code-quote an exclamation mark

Philippe Blain (1):
      pull --rebase: honor rebase.autostash when fast-forwarding

Phillip Wood (29):
      t3701: clean up hunk splitting tests
      builtin add -p: fix hunk splitting
      rebase: factor out checkout for up to date branch
      t5403: refactor rebase post-checkout hook tests
      rebase: pass correct arguments to post-checkout hook
      rebase: do not remove untracked files on checkout
      rebase --apply: don't run post-checkout hook if there is an error
      reset_head(): remove action parameter
      reset_head(): factor out ref updates
      reset_head(): make default_reflog_action optional
      create_autostash(): remove unneeded parameter
      rebase: cleanup reset_head() calls
      reset_head(): take struct rebase_head_opts
      rebase --apply: fix reflog
      rebase --apply: set ORIG_HEAD correctly
      rebase -m: don't fork git checkout
      xdiff: fix a memory leak
      xdiff: handle allocation failure in patience diff
      xdiff: refactor a function
      xdiff: handle allocation failure when merging
      terminal: always reset terminal when reading without echo
      terminal: pop signal handler when terminal is restored
      terminal: set VMIN and VTIME in non-canonical mode
      add -p: disable stdin buffering when interactive.singlekey is set
      terminal: use flags for save_term()
      terminal: don't assume stdin is /dev/tty
      terminal: work around macos poll() bug
      terminal: restore settings on SIGTSTP
      worktree: add -z option for list subcommand

Ren=C3=A9 Scharfe (10):
      grep: use grep_or_expr() in compile_pattern_or()
      grep: use grep_not_expr() in compile_pattern_not()
      apply: use strsets to track symlinks
      stable-qsort: avoid using potentially unaligned access
      bisect--helper: report actual bisect_state() argument on error
      bisect--helper: release strbuf and strvec on run error
      bisect: document run behavior with exit codes 126 and 127
      bisect--helper: double-check run command on exit code 126 and 127
      parse-options: document bracketing of argh
      grep: fix triggering PCRE2_NO_START_OPTIMIZE workaround

Robert Coup (8):
      fetch: fix negotiate-only error message
      fetch-negotiator: add specific noop initializer
      fetch-pack: add refetch
      builtin/fetch-pack: add --refetch option
      fetch: add --refetch option
      t5615-partial-clone: add test for fetch --refetch
      fetch: after refetch, encourage auto gc repacking
      docs: mention --refetch fetch option

SZEDER G=C3=A1bor (1):
      reflog: fix 'show' subcommand's argv

Shaoxuan Yuan (4):
      builtin/diff.c: fix "git-diff" usage string typo
      t/lib-read-tree-m-3way: modernize style
      t/lib-read-tree-m-3way: indent with tabs
      t0001: replace "test [-d|-f]" with test_path_is_* functions

Shubham Mishra (3):
      t0003: avoid pipes with Git on LHS
      t0001-t0028: avoid pipes with Git on LHS
      t0030-t0050: avoid pipes with Git on LHS

Tao Klerks (6):
      t7519: avoid file to index mtime race for untracked cache
      t7519: populate untracked cache before test
      untracked-cache: write index when populating empty untracked cache
      t/helper/test-chmtime: update mingw to support chmtime on directori=
es
      t7063: mtime-mangling instead of delays in untracked cache testing
      tracking branches: add advice to ambiguous refspec error

Taylor Blau (15):
      grep: extract grep_binexp() from grep_or_expr()
      grep: use grep_and_expr() in compile_pattern_and()
      t5326: demonstrate bitmap corruption after permutation
      midx.c: make changing the preferred pack safe
      pack-revindex.c: instrument loading on-disk reverse index
      t5326: drop unnecessary setup
      t5326: extract `test_rev_exists`
      t5326: move tests to t/lib-bitmap.sh
      t/lib-bitmap.sh: parameterize tests over reverse index source
      midx: read `RIDX` chunk when present
      pack-bitmap.c: gracefully fallback after opening pack/MIDX
      midx: prevent writing a .bitmap without any objects
      CODE_OF_CONDUCT.md: update PLC members list
      builtin/remote.c: parse options in 'rename'
      builtin/remote.c: show progress when renaming remote references

Teng Long (6):
      git-cli.txt: clarify "options first and then args"
      ls-tree: rename "retval" to "recurse" in "show_tree()"
      ls-tree: simplify nesting if/else logic in "show_tree()"
      ls-tree: fix "--name-only" and "--long" combined use bug
      ls-tree: slightly refactor `show_tree()`
      ls-tree: support --object-only option for "git-ls-tree"

Thomas Gummerer (1):
      fetch --prune: exit with error if pruning fails

Thomas Koutcher (1):
      subtree: force merge commit

Todd Zullinger (3):
      t/lib-gpg: reload gpg components after updating trustlist
      t/lib-gpg: kill all gpg components, not just gpg-agent
      doc: replace "--" with {litdd} in credential-cache/fsmonitor

Victoria Dye (30):
      reset: fix validation in sparse index test
      reset: reorder wildcard pathspec conditions
      clean: integrate with sparse index
      checkout-index: expand sparse checkout compatibility tests
      checkout-index: add --ignore-skip-worktree-bits option
      checkout-index: integrate with sparse index
      update-index: add tests for sparse-checkout compatibility
      update-index: integrate with sparse index
      update-index: reduce scope of index expansion in do_reupdate
      sparse-index: prevent repo root from becoming sparse
      status: fix nested sparse directory diff in sparse index
      read-tree: explicitly disallow prefixes with a leading '/'
      read-tree: expand sparse checkout test coverage
      read-tree: integrate with sparse index
      read-tree: narrow scope of index expansion for '--prefix'
      read-tree: make two-way merge sparse-aware
      read-tree: make three-way merge sparse-aware
      reset: revise index refresh advice
      reset: introduce --[no-]refresh option to --mixed
      reset: replace '--quiet' with '--no-refresh' in performance advice
      reset: suppress '--no-refresh' advice if logging is silenced
      stash: make internal resets quiet and refresh index
      t1092: add sparse directory before cone in test repo
      unpack-trees: increment cache_bottom for sparse directories
      Revert "unpack-trees: improve performance of next_cache_entry"
      reset: do not make '--quiet' disable index refresh
      reset: remove 'reset.quiet' config option
      reset: remove 'reset.refresh' config option
      mv: refresh stat info for moved entry
      contrib/scalar: fix 'all' target in Makefile

brian m. carlson (6):
      t0027: add tests for eol without text in .gitattributes
      docs: correct documentation about eol attribute
      wrapper: add a helper to generate numbers from a CSPRNG
      wrapper: use a CSPRNG to generate random file names
      doc: clarify interaction between 'eol' and text=3Dauto
      block-sha1: remove use of obsolete x86 assembly

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (186):
      cat-file tests: test bad usage
      cat-file tests: test messaging on bad objects/paths
      parse-options API: add a usage_msg_optf()
      cat-file docs: fix SYNOPSIS and "-h" output
      cat-file: move "usage" variable to cmd_cat_file()
      cat-file: make --batch-all-objects a CMDMODE
      cat-file: fix remaining usage bugs
      cat-file: correct and improve usage information
      object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
      cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
      hook API: add a run_hooks() wrapper
      hook API: add a run_hooks_l() wrapper
      git hook run: add an --ignore-missing flag
      cat-file: don't whitespace-pad "(...)" in SYNOPSIS and usage output
      cat-file: s/_/-/ in typo'd usage_msg_optf() message
      compat: auto-detect if zlib has uncompress2()
      sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failu=
re
      refs API: remove "failure_errno" from refs_resolve_ref_unsafe()
      object-name tests: add tests for ambiguous object blind spots
      object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
      object-name: explicitly handle bad tags in show_ambiguous_object()
      object-name: make ambiguous object output translatable
      object-name: show date for ambiguous tag objects
      object-name: iterate ambiguous objects before showing header
      object-name: re-use "struct strbuf" in show_ambiguous_object()
      perl Git.pm: don't ignore signalled failure in _cmd_close()
      completion tests: re-source git-completion.bash in a subshell
      completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
      leak tests: fix a memory leak in "test-progress" helper
      progress.c test helper: add missing braces
      progress.c tests: make start/stop commands on stdin
      progress.c tests: test some invalid usage
      progress.h: format and be consistent with progress.c naming
      progress.c: use dereferenced "progress" variable, not "(*p_progress=
)"
      progress.c: refactor stop_progress{,_msg}() to use helpers
      progress API: unify stop_progress{,_msg}(), fix trace2 bug
      pack-bitmap-write.c: don't return without stop_progress()
      t0051: use "skip_all" under !MINGW in single-test file
      hash-object: fix a trivial leak in --path
      ls-remote & transport API: release "struct transport_ls_refs_option=
s"
      grep.h: remove unused "regex_t regexp" from grep_opt
      log tests: check if grep_config() is called by "log"-like cmds
      grep tests: create a helper function for "BRE" or "ERE"
      grep tests: add missing "grep.patternType" config tests
      built-ins: trust the "prefix" from run_builtin()
      grep.c: don't pass along NULL callback value
      grep API: call grep_config() after grep_init()
      grep.h: make "grep_opt.pattern_type_option" use its enum
      grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
      grep: simplify config parsing and option parsing
      cache.h: remove always unused show_date_human() declaration
      date API: create a date.h, split from cache.h
      date API: provide and use a DATE_MODE_INIT
      date API: add basic API docs
      date API: add and use a date_mode_release()
      diff.[ch]: have diff_free() call clear_pathspec(opts.pathspec)
      diff.[ch]: have diff_free() free options->parseopts
      hook tests: test for exact "pre-push" hook input
      hook tests: use a modern style for "pre-push" tests
      git-compat-util.h: clarify GCC v.s. C99-specific in comment
      C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
      help doc: add missing "]" to "[-a|--all]"
      help.c: use puts() instead of printf{,_ln}() for consistency
      help tests: test "git" and "git help [-a|-g] spacing
      help.c: split up list_all_cmds_help() function
      help: note the option name on option incompatibility
      help: correct usage & behavior of "git help --all"
      help: error if [-a|-g|-c] and [-i|-m|-w] are combined
      help: add --no-[external-commands|aliases] for use with --all
      help: don't print "\n" before single-section output
      imap-send.c: use designated initializers for "struct imap_server_co=
nf"
      trace2: use designated initializers for "struct tr2_tgt"
      trace2: use designated initializers for "struct tr2_dst"
      object-file: use designated initializers for "struct git_hash_algo"
      archive-*.c: use designated initializers for "struct archiver"
      userdiff.c: use designated initializers for "struct userdiff_driver=
"
      convert.c: use designated initializers for "struct stream_filter*"
      refspec.c: use designated initializers for "struct refspec_item"
      fast-import.c: use designated initializers for "partial" struct ass=
ignments
      object-file.c: split up declaration of unrelated variables
      object-file API: return "void", not "int" from hash_object_file()
      object-file API: add a format_object_header() function
      object-file API: have write_object_file() take "enum object_type"
      object API: correct "buf" v.s. "map" mismatch in *.c and *.h
      object API docs: move check_object_signature() docs to cache.h
      object API users + docs: check <0, not !0 with check_object_signatu=
re()
      object-file API: split up and simplify check_object_signature()
      object API: rename hash_object_file_literally() to write_*()
      object-file API: have hash_object_file() take "enum object_type"
      object-file.c: add a literal version of write_object_file_prepare()
      object-file API: pass an enum to read_object_with_reference()
      test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
      test-lib: correct and assert TEST_DIRECTORY overriding
      test-lib: make $GIT_BUILD_DIR an absolute path
      test-lib: add "fast_unwind_on_malloc=3D0" to LSAN_OPTIONS
      scalar Makefile: use "The default target of..." pattern
      Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
      Makefile: disable GNU make built-in wildcard rules
      Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
      Makefile: move ".SUFFIXES" rule to shared.mak
      Makefile: move $(comma), $(empty) and $(space) to shared.mak
      Makefile: add "$(QUIET)" boilerplate to shared.mak
      Makefiles: add and use wildcard "mkdir -p" template
      log tests: fix "abort tests early" regression in ff37a60c369
      index-pack: fix memory leaks
      merge-base: free() allocated "struct commit **" list
      diff.c: free "buf" in diff_words_flush()
      urlmatch.c: add and use a *_release() function
      remote-curl.c: free memory in cmd_main()
      bundle: call strvec_clear() on allocated strvec
      transport: stop needlessly copying bundle header references
      submodule--helper: fix trivial leak in module_add()
      commit-graph: fix memory leak in misused string_list API
      commit-graph: stop fill_oids_from_packs() progress on error and fre=
e()
      lockfile API users: simplify and don't leak "path"
      range-diff: plug memory leak in common invocation
      range-diff: plug memory leak in read_patches()
      repository.c: free the "path cache" in repo_clear()
      submodule tests: test for init and update failure output
      submodule--helper: don't use bitfield indirection for parse_options=
()
      gettext API users: don't explicitly cast ngettext()'s "n"
      string-list API: change "nr" and "alloc" to "size_t"
      merge: don't run post-hook logic on --no-verify
      hooks: fix an obscure TOCTOU "did we just run a hook?" race
      tests: change some 'test $(git) =3D "x"' to test_cmp
      tests: use "test_stdout_line_count", not "test $(git [...] | wc -l)=
"
      read-tree tests: check "diff-files" exit code on failure
      diff tests: don't ignore "git diff" exit code
      diff tests: don't ignore "git diff" exit code in "read" loop
      apply tests: use "test_must_fail" instead of ad-hoc pattern
      merge tests: use "test_must_fail" instead of ad-hoc pattern
      rev-parse tests: don't ignore "git reflog" exit code
      notes tests: don't ignore "git" exit code
      diff tests: don't ignore "git rev-list" exit code
      rev-list tests: don't hide abort() in "test_expect_failure"
      gettext tests: don't ignore "test-tool regex" exit code
      apply tests: don't ignore "git ls-files" exit code, drop sub-shell
      checkout tests: don't ignore "git <cmd>" exit code
      rev-list simplify tests: don't ignore "git" exit code
      list-objects: handle NULL function pointers
      reflog: don't be noisy on empty reflogs
      builtin/submodule--helper.c: rename option struct to "opt"
      test-lib-functions: add and use a "test_hook" wrapper
      hook tests: turn exit code assertions into a loop
      http tests: don't rely on "hook/post-update.sample"
      tests: assume the hooks are disabled by default
      bugreport tests: tighten up "git bugreport -s hooks" test
      fetch+push tests: use "test_hook" and "test_when_finished" pattern
      gc + p4 tests: use "test_hook", remove sub-shells
      tests: change "cat && chmod +x" to use "test_hook"
      tests: change "mkdir -p && write_script" to use "test_hook"
      tests: use "test_hook" for misc "mkdir -p" and "chmod" cases
      diff.c: fix a double-free regression in a18d66cefb
      refs: use designated initializers for "struct ref_storage_be"
      refs: use designated initializers for "struct ref_iterator_vtable"
      misc *.c: use designated initializers for struct assignments
      packed-backend: remove stub BUG(...) functions
      refs debug: add a wrapper for "read_symbolic_ref"
      tests: extend "test_hook" for "rm" and "chmod -x", convert "$HOOK"
      proc-receive hook tests: use "test_hook" instead of "write_script"
      http tests: use "test_hook" for "smart" and "dumb" http tests
      reflog.c: indent argument lists
      reflog: refactor cmd_reflog() to "if" branches
      reflog tests: add missing "git reflog exists" tests
      reflog: move "usage" variables and use macros
      git reflog [expire|delete]: make -h output consistent with SYNOPSIS
      reflog exists: use parse_options() API
      Makefile: use ' ', not non-existing $(wspfx_SQ)
      ls-tree tests: add tests for --name-status
      ls-tree: remove commented-out code
      ls-tree: add missing braces to "else" arms
      ls-tree: use "enum object_type", not {blob,tree,commit}_type
      ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
      ls-tree: introduce struct "show_tree_data"
      ls-tree: introduce "--format" option
      ls-tree: detect and error on --name-only --name-status
      ls-tree: split up "fast path" callbacks
      hooks: fix "invoked hook" regression in a8cc5943338
      reflog: convert to parse_options() API
      reflog [show]: display sensible -h output
      test-lib: have --immediate emit valid TAP on failure
      pack-objects: lazily set up "struct rev_info", don't leak
      reftable: make assignments portable to AIX xlc v12.01
      Documentation/Makefile: fix "make info" regression in dad9cd7d518
      Documentation: add --batch-command to cat-file synopsis
      ls-tree doc: document interaction with submodules



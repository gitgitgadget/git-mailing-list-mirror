Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C268EC47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F5D60C40
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFFMmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:42:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53531 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhFFMmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 08:42:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78B1CC5E83;
        Sun,  6 Jun 2021 08:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=lzqQz+JqgjS5l7fvG2TyleXT8
        WHaVE6zHz8NVuDMBVc=; b=YzLb377NBmcghSfKfQ0t9bDwDYDzgFjz3rTvA6LGx
        h3PMuybmquWzff4RM5QPeXACP8ZxlXxpttcWWkoACQdCtLwa8v/NSJBrrteaxtSO
        AzyJmLW80UMSY1W8qH/sKFu/x3JXuKQ5FXDKeWnAtgbxwEK0O2Uef7VxSZTWcrlH
        Oo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F7BDC5E81;
        Sun,  6 Jun 2021 08:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B544FC5E7C;
        Sun,  6 Jun 2021 08:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.32.0
Date:   Sun, 06 Jun 2021 21:40:25 +0900
Message-ID: <xmqqa6o3xj2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5DFB6CD0-C6C4-11EB-8C8D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.32.0 is now available at the
usual places.  It is comprised of 617 non-merge commits since
v2.31.0, contributed by 100 people, 35 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.32.0'
tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.31.0 are as
follows.  Welcome to the Git development community!

  Adam Sharafeddine, Alexey Roslyakov, Andrey Bienkowski,
  Atharva Raykar, Bruno Albuquerque, Chinmoy Chakraborty,
  Christopher Schenk, Dan Moseley, David Emett, Dmitry Torilov,
  Fabien Terrani, Firmin Martin, Georgios Kontaxis, Jason Gore,
  Jerry Zhang, Joachim Kuebart, Joseph Vusich, Josh Soref,
  Julien Richard, Li Linchao, Louis Sautier, Luke Shumaker,
  Matheus Tavares Bernardino, Nicholas Clark, Peter Oliver,
  Renato Botelho, rlespinasse, Robert Foss, RyotaK, Sardorbek
  Imomaliev, Tom Saeger, Vincent Tam, Will Chandler, Wolfgang
  M=C3=BCller, and Yiyuan guo.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alexander Shopo=
v,
  Alex Henrie, Andrzej Hunt, Bagas Sanjaya, Ben Humphreys, brian
  m. carlson, Charvi Mendiratta, Christian Couder, Christopher Diaz
  Riveros, Daniel Santos, David Aguilar, Dennis Ameling, Denton
  Liu, Derrick Stolee, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh, Elijah=
 Newren,
  Emir Sar=C4=B1, Eric Sunshine, Eric Wong, Han-Wen Nienhuys, Han Xin,
  Jean-No=C3=ABl Avila, Jeff Hostetler, Jeff King, Jiang Xin, Johannes
  Schindelin, Johannes Sixt, John Szakmeister, Jonathan Nieder,
  Jonathan Tan, Jordi Mas, Junio C Hamano, Kyle Meyer, L=C3=A9na=C3=AFc
  Huard, Luke Diamand, Marc Branchaud, Martin =C3=85gren, Matheus
  Tavares, Matthias R=C3=BCster, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y, Nipunn
  Koorapati, =C3=98ystein Walle, Patrick Steinhardt, Peter Krefting,
  Phillip Wood, Rafael Silva, Ralf Thielow, Ramkumar Ramachandra,
  Ramsay Jones, Randall S. Becker, Ren=C3=A9 Scharfe, Sergey Organov,
  Shubham Verma, Son Luong Ngoc, SZEDER G=C3=A1bor, Taylor Blau,
  Todd Zullinger, Torsten B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=
=C3=A2n,
  Trygve Aaberge, Ville Skytt=C3=A4, Yi-Jyun Pan, and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git 2.32 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

 * ".gitattributes", ".gitignore", and ".mailmap" files that are
   symbolic links are ignored.

 * "git apply --3way" used to first attempt a straight application,
   and only fell back to the 3-way merge algorithm when the stright
   application failed.  Starting with this version, the command will
   first try the 3-way merge algorithm and only when it fails (either
   resulting with conflict or the base versions of blobs are missing),
   falls back to the usual patch application.


Updates since v2.31
-------------------

UI, Workflows & Features

 * It does not make sense to make ".gitattributes", ".gitignore" and
   ".mailmap" symlinks, as they are supposed to be usable from the
   object store (think: bare repositories where HEAD:.mailmap etc. are
   used).  When these files are symbolic links, we used to read the
   contents of the files pointed by them by mistake, which has been
   corrected.

 * "git stash show" learned to optionally show untracked part of the
   stash.

 * "git log --format=3D'...'" learned "%(describe)" placeholder.

 * "git repack" so far has been only capable of repacking everything
   under the sun into a single pack (or split by size).  A cleverer
   strategy to reduce the cost of repacking a repository has been
   introduced.

 * The http codepath learned to let the credential layer to cache the
   password used to unlock a certificate that has successfully been
   used.

 * "git commit --fixup=3D<commit>", which was to tweak the changes made
   to the contents while keeping the original log message intact,
   learned "--fixup=3D(amend|reword):<commit>", that can be used to
   tweak both the message and the contents, and only the message,
   respectively.

 * "git send-email" learned to honor the core.hooksPath configuration.

 * "git format-patch -v<n>" learned to allow a reroll count that is
   not an integer.

 * "git commit" learned "--trailer <key>[=3D<value>]" option; together
   with the interpret-trailers command, this will make it easier to
   support custom trailers.

 * "git clone --reject-shallow" option fails the clone as soon as we
   notice that we are cloning from a shallow repository.

 * A configuration variable has been added to force tips of certain
   refs to be given a reachability bitmap.

 * "gitweb" learned "e-mail privacy" feature to redact strings that
   look like e-mail addresses on various pages.

 * "git apply --3way" has always been "to fall back to 3-way merge
   only when straight application fails". Swap the order of falling
   back so that 3-way is always attempted first (only when the option
   is given, of course) and then straight patch application is used as
   a fallback when it fails.

 * "git apply" now takes "--3way" and "--cached" at the same time, and
   work and record results only in the index.

 * The command line completion (in contrib/) has learned that
   CHERRY_PICK_HEAD is a possible pseudo-ref.

 * Userdiff patterns for "Scheme" has been added.

 * "git log" learned "--diff-merges=3D<style>" option, with an
   associated configuration variable log.diffMerges.

 * "git log --format=3D..." placeholders learned %ah/%ch placeholders to
   request the --date=3Dhuman output.

 * Replace GIT_CONFIG_NOSYSTEM mechanism to decline from reading the
   system-wide configuration file with GIT_CONFIG_SYSTEM that lets
   users specify from which file to read the system-wide configuration
   (setting it to an empty file would essentially be the same as
   setting NOSYSTEM), and introduce GIT_CONFIG_GLOBAL to override the
   per-user configuration in $HOME/.gitconfig.

 * "git add" and "git rm" learned not to touch those paths that are
   outside of sparse checkout.

 * "git rev-list" learns the "--filter=3Dobject:type=3D<type>" option,
   which can be used to exclude objects of the given kind from the
   packfile generated by pack-objects.

 * The command line completion (in contrib/) for "git stash" has been
   updated.

 * "git subtree" updates.

 * It is now documented that "format-patch" skips merges.

 * Options to "git pack-objects" that take numeric values like
   --window and --depth should not accept negative values; the input
   validation has been tightened.

 * The way the command line specified by the trailer.<token>.command
   configuration variable receives the end-user supplied value was
   both error prone and misleading.  An alternative to achieve the
   same goal in a safer and more intuitive way has been added, as
   the trailer.<token>.cmd configuration variable, to replace it.

 * "git add -i --dry-run" does not dry-run, which was surprising.  The
   combination of options has taught to error out.

 * "git push" learns to discover common ancestor with the receiving
   end over protocol v2.  This will hopefully make "git push" as
   efficient as "git fetch" in avoiding objects from getting
   transferred unnecessarily.

 * "git mailinfo" (hence "git am") learned the "--quoted-cr" option to
   control how lines ending with CRLF wrapped in base64 or qp are
   handled.


Performance, Internal Implementation, Development Support etc.

 * Rename detection rework continues.

 * GIT_TEST_FAIL_PREREQS is a mechanism to skip test pieces with
   prerequisites to catch broken tests that depend on the side effects
   of optional pieces, but did not work at all when negative
   prerequisites were involved.
   (merge 27d578d904 jk/fail-prereq-testfix later to maint).

 * "git diff-index" codepath has been taught to trust fsmonitor status
   to reduce number of lstat() calls.
   (merge 7e5aa13d2c nk/diff-index-fsmonitor later to maint).

 * Reorganize Makefile to allow building git.o and other essential
   objects without extra stuff needed only for testing.

 * Preparatory API changes for parallel checkout.

 * A simple IPC interface gets introduced to build services like
   fsmonitor on top.

 * Fsck API clean-up.

 * SECURITY.md that is facing individual contributors and end users
   has been introduced.  Also a procedure to follow when preparing
   embargoed releases has been spelled out.
   (merge 09420b7648 js/security-md later to maint).

 * Optimize "rev-list --use-bitmap-index --objects" corner case that
   uses negative tags as the stopping points.

 * CMake update for vsbuild.

 * An on-disk reverse-index to map the in-pack location of an object
   back to its object name across multiple packfiles is introduced.

 * Generate [ec]tags under $(QUIET_GEN).

 * Clean-up codepaths that implements "git send-email --validate"
   option and improves the message from it.

 * The last remnant of gettext-poison has been removed.

 * The test framework has been taught to optionally turn the default
   merge strategy to "ort" throughout the system where we use
   three-way merges internally, like cherry-pick, rebase etc.,
   primarily to enhance its test coverage (the strategy has been
   available as an explicit "-s ort" choice).

 * A bit of code clean-up and a lot of test clean-up around userdiff
   area.

 * Handling of "promisor packs" that allows certain objects to be
   missing and lazily retrievable has been optimized (a bit).

 * When packet_write() fails, we gave an extra error message
   unnecessarily, which has been corrected.

 * The checkout machinery has been taught to perform the actual
   write-out of the files in parallel when able.

 * Show errno in the trace output in the error codepath that calls
   read_raw_ref method.

 * Effort to make the command line completion (in contrib/) safe with
   "set -u" continues.

 * Tweak a few tests for "log --format=3D..." that show timestamps in
   various formats.

 * The reflog expiry machinery has been taught to emit trace events.

 * Over-the-wire protocol learns a new request type to ask for object
   sizes given a list of object names.


Fixes since v2.31
-----------------

 * The fsmonitor interface read from its input without making sure
   there is something to read from.  This bug is new in 2.31
   timeframe.

 * The data structure used by fsmonitor interface was not properly
   duplicated during an in-core merge, leading to use-after-free etc.

 * "git bisect" reimplemented more in C during 2.30 timeframe did not
   take an annotated tag as a good/bad endpoint well.  This regression
   has been corrected.

 * Fix macros that can silently inject unintended null-statements.

 * CALLOC_ARRAY() macro replaces many uses of xcalloc().

 * Update insn in Makefile comments to run fuzz-all target.

 * Fix a corner case bug in "git mv" on case insensitive systems,
   which was introduced in 2.29 timeframe.

 * We had a code to diagnose and die cleanly when a required
   clean/smudge filter is missing, but an assert before that
   unnecessarily fired, hiding the end-user facing die() message.
   (merge 6fab35f748 mt/cleanly-die-upon-missing-required-filter later to=
 maint).

 * Update C code that sets a few configuration variables when a remote
   is configured so that it spells configuration variable names in the
   canonical camelCase.
   (merge 0f1da600e6 ab/remote-write-config-in-camel-case later to maint)=
.

 * A new configuration variable has been introduced to allow choosing
   which version of the generation number gets used in the
   commit-graph file.
   (merge 702110aac6 ds/commit-graph-generation-config later to maint).

 * Perf test update to work better in secondary worktrees.
   (merge 36e834abc1 jk/perf-in-worktrees later to maint).

 * Updates to memory allocation code around the use of pcre2 library.
   (merge c1760352e0 ab/grep-pcre2-allocfix later to maint).

 * "git -c core.bare=3Dfalse clone --bare ..." would have segfaulted,
   which has been corrected.
   (merge 75555676ad bc/clone-bare-with-conflicting-config later to maint=
).

 * When "git checkout" removes a path that does not exist in the
   commit it is checking out, it wasn't careful enough not to follow
   symbolic links, which has been corrected.
   (merge fab78a0c3d mt/checkout-remove-nofollow later to maint).

 * A few option description strings started with capital letters,
   which were corrected.
   (merge 5ee90326dc cc/downcase-opt-help later to maint).

 * Plug or annotate remaining leaks that trigger while running the
   very basic set of tests.
   (merge 68ffe095a2 ah/plugleaks later to maint).

 * The hashwrite() API uses a buffering mechanism to avoid calling
   write(2) too frequently. This logic has been refactored to be
   easier to understand.
   (merge ddaf1f62e3 ds/clarify-hashwrite later to maint).

 * "git cherry-pick/revert" with or without "--[no-]edit" did not spawn
   the editor as expected (e.g. "revert --no-edit" after a conflict
   still asked to edit the message), which has been corrected.
   (merge 39edfd5cbc en/sequencer-edit-upon-conflict-fix later to maint).

 * "git daemon" has been tightened against systems that take backslash
   as directory separator.
   (merge 9a7f1ce8b7 rs/daemon-sanitize-dir-sep later to maint).

 * A NULL-dereference bug has been corrected in an error codepath in
   "git for-each-ref", "git branch --list" etc.
   (merge c685450880 jk/ref-filter-segfault-fix later to maint).

 * Streamline the codepath to fix the UTF-8 encoding issues in the
   argv[] and the prefix on macOS.
   (merge c7d0e61016 tb/precompose-prefix-simplify later to maint).

 * The command-line completion script (in contrib/) had a couple of
   references that would have given a warning under the "-u" (nounset)
   option.
   (merge c5c0548d79 vs/completion-with-set-u later to maint).

 * When "git pack-objects" makes a literal copy of a part of existing
   packfile using the reachability bitmaps, its update to the progress
   meter was broken.
   (merge 8e118e8490 jk/pack-objects-bitmap-progress-fix later to maint).

 * The dependencies for config-list.h and command-list.h were broken
   when the former was split out of the latter, which has been
   corrected.
   (merge 56550ea718 sg/bugreport-fixes later to maint).

 * "git push --quiet --set-upstream" was not quiet when setting the
   upstream branch configuration, which has been corrected.
   (merge f3cce896a8 ow/push-quiet-set-upstream later to maint).

 * The prefetch task in "git maintenance" assumed that "git fetch"
   from any remote would fetch all its local branches, which would
   fetch too much if the user is interested in only a subset of
   branches there.
   (merge 32f67888d8 ds/maintenance-prefetch-fix later to maint).

 * Clarify that pathnames recorded in Git trees are most often (but
   not necessarily) encoded in UTF-8.
   (merge 9364bf465d ab/pathname-encoding-doc later to maint).

 * "git --config-env var=3Dval cmd" weren't accepted (only
   --config-env=3Dvar=3Dval was).
   (merge c331551ccf ps/config-env-option-with-separate-value later to ma=
int).

 * When the reachability bitmap is in effect, the "do not lose
   recently created objects and those that are reachable from them"
   safety to protect us from races were disabled by mistake, which has
   been corrected.
   (merge 2ba582ba4c jk/prune-with-bitmap-fix later to maint).

 * Cygwin pathname handling fix.
   (merge bccc37fdc7 ad/cygwin-no-backslashes-in-paths later to maint).

 * "git rebase --[no-]reschedule-failed-exec" did not work well with
   its configuration variable, which has been corrected.
   (merge e5b32bffd1 ab/rebase-no-reschedule-failed-exec later to maint).

 * Portability fix for command line completion script (in contrib/).
   (merge f2acf763e2 si/zsh-complete-comment-fix later to maint).

 * "git repack -A -d" in a partial clone unnecessarily loosened
   objects in promisor pack.

 * "git bisect skip" when custom words are used for new/old did not
   work, which has been corrected.

 * A few variants of informational message "Already up-to-date" has
   been rephrased.
   (merge ad9322da03 js/merge-already-up-to-date-message-reword later to =
maint).

 * "git submodule update --quiet" did not propagate the quiet option
   down to underlying "git fetch", which has been corrected.
   (merge 62af4bdd42 nc/submodule-update-quiet later to maint).

 * Document that our test can use "local" keyword.
   (merge a84fd3bcc6 jc/test-allows-local later to maint).

 * The word-diff mode has been taught to work better with a word
   regexp that can match an empty string.
   (merge 0324e8fc6b pw/word-diff-zero-width-matches later to maint).

 * "git p4" learned to find branch points more efficiently.
   (merge 6b79818bfb jk/p4-locate-branch-point-optim later to maint).

 * When "git update-ref -d" removes a ref that is packed, it left
   empty directories under $GIT_DIR/refs/ for
   (merge 5f03e5126d wc/packed-ref-removal-cleanup later to maint).

 * "git clean" and "git ls-files -i" had confusion around working on
   or showing ignored paths inside an ignored directory, which has
   been corrected.
   (merge b548f0f156 en/dir-traversal later to maint).

 * The handling of "%(push)" formatting element of "for-each-ref" and
   friends was broken when the same codepath started handling
   "%(push:<what>)", which has been corrected.
   (merge 1e1c4c5eac zh/ref-filter-push-remote-fix later to maint).

 * The bash prompt script (in contrib/) did not work under "set -u".
   (merge 5c0cbdb107 en/prompt-under-set-u later to maint).

 * The "chainlint" feature in the test framework is a handy way to
   catch common mistakes in writing new tests, but tends to get
   expensive.  An knob to selectively disable it has been introduced
   to help running tests that the developer has not modified.
   (merge 2d86a96220 jk/test-chainlint-softer later to maint).

 * The "rev-parse" command did not diagnose the lack of argument to
   "--path-format" option, which was introduced in v2.31 era, which
   has been corrected.
   (merge 99fc555188 wm/rev-parse-path-format-wo-arg later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge f451960708 dl/cat-file-doc-cleanup later to maint).
   (merge 12604a8d0c sv/t9801-test-path-is-file-cleanup later to maint).
   (merge ea7e63921c jr/doc-ignore-typofix later to maint).
   (merge 23c781f173 ps/update-ref-trans-hook-doc later to maint).
   (merge 42efa1231a jk/filter-branch-sha256 later to maint).
   (merge 4c8e3dca6e tb/push-simple-uses-branch-merge-config later to mai=
nt).
   (merge 6534d436a2 bs/asciidoctor-installation-hints later to maint).
   (merge 47957485b3 ab/read-tree later to maint).
   (merge 2be927f3d1 ab/diff-no-index-tests later to maint).
   (merge 76593c09bb ab/detox-gettext-tests later to maint).
   (merge 28e29ee38b jc/doc-format-patch-clarify later to maint).
   (merge fc12b6fdde fm/user-manual-use-preface later to maint).
   (merge dba94e3a85 cc/test-helper-bloom-usage-fix later to maint).
   (merge 61a7660516 hn/reftable-tables-doc-update later to maint).
   (merge 81ed96a9b2 jt/fetch-pack-request-fix later to maint).
   (merge 151b6c2dd7 jc/doc-do-not-capitalize-clarification later to main=
t).
   (merge 9160068ac6 js/access-nul-emulation-on-windows later to maint).
   (merge 7a14acdbe6 po/diff-patch-doc later to maint).
   (merge f91371b948 pw/patience-diff-clean-up later to maint).
   (merge 3a7f0908b6 mt/clean-clean later to maint).
   (merge d4e2d15a8b ab/streaming-simplify later to maint).
   (merge 0e59f7ad67 ah/merge-ort-i18n later to maint).
   (merge e6f68f62e0 ls/typofix later to maint).

----------------------------------------------------------------

Changes since v2.31.0 are as follows:

Adam Dinwoodie (1):
      cygwin: disallow backslashes in file names

Alex Henrie (2):
      merge-ort: split "distinct types" message into two translatable mes=
sages
      l10n: Update Catalan translation

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5204t)

Alexey Roslyakov (1):
      l10n: ru.po: fix typo in Russian translation

Andrey Bienkowski (1):
      doc: clarify the filename encoding in git diff

Andrzej Hunt (24):
      Makefile: update 'make fuzz-all' docs to reflect modern clang
      symbolic-ref: don't leak shortened refname in check_symref()
      reset: free instead of leaking unneeded ref
      clone: free or UNLEAK further pointers when finished
      worktree: fix leak in dwim_branch()
      init: remove git_init_db_config() while fixing leaks
      init-db: silence template_dir leak when converting to absolute path
      fsmonitor: avoid global-buffer-overflow READ when checking trivial =
response
      parse-options: convert bitfield values to use binary shift
      parse-options: don't leak alias help messages
      transport: also free remote_refs in transport_disconnect()
      merge-ort: only do pointer arithmetic for non-empty lists
      revision: free remainder of old commit list in limit_list
      wt-status: fix multiple small leaks
      ls-files: free max_prefix when done
      bloom: clear each bloom_key after use
      branch: FREE_AND_NULL instead of NULL'ing real_ref
      builtin/bugreport: don't leak prefixed filename
      builtin/check-ignore: clear_pathspec before returning
      builtin/checkout: clear pending objects after diffing
      mailinfo: also free strbuf lists when clearing mailinfo
      builtin/for-each-ref: free filter and UNLEAK sorting.
      builtin/rebase: release git_format_patch_opt too
      builtin/rm: avoid leaking pathspec and seen

Atharva Raykar (1):
      userdiff: add support for Scheme

Bagas Sanjaya (6):
      INSTALL: note on using Asciidoctor to build doc
      l10n: id: po-id for 2.32.0 (round 1)
      l10n: README: document git-po-helper
      l10n: README: document "core translation"
      l10n: README: document l10n conventions
      l10n: README: note on fuzzy translations

Bruno Albuquerque (1):
      object-info: support for retrieving object info

Charvi Mendiratta (23):
      sequencer: pass todo_item to do_pick_commit()
      sequencer: use const variable for commit message comments
      rebase -i: add fixup [-C | -c] command
      t3437: test script for fixup [-C|-c] options in interactive rebase
      rebase -i: teach --autosquash to work with amend!
      doc/git-rebase: add documentation for fixup [-C|-c] options
      sequencer: fixup the datatype of the 'flag' argument
      sequencer: rename a few functions
      rebase -i: clarify and fix 'fixup -c' rebase-todo help
      t/lib-rebase: update the documentation of FAKE_LINES
      t/t3437: fixup here-docs in the 'setup' test
      t/t3437: remove the dependency of 'expected-message' file from test=
s
      t/t3437: check the author date of fixed up commit
      t/t3437: simplify and document the test helpers
      t/t3437: use named commits in the tests
      t/t3437: fixup the test 'multiple fixup -c opens editor once'
      doc/rebase -i: fix typo in the documentation of 'fixup' command
      sequencer: export and rename subject_length()
      commit: add amend suboption to --fixup to create amend! commit
      commit: add a reword suboption to --fixup
      t7500: add tests for --fixup=3D[amend|reword] options
      t3437: use --fixup with options to create amend! commit
      doc/git-commit: add documentation for fixup=3D[amend|reword] option=
s

Chinmoy Chakraborty (1):
      column, range-diff: downcase option description

Christian Couder (1):
      test-bloom: fix missing 'bloom' from usage string

Christopher Diaz Riveros (1):
      l10n: es: 2.32.0 round 1

Christopher Schenk (1):
      remote-curl: fall back to basic auth if Negotiate fails

Daniel Santos (2):
      l10n: pt_PT: add Portuguese translations part 2
      l10n: pt_PT: add Portuguese translations part 3

David Aguilar (1):
      contrib/completion: fix zsh completion regression from 59d85a2a05

Dennis Ameling (2):
      cmake(install): fix double .exe suffixes
      cmake(install): include vcpkg dlls

Denton Liu (14):
      git-cat-file.txt: monospace args, placeholders and filenames
      git-cat-file.txt: remove references to "sha1"
      stash show: teach --include-untracked and --only-untracked
      stash show: learn stash.showIncludeUntracked
      git-completion.bash: pass $__git_subcommand_idx from __git_main()
      git-completion.bash: extract from else in _git_stash()
      git-completion.bash: use __gitcomp_builtin() in _git_stash()
      git-completion.bash: separate some commands onto their own line
      git-completion.bash: rename to $__git_cmd_idx
      git-completion.bash: use $__git_cmd_idx in more places
      git-completion.bash: consolidate cases in _git_stash()
      t3905: correct test title
      stash show: fix segfault with --{include,only}-untracked
      stash show: use stash.showIncludeUntracked even when diff options g=
iven

Derrick Stolee (58):
      commit-graph: create local repository pointer
      commit-graph: use config to specify generation type
      csum-file: make hashwrite() more readable
      sparse-index: design doc and format update
      t/perf: add performance test for sparse operations
      t1092: clean up script quoting
      sparse-index: add guard to ensure full index
      sparse-index: implement ensure_full_index()
      t1092: compare sparse-checkout to sparse-index
      test-read-cache: print cache entries with --table
      test-tool: don't force full index
      unpack-trees: ensure full index
      sparse-checkout: hold pattern list in index
      sparse-index: add 'sdir' index extension
      sparse-index: convert from full to sparse
      submodule: sparse-index should not collapse links
      unpack-trees: allow sparse directories
      sparse-index: check index conversion happens
      sparse-index: add index.sparse config option
      sparse-checkout: toggle sparse index from builtin
      sparse-checkout: disable sparse-index
      cache-tree: integrate with sparse directory entries
      sparse-index: loose integration with cache_tree_verify()
      p2000: add sparse-index repos
      maintenance: simplify prefetch logic
      sparse-index: API protection strategy
      *: remove 'const' qualifier for struct index_state
      read-cache: expand on query into sparse-directory entry
      cache: move ensure_full_index() to cache.h
      add: ensure full index
      checkout-index: ensure full index
      checkout: ensure full index
      commit: ensure full index
      difftool: ensure full index
      fsck: ensure full index
      grep: ensure full index
      ls-files: ensure full index
      merge-index: ensure full index
      rm: ensure full index
      stash: ensure full index
      update-index: ensure full index
      dir: ensure full index
      entry: ensure full index
      merge-recursive: ensure full index
      pathspec: ensure full index
      read-cache: ensure full index
      resolve-undo: ensure full index
      revision: ensure full index
      name-hash: don't add directories to name_hash
      sparse-index: expand_to_path()
      name-hash: use expand_to_path()
      fetch: add --prefetch option
      maintenance: use 'git fetch --prefetch'
      maintenance: respect remote.*.skipFetchAll
      dir: update stale description of treat_directory()
      sparse-index: fix uninitialized jump
      t1092: use GIT_PROGRESS_DELAY for consistent results
      dir: update stale description of treat_directory()

Elijah Newren (50):
      diffcore-rename: use directory rename guided basename comparisons
      diffcore-rename: provide basic implementation of idx_possible_renam=
e()
      diffcore-rename: add a mapping of destination names to their indice=
s
      Move computation of dir_rename_count from merge-ort to diffcore-ren=
ame
      diffcore-rename: add function for clearing dir_rename_count
      diffcore-rename: move dir_rename_counts into dir_rename_info struct
      diffcore-rename: extend cleanup_dir_rename_info()
      diffcore-rename: compute dir_rename_counts in stages
      diffcore-rename: limit dir_rename_counts computation to relevant di=
rs
      diffcore-rename: compute dir_rename_guess from dir_rename_counts
      diffcore-rename: enable filtering possible rename sources
      merge-ort: precompute subset of sources for which we need rename de=
tection
      merge-ort: add data structures for an alternate tree traversal
      merge-ort: introduce wrappers for alternate tree traversal
      merge-ort: precompute whether directory rename detection is needed
      merge-ort: use relevant_sources to filter possible rename sources
      merge-ort: skip rename detection entirely if possible
      diffcore-rename: avoid doing basename comparisons for irrelevant so=
urces
      diffcore-rename: take advantage of "majority rules" to skip more re=
names
      merge-ort, diffcore-rename: tweak dirs_removed and relevant_source =
type
      merge-ort: record the reason that we want a rename for a directory
      diffcore-rename: only compute dir_rename_count for relevant directo=
ries
      diffcore-rename: check if we have enough renames for directories ea=
rly on
      diffcore-rename: add computation of number of unknown renames
      merge-ort: record the reason that we want a rename for a file
      diffcore-rename: determine which relevant_sources are no longer rel=
evant
      merge-ort: use STABLE_QSORT instead of QSORT where required
      merge-ort: add a special minimal index just for renormalization
      merge-ort: have ll_merge() use a special attr_index for renormaliza=
tion
      merge-ort: let renormalization change modify/delete into clean dele=
te
      merge-ort: support subtree shifting
      t6428: new test for SKIP_WORKTREE handling and conflicts
      merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entr=
ies
      t: mark several submodule merging tests as fixed under merge-ort
      merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
      merge-recursive: add a bunch of FIXME comments documenting known bu=
gs
      Revert "merge-ort: ignore the directory rename split conflict for n=
ow"
      t6423: mark remaining expected failure under merge-ort as such
      Add testing with merge-ort merge strategy
      sequencer: fix edit handling for cherry-pick and revert messages
      dir: convert trace calls to trace2 equivalents
      dir: report number of visited directories and paths with trace2
      ls-files: error out on -i unless -o or -c are specified
      t7300: add testcase showing unnecessary traversal into ignored dire=
ctory
      t3001, t7300: add testcase showcasing missed directory traversal
      dir: avoid unnecessary traversal into ignored directory
      dir: traverse into untracked directories if they may have ignored s=
ubfiles
      dir: introduce readdir_skip_dot_and_dotdot() helper
      git-prompt: work under set -u
      dir: introduce readdir_skip_dot_and_dotdot() helper

Emir Sar=C4=B1 (1):
      l10n: tr: v2.32.0-r1

Eric Sunshine (1):
      merge(s): apply consistent punctuation to "up to date" messages

Eric Wong (1):
      remote-curl: fix clone on sha256 repos

Firmin Martin (1):
      user-manual.txt: assign preface an id and a title

Georgios Kontaxis (1):
      gitweb: add "e-mail privacy" feature to redact e-mail addresses

Han Xin (1):
      pack-objects: fix comment of reused_chunk.difference

Han-Wen Nienhuys (3):
      reftable: document an alternate cleanup method on Windows
      refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
      refs/debug: trace into reflog expiry too

Jean-No=C3=ABl Avila (1):
      l10n: fr: v2.32.0 round 1

Jeff Hostetler (14):
      pkt-line: eliminate the need for static buffer in packet_write_gent=
ly()
      simple-ipc: design documentation for new IPC mechanism
      simple-ipc: add win32 implementation
      unix-socket: eliminate static unix_stream_socket() helper function
      unix-socket: add backlog size option to unix_stream_listen()
      unix-socket: disallow chdir() when creating unix domain sockets
      unix-stream-server: create unix domain socket under lock
      convert: make convert_attrs() and convert structs public
      convert: add [async_]convert_to_working_tree_ca() variants
      convert: add get_stream_filter_ca() variant
      convert: add classification for conv_attrs struct
      simple-ipc: add Unix domain socket implementation
      t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
      simple-ipc: correct ifdefs when NO_PTHREADS is defined

Jeff King (43):
      add open_nofollow() helper
      attr: convert "macro_ok" into a flags field
      exclude: add flags parameter to add_patterns()
      attr: do not respect symlinks for in-tree .gitattributes
      exclude: do not respect symlinks for in-tree .gitignore
      mailmap: do not respect symlinks for in-tree .mailmap
      p5303: add missing &&-chains
      p5303: measure time to repack with keep
      builtin/pack-objects.c: rewrite honor-pack-keep logic
      packfile: add kept-pack cache for find_kept_pack_entry()
      t/perf: handle worktrees as test repos
      t/perf: avoid copying worktree files from test repo
      t7003: test ref rewriting explicitly
      filter-branch: drop multiple-ancestor warning
      filter-branch: drop $_x40 glob
      bisect: peel annotated tags to commits
      t: annotate !PTHREADS tests with !FAIL_PREREQS
      ref-filter: fix NULL check for parse object failure
      midx.c: improve cache locality in midx_pack_order_cmp()
      pack-objects: update "nr_seen" progress based on pack-reused count
      is_promisor_object(): free tree buffer after parsing
      lookup_unknown_object(): take a repository argument
      revision: avoid parsing with --exclude-promisor-objects
      pack-bitmap: clean up include_check after use
      prune: save reachable-from-recent objects with bitmaps
      t5300: modernize basic tests
      t5300: check that we produced expected number of deltas
      pack-objects: clamp negative window size to 0
      t5316: check behavior of pack-objects --depth=3D0
      pack-objects: clamp negative depth to 0
      docs/format-patch: mention handling of merges
      t7415: remove out-dated comment about translation
      fsck_tree(): fix shadowed variable
      fsck_tree(): wrap some long lines
      t7415: rename to expand scope
      t7450: test verify_path() handling of gitmodules
      t7450: test .gitmodules symlink matching against obscured names
      t0060: test ntfs/hfs-obscured dotfiles
      fsck: warn about symlinked dotfiles we'll open with O_NOFOLLOW
      docs: document symlink restrictions for dot-files
      t: avoid sed-based chain-linting in some expensive cases
      t5551: test http interaction with credential helpers
      Revert "remote-curl: fall back to basic auth if Negotiate fails"

Jerry Zhang (3):
      git-apply: try threeway first when "--3way" is used
      git-apply: allow simultaneous --cached and --3way options
      apply: adjust messages to account for --3way changes

Jiang Xin (4):
      l10n: git.pot: v2.32.0 round 1 (126 new, 26 removed)
      l10n: fix typos in po/TEAMS
      l10n: README: add file extention ".md"
      l10n: zh_CN: for git v2.32.0 l10n round 1

Joachim Kuebart (2):
      git-p4: ensure complex branches are cloned correctly
      git-p4: speed up search for branch parent

Johannes Schindelin (10):
      pkt-line: do not issue flush packets in write_packetized_*()
      pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
      pkt-line: add options argument to read_packetized_to_strbuf()
      fsmonitor: fix memory corruption in some corner cases
      fsmonitor: do not forget to release the token in `discard_index()`
      SECURITY: describe how to report vulnerabilities
      Document how we do embargoed releases
      cmake: support SKIP_DASHED_BUILT_INS
      cmake: add a preparatory work-around to accommodate `vcpkg`
      msvc: avoid calling `access("NUL", flags)`

Johannes Sixt (1):
      t9001-send-email.sh: fix expected absolute paths on Windows

John Szakmeister (2):
      http: store credential when PKI auth is used
      http: drop the check for an empty proxy password before approving

Jonathan Tan (8):
      t5606: run clone branch name test with protocol v2
      fetch-pack: buffer object-format with other args
      fetch-pack: refactor process_acks()
      fetch-pack: refactor add_haves()
      fetch-pack: refactor command and capability write
      fetch: teach independent negotiation (no packfile)
      send-pack: support push negotiation
      t5601: mark protocol v2-only test

Jordi Mas (1):
      l10n: Update Catalan translation

Josh Soref (1):
      merge: fix swapped "up to date" message components

Julien Richard (1):
      doc: .gitignore documentation typofix

Junio C Hamano (34):
      builtin/repack.c: reword comment around pack-objects flags
      xcalloc: use CALLOC_ARRAY() when applicable
      cocci: allow xcalloc(1, size)
      The first batch in 2.32 cycle
      The second batch
      format-patch: give an overview of what a "patch" message is
      The third patch
      Git 2.31.1
      The fourth batch
      The fifth batch
      The sixth batch
      The seventh batch
      The eighth batch
      The ninth batch
      doc: clarify "do not capitalize the first word" rule
      The tenth batch
      The eleventh (aka "ort") batch
      The twelfth batch
      The thirteenth batch
      CodingGuidelines: explicitly allow "local" for test scripts
      The fourteenth batch
      The fifteenth batch
      The sixteenth batch
      The seventeenth batch
      Git 2.32-rc0
      A handful more topics before -rc1
      Git 2.32-rc1
      t1092: revert the "-1" hack for emulating "no progress meter"
      Revert "dir: introduce readdir_skip_dot_and_dotdot() helper"
      Revert "dir: update stale description of treat_directory()"
      Git 2.32-rc2
      Git 2.32-rc3
      fsync(): be prepared to see EINTR
      Git 2.32

Kyle Meyer (1):
      config.txt: add missing period

Li Linchao (1):
      builtin/clone.c: add --reject-shallow option

Louis Sautier (1):
      pretty: fix a typo in the documentation for %(trailers)

Luke Shumaker (30):
      .gitignore: ignore 'git-subtree' as a build artifact
      subtree: t7900: update for having the default branch name be 'main'
      subtree: t7900: use test-lib.sh's test_count
      subtree: t7900: use consistent formatting
      subtree: t7900: comment subtree_test_create_repo
      subtree: t7900: use 'test' for string equality
      subtree: t7900: delete some dead code
      subtree: t7900: fix 'verify one file change per commit'
      subtree: t7900: rename last_commit_message to last_commit_subject
      subtree: t7900: add a test for the -h flag
      subtree: t7900: add porcelain tests for 'pull' and 'push'
      subtree: don't have loose code outside of a function
      subtree: more consistent error propagation
      subtree: drop support for git < 1.7
      subtree: use `git merge-base --is-ancestor`
      subtree: use git-sh-setup's `say`
      subtree: use more explicit variable names for cmdline args
      subtree: use "$*" instead of "$@" as appropriate
      subtree: don't fuss with PATH
      subtree: use "^{commit}" instead of "^0"
      subtree: parse revs in individual cmd_ functions
      subtree: remove duplicate check
      subtree: add comments and sanity checks
      subtree: don't let debug and progress output clash
      subtree: have $indent actually affect indentation
      subtree: give the docs a once-over
      subtree: allow --squash to be used with --rejoin
      subtree: allow 'split' flags to be passed to 'push'
      subtree: push: allow specifying a local rev other than HEAD
      subtree: be stricter about validating flags

L=C3=A9na=C3=AFc Huard (1):
      maintenance: fix two memory leaks

Martin =C3=85gren (2):
      git-repack.txt: remove spurious ")"
      pretty-formats.txt: add missing space

Matheus Tavares (32):
      convert: fail gracefully upon missing clean cmd on required filter
      symlinks: update comment on threaded_check_leading_path()
      checkout: don't follow symlinks when removing entries
      entry: extract a header file for entry.c functions
      entry: make fstat_output() and read_blob_entry() public
      entry: extract update_ce_after_write() from write_entry()
      entry: move conv_attrs lookup up to checkout_entry()
      entry: add checkout_entry_ca() taking preloaded conv_attrs
      add: include magic part of pathspec on --refresh error
      t3705: add tests for `git add` in sparse checkouts
      add: make --chmod and --renormalize honor sparse checkouts
      pathspec: allow to ignore SKIP_WORKTREE entries on index matching
      refresh_index(): add flag to ignore SKIP_WORKTREE entries
      add: warn when asked to update SKIP_WORKTREE entries
      rm: honor sparse checkout patterns
      pkt-line: do not report packet write errors twice
      unpack-trees: add basic support for parallel checkout
      parallel-checkout: make it truly parallel
      parallel-checkout: add configuration options
      parallel-checkout: support progress displaying
      parallel-checkout: add design documentation
      make_transient_cache_entry(): optionally alloc from mem_pool
      builtin/checkout.c: complete parallel checkout support
      parallel-checkout: add tests related to path collisions
      t0028: extract encoding helpers to lib-encoding.sh
      checkout-index: add parallel checkout support
      parallel-checkout: add tests related to .gitattributes
      parallel-checkout: add tests for basic operations
      ci: run test round with parallel-checkout enabled
      clean: remove unnecessary variable
      init: fix bug regarding ~/ expansion in init.templateDir
      t2080: fix cp invocation to copy symlinks instead of following them

Matthias R=C3=BCster (1):
      l10n: de.po: Update German translation for Git v2.32.0

Nicholas Clark (1):
      submodule update: silence underlying fetch with "--quiet"

Nipunn Koorapati (3):
      fsmonitor: skip lstat deletion check during git diff-index
      fsmonitor: add assertion that fsmonitor is valid to check_removed
      fsmonitor: add perf test for git diff HEAD

Patrick Steinhardt (17):
      githooks.txt: replace mentions of SHA-1 specific properties
      githooks.txt: clarify documentation on reference-transaction hook
      pack-bitmap: avoid traversal of objects referenced by uninteresting=
 tag
      uploadpack.txt: document implication of `uploadpackfilter.allow`
      revision: mark commit parents as NOT_USER_GIVEN
      list-objects: move tag processing into its own function
      list-objects: support filtering by tag and commit
      list-objects: implement object type filter
      pack-bitmap: implement object type filter
      pack-bitmap: implement combined filter
      rev-list: allow filtering of provided items
      config: rename `git_etc_config()`
      config: unify code paths to get global config paths
      config: allow overriding of global and system configuration
      t1300: fix unset of GIT_CONFIG_NOSYSTEM leaking into subsequent tes=
ts
      git.txt: fix synopsis of `--config-env` missing the equals sign
      git: support separate arg for `--config-env`'s value

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5204t0f0u)

Peter Oliver (1):
      doc: point to diff attribute in patch format docs

Phillip Wood (6):
      rebase -i: only write fixup-message when it's needed
      sequencer: factor out code to append squash message
      rebase -i: comment out squash!/fixup! subjects from squash message
      word diff: handle zero length matches
      patience diff: remove unnecessary string comparisons
      patience diff: remove unused variable

Rafael Silva (1):
      repack: avoid loosening promisor objects in partial clones

Ramkumar Ramachandra (1):
      Add entry for Ramkumar Ramachandra

Ramsay Jones (1):
      bisect--helper: use BISECT_TERMS in 'bisect skip' command

Ren=C3=A9 Scharfe (13):
      pretty: add %(describe)
      pretty: add merge and exclude options to %(describe)
      t4205: assert %(describe) test coverage
      pretty: document multiple %(describe) being inconsistent
      fix xcalloc() argument order
      archive: expand only a single %(describe) per archive
      git-compat-util.h: drop trailing semicolon from macro definition
      use CALLOC_ARRAY
      vcs-svn: remove header files as well
      block-sha1: drop trailing semicolon from macro definition
      mem-pool: drop trailing semicolon from macro definition
      daemon: sanitize all directory separators
      parallel-checkout: avoid dash local bug in tests

Robert Foss (1):
      git-send-email: Respect core.hooksPath setting

SZEDER G=C3=A1bor (1):
      Makefile: add missing dependencies of 'config-list.h'

Sardorbek Imomaliev (1):
      work around zsh comment in __git_complete_worktree_paths

Sergey Organov (5):
      diff-merges: introduce --diff-merges=3Don
      diff-merges: refactor set_diff_merges()
      diff-merges: adapt -m to enable default diff format
      diff-merges: introduce log.diffMerges config variable
      doc/diff-options: document new --diff-merges features

Shubham Verma (1):
      t9801: replace test -f with test_path_is_file

Taylor Blau (28):
      packfile: introduce 'find_kept_pack_entry()'
      revision: learn '--no-kept-objects'
      builtin/pack-objects.c: add '--stdin-packs' option
      builtin/repack.c: add '--geometric' option
      builtin/repack.c: do not repack single packs with --geometric
      t7703: test --geometric repack with loose objects
      builtin/repack.c: assign pack split later
      builtin/repack.c: be more conservative with unsigned overflows
      Documentation/git-push.txt: correct configuration typo
      builtin/pack-objects.c: ignore missing links with --stdin-packs
      builtin/multi-pack-index.c: inline 'flags' with options
      builtin/multi-pack-index.c: don't handle 'progress' separately
      builtin/multi-pack-index.c: define common usage with a macro
      builtin/multi-pack-index.c: split sub-commands
      builtin/multi-pack-index.c: don't enter bogus cmd_mode
      builtin/multi-pack-index.c: display usage on unrecognized command
      t/helper/test-read-midx.c: add '--show-objects'
      pack-bitmap: add 'test_bitmap_commits()' helper
      t/helper/test-bitmap.c: initial commit
      builtin/pack-objects.c: respect 'pack.preferBitmapTips'
      midx: allow marking a pack as preferred
      midx: don't free midx_name early
      midx: keep track of the checksum
      midx: make some functions non-static
      Documentation/technical: describe multi-pack reverse indexes
      pack-revindex: read multi-pack reverse indexes
      pack-write.c: extract 'write_rev_file_order'
      pack-revindex: write multi-pack reverse indexes

Todd Zullinger (1):
      t7500: remove non-existant C_LOCALE_OUTPUT prereq

Torsten B=C3=B6gershausen (3):
      git mv foo FOO ; git mv foo bar gave an assert
      precompose_utf8: make precompose_string_if_needed() public
      macOS: precompose startup_info->prefix

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po(5204t): Updated Vietnamese translation for v2.32.0

Ville Skytt=C3=A4 (2):
      completion: audit and guard $GIT_* against unset use
      completion: avoid aliased command lookup error in nounset mode

Vincent Tam (1):
      l10n: fr.po fixed inconsistencies

Will Chandler (1):
      refs: cleanup directories when deleting packed ref

Wolfgang M=C3=BCller (1):
      rev-parse: fix segfault with missing --path-format argument

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.32.0 round 1 (11 untranslated)
      l10n: zh_TW.po: localized

ZheNing Hu (8):
      commit: add --trailer option
      format-patch: allow a non-integral version numbers
      ref-filter: get rid of show_ref_array_item
      ref-filter: reuse output buffer
      pretty: provide human date format
      docs: correct descript of trailer.<token>.command
      trailer: add new .cmd config option
      ref-filter: fix read invalid union member bug

brian m. carlson (14):
      builtin/init-db: handle bare clones when core.bare set to false
      hash: add an algo member to struct object_id
      Always use oidread to read into struct object_id
      http-push: set algorithm when reading object ID
      hash: add a function to finalize object IDs
      Use the final_oid_fn to finalize hashing of object IDs
      builtin/pack-redundant: avoid casting buffers to struct object_id
      hash: set, copy, and use algo field in struct object_id
      hash: provide per-algorithm null OIDs
      builtin/show-index: set the algorithm for object IDs
      commit-graph: don't store file hashes as struct object_id
      builtin/pack-objects: avoid using struct object_id for pack hash
      hex: default to the_hash_algo on zero algorithm value
      hex: print objects using the hash algorithm member

rlespinasse (1):
      l10n: fr: fixed inconsistencies

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (97):
      grep/pcre2: drop needless assignment + assert() on opt->pcre2
      grep/pcre2: drop needless assignment to NULL
      grep/pcre2: correct reference to grep_init() in comment
      grep/pcre2: prepare to add debugging to pcre2_malloc()
      grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
      grep/pcre2: use compile-time PCREv2 version test
      grep/pcre2: use pcre2_maketables_free() function
      grep/pcre2: actually make pcre2 use custom allocator
      grep/pcre2: move back to thread-only PCREv2 structures
      grep/pcre2: move definitions of pcre2_{malloc,free}
      Makefile: guard against TEST_OBJS in the environment
      Makefile: split up long OBJECTS line
      Makefile: sort OBJECTS assignment for subsequent change
      Makefile: split OBJECTS into OBJECTS and GIT_OBJS
      Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
      remote: add camel-cased *.tagOpt key, like clone
      remote: write camel-cased *.pushRemote on rename
      fsck.c: refactor and rename common config callback
      show tests: add test for "git show <tree>"
      ls-files tests: add meaningful --with-tree tests
      tree.c API: move read_tree() into builtin/ls-files.c
      ls-files: don't needlessly pass around stage variable
      ls-files: refactor away read_tree()
      archive: stop passing "stage" through read_tree_recursive()
      tree.h API: expose read_tree_1() as read_tree_at()
      tree.h API: simplify read_tree_recursive() signature
      diff --no-index tests: add test for --exit-code
      diff --no-index tests: test mode normalization
      rebase: remove transitory rebase.useBuiltin setting & env
      mktag tests: fix broken "&&" chain
      fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
      fsck.h: use "enum object_type" instead of "int"
      fsck.c: rename variables in fsck_set_msg_type() for less confusion
      fsck.c: remove (mostly) redundant append_msg_id() function
      fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
      fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
      fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
      fsck.h: re-order and re-assign "enum fsck_msg_type"
      fsck.c: call parse_msg_type() early in fsck_set_msg_type()
      fsck.c: undefine temporary STR macro after use
      fsck.c: give "FOREACH_MSG_ID" a more specific name
      fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
      fsck.c: pass along the fsck_msg_id in the fsck_error callback
      fsck.c: add an fsck_set_msg_type() API that takes enums
      fsck.c: move gitmodules_{found,done} into fsck_options
      fetch-pack: don't needlessly copy fsck_options
      fetch-pack: use file-scope static struct for fsck_options
      fetch-pack: use new fsck API to printing dangling submodules
      Makefile: add QUIET_GEN to "tags" and "TAGS" targets
      git-send-email: replace "map" in void context with "for"
      git-send-email: test full --validate output
      git-send-email: refactor duplicate $? checks into a function
      git-send-email: improve --validate error output
      bash completion: complete CHERRY_PICK_HEAD
      config.c: remove last remnant of GIT_TEST_GETTEXT_POISON
      userdiff style: re-order drivers in alphabetical order
      userdiff style: declare patterns with consistent style
      userdiff style: normalize pascal regex declaration
      userdiff: add and use for_each_userdiff_driver()
      userdiff tests: explicitly test "default" pattern
      userdiff tests: list builtin drivers via test-tool
      userdiff: remove support for "broken" tests
      blame tests: don't rely on t/t4018/ directory
      blame tests: simplify userdiff driver test
      rebase tests: camel-case rebase.rescheduleFailedExec consistently
      rebase: don't override --no-reschedule-failed-exec with config
      Documentation/Makefile: make $(wildcard howto/*.txt) a var
      Documentation/Makefile: make doc.dep dependencies a variable again
      doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
      doc lint: fix bugs in, simplify and improve lint script
      doc lint: lint and fix missing "GIT" end sections
      doc lint: lint relative section order
      docs: fix linting issues due to incorrect relative section order
      svn tests: remove legacy re-setup from init-clone test
      svn tests: refactor away a "set -e" in test body
      tests: remove all uses of test_i18cmp
      usage.c: don't copy/paste the same comment three times
      api docs: document BUG() in api-error-handling.txt
      api docs: document that BUG() emits a trace2 error event
      pretty tests: simplify %aI/%cI date format test
      pretty tests: give --date/format tests a better description
      sparse-index.c: remove set_index_sparse_config()
      streaming.c: avoid forward declarations
      streaming.c: remove enum/function/vtbl indirection
      streaming.c: remove {open,close,read}_method_decl() macros
      streaming.c: stop passing around "object_info *" to open()
      streaming.c: move {open,close,read} from vtable to "struct git_istr=
eam"
      Makefile: don't re-define PERL_DEFINES
      Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
      Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
      perl: use mock i18n functions under NO_GETTEXT=3DY
      Makefile: make PERL_DEFINES recursively expanded
      send-email: fix missing error message regression
      send-email: don't needlessly abs_path() the core.hooksPath
      send-email: move "hooks_path" invocation to git-send-email.perl
      pack-objects: move static inline from a header to the sole consumer
      builtin/fsck.c: don't conflate "int" and "enum" in callback

=C3=98ystein Walle (2):
      transport: respect verbosity when setting upstream
      add: die if both --dry-run and --interactive are given

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (6):
      mailinfo: load default metainfo_charset lazily
      mailinfo: stop parsing options manually
      mailinfo: warn if CRLF found in decoded base64/QP email
      mailinfo: allow squelching quoted CRLF warning
      mailinfo: allow stripping quoted CR without warning
      am: learn to process quoted lines that ends with CRLF


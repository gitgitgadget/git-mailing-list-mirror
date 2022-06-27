Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42AFC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbiF0SW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbiF0SWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:22:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1386F12D2E
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:22:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76524120E28;
        Mon, 27 Jun 2022 14:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=GI+Jc8jRJOpZ1CdTdQLvJpaXH
        W/cxpBMieWcncv7LQk=; b=OeqVRlsOZcb7q/VS3Eotly4nRaUkw0oRmlC5vSPkq
        h0pneyMyi4FyHDtigVr7Lue0HUZ5rlkQr4/11tsu6TwHIlcpwmhnUTVIA+2P8zpa
        15JZou//GjYfsz5OO+T0u1mSEVMuz87eAscjqHr2SIOZ+y+smy1hwnR6U07enD2n
        Ik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BD0D120E27;
        Mon, 27 Jun 2022 14:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88035120E24;
        Mon, 27 Jun 2022 14:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.37.0
Date:   Mon, 27 Jun 2022 11:22:07 -0700
Message-ID: <xmqqy1xinf00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0EA9B74C-F646-11EC-92C6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.37.0 is now available at the
usual places.  It is comprised of 395 non-merge commits since
v2.36.0, contributed by 75 people, 20 of which are new faces [*].
As this cycle was shorter than usual, it is a smaller release than
usual, but the size of tarballs are about the same ;-).

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.37.0'
tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.36.0 are as follows.
Welcome to the Git development community!

  Arthur Milchior, Chris Down, Daniel Li, Fernando Ramos, Frantisek
  Hrbata, Garrit Franke, Gregory David, Guy Maurel, halilsen,
  Huang Zou, "Ing. Martin Prantl Ph.D.", Joakim Petersen, Kevin
  Locke, Khalid Masum, Kirill Frolov, Kleber Tarc=C3=ADsio, Laurent
  Lyaudet, Siddharth Asthana, Thomas Hurst, and Yuyi Wang.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Abhradeep Chakraborty, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alexande=
r
  Shopov, Alex Henrie, Anthony Sottile, Bagas Sanjaya, BRESSAT
  Jonathan, Carlo Arenas, Carlo Marcelo Arenas Bel=C3=B3n, Christian
  Couder, COGONI Guillaume, Derrick Stolee, Dimitriy Ryazantcev,
  Edmundo Carmona Antoranz, Elia Pinto, Elijah Newren, Emir SARI,
  Eric Sunshine, Fabian Stelzer, Fangyi Zhou, Glen Choo, Jason
  Yundt, Jean-No=C3=ABl Avila, Jeff Hostetler, Jeff King, Jiang Xin,
  Joel Holdsworth, Johannes Schindelin, Jonathan Tan, Jordi Mas,
  Josh Steadmon, Junio C Hamano, Matthew John Cheetham, Matthias
  A=C3=9Fhauer, Matthias R=C3=BCster, Matthieu Moy, Michael J Gruber,
  Miklos Vajna, Neeraj Singh, Orgad Shaneh, Peter Krefting,
  Philip Oakley, Philippe Blain, Phillip Wood, Ralf Thielow,
  Randall S. Becker, Ren=C3=A9 Scharfe, Son Luong Ngoc, SZEDER G=C3=A1bor=
,
  Tao Klerks, Taylor Blau, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, Victoria =
Dye,
  Yi-Jyun Pan, and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.37 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

UI, Workflows & Features

 * "vimdiff[123]" mergetool drivers have been reimplemented with a
   more generic layout mechanism.

 * "git -v" and "git -h" are now understood as "git --version" and
   "git --help".

 * The temporary files fed to external diff command are now generated
   inside a new temporary directory under the same basename.

 * "git log --since=3DX" will stop traversal upon seeing a commit that
   is older than X, but there may be commits behind it that is younger
   than X when the commit was created with a faulty clock.  A new
   option is added to keep digging without stopping, and instead
   filter out commits with timestamp older than X.

 * "git -c branch.autosetupmerge=3Dsimple branch $A $B" will set the $B
   as $A's upstream only when $A and $B shares the same name, and "git
   -c push.default=3Dsimple" on branch $A would push to update the
   branch $A at the remote $B came from.  Also more places use the
   sole remote, if exists, before defaulting to 'origin'.

 * A new doc has been added that lists tips for tools to work with
   Git's codebase.

 * "git remote -v" now shows the list-objects-filter used during
   fetching from the remote, if available.

 * With the new http.curloptResolve configuration, the CURLOPT_RESOLVE
   mechanism that allows cURL based applications to use pre-resolved
   IP addresses for the requests is exposed to the scripts.

 * "git add -i" was rewritten in C some time ago and has been in
   testing; the reimplementation is now exposed to general public by
   default.

 * Deprecate non-cone mode of the sparse-checkout feature.

 * Introduce a filesystem-dependent mechanism to optimize the way the
   bits for many loose object files are ensured to hit the disk
   platter.

 * The "do not remove the directory the user started Git in" logic,
   when Git cannot tell where that directory is, is disabled.  Earlier
   we refused to run in such a case.

 * A mechanism to pack unreachable objects into a "cruft pack",
   instead of ejecting them into loose form to be reclaimed later, has
   been introduced.

 * Update the doctype written in gitweb output to xhtml5.

 * The "transfer.credentialsInURL" configuration variable controls what
   happens when a URL with embedded login credential is used on either
   "fetch" or "push". Credentials are currently only detected in
   `remote.<name>.url` config, not `remote.<name>.pushurl`.

 * "git revert" learns "--reference" option to use more human-readable
   reference to the commit it reverts in the message template it
   prepares for the user.

 * Various error messages that talk about the removal of
   "--preserve-merges" in "rebase" have been strengthened, and "rebase
   --abort" learned to get out of a state that was left by an earlier
   use of the option.


Performance, Internal Implementation, Development Support etc.

 * The performance of the "untracked cache" feature has been improved
   when "--untracked-files=3D<mode>" and "status.showUntrackedFiles"
   are combined.

 * "git stash" works better with sparse index entries.

 * "git show :<path>" learned to work better with the sparse-index
   feature.

 * Introduce and apply coccinelle rule to discourage an explicit
   comparison between a pointer and NULL, and applies the clean-up to
   the maintenance track.

 * Preliminary code refactoring around transport and bundle code.

 * "sparse-checkout" learns to work better with the sparse-index
   feature.

 * A workflow change for translators are being proposed.  git.pot is
   no longer version controlled and it is local responsibility of
   translators to generate it.

 * Plug the memory leaks from the trickiest API of all, the revision
   walker.

 * Rename .env_array member to .env in the child_process structure.

  * The fsmonitor--daemon handles even more corner cases when
    watching filesystem events.

 * A new bug() and BUG_if_bug() API is introduced to make it easier to
   uniformly log "detect multiple bugs and abort in the end" pattern.


Fixes since v2.36
-----------------

 * "git submodule update" without pathspec should silently skip an
   uninitialized submodule, but it started to become noisy by mistake.
   (merge 4f1ccef87c gc/submodule-update-part2 later to maint).

 * "diff-tree --stdin" has been broken for about a year, but 2.36
   release broke it even worse by breaking running the command with
   <pathspec>, which in turn broke "gitk" and got noticed.  This has
   been corrected by aligning its behaviour to that of "log".
   (merge f8781bfda3 jc/diff-tree-stdin-fix later to maint).

 * Regression fix for 2.36 where "git name-rev" started to sometimes
   reference strings after they are freed.
   (merge 45a14f578e rs/name-rev-fix-free-after-use later to maint).

 * "git show <commit1> <commit2>... -- <pathspec>" lost the pathspec
   when showing the second and subsequent commits, which has been
   corrected.
   (merge 5cdb38458e jc/show-pathspec-fix later to maint).

 * "git fast-export -- <pathspec>" lost the pathspec when showing the
   second and subsequent commits, which has been corrected.
   (merge d1c25272f5 rs/fast-export-pathspec-fix later to maint).

 * "git format-patch <args> -- <pathspec>" lost the pathspec when
   showing the second and subsequent commits, which has been
   corrected.
   (merge 91f8f7e46f rs/format-patch-pathspec-fix later to maint).

 * "git clone --origin X" leaked piece of memory that held value read
   from the clone.defaultRemoteName configuration variable, which has
   been plugged.
   (merge 6dfadc8981 jc/clone-remote-name-leak-fix later to maint).

 * Get rid of a bogus and over-eager coccinelle rule.
   (merge 08bdd3a185 jc/cocci-xstrdup-or-null-fix later to maint).

 * The path taken by "git multi-pack-index" command from the end user
   was compared with path internally prepared by the tool without first
   normalizing, which lead to duplicated paths not being noticed,
   which has been corrected.
   (merge 11f9e8de3d ds/midx-normalize-pathname-before-comparison later t=
o maint).

 * Correct choices of C compilers used in various CI jobs.
   (merge 3506cae04f ab/cc-package-fixes later to maint).

 * Various cleanups to "git p4".
   (merge 4ff0108d9e jh/p4-various-fixups later to maint).

 * The progress meter of "git blame" was showing incorrect numbers
   when processing only parts of the file.
   (merge e5f5d7d42e ea/progress-partial-blame later to maint).

 * "git rebase --keep-base <upstream> <branch-to-rebase>" computed the
   commit to rebase onto incorrectly, which has been corrected.
   (merge 9e5ebe9668 ah/rebase-keep-base-fix later to maint).

 * Fix a leak of FILE * in an error codepath.
   (merge c0befa0c03 kt/commit-graph-plug-fp-leak-on-error later to maint=
).

 * Avoid problems from interaction between malloc_check and address
   sanitizer.
   (merge 067109a5e7 pw/test-malloc-with-sanitize-address later to maint)=
.

 * The commit summary shown after making a commit is matched to what
   is given in "git status" not to use the break-rewrite heuristics.
   (merge 84792322ed rs/commit-summary-wo-break-rewrite later to maint).

 * Update a few end-user facing messages around EOL conversion.
   (merge c970d30c2c ah/convert-warning-message later to maint).

 * Trace2 documentation updates.
   (merge a6c80c313c js/trace2-doc-fixes later to maint).

 * Build procedure fixup.
   (merge 1fbfd96f50 mg/detect-compiler-in-c-locale later to maint).

 * "git pull" without "--recurse-submodules=3D<arg>" made
   submodule.recurse take precedence over fetch.recurseSubmodules by
   mistake, which has been corrected.
   (merge 5819417365 gc/pull-recurse-submodules later to maint).

 * "git bisect" was too silent before it is ready to start computing
   the actual bisection, which has been corrected.
   (merge f11046e6de cd/bisect-messages-from-pre-flight-states later to m=
aint).

 * macOS CI jobs have been occasionally flaky due to tentative version
   skew between perforce and the homebrew packager.  Instead of
   failing the whole CI job, just let it skip the p4 tests when this
   happens.
   (merge f15e00b463 cb/ci-make-p4-optional later to maint).

 * A bit of test framework fixes with a few fixes to issues found by
   valgrind.
   (merge 7c898554d7 ab/valgrind-fixes later to maint).

 * "git archive --add-file=3D<path>" picked up the raw permission bits
   from the path and propagated to zip output in some cases, without
   normalization, which has been corrected (tar output did not have
   this issue).
   (merge 6a61661967 jc/archive-add-file-normalize-mode later to maint).

 * "make coverage-report" without first running "make coverage" did
   not produce any meaningful result, which has been corrected.
   (merge 96ddfecc5b ep/coverage-report-wants-test-to-have-run later to m=
aint).

 * The "--current" option of "git show-branch" should have been made
   incompatible with the "--reflog" mode, but this was not enforced,
   which has been corrected.
   (merge 41c64ae0e7 jc/show-branch-g-current later to maint).

 * "git fetch" unnecessarily failed when an unexpected optional
   section appeared in the output, which has been corrected.
   (merge 7709acf7be jt/fetch-peek-optional-section later to maint).

 * The way "git fetch" without "--update-head-ok" ensures that HEAD in
   no worktree points at any ref being updated was too wasteful, which
   has been optimized a bit.
   (merge f7400da800 os/fetch-check-not-current-branch later to maint).

 * "git fetch --recurse-submodules" from multiple remotes (either from
   a remote group, or "--all") used to make one extra "git fetch" in
   the submodules, which has been corrected.
   (merge 0353c68818 jc/avoid-redundant-submodule-fetch later to maint).

 * With a recent update to refuse access to repositories of other
   people by default, "sudo make install" and "sudo git describe"
   stopped working, which has been corrected.
   (merge 6b11e3d52e cb/path-owner-check-with-sudo-plus later to maint).

 * The tests that ensured merges stop when interfering local changes
   are present did not make sure that local changes are preserved; now
   they do.
   (merge 4b317450ce jc/t6424-failing-merge-preserve-local-changes later =
to maint).

 * Some real problems noticed by gcc 12 have been fixed, while false
   positives have been worked around.

 * Update the version of FreeBSD image used in Cirrus CI.
   (merge c58bebd4c6 pb/use-freebsd-12.3-in-cirrus-ci later to maint).

 * The multi-pack-index code did not protect the packfile it is going
   to depend on from getting removed while in use, which has been
   corrected.
   (merge 4090511e40 tb/midx-race-in-pack-objects later to maint).

 * Teach "git repack --geometric" work better with "--keep-pack" and
   avoid corrupting the repository when packsize limit is used.
   (merge 66731ff921 tb/geom-repack-with-keep-and-max later to maint).

 * The documentation on the interaction between "--add-file" and
   "--prefix" options of "git archive" has been improved.
   (merge a75910602a rs/document-archive-prefix later to maint).

 * A git subcommand like "git add -p" spawns a separate git process
   while relaying its command line arguments.  A pathspec with only
   negative elements was mistakenly passed with an empty string, which
   has been corrected.
   (merge b02fdbc80a jc/all-negative-pathspec later to maint).

 * With a more targeted workaround in http.c in another topic, we may
   be able to lift this blanket "GCC12 dangling-pointer warning is
   broken and unsalvageable" workaround.
   (merge 419141e495 cb/buggy-gcc-12-workaround later to maint).

 * A misconfigured 'branch..remote' led to a bug in configuration
   parsing.
   (merge f1dfbd9ee0 gc/zero-length-branch-config-fix later to maint).

 * "git -c diff.submodule=3Dlog range-diff" did not show anything for
   submodules that changed in the ranges being compared, and
   "git -c diff.submodule=3Ddiff range-diff" did not work correctly.
   Fix this by including the "--submodule=3Dshort" output
   unconditionally to be compared.

 * In Git 2.36 we revamped the way how hooks are invoked.  One change
   that is end-user visible is that the output of a hook is no longer
   directly connected to the standard output of "git" that spawns the
   hook, which was noticed post release.  This is getting corrected.
   (merge a082345372 ab/hooks-regression-fix later to maint).

 * Updating the graft information invalidates the list of parents of
   in-core commit objects that used to be in the graft file.

 * "git show-ref --heads" (and "--tags") still iterated over all the
   refs only to discard refs outside the specified area, which has
   been corrected.
   (merge c0c9d35e27 tb/show-ref-optim later to maint).

 * Remove redundant copying (with index v3 and older) or possible
   over-reading beyond end of mmapped memory (with index v4) has been
   corrected.
   (merge 6d858341d2 zh/read-cache-copy-name-entry-fix later to maint).

 * Sample watchman interface hook sometimes failed to produce
   correctly formatted JSON message, which has been corrected.
   (merge 134047b500 sn/fsmonitor-missing-clock later to maint).

 * Use-after-free (with another forget-to-free) fix.
   (merge 323822c72b ab/remote-free-fix later to maint).

 * Remove a coccinelle rule that is no longer relevant.
   (merge b1299de4a1 jc/cocci-cleanup later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge e6b2582da3 cm/reftable-0-length-memset later to maint).
   (merge 0b75e5bf22 ab/misc-cleanup later to maint).
   (merge 52e1ab8a76 ea/rebase-code-simplify later to maint).
   (merge 756d15923b sg/safe-directory-tests-and-docs later to maint).
   (merge d097a23bfa ds/do-not-call-bug-on-bad-refs later to maint).
   (merge c36c27e75c rs/t7812-pcre2-ws-bug-test later to maint).
   (merge 1da312742d gf/unused-includes later to maint).
   (merge 465b30a92d pb/submodule-recurse-mode-enum later to maint).
   (merge 82b28c4ed8 km/t3501-use-test-helpers later to maint).
   (merge 72315e431b sa/t1011-use-helpers later to maint).
   (merge 95b3002201 cg/vscode-with-gdb later to maint).
   (merge fbe5f6b804 tk/p4-utf8-bom later to maint).
   (merge 17f273ffba tk/p4-with-explicity-sync later to maint).
   (merge 944db25c60 kf/p4-multiple-remotes later to maint).
   (merge b014cee8de jc/update-ozlabs-url later to maint).
   (merge 4ec5008062 pb/ggg-in-mfc-doc later to maint).
   (merge af845a604d tb/receive-pack-code-cleanup later to maint).
   (merge 2acf4cf001 js/ci-gcc-12-fixes later to maint).
   (merge 05e280c0a6 jc/http-clear-finished-pointer later to maint).
   (merge 8c49d704ef fh/transport-push-leakfix later to maint).
   (merge 1d232d38bd tl/ls-tree-oid-only later to maint).
   (merge db7961e6a6 gc/document-config-worktree-scope later to maint).
   (merge ce18a30bb7 fs/ssh-default-key-command-doc later to maint).

----------------------------------------------------------------

Changes since v2.36.0 are as follows:

Abhradeep Chakraborty (1):
      builtin/remote.c: teach `-v` to list filters for promisor remotes

Alex Henrie (3):
      convert: clarify line ending conversion warning
      rebase: use correct base for --keep-base when a branch is given
      l10n: es: update translation

Alexander Shopov (2):
      name-rev: prefix annotate-stdin with '--' in message
      l10n: bg.po: Updated Bulgarian translation (5367t)

Arthur Milchior (1):
      l10n: README: fix typo

Bagas Sanjaya (1):
      l10n: po-id for 2.37 (first batch)

COGONI Guillaume (2):
      contrib/vscode/: debugging with VS Code and gdb
      Documentation/ToolsForGit.txt: Tools for developing Git

Carlo Marcelo Arenas Bel=C3=B3n (8):
      reftable: avoid undefined behaviour breaking t0032
      ci: make failure to find perforce more user friendly
      ci: avoid brew for installing perforce
      ci: reintroduce prevention from perforce being quarantined in macOS
      t: regression git needs safe.directory when using sudo
      git-compat-util: avoid failing dir ownership checks if running priv=
ileged
      t0034: add negative tests and allow git init to mostly work under s=
udo
      git-compat-util: allow root to access both SUDO_UID and root owned

Chris Down (2):
      bisect: output state before we are ready to compute bisection
      bisect: output bisect setup status in bisect log

Christian Couder (1):
      http: add custom hostname to IP address resolutions

Derrick Stolee (28):
      clone: die() instead of BUG() on bad refs
      midx: use real paths in lookup_multi_pack_index()
      multi-pack-index: use --object-dir real path
      cache: use const char * for get_object_directory()
      t1092: add compatibility tests for 'git show'
      show: integrate with the sparse index
      object-name: reject trees found in the index
      object-name: diagnose trees in index properly
      rev-parse: integrate with sparse index
      http: make http_get_file() external
      remote: move relative_url()
      remote: allow relative_url() to return an absolute url
      object-file: convert 'switch' back to 'if'
      t1092: refactor 'sparse-index contents' test
      t1092: stress test 'git sparse-checkout set'
      sparse-index: create expand_index()
      sparse-index: introduce partially-sparse indexes
      cache-tree: implement cache_tree_find_path()
      sparse-checkout: --no-sparse-index needs a full index
      sparse-index: partially expand directories
      sparse-index: complete partial expansion
      p2000: add test for 'git sparse-checkout [add|set]'
      sparse-checkout: integrate with sparse index
      remote: create fetch.credentialsInUrl config
      t2107: test 'git update-index --verbose'
      t5329: test 'git gc --cruft' without '--prune=3Dnow'
      pack-write: drop always-NULL parameter
      cache-tree: remove cache_tree_find_path()

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Edmundo Carmona Antoranz (2):
      blame: report correct number of lines in progress when using ranges
      rebase: simplify an assignment of options.type in cmd_rebase

Elia Pinto (2):
      Makefile: add a prerequisite to the coverage-report target
      contrib/coccinnelle: add equals-null.cocci

Elijah Newren (9):
      tests: stop assuming --no-cone is the default mode for sparse-check=
out
      sparse-checkout: make --cone the default
      git-sparse-checkout.txt: wording updates for the cone mode default
      git-sparse-checkout.txt: update docs for deprecation of 'init'
      git-sparse-checkout.txt: shuffle some sections and mark as internal
      git-sparse-checkout.txt: add a new EXAMPLES section
      git-sparse-checkout.txt: flesh out pattern set sections a bit
      git-sparse-checkout.txt: mark non-cone mode as deprecated
      Documentation: some sparsity wording clarifications

Emir SARI (1):
      l10n: tr: v2.37.0 round #1

Fabian Stelzer (1):
      gpg docs: explain better use of ssh.defaultKeyCommand

Fangyi Zhou (3):
      push: fix capitalisation of the option name autoSetupMerge
      builtin/rebase: remove a redundant space in l10n string
      l10n: zh_CN: v2.37.0 round 1

Fernando Ramos (4):
      vimdiff: new implementation with layout support
      vimdiff: integrate layout tests in the unit tests framework ('t' fo=
lder)
      vimdiff: add tool documentation
      mergetools: add description to all diff/merge tools

Frantisek Hrbata (3):
      transport: remove unnecessary indenting in transport_push()
      transport: unify return values and exit point from transport_push()
      transport: free local and remote refs in transport_push()

Garrit Franke (3):
      cli: add -v and -h shorthands
      serve.c: remove unnecessary include
      apply.c: remove unnecessary include

Glen Choo (4):
      pull: do not let submodule.recurse override fetch.recurseSubmodules
      remote.c: don't BUG() on 0-length branch names
      remote.c: reject 0-length branch names
      config: document and test the 'worktree' scope

Jason Yundt (1):
      gitweb: switch to an XHTML5 DOCTYPE

Jean-No=C3=ABl Avila (1):
      l10n: fr v2.37 round 1

Jeff Hostetler (30):
      fsm-listen-win32: handle shortnames
      t7527: test FSMonitor on repos with Unicode root paths
      t/helper/fsmonitor-client: create stress test
      fsmonitor-settings: bare repos are incompatible with FSMonitor
      fsmonitor-settings: stub in Win32-specific incompatibility checking
      fsmonitor-settings: VFS for Git virtual repos are incompatible
      fsmonitor-settings: stub in macOS-specific incompatibility checking
      fsmonitor-settings: remote repos on macOS are incompatible
      fsmonitor-settings: remote repos on Windows are incompatible
      fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
      unpack-trees: initialize fsmonitor_has_run_once in o->result
      fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
      fsmonitor--daemon: cd out of worktree root
      fsmonitor--daemon: prepare for adding health thread
      fsmonitor--daemon: rename listener thread related variables
      fsmonitor--daemon: stub in health thread
      fsm-health-win32: add polling framework to monitor daemon health
      fsm-health-win32: force shutdown daemon if worktree root moves
      fsm-listen-darwin: shutdown daemon if worktree root is moved/rename=
d
      fsmonitor: optimize processing of directory events
      t7527: FSMonitor tests for directory moves
      t/perf/p7527: add perf test for builtin FSMonitor
      fsmonitor: never set CE_FSMONITOR_VALID on submodules
      t7527: test FSMonitor on case insensitive+preserving file system
      fsmonitor: on macOS also emit NFC spelling for NFD pathname
      t/helper/hexdump: add helper to print hexdump of stdin
      t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
      t7527: test Unicode NFC/NFD handling on MacOS
      fsmonitor--daemon: allow --super-prefix argument
      t7527: improve implicit shutdown testing in fsmonitor--daemon

Jeff King (2):
      perf-lib: fix missing test titles in output
      bug_fl(): correctly initialize trace2 va_list

Jiang Xin (6):
      Makefile: sort source files before feeding to xgettext
      Makefile: generate "po/git.pot" from stable LOCALIZED_C
      Makefile: remove duplicate and unwanted files in FOUND_SOURCE_FILES
      po/git.pot: this is now a generated file
      Makefile: add "po-update" rule to update po/XX.po
      i18n: fix mismatched camelCase config variables

Joakim Petersen (2):
      git-prompt: make colourization consistent
      git-prompt: fix expansion of branch colour codes

Joel Holdsworth (22):
      git-p4: add blank lines between functions and class definitions
      git-p4: remove unneeded semicolons from statements
      git-p4: indent with 4-spaces
      git-p4: improve consistency of docstring formatting
      git-p4: convert descriptive class and function comments into docstr=
ings
      git-p4: remove commented code
      git-p4: sort and de-duplcate pylint disable list
      git-p4: remove padding from lists, tuples and function arguments
      git-p4: remove spaces around default arguments
      git-p4: removed brackets when assigning multiple return values
      git-p4: place a single space after every comma
      git-p4: remove extraneous spaces before function arguments
      git-p4: remove redundant backslash-continuations inside brackets
      git-p4: remove spaces between dictionary keys and colons
      git-p4: ensure every comment has a single #
      git-p4: ensure there is a single space around all operators
      git-p4: normalize indentation of lines in conditionals
      git-p4: compare to singletons with "is" and "is not"
      git-p4: only seperate code blocks by a single empty line
      git-p4: move inline comments to line above
      git-p4: seperate multiple statements onto seperate lines
      git-p4: sort imports

Johannes Schindelin (36):
      t2016: require the PERL prereq only when necessary
      add -i: default to the built-in implementation
      trace2 docs: a couple of grammar fixes
      trace2 docs: "printf" is not an English word
      trace2 docs: surround more terms in backticks
      trace2 docs: fix a JSON formatted example
      trace2 docs: clarify what `varargs` is all about
      trace2 docs: add missing full stop
      ci: fix code style
      tests: refactor --write-junit-xml code
      test(junit): avoid line feeds in XML attributes
      ci/run-build-and-tests: take a more high-level view
      ci: make it easier to find failed tests' logs in the GitHub workflo=
w
      ci/run-build-and-tests: add some structure to the GitHub workflow o=
utput
      ci: optionally mark up output in the GitHub workflow
      ci(github): skip the logs of the successful test cases
      ci: use `--github-workflow-markup` in the GitHub workflow
      ci(github): mention where the full logs can be found
      ci: call `finalize_test_case_output` a little later
      compat/win32/syslog: fix use-after-realloc
      nedmalloc: avoid new compile error
      dir.c: avoid "exceeds maximum object size" error with GCC v12.x
      archive: optionally add "virtual" files
      archive --add-virtual-file: allow paths containing colons
      scalar: validate the optional enlistment argument
      scalar: implement `scalar diagnose`
      scalar diagnose: include disk space information
      ci(github): bring back the 'print test failures' step
      ci(github): use grouping also in the `win-build` job
      ci(github): also mark up compile errors
      fsmonitor: avoid memory leak in `fsm_settings__get_incompatible_msg=
()`
      submodule-config: avoid memory leak
      submodule--helper: avoid memory leak when fetching submodules
      read_index_from(): avoid memory leak
      pack-mtimes: avoid closing a bogus file descriptor
      relative_url(): fix incorrect condition

Jonathan Tan (2):
      fetch-pack: make unexpected peek result non-fatal
      commit,shallow: unparse commits if grafts changed

Jordi Mas (1):
      l10n: Update Catalan translation

Josh Steadmon (1):
      run-command: don't spam trace2_child_exit()

Junio C Hamano (40):
      show-branch: -g and --current are incompatible
      2.36 gitk/diff-tree --stdin regression fix
      Some regression fixes for 2.36
      2.36 show regression fix
      clone: plug a miniscule leak
      cocci: drop bogus xstrdup_or_null() rule
      tree-wide: apply equals-null.cocci
      tree-wide: apply equals-null.cocci
      tree-wide: apply equals-null.cocci
      A bit more regression fixes for 2.36
      Git 2.36.1
      0th batch for topics from the previous cycle
      SubmittingPatches: use more stable git.ozlabs.org URL
      second 0th batch of topics from the previous cycle
      archive: do not let on-disk mode leak to zip archives
      commit: fix "author_ident" leak
      fetch: do not run a redundant fetch from submodule
      t6424: make sure a failed merge preserves local changes
      First batch for 2.37
      Second batch
      Third batch
      Fourth batch
      revert: optionally refer to commit in the "reference" format
      http.c: clear the 'finished' member once we are done with it
      pathspec: correct an empty string used as a pathspec element
      Fifth batch
      revert: --reference should apply only to 'revert', not 'cherry-pick=
'
      Sixth batch
      Revert -Wno-error=3Ddangling-pointer
      Seventh batch
      Eighth batch
      cocci: retire is_null_sha1() rule
      Prepare for 2.36.2
      Ninth batch
      Git 2.37-rc0
      Fixes and updates post -rc0
      Another batch of fixes before -rc1
      Git 2.37-rc1
      Git 2.37-rc2
      Git 2.37

Kevin Locke (1):
      setup: don't die if realpath(3) fails on getcwd(3)

Khalid Masum (1):
      t3501: remove test -f and stop ignoring git <cmd> exit code

Kirill Frolov (1):
      git-p4: fix issue with multiple perforce remotes

Kleber Tarc=C3=ADsio (1):
      commit-graph: close file before returning NULL

Matthew John Cheetham (2):
      scalar: teach `diagnose` to gather packfile info
      scalar: teach `diagnose` to gather loose objects information

Matthias R=C3=BCster (2):
      l10n: de.po: Update German translation
      l10n: TEAMS: Change German translation team leader

Michael J Gruber (1):
      detect-compiler: make detection independent of locale

Miklos Vajna (1):
      log: "--since-as-filter" option is a non-terminating "--since" vari=
ant

Neeraj Singh (12):
      bulk-checkin: rename 'state' variable and separate 'plugged' boolea=
n
      bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
      core.fsyncmethod: batched disk flushes for loose-objects
      cache-tree: use ODB transaction around writing a tree
      builtin/add: add ODB transaction around add_files_to_cache
      update-index: use the bulk-checkin infrastructure
      unpack-objects: use the bulk-checkin infrastructure
      core.fsync: use batch mode and sync loose objects by default on Win=
dows
      test-lib-functions: add parsing helpers for ls-files and ls-tree
      core.fsyncmethod: tests for batch mode
      core.fsyncmethod: performance tests for batch mode
      t/perf: add iteration setup mechanism to perf-lib

Orgad Shaneh (2):
      submodule--helper: fix initialization of warn_if_uninitialized
      fetch: limit shared symref check only for local branches

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5367t0f0u)

Philip Oakley (4):
      rebase.c: state preserve-merges has been removed
      rebase: help users when dying with `preserve-merges`
      rebase: note `preserve` merges may be a pull config option
      rebase: translate a die(preserve-merges) message

Philippe Blain (8):
      submodule.h: use a named enum for RECURSE_SUBMODULES_*
      MyFirstContribution: add "Anatomy of a Patch Series" section
      MyFirstContribution: add standalone section on cover letter
      MyFirstContribution: reference "The cover letter" in "Preparing Ema=
il"
      MyFirstContribution: reference "The cover letter" in GitGitGadget s=
ection
      MyFirstContribution: drop PR description for GGG single-patch contr=
ibutions
      ci: update Cirrus-CI image to FreeBSD 12.3
      range-diff: show submodule changes irrespective of diff.submodule

Phillip Wood (1):
      tests: make SANITIZE=3Daddress imply TEST_NO_MALLOC_CHECK

Ren=C3=A9 Scharfe (10):
      commit, sequencer: turn off break_opt for commit summary
      t7812: test PCRE2 whitespace bug
      tempfile: add mks_tempfile_dt()
      diff: use mks_tempfile_dt()
      Revert "name-rev: release unused name strings"
      2.36 format-patch regression fix
      2.36 fast-export regression fix
      archive: improve documentation of --prefix
      gc: simplify --cruft description
      revert: config documentation fixes

SZEDER G=C3=A1bor (3):
      t0033-safe-directory: check the error message without matching the =
trash dir
      t0033-safe-directory: check when 'safe.directory' is ignored
      safe.directory: document and check that it's ignored in the environ=
ment

Siddharth Asthana (1):
      t1011: replace test -f with test_path_is_file

Son Luong Ngoc (1):
      fsmonitor: query watchman with right valid json

Tao Klerks (8):
      untracked-cache: test untracked-cache-bypassing behavior with -uall
      untracked-cache: support '--untracked-files=3Dall' if configured
      git-p4: support explicit sync of arbitrary existing git-p4 refs
      git-p4: preserve utf8 BOM when importing from p4 to git
      branch: new autosetupmerge option 'simple' for matching branches
      push: default to single remote even when not named origin
      push: new config option "push.autoSetupRemote" supports "simple" pu=
sh
      git-p4: improve encoding handling to support inconsistent encodings

Taylor Blau (26):
      builtin/receive-pack.c: remove redundant 'if'
      t7703: demonstrate object corruption with pack.packSizeLimit
      builtin/repack.c: ensure that `names` is sorted
      Documentation/technical: add cruft-packs.txt
      pack-bitmap.c: check preferred pack validity when opening MIDX bitm=
ap
      builtin/pack-objects.c: avoid redundant NULL check
      builtin/pack-objects.c: ensure included `--stdin-packs` exist
      builtin/pack-objects.c: ensure pack validity from MIDX bitmap objec=
ts
      pack-mtimes: support reading .mtimes files
      pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
      chunk-format.h: extract oid_version()
      pack-mtimes: support writing pack .mtimes files
      t/helper: add 'pack-mtimes' test-tool
      builtin/pack-objects.c: return from create_object_entry()
      builtin/pack-objects.c: --cruft without expiration
      reachable: add options to add_unseen_recent_objects_to_traversal
      reachable: report precise timestamps from objects in cruft packs
      builtin/pack-objects.c: --cruft with expiration
      builtin/repack.c: support generating a cruft pack
      builtin/repack.c: allow configuring cruft pack generation
      builtin/repack.c: use named flags for existing_packs
      builtin/repack.c: add cruft packs to MIDX during geometric repack
      builtin/gc.c: conditionally avoid pruning objects via loose
      sha1-file.c: don't freshen cruft packs
      builtin/show-ref.c: avoid over-iterating with --heads, --tags
      Documentation/config/transfer.txt: fix typo

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi(5367t): Updated translation

Victoria Dye (8):
      stash: expand sparse-checkout compatibility testing
      stash: integrate with sparse index
      sparse-index: expose 'is_sparse_index_allowed()'
      read-cache: set sparsity when index is new
      stash: apply stash using 'merge_ort_nonrecursive()'
      unpack-trees: preserve index sparsity
      repack: respect --keep-pack with geometric repack
      ci(github): avoid printing test case preamble twice

Yi-Jyun Pan (1):
      l10n: zh_TW: v2.37.0 round 1

Yuyi Wang (3):
      cmake: fix CMakeLists.txt on Linux
      cmake: add pcre2 support
      cmake: remove (_)UNICODE def on Windows in CMakeLists.txt

ZheNing Hu (1):
      read-cache.c: reduce unnecessary cache entry name copying

halilsen (2):
      gitk: trivial indentation fix
      gitk: include y coord in recorded sash position

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (66):
      run-command.h: remove always unused "clean_on_exit_handler_cbdata"
      configure.ac: remove USE_PIC comment
      xdiff/xmacros.h: remove unused XDL_PTRFREE
      pack-bitmap-write: remove unused bitmap_reset() function
      object-store.h: remove unused has_sha1_file*()
      alloc.[ch]: remove alloc_report() function
      t/helper/test-fast-rebase.c: don't leak "struct strbuf"
      blame: use "goto cleanup" for cleanup_scoreboard()
      string_list API users: use string_list_init_{no,}dup
      format-patch: don't leak "extra_headers" or "ref_message_ids"
      cocci: add and apply free_commit_list() rules
      revision.[ch]: provide and start using a release_revisions()
      revisions API users: add straightforward release_revisions()
      revision.[ch]: document and move code declared around "init"
      revisions API users: use release_revisions() needing REV_INFO_INIT
      stash: always have the owner of "stash_info" free it
      revisions API users: add "goto cleanup" for release_revisions()
      revisions API users: use release_revisions() in http-push.c
      revisions API users: use release_revisions() in builtin/log.c
      revisions API users: use release_revisions() with UNLEAK()
      revisions API users: use release_revisions() for "prune_data" users
      revisions API: have release_revisions() release "commits"
      revisions API: have release_revisions() release "mailmap"
      revisions API: have release_revisions() release "cmdline"
      revisions API: have release_revisions() release "filter"
      revisions API: have release_revisions() release "grep_filter"
      revisions API: have release_revisions() release "prune_data"
      revisions API: clear "boundary_commits" in release_revisions()
      revisions API: release "reflog_info" in release revisions()
      revisions API: call diff_free(&revs->pruning) in revisions_release(=
)
      revisions API: have release_revisions() release "date_mode"
      revisions API: have release_revisions() release "topo_walk_info"
      revisions API: add a TODO for diff_free(&revs->diffopt)
      CI: select CC based on CC_PACKAGE (again)
      tests: using custom GIT_EXEC_PATH breaks --valgrind tests
      log test: skip a failing mkstemp() test under valgrind
      object-file: fix a unpack_loose_header() regression in 3b6a8db3b03
      commit-graph.c: don't assume that stat() succeeds
      ci: use https, not http to download binaries from perforce.com
      connect.c: refactor sending of agent & object-format
      dir API: add a generalized path_match_flags() function
      fetch-pack: add a deref_without_lazy_fetch_extended()
      fetch-pack: move --keep=3D* option filling to a function
      bundle.h: make "fd" version of read_bundle_header() public
      Makefile: have "make pot" not "reset --hard"
      i18n CI: stop allowing non-ASCII source messages in po/git.pot
      po/git.pot: don't check in result of "make pot"
      Makefile: add "po-init" rule to initialize po/XX.po
      l10n: Document the new l10n workflow
      common-main.c: move non-trace2 exit() behavior out of trace2.c
      usage.c: add a non-fatal bug() function to go with BUG()
      parse-options.c: use new bug() API for optbug()
      parse-options.c: use optbug() instead of BUG() "opts" check
      receive-pack: use bug() and BUG_if_bug()
      cache-tree.c: use bug() and BUG_if_bug()
      run-command API: rename "env_array" to "env"
      run-command API users: use "env" not "env_array" in comments & name=
s
      ls-tree: test for the regression in 9c4d58ff2c3
      run-command: add an "ungroup" option to run_process_parallel()
      remote.c: remove braces from one-statement "for"-loops
      remote.c: don't dereference NULL in freeing loop
      hook API: fix v2.36.0 regression: hooks should be connected to a TT=
Y
      add -i tests: mark "TODO" depending on GIT_TEST_ADD_I_USE_BUILTIN
      fetch doc: note "pushurl" caveat about "credentialsInUrl", elaborat=
e
      transfer doc: move fetch.credentialsInUrl to "transfer" config name=
space
      tests: add LIBCURL prerequisite to tests needing libcurl


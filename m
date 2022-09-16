Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D8BECAAD3
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 02:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIPChR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIPChQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 22:37:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F786D9D1
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 19:37:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BB6413021E;
        Thu, 15 Sep 2022 22:37:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=7YP/cKTknLj2nxM4ZYxWYfZmV
        D09NtZKYo1xzj9ouxo=; b=JeB0SycXSutRn2snME1TftmhOSk3Z0vH7C/38D6nN
        Y84tFfQoiqOEN38rR+mgEOXp59FiTqFmRczKyai6oH1CXlkbNvE14K3JqxG7iUXj
        nGcjV7vsKjsAQupVRtf0f3p9Zif0jb0cr5pDEzTPW4gPxElJTNT7Y7JrTTJmaxgH
        iw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0043E13021D;
        Thu, 15 Sep 2022 22:37:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29FA813021C;
        Thu, 15 Sep 2022 22:37:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git v2.38.0-rc0
Date:   Thu, 15 Sep 2022 19:37:07 -0700
Message-ID: <xmqqczbwkpt8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 760EF0E4-3568-11ED-BC02-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early preview release Git v2.38.0-rc0 is now available for
testing at the usual places.  It is comprised of 607 non-merge
commits since v2.37.0, contributed by 75 people, 21 of which are
new faces [*].

Since many contributors are travelling for Git Merge conference this
week, I do not expect a lot of activities around this one.  Just
treat it as one of the normal updates to the tip of the 'master'
branch.  The real fun will begin with -rc1, where we enter feature
freeze for the upcoming release, which is expected to happen mid
next week.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.38.0-rc0' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.37.0 are as follows.
Welcome to the Git development community!

  Andrew Olsen, Anthony Delannoy, Carlos L=C3=B3pez, Celeste Liu,
  Cleber Rosa, David Plumpton, Eric DeCosta, Goss Geppert, Ilya
  K, Ingy dot Net, Jacob Stopak, Julien Rouhaud, Kilian Kilger,
  Lana Deere, Manuel Boni, Matthew Klein, Moritz Baumann, Pavel
  Rappo, Pierre Garnier, Richard Oliver, and Xavier Morel.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Abhradeep Chakraborty, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Arthur
  Milchior, brian m. carlson, Calvin Wan, Carlo Marcelo Arenas
  Bel=C3=B3n, Christian Couder, Christoph Reiter, Derrick Stolee,
  Dimitriy Ryazantcev, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh, Elijah=
 Newren,
  Emily Shaffer, Eric Sunshine, Felipe Contreras, Fernando Ramos,
  Glen Choo, Han Xin, Hariom Verma, Jacob Keller, Jaydeep Das,
  Jeff King, Jiang Xin, Joey Hess, Johannes Schindelin, John Cai,
  Jonathan Tan, Josh Steadmon, Junio C Hamano, Justin Donnelly,
  Kyle Zhao, Lessley Dennington, Li Linchao, Linus Torvalds,
  Martin =C3=85gren, Matheus Tavares, Matthew John Cheetham, Michael
  J Gruber, =C3=98ystein Walle, Philip Oakley, Philippe Blain, Phillip
  Wood, Randall S. Becker, Renato Botelho, Ren=C3=A9 Scharfe, Shaoxuan
  Yuan, Siddharth Asthana, SZEDER G=C3=A1bor, Tao Klerks, Taylor Blau,
  Teng Long, Torsten B=C3=B6gershausen, Victoria Dye, and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.38 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

UI, Workflows & Features

 * "git remote show [-n] frotz" now pays attention to negative
   pathspec.

 * "git push" sometimes perform poorly when reachability bitmaps are
   used, even in a repository where other operations are helped by
   bitmaps.  The push.useBitmaps configuration variable is introduced
   to allow disabling use of reachability bitmaps only for "git push".

 * "git grep -m<max-hits>" is a way to limit the hits shown per file.

 * "git merge-tree" learned a new mode where it takes two commits and
   computes a tree that would result in the merge commit, if the
   histories leading to these two commits were to be merged.

 * "git mv A B" in a sparsely populated working tree can be asked to
   move a path between directories that are "in cone" (i.e. expected
   to be materialized in the working tree) and "out of cone"
   (i.e. expected to be hidden).  The handling of such cases has been
   improved.

 * Earlier, HTTP transport clients learned to tell the server side
   what locale they are in by sending Accept-Language HTTP header, but
   this was done only for some requests but not others.

 * Introduce a discovery.barerepository configuration variable that
   allows users to forbid discovery of bare repositories.

 * Various messages that come from the pack-bitmap codepaths have been
   tweaked.

 * "git rebase -i" learns to update branches whose tip appear in the
   rebased range with "--update-refs" option.

 * "git ls-files" learns the "--format" option to tweak its output.

 * "git cat-file" learned an option to use the mailmap when showing
   commit and tag objects.

 * When "git merge" finds that it cannot perform a merge, it should
   restore the working tree to the state before the command was
   initiated, but in some corner cases it didn't.

 * Operating modes like "--batch" of "git cat-file" command learned to
   take NUL-terminated input, instead of one-item-per-line.

 * "git rm" has become more aware of the sparse-index feature.

 * "git rev-list --disk-usage" learned to take an optional value
   "human" to show the reported value in human-readable format, like
   "3.40MiB".

 * The "diagnose" feature to create a zip archive for diagnostic
   material has been lifted from "scalar" and made into a feature of
   "git bugreport".

 * The namespaces used by "log --decorate" from "refs/" hierarchy by
   default has been tightened.

 * "git rev-list --ancestry-path=3DC A..B" is a natural extension of
   "git rev-list A..B"; instead of choosing a subset of A..B to those
   that have ancestry relationship with A, it lets a subset with
   ancestry relationship with C.

 * "scalar" now enables built-in fsmonitor on enlisted repositories,
   when able.

 * The bash prompt (in contrib/) learned to optionally indicate when
   the index is unmerged.

 * "git clone" command learned the "--bundle-uri" option to coordinate
   with hosting sites the use of pre-prepared bundle files.

 * "git range-diff" learned to honor pathspec argument if given.

 * "git format-patch --from=3D<ident>" can be told to add an in-body
   "From:" line even for commits that are authored by the given
   <ident> with "--force-in-body-from"option.

 * The built-in fsmonitor refuses to work on a network mounted
   repositories; a configuration knob for users to override this has
   been introduced.


Performance, Internal Implementation, Development Support etc.

 * Collection of what is referenced by objects in promisor packs have
   been optimized to inspect these objects in the in-pack order.

 * Introduce a helper to see if a branch is already being worked on
   (hence should not be newly checked out in a working tree), which
   performs much better than the existing find_shared_symref() to
   replace many uses of the latter.

 * Teach "git archive" to (optionally and then by default) avoid
   spawning an external "gzip" process when creating ".tar.gz" (and
   ".tgz") archives.

 * Allow large objects read from a packstream to be streamed into a
   loose object file straight, without having to keep it in-core as a
   whole.

 * Further preparation to turn git-submodule.sh into a builtin
   continues.

 * Apply Coccinelle rule to turn raw memmove() into MOVE_ARRAY() cpp
   macro, which would improve maintainability and readability.

 * Teach "make all" to build gitweb as well.

 * Tweak tests so that they still work when the "git init" template
   did not create .git/info directory.

 * Add Coccinelle rules to detect the pattern of initializing and then
   finalizing a structure without using it in between at all, which
   happens after code restructuring and the compilers fail to
   recognize as an unused variable.

 * The code to convert between GPG trust level strings and internal
   constants we use to represent them have been cleaned up.

 * Support for libnettle as SHA256 implementation has been added.

 * The way "git multi-pack" uses parse-options API has been improved.

 * A coccinelle rule (in contrib/) to encourage use of COPY_ARRAY
   macro has been improved.

 * API tweak to make it easier to run fuzz testing on commit-graph parser=
.

 * Omit fsync-related trace2 entries when their values are all zero.

 * The codepath to write multi-pack index has been taught to release a
   large chunk of memory that holds an array of objects in the packs,
   as soon as it is done with the array, to reduce memory consumption.

 * Add a level of redirection to array allocation API in xdiff part,
   to make it easier to share with the libgit2 project.

 * "git fetch" client logs the partial clone filter used in the trace2
   output.

 * The "bundle URI" design gets documented.

 * The common ancestor negotiation exchange during a "git fetch"
   session now leaves trace log.

 * Test portability improvements.
   (merge 4d1d843be7 mt/rot13-in-c later to maint).

 * The "subcommand" mode is introduced to parse-options API and update
   the command line parser of Git commands with subcommands.

 * The pack bitmap file gained a bitmap-lookup table to speed up
   locating the necessary bitmap for a given commit.

 * The assembly version of SHA-1 implementation for PPC has been
   removed.

 * The server side that responds to "git fetch" and "git clone"
   request has been optimized by allowing it to send objects in its
   object store without recomputing and validating the object names.

 * Annotate function parameters that are not used (but cannot be
   removed for structural reasons), to prepare us to later compile
   with -Wunused warning turned on.

 * Share the text used to explain configuration variables used by "git
   <subcmd>" in "git help <subcmd>" with the text from "git help config".


Fixes since v2.37
-----------------

 * Rewrite of "git add -i" in C that appeared in Git 2.25 didn't
   correctly record a removed file to the index, which was fixed.

 * Certain diff options are currently ignored when combined-diff is
   shown; mark them as incompatible with the feature.

 * Adjust technical/bitmap-format to be formatted by AsciiDoc, and
   add some missing information to the documentation.

 * Fixes for tests when the source directory has unusual characters in
   its path, e.g. whitespaces, double-quotes, etc.

 * "git mktree --missing" lazily fetched objects that are missing from
   the local object store, which was totally unnecessary for the purpose
   of creating the tree object(s) from its input.

 * Give _() markings to fatal/warning/usage: labels that are shown in
   front of these messages.

 * References to commands-to-be-typed-literally in "git rebase"
   documentation mark-up have been corrected.

 * In a non-bare repository, the behavior of Git when the
   core.worktree configuration variable points at a directory that has
   a repository as its subdirectory, regressed in Git 2.27 days.

 * Recent update to vimdiff layout code has been made more robust
   against different end-user vim settings.

 * Plug various memory leaks, both in the main code and in test-tool
   commands.

 * Fixes a long-standing corner case bug around directory renames in
   the merge-ort strategy.

 * The resolve-undo information in the index was not protected against
   GC, which has been corrected.

 * A corner case bug where lazily fetching objects from a promisor
   remote resulted in infinite recursion has been corrected.

 * "git clone" from a repository with some ref whose HEAD is unborn
   did not set the HEAD in the resulting repository correctly, which
   has been corrected.

 * An earlier attempt to plug leaks placed a clean-up label to jump to
   at a bogus place, which as been corrected.

 * Variable quoting fix in the vimdiff driver of "git mergetool"

 * "git shortlog -n" relied on the underlying qsort() to be stable,
   which shouldn't have.  Fixed.

 * A fix for a regression in test framework.

 * mkstemp() emulation on Windows has been improved.

 * Add missing documentation for "include" and "includeIf" features in
   "git config" file format, which incidentally teaches the command
   line completion to include them in its offerings.

 * Avoid "white/black-list" in documentation and code comments.

 * Workaround for a compiler warning against use of die() in
   osx-keychain (in contrib/).

 * Workaround for a false positive compiler warning.

 * "git p4" working on UTF-16 files on Windows did not implement
   CRLF-to-LF conversion correctly, which has been corrected.

 * "git p4" did not handle non-ASCII client name well, which has been
   corrected.

 * "rerere-train" script (in contrib/) used to honor commit.gpgSign
   while recreating the throw-away merges.

 * "git checkout" miscounted the paths it updated, which has been
   corrected.

 * Fix for a bug that makes write-tree to fail to write out a
   non-existent index as a tree, introduced in 2.37.

 * There was a bug in the codepath to upgrade generation information
   in commit-graph from v1 to v2 format, which has been corrected.

 * Gitweb had legacy URL shortener that is specific to the way
   projects hosted on kernel.org used to (but no longer) work, which
   has been removed.

 * Fix build procedure for Windows that uses CMake so that it can pick
   up the shell interpreter from local installation location.

 * Conditionally allow building Python interpreter on Windows

 * Fix to lstat() emulation on Windows.

 * Older gcc with -Wall complains about the universal zero initializer
   "struct s =3D { 0 };" idiom, which makes developers' lives
   inconvenient (as -Werror is enabled by DEVELOPER=3DYesPlease).  The
   build procedure has been tweaked to help these compilers.

 * Plug memory leaks in the failure code path in the "merge-ort" merge
   strategy backend.

 * "git symbolic-ref symref non..sen..se" is now diagnosed as an error.

 * A follow-up fix to a fix for a regression in 2.36 around hooks.

 * Avoid repeatedly running getconf to ask libc version in the test
   suite, and instead just as it once per script.

 * Platform-specific code that determines if a directory is OK to use
   as a repository has been taught to report more details, especially
   on Windows.

 * "vimdiff3" regression fix.

 * "git fsck" reads mode from tree objects but canonicalizes the mode
   before passing it to the logic to check object sanity, which has
   hid broken tree objects from the checking logic.  This has been
   corrected, but to help exiting projects with broken tree objects
   that they cannot fix retroactively, the severity of anomalies this
   code detects has been demoted to "info" for now.

 * Fixes to sparse index compatibility work for "reset" and "checkout"
   commands.

 * An earlier optimization discarded a tree-object buffer that is
   still in use, which has been corrected.
   (merge 1490d7d82d jk/is-promisor-object-keep-tree-in-use later to main=
t).

 * Fix deadlocks between main Git process and subprocess spawned via
   the pipe_command() API, that can kill "git add -p" that was
   reimplemented in C recently.
   (merge 716c1f649e jk/pipe-command-nonblock later to maint).

 * The sequencer machinery translated messages left in the reflog by
   mistake, which has been corrected.

 * xcalloc(), imitating calloc(), takes "number of elements of the
   array", and "size of a single element", in this order.  A call that
   does not follow this ordering has been corrected.
   (merge c4bbd9bb8f sg/xcalloc-cocci-fix later to maint).

 * The preload-index codepath made copies of pathspec to give to
   multiple threads, which were left leaked.
   (merge 23578904da ad/preload-plug-memleak later to maint).

 * Update the version of Ubuntu used for GitHub Actions CI from 18.04
   to 22.04.
   (merge ef46584831 ds/github-actions-use-newer-ubuntu later to maint).

 * The auto-stashed local changes created by "git merge --autostash"
   was mixed into a conflicted state left in the working tree, which
   has been corrected.
   (merge d3a9295ada en/merge-unstash-only-on-clean-merge later to maint)=
.

 * Multi-pack index got corrupted when preferred pack changed from one
   pack to another in a certain way, which has been corrected.
   (merge 99e4d084ff tb/midx-with-changing-preferred-pack-fix later to ma=
int).

 * The clean-up of temporary files created via mks_tempfile_dt() was
   racy and attempted to unlink() the leading directory when signals
   are involved, which has been corrected.
   (merge babe2e0559 rs/tempfile-cleanup-race-fix later to maint).

 * FreeBSD portability fix for "git maintenance" that spawns "crontab"
   to schedule tasks.
   (merge ee69e7884e bc/gc-crontab-fix later to maint).

 * Those who use diff-so-fancy as the diff-filter noticed a regression
   or two in the code that parses the diff output in the built-in
   version of "add -p", which has been corrected.
   (merge 0a101676e5 js/add-p-diff-parsing-fix later to maint).

 * Segfault fix-up to an earlier fix to the topic to teach "git reset"
   and "git checkout" work better in a sparse checkout.
   (merge 037f8ea6d9 vd/sparse-reset-checkout-fixes later to maint).

 * "git diff --no-index A B" managed its the pathnames of its two
   input files rather haphazardly, sometimes leaking them.  The
   command line argument processing has been straightened out to clean
   it up.
   (merge 2b43dd0eb5 rs/diff-no-index-cleanup later to maint).

 * "git rev-list --verify-objects" ought to inspect the contents of
   objects and notice corrupted ones, but it didn't when the commit
   graph is in use, which has been corrected.
   (merge b27ccae34b jk/rev-list-verify-objects-fix later to maint).

 * More fixes to "add -p"
   (merge 64ec8efb83 js/builtin-add-p-portability-fix later to maint).

 * The parser in the script interface to parse-options in "git
   rev-parse" has been updated to diagnose a bogus input correctly.
   (merge f20b9c36d0 ow/rev-parse-parseopt-fix later to maint).

 * The code that manages list-object-filter structure, used in partial
   clones, leaked the instances, which has been plugged.
   (merge 66eede4a37 jk/plug-list-object-filter-leaks later to maint).

 * Fix another UI regression in the reimplemented "add -p".
   (merge f6f0ee247f rs/add-p-worktree-mode-prompt-fix later to maint).

 * "git fetch" over protocol v2 sent an incorrect ref prefix request
   to the server and made "git pull" with configured fetch refspec
   that does not cover the remote branch to merge with fail, which has
   been corrected.
   (merge 49ca2fba39 jk/proto-v2-ref-prefix-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 77b9e85c0f vd/fix-perf-tests later to maint).
   (merge 0682bc43f5 jk/test-crontab-fixes later to maint).
   (merge b46dd1726c cc/doc-trailer-whitespace-rules later to maint).

----------------------------------------------------------------

Changes since v2.37.0 are as follows:

Abhradeep Chakraborty (9):
      bitmap-format.txt: feed the file to asciidoc to generate html
      bitmap-format.txt: fix some formatting issues
      bitmap-format.txt: add information for trailing checksum
      Documentation/technical: describe bitmap lookup table extension
      bitmap: move `get commit positions` code to `bitmap_writer_finish`
      pack-bitmap-write.c: write lookup table extension
      pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
      pack-bitmap: prepare to read lookup table extension
      bitmap-lookup-table: add performance tests for lookup table

Anthony Delannoy (1):
      preload-index: fix memleak

Calvin Wan (1):
      submodule merge: update conflict error message

Carlo Marcelo Arenas Bel=C3=B3n (2):
      setup: tighten ownership checks post CVE-2022-24765
      cmake: support local installations of git

Carlos L=C3=B3pez (1):
      grep: add --max-count command line option

Celeste Liu (1):
      contrib/rerere-train: avoid useless gpg sign in training

Christian Couder (1):
      Documentation: clarify whitespace rules for trailers

Cleber Rosa (1):
      setup: fix function name in a BUG() message

Derrick Stolee (50):
      branch: add branch_checked_out() helper
      branch: check for bisects and rebases
      fetch: use new branch_checked_out() and add tests
      branch: use branch_checked_out() when deleting refs
      branch: fix branch_checked_out() leaks
      t5510: replace 'origin' with URL more carefully
      vscode: improve tab size and wrapping
      git-rebase.txt: use back-ticks consistently
      pack-bitmap-write: use const for hashes
      midx: extract bitmap write setup
      midx: reduce memory pressure while writing bitmaps
      daemon: clarify directory arguments
      git-cvsserver: clarify directory list
      git.txt: remove redundant language
      t: avoid "whitelist"
      transport.c: avoid "whitelist"
      t2407: test bisect and rebase as black-boxes
      t2407: test branches currently using apply backend
      branch: consider refs under 'update-refs'
      rebase-interactive: update 'merge' description
      sequencer: define array with enum values
      sequencer: add update-ref command
      rebase: add --update-refs option
      rebase: update refs from 'update-ref' commands
      sequencer: rewrite update-refs as user edits todo list
      rebase: add rebase.updateRefs config option
      sequencer: ignore HEAD ref under --update-refs
      sequencer: notify user of --update-refs activity
      compat/win32: correct for incorrect compiler warning
      refs: allow "HEAD" as decoration filter
      t4207: modernize test
      t4207: test coloring of grafted decorations
      refs: add array of ref namespaces
      refs: use ref_namespaces for replace refs base
      log-tree: use ref_namespaces instead of if/else-if
      log: add default decoration filter
      log: add --clear-decorations option
      log: create log.initialDecorationSet=3Dall
      maintenance: stop writing log.excludeDecoration
      fetch: use ref_namespaces during prefetch
      docs: document bundle URI standard
      bundle-uri: add example bundle organization
      remote-curl: add 'get' capability
      bundle-uri: create basic file-copy logic
      clone: add --bundle-uri option
      bundle-uri: add support for http(s):// and file://
      clone: --bundle-uri cannot be combined with --depth
      t6019: modernize tests with helper
      clone: warn on failure to repo_init()
      ci: update 'static-analysis' to Ubuntu 22.04

Dimitriy Ryazantcev (1):
      i18n: mark message helpers prefix for translation

Elijah Newren (43):
      merge-tree: rename merge_trees() to trivial_merge_trees()
      merge-tree: move logic for existing merge into new function
      merge-tree: add option parsing and initial shell for real merge fun=
ction
      merge-tree: implement real merges
      merge-ort: split out a separate display_update_messages() function
      merge-tree: support including merge messages in output
      merge-ort: provide a merge_get_conflicted_files() helper function
      merge-ort: remove command-line-centric submodule message from merge=
-ort
      merge-tree: provide a list of which files have conflicts
      merge-tree: provide easy access to `ls-files -u` style info
      merge-ort: store more specific conflict information
      merge-ort: optionally produce machine-readable output
      merge-tree: allow `ls-files -u` style info to be NUL terminated
      merge-tree: add a --allow-unrelated-histories flag
      git-merge-tree.txt: add a section on potentional usage mistakes
      t6429: fix use of non-existent function
      t6423: add tests of dual directory rename plus add/add conflict
      merge-ort: small cleanups of check_for_directory_rename
      merge-ort: make a separate function for freeing struct collisions
      merge-ort: shuffle the computation and cleanup of potential collisi=
ons
      merge-ort: fix issue with dual rename and add/add conflict
      merge-ort-wrappers: make printed message match the one from recursi=
ve
      merge-resolve: abort if index does not match HEAD
      merge: abort if index does not match HEAD for trivial merges
      merge: do not abort early if one strategy fails to handle the merge
      merge: fix save_state() to work when there are stat-dirty files
      merge: make restore_state() restore staged state too
      merge: ensure we can actually restore pre-merge state
      merge: do not exit restore_state() prematurely
      merge-ort: remove translator lego in new "submodule conflict sugges=
tion"
      merge-ort: avoid surprise with new sub_flag variable
      merge-ort: provide helpful submodule update message when possible
      merge-ort: remove code obsoleted by other changes
      rev-list-options.txt: fix simple typo
      revision: allow --ancestry-path to take an argument
      merge: only apply autostash when appropriate
      merge: cleanup confusing logic for handling successful merges
      merge: small code readability improvement
      t4301: add more interesting merge-tree testcases
      t64xx: convert 'test_create_repo' to 'git init'
      diff: have submodule_format logic avoid additional diff headers
      diff: fix filtering of additional headers under --remerge-diff
      diff: fix filtering of merge commits under --remerge-diff

Eric DeCosta (1):
      fsmonitor: option to allow fsmonitor to run against network-mounted=
 repos

Eric Sunshine (6):
      t2407: fix broken &&-chains in compound statement
      t1092: fix buggy sparse "blame" test
      t: detect and signal failure within loop
      t4301: account for behavior differences between sed implementations
      t4301: fix broken &&-chains and add missing loop termination
      t4301: emit blank line in more idiomatic fashion

Felipe Contreras (7):
      mergetools: vimdiff: fix comment
      mergetools: vimdiff: make vimdiff3 actually work
      mergetools: vimdiff: silence annoying messages
      mergetools: vimdiff: fix for diffopt
      mergetools: vimdiff: rework tab logic
      mergetools: vimdiff: fix single window layouts
      mergetools: vimdiff: simplify tabfirst

Fernando Ramos (1):
      vimdiff: make layout engine more robust against user vim settings

Glen Choo (16):
      submodule--helper: eliminate internal "--update" option
      submodule--helper tests: add missing "display path" coverage
      submodule--helper update: use display path helper
      submodule--helper: don't recreate recursive prefix
      submodule--helper: use correct display path helper
      submodule--helper update: use --super-prefix
      submodule--helper: remove display path helper
      Documentation/git-config.txt: add SCOPES section
      Documentation: define protected configuration
      config: learn `git_protected_config()`
      safe.directory: use git_protected_config()
      setup.c: create `safe.bareRepository`
      config.c: NULL check when reading protected config
      Documentation/git-reflog: remove unneeded \ from \{
      submodule--helper: add "const" to copy of "update_data"
      submodule--helper: refactor "errmsg_str" to be a "struct strbuf"

Goss Geppert (2):
      dir: traverse into repository
      dir: minor refactoring / clean-up

Han Xin (6):
      unpack-objects: low memory footprint for get_data() in dry_run mode
      object-file.c: refactor write_loose_object() to several steps
      object-file.c: add "stream_loose_object()" to handle large object
      unpack-objects: use stream_loose_object() to unpack large objects
      commit-graph.c: no lazy fetch in lookup_commit_in_graph()
      t5330: remove run_with_limited_processses()

Jacob Keller (1):
      remote: handle negative refspecs in git remote show

Jacob Stopak (1):
      Documentation: fix various repeat word typos

Jaydeep Das (1):
      gpg-interface: add function for converting trust level to string

Jeff King (59):
      is_promisor_object(): walk promisor packs in pack-order
      fetch: stop passing around unused worktrees variable
      branch: drop unused worktrees variable
      revisions.txt: escape "..." to avoid asciidoc horizontal ellipsis
      clone: drop extra newline from warning message
      clone: propagate empty remote HEAD even with other branches
      clone: use remote branch if it matches default HEAD
      clone: move unborn head creation to update_head()
      ref-filter: disable save_commit_buffer while traversing
      diff-files: move misplaced cleanup label
      write_midx_bitmap(): drop unused refs_snapshot parameter
      config.mak.dev: squelch -Wno-missing-braces for older gcc
      tree-walk: add a mechanism for getting non-canonicalized modes
      fsck: actually detect bad file modes in trees
      fsck: downgrade tree badFilemode to "info"
      is_promisor_object(): fix use-after-free of tree buffer
      compat: add function to enable nonblocking pipes
      git-compat-util: make MAX_IO_SIZE define globally available
      pipe_command(): avoid xwrite() for writing to pipe
      pipe_command(): handle ENOSPC when writing to a pipe
      pipe_command(): mark stdin descriptor as non-blocking
      git-compat-util: add UNUSED macro
      refs: mark unused each_ref_fn parameters
      refs: mark unused reflog callback parameters
      refs: mark unused virtual method parameters
      transport: mark bundle transport_options as unused
      streaming: mark unused virtual method parameters
      config: mark unused callback parameters
      hashmap: mark unused callback parameters
      mark unused read_tree_recursive() callback parameters
      run-command: mark unused async callback parameters
      is_path_owned_by_current_uid(): mark "report" parameter as unused
      xdiff: drop unused mmfile parameters from xdl_do_histogram_diff()
      log-tree: drop unused commit param in remerge_diff()
      match_pathname(): drop unused "flags" parameter
      verify_one_sparse(): drop unused parameters
      reftable: drop unused parameter from reader_seek_linear()
      reflog: assert PARSE_OPT_NONEG in parse-options callbacks
      xdiff: drop unused mmfile parameters from xdl_do_patience_diff()
      pass subcommand "prefix" arguments to parse_options()
      maintenance: add parse-options boilerplate for subcommands
      remote: run "remote rm" argv through parse_options()
      pack-bitmap-write: drop unused pack_idx_entry parameters
      tempfile: drop active flag
      tempfile: update comment describing state transitions
      test-crontab: minor memory and error handling fixes
      lookup_commit_in_graph(): use prepare_commit_graph() to check for g=
raph
      rev-list: disable commit graph with --verify-objects
      parse_object(): allow skipping hash check
      upload-pack: skip parse-object re-hashing of "want" objects
      parse_object(): check commit-graph when skip_hash set
      t1060: check partial clone of misnamed blob
      list_objects_filter_copy(): deep-copy sparse_oid_name field
      transport: deep-copy object-filter struct for fetch-pack
      transport: free filter options in disconnect_git()
      list_objects_filter_options: plug leak of filter_spec strings
      prepare_repo_settings(): plug leak of config values
      fetch: stop checking for NULL transport->remote in do_fetch()
      fetch: add branch.*.merge to default ref-prefix extension

Johannes Schindelin (36):
      merge-ort: store messages in a list, not in a single strbuf
      merge-ort: make `path_messages` a strmap to a string_list
      Git 2.30.5
      Git 2.31.4
      Git 2.32.3
      Git 2.33.4
      Git 2.34.4
      Git 2.35.4
      Git 2.36.2
      add --interactive: allow `update` to stage deleted files
      tests: fix incorrect --write-junit-xml code
      mergetool(vimdiff): allow paths to contain spaces again
      shortlog: use a stable sort
      t5351: avoid relying on `core.fsyncMethod =3D batch` to be supporte=
d
      t5351: avoid using `test_cmp` for binary data
      windows: include the Python bits when building Git for Windows
      mingw: remove unneeded `NO_GETTEXT` directive
      mingw: remove unneeded `NO_CURL` directive
      lstat(mingw): correctly detect ENOTDIR scenarios
      merge-ort: clean up after failed merge
      merge-ort: do leave trace2 region even if checkout fails
      setup: fix some formatting
      setup: prepare for more detailed "dubious ownership" messages
      mingw: provide details about unsafe directories' ownership
      mingw: be more informative when ownership check fails on FAT32
      mingw: handle a file owned by the Administrators group correctly
      scalar unregister: stop FSMonitor daemon
      range-diff: reorder argument handling
      range-diff: consistently validate the arguments
      range-diff: optionally accept pathspecs
      add -p: avoid ambiguous signed/unsigned comparison
      t3701: test the built-in `add -i` regardless of NO_PERL
      t6132(NO_PERL): do not run the scripted `add -p`
      add -p: detect more mismatches between plain vs colored diffs
      add -p: gracefully handle unparseable hunk headers in colored diffs
      add -p: ignore dirty submodules

Jonathan Tan (1):
      fetch-pack: write effective filter to trace2

Josh Steadmon (1):
      fetch-pack: add tracing for negotiation rounds

Julien Rouhaud (1):
      gitweb: remove title shortening heuristics

Junio C Hamano (40):
      revision: mark blobs needed for resolve-undo as reachable
      A regression fix for 2.37
      Git 2.37.1
      builtin/mv.c: use the MOVE_ARRAY() macro instead of memmove()
      The first batch after Git 2.37
      fsck: do not dereference NULL while checking resolve-undo data
      The second batch
      The third batch
      The fourth batch
      The fifth batch
      builtin/remote.c: use the right kind of STRING_LIST_INIT
      The sixth batch
      The seventh batch
      Downmerge a handful of fixes for 2.37.x maintenance track
      The eighth batch
      The ninth batch
      doc: consolidate --rerere-autoupdate description
      doc: clarify rerere-autoupdate
      Downmerge a bit more for 2.37.x
      The tenth batch
      The eleventh batch
      Git 2.37.2
      The twelfth batch
      The thirteenth batch
      The fourteenth batch
      t5329: notice a failure within a loop
      The fifteenth batch
      A handful more topics from the 'master' front for 2.37.3
      pretty: separate out the logic to decide the use of in-body from
      format-patch: allow forcing the use of in-body From: header
      format-patch: learn format.forceInBodyFrom configuration variable
      The sixteenth batch
      Git 2.37.3
      The seventeenth batch
      The eighteenth batch
      The nineteenth batch
      The twentieth batch
      Merge a handful of topics from the 'master' front
      Prepare for 2.38-rc0
      Git 2.38-rc0

Justin Donnelly (1):
      git-prompt: show presence of unresolved conflicts at command prompt

Kilian Kilger (2):
      git-p4: fix bug with encoding of p4 client name
      git-p4: refactoring of p4CmdList()

Kyle Zhao (1):
      send-pack.c: add config push.useBitmaps

Lessley Dennington (1):
      osx-keychain: fix compiler warning

Li Linchao (3):
      ls-files: update test style
      remote-curl: send Accept-Language header to server
      rev-list: support human-readable output for `--disk-usage`

Linus Torvalds (1):
      symbolic-ref: refuse to set syntactically invalid target

Manuel Boni (1):
      config.txt: document include, includeIf

Martin =C3=85gren (3):
      config/core.txt: fix minor issues for `core.sparseCheckoutCone`
      t4200: drop irrelevant code
      read-cache: make `do_read_index()` always set up `istate->repo`

Matheus Tavares (7):
      checkout: document bug where delayed checkout counts entries twice
      checkout: show bug about failed entries being included in final rep=
ort
      checkout: fix two bugs on the final count of updated entries
      pkt-line.h: move comment closer to the associated code
      t0021: avoid grepping for a Perl-specific string at filter output
      t0021: implementation the rot13-filter.pl script in C
      tests: use the new C rot13-filter helper to avoid PERL prereq

Matthew John Cheetham (1):
      scalar: enable built-in FSMonitor on `register`

Michael J Gruber (3):
      sequencer: do not translate reflog messages
      sequencer: do not translate parameters to error_resolve_conflict()
      sequencer: do not translate command names

Moritz Baumann (3):
      git-p4: fix CR LF handling for utf16 files
      git-p4: fix typo in P4Submit.applyCommit()
      git-p4: fix error handling in P4Unshelve.renameBranch()

Philip Oakley (1):
      doc add: renormalize is not idempotent for CRCRLF

Philippe Blain (3):
      diff-format.txt: dst can be 0* SHA-1 when path is deleted, too
      diff-format.txt: correct misleading wording
      diff-index.txt: update raw output format in examples

Phillip Wood (5):
      xdiff: introduce XDL_ALLOC_ARRAY()
      xdiff: introduce xdl_calloc
      xdiff: introduce XDL_CALLOC_ARRAY()
      xdiff: introduce XDL_ALLOC_GROW()
      tests: cache glibc version check

Ren=C3=A9 Scharfe (28):
      archive: update format documentation
      archive: rename archiver data field to filter_command
      archive-tar: factor out write_block()
      archive-tar: add internal gzip implementation
      archive-tar: use OS_CODE 3 (Unix) for internal gzip
      archive-tar: use internal gzip by default
      combine-diff: abort if --ignore-matching-lines is given
      combine-diff: abort if --output is given
      cocci: avoid normalization rules for memcpy
      mingw: avoid mktemp() in mkstemp() implementation
      mergesort: unify ranks loops
      mergesort: tighten merge loop
      mergesort: add macros for typed sort of linked lists
      test-mergesort: use DEFINE_LIST_SORT_DEBUG
      test-mergesort: use DEFINE_LIST_SORT
      blame: use DEFINE_LIST_SORT
      commit: use DEFINE_LIST_SORT
      fetch-pack: use DEFINE_LIST_SORT
      packfile: use DEFINE_LIST_SORT
      mergesort: remove llist_mergesort()
      nonblock: support Windows
      tempfile: avoid directory cleanup race
      test-mergesort: read sort input all at once
      test-mergesort: use mem_pool for sort input
      diff-no-index: release strbuf on queue error
      diff-no-index: release prefixed filenames
      diff-no-index: simplify argv index calculation
      add -p: fix worktree patch mode prompts

Richard Oliver (1):
      mktree: do not check type of remote objects

SZEDER G=C3=A1bor (29):
      Makefile: build 'gitweb' in the default target
      multi-pack-index: simplify handling of unknown --options
      index-format.txt: remove outdated list of supported extensions
      git.c: update NO_PARSEOPT markings
      t3301-notes.sh: check that default operation mode doesn't take argu=
ments
      t5505-remote.sh: check the behavior without a subcommand
      t0040-parse-options: test parse_options() with various 'parse_opt_f=
lags'
      api-parse-options.txt: fix description of OPT_CMDMODE
      parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
      parse-options: clarify the limitations of PARSE_OPT_NODASH
      parse-options: drop leading space from '--git-completion-helper' ou=
tput
      parse-options: add support for parsing subcommands
      builtin/bundle.c: let parse-options parse subcommands
      builtin/commit-graph.c: let parse-options parse subcommands
      builtin/gc.c: let parse-options parse 'git maintenance's subcommand=
s
      builtin/hook.c: let parse-options parse subcommands
      builtin/multi-pack-index.c: let parse-options parse subcommands
      builtin/notes.c: let parse-options parse subcommands
      builtin/reflog.c: let parse-options parse subcommands
      builtin/remote.c: let parse-options parse subcommands
      builtin/sparse-checkout.c: let parse-options parse subcommands
      builtin/stash.c: let parse-options parse subcommands
      builtin/worktree.c: let parse-options parse subcommands
      promisor-remote: fix xcalloc() argument order
      t0040-parse-options: remove leftover debugging
      test-parse-options.c: don't use for loop initial declaration
      test-parse-options.c: fix style of comparison with zero
      notes: simplify default operation mode arguments check
      notes, remote: show unknown subcommands between `'

Shaoxuan Yuan (12):
      t7002: add tests for moving out-of-cone file/directory
      t1092: mv directory from out-of-cone to in-cone
      mv: update sparsity after moving from out-of-cone to in-cone
      mv: decouple if/else-if checks using goto
      mv: check if out-of-cone file exists in index with SKIP_WORKTREE bi=
t
      mv: check if <destination> exists in index to handle overwriting
      mv: use flags mode for update_mode
      mv: add check_dir_in_index() and solve general dir check issue
      t1092: add tests for `git-rm`
      pathspec.h: move pathspec_needs_expanded_index() from reset.c to he=
re
      rm: expand the index only when necessary
      rm: integrate with sparse-index

Siddharth Asthana (4):
      revision: improve commit_rewrite_person()
      ident: move commit_rewrite_person() to ident.c
      ident: rename commit_rewrite_person() to apply_mailmap_to_header()
      cat-file: add mailmap support

Tao Klerks (1):
      rev-parse: documentation adjustment - mention remote tracking with =
@{u}

Taylor Blau (14):
      pack-objects.h: remove outdated pahole results
      commit-graph: pass repo_settings instead of repository
      t5318: demonstrate commit-graph generation v2 corruption
      commit-graph: introduce `repo_find_commit_pos_in_graph()`
      commit-graph: fix corrupt upgrade from generation v1 to v2
      t1006: extract --batch-command inputs to variables
      builtin/cat-file.c: support NUL-delimited input with `-z`
      t5326: demonstrate potential bitmap corruption
      t/lib-bitmap.sh: avoid silencing stderr
      midx.c: extract `struct midx_fanout`
      midx.c: extract `midx_fanout_add_midx_fanout()`
      midx.c: extract `midx_fanout_add_pack_fanout()`
      midx.c: include preferred pack correctly with existing MIDX
      midx.c: avoid adding preferred objects twice

Teng Long (8):
      pack-bitmap.c: fix formatting of error messages
      pack-bitmap.c: mark more strings for translations
      pack-bitmap.c: rename "idx_name" to "bitmap_name"
      pack-bitmap.c: do not ignore error when opening a bitmap file
      pack-bitmap.c: using error() instead of silently returning -1
      pack-bitmap.c: continue looping when first MIDX bitmap is found
      api-trace2.txt: print config key-value pair
      tr2: shows scope unconditionally in addition to key-value pair

Victoria Dye (26):
      scalar: reword command documentation to clarify purpose
      scalar: convert README.md into a technical design doc
      checkout: fix nested sparse directory diff in sparse index
      oneway_diff: handle removed sparse directories
      cache.h: create 'index_name_pos_sparse()'
      unpack-trees: unpack new trees as sparse directories
      scalar-diagnose: use "$GIT_UNZIP" in test
      scalar-diagnose: avoid 32-bit overflow of size_t
      scalar-diagnose: add directory to archiver more gently
      scalar-diagnose: move 'get_disk_info()' to 'compat/'
      scalar-diagnose: move functionality to common location
      diagnose.c: add option to configure archive contents
      builtin/diagnose.c: create 'git diagnose' builtin
      builtin/diagnose.c: add '--mode' option
      builtin/bugreport.c: create '--diagnose' option
      scalar-diagnose: use 'git diagnose --mode=3Dall'
      scalar: update technical doc roadmap
      scalar: constrain enlistment search
      scalar-unregister: handle error codes greater than 0
      scalar-[un]register: clearly indicate source of error
      scalar-delete: do not 'die()' in 'delete_enlistment()'
      scalar: move config setting logic into its own function
      scalar: update technical doc roadmap with FSMonitor support
      p0004: fix prereq declaration
      p0006: fix 'read-tree' argument ordering
      unpack-trees: fix sparse directory recursion check

ZheNing Hu (1):
      ls-files: introduce "--format" option

brian m. carlson (2):
      sha256: add support for Nettle
      gc: use temporary file for editing crontab

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (153):
      t0008: don't rely on default ".git/info/exclude"
      tests: don't depend on template-created .git/branches
      tests: don't assume a .git/info for .git/info/grafts
      tests: don't assume a .git/info for .git/info/attributes
      tests: don't assume a .git/info for .git/info/refs
      tests: don't assume a .git/info for .git/info/exclude
      tests: don't assume a .git/info for .git/info/sparse-checkout
      object-file.c: factor out deflate part of write_loose_object()
      core doc: modernize core.bigFileThreshold documentation
      git-submodule.sh: remove unused sanitize_submodule_env()
      git-submodule.sh: remove unused $prefix variable
      git-submodule.sh: make the "$cached" variable a boolean
      git-submodule.sh: remove unused top-level "--branch" argument
      submodule--helper: have --require-init imply --init
      submodule update: remove "-v" option
      submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
      submodule--helper: report "submodule" as our name in some "-h" outp=
ut
      submodule--helper: understand --checkout, --merge and --rebase syno=
nyms
      git-submodule.sh: use "$quiet", not "$GIT_QUIET"
      git-sh-setup.sh: remove "say" function, change last users
      gitweb/Makefile: define all .PHONY prerequisites inline
      gitweb/Makefile: add a $(GITWEB_ALL) variable
      gitweb/Makefile: clear up and de-duplicate the gitweb.{css,js} vars
      gitweb/Makefile: prepare to merge into top-level Makefile
      gitweb: remove "test" and "test-installed" targets
      gitweb/Makefile: include in top-level Makefile
      gitweb/Makefile: add a "NO_GITWEB" parameter
      tests: add missing double quotes to included library paths
      test-lib.sh: fix prepend_var() quoting issue
      config tests: fix harmless but broken "rm -r" cleanup
      submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags
      check-ref-format: fix trivial memory leak
      clone: fix memory leak in wanted_peer_refs()
      submodule.c: free() memory from xgetcwd()
      revert: free "struct replay_opts" members
      cat-file: fix a memory leak in --batch-command mode
      merge-file: refactor for subsequent memory leak fix
      merge-file: fix memory leaks on error path
      checkout: avoid "struct unpack_trees_options" leak
      gc: fix a memory leak
      cat-file: fix a common "struct object_context" memory leak
      pull: fix a "struct oid_array" memory leak
      test-tool test-hash: fix a memory leak
      test-tool path-utils: fix a memory leak
      test-tool {dump,scrap}-cache-tree: fix memory leaks
      test-tool urlmatch-normalization: fix a memory leak
      test-tool regex: call regfree(), fix memory leaks
      test-tool json-writer: fix memory leaks
      test-tool bloom: fix memory leaks
      test-tool ref-store: fix a memory leak
      test-tool delta: fix a memory leak
      Makefile: remove mandatory "spatch" arguments from SPATCH_FLAGS
      Makefile & .gitignore: ignore & clean "git.res", not "*.res"
      cocci: add a "coccicheck-test" target and test *.cocci rules
      cocci: have "coccicheck{,-pending}" depend on "coccicheck-test"
      cocci: add and apply a rule to find "unused" strbufs
      cocci: generalize "unused" rule to cover more than "strbuf"
      trace2: only include "fsync" events if we git_fsync()
      test-lib: use $1, not $@ in test_known_broken_{ok,failure}_
      test-lib: don't set GIT_EXIT_OK before calling test_atexit_handler
      test-lib: fix GIT_EXIT_OK logic errors, use BAIL_OUT
      test-lib: add a --invert-exit-code switch
      t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
      test-lib: add a SANITIZE=3Dleak logging mode
      t/Makefile: don't remove test-results in "clean-except-prove-cache"
      tests: move copy/pasted PERL + Test::More checks to a lib-perl.sh
      test-lib: simplify by removing test_external
      test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck mode
      test-lib: have the "check" mode for SANITIZE=3Dleak consider leak l=
ogs
      leak tests: don't skip some tests under SANITIZE=3Dleak
      leak tests: mark passing SANITIZE=3Dleak tests as leak-free
      upload-pack: fix a memory leak in create_pack_file()
      CI: use "GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue" in linux-leaks
      bisect.c: add missing "goto" for release_revisions()
      test-fast-rebase helper: use release_revisions() (again)
      log: fix a memory leak in "git show <revision>..."
      log: refactor "rev.pending" code in cmd_show()
      bisect.c: partially fix bisect_rev_setup() memory leak
      revisions API: don't leak memory on argv elements that need free()-=
ing
      help.c: refactor drop_prefix() to use a "switch" statement"
      help.c: remove common category behavior from drop_prefix() behavior
      git help doc: use "<doc>" instead of "<guide>"
      git docs: add a category for user-facing file, repo and command UX
      git docs: add a category for file formats, protocols and interfaces
      docs: move commit-graph format docs to man section 5
      docs: move protocol-related docs to man section 5
      docs: move index format docs to man section 5
      docs: move signature docs to man section 5
      docs: move pack format docs to man section 5
      docs: move cruft pack docs to gitformat-pack
      docs: move http-protocol docs to man section 5
      hook API: don't segfault on strbuf_addf() to NULL "out"
      Makefile + hash.h: remove PPC_SHA1 implementation
      Makefile: use $(OBJECTS) instead of $(C_OBJ)
      git-compat-util.h: use "UNUSED", not "UNUSED(var)"
      git-compat-util.h: use "deprecated" for UNUSED variables
      submodule tests: test usage behavior
      submodule tests: test for "add <repository> <abs-path>"
      submodule--helper: remove unused "name" helper
      submodule--helper: remove unused "list" helper
      test-tool submodule-config: remove unused "--url" handling
      submodule--helper: move "is-active" to a test-tool
      submodule--helper: move "check-name" to a test-tool
      submodule--helper: move "resolve-relative-url-test" to a test-tool
      submodule--helper style: don't separate declared variables with \n\=
n
      submodule--helper style: add \n\n after variable declarations
      submodule--helper: replace memset() with { 0 }-initialization
      submodule--helper: use xstrfmt() in clone_submodule()
      submodule--helper: move "sb" in clone_submodule() to its own scope
      submodule--helper: add "const" to passed "module_clone_data"
      submodule--helper: add "const" to passed "struct update_data"
      submodule--helper: don't redundantly check "else if (res)"
      submodule--helper: rename "int res" to "int ret"
      submodule--helper: return "ret", not "1" from update_submodule()
      submodule--helper: add missing braces to "else" arm
      submodule--helper: don't call submodule_strategy_to_string() in BUG=
()
      submodule API: don't handle SM_..{UNSPECIFIED,COMMAND} in to_string=
()
      submodule--helper: use "code" in run_update_command()
      submodule--helper: don't exit() on failure, return
      submodule--helper: libify determine_submodule_update_strategy()
      submodule--helper: libify "must_die_on_failure" code paths
      submodule--helper update: don't override 'checkout' exit code
      submodule--helper: libify "must_die_on_failure" code paths (for die=
)
      submodule--helper: check repo{_submodule,}_init() return values
      submodule--helper: libify more "die" paths for module_update()
      submodule--helper: libify even more "die" paths for module_update()
      submodule--helper: fix bad config API usage
      submodule--helper: fix a leak in "clone_submodule"
      submodule--helper: fix trivial get_default_remote_submodule() leak
      submodule--helper: fix most "struct pathspec" memory leaks
      submodule--helper: "struct pathspec" memory leak in module_update()
      submodule--helper: don't leak {run,capture}_command() cp.dir argume=
nt
      submodule--helper: add and use *_release() functions
      submodule--helper: fix "errmsg_str" memory leak
      submodule--helper: fix "sm_path" and other "module_cb_list" leaks
      submodule--helper: fix a leak with repo_clear()
      submodule--helper: fix a memory leak in get_default_remote_submodul=
e()
      submodule--helper: fix "reference" leak
      submodule--helper: fix obscure leak in module_add()
      submodule--helper: fix a leak in module_add()
      submodule--helper: fix a memory leak in print_status()
      submodule--helper: free some "displaypath" in "struct update_data"
      submodule--helper: free rest of "displaypath" in "struct update_dat=
a"
      submodule--helper: fix a configure_added_submodule() leak
      docs: add and use include template for config/* includes
      grep docs: de-duplicate configuration sections
      send-email docs: de-duplicate configuration sections
      apply docs: de-duplicate configuration sections
      notes docs: de-duplicate and combine configuration sections
      difftool docs: de-duplicate configuration sections
      log docs: de-duplicate configuration sections
      docs: add CONFIGURATION sections that map to a built-in
      docs: add CONFIGURATION sections that fuzzy map to built-ins

=C3=98ystein Walle (1):
      rev-parse --parseopt: detect missing opt-spec


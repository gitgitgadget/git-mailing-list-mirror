Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5AC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857F4611C1
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhKCXUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:20:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55543 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhKCXUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 19:20:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1CF6173065;
        Wed,  3 Nov 2021 19:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=6eC9QbFpjuMJc+Xo12o1p/gHi
        uraXEMkNT3H5B7Tngg=; b=jx6nNcGdazCxXLFycFzOi1g/ZcWCmkDQf6VHWrLlK
        Y33gRCvW2WUlOJroSI/T37kawg4S7X2AokQ2LRt8T1ZSwsh1ONraFb8+k6H5Rqby
        QYE786uMhgpmCWI7stCqPb+dWtQGbE5wqLrcEm8taWXOF3MX7p2c473GOds1Ej7L
        pY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A810D173064;
        Wed,  3 Nov 2021 19:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4432A173063;
        Wed,  3 Nov 2021 19:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.34.0-rc1
Date:   Wed, 03 Nov 2021 16:17:41 -0700
Message-ID: <xmqqsfwc4yne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F4AFA7C-3CFC-11EC-8F45-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.34.0-rc1 is now available for testing at
the usual places.  It is comprised of 778 non-merge commits since
v2.33.0, contributed by 90 people, 27 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.34.0-rc1' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.33.0 are as follows.
Welcome to the Git development community!

  Alan Blotz, Azeem Bande-Ali, Dr. Matthias St. Pierre, Eli
  Schwartz, git.mexon@spamgourmet.com, Glen Choo, Hamza Mahfooz,
  Joel Klinghed, Johannes Altmanninger, Jonas Kittner, Kim
  Altintop, Kyle Zhao, Mahi Kolla, Marvin H=C3=A4user, Mickey Endito,
  Rob Browning, Robert Estelle, Robert Leftwich, Tal Kelrich,
  Tassilo Horn, Thomas De Zeeuw, USAMI Kenta, Victor Gambier,
  Victoria Dye, Wesley Schwengle, Xingman Chen, and Zoker.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alban Gruin, Alex Henrie, Andrz=
ej
  Hunt, Atharva Raykar, Bagas Sanjaya, Ben Boeckel, brian
  m. carlson, Carlo Arenas, Carlo Marcelo Arenas Bel=C3=B3n, Christian
  Couder, David Aguilar, David Turner, Derrick Stolee, =C4=90o=C3=A0n
  Tr=E1=BA=A7n C=C3=B4ng Danh, Elijah Newren, Emily Shaffer, Emir Sar=C4=B1=
,
  Eric Sunshine, Eric Wong, Fabian Stelzer, Felipe Contreras,
  Greg Hurrell, Han-Wen Nienhuys, Hariom Verma, Jacob Keller,
  Jacob Vosmaer, Jean-No=C3=ABl Avila, Jeff Hostetler, Jeff King,
  Jiang Xin, Johannes Schindelin, Johannes Sixt, Jonathan Nieder,
  Jonathan Tan, Josh Steadmon, Junio C Hamano, Kaartic Sivaraam,
  L=C3=A9na=C3=AFc Huard, Martin =C3=85gren, Matheus Tavares, Matheus Tav=
ares
  Bernardino, Matthias A=C3=9Fhauer, Mike Hommey, Miriam Rubio, Orgad
  Shaneh, Patrick Steinhardt, Philip Oakley, Philippe Blain,
  Phillip Wood, Pranit Bauva, Randall S. Becker, Ren=C3=A9 Scharfe,
  Sergey Organov, Shourya Shukla, SZEDER G=C3=A1bor, Takashi Iwai,
  Tanushree Tumane, Taylor Blau, Teng Long, Todd Zullinger,
  Ulrich Windl, and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git 2.34 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since Git 2.33
----------------------

Backward compatibility notes

 * The "--preserve-merges" option of "git rebase" has been removed.


UI, Workflows & Features

 * Pathname expansion (like "~username/") learned a way to specify a
   location relative to Git installation (e.g. its $sharedir which is
   $(prefix)/share), with "%(prefix)".

 * Use `ort` instead of `recursive` as the default merge strategy.

 * The userdiff pattern for "java" language has been updated.

 * "git rebase" by default skips changes that are equivalent to
   commits that are already in the history the branch is rebased onto;
   give messages when this happens to let the users be aware of
   skipped commits, and also teach them how to tell "rebase" to keep
   duplicated changes.

 * The advice message that "git cherry-pick" gives when it asks
   conflicted replay of a commit to be resolved by the end user has
   been updated.

 * After "git clone --recurse-submodules", all submodules are cloned
   but they are not by default recursed into by other commands.  With
   submodule.stickyRecursiveClone configuration set, submodule.recurse
   configuration is set to true in a repository created by "clone"
   with "--recurse-submodules" option.

 * The logic for auto-correction of misspelt subcommands learned to go
   interactive when the help.autocorrect configuration variable is set
   to 'prompt'.

 * "git maintenance" scheduler learned to use systemd timers as a
   possible backend.

 * "git diff --submodule=3Ddiff" showed failure from run_command() when
   trying to run diff inside a submodule, when the user manually
   removes the submodule directory.

 * "git bundle unbundle" learned to show progress display.

 * In cone mode, the sparse-index code path learned to remove ignored
   files (like build artifacts) outside the sparse cone, allowing the
   entire directory outside the sparse cone to be removed, which is
   especially useful when the sparse patterns change.

 * Taking advantage of the CGI interface, http-backend has been
   updated to enable protocol v2 automatically when the other side
   asks for it.

 * The credential-cache helper has been adjusted to Windows.

 * The error in "git help no-such-git-command" is handled better.

 * The unicode character width table (used for output alignment) has
   been updated.

 * The ref iteration code used to optionally allow dangling refs to be
   shown, which has been tightened up.

 * "git add", "git mv", and "git rm" have been adjusted to avoid
   updating paths outside of the sparse-checkout definition unless
   the user specifies a "--sparse" option.

 * "git repack" has been taught to generate multi-pack reachability
   bitmaps.

 * "git fsck" has been taught to report mismatch between expected and
   actual types of an object better.

 * Use ssh public crypto for object and push-cert signing.

 * "git log --grep=3Dstring --author=3Dname" learns to highlight hits jus=
t
   like "git grep string" does.



Performance, Internal Implementation, Development Support etc.

 * "git bisect" spawned "git show-branch" only to pretty-print the
   title of the commit after checking out the next version to be
   tested; this has been rewritten in C.

 * "git add" can work better with the sparse index.

 * Support for ancient versions of cURL library (pre 7.19.4) has been
   dropped.

 * A handful of tests that assumed implementation details of files
   backend for refs have been cleaned up.

 * trace2 logs learned to show parent process name to see in what
   context Git was invoked.

 * Loading of ref tips to prepare for common ancestry negotiation in
   "git fetch-pack" has been optimized by taking advantage of the
   commit graph when available.

 * Remind developers that the userdiff patterns should be kept simple
   and permissive, assuming that the contents they apply are always
   syntactically correct.

 * The current implementation of GIT_TEST_FAIL_PREREQS is broken in
   that checking for the lack of a prerequisite would not work.  Avoid
   the use of "if ! test_have_prereq X" in a test script.

 * The revision traversal API has been optimized by taking advantage
   of the commit-graph, when available, to determine if a commit is
   reachable from any of the existing refs.

 * "git fetch --quiet" optimization to avoid useless computation of
   info that will never be displayed.

 * Callers from older advice_config[] based API has been updated to
   use the newer advice_if_enabled() and advice_enabled() API.

 * Teach "test_pause" and "debug" helpers to allow using the HOME and
   TERM environment variables the user usually uses.

 * "make INSTALL_STRIP=3D-s install" allows the installation step to use
   "install -s" to strip the binaries as they get installed.

 * Code that handles large number of refs in the "git fetch" code
   path has been optimized.

 * The reachability bitmap file used to be generated only for a single
   pack, but now we've learned to generate bitmaps for history that
   span across multiple packfiles.

 * The code to make "git grep" recurse into submodules has been
   updated to migrate away from the "add submodule's object store as
   an alternate object store" mechanism (which is suboptimal).

 * The tracing of process ancestry information has been enhanced.

 * Reduce number of write(2) system calls while sending the
   ref advertisement.

 * Update the build procedure to use the "-pedantic" build when
   DEVELOPER makefile macro is in effect.

 * Large part of "git submodule add" gets rewritten in C.

 * The run-command API has been updated so that the callers can easily
   ask the file descriptors open for packfiles to be closed immediately
   before spawning commands that may trigger auto-gc.

 * An oddball OPTION_ARGUMENT feature has been removed from the
   parse-options API.

 * The mergesort implementation used to sort linked list has been
   optimized.

 * Remove external declaration of functions that no longer exist.

 * "git multi-pack-index write --bitmap" learns to propagate the
   hashcache from original bitmap to resulting bitmap.

 * CI learns to run the leak sanitizer builds.

 * "git grep --recurse-submodules" takes trees and blobs from the
   submodule repository, but the textconv settings when processing a
   blob from the submodule is not taken from the submodule repository.
   A test is added to demonstrate the issue, without fixing it.

 * Teach "git help -c" into helping the command line completion of
   configuration variables.

 * When "git cmd -h" shows more than one line of usage text (e.g.
   the cmd subcommand may take sub-sub-command), parse-options API
   learned to align these lines, even across i18n/l10n.

 * Prevent "make sparse" from running for the source files that
   haven't been modified.

 * The codepath to write a new version of .midx multi-pack index files
   has learned to release the mmaped memory holding the current
   version of .midx before removing them from the disk, as some
   platforms do not allow removal of a file that still has mapping.

 * A new feature has been added to abort early in the test framework.


Fixes since v2.33
-----------------

 * Input validation of "git pack-objects --stdin-packs" has been
   corrected.

 * Bugfix for common ancestor negotiation recently introduced in "git
   push" code path.

 * "git pull" had various corner cases that were not well thought out
   around its --rebase backend, e.g. "git pull --ff-only" did not stop
   but went ahead and rebased when the history on other side is not a
   descendant of our history.  The series tries to fix them up.

 * "git apply" miscounted the bytes and failed to read to the end of
   binary hunks.

 * "git range-diff" code clean-up.

 * "git commit --fixup" now works with "--edit" again, after it was
   broken in v2.32.

 * Use upload-artifacts v1 (instead of v2) for 32-bit linux, as the
   new version has a blocker bug for that architecture.

 * Checking out all the paths from HEAD during the last conflicted
   step in "git rebase" and continuing would cause the step to be
   skipped (which is expected), but leaves MERGE_MSG file behind in
   $GIT_DIR and confuses the next "git commit", which has been
   corrected.

 * Various bugs in "git rebase -r" have been fixed.

 * mmap() imitation used to call xmalloc() that dies upon malloc()
   failure, which has been corrected to just return an error to the
   caller to be handled.

 * "git diff --relative" segfaulted and/or produced incorrect result
   when there are unmerged paths.

 * The delayed checkout code path in "git checkout" etc. were chatty
   even when --quiet and/or --no-progress options were given.

 * "git branch -D <branch>" used to refuse to remove a broken branch
   ref that points at a missing commit, which has been corrected.

 * Build update for Apple clang.

 * The parser for the "--nl" option of "git column" has been
   corrected.

 * "git upload-pack" which runs on the other side of "git fetch"
   forgot to take the ref namespaces into account when handling
   want-ref requests.

 * The sparse-index support can corrupt the index structure by storing
   a stale and/or uninitialized data, which has been corrected.

 * Buggy tests could damage repositories outside the throw-away test
   area we created.  We now by default export GIT_CEILING_DIRECTORIES
   to limit the damage from such a stray test.

 * Even when running "git send-email" without its own threaded
   discussion support, a threading related header in one message is
   carried over to the subsequent message to result in an unwanted
   threading, which has been corrected.

 * The output from "git fast-export", when its anonymization feature
   is in use, showed an annotated tag incorrectly.

 * Doc update plus improved error reporting.

 * Recent "diff -m" changes broke "gitk", which has been corrected.

 * Regression fix.

 * The "git apply -3" code path learned not to bother the lower level
   merge machinery when the three-way merge can be trivially resolved
   without the content level merge.  This fixes a regression caused by
   recent "-3way first and fall back to direct application" change.

 * The code that optionally creates the *.rev reverse index file has
   been optimized to avoid needless computation when it is not writing
   the file out.

 * "git range-diff -I... <range> <range>" segfaulted, which has been
   corrected.

 * The order in which various files that make up a single (conceptual)
   packfile has been reevaluated and straightened up.  This matters in
   correctness, as an incomplete set of files must not be shown to a
   running Git.

 * The "mode" word is useless in a call to open(2) that does not
   create a new file.  Such a call in the files backend of the ref
   subsystem has been cleaned up.

 * "git update-ref --stdin" failed to flush its output as needed,
   which potentially led the conversation to a deadlock.

 * When "git am --abort" fails to abort correctly, it still exited
   with exit status of 0, which has been corrected.

 * Correct nr and alloc members of strvec struct to be of type size_t.

 * "git stash", where the tentative change involves changing a
   directory to a file (or vice versa), was confused, which has been
   corrected.

 * "git clone" from a repository whose HEAD is unborn into a bare
   repository didn't follow the branch name the other side used, which
   is corrected.

 * "git cvsserver" had a long-standing bug in its authentication code,
   which has finally been corrected (it is unclear and is a separate
   question if anybody is seriously using it, though).

 * "git difftool --dir-diff" mishandled symbolic links.

 * Sensitive data in the HTTP trace were supposed to be redacted, but
   we failed to do so in HTTP/2 requests.

 * "make clean" has been updated to remove leftover .depend/
   directories, even when it is not told to use them to compute header
   dependencies.

 * Protocol v0 clients can get stuck parsing a malformed feature line.

 * A few kinds of changes "git status" can show were not documented.
   (merge d2a534c515 ja/doc-status-types-and-copies later to maint).

 * The mergesort implementation used to sort linked list has been
   optimized.
   (merge c90cfc225b rs/mergesort later to maint).

 * An editor session launched during a Git operation (e.g. during 'git
   commit') can leave the terminal in a funny state.  The code path
   has updated to save the terminal state before, and restore it
   after, it spawns an editor.
   (merge 3d411afabc cm/save-restore-terminal later to maint).

 * "git cat-file --batch" with the "--batch-all-objects" option is
   supposed to iterate over all the objects found in a repository, but
   it used to translate these object names using the replace mechanism,
   which defeats the point of enumerating all objects in the repository.
   This has been corrected.
   (merge bf972896d7 jk/cat-file-batch-all-wo-replace later to maint).

 * Recent sparse-index work broke safety against attempts to add paths
   with trailing slashes to the index, which has been corrected.
   (merge c8ad9d04c6 rs/make-verify-path-really-verify-again later to mai=
nt).

 * The "--color-lines" and "--color-by-age" options of "git blame"
   have been missing, which are now documented.
   (merge 8c32856133 bs/doc-blame-color-lines later to maint).

 * The PATH used in CI job may be too wide and let incompatible dlls
   to be grabbed, which can cause the build&test to fail.  Tighten it.
   (merge 7491ef6198 js/windows-ci-path-fix later to maint).

 * Avoid performance measurements from getting ruined by gc and other
   housekeeping pauses interfering in the middle.
   (merge be79131a53 rs/disable-gc-during-perf-tests later to maint).

 * Stop "git add --dry-run" from creating new blob and tree objects.
   (merge e578d0311d rs/add-dry-run-without-objects later to maint).

 * "git commit" gave duplicated error message when the object store
   was unwritable, which has been corrected.
   (merge 4ef91a2d79 ab/fix-commit-error-message-upon-unwritable-object-s=
tore later to maint).

 * Recent sparse-index addition, namely any use of index_name_pos(),
   can expand sparse index entries and breaks any code that walks
   cache-tree or existing index entries.  One such instance of such a
   breakage has been corrected.

 * The xxdiff difftool backend can exit with status 128, which the
   difftool-helper that launches the backend takes as a significant
   failure, when it is not significant at all.  Work it around.
   (merge 571f4348dd da/mergetools-special-case-xxdiff-exit-128 later to =
maint).

 * Improve test framework around unwritable directories.
   (merge 5d22e18965 ab/test-cleanly-recreate-trash-directory later to ma=
int).

 * "git push" client talking to an HTTP server did not diagnose the
   lack of the final status report from the other side correctly,
   which has been corrected.
   (merge c5c3486f38 jk/http-push-status-fix later to maint).

 * Update "git archive" documentation and give explicit mention on the
   compression level for both zip and tar.gz format.
   (merge c4b208c309 bs/archive-doc-compression-level later to maint).

 * Drop "git sparse-index" from the list of common commands.
   (merge 6a9a50a8af sg/sparse-index-not-that-common-a-command later to m=
aint).

 * "git branch -c/-m new old" was not described to copy config, which
   has been corrected.
   (merge 8252ec300e jc/branch-copy-doc later to maint).

 * Squelch over-eager warning message added during this cycle.
   (merge 9e8fe7b1c7 jk/log-warn-on-bogus-encoding later to maint).

 * Fix long-standing shell syntax error in the completion script.
   (merge 46b0585286 re/completion-fix-test-equality later to maint).

 * Teach "git commit-graph" command not to allow using replace objects
   at all, as we do not use the commit-graph at runtime when we see
   object replacement.
   (merge 095d112f8c ab/ignore-replace-while-working-on-commit-graph late=
r to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge f188160be9 ab/bundle-remove-verbose-option later to maint).
   (merge 8c6b4332b4 rs/close-pack-leakfix later to maint).
   (merge 51b04c05b7 bs/difftool-msg-tweak later to maint).
   (merge dd20e4a6db ab/make-compdb-fix later to maint).
   (merge 6ffb990dc4 os/status-docfix later to maint).
   (merge 100c2da2d3 rs/p3400-lose-tac later to maint).
   (merge 76f3b69896 tb/aggregate-ignore-leading-whitespaces later to mai=
nt).
   (merge 6e4fd8bfcd tz/doc-link-to-bundle-format-fix later to maint).
   (merge f6c013dfa1 jc/doc-commit-header-continuation-line later to main=
t).
   (merge ec9a37d69b ab/pkt-line-cleanup later to maint).
   (merge 8650c6298c ab/fix-make-lint-docs later to maint).
   (merge 1c720357ce ab/test-lib-diff-cleanup later to maint).
   (merge 6b615dbece ks/submodule-add-message-fix later to maint).
   (merge 82a57cd13f ma/doc-git-version later to maint).
   (merge 203eb8381a jc/doc-format-patch-clarify-auto-base later to maint=
).
   (merge 559664c792 ab/test-lib later to maint).

----------------------------------------------------------------

Changes since v2.33.0 are as follows:

Alex Henrie (1):
      pull: abort if --ff-only is given and fast-forwarding is impossible

Andrzej Hunt (1):
      connect: also update offset for features without values

Atharva Raykar (11):
      submodule--helper: introduce add-config subcommand
      submodule--helper: add options for compute_submodule_clone_url()
      submodule--helper: refactor resolve_relative_url() helper
      submodule--helper: remove repeated code in sync_submodule()
      dir: libify and export helper functions from clone.c
      submodule--helper: convert the bulk of cmd_add() to C
      submodule--helper: remove add-clone subcommand
      submodule--helper: remove add-config subcommand
      submodule--helper: remove resolve-relative-url subcommand
      submodule--helper: rename compute_submodule_clone_url()
      submodule--helper: run update procedures from C

Azeem Bande-Ali (1):
      help.c: help.autocorrect=3Dprompt waits for user action

Bagas Sanjaya (8):
      make: add INSTALL_STRIP option variable
      Documentation: fix default directory of git bugreport -o
      ls-files: use imperative mood for -X and -z option description
      difftool: fix word spacing in the usage strings
      blame: describe default output format
      bisect--helper: add space between colon and following sentence
      blame: document --color-* options
      archive: describe compression level option

Ben Boeckel (2):
      advice: add enum variants for missing advice variables
      advice: remove read uses of most global `advice_` variables

Carlo Marcelo Arenas Bel=C3=B3n (23):
      build: update detect-compiler for newer Xcode version
      builtin/merge: avoid -Wformat-extra-args from ancient Xcode
      ci: run a pedantic build as part of the GitHub workflow
      ci: update freebsd 12 cirrus job
      ci: use upload-artifacts v1 for dockerized jobs
      remote: avoid -Wunused-but-set-variable in gcc with -DNDEBUG
      win32: allow building with pedantic mode enabled
      developer: enable pedantic by default
      t0301: fixes for windows compatibility
      credential-cache: check for windows specific errors
      git-compat-util: include declaration for unix sockets in windows
      tree-diff: fix leak when not HAVE_ALLOCA_H
      t0000: avoid masking git exit value through pipes
      git-cvsserver: use crypt correctly to compare password hashes
      git-cvsserver: protect against NULL in crypt(3)
      Documentation: cleanup git-cvsserver
      unicode: update the width tables to Unicode 14
      simple-ipc: move definition of ipc_active_state outside of ifdef
      lazyload.h: use an even more generic function pointer than FARPROC
      Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
      terminal: teach git how to save/restore its terminal settings
      editor: save and reset terminal after calling EDITOR
      wrapper: remove xunsetenv()

David Aguilar (6):
      difftool: fix symlink-file writing in dir-diff mode
      difftool: create a tmpdir path without repeated slashes
      difftool: refactor dir-diff to write files using helper functions
      difftool: remove an unnecessary call to strbuf_release()
      difftool: add a missing space to the run_dir_diff() comments
      mergetools/xxdiff: prevent segfaults from stopping difftool

David Turner (3):
      t4060: remove unused variable
      diff --submodule=3Ddiff: do not fail on ever-initialied deleted sub=
modules
      diff --submodule=3Ddiff: don't print failure message twice

Derrick Stolee (36):
      t1092: test merge conflicts outside cone
      add: allow operating on a sparse-only index
      pathspec: stop calling ensure_full_index
      add: ignore outside the sparse-checkout in refresh()
      add: remove ensure_full_index() with --renormalize
      maintenance: skip bootout/bootstrap when plist is registered
      t7519: rewrite sparse index test
      sparse-index: silently return when not using cone-mode patterns
      unpack-trees: fix nested sparse-dir search
      sparse-index: silently return when cache tree fails
      sparse-index: use WRITE_TREE_MISSING_OK
      sparse-checkout: create helper methods
      attr: be careful about sparse directories
      sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
      sparse-checkout: clear tracked sparse dirs
      diff: ignore sparse paths in diffstat
      merge: make sparse-aware with ORT
      merge-ort: expand only for out-of-cone conflicts
      t1092: add cherry-pick, rebase tests
      sequencer: ensure full index if not ORT strategy
      sparse-index: integrate with cherry-pick and rebase
      t/perf/run: fix bin-wrappers computation
      t3705: test that 'sparse_entry' is unstaged
      t1092: behavior for adding sparse files
      dir: select directories correctly
      dir: fix pattern matching on dirs
      add: fail when adding an untracked sparse file
      add: skip tracked paths outside sparse-checkout cone
      add: implement the --sparse option
      add: update --chmod to skip sparse paths
      add: update --renormalize to skip sparse paths
      rm: add --sparse option
      rm: skip sparse paths with missing SKIP_WORKTREE
      mv: refuse to move sparse paths
      advice: update message to suggest '--sparse'
      dir: fix directory-matching bug

Elijah Newren (48):
      t7601: test interaction of merge/rebase/fast-forward flags and opti=
ons
      t7601: add tests of interactions with multiple merge heads and conf=
ig
      pull: since --ff-only overrides, handle it first
      pull: make --rebase and --no-rebase override pull.ff=3Donly
      pull: abort by default when fast-forwarding is not possible
      pull: update docs & code for option compatibility with rebasing
      pull: fix handling of multiple heads
      merge-ort: rename str{map,intmap,set}_func()
      diffcore-rename: use a mem_pool for exact rename detection's hashma=
p
      merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
      merge-ort: set up a memory pool
      merge-ort: switch our strmaps over to using memory pools
      diffcore-rename, merge-ort: add wrapper functions for filepair allo=
c/dealloc
      merge-ort: store filepairs and filespecs in our mem_pool
      merge-ort: reuse path strings in pool_alloc_filespec
      merge-ort: remove compile-time ability to turn off usage of memory =
pools
      git-rebase.txt: correct antiquated claims about --rebase-merges
      directory-rename-detection.txt: small updates due to merge-ort opti=
mizations
      Documentation: edit awkward references to `git merge-recursive`
      merge-strategies.txt: update wording for the resolve strategy
      merge-strategies.txt: do not imply using copy detection is desired
      merge-strategies.txt: avoid giving special preference to patience a=
lgorithm
      merge-strategies.txt: fix simple capitalization error
      git-rebase.txt: correct out-of-date and misleading text about renam=
es
      merge-strategies.txt: add coverage of the `ort` merge strategy
      Update error message and code comment
      Change default merge backend from recursive to ort
      Update docs for change of default merge backend
      t3903: document a pair of directory/file bugs
      stash: avoid feeding directories to update-index
      stash: restore untracked files AFTER restoring tracked files
      git-am.txt: clarify --abort behavior
      t4151: add a few am --abort tests
      am: fix incorrect exit status on am fail to abort
      tests: remove leftover untracked files
      trace2.h: fix trivial comment typo
      merge-ort: fix completely wrong comment
      t2500: add various tests for nuking untracked files
      checkout, read-tree: fix leak of unpack_trees_options.dir
      read-tree, merge-recursive: overwrite ignored files by default
      unpack-trees: introduce preserve_ignored to unpack_trees_options
      unpack-trees: make dir an internal-only struct
      Remove ignored files by default when they are in the way
      Change unpack_trees' 'reset' flag into an enum
      unpack-trees: avoid nuking untracked dir in way of unmerged file
      unpack-trees: avoid nuking untracked dir in way of locally deleted =
file
      Comment important codepaths regarding nuking untracked files/dirs
      Documentation: call out commands that nuke untracked files/director=
ies

Emily Shaffer (3):
      tr2: make process info collection platform-generic
      tr2: log parent process name
      hook.c: add a hook_exists() wrapper and use it in bugreport.c

Eric Wong (1):
      doc/technical: update note about core.multiPackIndex

Fabian Stelzer (11):
      ssh signing: preliminary refactoring and clean-up
      ssh signing: add test prereqs
      ssh signing: add ssh key format and signing code
      ssh signing: retrieve a default key from ssh-agent
      ssh signing: provide a textual signing_key_id
      ssh signing: verify signatures using ssh-keygen
      ssh signing: duplicate t7510 tests for commits
      ssh signing: tests for logs, tags & push certs
      ssh signing: test that gpg fails for unknown keys
      ssh signing: fmt-merge-msg tests & config parse
      ssh signing: clarify trustlevel usage in docs

Felipe Contreras (4):
      completion: bash: fix prefix detection in branch.*
      completion: bash: fix for suboptions with value
      completion: bash: fix for multiple dash commands
      completion: bash: add correct suffix in variables

Glen Choo (4):
      MyFirstContribution: Document --range-diff option when writing v2
      fsck: verify commit graph when implicitly enabled
      fsck: verify multi-pack-index when implictly enabled
      gc: perform incremental repack when implictly enabled

Greg Hurrell (1):
      gitweb: use HEAD as secondary sort key in git_get_heads_list()

Hamza Mahfooz (3):
      grep: refactor next_match() and match_one_pattern() for external us=
e
      pretty: colorize pattern matches in commit messages
      grep/pcre2: fix an edge case concerning ascii patterns and UTF-8 da=
ta

Han-Wen Nienhuys (14):
      t6050: use git-update-ref rather than filesystem access
      t1503: mark symlink test as REFFILES
      t6120: use git-update-ref rather than filesystem access
      t3320: use git-symbolic-ref rather than filesystem access
      t2402: use ref-store test helper to create broken symlink
      t1405: use 'git reflog exists' to check reflog existence
      t1405: mark test for 'git pack-refs' as REFFILES
      t1410: mark test as REFFILES
      t7064: use update-ref -d to remove upstream branch
      t6500: use "ls -1" to snapshot ref database state
      t6001: avoid direct file system access
      refs: remove EINVAL errno output from specification of read_raw_ref=
_fn
      refs/files-backend: stop setting errno from lock_ref_oid_basic
      refs: make errno output explicit for read_raw_ref_fn

Jacob Vosmaer (2):
      pkt-line: add stdio packet write functions
      upload-pack: use stdio in send_ref callbacks

Jeff Hostetler (8):
      sparse-index: copy dir_hash in ensure_full_index()
      trace2: add trace2_child_ready() to report on background children
      simple-ipc: preparations for supporting binary messages.
      simple-ipc/ipc-win32: add trace2 debugging
      simple-ipc/ipc-win32: add Windows ACL to named pipe
      run-command: create start_bg_command
      t/helper/simple-ipc: convert test-simple-ipc to use start_bg_comman=
d
      t/perf/perf-lib.sh: remove test_times.* at the end test_perf_()

Jeff King (73):
      http: drop support for curl < 7.11.1
      http: drop support for curl < 7.16.0
      http: drop support for curl < 7.19.4
      build: clang version may not be followed by extra words
      range-diff: drop useless "offset" variable from read_patches()
      range-diff: handle unterminated lines in read_patches()
      range-diff: use ssize_t for parsed "len" in read_patches()
      apply: keep buffer/size pair in sync when parsing binary hunks
      t5323: drop mentions of "master"
      refs: drop unused "flags" parameter to lock_ref_oid_basic()
      logmsg_reencode(): warn when iconv() fails
      docs: use "character encoding" to refer to commit-object encoding
      t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
      t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
      pack-bitmap: drop repository argument from prepare_midx_bitmap_git(=
)
      pack-bitmap: drop bitmap_index argument from try_partial_reuse()
      t5562: use alarm() to interrupt timed child-wait
      t5551: test v2-to-v0 http protocol fallback
      http-backend: handle HTTP_GIT_PROTOCOL CGI variable
      docs/http-backend: mention v2 protocol
      docs/git: discuss server-side config for GIT_PROTOCOL
      docs/protocol-v2: point readers transport config discussion
      strvec: use size_t to store nr and alloc
      difftool: prepare "diff" cmdline in cmd_difftool()
      serve: rename is_command() to parse_command()
      serve: return capability "value" from get_capability()
      serve: add "receive" method for v2 capabilities table
      serve: provide "receive" function for object-format capability
      serve: provide "receive" function for session-id capability
      serve: drop "keys" strvec
      ls-refs: ignore very long ref-prefix counts
      docs/protocol-v2: clarify some ls-refs ref-prefix details
      serve: reject bogus v2 "command=3Dls-refs=3Dfoo"
      serve: reject commands used as capabilities
      ls-refs: reject unknown arguments
      t1400: avoid SIGPIPE race condition on fifo
      clone: handle unborn branch in bare repos
      grep: stop modifying buffer in strip_timestamp
      grep: stop modifying buffer in show_line()
      grep: stop modifying buffer in grep_source_1()
      grep: mark "haystack" buffers as const
      grep: store grep_source buffer as const
      http: match headers case-insensitively when redacting
      t7900: clean up some more broken refs
      t5516: don't use HEAD ref for invalid ref-deletion tests
      t5600: provide detached HEAD for corruption failures
      t5312: drop "verbose" helper
      t5312: create bogus ref as necessary
      t5312: test non-destructive repack
      t5312: be more assertive about command failure
      refs-internal.h: move DO_FOR_EACH_* flags next to each other
      refs-internal.h: reorganize DO_FOR_EACH_* flag documentation
      refs: add DO_FOR_EACH_OMIT_DANGLING_SYMREFS flag
      refs: omit dangling symrefs when using GIT_REF_PARANOIA
      refs: turn on GIT_REF_PARANOIA by default
      repack, prune: drop GIT_REF_PARANOIA settings
      ref-filter: stop setting FILTER_REFS_INCLUDE_BROKEN
      ref-filter: drop broken-ref code entirely
      refs: drop "broken" flag from for_each_fullref_in()
      test-read-midx: fix leak of bitmap_index struct
      t1006: clean up broken objects
      cat-file: mention --unordered along with --batch-all-objects
      cat-file: disable refs/replace with --batch-all-objects
      cat-file: split ordered/unordered batch-all-objects callbacks
      cat-file: use packed_object_info() for --batch-all-objects
      gpg-interface: fix leak of "line" in parse_ssh_output()
      gpg-interface: fix leak of strbufs in get_ssh_key_fingerprint()
      send-pack: complain about "expecting report" with --helper-status
      transport-helper: recognize "expecting report" error from send-pack
      submodule: drop unused sm_name parameter from append_fetch_remotes(=
)
      Documentation/Makefile: fix lint-docs mkdir dependency
      t5310: drop lib-bundle.sh include
      log: document --encoding behavior on iconv() failure

Jiang Xin (2):
      ci: new github-action for git-l10n code review
      i18n: fix typos found during l10n for git 2.34.0

Joel Klinghed (1):
      commit: restore --edit when combined with --fixup

Johannes Altmanninger (4):
      Documentation/git-status: remove impossible porcelain status DR and=
 DC
      Documentation/diff-format: state in which cases porcelain status is=
 T
      Documentation/git-status: document porcelain status T (typechange)
      Documentation/git-status: mention how to detect copies

Johannes Schindelin (24):
      tests: exercise the RUNTIME_PREFIX feature
      expand_user_path(): remove stale part of the comment
      expand_user_path(): clarify the role of the `real_home` parameter
      Use a better name for the function interpolating paths
      interpolate_path(): allow specifying paths relative to the runtime =
prefix
      maintenance: create `launchctl` configuration using a lock file
      t5520: do not use `pull.rebase=3Dpreserve`
      remote: warn about unhandled branch.<name>.rebase values
      tests: stop testing `git rebase --preserve-merges`
      pull: remove support for `--rebase=3Dpreserve`
      rebase: drop support for `--preserve-merges`
      git-svn: drop support for `--preserve-merges`
      rebase: drop the internal `rebase--interactive` command
      rebase: remove obsolete code comment
      rebase: stop mentioning the -p option in comments
      rebase: remove a no-longer-used function
      sequencer: restrict scope of a formerly public function
      commit-graph: when closing the graph, also release the slab
      pull: release packs before fetching
      run-command: prettify the `RUN_COMMAND_*` flags
      run-command: offer to close the object store before running
      run_auto_maintenance(): implicitly close the object store
      Close object store closer to spawning child processes
      ci(windows): ensure that we do not pick up random executables

Johannes Sixt (9):
      t9001: PATH must not use Windows-style paths
      lazyload.h: fix warnings about mismatching function pointer types
      t4034/cpp: actually test that operator tokens are not split
      t4034: add tests showing problematic cpp tokenizations
      userdiff-cpp: tighten word regex
      userdiff-cpp: prepare test cases with yet unsupported features
      userdiff-cpp: permit the digit-separating single-quote in numbers
      userdiff-cpp: learn the C++ spaceship operator
      userdiff-cpp: back out the digit-separators in numbers

Jonathan Tan (22):
      send-pack: fix push.negotiate with remote helper
      send-pack: fix push nego. when remote has refs
      fetch: die on invalid --negotiation-tip hash
      submodule: lazily add submodule ODBs as alternates
      grep: use submodule-ODB-as-alternate lazy-addition
      grep: typesafe versions of grep_source_init
      grep: read submodule entry with explicit repo
      grep: allocate subrepos on heap
      grep: add repository to OID grep sources
      submodule-config: pass repo upon blob config read
      t7814: show lack of alternate ODB-adding
      submodule: remove unnecessary unabsorbed fallback
      repository: support unabsorbed in repo_submodule_init
      revision: remove "submodule" from opt struct
      submodule: extract path to submodule gitdir func
      refs: plumb repo into ref stores
      refs: teach arbitrary repo support to iterators
      refs: peeling non-the_repository iterators is BUG
      merge-{ort,recursive}: remove add_submodule_odb()
      object-file: only register submodule ODB if needed
      submodule: pass repo to check_has_commit()
      submodule: trace adding submodule ODB as alternate

Josh Steadmon (2):
      connect, protocol: log negotiated protocol version
      sequencer: advise if skipping cherry-picked commit

Junio C Hamano (30):
      expand_user_path: allow in-flight topics to keep using the old name
      bisect: do not run show-branch just to show the current commit
      bisect: simplify return code from bisect_checkout()
      build: catch clang that identifies itself as "$VENDOR clang"
      userdiff: comment on the builtin patterns
      The first batch post 2.33
      The second batch
      The third batch
      apply: resolve trivial merge without hitting ll-merge with "--3way"
      hash-object: prefix_filename() returns allocated memory these days
      The fourth batch
      The fifth batch
      The sixth batch
      The seventh batch
      The eighth batch
      The ninth batch
      The tenth batch
      The eleventh batch
      Twelfth batch
      Git 2.33.1
      signature-format.txt: explain and illustrate multi-line headers
      Thirteenth batch
      The fourteenth batch
      format-patch (doc): clarify --base=3Dauto
      branch (doc): -m/-c copies config and reflog
      The fifteenth batch
      Revert "logmsg_reencode(): warn when iconv() fails"
      Git 2.34-rc0
      A few more topics before -rc1
      Git 2.34-rc1

Kaartic Sivaraam (1):
      submodule--helper: fix incorrect newlines in an error message

Kim Altintop (3):
      t5730: introduce fetch command helper
      upload-pack.c: treat want-ref relative to namespace
      docs: clarify the interaction of transfer.hideRefs and namespaces

Kyle Zhao (1):
      pack-revindex.h: correct the time complexity descriptions

L=C3=A9na=C3=AFc Huard (4):
      cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" funct=
ion
      maintenance: `git maintenance run` learned `--scheduler=3D<schedule=
r>`
      maintenance: add support for systemd timers on Linux
      maintenance: fix test t7900-maintenance.sh

Mahi Kolla (1):
      clone: set submodule.recurse=3Dtrue if submodule.stickyRecursiveClo=
ne enabled

Martin =C3=85gren (6):
      config.txt: fix typo
      git.txt: fix typo
      git-multi-pack-index.txt: change "folder" to "directory"
      gitignore.txt: change "folder" to "directory"
      gitweb.txt: change "folder" to "directory"
      git-bundle.txt: add missing words and punctuation

Marvin H=C3=A4user (1):
      send-email: avoid incorrect header propagation

Matheus Tavares (3):
      checkout: make delayed checkout respect --quiet and --no-progress
      grep: demonstrate bug with textconv attributes and submodules
      add, rm, mv: fix bug that prevents the update of non-sparse dirs

Matthias A=C3=9Fhauer (2):
      help: make sure local html page exists before calling external proc=
esses
      documentation: add documentation for 'git version'

Mickey Endito (1):
      t5582: remove spurious 'cd "$D"' line

Mike Hommey (1):
      credential: fix leak in credential_apply_config()

Miriam Rubio (3):
      t6030-bisect-porcelain: add tests to control bisect run exit cases
      t6030-bisect-porcelain: add test for bisect visualize
      bisect--helper: retire `--bisect-next-check` subcommand

Orgad Shaneh (1):
      doc: fix capitalization in "git status --porcelain=3Dv2" descriptio=
n

Patrick Steinhardt (16):
      fetch-pack: speed up loading of refs via commit graph
      revision: separate walk and unsorted flags
      connected: do not sort input revisions
      revision: stop retrieving reference twice
      commit-graph: split out function to search commit position
      revision: avoid hitting packfiles when commits are in commit-graph
      ls-refs: reuse buffer when sending refs
      fetch: skip formatting updated refs with `--quiet`
      fetch: speed up lookup of want refs via commit-graph
      fetch: avoid unpacking headers in object existence check
      connected: refactor iterator to return next object ID directly
      fetch-pack: optimize loading of refs via commit graph
      fetch: refactor fetch refs to be more extendable
      fetch: merge fetching and consuming refs
      fetch: avoid second connectivity check if we already have all objec=
ts
      update-ref: fix streaming of status updates

Philip Oakley (1):
      doc: config, tell readers of `git help --config`

Philippe Blain (3):
      test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
      test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_p=
ause'
      test-lib-functions: keep user's debugger config files and TERM in '=
debug'

Phillip Wood (22):
      t3403: fix commit authorship
      rebase --apply: restore some tests
      rebase --continue: remove .git/MERGE_MSG
      rebase -r: make 'merge -c' behave like reword
      rebase -i: add another reword test
      rebase -r: don't write .git/MERGE_MSG when fast-forwarding
      rebase -r: fix merge -c with a merge strategy
      t3407: run tests in $TEST_DIRECTORY
      t3407: use test_commit
      t3407: use test_cmp_rev
      t3407: rename a variable
      t3407: use test_path_is_missing
      t3407: strengthen rebase --abort tests
      t3407: rework rebase --quit tests
      rebase: use our standard error return value
      rebase: use lookup_commit_reference_by_name()
      rebase: dereference tags
      sequencer.c: factor out a function
      rebase: fix todo-list rereading
      sparse index: fix use-after-free bug in cache_tree_verify()
      t1092: run "rebase --apply" without "-q" in testing
      rebase -i: fix rewording with --committer-date-is-author-date

Pranit Bauva (2):
      run-command: make `exists_in_PATH()` non-static
      bisect--helper: reimplement `bisect_visualize()` shell function in =
C

Ren=C3=A9 Scharfe (36):
      compat: let git_mmap use malloc(3) directly
      xopen: explicitly report creation failures
      use xopen() to handle fatal open(2) failures
      show-branch: simplify rev_is_head()
      archive: convert queue_directory to struct object_id
      branch: allow deleting dangling branches with --force
      merge-recursive: use fspathcmp() in path_hashmap_cmp()
      range-diff: avoid segfault with -I
      setup: use xopen and xdup in sanitize_stdfds
      refs/files-backend: remove unused open mode parameter
      index-pack: use xopen in init_thread
      oidset: make oidset_size() an inline function
      midx: inline nth_midxed_pack_entry()
      packfile: convert mark_bad_packed_object() to object_id
      packfile: convert has_packed_and_bad() to object_id
      packfile: use oidset for bad objects
      compression: drop write-only core_compression_* variables
      packfile: release bad_objects in close_pack()
      test-mergesort: use strbuf_getline()
      test-mergesort: add sort subcommand
      test-mergesort: add test subcommand
      test-mergesort: add generate subcommand
      test-mergesort: add unriffle mode
      test-mergesort: add unriffle_skewed mode
      p0071: measure sorting of already sorted and reversed files
      p0071: test performance of llist_mergesort()
      mergesort: use ranks stack
      p3400: stop using tac(1)
      t3905: show failure to ignore sub-repo
      read-cache: add verify_path_internal()
      read-cache: let verify_path() reject trailing dir separators again
      test-mergesort: use repeatable random numbers
      perf: disable automatic housekeeping
      add: don't write objects with --dry-run
      gpg-interface: handle missing " with " gracefully in parse_ssh_outp=
ut()
      gpg-interface: avoid buffer overrun in parse_ssh_output()

Robert Estelle (1):
      completion: fix incorrect bash/zsh string equality check

SZEDER G=C3=A1bor (12):
      Makefile: remove archives before manipulating them with 'ar'
      column: fix parsing of the '--nl' option
      test-lib: set GIT_CEILING_DIRECTORIES to protect the surrounding re=
pository
      t1600-index: remove unnecessary redirection
      t1600-index: don't run git commands upstream of a pipe
      t1600-index: disable GIT_TEST_SPLIT_INDEX
      read-cache: look for shared index files next to the index, too
      tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
      read-cache: fix GIT_TEST_SPLIT_INDEX
      commit-graph: fix bogus counter in "Scanning merged commits" progre=
ss line
      entry: show finer-grained counter in "Filtering content" progress l=
ine
      command-list.txt: remove 'sparse-index' from main help

Sergey Organov (1):
      diff-index: restore -c/--cc options handling

Takashi Iwai (1):
      completion: tcsh: Fix regression by drop of wrapper functions

Tal Kelrich (1):
      fast-export: fix anonymized tag using original length

Tanushree Tumane (1):
      bisect--helper: reimplement `bisect_run` shell function in C

Tassilo Horn (1):
      userdiff: improve java hunk header regex

Taylor Blau (55):
      pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
      pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
      pack-bitmap-write.c: free existing bitmaps
      Documentation: describe MIDX-based bitmaps
      object-store.h: teach for_each_packed_object to ignore kept packs
      builtin/pack-objects.c: simplify add_objects_in_unpacked_packs()
      builtin/pack-objects.c: remove duplicate hash lookup
      midx: disallow running outside of a repository
      midx: fix `*.rev` cleanups with `--object-dir`
      midx: clear auxiliary .rev after replacing the MIDX
      midx: reject empty `--preferred-pack`'s
      midx: infer preferred pack when not given one
      midx: close linked MIDXs, avoid leaking memory
      midx: avoid opening multiple MIDXs when writing
      pack-bitmap.c: introduce 'bitmap_num_objects()'
      pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
      pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
      pack-bitmap.c: avoid redundant calls to try_partial_reuse
      pack-bitmap: read multi-pack bitmaps
      pack-bitmap: write multi-pack bitmaps
      t5310: move some tests to lib-bitmap.sh
      t/helper/test-read-midx.c: add --checksum mode
      t5326: test multi-pack bitmap behavior
      t5319: don't write MIDX bitmaps in t5319
      t7700: update to work with MIDX bitmap test knob
      midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
      p5310: extract full and partial bitmap tests
      p5326: perf tests for MIDX bitmaps
      bulk-checkin.c: store checksum directly
      pack-write.c: rename `.idx` files after `*.rev`
      builtin/repack.c: move `.idx` files into place last
      builtin/index-pack.c: move `.idx` files into place last
      t/helper/test-bitmap.c: add 'dump-hashes' mode
      pack-bitmap.c: propagate namehash values from existing bitmaps
      midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
      p5326: create missing 'perf-tag' tag
      p5326: don't set core.multiPackIndex unnecessarily
      p5326: generate pack bitmaps before writing the MIDX bitmap
      t5326: test propagating hashcache values
      builtin/commit-graph.c: don't accept common --[no-]progress
      builtin/multi-pack-index.c: disable top-level --[no-]progress
      midx: expose `write_midx_file_only()` publicly
      builtin/multi-pack-index.c: support `--stdin-packs` mode
      midx: preliminary support for `--refs-snapshot`
      builtin/repack.c: keep track of existing packs unconditionally
      builtin/repack.c: rename variables that deal with non-kept packs
      builtin/repack.c: extract showing progress to a variable
      builtin/repack.c: support writing a MIDX while repacking
      builtin/repack.c: make largest pack preferred
      builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
      t/perf/aggregate.perl: tolerate leading spaces
      midx.c: extract MIDX lookup by object_dir
      midx.c: lookup MIDX by object directory during expire
      midx.c: lookup MIDX by object directory during repack
      midx.c: guard against commit_lock_file() failures

Teng Long (1):
      list-objects.c: rename "traverse_trees_and_blobs" to "traverse_non_=
commits"

Todd Zullinger (1):
      doc: add bundle-format to TECH_DOCS

USAMI Kenta (1):
      userdiff: support enum keyword in PHP hunk header

Wesley Schwengle (1):
      Document `rebase.forkpoint` in rebase man page

ZheNing Hu (6):
      ref-filter: add obj-type check in grab contents
      ref-filter: add %(raw) atom
      ref-filter: --format=3D%(raw) support --perl
      ref-filter: use non-const ref_format in *_atom_parser()
      ref-filter: add %(rest) atom
      cherry-pick: use better advice message

Zoker (1):
      doc: fix syntax error and the format of printf

brian m. carlson (1):
      t5607: avoid using prerequisites to select algorithm

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (224):
      pack-objects tests: cover blindspots in stdin handling
      Makefile: move ".PHONY: cscope" near its target
      Makefile: add QUIET_GEN to "cscope" target
      pack-objects: fix segfault in --stdin-packs option
      test-lib tests: move "run_sub_test" to a new lib-subtest.sh
      Makefile: don't use "FORCE" for tags targets
      http: drop support for curl < 7.19.3 and < 7.17.0 (again)
      http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
      bundle doc: elaborate on object prerequisites
      bundle doc: elaborate on rev<->ref restriction
      bundle doc: rewrite the "DESCRIPTION" section
      bundle doc: replace "basis" with "prerequsite(s)"
      serve: mark has_capability() as static
      transport: rename "fetch" in transport_vtable to "fetch_refs"
      transport: use designated initializers
      serve: use designated initializers
      serve.[ch]: don't pass "struct strvec *keys" to commands
      serve: move transfer.advertiseSID check into session_id_advertise()
      serve.c: move version line to advertise_capabilities()
      {upload,receive}-pack tests: add --advertise-refs tests
      serve.[ch]: remove "serve_options", split up --advertise-refs code
      upload-pack: document and rename --advertise-refs
      Makefile: remove "cscope.out", not "cscope*" in cscope.out target
      Makefile: normalize clobbering & xargs for tags targets
      refs/packet: add missing BUG() invocations to reflog callbacks
      refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
      ls-remote: set packet_trace_identity(<name>)
      rebase: emit one "fatal" in "fatal: fatal: <error>"
      advice: remove use of global advice_add_embedded_repo
      advice: move advice.graftFileDeprecated squashing to commit.[ch]
      refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
      refs/files: remove unused "skip" in lock_raw_ref() too
      refs/debug: re-indent argument list for "prepare"
      refs: make repo_dwim_log() accept a NULL oid
      refs/files: add a comment about refs_reflog_exists() call
      reflog expire: don't lock reflogs using previously seen OID
      refs API: remove OID argument to reflog_expire()
      refs/files: remove unused "oid" in lock_ref_oid_basic()
      refs/files: remove unused "errno =3D=3D EISDIR" code
      refs/files: remove unused "errno !=3D ENOTDIR" condition
      refs file backend: move raceproof_create_file() here
      bundle API: start writing API documentation
      commit-graph: define common usage with a macro
      commit-graph: remove redundant handling of -h
      commit-graph: use parse_options_concat()
      multi-pack-index: refactor "goto usage" pattern
      commit-graph: early exit to "usage" on !argc
      commit-graph: show usage on "commit-graph [write|verify] garbage"
      commit-graph: show "unexpected subcommand" error
      protocol-caps.c: fix memory leak in send_info()
      mailmap.c: fix a memory leak in free_mailap_{info,entry}()
      gc: remove trailing dot from "gc.log" line
      gettext: remove optional non-standard parens in N_() definition
      bundle API: change "flags" to be "extra_index_pack_args"
      index-pack: add --progress-title option
      bundle: show progress on "unbundle"
      tr2: remove NEEDSWORK comment for "non-procfs" implementations
      tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
      tr2: stop leaking "thread_name" memory
      tr2: leave the parent list empty upon failure & don't leak memory
      tr2: do compiler enum check in trace2_collect_process_info()
      tr2: log N parent process names on Linux
      send-email: fix a "first config key wins" regression in v2.33.0
      Makefile: remove the check_bindir script
      pack-write: skip *.rev work when not writing *.rev
      pack.h: line-wrap the definition of finish_tmp_packfile()
      pack-write: refactor renaming in finish_tmp_packfile()
      index-pack: refactor renaming in final()
      pack-write: split up finish_tmp_packfile() function
      pack-objects: rename .idx files into place after .bitmap files
      help: correct the usage string in -h and documentation
      INSTALL: don't mention the "curl" executable at all
      INSTALL: reword and copy-edit the "libcurl" section
      git-submodule: remove unused is_zero_oid() function
      git-sh-setup: remove unused "pull with rebase" message
      git-bisect: remove unused SHA-1 $x40 shell variable
      test-lib: remove unused $_x40 and $_z40 variables
      test-tool run-command: fix flip-flop init pattern
      gc: remove unused launchctl_get_uid() call
      parse-options API users: align usage output in C-strings
      send-pack: properly use parse_options() API for usage string
      git rev-parse --parseopt tests: add more usagestr tests
      difftool: prepare "struct child_process" in cmd_difftool()
      difftool: use run_command() API in run_file_diff()
      parse-options API: remove OPTION_ARGUMENT feature
      INSTALL: mention that we need libcurl 7.19.4 or newer to build
      Makefile: drop support for curl < 7.9.8 (again)
      http: drop support for curl < 7.18.0 (again)
      http: correct version check for CURL_HTTP_VERSION_2
      http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
      http: centralize the accounting of libcurl dependencies
      http: don't hardcode the value of CURL_SOCKOPT_OK
      wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
      environment.c: remove test-specific "ignore_untracked..." variable
      read-cache & fetch-negotiator: check "enum" values in switch()
      repo-settings.c: simplify the setup
      repository.h: don't use a mix of int and bitfields
      Makefile: clean .depend dirs under COMPUTE_HEADER_DEPENDENCIES !=3D=
 yes
      parse-options: properly align continued usage output
      test-lib tests: split up "write and run" into two functions
      test-lib tests: don't provide a description for the sub-tests
      test-lib tests: avoid subshell for "test_cmp" for readability
      test-lib tests: refactor common part of check_sub_test_lib_test*()
      test-lib tests: assert 1 exit code, not non-zero
      test-lib tests: get rid of copy/pasted mock test code
      Makefile: make the "sparse" target non-.PHONY
      Makefile: make COMPUTE_HEADER_DEPENDENCIES=3Dauto work with DEVOPTS=
=3Dpedantic
      help: correct usage & behavior of "git help --guides"
      help tests: add test for --config output
      help: correct logic error in combining --all and --config
      help: correct logic error in combining --all and --guides
      help: simplify by moving to OPT_CMDMODE()
      help tests: test --config-for-completion option & output
      help / completion: make "git help" do the hard work
      help: move column config discovery to help.c library
      Makefile: add SANITIZE=3Dleak flag to GIT-BUILD-OPTIONS
      tests: add a test mode for SANITIZE=3Dleak, run it in CI
      bundle: remove ignored & undocumented "--verbose" flag
      Makefile: mark "check" target as .PHONY
      Makefile: stop hardcoding {command,config}-list.h
      Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
      Makefile: remove an out-of-date comment
      hook.[ch]: move find_hook() from run-command.c to hook.c
      hook.c users: use "hook_exists()" instead of "find_hook()"
      hook-list.h: add a generated list of hooks, like config-list.h
      http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors
      Makefile: pass -Wno-pendantic under GENERATE_COMPILATION_DATABASE=3D=
yes
      submodule-config.h: remove unused SUBMODULE_INIT macro
      *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
      *.h _INIT macros: don't specify fields equal to 0
      *.h: move some *_INIT to designated initializers
      cbtree.h: define cb_init() in terms of CBTREE_INIT
      daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
      builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT ma=
cro
      string-list.[ch]: remove string_list_init() compatibility function
      config.c: remove unused git_config_key_is_valid()
      refs.[ch]: remove unused ref_storage_backend_exists()
      refs/ref-cache.[ch]: remove unused remove_entry_from_dir()
      refs/ref-cache.[ch]: remove unused add_ref_entry()
      refs/ref-cache.c: remove "mkdir" parameter from find_containing_dir=
()
      refs/ref-cache.[ch]: remove "incomplete" from create_dir_entry()
      parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
      urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
      builtin/remote.c: add and use a REF_STATES_INIT
      builtin/remote.c: add and use SHOW_INFO_INIT
      builtin.h: remove cmd_tar_tree() declaration
      grep.h: remove unused grep_threads_ok() declaration
      log-tree.h: remove unused function declarations
      config.h: remove unused git_config_get_untracked_cache() declaratio=
n
      fsck tests: add test for fsck-ing an unknown type
      fsck tests: refactor one test to use a sub-repo
      fsck tests: test current hash/type mismatch behavior
      fsck tests: test for garbage appended to a loose object
      cat-file tests: move bogus_* variable declarations earlier
      cat-file tests: test for missing/bogus object with -t, -s and -p
      cat-file tests: add corrupt loose object test
      cat-file tests: test for current --allow-unknown-type behavior
      object-file.c: don't set "typep" when returning non-zero
      object-file.c: return -1, not "status" from unpack_loose_header()
      object-file.c: make parse_loose_header_extended() public
      object-file.c: simplify unpack_loose_short_header()
      object-file.c: use "enum" return type for unpack_loose_header()
      object-file.c: return ULHR_TOO_LONG on "header too long"
      object-file.c: stop dying in parse_loose_header()
      fsck: don't hard die on invalid object types
      fsck: report invalid object type-path combinations
      unpack-trees: don't leak memory in verify_clean_subdirectory()
      tests: fix a memory leak in test-prio-queue.c
      tests: fix a memory leak in test-parse-options.c
      tests: fix a memory leak in test-oidtree.c
      tests: fix test-oid-array leak, test in SANITIZE=3Dleak
      ls-files: fix a trivial dir_clear() leak
      ls-files: add missing string_list_clear()
      merge: add missing strbuf_release()
      parse-options.[ch]: consistently use "enum parse_opt_flags"
      parse-options.[ch]: consistently use "enum parse_opt_result"
      parse-options.c: use exhaustive "case" arms for "enum parse_opt_res=
ult"
      parse-options.h: make the "flags" in "struct option" an enum
      parse-options.c: move optname() earlier in the file
      commit-graph: stop using optname()
      parse-options.[ch]: make opt{bug,name}() "static"
      parse-options tests: test optname() output
      parse-options: change OPT_{SHORT,UNSET} to an enum
      unwritable tests: assert exact error output
      commit: fix duplication regression in permission error output
      leak tests: run various built-in tests in t00*.sh SANITIZE=3Dleak
      leak tests: run various "test-tool" tests in t00*.sh SANITIZE=3Dlea=
k
      leak tests: mark all ls-tree tests as passing with SANITIZE=3Dleak
      leak tests: mark all trace2 tests as passing with SANITIZE=3Dleak
      leak tests: mark all checkout-index tests as passing with SANITIZE=3D=
leak
      leak tests: mark some ls-files tests as passing with SANITIZE=3Dlea=
k
      leak tests: mark some read-tree tests as passing with SANITIZE=3Dle=
ak
      leak tests: mark various "generic" tests as passing with SANITIZE=3D=
leak
      leak tests: mark some misc tests as passing with SANITIZE=3Dleak
      sequencer: add a "goto cleanup" to do_reset()
      sequencer: fix a memory leak in do_reset()
      test-lib.sh: de-duplicate error() teardown code
      test-lib.sh: use "Bail out!" syntax on bad SANITIZE=3Dleak use
      test-lib.sh: try to re-chmod & retry on failed trash removal
      commit-graph tests: fix error-hiding graph_git_two_modes() helper
      commit-graph tests: fix another graph_git_two_modes() helper
      commit-graph: don't consider "replace" objects with "verify"
      "lib-diff" tests: make "README" and "COPYING" test data smaller
      tests: stop using top-level "README" and "COPYING" files
      doc lint: fix error-hiding regression
      doc lint: emit errors on STDERR
      doc build: speed up "make lint-docs"
      doc lint: make "lint-docs" non-.PHONY
      pkt-line.[ch]: remove unused packet_buf_write_len()
      pkt-line.[ch]: remove unused packet_read_line_buf()
      git config doc: fix recent ASCIIDOC formatting regression
      tag: use a "goto cleanup" pattern, leak less memory
      ref-filter API user: add and use a ref_sorting_release()
      branch: use ref_sorting_release()
      git-sh-i18n: remove unused eval_ngettext()
      git-sh-setup: remove messaging supporting --preserve-merges
      Makefile: remove redundant GIT-CFLAGS dependency from "sparse"
      config.c: don't leak memory in handle_path_include()
      grep: prefer "struct grep_opt" over its "void *" equivalent
      grep: use object_array_clear() in cmd_grep()
      grep: fix a "path_list" memory leak
      clone: fix a memory leak of the "git_dir" variable
      submodule--helper: fix small memory leaks
      reflog: free() ref given to us by dwim_log()

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (3):
      t6300: don't run cat-file on non-existent object
      t6300: check for cat-file exit status code
      diff-lib: ignore paths that are outside $cwd if --relative asked


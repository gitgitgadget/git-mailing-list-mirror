Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96262C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiAOCTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 21:19:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55726 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiAOCTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 21:19:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ECE016920D;
        Fri, 14 Jan 2022 21:19:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=fgQs+02SjT56Wlv8ztJHrQM2U
        AprxabeA83jNhxAZM0=; b=ZHGMzvNUp590nP5cfL7Ph55i1HKcwcTpQkM1Mb6tV
        puLLhrNJiSQYOKxmvPNoarSEgOw6P1MSkB2+ELFSeAJItQ3629BBqVKyH5y7O4aC
        dQk3g39MDDkJNe6JwgagtfD03BOGbsypYxg4h8vgoNZwx+ayAdHCnk1fmF+31PSz
        lQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1690E16920B;
        Fri, 14 Jan 2022 21:19:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BE84169208;
        Fri, 14 Jan 2022 21:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.35.0-rc1
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Fri, 14 Jan 2022 18:18:59 -0800
Message-ID: <xmqq35lp68rw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80544222-75A9-11EC-97A5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.35.0-rc1 is now available for testing at
the usual places.  It is comprised of 467 non-merge commits since
v2.34.0, contributed by 80 people, 32 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.35.0-rc1' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.34.0 are as follows.
Welcome to the Git development community!

  AJ Henderson, Alex Waite, Baruch Burstein, Calbabreaker, Calvin
  Wan, Christoph Reiter, Clemens Fruhwirth, Danial Alihosseini,
  Dotan Cohen, Enzo Matsumiya, Erwin Villejo, Gustave Granroth,
  Hans Krentel (hakre), Ivan Frade, James Limbouris, Jan Pokorn=C3=BD,
  Joel Holdsworth, John Burnett, John Cai, Josh Rampersad, Kashav
  Madan, Lessley Dennington, Matt Cooper, Matthew John Cheetham,
  Mike Marcelais, Mugdha Pattnaik, Nikita Bobko, Robin Jarry,
  Thiago Perrotta, Thomas Wei=C3=9Fschuh, William Sprent, and =E5=BE=90=E6=
=B2=9B=E6=96=87
  (Aleen).

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alex Henrie, Anders Kaseorg,
  Bagas Sanjaya, brian m. carlson, Carlo Marcelo Arenas Bel=C3=B3n,
  Derrick Stolee, Elijah Newren, Eli Schwartz, Eric Sunshine,
  Eric Wong, Fabian Stelzer, Glen Choo, Greg Hurrell, Han-Wen
  Nienhuys, Jacob Vosmaer, Jean-No=C3=ABl Avila, Jeff King, Jerry
  Zhang, Jiang Xin, Johannes Altmanninger, Johannes Schindelin,
  Johannes Sixt, Jonathan Tan, Josh Steadmon, Junio C Hamano,
  L=C3=A9na=C3=AFc Huard, Linus Torvalds, Marc Strapetz, Martin =C3=85gre=
n,
  Matthias A=C3=9Fhauer, Mike Hommey, Neeraj Singh, =C3=98ystein Walle,
  Patrick Steinhardt, Philip Oakley, Philippe Blain, Phillip Wood,
  Ralf Thielow, Randall S. Becker, Ren=C3=A9 Scharfe, Robert Estelle,
  Sergey Organov, SZEDER G=C3=A1bor, Taylor Blau, Teng Long, Victoria
  Dye, and Yoichi Nakayama.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git 2.35 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since Git 2.34
----------------------

Backward compatibility warts

 * "_" is now treated as any other URL-valid characters in an URL when
   matching the per-URL configuration variable names.

 * The color palette used by "git grep" has been updated to match that
   of GNU grep.


UI, Workflows & Features

 * "git status --porcelain=3Dv2" now show the number of stash entries
   with --show-stash like the normal output does.

 * "git stash" learned the "--staged" option to stash away what has
   been added to the index (and nothing else).

 * "git var GIT_DEFAULT_BRANCH" is a way to see what name is used for
   the newly created branch if "git init" is run.

 * Various operating modes of "git reset" have been made to work
   better with the sparse index.

 * "git submodule deinit" for a submodule whose .git metadata
   directory is embedded in its working tree refused to work, until
   the submodule gets converted to use the "absorbed" form where the
   metadata directory is stored in superproject, and a gitfile at the
   top-level of the working tree of the submodule points at it.  The
   command is taught to convert such submodules to the absorbed form
   as needed.

 * The completion script (in contrib/) learns that the "--date"
   option of commands from the "git log" family takes "human" and
   "auto" as valid values.

 * "Zealous diff3" style of merge conflict presentation has been added.

 * The "git log --format=3D%(describe)" placeholder has been extended to
   allow passing selected command-line options to the underlying "git
   describe" command.

 * "default" and "reset" have been added to our color palette.

 * The cryptographic signing using ssh keys can specify literal keys
   for keytypes whose name do not begin with the "ssh-" prefix by
   using the "key::" prefix mechanism (e.g. "key::ecdsa-sha2-nistp256").

 * "git fetch" without the "--update-head-ok" option ought to protect
   a checked out branch from getting updated, to prevent the working
   tree that checks it out to go out of sync.  The code was written
   before the use of "git worktree" got widespread, and only checked
   the branch that was checked out in the current worktree, which has
   been updated.

 * "git name-rev" has been tweaked to give output that is shorter and
   easier to understand.

 * "git apply" has been taught to ignore a message without a patch
   with the "--allow-empty" option.  It also learned to honor the
   "--quiet" option given from the command line.

 * The "init" and "set" subcommands in "git sparse-checkout" have been
   unified for a better user experience and performance.

 * Many git commands that deal with working tree files try to remove a
   directory that becomes empty (i.e. "git switch" from a branch that
   has the directory to another branch that does not would attempt
   remove all files in the directory and the directory itself).  This
   drops users into an unfamiliar situation if the command was run in
   a subdirectory that becomes subject to removal due to the command.
   The commands have been taught to keep an empty directory if it is
   the directory they were started in to avoid surprising users.

 * "git am" learns "--empty=3D(stop|drop|keep)" option to tweak what is
   done to a piece of e-mail without a patch in it.

 * The default merge message prepared by "git merge" records the name
   of the current branch; the name can be overridden with a new option
   to allow users to pretend a merge is made on a different branch.

 * The way "git p4" shows file sizes in its output has been updated to
   use human-readable units.

 * "git -c branch.autosetupmerge=3Dinherit branch new old" makes "new"
   to have the same upstream as the "old" branch, instead of marking
   "old" itself as its upstream.


Performance, Internal Implementation, Development Support etc.

 * The use of errno as a means to carry the nature of error in the ref
   API implementation has been reworked and reduced.

 * Teach and encourage first-time contributors to this project to
   state the base commit when they submit their topic.

 * The command line completion for "git send-email" options have been
   tweaked to make it easier to keep it in sync with the command itself.

 * Ensure that the sparseness of the in-core index matches the
   index.sparse configuration specified by the repository immediately
   after the on-disk index file is read.

 * Code clean-up to eventually allow information on remotes defined
   for an arbitrary repository to be read.

 * Build optimization.

 * Tighten code for testing pack-bitmap.

 * Weather balloon to break people with compilers that do not support
   C99.

 * The "reftable" backend for the refs API, without integrating into
   the refs subsystem, has been added.

 * More tests are marked as leak-free.

 * The test framework learns to list unsatisfied test prerequisites,
   and optionally error out when prerequisites that are expected to be
   satisfied are not.

 * The default setting for trace2 event nesting was too low to cause
   test failures, which is worked around by bumping it up in the test
   framework.

 * Drop support for TravisCI and update test workflows at GitHub.

 * Many tests that used to need GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
   mechanism to force "git" to use 'master' as the default name for
   the initial branch no longer need it; the use of the mechanism from
   them have been removed.

 * Allow running our tests while disabling fsync.

 * Document the parameters given to the reflog entry iterator callback
   functions.
   (merge e6e94f34b2 jc/reflog-iterator-callback-doc later to maint).

 * The test helper for refs subsystem learned to write bogus and/or
   nonexistent object name to refs to simulate error situations we
   want to test Git in.

 * "diff --histogram" optimization.

 * Weather balloon to find compilers that do not grok variable
   declaration in the for() loop.

 * diff and blame commands have been taught to work better with sparse
   index.

 * The chainlint test script linter in the test suite has been updated.

 * The DEVELOPER=3Dyes build uses -std=3Dgnu99 now.

 * "git format-patch" uses a single rev_info instance and then exits.
   Mark the structure with UNLEAK() macro to squelch leak sanitizer.

 * New interface into the tmp-objdir API to help in-core use of the
   quarantine feature.

 * Broken &&-chains in the test scripts have been corrected.

 * The RCS keyword substitution in "git p4" used to be done assuming
   that the contents are UTF-8 text, which can trigger decoding
   errors.  We now treat the contents as a bytestring for robustness
   and correctness.

 * The conditions to choose different definitions of the FLEX_ARRAY
   macro for vendor compilers has been simplified to make it easier to
   maintain.

 * Correctness and performance update to "diff --color-moved" feature.

 * "git upload-pack" (the other side of "git fetch") used a 8kB buffer
   but most of its payload came on 64kB "packets".  The buffer size
   has been enlarged so that such a packet fits.

 * "git fetch" and "git pull" are now declared sparse-index clean.
   Also "git ls-files" learns the "--sparse" option to help debugging.

 * Similar message templates have been consolidated so that
   translators need to work on fewer number of messages.


Fixes since v2.34
-----------------

 * "git grep" looking in a blob that has non-UTF8 payload was
   completely broken when linked with certain versions of PCREv2
   library in the latest release.

 * Other code cleanup, docfix, build fix, etc.

 * "git pull" with any strategy when the other side is behind us
   should succeed as it is a no-op, but doesn't.

 * An earlier change in 2.34.0 caused JGit application (that abused
   GIT_EDITOR mechanism when invoking "git config") to get stuck with
   a SIGTTOU signal; it has been reverted.

 * An earlier change that broke .gitignore matching has been reverted.

 * Things like "git -c branch.sort=3Dbogus branch new HEAD", i.e. the
   operation modes of the "git branch" command that do not need the
   sort key information, no longer errors out by seeing a bogus sort
   key.
   (merge 98e7ab6d42 jc/fix-ref-sorting-parse later to maint).

 * The compatibility implementation for unsetenv(3) were written to
   mimic ancient, non-POSIX, variant seen in an old glibc; it has been
   changed to return an integer to match the more modern era.
   (merge a38989bd5b jc/unsetenv-returns-an-int later to maint).

 * The clean/smudge conversion code path has been prepared to better
   work on platforms where ulong is narrower than size_t.
   (merge 596b5e77c9 mc/clean-smudge-with-llp64 later to maint).

 * Redact the path part of packfile URI that appears in the trace output.
   (merge 0ba558ffb1 if/redact-packfile-uri later to maint).

 * CI has been taught to catch some Unicode directional formatting
   sequence that can be used in certain mischief.
   (merge 0e7696c64d js/ci-no-directional-formatting later to maint).

 * The "--date=3Dformat:<strftime>" gained a workaround for the lack of
   system support for a non-local timezone to handle "%s" placeholder.
   (merge 9b591b9403 jk/strbuf-addftime-seconds-since-epoch later to main=
t).

 * The "merge" subcommand of "git jump" (in contrib/) silently ignored
   pathspec and other parameters.
   (merge 67ba13e5a4 jk/jump-merge-with-pathspec later to maint).

 * The code to decode the length of packed object size has been
   corrected.
   (merge 34de5b8eac jt/pack-header-lshift-overflow later to maint).

 * The advice message given by "git pull" when the user hasn't made a
   choice between merge and rebase still said that the merge is the
   default, which no longer is the case.  This has been corrected.
   (merge 71076d0edd ah/advice-pull-has-no-preference-between-rebase-and-=
merge later to maint).

 * "git fetch", when received a bad packfile, can fail with SIGPIPE.
   This wasn't wrong per-se, but we now detect the situation and fail
   in a more predictable way.
   (merge 2a4aed42ec jk/fetch-pack-avoid-sigpipe-to-index-pack later to m=
aint).

 * The function to cull a child process and determine the exit status
   had two separate code paths for normal callers and callers in a
   signal handler, and the latter did not yield correct value when the
   child has caught a signal.  The handling of the exit status has
   been unified for these two code paths.  An existing test with
   flakiness has also been corrected.
   (merge 5263e22cba jk/t7006-sigpipe-tests-fix later to maint).

 * When a non-existent program is given as the pager, we tried to
   reuse an uninitialized child_process structure and crashed, which
   has been fixed.
   (merge f917f57f40 em/missing-pager later to maint).

 * The single-key-input mode in "git add -p" had some code to handle
   keys that generate a sequence of input via ReadKey(), which did not
   handle end-of-file correctly, which has been fixed.
   (merge fc8a8126df cb/add-p-single-key-fix later to maint).

 * "git rebase -x" added an unnecessary 'exec' instructions before
   'noop', which has been corrected.
   (merge cc9dcdee61 en/rebase-x-fix later to maint).

 * When the "git push" command is killed while the receiving end is
   trying to report what happened to the ref update proposals, the
   latter used to die, due to SIGPIPE.  The code now ignores SIGPIPE
   to increase our chances to run the post-receive hook after it
   happens.
   (merge d34182b9e3 rj/receive-pack-avoid-sigpipe-during-status-reportin=
g later to maint).

 * "git worktree add" showed "Preparing worktree" message to the
   standard output stream, but when it failed, the message from die()
   went to the standard error stream.  Depending on the order the
   stdio streams are flushed at the program end, this resulted in
   confusing output.  It has been corrected by sending all the chatty
   messages to the standard error stream.
   (merge b50252484f es/worktree-chatty-to-stderr later to maint).

 * Coding guideline document has been updated to clarify what goes to
   standard error in our system.
   (merge e258eb4800 es/doc-stdout-vs-stderr later to maint).

 * The sparse-index/sparse-checkout feature had a bug in its use of
   the matching code to determine which path is in or outside the
   sparse checkout patterns.
   (merge 8c5de0d265 ds/sparse-deep-pattern-checkout-fix later to maint).

 * "git rebase -x" by mistake started exporting the GIT_DIR and
   GIT_WORK_TREE environment variables when the command was rewritten
   in C, which has been corrected.
   (merge 434e0636db en/rebase-x-wo-git-dir-env later to maint).

 * When "git log" implicitly enabled the "decoration" processing
   without being explicitly asked with "--decorate" option, it failed
   to read and honor the settings given by the "--decorate-refs"
   option.

 * "git fetch --set-upstream" did not check if there is a current
   branch, leading to a segfault when it is run on a detached HEAD,
   which has been corrected.
   (merge 17baeaf82d ab/fetch-set-upstream-while-detached later to maint)=
.

 * Among some code paths that ask an yes/no question, only one place
   gave a prompt that looked different from the others, which has been
   updated to match what the others create.
   (merge 0fc8ed154c km/help-prompt-fix later to maint).

 * "git log --invert-grep --author=3D<name>" used to exclude commits
   written by the given author, but now "--invert-grep" only affects
   the matches made by the "--grep=3D<pattern>" option.
   (merge 794c000267 rs/log-invert-grep-with-headers later to maint).

 * "git grep --perl-regexp" failed to match UTF-8 characters with
   wildcard when the pattern consists only of ASCII letters, which has
   been corrected.
   (merge 32e3e8bc55 rs/pcre2-utf later to maint).

 * Certain sparse-checkout patterns that are valid in non-cone mode
   led to segfault in cone mode, which has been corrected.

 * Use of certain "git rev-list" options with "git fast-export"
   created nonsense results (the worst two of which being "--reverse"
   and "--invert-grep --grep=3D<foo>").  The use of "--first-parent" is
   made to behave a bit more sensible than before.
   (merge 726a228dfb ws/fast-export-with-revision-options later to maint)=
.

 * Perf tests were run with end-user's shell, but it has been
   corrected to use the shell specified by $TEST_SHELL_PATH.
   (merge 9ccab75608 ja/perf-use-specified-shell later to maint).

 * Fix dependency rules to generate hook-list.h header file.
   (merge d3fd1a6667 ab/makefile-hook-list-dependency-fix later to maint)=
.

 * "git stash" by default triggers its "push" action, but its
   implementation also made "git stash -h" to show short help only for
   "git stash push", which has been corrected.
   (merge ca7990cea5 ab/do-not-limit-stash-help-to-push later to maint).

 * "git apply --3way" bypasses the attempt to do a three-way
   application in more cases to address the regression caused by the
   recent change to use direct application as a fallback.
   (merge 34d607032c jz/apply-3-corner-cases later to maint).

 * Fix performance-releated bug in "git subtree" (in contrib/).
   (merge 3ce8888fb4 jl/subtree-check-parents-argument-passing-fix later =
to maint).

 * Extend the guidance to choose the base commit to build your work
   on, and hint/nudge contributors to read others' changes.
   (merge fdfae830f8 jc/doc-submitting-patches-choice-of-base later to ma=
int).

 * A corner case bug in the ort merge strategy has been corrected.
   (merge d30126c20d en/merge-ort-renorm-with-rename-delete-conflict-fix =
later to maint).

 * "git stash apply" forgot to attempt restoring untracked files when
   it failed to restore changes to tracked ones.
   (merge 71cade5a0b en/stash-df-fix later to maint).

 * Calling dynamically loaded functions on Windows has been corrected.
   (merge 4a9b204920 ma/windows-dynload-fix later to maint).

 * Some lockfile code called free() in signal-death code path, which
   has been corrected.
   (merge 58d4d7f1c5 ps/lockfile-cleanup-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 74db416c9c cw/protocol-v2-doc-fix later to maint).
   (merge f9b2b6684d ja/doc-cleanup later to maint).
   (merge 7d1b866778 jc/fix-first-object-walk later to maint).
   (merge 538ac74604 js/trace2-avoid-recursive-errors later to maint).
   (merge 152923b132 jk/t5319-midx-corruption-test-deflake later to maint=
).
   (merge 9081a421a6 ab/checkout-branch-info-leakfix later to maint).
   (merge 42c456ff81 rs/mergesort later to maint).
   (merge ad506e6780 tl/midx-docfix later to maint).
   (merge bf5b83fd8a hk/ci-checkwhitespace-commentfix later to maint).
   (merge 49f1eb3b34 jk/refs-g11-workaround later to maint).
   (merge 7d3fc7df70 jt/midx-doc-fix later to maint).
   (merge 7b089120d9 hn/create-reflog-simplify later to maint).
   (merge 9e12400da8 cb/mingw-gmtime-r later to maint).
   (merge 0bf0de6cc7 tb/pack-revindex-on-disk-cleanup later to maint).
   (merge 2c68f577fc ew/cbtree-remove-unused-and-broken-cb-unlink later t=
o maint).
   (merge eafd6e7e55 ab/die-with-bug later to maint).
   (merge 91028f7659 jc/grep-patterntype-default-doc later to maint).
   (merge 47ca93d071 ds/repack-fixlets later to maint).
   (merge e6a9bc0c60 rs/t4202-invert-grep-test-fix later to maint).
   (merge deb5407a42 gh/gpg-doc-markup-fix later to maint).
   (merge 999bba3e0b rs/daemon-plug-leak later to maint).
   (merge 786eb1ba39 js/l10n-mention-ngettext-early-in-readme later to ma=
int).
   (merge 2f12b31b74 ab/makefile-msgfmt-wo-stats later to maint).
   (merge 0517f591ca fs/gpg-unknown-key-test-fix later to maint).
   (merge 97d6fb5a1f ma/header-dup-cleanup later to maint).

----------------------------------------------------------------

Changes since v2.34.0 are as follows:

Alex Henrie (1):
      pull: don't say that merge is "the default strategy"

Anders Kaseorg (8):
      fetch: lowercase error messages
      receive-pack: lowercase error messages
      branch: lowercase error messages
      worktree: simplify find_shared_symref() memory ownership model
      fetch: protect branches checked out in all worktrees
      receive-pack: clean dead code from update_worktree()
      receive-pack: protect current branch for bare repository worktree
      branch: protect branches checked out in all worktrees

Bagas Sanjaya (1):
      branch: missing space fix at line 313

Calvin Wan (1):
      protocol-v2.txt: align delim-pkt spec with usage

Carlo Marcelo Arenas Bel=C3=B3n (4):
      test-genzeros: allow more than 2G zeros in Windows
      test-lib: add prerequisite for 64-bit platforms
      mingw: avoid fallback for {local,gm}time_r()
      add -p: avoid use of undefined $key when ReadKey -> EOF

Derrick Stolee (19):
      dir: revert "dir: select directories correctly"
      test-lib.sh: set GIT_TRACE2_EVENT_NESTING
      t/t*: remove custom GIT_TRACE2_EVENT_NESTING
      scalar: 'register' sets recommended config and starts maintenance
      scalar: 'unregister' stops background maintenance
      scalar: implement 'scalar list'
      scalar: implement the `run` command
      t1092: add deeper changes during a checkout
      unpack-trees: use traverse_path instead of name
      repack: respect kept objects with '--write-midx -b'
      repack: make '--quiet' disable progress
      fetch/pull: use the sparse index
      ls-files: add --sparse option
      t1092: replace 'read-cache --table' with 'ls-files --sparse'
      t1091/t3705: remove 'test-tool read-cache --table'
      test-read-cache: remove --table, --expand options
      sparse-checkout: fix segfault on malformed patterns
      sparse-checkout: fix OOM error with mixed patterns
      sparse-checkout: refuse to add to bad patterns

Eli Schwartz (3):
      pretty.c: rework describe options parsing for better extensibility
      pretty: add tag option to %(describe)
      pretty: add abbrev option to %(describe)

Elijah Newren (28):
      sequencer: avoid adding exec commands for non-commit creating comma=
nds
      update documentation for new zdiff3 conflictStyle
      name-rev: prefer shorter names over following merges
      sequencer: do not export GIT_DIR and GIT_WORK_TREE for 'exec'
      t2501: add various tests for removing the current working directory
      setup: introduce startup_info->original_cwd
      unpack-trees: refuse to remove startup_info->original_cwd
      unpack-trees: add special cwd handling
      symlinks: do not include startup_info->original_cwd in dir removal
      clean: do not attempt to remove startup_info->original_cwd
      rebase: do not attempt to remove startup_info->original_cwd
      stash: do not attempt to remove startup_info->original_cwd
      dir: avoid incidentally removing the original_cwd in remove_path()
      dir: new flag to remove_dir_recurse() to spare the original_cwd
      t2501: simplify the tests since we can now assume desired behavior
      sparse-checkout: pass use_stdin as a parameter instead of as a glob=
al
      sparse-checkout: break apart functions for sparse_checkout_(set|add=
)
      sparse-checkout: add sanity-checks on initial sparsity state
      sparse-checkout: disallow --no-stdin as an argument to set
      sparse-checkout: split out code for tweaking settings config
      sparse-checkout: enable `set` to initialize sparse-checkout mode
      sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
      git-sparse-checkout.txt: update to document init/set/reapply change=
s
      Documentation: clarify/correct a few sparsity related statements
      clone: avoid using deprecated `sparse-checkout init`
      sparse-checkout: remove stray trailing space
      merge-ort: fix bug with renormalization and rename/delete conflicts
      stash: do not return before restoring untracked files

Enzo Matsumiya (1):
      pager: fix crash when pager program doesn't exist

Eric Sunshine (38):
      worktree: stop being overly intimate with run_command() internals
      CodingGuidelines: document which output goes to stdout vs. stderr
      worktree: send "chatty" messages to stderr
      git-worktree.txt: add missing `-v` to synopsis for `worktree list`
      t/lib-pager: use sane_unset() to avoid breaking &&-chain
      t1010: fix unnoticed failure on Windows
      t1020: avoid aborting entire test script when one test fails
      t4202: clarify intent by creating expected content less cleverly
      t5516: drop unnecessary subshell and command invocation
      t6300: make `%(raw:size) --shell` test more robust
      t9107: use shell parameter expansion to avoid breaking &&-chain
      tests: simplify construction of large blocks of text
      tests: use test_write_lines() to generate line-oriented output
      tests: fix broken &&-chains in compound statements
      tests: fix broken &&-chains in `$(...)` command substitutions
      tests: fix broken &&-chains in `{...}` groups
      tests: apply modern idiom for signaling test failure
      tests: apply modern idiom for exiting loop upon failure
      tests: simplify by dropping unnecessary `for` loops
      t0000-t3999: detect and signal failure within loop
      t4000-t4999: detect and signal failure within loop
      t5000-t5999: detect and signal failure within loop
      t6000-t9999: detect and signal failure within loop
      t/chainlint/*.test: don't use invalid shell syntax
      t/chainlint/*.test: fix invalid test cases due to mixing quote type=
s
      t/chainlint/*.test: generalize self-test commentary
      t/chainlint/one-liner: avoid overly intimate chainlint.sed knowledg=
e
      t/Makefile: optimize chainlint self-test
      chainlint.sed: improve ?!AMP?! placement accuracy
      chainlint.sed: improve ?!SEMI?! placement accuracy
      chainlint.sed: tolerate harmless ";" at end of last line in block
      chainlint.sed: drop unnecessary distinction between ?!AMP?! and ?!S=
EMI?!
      chainlint.sed: drop subshell-closing ">" annotation
      chainlint.sed: make here-doc "<<-" operator recognition more POSIX-=
like
      chainlint.sed: don't mistake `<< word` in string as here-doc operat=
or
      chainlint.sed: stop throwing away here-doc tags
      chainlint.sed: swallow comments consistently
      chainlint.sed: stop splitting "(..." into separate lines "(" and ".=
.."

Eric Wong (2):
      tests: disable fsync everywhere
      cbtree: remove broken and unused cb_unlink

Erwin Villejo (1):
      pull: should be noop when already-up-to-date

Fabian Stelzer (15):
      ssh signing: support non ssh-* keytypes
      ssh signing: make sign/amend test more resilient
      test-lib: show missing prereq summary
      test-lib: introduce required prereq for test runs
      test-lib: make BAIL_OUT() work in tests and prereq
      t/fmt-merge-msg: do not redirect stderr
      t/fmt-merge-msg: make gpgssh tests more specific
      ssh signing: use sigc struct to pass payload
      ssh signing: add key lifetime test prereqs
      ssh signing: make verify-commit consider key lifetime
      ssh signing: make git log verify key lifetime
      ssh signing: make verify-tag consider key lifetime
      ssh signing: make fmt-merge-msg consider key lifetime
      ssh signing: verify ssh-keygen in test prereq
      t/gpg: simplify test for unknown key

Glen Choo (5):
      t5516: add test case for pushing remote refspecs
      remote: move static variables into per-repository struct
      remote: use remote_state parameter internally
      remote: remove the_repository->remote_state from static methods
      remote: die if branch is not found in repository

Greg Hurrell (1):
      docs: add missing colon to Documentation/config/gpg.txt

Han-Wen Nienhuys (49):
      hash.h: provide constants for the hash IDs
      reftable: add LICENSE
      reftable: add error related functionality
      reftable: utility functions
      reftable: add blocksource, an abstraction for random access reads
      reftable: (de)serialization for the polymorphic record type.
      Provide zlib's uncompress2 from compat/zlib-compat.c
      reftable: reading/writing blocks
      reftable: a generic binary tree implementation
      reftable: write reftable files
      reftable: generic interface to tables
      reftable: read reftable files
      reftable: reftable file level tests
      reftable: add a heap-based priority queue for reftable records
      reftable: add merged table view
      reftable: implement refname validation
      reftable: implement stack, a mutable database of reftable files.
      reftable: add dump utility
      Add "test-tool dump-reftable" command.
      branch tests: test for errno propagating on failing read
      refs API: make refs_read_raw_ref() not set errno
      refs API: make parse_loose_ref_contents() not set errno
      refs: drop force_create argument of create_reflog API
      t1404: mark directory/file conflict tests with REFFILES
      show-branch: show reflog message
      test-ref-store: don't add newline to reflog message
      t1405: check for_each_reflog_ent_reverse() more thoroughly
      test-ref-store: tweaks to for-each-reflog-ent format
      refs/debug: trim trailing LF from reflog message
      test-ref-store: remove force-create argument for create-reflog
      test-ref-store: parse symbolic flag constants
      test-ref-store: plug memory leak in cmd_delete_refs
      refs: update comment.
      refs: introduce REF_SKIP_OID_VERIFICATION flag
      refs: introduce REF_SKIP_REFNAME_VERIFICATION flag
      t1430: remove refs using test-tool
      t1430: create valid symrefs using test-helper
      test-ref-store: print hash algorithm
      t5540: require REFFILES
      t5550: require REFFILES
      t7004: create separate tags for different tests
      t7004: use "test-tool ref-store" for reflog inspection
      refs: pass gitdir to packed_ref_store_create
      refs: print error message in debug output
      refs: centralize initialization of the base ref_store.
      reftable: fix typo in header
      reftable: signal overflow
      reftable: support preset file mode for writing
      reftable: avoid initializing structs from structs

Hans Krentel (hakre) (1):
      ci(check-whitespace): update stale file top comments

Ivan Frade (2):
      fetch-pack: redact packfile urls in traces
      http-fetch: redact url on die() message

Jacob Vosmaer (1):
      upload-pack.c: increase output buffer size

James Limbouris (1):
      subtree: fix argument handling in check_parents

Jean-No=C3=ABl Avila (20):
      doc: fix git credential synopsis
      doc: split placeholders as individual tokens
      doc: express grammar placeholders between angle brackets
      doc: use only hyphens as word separators in placeholders
      doc: git-ls-files: express options as optional alternatives
      doc: use three dots for indicating repetition instead of star
      doc: uniformize <URL> placeholders' case
      doc: git-http-push: describe the refs as pattern pairs
      doc: git-init: clarify file modes in octal.
      i18n: refactor "foo and bar are mutually exclusive"
      i18n: refactor "%s, %s and %s are mutually exclusive"
      i18n: turn "options are incompatible" into "cannot be used together=
"
      i18n: standardize "cannot open" and "cannot read"
      i18n: tag.c factorize i18n strings
      i18n: factorize "--foo requires --bar" and the like
      i18n: factorize "no directory given for --foo"
      i18n: refactor "unrecognized %(foo) argument" strings
      i18n: factorize "--foo outside a repository"
      i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
      i18n: turn even more messages into "cannot be used together" ones

Jeff King (18):
      urlmatch: add underscore to URL_HOST_CHARS
      strbuf_addftime(): handle "%s" manually
      test_bitmap_hashes(): handle repository without bitmaps
      generate-cmdlist.sh: do not shell out to "sed"
      git-jump: pass "merge" arguments to ls-files
      t5319: corrupt more bytes of the midx checksum
      refs: work around gcc-11 warning with REF_HAVE_NEW
      fetch-pack: ignore SIGPIPE when writing to index-pack
      run-command: unify signal and regular logic for wait_or_whine()
      t7006: clean up SIGPIPE handling in trace2 tests
      t7006: simplify exit-code checks for sigpipe tests
      log: handle --decorate-refs with userformat "%d"
      log: load decorations with --simplify-by-decoration
      xdiff: drop CMP_ENV macro from xhistogram
      xdiff: drop xpparam_t parameter from histogram cmp_recs()
      xdiff: drop unused flags parameter from recs_match
      config.mak.dev: specify -std=3Dgnu99 for gcc/clang
      doc/config: mark ssh allowedSigners example as literal

Jerry Zhang (3):
      git-apply: add --quiet flag
      git-apply: add --allow-empty flag
      git-apply: skip threeway in add / rename cases

Joel Holdsworth (9):
      git-p4: use with statements to close files after use in patchRCSKey=
words
      git-p4: pre-compile RCS keyword regexes
      git-p4: add raw option to read_pipelines
      git-p4: open temporary patch file for write only
      git-p4: resolve RCS keywords in bytes not utf-8
      git-p4: print size values in appropriate units
      git-p4: show progress as an integer
      git-p4: remove "debug" verb
      git-p4: remove "rollback" verb

Johannes Altmanninger (1):
      t/perf: do not run tests in user's $SHELL

Johannes Schindelin (14):
      test-tool genzeros: generate large amounts of data more efficiently
      git-compat-util: introduce more size_t helpers
      ci: disallow directional formatting
      scalar: add a README with a roadmap
      scalar: create a rudimentary executable
      scalar: start documenting the command
      scalar: create test infrastructure
      scalar: let 'unregister' handle a deleted enlistment directory grac=
efully
      scalar: implement the `clone` subcommand
      scalar: teach 'clone' to support the --single-branch option
      scalar: allow reconfiguring an existing enlistment
      scalar: teach 'reconfigure' to optionally handle all registered enl=
istments
      scalar: implement the `version` command
      tests: set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME only when needed

Johannes Sixt (3):
      generate-cmdlist.sh: spawn fewer processes
      generate-cmdlist.sh: replace for loop by printf's auto-repeat featu=
re
      t1450-fsck: exec-bit is not needed to make loose object writable

John Cai (2):
      docs: fix places that break compilation in MyFirstObjectWalk
      docs: add headers in MyFirstObjectWalk

Jonathan Tan (2):
      packfile: avoid overflowing shift during decode
      Doc: no midx and partial clone relation

Josh Steadmon (5):
      trace2: disable tr2_dst before warning on write errors
      branch: accept multiple upstream branches for tracking
      branch: add flags and config to inherit tracking
      config: require lowercase for branch.*.autosetupmerge
      l10n: README: call more attention to plural strings

Junio C Hamano (28):
      for-each-ref: delay parsing of --sort=3D<atom> options
      MyFirstContribution: teach to use "format-patch --base=3Dauto"
      unsetenv(3) returns int, not void
      init doc: --shared=3D0xxx does not give umask but perm bits
      Revert "grep/pcre2: fix an edge case concerning ascii patterns and =
UTF-8 data"
      0th batch for early fixes
      Revert "editor: save and reset terminal after calling EDITOR"
      A bit more regression fixes
      Git 2.34.1
      refs: document callback for reflog-ent iterators
      The first batch to start the current cycle
      revision: use C99 declaration of variable in for() loop
      grep: clarify what `grep.patternType=3Ddefault` means
      flex-array: simplify compiler-specific workaround
      The second batch
      The third batch
      t4204 is not sanitizer clean at all
      format-patch: mark rev_info with UNLEAK
      merge: allow to pretend a merge is made into a different branch
      The fourth batch
      The fifth batch
      SubmittingPatchs: clarify choice of base and testing
      The sixth batch
      The seventh batch
      Git 2.35-rc0
      packfile: fix off-by-one error in decoding logic
      Last minute fixes before -rc1
      Git 2.35-rc1

Kashav Madan (1):
      help: make auto-correction prompt more consistent

Lessley Dennington (7):
      git: ensure correct git directory setup with -h
      commit-graph: return if there is no git directory
      test-read-cache: set up repo after git directory
      repo-settings: prepare_repo_settings only in git repos
      diff: replace --staged with --cached in t1092 tests
      diff: enable and test the sparse index
      blame: enable and test the sparse index

L=C3=A9na=C3=AFc Huard (1):
      grep: align default colors with GNU grep ones

Marc Strapetz (1):
      t/README: fix typo

Martin =C3=85gren (1):
      cache.h: drop duplicate `ensure_full_index()` declaration

Matt Cooper (4):
      t1051: introduce a smudge filter test for extremely large files
      odb: teach read_blob_entry to use size_t
      odb: guard against data loss checking out a huge file
      clean/smudge: allow clean filters to process extremely large files

Matthew John Cheetham (1):
      scalar: implement the `delete` command

Matthias A=C3=9Fhauer (1):
      lazyload: use correct calling conventions

Mugdha Pattnaik (1):
      submodule: absorb git dir instead of dying on deinit

Neeraj Singh (2):
      tmp-objdir: new API for creating temporary writable databases
      tmp-objdir: disable ref updates when replacing the primary odb

Patrick Steinhardt (1):
      fetch: fix deadlock when cleaning up lockfiles in async signals

Philip Oakley (3):
      repack.c: LLP64 compatibility, upcast unity for left shift
      diffcore-delta.c: LLP64 compatibility, upcast unity for left shift
      object-file.c: LLP64 compatibility, upcast unity for left shift

Philippe Blain (1):
      SubmittingPatches: fix Asciidoc syntax in "GitHub CI" section

Phillip Wood (19):
      diff histogram: intern strings
      xdiff: avoid unnecessary memory allocations
      xdiff: simplify comparison
      xdiff: implement a zealous diff3, or "zdiff3"
      diff --color-moved: add perf tests
      diff --color-moved: clear all flags on blocks that are too short
      diff --color-moved: factor out function
      diff --color-moved: rewind when discarding pmb
      diff --color-moved=3Dzebra: fix alternate coloring
      diff --color-moved: avoid false short line matches and bad zebra co=
loring
      diff: simplify allow-indentation-change delta calculation
      diff --color-moved-ws=3Dallow-indentation-change: simplify and opti=
mize
      diff --color-moved: call comparison function directly
      diff --color-moved: unify moved block growth functions
      diff --color-moved: shrink potential moved blocks as we go
      diff --color-moved: stop clearing potential moved blocks
      diff --color-moved-ws=3Dallow-indentation-change: improve hash look=
ups
      diff: use designated initializers for emitted_diff_symbol
      diff --color-moved: intern strings

Randall S. Becker (1):
      build: NonStop ships with an older zlib

Ren=C3=A9 Scharfe (6):
      mergesort: avoid left shift overflow
      log: let --invert-grep only invert --grep
      t4202: fix patternType setting in --invert-grep test
      daemon: plug memory leak on overlong path
      grep/pcre2: use PCRE2_UTF even with ASCII patterns
      grep/pcre2: factor out literal variable

Robert Estelle (3):
      color: add missing GIT_COLOR_* white/black constants
      color: support "default" to restore fg/bg color
      color: allow colors to be prefixed with "reset"

Robin Jarry (1):
      receive-pack: ignore SIGPIPE while reporting status to client

Sergey Organov (2):
      stash: implement '--staged' option for 'push' and 'save'
      stash: get rid of unused argument in stash_staged()

Taylor Blau (11):
      midx.c: clean up chunkfile after reading the MIDX
      midx.c: don't leak MIDX from verify_midx_file
      t/helper/test-read-midx.c: free MIDX within read_midx_file()
      builtin/pack-objects.c: don't leak memory via arguments
      builtin/repack.c: avoid leaking child arguments
      builtin/multi-pack-index.c: don't leak concatenated options
      midx.c: write MIDX filenames to strbuf
      pack-bitmap.c: don't leak type-level bitmaps
      pack-bitmap.c: more aggressively free in free_bitmap_index()
      packfile: make `close_pack_revindex()` static
      fmt-merge-msg: prevent use-after-free with signed tags

Teng Long (1):
      midx: fix a formatting issue in "multi-pack-index.txt"

Thiago Perrotta (2):
      send-email: programmatically generate bash completions
      send-email docs: add format-patch options

Thomas Wei=C3=9Fschuh (1):
      var: add GIT_DEFAULT_BRANCH variable

Victoria Dye (12):
      reset: rename is_missing to !is_in_reset_tree
      reset: preserve skip-worktree bit in mixed reset
      sparse-index: update command for expand/collapse test
      test-read-cache.c: prepare_repo_settings after config init
      sparse-index: avoid unnecessary cache tree clearing
      sparse-index: add ensure_correct_sparsity function
      sparse-index: update do_read_index to ensure correct sparsity
      reset: expand test coverage for sparse checkouts
      reset: integrate with sparse index
      reset: make sparse-aware (except --mixed)
      reset: make --mixed sparse-aware
      unpack-trees: improve performance of next_cache_entry

William Sprent (1):
      fast-export: fix surprising behavior with --first-parent

Yoichi Nakayama (1):
      completion: add human and auto: date format

brian m. carlson (1):
      git-compat-util: add a test balloon for C99 support

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (88):
      refs API: add a version of refs_resolve_ref_unsafe() with "errno"
      refs API: make refs_rename_ref_available() static
      reflog tests: add --updateref tests
      refs/files: remove "name exist?" check in lock_ref_oid_basic()
      refs API: remove refs_read_ref_full() wrapper
      refs API: make resolve_gitlink_ref() not set errno
      refs API: make loose_fill_ref_dir() not set errno
      refs API: make files_copy_or_rename_ref() et al not set errno
      refs API: ignore errno in worktree.c's add_head_info()
      refs API: ignore errno in worktree.c's find_shared_symref()
      refs tests: ignore ignore errno in test-ref-store helper
      refs API: make refs_resolve_refdup() not set errno
      refs API: make refs_ref_exists() not set errno
      refs API: make resolve_ref_unsafe() not set errno
      refs API: make expand_ref() & repo_dwim_log() not set errno
      refs API: don't expose "errno" in run_transaction_hook()
      refs API: post-migration API renaming [1/2]
      refs API: post-migration API renaming [2/2]
      Makefile: move git-SCRIPT-DEFINES adjacent to $(SCRIPT_DEFINES)
      Makefile: remove $(GIT_VERSION) from $(SCRIPT_DEFINES)
      Makefile: remove $(NO_CURL) from $(SCRIPT_DEFINES)
      git-instaweb: unconditionally assume that gitweb is mod_perl capabl=
e
      git-sh-setup: remove unused sane_egrep() function
      git-sh-setup: remove "sane_grep", it's not needed anymore
      leak tests: mark a read-tree test as passing SANITIZE=3Dleak
      leak tests: mark "sort" test as passing SANITIZE=3Dleak
      leak tests: mark most gettext tests as passing with SANITIZE=3Dleak
      leak tests: mark some misc tests as passing with SANITIZE=3Dleak
      leak tests: mark some rev-list tests as passing with SANITIZE=3Dlea=
k
      leak tests: mark some rev-parse tests as passing with SANITIZE=3Dle=
ak
      leak tests: mark some update-index tests as passing with SANITIZE=3D=
leak
      leak tests: mark some notes tests as passing with SANITIZE=3Dleak
      leak tests: mark some apply tests as passing with SANITIZE=3Dleak
      leak tests: mark some diff tests as passing with SANITIZE=3Dleak
      leak tests: mark some add tests as passing with SANITIZE=3Dleak
      leak tests: mark some clone tests as passing with SANITIZE=3Dleak
      leak tests: mark some status tests as passing with SANITIZE=3Dleak
      leak tests: mark some config tests as passing with SANITIZE=3Dleak
      leak tests: mark some fast-import tests as passing with SANITIZE=3D=
leak
      command-list.txt: sort with "LC_ALL=3DC sort"
      generate-cmdlist.sh: trivial whitespace change
      generate-cmdlist.sh: don't call get_categories() from category_list=
()
      generate-cmdlist.sh: run "grep | sort", not "sort | grep"
      generate-cmdlist.sh: stop sorting category lines
      generate-cmdlist.sh: replace "grep' invocation with a shell version
      generate-cmdlist.sh: don't parse command-list.txt thrice
      parse-options.c: use "enum parse_opt_result" for parse_nodash_opt()
      checkout: fix "branch info" memory leaks
      CI: remove Travis CI support
      CI: use shorter names that fit in UX tooltips
      CI: rename the "Linux32" job to lower-case "linux32"
      CI: use "$runs_on_pool", not "$jobname" to select packages & config
      CI: don't run "make test" twice in one job
      upload-archive: use regular "struct child_process" pattern
      run-command API users: use strvec_pushv(), not argv assignment
      run-command tests: use strvec_pushv(), not argv assignment
      run-command API users: use strvec_pushl(), not argv construction
      run-command API users: use strvec_push(), not argv construction
      run-command API: remove "argv" member, always use "args"
      difftool: use "env_array" to simplify memory management
      run-command API: remove "env" member, always use "env_array"
      common-main.c: call exit(), don't return
      pack-objects: use BUG(...) not die("BUG: ...")
      strbuf.h: use BUG(...) not die("BUG: ...")
      pathspec: use BUG(...) not die("BUG:%s:%d....", <file>, <line>)
      object.c: use BUG(...) no die("BUG: ...") in lookup_object_by_type(=
)
      usage.c: add a die_message() routine
      usage.c API users: use die_message() for "fatal :" + exit 128
      usage.c API users: use die_message() for error() + exit 128
      gc: return from cmd_gc(), don't call exit()
      usage.c + gc: add and use a die_message_errno()
      config API: use get_error_routine(), not vreportf()
      pull, fetch: fix segfault in --set-upstream option
      stash: don't show "git stash push" usage on bad "git stash" usage
      reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
      reflog expire: narrow scope of "cb" in cmd_reflog_expire()
      reflog: change one->many worktree->refnames to use a string_list
      reflog expire: use "switch" over enum values
      reflog expire: refactor & use "tip_commit" only for UE_NORMAL
      reflog expire: don't use lookup_commit_reference_gently()
      reflog: reduce scope of "struct rev_info"
      refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
      reflog + refs-backend: move "verbose" out of the backend
      Makefile: correct the dependency graph of hook-list.h
      Makefile: move -DPAGER_ENV from BASIC_CFLAGS to EXTRA_CPPFLAGS
      Makefile: don't invoke msgfmt with --statistics
      refs API: use "failure_errno", not "errno"
      reftable tests: avoid "int" overflow, use "uint64_t"

=C3=98ystein Walle (2):
      status: count stash entries in separate function
      status: print stash info with --porcelain=3Dv2 --show-stash

=E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) (3):
      doc: git-format-patch: describe the option --always
      am: support --empty=3D<option> to handle empty patches
      am: support --allow-empty to record specific empty patches


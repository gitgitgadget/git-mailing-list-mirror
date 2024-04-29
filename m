Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF08626C;
	Mon, 29 Apr 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410756; cv=none; b=MVTCMYYoeqNkOE0oUi7YdHQpCxXg+al+PJ6++cd8ENMBbULq84MnxGjjDHdj47yYEYKls11YYZfqJ7pZ9HP0vtSWPUH6L9OlJa+trsUZvMAi8MfW5a6uAuGlb6p7wVOfM3w/gehN/3QEGATP45qi7Cl/NVywvVRiWEYoH28Bg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410756; c=relaxed/simple;
	bh=c3K83JnSDFGRFmcmi/ho288ngDQ2NCo75NbCAIffNgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fj9TXJMplWmhV5sMu5e6FVXd4FaW5DRcIFK6B0qdHG1mqf2KJyyWQ260Ite1qY9oiazxOr+ibCdHPqUlbboSLfOs6a+jUmRVzcAQ6zTFDQ0gXGXHhdeS1aEbhne7aMshkqAfylFN0aqHf25zPhvaRzHLDwKRwPqgYNI+NkurJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U+m23ziS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U+m23ziS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12159235A1;
	Mon, 29 Apr 2024 13:12:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=c3K83JnSDFGRFmcmi/ho288ng
	DQ2NCo75NbCAIffNgw=; b=U+m23ziSv0CuEok2wwlVaGopmwHEo4tRxJiZSBzqB
	gHWdpB7ckvVYln7tadJF2u6bYMk89g4UOi2MhMg09+OvepzXjNSRW1b/Wt6uPKWs
	jkIb8SfO5WeaJTN7I6qHfFT+DpRNy3b5p4Fw2LqJgcWRXe+nfqgmsHOQQtf5PWzC
	Jw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 09422235A0;
	Mon, 29 Apr 2024 13:12:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 253422359F;
	Mon, 29 Apr 2024 13:12:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.45.0
Date: Mon, 29 Apr 2024 10:12:28 -0700
Message-ID: <xmqq8r0ww0sj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A8899D66-064B-11EF-B17C-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The latest feature release Git v2.45.0 is now available at the
usual places.  It is comprised of 540 non-merge commits since
v2.44.0, contributed by 96 people, 38 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.45.0'
tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.44.0 are as follows.
Welcome to the Git development community!

  Ahelenia Ziemia=C5=84ska, Angelo Dureghello, Aryan Gupta, Benjamin
  Flesch, Bo Anderson, Brian C Tracy, Brian Lyles, Bruno Haible,
  Chuck Lever, Dario Gjorgjevski, Dirk Gouders, Eugenio Gigante,
  Florian Schmidt, Haritha D, Harmen Stoppels, Jean-R=C3=A9my
  Falleri, Jiamu Sun, Jonas Wunderlich, Jonathan Davies, Julio
  Bacellari, Kipras Melnikovas, Kisaragi Hiu, Marcel R=C3=B6thke,
  Matthew Rollings, Max Gautier, mirth hickford, Pawe=C5=82 Dominiak,
  Pi Fisher, Ralph Seichter, Richard Macklin, shejialuo, Steven
  Jeuris, Thalia Archibald, Tiago Pascoal, Vincenzo Mezzela,
  V=C5=A9 Ti=E1=BA=BFn H=C6=B0ng, Xing Xin, and Yehezkel Bernat.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Shopov, Arkadii Yakovets, Bagas Sanjaya, Beat Bolli,
  brian m. carlson, Chandra Pratap, Christian Couder, Derrick
  Stolee, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh, Dragan Simic, Elija=
h Newren,
  Emir SARI, Eric Sunshine, Eric W. Biederman, Ghanshyam Thakkar,
  Han Young, Jakub Wilk, Jean-No=C3=ABl Avila, Jeff Hostetler, Jeff
  King, Jiang Xin, Johannes Schindelin, Johannes Sixt, John Cai,
  Josh Steadmon, Josh Triplett, Junio C Hamano, Justin Tobler,
  Karthik Nayak, Kate Golovanova, Kristoffer Haugsbakk, Kyle
  Lippincott, Kyle Meyer, Linus Arver, Lumynous, Manlio Perillo,
  Matthias A=C3=9Fhauer, Matthias R=C3=BCster, M Hickford, Michael Lohman=
n,
  Michael Osipov, Mike Hommey, Orgad Shaneh, Patrick Steinhardt,
  Peter Hutterer, Peter Krefting, Philippe Blain, Phillip Wood,
  Ralf Thielow, Ren=C3=A9 Scharfe, Rub=C3=A9n Justo, Sergey Organov,
  SZEDER G=C3=A1bor, Taylor Blau, Teng Long, Ville Skytt=C3=A4, Yasushi
  SHOJI, and Yi-Jyun Pan.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.45 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward Compatibility Notes

UI, Workflows & Features

 * Integrate the reftable code into the refs framework as a backend.
   With "git init --ref-format=3Dreftable", hopefully it would be a lot
   more efficient to manage a repository with many references.

 * "git checkout -p" and friends learned that that "@" is a synonym
   for "HEAD".

 * Variants of vimdiff learned to honor mergetool.<variant>.layout
   settings.

 * "git reflog" learned a "list" subcommand that enumerates known reflogs=
.

 * When a merge conflicted at a submodule, merge-ort backend used to
   unconditionally give a lengthy message to suggest how to resolve
   it.  Now the message can be squelched as an advice message.

 * "git for-each-ref" learned "--include-root-refs" option to show
   even the stuff outside the 'refs/' hierarchy.

 * "git rev-list --missing=3Dprint" has learned to optionally take
   "--allow-missing-tips", which allows the objects at the starting
   points to be missing.

 * "git merge-tree" has learned that the three trees involved in the
   3-way merge only need to be trees, not necessarily commits.

 * "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
   other kinds of *_HEAD pseudorefs.

 * Platform specific tweaks for OS/390 has been added to
   config.mak.uname.

 * Users with safe.bareRepository=3Dexplicit can still work from within
   $GIT_DIR of a seconary worktree (which resides at .git/worktrees/$name=
/)
   of the primary worktree without explicitly specifying the $GIT_DIR
   environment variable or the --git-dir=3D<path> option.

 * The output format for dates "iso-strict" has been tweaked to show
   a time in the Zulu timezone with "Z" suffix, instead of "+00:00".

 * "git diff" and friends learned two extra configuration variables,
   diff.srcPrefix and diff.dstPrefix.

 * The status.showUntrackedFiles configuration variable had a name
   that tempts users to set a Boolean value expressed in our usual
   "false", "off", and "0", but it only took "no".  This has been
   corrected so "true" and its synonyms are taken as "normal", while
   "false" and its synonyms are taken as "no".

 * Remove an ancient and not well maintained Hg-to-git migration
   script from contrib/.

 * Hints that suggest what to do after resolving conflicts can now be
   squelched by disabling advice.mergeConflict.

 * Allow git-cherry-pick(1) to automatically drop redundant commits via
   a new `--empty` option, similar to the `--empty` options for
   git-rebase(1) and git-am(1). Includes a soft deprecation of
   `--keep-redundant-commits` as well as some related docs changes and
   sequencer code cleanup.

 * "git config" learned "--comment=3D<message>" option to leave a
   comment immediately after the "variable =3D value" on the same line
   in the configuration file.

 * core.commentChar used to be limited to a single byte, but has been
   updated to allow an arbitrary multi-byte sequence.

 * "git add -p" and other "interactive hunk selection" UI has learned to
   skip showing the hunk immediately after it has already been shown, and
   an additional action to explicitly ask to reshow the current hunk.

 * "git pack-refs" learned the "--auto" option, which defers the decision=
 of
   whether and how to pack to the ref backend. This is used by the reftab=
le
   backend to avoid repacking of an already-optimal ref database. The new=
 mode
   is triggered from "git gc --auto".

 * "git add -u <pathspec>" and "git commit [-i] <pathspec>" did not
   diagnose a pathspec element that did not match any files in certain
   situations, unlike "git add <pathspec>" did.

 * The userdiff patterns for C# has been updated.

 * Git writes a "waiting for your editor" message on an incomplete
   line after launching an editor, and then append another error
   message on the same line if the editor errors out.  It now clears
   the "waiting for..." line before giving the error message.

 * The filename used for rejected hunks "git apply --reject" creates
   was limited to PATH_MAX, which has been lifted.

 * When "git bisect" reports the commit it determined to be the
   culprit, we used to show it in a format that does not honor common
   UI tweaks, like log.date and log.decorate.  The code has been
   taught to use "git show" to follow more customizations.


Performance, Internal Implementation, Development Support etc.

 * The code to iterate over refs with the reftable backend has seen
   some optimization.

 * More tests that are marked as "ref-files only" have been updated to
   improve test coverage of reftable backend.

 * Some parts of command line completion script (in contrib/) have
   been micro-optimized.

 * The way placeholders are to be marked-up in documentation have been
   specified; use "_<placeholder>_" to typeset the word inside a pair
   of <angle-brackets> emphasized.

 * "git --no-lazy-fetch cmd" allows to run "cmd" while disabling lazy
   fetching of objects from the promisor remote, which may be handy
   for debugging.

 * The implementation in "git clean" that makes "-n" and "-i" ignore
   clean.requireForce has been simplified, together with the
   documentation.

 * Uses of xwrite() helper have been audited and updated for better
   error checking and simpler code.

 * Some trace2 events that lacked def_param have learned to show it,
   enriching the output.

 * The parse-options code that deals with abbreviated long option
   names have been cleaned up.

 * The code in reftable backend that creates new table files works
   better with the tempfile framework to avoid leaving cruft after a
   failure.

 * The reftable code has its own custom binary search function whose
   comparison callback has an unusual interface, which caused the
   binary search to degenerate into a linear search, which has been
   corrected.

 * The code to iterate over reflogs in the reftable has been optimized
   to reduce memory allocation and deallocation.

 * Work to support a repository that work with both SHA-1 and SHA-256
   hash algorithms has started.

 * A new fuzz target that exercises config parsing code has been
   added.

 * Fix the way recently added tests interpolate variables defined
   outside them, and document the best practice to help future
   developers.

 * Introduce an experimental protocol for contributors to propose the
   topic description to be used in the "What's cooking" report, the
   merge commit message for the topic, and in the release notes and
   document it in the SubmittingPatches document.

 * The t/README file now gives a hint on running individual tests in
   the "t/" directory with "make t<num>-*.sh t<num>-*.sh".
   (merge 8d383806fc pb/test-scripts-are-build-targets later to maint).

 * The "hint:" messages given by the advice mechanism, when given a
   message with a blank line, left a line with trailing whitespace,
   which has been cleansed.

 * Documentation rules has been explicitly described how to mark-up
   literal parts and a few manual pages have been updated as examples.

 * The .editorconfig file has been taught that a Makefile uses HT
   indentation.

 * t-prio-queue test has been cleaned up by using C99 compound
   literals; this is meant to also serve as a weather-balloon to smoke
   out folks with compilers who have trouble compiling code that uses
   the feature.

 * Windows binary used to decide the use of unix-domain socket at
   build time, but it learned to make the decision at runtime instead.

 * The "shared repository" test in the t0610 reftable test failed
   under restrictive umask setting (e.g. 007), which has been
   corrected.

 * Document and apply workaround for a buggy version of dash that
   mishandles "local var=3Dval" construct.

 * The codepaths that reach date_mode_from_type() have been updated to
   pass "struct date_mode" by value to make them thread safe.

 * The strategy to compact multiple tables of reftables after many
   operations accumulate many entries has been improved to avoid
   accumulating too many tables uncollected.

 * The code to iterate over reftable blocks has seen some optimization
   to reduce memory allocation and deallocation.

 * The way "git fast-import" handles paths described in its input has
   been tightened up and more clearly documented.

 * The cvsimport tests required that the platform understands
   traditional timezone notations like CST6CDT, which has been
   updated to work on those systems as long as they understand
   POSIX notation with explicit tz transition dates.

 * The code to format trailers have been cleaned up.


Fixes since v2.44
-----------------

 * "git apply" on a filesystem without filemode support have learned
   to take a hint from what is in the index for the path, even when
   not working with the "--index" or "--cached" option, when checking
   the executable bit match what is required by the preimage in the
   patch.
   (merge 45b625142d cp/apply-core-filemode later to maint).

 * "git column" has been taught to reject negative padding value, as
   it would lead to nonsense behaviour including division by zero.
   (merge 76fb807faa kh/column-reject-negative-padding later to maint).

 * "git am --help" now tells readers what actions are available in
   "git am --whitespace=3D<action>", in addition to saying that the
   option is passed through to the underlying "git apply".
   (merge a171dac734 jc/am-whitespace-doc later to maint).

 * "git tag --column" failed to check the exit status of its "git
   column" invocation, which has been corrected.
   (merge 92e66478fc rj/tag-column-fix later to maint).

 * Credential helper based on libsecret (in contrib/) has been updated
   to handle an empty password correctly.
   (merge 8f1f2023b7 mh/libsecret-empty-password-fix later to maint).

 * "git difftool --dir-diff" learned to honor the "--trust-exit-code"
   option; it used to always exit with 0 and signalled success.
   (merge eb84c8b6ce ps/difftool-dir-diff-exit-code later to maint).

 * The code incorrectly attempted to use textconv cache when asked,
   even when we are not running in a repository, which has been
   corrected.
   (merge affe355fe7 jk/textconv-cache-outside-repo-fix later to maint).

 * Remove an empty file that shouldn't have been added in the first
   place.
   (merge 4f66942215 js/remove-cruft-files later to maint).

 * The logic to access reflog entries by date and number had ugly
   corner cases at the boundaries, which have been cleaned up.
   (merge 5edd126720 jk/reflog-special-cases-fix later to maint).

 * An error message from "git upload-pack", which responds to "git
   fetch" requests, had a trailing NUL in it, which has been
   corrected.
   (merge 3f4c7a0805 sg/upload-pack-error-message-fix later to maint).

 * Clarify wording in the CodingGuidelines that requires <git-compat-util=
.h>
   to be the first header file.
   (merge 4e89f0e07c jc/doc-compat-util later to maint).

 * "git commit -v --cleanup=3Dscissors" used to add the scissors line
   twice in the log message buffer, which has been corrected.
   (merge e90cc075cc jt/commit-redundant-scissors-fix later to maint).

 * A custom remote helper no longer cannot access the newly created
   repository during "git clone", which is a regression in Git 2.44.
   This has been corrected.
   (merge 199f44cb2e ps/remote-helper-repo-initialization-fix later to ma=
int).

 * Various parts of upload-pack have been updated to bound the resource
   consumption relative to the size of the repository to protect from
   abusive clients.
   (merge 6cd05e768b jk/upload-pack-bounded-resources later to maint).

 * The upload-pack program, when talking over v2, accepted the
   packfile-uris protocol extension from the client, even if it did
   not advertise the capability, which has been corrected.
   (merge a922bfa3b5 jk/upload-pack-v2-capability-cleanup later to maint)=
.

 * Make sure failure return from merge_bases_many() is properly caught.
   (merge 25fd20eb44 js/merge-base-with-missing-commit later to maint).

 * FSMonitor client code was confused when FSEvents were given in a
   different case on a case-insensitive filesystem, which has been
   corrected.
   (merge 29c139ce78 jh/fsmonitor-icase-corner-case-fix later to maint).

 * The "core.commentChar" configuration variable only allows an ASCII
   character, which was not clearly documented, which has been
   corrected.
   (merge fb7c556f58 kh/doc-commentchar-is-a-byte later to maint).

 * With release 2.44 we got rid of all uses of test_i18ngrep and there
   is no in-flight topic that adds a new use of it.  Make a call to
   test_i18ngrep a hard failure, so that we can remove it at the end
   of this release cycle.
   (merge 381a83dfa3 jc/test-i18ngrep later to maint).

 * The command line completion script (in contrib/) learned to
   complete "git reflog" better.
   (merge 1284f9cc11 rj/complete-reflog later to maint).

 * The logic to complete the command line arguments to "git worktree"
   subcommand (in contrib/) has been updated to correctly honor things
   like "git -C dir" etc.
   (merge 3574816d98 rj/complete-worktree-paths-fix later to maint).

 * When git refuses to create a branch because the proposed branch
   name is not a valid refname, an advice message is given to refer
   the user to exact naming rules.
   (merge 8fbd903e58 kh/branch-ref-syntax-advice later to maint).

 * Code simplification by getting rid of code that sets an environment
   variable that is no longer used.
   (merge 72a8d3f027 pw/rebase-i-ignore-cherry-pick-help-environment late=
r to maint).

 * The code to find the effective end of log messages can fall into an
   endless loop, which has been corrected.
   (merge 2541cba2d6 fs/find-end-of-log-message-fix later to maint).

 * Mark-up used in the documentation has been improved for
   consistency.
   (merge 45d5ed3e50 ja/doc-markup-fixes later to maint).

 * The status.showUntrackedFiles configuration variable was
   incorrectly documented to accept "false", which has been corrected.

 * Leaks from "git restore" have been plugged.
   (merge 2f64da0790 rj/restore-plug-leaks later to maint).

 * "git bugreport --no-suffix" was not supported and instead
   segfaulted, which has been corrected.
   (merge b3b57c69da js/bugreport-no-suffix-fix later to maint).

 * The documentation for "%(trailers[:options])" placeholder in the
   "--pretty" option of commands in the "git log" family has been
   updated.
   (merge bff85a338c bl/doc-key-val-sep-fix later to maint).

 * "git checkout --conflict=3Dbad" reported a bad conflictStyle as if it
   were given to a configuration variable; it has been corrected to
   report that the command line option is bad.
   (merge 5a99c1ac1a pw/checkout-conflict-errorfix later to maint).

 * Code clean-up in the "git log" machinery that implements custom log
   message formatting.
   (merge 1c10b8e5b0 jk/pretty-subject-cleanup later to maint).

 * "git config" corrupted literal HT characters written in the
   configuration file as part of a value, which has been corrected.
   (merge e6895c3f97 ds/config-internal-whitespace-fix later to maint).

 * A unit test for reftable code tried to enumerate all files in a
   directory after reftable operations and expected to see nothing but
   the files it wanted to leave there, but was fooled by .nfs* cruft
   files left, which has been corrected.
   (merge 0068aa7946 ps/reftable-unit-test-nfs-workaround later to maint)=
.

 * The implementation and documentation of "object-format" option
   exchange between the Git itself and its remote helpers did not
   quite match, which has been corrected.

 * The "--pretty=3D<shortHand>" option of the commands in the "git log"
   family, defined as "[pretty] shortHand =3D <expansion>" should have
   been looked up case insensitively, but was not, which has been
   corrected.
   (merge f999d5188b bl/pretty-shorthand-config-fix later to maint).

 * "git apply" failed to extract the filename the patch applied to,
   when the change was about an empty file created in or deleted from
   a directory whose name ends with a SP, which has been corrected.
   (merge 776ffd1a30 jc/apply-parse-diff-git-header-names-fix later to ma=
int).

 * Update a more recent tutorial doc.
   (merge 95ab557b4b dg/myfirstobjectwalk-updates later to maint).

 * The test script had an incomplete and ineffective attempt to avoid
   clobbering the testing user's real crontab (and its equivalents),
   which has been completed.
   (merge 73cb87773b es/test-cron-safety later to maint).

 * Use advice_if_enabled() API to rewrite a simple pattern to
   call advise() after checking advice_enabled().
   (merge 6412d01527 rj/use-adv-if-enabled later to maint).

 * Another "set -u" fix for the bash prompt (in contrib/) script.
   (merge d7805bc743 vs/complete-with-set-u-fix later to maint).

 * "git checkout/switch --detach foo", after switching to the detached
   HEAD state, gave the tracking information for the 'foo' branch,
   which was pointless.

 * "git apply" has been updated to lift the hardcoded pathname length
   limit, which in turn allowed a mksnpath() function that is no
   longer used.
   (merge 708f7e0590 rs/apply-lift-path-length-limit later to maint).

 * A file descriptor leak in an error codepath, used when "git apply
   --reject" fails to create the *.rej file, has been corrected.
   (merge 2b1f456adf rs/apply-reject-fd-leakfix later to maint).

 * A config parser callback function fell through instead of returning
   after recognising and processing a variable, wasting cycles, which
   has been corrected.
   (merge a816ccd642 ds/fetch-config-parse-microfix later to maint).

 * Fix was added to work around a regression in libcURL 8.7.0 (which has
   already been fixed in their tip of the tree).
   (merge 92a209bf24 jk/libcurl-8.7-regression-workaround later to maint)=
.

 * The variable that holds the value read from the core.excludefile
   configuration variable used to leak, which has been corrected.
   (merge 0e0fefb29f jc/unleak-core-excludesfile later to maint).

 * vreportf(), which is used by error() and friends, has been taught
   to give the error message printf-format string when its vsnprintf()
   call fails, instead of showing nothing useful to identify the
   nature of the error.
   (merge c63adab961 rs/usage-fallback-to-show-message-format later to ma=
int).

 * Adjust to an upcoming changes to GNU make that breaks our Makefiles.
   (merge 227b8fd902 tb/make-indent-conditional-with-non-spaces later to =
maint).

 * Git 2.44 introduced a regression that makes the updated code to
   barf in repositories with multi-pack index written by older
   versions of Git, which has been corrected.

 * When .git/rr-cache/ rerere database gets corrupted or rerere is fed to
   work on a file with conflicted hunks resolved incompletely, the rerere
   machinery got confused and segfaulted, which has been corrected.
   (merge 167395bb47 mr/rerere-crash-fix later to maint).

 * The "receive-pack" program (which responds to "git push") was not
   converted to run "git maintenance --auto" when other codepaths that
   used to run "git gc --auto" were updated, which has been corrected.
   (merge 7bf3057d9c ps/run-auto-maintenance-in-receive-pack later to mai=
nt).

 * Other code cleanup, docfix, build fix, etc.
   (merge f0e578c69c rs/use-xstrncmpz later to maint).
   (merge 83e6eb7d7a ba/credential-test-clean-fix later to maint).
   (merge 64562d784d jb/doc-interactive-singlekey-do-not-need-perl later =
to maint).
   (merge c431a235e2 cp/t9146-use-test-path-helpers later to maint).
   (merge 82d75402d5 ds/doc-send-email-capitalization later to maint).
   (merge 41bff66e35 jc/doc-add-placeholder-fix later to maint).
   (merge 6835f0efe9 jw/remote-doc-typofix later to maint).
   (merge 244001aa20 hs/rebase-not-in-progress later to maint).
   (merge 2ca6c07db2 jc/no-include-of-compat-util-from-headers later to m=
aint).
   (merge 87bd7fbb9c rs/fetch-simplify-with-starts-with later to maint).
   (merge f39addd0d9 rs/name-rev-with-mempool later to maint).
   (merge 9a97b43e03 rs/submodule-prefix-simplify later to maint).
   (merge 40b8076462 ak/rebase-autosquash later to maint).
   (merge 3223204456 eg/add-uflags later to maint).
   (merge 5f78d52dce es/config-doc-sort-sections later to maint).
   (merge 781fb7b4c2 as/option-names-in-messages later to maint).
   (merge 51d41dc243 jk/doc-remote-helpers-markup-fix later to maint).
   (merge e1aaf309db pb/ci-win-artifact-names-fix later to maint).
   (merge ad538c61da jc/index-pack-fsck-levels later to maint).
   (merge 67471bc704 ja/doc-formatting-fix later to maint).
   (merge 86f9ce7dd6 bl/doc-config-fixes later to maint).
   (merge 0d527842b7 az/grep-group-error-message-update later to maint).
   (merge 7c43bdf07b rs/strbuf-expand-bad-format later to maint).
   (merge 8b68b48d5c ds/typofix-core-config-doc later to maint).
   (merge 39bb692152 rs/imap-send-use-xsnprintf later to maint).
   (merge 8d320cec60 jc/t2104-style-fixes later to maint).
   (merge b4454d5a7b pw/t3428-cleanup later to maint).
   (merge 84a7c33a4b pf/commitish-committish later to maint).
   (merge 8882ee9d68 la/mailmap-entry later to maint).
   (merge 44bdba2fa6 rs/no-openssl-compilation-fix-on-macos later to main=
t).
   (merge f412d72c19 yb/replay-doc-linkfix later to maint).
   (merge 5da40be8d7 xx/rfc2822-date-format-in-doc later to maint).

----------------------------------------------------------------

Changes since v2.44.0 are as follows:

Ahelenia Ziemia=C5=84ska (1):
      grep: improve errors for unmatched ( and )

Alexander Shopov (5):
      transport-helper.c: trivial fix of error message
      builtin/remote.c: trivial fix of error message
      builtin/clone.c: trivial fix of message
      revision.c: trivial fix to message
      l10n: bg.po: Updated Bulgarian translation (5652t)

Arkadii Yakovets (1):
      l10n: uk: v2.45 update

Aryan Gupta (1):
      tests: modernize the test script t0010-racy-git.sh

Bagas Sanjaya (1):
      l10n: po-id for 2.45

Beat Bolli (25):
      completion: use awk for filtering the config entries
      date: make "iso-strict" conforming for the UTC timezone
      t0006: add more tests with a negative TZ offset
      doc: avoid redundant use of cat
      contrib/subtree/t: avoid redundant use of cat
      t/lib-cvs.sh: avoid redundant use of cat
      t/annotate-tests.sh: avoid redundant use of cat
      t/perf: avoid redundant use of cat
      t/t0*: avoid redundant uses of cat
      t/t1*: avoid redundant uses of cat
      t/t3*: avoid redundant uses of cat
      t/t4*: avoid redundant uses of cat
      t/t5*: avoid redundant uses of cat
      t/t6*: avoid redundant uses of cat
      t/t7*: avoid redundant use of cat
      t/t8*: avoid redundant use of cat
      t/t9*: avoid redundant uses of cat
      t/t1*: merge a "grep | sed" pipeline
      t/t3*: merge a "grep | awk" pipeline
      t/t4*: merge a "grep | sed" pipeline
      t/t5*: merge a "grep | sed" pipeline
      t/t8*: merge "grep | sed" pipelines
      t/t9*: merge "grep | sed" pipelines
      contrib/coverage-diff: avoid redundant pipelines
      git-quiltimport: avoid an unnecessary subshell

Bo Anderson (5):
      t/lib-credential: clean additional credential
      osxkeychain: replace deprecated SecKeychain API
      osxkeychain: erase all matching credentials
      osxkeychain: erase matching passwords only
      osxkeychain: store new attributes

Brian C Tracy (1):
      fuzz: add fuzzer for config parsing

Brian Lyles (13):
      docs: clarify file options in git-config `--edit`
      docs: fix typo in git-config `--default`
      docs: correct trailer `key_value_separator` description
      docs: adjust trailer `separator` and `key_value_separator` language
      pretty: update tests to use `test_config`
      pretty: find pretty formats case-insensitively
      docs: address inaccurate `--empty` default with `--exec`
      docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
      rebase: update `--empty=3Dask` to `--empty=3Dstop`
      sequencer: handle unborn branch with `--allow-empty`
      sequencer: do not require `allow_empty` for redundant commit option=
s
      cherry-pick: enforce `--keep-redundant-commits` incompatibility
      cherry-pick: add `--empty` for more robust redundant commit handlin=
g

Chandra Pratap (2):
      apply: ignore working tree filemode when !core.filemode
      t9146: replace test -d/-e/-f with appropriate test_path_is_* functi=
on

Christian Couder (5):
      revision: clarify a 'return NULL' in get_reference()
      oidset: refactor oidset_insert_from_set()
      t6022: fix 'test' style and 'even though' typo
      rev-list: allow missing tips with --missing=3D[print|allow*]
      revision: fix --missing=3D[print|allow*] for annotated tags

Derrick Stolee (1):
      fetch: return when parsing submodule.recurse

Dirk Gouders (6):
      Documentation/user-manual.txt: example for generating object hashes
      MyFirstObjectWalk: use additional arg in config_fn_t
      MyFirstObjectWalk: fix misspelled "builtins/"
      MyFirstObjectWalk: fix filtered object walk
      MyFirstObjectWalk: fix description for counting omitted objects
      MyFirstObjectWalk: add stderr to pipe processing

Dragan Simic (8):
      documentation: send-email: use camel case consistently
      config: minor addition of whitespace
      config: really keep value-internal whitespace verbatim
      t1300: add more tests for whitespace and inline comments
      config.txt: describe handling of whitespace further
      grep docs: describe --recurse-submodules further and improve format=
ting a bit
      grep docs: describe --no-index further and improve formatting a bit
      config: fix some small capitalization issues, as spotted

Emir SARI (1):
      l10n: tr: Update Turkish translations

Eric Sunshine (2):
      docs: sort configuration variable groupings alphabetically
      test-lib: fix non-functioning GIT_TEST_MAINT_SCHEDULER fallback

Eric W. Biederman (23):
      object-file-convert: stubs for converting from one object format to=
 another
      oid-array: teach oid-array to handle multiple kinds of oids
      object-names: support input of oids in any supported hash
      repository: add a compatibility hash algorithm
      loose: compatibilty short name support
      object-file: update the loose object map when writing loose objects
      object-file: add a compat_oid_in parameter to write_object_file_fla=
gs
      commit: convert mergetag before computing the signature of a commit
      commit: export add_header_signature to support handling signatures =
on tags
      tag: sign both hashes
      object: factor out parse_mode out of fast-import and tree-walk into=
 in object.h
      object-file-convert: don't leak when converting tag objects
      object-file-convert: convert commits that embed signed tags
      object-file: update object_info_extended to reencode objects
      rev-parse: add an --output-object-format parameter
      builtin/cat-file: let the oid determine the output algorithm
      tree-walk: init_tree_desc take an oid to get the hash algorithm
      object-file: handle compat objects in check_object_signature
      builtin/ls-tree: let the oid determine the output algorithm
      test-lib: compute the compatibility hash so tests may use it
      t1006: rename sha1 to oid
      t1006: test oid compatibility with cat-file
      t1016-compatObjectFormat: add tests to verify the conversion betwee=
n objects

Eugenio Gigante (1):
      add: use unsigned type for collection of bits

Florian Schmidt (1):
      wt-status: don't find scissors line beyond buf len

Ghanshyam Thakkar (5):
      add-patch: classify '@' as a synonym for 'HEAD'
      add -p tests: remove PERL prerequisites
      setup: remove unnecessary variable
      builtin/commit: error out when passing untracked path with -i
      builtin/add: error out when passing untracked path with -u

Haritha D (1):
      build: support z/OS (OS/390).

Harmen Stoppels (1):
      rebase: make warning less passive aggressive

Jakub Wilk (1):
      git-remote.txt: fix typo

Jean-No=C3=ABl Avila (18):
      doc: git-rev-parse: enforce command-line description syntax
      doc: close unclosed angle-bracket of a placeholder in git-clone doc
      doc: end sentences with full-stop
      doc: clarify the format of placeholders
      doc: git-init: format verbatim parts
      doc: git-init: format placeholders
      doc: git-init: rework definition lists
      doc: git-init: rework config item init.templateDir
      doc: git-clone: format verbatim words
      doc: git-clone: format placeholders
      doc: format alternatives in synopsis
      doc: fix some placeholders formating
      doc: rework CodingGuidelines with new formatting rules
      doc: allow literal and emphasis format in doc vs help tests
      doc: git-init: apply new documentation formatting guidelines
      doc: git-clone: apply new documentation formatting guidelines
      doc: git-clone: do not autoreference the manpage in itself
      l10n: fr: v2.45.0

Jeff Hostetler (17):
      name-hash: add index_dir_find()
      t7527: add case-insensitve test for FSMonitor
      fsmonitor: refactor refresh callback on directory events
      fsmonitor: clarify handling of directory events in callback helper
      fsmonitor: refactor refresh callback for non-directory events
      dir: create untracked_cache_invalidate_trimmed_path()
      fsmonitor: refactor untracked-cache invalidation
      fsmonitor: move untracked-cache invalidation into helper functions
      fsmonitor: return invalidated cache-entry count on directory event
      fsmonitor: remove custom loop from non-directory path handler
      fsmonitor: return invalidated cache-entry count on non-directory ev=
ent
      fsmonitor: trace the new invalidated cache-entry count
      fsmonitor: refactor bit invalidation in refresh callback
      fsmonitor: support case-insensitive events
      t0211: demonstrate missing 'def_param' events for certain commands
      trace2: avoid emitting 'def_param' set more than once
      trace2: emit 'def_param' set with 'cmd_name' event

Jeff King (51):
      t0303: check that helper_test_clean removes all credentials
      userdiff: skip textconv caching when not in a repository
      Revert "refs: allow @{n} to work with n-sized reflog"
      get_oid_basic(): special-case ref@{n} for oldest reflog entry
      read_ref_at(): special-case ref@{0} for an empty reflog
      upload-pack: drop separate v2 "haves" array
      upload-pack: switch deepen-not list to an oid_array
      upload-pack: use oidset for deepen_not list
      upload-pack: use a strmap for want-ref lines
      upload-pack: accept only a single packfile-uri line
      upload-pack: always turn off save_commit_buffer
      upload-pack: use PARSE_OBJECT_SKIP_HASH_CHECK in more places
      upload-pack: free tree buffers after parsing
      upload-pack: use repository struct to get config
      upload-pack: centralize setup of sideband-all config
      upload-pack: use existing config mechanism for advertisement
      upload-pack: only accept packfile-uris if we advertised it
      doc/gitremote-helpers: fix missing single-quote
      config: forbid newline as core.commentChar
      strbuf: simplify comment-handling in add_lines() helper
      strbuf: avoid static variables in strbuf_add_commented_lines()
      commit: refactor base-case of adjust_comment_line_char()
      strbuf: avoid shadowing global comment_line_char name
      environment: store comment_line_char as a string
      strbuf: accept a comment string for strbuf_stripspace()
      strbuf: accept a comment string for strbuf_commented_addf()
      strbuf: accept a comment string for strbuf_add_commented_lines()
      prefer comment_line_str to comment_line_char for printing
      find multi-byte comment chars in NUL-terminated strings
      find multi-byte comment chars in unterminated buffers
      sequencer: handle multi-byte comment characters when writing todo l=
ist
      wt-status: drop custom comment-char stringification
      environment: drop comment_line_char compatibility macro
      config: allow multi-byte core.commentChar
      shortlog: stop setting pp.print_email_subject
      pretty: split oneline and email subject printing
      pretty: drop print_email_subject flag
      log: do not set up extra_headers for non-email formats
      format-patch: return an allocated string from log_write_email_heade=
rs()
      format-patch: simplify after-subject MIME header handling
      doc/gitremote-helpers: fix more missing single-quotes
      transport-helper: use write helpers more consistently
      transport-helper: drop "object-format <algo>" option
      transport-helper: send "true" value for object-format option
      contrib: drop hg-to-git script
      format-patch: fix leak of empty header string
      rebase: use child_process_clear() to clean
      config: add core.commentString
      http: reset POSTFIELDSIZE when clearing curl handle
      INSTALL: bump libcurl version to 7.21.3
      remote-curl: add Transfer-Encoding header only for older curl

Jiamu Sun (1):
      bugreport.c: fix a crash in `git bugreport` with `--no-suffix` opti=
on

Jiang Xin (1):
      l10n: TEAMS: retire l10n teams no update in 1 year

Johannes Schindelin (22):
      merge-tree: accept 3 trees as arguments
      merge-tree: fail with a non-zero exit code on missing tree objects
      merge-ort: do check `parse_tree()`'s return value
      t4301: verify that merge-tree fails on missing blob objects
      Always check `parse_tree*()`'s return value
      cache-tree: avoid an unnecessary check
      fill_tree_descriptor(): mark error message for translation
      neue: remove a bogus empty file
      commit-reach(paint_down_to_common): plug two memory leaks
      commit-reach(repo_in_merge_bases_many): optionally expect missing c=
ommits
      commit-reach(repo_in_merge_bases_many): report missing commits
      commit-reach(paint_down_to_common): prepare for handling shallow co=
mmits
      commit-reach(paint_down_to_common): start reporting errors
      commit-reach(merge_bases_many): pass on "missing commits" errors
      commit-reach(get_merge_bases_many_0): pass on "missing commits" err=
ors
      commit-reach(repo_get_merge_bases): pass on "missing commits" error=
s
      commit-reach(get_octopus_merge_bases): pass on "missing commits" er=
rors
      commit-reach(repo_get_merge_bases_many): pass on "missing commits" =
errors
      commit-reach(repo_get_merge_bases_many_dirty): pass on errors
      merge-recursive: prepare for `merge_submodule()` to report errors
      merge-ort/merge-recursive: do report errors in `merge_submodule()`
      merge-tree: fix argument type of the `--merge-base` option

John Cai (1):
      t5300: fix test_with_bad_commit()

Jonas Wunderlich (1):
      doc: status.showUntrackedFiles does not take "false"

Josh Triplett (2):
      commit: avoid redundant scissor line with --cleanup=3Dscissors -v
      commit: unify logic to avoid multiple scissors lines when merging

Julio Bacellari (1):
      doc: remove outdated information about interactive.singleKey

Junio C Hamano (64):
      apply: correctly reverse patch's pre- and post-image mode bits
      apply: code simplification
      t9210: do not rely on lazy fetching to fail
      git: --no-lazy-fetch option
      doc: add shortcut to "am --whitespace=3D<action>"
      doc: apply the new placeholder rules to git-add documentation
      compat: drop inclusion of <git-compat-util.h>
      Start the 2.45 cycle
      git: document GIT_NO_REPLACE_OBJECTS environment variable
      doc: clarify the wording on <git-compat-util.h> requirement
      git: extend --no-lazy-fetch to work across subprocesses
      The second batch
      The third batch
      test_i18ngrep: hard deprecate and forbid its use
      unpack: replace xwrite() loop with write_in_full()
      sideband: avoid short write(2)
      repack: check error writing to pack-objects subprocess
      clean: further clean-up of implementation around "--force"
      The fourth batch
      The fifth batch
      setup: notice more types of implicit bare repositories
      The sixth batch
      status: unify parsing of --untracked=3D and status.showUntrackedFil=
es
      status: allow --untracked=3Dfalse and friends
      The seventh batch
      The eighth batch
      config: fix --comment formatting
      config: allow tweaking whitespace between value and comment
      diff.*Prefix: use camelCase in the doc and test titles
      The ninth batch
      apply: parse names out of "diff --git" more carefully
      The tenth batch
      The eleventh batch
      SubmittingPatches: release-notes entry experiment
      The twelfth batch
      t4126: make sure a directory with SP at the end is usable
      t4126: fix "funny directory name" test on Windows (again)
      advice: omit trailing whitespace
      checkout: omit "tracking" information on a detached HEAD
      The thirteenth batch
      t2104: style fixes
      The fourteenth batch
      revision: optionally record matches with pathspec elements
      The fifteenth batch
      CodingGuidelines: describe "export VAR=3DVAL" rule
      CodingGuidelines: quote assigned value in 'local var=3D$val'
      t: local VAR=3D"VAL" (quote positional parameters)
      t: local VAR=3D"VAL" (quote command substitution)
      t: local VAR=3D"VAL" (quote ${magic-reference})
      t: teach lint that RHS of 'local VAR=3DVAL' needs to be quoted
      t0610: local VAR=3D"VAL" fix
      t1016: local VAR=3D"VAL" fix
      config: do not leak excludes_file
      Makefile(s): do not enforce "all indents must be done with tab"
      The sixteenth batch
      t2104: style fixes
      The seventeenth batch
      The eighteenth batch
      The ninteenth batch
      The twentieth batch
      Git 2.45-rc0
      A bit more topics before -rc1
      Git 2.45-rc1
      Git 2.45

Justin Tobler (3):
      reftable/stack: expose option to disable auto-compaction
      reftable/stack: add env to disable autocompaction
      reftable/stack: use geometric table compaction

Karthik Nayak (7):
      refs: introduce `is_pseudoref()` and `is_headref()`
      refs: extract out `loose_fill_ref_dir_regular_file()`
      refs: introduce `refs_for_each_include_root_refs()`
      ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
      for-each-ref: add new option to include root refs
      update-ref: use {old,new}-oid instead of {old,new}value
      githooks: use {old,new}-oid instead of {old,new}-value

Kipras Melnikovas (1):
      mergetools: vimdiff: use correct tool's name when reading mergetool=
 config

Kristoffer Haugsbakk (9):
      column: disallow negative padding
      column: guard against negative padding
      gitcli: drop mention of =E2=80=9Cnon-dashed form=E2=80=9D
      config: document `core.commentChar` as ASCII-only
      t3200: improve test style
      advice: make all entries stylistically consistent
      advice: use backticks for verbatim
      advice: use double quotes for regular quoting
      branch: advise about ref syntax rules

Linus Arver (15):
      trailer: free trailer_info _after_ all related usage
      shortlog: add test for de-duplicating folded trailers
      trailer: rename functions to use 'trailer'
      trailer: reorder format_trailers_from_commit() parameters
      trailer: move interpret_trailers() to interpret-trailers.c
      trailer_info_get(): reorder parameters
      format_trailers(): use strbuf instead of FILE
      format_trailer_info(): move "fast path" to caller
      format_trailers_from_commit(): indirectly call trailer_info_get()
      format_trailer_info(): use trailer_item objects
      format_trailer_info(): drop redundant unfold_value()
      format_trailer_info(): append newline for non-trailer lines
      trailer: begin formatting unification
      trailer: finish formatting unification
      mailmap: change primary address for Linus Arver

M Hickford (1):
      libsecret: retrieve empty password

Marcel R=C3=B6thke (1):
      rerere: fix crashes due to unmatched opening conflict markers

Matthias A=C3=9Fhauer (1):
      Win32: detect unix socket support at runtime

Max Gautier (1):
      editorconfig: add Makefiles to "text files"

Michael Lohmann (2):
      revision: ensure MERGE_HEAD is a ref in prepare_show_merge
      revision: implement `git log --merge` also for rebase/cherry-pick/r=
evert

Orgad Shaneh (1):
      docs: remove duplicate entry and fix typo in 2.45 changelog

Patrick Steinhardt (99):
      refs: introduce reftable backend
      ci: add jobs to test with the reftable backend
      refs/reftable: fix leak when copying reflog fails
      reftable/record: introduce function to compare records by key
      reftable/merged: allocation-less dropping of shadowed records
      reftable/merged: skip comparison for records of the same subiter
      reftable/pq: allocation-less comparison of entry keys
      reftable/block: swap buffers instead of copying
      reftable/record: don't try to reallocate ref record name
      reftable/reader: add comments to `table_iter_next()`
      t: move tests exercising the "files" backend
      t0410: convert tests to use DEFAULT_REPO_FORMAT prereq
      t1400: exercise reflog with gaps with reftable backend
      t1404: make D/F conflict tests compatible with reftable backend
      t1405: remove unneeded cleanup step
      t2011: exercise D/F conflicts with HEAD with the reftable backend
      t7003: ensure filter-branch prunes reflogs with the reftable backen=
d
      git-difftool--helper: honor `--trust-exit-code` with `--dir-diff`
      dir-iterator: pass name to `prepare_next_entry_data()` directly
      dir-iterator: support iteration in sorted order
      refs/files: sort reflogs returned by the reflog iterator
      refs/files: sort merged worktree and common reflogs
      refs: always treat iterators as ordered
      refs: drop unused params from the reflog iterator callback
      refs: stop resolving ref corresponding to reflogs
      builtin/reflog: introduce subcommand to list reflogs
      builtin/clone: allow remote helpers to detect repo
      refs/reftable: don't fail empty transactions in repo without HEAD
      reftable/pq: use `size_t` to track iterator index
      reftable/merged: make `merged_iter` structure private
      reftable/merged: advance subiter on subsequent iteration
      reftable/merged: make subiters own their records
      reftable/merged: remove unnecessary null check for subiters
      reftable/merged: handle subiter cleanup on close only
      reftable/merged: circumvent pqueue with single subiter
      reftable/merged: avoid duplicate pqueue emptiness check
      reftable/record: reuse refname when decoding
      reftable/record: reuse refname when copying
      reftable/record: decode keys in place
      reftable: allow inlining of a few functions
      refs/reftable: precompute prefix length
      refs/reftable: reload correct stack when creating reflog iter
      reftable/record: convert old and new object IDs to arrays
      reftable/record: avoid copying author info
      reftable/record: reuse refnames when decoding log records
      reftable/record: reuse message when decoding log records
      reftable/record: use scratch buffer when decoding records
      refs/reftable: track last log record name via strbuf
      t0610: remove unused variable assignment
      lockfile: report when rollback fails
      reftable/stack: register new tables as tempfiles
      reftable/stack: register lockfiles during compaction
      reftable/stack: register compacted tables as tempfiles
      reftable/record: fix memory leak when decoding object records
      reftable/block: fix binary search over restart counter
      t5601: exercise clones with "includeIf.*.onbranch"
      reftable: fix tests being broken by NFS' delete-after-close semanti=
cs
      t7800: improve test descriptions with empty arguments
      t7800: use single quotes for test bodies
      t/README: document how to loop around test cases
      reftable/stack: fix error handling in `reftable_stack_init_addition=
()`
      reftable/error: discern locked/outdated errors
      reftable/stack: use error codes when locking fails during compactio=
n
      reftable/stack: gracefully handle failed auto-compaction due to loc=
ks
      refs/reftable: print errors on compaction failure
      t/helper: drop pack-refs wrapper
      refs: move `struct pack_refs_opts` to where it's used
      refs: remove `PACK_REFS_ALL` flag
      refs/reftable: expose auto compaction via new flag
      builtin/pack-refs: release allocated memory
      builtin/pack-refs: introduce new "--auto" flag
      builtin/gc: move `struct maintenance_run_opts`
      t6500: extract objects with "17" prefix
      builtin/gc: forward git-gc(1)'s `--auto` flag when packing refs
      builtin/gc: pack refs when using `git maintenance run --auto`
      reftable/basics: fix return type of `binsearch()` to be `size_t`
      reftable/basics: improve `binsearch()` test
      reftable/refname: refactor binary search over refnames
      reftable/block: refactor binary search over restart points
      reftable/block: fix error handling when searching restart points
      reftable/record: extract function to decode key lengths
      reftable/block: avoid decoding keys when searching restart points
      t0610: make `--shared=3D` tests reusable
      t0610: execute git-pack-refs(1) with specified umask
      reftable/block: rename `block_reader_start()`
      reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
      reftable/block: better grouping of functions
      reftable/block: introduce `block_reader_release()`
      reftable/block: move ownership of block reader into `struct table_i=
ter`
      reftable/reader: iterate to next block in place
      reftable/block: reuse uncompressed blocks
      reftable/block: open-code call to `uncompress2()`
      reftable/block: reuse `zstream` state on inflation
      reftable/block: avoid copying block iterators on seek
      pack-bitmap: gracefully handle missing BTMP chunks
      run-command: introduce function to prepare auto-maintenance process
      builtin/receive-pack: convert to use git-maintenance(1)
      docs: improve changelog entry for `git pack-refs --auto`
      docs: address typos in Git v2.45 changelog

Peter Hutterer (1):
      diff: add diff.srcPrefix and diff.dstPrefix configuration variables

Peter Krefting (2):
      bisect: report the found commit with "show"
      l10n: sv.po: Update Swedish translation

Philippe Blain (5):
      merge-ort: turn submodule conflict suggestions into an advice
      ci(github): make Windows test artifacts name unique
      sequencer: allow disabling conflict advice
      builtin/am: allow disabling conflict advice
      t/README: mention test files are make targets

Phillip Wood (9):
      rebase -i: stop setting GIT_CHERRY_PICK_HELP
      xdiff-interface: refactor parsing of merge.conflictstyle
      merge-ll: introduce LL_MERGE_OPTIONS_INIT
      merge options: add a conflict style member
      checkout: cleanup --conflict=3D<style> parsing
      checkout: fix interaction between --conflict and --merge
      t3428: modernize test setup
      t3428: use test_commit_message
      t3428: restore coverage for "apply" backend

Pi Fisher (1):
      typo: replace 'commitish' with 'committish'

Ralf Thielow (1):
      l10n: Update German translation

Ralph Seichter (1):
      config: add --comment option to add a comment

Ren=C3=A9 Scharfe (32):
      use xstrncmpz()
      fetch: convert strncmp() with strlen() to starts_with()
      mem-pool: add mem_pool_strfmt()
      name-rev: use mem_pool_strfmt()
      submodule: use strvec_pushf() for --submodule-prefix
      t-ctype: allow NUL anywhere in the specification string
      t-ctype: simplify EOF check
      t-ctype: align output of i
      t-ctype: avoid duplicating class names
      parse-options: recognize abbreviated negated option with arg
      parse-options: set arg of abbreviated option lazily
      parse-options: factor out register_abbrev() and struct parsed_optio=
n
      parse-options: detect ambiguous self-negation
      parse-options: normalize arg and long_name before comparison
      parse-options: rearrange long_name matching code
      t-prio-queue: shorten array index message
      t-prio-queue: check result array bounds
      factor out strbuf_expand_bad_format()
      cat-file: use strbuf_expand_bad_format()
      midx: use strvec_pushf() for pack-objects base name
      mem-pool: use st_add() in mem_pool_strvfmt()
      imap-send: use xsnprintf to format command
      t-prio-queue: simplify using compound literals
      apply: avoid fixed-size buffer in create_one_file()
      path: remove mksnpath()
      apply: don't leak fd on fdopen() error
      usage: report vsnprintf(3) failure
      date: make DATE_MODE thread-safe
      git-compat-util: fix NO_OPENSSL on current macOS
      imap-send: increase command size limit
      apply: avoid using fixed-size buffer in write_out_one_reject()
      don't report vsnprintf(3) error as bug

Richard Macklin (1):
      rebase: fix typo in autosquash documentation

Rub=C3=A9n Justo (18):
      tag: error when git-column fails
      completion: fix __git_complete_worktree_paths
      completion: reflog with implicit "show"
      completion: reflog show <log-options>
      completion: introduce __git_find_subcommand
      completion: factor out __git_resolve_builtins
      completion: reflog subcommands and options
      checkout: plug some leaks in git-restore
      add-patch: introduce 'p' in interactive-patch
      add-patch: do not print hunks repeatedly
      add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
      add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
      add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO
      launch_editor: waiting message on error
      apply: plug a leak in apply_data
      add-interactive: plug a leak in get_untracked_files
      add-patch: plug a leak handling the '/' command
      add: plug a leak on interactive_add

SZEDER G=C3=A1bor (1):
      upload-pack: don't send null character in abort message to the clie=
nt

Sergey Organov (1):
      clean: improve -n and -f implementation and documentation

Steven Jeuris (1):
      userdiff: better method/property matching for C#

Taylor Blau (9):
      Documentation/config/pack.txt: fix broken AsciiDoc mark-up
      upload-pack: disallow object-info capability by default
      midx-write: move writing-related functions from midx.c
      midx-write.c: factor out common want_included_pack() routine
      midx-write.c: check count of packs to repack after grouping
      midx-write.c: use `--stdin-packs` when repacking
      t/t7700-repack.sh: fix test breakages with `GIT_TEST_MULTI_PACK_IND=
EX=3D1 `
      Makefile(s): avoid recipe prefix in conditional statements
      Documentation/RelNotes/2.45.0.txt: fix typo

Teng Long (1):
      l10n: zh_CN: for git 2.45 rounds

Thalia Archibald (8):
      fast-import: tighten path unquoting
      fast-import: directly use strbufs for paths
      fast-import: allow unquoted empty path for root
      fast-import: remove dead strbuf
      fast-import: improve documentation for path quoting
      fast-import: document C-style escapes for paths
      fast-import: forbid escaped NUL in paths
      fast-import: make comments more precise

Ville Skytt=C3=A4 (2):
      completion: fix prompt with unset SHOWCONFLICTSTATE in nounset mode
      completion: protect prompt against unset SHOWUPSTREAM in nounset mo=
de

Vincenzo Mezzela (1):
      t7301: use test_path_is_(missing|file)

V=C5=A9 Ti=E1=BA=BFn H=C6=B0ng (2):
      l10n: Update Vietnamese team contact
      l10n: vi: Updated translation for 2.45

Xing Xin (1):
      Documentation: fix typos describing date format

Yehezkel Bernat (1):
      Documentation: fix linkgit reference

Yi-Jyun Pan (1):
      l10n: zh-TW: Git 2.45

brian m. carlson (7):
      loose: add a mapping between SHA-1 and SHA-256 for loose objects
      commit: write commits for both hashes
      cache: add a function to read an OID of a specific algorithm
      object-file-convert: add a function to convert trees between algori=
thms
      object-file-convert: convert tag objects when writing
      object-file-convert: convert commit objects when writing
      repository: implement extensions.compatObjectFormat

shejialuo (1):
      t9117: prefer test_path_* helper functions

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (1):
      t9604: Fix test for musl libc and new Debian


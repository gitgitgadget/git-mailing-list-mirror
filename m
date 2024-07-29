Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0E15B97D;
	Mon, 29 Jul 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272986; cv=none; b=b2wqZB6BB0Djn/X5ZfFCX1gaL/omdcBSKc9kGPyYD4OBcY5RYHtNXE8yLgCCjduKCr3EQ9dqBgv3aCqzwJFBTC+9rVdWQO3oOvXU3ThIe1m55XvMtyjXwI5h9RdQZrz9arf6835l8B98tp8CvbkTCuGZGEv4P6qqQcJs0bajY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272986; c=relaxed/simple;
	bh=t88l6ouPH0Csb0/m/SGHIHPuPH3AQqkWWv3QUbQ4o7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVD4QRAgmUP3U1R7y1YRHOK5GU8UcCrOPBiXr4xwlXxObYzOcgMIL8dL9hT0NUlcOdmb+NjnxD2CjP+m4oagYlC/78TF7lYFAoame3cLU+A79fxXgv4N8NB3QQ2f5LlwZvFYjoUvYWJ1RfkjQ30rWRx32hNm6VoW+K/MRrg+yoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GqpTNvao; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GqpTNvao"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA4CA23C92;
	Mon, 29 Jul 2024 13:09:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=t88l6ouPH0Csb0/m/SGHIHPuP
	H3AQqkWWv3QUbQ4o7M=; b=GqpTNvaoZS1Znv0bBO53ZVXTDOiaBdjuUElzpPNH1
	Qf0ogqt08WbPbC388B8sARDsbEH1iSR0KZS4zhN9GDWcUtsgRNPFz4LlC1x7b94G
	NMa/WxwqMbhw2Zywc1ED32xps8MsDPLpuQtg2ttboqwZhLqPrZ58WzOBZXzA8pWN
	2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFF9523C91;
	Mon, 29 Jul 2024 13:09:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FAAB23C90;
	Mon, 29 Jul 2024 13:09:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.46.0
Date: Mon, 29 Jul 2024 10:09:33 -0700
Message-ID: <xmqqzfq0i0qa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 545D8FBC-4DCD-11EF-AF09-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The latest feature release Git v2.46.0 is now available at the
usual places.  It is comprised of 746 non-merge commits since
v2.45.0, contributed by 96 people, 31 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.46.0'
tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.45.0 are as follows.
Welcome to the Git development community!

  Aaron Plattner, Abhijeet Sonar, Apple Product Security, Brooke
  Kuhlmann, Cs=C3=B3k=C3=A1s, Bence, Darcy Burke, David Bimmler, Dov
  Murik, Dr. David Alan Gilbert, Fahad Alrashed, Filip Hejsek,
  Heghedus Razvan, hms5232, Ivan Tse, James Liu, Jes=C3=BAs Ariel
  Cabello Mateos, Jun T, Koji Nakamaru, L=C3=A9onard Michelet,
  lolligerhans@gmx.de, Marcel Telka, Mathew George, Matt Cree,
  Ngoo Ka-iu, Nightfeather Chen, Paul Millar, Piotr Szlazak,
  Rikita Ishikawa, Roland Hieber, Shane Sun, and Tom Hughes.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Achu Luma, Adam Johnson, Alexander Shopov, Arkadii Yakovets,
  Bagas Sanjaya, Beat Bolli, brian m. carlson, Chandra Pratap,
  Christian Couder, Christian Hesse, Dario Gjorgjevski, D. Ben
  Knoble, Derrick Stolee, Dragan Simic, Elijah Newren, Emir SARI,
  Eric Sunshine, Eric Wong, Ghanshyam Thakkar, Ian Wienand,
  Jean-No=C3=ABl Avila, Jeff King, Johannes Schindelin, Johannes
  Sixt, John Passaro, John Paul Adrian Glaubitz, Jonathan Nieder,
  Jonathan Tan, Josh Soref, Josh Steadmon, Junio C Hamano, Justin
  Tobler, Kaartic Sivaraam, Karthik Nayak, Kate Golovanova, Kirill
  Smelkov, Kisaragi Hiu, Kyle Lippincott, Kyle Zhao, Linus Arver,
  Lumynous, Martin =C3=85gren, Matthias A=C3=9Fhauer, Matthias R=C3=BCste=
r,
  Mike Hommey, Orgad Shaneh, =C3=98ystein Walle, Patrick Steinhardt,
  Peter Krefting, Phillip Wood, Ralf Thielow, Ramsay Jones, Randall
  S. Becker, Ren=C3=A9 Scharfe, Rub=C3=A9n Justo, Stefan Haller, SZEDER
  G=C3=A1bor, Taylor Blau, Teng Long, Torsten B=C3=B6gershausen, Victoria
  Dye, V=C5=A9 Ti=E1=BA=BFn H=C6=B0ng, Xing Xin, Yi-Jyun Pan, and =E4=BE=9D=
=E4=BA=91.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.46 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

UI, Workflows & Features

 * The "--rfc" option of "git format-patch" learned to take an
   optional string value to be used in place of "RFC" to tweak the
   "[PATCH]" on the subject header.

 * The credential helper protocol, together with the HTTP layer, have
   been enhanced to support authentication schemes different from
   username & password pair, like Bearer and NTLM.

 * Command line completion script (in contrib/) learned to complete
   "git symbolic-ref" a bit better (you need to enable plumbing
   commands to be completed with GIT_COMPLETION_SHOW_ALL_COMMANDS).

 * When the user responds to a prompt given by "git add -p" with an
   unsupported command, list of available commands were given, which
   was too much if the user knew what they wanted to type but merely
   made a typo.  Now the user gets a much shorter error message.

 * The color parsing code learned to handle 12-bit RGB colors, spelled
   as "#RGB" (in addition to "#RRGGBB" that is already supported).

 * The operation mode options (like "--get") the "git config" command
   uses have been deprecated and replaced with subcommands (like "git
   config get").

 * "git tag" learned the "--trailer" option to futz with the trailers
   in the same way as "git commit" does.

 * A new global "--no-advice" option can be used to disable all advice
   messages, which is meant to be used only in scripts.

 * Updates to symbolic refs can now be made as a part of ref
   transaction.

 * The trailer API has been reshuffled a bit.

 * Terminology to call various ref-like things are getting
   straightened out.

 * The command line completion script (in contrib/) has been adjusted
   to the recent update to "git config" that adopted subcommand based
   UI.

 * The knobs to tweak how reftable files are written have been made
   available as configuration variables.

 * When "git push" notices that the commit at the tip of the ref on
   the other side it is about to overwrite does not exist locally, it
   used to first try fetching it if the local repository is a partial
   clone. The command has been taught not to do so and immediately
   fail instead.

 * The promisor.quiet configuration knob can be set to true to make
   lazy fetching from promisor remotes silent.

 * The inter/range-diff output has been moved to the end of the patch
   when format-patch adds it to a single patch, instead of writing it
   before the patch text, to be consistent with what is done for a
   cover letter for a multi-patch series.

 * A new command has been added to migrate a repository that uses the
   files backend for its ref storage to use the reftable backend, with
   limitations.

 * "git diff --exit-code --ext-diff" learned to take the exit status
   of the external diff driver into account when deciding the exit
   status of the overall "git diff" invocation when configured to do
   so.

 * "git update-ref --stdin" learned to handle transactional updates of
   symbolic-refs.

 * "git format-patch --interdiff" for multi-patch series learned to
   turn on cover letters automatically (unless told never to enable
   cover letter with "--no-cover-letter" and such).

 * The "--heads" option of "ls-remote" and "show-ref" has been been
   deprecated; "--branches" replaces "--heads".

 * For over a year, setting add.interactive.useBuiltin configuration
   variable did nothing but giving a "this does not do anything"
   warning.  The warning has been removed.

 * The http transport can now be told to send request with
   authentication material without first getting a 401 response.

 * A handful of entries are added to the GitFAQ document.

 * "git var GIT_SHELL_PATH" should report the path to the shell used
   to spawn external commands, but it didn't do so on Windows, which
   has been corrected.


Performance, Internal Implementation, Development Support etc.

 * Advertise "git contacts", a tool for newcomers to find people to
   ask review for their patches, a bit more in our developer
   documentation.

 * In addition to building the objects needed, try to link the objects
   that are used in fuzzer tests, to make sure at least they build
   without bitrot, in Linux CI runs.

 * Code to write out reftable has seen some optimization and
   simplification.

 * Tests to ensure interoperability between reftable written by jgit
   and our code have been added and enabled in CI.

 * The singleton index_state instance "the_index" has been eliminated
   by always instantiating "the_repository" and replacing references
   to "the_index"  with references to its .index member.

 * Git-GUI has a new maintainer, Johannes Sixt.

 * The "test-tool" has been taught to run testsuite tests in parallel,
   bypassing the need to use the "prove" tool.

 * The "whitespace check" task that was enabled for GitHub Actions CI
   has been ported to GitLab CI.

 * The refs API lost functions that implicitly assumes to work on the
   primary ref_store by forcing the callers to pass a ref_store as an
   argument.

 * Code clean-up to reduce inter-function communication inside
   builtin/config.c done via the use of global variables.

 * The pack bitmap code saw some clean-up to prepare for a follow-up topi=
c.

 * Preliminary code clean-up for "git send-email".

 * The default "creation-factor" used by "git format-patch" has been
   raised to make it more aggressively find matching commits.

 * Before discovering the repository details, We used to assume SHA-1
   as the "default" hash function, which has been corrected. Hopefully
   this will smoke out codepaths that rely on such an unwarranted
   assumptions.

 * The project decision making policy has been documented.

 * The strcmp-offset tests have been rewritten using the unit test
   framework.

 * "git add -p" learned to complain when an answer with more than one
   letter is given to a prompt that expects a single letter answer.

 * The alias-expanded command lines are logged to the trace output.

 * A new test was added to ensure git commands that are designed to
   run outside repositories do work.

 * A few tests in reftable library have been rewritten using the
   unit test framework.

 * A pair of test helpers that essentially are unit tests on hash
   algorithms have been rewritten using the unit-tests framework.

 * A test helper that essentially is unit tests on the "decorate"
   logic has been rewritten using the unit-tests framework.

 * Many memory leaks in the sparse-checkout code paths have been
   plugged.

 * "make check-docs" noticed problems and reported to its output but
   failed to signal its findings with its exit status, which has been
   corrected.

 * Building with "-Werror -Wwrite-strings" is now supported.

 * To help developers, the build procedure now allows builders to use
   CFLAGS_APPEND to specify additional CFLAGS.

 * "oidtree" tests were rewritten to use the unit test framework.

 * The structure of the document that records longer-term project
   decisions to deprecate/remove/update various behaviour has been
   outlined.

 * The pseudo-merge reachability bitmap to help more efficient storage
   of the reachability bitmap in a repository with too many refs has
   been added.

 * When "git merge" sees that the index cannot be refreshed (e.g. due
   to another process doing the same in the background), it died but
   after writing MERGE_HEAD etc. files, which was useless for the
   purpose to recover from the failure.

 * The output from "git cat-file --batch-check" and "--batch-command
   (info)" should not be unbuffered, for which some tests have been
   added.

 * A CPP macro USE_THE_REPOSITORY_VARIABLE is introduced to help
   transition the codebase to rely less on the availability of the
   singleton the_repository instance.

 * "git version --build-options" reports the version information of
   OpenSSL and other libraries (if used) in the build.

 * Memory ownership rules for the in-core representation of
   remote.*.url configuration values have been straightened out, which
   resulted in a few leak fixes and code clarification.

 * When bundleURI interface fetches multiple bundles, Git failed to
   take full advantage of all bundles and ended up slurping duplicated
   objects, which has been corrected.

 * The code to deal with modified paths that are out-of-cone in a
   sparsely checked out working tree has been optimized.

 * An existing test of oidmap API has been rewritten with the
   unit-test framework.

 * The "ort" merge backend saw one bugfix for a crash that happens
   when inner merge gets killed, and assorted code clean-ups.

 * A new warning message is issued when a command has to expand a
   sparse index to handle working tree cruft that are outside of the
   sparse checkout.

 * The test framework learned to take the test body not as a single
   string but as a here-document.

 * "git push '' HEAD:there" used to hit a BUG(); it has been corrected
   to die with "fatal: bad repository ''".

 * What happens when http.cookieFile gets the special value "" has
   been clarified in the documentation.


Fixes since v2.45
-----------------

 * "git rebase --signoff" used to forget that it needs to add a
   sign-off to the resulting commit when told to continue after a
   conflict stops its operation.

 * The procedure to build multi-pack-index got confused by the
   replace-refs mechanism, which has been corrected by disabling the
   latter.

 * The "-k" and "--rfc" options of "format-patch" will now error out
   when used together, as one tells us not to add anything to the
   title of the commit, and the other one tells us to add "RFC" in
   addition to "PATCH".

 * "git stash -S" did not handle binary files correctly, which has
   been corrected.

 * A scheduled "git maintenance" job is expected to work on all
   repositories it knows about, but it stopped at the first one that
   errored out.  Now it keeps going.

 * zsh can pretend to be a normal shell pretty well except for some
   glitches that we tickle in some of our scripts. Work them around
   so that "vimdiff" and our test suite works well enough with it.

 * Command line completion support for zsh (in contrib/) has been
   updated to stop exposing internal state to end-user shell
   interaction.

 * Tests that try to corrupt in-repository files in chunked format did
   not work well on macOS due to its broken "mv", which has been
   worked around.

 * The maximum size of attribute files is enforced more consistently.

 * Unbreak CI jobs so that we do not attempt to use Python 2 that has
   been removed from the platform.

 * Git 2.43 started using the tree of HEAD as the source of attributes
   in a bare repository, which has severe performance implications.
   For now, revert the change, without ripping out a more explicit
   support for the attr.tree configuration variable.

 * The "--exit-code" option of "git diff" command learned to work with
   the "--ext-diff" option.

 * Windows CI running in GitHub Actions started complaining about the
   order of arguments given to calloc(); the imported regex code uses
   the wrong order almost consistently, which has been corrected.

 * Expose "name conflict" error when a ref creation fails due to D/F
   conflict in the ref namespace, to improve an error message given by
   "git fetch".
   (merge 9339fca23e it/refs-name-conflict later to maint).

 * The SubmittingPatches document now refers folks to manpages
   translation project.

 * The documentation for "git diff --name-only" has been clarified
   that it is about showing the names in the post-image tree.

 * The credential helper that talks with osx keychain learned to avoid
   storing back the authentication material it just got received from
   the keychain.
   (merge e1ab45b2da kn/osxkeychain-skip-idempotent-store later to maint)=
.

 * The chainlint script (invoked during "make test") did nothing when
   it failed to detect the number of available CPUs.  It now falls
   back to 1 CPU to avoid the problem.

 * Revert overly aggressive "layered defence" that went into 2.45.1
   and friends, which broke "git-lfs", "git-annex", and other use
   cases, so that we can rebuild necessary counterparts in the open.

 * "git init" in an already created directory, when the user
   configuration has includeif.onbranch, started to fail recently,
   which has been corrected.

 * Memory leaks in "git mv" has been plugged.

 * The safe.directory configuration knob has been updated to
   optionally allow leading path matches.

 * An overly large ".gitignore" files are now rejected silently.

 * Upon expiration event, the credential subsystem forgot to clear
   in-core authentication material other than password (whose support
   was added recently), which has been corrected.

 * Fix for an embarrassing typo that prevented Python2 tests from running
   anywhere.

 * Varargs functions that are unannotated as printf-like or execl-like
   have been annotated as such.

 * "git am" has a safety feature to prevent it from starting a new
   session when there already is a session going.  It reliably
   triggers when a mbox is given on the command line, but it has to
   rely on the tty-ness of the standard input.  Add an explicit way to
   opt out of this safety with a command line option.
   (merge 62c71ace44 jk/am-retry later to maint).

 * A leak in "git imap-send" that somehow escapes LSan has been
   plugged.

 * Setting core.abbrev too early before the repository set-up
   (typically in "git clone") caused segfault, which as been
   corrected.

 * When the user adds to "git rebase -i" instruction to "pick" a merge
   commit, the error experience is not pleasant.  Such an error is now
   caught earlier in the process that parses the todo list.

 * We forgot to normalize the result of getcwd() to NFC on macOS where
   all other paths are normalized, which has been corrected.  This still
   does not address the case where core.precomposeUnicode configuration
   is not defined globally.

 * Earlier we stopped using the tree of HEAD as the default source of
   attributes in a bare repository, but failed to document it.  This
   has been corrected.

 * "git update-server-info" and "git commit-graph --write" have been
   updated to use the tempfile API to avoid leaving cruft after
   failing.

 * An unused extern declaration for mingw has been removed to prevent
   it from causing build failure.

 * A helper function shared between two tests had a copy-paste bug,
   which has been corrected.

 * "git fetch-pack -k -k" without passing "--lock-pack" (which we
   never do ourselves) did not work at all, which has been corrected.

 * CI job to build minimum fuzzers learned to pass NO_CURL=3DNoThanks to
   the build procedure, as its build environment does not offer, or
   the rest of the build needs, anything cURL.
   (merge 4e66b5a990 jc/fuzz-sans-curl later to maint).

 * "git diff --no-ext-diff" when diff.external is configured ignored
   the "--color-moved" option.
   (merge 0f4b0d4cf0 rs/diff-color-moved-w-no-ext-diff-fix later to maint=
).

 * "git archive --add-virtual-file=3D<path>:<contents>" never paid
   attention to the --prefix=3D<prefix> option but the documentation
   said it would. The documentation has been corrected.
   (merge 72c282098d jc/archive-prefix-with-add-virtual-file later to mai=
nt).

 * When GIT_PAGER failed to spawn, depending on the code path taken,
   we failed immediately (correct) or just spew the payload to the
   standard output (incorrect).  The code now always fail immediately
   when GIT_PAGER fails.
   (merge 78f0a5d187 rj/pager-die-upon-exec-failure later to maint).

 * date parser updates to be more careful about underflowing epoch
   based timestamp.
   (merge 9d69789770 db/date-underflow-fix later to maint).

 * The Bloom filter used for path limited history traversal was broken
   on systems whose "char" is unsigned; update the implementation and
   bump the format version to 2.
   (merge 9c8a9ec787 tb/path-filter-fix later to maint).

 * Typofix.
   (merge 231cf7370e as/pathspec-h-typofix later to maint).

 * Code clean-up.
   (merge 4b837f821e rs/simplify-submodule-helper-super-prefix-invocation=
 later to maint).

 * "git describe --dirty --broken" forgot to refresh the index before
   seeing if there is any chang, ("git describe --dirty" correctly did
   so), which has been corrected.
   (merge b8ae42e292 as/describe-broken-refresh-index-fix later to maint)=
.

 * Test suite has been taught not to unnecessarily rely on DNS failing
   a bogus external name.
   (merge 407cdbd271 jk/tests-without-dns later to maint).

 * GitWeb update to use committer date consistently in rss/atom feeds.
   (merge cf6ead095b am/gitweb-feed-use-committer-date later to maint).

 * Custom control structures we invented more recently have been
   taught to the clang-format file.
   (merge 1457dff9be rs/clang-format-updates later to maint).

 * Developer build procedure fix.
   (merge df32729866 tb/dev-build-pedantic-fix later to maint).

 * "git push" that pushes only deletion gave an unnecessary and
   harmless error message when push negotiation is configured, which
   has been corrected.
   (merge 4d8ee0317f jc/disable-push-nego-for-deletion later to maint).

 * Address-looking strings found on the trailer are now placed on the
   Cc: list after running through sanitize_address by "git send-email".
   (merge c852531f45 cb/send-email-sanitize-trailer-addresses later to ma=
int).

 * Tests that use GIT_TEST_SANITIZE_LEAK_LOG feature got their exit
   status inverted, which has been corrected.
   (merge 8c1d6691bc rj/test-sanitize-leak-log-fix later to maint).

 * The http.cookieFile and http.saveCookies configuration variables
   have a few values that need to be avoided, which are now ignored
   with warning messages.
   (merge 4f5822076f jc/http-cookiefile later to maint).

 * Repacking a repository with multi-pack index started making stupid
   pack selections in Git 2.45, which has been corrected.
   (merge 8fb6d11fad ds/midx-write-repack-fix later to maint).

 * Fix documentation mark-up regression in 2.45.
   (merge 6474da0aa4 ja/doc-markup-updates-fix later to maint).

 * Work around asciidoctor's css that renders `monospace` material
   in the SYNOPSIS section of manual pages as block elements.
   (merge d44ce6ddd5 js/doc-markup-updates-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 493fdae046 ew/object-convert-leakfix later to maint).
   (merge 00f3661a0a ss/doc-eol-attr-fix later to maint).
   (merge 428c40da61 ri/doc-show-branch-fix later to maint).
   (merge 58696bfcaa jc/where-is-bash-for-ci later to maint).
   (merge 616e94ca24 tb/doc-max-tree-depth-fix later to maint).

----------------------------------------------------------------

Changes since v2.45.0 are as follows:

Aaron Plattner (1):
      credential: clear expired c->credential, unify secret clearing

Abhijeet Sonar (2):
      describe: refresh the index when 'broken' flag is used
      pathspec: fix typo "glossary-context.txt" -> "glossary-content.txt"

Adam Johnson (1):
      stash: fix "--staged" with binary files

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5734t)

Arkadii Yakovets (1):
      l10n: uk: v2.46 update

Bagas Sanjaya (1):
      l10n: po-id for 2.46

Beat Bolli (3):
      t/t4026-color: remove an extra double quote character
      t/t4026-color: add test coverage for invalid RGB colors
      color: add support for 12-bit RGB colors

Chandra Pratap (16):
      t: move reftable/basics_test.c to the unit testing framework
      t: move tests from reftable/stack_test.c to the new unit test
      t: move tests from reftable/record_test.c to the new unit test
      t: add test for put_be16()
      t: improve the test-case for parse_names()
      t: move reftable/record_test.c to the unit testing framework
      t-reftable-record: add reftable_record_cmp() tests for log records
      t-reftable-record: add comparison tests for ref records
      t-reftable-record: add comparison tests for index records
      t-reftable-record: add comparison tests for obj records
      t-reftable-record: add ref tests for reftable_record_is_deletion()
      t-reftable-record: add log tests for reftable_record_is_deletion()
      t-reftable-record: add obj tests for reftable_record_is_deletion()
      t-reftable-record: add index tests for reftable_record_is_deletion(=
)
      t-reftable-record: add tests for reftable_ref_record_compare_name()
      t-reftable-record: add tests for reftable_log_record_compare_key()

Christian Hesse (1):
      refs: correct the version numbers in a comment

Cs=C3=B3k=C3=A1s, Bence (1):
      git-send-email: use sanitized address when reading mbox body

D. Ben Knoble (1):
      completion: zsh: stop leaking local cache variable

Darcy Burke (1):
      date: detect underflow/overflow when parsing dates with timezone of=
fset

Derrick Stolee (10):
      scalar: avoid segfault in reconfigure --all
      commit-graph: increment progress indicator
      sparse-checkout: refactor skip worktree retry logic
      sparse-index: refactor path_found()
      sparse-index: use strbuf in path_found()
      sparse-index: count lstat() calls
      sparse-index: improve lstat caching of sparse paths
      advice: warn when sparse index expands
      t5319: add failing test case for repack/expire
      midx-write: revert use of --stdin-packs

Dov Murik (1):
      documentation: git-update-index: add --show-index-version to synops=
is

Dr. David Alan Gilbert (1):
      fetch-pack: remove unused 'struct loose_object_iter'

Dragan Simic (3):
      send-email: move newline characters out of a few translatable strin=
gs
      format-patch: ensure that --rfc and -k are mutually exclusive
      doc: interactive.singleKey is disabled by default

Elijah Newren (8):
      merge-ort: extract handling of priv member into reusable function
      merge-ort: maintain expected invariant for priv member
      merge-ort: fix type of local 'clean' var in handle_content_merge ()
      merge-ort: clearer propagation of failure-to-function from merge_su=
bmodule
      merge-ort: loosen commented requirements
      merge-ort: upon merge abort, only show messages causing the abort
      merge-ort: convert more error() cases to path_msg()
      merge-ort: fix missing early return

Emir SARI (1):
      l10n: tr: Update Turkish translations

Eric Sunshine (3):
      chainlint.pl: make CPU count computation more robust
      chainlint.pl: latch CPU count directly reported by /proc/cpuinfo
      chainlint.pl: recognize test bodies defined via heredoc

Eric Wong (3):
      Git.pm: use array in command_bidi_pipe example
      t1006: ensure cat-file info isn't buffered by default
      object-file: fix leak on conversion failure

Fahad Alrashed (1):
      git-p4: show Perforce error to the user

Filip Hejsek (4):
      t0411: add tests for cloning from partial repo
      has_dir_name(): do not get confused by characters < '/'
      t7423: add tests for symlinked submodule directories
      clone: prevent clashing git dirs when cloning submodule in parallel

Ghanshyam Thakkar (6):
      t/: port helper/test-strcmp-offset.c to unit-tests/t-strcmp-offset.=
c
      t/: migrate helper/test-example-decorate to the unit testing framew=
ork
      strbuf: introduce strbuf_addstrings() to repeatedly add a string
      t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
      t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
      t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c

Ian Wienand (3):
      Documentation: alias: rework notes into points
      Documentation: alias: add notes on shell expansion
      run-command: show prepared command

Ivan Tse (1):
      refs: return conflict error when checking packed refs

James Liu (3):
      doc: clean up usage documentation for --no-* opts
      doc: add spacing around paginate options
      advice: add --no-advice global option

Jean-No=C3=ABl Avila (2):
      l10n: fr: v2.46.0
      doc: git-clone fix discrepancy between asciidoc and asciidoctor

Jeff King (65):
      http: reset POSTFIELDSIZE when clearing curl handle
      INSTALL: bump libcurl version to 7.21.3
      remote-curl: add Transfer-Encoding header only for older curl
      test-lib: ignore uninteresting LSan output
      upload-pack: disable lazy-fetching by default
      docs: document security issues around untrusted .git dirs
      t/Makefile: run unit tests alongside shell tests
      ci: update coverity runs_on_pool reference
      ci: drop mention of BREW_INSTALL_PACKAGES variable
      ci: avoid bare "gcc" for osx-gcc job
      ci: stop installing "gcc-13" for osx-gcc
      send-email: drop FakeTerm hack
      send-email: avoid creating more than one Term::ReadLine object
      ci: drop mention of BREW_INSTALL_PACKAGES variable
      ci: avoid bare "gcc" for osx-gcc job
      ci: stop installing "gcc-13" for osx-gcc
      t-strvec: use va_end() to match va_start()
      t-strvec: mark variable-arg helper with LAST_ARG_MUST_BE_NULL
      mv: move src_dir cleanup to end of cmd_mv()
      mv: factor out empty src_dir removal
      mv: replace src_dir with a strvec
      dir.c: skip .gitignore, etc larger than INT_MAX
      sparse-checkout: free string list in write_cone_to_file()
      sparse-checkout: pass string literals directly to add_pattern()
      dir.c: free strings in sparse cone pattern hashmaps
      sparse-checkout: clear patterns when init() sees existing sparse fi=
le
      dir.c: free removed sparse-pattern hashmap entries
      dir.c: reduce max pattern file size to 100MB
      dir.c: always copy input to add_pattern()
      sparse-checkout: reuse --stdin buffer when reading patterns
      sparse-checkout: always free "line" strbuf after reading input
      sparse-checkout: refactor temporary sparse_checkout_patterns
      sparse-checkout: free sparse_filename after use
      sparse-checkout: free pattern list in sparse_checkout_list()
      sparse-checkout: free string list after displaying
      sparse-checkout: free duplicate hashmap entries
      am: add explicit "--retry" option
      test-terminal: drop stdin handling
      imap-send: free all_msgs strbuf in "out" label
      archive: fix check for missing url
      remote: refactor alias_url() memory ownership
      remote: transfer ownership of memory in add_url(), etc
      remote: use strvecs to store remote url/pushurl
      remote: simplify url/pushurl selection
      config: document remote.*.url/pushurl interaction
      remote: allow resetting url list
      t5801: make remote-testgit GIT_DIR setup more robust
      t5801: test remote.*.vcs config
      remote: always require at least one url in a remote
      remote: drop checks for zero-url case
      fetch-pack: fix segfault when fscking without --lock-pack
      t5500: fix mistaken $SERVER reference in helper function
      t5553: use local url for invalid fetch
      t5551: do not confirm that bogus url cannot be used
      t/lib-bundle-uri: use local fake bundle URLs
      chainlint.pl: add test_expect_success call to test snippets
      chainlint.pl: only start threads if jobs > 1
      chainlint.pl: do not spawn more threads than we have scripts
      chainlint.pl: force CRLF conversion when opening input files
      chainlint.pl: check line numbers in expected output
      chainlint.pl: add tests for test body in heredoc
      test-lib: allow test snippets as here-docs
      t: convert some here-doc test bodies
      t/.gitattributes: ignore whitespace in chainlint expect files
      t4153: stop redirecting input from /dev/zero

Jes=C3=BAs Ariel Cabello Mateos (1):
      gitweb: rss/atom change published/updated date to committer date

Johannes Schindelin (45):
      repository: avoid leaking `fsmonitor` data
      ci: upgrade to using macos-13
      ci(linux-asan/linux-ubsan): let's save some time
      ci: bump remaining outdated Actions versions
      ci(linux32): add a note about Actions that must not be updated
      fetch/clone: detect dubious ownership of local repositories
      submodules: submodule paths must not contain symlinks
      clone_submodule: avoid using `access()` on directories
      submodule: require the submodule path to contain directories only
      t5510: verify that D/F confusion cannot lead to an RCE
      entry: report more colliding paths
      clone: when symbolic links collide with directories, keep the latte=
r
      find_hook(): refactor the `STRIP_EXTENSION` logic
      init: refactor the template directory discovery into its own functi=
on
      Add a helper function to compare file contents
      clone: prevent hooks from running during a clone
      init.templateDir: consider this config setting protected
      core.hooksPath: add some protection while cloning
      fsck: warn about symlink pointing inside a gitdir
      Git 2.39.4
      Git 2.40.2
      Git 2.41.1
      Git 2.42.2
      Git 2.43.4
      Git 2.44.1
      for-each-repo: optionally keep going on an error
      maintenance: running maintenance should not stop on errors
      Git 2.45.1
      cmake: let `test-tool` run the unit tests, too
      hook: plug a new memory leak
      init: use the correct path of the templates directory again
      Revert "core.hooksPath: add some protection while cloning"
      tests: verify that `clone -c core.hooksPath=3D/dev/null` works agai=
n
      clone: drop the protections where hooks aren't run
      Revert "Add a helper function to compare file contents"
      mingw: drop bogus (and unneeded) declaration of `_pgmptr`
      cmake: fix build of `t-oidtree`
      run-command: refactor getting the Unix shell path into its own func=
tion
      strvec: declare the `strvec_push_nodup()` function globally
      win32: override `fspathcmp()` with a directory separator-aware vers=
ion
      mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, to=
o
      run-command(win32): resolve the path to the Unix shell early
      run-command: declare the `git_shell_path()` function globally
      var(win32): do report the GIT_SHELL_PATH that is actually used
      asciidoctor: fix `synopsis` rendering

Johannes Sixt (1):
      git-gui: note the new maintainer

John Passaro (3):
      builtin/commit: use ARGV macro to collect trailers
      builtin/commit: refactor --trailer logic
      builtin/tag: add --trailer option

John Paul Adrian Glaubitz (1):
      chainlint.pl: fix incorrect CPU count on Linux SPARC

Jonathan Tan (1):
      gitformat-commit-graph: describe version 2 of BDAT

Josh Soref (2):
      doc: update links to current pages
      doc: switch links to https

Josh Steadmon (8):
      fuzz: link fuzz programs with `make all` on Linux
      t0080: turn t-basic unit test into a helper
      test-tool run-command testsuite: get shell from env
      test-tool run-command testsuite: remove hardcoded filter
      test-tool run-command testsuite: support unit tests
      unit tests: add rule for running with test-tool
      ci: use test-tool as unit test runner on Windows
      doc: describe the project's decision-making process

Junio C Hamano (75):
      GitHub Actions: update to checkout@v4
      GitHub Actions: update to github-script@v7
      format-patch: allow --rfc to optionally take a value, like --rfc=3D=
WIP
      format-patch: "--rfc=3D-(WIP)" appends to produce [PATCH (WIP)]
      Start the 2.46 cycle
      rev-parse: document how --is-* options work outside a repository
      t/lib-chunk: work around broken "mv" on some vintage of macOS
      stop using HEAD for attributes in bare repository by default
      Makefile(s): do not enforce "all indents must be done with tab"
      format-patch: run range-diff with larger creation-factor
      t0018: two small fixes
      The second batch
      SubmittingPatches: move the patch-flow section earlier
      SubmittingPatches: extend the "flow" section
      SubmittingPatches: welcome the new maintainer of git-gui part
      compat/regex: fix argument order to calloc(3)
      The third batch
      The fourth batch
      Revert "diff: fix --exit-code with external diff"
      The fifth batch
      t0017: clarify dubious test set-up
      SubmittingPatches: advertise git-manpages-l10n project a bit
      diff: document what --name-only shows
      The sixth batch
      setup: add an escape hatch for "no more default hash algorithm" cha=
nge
      t1517: test commands that are designed to be run outside repository
      apply: fix uninitialized hash function
      add-patch: enforce only one-letter response to prompts
      Revert "fsck: warn about symlink pointing inside a gitdir"
      The seventh batch
      show_log: factor out interdiff/range-diff generation
      format-patch: move range/inter diff at the end of a single patch ou=
tput
      The eighth batch
      safe.directory: allow "lead/ing/path/*" match
      The ninth batch
      Git 2.39.5
      t1517: more coverage for commands that work without repository
      Post 2.45.2 updates
      The tenth batch
      imap-send: minimum leakfix
      refs: call branches branches
      ls-remote: introduce --branches and deprecate --heads
      show-ref: introduce --branches and deprecate --heads
      attr.tree: HEAD:.gitattributes is no longer the default in a bare r=
epo
      add-i: finally retire add.interactive.useBuiltin
      The eleventh batch
      worktree_git_path(): move the declaration to path.h
      __attribute__: trace2_region_enter_printf() is like "printf"
      __attribute__: remove redundant attribute declaration for git_die_c=
onfig()
      __attribute__: mark some functions with LAST_ARG_MUST_BE_NULL
      __attribute__: add a few missing format attributes
      The twelfth batch
      The thirteenth batch
      The fourteenth batch
      The fifteenth batch
      fuzz: minimum fuzzers environment lacks libcURL
      The sixteenth batch
      t0006: simplify prerequisites
      archive: document that --add-virtual-file takes full path
      The seventeenth batch
      More post 2.45.2 updates from the 'master' front
      Yet another batch of post 2.45.2 updates from the 'master' front
      The eighteenth batch
      push: avoid showing false negotiation errors
      The ninteenth batch
      ci: unify bash calling convention
      http.c: cookie file tightening
      Git 2.46-rc0
      Post 2.46-rc0 batch #1
      Post 2.46-rc0 batch #2
      Post 2.46-rc0 batch #3
      Git 2.46-rc1
      Doc: fix Asciidoctor css workaround
      Git 2.46-rc2
      Git 2.46

Justin Tobler (6):
      doc: clarify practices for submitting updated patch versions
      ci: pre-collapse GitLab CI sections
      github-ci: fix link to whitespace error
      ci: separate whitespace check script
      ci: make the whitespace report optional
      gitlab-ci: add whitespace error check

Karthik Nayak (17):
      refs: accept symref values in `ref_transaction_update()`
      files-backend: extract out `create_symref_lock()`
      refs: support symrefs in 'reference-transaction' hook
      refs: move `original_update_refname` to 'refs.c'
      refs: add support for transactional symref updates
      refs: use transaction in `refs_create_symref()`
      refs: rename `refs_create_symref()` to `refs_update_symref()`
      refs: remove `create_symref` and associated dead code
      SubmittingPatches: add section for iterating patches
      refs: create and use `ref_update_expects_existing_old_ref()`
      refs: specify error for regular refs with `old_target`
      update-ref: add support for 'symref-verify' command
      update-ref: add support for 'symref-delete' command
      update-ref: add support for 'symref-create' command
      reftable: pick either 'oid' or 'target' for new updates
      update-ref: add support for 'symref-update' command
      builtin/push: call set_refspecs after validating remote

Koji Nakamaru (2):
      osxkeychain: exclusive lock to serialize execution of operations
      osxkeychain: state to skip unnecessary store operations

Kyle Lippincott (1):
      attr: fix msan issue in read_attr_from_index

Kyle Zhao (1):
      merge: avoid write merge state when unable to write index

Linus Arver (18):
      MyFirstContribution: mention contrib/contacts/git-contacts
      SubmittingPatches: clarify 'git-contacts' location
      SubmittingPatches: mention GitGitGadget
      SubmittingPatches: quote commands
      SubmittingPatches: discuss reviewers first
      SubmittingPatches: dedupe discussion of security patches
      SubmittingPatches: add heading for format-patch and send-email
      SubmittingPatches: demonstrate using git-contacts with git-send-ema=
il
      Makefile: sort UNIT_TEST_PROGRAMS
      trailer: add unit tests for trailer iterator
      trailer: teach iterator about non-trailer lines
      sequencer: use the trailer iterator
      interpret-trailers: access trailer_info with new helpers
      trailer: make parse_trailers() return trailer_info pointer
      trailer: make trailer_info struct private
      trailer: retire trailer_info_get() from API
      trailer: document parse_trailers() usage
      trailer unit tests: inspect iterator contents

Marcel Telka (9):
      t/t0211-trace2-perf.sh: fix typo patern -> pattern
      Switch grep from non-portable BRE to portable ERE
      t/t9902-completion.sh: backslashes in echo
      t/t0600-reffiles-backend.sh: rm -v is not portable
      t/t4202-log.sh: fix misspelled variable
      t/t1700-split-index.sh: mv -v is not portable
      t/t9118-git-svn-funky-branch-names.sh: sed needs semicolon
      t/t9001-send-email.sh: sed - remove the i flag for s
      scalar: make enlistment delete to work on all POSIX platforms

Martin =C3=85gren (2):
      Documentation/gitpacking: make sample configs listing blocks
      Documentation/glossary: fix double word

Mike Hommey (1):
      win32: fix building with NO_UNIX_SOCKETS

Orgad Shaneh (1):
      git-gui: fix inability to quit after closing another instance

Patrick Steinhardt (267):
      refs/reftable: fix D/F conflict error message on ref copy
      refs/reftable: perform explicit D/F check when writing symrefs
      refs/reftable: skip duplicate name checks
      reftable: remove name checks
      refs/reftable: don't recompute committer ident
      reftable/writer: refactorings for `writer_add_record()`
      reftable/writer: refactorings for `writer_flush_nonempty_block()`
      reftable/writer: unify releasing memory
      reftable/writer: reset `last_key` instead of releasing it
      reftable/block: reuse zstream when writing log blocks
      reftable/block: reuse compressed array
      ci: rename "runs_on_pool" to "distro"
      ci: expose distro name in dockerized GitHub jobs
      ci: skip sudo when we are already root
      ci: drop duplicate package installation for "linux-gcc-default"
      ci: convert "install-dependencies.sh" to use "/bin/sh"
      ci: merge custom PATH directories
      ci: fix setup of custom path for GitLab CI
      ci: merge scripts which install dependencies
      ci: make Perforce binaries executable for all users
      ci: install JGit dependency
      t06xx: always execute backend-specific tests
      t0610: fix non-portable variable assignment
      t0612: add tests to exercise Git/JGit reftable compatibility
      builtin/clone: stop resolving symlinks when copying files
      builtin/clone: abort when hardlinked source and target file differ
      setup.c: introduce `die_upon_dubious_ownership()`
      builtin/clone: refuse local clones of unsafe repositories
      t/helper: stop using `the_index`
      builtin: stop using `the_index`
      repository: initialize index in `repo_init()`
      builtin/clone: stop using `the_index`
      repository: drop `the_index` variable
      repository: drop `initialize_the_repository()`
      config: clarify memory ownership when preparing comment strings
      builtin/config: move option array around
      builtin/config: move "fixed-value" option to correct group
      builtin/config: use `OPT_CMDMODE()` to specify modes
      builtin/config: pull out function to handle config location
      builtin/config: pull out function to handle `--null`
      builtin/config: introduce "list" subcommand
      builtin/config: introduce "get" subcommand
      builtin/config: introduce "set" subcommand
      builtin/config: introduce "unset" subcommand
      builtin/config: introduce "rename-section" subcommand
      builtin/config: introduce "remove-section" subcommand
      builtin/config: introduce "edit" subcommand
      builtin/config: display subcommand help
      gitlab-ci: add smoke test for fuzzers
      ci: fix Python dependency on Ubuntu 24.04
      path: harden validation of HEAD with non-standard hashes
      path: move `validate_headref()` to its only user
      parse-options-cb: only abbreviate hashes when hash algo is known
      attr: don't recompute default attribute source
      attr: fix BUG() when parsing attrs outside of repo
      remote-curl: fix parsing of detached SHA256 heads
      builtin/rev-parse: allow shortening to more than 40 hex characters
      builtin/blame: don't access potentially unitialized `the_hash_algo`
      builtin/bundle: abort "verify" early when there is no repository
      builtin/diff: explicitly set hash algo when there is no repo
      builtin/shortlog: don't set up revisions without repo
      oss-fuzz/commit-graph: set up hash algorithm
      repository: stop setting SHA1 as the default object hash
      refs: introduce missing functions that accept a `struct ref_store`
      refs: add `exclude_patterns` parameter to `for_each_fullref_in()`
      cocci: introduce rules to transform "refs" to pass ref store
      cocci: apply rules to rewrite callers of "refs" interfaces
      refs: remove functions without ref store
      gitlab-ci: fix installing dependencies for fuzz smoke tests
      reftable: consistently refer to `reftable_write_options` as `opts`
      reftable: pass opts as constant pointer
      reftable/writer: drop static variable used to initialize strbuf
      reftable/writer: improve error when passed an invalid block size
      reftable/dump: support dumping a table's block structure
      refs/reftable: allow configuring block size
      reftable: use `uint16_t` to track restart interval
      refs/reftable: allow configuring restart interval
      refs/reftable: allow disabling writing the object index
      reftable: make the compaction factor configurable
      refs/reftable: allow configuring geometric factor
      reftable/block: use `size_t` to track restart point index
      reftable/reader: avoid copying index iterator
      reftable/reader: unify indexed and linear seeking
      reftable/reader: separate concerns of table iter and reftable reade=
r
      reftable/reader: inline `reader_seek_internal()`
      reftable/reader: set up the reader when initializing table iterator
      reftable/merged: split up initialization and seeking of records
      reftable/merged: simplify indices for subiterators
      reftable/generic: move seeking of records into the iterator
      reftable/generic: adapt interface to allow reuse of iterators
      reftable/reader: adapt interface to allow reuse of iterators
      reftable/stack: provide convenience functions to create iterators
      reftable/merged: adapt interface to allow reuse of iterators
      builtin/config: stop printing full usage on misuse
      builtin/config: move legacy mode into its own function
      builtin/config: move subcommand options into `cmd_config()`
      builtin/config: move legacy options into `cmd_config()`
      builtin/config: move actions into `cmd_config_actions()`
      builtin/config: check for writeability after source is set up
      config: make the config source const
      builtin/config: refactor functions to have common exit paths
      builtin/config: move location options into local variables
      builtin/config: move display options into local variables
      builtin/config: move type options into display options
      builtin/config: move default value into display options
      builtin/config: move `respect_includes_opt` into location options
      builtin/config: convert `do_not_match` to a local variable
      builtin/config: convert `value_pattern` to a local variable
      builtin/config: convert `regexp` to a local variable
      builtin/config: convert `key_regexp` to a local variable
      builtin/config: convert `key` to a local variable
      builtin/config: track "fixed value" option via flags only
      builtin/config: convert flags to a local variable
      builtin/config: pass data between callbacks via local variables
      Documentation/glossary: redefine pseudorefs as special refs
      Documentation/glossary: clarify limitations of pseudorefs
      Documentation/glossary: define root refs as refs
      refs: rename `is_pseudoref()` to `is_root_ref()`
      refs: rename `is_special_ref()` to `is_pseudo_ref()`
      refs: do not check ref existence in `is_root_ref()`
      refs: classify HEAD as a root ref
      refs: pseudorefs are no refs
      ref-filter: properly distinuish pseudo and root refs
      refs: refuse to write pseudorefs
      completion: adapt git-config(1) to complete subcommands
      refs: adjust names for `init` and `init_db` callbacks
      refs: rename `init_db` callback to avoid confusion
      refs: implement releasing ref storages
      refs: track ref stores via strmap
      refs: pass repo when retrieving submodule ref store
      refs: refactor `resolve_gitlink_ref()` to accept a repository
      refs: retrieve worktree ref stores via associated repository
      refs: convert iteration over replace refs to accept ref store
      refs: pass ref store when detecting dangling symrefs
      refs: move object peeling into "object.c"
      refs: pass repo when peeling objects
      refs: drop `git_default_branch_name()`
      refs: remove `dwim_log()`
      refs/files: use correct repository
      refs/files: remove references to `the_hash_algo`
      refs/packed: remove references to `the_hash_algo`
      builtin/patch-id: fix uninitialized hash function
      builtin/hash-object: fix uninitialized hash function
      setup: fix bug with "includeIf.onbranch" when initializing dir
      ci: add missing dependency for TTY prereq
      transport-helper: fix leaking helper name
      t: mark a bunch of tests as leak-free
      strbuf: fix leak when `appendwholeline()` fails with EOF
      checkout: clarify memory ownership in `unique_tracking_name()`
      http: refactor code to clarify memory ownership
      config: clarify memory ownership in `git_config_pathname()`
      diff: refactor code to clarify memory ownership of prefixes
      convert: refactor code to clarify ownership of check_roundtrip_enco=
ding
      builtin/log: stop using globals for log config
      builtin/log: stop using globals for format config
      config: clarify memory ownership in `git_config_string()`
      config: plug various memory leaks
      builtin/credential: clear credential before exit
      commit-reach: fix memory leak in `ahead_behind()`
      submodule: fix leaking memory for submodule entries
      strvec: add functions to replace and remove strings
      builtin/mv: refactor `add_slash()` to always return allocated strin=
gs
      builtin/mv duplicate string list memory
      builtin/mv: refactor to use `struct strvec`
      builtin/mv: fix leaks for submodule gitfile paths
      Makefile: extract script to lint missing/extraneous manpages
      Documentation/lint-manpages: bubble up errors
      gitlab-ci: add job to run `make check-docs`
      ci/test-documentation: work around SyntaxWarning in Python 3.12
      setup: unset ref storage when reinitializing repository version
      refs: convert ref storage format to an enum
      refs: pass storage format to `ref_store_init()` explicitly
      refs: allow to skip creation of reflog entries
      refs/files: refactor `add_pseudoref_and_head_entries()`
      refs/files: extract function to iterate through root refs
      refs/files: fix NULL pointer deref when releasing ref store
      reftable: inline `merged_table_release()`
      worktree: don't store main worktree twice
      refs: implement removal of ref storages
      refs: implement logic to migrate between ref storage formats
      builtin/refs: new command to migrate ref storage formats
      ci: fix check for Ubuntu 20.04
      global: improve const correctness when assigning string constants
      global: convert intentionally-leaking config strings to consts
      refs/reftable: stop micro-optimizing refname allocations on copy
      reftable: cast away constness when assigning constants to records
      refspec: remove global tag refspec structure
      builtin/remote: cast away constness in `get_head_names()`
      diff: cast string constant in `fill_textconv()`
      line-log: stop assigning string constant to file parent buffer
      line-log: always allocate the output prefix
      entry: refactor how we remove items for delayed checkouts
      ident: add casts for fallback name and GECOS
      object-file: mark cached object buffers as const
      object-file: make `buf` parameter of `index_mem()` a constant
      pretty: add casts for decoration option pointers
      compat/win32: fix const-correctness with string constants
      http: do not assign string constant to non-const field
      parse-options: cast long name for OPTION_ALIAS
      send-pack: always allocate receive status
      remote-curl: avoid assigning string constant to non-const variable
      revision: always store allocated strings in output encoding
      mailmap: always store allocated strings in mailmap blob
      imap-send: drop global `imap_server_conf` variable
      imap-send: fix leaking memory in `imap_server_conf`
      builtin/rebase: do not assign default backend to non-constant field
      builtin/rebase: always store allocated string in `options.strategy`
      builtin/merge: always store allocated strings in `pull_twohead`
      config.mak.dev: enable `-Wwrite-strings` warning
      revision: fix memory leak when reversing revisions
      parse-options: fix leaks for users of OPT_FILENAME
      notes-utils: free note trees when releasing copied notes
      bundle: plug leaks in `create_bundle()`
      biultin/rev-parse: fix memory leaks in `--parseopt` mode
      merge-recursive: fix leaking rename conflict info
      revision: fix leaking display notes
      notes: fix memory leak when pruning notes
      builtin/rev-list: fix leaking bitmap index when calculating disk us=
age
      object-name: free leaking object contexts
      builtin/difftool: plug memory leaks in `run_dir_diff()`
      builtin/merge-recursive: fix leaking object ID bases
      merge-recursive: fix memory leak when finalizing merge
      builtin/log: fix leaking commit list in git-cherry(1)
      revision: free diff options
      builtin/stash: fix leak in `show_stash()`
      rerere: fix various trivial leaks
      config: fix leaking "core.notesref" variable
      commit: fix leaking parents when calling `commit_tree_extended()`
      sequencer: fix leaking string buffer in `commit_staged_changes()`
      apply: fix leaking string in `match_fragment()`
      builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
      sequencer: fix memory leaks in `make_script_with_merges()`
      builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
      merge: fix leaking merge bases
      line-range: plug leaking find functions
      blame: fix leaking data for blame scoreboards
      builtin/blame: fix leaking prefixed paths
      builtin/blame: fix leaking ignore revs files
      Makefile: add ability to append to CFLAGS and LDFLAGS
      config: fix segfault when parsing "core.abbrev" without repo
      parse-options-cb: stop clamping "--abbrev=3D" to hash length
      object-name: don't try to abbreviate to lengths greater than hexsz
      docs: introduce document to announce breaking changes
      BreakingChanges: document upcoming change from "sha1" to "sha256"
      BreakingChanges: document removal of grafting
      BreakingChanges: document that we do not plan to deprecate git-chec=
kout
      hash: drop (mostly) unused `is_empty_{blob,tree}_sha1()` functions
      hash: require hash algorithm in `hasheq()`, `hashcmp()` and `hashcl=
r()`
      hash: require hash algorithm in `oidread()` and `oidclr()`
      global: ensure that object IDs are always padded
      hash: convert `oidcmp()` and `oideq()` to compare whole hash
      hash: make `is_null_oid()` independent of `the_repository`
      hash: require hash algorithm in `is_empty_{blob,tree}_oid()`
      hash: require hash algorithm in `empty_tree_oid_hex()`
      global: introduce `USE_THE_REPOSITORY_VARIABLE` macro
      refs: avoid include cycle with "repository.h"
      hash-ll: merge with "hash.h"
      http-fetch: don't crash when parsing packfile without a repo
      oidset: pass hash algorithm when parsing file
      protocol-caps: use hash algorithm from passed-in repository
      replace-object: use hash algorithm from passed-in repository
      compat/fsmonitor: fix socket path in networked SHA256 repos
      t/helper: use correct object hash in partial-clone helper
      t/helper: fix segfault in "oid-array" command without repository
      t/helper: remove dependency on `the_repository` in "proc-receive"
      hex: guard declarations with `USE_THE_REPOSITORY_VARIABLE`
      refs: fix format migration on Cygwin

Peter Krefting (2):
      git-gui: sv.po: Update Swedish translation (576t0f0u)
      l10n: sv.po: Update Swedish translation

Phillip Wood (7):
      sequencer: always free "struct replay_opts"
      sequencer: start removing private fields from public API
      sequencer: move current fixups to private context
      sequencer: store commit message in private context
      rebase -m: fix --signoff with conflicts
      rebase -i: pass struct replay_opts to parse_insn_line()
      rebase -i: improve error message when picking merge

Piotr Szlazak (1):
      doc: update http.cookieFile with in-memory cookie processing

Ralf Thielow (1):
      l10n: Update German translation

Randall S. Becker (3):
      version: --build-options reports OpenSSL version information
      version: teach --build-options to reports libcurl version informati=
on
      version: teach --build-options to reports zlib version information

Ren=C3=A9 Scharfe (11):
      diff-lib: stop calling diff_setup_done() in do_diff_cache()
      diff: report unmerged paths as changes in run_diff_cmd()
      diff: fix --exit-code with external diff
      difftool: add env vars directly in run_file_diff()
      t4020: test exit code with external diffs
      userdiff: add and use struct external_diff
      diff: let external diffs report that changes are uninteresting
      commit: remove find_header_mem()
      diff: allow --color-moved with --no-ext-diff
      submodule--helper: use strvec_pushf() for --super-prefix
      clang-format: include kh_foreach* macros in ForEachMacros

Rikita Ishikawa (1):
      doc: fix the max number of branches shown by "show-branch"

Roland Hieber (3):
      completion: add 'symbolic-ref'
      completion: improve docs for using __git_complete
      completion: add docs on how to add subcommand completions

Rub=C3=A9n Justo (9):
      add-patch: do not show UI messages on stderr
      add-patch: response to unknown command
      t4014: cleanups in a few tests
      format-patch: assume --cover-letter for diff in multi-patch series
      pager: die when paging to non-existing command
      t0613: mark as leak-free
      test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
      t0612: mark as leak-free
      test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default

Shane Sun (1):
      doc: fix case error of eol attribute in example

Taylor Blau (64):
      attr.c: move ATTR_MAX_FILE_SIZE check into read_attr_from_buf()
      Makefile(s): avoid recipe prefix in conditional statements
      object.h: add flags allocated by pack-bitmap.h
      pack-bitmap-write.c: move commit_positions into commit_pos fields
      pack-bitmap: avoid use of static `bitmap_writer`
      pack-bitmap: drop unused `max_bitmaps` parameter
      pack-bitmap-write.c: avoid uninitialized 'write_as' field
      pack-bitmap: introduce `bitmap_writer_free()`
      Documentation/gitpacking.txt: initial commit
      Documentation/gitpacking.txt: describe pseudo-merge bitmaps
      Documentation/technical: describe pseudo-merge bitmaps format
      ewah: implement `ewah_bitmap_is_subset()`
      pack-bitmap: move some initialization to `bitmap_writer_init()`
      pseudo-merge.ch: initial commit
      pack-bitmap-write: support storing pseudo-merge commits
      pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
      pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
      config: introduce `git_config_double()`
      pseudo-merge: implement support for selecting pseudo-merge commits
      pack-bitmap-write.c: write pseudo-merge table
      pack-bitmap: extract `read_bitmap()` function
      pseudo-merge: scaffolding for reads
      pack-bitmap.c: read pseudo-merge extension
      pseudo-merge: implement support for reading pseudo-merge commits
      ewah: implement `ewah_bitmap_popcount()`
      pack-bitmap: implement test helpers for pseudo-merge
      t/test-lib-functions.sh: support `--notick` in `test_commit_bulk()`
      pack-bitmap.c: use pseudo-merges during traversal
      pack-bitmap: extra trace2 information
      ewah: `bitmap_equals_ewah()`
      pseudo-merge: implement support for finding existing merges
      t/perf: implement performance tests for pseudo-merge bitmaps
      midx-write.c: tolerate `--preferred-pack` without bitmaps
      midx-write.c: reduce argument count for `get_sorted_entries()`
      midx-write.c: pass `start_pack` to `compute_sorted_entries()`
      midx-write.c: extract `should_include_pack()`
      midx-write.c: extract `fill_packs_from_midx()`
      midx-write.c: support reading an existing MIDX with `packs_to_inclu=
de`
      midx: replace `get_midx_rev_filename()` with a generic helper
      pack-bitmap.c: reimplement `midx_bitmap_filename()` with helper
      commit-graph.c: remove temporary graph layers on exit
      server-info.c: remove temporary info files on exit
      midx-write.c: do not read existing MIDX with `packs_to_include`
      pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
      pack-revindex.c: guard against out-of-bounds pack lookups
      Documentation/technical/bitmap-format.txt: add missing position tab=
le
      pack-bitmap.c: ensure pseudo-merge offset reads are bounded
      t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
      revision.c: consult Bloom filters for root commits
      commit-graph: ensure Bloom filters are read with consistent setting=
s
      t/helper/test-read-graph.c: extract `dump_graph_info()`
      bloom.h: make `load_bloom_filter_from_graph()` public
      t/helper/test-read-graph: implement `bloom-filters` mode
      t4216: test changed path filters with high bit paths
      repo-settings: introduce commitgraph.changedPathsVersion
      bloom: annotate filters with hash version
      bloom: prepare to discard incompatible Bloom filters
      commit-graph: unconditionally load Bloom filters
      commit-graph: new Bloom filter version that fixes murmur3
      object.h: fix mis-aligned flag bits table
      commit-graph: reuse existing Bloom filters where possible
      bloom: introduce `deinit_bloom_filters()`
      config.mak.dev: fix typo when enabling -Wpedantic
      Documentation: fix default value for core.maxTreeDepth

Teng Long (1):
      l10n: zh_CN: updated translation for 2.46

Tom Hughes (2):
      push: don't fetch commit object when checking existence
      promisor-remote: add promisor.quiet configuration option

Torsten B=C3=B6gershausen (1):
      macOS: ls-files path fails if path of workdir is NFD

Victoria Dye (1):
      Documentation/git-merge-tree.txt: document -X

V=C5=A9 Ti=E1=BA=BFn H=C6=B0ng (1):
      l10n: vi: Updated translation for 2.46

Xing Xin (4):
      midx: disable replace objects
      bundle-uri: verify oid before writing refs
      fetch-pack: expose fsckObjects configuration logic
      unbundle: extend object verification for fetches

Yi-Jyun Pan (1):
      l10n: zh_TW: Git 2.46

brian m. carlson (24):
      credential: add an authtype field
      remote-curl: reset headers on new request
      http: use new headers for each object request
      credential: add a field for pre-encoded credentials
      credential: gate new fields on capability
      credential: add a field called "ephemeral"
      docs: indicate new credential protocol fields
      http: add support for authtype and credential
      credential: add an argument to keep state
      credential: enable state capability
      docs: set a limit on credential line length
      t5563: refactor for multi-stage authentication
      credential: add support for multistage credential rounds
      t: add credential tests for authtype
      credential-cache: implement authtype capability
      credential: add method for querying capabilities
      t4046: avoid continue in &&-chain for zsh
      vimdiff: make script and tests work with zsh
      git-gui: po: fix typo in French "aper=C3=A7u"
      gitfaq: add documentation on proxies
      gitfaq: give advice on using eol attribute in gitattributes
      gitfaq: add entry about syncing working trees
      doc: mention that proxies must be completely transparent
      http: allow authenticating proactively

=C3=98ystein Walle (1):
      Documentation: Mention that refspecs are explained elsewhere


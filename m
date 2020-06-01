Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96523C433E1
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5994D207BB
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 16:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DdcExdNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgFAQe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:34:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51300 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAQe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 12:34:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51DFADE0A3;
        Mon,  1 Jun 2020 12:34:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=fyWueVdNkYEiz7y2AAL1TZxvu
        co=; b=DdcExdNzT2O4MOiTsO/B+J0weDmZRyNRMPVoKVyN2lJ1eOeTlKxznqHh1
        3BWr/9ORD4pD7JU+SZmUjCkZc6Vj8DS2AwKDhhPbZPbeNwdeug/JBrLsKc2l5hEu
        HivHiBLuumMd7x0KOhusPvUETz/ubHncKB717lZTffHzsVtN/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=fhXPzT+1tWSvXQmq/JV
        giAZR5dkeQnQ3szjypIC5+TafG9NNNB3SJ8g7ZszeQuxozkWdNaF2A7/fCMHUDY3
        p5wcoTHKr+PS6Ja89NWvHqDsLEztro9At04up03MpAUFaSjdC7qKitTRPzecVT+V
        mAp+Bjn+8BzOka46lHqEj1lk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 488CCDE0A2;
        Mon,  1 Jun 2020 12:34:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43641DE09F;
        Mon,  1 Jun 2020 12:34:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.27.0
Date:   Mon, 01 Jun 2020 09:34:13 -0700
Message-ID: <xmqqzh9mu4my.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BB65697E-A425-11EA-BB02-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.27.0 is now available at the
usual places.  It is comprised of 537 non-merge commits since
v2.26.0, contributed by 71 people, 19 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.27.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.26.0 are as follows.
Welcome to the Git development community!

  Andras Kucsma, Ansgar R=C3=B6ber, Ash Holland, Christopher
  Warrington, Emma Brooks, Jan Engelhardt, Jessica Clarke,
  Jorge Lopez Silva, Julien Moutinho, Li Xuejiang,
  luciano.rocha@booking.com, Matthias A=C3=9Fhauer, Michael
  F. Sch=C3=B6nitzer, Nathan Sanders, Son Luong Ngoc, Terry Moschou,
  Toon Claes, Vasil Dimov, and Yang Zhao.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =EB=A7=88=EB=88=84=EC=97=98, Abhishek Kumar, Alban Gruin, Alessandro Me=
nti,
  Alexander Shopov, Alexandr Miloslavskiy, Alex Henrie, Andrei
  Rybak, Andrew Oakley, Ben Keene, brian m. carlson, Carlo
  Marcelo Arenas Bel=C3=B3n, Christian Couder, Christopher Diaz
  Riveros, Damien Robert, Denton Liu, Derrick Stolee, =C4=90o=C3=A0n
  Tr=E1=BA=A7n C=C3=B4ng Danh, Elijah Newren, Emily Shaffer, Emir Sar=C4=B1=
,
  Eric Sunshine, Garima Singh, Greg Price, Hans Jerry Illikainen,
  Heba Waly, Ismael Luceno, Jean-No=C3=ABl Avila, Jeff King, Jiang
  Xin, Johannes Schindelin, Jonathan Nieder, Jonathan Tan, Jordi
  Mas, Josh Steadmon, Junio C Hamano, Martin =C3=85gren, Matheus
  Tavares, Matthias R=C3=BCster, Patrick Steinhardt, Peter Krefting,
  Philippe Blain, Phillip Wood, Pratyush Yadav, Ren=C3=A9 Scharfe,
  Shourya Shukla, SZEDER G=C3=A1bor, Taylor Blau, Thomas Gummerer,
  Todd Zullinger, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, and Yi-Jyun Pan.

----------------------------------------------------------------

Git 2.27 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v2.26
-------------------

Backward compatibility notes

 * When "git describe C" finds that commit C is pointed by a signed or
   annotated tag, which records T as its tagname in the object, the
   command gives T as its answer.  Even if the user renames or moves
   such a tag from its natural location in the "refs/tags/" hierarchy,
   "git describe C" would still give T as the answer, but in such a
   case "git show T^0" would no longer work as expected.  There may be
   nothing at "refs/tags/T" or even worse there may be a different tag
   instead.

   Starting from this version, "git describe" will always use the
   "long" version, as if the "--long" option were given, when giving
   its output based on such a misplaced tag to work around the problem.

 * "git pull" issues a warning message until the pull.rebase
   configuration variable is explicitly given, which some existing
   users may find annoying---those who prefer not to rebase need to
   set the variable to false to squelch the warning.

 * The transport protocol version 2, which was promoted to the default
   in Git 2.26 release, turned out to have some remaining rough edges,
   so it has been demoted from the default.


UI, Workflows & Features

 * A handful of options to configure SSL when talking to proxies have
   been added.

 * Smudge/clean conversion filters are now given more information
   (e.g. the object of the tree-ish in which the blob being converted
   appears, in addition to its path, which has already been given).

 * When "git describe C" finds an annotated tag with tagname A to be
   the best name to explain commit C, and the tag is stored in a
   "wrong" place in the refs/tags hierarchy, e.g. refs/tags/B, the
   command gave a warning message but used A (not B) to describe C.
   If C is exactly at the tag, the describe output would be "A", but
   "git rev-parse A^0" would not be equal as "git rev-parse C^0".  The
   behavior of the command has been changed to use the "long" form
   i.e. A-0-gOBJECTNAME, which is correctly interpreted by rev-parse.

 * "git pull" learned to warn when no pull.rebase configuration
   exists, and neither --[no-]rebase nor --ff-only is given (which
   would result a merge).

 * "git p4" learned four new hooks and also "--no-verify" option to
   bypass them (and the existing "p4-pre-submit" hook).

 * "git pull" shares many options with underlying "git fetch", but
   some of them were not documented and some of those that would make
   sense to pass down were not passed down.

 * "git rebase" learned the "--no-gpg-sign" option to countermand
   commit.gpgSign the user may have.

 * The output from "git format-patch" uses RFC 2047 encoding for
   non-ASCII letters on From: and Subject: headers, so that it can
   directly be fed to e-mail programs.  A new option has been added
   to produce these headers in raw.

 * "git log" learned "--show-pulls" that helps pathspec limited
   history views; a merge commit that takes the whole change from a
   side branch, which is normally omitted from the output, is shown
   in addition to the commits that introduce real changes.

 * The interactive input from various codepaths are consolidated and
   any prompt possibly issued earlier are fflush()ed before we read.

 * Allow "git rebase" to reapply all local commits, even if the may be
   already in the upstream, without checking first.

 * The 'pack.useSparse' configuration variable now defaults to 'true',
   enabling an optimization that has been experimental since Git 2.21.

 * "git rebase" happens to call some hooks meant for "checkout" and
   "commit" by this was not a designed behaviour than historical
   accident.  This has been documented.

 * "git merge" learns the "--autostash" option.

 * "sparse-checkout" UI improvements.

 * "git update-ref --stdin" learned a handful of new verbs to let the
   user control ref update transactions more explicitly, which helps
   as an ingredient to implement two-phase commit-style atomic
   ref-updates across multiple repositories.

 * "git commit-graph write" learned different ways to write out split
   files.

 * Introduce an extension to the commit-graph to make it efficient to
   check for the paths that were modified at each commit using Bloom
   filters.

 * The approxidate parser learns to parse seconds with fraction and
   ignore fractional part.

 * The userdiff patterns for Markdown documents have been added.

 * The sparse-checkout patterns have been forbidden from excluding all
   paths, leaving an empty working tree, for a long time.  This
   limitation has been lifted.

 * "git restore --staged --worktree" now defaults to take the contents
   out of "HEAD", instead of erring out.

 * "git p4" learned to recover from a (broken) state where a directory
   and a file are recorded at the same path in the Perforce repository
   the same way as their clients do.

 * "git multi-pack-index repack" has been taught to honor some
   repack.* configuration variables.


Performance, Internal Implementation, Development Support etc.

 * The advise API has been revamped to allow more systematic enumeration =
of
   advice knobs in the future.

 * SHA-256 transition continues.

 * The code to interface with GnuPG has been refactored.

 * "git stash" has kept an escape hatch to use the scripted version
   for a few releases, which got stale.  It has been removed.

 * Enable tests that require GnuPG on Windows.

 * Minor test usability improvement.

 * Trace2 enhancement to allow logging of the environment variables.

 * Test clean-up continues.

 * Perf-test update.

 * A Windows-specific test element has been made more robust against
   misuse from both user's environment and programmer's errors.

 * Various tests have been updated to work around issues found with
   shell utilities that come with busybox etc.

 * The config API made mixed uses of int and size_t types to represent
   length of various pieces of text it parsed, which has been updated
   to use the correct type (i.e. size_t) throughout.

 * The "--decorate-refs" and "--decorate-refs-exclude" options "git
   log" takes have learned a companion configuration variable
   log.excludeDecoration that sits at the lowest priority in the
   family.

 * A new CI job to build and run test suite on linux with musl libc
   has been added.

 * Update the CI configuration to use GitHub Actions, retiring the one
   based on Azure Pipelines.

 * The directory traversal code had redundant recursive calls which
   made its performance characteristics exponential with respect to
   the depth of the tree, which was corrected.

 * "git blame" learns to take advantage of the "changed-paths" Bloom
   filter stored in the commit-graph file.

 * The "bugreport" tool has been added.

 * The object walk with object filter "--filter=3Dtree:0" can now take
   advantage of the pack bitmap when available.

 * Instead of always building all branches at GitHub via Actions,
   users can specify which branches to build.

 * Codepaths that show progress meter have been taught to also use the
   start_progress() and the stop_progress() calls as a "region" to be
   traced.

 * Instead of downloading Windows SDK for CI jobs for windows builds
   from an external site (wingit.blob.core.windows.net), use the one
   created in the windows-build job, to work around quota issues at
   the external site.


Fixes since v2.26
-----------------

 * The real_path() convenience function can easily be misused; with a
   bit of code refactoring in the callers' side, its use has been
   eliminated.
   (merge 49d3c4b481 am/real-path-fix later to maint).

 * Update "git p4" to work with Python 3.
   (merge 6bb40ed20a yz/p4-py3 later to maint).

 * The mechanism to prevent "git commit" from making an empty commit
   or amending during an interrupted cherry-pick was broken during the
   rewrite of "git rebase" in C, which has been corrected.
   (merge 430b75f720 pw/advise-rebase-skip later to maint).

 * Fix "git checkout --recurse-submodules" of a nested submodule
   hierarchy.
   (merge 846f34d351 pb/recurse-submodules-fix later to maint).

 * The "--fork-point" mode of "git rebase" regressed when the command
   was rewritten in C back in 2.20 era, which has been corrected.
   (merge f08132f889 at/rebase-fork-point-regression-fix later to maint).

 * The import-tars importer (in contrib/fast-import/) used to create
   phony files at the top-level of the repository when the archive
   contains global PAX headers, which made its own logic to detect and
   omit the common leading directory ineffective, which has been
   corrected.
   (merge c839fcff65 js/import-tars-do-not-make-phony-files-from-pax-head=
ers later to maint).

 * Simplify the commit ancestry connectedness check in a partial clone
   repository in which "promised" objects are assumed to be obtainable
   lazily on-demand from promisor remote repositories.
   (merge 2b98478c6f jt/connectivity-check-optim-in-partial-clone later t=
o maint).

 * The server-end of the v2 protocol to serve "git clone" and "git
   fetch" was not prepared to see a delim packets at unexpected
   places, which led to a crash.
   (merge cacae4329f jk/harden-protocol-v2-delim-handling later to maint)=
.

 * When fed a midx that records no objects, some codepaths tried to
   loop from 0 through (num_objects-1), which, due to integer
   arithmetic wrapping around, made it nonsense operation with out of
   bounds array accesses.  The code has been corrected to reject such
   an midx file.
   (merge 796d61cdc0 dr/midx-avoid-int-underflow later to maint).

 * Utitiles run via the run_command() API were not spawned correctly
   on Cygwin, when the paths to them are given as a full path with
   backslashes.
   (merge 05ac8582bc ak/run-command-on-cygwin-fix later to maint).

 * "git pull --rebase" tried to run a rebase even after noticing that
   the pull results in a fast-forward and no rebase is needed nor
   sensible, for the past few years due to a mistake nobody noticed.
   (merge fbae70ddc6 en/pull-do-not-rebase-after-fast-forwarding later to=
 maint).

 * "git rebase" with the merge backend did not work well when the
   rebase.abbreviateCommands configuration was set.
   (merge de9f1d3ef4 ag/rebase-merge-allow-ff-under-abbrev-command later =
to maint).

 * The logic to auto-follow tags by "git clone --single-branch" was
   not careful to avoid lazy-fetching unnecessary tags, which has been
   corrected.
   (merge 167a575e2d jk/use-quick-lookup-in-clone-for-tag-following later=
 to maint).

 * "git rebase -i" did not leave the reflog entries correctly.
   (merge 1f6965f994 en/sequencer-reflog-action later to maint).

 * The more aggressive updates to remote-tracking branches we had for
   the past 7 years or so were not reflected in the documentation,
   which has been corrected.
   (merge a44088435c pb/pull-fetch-doc later to maint).

 * We've left the command line parsing of "git log :/a/b/" broken for
   about a full year without anybody noticing, which has been
   corrected.
   (merge 0220461071 jc/missing-ref-store-fix later to maint).

 * Misc fixes for Windows.
   (merge 3efc128cd5 js/mingw-fixes later to maint).

 * "git rebase" (again) learns to honor "--no-keep-empty", which lets
   the user to discard commits that are empty from the beginning (as
   opposed to the ones that become empty because of rebasing).  The
   interactive rebase also marks commits that are empty in the todo.
   (merge 50ed76148a en/rebase-no-keep-empty later to maint).

 * Parsing the host part out of URL for the credential helper has been co=
rrected.
   (merge 4c5971e18a jk/credential-parsing-end-of-host-in-URL later to ma=
int).

 * Document the recommended way to abort a failing test early (e.g. by
   exiting a loop), which is to say "return 1".
   (merge 7cc112dc95 jc/doc-test-leaving-early later to maint).

 * The code that refreshes the last access and modified time of
   on-disk packfiles and loose object files have been updated.
   (merge 312cd76130 lr/freshen-file-fix later to maint).

 * Validation of push certificate has been made more robust against
   timing attacks.
   (merge 719483e547 bc/constant-memequal later to maint).

 * The custom hash function used by "git fast-import" has been
   replaced with the one from hashmap.c, which gave us a nice
   performance boost.
   (merge d8410a816b jk/fast-import-use-hashmap later to maint).

 * The "git submodule" command did not initialize a few variables it
   internally uses and was affected by variable settings leaked from
   the environment.
   (merge 65d100c4dd lx/submodule-clear-variables later to maint).

 * Raise the minimum required version of docbook-xsl package to 1.74,
   as 1.74.0 was from late 2008, which is more than 10 years old, and
   drop compatibility cruft from our documentation suite.
   (merge 3c255ad660 ma/doc-discard-docbook-xsl-1.73 later to maint).

 * "git log" learns "--[no-]mailmap" as a synonym to "--[no-]use-mailmap"
   (merge 88acccda38 jc/log-no-mailmap later to maint).

 * "git commit-graph write --expire-time=3D<timestamp>" did not use the
   given timestamp correctly, which has been corrected.
   (merge b09b785c78 ds/commit-graph-expiry-fix later to maint).

 * Tests update to use "test-chmtime" instead of "touch -t".
   (merge e892a56845 ds/t5319-touch-fix later to maint).

 * "git diff" in a partial clone learned to avoid lazy loading blob
   objects in more casese when they are not needed.
   (merge 95acf11a3d jt/avoid-prefetch-when-able-in-diff later to maint).

 * "git push --atomic" used to show failures for refs that weren't
   even pushed, which has been corrected.
   (merge dfe1b7f19c jx/atomic-push later to maint).

 * Code in builtin/*, i.e. those can only be called from within
   built-in subcommands, that implements bulk of a couple of
   subcommands have been moved to libgit.a so that they could be used
   by others.
   (merge 9460fd48b5 dl/libify-a-few later to maint).

 * Allowing the user to split a patch hunk while "git stash -p" does
   not work well; a band-aid has been added to make this (partially)
   work better.

 * "git diff-tree --pretty --notes" used to hit an assertion failure,
   as it forgot to initialize the notes subsystem.
   (merge 5778b22b3d tb/diff-tree-with-notes later to maint).

 * "git range-diff" fixes.
   (merge 8d1675eb7f vd/range-diff-with-custom-pretty-format-fix later to=
 maint).

 * "git grep" did not quote a path with unusual character like other
   commands (like "git diff", "git status") do, but did quote when run
   from a subdirectory, both of which has been corrected.
   (merge 45115d8490 mt/grep-cquote-path later to maint).

 * GNU/Hurd is also among the ones that need the fopen() wrapper.
   (merge 274a1328fb jc/gnu-hurd-lets-fread-read-dirs later to maint).

 * Those fetching over protocol v2 from linux-next and other kernel
   repositories are reporting that v2 often fetches way too much than
   needed.
   (merge 11c7f2a30b jn/demote-proto2-from-default later to maint).

 * The upload-pack protocol v2 gave up too early before finding a
   common ancestor, resulting in a wasteful fetch from a fork of a
   project.  This has been corrected to match the behaviour of v0
   protocol.
   (merge 2f0a093dd6 jt/v2-fetch-nego-fix later to maint).

 * The build procedure did not use the libcurl library and its include
   files correctly for a custom-built installation.
   (merge 0573831950 jk/build-with-right-curl later to maint).

 * Tighten "git mailinfo" to notice and error out when decoded result
   contains NUL in it.
   (merge 3919997447 dd/mailinfo-with-nul later to maint).

 * Fix in-core inconsistency after fetching into a shallow repository
   that broke the code to write out commit-graph.
   (merge 37b9dcabfc tb/reset-shallow later to maint).

 * The commit-graph code exhausted file descriptors easily when it
   does not have to.
   (merge c8828530b7 tb/commit-graph-fd-exhaustion-fix later to maint).

 * The multi-pack-index left mmapped file descriptors open when it
   does not have to.
   (merge 6c7ff7cf7f ds/multi-pack-index later to maint).

 * Recent update to Homebrew used by macOS folks breaks build by
   moving gettext library and necessary headers.
   (merge a0b3108618 ds/build-homebrew-gettext-fix later to maint).

 * Incompatible options "--root" and "--fork-point" of "git rebase"
   have been marked and documented as being incompatible.
   (merge a35413c378 en/rebase-root-and-fork-point-are-incompatible later=
 to maint).

 * Error and verbose trace messages from "git push" did not redact
   credential material embedded in URLs.
   (merge d192fa5006 js/anonymise-push-url-in-errors later to maint).

 * Update the parser used for credential.<URL>.<variable>
   configuration, to handle <URL>s with '/' in them correctly.
   (merge b44d0118ac bc/wildcard-credential later to maint).

 * Recent updates broke parsing of "credential.<url>.<key>" where
   <url> is not a full URL (e.g. [credential "https://"] helper =3D ...)
   stopped working, which has been corrected.
   (merge 9a121b0d22 js/partial-urlmatch-2.17 later to maint).
   (merge cd93e6c029 js/partial-urlmatch later to maint).

 * Some of the files commit-graph subsystem keeps on disk did not
   correctly honor the core.sharedRepository settings and some were
   left read-write.

 * In error messages that "git switch" mentions its option to create a
   new branch, "-b/-B" options were shown, where "-c/-C" options
   should be, which has been corrected.
   (merge 7c16ef7577 dl/switch-c-option-in-error-message later to maint).

 * With the recent tightening of the code that is used to parse
   various parts of a URL for use in the credential subsystem, a
   hand-edited credential-store file causes the credential helper to
   die, which is a bit too harsh to the users.  Demote the error
   behaviour to just ignore and keep using well-formed lines instead.
   (merge c03859a665 cb/credential-store-ignore-bogus-lines later to main=
t).

 * The samples in the credential documentation has been updated to
   make it clear that we depict what would appear in the .git/config
   file, by adding appropriate quotes as needed..
   (merge 177681a07e jk/credential-sample-update later to maint).

 * "git branch" and other "for-each-ref" variants accepted multiple
   --sort=3D<key> options in the increasing order of precedence, but it
   had a few breakages around "--ignore-case" handling, and tie-breaking
   with the refname, which have been fixed.
   (merge 7c5045fc18 jk/for-each-ref-multi-key-sort-fix later to maint).

 * The coding guideline for shell scripts instructed to refer to a
   variable with dollar-sign inside arithmetic expansion to work
   around a bug in old versions of dash, which is a thing of the past.
   Now we are not forbidden from writing $((var+1)).
   (merge 32b5fe7f0e jk/arith-expansion-coding-guidelines later to maint)=
.

 * The <stdlib.h> header on NetBSD brings in its own definition of
   hmac() function (eek), which conflicts with our own and unrelated
   function with the same name.  Our function has been renamed to work
   around the issue.
   (merge 3013118eb8 cb/avoid-colliding-with-netbsd-hmac later to maint).

 * The basic test did not honor $TEST_SHELL_PATH setting, which has
   been corrected.
   (merge 0555e4af58 cb/t0000-use-the-configured-shell later to maint).

 * Minor in-code comments and documentation updates around credential
   API.
   (merge 1aed817f99 cb/credential-doc-fixes later to maint).

 * Teach "am", "commit", "merge" and "rebase", when they are run with
   the "--quiet" option, to pass "--quiet" down to "gc --auto".
   (merge 7c3e9e8cfb jc/auto-gc-quiet later to maint).

 * The code to skip unmerged paths in the index when sparse checkout
   is in use would have made out-of-bound access of the in-core index
   when the last path was unmerged, which has been corrected.

 * Serving a "git fetch" client over "git://" and "ssh://" protocols
   using the on-wire protocol version 2 was buggy on the server end
   when the client needs to make a follow-up request to
   e.g. auto-follow tags.
   (merge 08450ef791 cc/upload-pack-v2-fetch-fix later to maint).

 * "git bisect replay" had trouble with input files when they used
   CRLF line ending, which has been corrected.
   (merge 6c722cbe5a cw/bisect-replay-with-dos later to maint).

 * "rebase -i" segfaulted when rearranging a sequence that has a
   fix-up that applies another fix-up (which may or may not be a
   fix-up of yet another step).
   (merge 02471e7e20 js/rebase-autosquash-double-fixup-fix later to maint=
).

 * "git fsck" ensures that the paths recorded in tree objects are
   sorted and without duplicates, but it failed to notice a case where
   a blob is followed by entries that sort before a tree with the same
   name.  This has been corrected.
   (merge 9068cfb20f rs/fsck-duplicate-names-in-trees later to maint).

 * Code clean-up by removing a compatibility implementation of a
   function we no longer use.
   (merge 84b0115f0d cb/no-more-gmtime later to maint).

 * When a binary file gets modified and renamed on both sides of history
   to different locations, both files would be written to the working
   tree but both would have the contents from "ours".  This has been
   corrected so that the path from each side gets their original content.

 * Fix for a copy-and-paste error introduced during 2.20 era.
   (merge e68a5272b1 ds/multi-pack-verify later to maint).

 * Update an unconditional use of "grep -a" with a perl script in a test.
   (merge 1eb7371236 dd/t5703-grep-a-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 564956f358 jc/maintain-doc later to maint).
   (merge 7422b2a0a1 sg/commit-slab-clarify-peek later to maint).
   (merge 9c688735f6 rs/doc-passthru-fetch-options later to maint).
   (merge 757c2ba3e2 en/oidset-uninclude-hashmap later to maint).
   (merge 8312aa7d74 jc/config-tar later to maint).
   (merge d00a5bdd50 ss/submodule-foreach-cb later to maint).
   (merge 64d1022e14 ar/test-style-fixes later to maint).
   (merge 4a465443a6 ds/doc-clone-filter later to maint).
   (merge bb2dbe301b jk/t3419-drop-expensive-tests later to maint).
   (merge d3507cc712 js/test-junit-finalization-fix later to maint).
   (merge 2149b6748f bc/faq later to maint).
   (merge 12dc0879f1 jk/test-cleanup later to maint).
   (merge 344420bf0f pb/rebase-doc-typofix later to maint).
   (merge 7cd54d37dc dl/wrapper-fix-indentation later to maint).
   (merge 78725ebda9 jc/allow-strlen-substitution-in-shell-scripts later =
to maint).
   (merge 2ecfcdecc6 jm/gitweb-fastcgi-utf8 later to maint).
   (merge 0740d0a5d3 jk/oid-array-cleanups later to maint).
   (merge a1aba0c95c js/t0007-typofix later to maint).
   (merge 76ba7fa225 ma/config-doc-fix later to maint).
   (merge 826f0c0df2 js/subtree-doc-update-to-asciidoctor-2 later to main=
t).
   (merge 88eaf361e0 eb/mboxrd-doc later to maint).
   (merge 051cc54941 tm/zsh-complete-switch-restore later to maint).
   (merge 39102cf4fe ms/doc-revision-illustration-fix later to maint).
   (merge 4d9378bfad eb/gitweb-more-trailers later to maint).
   (merge bdccbf7047 mt/doc-worktree-ref later to maint).
   (merge ce9baf234f dl/push-recurse-submodules-fix later to maint).
   (merge 4153274052 bc/doc-credential-helper-value later to maint).
   (merge 5c7bb0146e jc/codingstyle-compare-with-null later to maint).

----------------------------------------------------------------

Changes since v2.26.0 are as follows:

Abhishek Kumar (1):
      commit-slab-decl.h: update include guard

Alban Gruin (3):
      sequencer: mark messages for translation
      sequencer: don't abbreviate a command if it doesn't have a short fo=
rm
      t3432: test `--merge' with `rebase.abbreviateCommands =3D true', to=
o

Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.27.0 round 1
      l10n: it.po: update for Git 2.27.0 round #2

Alex Henrie (1):
      pull: warn if the user didn't say whether to rebase or to merge

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (4868t)
      l10n: bg.po: Updated Bulgarian translation (4875t)

Alexandr Miloslavskiy (4):
      set_git_dir: fix crash when used with real_path()
      real_path: remove unsafe API
      real_path_if_valid(): remove unsafe API
      get_superproject_working_tree(): return strbuf

Andras Kucsma (1):
      run-command: trigger PATH lookup properly on Cygwin

Andrei Rybak (2):
      t9500: remove spaces after redirect operators
      t: fix whitespace around &&

Andrew Oakley (1):
      git-p4: recover from inconsistent perforce history

Ansgar R=C3=B6ber (1):
      Subject: git-gui: fix syntax error because of missing semicolon

Ash Holland (1):
      userdiff: support Markdown

Ben Keene (8):
      git-p4: change the expansion test from basestring to list
      git-p4: rewrite prompt to be Windows compatible
      git-p4: create new function run_git_hook
      git-p4: add p4-pre-submit exit text
      git-p4: add --no-verify option
      git-p4: restructure code in submit
      git-p4: add p4 submit hooks
      git-p4: add RCS keyword status message

Carlo Marcelo Arenas Bel=C3=B3n (13):
      credential-store: ignore bogus lines from store file
      credential: update description for credential_from_url_gently
      credential: correct order of parameters for credential_match
      builtin/receive-pack: avoid generic function name hmac()
      t/t0000-basic: make sure subtests also use TEST_SHELL_PATH
      t/test_lib: avoid naked bash arrays in file_lineno
      credential: update gitcredentials documentation
      credential: document protocol updates
      compat: remove gmtime
      t4216: avoid unnecessary subshell in test_bloom_filters_not_used
      t5520: avoid alternation in grep's BRE (not POSIX)
      bisect: avoid tailing CR characters from revision in replay
      t: avoid alternation (not POSIX) in grep's BRE

Christian Couder (1):
      upload-pack: clear filter_options for each v2 fetch command

Christopher Diaz Riveros (1):
      l10n: es: 2.27.0 round 1

Christopher Warrington (1):
      bisect: allow CRLF line endings in "git bisect replay" input

Damien Robert (6):
      midx.c: fix an integer underflow
      doc: list all commands affected by submodule.recurse
      doc: document --recurse-submodules for reset and restore
      doc: explain how to deactivate submodule.recurse completely
      doc: be more precise on (fetch|push).recurseSubmodules
      doc: --recurse-submodules mostly applies to active submodules

Denton Liu (45):
      Makefile: ASCII-sort +=3D lists
      t7600: use test_write_lines()
      Lib-ify fmt-merge-msg
      Lib-ify prune-packed
      t5512: don't use `test_must_fail test_cmp`
      t5512: stop losing git exit code in here-docs
      t5512: stop losing return codes of git commands
      t5550: simplify no matching line check
      t5607: reorder `nongit test_must_fail`
      t5612: don't use `test_must_fail test_cmp`
      t5612: stop losing return codes of git commands
      t5801: teach compare_refs() to accept !
      wrapper: indent with tabs
      sequencer: stop leaking buf
      sequencer: make file exists check more efficient
      sequencer: make read_oneliner() accept flags
      sequencer: configurably warn on non-existent files
      sequencer: make read_oneliner() extern
      rebase: use read_oneliner()
      sequencer: make apply_autostash() accept a path
      sequencer: rename stash_sha1 to stash_oid
      rebase: use apply_autostash() from sequencer.c
      rebase: generify reset_head()
      reset: extract reset_head() from rebase
      rebase: extract create_autostash()
      rebase: generify create_autostash()
      sequencer: extract perform_autostash() from rebase
      sequencer: unlink autostash in apply_autostash()
      sequencer: implement save_autostash()
      sequencer: implement apply_autostash_oid()
      merge: teach --autostash option
      t5520: make test_pull_autostash() accept expect_parent_num
      pull: pass --autostash to merge
      t6030: use test_path_is_missing()
      t7408: replace incorrect uses of test_must_fail
      t7508: don't use `test_must_fail test_cmp`
      t9141: use test_path_is_missing()
      t9160: use test_path_is_missing()
      t9164: use test_must_fail only on git commands
      t9819: don't use test_must_fail with p4
      Use OPT_CALLBACK and OPT_CALLBACK_F
      push: unset PARSE_OPT_OPTARG for --recurse-submodules
      rebase: save autostash entry into stash reflog on --quit
      switch: fix errors and comments related to -c and -C
      Doc: reference the "stash list" in autostash docs

Derrick Stolee (27):
      connected.c: reprepare packs for corner cases
      config: set pack.useSparse=3Dtrue by default
      pack-objects: flip the use of GIT_TEST_PACK_SPARSE
      clone: document --filter options
      diff: halt tree-diff early after max_changes
      dir: refactor treat_directory to clarify control flow
      commit-graph: fix buggy --expire-time option
      t5319: replace 'touch -m' with 'test-tool chmtime'
      bloom: ignore renames when computing changed paths
      revision: --show-pulls adds helpful merges
      log-tree: make ref_filter_match() a helper method
      log: add log.excludeDecoration config option
      revision: complicated pathspecs disable filters
      tests: write commit-graph with Bloom filters
      blame: use changed-path Bloom filters
      multi-pack-index: close file descriptor after mmap
      bloom: fix whitespace around tab length
      test-bloom: fix usage typo
      sparse-checkout: stop blocking empty workdirs
      unpack-trees: avoid array out-of-bounds error
      multi-pack-index: respect repack.packKeptObjects=3Dfalse
      bloom: parse commit before computing filters
      Documentation: changed-path Bloom filters use byte words
      bloom: de-duplicate directory entries
      bloom: use num_changes not nr for limit detection
      progress: call trace2_region_leave() only after calling _enter()
      fsck: use ERROR_MULTI_PACK_INDEX

Elijah Newren (39):
      oidset: remove unnecessary include
      unpack-trees: fix minor typo in comment
      unpack-trees: remove unused error type
      unpack-trees: simplify verify_absent_sparse()
      unpack-trees: simplify pattern_list freeing
      t1091: make some tests a little more defensive against failures
      unpack-trees: allow check_updates() to work on a different index
      unpack-trees: do not mark a dirty path with SKIP_WORKTREE
      unpack-trees: pull sparse-checkout pattern reading into a new funct=
ion
      unpack-trees: add a new update_sparsity() function
      sparse-checkout: use new update_sparsity() function
      sparse-checkout: use improved unpack_trees porcelain messages
      unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
      unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
      unpack-trees: split display_error_msgs() into two
      unpack-trees: make sparse path messages sound like warnings
      unpack-trees: provide warnings on sparse updates for unmerged paths=
 too
      unpack-trees: failure to set SKIP_WORKTREE bits always just a warni=
ng
      sparse-checkout: provide a new reapply subcommand
      pull: avoid running both merge and rebase
      t7063: more thorough status checking
      t3000: add more testcases testing a variety of ls-files issues
      dir: fix simple typo in comment
      dir: consolidate treat_path() and treat_one_path()
      dir: fix broken comment
      dir: fix confusion based on variable tense
      dir: replace exponential algorithm with a linear one
      dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_director=
y()
      dir: replace double pathspec matching with single in treat_director=
y()
      Fix error-prone fill_directory() API; make it only return matches
      completion: fix 'git add' on paths under an untracked directory
      git-rebase.txt: add another hook to the hooks section, and explain =
more
      sequencer: honor GIT_REFLOG_ACTION
      rebase -i: mark commits that begin empty in todo editor
      rebase: reinstate --no-keep-empty
      rebase: fix an incompatible-options error message
      rebase: display an error if --root and --fork-point are both provid=
ed
      merge-recursive: fix rename/rename(1to2) for working tree with a bi=
nary
      unpack-trees: also allow get_progress() to work on a different inde=
x

Emily Shaffer (8):
      help: move list_config_help to builtin/help
      bugreport: add tool to generate debugging info
      bugreport: gather git version and build info
      bugreport: add uname info
      bugreport: add compiler info
      bugreport: drop extraneous includes
      bugreport: collect list of populated hooks
      trace2: log progress time and throughput

Emir Sar=C4=B1 (2):
      l10n: tr: v2.27.0 round 1
      l10n: tr: v2.27.0 round 2

Emma Brooks (3):
      format-patch: teach --no-encode-email-headers
      Documentation: explain "mboxrd" pretty format
      gitweb: Recognize *-to and Closes/Fixes trailers

Eric Sunshine (1):
      restore: default to HEAD when combining --staged and --worktree

Garima Singh (13):
      commit-graph: define and use MAX_NUM_CHUNKS
      bloom.c: add the murmur3 hash implementation
      bloom.c: introduce core Bloom filter constructs
      bloom.c: core Bloom filter implementation for changed paths.
      commit-graph: compute Bloom filters for changed paths
      commit-graph: examine commits by generation number
      commit-graph: write Bloom filters to commit graph file
      commit-graph: reuse existing Bloom filters during write
      commit-graph: add --changed-paths option to write subcommand
      revision.c: use Bloom filters to speed up path based revision walks
      revision.c: add trace2 stats around Bloom filter usage
      t4216: add end to end tests for git log with Bloom filters
      commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag

Greg Price (1):
      tests: skip small-stack tests on hppa architecture

Hans Jerry Illikainen (2):
      t: increase test coverage of signature verification output
      gpg-interface: prefer check_signature() for GPG verification

Heba Waly (4):
      advice: extract vadvise() from advise()
      advice: change "setupStreamFailure" to "setUpstreamFailure"
      advice: revamp advise API
      tag: use new advice API to check visibility

Ismael Luceno (1):
      git-gui: Handle Ctrl + BS/Del in the commit msg

Jan Engelhardt (1):
      l10n: de.po: Fix typo in the German translation of octopus

Jean-No=C3=ABl Avila (2):
      l10n: fr v2.27.0 rnd 1
      l10n: fr.po v2.27.0 rnd 2

Jeff King (51):
      credential: avoid writing values with newlines
      t/lib-credential: use test_i18ncmp to check stderr
      credential: detect unrepresentable values when parsing urls
      fsck: detect gitmodules URLs with embedded newlines
      t3419: drop EXPENSIVE tests
      t/lib-credential.sh: drop shebang line
      t/lib-*.sh: drop executable bit
      test-lib-functions: make packetize() more efficient
      upload-pack: handle unexpected delim packets
      p5310: stop timing non-bitmap pack-to-disk
      Makefile: avoid running curl-config multiple times
      Makefile: use curl-config --cflags
      test-lib-functions: simplify packetize() stdin code
      commit-graph: examine changed-path objects in pack order
      oid_array: use size_t for count and allocation
      oid_array: use size_t for iteration
      oid_array: rename source file from sha1-array
      test-tool: rename sha1-array to oid-array
      bisect: stop referring to sha1_array
      ref-filter: stop referring to "sha1 array"
      oidset: stop referring to sha1-array
      clone: use "quick" lookup while following tags
      Makefile: avoid running curl-config unnecessarily
      fast-import: replace custom hash with hashmap.c
      repository: mark the "refs" pointer as private
      remote: drop auto-strlen behavior of make_branch() and make_rewrite=
()
      parse_config_key(): return subsection len as size_t
      config: drop useless length variable in write_pair()
      git_config_parse_key(): return baselen as size_t
      config: use size_t to store parsed variable baselen
      config: reject parsing of files over INT_MAX
      credential: treat "?" and "#" in URLs as end of host
      t0300: make "quit" helper more realistic
      t0300: use more realistic inputs
      credential: parse URL without host as empty host, not unset
      credential: refuse to operate when missing host or protocol
      credential: die() when parsing invalid urls
      Git 2.17.5
      blame: drop unused parameter from maybe_changed_path
      test-bloom: fix some whitespace issues
      test-bloom: check that we have expected arguments
      commit-graph: close descriptors after mmap
      t0000: disable GIT_TEST_FAIL_PREREQS in sub-tests
      gitcredentials(7): clarify quoting of helper examples
      gitcredentials(7): make shell-snippet example more realistic
      CodingGuidelines: drop arithmetic expansion advice to use "$x"
      ref-filter: apply --ignore-case to all sorting keys
      ref-filter: apply fallback refname sort only after all user sorts
      list-objects-filter: treat NULL filter_options as "disabled"
      pack-bitmap: pass object filter to fill-in traversal
      ci: allow per-branch config for GitHub Actions

Jessica Clarke (1):
      config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd

Jiang Xin (8):
      send-pack: fix inconsistent porcelain output
      t5543: never report what we do not push
      send-pack: mark failure of atomic push properly
      transport-helper: mark failure for atomic push
      transport-helper: new method reject_atomic_push()
      l10n: git.pot: v2.27.0 round 1 (72 new, 37 removed)
      l10n: git.pot: v2.27.0 round 2 (+1)
      l10n: zh_CN: for git v2.27.0 l10n round 1~2

Johannes Schindelin (37):
      cherry-pick: add test for `--skip` advice in `git commit`
      tests(junit-xml): avoid invalid XML
      import-tars: ignore the global PAX header
      tests(gpg): allow the gpg-agent to start on Windows
      t/lib-gpg.sh: stop pretending to be a stand-alone script
      tests: do not let lazy prereqs inside `test_expect_*` turn off trac=
ing
      tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
      tests: increase the verbosity of the GPG-related prereqs
      MyFirstObjectWalk: remove unnecessary conditional statement
      t0007: fix a typo
      ci/lib: if CI type is unknown, show the environment variables
      ci/lib: allow running in GitHub Actions
      ci: fix the `jobname` of the `GETTEXT_POISON` job
      subtree: fix build with AsciiDoctor 2
      mingw: do not treat `COM0` as a reserved file name
      t3904: fix incorrect demonstration of a bug
      stash -p: (partially) fix bug concerning split hunks
      mingw: help debugging by optionally executing bash with strace
      interactive: refactor code asking the user for interactive input
      ci: run gem with sudo to install asciidoctor
      README: add a build badge for the GitHub Actions runs
      ci: retire the Azure Pipelines definition
      tests: when run in Bash, annotate test failures with file name/line=
 number
      ci: add a problem matcher for GitHub Actions
      ci: let GitHub Actions upload failed tests' directories
      t: consolidate the `is_hidden` functions
      mingw: make test_path_is_hidden more robust
      t: restrict `is_hidden` to be called only on Windows
      credential: fix grammar
      credential: optionally allow partial URLs in credential_from_url_ge=
ntly()
      credential: optionally allow partial URLs in credential_from_url_ge=
ntly()
      credential: handle `credential.<partial-URL>.<key>` again
      macOS/brew: let the build find gettext headers/libraries/msgfmt
      push: anonymize URLs in error messages and warnings
      credential: handle `credential.<partial-URL>.<key>` again
      rebase --autosquash: fix a potential segfault
      ci: avoid pounding on the poor ci-artifacts container

Jonathan Nieder (5):
      fsck: convert gitmodules url to URL passed to curl
      credential: treat URL without scheme as invalid
      credential: treat URL with empty scheme as invalid
      fsck: reject URL with empty host in .gitmodules
      Revert "fetch: default to protocol version 2"

Jonathan Tan (12):
      connected: always use partial clone optimization
      promisor-remote: accept 0 as oid_nr in function
      diff: make diff_populate_filespec_options struct
      diff: refactor object read
      diff: restrict when prefetching occurs
      rebase --merge: optionally skip upstreamed commits
      fetch-pack: return enum from process_acks()
      fetch-pack: in protocol v2, in_vain only after ACK
      fetch-pack: in protocol v2, reset in_vain upon ACK
      commit-graph: avoid memory leaks
      t5500: count objects through stderr, not trace
      t4067: make rename detection test output raw diff

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Jorge Lopez Silva (2):
      http: add client cert support for HTTPS proxies
      http: add environment variable support for HTTPS proxies

Josh Steadmon (1):
      trace2: teach Git to log environment variables

Julien Moutinho (1):
      gitweb: fix UTF-8 encoding when using CGI::Fast

Junio C Hamano (34):
      rebase: --fork-point regression fix
      describe: force long format for a name based on a mislocated tag
      update how-to-maintain-git
      parse-options: teach "git cmd -h" to show alias as alias
      clone: reorder --recursive/--recurse-submodules
      log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap
      Git 2.17.4
      separate tar.* config to its own source file
      The first batch post 2.26 cycle
      The second batch post 2.26 cycle
      t/README: suggest how to leave test early with failure
      CodingGuidelines: allow ${#posix} =3D=3D strlen($posix)
      sha1-name: do not assume that the ref store is initialized
      receive-pack: compilation fix
      The third batch
      The fourth batch
      credential-store: document the file format a bit more
      Revert "commit-graph.c: introduce '--[no-]check-oids'"
      The fifth batch
      The sixth batch
      The seventh batch
      auto-gc: extract a reusable helper from "git fetch"
      auto-gc: pass --quiet down from am, commit, merge and rebase
      CodingGuidelines: do not =3D=3D/!=3D compare with 0 or '\0' or NULL
      The eighth batch
      The ninth batch
      Git 2.27-rc0
      Revert "t/test_lib: avoid naked bash arrays in file_lineno"
      Revert "ci: add a problem matcher for GitHub Actions"
      Revert "tests: when run in Bash, annotate test failures with file n=
ame/line number"
      Git 2.27-rc1
      Hopefully final batch before 2.27-rc2
      Git 2.27-rc2
      Git 2.27

Li Xuejiang (1):
      git-submodule.sh: setup uninitialized variables

Martin =C3=85gren (15):
      Doc: drop support for docbook-xsl before 1.71.1
      Doc: drop support for docbook-xsl before 1.72.0
      Doc: drop support for docbook-xsl before 1.73.0
      manpage-bold-literal.xsl: stop using git.docbook.backslash
      manpage-normal.xsl: fold in manpage-base.xsl
      INSTALL: drop support for docbook-xsl before 1.74
      user-manual.conf: don't specify [listingblock]
      config.txt: move closing "----" to cover entire listing
      merge: use skip_prefix to parse config key
      date-formats.txt: fix list continuation
      git-commit-graph.txt: fix grammo
      git-commit-graph.txt: fix list rendering
      git-credential.txt: use list continuation
      git-sparse-checkout.txt: add missing '
      rev-list-options.txt: start a list for `show-pulls`

Matheus Tavares (3):
      test-lib: allow short options to be bundled
      grep: follow conventions for printing paths w/ unusual chars
      config doc: fix reference to config.worktree info

Matthias A=C3=9Fhauer (1):
      mingw: use modern strftime implementation if possible

Matthias R=C3=BCster (1):
      l10n: de.po: Update German translation for Git 2.27.0

Michael F. Sch=C3=B6nitzer (1):
      docs: fix minor glitch in illustration

Nathan Sanders (1):
      mingw: cope with the Isilon network file system

Patrick Steinhardt (9):
      refs: fix segfault when aborting empty transaction
      git-update-ref.txt: add missing word
      strbuf: provide function to append whole lines
      update-ref: organize commands in an array
      update-ref: drop unused argument for `parse_refname`
      update-ref: pass end pointer instead of strbuf
      update-ref: move transaction handling into `update_refs_stdin()`
      update-ref: read commands in a line-wise fashion
      update-ref: implement interactive transaction handling

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4839t0f0u)
      l10n: sv.po: Update Swedish translation (4875t0f0u)

Philippe Blain (10):
      t7112: remove mention of KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED
      t/lib-submodule-update: remove outdated test description
      t/lib-submodule-update: move a test to the right section
      unpack-trees: remove outdated description for verify_clean_submodul=
e
      unpack-trees: check for missing submodule directory in merged_entry
      t/lib-submodule-update: add test removing nested submodules
      git-rebase.txt: fix typo
      pull doc: refer to a specific section in 'fetch' doc
      pull doc: correct outdated description of an example
      command-list.txt: add gitfaq to the list of guides

Phillip Wood (6):
      t3404: use test_cmp_rev
      cherry-pick: check commit error messages
      sequencer: write CHERRY_PICK_HEAD for reword and edit
      commit: use enum value for multiple cherry-picks
      commit: encapsulate determine_whence() for sequencer
      commit: give correct advice for empty commit during a rebase

Ren=C3=A9 Scharfe (4):
      pull: document more passthru options
      pull: remove --update-head-ok from documentation
      pull: pass documented fetch options on
      fsck: report non-consecutive duplicate names in trees

SZEDER G=C3=A1bor (4):
      ci: use python3 in linux-gcc and osx-gcc and python2 elsewhere
      commit-slab: clarify slabname##_peek()'s return value
      ci: make MAKEFLAGS available inside the Docker container in the Lin=
ux32 job
      completion: offer '--(no-)patch' among 'git log' options

Shourya Shukla (4):
      submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
      gitfaq: files in .gitignore are tracked
      gitfaq: fetching and pulling a repository
      submodule: port subcommand 'set-url' from shell to C

Son Luong Ngoc (1):
      midx: teach "git multi-pack-index repack" honor "git repack" config=
urations

Taylor Blau (24):
      t/helper/test-read-graph.c: support commit-graph chains
      builtin/commit-graph.c: support for '--split[=3D<strategy>]'
      builtin/commit-graph.c: introduce split strategy 'no-merge'
      builtin/commit-graph.c: introduce split strategy 'replace'
      oidset: introduce 'oidset_size'
      commit-graph.h: replace 'commit_hex' with 'commits'
      commit-graph.c: introduce '--[no-]check-oids'
      diff-tree.c: load notes machinery when required
      commit-graph.c: don't use discarded graph_name in error
      t/test-lib.sh: make ULIMIT_FILE_DESCRIPTORS available to tests
      commit-graph.c: gracefully handle file descriptor exhaustion
      t5537: use test_write_lines and indented heredocs for readability
      shallow.c: use '{commit,rollback}_shallow_file'
      tempfile.c: introduce 'create_tempfile_mode'
      lockfile.c: introduce 'hold_lock_file_for_update_mode'
      commit-graph.c: write non-split graphs as read-only
      commit-graph.c: ensure graph layers respect core.sharedRepository
      commit-graph.c: make 'commit-graph-chain's read-only
      commit: make 'commit_graft_pos' non-static
      shallow: extract a header file for shallow-related functions
      shallow.h: document '{commit,rollback}_shallow_file'
      shallow: use struct 'shallow_lock' for additional safety
      pack-bitmap.c: make object filtering functions generic
      pack-bitmap.c: support 'tree:0' filtering

Terry Moschou (1):
      complete: zsh: add missing sub cmd completion candidates

Thomas Gummerer (2):
      stash: get git_stash_config at the top level
      stash: remove the stash.useBuiltin setting

Todd Zullinger (2):
      git-bugreport.txt: adjust reference to strftime(3)
      gitfaq: avoid validation error with older asciidoc

Toon Claes (1):
      Documentation: correct hash environment variable

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi(4874t): Updated Vietnamses translation for 2.27.0
      l10n: vi(4875t): Updated Vietnamses translation for 2.27.0rd2

Vasil Dimov (2):
      range-diff: fix a crash in parsing git-log output
      range-diff: avoid negative string precision

Yang Zhao (12):
      git-p4: make python2.7 the oldest supported version
      git-p4: remove string type aliasing
      git-p4: encode/decode communication with p4 for python3
      git-p4: encode/decode communication with git for python3
      git-p4: convert path to unicode before processing them
      git-p4: open .gitp4-usercache.txt in text mode
      git-p4: use marshal format version 2 when sending to p4
      git-p4: fix freezing while waiting for fast-import progress
      git-p4: use functools.reduce instead of reduce
      git-p4: use dict.items() iteration for python3 compatibility
      git-p4: simplify regex pattern generation for parsing diff-tree
      git-p4: use python3's input() everywhere

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.27.0 round 1 (0 untranslated)
      l10n: zh_TW.po: v2.27.0 round 2 (0 untranslated)

brian m. carlson (34):
      builtin/pack-objects: make hash agnostic
      hash: implement and use a context cloning function
      hex: introduce parsing variants taking hash algorithms
      hex: add functions to parse hex object IDs in any algorithm
      repository: require a build flag to use SHA-256
      t: use hash-specific lookup tables to define test constants
      t6300: abstract away SHA-1-specific constants
      t6300: make hash algorithm independent
      t/helper/test-dump-split-index: initialize git repository
      t/helper: initialize repository if necessary
      t/helper: make repository tests hash independent
      setup: allow check_repository_format to read repository format
      builtin/init-db: allow specifying hash algorithm on command line
      builtin/init-db: add environment variable for new repo hash
      init-db: move writing repo version into a function
      worktree: allow repository version 1
      commit: use expected signature header for SHA-256
      fast-import: permit reading multiple marks files
      fast-import: add helper function for inserting mark object entries
      fast-import: make find_marks work on any mark set
      fast-import: add a generic function to iterate over marks
      fast-import: add options for rewriting submodules
      builtin/checkout: pass branch info down to checkout_worktree
      convert: permit passing additional metadata to filter processes
      convert: provide additional metadata to filters
      builtin/checkout: compute checkout metadata for checkouts
      builtin/clone: compute checkout metadata for clones
      builtin/rebase: compute checkout metadata for rebases
      builtin/reset: compute checkout metadata for reset
      t0021: test filter metadata for additional cases
      docs: add a FAQ
      builtin/receive-pack: use constant-time comparison for HMAC value
      credential: fix matching URLs with multiple levels in path
      docs: document credential.helper allowed values

luciano.rocha@booking.com (1):
      freshen_file(): use NULL `times' for implicit current-time

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (37):
      t4061: use POSIX compliant regex(7)
      test-lib-functions: test_cmp: eval $GIT_TEST_CMP
      t5003: drop the subshell in test_lazy_prereq
      t5003: skip conversion test if unzip -a is unavailable
      t5616: use rev-parse instead to get HEAD's object_id
      t7063: drop non-POSIX argument "-ls" from find(1)
      t4124: tweak test so that non-compliant diff(1) can also be used
      t5703: feed raw data into test-tool unpack-sideband
      rebase.c: honour --no-gpg-sign
      cherry-pick/revert: honour --no-gpg-sign in all case
      Documentation: document am --no-gpg-sign
      Documentation: reword commit --no-gpg-sign
      Documentation: merge commit-tree --[no-]gpg-sign
      Documentation: document merge option --no-gpg-sign
      ci/lib-docker: preserve required environment variables
      ci/linux32: parameterise command to switch arch
      ci: refactor docker runner script
      ci/linux32: libify install-dependencies step
      travis: build and test on Linux with musl libc and busybox
      ci/lib: set TERM environment variable if not exist
      ci: explicit install all required packages
      ci: configure GitHub Actions for CI/PR
      t4254: merge 2 steps of a single test
      mailinfo.c: avoid strlen on strings that can contains NUL
      mailinfo: disallow NUL character in mail's header
      date.c: s/is_date/set_date/
      date.c: validate and set time in a helper function
      date.c: skip fractional second part of ISO-8601
      date.c: allow compact version of ISO-8601 datetime
      test-parse-pathspec-file.c: s/0/NULL/ for pointer type
      compat/regex: move stdlib.h up in inclusion chain
      graph.c: limit linkage of internal variable
      progress.c: silence cgcc suggestion about internal linkage
      bloom: fix `make sparse` warning
      t1509: correct i18n test
      ci/config: correct instruction for CI preferences
      t5703: replace "grep -a" usage by perl

=EB=A7=88=EB=88=84=EC=97=98 (1):
      interactive: explicitly `fflush` stdout before expecting input



Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56402BF016;
	Mon, 16 Jun 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093764; cv=none; b=DCvWG0T6ISfGomKJx/KSB8M3gjGYqASX2g0spTUewIhRUErtV//twPd5GeknKJYH7D4PpBpsLSyozkWJ09HPD1fCiOcWbjRThCBsG+SNogiV/RVOCZimP+FA9/92M1D9e4SlNB+8qNRWrSdvJnBkrIZxolRV1qYwoJ4TQOexVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093764; c=relaxed/simple;
	bh=4QnHq/6fG8OaTXz1ufJjDGurw+AblYL3DQmCvC3tC08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KXrqReYSZXZAqNDiTJxxuGrV1CTNJxZ70du8C6Gw40pn3G/eX6e+T7g3AbJS0isQI0jz0AUry+/QJn0aMZeVhSgEs8GQ+LLa4c+hJeSuWZK3xJKDrD/VWonzRInKcmNrfsnqsa7UZE2YHQDThgkAt3OjwWsbSYxWjuwknJUpg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rUoPiy2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWazB00C; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rUoPiy2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWazB00C"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 78E751140120;
	Mon, 16 Jun 2025 13:09:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 16 Jun 2025 13:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1750093758; x=1750180158; bh=1F
	+yMnIq49eFlTuJgfUQoxO3F0UTZ30HS9QUDOovzQU=; b=rUoPiy2HN4+KHIcQj/
	2Ae2ahlL+zJDh6F5CpcIxqN54gJVzCn3NH3QZAV5zKrz8/ZUaLBg0RICetO+KFkI
	FSFBq18LioXLFAVFRX6l97XM+ZyHcG4hBxFircOkhfpeAPfjE2Y55LP7ARz8FW9x
	QNm+yV4UcLaZcy7soDEnPLs4uNl8cX8sXr/i1EfnIxAocuOLpKDTTa5KbOt/bmg+
	rriMD8oeXCdAHE6ohXdCRehj4oiHLcjdS7PLDmLNis1QpgKSIC0p62CPXAU3YZiJ
	wYsxK1fYetXtXNojN4sWW7BX59GAeOt31g5uHCZITA95gDGQsINC2xgyGDeqvnlV
	ft9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1750093758; x=1750180158; bh=1F+yMnIq49eFlTuJgfUQoxO3F0UT
	Z30HS9QUDOovzQU=; b=OWazB00C3Jm5K1ocoVGLVvpa4lU5uwQJrTix+V61BWXv
	WbJ/5wO8i8bWWMsMVMEsa4gTCiWnsYQBqpjsPSvTdTKBIOdklJh5+eXsb8+Y2Ds9
	teB4EZjyvxt965OrIIKRTPZxVL0ZD0FJETjIx7HpPCztSzV/PZFEIRGOLn0DuCXi
	59bVs/5KraHcuEC12D2jwoI46s+sUJ8GcC4W/pZeFJoL1WOnuZUPUiBfQ6mHDSpY
	ceqHJgcHnqWd37v5Z0JVsooOtInKieb43/nIUe5UfAkeRSYT00Uf59TqS9KtdTrV
	kYqKnxz/Rx714qxH3WSb7ghsPasw41CXcazj58mVkA==
X-ME-Sender: <xms:vU9QaCddu68Kh55AJ1utorQqIy4bduHhXwEIuio4-VdDBwQVHt-MYQ>
    <xme:vU9QaMPPYSKXPddvMgBz2Pt1egQuf4uXhqs6pY_TrUCkUQdK-rbIRjoRynfpzqT76
    0Q8EkCajZtwp_la0g>
X-ME-Received: <xmr:vU9QaDgAcx3RnCZR0Lx9m0xb8zxwvS5XTxAcV_3LsT3aHbc24m4ibqW7SvUWi2nFzfdHJqO6FxkP2Si7zEe-bAWbgwSfmQo3VJNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdeggedtvefhieevvdehgeffffefffegleeu
    gffhfeetgffhjedvffegffefgeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hoohhglhgvshhouhhrtggvrdgtohhmpdhorhdrtgiipdhgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtg
    hpthhtoheplhifnheslhifnhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:vk9QaP_TrOTG6eWCsUun0sxVOQliaxx2Sgv3X1eQ1oxN_F5-dKRR_g>
    <xmx:vk9QaOshZXEC-nfvUAdCB6ov_SebWicTr8zU3TckCqla9P6Km-_S3g>
    <xmx:vk9QaGEvE7RhTGaBRO9GMeAimGXNPN70CFPgyFM4B9M_rFSKr_dfpw>
    <xmx:vk9QaNPjxSZ4e8bnAbTgnNUYOCXC43-SoP4rufVusGTGyb5U31QadA>
    <xmx:vk9QaN1gV6MNDN6ECUDdb4PvN-hTuemIf7O0_YgP7hMzASgfaVn4ajqs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 13:09:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.50.0
Date: Mon, 16 Jun 2025 10:09:16 -0700
Message-ID: <xmqq1prj1umb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The latest feature release Git v2.50.0 is now available at the
usual places.  It is comprised of 621 non-merge commits since
v2.49.0, contributed by 98 people, 35 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.50.0'
tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.49.0 are as follows.
Welcome to the Git development community!

  Abhijeetsingh Meena, Aditya Garg, Aindriú Mac Giolla Eoin,
  Alexander Ogorodov, Alex Mironov, Anthony Wang, Arnav Bhate,
  Brad Smith, Bruno De Fraine, Christian Fredrik Johnsen, Christian
  Reich, Collin Funk, Dmitry Goncharov, Jason Cho, Jensen Huang,
  Jitka Plesnikova, kawarimidoll, K Jayatheerth, Lidong Yan,
  Mahendra Dani, Mark Mentovai, Matt Hunter, Moumita Dhar, Nathan
  Royce, Niels Glodny, Ondřej Pohořelský, Peter Seiderer,
  piotrsiupa, R. Diez, Rodrigo Carvalho, Sebastian Andrzej
  Siewior, SURA, Wonuk Kim, Zheng Yuting, and தமிழ்
  நேரம்.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Abhijeet Sonar, Adam Johnson, Ahelenia Ziemiańska, Alexander
  Shopov, Arkadii Yakovets, Bagas Sanjaya, brian m. carlson, Carlo
  Marcelo Arenas Belón, Christian Couder, David Mandelberg, D. Ben
  Knoble, Dennis Ameling, Derrick Stolee, Đoàn Trần Công
  Danh, Elijah Newren, Eli Schwartz, Emir SARI, Eric Sunshine,
  Fernando Ramos, Han Jiang, Jacob Keller, Jean-Noël Avila, Jeff
  King, Jiang Xin, Johannes Schindelin, Johannes Sixt, John Paul
  Adrian Glaubitz, Josh Heinrichs, Junio C Hamano, Justin Tobler,
  Karthik Nayak, Kate Golovanova, Koji Nakamaru, Kristoffer
  Haugsbakk, Lucas Seiki Oshiro, Luke Shumaker, Mark Levedahl,
  Meet Soni, Olaf Hering, Oswald Buddenhagen, Patrick Steinhardt,
  Philippe Blain, Phillip Wood, Ralf Thielow, Ramsay Jones, Randall
  S. Becker, René Scharfe, Sam James, Scott Chacon, Seyi Kuforiji,
  shejialuo, SZEDER Gábor, Tamara Lazerka, Taylor Blau, Teng Long,
  Todd Zullinger, Toon Claes, Torsten Bögershausen, Tuomas Ahola,
  Usman Akinyemi, Yi-Jyun Pan, YOKOTA Hiroshi, and 依云.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.50 Release Notes
=======================

UI, Workflows & Features
------------------------

 * A post-processing filter for "diff --raw" output has been
   introduced.

 * "git repack" learned "--combine-cruft-below-size" option that
   controls how cruft-packs are combined.

 * TCP keepalive behaviour on http transports can now be configured by
   calling cURL library.

 * Incrementally updating multi-pack index files.

 * "git reflog" learns "drop" subcommand, that discards the entire
   reflog data for a ref.

 * A new userdiff driver for ".ini" format configuration files has
   been added.

 * The job to coalesce loose objects into packfiles in "git
   maintenance" now has configurable batch size.

 * "git clone" still gave the message about the default branch name;
   this message has been turned into an advice message that can be
   turned off.

 * "git rev-list" learns machine-parsable output format that delimits
   each field with NUL.

 * "git maintenance" learns a new task to expire reflog entries.

 * Auth-related (and unrelated) error handling in send-email has been
   made more robust.

 * Updating multiple references have only been possible in an all-or-nothing
   fashion with transactions, but it can be more efficient to batch
   multiple updates even when some of them are allowed to fail in a
   best-effort manner.  A new "best effort batches of updates" mode
   has been introduced.

 * "git help --build-options" reports SHA-1 and SHA-256 backends used
   in the build.

 * "git cat-file --batch" and friends learned to allow "--filter=" to
   omit certain objects, just like the transport layer does.

 * "git blame --porcelain" mode now talks about unblamable lines and
   lines that are blamed to an ignored commit.

 * The build procedure installs bash (but not zsh) completion script.

 * send-email has been updated to work better with Outlook's SMTP server.

 * "git diff --minimal" used to give non-minimal output when its
   optimization kicked in, which has been disabled.

 * "git index-pack --fix-thin" used to abort to prevent a cycle in
   delta chains from forming in a corner case even when there is no
   such cycle.

 * Make repository clean-up tasks that "gc" can do available to "git
   maintenance" front-end.

 * Bundle-URI feature did not use refs recorded in the bundle other
   than normal branches as anchoring points to optimize the follow-up
   fetch during "git clone"; now it is told to utilize all.

 * The `send-email` documentation has been updated with OAuth2.0
   related examples.

 * Two of the "scalar" subcommands that add a repository that hasn't
   been under "scalar"'s control are taught an option not to enable the
   scheduled maintenance on it.

 * The userdiff pattern for shell scripts has been updated to cope
   with more bash-isms.

 * "git merge-tree" learned an option to see if it resolves cleanly
   without actually creating a result.

 * The commit title in the "rebase -i" todo file are now prefixed with
   '#', just like a merge commit being replayed.

 * "git receive-pack" optionally learns not to care about connectivity
   check, which can be useful when the repository arranges to ensure
   connectivity by some other means.

 * "git notes --help" documentation updates.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * A handful of built-in command implementations have been rewritten
   to use the repository instance supplied by git.c:run_builtin(), its
   caller.

 * "git fsck" becomes more careful when checking the refs.

 * "git fast-export | git fast-import" learns to deal with commit and
   tag objects with embedded signatures a bit better.  This is highly
   experimental and the format of the data stream may change in the
   future without compatibility guarantees.

 * The code paths to check whether a refname X is available (by seeing
   if another ref X/Y exists, etc.) have been optimized.

 * First step of deprecating and removing merge-recursive.

 * In protocol v2 where the refs advertisement is constrained, we try
   to tell the server side not to limit the advertisement when there
   is no specific need to, which has been the source of confusion and
   recent bugs.  Revamp the logic to simplify.

 * Update meson based build procedure for breaking changes support.

 * Enable -Wunreachable-code for developer builds.

 * Ensure what we write in assert() does not have side effects,
   and introduce ASSERT() macro to mark those that cannot be
   mechanically checked for lack of side effects.

 * Give more meaningful error return values from block writer layer of
   the reftable ref-API backend.

 * Make the code in reftable library less reliant on the service
   routines it used to borrow from Git proper, to make it easier to
   use by external users of the library.

 * CI update.

 * The object layer has been updated to take an explicit repository
   instance as a parameter in more code paths.

 * Some warnings from "-Wsign-compare" for builtin/rm.c have been
   squelched.

 * A few traditional unit tests have been rewritten to use the clar
   framework.

 * Some warnings from "-Wsign-compare" for pathspec.c have been
   squelched.

 * "make test" used to have a hard dependency on (basic) Perl; tests
   have been rewritten help environment with NO_PERL test the build as
   much as possible.

 * Remove remnants of the recursive merge strategy backend, which was
   superseded by the ort merge strategy.

 * Optimize the code to dedup references recorded in a bundle file.

 * Update parse-options API to catch mistakes to pass address of an
   integral variable of a wrong type/size.

 * Since a call to repo_config() can be called with repo set to NULL
   these days, a command that is marked as RUN_SETUP in the builtin
   command table does not have to check repo with NULL before making
   the call.

 * Overhaul of the reftable API.

 * Reduce requirement for Perl in our documentation build and a few
   scripts.

 * The build procedure based on Meson learned to drive the
   benchmarking tests.

 * Code clean-up for meson-based build infrastructure.

 * Add an equivalent to "make hdr-check" target to meson based builds.

 * Further code clean-up in the object-store layer.

 * Build performance fix.

 * Teach "git send-email" to also consult `hostname -f` for mail
   domain to compute the identity given to SMTP servers.

 * The dependency on the_repository variable has been reduced from the
   code paths in "git replay".

 * Support to create a loose object file with unknown object type has
   been dropped.

 * The code path to access the "packed-refs" file while "fsck" is
   taught to mmap the file, instead of reading the whole file into
   memory.

 * Assorted fixes for issues found with CodeQL.

 * Remove the leftover hints to the test framework to mark tests that
   do not pass the leak checker tests, as they should no longer be
   needed.

 * When a stale .midx file refers to .pack files that no longer exist,
   we ended up checking for these non-existent files repeatedly, which
   has been optimized by memoizing the non-existence.

 * Build settings have been improved for BSD based systems.

 * Newer version of libcURL detected curl_easy_setopt() calls we made
   with platform-natural "int" when we should have used "long", which
   all have been corrected.

 * Tests that compare $HOME and $(pwd), which should be the same
   directory unless the tests chdir's around, would fail when the user
   enters the test directory via symbolic links, which has been
   corrected.


Fixes since v2.49
-----------------

 * The refname exclusion logic in the packed-ref backend has been
   broken for some time, which confused upload-pack to advertise
   different set of refs.  This has been corrected.
   (merge 10e8a9352b tb/refs-exclude-fixes later to maint).

 * The merge-recursive and merge-ort machinery crashed in corner cases
   when certain renames are involved.
   (merge 3adba40858 en/merge-process-renames-crash-fix later to maint).

 * Certain "cruft" objects would have never been refreshed when there
   are multiple cruft packs in the repository, which has been
   corrected.
   (merge 08f612ba70 tb/multi-cruft-pack-refresh-fix later to maint).

 * The xdiff code on 32-bit platform misbehaved when an insanely large
   context size is given, which has been corrected.
   (merge d39e28e68c rs/xdiff-context-length-fix later to maint).

 * GitHub Actions CI switched on a CI/CD variable that does not exist
   when choosing what packages to install etc., which has been
   corrected.
   (merge ee89f7c79d kn/ci-meson-check-build-docs-fix later to maint).

 * Using "git name-rev --stdin" as an example, improve the framework to
   prepare tests to pretend to be in the future where the breaking
   changes have already happened.
   (merge de3dec1187 jc/name-rev-stdin later to maint).

 * An earlier code refactoring of the hash machinery missed a few
   required calls to init_fn.
   (merge d39f04b638 jh/hash-init-fixes later to maint).

 * A documentation page was left out from formatting and installation,
   which has been corrected.
   (merge ae85116f18 pw/build-breaking-changes-doc later to maint).

 * The bash command line completion script (in contrib/) has been
   updated to cope with remote repository nicknames with slashes in
   them.
   (merge 778d2f1760 dm/completion-remote-names-fix later to maint).

 * "Dubious ownership" checks on Windows has been tightened up.
   (merge 5bb88e89ef js/mingw-admins-are-special later to maint).

 * Layout configuration in vimdiff backend didn't work as advertised,
   which has been corrected.
   (merge 93bab2d04b fr/vimdiff-layout-fixes later to maint).

 * Fix our use of zlib corner cases.
   (merge 1cb2f293f5 jk/zlib-inflate-fixes later to maint).

 * Fix lockfile contention in reftable code on Windows.
   (merge 0a3dceabf1 ps/mingw-creat-excl-fix later to maint).

 * "git-merge-file" documentation source, which has lines that look
   like conflict markers, lacked custom conflict marker size defined,
   which has been corrected..
   (merge d3b5832381 pw/custom-conflict-marker-size-for-merge-related-docs later to maint).

 * Squelch false-positive from sparse.
   (merge da87b58014 dd/sparse-glibc-workaround later to maint).

 * Adjust to the deprecation of use of Ubuntu 20.04 GitHub Actions CI.
   (merge 832d9f6d0b js/ci-github-update-ubuntu later to maint).

 * Work around CI breakage due to fedora base image getting updated.
   (merge 8a471a663b js/ci-fedora-gawk later to maint).

 * A ref transaction corner case fix.
   (merge b9fadeead7 jt/ref-transaction-abort-fix later to maint).

 * Random build fixes.
   (merge 85e1d6819f ps/misc-build-fixes later to maint).

 * "git fetch [<remote>]" with only the configured fetch refspec
   should be the only thing to update refs/remotes/<remote>/HEAD,
   but the code was overly eager to do so in other cases.

 * Incorrect sorting of refs with bytes with high-bit set on platforms
   with signed char led to a BUG, which has been corrected.

 * "make perf" fixes.
   (merge 1665f12fa0 pb/perf-test-fixes later to maint).

 * Doc mark-up updates.
   (merge 5a5565ec44 ja/doc-reset-mv-rm-markup-updates later to maint).

 * Work around false positive from CodeQL checker.
   (merge 0f558141ed js/range-check-codeql-workaround later to maint).

 * "git log --{left,right}-only A...B", when A and B does not share
   any common ancestor, now behaves as expected.
   (merge e7ef4be7c2 mh/left-right-limited later to maint).

 * Document the convention to disable hooks altogether by setting the
   hooksPath configuration variable to /dev/null.
   (merge 1b2eee94f1 ds/doc-disable-hooks later to maint).

 * Make sure outage of third-party sites that supply P4, Git-LFS, and
   JGit we use for testing would not prevent our CI jobs from running
   at all.

 * Various build tweaks, including CSPRNG selection on some platforms.
   (merge cdda67de03 rj/build-tweaks later to maint).

 * Developer support fix..
   (merge 32b74b9809 js/git-perf-env-override later to maint).

 * Fix for scheduled maintenance tasks on platforms using launchctl.
   (merge eb2d7beb0e jh/gc-launchctl-schedule-fix later to maint).

 * Update to arm64 Windows port (part of which had been reverted as it
   broke builds for existing platforms, which may need to be redone in
   future releases).

 * hashmap API clean-up to ensure hashmap_clear() leaves a cleared map
   in a reusable state.
   (merge 9481877de3 en/hashmap-clear-fix later to maint).

 * "git mv a a/b dst" would ask to move the directory 'a' itself, as
   well as its contents, in a single destination directory, which is
   a contradicting request that is impossible to satisfy. This case is
   now detected and the command errors out.
   (merge 974f0d4664 ps/mv-contradiction-fix later to maint).

 * Further refinement on CI messages when an optional external
   software is unavailable (e.g. due to third-party service outage).
   (merge 956acbefbd jc/ci-skip-unavailable-external-software later to maint).

 * Test result aggregation did not work in Meson based CI jobs.
   (merge bd38ed5be1 ps/ci-test-aggreg-fix-for-meson later to maint).

 * Code clean-up around stale CI elements and building with Visual Studio.
   (merge a7b060f67f js/ci-buildsystems-cleanup later to maint).

 * "git add 'f?o'" did not add 'foo' if 'f?o', an unusual pathname,
   also existed on the working tree, which has been corrected.
   (merge ec727e189c kj/glob-path-with-special-char later to maint).

 * The fallback implementation of open_nofollow() depended on
   open("symlink", O_NOFOLLOW) to set errno to ELOOP, but a few BSD
   derived systems use different errno, which has been worked around.
   (merge f47bcc3413 cf/wrapper-bsd-eloop later to maint).

 * Use-after-free fix in the sequencer.
   (merge 5dbaec628d pw/sequencer-reflog-use-after-free later to maint).

 * win+Meson CI pipeline, unlike other pipelines for Windows,
   used to build artifacts in developer mode, which has been changed to
   build them in release mode for consistency.
   (merge 184abdcf05 js/ci-build-win-in-release-mode later to maint).

 * CI settings at GitLab has been updated to run MSVC based Meson job
   automatically (as opposed to be done only upon manual request).
   (merge 6389579b2f ps/ci-gitlab-enable-msvc-meson-job later to maint).

 * "git apply" and "git add -i/-p" code paths no longer unnecessarily
   expand sparse-index while working.
   (merge ecf9ba20e3 ds/sparse-apply-add-p later to maint).

 * Avoid adding directory path to a sparse-index tree entries to the
   name-hash, since they would bloat the hashtable without anybody
   querying for them.  This was done already for a single threaded
   part of the code, but now the multi-threaded code also does the
   same.
   (merge 2e60aabc75 am/sparse-index-name-hash-fix later to maint).

 * Recent versions of Perl started warning against "! A =~ /pattern/"
   which does not negate the result of the matching.  As it turns out
   that the problematic function is not even called, it was removed.
   (merge 67cae845d2 op/cvsserver-perl-warning later to maint).

 * "git apply --index/--cached" when applying a deletion patch in
   reverse failed to give the mode bits of the path "removed" by the
   patch to the file it creates, which has been corrected.

 * "git verify-refs" errored out in a repository in which
   linked worktrees were prepared with Git 2.43 or lower.
   (merge d5b3c38b8a sj/ref-contents-check-fix later to maint).

 * Update total_ram() function on BSD variants.

 * Update online_cpus() function on BSD variants.

 * Revert a botched bswap.h change that broke ntohll() functions on
   big-endian systems with __builtin_bswap32/64().

 * Fixes for GitHub Actions Coverity job.
   (merge 3cc4fc1ebd js/github-ci-win-coverity-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 227c4f33a0 ja/doc-block-delimiter-markup-fix later to maint).
   (merge 2bfd3b3685 ab/decorate-code-cleanup later to maint).
   (merge 5337daddc7 am/dir-dedup-decl-of-repository later to maint).
   (merge 554051d691 en/diff-rename-follow-fix later to maint).
   (merge a18c18b470 en/random-cleanups later to maint).
   (merge 5af21c9acb hj/doc-rev-list-ancestry-fix later to maint).
   (merge 26d76ca284 aj/doc-restore-p-update later to maint).
   (merge 2c0dcb9754 cc/lop-remote later to maint).
   (merge 7b399322a2 ja/doc-branch-markup later to maint).
   (merge ee434e1807 pw/doc-pack-refs-markup-fix later to maint).
   (merge c000918eb7 tb/bitamp-typofix later to maint).
   (merge fa8cd29676 js/imap-send-peer-cert-verify later to maint).
   (merge 98b423bc1c rs/clear-commit-marks-simplify later to maint).
   (merge 133d065dd6 ta/bulk-checkin-signed-compare-false-warning-fix later to maint).
   (merge d2827dc31e es/meson-build-skip-coccinelle later to maint).
   (merge ee8edb7156 dk/vimdiff-doc-fix later to maint).
   (merge 107d889303 md/t1403-path-is-file later to maint).
   (merge abd4192b07 js/comma-semicolon-confusion later to maint).
   (merge 27b7264206 ab/environment-clean-header later to maint).
   (merge ff4a749354 as/typofix-in-env-h-header later to maint).
   (merge 86eef3541e az/tighten-string-array-constness later to maint).
   (merge 25292c301d lo/remove-log-reencode-from-rev-info later to maint).
   (merge 1aa50636fd jk/p5332-testfix later to maint).
   (merge 42cf4ac552 ps/ci-resurrect-p4-on-github later to maint).
   (merge 104add8368 js/diff-codeql-false-positive-workaround later to maint).
   (merge f62977b93c en/get-tree-entry-doc later to maint).
   (merge e5dd0a05ed ly/am-split-stgit-leakfix later to maint).
   (merge bac220e154 rc/t1001-test-path-is-file later to maint).
   (merge 91db6c735d ly/reftable-writer-leakfix later to maint).
   (merge 20e4e9ad0b jc/doc-synopsis-option-markup later to maint).
   (merge cddcee7f64 es/meson-configure-build-options-fix later to maint).
   (merge cea9f55f00 wk/sparse-checkout-doc-fix later to maint).

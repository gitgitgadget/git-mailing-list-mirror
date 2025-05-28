Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FF28BA8E;
	Wed, 28 May 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451250; cv=none; b=o/jHPFymNTnHxtGnND5dSSwzG49FU6w2MUjPj2mPDohcScCpbts/oQMkpjtgZxKVtZ+earhQ8t5lj+ucX5amz1sjzNl6VaI5BDEpB5ZS9laM/rbAXMKeoL6xubI/n2eUL/P6uZDbGEcmsG6vRbGuFeVY6QgT+V4jReudqHYpzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451250; c=relaxed/simple;
	bh=zzUjyhaDN+0LnV+L/slbTC0DYCzLFG0TIT+hCx+3CoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1/RjXIqXbd5FIEfyorW1NXLGZTUrkr3wF9SZZIqF2+m5HEfyIGQgXI6mVkyyjDfpg66qhb6ZkK3dyYOmSHwfCd/PePFkwyQB66tvoJ65wdC/QQ4offW3Y6AvvrdB2wzj/H2ekAZRGYRblkqEb94Eiqj3VsoUyO6TmLHHhzEsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hjFBfHRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfxfHlHp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hjFBfHRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfxfHlHp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C1B525400E1;
	Wed, 28 May 2025 12:54:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 28 May 2025 12:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1748451245; x=1748537645; bh=i9
	nC8B5ikV5R0DYgPGeAcVxTe96MbGzKQh8UuIpo4nk=; b=hjFBfHRfB3urvJvZ5u
	HBFYqsncpPzzoWYi7HQT6JVSlbc9Pu2foeWS+si7402ArzKyrKBnu5Y4rW/2eivD
	oKrFUXT/enxY9gCLg+gGrltAsw7cxKVY130x4PNss5os7t07Qe+tGDuPDSLR6GwS
	7e2Gbu+6hDHTK9Sx4YO872AipnDy3r8stS+0+z01jQ/y5Iit0DwIjzql/mE3b5y4
	OzmxjNJRidk7Ei4D8HIKEjxAQz0jQYXTAKSQ7XKILgpC6DLAB71vTT9gusdKU/ix
	2cgfrDZdU+PFOpxYuxkBjsTSU6kB+T/ApiHcpSI2V94hzyqtIcSnPSzlZl8Gt7yF
	fXeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748451245; x=1748537645; bh=i9nC8B5ikV5R0DYgPGeAcVxTe96M
	bGzKQh8UuIpo4nk=; b=AfxfHlHptc4EE8qA0OQ5eCHYKiMiGxiQoVrCEonPqsKG
	SjYcFpRZtIjoGSnc5o9775zTAQTE5vrM1gtngpbQstubxZg6IDsEK90QnhwGB3sd
	SNk0HkwmVvi0Cndt2z4DkMVupbZbsQJHDDAz9V6syzaOYoeQhNki93zvuliFgqjL
	O/8nlASdu59/XxmzG2NjZTucDQHSW8pOS2N5UQQS3ddS//jQCEC37w/3cDZc64bW
	N0My+RcKhOXJtGYMPMkd0Tp3kd0z8u95YX52NbKR6C7aQhcnWxsp65LicfvmZ6rU
	ejexJpBjXFDqnlN1VA90xiCpUREEwqkzn7ZF9Pbc5w==
X-ME-Sender: <xms:rD83aKGZOSa6oJAdeZMWsaGicBFKRzqpf0XjTCitkwiuK3OCiMbnpQ>
    <xme:rD83aLUr74xt2MxYK7xaBX5j8eftKwnj_rPML6CwUxVj9a8uiokQUN0EGeoDUdB1g
    aqzRKFPYR2IVgLVEg>
X-ME-Received: <xmr:rD83aEKSVhvhI9Dwd6P51UXOBnRxFMrR8py0q7W3V5LhU7Ny3_JLmzKNKs7ryi9c85E9bEbdGvjyEi_klH4CkHazCXd23IJXiykLXBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeejleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgf
    gggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepheeltdetheeg
    heefieefkeeuudelheeujedukefhfedtvdeggefgleduteehgedvnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghdpghhoohhglhgvshhouhhrtggvrdgtohhmpdhorhdrtgiipdhg
    ihhthhhusgdrtghomhdpmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghrsh
    esghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtoheplhifnheslhifnhdrnhgv
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rD83aEH-_sDdu7u6op5VnOwBZY12mptNZh0Tvf9fG3RkPUS82wjvpw>
    <xmx:rD83aAVsMEOHJpUEIzl_fiBsRDfM5sWGEHM8rwsMzd0czPO75aX9Lw>
    <xmx:rD83aHMYLYhkozmR97UHOupPxJc1E42paD8zYtzUpygAn5F9YwX_bw>
    <xmx:rD83aH1MzDX9B5E_VkO1Pa9tLJkn6AHW4wDGSWdo0HDQ4gy6Ion5KQ>
    <xmx:rT83aO-r5aZku4su_0547QiSbuvmb3P_OXykGj9b8kryzIYpAnCkjnMo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 12:54:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.50.0-rc0
Date: Wed, 28 May 2025 09:54:02 -0700
Message-ID: <xmqqzfewsml1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

An early preview release Git v2.50.0-rc0 is now available for
testing at the usual places.  It is comprised of 541 non-merge
commits since v2.49.0, contributed by 73 people, 25 of which are
new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.50.0-rc0' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.49.0 are as follows.
Welcome to the Git development community!

  Abhijeetsingh Meena, Aditya Garg, Anthony Wang, Arnav Bhate,
  Bruno De Fraine, Christian Fredrik Johnsen, Christian Reich,
  Collin Funk, Dmitry Goncharov, Jason Cho, Jensen Huang,
  kawarimidoll, K Jayatheerth, Lidong Yan, Mahendra Dani,
  Matt Hunter, Moumita Dhar, Niels Glodny, Peter Seiderer,
  piotrsiupa, R. Diez, Rodrigo Carvalho, SURA, Zheng Yuting,
  and தமிழ் நேரம்.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Abhijeet Sonar, Adam Johnson, Ahelenia Ziemiańska, brian
  m. carlson, Christian Couder, David Mandelberg, D. Ben Knoble,
  Dennis Ameling, Derrick Stolee, Đoàn Trần Công Danh,
  Elijah Newren, Eli Schwartz, Eric Sunshine, Fernando Ramos,
  Han Jiang, Jean-Noël Avila, Jeff King, Johannes Schindelin,
  Johannes Sixt, John Paul Adrian Glaubitz, Josh Heinrichs, Junio C
  Hamano, Justin Tobler, Karthik Nayak, Koji Nakamaru, Kristoffer
  Haugsbakk, Lucas Seiki Oshiro, Luke Shumaker, Mark Levedahl,
  Meet Soni, Olaf Hering, Oswald Buddenhagen, Patrick Steinhardt,
  Philippe Blain, Phillip Wood, Ramsay Jones, René Scharfe, Sam
  James, Scott Chacon, Seyi Kuforiji, shejialuo, SZEDER Gábor,
  Taylor Blau, Todd Zullinger, Toon Claes, Torsten Bögershausen,
  Tuomas Ahola, and Usman Akinyemi.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.50 Release Notes (draft)
===============================

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

 * Updating multiple references have only been possible in all-or-none
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

 * send-email has been updated to work better with Outlook's smtp server.

 * "git diff --minimal" used to give non-minimal output when its
   optimization kicked in, which has been disabled.

 * "git index-pack --fix-thin" used to abort to prevent a cycle in
   delta chains from forming in a corner case even when there is no
   such cycle.

 * Make repository clean-up tasks "gc" can do available to "git
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


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * A handful of built-in command implementations have been rewritten
   to use the repository instance supplied by git.c:run_builtin(), its
   caller.

 * "git fsck" becomes more careful when checking the refs.

 * "git fast-export | git fast-import" learns to deal with commit and
   tag objects with embedded signatures a bit better.

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
   taught to mmap the file, instead of reading the whole file in the
   memory.

 * Assorted fixes for issues found with CodeQL.

 * Remove the leftover hints to the test framework to mark tests that
   do not pass the leak checker tests, as they should no longer be
   needed.


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
   hooksPath configuration variable to /dev/nulll
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

 * Update to arm64 Windows port.
   (merge 436a42215e js/windows-arm64 later to maint).
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
   used to build artifacts in develper mode, which has been changed to
   build them in release mode for consistency.
   (merge 184abdcf05 js/ci-build-win-in-release-mode later to maint).

 * CI settings at GitLab has been updated to run MSVC based Meson job
   automatically (as opposed to be done only upon manual request).
   (merge 6389579b2f ps/ci-gitlab-enable-msvc-meson-job later to maint).

 * "git apply" and "git add -i/-p" code paths no longer unnecessarily
   expand sparse-index while working.
   (merge ecf9ba20e3 ds/sparse-apply-add-p later to maint).

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

----------------------------------------------------------------

Changes since v2.49.0 are as follows:

Abhijeet Sonar (1):
      environment: fix typo: 'setup_git_directory_gently'

Abhijeetsingh Meena (1):
      dir.h: remove duplicate forward declaration of struct repository

Adam Johnson (1):
      doc: restore: remove note on --patch w/ pathspecs

Aditya Garg (6):
      send-email: retrieve Message-ID from outlook SMTP server
      send-email: add --[no-]outlook-id-fix option
      send-mail: improve checks for valid_fqdn
      docs: improve send-email documentation
      docs: add credential helper for outlook and gmail in OAuth list of helpers
      send-email: try to get fqdn by running hostname -f on Linux and macOS

Ahelenia Ziemiańska (1):
      global: mark usage strings and string tables const

Anthony Wang (1):
      t9811: be more precise to check importing of tags

Arnav Bhate (4):
      decorate: fix sign comparison warnings
      rm: fix sign comparison warnings
      pathspec: fix sign comparison warnings
      environment.h: remove unused variables

Christian Couder (5):
      fast-export: fix missing whitespace after switch
      t5710: arrange to delete the client before cloning
      promisor-remote: fix segfault when remote URL is missing
      promisor-remote: fix possible issue when no URL is advertised
      promisor-remote: compare remote names case sensitively

Christian Fredrik Johnsen (1):
      refs: fix duplicated word in comment

Collin Funk (1):
      wrapper: NetBSD gives EFTYPE and FreeBSD gives EMFILE where POSIX uses ELOOP

D. Ben Knoble (1):
      vimdiff: clarify the sigil used for marking the buffer to save

David Mandelberg (2):
      completion: add helper to count path components
      completion: fix bugs with slashes in remote names

Dennis Ameling (2):
      bswap.h: add support for built-in bswap functions
      config.mak.uname: add support for clangarm64

Derrick Stolee (15):
      maintenance: force progress/no-quiet to children
      maintenance: add loose-objects.batchSize config
      docs: document core.hooksPath=/dev/null
      test-tool: add pack-deltas helper
      t5309: create failing test for 'git index-pack'
      index-pack: allow revisiting REF_DELTA chains
      scalar: customize register_dir()'s behavior
      scalar register: add --no-maintenance option
      scalar clone: add --no-maintenance option
      scalar reconfigure: add --maintenance=<mode> option
      scalar reconfigure: improve --maintenance docs
      apply: integrate with the sparse index
      git add: make -p/-i aware of sparse index
      reset: integrate sparse index with --patch
      p2000: add performance test for patch-mode commands

Dmitry Goncharov (1):
      t6423: add a testcase causing a failed assertion in process_renames

Eli Schwartz (9):
      meson: fix perl detection when docs are enabled, but perl bindings aren't
      meson: disable coccinelle configuration when building from a tarball
      meson: simplify and parameterize various standard function checks
      meson: check for getpagesize before using it
      meson: do a full usage-based compile check for sysinfo
      meson: add a couple missing networking dependencies
      meson: fix typo in function check that prevented checking for hstrerror
      meson: only check for missing networking syms on non-Windows; add compat impls
      meson: reformat default options to workaround bug in `meson configure`

Elijah Newren (29):
      merge-ort: fix slightly overzealous assertion for rename-to-self
      diffcore-rename: fix BUG when break detection and --follow used together
      stash: remove merge-recursive.h include
      t6423: fix a comment that accidentally reversed two commits
      t7615: be more explicit about diff algorithm used
      merge-ort: fix accidental strset<->strintmap
      merge-ort: remove extraneous word in comment
      merge-ort: add new merge_ort_generic() function
      merge-ort: allow rename detection to be disabled
      merge-ort: support having merge verbosity be set to 0
      merge-ort: fix merge.directoryRenames=false
      am: switch from merge_recursive_generic() to merge_ort_generic()
      git-compat-util: introduce ASSERT() macro
      ci: add build checking for side-effects in assert() calls
      treewide: replace assert() with ASSERT() in special cases
      checkout: replace merge_trees() with merge_ort_nonrecursive()
      builtin/merge-recursive: switch to using merge_ort_generic()
      merge-ort: enable diff-algorithms other than histogram
      sequencer: switch non-recursive merges over to ort
      merge, sequencer: switch recursive merges over to ort
      merge-recursive.[ch]: thoroughly debug these
      tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
      builtin/{merge,rebase,revert}: remove GIT_TEST_MERGE_ALGORITHM
      hashmap: ensure hashmaps are reusable after hashmap_clear()
      tree-walk.h: fix incorrect API comment
      replay: replace the_repository with repo parameter passed to cmd_replay ()
      sequencer: make it clearer that commit descriptions are just comments
      merge-ort: add a new mergeability_only option
      merge-tree: add a new --quiet flag

Fernando Ramos (2):
      mergetools: vimdiff: fix layout where REMOTE is the target
      mergetools: vimdiff: add tests for layout with REMOTE as the target

Han Jiang (1):
      doc: add missing commit C to the graph for --ancestry-path=H D..M

Jean-Noël Avila (11):
      doc: add a blank line around block delimiters
      completion: take into account the formatting backticks for options
      doc: apply new format to git-branch man page
      doc: convert git-reset to new documentation format
      doc: fix synopsis analysis logic
      doc: convert git-rm to new documentation format
      doc: move synopsis git-mv commands in the synopsis section
      doc: convert git-mv to new documentation format
      doc: fix asciidoctor synopsis processing of triple-dots
      doc: add markup for characters in Guidelines
      git-var doc: fix usage of $ENV_VAR vs ENV_VAR

Jeff King (41):
      loose_object_info(): BUG() on inflating content with unknown type
      unpack_loose_header(): simplify next_out assignment
      unpack_loose_header(): report headers without NUL as "bad"
      unpack_loose_header(): fix infinite loop on broken zlib input
      git_inflate(): skip zlib_post_call() sanity check on Z_NEED_DICT
      unpack_loose_header(): avoid numeric comparison of zlib status
      unpack_loose_rest(): avoid numeric comparison of zlib status
      unpack_loose_rest(): never clean up zstream
      unpack_loose_rest(): simplify error handling
      unpack_loose_rest(): rewrite return handling for clarity
      t5702: fix typo in test name
      t5516: prefer "oid" to "sha1" in some test titles
      t5516: drop NEEDSWORK about v2 reachability behavior
      t5516: beef up exact-oid ref prefixes test
      refspec_ref_prefixes(): clean up refspec_item logic
      fetch: ask server to advertise HEAD for config-less fetch
      fetch: stop protecting additions to ref-prefix list
      fetch: avoid ls-refs only to ask for HEAD symref update
      fetch: use ref prefix list to skip ls-refs
      run-command: use errno to check for sigfillset() error
      config.mak.dev: enable -Wunreachable-code
      fetch: only respect followRemoteHEAD with configured refspecs
      fetch: don't ask for remote HEAD if followRemoteHEAD is "never"
      fetch: make set_head() call easier to read
      p5332: drop "+" from --stdin-packs input
      oidmap: rename oidmap_free() to oidmap_clear()
      oidmap: add size function
      raw_object_store: drop extra pointer to replace_map
      object-file.h: fix typo in variable declaration
      cat-file: make --allow-unknown-type a noop
      object-file: drop OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag
      cat-file: use type enum instead of buffer for -t option
      oid_object_info_convert(): stop using string for object type
      fsck: stop using object_info->type_name strbuf
      oid_object_info(): drop type_name strbuf
      t/helper: add zlib test-tool
      t: add lib-loose.sh
      hash-object: stop allowing unknown types
      hash-object: merge HASH_* and INDEX_* flags
      hash-object: handle --literally with OPT_NEGBIT
      object-file: drop support for writing objects with unknown types

Jensen Huang (1):
      index-pack, unpack-objects: restore missing ->init_fn

Johannes Schindelin (38):
      t3650: document bug when directory renames are turned off
      mingw: special-case administrators even more
      test-tool path-utils: support debugging "dubious ownership" issues
      imap-send: explicitly verify the peer certificate
      remote-curl: avoid using the comma operator unnecessarily
      rebase: avoid using the comma operator unnecessarily
      kwset: avoid using the comma operator unnecessarily
      clar: avoid using the comma operator unnecessarily
      xdiff: avoid using the comma operator unnecessarily
      diff-delta: avoid using the comma operator
      wildmatch: avoid using of the comma operator
      compat/regex: explicitly mark intentional use of the comma operator
      clang: warn when the comma operator is used
      detect-compiler: detect clang even if it found CUDA
      read-cache: check range before dereferencing an array element
      ci: upgrade `sparse` to supported build agents
      ci(pedantic): ensure that awk is installed
      perf: do allow `GIT_PERF_*` to be overridden again
      mingw: do not use nedmalloc on Windows/ARM64
      msvc: do handle builds on Windows/ARM64
      mingw(arm64): do move the `/etc/git*` location
      max_tree_depth: lower it for clangarm64 on Windows
      diff: check range before dereferencing an array element
      ci(win+Meson): build in Release mode
      ci: stop linking the `prove` cache
      contrib/buildsystems: drop support for building . vcproj/.vcxproj files
      config.mak.uname: drop the `vcxproj` target
      commit: simplify code
      fetch: carefully clear local variable's address after use
      commit-graph: avoid malloc'ing a local variable
      upload-pack: rename `enum` to reflect the operation
      has_dir_name(): make code more obvious
      fetch: avoid unnecessary work when there is no current branch
      Avoid redundant conditions
      trace2: avoid "futile conditional"
      commit-graph: avoid using stale stack addresses
      bundle-uri: avoid using undefined output of `sscanf()`
      sequencer: stop pretending that an assignment is a condition

Johannes Sixt (3):
      git-gui: po/README: update repository location and maintainer
      gitk: adjust indentation to match the style used in this script
      git-gui: treat the message template file as a built file

Josh Heinrichs (1):
      maintenance: fix launchctl calendar intervals

Junio C Hamano (35):
      t: document test_lazy_prereq
      t: extend test_lazy_prereq
      t: introduce WITH_BREAKING_CHANGES prerequisite
      t6120: avoid hiding "git" exit status
      t6120: further modernize
      name-rev: remove "--stdin" support
      git-compat-util: add NOT_CONSTANT macro and use it in atfork_prepare()
      Start 2.50 cycle (batch #1)
      The second batch
      The third batch
      The fourth batch
      The fifth batch
      The sixth batch
      The seventh batch
      t9811: fix misconversion of tests
      The eighth batch
      ci: skip unavailable external software
      CI updates
      The ninth batch
      ci: update the message for unavailble third-party software
      ci: download JGit from maven, not eclipse.org
      The tenth batch
      The eleventh batch
      t6011: fix misconversion from perl to sed
      The twelfth batch
      git-daemon doc: update mark-up of synopsis option descriptions
      git-{var,write-tree} docs: update mark-up of synopsis option descriptions
      git-verify-* doc: update mark-up of synopsis option descriptions
      The thirteenth batch
      The fourteenth batch
      The fifteenth batch
      The sixteenth batch
      The seventeenth batch
      The eighteenth batch
      Git 2.50-rc0

Justin Tobler (17):
      diff: return diff_filepair from diff queue helpers
      diff: add option to skip resolving diff statuses
      builtin: introduce diff-pairs command
      builtin/diff-pairs: allow explicit diff queue flush
      rev-list: inline `show_object_with_name()` in `show_object()`
      rev-list: refactor early option parsing
      rev-list: support delimiting objects with NUL bytes
      rev-list: support NUL-delimited --boundary option
      rev-list: support NUL-delimited --missing option
      builtin/fetch: avoid aborting closed reference transaction
      remote: allow `guess_remote_head()` to suppress advice
      builtin/clone: suppress unexpected default branch advice
      advice: allow disabling default branch name advice
      help: include SHA implementation in version info
      help: include unsafe SHA-1 build info in version
      t5410: test receive-pack connectivity check
      builtin/receive-pack: add option to skip connectivity check

K Jayatheerth (4):
      dir.c: literal match with wildcard in pathspec should still glob
      docs: remove unused mentoring mailing list reference
      docs: clarify cmd_psuh signature and explain UNUSED macro
      docs: replace git_config to repo_config

Karthik Nayak (21):
      reflog: improve error for when reflog is not found
      reflog: implement subcommand to drop reflogs
      ci/github: add missing 'CI_JOB_IMAGE' env variable
      blame: print unblamable and ignored commits in porcelain mode
      refs/files: remove redundant check in split_symref_update()
      refs: move duplicate refname update check to generic layer
      refs/files: remove duplicate duplicates check
      refs/reftable: extract code from the transaction preparation
      refs: introduce enum-based transaction error types
      refs: implement batch reference update support
      refs: support rejection in batch updates during F/D checks
      update-ref: add --batch-updates flag for stdin mode
      t6020: test for duplicate refnames in bundle creation
      bundle: fix non-linear performance scaling with refs
      ci/github: install git before checking out the repository
      coccinelle: meson: rename variables to be more specific
      meson: move headers definition from 'contrib/coccinelle'
      meson: rename 'third_party_sources' to 'third_party_excludes'
      meson: add support for 'hdr-check'
      makefile/meson: add 'check-headers' as alias for 'hdr-check'
      t: remove unexpected SANITIZE_LEAK variables

Kristoffer Haugsbakk (2):
      doc: reflog: fix `drop` subheading
      doc: branch: fix inline-verbatim

Lidong Yan (7):
      reftable/writer: fix memory leak when `padded_write()` fails
      reftable/writer: fix memory leak when `writer_index_hash()` fails
      builtin/am: fix memory leak in `split_mail_stgit_series`
      pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
      mailinfo: fix pointential memory leak if `decode_header` failed
      sequencer: fix memory leak if `todo_list_rearrange_squash()` failed
      commit-graph: fix memory leak when `fill_oids_from_packs()` fails

Lucas Seiki Oshiro (4):
      userdiff: add builtin driver for INI files
      revision: remove log_reencode field from rev_info
      json-writer: add docstrings to jw_* functions
      json-writer: describe the usage of jw_* functions

Luke Shumaker (5):
      git-fast-import.adoc: add missing LF in the BNF
      fast-export: rename --signed-tags='warn' to 'warn-verbatim'
      git-fast-export.adoc: clarify why 'verbatim' may not be a good idea
      fast-export: do not modify memory from get_commit_buffer
      fast-export, fast-import: add support for signed-commits

Mahendra Dani (1):
      t1403: verify that path exists and is a file

Mark Levedahl (3):
      gitk: override $PATH search only on Windows
      gitk: _search_exe is no longer needed
      gitk: limit PATH search to bare executable names

Matt Hunter (1):
      revision: fix --left/right-only use with unrelated histories

Meet Soni (3):
      reftable: propagate specific error codes in block_writer_add()
      reftable: adapt writer_add_record() to propagate block_writer_add() errors
      reftable: adapt write_object_record() to propagate block_writer_add() errors

Moumita Dhar (1):
      userdiff: extend Bash pattern to cover more shell function forms

Niels Glodny (1):
      xdiff: disable cleanup_records heuristic with --minimal

Oswald Buddenhagen (1):
      git-gui: heed core.commentChar/commentString

Patrick Steinhardt (160):
      reftable/stack: stop using `read_in_full()`
      reftable/stack: stop using `write_in_full()`
      reftable/blocksource: stop using `xmmap()`
      reftable/record: stop using `COPY_ARRAY()`
      reftable/record: stop using `BUG()` in `reftable_record_init()`
      reftable/record: don't `BUG()` in `reftable_record_cmp()`
      reftable: stop using `BUG()` in trivial cases
      reftable/basics: stop using `st_mult()` in array allocators
      reftable/basics: provide wrappers for big endian conversion
      reftable/reader: stop using `ARRAY_SIZE()` macro
      reftable/system: introduce `reftable_rand()`
      reftable/stack: stop using `sleep_millisec()`
      reftable/basics: stop using `SWAP()` macro
      reftable/basics: introduce `REFTABLE_UNUSED` annotation
      compat/mingw: split out POSIX-related bits
      git-compat-util.h: split out POSIX-emulating bits
      reftable: decouple from Git codebase by pulling in "compat/posix.h"
      Makefile: skip reftable library for Coccinelle
      reftable: ignore file-in-use errors when unlink(3p) fails on Windows
      csum-file: stop depending on `the_repository`
      object: stop depending on `the_repository`
      pack-write: stop depending on `the_repository` and `the_hash_algo`
      environment: move access to "core.bigFileThreshold" into repo settings
      pack-check: stop depending on `the_repository`
      pack-revindex: stop depending on `the_repository`
      pack-bitmap-write: stop depending on `the_repository`
      object-file-convert: stop depending on `the_repository`
      delta-islands: stop depending on `the_repository`
      object-file: split out logic regarding hash algorithms
      hash: fix "-Wsign-compare" warnings
      hash: stop depending on `the_repository` in `null_oid()`
      meson: define WITH_BREAKING_CHANGES when enabling breaking changes
      meson: don't compile git-pack-redundant(1) with breaking changes
      meson: don't install git-pack-redundant(1) docs with breaking changes
      ci: perform build and smoke tests for Meson docs
      object-name: introduce `repo_get_oid_with_flags()`
      object-name: allow skipping ambiguity checks in `get_oid()` family
      builtin/update-ref: skip ambiguity checks when parsing object IDs
      refs: introduce function to batch refname availability checks
      refs/reftable: batch refname availability checks
      refs/files: batch refname availability checks for normal transactions
      refs/files: batch refname availability checks for initial transactions
      refs: stop re-verifying common prefixes for availability
      refs/iterator: separate lifecycle from iteration
      refs/iterator: provide infrastructure to re-seek iterators
      refs/iterator: implement seeking for merged iterators
      refs/iterator: implement seeking for reftable iterators
      refs/iterator: implement seeking for ref-cache iterators
      refs/iterator: implement seeking for packed-ref iterators
      refs/iterator: implement seeking for files iterators
      refs: reuse iterators when determining refname availability
      meson: fix compat sources when compiling with MSVC
      compat/mingw: fix EACCESS when opening files with `O_CREAT | O_EXCL`
      meson: fix handling of '-Dcurl=auto'
      gitweb: fix generation of "gitweb.js"
      meson: respect 'tests' build option in contrib
      meson: distinguish build and target host binaries
      ci: use Visual Studio for win+meson job on GitHub Workflows
      builtin/cat-file: rename variable that tracks usage
      builtin/cat-file: introduce function to report object status
      builtin/cat-file: wire up an option to filter objects
      builtin/cat-file: support "blob:none" objects filter
      builtin/cat-file: support "blob:limit=" objects filter
      builtin/cat-file: support "object:type=" objects filter
      pack-bitmap: allow passing payloads to `show_reachable_fn()`
      pack-bitmap: add function to iterate over filtered bitmapped objects
      pack-bitmap: introduce function to check whether a pack is bitmapped
      builtin/cat-file: deduplicate logic to iterate over all objects
      builtin/cat-file: use bitmaps to efficiently filter by object type
      t: skip chain lint when PERL_PATH is unset
      t: refactor environment sanitization to not use Perl
      t: adapt character translation helpers to not use Perl
      t: adapt `test_copy_bytes()` to not use Perl
      t: adapt `test_readlink()` to not use Perl
      t: introduce PERL_TEST_HELPERS prerequisite
      t: adapt existing PERL prerequisites
      meson: stop requiring Perl when tests are enabled
      Makefile: stop requiring Perl when running tests
      t: refactor tests depending on Perl transliteration operator
      t: refactor tests depending on Perl substitution operator
      t: refactor tests depending on Perl to print data
      t: refactor tests depending on Perl for textconv scripts
      t/lib-gpg: refactor `sanitize_pgp()` to not depend on Perl
      t/lib-t6000: refactor `name_from_description()` to not depend on Perl
      t/lib-httpd: refactor "one-time-perl" CGI script to not depend on Perl
      t0021: refactor `generate_random_characters()` to not depend on Perl
      t0210: refactor trace2 scrubbing to not use Perl
      t5316: refactor `max_chain()` to not depend on Perl
      t5703: refactor test to not depend on Perl
      reftable: fix formatting of the license header
      reftable/reader: rename data structure to "table"
      reftable/blocksource: consolidate code into a single file
      reftable/block: simplify how we track restart points
      reftable/table: move reading block into block reader
      reftable/block: rename `block` to `block_data`
      reftable/block: rename `block_reader` to `reftable_block`
      git-zlib: use `struct z_stream_s` instead of typedef
      reftable/block: create public interface for reading blocks
      reftable/block: store block pointer in the block iterator
      reftable/block: make block iterators reseekable
      reftable/block: expose a generic iterator over reftable records
      reftable/table: add `reftable_table` to the public interface
      reftable/table: introduce iterator for table blocks
      reftable/constants: make block types part of the public interface
      reftable/table: move printing logic into test helper
      reflog: rename `cmd_reflog_expire_cb` to `reflog_expire_options`
      builtin/reflog: stop storing default reflog expiry dates globally
      builtin/reflog: stop storing per-reflog expiry dates globally
      builtin/reflog: make functions regarding `reflog_expire_options` public
      builtin/gc: split out function to expire reflog entries
      builtin/maintenance: introduce "reflog-expire" task
      refs/packed: fix BUG when seeking refs with UTF-8 characters
      object-file: move `mkdir_in_gitdir()` into "path.c"
      object-file: move `safe_create_leading_directories()` into "path.c"
      object-file: move `git_open_cloexec()` to "compat/open.c"
      object-file: move `xmmap()` into "wrapper.c"
      object-file: split out functions relating to object store subsystem
      object-file: split up concerns of `HASH_*` flags
      object-file: drop `index_blob_stream()`
      object: split out functions relating to object store subsystem
      object-store: remove global array of cached objects
      object-store: merge "object-store-ll.h" and "object-store.h"
      filter-branch: stop depending on Perl
      request-pull: stop depending on Perl
      Documentation: stop depending on Perl to massage user manual
      Documentation: stop depending on Perl to generate command list
      parse: fix off-by-one for minimum signed values
      global: use designated initializers for options
      parse-options: support unit factors in `OPT_INTEGER()`
      parse-options: rename `OPT_MAGNITUDE()` to `OPT_UNSIGNED()`
      parse-options: introduce precision handling for `OPTION_INTEGER`
      parse-options: introduce precision handling for `OPTION_UNSIGNED`
      parse-options: detect mismatches in integer signedness
      ci: fix p4d executable not being found on GitHub Actions
      contrib/completion: install Bash completion
      meson: report detected runtime executable paths
      meson: prefer shell at "/bin/sh"
      t/perf: fix benchmarks with alternate repo formats
      t/perf: use configured PERL_PATH
      t/perf: fix benchmarks with out-of-tree builds
      meson: wire up benchmarks
      meson: wire up benchmarking options
      object-store: move `struct packed_git` into "packfile.h"
      object-store: drop `loose_object_path()`
      object-store: move and rename `odb_pack_keep()`
      object-store: move function declarations to their respective subsystems
      object-store: allow fetching objects via `has_object()`
      treewide: convert users of `repo_has_object_file()` to `has_object()`
      object-store: drop `repo_has_object_file()`
      builtin/mv: bail out when trying to move child and its parent
      builtin/mv: convert assert(3p) into `BUG()`
      ci: fix aggregation of test results with Meson
      builtin/gc: fix indentation of `cmd_gc()` parameters
      builtin/gc: remove global variables where it is trivial to do
      builtin/gc: move pruning of worktrees into a separate function
      builtin/maintenance: introduce "worktree-prune" task
      builtin/gc: move rerere garbage collection into separate function
      builtin/maintenance: introduce "rerere-gc" task
      reftable: fix perf regression when reading blocks of unwanted type
      gitlab-ci: always run MSVC-based Meson job

Philippe Blain (3):
      p7821: fix test_perf invocation for prereqs
      p9210: fix 'scalar clone' when running from a detached HEAD
      p7821: fix instructions for testing with threads

Phillip Wood (5):
      pack-refs doc: fix indentation for --exclude
      docs: add BreakingChanges to TECH_DOCS target
      merge-file doc: set conflict-marker-size attribute
      sequencer: move reflog message functions
      sequencer: rework reflog message handling

Ramsay Jones (18):
      meson.build: remove -DCURL_DISABLE_TYPECHECK
      Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
      meson.build: only set build variables for non-default values
      meson.build: set default help format to html on windows
      Makefile: remove NEEDS_LIBRT build variable
      config.mak.uname: add a note about NO_STRLCPY for Linux
      config.mak.uname: only set NO_REGEX on cygwin for v1.7
      config.mak.uname: add HAVE_GETDELIM to the cygwin section
      config.mak.uname: add clock_gettime() to the cygwin build
      builtin/gc.c: correct RAM calculation when using sysinfo
      config.mak.uname: add sysinfo() configuration for cygwin
      config.mak.uname: add arc4random to the cygwin build
      config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
      meson.build: quote the GITWEBDIR build configuration
      meson: correct install location of YAML.pm
      meson: correct path to system config/attribute files
      meson.build: correct setting of GIT_EXEC_PATH
      configure.ac: upgrade to a compilation check for sysinfo

René Scharfe (2):
      xdiff: avoid arithmetic overflow in xdl_get_hunk()
      commit: move clear_commit_marks_many() loop body to clear_commit_marks()

Rodrigo Carvalho (1):
      t1001: replace 'test -f' with 'test_path_is_file'

Scott Chacon (2):
      bundle-uri: copy all bundle references ino the refs/bundle space
      bundle-uri: add test for bundle-uri clones with tags

Seyi Kuforiji (2):
      t/unit-tests: convert trailer test to use clar
      t/unit-tests: convert urlmatch-normalization test to clar

Taylor Blau (31):
      refs.c: remove empty '--exclude' patterns
      refs.c: stop matching non-directory prefixes in exclude patterns
      builtin/pack-objects.c: freshen objects from existing cruft packs
      http.c: remove unnecessary casts to long
      http.c: introduce `set_long_from_env()` for convenience
      http.c: inline `set_curl_keepalive()`
      http.c: allow custom TCP keepalive behavior via config
      refspec: treat 'fetch' as a Boolean value
      refspec: replace `refspec_init()` with fetch/push variants
      refspec: remove refspec_item_init_or_die()
      refspec: replace `refspec_item_init()` with fetch/push variants
      pseudo-merge.h: fix a typo
      t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
      t/t7704-repack-cruft.sh: clarify wording in --max-cruft-size tests
      t/t7704-repack-cruft.sh: consolidate `write_blob()`
      repack: avoid combining cruft packs with `--max-cruft-size`
      repack: begin combining cruft packs with `--combine-cruft-below-size`
      Documentation: remove a "future work" item from the MIDX docs
      Documentation: describe incremental MIDX bitmaps
      pack-revindex: prepare for incremental MIDX bitmaps
      pack-bitmap.c: open and store incremental bitmap layers
      pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
      pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
      pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
      pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
      pack-bitmap.c: compute disk-usage with incremental MIDXs
      pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
      ewah: implement `struct ewah_or_iterator`
      pack-bitmap.c: keep track of each layer's type bitmaps
      pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
      midx: implement writing incremental MIDX bitmaps

Torsten Bögershausen (1):
      intialize false_but_the_compiler_does_not_know_it_

Tuomas Ahola (1):
      bulk-checkin: fix sign compare warnings

Usman Akinyemi (11):
      config: teach repo_config to allow `repo` to be NULL
      builtin/verify-tag: stop using `the_repository`
      builtin/verify-commit: stop using `the_repository`
      builtin/send-pack: stop using `the_repository`
      builtin/pack-refs: stop using `the_repository`
      builtin/ls-files: stop using `the_repository`
      builtin/for-each-ref: stop using `the_repository`
      builtin/checkout-index: stop using `the_repository`
      builtin/update-server-info: remove unnecessary if statement
      builtin/add: remove unnecessary if statement
      builtin/difftool: remove unnecessary if statement

Zheng Yuting (2):
      send-email: capture errors in an eval {} block
      send-email: finer-grained SMTP error handling

brian m. carlson (2):
      t5605: fix test for cloning from a different user
      Makefile: avoid constant rebuilds with compilation database

shejialuo (12):
      t0602: use subshell to ensure working directory unchanged
      builtin/refs: get worktrees without reading head information
      packed-backend: check whether the "packed-refs" is regular file
      packed-backend: check if header starts with "# pack-refs with: "
      packed-backend: add "packed-refs" header consistency check
      packed-backend: check whether the refname contains NUL characters
      packed-backend: add "packed-refs" entry consistency check
      packed-backend: check whether the "packed-refs" is sorted
      builtin/fsck: add `git refs verify` child process
      packed-backend: fsck should warn when "packed-refs" file is empty
      packed-backend: extract snapshot allocation in `load_contents`
      packed-backend: mmap large "packed-refs" file during fsck

Đoàn Trần Công Danh (2):
      sparse: ignore warning from new glibc headers
      meson: allow customize perl installation path

தமிழ் நேரம் (1):
      gitk: add Tamil translation


Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C11D14E8;
	Wed,  2 Oct 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888392; cv=none; b=d3v141rgzh3QeNwfBFnifGt1lobyUuaExaLaV1KOBlWdgSFPiR5khaJakrzdpT61wP5xzU4B1+oTa7Lwj9oWn6e3RGskGg1RjIDumRBgPAIuZ4lYdZusUSTWxFiTpLQb5pJ4PeYFBjm9xkwQ+wi9eSKQHXAXDBC55GtIrcB8Z/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888392; c=relaxed/simple;
	bh=kt6yOsTBJovNmpqPfJKpkM6owBPJoeq4sqlkh2vrey4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lDEWQzyB/VHmJEegpmOxR4kE4JNADCEUmXJFQWRGAvH2YVrWbEEKUGslZLllhcB+maf2JKcoaNctdnMFxRGK+aW5xifv/SsxB1op8twDRcxf1C3YcNuLfvdeUVTIszq3hE0kSMW36sL3DgI3opX0rz2RlxPBm/r/JyEdjxhcua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JJU27bGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pctqZxfK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JJU27bGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pctqZxfK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB08F114017F;
	Wed,  2 Oct 2024 12:59:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 02 Oct 2024 12:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1727888386; x=1727974786; bh=QA
	fAoF7fY2KqYvWpu2XT6PMM17goaLckKI7T/kcsO3U=; b=JJU27bGHRWcS3k40pn
	uDcS/dyYAk6Bor7000bzdqnEhMfP12X+c/U8LJaHNwcGqfbwjQU0fwAhn/j8p7TX
	ckTPwylhtBjiE8CLpl6i2UqbwBq1Hpn3CGrfywJye5ipslsQJGykbiDhrgdUlVaq
	xVVKX2Ei1aRAEqEWAATe6uViZEl0QLMxIquQdURNoAHNQIpFjZJ4jaGG76KMx1MR
	jiajZuSHuXUKBUD0xwdiLMrMZq+NlTswV184PhAlRuTYJJA/w635lMoHTwHkqUaA
	MyLpUL6JA61ASymadFIWQjW+R+aOWAjz+wHp43fzDI8f6ypdLOiMLsdr4q7RBj6D
	K2rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727888386; x=1727974786; bh=QAfAoF7fY2KqY
	vWpu2XT6PMM17goaLckKI7T/kcsO3U=; b=pctqZxfK89BPIzpdoGXLtsRLFhz+Q
	twWkXjBJPgqYWIhv2Zy0Z3KQ6EjyS0+esa4ltl2u2jFWXipGgQA3m7zNRfw5WWfU
	y1oVqHWi039qz7fBsIUMXQhg58YDZsk+kwG1PhFOs1e74lg1Vwm1ooRjo21+zyVC
	ODEoLgbMeZELhTiZ2D9IiSZC77PUx7VvJQDWdUb92NQsiaUa6Kef/m8kGl+9mgkh
	YD6lHheWt6xJ1iXBWLnJ7kDrqmHh2P5itWeoesaFkT37MNfzfTUcSkm0vK2R8xzJ
	EIrHCOANlDaZfvNR7eGf1vJ+5OhyHgewXztG71ZxDgDqBBjmmMDra5Rdg==
X-ME-Sender: <xms:Anz9ZvhQBsYMxYvyxEvMEiHp3PugPYUkzM6Sp_d-KwM_HXHG9Fsnwg>
    <xme:Anz9ZsBlBfog6Mt68Z6C0H4YOf_Iu9u2dAYEsSqlDKuXpJCupbGhwskQOB9lw9MIm
    L5aBsYpG_Dt6wCZqg>
X-ME-Received: <xmr:Anz9ZvEqF5LYi0DSwbvAyfqkP6cFrIdzRAHfGaGLLPgC7jk3FpJqSiLjhe0Rb64qLL7JBjhwOIOGAswA3Fh-D2tcct-wZAUV6GNysrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepheeltdetheegheefieefkeeuudelheeujedu
    kefhfedtvdeggefgleduteehgedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hoohhglhgvshhouhhrtggvrdgtohhmpdhorhdrtgiipdhgihhthhhusgdrtghomhdpmhgr
    khdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhrohhuph
    hsrdgtohhmpdhrtghpthhtoheplhifnheslhifnhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Anz9ZsQ6gd0Kd7cKKAJYHOFBrL44k1dtfD5rwKii0dXbfcXUvqK-wA>
    <xmx:Anz9Zszhxct29y8EX56IWwBJ_KQcd8_Q7iGDeWzpMrpQRwug02UnaQ>
    <xmx:Anz9Zi4IFR0rmSXWk1KH_-VX0bhRCGjctaLzn2w4G10KmxpD8xa_8A>
    <xmx:Anz9ZhxhUyhLJo9_aA1Wyz4S6SXuQnUBIitIHuS-ty7Nx32HI0XSwg>
    <xmx:Anz9Zrrw8hmkwCeyRVdwwX12JwnhyLCwIbqnzAJ9-uK2vQBYEQRj9WKJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 12:59:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.47.0-rc1
Date: Wed, 02 Oct 2024 09:59:44 -0700
Message-ID: <xmqqploiphj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A release candidate Git v2.47.0-rc1 is now available for testing at
the usual places.  It is comprised of 670 non-merge commits since
v2.46.0, contributed by 71 people, 28 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.47.0-rc1' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.46.0 are as follows.
Welcome to the Git development community!

  AbdAlRahman Gad, ahmed akef, Alex Galvin, Andrew Kreimer, Andrew
  Morton, ArcticLampyrid, Avi Halachmi (:avih), David Disseldorp,
  David Hull, D Harithamma, Furkan Akkurt, Han Jiang, Hong Jiang,
  Ilya Tumaykin, Jayson Rhynas, Jeppe Øland, Jorge Luis Martinez
  Gomez, Kevin Lyles, Kohei Shibata, Lincoln Yuji, Matt Liberty,
  Piotr Siupa, Randall Becker, Rodrigo, Rodrigo Siqueira, Ryan
  Hendrickson, Tomas Nordin, and Yuri Karnilaev.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Shopov, Alex Henrie, Antonin Delpeuch, Beat Bolli,
  Brian Lyles, brian m. carlson, Brooke Kuhlmann, Calvin Wan,
  Carlo Marcelo Arenas Belón, Celeste Liu, Chandra Pratap,
  Christian Couder, Derrick Stolee, Elijah Newren, Emily Shaffer,
  Eric Sunshine, Ghanshyam Thakkar, Ilya K, Jacob Keller, Jeff
  King, Johannes Schindelin, John Cai, Josh Steadmon, Junio C
  Hamano, Justin Tobler, Kaartic Sivaraam, Karthik Nayak, Kousik
  Sanagavarapu, Kyle Lippincott, Martin Ågren, Matheus Tavares,
  Mike Hommey, Patrick Steinhardt, Phillip Wood, Ramsay Jones,
  René Scharfe, Ronan Pigott, Rubén Justo, shejialuo, Stephen
  P. Smith, Sven Strickroth, Taylor Blau, and Xing Xin.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.47 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * Many Porcelain commands that internally use the merge machinery
   were taught to consistently honor the diff.algorithm configuration.

 * A few descriptions in "git show-ref -h" have been clarified.

 * A 'P' command to "git add -p" that passes the patch hunk to the
   pager has been added.

 * "git grep -W" omits blank lines that follow the found function at
   the end of the file, just like it omits blank lines before the next
   function.

 * The value of http.proxy can have "path" at the end for a socks
   proxy that listens to a unix-domain socket, but we started to
   discard it when we taught proxy auth code path to use the
   credential helpers, which has been corrected.

 * The code paths to compact multiple reftable files have been updated
   to correctly deal with multiple compaction triggering at the same
   time.

 * Support to specify ref backend for submodules has been enhanced.

 * "git svn" has been taught about svn:global-ignores property
   recent versions of Subversion has.

 * The default object hash and ref backend format used to be settable
   only with explicit command line option to "git init" and
   environment variables, but now they can be configured in the user's
   global and system wide configuration.

 * "git send-email" learned "--translate-aliases" option that reads
   addresses from the standard input and emits the result of applying
   aliases on them to the standard output.

 * 'git for-each-ref' learned a new "--format" atom to find the branch
   that the history leading to a given commit "%(is-base:<commit>)" is
   likely based on.

 * The command line prompt support used to be littered with bash-isms,
   which has been corrected to work with more shells.

 * Support for the RUNTIME_PREFIX feature has been added to z/OS port.

 * "git send-email" learned "--mailmap" option to allow rewriting the
   recipient addresses.

 * "git mergetool" learned to use VSCode as a merge backend.

 * "git pack-redundant" has been marked for removal in Git 3.0.

 * One-line messages to "die" and other helper functions will get LF
   added by these helper functions, but many existing messages had an
   unnecessary LF at the end, which have been corrected.

 * The "scalar clone" command learned the "--no-tags" option.

 * The environment GIT_ADVICE has been intentionally kept undocumented
   to discourage its use by interactive users.  Add documentation to
   help tool writers.

 * "git apply --3way" learned to take "--ours" and other options.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * A build tweak knob has been simplified by not setting the value
   that is already the default; another unused one has been removed.

 * A CI job that use clang-format to check coding style issues in new
   code has been added.

 * The reviewing guidelines document now explicitly encourages people
   to give positive reviews and how.

 * Test script linter has been updated to catch an attempt to use
   one-shot export construct "VAR=VAL func" for shell functions (which
   does not work for some shells) better.

 * Some project conventions have been added to CodingGuidelines.

 * In the refs subsystem, implicit reliance of the_repository has been
   eliminated; the repository associated with the ref store object is
   used instead.

 * Various tests in reftable library have been rewritten using the unit test
   framework.

 * A test that fails on an unusually slow machine was found, and made
   less likely to cause trouble by lengthening the expiry value it
   uses.

 * An existing test of hashmap API has been rewritten with the
   unit-test framework.

 * A policy document that describes platform support levels and
   expectation on platform stakeholders has been introduced.

 * The refs API has been taught to give symref target information to
   the users of ref iterators, allowing for-each-ref and friends to
   avoid an extra ref_resolve_* API call per a symbolic ref.

 * Unit-test framework has learned a simple control structure to allow
   embedding test statements in-line instead of having to create a new
   function to contain them.

 * Incremental updates of multi-pack index files is getting worked on.

 * Use of API functions that implicitly depend on the_repository
   object in the config subsystem has been rewritten to pass a
   repository object through the callchain.

 * Unused parameters have been either marked as UNUSED to squelch
   -Wunused warnings or dropped from many functions..

 * The code in the reftable library has been cleaned up by discarding
   unused "generic" interface.

 * The underlying machinery for "git diff-index" has long been made to
   expand the sparse index as needed, but the command fully expanded
   the sparse index upfront, which now has been taught not to do.

 * More trace2 events at key points on push and fetch code paths have
   been added.

 * Make our codebase compilable with the -Werror=unused-parameter
   option.

 * "git cat-file" works well with the sparse-index, and gets marked as
   such.

 * CI started failing completely for linux32 jobs, as the step to
   upload failed test directory uses GitHub actions that is deprecated
   and is now disabled.

 * Import clar unit tests framework libgit2 folks invented for our
   use.

 * The error messages from the test script checker have been improved.

 * The convention to calling into built-in command implementation has
   been updated to pass the repository, if known, together with the
   prefix value.

 * "git apply" had custom buffer management code that predated before
   use of strbuf got widespread, which has been updated to use strbuf,
   which also plugged some memory leaks.

 * The reftable backend learned to more efficiently handle exclude
   patterns while enumerating the refs.

 * CI updates.  FreeBSD image has been updated to 13.4.
   (merge 2eeb29702e cb/ci-freebsd-13-4 later to maint).

 * Give timeout to the locking code to write to reftable, instead of
   failing on the first failure without retrying.

 * The checksum at the tail of files are now computed without
   collision detection protection.  This is safe as the consumer of
   the information to protect itself from replay attacks checks for
   hash collisions independently.


Fixes since v2.46
-----------------

 * "git add -p" by users with diff.suppressBlankEmpty set to true
   failed to parse the patch that represents an unmodified empty line
   with an empty line (not a line with a single space on it), which
   has been corrected.

 * "git checkout --ours" (no other arguments) complained that the
   option is incompatible with branch switching, which is technically
   correct, but found confusing by some users.  It now says that the
   user needs to give pathspec to specify what paths to checkout.

 * It has been documented that we avoid "VAR=VAL shell_func" and why.

 * "git rebase --help" referred to "offset" (the difference between
   the location a change was taken from and the change gets replaced)
   incorrectly and called it "fuzz", which has been corrected.

 * "git notes add -m '' --allow-empty" and friends that take prepared
   data to create notes should not invoke an editor, but it started
   doing so since Git 2.42, which has been corrected.

 * An expensive operation to prepare tracing was done in re-encoding
   code path even when the tracing was not requested, which has been
   corrected.

 * More leakfixes.

 * The credential helper to talk to OSX keychain sometimes sent
   garbage bytes after the username, which has been corrected.

 * A recent update broke "git ls-remote" used outside a repository,
   which has been corrected.

 * The patch parser in 'git apply' has been a bit more lenient against
   unexpected mode bits, like 100664, recorded on extended header lines.

 * "git config --value=foo --fixed-value section.key newvalue" barfed
   when the existing value in the configuration file used the
   valueless true syntax, which has been corrected.

 * The patch parser in "git patch-id" has been tightened to avoid
   getting confused by lines that look like a patch header in the log
   message.

 * "git reflog expire" failed to honor annotated tags when computing
   reachable commits.

 * A flakey test and incorrect calls to strtoX() functions have been
   fixed.

 * Follow-up on 2.45.1 regression fix.

 * "git rev-list ... | git diff-tree -p --remerge-diff --stdin" should
   behave more or less like "git log -p --remerge-diff" but instead it
   crashed, forgetting to prepare a temporary object store needed.

 * "git bundle unbundle" outside a repository triggered a BUG()
   unnecessarily, which has been corrected.

 * Maintenance tasks other than "gc" now properly go background when
   "git maintenance" runs them.

 * We created a useless pseudo-merge reachability bitmap that is about
   0 commits, and attempted to include commits that are not in packs,
   which made no sense.  These bugs have been corrected.
   (merge a72dfab8b8 tb/pseudo-merge-bitmap-fixes later to maint).

 * "git rebase -x --quiet" was not quiet, which was corrected.

 * The code path for compacting reftable files saw some bugfixes
   against concurrent operation.

 * The code forgot to discard unnecessary in-core commit buffer data
   for commits that "git log --skip=<number>" traversed but omitted
   from the output, which has been corrected.

 * "git verify-pack" and "git index-pack" started dying outside a
   repository, which has been corrected.

 * A data corruption bug when multi-pack-index is used and the same
   objects are stored in multiple packfiles has been corrected.

 * "git pack-refs --auto" for the files backend was too aggressive,
   which has been a bit tamed.
   (merge c3459ae9ef ps/pack-refs-auto-heuristics later to maint).

 * A file descriptor left open is now properly closed when "git
   sparse-checkout" updates the sparse patterns.

 * In a few corner cases "git diff --exit-code" failed to report
   "changes" (e.g., renamed without any content change), which has
   been corrected.

 * Cygwin does have /dev/tty support that is needed by things like
   single-key input mode.

 * The interpret-trailers command failed to recognise the end of the
   message when the commit log ends in an incomplete line.

 * "git rebase --autostash" failed to resurrect the autostashed
   changes when the command gets aborted after giving back control
   asking for hlep in conflict resolution.
   (merge bf6ab087d1 pw/rebase-autostash-fix later to maint).

 * The "imap-send" now allows to be compiled with NO_OPENSSL and
   OPENSSL_SHA1 defined together.
   (merge 997950a750 jk/no-openssl-with-openssl-sha1 later to maint).

 * The support to customize build options to adjust for older versions
   and/or older systems for the interop tests has been improved.
   (merge 22ef5f02a8 jk/interop-test-build-options later to maint).

 * Update the character width table for Unicode 16.
   (merge 44dc651132 bb/unicode-width-table-16 later to maint).

 * In Git 2.39, Git.pm stopped working in a bare repository, which has
   been corrected.
   (merge d3edb0bdde jk/git-pm-bare-repo-fix later to maint).

 * When a remote-helper dies before Git writes to it, SIGPIPE killed
   Git silently.  We now explain the situation a bit better to the end
   user in our error message.
   (merge 6e7fac9bca jk/diag-unexpected-remote-helper-death later to maint).

 * A few usability fixes to "git jump" (in contrib/).
   (merge 083b82544d jk/jump-quickfix-fixes later to maint).

 * "git diff --exit-code" ignored modified binary files, which has
   been corrected.
   (merge 9a41735af6 rs/diff-exit-code-binary later to maint).

 * When a subprocess to work in a submodule spawned by "git submodule"
   fails with SIGPIPE, the parent Git process caught the death of it,
   but gave a generic "failed to work in that submodule", which was
   misleading.  We now behave as if the parent got SIGPIPE and die.
   (merge 082caf527e pw/submodule-process-sigpipe later to maint).

 * "git archive" with pathspec magic that uses the attribute
   information did not work well, which has been corrected.
   (merge 296743a7ca rs/archive-with-attr-pathspec-fix later to maint).

 * Background tasks "git maintenance" runs may need to use credential
   information when going over the network, but a credential helper
   may work only in an interactive environment, and end up blocking a
   scheduled task waiting for UI.  Credential helpers can now behave
   differently when they are not running interactively.
   (merge b9183b0a02 ds/background-maintenance-with-credential later to maint).

 * "git --git-dir=nowhere cmd" failed to properly notice that it
   wasn't in any repository while processing includeIf.onbranch
   configuration and instead crashed.

 * When "git sparse-checkout disable" turns a sparse checkout into a
   regular checkout, the index is fully expanded.  This totally
   expected behaviour however had an "oops, we are expanding the
   index" advice message, which has been corrected.
   (merge 537e516a39 ds/sparse-checkout-expansion-advice later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge be10ac7037 jc/mailinfo-header-cleanup later to maint).
   (merge 4460e052e0 jc/range-diff-lazy-setup later to maint).
   (merge 0627c58e7a ak/typofixes later to maint).
   (merge 83799f1500 jk/t9001-deflake later to maint).
   (merge e02cc08a88 ak/typofix-2.46-maint later to maint).
   (merge 5c5d29e1c4 ps/ci-gitlab-upgrade later to maint).

----------------------------------------------------------------

Changes since v2.46.0 are as follows:

AbdAlRahman Gad (8):
      t7004: remove space after redirect operators
      t7004: one command per line
      t7004: use indented here-doc
      t7004: do not prepare things outside test_expect_success
      t7004: description on the same line as test_expect_success
      t7004: begin the test body on the same line as test_expect_success
      t7004: use single quotes instead of double quotes
      t7004: make use of write_script

Alex Galvin (3):
      git-svn: add public property `svn:global-ignores`
      git-svn: use `svn:global-ignores` to create .gitignore
      git-svn: mention `svn:global-ignores` in help+docs

Alex Henrie (2):
      mergetools: vscode: new tool
      apply: support --ours, --theirs, and --union for three-way merges

Alexander Shopov (1):
      show-ref: improve short help messages of options

Andrew Kreimer (25):
      attr: fix a typo
      bloom: fix a typo
      cbtree: fix a typo
      config.mak.dev: fix a typo
      diffcore-rename: fix typos
      fsmonitor-settings: fix a typo
      git-instaweb: fix a typo
      git-p4: fix typos
      gpg-interface: fix a typo
      http: fix a typo
      merge-ll: fix a typo
      merge-ort: fix typos
      object-file: fix a typo
      pretty: fix a typo
      read-cache-ll: fix a typo
      rebase: fix a typo
      refs: fix typos
      revision: fix a typo
      run-command: fix a typo
      setup: fix a typo
      sideband: fix a typo
      upload-pack: fix a typo
      ref-filter: fix a typo
      Documentation/technical: fix a typo
      builtin: fix typos

Antonin Delpeuch (1):
      merge-recursive: honor diff.algorithm

Avi Halachmi (:avih) (8):
      git-prompt: use here-doc instead of here-string
      git-prompt: fix uninitialized variable
      git-prompt: don't use shell arrays
      git-prompt: replace [[...]] with standard code
      git-prompt: add some missing quotes
      git-prompt: don't use shell $'...'
      git-prompt: ta-da! document usage in other shells
      git-prompt: support custom 0-width PS1 markers

Beat Bolli (1):
      unicode: update the width tables to Unicode 16

Brian Lyles (1):
      interpret-trailers: handle message without trailing newline

Calvin Wan (1):
      send-pack: add new tracing regions for push

Carlo Marcelo Arenas Belón (1):
      ci: update FreeBSD image to 13.4

Celeste Liu (1):
      doc: replace 3 dash with correct 2 dash in git-config(1)

Chandra Pratap (40):
      t: move reftable/merged_test.c to the unit testing framework
      t: harmonize t-reftable-merged.c with coding guidelines
      t-reftable-merged: improve the test t_merged_single_record()
      t-reftable-merged: improve the const-correctness of helper functions
      t-reftable-merged: add tests for reftable_merged_table_max_update_index
      t-reftable-merged: use reftable_ref_record_equal to compare ref records
      t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
      reftable: remove unnecessary curly braces in reftable/pq.c
      reftable: change the type of array indices to 'size_t' in reftable/pq.c
      t: move reftable/pq_test.c to the unit testing framework
      t-reftable-pq: make merged_iter_pqueue_check() static
      t-reftable-pq: make merged_iter_pqueue_check() callable by reference
      t-reftable-pq: add test for index based comparison
      t-reftable-pq: add tests for merged_iter_pqueue_top()
      reftable: remove unnecessary curly braces in reftable/tree.c
      t: move reftable/tree_test.c to the unit testing framework
      t-reftable-tree: split test_tree() into two sub-test functions
      t-reftable-tree: add test for non-existent key
      t-reftable-tree: improve the test for infix_walk()
      t: move reftable/readwrite_test.c to the unit testing framework
      t-reftable-readwrite: use free_names() instead of a for loop
      t-reftable-readwrite: use 'for' in place of infinite 'while' loops
      t-reftable-readwrite: add test for known error
      t: move reftable/block_test.c to the unit testing framework
      t: harmonize t-reftable-block.c with coding guidelines
      t-reftable-block: release used block reader
      t-reftable-block: use reftable_record_equal() instead of check_str()
      t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
      t-reftable-block: use block_iter_reset() instead of block_iter_close()
      t-reftable-block: use xstrfmt() instead of xstrdup()
      t-reftable-block: remove unnecessary variable 'j'
      t-reftable-block: add tests for log blocks
      t-reftable-block: add tests for obj blocks
      t-reftable-block: add tests for index blocks
      t: move reftable/stack_test.c to the unit testing framework
      t: harmonize t-reftable-stack.c with coding guidelines
      t-reftable-stack: use Git's tempfile API instead of mkstemp()
      t-reftable-stack: use reftable_ref_record_equal() to compare ref records
      t-reftable-stack: add test for non-default compaction factor
      t-reftable-stack: add test for stack iterators

D Harithamma (2):
      convert: return early when not tracing
      exec_cmd: RUNTIME_PREFIX on z/OS systems

David Disseldorp (1):
      notes: do not trigger editor when adding an empty note

Derrick Stolee (11):
      commit-reach: add get_branch_base_for_tip
      commit: add gentle reference lookup method
      for-each-ref: add 'is-base' token
      p1500: add is-base performance tests
      diff-index: integrate with the sparse index
      scalar: add --no-tags option to 'scalar clone'
      advice: recommend GIT_ADVICE=0 for tools
      credential: add new interactive config option
      maintenance: add custom config to background jobs
      scalar: configure maintenance during 'reconfigure'
      sparse-checkout: disable advice in 'disable'

Emily Shaffer (1):
      Documentation: add platform support policy

Eric Sunshine (8):
      t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
      t4034: fix use of one-shot variable assignment with shell function
      check-non-portable-shell: loosen one-shot assignment error message
      check-non-portable-shell: suggest alternative for `VAR=val shell-func`
      check-non-portable-shell: improve `VAR=val shell-func` detection
      chainlint: don't be fooled by "?!...?!" in test body
      chainlint: make error messages self-explanatory
      chainlint: reduce annotation noise-factor

Ghanshyam Thakkar (3):
      t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
      t: migrate t0110-urlmatch-normalization to the new framework
      t: port helper/test-oid-array.c to unit-tests/t-oid-array.c

Jacob Keller (7):
      t9001-send-email.sh: fix quoting for mailrc --dump-aliases test
      t9001-send-email.sh: update alias list used for pine test
      send-email: teach git send-email option to translate aliases
      check-mailmap: accept "user@host" contacts
      check-mailmap: add options for additional mailmap sources
      send-email: add mailmap support via sendemail.mailmap and --mailmap
      send-email: document --mailmap and associated configuration

Jayson Rhynas (1):
      doc: fix hex code escapes in git-ls-files

Jeff King (87):
      credential/osxkeychain: respect NUL terminator in username
      apply: canonicalize modes read from patches
      midx: drop unused parameters from add_midx_to_chain()
      t4129: fix racy index when calling chmod after git-add
      refs: drop some unused parameters from create_symref_lock()
      pack-bitmap: load writer config from repository parameter
      pack-bitmap: drop unused parameters from select_pseudo_merges()
      ref-filter: drop unused parameters from email_atom_option_parser()
      diff-lib: drop unused index argument from get_stat_data()
      imap-send: mark unused parameter in ssl_socket_connect() fallback
      update-ref: mark more unused parameters in parser callbacks
      refs: mark unused parameters in ref_store fsck callbacks
      refs: mark unused parameters in do_for_each_reflog_helper()
      oss-fuzz: mark unused argv/argc argument
      t/helper: mark more unused argv/argc arguments
      unit-tests: ignore unused argc/argv
      reftable: ignore unused argc/argv in test functions
      reftable: drop obsolete test function declarations
      reftable: mark unused parameters in virtual functions
      t-hashmap: mark unused parameters in callback function
      test-mergesort: mark unused parameters in trivial callback
      setup: mark unused parameter in config callback
      daemon: mark unused parameters in non-posix fallbacks
      scalar: mark unused parameters in dummy function
      t-hashmap: stop calling setup() for t_intern() test
      gc: mark unused config parameter in virtual functions
      t-reftable-readwrite: mark unused parameter in callback function
      compat: disable -Wunused-parameter in 3rd-party code
      compat: disable -Wunused-parameter in win32/headless.c
      compat: mark unused parameters in win32/mingw functions
      config.mak.dev: enable -Wunused-parameter by default
      CodingGuidelines: mention -Wunused-parameter and UNUSED
      t-reftable-block: mark unused argv/argc
      reftable: mark unused parameters in empty iterator functions
      gc: drop MAYBE_UNUSED annotation from used parameter
      grep: prefer UNUSED to MAYBE_UNUSED for pcre allocators
      revision: free commit buffers for skipped commits
      drop trailing newline from warning/error/die messages
      sparse-checkout: consolidate cleanup when writing patterns
      sparse-checkout: check commit_lock_file when writing patterns
      sparse-checkout: use fdopen_lock_file() instead of xfdopen()
      t6300: drop newline from wrapped test title
      ref-filter: avoid extra copies of payload/signature
      ref-filter: strip signature when parsing tag trailers
      ref-filter: drop useless cast in trailers_atom_parser()
      ref-filter: store ref_trailer_buf data per-atom
      ref-filter: fix leak of %(trailers) "argbuf"
      ref-filter: fix leak with %(describe) arguments
      ref-filter: fix leak when formatting %(push:remoteref)
      ref-filter: add ref_format_clear() function
      ci: drop run-docker scripts
      ci: unify ubuntu and ubuntu32 dependencies
      ci: use more recent linux32 image
      ci: use regular action versions for linux32 job
      imap-send: handle NO_OPENSSL even when openssl exists
      t/interop: allow per-version make options
      Git.pm: fix bare repository search with Directory option
      Git.pm: use "rev-parse --absolute-git-dir" rather than perl code
      print an error when remote helpers die during capabilities
      git-jump: always specify column 1 for diff entries
      git-jump: ignore deleted files in diff mode
      t9001: use a more distinct fake BugID
      connect: clear child process before freeing in diagnostic mode
      fetch-pack: free object filter before exiting
      fetch-pack, send-pack: clean up shallow oid array
      commit: avoid leaking already-saved buffer
      send-pack: free cas options before exit
      transport-helper: fix strbuf leak in push_refs_with_push()
      fetch: free "raw" string when shrinking refspec
      fetch-pack: clear pack lockfiles list
      transport-helper: fix leak of dummy refs_list
      http: fix leak when redacting cookies from curl trace
      http: fix leak of http_object_request struct
      http: call git_inflate_end() when releasing http_object_request
      http: stop leaking buffer in http_get_info_packs()
      remote-curl: free HEAD ref with free_one_ref()
      http-walker: free fake packed_git list
      http-push: clear refspecs before exiting
      http-push: free repo->url string
      http-push: free curl header lists
      http-push: free transfer_request dest field
      http-push: free transfer_request strbuf
      http-push: free remote_ls_ctx.dentry_name
      http-push: free xml_ctx.cdata after use
      http-push: clean up objects list
      http-push: clean up loose request when falling back to packed
      http-push: clean up local_refs at exit

Johannes Schindelin (9):
      ci: bump microsoft/setup-msbuild from v1 to v2
      ci(win+VS): download the vcpkg artifacts using a dedicated GitHub Action
      clar: avoid compile error with mingw-w64
      clar(win32): avoid compile error due to unused `fs_copy()`
      clar: stop including `shellapi.h` unnecessarily
      clar: add CMake support
      cmake: rename clar-related variables to avoid confusion
      cmake: stop looking for `REFTABLE_TEST_OBJS` in the Makefile
      cmake: generalize the handling of the `UNIT_TEST_OBJS` list

John Cai (7):
      refs: keep track of unresolved reference value in iterators
      refs: add referent to each_ref_fn
      ref-filter: populate symref from iterator
      builtin: add a repository parameter for builtin functions
      builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
      builtin: remove USE_THE_REPOSITORY for those without the_repository
      add: pass in repo variable instead of global the_repository

Josh Steadmon (2):
      trace2: implement trace2_printf() for event target
      fetch: add top-level trace2 regions

Junio C Hamano (69):
      checkout: special case error messages during noop switching
      doc: note that AT&T ksh does not work with our test suite
      Revert "reflog expire: don't use lookup_commit_reference_gently()"
      howto-maintain: cover a whole development cycle
      howto-maintain: update daily tasks
      CodingGuidelines: document a shell that "fails" "VAR=VAL shell_func"
      ReviewingGuidelines: encourage positive reviews more
      doc: difference in location to apply is "offset", not "fuzz"
      mailmap: plug memory leak in read_mailmap_blob()
      csum-file: introduce discard_hashfile()
      t4204: patch-id supports various input format
      patch-id: call flush_current_id() only when needed
      patch-id: make get_one_patchid() more extensible
      patch-id: rewrite code that detects the beginning of a patch
      patch-id: tighten code to detect the patch header
      safe.directory: preliminary clean-up
      safe.directory: normalize the checked path
      safe.directory: normalize the configured path
      safe.directory: setting safe.directory="." allows the "current" directory
      Start the 2.47 cycle
      The second batch
      t0018: remove leftover debugging cruft
      t3206: test_when_finished before dirtying operations, not after
      transport: fix leak with transport helper URLs
      The third batch
      tests: drop use of 'tee' that hides exit status
      tutorial: grammofix
      doc: grammofix in git-diff-tree
      remerge-diff: lazily prepare temporary objdir on demand
      remerge-diff: clean up temporary objdir at a central place
      The fourth batch
      howto-maintain: mention preformatted docs
      The fifth batch
      Prepare for 2.46.1
      The sixth batch
      CodingGuidelines: spaces around C operators
      mailinfo: we parse fixed headers
      The seventh batch
      The eighth batch
      A bit more topics for 2.46.x maintenance track
      The ninth batch
      git-config.1: --get-all description update
      git-config.1: fix description of --regexp in synopsis
      The tenth batch
      The eleventh batch
      CodingGuidelines: also mention MAYBE_UNUSED
      refs/files-backend: work around -Wunused-parameter
      The twelfth batch
      The thirteenth batch
      doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch
      ci: remove 'Upload failed tests' directories' step from linux32 jobs
      The fourteenth batch
      Another batch of topics for 2.46.1
      The fifteenth batch
      t5512.40 sometimes dies by SIGPIPE
      Git 2.46.1
      The sixteenth batch
      The seventeenth batch
      Revert "Merge branch 'jc/patch-id' into maint-2.46"
      Start preparing for Git 2.46.2
      ci updates
      The eighteenth batch
      The 19th batch
      Git 2.46.2
      The 20th batch
      The 21st batch
      Git 2.47-rc0
      another batch after 2.47-rc0
      Git 2.47-rc1

Justin Tobler (1):
      doc: clarify post-receive hook behavior

Karthik Nayak (6):
      clang-format: indent preprocessor directives after hash
      clang-format: avoid spacing around bitfield colon
      clang-format: formalize some of the spacing rules
      ci: run style check on GitHub and GitLab
      check-whitespace: detect if no base_commit is provided
      ci/style-check: add `RemoveBracesLLVM` in CI job

Kevin Lyles (2):
      t1092: allow run_on_* functions to use standard input
      builtin/cat-file: mark 'git cat-file' sparse-index compatible

Kousik Sanagavarapu (1):
      unit-tests/test-lib: fix typo in check_pointer_eq() description

Kyle Lippincott (2):
      set errno=0 before strtoX calls
      t6421: fix test to work when repo dir contains d0

Martin Ågren (2):
      t1517: add missing LIBCURL prereq
      t0211: add missing LIBCURL prereq

Matheus Tavares (1):
      rebase --exec: respect --quiet

Patrick Steinhardt (267):
      refs: stop using `the_repository`
      refs/files: stop using `the_repository` in `parse_loose_ref_contents()`
      refs/files: stop using `the_repository`
      refs/packed: stop using `the_repository`
      refs/reftable: stop using `the_repository`
      clang-format: fix indentation width for preprocessor directives
      Documentation: clarify indentation style for C preprocessor directives
      Documentation: document naming schema for structs and their functions
      Documentation: document idiomatic function names
      Documentation: consistently use spaces inside initializers
      t98xx: fix Perforce tests with p4d r23 and newer
      ci: update Perforce version to r23.2
      t98xx: mark Perforce tests as memory-leak free
      builtin/replay: plug leaking `advance_name` variable
      builtin/log: fix leaking branch name when creating cover letters
      builtin/describe: fix memory leak with `--contains=`
      builtin/describe: fix leaking array when running diff-index
      builtin/describe: fix trivial memory leak when describing blob
      builtin/name-rev: fix various trivial memory leaks
      builtin/submodule--helper: fix leaking clone depth parameter
      builtin/submodule--helper: fix leaking buffer in `is_tip_reachable`
      builtin/ls-remote: fix leaking `pattern` strings
      builtin/remote: fix leaking strings in `branch_list`
      builtin/remote: fix various trivial memory leaks
      builtin/stash: fix various trivial memory leaks
      builtin/rev-parse: fix memory leak with `--parseopt`
      builtin/show-branch: fix several memory leaks
      builtin/credential-store: fix leaking credential
      builtin/rerere: fix various trivial memory leaks
      builtin/shortlog: fix various trivial memory leaks
      builtin/worktree: fix leaking derived branch names
      builtin/credential-cache: fix trivial leaks
      t/test-repository: fix leaking repository
      object-name: fix leaking commit list items
      entry: fix leaking pathnames during delayed checkout
      convert: fix leaking config strings
      commit-reach: fix trivial memory leak when computing reachability
      builtin/ls-remote: fall back to SHA1 outside of a repo
      refs: drop `ref_store`-less functions
      transport: mark more tests leak-free
      git-submodule.sh: break overly long command lines
      builtin/submodule: allow cloning with different ref storage format
      builtin/clone: propagate ref storage format to submodules
      refs: fix ref storage format for submodule ref stores
      builtin/submodule: allow "add" to use different ref storage format
      submodule: fix leaking fetch tasks
      submodule: fix leaking seen submodule names
      object: fix leaking packfiles when closing object store
      reftable/stack: refactor function to gather table sizes
      reftable/stack: extract function to setup stack with N tables
      reftable/stack: test compaction with already-locked tables
      reftable/stack: update stats on failed full compaction
      reftable/stack: simplify tracking of table locks
      reftable/stack: do not die when fsyncing lock file files
      reftable/stack: use lock_file when adding table to "tables.list"
      reftable/stack: fix corruption on concurrent compaction
      reftable/stack: handle locked tables during auto-compaction
      path: expose `do_git_path()` as `repo_git_pathv()`
      path: expose `do_git_common_path()` as `repo_common_pathv()`
      editor: do not rely on `the_repository` for interactive edits
      hooks: remove implicit dependency on `the_repository`
      path: stop relying on `the_repository` when reporting garbage
      path: stop relying on `the_repository` in `worktree_git_path()`
      path: hide functions using `the_repository` by default
      config: introduce missing setters that take repo as parameter
      config: expose `repo_config_clear()`
      config: pass repo to `git_config_get_index_threads()`
      config: pass repo to `git_config_get_split_index()`
      config: pass repo to `git_config_get_max_percent_split_change()`
      config: pass repo to `git_config_get_expiry()`
      config: pass repo to `git_config_get_expiry_in_days()`
      config: pass repo to `git_die_config()`
      config: pass repo to functions that rename or copy sections
      config: don't have setters depend on `the_repository`
      config: don't depend on `the_repository` with branch conditions
      global: prepare for hiding away repo-less config functions
      config: hide functions using `the_repository` by default
      builtin/bundle: have unbundle check for repo before opening its bundle
      bundle: default to SHA1 when reading bundle headers
      remote: plug memory leak when aliasing URLs
      git: fix leaking system paths
      object-file: fix memory leak when reading corrupted headers
      object-name: fix leaking symlink paths in object context
      bulk-checkin: fix leaking state TODO
      read-cache: fix leaking hashfile when writing index fails
      submodule-config: fix leaking name entry when traversing submodules
      config: fix leaking comment character config
      builtin/rebase: fix leaking `commit.gpgsign` value
      builtin/notes: fix leaking `struct notes_tree` when merging notes
      builtin/fast-import: plug trivial memory leaks
      builtin/fast-export: fix leaking diff options
      builtin/fast-export: plug leaking tag names
      merge-ort: unconditionally release attributes index
      sequencer: release todo list on error paths
      unpack-trees: clear index when not propagating it
      diff: fix leak when parsing invalid ignore regex option
      builtin/format-patch: fix various trivial memory leaks
      userdiff: fix leaking memory for configured diff drivers
      builtin/log: fix leak when showing converted blob contents
      diff: free state populated via options
      builtin/diff: free symmetric diff members
      config: fix constness of out parameter for `git_config_get_expiry()`
      builtin/gc: refactor to read config into structure
      builtin/gc: fix leaking config values
      builtin/gc: stop processing log file on signal
      builtin/gc: add a `--detach` flag
      builtin/maintenance: add a `--detach` flag
      run-command: fix detaching when running auto maintenance
      builtin/stash: fix `--keep-index --include-untracked` with empty HEAD
      t0001: exercise initialization with ref formats more thoroughly
      t0001: delete repositories when object format tests finish
      setup: merge configuration of repository formats
      setup: make object format configurable via config
      setup: make ref storage format configurable via config
      t7900: fix flaky test due to leaking background job
      t7900: exercise detaching via trace2 regions
      builtin/maintenance: fix loose objects task emitting pack hash
      reftable/merged: expose functions to initialize iterators
      reftable/merged: rename `reftable_new_merged_table()`
      reftable/merged: stop using generic tables in the merged table
      reftable/stack: open-code reading refs
      reftable/iter: drop double-checking logic
      reftable/generic: move generic iterator code into iterator interface
      reftable/dump: drop unused `compact_stack()`
      t/helper: inline `reftable_dump_main()`
      t/helper: inline `reftable_reader_print_file()`
      t/helper: inline `reftable_stack_print_directory()`
      t/helper: inline `reftable_table_print()`
      t/helper: inline printing of reftable records
      t/helper: use `hash_to_hex_algop()` to print hashes
      t/helper: refactor to not use `struct reftable_table`
      reftable/generic: drop interface
      mailinfo: fix leaking header data
      convert: fix leaks when resetting attributes
      pretty: fix memory leaks when parsing pretty formats
      pretty: fix leaking key/value separator buffer
      builtin/merge-tree: fix leaking `-X` strategy options
      builtin/upload-archive: fix leaking args passed to `write_archive()`
      builtin/archive: fix leaking `OPT_FILENAME()` value
      midx-write: fix leaking hashfile on error cases
      builtin/repack: fix leaks when computing packs to repack
      t/helper: fix leaking multi-pack-indices in "read-midx"
      transport: fix leaking OID arrays in git:// transport data
      builtin/send-pack: fix leaking refspecs
      sideband: fix leaks when configuring sideband colors
      builtin/fetch-pack: fix leaking refs
      remote: fix leaking config strings
      remote: fix leaks when matching refspecs
      remote: fix leaking peer ref when expanding refmap
      builtin/fetch: fix leaking transaction with `--atomic`
      transport: fix leaking arguments when fetching from bundle
      transport: fix leaking negotiation tips
      reftable/blocksource: drop malloc block source
      reftable/stack: inline `stack_compact_range_stats()`
      reftable/reader: rename `reftable_new_reader()`
      reftable/reader: inline `init_reader()`
      reftable/reader: inline `reader_close()`
      reftable/stack: fix broken refnames in `write_n_ref_tables()`
      reftable/reader: introduce refcounting
      reftable/reader: keep readers alive during iteration
      reftable/stack: reorder swapping in the reloaded stack contents
      reftable/stack: fix segfault when reload with reused readers fails
      Documentation/BreakingChanges: announce removal of git-pack-redundant(1)
      builtin/index-pack: fix segfaults when running outside of a repo
      wrapper: introduce `log2u()`
      t0601: merge tests for auto-packing of refs
      refs/files: use heuristic to decide whether to repack with `--auto`
      t: do not pass GIT_TEST_OPTS to unit tests with prove
      t: import the clar unit testing framework
      t/clar: fix compatibility with NonStop
      Makefile: fix sparse dependency on GENERATED_H
      Makefile: make hdr-check depend on generated headers
      Makefile: do not use sparse on third-party sources
      Makefile: wire up the clar unit testing framework
      t/unit-tests: implement test driver
      t/unit-tests: convert strvec tests to use clar
      t/unit-tests: convert ctype tests to use clar
      t/test-lib: allow skipping leak checks for passing tests
      fetch-pack: fix memory leaks on fetch negotiation
      send-pack: fix leaking common object IDs
      builtin/push: fix leaking refspec query result
      upload-pack: fix leaking child process data on reachability checks
      submodule: fix leaking fetch task data
      builtin/submodule--helper: fix leaking refs on push-check
      remote: fix leaking tracking refs
      remote: fix leak in reachability check of a remote-tracking ref
      send-pack: fix leaking push cert nonce
      gpg-interface: fix misdesigned signing key interfaces
      object: clear grafts when clearing parsed object pool
      shallow: free grafts when unregistering them
      shallow: fix leaking members of `struct shallow_info`
      negotiator/skipping: fix leaking commit entries
      builtin/repack: fix leaking line buffer when packing promisors
      builtin/pack-objects: plug leaking list of keep-packs
      builtin/grep: fix leaking object context
      builtin/fmt-merge-msg: fix leaking buffers
      match-trees: fix leaking prefixes in `shift_tree()`
      merge-ort: fix two leaks when handling directory rename modifications
      builtin/repack: fix leaking keep-pack list
      ref-filter: fix leak with unterminated %(if) atoms
      Makefile: rename clar-related variables to avoid confusion
      environment: make `get_git_dir()` accept a repository
      environment: make `get_git_common_dir()` accept a repository
      environment: make `get_object_directory()` accept a repository
      environment: make `get_index_file()` accept a repository
      environment: make `get_graft_file()` accept a repository
      environment: make `get_git_work_tree()` accept a repository
      config: document `read_early_config()` and `read_very_early_config()`
      config: make dependency on repo in `read_early_config()` explicit
      environment: move object database functions into object layer
      environment: make `get_git_namespace()` self-contained
      environment: move `set_git_dir()` and related into setup layer
      environment: reorder header to split out `the_repository`-free section
      environment: guard state depending on a repository
      repo-settings: split out declarations into a standalone header
      repo-settings: track defaults close to `struct repo_settings`
      branch: stop modifying `log_all_ref_updates` variable
      refs: stop modifying global `log_all_ref_updates` variable
      environment: stop storing "core.logAllRefUpdates" globally
      environment: stop storing "core.preferSymlinkRefs" globally
      environment: stop storing "core.warnAmbiguousRefs" globally
      environment: stop storing "core.notesRef" globally
      ci: add Ubuntu 16.04 job to GitLab CI
      refs: properly apply exclude patterns to namespaced refs
      builtin/receive-pack: fix exclude patterns when announcing refs
      Makefile: stop listing test library objects twice
      t/unit-tests: introduce reftable library
      reftable/reader: make table iterator reseekable
      refs/reftable: wire up support for exclude patterns
      apply: reorder functions to move image-related things together
      apply: rename functions operating on `struct image`
      apply: introduce macro and function to init images
      apply: refactor code to drop `line_allocated`
      apply: rename members that track line count and allocation length
      apply: refactor `struct image` to use a `struct strbuf`
      gitlab-ci: upgrade machine type of Linux runners
      t1305: exercise edge cases of "onbranch" includes
      config: fix evaluating "onbranch" with nonexistent git dir
      refs/reftable: introduce "reftable.lockTimeout"
      reftable/stack: allow locking of outdated stacks
      refs/reftable: reload locked stack when preparing transaction
      http-fetch: clear leaking git-index-pack(1) arguments
      shallow: fix leak when unregistering last shallow root
      fetch-pack: fix leaking sought refs
      builtin/help: fix dangling reference to `html_path`
      builtin/help: fix leaking `html_path` when reading config multiple times
      git: fix leaking argv when handling builtins
      submodule: fix leaking update strategy
      builtin/submodule--helper: clear child process when not running it
      builtin/submodule--helper: fix leaking error buffer
      t/helper: fix leaking subrepo in nested submodule config helper
      builtin/submodule--helper: fix leaking remote ref on errors
      dir: fix off by one errors for ignored and untracked entries
      builtin/pull: fix leaking "ff" option
      diff: fix leaking orderfile option
      parse-options: free previous value of `OPTION_FILENAME`
      diffcore-order: fix leaking buffer when parsing orderfiles
      builtin/repack: fix leaking configuration
      builtin/difftool: plug several trivial memory leaks
      trace2: destroy context stored in thread-local storage
      submodule: fix leaking submodule ODB paths
      grep: fix leaking grep pattern
      promisor-remote: fix leaking partial clone filter
      builtin/maintenance: fix leaking config string
      builtin/maintenance: fix leak in `get_schedule_cmd()`
      revision: fix leaking parents when simplifying commits
      diffcore-break: fix leaking filespecs when merging broken pairs

Phillip Wood (4):
      add-patch: handle splitting hunks with diff.suppressBlankEmpty
      add-patch: use normalize_marker() when recounting edited hunk
      rebase: apply and cleanup autostash when rebase fails to start
      submodule status: propagate SIGPIPE

Ramsay Jones (4):
      Makefile: drop -Wno-universal-initializer from SP_EXTRA_FLAGS
      config.mak.uname: remove unused uname_P variable
      compat/terminal: mark parameter of git_terminal_prompt() UNUSED
      config.mak.uname: add HAVE_DEV_TTY to cygwin config section

René Scharfe (18):
      t-strvec: use test_msg()
      t-strvec: improve check_strvec() output
      t-strvec: fix type mismatch in check_strvec
      grep: -W: skip trailing empty lines at EOF, too
      t-example-decorate: remove test messages
      t0080: use here-doc test body
      unit-tests: show location of checks outside of tests
      unit-tests: add if_test
      t-ctype: use if_test
      t-reftable-basics: use if_test
      t-strvec: use if_test
      log-tree: use decimal_width()
      remote: plug memory leaks at early returns
      diff: report copies and renames as changes in run_diff_cmd()
      diff: report dirty submodules as changes in builtin_diff()
      diff: report modified binary files as changes in builtin_diff()
      archive: load index before pathspec checks
      commit-graph: remove unnecessary UNLEAK

Rubén Justo (4):
      add-patch: test for 'p' command
      pager: do not close fd 2 unnecessarily
      pager: introduce wait_for_pager
      add-patch: render hunks through the pager

Ryan Hendrickson (1):
      http: do not ignore proxy path

Stephen P. Smith (1):
      .mailmap document current address.

Sven Strickroth (1):
      refs/files: prevent memory leak by freeing packed_ref_store

Taylor Blau (42):
      config.c: avoid segfault with --fixed-value and valueless config
      t/t7704-repack-cruft.sh: avoid failures during long-running tests
      Documentation: describe incremental MIDX format
      midx: add new fields for incremental MIDX chains
      midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
      midx: teach `prepare_midx_pack()` about incremental MIDXs
      midx: teach `nth_midxed_object_oid()` about incremental MIDXs
      midx: teach `nth_bitmapped_pack()` about incremental MIDXs
      midx: introduce `bsearch_one_midx()`
      midx: teach `bsearch_midx()` about incremental MIDXs
      midx: teach `nth_midxed_offset()` about incremental MIDXs
      midx: teach `fill_midx_entry()` about incremental MIDXs
      midx: remove unused `midx_locate_pack()`
      midx: teach `midx_contains_pack()` about incremental MIDXs
      midx: teach `midx_preferred_pack()` about incremental MIDXs
      midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
      midx: support reading incremental MIDX chains
      midx: implement verification support for incremental MIDXs
      t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
      t/t5313-pack-bounds-checks.sh: prepare for sub-directories
      midx: implement support for writing incremental MIDX chains
      pack-bitmap: initialize `bitmap_writer_init()` with packing_data
      pack-bitmap: drop redundant args from `bitmap_writer_build_type_index()`
      pack-bitmap: drop redundant args from `bitmap_writer_build()`
      pack-bitmap: drop redundant args from `bitmap_writer_finish()`
      pack-bitmap-write.c: select pseudo-merges even for small bitmaps
      t/t5333-pseudo-merge-bitmaps.sh: demonstrate empty pseudo-merge groups
      pseudo-merge.c: do not generate empty pseudo-merge commits
      pseudo-merge.c: ensure pseudo-merge groups are closed
      t/t5332-multi-pack-reuse.sh: verify pack generation with --strict
      pack-bitmap: tag bitmapped packs with their corresponding MIDX
      builtin/pack-objects.c: translate bit positions during pack-reuse
      pack-bitmap.c: avoid repeated `pack_pos_to_offset()` during reuse
      builtin/pack-objects.c: do not open-code `MAX_PACK_OBJECT_HEADER`
      finalize_object_file(): check for name collision before renaming
      finalize_object_file(): refactor unlink_or_warn() placement
      finalize_object_file(): implement collision check
      pack-objects: use finalize_object_file() to rename pack/idx/etc
      sha1: do not redefine `platform_SHA_CTX` and friends
      hash.h: scaffolding for _unsafe hashing variants
      Makefile: allow specifying a SHA-1 for non-cryptographic uses
      csum-file.c: use unsafe SHA-1 implementation when available

Tomas Nordin (1):
      doc: remove dangling closing parenthesis

Xing Xin (1):
      diff-tree: fix crash when used with --remerge-diff

ahmed akef (1):
      docs: explain the order of output in the batched mode of git-cat-file(1)

shejialuo (9):
      fsck: rename "skiplist" to "skip_oids"
      fsck: rename objects-related fsck error functions
      fsck: make "fsck_error" callback generic
      fsck: add a unified interface for reporting fsck messages
      fsck: add refs report function
      refs: set up ref consistency check infrastructure
      builtin/refs: add verify subcommand
      files-backend: add unified interface for refs scanning
      fsck: add ref name check for files backend


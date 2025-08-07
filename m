Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D01E2823;
	Thu,  7 Aug 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586435; cv=none; b=beEGaq7canFWIUFvallNkSm21lPUeOyeah6xlbVeEW4e4jPrBSvShJTHw/pFjxe4HOL9dSPtKmhDTRuHMCpKx426R2o0W32UcHEDXygxSD5L9400ueYeV4pejd8gLLAJZRVknTFT0f842iAcf2NV65QrjZ0ceFZyfepIcQujAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586435; c=relaxed/simple;
	bh=cVhj4R/FTDUwbyvZzdmeCJUK3RsZo2cvoIdmjECEkcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEtybUMEFsgbhF7A/hTo/NR8pA9FaGdemu9/gx9PrgDCaTmgZxuqrm3MKcPzMyLFOt9gwGxldQmeVC1ivXTsmNliSdlY1FBxygxLy7MphGqf8fac5CFSMdwipryaXOxQRV/QvW8ILT3SEP6FpH8SujkgJsYAYMtOjJSpdDSXMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EAM10SxR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OmguKJEa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EAM10SxR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OmguKJEa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 074DD1D0023E;
	Thu,  7 Aug 2025 13:07:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 07 Aug 2025 13:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1754586430; x=1754672830; bh=vF
	0djwoJ8KQowJWgnbSi1sPDUj04GVaRRL7zAEEZLUU=; b=EAM10SxR2zHh4P1W5w
	G5jUtccK8LqZxIdE+nKca3sT04qEe3cE6WDhtsApG2LhN8mFhy+jnY1pQVWni5YF
	ahSQ0AUgeX8nBoc/0IiqyGGrn3n4BNlSqMMhDAVPo9Ig/EyYRcex4D5onWfeu40/
	mN/2/gdoFqa1dqa+rX+fyYRXw7H8JKtBZoMaGQGLMfEwQMZNXIhaQ2NW+P4/jMAo
	ARIj5NqWivXgc+/4uoUlPfpQORZ0dwwBiFy6AAEgxNjoCw4a2DwV6Gil8AeIbmfA
	sNvXlp1XHEpNY9J2kueh5xhhrmvu3HFkh5ADvl9ZkQtCELGmB35u+8ZBfnJ1kn60
	BatQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754586430; x=1754672830; bh=vF0djwoJ8KQowJWgnbSi1sPDUj04
	GVaRRL7zAEEZLUU=; b=OmguKJEaxp+F4NlXBJxY7AcsKChKbw6q0ngNoHmv11Uv
	ndj2KGG8on752IObPfPOdGDAeQeZdb6WIpqcKKHqfxScoQhyGVZlQF+VzTugOFPr
	Xzk3Y6TEIS1xhbHTXgss2uBoZ6izWTLkJfPJC+9HyeLYXmCpPYEbZDhbAFPFbJJb
	aCB9UF0lJagIX3wsetJlP+CUSE/ZkVzvBsQHrbaF7fsna5V+W7pCZl6PwXb+lcy8
	mKCZxlthOv2MizD15M3WWZYpqFy6Pim+Eob+7ufJuuSeHMY36Z1GXFiGshpaTc5d
	llxFBHuwA6+lfuGm8hu7R17hWp42vq76dBWyv/sSRA==
X-ME-Sender: <xms:Pt2UaDHfWr-YOWcqCGVPcv27QnML00VfMEsAgbTLKn8nwywgJc--jw>
    <xme:Pt2UaNfKeJKWEu72jueLgtYH0MxENAinvwYC4L_HK_erprM5vfT0KF96XNIvjO_Pz
    wsv8mMhU1w-gOOvCQ>
X-ME-Received: <xmr:Pt2UaELh21f0c5qPOTsn34rbwPZnWj8cmeJwIoN-KbFOCBHIlvCPvbMYq7044ir8Ph8fGJMIAp0o_nIrz1Ne9kHnMjpv_iGTmSrZ9UY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgffekgeeifeeihfelueeklefhgfekleehhedtieeghfejffejffdthfejheeu
    heenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvghsohhurhgtvgdrtg
    homhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgv
    rhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehlfihnsehlfihnrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Pt2UaCF9ETBNOzrc6CXQZ0PJs7weL_uDm_F2TCsJ1I-jm55lKSQTcw>
    <xmx:Pt2UaHAuux0LE8S6czMFXihEZPYASpu9a_rrsbJhdV4CwNsjRrSPoA>
    <xmx:Pt2UaF_Abgw70avhyXzsbDjE0i8pQIimFWIE5WCHbFsEQY4DTENPlw>
    <xmx:Pt2UaDCyfmmIBQ_iDIc92LrXsjLKnPtTqHGkZF5qayVNUIKR4s1zvg>
    <xmx:Pt2UaH935HNNc3AkHbdyhbnpS7FaSJoqQMFBSHEz6osO6AqgU1aB2k0g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 13:07:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.51.0-rc1
Date: Thu, 07 Aug 2025 10:07:08 -0700
Message-ID: <xmqqikizoybn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A release candidate Git v2.51.0-rc1 is now available for testing at
the usual places.  It is comprised of 542 non-merge commits since
v2.50.0, contributed by 81 people, 22 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.51.0-rc1' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.50.0 are as follows.
Welcome to the Git development community!

  Brett A C Sheffield, chenjianhu, David Leadbeater, Gareth
  Fenn, Hoyoung Lee, Ilya Grigoriev, irecca.kun@gmail.com,
  Isabella Caselli, Jakub Ječmínek, Jan Mazur, Jinyao Guo,
  Jonas Brandstötter, Jörg Thalheim, Leon Michalak, Patrick
  Steinhardt' via Git Security, Patrik Weiskircher, redoste,
  Rodrigo Michelassi, Russell Hanneken, Ryan Hodges, Timur
  Sultanaev, and Vasilii Iakliushin.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Aditya Garg, Alexander Shopov, Avi Halachmi (:avih), Ayush
  Chandekar, Brad Smith, brian m. carlson, Carlo Marcelo Arenas
  Belón, Christian Couder, Collin Funk, Denton Liu, Derrick
  Stolee, Elijah Newren, Eric Sunshine, Ghanshyam Thakkar, Han
  Young, Jacob Keller, Jean-Noël Avila, Jeff King, Johannes
  Schindelin, Johannes Sixt, Jouke Witteveen, Junio C Hamano,
  Justin Tobler, Karthik Nayak, Kevin Brodsky, K Jayatheerth,
  Kristoffer Haugsbakk, Kyle Lippincott, Lidong Yan, Lucas Seiki
  Oshiro, Mark Levedahl, Martin Ågren, Martin Storsjö, Matthias
  Aßhauer, Maxim Cournoyer, Michael Rappazzo, Orgad Shaneh,
  Ori Avtalion, Oswald Buddenhagen, Øystein Walle, Patrick
  Steinhardt, Phil Hord, Phillip Wood, Ramsay Jones, Raymond
  E. Pasco, Renato Botelho, René Scharfe, Rodrigo Carvalho,
  Sebastian Andrzej Siewior, Seyi Kuforiji, shejialuo, Siddharth
  Asthana, Stan Hu, SZEDER Gábor, Takashi Iwai, Taylor Blau,
  Todd Zullinger, Toon Claes, and Victoria Dye.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.51 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * Userdiff patterns for the R language have been added.

 * Documentation for "git send-email" has been updated with a bit more
   credential helper and OAuth information.

 * "git cat-file --batch" learns to understand %(objectmode) atom to
   allow the caller to tell missing objects (due to repository
   corruption) and submodules (whose commit objects are OK to be
   missing) apart.

 * "git diff --no-index dirA dirB" can limit the comparison with
   pathspec at the end of the command line, just like normal "git
   diff".

 * "git subtree" (in contrib/) learned to grok GPG signing its commits.

 * "git whatchanged" that is longer to type than "git log --raw"
   which is its modern rough equivalent has outlived its usefulness
   more than 10 years ago.  Plan to deprecate and remove it.

 * An interchange format for stash entries is defined, and subcommand
   of "git stash" to import/export has been added.

 * "git merge/pull" has been taught the "--compact-summary" option to
   use the compact-summary format, intead of diffstat, when showing
   the summary of the incoming changes.

 * "git imap-send" has been broken for a long time, which has been
   resurrected and then taught to talk OAuth2.0 etc.

 * Some error messages from "git imap-send" has been updated.

 * When "git daemon" sees a signal while attempting to accept() a new
   client, instead of retrying, it skipped it by mistake, which has
   been corrected.

 * The reftable ref backend has matured enough; Git 3.0 will make it
   the default format in a newly created repositories by default.

 * "netrc" credential helper has been improved to understand textual
   service names (like smtp) in addition to the numeric port numbers
   (like 25).

 * Lift the limitation to use changed-path filter in "git log" so that
   it can be used for a pathspec with multiple literal paths.

 * Clean up the way how signature on commit objects are exported to
   and imported from fast-import stream.

 * Remove unsupported, unused, and unsupportable old option from "git
   log".

 * Document recently added "git imap-send --list" with an example.

 * "git pull" learned to pay attention to pull.autostash configuration
   variable, which overrides rebase/merge.autostash.

 * "git for-each-ref" learns "--start-after" option to help
   applications that want to page its output.

 * "git switch" and "git restore" are declared to be no longer
   experimental.

 * "git -c alias.foo=bar foo -h baz" reported "'foo' is aliased to
   'bar'" and then went on to run "git foo -h baz", which was
   unexpected.  Tighten the rule so that alias expansion is reported
   only when "-h" is the sole option.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * "git pack-objects" learned to find delta bases from blobs at the
   same path, using the --path-walk API.

 * CodingGuidelines update.

 * Add settings for Solaris 10 & 11.

 * Meson-based build/test framework now understands TAP output
   generated by our tests.

 * "Do not explicitly initialize to zero" rule has been clarified in
   the CodingGuidelines document.

 * A test helper "test_seq" function learned the "-f <fmt>" option,
   which allowed us to simplify a lot of test scripts.

 * A lot of stale stuff has been removed from the contrib/ hierarchy.

 * "git push" and "git fetch" are taught to update refs in batches to
   gain performance.

 * Some code paths in "git prune" used to ignore the passed-in
   repository object and used the `the_repository` singleton instance
   instead, which has been corrected.

 * Update ".clang-format" and ".editorconfig" to match our style guide
   a bit better.

 * "make coccicheck" succeeds even when spatch made suggestions, which
   has been updated to fail in such a case.

 * Code clean-up around object access API.

 * Define .precision to more canned parse-options type to avoid bugs
   coming from using a variable with a wrong type to capture the
   parsed values.

 * Flipping the default hash function to SHA-256 at Git 3.0 boundary
   is planned.

 * Declare weather-balloon we raised for "bool" type 18 months ago a
   success and officially allow using the type in our codebase.

 * GIT_TEST_INSTALLED was not honored in the recent topic related to
   SHA256 hashes, which has been corrected.

 * The pop_most_recent_commit() function can have quite expensive
   worst case performance characteristics, which has been optimized by
   using prio-queue data structure.

 * Move structure definition from unrelated header file to where it
   belongs.

 * To help our developers, document what C99 language features are
   being considered for adoption, in addition to what past experiments
   have already decided.

 * The reftable unit tests are now ported to the "clar" unit testing
   framework.

 * Redefine where the multi-pack-index sits in the object subsystem,
   which recently was restructured to allow multiple backends that
   support a single object source that belongs to one repository.  A
   MIDX does span multiple "object sources".

 * Reduce implicit assumption and dependence on the_repository in the
   object-file subsystem.


Fixes since v2.50
-----------------

Unless otherwise noted, all the changes in 2.50.X maintenance track,
including security updates, are included in this release.

 * A memory-leak in an error code path has been plugged.
   (merge 7082da85cb ly/commit-graph-graph-write-leakfix later to maint).

 * A memory-leak in an error code path has been plugged.
   (merge aedebdb6b9 ly/fetch-pack-leakfix later to maint).

 * Some leftover references to documentation source files that no
   longer exist, due to recent ".txt" -> ".adoc" renaming, have been
   corrected.
   (merge 3717a5775a jw/doc-txt-to-adoc-refs later to maint).

 * "git stash -p <pathspec>" improvements.
   (merge 468817bab2 pw/stash-p-pathspec-fixes later to maint).

 * "git send-email" incremented its internal message counter when a
   message was edited, which made logic that treats the first message
   specially misbehave, which has been corrected.
   (merge 2cc27b3501 ag/send-email-edit-threading-fix later to maint).

 * "git stash" recorded a wrong branch name when submodules are
   present in the current checkout, which has been corrected.
   (merge ffb36c64f2 kj/stash-onbranch-submodule-fix later to maint).

 * When asking to apply mailmap to both author and committer field
   while showing a commit object, the field that appears later was not
   correctly parsed and replaced, which has been corrected.
   (merge abf94a283f sa/multi-mailmap-fix later to maint).

 * "git maintenance" lacked the care "git gc" had to avoid holding
   onto the repository lock for too long during packing refs, which
   has been remedied.
   (merge 1b5074e614 ps/maintenance-ref-lock later to maint).

 * Avoid regexp_constraint and instead use comparison_constraint when
   listing functions to exclude from application of coccinelle rules,
   as spatch can be built with different regexp engine X-<.
   (merge f2ad545813 jc/cocci-avoid-regexp-constraint later to maint).

 * Updating submodules from the upstream did not work well when
   submodule's HEAD is detached, which has been improved.
   (merge ca62f524c1 jk/submodule-remote-lookup-cleanup later to maint).

 * Remove unnecessary check from "git daemon" code.
   (merge 0c856224d2 cb/daemon-fd-check-fix later to maint).

 * Use of sysctl() system call to learn the total RAM size used on
   BSDs has been corrected.
   (merge 781c1cf571 cb/total-ram-bsd-fix later to maint).

 * Drop FreeBSD 4 support and declare that we support only FreeBSD 12
   or later, which has memmem() supported.
   (merge 0392f976a7 bs/config-mak-freebsd later to maint).

 * A diff-filter with negative-only specification like "git log
   --diff-filter=d" did not trigger correctly, which has been fixed.
   (merge 375ac087c5 jk/all-negative-diff-filter-fix later to maint).

 * A failure to open the index file for writing due to conflicting
   access did not state what went wrong, which has been corrected.
   (merge 9455397a5c hy/read-cache-lock-error-fix later to maint).

 * Tempfile removal fix in the codepath to sign commits with SSH keys.
   (merge 4498127b04 re/ssh-sign-buffer-fix later to maint).

 * Code and test clean-up around string-list API.
   (merge 6e5b26c3ff sj/string-list later to maint).

 * "git apply -N" should start from the current index and register
   only new files, but it instead started from an empty index, which
   has been corrected.
   (merge 2b49d97fcb rp/apply-intent-to-add-fix later to maint).

 * Leakfix with a new and a bit invasive test on pack-bitmap files.
   (merge bfd5522e98 ly/load-bitmap-leakfix later to maint).

 * "git fetch --prune" used to be O(n^2) expensive when there are many
   refs, which has been corrected.
   (merge 87d8d8c5d0 ph/fetch-prune-optim later to maint).

 * When a ref creation at refs/heads/foo/bar fails, the files backend
   now removes refs/heads/foo/ if the directory is otherwise not used.
   (merge a3a7f20516 ps/refs-files-remove-empty-parent later to maint).

 * "pack-objects" has been taught to avoid pointing into objects in
   cruft packs from midx.

 * "git remote" now detects remote names that overlap with each other
   (e.g., remote nickname "outer" and "outer/inner" are used at the
   same time), as it will lead to overlapping remote-tracking
   branches.
   (merge a5a727c448 jk/remote-avoid-overlapping-names later to maint).

 * The gpg.program configuration variable, which names a pathname to
   the (custom) GPG compatible program, can now be spelled with ~tilde
   expansion.
   (merge 7d275cd5c0 jb/gpg-program-variable-is-a-pathname later to maint).

 * Our <sane-ctype.h> header file relied on that the system-supplied
   <ctype.h> header is not later included, which would override our
   macro definitions, but "amazon linux" broke this assumption.  Fix
   this by preemptively including <ctype.h> near the beginning of
   <sane-ctype.h> ourselves.
   (merge 9d3b33125f ps/sane-ctype-workaround later to maint).

 * Clean-up compat/bswap.h mess.
   (merge f4ac32c03a ss/compat-bswap-revamp later to maint).

 * Meson-based build did not handle libexecdir setting correctly,
   which has been corrected.
   (merge 056dbe8612 rj/meson-libexecdir-fix later to maint).

 * Document that we do not require "real" name when signing your
   patches off.
   (merge 1f0fed312a bc/contribution-under-non-real-names later to maint).

 * "git commit" that concludes a conflicted merge failed to notice and remove
   existing comment added automatically (like "# Conflicts:") when the
   core.commentstring is set to 'auto'.
   (merge 92b7c7c9f5 ac/auto-comment-char-fix later to maint).

 * "git rebase -i" with bogus rebase.instructionFormat configuration
   failed to produce the todo file after recording the state files,
   leading to confused "git status"; this has been corrected.
   (merge ade14bffd7 ow/rebase-verify-insn-fmt-before-initializing-state later to maint).

 * A few file descriptors left unclosed upon program completion in a
   few test helper programs are now closed.
   (merge 0f1b33815b hl/test-helper-fd-close later to maint).

 * Interactive prompt code did not correctly strip CRLF from the end
   of line on Windows.
   (merge 711a20827b js/prompt-crlf-fix later to maint).

 * The config API had a set of convenience wrapper functions that
   implicitly use the_repository instance; they have been removed and
   inlined at the calling sites.

 * "git add/etc -p" now honor the diff.context configuration variable,
   and also they learn to honor the -U<n> command-line option.
   (merge 2b3ae04011 lm/add-p-context later to maint).

 * The case where a new submodule takes a path where there used to be a
   completely different subproject is now dealt with a bit better than
   before.
   (merge 5ed8c5b465 kj/renamed-submodule later to maint).

 * The deflate codepath in "git archive --format=zip" had a
   longstanding bug coming from misuse of zlib API, which has been
   corrected.

 * Other code cleanup, docfix, build fix, etc.
   (merge b257adb571 lo/my-first-ow-doc-update later to maint).
   (merge 8b34b6a220 ly/sequencer-update-squash-is-fixup-only later to maint).
   (merge 5dceb8bd05 ly/do-not-localize-bug-messages later to maint).
   (merge 61372dd613 ly/commit-buffer-reencode-leakfix later to maint).
   (merge 81cd1eef7d ly/pack-bitmap-root-leakfix later to maint).
   (merge bfc9f9cc64 ly/submodule-update-failure-leakfix later to maint).
   (merge 65dff89c6b ma/doc-diff-cc-headers later to maint).
   (merge efb61591ee jm/bundle-uri-debug-output-to-fp later to maint).
   (merge a3d278bb64 ly/prepare-show-merge-leakfix later to maint).
   (merge 1fde1c5daf ac/preload-index-wo-the-repository later to maint).
   (merge 855cfc65ae rm/t2400-modernize later to maint).
   (merge 2939494284 ly/run-builtin-use-passed-in-repo later to maint).
   (merge ff73f375bb jg/mailinfo-leakfix later to maint).
   (merge 996f14c02b jj/doc-branch-markup-fix later to maint).
   (merge 1e77de1864 cb/ci-freebsd-update-to-14.3 later to maint).
   (merge b0e9d25865 jk/fix-leak-send-pack later to maint).
   (merge f3a9558c8c bs/remote-helpers-doc-markup-fix later to maint).
   (merge c4e9775c60 kh/doc-config-subcommands later to maint).
   (merge de404249ab ps/perlless-test-fixes later to maint).
   (merge 953049eed8 ts/merge-orig-head-doc-fix later to maint).
   (merge 0c83bbc704 rj/freebsd-sysinfo-build-fix later to maint).
   (merge ad7780b38f ps/doc-pack-refs-auto-with-files-backend-fix later to maint).
   (merge f4fa8a3687 rh/doc-glob-pathspec-fix later to maint).
   (merge b27be108c8 ja/doc-git-log-markup later to maint).
   (merge 14d7583beb pw/config-kvi-remove-path later to maint).
   (merge f31abb421d jc/do-not-scan-argv-without-parsing later to maint).
   (merge 26552cb62a jk/unleak-reflog-expire-entry later to maint).
   (merge 339d95fda9 jc/ci-print-test-failures-fix later to maint).
   (merge 8c3add51a8 cb/meson-avoid-broken-macos-pcre2 later to maint).
   (merge 5247da07b8 ps/meson-clar-decls-fix later to maint).
   (merge f3ef347bb2 ch/t7450-recursive-clone-test-fix later to maint).
   (merge 4ac3302a1a jc/doc-release-vs-clear later to maint).
   (merge 3bdd897413 ms/meson-with-ancient-git-wo-ls-files-dedup later to maint).
   (merge cca758d324 kh/doc-fast-import-historical later to maint).
   (merge 9b0781196a jc/test-hashmap-is-still-here later to maint).
   (merge 1bad05bacc jk/revert-squelch-compiler-warning later to maint).
   (merge 3a7e783d9c dl/squelch-maybe-uninitialized later to maint).

----------------------------------------------------------------

Changes since v2.50.0 are as follows:

Aditya Garg (22):
      docs: add credential helper for yahoo and link Google's sendgmail tool
      docs: improve formatting in git-send-email documentation
      docs: remove credential helper links for emails from gitcredentials
      docs: make the purpose of using app password for Gmail more clear in send-email
      send-email: fix bug resulting in broken threads if a message is edited
      send-email: show the new message id assigned by outlook in the logs
      imap-send: fix bug causing cfg->folder being set to NULL
      imap-send: fix memory leak in case auth_cram_md5 fails
      imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
      imap-send: add support for OAuth2.0 authentication
      imap-send: add PLAIN authentication method to OpenSSL
      imap-send: enable specifying the folder using the command line
      imap-send: add ability to list the available folders
      imap-send: display port alongwith host when git credential is invoked
      imap-send: display the destination mailbox when sending a message
      imap-send: fix minor mistakes in the logs
      docs: link OpenSSL's verify(1) manual page to know about -CAfile and -CApath options
      docs: add outlookidfix config option to sendemail documentation
      docs: add an OAuth2.0 credential helper for AOL accounts
      docs: add a paragraph explaining the `sendmailCmd` option of sendemail
      docs: mention possible options for Proton Mail users
      docs: explain how to use `git imap-send --list` command to get a list of available folders

Alexander Shopov (5):
      git-gui i18n: Updated Bulgarian translation (578t)
      gitk i18n: Update Bulgarian translation (322t)
      gitk i18n: Remove the locations within the Bulgarian translation
      git-gui i18n: Update Bulgarian translation (557t)
      git-gui i18n: Remove the locations within the Bulgarian translation

Avi Halachmi (:avih) (1):
      gitk: encode arguments correctly with "open"

Ayush Chandekar (6):
      environment: remove the global variable 'core_preload_index'
      preload-index: stop depending on 'the_repository'
      repository: move 'repository_format_precious_objects' to repo scope
      builtin/prune: stop depending on 'the_repository'
      commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
      config: set comment_line_str to "#" when core.commentChar=auto

Brad Smith (1):
      config.mak.uname: update settings for Solaris 10 and 11

Brett A C Sheffield (1):
      gitremote-helpers.adoc: fix formatting

Carlo Marcelo Arenas Belón (14):
      daemon: remove unnecesary restriction for listener fd
      daemon: correctly handle soft accept() errors in service_loop
      ci: update FreeBSD image to 14.3
      config.mak.uname: set NO_MEMMEM only for functional version
      build: retire NO_UINTMAX_T
      builtin/gc: correct total_ram calculation with HAVE_BSD_SYSCTL
      compat/mingw: allow sigaction(SIGCHLD)
      daemon: use sigaction() to install child_handler()
      meson: work around broken system PCRE2 dependency in macOS
      git-gui: remove uname_O in Makefile
      git-gui: fix dependency of GITGUI_MAIN on generator
      git-gui: retire Git Gui.app
      git-gui: honor TCLTK_PATH in git-gui--askpass
      git-gui: ensure own version of git-gui--askpass is used

Christian Couder (2):
      fast-(import|export): improve on commit signature output format
      t9350: redirect input to only fast-import

Collin Funk (1):
      CodingGuidelines: document formatting of similar config variables.

Denton Liu (1):
      t/unit-tests/clar: fix -Wmaybe-uninitialized with -Og

Derrick Stolee (13):
      pack-objects: extract should_attempt_deltas()
      pack-objects: add --path-walk option
      pack-objects: update usage to match docs
      p5313: add performance tests for --path-walk
      pack-objects: introduce GIT_TEST_PACK_PATH_WALK
      t5538: add tests to confirm deltas in shallow pushes
      repack: add --path-walk option
      pack-objects: enable --path-walk via config
      scalar: enable path-walk during push via config
      pack-objects: refactor path-walk delta phase
      pack-objects: thread the path-based compression
      path-walk: add new 'edge_aggressive' option
      pack-objects: allow --shallow and --path-walk

Han Young (2):
      read-cache: report lock error when refreshing index
      blame: remove parameter detailed in get_commit_info()

Hoyoung Lee (1):
      t/helper/test-truncate: close file descriptor after truncation

Ilya Grigoriev (1):
      gitk: Mention globs in description of preference to hide custom refs

Jacob Keller (12):
      pathspec: add match_leading_pathspec variant
      pathspec: add flag to indicate operation without repository
      diff --no-index: support limiting by pathspec
      remote: remove branch->merge_name and fix branch_release()
      remote: fix tear down of struct remote
      dir: move starts_with_dot(_dot)_slash to dir.h
      remote: remove the_repository from some functions
      submodule--helper: improve logic for fallback remote name
      submodule: move get_default_remote_submodule()
      submodule: look up remotes by URL first
      send-pack: clean up extra_have oid array
      reflog: close leak of reflog expire entry

Jakub Ječmínek (1):
      doc: improve formatting in branch section

Jan Mazur (1):
      bundle-uri: send debug output to given FILE * stream

Jean-Noël Avila (9):
      doc: convert git-log to new documentation format
      doc: git-log convert rev-list-description to new doc format
      doc: git-log: convert line range options to new doc format
      doc: git-log: convert line range format to new doc format
      doc: git-log: convert rev list options to new doc format
      doc: git-log: convert pretty options to new doc format
      doc: git-log: convert pretty formats to new doc format
      doc: git-log: convert diff options to new doc format
      doc: git-log: convert log config to new doc format

Jeff King (11):
      t7422: replace confusing printf with echo
      test-lib: teach test_seq the -f option
      setup_revisions(): turn on diffs for all-negative diff filter
      remote: detect collisions in remote names
      revision: drop early output option
      test-delta: handle errors with die()
      test-delta: use strbufs to hold input files
      test-delta: close output descriptor after use
      t7510: use $PWD instead of $(pwd) inside PATH
      revert: initialize const value
      remote: bail early from set_head() if missing remote name

Jinyao Guo (1):
      mailinfo.c: fix memory leak in function handle_content_type()

Johannes Schindelin (3):
      mingw: drop Windows 7-specific work-around
      mingw_rename: support ReFS on Windows 2022
      mingw: support Windows Server 2016 again

Johannes Sixt (32):
      git-gui: do not end the commit message with an empty line
      gitk: treat file names beginning with "|" as relative paths
      gitk: have callers of diffcmd supply pipe symbol when necessary
      gitk: sanitize 'exec' arguments: simple cases
      gitk: sanitize 'exec' arguments: 'eval exec'
      gitk: sanitize 'exec' arguments: redirections
      gitk: sanitize 'exec' arguments: redirections and background
      gitk: sanitize 'exec' arguments: redirect to process
      gitk: sanitize 'open' arguments: simple commands
      gitk: sanitize 'open' arguments: simple commands with redirections
      gitk: sanitize 'open' arguments: simple commands, readable and writable
      gitk: collect construction of blameargs into a single conditional
      gitk: sanitize 'open' arguments: command pipeline
      git-gui: remove special treatment of Windows from open_cmd_pipe
      git-gui: remove git config --list handling for git < 1.5.3
      git-gui: treat file names beginning with "|" as relative paths
      git-gui: sanitize 'exec' arguments: simple cases
      git-gui: sanitize 'exec' arguments: background
      git-gui: remove option --stderr from git_read
      git-gui: break out a separate function git_read_nice
      git-gui: use git_read in githook_read
      gitk: sanitize 'open' arguments: revisit recently updated 'open' calls
      git-gui: convert git_read*, git_write to be non-variadic
      git-gui: pass redirections as separate argument to _open_stdout_stderr
      git-gui: pass redirections as separate argument to git_read
      git-gui: introduce function git_redir for git calls with redirections
      git-gui: do not mistake command arguments as redirection operators
      git-gui: sanitize 'exec' arguments: convert new 'cygpath' calls
      gitk: choosefont - remove a stray debugging line
      gitk: remove header of now empty section "General options"
      gitk: avoid duplicated upstream refs
      interactive: do strip trailing CRLF from input

Jonas Brandstötter (2):
      gpg-interface: expand gpg.program as a path
      t7510: add test cases for non-absolute gpg program

Jouke Witteveen (1):
      doc: update references to renamed AsciiDoc files

Junio C Hamano (43):
      you-still-use-that??: help deprecating commands for removal
      doc: prepare for a world without whatchanged
      tests: prepare for a world without whatchanged
      whatchanged: require --i-still-use-this
      whatchanged: remove when built with WITH_BREAKING_CHANGES
      whatschanged: list it in BreakingChanges document
      CodingGuidelines: let BSS do its job
      Git 2.49.1
      merge/pull: add the "--compact-summary" option
      merge/pull: extend merge.stat configuration variable to cover --compact-summary
      Git 2.50.1
      Start 2.51 cycle, the first batch
      diff-no-index: do not reference .d_type member of struct dirent
      The second batch
      cocci: matching (multiple) identifiers
      coccicheck: fail "make" when it fails
      The third batch
      The fourth batch
      The fifth batch
      send-pack: clean-up even when taking an early exit
      The sixth batch
      The seventh batch
      The eighth batch
      The ninth batch
      The tenth batch
      The eleventh batch
      ci: allow github-actions print test failures again
      The twelfth batch
      rev-list: make "struct rev_list_info" static to the only user
      rev-list: update a NEEDSWORK comment
      The thirteenth batch
      CodingGuidelines: document test balloons in flight
      fixup! submodule: prevent overwriting .gitmodules on path reuse
      fixup! submodule: skip redundant active entries when pattern covers path
      The fourteenth batch
      The fifteenth batch
      test-hashmap: document why it is no longer used but still there
      CodingGuidelines: clarify that S_release() does not reinitialize
      The sixteenth batch
      The seventeenth batch, just before -rc0
      Git 2.51-rc0
      A bit more after -rc0
      Git 2.51-rc1

Justin Tobler (3):
      config: quote values containing CR character
      builtin: unmark git-switch and git-restore as experimental
      archive: flush deflate stream until Z_STREAM_END

Jörg Thalheim (2):
      imap-send: fix confusing 'store' terminology in error message
      imap-send: improve error messages with configuration hints

K Jayatheerth (3):
      stash: fix incorrect branch name in stash message
      submodule: prevent overwriting .gitmodules on path reuse
      submodule: skip redundant active entries when pattern covers path

Karthik Nayak (20):
      refs: add function to translate errors to strings
      fetch: use batched reference updates
      send-pack: fix memory leak around duplicate refs
      receive-pack: use batched reference updates
      refs/files: skip updates with errors in batched updates
      receive-pack: handle reference deletions separately
      clang-format: set 'ColumnLimit' to 0
      clang-format: add 'RemoveBracesLLVM' to the main config
      meson: add rule to run 'git clang-format'
      refs: expose `ref_iterator` via 'refs.h'
      ref-cache: remove unused function 'find_ref_entry()'
      refs: selectively set prefix in the seek functions
      ref-filter: remove unnecessary else clause
      for-each-ref: introduce a '--start-after' option
      ref-cache: set prefix_state when seeking
      ref-cache: use 'size_t' instead of int for length
      for-each-ref: fix documentation argument ordering
      for-each-ref: reword the documentation for '--start-after'
      t6302: add test combining '--start-after' with '--exclude'
      ref-filter: use REF_ITERATOR_SEEK_SET_PREFIX instead of '1'

Kristoffer Haugsbakk (6):
      config: document --[no-]show-names
      config: use --value=<pattern> consistently
      config: document --[no-]value
      config: use --value instead of value-pattern
      config: mention --url in the synopsis
      doc: fast-import: contextualize the hardware cost

Kyle Lippincott (1):
      test-lib: respect GIT_TEST_INSTALLED when querying default hash

Leon Michalak (4):
      t: use test_grep in t3701 and t4055
      t: use test_config in t4055
      add-patch: respect diff.context configuration
      add-patch: add diff.context command line overrides

Lidong Yan (17):
      sequencer: replace error() with BUG() in update_squash_messages ()
      BUG(): remove leading underscore of the format string
      builtin/fetch-pack: cleanup before return error
      commit-graph: fix start_delayed_progress() leak
      repo_logmsg_reencode: fix memory leak when use repo_logmsg_reencode ()
      builtin/submodule--helper: fix leak when remote_submodule_branch() failed
      pack-bitmap: remove checks before bitmap_free
      revision: fix memory leak in prepare_show_merge()
      git.c: remove the_repository dependence in run_builtin()
      pack-bitmap: reword comments in test_bitmap_commits()
      pack-bitmap: add load corrupt bitmap test
      bloom: add test helper to return murmur3 hash
      bloom: rename function operates on bloom_key
      bloom: replace struct bloom_key * with struct bloom_keyvec
      revision: make helper for pathspec to bloom keyvec
      bloom: optimize multiple pathspec items in revision
      pull: add pull.autoStash config option

Lucas Seiki Oshiro (2):
      MyFirstContribution: use struct repository in examples
      MyFirstContribution: add walken.c to meson.build

Mark Levedahl (71):
      git-gui: _which, only add .exe suffix if not present
      git-gui: use [is_Windows], not bad _shellpath
      git-gui: make _shellpath usable on startup
      git-gui: remove Tcl 8.4 workaround on 2>@1 redirection
      git-gui: use only the configured shell
      git-gui: remove HEAD detachment implementation for git < 1.5.3
      git-gui: remove unused proc is_shellscript
      git-gui: avoid auto_execok for git-bash menu item
      git-gui: avoid auto_execok in do_windows_shortcut
      git-gui: cleanup git-bash menu item
      git-gui: assure PATH has only absolute elements.
      git-gui: sanitize $PATH on all platforms
      git-gui: override exec and open only on Windows
      gitk: require git >= 2.20
      gitk: remove code targeting git <= 1.7.2
      gitk: Make TclTk 8.6 the minimum, allow 8.7
      gitk: remove implementations for Tcl/Tk < 8.6
      gitk: use $config_variables as list for save/restore
      gitk: always use themed Tk (ttk)
      gitk: replace ${NS} with ttk
      gitk: remove non-ttk support code
      gitk: separate x11 / win32 / aqua Mouse bindings
      gitk: wheel scrolling multiplier preference
      gitk: mousewheel scrolling functions for Tk 8.6
      gitk: update win32 scrolling for Tk 8.6 / TIP 171
      gitk: update x11 scrolling for TclTk 8.6 / TIP 171
      gitk: update aqua scrolling for TclTk 8.6 / TIP171
      gitk: set config dialog color swatches in one place
      gitk: allow horizontal commit-graph scrolling
      gitk: restore ui colors after cancelling config dialog
      gitk: update scrolling for TclTk 8.7+ / TIP 474
      gitk: switch to -translation binary
      gitk: Tcl9 doesn't expand ~, use $env(HOME)
      gitk: use -profile tcl8 for file input with Tcl 9
      gitk: use -profile tcl8 on encoding conversions
      gitk: allow Tcl/Tk 9.0+
      git-gui: require git >= 2.36
      git-gui: Make TclTk 8.6 the minimum, allow 8.7
      git-gui: git ls-files knows --exclude-standard
      git-gui: git-diff-index always knows submodules
      git-gui: use git-branch --show-current
      git-gui: git rev-parse knows show_toplevel
      git-gui: git-blame understands -w and textconv
      git-gui: git-diff knows submodules and textconv
      git-gui: git merge understands --strategy=recursive
      git-gui: git-remote is always available
      git-gui: use git_init to create new repository dir
      git-gui: remove unused git-version
      git-gui: remove unreachable Tk 8.4 code
      git-gui: remove redundant check for Tk >= 8.5
      git-gui: always use themed widgets from ttk
      git-gui: remove ${NS} indirection for ttk
      git-gui: do not add directories to PATH on Windows
      git-gui: let nice work on Windows
      git-gui: Windows tk_getSaveFile is not useful for shortcuts
      git-gui: remove non-ttk code
      git-gui: use git-clone
      git-gui: default to full copy for linked worktrees
      git-gui: use dashless 'git cmd' form for read/write
      git-gui: remove procs gitexec and _git_cmd
      git-gui: eliminate _search_exe
      git-gui: use /cmd/git-gui.exe for shortcut
      git-gui: assure -eofchar {} on all channels
      git-gui: translation binary defines iso8859-1
      git-gui: replace encoding binary with iso8859-1
      git-gui: do not mix -translation binary and -encoding
      git-gui: remove EOL translation for gets
      git-gui: themed.tcl: use full namespace for color
      git-gui: use -profile tcl8 for file input with Tcl 9
      git-gui: use -profile tcl8 on encoding conversions
      git-gui: Allow Tcl 9.0

Martin Storsjö (1):
      meson: tolerate errors from git ls-files --deduplicate

Martin Ågren (1):
      diff-generate-patch.adoc: drop spurious backticks

Matthias Aßhauer (1):
      mingw_open_existing: handle directories better

Maxim Cournoyer (3):
      contrib: use a more portable shebang for git-credential-netrc
      contrib: warn for invalid netrc file ports in git-credential-netrc
      contrib: better support symbolic port names in git-credential-netrc

Michael Rappazzo (4):
      gitk: sort by ref type on the 'tags and heads' view
      gitk: make 'sort-refs-by-type' optional and persistent
      gitk: separate upstream refs when using the sort-by-type option
      gitk: filter invisible upstream refs from reference list

Orgad Shaneh (1):
      git-gui: strip the commit message after running commit-msg hook

Ori Avtalion (1):
      gitk: Add user preference to hide specific references

Patrick Steinhardt (111):
      contrib: remove "remotes2config.sh"
      contrib: remove "examples" directory
      contrib: remove remote-helper stubs
      contrib: remove "thunderbird-patch-inline"
      contrib: remove "hooks" directory
      contrib: remove "mw-to-git"
      contrib: remove "persistent-https" remote helper
      contrib: remove "git-resurrect.sh"
      contrib: remove "emacs" directory
      contrib: remove "git-new-workdir"
      contrib: remove some scripts in "stats" directory
      t: stop announcing prereqs
      t: silence output from `test_create_repo()`
      t9822: use prereq to check for ISO-8859-1 support
      t983*: use prereq to check for Python-specific git-p4(1) support
      t/test-lib: don't print shell traces to stdout
      t/test-lib: fix TAP format for BASH_XTRACEFD warning
      t7815: fix unexpectedly passing test on macOS
      test-lib: fail on unexpectedly passing tests
      meson: introduce kwargs variable for tests
      meson: parse TAP output generated by our tests
      builtin/gc: use designated field initializers for maintenance tasks
      builtin/gc: drop redundant local variable
      builtin/maintenance: centralize configuration of explicit tasks
      builtin/maintenance: mark "--task=" and "--schedule=" as incompatible
      builtin/maintenance: stop modifying global array of tasks
      builtin/maintenance: extract function to run tasks
      builtin/maintenance: fix typedef for function pointers
      builtin/maintenance: split into foreground and background tasks
      builtin/maintenance: fix locking race with refs and reflogs tasks
      usage: allow dying without writing an error message
      builtin/gc: avoid global state in `gc_before_repack()`
      builtin/maintenance: fix locking race when handling "gc" task
      object-store: rename `raw_object_store` to `object_database`
      object-store: rename `object_directory` to `odb_source`
      object-store: rename files to "odb.{c,h}"
      odb: introduce parent pointers
      odb: get rid of `the_repository` in `find_odb()`
      odb: get rid of `the_repository` in `assert_oid_type()`
      odb: get rid of `the_repository` in `odb_mkstemp()`
      odb: get rid of `the_repository` when handling alternates
      odb: get rid of `the_repository` in `for_each()` functions
      odb: get rid of `the_repository` when handling the primary source
      odb: get rid of `the_repository` when handling submodule sources
      odb: trivial refactorings to get rid of `the_repository`
      odb: rename `oid_object_info()`
      odb: rename `repo_read_object_file()`
      odb: rename `has_object()`
      odb: rename `pretend_object_file()`
      odb: rename `read_object_with_reference()`
      BreakingChanges: announce switch to "reftable" format
      setup: use "reftable" format when experimental features are enabled
      t4150: fix warning printed by awk due to escaped '\@'
      t5333: fix missing terminator for sed(1) 's' command
      docs/git-pack-refs: document heuristic used for packing loose refs
      refs/files: remove empty parent dirs when ref creation fails
      t1006: fix broken TAP format
      meson: stop discovering native version of Python
      meson: stop printing 'https' option twice in our summaries
      meson: improve summary of auto-detected features
      meson: clean up unnecessary variables
      meson: fix lookup of shell on MINGW64
      sane-ctype: fix compiler error on Amazon Linux 2
      meson: update subproject wrappers
      ci: use Meson's new `--slice` option
      midx: start tracking per object database source
      packfile: refactor `prepare_packed_git_one()` to work on sources
      midx: stop using linked list when closing MIDX
      packfile: refactor `get_multi_pack_index()` to work on sources
      packfile: stop using linked MIDX list in `find_pack_entry()`
      packfile: stop using linked MIDX list in `get_all_packs()`
      midx: remove now-unused linked list of multi-pack indices
      object-file: fix -Wsign-compare warnings
      object-file: stop using `the_hash_algo`
      object-file: get rid of `the_repository` in `has_loose_object()`
      object-file: inline `check_and_freshen()` functions
      object-file: get rid of `the_repository` when freshening objects
      object-file: get rid of `the_repository` in `loose_object_info()`
      object-file: get rid of `the_repository` in `finalize_object_file()`
      loose: write loose objects map via their source
      odb: introduce `odb_write_object()`
      object-file: get rid of `the_repository` when writing objects
      object-file: inline `for_each_loose_file_in_objdir_buf()`
      object-file: remove declaration for `for_each_file_in_obj_subdir()`
      object-file: get rid of `the_repository` in loose object iterators
      object-file: get rid of `the_repository` in `read_loose_object()`
      object-file: get rid of `the_repository` in `force_object_loose()`
      object-file: get rid of `the_repository` in index-related functions
      config: drop `git_config()` wrapper
      config: drop `git_config_clear()` wrapper
      config: drop `git_config_get()` wrapper
      config: drop `git_config_get_value()` wrapper
      config: drop `git_config_get_value()` wrapper
      config: drop `git_config_get_string_multi()` wrapper
      config: drop `git_config_get_string()` wrapper
      config: drop `git_config_get_string()` wrapper
      config: drop `git_config_get_int()` wrapper
      config: drop `git_config_get_ulong()` wrapper
      config: drop `git_config_get_bool()` wrapper
      config: drop `git_config_set_in_file()` wrapper
      config: drop `git_config_set_gently()` wrapper
      config: drop `git_config_set()` wrapper
      config: drop `git_config_set_in_file_gently()` wrapper
      config: drop `git_config_set_multivar_in_file_gently()` wrapper
      config: drop `git_config_get_multivar_gently()` wrapper
      config: drop `git_config_set_multivar()` wrapper
      config: remove unused `the_repository` wrappers
      config: move Git config parsing into "environment.c"
      config: fix sign comparison warnings
      meson: ensure correct "clar-decls.h" header is used
      Documentation/RelNotes/2.51.0: improve wording for a couple entries

Patrick Steinhardt' via Git Security (1):
      bundle-uri: fix arbitrary file writes via parameter injection

Patrik Weiskircher (2):
      contrib/subtree: parse using --stuck-long
      contrib/subtree: add -S/--gpg-sign

Phil Hord (3):
      fetch-prune: optimize dangling-ref reporting
      refs: remove old refs_warn_dangling_symref
      clean up interface for refs_warn_dangling_symrefs

Phillip Wood (6):
      stash: allow "git stash -p <pathspec>" to assume push again
      stash: allow "git stash [<options>] --patch <pathspec>" to assume push
      config: remove unneeded struct field
      CodingGuidelines: allow the use of bool
      git-compat-util: convert string predicates to return bool
      strbuf: convert predicates to return bool

Ramsay Jones (4):
      test-lib: add missing prerequisites for Darwin
      build: fix FreeBSD build when sysinfo compat library installed
      meson: fix installation when -Dlibexexdir is set
      po/meson.build: add missing 'ga' language code

Raymond E. Pasco (4):
      apply: read in the index in --intent-to-add mode
      apply: only write intents to add for new files
      t4140: test apply --intent-to-add interactions
      apply docs: clarify wording for --intent-to-add

René Scharfe (11):
      parse-options: require PARSE_OPT_NOARG for OPTION_BITOP
      parse-options: add precision handling for PARSE_OPT_CMDMODE
      parse-options: add precision handling for OPTION_SET_INT
      parse-options: add precision handling for OPTION_BIT
      parse-options: add precision handling for OPTION_NEGBIT
      parse-options: add precision handling for OPTION_BITOP
      parse-options: add precision handling for OPTION_COUNTUP
      commit: convert pop_most_recent_commit() to prio_queue
      prio-queue: add prio_queue_replace()
      commit: use prio_queue_replace() in pop_most_recent_commit()
      git: show alias info only with lone -h

Rodrigo Carvalho (1):
      userdiff: add support for R programming language

Rodrigo Michelassi (1):
      t2400: replace 'test -[efd]' with 'test_path_is_*'

Russell Hanneken (1):
      doc: correct doc for glob pathspec

Sebastian Andrzej Siewior (5):
      bswap.h: add support for __BYTE_ORDER__
      bswap.h: define GIT_LITTLE_ENDIAN on msvc as little endian
      bswap.h: always overwrite ntohl/ ntohll macros
      bswap.h: remove optimized x86 version of bswap32/64
      bswap.h: provide a built-in based version of bswap32/64 if possible

Seyi Kuforiji (10):
      t/unit-tests: implement clar specific reftable test helper functions
      t/unit-tests: convert reftable basics test to use clar test framework
      t/unit-tests: convert reftable block test to use clar
      t/unit-tests: convert reftable merged test to use clar
      t/unit-tests: convert reftable pq test to use clar
      t/unit-tests: convert reftable table test to use clar
      t/unit-tests: convert reftable readwrite test to use clar
      t/unit-tests: convert reftable record test to use clar
      t/unit-tests: convert reftable stack test to use clar
      t/unit-tests: finalize migration of reftable-related tests

Siddharth Asthana (1):
      cat-file: fix mailmap application for different author and committer

Takashi Iwai (3):
      gitk: Add support of SHA256 repositories
      git-gui: Replace null_sha1 with nullid
      git-gui: Add support of SHA256 repo

Taylor Blau (18):
      wincred: avoid buffer overflow in wcsncat()
      Git 2.43.7
      Git 2.44.4
      Git 2.45.4
      Git 2.46.4
      Git 2.47.3
      Git 2.48.2
      pack-objects: use standard option incompatibility functions
      pack-objects: limit scope in 'add_object_entry_from_pack()'
      pack-objects: factor out handling '--stdin-packs'
      pack-objects: declare 'rev_info' for '--stdin-packs' earlier
      pack-objects: perform name-hash traversal for unpacked objects
      pack-objects: fix typo in 'show_object_pack_hint()'
      pack-objects: swap 'show_{object,commit}_pack_hint'
      pack-objects: introduce '--stdin-packs=follow'
      repack: exclude cruft pack(s) from the MIDX where possible
      pack-bitmap: fix memory leak if load_bitmap() failed
      Documentation/RelNotes: use .adoc extension for new security releases

Timur Sultanaev (1):
      docs: correct ORIG_HEAD example in "git merge" documentation

Todd Zullinger (1):
      t: avoid git config syntax from newer releases

Victoria Dye (3):
      t1006: update 'run_tests' to test generic object specifiers
      cat-file: add %(objectmode) atom
      cat-file.c: add batch handling for submodules

brian m. carlson (16):
      object-name: make get_oid quietly return an error
      builtin/stash: factor out revision parsing into a function
      builtin/stash: provide a way to export stashes to a ref
      builtin/stash: provide a way to import stashes from a ref
      hash: add a constant for the default hash algorithm
      hash: add a constant for the legacy hash algorithm
      builtin: use default hash when outside a repository
      Use legacy hash for legacy formats
      setup: use the default algorithm to initialize repo format
      t: default to compile-time default hash if not set
      t1007: choose the built-in hash outside of a repo
      t4042: choose the built-in hash outside of a repo
      t5300: choose the built-in hash outside of a repo
      help: add a build option for default hash
      Enable SHA-256 by default in breaking changes mode
      SubmittingPatches: allow non-real name contributions

chenjianhu (1):
      t7450: inspect the correct path a broken code would write to

redoste (1):
      ssh signing: don't detach the filename strbuf from key_file tempfile

shejialuo (8):
      string-list: fix sign compare warnings for loop iterator
      string-list: remove unused "insert_at" parameter from add_entry
      string-list: return index directly when inserting an existing element
      string-list: enable sign compare warnings check
      u-string-list: move "test_split" into "u-string-list.c"
      u-string-list: move "test_split_in_place" to "u-string-list.c"
      u-string-list: move "filter string" test to "u-string-list.c"
      u-string-list: move "remove duplicates" test to "u-string-list.c"

Øystein Walle (1):
      rebase: write script before initializing state


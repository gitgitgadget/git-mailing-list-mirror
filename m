Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B71407576;
	Mon, 29 Jun 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753022; cv=none; b=YWVVIccS5rPf8CFLY7Z4gc0YE5Q9A9LNGTym/cw4aFAD45o5NgoNz1RVaxwTx1okBz7a9IrHC9PgASc5hDwO+KtKs16lCj/SeGyMH3GbA5zHfwtwfr9js0TCFBd2n3qlJx7UMVWQ9BudAvASPrTCF+UF5ySdYVrnfM4PxoygwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753022; c=relaxed/simple;
	bh=0tepZ9e3DHUZdz/92MqT4XCcc6try7gRVF5dNe3MRUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VElu8YaSVA/ZC/Oxy06Xg8Dxp7fvKEAOwBsoZXocjlwpvAvBTRuh5eR/SRbOenhXuJtkUXfEhV9QKPMY6CQ7tp/VsKLZ8T365h8qWhzo++5k9bcsL2g+IwApJozGITvClCli9Z7192eygj85Cvu41BfaQzXX9E21x5aotXHJCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jb55EN2c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QoaWTJk2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jb55EN2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QoaWTJk2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C63581D000C8;
	Mon, 29 Jun 2026 13:10:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 13:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1782753018; x=1782839418; bh=Nm
	8COLlwimmsNYe2eqGtyMLN5BahH89TdS6kwFssl4o=; b=jb55EN2cT777ic3j+b
	5aafjjs71zbK3dhfgR+v6FIiBJBbd5wl7/B26hittiKNs2n9P2fL7gwHTVAZoBY2
	nAkbE7hk6vnQddAQThfV3f+wlaX+w4ySoQiJleMT2iFOrYSQaUqSvPhOl/9OObT6
	MKv4wkYS8UdaKzmRzyIiznzC9m9tOK0IbPvLAiSi+r/CkbCtwLuUJPNKxTl3Fz5i
	8X2/W9yovLxyTxV9My3BRmhUc7pWp7PePECx+VlGDqRhaZ3F5UN9q/3hhrvkYhQh
	lelUa0g6aVnBnWalOMV2sA3SACGKFE/cms3JQZqIJGdL/eehadkKQX9p1M+fNq/v
	LcBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782753018; x=1782839418; bh=Nm8COLlwimmsNYe2eqGtyMLN5Bah
	H89TdS6kwFssl4o=; b=QoaWTJk2ugWTkzdEYSLSifVZ/ojfwesryqU8mvjt2+RT
	KlufeUt+xj7Tpxdo5jSYovCTPJDoNVStL84d2Ct/10tISCXyIg4qCxp1zCw9D0E7
	xS3/eROExn1qF8iY3SqA22nSFQ28Xtbnh6hrtuCC3CDFxd0oQ4b2IDsGnP2g63d2
	FyEKmkUg6ymMozt7ClRwcmHGoCJbSwcwDDpYK5IzVx997blsbA/RI6NZgMBjOpqd
	LSjGEEK5aCq7NPLwQMPmxAOlBTYU1u1tkkic2KL6E+S5vDAMnD9q8e1RvnRPjo+L
	DBMJDNgZp9PWf+3yNidRUtYoVbu+QGhbRISgZmRTmA==
X-ME-Sender: <xms:-qZCap4oSpwaZYDO4CrDgjZHrS_1orfstmPEDi1TngUif9qsikBJRA>
    <xme:-qZCaoZpWie8Ck1zv-lEQaR4RV_XgqsAtCaa7de_yMtMWcB9WSUhx6Zb39dmWpcKv
    Y1o69PEK3d3BDJ3m0o9Combn1X3NaKy4nUPniH6c_2DWqTCCmm6-A>
X-ME-Received: <xmr:-qZCaggP66yp17sgMSvmynKcLOp3zKm8cYQpMp8bW0fHYTkeQ69opecdxMzIOjw_uJoGc3WRBKvxp_gSgNtFefWZGyHVaaFnPD0OqPE>
X-ME-Proxy-Cause: dmFkZTEAkxJbmoyBoyzru6Fv6SqsesF0aXr6RxsKlaInOPWaSvtJKeApL4pWswBfUHeDCZ
    oQ9Vt8WG0BAZRcMPfD8HoU1JRzzmNXyXa+mh8hfiQa5mmCii/5uI9eLgkZjwLjIHhH48Ng
    G1Tht12xfbt9lz739JSas8Odxd9tq9OGSWL+OBj0j9heqH4pcg6WrSFfRxW6l8FWSoGcNZ
    5g7QGLI6p78GaySk+gC+z588xOCLiMJjvkHCpTFgDdRJJUHVghMUnKHafbcYEAZ06uB8BN
    hLzhGYJM/7OgeaeJkTlue2+bf5Qxmt9oIKlsFCymDOtbH872b4I0xjAKkD6ehEfBCAdiYr
    neF1fockKISTkXLy4Fx+XoLPcEzNUNHgnn60iOtph0Z5OkIWvIj60/D8jUScfLETARWLL4
    jJqpAvNB0ev5PNAgChKk+k+eIEWaXWjVp6S7kxT9LfVU1h9uPTbUw4R5oIMnj5H109u//o
    bx581cxBY6kmpnJpVuRQHhT6xU68O9wNuCtU/Gtzj1l6IcjIWO0Yo+GR8BA909LCr1Br4Y
    8lwdMJwAqr/ExslGxezPSXt6RmYGKprvM3OkIxSkf1IVYVZAIBlZ8pHyb3Ad5okdnz8Xh0
    Khv0/P9xwslyt95ZaRU3TfI3yfNToCdYTRte3DB6/DTMhT6K/QR1deaYZXQA
X-ME-Proxy: <xmx:-qZCah_w8p64-iRJ-2w_yu1xdokrl3hZyXI1G66nsThGuuethLcVHg>
    <xmx:-qZCajpf-YXN4sRSO6_cPHZbuCJCfN-7PBcNFBy-nGv-0S1nzCVm3w>
    <xmx:-qZCahXppCP2SqY-BpsI14LKPnymW8IHKOHW9tqJZrXA_YjRC9zjlA>
    <xmx:-qZCaqB2v7SafjrbHc9cbI6b9B3U3Ug1NkAEae4__RMDUy-gMrKpCw>
    <xmx:-qZCamddjFaVv8sLfQVq5HmZzr0tJYgLz_Pr51SbTo0d09fOt1oF5F0o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 13:10:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.55.0
Date: Mon, 29 Jun 2026 10:10:16 -0700
Message-ID: <xmqqv7b1w9vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The latest feature release Git v2.55.0 is now available at the
usual places.  It is comprised of 505 non-merge commits since
v2.54.0, contributed by 100 people, 33 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.55.0'
tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.54.0 are as follows.
Welcome to the Git development community!

  Abhinav Gupta, Aliwoto, Arijit Banerjee, Brandon Chinn, Claude
  Sonnet 4.6, David Lin, Dominik Loidolt, Ethan Dickson, Hugo
  Osvaldo Barrera, Ivan Baluta, Jean-Christophe Manciot, Jonas
  Rebmann, Kévin Leprêtre, Koutian Wu, Kristofer Karlsson,
  Kushal Das, lilydjwg, Luke Martin, Luna Schwalbe, Matheus
  Afonso Martins Moreira, Matteo Beniamino, Michael Grossfeld,
  Owen Stephens, Rob McDonald, Saagar Jha, Scott Bauersfeld,
  Scott L. Burson, Sebastien Tardif, Shardul Natu, Siddh Raman
  Pant, slonkazoid, Tamir Duberstein, and Weijie Yuan.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Johnson, Adrian Ratiu, Ævar Arnfjörð Bjarmason, Aindriú
  Mac Giolla Eoin, Alexander Monakov, Alexander Shopov, Alyssa
  Ross, Andrew Kreimer, Arkadii Yakovets, Bagas Sanjaya, brian
  m. carlson, Christian Couder, D. Ben Knoble, Derrick Stolee,
  Elijah Newren, Emily Shaffer, Emir SARI, Ezekiel Newren, Fangyi
  Zhou, Ghanshyam Thakkar, Greg Hurrell, Harald Nordgren, Jacob
  Keller, Jan Palus, Jayesh Daga, Jean-Noël Avila, Jeff King,
  Jiang Xin, Johannes Schindelin, Johannes Sixt, Jonatan Holmgren,
  Junio C Hamano, Justin Tobler, Karthik Nayak, Kate Golovanova,
  Kristoffer Haugsbakk, LorenzoPegorari, Lucas Seiki Oshiro,
  Lumynous, Mark Levedahl, Matthew John Cheetham, Michael
  Montalbo, Mikel Forcada, Mirko Faina, Olamide Caleb Bello,
  Pablo Sabater, Patrick Steinhardt, Paul Tarjan, Peter Krefting,
  Philippe Blain, Phillip Wood, Pushkar Singh, Ramsay Jones, René
  Scharfe, Samo Pogačnik, Shreyansh Paliwal, Siddharth Asthana,
  Siddharth Shrimali, SZEDER Gábor, Taylor Blau, Todd Zullinger,
  Toon Claes, Torsten Bögershausen, Trieu Huynh, Tuomas Ahola,
  Usman Akinyemi, and Zakariyah Ali.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.55 Release Notes
=======================

UI, Workflows & Features
------------------------

 * Hook scripts defined via the configuration system can now be
   configured to run in parallel.

 * The userdiff driver for the Scheme language has been extended to
   cover other Lisp dialects.

 * Terminal control sequences coming over the sideband while talking
   to a remote repository are mostly disabled by default, except for
   ANSI color escape sequences.

 * "ort" merge backend improvements.

 * "git checkout -m another-branch" was invented to deal with local
   changes to paths that are different between the current and the new
   branch, but it gave only one chance to resolve conflicts.  The command
   was taught to create a stash to save the local changes.

 * A new builtin "git format-rev" is introduced for pretty formatting
   one revision expression per line or commit object names found in
   running text.

 * "git history" learned "fixup" command.

 * The internal URL parsing logic has been made accessible via a new
   subcommand "git url-parse".

 * Misspelt proxy URL (e.g., httt://...) did not trigger any warning
   or failure, which has been corrected.  We had a regression in this
   update that broke https:// proxies, but that has been caught and
   corrected.

 * Document the fact that .git/info/exclude is shared across worktrees
   linked to the same repository.

 * The command line parser for "git diff" learned a few options take
   only non-negative integers.

 * The graph output from commands like "git log --graph" can now be
   limited to a specified number of lanes, preventing overly wide output
   in repositories with many branches.

 * The fsmonitor daemon has been implemented for Linux.

 * "git cat-file --batch" learns an in-line command "mailmap"
   that lets the user toggle use of mailmap.

 * The "git pack-objects --path-walk" traversal has been integrated
   with several object filters, including blobless and sparse filters.

 * "git push" learned to take a "remote group" name to push to, which
   causes pushes to multiple places, just like "git fetch" would do.

 * The 'git-jump' command (in contrib/) has been taught to automatically
   pick a mode (merge, diff, or ws) when invoked without arguments.

 * The documentation for `push.default = simple` has been clarified to
   better explain its behavior, making it clear that it pushes the
   current branch to a same-named branch on the remote, and detailing
   the upstream requirements for centralized workflows.

 * The documentation for "--word-diff" has been extended with a bit of
   implementation detail of where these different words come from.

 * "git config foo.bar=baz" is not likely to be a request to read the
   value of such a variable with '=' in its name; rather it is plausible
   that the user meant "git config set foo.bar baz".  Give advice when
   giving an error message.

 * "git rev-list" (and "git log" family of commands) learned a new "--max-count-oldest"
   that picks oldest N commits in the range instead of the usual newest.

 * Various AsciiDoc markup fixes in 'git config' documentation and
   related files to ensure lists and formatting are rendered correctly.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * Promisor remote handling has been refactored and fixed in
   preparation for auto-configuration of advertised remotes.

 * Rust support is enabled by default (but still allows opting out) in
   some future version of Git.

 * Preparation of the xdiff/ codebase to work with Rust.

 * Use a larger buffer size in the code paths to ingest pack stream.

 * Refactor service routines in the ref subsystem backends.

 * Shrink wasted memory in Myers diff that does not account for common
   prefix and suffix removal.

 * Enable expensive tests to catch topics that may cause breakages on
   integration branches closer to their origin in the contributor PR
   builds.

 * "git merge-base" optimization.

 * The limit_list() function that is one of the core part of the
   revision traversal infrastructure has been optimized by replacing
   its use of linear list with priority queue.

 * In a lazy clone, "git cherry" and "git grep" often fetch necessary
   blob objects one by one from promisor remotes.  It has been corrected
   to collect necessary object names and fetch them in bulk to gain
   reasonable performance.

 * The logic to determine that branches in an octopus merge are
   independent has been optimized.

 * The consistency checks for the files reference backend have been updated
   to skip lock files earlier, avoiding unnecessary parsing of
   intermediate files.

 * The negotiation tip options in "git fetch" have been reworked to
   allow requiring certain refs to be sent as "have" lines, and to
   restrict negotiation to a specific set of refs.

 * The repacking code has been refactored and compaction of MIDX layers
   have been implemented, and incremental strategy that does not require
   all-into-one repacking has been introduced.

 * ODB transaction interface is being reworked to explicitly handle
   object writes.

 * Add a new odb "in-memory" source that is meant to only hold
   tentative objects (like the virtual blob object that represents the
   working tree file used by "git blame").

 * Many uses of the_repository has been updated to use a more
   appropriate struct repository instance in setup.c codepath.

 * Revision traversal optimization.

 * Build update.

 * The logic to lazy-load trees from the commit-graph has been made
   more robust by falling back to reading the commit object when
   the commit-graph is no longer available.

 * The "name" argument in git_connect() and related functions has been
   converted to a "service" enum to improve type safety and clarify its
   purpose.

 * 'git restore --staged' has been optimized to avoid unnecessarily expanding
   the sparse index when operating on paths within the sparse checkout
   definition, by handling sparse directory entries at the tree level.

 * "git stash -p" has been optimized by reusing cached index
   entries in its temporary index, avoiding unnecessary lstat()
   calls on unchanged files.

 * The check for non-stale commits in the priority queue used by
   `paint_down_to_common` and `ahead_behind` has been optimized by
   replacing an O(N) scan with an O(1) counter, yielding performance
   improvements in repositories with wide histories.

 * Reachability bitmap generation has been significantly optimized. By
   reordering tree traversal, caching object positions, and refining how
   pseudo-merge bitmaps are constructed, the performance of "git repack
   --write-midx-bitmaps" is improved, especially for large repositories
   and when using pseudo-merges.

 * Adding a decimal integer with strbuf_addf("%u") appears commonly;
   they have been optimized by using a custom formatter.

 * Formatting object name in full hexadecimal form has been optimized
   by using a new strbuf_add_oid_hex() helper function.

 * Encourage original authors to monitor the CI status.

 * The `git log -L` implementation has been refactored to use the
   standard diff output pipeline, enabling pickaxe and diff-filter to
   work as expected. Additionally, metadata-only diff formats like
   --raw and --name-only are now supported with -L.

 * The loose object source has been refactored into a proper `struct
   odb_source`.

 * Guidelines on how to write a cover letter for a multi-patch series
   have been added to SubmittingPatches, which also got a new marker
   to separate the section for typofixes.

 * The setup logic to discover and configure repositories has been
   refactored, and the initialization of the object database has been
   centralized.

 * Many core configuration variables have been migrated from global
   variables into 'repo_config_values' to tie them to a specific
   repository instance, avoiding cross-repository state leakage.

 * Streaming revision walks have been optimized by using a priority queue
   for date-sorting commits, speeding up walks repositories with many
   merges.

 * A recent regression in t7527 that broke TAP output has been fixed,
   some other test noise that also broke TAP output has been silenced,
   and 'prove' is now configured to fail on invalid TAP output to
   prevent future regressions.

 * A handful of inappropriate uses of the_repository have been
   rewritten to use the right repository structure instance in the
   unpack-trees.c codepath.

 * "git index-pack" has been optimized by retaining child bases in the
   delta cache instead of immediately freeing them, letting the existing
   cache limit policy decide eviction.

 * `git ls-files --modified` and `git ls-files --deleted` have been
   optimized to filter with pathspec before calling lstat() when there is
   only a single pathspec item, avoiding unnecessary filesystem access
   for entries that will not be shown.

 * The UNUSED macro in 'compat/posix.h' has been updated to use a
   newly introduced GIT_CLANG_PREREQ macro for compiler version
   checks, and the existing GIT_GNUC_PREREQ macro has been modernized
   to use explicit major/minor comparisons rather than bit-shifting.

 * Wean the Windows builds in GitLab CI procedure away from
   (unfortunately unreliable) Chocolatey to install dependencies.
   (merge 0e7b51fed2 ps/gitlab-ci-windows later to maint).

 * Build-fix for 32-bit Windows.

 * Xcode 15 and later has a linker set to complain when the same library
   archive is listed twice on the command line.  Squelch the annoyance.


Fixes since v2.54
-----------------

 * Code clean-up to use the right instance of a repository instance in
   calls inside refs subsystem.
   (merge 57c590feb9 sp/refs-reduce-the-repository later to maint).

 * The check that implements the logic to see if an in-core cache-tree
   is fully ready to write out a tree object was broken, which has
   been corrected.
   (merge 521731213c dl/cache-tree-fully-valid-fix later to maint).

 * The test suite harness and many individual test scripts have been
   updated to work correctly when 'set -e' is in effect, which helps
   detect misspelled test commands.
   (merge ffe8005b9d ps/test-set-e-clean later to maint).

 * Revert a recent change that introduced a regression to help mksh users.

 * Update various GitHub Actions versions.

 * Avoid hitting the pathname limit for socks proxy socket during the
   test..

 * To help Windows 10 installations, avoid removing files whose
   contents are still mmap()'ed.

 * The 'git backfill' command now rejects revision-limiting options that
   are incompatible with its operation, uses standard documentation for
   revision ranges, and includes blobs from boundary commits by default
   to improve performance of subsequent operations.
   (merge a1ad4a0fca en/backfill-fixes-and-edges later to maint).

 * "git grep" update.
   (merge 9ff4b5ab1b rs/grep-column-only-match-fix later to maint).

 * Headers from glibc 2.43 when used with clang does not allow
   disabling C11 language features, causing build failures..

 * The 'http.emptyAuth=auto' configuration now correctly attempts
   Negotiate authentication before falling back to manual credentials.
   This allows seamless Kerberos ticket-based authentication without
   requiring users to explicitly set 'http.emptyAuth=true'.
   (merge 4919938d28 mc/http-emptyauth-negotiate-fix later to maint).

 * Ramifications of turning off commit-graph has been documented a bit
   more clearly.
   (merge 48c855bb8f kh/doc-commit-graph later to maint).

 * "git rebase --update-refs", when used with an rebase.instructionFormat
   with "%d" (describe) in it, tried to update local branch HEAD by
   mistake, which has been corrected.
   (merge 106b6885c7 ag/rebase-update-refs-limit-to-branches later to maint).

 * Tweak the way how sideband messages from remote are printed while
   we talk with a remote repository to avoid tickling terminal
   emulator glitches.
   (merge 31e8fcabd8 rs/sideband-clear-line-before-print later to maint).

 * The configuration variable submodule.fetchJobs was not read correctly,
   which has been corrected.
   (merge aa45a5902f sj/submodule-update-clone-config-fix later to maint).

 * Update code paths that assumed "unsigned long" was long enough for
   "size_t".
   (merge 7a094d68a2 js/objects-larger-than-4gb-on-windows later to maint).

 * Stop using unmaintained custom allocator in Windows build which was
   the last user of the code.

 * The computation to shorten the filenames shown in diffstat measured
   width of individual UTF-8 characters to add up, but forgot to take
   into account error cases (e.g., an invalid UTF-8 sequence, or a
   control character).
   (merge 09d86a3b98 en/diffstat-utf8-truncation-fix later to maint).

 * Some tests assume that bare repository accesses are by default
   allowed; rewrite some of them to avoid the assumption, rewrite
   others to explicitly set safe.bareRepository to allow them.
   (merge 985b38ca6c js/adjust-tests-to-explicitly-access-bare-repo later to maint).

 * Signing commit with custom encoding was passing the data to be
   signed at a wrong stage in the pipeline, which has been corrected.
   (merge 7735d7eee3 bc/sign-commit-with-custom-encoding later to maint).

 * Further update to the i18n alias support to avoid regressions.

 * "git fetch --deepen=<n>" in a full clone truncated the history to <n>
   commits deep, which has been corrected to be a no-op instead.
   (merge 2431f5e0e5 sp/shallow-deepen-on-non-shallow-repo-fix later to maint).

 * "git maintenance" that goes background did not use the lockfile to
   prevent multiple maintenance processes from running at the same
   time, which has been corrected.
   (merge 29364f1624 ps/maintenance-daemonize-lockfix later to maint).

 * Remove ineffective strbuf presizing that would have computed an
   allocation that would not have fit in the available memory anyway,
   or too small due to integer wraparound to cause immediate automatic
   growing.
   (merge a9ce8526dc jk/pretty-no-strbuf-presizing later to maint).

 * The HTTP walker misinterpreted the alternates file that gives an
   absolute path when the server URL does not have the final slash
   (i.e., "https://example.com" not "https://example.com/").
   (merge b92387cd55 jk/dumb-http-alternate-fix later to maint).

 * "git bisect" now uses the selected terms (e.g., old/new) more
   consistently in its output.
   (merge cb55991825 jr/bisect-custom-terms-in-output later to maint).

 * Update GitLab CI jobs that exercise macOS.
   (merge 62319b49bb ps/gitlab-ci-macOS-improvements later to maint).

 * "Friday noon" asked in the morning on Sunday was parsed to be one
   day before the specified time, which has been corrected.
   (merge b809304101 ta/approxidate-noon-fix later to maint).

 * The GIT_WORK_TREE variable prepared to invoke the push-to-checkout
   hook was leaking into the environment even when there was no hook
   used and broke the default push-to-deploy (i.e., let "git checkout"
   update the working tree only when the working tree is clean).
   (merge 44d04e4426 ar/receive-pack-worktree-env later to maint).

 * A batch of documentation pages has been updated to use the modern
   synopsis style.
   (merge 2ef248ae45 ja/doc-synopsis-style-again later to maint).

 * The "promisor.quiet" configuration variable was not used from
   relevant submodules when commands like "grep --recurse-submodules"
   triggered a lazy fetch, which has been corrected.
   (merge fa1468a1f7 th/promisor-quiet-per-repo later to maint).

 * Correct use of sockaddr API in "git daemon".
   (merge 422a5bf575 st/daemon-sockaddr-fixes later to maint).

 * A memory leak in `fetch_and_setup_pack_index()` when verification of
   the downloaded pack index fails has been plugged. Also an obsolete
   `unlink()` call on parse failure has been cleaned up.

 * In t3070-wildmatch, "via ls-files" test variants with patterns
   containing backslash escapes are now skipped on Windows, avoiding 36
   test failures caused by pathspec separator conversion.
   (merge 8c84e6802c kk/wildmatch-windows-ls-files-prereq later to maint).

 * A linker warning on macOS when building with Xcode 16.3 or newer has
   been avoided by passing -fno-common to the compiler when a
   sufficiently new linker is detected.
   (merge 5cd4d0d850 hn/macos-linker-warning later to maint).

 * Documentation and tests have been added to clarify that Git's internal
   raw timestamp format requires a `@` prefix for values less than
   100,000,000 to prevent ambiguity with other formats like YYYYMMDD.
   (merge 4018dc29ee ls/doc-raw-timestamp-prefix later to maint).

 * Wording used in "format-patch --subject-prefix" documentation
   has been improved.
   (merge 4a1eb9304a lo/doc-format-patch-subject-prefix later to maint).

 * Advanced emulation of kill() used on Windows in GfW has been
   upstreamed to improve the symptoms like left-behind .lock files and
   that fails to let the child clean-up itself when it gets killed.
   (merge 363f1d8b3a js/win-kill-child-more-gently later to maint).

 * The 'git describe --contains --all' command has been fixed to
   properly honor the '--match' and '--exclude' options by passing
   them down to 'git name-rev' with the appropriate reference
   prefixes.
   (merge 1891707d1b jk/describe-contains-all-match-fix later to maint).

 * Various typos, grammatical errors, and duplicated words in both
   documentation and code comments have been corrected.
   (merge dc6068df67 wy/docs-typofixes later to maint).

 * The subprocess handshake during startup has been made gentler by using
   packet_read_line_gently() instead of packet_read_line() to prevent the
   parent Git process from dying abruptly when a configured subprocess
   (e.g., a clean/smudge filter) fails to start.
   (merge 061a68e443 mm/subprocess-handshake-fix later to maint).

 * The TSAN race in transfer_debug() within transport-helper.c has been
   resolved by initializing the debug flag early in
   bidirectional_transfer_loop() before spawning worker threads, allowing
   the removal of a TSAN suppression.
   (merge 85704eda18 ps/transport-helper-tsan-fix later to maint).

 * 'git describe' has been taught to pass the 'refs/tags/' prefix down to
   the ref iterator when '--all' is not requested, avoiding unnecessary
   iteration over non-tag refs.
   (merge 55088ac8a4 td/describe-tag-iteration later to maint).

 * compute_reachable_generation_numbers() in commit-graph used a 32-bit
   integer to accumulate parent generations, which is OK for generation
   number v1 (topological levels), but with generation number v2
   (adjusted committer timestamps), it truncated timestamps beyond
   2106.  Fixed by widening the accumulator to timestamp_t.
   (merge fbcc5408fc en/commit-graph-timestamp-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 80f4b802e9 ja/doc-difftool-synopsis-style later to maint).
   (merge b96490241e jc/doc-timestamps-in-stat later to maint).
   (merge ef85286e51 ss/t7004-unhide-git-failures later to maint).
   (merge 7584d10bc2 mf/format-patch-cover-letter-format-docfix later to maint).
   (merge 8547908eb3 pw/rename-to-get-current-worktree later to maint).
   (merge 890229b3f3 sg/t6112-unwanted-tilde-expansion-fix later to maint).
   (merge ab9753e7bc kh/doc-restore-double-underscores-fix later to maint).
   (merge 4a9e097228 za/t2000-modernise-more later to maint).
   (merge b635fd0725 kh/doc-log-decorate-list later to maint).
   (merge 65ea197dca jk/commit-sign-overflow-fix later to maint).
   (merge 3ccb16052a jk/apply-leakfix later to maint).
   (merge 5e6e8dc786 tb/pseudo-merge-bugfixes later to maint).
   (merge 6d09e798bc pb/doc-diff-format-updates later to maint).
   (merge 34a891a2d3 rs/trailer-fold-optim later to maint).
   (merge 499f9048e0 ps/t3903-cover-stash-include-untracked later to maint).
   (merge b56ab270aa jk/sq-dequote-cleanup later to maint).
   (merge 29d9fdcf10 rs/use-builtin-add-overflow-explicitly-on-clang later to maint).
   (merge d9982e8290 ed/check-connected-close-err-fd-2.53 later to maint).
   (merge 1740cc35d0 ed/check-connected-close-err-fd later to maint).
   (merge f4d7eb3d1c sp/doc-range-diff-takes-notes later to maint).
   (merge 83e7f3bd2b kh/free-commit-list later to maint).
   (merge d1b72b29e9 am/doc-tech-hash-typofix later to maint).
   (merge 014c454799 ak/typofixes later to maint).
   (merge 522ea8ef7d js/osxkeychain-build-wo-rust later to maint).
   (merge e8f12e0e95 jc/t1400-fifo-cleanup later to maint).
   (merge 0bf506efd4 kw/gitattributes-typofix later to maint).

----------------------------------------------------------------

Changes since v2.54.0 are as follows:

Abhinav Gupta (2):
      rebase: ignore non-branch update-refs
      sequencer: remove todo_add_branch_context.commit

Adam Johnson (1):
      stash: reuse cached index entries in --patch temporary index

Adrian Ratiu (9):
      repository: fix repo_init() memleak due to missing _clear()
      config: add a repo_config_get_uint() helper
      hook: parse the hook.jobs config
      hook: allow pre-push parallel execution
      hook: add per-event jobs config
      hook: warn when hook.<friendly-name>.jobs is set
      hook: move is_known_hook() to hook.c for wider use
      hook: add hook.<event>.enabled switch
      hook: allow hook.jobs=-1 to use all available CPU cores

Aindriú Mac Giolla Eoin (1):
      l10n: ga.po: update for Git 2.55

Alexander Monakov (1):
      doc: fix typo in GIT_ALTERNATE_OBJECT_DIRECTORIES

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (6322t)

Aliwoto (1):
      http: reject unsupported proxy URL schemes

Alyssa Ross (1):
      receive-pack: fix updateInstead with core.worktree

Andrew Kreimer (1):
      doc: fix typos via codespell

Arijit Banerjee (1):
      index-pack: retain child bases in delta cache

Arkadii Yakovets (1):
      l10n: uk: add 2.55 translation

Bagas Sanjaya (1):
      l10n: po-id for 2.55

Christian Couder (10):
      promisor-remote: try accepted remotes before others in get_direct()
      promisor-remote: pass config entry to all_fields_match() directly
      promisor-remote: clarify that a remote is ignored
      promisor-remote: reject empty name or URL in advertised remote
      promisor-remote: refactor should_accept_remote() control flow
      promisor-remote: refactor has_control_char()
      promisor-remote: refactor accept_from_server()
      promisor-remote: keep accepted promisor_info structs alive
      promisor-remote: remove the 'accepted' strvec
      t5710: use proper file:// URIs for absolute paths

D. Ben Knoble (1):
      ignore: note info/exclude lives in GIT_COMMON_DIR, not GIT_DIR

David Lin (1):
      cache-tree: fix inverted object existence check in cache_tree_fully_valid

Derrick Stolee (20):
      t5516: fix test order flakiness
      fetch: add --negotiation-restrict option
      transport: rename negotiation_tips
      remote: add remote.*.negotiationRestrict config
      negotiator: add have_sent() interface
      fetch: add --negotiation-include option for negotiation
      remote: add remote.*.negotiationInclude config
      send-pack: pass negotiation config in push
      t5620: make test work with path-walk var
      pack-objects: pass --objects with --path-walk
      t/perf: add pack-objects filter and path-walk benchmark
      path-walk: always emit directly-requested objects
      path-walk: support blobless filter
      backfill: die on incompatible filter options
      path-walk: support blob size limit filter
      path-walk: add pl_sparse_trees to control tree pruning
      pack-objects: support sparse:oid filter with path-walk
      t6601: tag otherwise-unreachable trees
      t1092: test 'git restore' with sparse index
      restore: avoid sparse index expansion

Dominik Loidolt (3):
      compat/posix.h: enable UNUSED warning messages for Clang
      compat/posix.h: clean up GIT_GNUC_PREREQ() and UNUSED
      compat/posix.h: simplify GIT_GNUC_PREREQ() comparison

Elijah Newren (10):
      backfill: reject rev-list arguments that do not make sense
      backfill: document acceptance of revision-range in more standard manner
      backfill: default to grabbing edge blobs too
      diff: fix out-of-bounds reads and NULL deref in diffstat UTF-8 truncation
      merge-ort: handle cached rename & trivial resolution interaction better
      promisor-remote: document caller filtering contract
      patch-ids.h: add missing trailing parenthesis in documentation comment
      builtin/log: prefetch necessary blobs for `git cherry`
      grep: prefetch necessary blobs
      commit-graph: use timestamp_t for max parent generation accumulator

Emily Shaffer (3):
      hook: allow parallel hook execution
      hook: mark non-parallelizable hooks
      hook: add -j/--jobs option to git hook run

Emir SARI (1):
      l10n: tr: Update Turkish translations

Ethan Dickson (1):
      connected: close err_fd in promisor fast-path

Ezekiel Newren (6):
      xdiff/xdl_cleanup_records: delete local recs pointer
      xdiff: use unambiguous types in xdl_bogo_sqrt()
      xdiff/xdl_cleanup_records: use unambiguous types
      xdiff/xdl_cleanup_records: make limits more clear
      xdiff/xdl_cleanup_records: make setting action easier to follow
      xdiff/xdl_cleanup_records: make execution of action easier to follow

Greg Hurrell (1):
      git-jump: pick a mode automatically when invoked without arguments

Harald Nordgren (10):
      stash: add --label-ours, --label-theirs, --label-base for apply
      sequencer: allow create_autostash to run silently
      sequencer: teach autostash apply to take optional conflict marker labels
      checkout: rollback lock on early returns in merge_working_tree
      checkout -m: autostash when switching branches
      config.mak.uname: avoid macOS linker warning on Xcode 16.3+
      config: add git_config_key_is_valid() for quiet validation
      config: improve diagnostic for "set" with missing value
      git-gui: silence install recipes under "make -s"
      config.mak.uname: avoid macOS dup-library warning

Ivan Baluta (1):
      doc: clarify push.default=simple behavior

Jacob Keller (1):
      describe: fix --exclude, --match with --contains and --all

Jayesh Daga (1):
      unpack-trees: use repository from index instead of global

Jean-Noël Avila (12):
      doc: convert git-difftool manual page to synopsis style
      doc: convert git-range-diff manual page to synopsis style
      doc: convert git-shortlog manual page to synopsis style
      doc: convert git-describe manual page to synopsis style
      doc: convert git-bisect to synopsis style
      doc: git bisect: clarify the usage of the synopsis vs actual command
      doc: convert git-grep synopsis and options to new style
      doc: convert git-am synopsis and options to new style
      doc: convert git-apply synopsis and options to new style
      doc: convert git-imap-send synopsis and options to new style
      l10n: fr: version 2.55
      l10n: fr: mass fix of typos

Jeff King (14):
      t1800: test SIGPIPE with parallel hooks
      Revert "transport-helper, connect: use clean_on_exit to reap children on abnormal exit"
      pretty: drop strbuf pre-sizing from add_rfc2047()
      http: handle absolute-path alternates from server root
      apply: plug leak on "patch too large" error
      commit: handle large commit messages in utf8 verification
      quote.h: bump strvec forward declaration to the top
      quote: drop sq_dequote_to_argv()
      quote: simplify internals of dequoting
      connect: use "service" enum for "name" argument
      commit: fall back to full read when maybe_tree is NULL
      transport-helper: fix typo in BUG() message
      t/lib-httpd: bump apache timeout
      t5551: put many-tags case into its own repo

Jiang Xin (1):
      l10n: AGENTS.md: add quotation mark preservation guidelines

Johannes Schindelin (49):
      sideband: mask control characters
      sideband: introduce an "escape hatch" to allow control characters
      sideband: do allow ANSI color sequences by default
      sideband: add options to allow more control sequences to be passed through
      sideband: offer to configure sanitizing on a per-URL basis
      test-lib: allow bare repository access when breaking changes are enabled
      t7900: do not let `$HOME/.gitconfig` interfere with XDG tests
      t1300: remove global config settings injected by test-lib.sh
      t1305: use `--git-dir=.` for bare repo in include cycle test
      t5601: restore `.gitconfig` after includeIf test
      ls-files tests: filter `.gitconfig` from `--others` output
      status tests: filter `.gitconfig` from status output
      safe.bareRepository: default to "explicit" with WITH_BREAKING_CHANGES
      t5564: use a short path for the SOCKS proxy socket
      ci: bump microsoft/setup-msbuild from v2 to v3
      ci: bump actions/{upload,download}-artifact to v7 and v8
      ci: bump actions/github-script from v8 to v9
      ci: bump actions/checkout from v5 to v6
      ci: bump git-for-windows/setup-git-for-windows-sdk from v1 to v2
      l10n: bump mshick/add-pr-comment from v2 to v3
      mingw: optionally use legacy (non-POSIX) delete semantics
      maintenance(geometric): do release the `.idx` files before repacking
      mingw: stop using nedmalloc
      mingw: drop the build-system plumbing for nedmalloc
      mingw: remove the vendored compat/nedmalloc/ subtree
      index-pack, unpack-objects: use size_t for object size
      git-zlib: handle data streams larger than 4GB
      odb, packfile: use size_t for streaming object sizes
      delta, packfile: use size_t for delta header sizes
      test-tool: add a helper to synthesize large packfiles
      t5608: add regression test for >4GB object clone
      test-tool synthesize: use the unsafe hash for speed
      test-tool synthesize: precompute pack for 4 GiB + 1
      test-tool synthesize: add precomputed SHA-256 pack for 4 GiB + 1
      t5608: mark >4GB tests as EXPENSIVE
      ci: run expensive tests on push builds to integration branches
      mingw: kill child processes in a gentler way
      mingw: really handle SIGINT
      compat/msvc: use _chsize_s for ftruncate
      patch-delta: use size_t for sizes
      pack-objects(check_pack_inflate()): use size_t instead of unsigned long
      packfile: widen unpack_entry()'s size out-parameter to size_t
      pack-objects: use size_t for in-core object sizes
      packfile,delta: drop the `cast_size_t_to_ulong()` wrappers
      odb: use size_t for object_info.sizep and the size APIs
      osxkeychain: fix build with Rust
      zlib: properly clamp to uLong
      win32: ensure that `localtime_r()` is declared even in i686 builds
      http: accept https:// proxies again

Johannes Sixt (2):
      userdiff: tighten word-diff test case of the scheme driver
      git-gui: remove unnecessary 'cd $_gitworktree' from do_gitk

Jonas Rebmann (3):
      bisect: use selected alternate terms in status output
      bisect: print bisect terms in single quotes
      rev-parse: use selected alternate terms to look up refs

Jonatan Holmgren (1):
      alias: restore support for simple dotted aliases

Junio C Hamano (30):
      sideband: drop 'default' configuration
      CodingGuidelines: st_mtimespec vs st_mtim vs st_mtime
      t5551: "GIT_TEST_LONG=Yes make test" is broken
      ci: enable EXPENSIVE for contributor builds
      Start 2.55 cycle
      The second batch
      The 3rd batch
      The 4th batch
      The 5th batch
      The 6th batch
      Start preparing for 2.54.1
      The 7th batch
      The 8th batch
      SubmittingPatches: proactively monitor GHCI pages
      The 9th batch
      The 10th batch
      The 11th batch
      SubmittingPatches: separate typofixes section
      SubmittingPatches: describe cover letter
      The 12th batch
      The 13th batch
      Git 2.55-rc0
      t1400: have fifo test clean after itself
      topic flush before -rc1 (batch 1)
      topic flush before -rc1 (batch 2)
      Git 2.55-rc1
      Hopefully final batch before -rc2
      A few more topics before -rc2
      Git 2.55-rc2
      Git 2.55

Justin Tobler (7):
      odb: split `struct odb_transaction` into separate header
      odb/transaction: use pluggable `begin_transaction()`
      odb: update `struct odb_write_stream` read() callback
      object-file: remove flags from transaction packfile writes
      object-file: avoid fd seekback by checking object size upfront
      object-file: generalize packfile writes to use odb_write_stream
      odb/transaction: make `write_object_stream()` pluggable

Karthik Nayak (10):
      refs: remove unused typedef 'ref_transaction_commit_fn'
      refs: introduce `ref_store_init_options`
      refs: extract out reflog config to generic layer
      refs: return `ref_transaction_error` from `ref_transaction_update()`
      update-ref: move `print_rejected_refs()` up
      update-ref: handle rejections while adding updates
      refs: move object parsing to the generic layer
      refs: add peeled object ID to the `ref_update` struct
      refs: use peeled tag values in reference backends
      refs/files: skip lock files during consistency checks

Koutian Wu (1):
      gitattributes: fix eol attribute for Perl scripts

Kristofer Karlsson (13):
      commit-reach: introduce merge_base_flags enum
      commit-reach: early exit paint_down_to_common for single merge-base
      merge: use repo_in_merge_bases for octopus up-to-date check
      revision: use priority queue in limit_list()
      commit-reach: use object flags for tips_reachable_from_bases()
      t6600: add tests for duplicate tips in tips_reachable_from_bases()
      object.h: fix stale entries in object flag allocation table
      commit-reach: deduplicate queue entries in paint_down_to_common
      commit-reach: replace queue_has_nonstale() scan with O(1) tracking
      pack-objects: call release_revisions() after cruft traversal
      revision: introduce rev_walk_mode to clarify get_revision_1()
      revision: use priority queue for non-limited streaming walks
      t3070: skip ls-files tests with backslash patterns on Windows

Kristoffer Haugsbakk (15):
      doc: log: fix --decorate description list
      doc: log: use the same delimiter in description list
      doc: restore: remove double underscore
      doc: add caveat about turning off commit-graph
      name-rev: wrap both blocks in braces
      name-rev: run clang-format before factoring code
      name-rev: factor code for sharing with a new command
      name-rev: make dedicated --annotate-stdin --name-only test
      format-rev: introduce builtin for on-demand pretty formatting
      doc: hook: remove stray backtick
      doc: hook: consistently capitalize Git
      doc: config: include existing git-hook(1) section
      doc: hook: don’t self-link via config include
      *: replace deprecated free_commit_list
      commit: remove deprecated functions

LorenzoPegorari (2):
      http: cleanup function fetch_and_setup_pack_index()
      http: fix memory leak in fetch_and_setup_pack_index()

Lucas Seiki Oshiro (1):
      Documentation: remove redundant 'instead' in --subject-prefix

Lumynous (1):
      l10n: zh-TW.po: Update Chinese (Traditional) translation

Luna Schwalbe (1):
      doc: document and test `@` prefix for raw timestamps

Mark Levedahl (11):
      git-gui: use HEAD as current branch when detached
      git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
      git-gui: do not change global vars in choose_repository::pick
      git-gui: use --absolute-git-dir
      git-gui: use rev-parse exclusively to find a repository
      git-gui: use git rev-parse for worktree discovery
      git-gui: simplify [is_bare] to report if a worktree is known
      git-gui: try harder to find worktree from gitdir
      git-gui: allow specifying path '.' to the browser
      git-gui: check browser/blame arguments carefully
      git-gui: add gui and pick as explicit subcommands

Matheus Afonso Martins Moreira (8):
      connect: rename enum protocol to url_scheme
      url: move url_is_local_not_ssh to url.h
      url: move scheme detection to URL header/source
      url: return URL_SCHEME_UNKNOWN instead of dying
      urlmatch: define url_parse function
      builtin: create url-parse command
      doc: describe the url-parse builtin
      t9904: add tests for the new url-parse builtin

Matteo Beniamino (1):
      l10n: it: fix italian usage messages alignment

Matthew John Cheetham (4):
      http: extract http_reauth_prepare() from retry paths
      http: attempt Negotiate auth in http.emptyAuth=auto mode
      t5563: add tests for http.emptyAuth with Negotiate
      doc: clarify http.emptyAuth values

Michael Montalbo (9):
      diff: reject negative values for --inter-hunk-context
      diff: reject negative values for -U/--unified
      xdiff: guard against negative context lengths
      parse-options: clarify what "negated" means for PARSE_OPT_NONEG
      doc: clarify that --word-diff operates on line-level hunks
      revision: move -L setup before output_format-to-diff derivation
      line-log: integrate -L output with the standard log-tree pipeline
      line-log: allow non-patch diff formats with -L
      sub-process: use gentle handshake to avoid die() on startup failure

Mikel Forcada (1):
      l10n: ca.po: update Catalan translation

Mirko Faina (3):
      Fix docs for format.commitListFormat
      revision.c: implement --max-count-oldest
      bash-completions: add --max-count-oldest

Olamide Caleb Bello (8):
      environment: move "trust_ctime" into `struct repo_config_values`
      environment: move "check_stat" into `struct repo_config_values`
      environment: move `zlib_compression_level` into `struct repo_config_values`
      environment: move "pack_compression_level" into `struct repo_config_values`
      environment: move "precomposed_unicode" into `struct repo_config_values`
      environment: move "core_sparse_checkout_cone" into `struct repo_config_values`
      environment: move "sparse_expect_files_outside_of_patterns" into `struct repo_config_values`
      environment: move "warn_on_object_refname_ambiguity" into `struct repo_config_values`

Pablo Sabater (3):
      graph: limit the graph width to a hard-coded max
      graph: add --graph-lane-limit option
      graph: add truncation mark to capped lanes

Patrick Steinhardt (91):
      t: prepare `test_match_signal ()` calls for `set -e`
      t: prepare `test_must_fail ()` for `set -e`
      t: prepare `stop_git_daemon ()` for `set -e`
      t: prepare `git config --unset` calls for `set -e`
      t: prepare conditional test execution for `set -e`
      t: prepare execution of potentially failing commands for `set -e`
      t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
      t0008: silence error in subshell when using `grep -v`
      t1301: don't fail in case setfacl(1) doesn't exist or fails
      t6002: fix use of `expr` with `set -e`
      t9902: fix use of `read` with `set -e`
      t: detect errors outside of test cases
      replay: allow callers to control what happens with empty commits
      builtin/history: generalize function to commit trees
      builtin/history: introduce "fixup" subcommand
      build: tolerate use of _Generic from glibc 2.43 with Clang
      builtin/maintenance: fix locking with "--detach"
      run-command: honor "gc.auto" for auto-maintenance
      odb: introduce "in-memory" source
      odb/source-inmemory: implement `free()` callback
      odb: fix unnecessary call to `find_cached_object()`
      odb/source-inmemory: implement `read_object_info()` callback
      odb/source-inmemory: implement `read_object_stream()` callback
      odb/source-inmemory: implement `write_object()` callback
      odb/source-inmemory: implement `write_object_stream()` callback
      cbtree: allow using arbitrary wrapper structures for nodes
      oidtree: add ability to store data
      odb/source-inmemory: convert to use oidtree
      odb/source-inmemory: implement `for_each_object()` callback
      odb/source-inmemory: implement `find_abbrev_len()` callback
      odb/source-inmemory: implement `count_objects()` callback
      odb/source-inmemory: implement `freshen_object()` callback
      odb/source-inmemory: stub out remaining functions
      odb: generic in-memory source
      t/unit-tests: add tests for the in-memory object source
      setup: replace use of `the_repository` in static functions
      setup: stop using `the_repository` in `is_inside_git_dir()`
      setup: stop using `the_repository` in `is_inside_work_tree()`
      setup: stop using `the_repository` in `prefix_path()`
      setup: stop using `the_repository` in `path_inside_repo()`
      setup: stop using `the_repository` in `verify_filename()`
      setup: stop using `the_repository` in `verify_non_filename()`
      setup: stop using `the_repository` in `enter_repo()`
      setup: stop using `the_repository` in `setup_work_tree()`
      setup: stop using `the_repository` in `set_git_work_tree()`
      setup: stop using `the_repository` in `setup_git_env()`
      setup: stop using `the_repository` in `setup_git_directory_gently()`
      setup: stop using `the_repository` in `setup_git_directory()`
      setup: stop using `the_repository` in `upgrade_repository_format()`
      setup: stop using `the_repository` in `check_repository_format()`
      setup: stop using `the_repository` in `initialize_repository_version()`
      setup: stop using `the_repository` in `create_reference_database()`
      setup: stop using `the_repository` in `init_db()`
      gitlab-ci: upgrade macOS runners
      gitlab-ci: update macOS image
      odb/source-loose: move loose source into "odb/" subsystem
      odb/source-loose: store pointer to "files" instead of generic source
      odb/source-loose: start converting to a proper `struct odb_source`
      odb/source-loose: wire up `reprepare()` callback
      odb/source-loose: wire up `close()` callback
      odb/source-loose: wire up `read_object_info()` callback
      odb/source-loose: wire up `read_object_stream()` callback
      odb/source-loose: wire up `for_each_object()` callback
      odb/source-loose: wire up `find_abbrev_len()` callback
      odb/source-loose: wire up `count_objects()` callback
      odb/source-loose: drop `odb_source_loose_has_object()`
      odb/source-loose: wire up `freshen_object()` callback
      loose: refactor object map to operate on `struct odb_source_loose`
      odb/source-loose: wire up `write_object()` callback
      object-file: refactor writing objects to use loose source
      odb/source-loose: wire up `write_object_stream()` callback
      odb/source-loose: stub out remaining callbacks
      odb/source-loose: drop pointer to the "files" source
      gitlab-ci: rearrange Linux jobs to match GitHub's order
      gitlab-ci: add missing Linux jobs
      ci: unify Linux images across GitLab and GitHub
      t7527: fix broken TAP output
      t7810: turn MB_REGEX check into a lazy prereq
      t/test-lib: silence EBUSY errors on Windows during test cleanup
      t/lib-git-p4: silence output when killing p4d and its watchdog
      t: let prove fail when parsing invalid TAP output
      t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
      setup: drop `setup_git_env()`
      setup: deduplicate logic to apply repository format
      repository: stop initializing the object database in `repo_set_gitdir()`
      setup: stop creating the object database in `setup_git_env()`
      setup: stop initializing object database without repository
      repository: stop reading loose object map twice on repo init
      setup: construct object database in `apply_repository_format()`
      gitlab-ci: migrate Windows builds away from Chocolatey
      t4216: fix no-op test that breaks TAP output

Paul Tarjan (13):
      t9210, t9211: disable GIT_TEST_SPLIT_INDEX for scalar clone tests
      fsmonitor: fix khash memory leak in do_handle_client
      fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
      compat/win32: add pthread_cond_timedwait
      fsmonitor: use pthread_cond_timedwait for cookie wait
      fsmonitor: rename fsm-ipc-darwin.c to fsm-ipc-unix.c
      fsmonitor: rename fsm-settings-darwin.c to fsm-settings-unix.c
      fsmonitor: implement filesystem change listener for Linux
      run-command: add close_fd_above_stderr option
      fsmonitor: close inherited file descriptors and detach in daemon
      fsmonitor: add timeout to daemon stop command
      fsmonitor: add tests for Linux
      fsmonitor: convert shown khash to strset in do_handle_client

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Philippe Blain (3):
      diff-format.adoc: remove mention of diff-tree specific output
      diff-format.adoc: 'git diff-files' prints two lines for unmerged files
      diff-format.adoc: mode and hash are 0* for unmerged paths from index only

Phillip Wood (5):
      worktree: rename get_worktree_from_repository()
      xdiff: reduce size of action arrays
      xdiff: cleanup xdl_clean_mmatch()
      xprepare: simplify error handling
      xdiff: reduce the size of array

Pushkar Singh (2):
      stash: add coverage for show --include-untracked
      transport-helper: fix TSAN race in transfer_debug()

René Scharfe (10):
      grep: fix --column --only-match for 2nd and later matches
      sideband: clear full line when printing remote messages
      strbuf: add strbuf_add_uint()
      cat-file: use strbuf_add_uint()
      ls-files: use strbuf_add_uint()
      ls-tree: use strbuf_add_uint()
      hex: add and use strbuf_add_oid_hex()
      trailer: change strbuf in-place in unfold_value()
      strbuf: use st_add3() in strbuf_grow()
      use __builtin_add_overflow() in st_add() with Clang

Rob McDonald (1):
      gitk: add horizontal scrollbar to the commit list pane

SZEDER Gábor (1):
      t6112: avoid tilde expansion

Saagar Jha (1):
      submodule-config: fix reading submodule.fetchJobs

Samo Pogačnik (1):
      shallow: fix relative deepen on non-shallow repositories

Scott Bauersfeld (1):
      index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB

Scott L. Burson (1):
      userdiff: extend Scheme support to cover other Lisp dialects

Sebastien Tardif (3):
      daemon: fix IPv6 address corruption in lookup_hostname()
      daemon: fix IPv6 address truncation in ip2str()
      daemon: guard NULL REMOTE_PORT in execute() logging

Shreyansh Paliwal (3):
      refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
      refs: remove the_hash_algo global state
      refs/reftable-backend: drop uses of the_repository

Siddh Raman Pant (1):
      Documentation/git-range-diff: add missing notes options in synopsis

Siddharth Asthana (1):
      cat-file: add mailmap subcommand to --batch-command

Siddharth Shrimali (3):
      t7004: drop hardcoded tag count for state verification
      t7004: dynamically grab expected state in tests
      t7004: avoid subshells to capture git exit codes

Tamir Duberstein (2):
      describe: limit default ref iteration to tags
      ls-files: filter pathspec before lstat

Taylor Blau (36):
      t/helper: add 'test-tool bitmap write' subcommand
      t5333: demonstrate various pseudo-merge bugs
      pack-bitmap-write: sort pseudo-merge commit lookup table in pack order
      pack-bitmap: fix inverted binary search in `pseudo_merge_at()`
      pack-bitmap: fix pseudo-merge lookup for shared commits
      pack-bitmap: parse commits in `find_pseudo_merge_group_for_ref()`
      pack-bitmap: reject pseudo-merge "sampleRate" of 0
      Documentation: fix broken `sampleRate` in gitpacking(7)
      pack-bitmap: prevent pattern leak on pseudo-merge re-assignment
      midx-write: handle noop writes when converting incremental chains
      midx: use `strset` for retained MIDX files
      midx: build `keep_hashes` array in order
      midx: use `strvec` for `keep_hashes`
      midx: introduce `--no-write-chain-file` for incremental MIDX writes
      midx: support custom `--base` for incremental MIDX writes
      repack: track the ODB source via existing_packs
      midx: expose `midx_layer_contains_pack()`
      repack-midx: factor out `repack_prepare_midx_command()`
      repack-midx: extract `repack_fill_midx_stdin_packs()`
      repack-geometry: prepare for incremental MIDX repacking
      builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
      packfile: ensure `close_pack_revindex()` frees in-memory revindex
      repack: implement incremental MIDX repacking
      repack: introduce `--write-midx=incremental`
      repack: allow `--write-midx=incremental` without `--geometric`
      path-walk: support `tree:0` filter
      path-walk: support `object:type` filter
      path-walk: support `combine` filter
      pack-bitmap: pass object position to `fill_bitmap_tree()`
      pack-bitmap: check subtree bits before recursing
      pack-bitmap: reuse stored selected bitmaps
      pack-bitmap: consolidate `find_object_pos()` success path
      pack-bitmap: cache object positions during fill
      pack-bitmap: sort bitmaps before XORing
      pack-bitmap: remember pseudo-merge parents
      pack-bitmap: build pseudo-merge bitmaps after regular bitmaps

Toon Claes (1):
      generate-configlist: collapse depfile for older Ninja

Trieu Huynh (1):
      promisor-remote: fix promisor.quiet to use the correct repository

Tuomas Ahola (8):
      approxidate: make "today" wrap to midnight
      t0006: add support for approxidate test date adjustment
      approxidate: make "specials" respect fixed day-of-month
      approxidate: use deferred mday adjustments for "specials"
      docs: fix typos
      doc: config: terminate runaway lists
      doc: config/sideband: fix description list delimiter
      doc: git-config: escape erroneous highlight markup

Usman Akinyemi (3):
      remote: fix sign-compare warnings in push_cas_option
      remote: move remote group resolution to remote.c
      push: support pushing to a remote group

Weijie Yuan (1):
      docs: fix typos and grammar

Zakariyah Ali (1):
      t2000: consolidate second scenario into a single test block

brian m. carlson (6):
      docs: update version with default Rust support
      ci: install cargo on Alpine
      Linux: link against libdl
      Enable Rust by default
      commit: name UTF-8 function appropriately
      commit: sign commit after mutating buffer

lilydjwg (2):
      l10n: TEAMS: change Simplified Chinese team leader
      l10n: zh_CN: updated translation for 2.55


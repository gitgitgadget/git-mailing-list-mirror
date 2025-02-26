Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F42222CF;
	Wed, 26 Feb 2025 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594997; cv=none; b=OE5Wor2IMTH7HtDTK1wrNK+HaiLqp4Ajf6GdwMQx+hBeYogm3GPWIQ011Rgv4AUWvHKuce8ue/OjVtbcp8FGeHHk77setcDcKFYqMNke6qpDiF2vjTsk8KobMKcuyU4yCuC9NbxoMl7vb7uWaMAc6e028hPpF4CU9klhSIzlk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594997; c=relaxed/simple;
	bh=WL+roedfS56kehq+xn9aiCkFQE1jkL29JgDNUHnI9x4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d2IoEwmoWMH3rixwv11VMmHK5Mb2rpexG4DTQqG5P/CX+iPlGerhJydrj6W2CkVYp73Cg0R3JiCbNZvVUF/+KURJ2DXE50fYkB44+kUCiCVmIslK2kcJC0EfOHXRNf4ZmeDTkaHwUBob+Vz8W5F089JyHl2TF6EdjEX4EPWtOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h8mMNW3Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zZBIN3di; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h8mMNW3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zZBIN3di"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E0A61381123;
	Wed, 26 Feb 2025 13:36:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 13:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1740594993; x=1740681393; bh=mB
	wJkAsGAV+kQra4ZoFVsmcV4rvDw6/U99AqcmBXHsk=; b=h8mMNW3Qe6Qv2JLWs4
	2BIeTegvWvCUB2zlQh4DcktEw9s396sCkOrlVmgHFsXrlY4iROGALcBbviTaP7aJ
	SXHFwLIpvneOz+erB3B/s7dDJKE9UY+qSD6KcdoQbY1FltRKrSn8U0YT6GFr0FxE
	uNUsJ0OXAh/B1LsIUKidbnyZCGhC0baeK/ey4c2A3UH6mMVPK1EW3hzuoYbiVllf
	dwBG1xme+ZgJbdyzvxYqK4WFBq5zjgb/yylVYK/pH+gfhPpJgPA0zcanPsv2vr8z
	ZOOwC3RhjTlHXW/S/2rTeCWOH5DQtKBHvOLwMTB8qX5HWB8eO55DF2wTos76DebJ
	nMIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1740594993; x=1740681393; bh=mBwJkAsGAV+kQra4ZoFVsmcV4rvD
	w6/U99AqcmBXHsk=; b=zZBIN3diDNWWe6hzynCwCQ/AZpCjjX/bEihL4DcI68sJ
	rj1Fsn5/KVt2vUTxDm5Okx1C5swv4iYbFv7z606KREArvn+L5O7L0hWr06Nhb986
	K+D4fLX1YDOQWv1YB47aydc3Hbitjx6QjvY2I1krXhO1fq0Y3ttroJ10Cxa4IdRU
	vYdX2KUhqTDZA+a0Dubz4TlWnRzIe/PxwatTV1CAYLVt1Q5i2x5y70emfMs3tzEz
	csvPpIkUyVutWw0sH1YNj4HtSqKx2tUoJ7YgjQTc2fGXa28WJFKNLLjZQjmTmiB6
	59/CWML3Rf1BsUVV+H1w2rGpfOiA/YuQ3tQCQySeRg==
X-ME-Sender: <xms:MV-_Z2sWVZHBSbl7SHWUHJb6l4fsCPn57drnhWthj1mGBenxkC8j8g>
    <xme:MV-_Z7fJ-A9X2xJzgAWxBNaDuDOCBYagmkO4uWWz8pTiCd966R6uLDVwDuDxwq1us
    QB1DylB-gPoFKyL_A>
X-ME-Received: <xmr:MV-_ZxylPPCNjZVl3GMrPJ4UbniJEmCFttemhhA9Xzon8tX_44nj-7md5wJF2yBIFemdskcLTZ-lDJyQIzfhk0BaWTuKerHsblGB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheefudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:MV-_ZxPh3IjqRnwZVpLKERDcTQpwfVhpmprXO6McUxoWDbR2y-6F8A>
    <xmx:MV-_Z2-rCuyMkfnoyth81MGRaoA-ExOFgXAZBWZrJR0z3uwJHd-kLA>
    <xmx:MV-_Z5VUy-OkfupbdsbWZek_QvNtC8xiBWfhxCq9JiPBkXRWMgyoHw>
    <xmx:MV-_Z_dyik3qU0AmuKJryPBhPwLmNq0F_-MHL3abk4cMNFbJOS1zow>
    <xmx:MV-_Z9n15QZicocdwIrWQXnesGSQFkO-2S4fhFR3iwJ7sDqGtomyskNW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 13:36:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.49.0-rc0
Date: Wed, 26 Feb 2025 10:36:31 -0800
Message-ID: <xmqqzfi8bljk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

An early preview release Git v2.49.0-rc0 is now available for
testing at the usual places.  It is comprised of 326 non-merge
commits since v2.48.0, contributed by 65 people, 15 of which are
new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.49.0-rc0' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.48.0 are as follows.
Welcome to the Git development community!

  Adam Murray, ambar chakravartty, Andrew Carter, Ayush Chandekar,
  Eliah Kagan, Evan Martin, Gabriel Amaral, James J. Raden,
  Jared Van Bortel, Koakuma, Lucas Oshiro, Matteo Bagnolini,
  Olga Pilipenco, Ross Goldberg, and Roy Eldar.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, Adam Johnson, Alecs King, Alexander Shopov,
  Bence Ferdinandy, brian m. carlson, Calvin Wan, Christian Couder,
  Christian Hesse, David Aguilar, D. Ben Knoble, Derrick Stolee,
  Elijah Newren, Eric Sunshine, Jacob Keller, Jan Palus, Jean-Noël
  Avila, Jeff King, Jiang Xin, Johannes Schindelin, Jonathan Tan,
  Josh Steadmon, Julian Prein, Junio C Hamano, Justin Tobler,
  Karsten Blees, Karthik Nayak, Kyle Lippincott, Matthew Hughes,
  Meet Soni, M Hickford, Michael Haggerty, Mike Hommey, Nika
  Layzell, Patrick Steinhardt, Peter Oliver, Phillip Wood, Piotr
  Szlazak, Randall S. Becker, Renato Botelho, René Scharfe, Sam
  James, Scott Chacon, Sebastian Schuberth, Seyi Kuforiji, Sören
  Krecker, Taylor Blau, Toon Claes, Usman Akinyemi, and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.49 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * Completion script updates for zsh

 * "git pack-objects" and its wrapper "git repack" learned an option
   to use an alternative path-hash function to improve delta-base
   selection to produce a packfile with deeper history than window
   size.

 * "git gc" learned the "--expire-to" option and passes it down to
   underlying "git repack".

 * "[help] autocorrect = 1" used to be a way to say "please wait for
   0.1 second after suggesting a typofix of the command name before
   running that command"; now it means "yes, if there is a plausible
   typofix for the command name, please run it immediately".

 * "git clone" learned to make a shallow clone for a single commit
   that is not necessarily be at the tip of any branch.

 * Lazy-loading missing files in a blobless clone on demand is costly
   as it tends to be one-blob-at-a-time.  "git backfill" is introduced
   to help bulk-download necessary files beforehand.

 * "git push --atomic --porcelain" used to ignore failures from the
   other side, losing the error status from the child process, which
   has been corrected.

 * "git rev-list --missing=" learned to accept "print-info" that gives
   known details expected of the missing objects, like path and type.

 * Comes with an updated "gitk".

 * The documentation of "git commit" and "git rebase" now refer to
   commit titles as such, not "subject".


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * More -Wsign-compare fixes.

 * meson-based build now supports the unsafe-sha1 build knob.

 * The code to check LSan results has been simplified and made more
   robust.
   (merge 164a2516eb jk/lsan-race-ignore-false-positive later to maint).

 * More code paths have a repository passed through the callchain,
   instead of assuming the primary the_repository object.

 * Move a few more unit tests to the clar test framework.

 * Introduce a new API to visit objects in batches based on a common
   path, or by type.

 * Following the procedure we established to introduce breaking
   changes for Git 3.0, allow an early opt-in for removing support of
   $GIT_DIR/branches/ and $GIT_DIR/remotes/ directories to configure
   remotes.

 * The code paths to interact with zlib has been cleaned up in
   preparation for building with zlib-ng.

 * Foreign language interface for Rust into our code base has been added.

 * All the documentation .txt files have been renamed to .adoc to help
   content aware editors.

 * "git difftool" code clean-up.


Fixes since v2.48
-----------------

 * "git submodule" learned various ways to spell the same option,
   e.g. "--branch=B" can be spelled "--branch B" or "-bB".
   (merge b86f0f9071 re/submodule-parse-opt later to maint).

 * Tweak the help text used for the option value placeholders by
   parse-options API so that translations can customize the "<>"
   placeholder signal (e.g. "--option=<value>").
   (merge 5b34dd08d0 as/long-option-help-i18n later to maint).

 * CI jobs gave sporadic failures, which turns out that that the
   object finalization code was giving an error when it did not have
   to.
   (merge d7fcbe2c56 ps/object-collision-check later to maint).

 * The code to compute "unique" name used git_rand() which can fail or
   get stuck; the callsite does not require cryptographic security.
   Introduce the "insecure" mode and use it appropriately.
   (merge 0b4f8afef6 ps/reftable-get-random-fix later to maint).

 * A misconfigured "fsck.skiplist" configuration variable was not
   diagnosed as an error, which has been corrected.
   (merge ca7158076f jt/fsck-skiplist-parse-fix later to maint).

 * Extended SHA-1 expression parser did not work well when a branch
   with an unusual name (e.g. "foo{bar") is involved.
   (merge 191f0c8db2 en/object-name-with-funny-refname-fix later to maint).

 * The meson build procedure looked for the 'version-def.h' file in a
   wrong directory, which has been corrected.
   (merge 4771501c0a tc/meson-use-our-version-def-h later to maint).

 * The meson build procedure for Documentation/technical/ hierarchy was
   missing necessary dependencies, which has been corrected.
   (merge 1dca492edd sj/meson-doc-technical-dependency-fix later to maint).

 * The "instaweb" bound only to local IP address without "--local" and
   to all addresses with "--local", which was the other way around, when
   using Python's http.server class, which has been corrected.
   (merge 76baf97fa1 ak/instaweb-python-port-binding-fix later to maint).

 * Document that it is insecure to use Personal Access Tokens, which
   some hosting providers take as username/password, embedded in URLs.
   (merge a90ff409f0 mh/doc-credential-helpers-with-pat later to maint).

 * The help text from "git $cmd -h" appear on the standard output for
   some $cmd and the standard error for others.  The built-in commands
   have been fixed to show them on the standard output consistently.
   (merge f66d1423f5 jc/show-usage-help later to maint).

 * The meson-driven build is now aware of "git-subtree" housed in
   contrib/subtree hierarchy.
   (merge 8454b42f94 ps/build-meson-subtree later to maint).

 * It was possible for "git unpack-objects" and "git index-pack" to
   make an unaligned access, which has been corrected.
   (merge 98046591b9 jk/pack-header-parse-alignment-fix later to maint).

 * The "cache" credential back-end did not handle authtype correctly,
   which has been corrected.
   (merge 0b43274850 mh/credential-cache-authtype-request-fix later to maint).

 * "git branch --sort=..." and "git for-each-ref --format=... --sort=..."
   did not work as expected with some atoms, which has been corrected.
   (merge c5490ce9d1 rs/ref-fitler-used-atoms-value-fix later to maint).

 * reflog entries for symbolic ref updates were broken, which has been
   corrected.
   (merge 3519492430 kn/reflog-symref-fix later to maint).

 * The trace2 code was not prepared to show a configuration variable
   that is set to true using the valueless true syntax, which has been
   corrected.
   (merge 2fd367cf63 am/trace2-with-valueless-true later to maint).

 * The "git refs migrate" command did not migrate the reflog for
   refs/stash, which is the contents of the stashes, which has been
   corrected.
   (merge a0bea0978f ps/reflog-migration-with-logall-fix later to maint).

 * Doc and short-help text for "show-index" has been clarified to
   stress that the command reads its data from the standard input.
   (merge 49edce4ff9 jc/show-index-h-update later to maint).

 * The API around choosing to use unsafe variant of SHA-1
   implementation has been updated in an attempt to make it harder to
   abuse.
   (merge 04292c3796 tb/unsafe-hash-cleanup later to maint).

 * Fix bugs in an earlier attempt to fix "git refs migration".
   (merge f11f0a5a2d kn/reflog-migration-fix-fix later to maint).

 * The code path used when "git fetch" fetches from a bundle file
   closed the same file descriptor twice, which sometimes broke things
   unexpectedly when the file descriptor was reused, which has been
   corrected.
   (merge 9a84794ad8 js/bundle-unbundle-fd-reuse-fix later to maint).

 * "git init" to reinitialize a repository that already exists cannot
   change the hash function and ref backends; such a request is
   silently ignored now.
   (merge 7e88640cd1 ps/setup-reinit-fixes later to maint).

 * "git apply" internally uses unsigned long for line numbers and uses
   strtoul() to parse numbers on the hunk headers.  It however forgot
   to check parse errors.
   (merge a206058fda pw/apply-ulong-overflow-check later to maint).

 * Two CI tasks, whitespace check and style check, work on the
   difference from the base version and the version being checked, but
   the base was computed incorrectly in GitLab CI in some cases, which
   has been corrected.
   (merge acc4fb302b jt/gitlab-ci-base-fix later to maint).

 * "git repack --keep-unreachable" to send unreachable objects to the
   main pack "git repack -ad" produces did not work when there is no
   existing packs, which has been corrected.
   (merge 414c82300a ps/repack-keep-unreachable-in-unpacked-repo later to maint).

 * Going into a secondary worktree and asking "is the main worktree
   bare?" did not work correctly when per-worktree configuration
   option was in use, which has been corrected.

 * Fetching into a bare repository incorrectly assumed it always used
   a mirror layout when deciding to update remote-tracking HEAD, which
   has been corrected.
   (merge 93dc16483a bf/fetch-set-head-fix later to maint).

 * A thunderbird helper script lost its bashism.
   (merge 59d26bd961 bc/contrib-thunderbird-patch-inline-fix later to maint).

 * The -G/-S options to the "diff" family of commands caused us to hit
   a BUG() when they get no values; they have been corrected.
   (merge a620046b29 bc/diff-reject-empty-arg-to-pickaxe later to maint).

 * "git merge-tree --stdin" has been improved (including a workaround
   for a deadlock).
   (merge 6a9ae81015 pw/merge-tree-stdin-deadlock-fix later to maint).

 * Correct the default target in Documentation/Makefile, and
   future-proof all Makefiles from similar breakages by declaring the
   default target (which happens to be "all") upfront.
   (merge 5309c1e9fb ad/set-default-target-in-makefiles later to maint).

 * "git check-mailmap" used to segfault when queried without human
   readable name.
   (merge bb60c52131 jk/check-mailmap-wo-name-fix later to maint).

 * Support for renaming of symbolic links on Windows has been improved.

 * Other code cleanup, docfix, build fix, etc.
   (merge ddb5287894 jk/t7407-use-test-grep later to maint).
   (merge 21e1b44865 aj/difftool-config-doc-fix later to maint).
   (merge 6a63995335 mh/gitattr-doc-markup-fix later to maint).
   (merge 43850dcf9c sk/unit-test-hash later to maint).
   (merge 4ad47d2de3 jc/cli-doc-option-and-config later to maint).
   (merge 2d0ff147e5 jp/t8002-printf-fix later to maint).
   (merge 69666e6746 ja/doc-restore-markup-update later to maint).
   (merge d11d003ba5 sk/strlen-returns-size_t later to maint).
   (merge 77b2d29e91 ja/doc-notes-markup-updates later to maint).
   (merge 6979bf6f8f jk/combine-diff-cleanup later to maint).
   (merge 8705c9bd13 kn/pack-write-with-reduced-globals later to maint).
   (merge 087740d65a ps/leakfixes-0129 later to maint).
   (merge 6bba6f604b jp/doc-trailer-config later to maint).
   (merge f1cc562b77 lo/t7603-path-is-file-update later to maint).
   (merge 45761988ac en/doc-renormalize later to maint).
   (merge 832f56f06a jc/doc-boolean-synonyms later to maint).
   (merge 3eeed876a9 ac/doc-http-ssl-type-config later to maint).

----------------------------------------------------------------

Changes since v2.48.0 are as follows:

Adam Dinwoodie (1):
      Makefile: set default goals in makefiles

Adam Johnson (1):
      difftool docs: restore correct position of tool list

Adam Murray (1):
      trace2: prevent segfault on config collection with valueless true

Alecs King (1):
      instaweb: fix ip binding for the python http.server

Alexander Shopov (1):
      parse-options: localize mark-up of placeholder text in the short help

Andrew Carter (1):
      docs: indicate http.sslCertType and sslKeyType

Ayush Chandekar (1):
      t6423: fix suppression of Git’s exit code in tests

Bence Ferdinandy (2):
      fetch set_head: refactor to use remote directly
      fetch set_head: fix non-mirror remotes in bare repositories

Calvin Wan (1):
      libgit: add higher-level libgit crate

D. Ben Knoble (1):
      completion: repair config completion for Zsh

David Aguilar (11):
      help: show the suggested command when help.autocorrect is false
      help: add "show" as a valid configuration value
      difftool: eliminate use of global variables
      difftool: eliminate use of the_repository
      difftool: eliminate use of USE_THE_REPOSITORY_VARIABLE
      xdiff: move sign comparison warning guard into each file
      xdiff: avoid signed vs. unsigned comparisons in xdiffi.c
      xdiff: avoid signed vs. unsigned comparisons in xemit.c
      xdiff: avoid signed vs. unsigned comparisons in xhistogram.c
      xdiff: avoid signed vs. unsigned comparisons in xpatience.c
      xdiff: avoid signed vs. unsigned comparisons in xutils.c

Derrick Stolee (18):
      path-walk: introduce an object walk by path
      test-lib-functions: add test_cmp_sorted
      t6601: add helper for testing path-walk API
      path-walk: allow consumer to specify object types
      path-walk: visit tags and cached objects
      path-walk: mark trees and blobs as UNINTERESTING
      path-walk: reorder object visits
      pack-objects: add --name-hash-version option
      repack: add --name-hash-version option
      pack-objects: add GIT_TEST_NAME_HASH_VERSION
      p5313: add size comparison test
      test-tool: add helper for name-hash values
      pack-objects: prevent name hash version change
      backfill: add builtin boilerplate
      backfill: basic functionality and tests
      backfill: add --min-batch-size=<n> option
      backfill: add --sparse option
      backfill: assume --sparse when sparse-checkout is enabled

Eliah Kagan (1):
      compat/mingw: rename the symlink, not the target

Elijah Newren (3):
      object-name: fix resolution of object names containing curly braces
      object-name: be more strict in parsing describe-like output
      doc: clarify the intent of the renormalize option in the merge machinery

Jacob Keller (1):
      mailmap: fix check-mailmap with full mailmap line

James J. Raden (1):
      gitk: make the "list references" default window width wider

Jan Palus (1):
      t8002: fix ambiguous printf conversion specifications

Jean-Noël Avila (7):
      doc: convert git-notes to new documentation format
      doc: convert git-restore to new style format
      doc: apply new documentation guidelines to git commit
      doc: the mode param of -u of git commit is optional
      doc: make more direct explanations in git commit options
      doc: convert git commit config to new format
      doc: migrate git-commit manpage secondary files to new format

Jeff King (25):
      test-lib: invert return value of check_test_results_san_file_empty
      test-lib: simplify lsan results check
      test-lib: add a few comments to LSan log checking
      t7407: use test_grep
      run_diff_files(): delay allocation of combine_diff_path
      combine-diff: add combine_diff_path_new()
      tree-diff: clear parent array in path_appendnew()
      combine-diff: use pointer for parent paths
      diff: add a comment about combine_diff_path.parent.path
      run_diff_files(): de-mystify the size of combine_diff_path struct
      tree-diff: drop path_appendnew() alloc optimization
      tree-diff: pass whole path string to path_appendnew()
      tree-diff: inline path_appendnew()
      combine-diff: drop public declaration of combine_diff_path_size()
      tree-diff: drop list-tail argument to diff_tree_paths()
      tree-diff: use the name "tail" to refer to list tail
      tree-diff: simplify emit_path() list management
      tree-diff: make list tail-passing more explicit
      t0012: optionally check that "-h" output goes to stdout
      packfile: factor out --pack_header argument parsing
      parse_pack_header_option(): avoid unaligned memory writes
      index-pack, unpack-objects: use get_be32() for reading pack header
      index-pack, unpack-objects: use skip_prefix to avoid magic number
      path-walk: drop redundant parse_tree() call
      ci: set CI_JOB_IMAGE for coverity job

Jiang Xin (5):
      t5548: refactor to reuse setup_upstream() function
      t5548: refactor test cases by resetting upstream
      t5548: add porcelain push test cases for dry-run mode
      send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
      send-pack: gracefully close the connection for atomic push

Johannes Schindelin (15):
      mingw: drop bogus (and unneeded) declaration of `_pgmptr`
      credential_format(): also encode <host>[:<port>]
      credential: sanitize the user prompt
      credential: disallow Carriage Returns in the protocol by default
      Git 2.40.4
      Git 2.41.3
      Git 2.42.4
      Git 2.43.6
      Git 2.45.3
      Git 2.44.3
      Git 2.46.3
      Git 2.47.2
      gitk(Windows): avoid inadvertently calling executables in the worktree
      gitk: fix arrow keys in input fields with Tcl/Tk >= 8.6
      bundle: avoid closing file descriptor twice

Jonathan Tan (1):
      pack-objects: create new name-hash function version

Josh Steadmon (3):
      common-main: split init and exit code into new files
      libgit-sys: introduce Rust wrapper for libgit.a
      libgit-sys: also export some config_set functions

Julian Prein (1):
      config.txt: add trailer.* variables

Junio C Hamano (29):
      ci: remove 'Upload failed tests' directories' step from linux32 jobs
      compat/regex: fix argument order to calloc(3)
      show-index: the short help should say the command reads from its input
      sign-compare: avoid comparing ptrdiff with an int/unsigned
      Git 2.48.1
      Start the Git 2.49 cycle
      The first batch
      gitcli: document that command line trumps config and env
      parse-options: add show_usage_with_options_if_asked()
      usage: add show_usage_if_asked()
      builtins: send usage_with_options() help text to standard output
      oddballs: send usage() help text to standard output
      builtin: send usage() help text to standard output
      bswap.h: squelch potential sparse -Wcast-truncate warnings
      The second batch
      The third batch
      The fourth batch
      The fifth batch
      The sixth batch
      The seventh batch
      The eighth batch
      The ninth batch
      doc: centrally document various ways tospell `true` and `false`
      The tenth batch
      The eleventh batch
      The twelfth batch
      The thirteenth batch
      The fourteenth batch
      Git 2.49-rc0

Justin Tobler (4):
      fsck: reject misconfigured fsck.skipList
      ci: fix base commit fallback for check-whitespace and check-style
      rev-list: add print-info action to print missing object path
      rev-list: extend print-info to print missing object type

Karsten Blees (1):
      gitk: Unicode file name support

Karthik Nayak (11):
      reftable: write correct max_update_index to header
      pack-write: pass hash_algo to `fixup_pack_header_footer()`
      pack-write: pass repository to `index_pack_lockfile()`
      pack-write: pass hash_algo to `write_idx_file()`
      pack-write: pass hash_algo to `write_rev_file()`
      pack-write: pass hash_algo to internal functions
      refs: mark `ref_transaction_update_reflog()` as static
      refs: use 'uint64_t' for 'ref_update.index'
      reftable: prevent 'update_index' changes after adding records
      refs: fix creation of reflog entries for symrefs
      refs/reftable: fix uninitialized memory access of `max_index`

Lucas Oshiro (1):
      t7603: replace test -f by test_path_is_file

M Hickford (4):
      credential-cache: respect authtype capability
      docs: list popular credential helpers
      docs: discuss caching personal access tokens
      doc: use 'title' consistently

Matteo Bagnolini (1):
      t7110: replace `test -f` with `test_path_is_*` helpers

Matthew Hughes (1):
      docs: fix typesetting of merge driver placeholders

Meet Soni (7):
      remote: rename function omit_name_by_refspec
      refspec: relocate refname_matches_negative_refspec_item
      remote: rename query_refspecs functions
      refspec: relocate matching related functions
      refspec: relocate apply_refspecs and related funtions
      remote: relocate valid_remote_name
      refspec: clarify function naming and documentation

Mike Hommey (1):
      connect: address -Wsign-compare warnings

Olga Pilipenco (1):
      worktree: detect from secondary worktree if main worktree is bare

Patrick Steinhardt (102):
      t7300: work around platform-specific behaviour with long paths on MinGW
      progress: stop using `the_repository`
      pager: stop using `the_repository`
      trace: stop using `the_repository`
      serve: stop using `the_repository`
      send-pack: stop using `the_repository`
      server-info: stop using `the_repository`
      diagnose: stop using `the_repository`
      mailinfo: stop using `the_repository`
      credential: stop using `the_repository`
      resolve-undo: stop using `the_repository`
      tmp-objdir: stop using `the_repository`
      add-interactive: stop using `the_repository`
      graph: stop using `the_repository`
      match-trees: stop using `the_repository`
      prio-queue: fix type of `insertion_ctr`
      commit-reach: fix index used to loop through unsigned integer
      commit-reach: fix type of `min_commit_date`
      commit-reach: use `size_t` to track indices in `remove_redundant()`
      commit-reach: use `size_t` to track indices in `get_reachable_subset()`
      builtin/log: use `size_t` to track indices
      builtin/log: fix remaining -Wsign-compare warnings
      shallow: fix -Wsign-compare warnings
      commit-reach: use `size_t` to track indices when computing merge bases
      object-file: fix race in object collision check
      meson: consistenlty spell 'CommonCrypto'
      meson: deduplicate access to SHA1/SHA256 backend options
      meson: require SecurityFramework when it's used as SHA1 backend
      meson: simplify conditions for HTTPS and SHA1 dependencies
      meson: add missing dots for build options
      meson: wire up unsafe SHA1 backend
      meson: provide a summary of configured backends
      object-file: rename variables in `check_collision()`
      object-file: don't special-case missing source file in collision check
      object-file: retry linking file into place when occluding file vanishes
      wrapper: allow generating insecure random bytes
      reftable/stack: accept insecure random bytes
      t0060: fix EBUSY in MinGW when setting up runtime prefix
      t7422: fix flaky test caused by buffered stdout
      github: adapt containerized jobs to be rootless
      github: convert all Linux jobs to be containerized
      github: simplify computation of the job's distro
      gitlab-ci: remove the "linux-old" job
      gitlab-ci: add linux32 job testing against i386
      ci: stop special-casing for Ubuntu 16.04
      ci: use latest Ubuntu release
      ci: remove stale code for Azure Pipelines
      contrib/subtree: fix building docs
      meson: introduce build option for contrib
      meson: wire up the git-subtree(1) command
      meson: stop disabling -Wsign-compare
      reftable/record: drop unused `print` function pointer
      reftable/record: handle overflows when decoding varints
      reftable/basics: adjust `common_prefix_size()` to return `size_t`
      reftable/basics: adjust `hash_size()` to return `uint32_t`
      reftable/block: adapt header and footer size to return a `size_t`
      reftable/block: adjust type of the restart length
      reftable/blocksource: adjust type of the block length
      reftable/blocksource: adjust `read_block()` to return `ssize_t`
      reftable: address trivial -Wsign-compare warnings
      refs: fix migration of reflogs respecting "core.logAllRefUpdates"
      Makefile: wire up build option for deprecated features
      ci: merge linux-gcc-default into linux-gcc
      ci: repurpose "linux-gcc" job for deprecations
      builtin/pack-redundant: remove subcommand with breaking changes
      GIT-VERSION-GEN: simplify computing the dirty marker
      GIT-VERSION-GEN: allow running without input and output files
      meson: populate project version via GIT-VERSION-GEN
      meson: fix dependencies for generated headers
      meson: wire up development environments
      meson: wire up generation of distribution archive
      meson: wire up fuzzers
      meson: make the CSPRNG backend configurable
      meson: fix compilation with Visual Studio
      ci: raise error when Meson generates warnings
      ci: wire up Visual Studio build with Meson
      remote: announce removal of "branches/" and "remotes/"
      compat: drop `uncompress2()` compatibility shim
      git-compat-util: drop `z_const` define
      compat: introduce new "zlib.h" header
      git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
      compat/zlib: provide `deflateBound()` shim centrally
      compat/zlib: provide stubs for `deflateSetHeader()`
      git-zlib: cast away potential constness of `next_in` pointer
      compat/zlib: allow use of zlib-ng as backend
      ci: switch linux-musl to use Meson
      ci: make "linux-musl" job use zlib-ng
      unix-socket: fix memory leak when chdir(3p) fails
      scalar: free result of `remote_default_branch()`
      t0001: remove duplicate test
      setup: fix reinit of repos with incompatible GIT_DEFAULT_REF_FORMAT
      setup: fix reinit of repos with incompatible GIT_DEFAULT_HASH
      hash: convert hashing context to a structure
      hash: stop typedeffing the hash context
      hash: provide generic wrappers to update hash contexts
      global: adapt callers to use generic hash context helpers
      t5504: modernize test by moving heredocs into test bodies
      t5548: add new porcelain test cases
      t5543: atomic push reports exit code failure
      builtin/repack: fix `--keep-unreachable` when there are no packs
      gitk: extract script to build executable
      gitk: introduce support for the Meson build system

Peter Oliver (2):
      meson: bump minimum required Perl version to 5.26.0
      meson: fix Perl version check for Meson versions before 1.7.0

Phillip Wood (6):
      apply: detect overflow when parsing hunk header
      merge-tree --stdin: flush stdout to avoid deadlock
      merge-tree: remove redundant code
      merge-tree: only use basic merge config
      merge-tree: improve docs for --stdin
      merge-tree: fix link formatting in html docs

Piotr Szlazak (1):
      doc: documentation for http.uploadarchive config option

René Scharfe (3):
      ref-filter: move ahead-behind bases into used_atom
      ref-filter: move is-base tip to used_atom
      ref-filter: remove ref_format_clear()

Roy Eldar (7):
      git-submodule.sh: improve parsing of some long options
      git-submodule.sh: improve parsing of short options
      git-submodule.sh: get rid of isnumber
      git-submodule.sh: get rid of unused variable
      git-submodule.sh: add some comments
      git-submodule.sh: improve variables readability
      git-submodule.sh: rename some variables

Sam James (1):
      meson: fix missing deps for technical articles

Scott Chacon (1):
      help: interpret boolean string values for help.autocorrect

Sebastian Schuberth (1):
      gitk: Use an external icon file on Windows

Seyi Kuforiji (9):
      t/unit-tests: convert hash to use clar test framework
      t/unit-tests: handle dashes in test suite filenames
      t/unit-tests: convert mem-pool test to use clar test framework
      t/unit-tests: adapt priority queue test to use clar test framework
      t/unit-tests: convert reftable tree test to use clar test framework
      t/unit-tests: convert hashmap test to use clar test framework
      t/unit-tests: adapt example decorate test to use clar test framework
      t/unit-tests: convert strbuf test to use clar test framework
      t/unit-tests: convert strcmp-offset test to use clar test framework

Sören Krecker (1):
      date.c: Fix type missmatch warings from msvc

Taylor Blau (9):
      t/helper/test-tool: implement sha1-unsafe helper
      csum-file: store the hash algorithm as a struct field
      csum-file.c: extract algop from hashfile_checksum_valid()
      hash.h: introduce `unsafe_hash_algo()`
      csum-file.c: use unsafe_hash_algo()
      t/helper/test-hash.c: use unsafe_hash_algo()
      csum-file: introduce hashfile_checkpoint_init()
      hash.h: drop unsafe_ function variants
      Makefile: remove accidental recipe prefix in conditional

Toon Claes (8):
      meson: ensure correct version-def.h is used
      clone: cut down on global variables in clone.c
      clone: make it possible to specify --tags
      clone: refactor wanted_peer_refs()
      clone: add tags refspec earlier to fetch refspec
      clone: introduce struct clone_opts in builtin/clone.c
      parse-options: introduce die_for_incompatible_opt2()
      builtin/clone: teach git-clone(1) the --revision= option

Usman Akinyemi (1):
      builtin/update-server-info: remove the_repository global variable

ZheNing Hu (1):
      gc: add `--expire-to` option

ambar chakravartty (1):
      t5401: prefer test_path_is_* helper function

brian m. carlson (7):
      doc: update gitignore for .adoc extension
      editorconfig: add .adoc extension
      gitattributes: mark AsciiDoc files as LF-only
      doc: use .adoc extension for AsciiDoc files
      Remove obsolete ".txt" extensions for AsciiDoc files
      thunderbird-patch-inline: avoid bashism
      diff: don't crash with empty argument to -G or -S


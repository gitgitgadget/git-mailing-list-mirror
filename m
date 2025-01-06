Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E311DDC23;
	Mon,  6 Jan 2025 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193753; cv=none; b=U8w0PKzYZyRoWqQLYA8cGUhUm4xIw/RaPESgxjkQq/QgGi448vSXdl7fdg75xMpDqo8lNjtPQsesEoSSoZ0UtpURkEixYMh1rerpsMcgu+S4xwS+A7rNzWeVkUbuPzmcDB9AOS9YmHU4YhUvdlPhSPjc+OMipjs5nTMsbIMz3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193753; c=relaxed/simple;
	bh=vINW374O/I6GFIJtRVvykgURyJ3Sz269rbAfelRRTq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BVP71NKh3VZJi+T3EMTgfRlqKQvuI/hfvCj0fW10X6Pat1JXzbujuV/GumIa5Fwm9rYE8mfcNbbCbfvvUsEs1pP13FsHG1M1fwSCaqAgopx6ReAcpIlkBNSkj6pnc7mUtjs+GSnIUmO0YKFMhIEZpPBzWqAFZqL+YMoXKt0p5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pqgt2BMJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6sMk/Vg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pqgt2BMJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6sMk/Vg"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C43D8138021C;
	Mon,  6 Jan 2025 15:02:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 15:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1736193746; x=1736280146; bh=7p
	BofjJ/BQ73TMgzxf9javiUfme4y04NjRDHz7ZKssc=; b=Pqgt2BMJCuDTwHXDGo
	r1+Zh/UwktKkaB5ntq83+iz9d6ZrCwzd9gmTTcKSDhRt11QzaY/iFhDS55DC6HP4
	gDrvqjJDZW1EVw8ukmOW796ISQwDoOakhVaOP6hDdSsHTJpWgCAFzt+c9Aqdk0h+
	tSJFuzCqWl1iCo5wKqrW7A8bnBO7+5KaDLwMIbqMFawj+k7cR6/lYEhn9DPVrywo
	0taafDleL0EmRpLhkb+Pe52iLssW3s8JMByXp/U/FBUSTchTguugEg+weMj6RE6/
	9lRtRRIwJoF5HuBT08bjDEfmEp64zjcbIsy5o2+2ToUwvZ2D8GvImj+S/ly1r3Zq
	shug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736193746; x=1736280146; bh=7pBofjJ/BQ73TMgzxf9javiUfme4
	y04NjRDHz7ZKssc=; b=i6sMk/Vg6KCMX1ukXqOx++LhTBGM3cnZYimuMM1sU6wr
	zCstHll9o4ZcVztbtWjSWq37N4Be/zxEdXef+1SmkYTCwetiozAfOJvlx6a+pq8j
	W5oeA9F1RpNtoT45/Aynri6qCcvlf/QR5naaogAIOJ1X62B0rIytycEH0EdGosaZ
	TuxSQQ/AUXf6+XVo4IQYpOUM67/QRkwe3dH1rA++rq/j38JpTQsycTRZXwd3hLiF
	P/0NF9aFCiJW3IFSgnZgqso6P0ME2Qo8MiJIEBaoUmql0972s9LDEgQL9VHjgnBg
	fdkMRzKpUNExUBiL+3uS8LGMoMP8/e8GTVx1z26YAA==
X-ME-Sender: <xms:0jZ8Z5VHv58Xbp2TzGANx2nY1fw7NDu1NRwQ3yHWEdinzhxY9hfLNQ>
    <xme:0jZ8Z5l0E1qXAehvHJdJYZsW_OfaPReR6UnPzqt2Dqg4R4kP3i7cLl8Fgyb4V-Zl1
    E6rFWwG14F_YZG6rw>
X-ME-Received: <xmr:0jZ8Z1ZzdvddCGdANec_Km73jlas_ccUnVamVs9ayquIIT233_SDGsmoIU0radS0irNnHz8-pQtvSN4sAJZpF6_0uymKPTpTUnh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepueetgfefhfehtddvieelieeuiefgteeuffeu
    lefgudefgedtjeejhfdtgefffeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hoohhglhgvshhouhhrtggvrdgtohhmpdhorhdrtgiipdhgihhthhhusgdrtghomhdprhgs
    rdhinhdpmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglh
    gvghhrohhuphhsrdgtohhmpdhrtghpthhtoheplhifnheslhifnhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0jZ8Z8XLOfUo56iyETaRYhuGNdTQ5Q9PdTTizdbSr13tTU6zGwMHPw>
    <xmx:0jZ8ZzmFjkIG6TBC_E2I3Yb4ntpZmPzZzrZzhbjqehG9dvQmzEl4Fg>
    <xmx:0jZ8Z5eL0iGSbpYwEGTKwFEW5D4X5vkXAdC_YTnSOUJn8DDfQKr6Ng>
    <xmx:0jZ8Z9Gq4KPcWHRqR8_u7Ph6a3rOf6DoJMp7V7vqbOc27zGQCGCyYA>
    <xmx:0jZ8Z-uBT4oNQzeF0br-FR9OjLsRFpYPFc0ycO8yQL9w6mmxStziN6lM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 15:02:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.48.0-rc2
Date: Mon, 06 Jan 2025 12:02:24 -0800
Message-ID: <xmqqbjwjyalr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A release candidate Git v2.48.0-rc2 is now available for testing at
the usual places.  It is comprised of 584 non-merge commits since
v2.47.0, contributed by 81 people, 33 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.48.0-rc2' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.47.0 are as follows.
Welcome to the Git development community!

  Aarni Koskela, Abraham Samuel Adekunle, Alejandro Barreto, Bence
  Ferdinandy, Caleb White, Chizoba ODINAKA, Christoph Sommer,
  Daniel Black, Daniel Engberg, David Gstir, Ed Reel, Eric Mills,
  fox, Jaroslav Lobačevski, Josh Heinrichs, Josh Poimboeuf,
  Kai Koponen, karthik nayak, Kev Kloss, Liu Zhongbo, Meet Soni,
  Miguel Rincon Barahona, Monika Kairaitytė, Nicolas Guichard,
  Russell Stuart, Sam James, Seyi Kuforiji, Shubham Kanodia,
  Simon Marchi, Tobias Boesch, Tobias Pietzsch, Usman Akinyemi,
  and Yuri Konotopov.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Abhijeet Sonar, Alejandro R. Sedeño, Alexander Shopov,
  Andrew Kreimer, Avi Halachmi (:avih), brian m. carlson, Dario
  Gjorgjevski, Derrick Stolee, Elijah Newren, Eli Schwartz,
  Eric Sesterhenn, Eric Sunshine, Jean-Noël Avila, Jeff King,
  Johannes Schindelin, Johannes Sixt, John Cai, Jonathan Tan,
  Josh Soref, Josh Steadmon, Junio C Hamano, Justin Tobler,
  Karthik Nayak, Koji Nakamaru, Kousik Sanagavarapu, Kristoffer
  Haugsbakk, Kyle Lippincott, Linus Arver, Martin Ågren, Oswald
  Buddenhagen, Patrick Steinhardt, Peter Krefting, Philippe Blain,
  Phillip Wood, Piotr Szlazak, Ramsay Jones, Randall S. Becker,
  Rasmus Villemoes, René Scharfe, Rubén Justo, Seija Kijin,
  shejialuo, Sören Krecker, Sven Strickroth, Taylor Blau, Toon
  Claes, Wolfgang Müller, and Xing Xin.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.48 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * A new configuration variable remote.<name>.serverOption makes the
   transport layer act as if the --serverOption=<value> option is
   given from the command line.

 * "git rebase --rebase-merges" now uses branch names as labels when
   able.

 * Describe the policy to introduce breaking changes.

 * Teach 'git notes add' and 'git notes append' a new '-e' flag,
   instructing them to open the note in $GIT_EDITOR before saving.

 * Documentation for "git bundle" saw improvements to more prominently
   call out the use of '--all' when creating bundles.

 * Drop support for older libcURL and Perl.

 * End-user experience of "git mergetool" when the command errors out
   has been improved.

 * "git bundle --unbundle" and "git clone" running on a bundle file
   both learned to trigger fsck over the new objects with configurable
   fck check levels.

 * When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
   missing and discovers what branch the other side points with its
   HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 * "git fetch" honors "remote.<remote>.followRemoteHEAD" settings to
   tweak the remote-tracking HEAD in "refs/remotes/<remote>/HEAD".

 * "git range-diff" learned to optionally show and compare merge
   commits in the ranges being compared, with the --diff-merges
   option.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * Document "amlog" notes.

 * The way AsciiDoc is used for SYNOPSIS part of the manual pages has
   been revamped.  The sources, at least for the simple cases, got
   vastly pleasant to work with.

 * The reftable library is now prepared to expect that the memory
   allocation function given to it may fail to allocate and to deal
   with such an error.

 * An extra worktree attached to a repository points at each other to
   allow finding the repository from the worktree and vice versa
   possible.  Turn this linkage to relative paths.

 * Enable Windows-based CI in GitLab.

 * Commands that can also work outside Git have learned to take the
   repository instance "repo" when we know we are in a repository, and
   NULL when we are not, in a parameter.  The uses of the_repository
   variable in a few of them have been removed using the new calling
   convention.

 * The reftable sub-system grew a new reftable-specific strbuf
   replacement to reduce its dependency on Git-specific data
   structures.

 * The ref-filter machinery learns to recognize and avoid cases where
   sorting would be redundant.

 * Various platform compatibility fixes split out of the larger effort
   to use Meson as the primary build tool.

 * Treat ECONNABORTED the same as ECONNRESET in 'git credential-cache'
   to work around a possible Cygwin regression. This resolves a race
   condition caused by changes in Cygwin's handling of socket
   closures, allowing the client to exit cleanly when encountering
   ECONNABORTED.

 * Demonstrate an assertion failure in 'git mv'.

 * Documentation update to clarify that 'uploadpack.allowAnySHA1InWant'
   implies both 'allowTipSHA1InWant' and 'allowReachableSHA1InWant'.

 * Replace various calls to atoi() with strtol_i() and strtoul_ui(),
   and add improved error handling.

 * Documentation updates to 'git-update-ref(1)'.

 * Update the project's CodingGuidelines to discourage naming functions
   with a "_1()" suffix.

 * Updates the '.clang-format' to match project conventions.

 * Centralize documentation for repository extensions into a single place.

 * Buildfix and upgrade of Clar to a newer version.

 * Documentation mark-up updates.

 * Renaming a handful of variables and structure fields.

 * Fix for clar unit tests to support CMake build.

 * C23 compatibility updates.

 * GCC 15 compatibility updates.

 * We now ensure "index-pack" is used with the "--promisor" option
   only during a "git fetch".

 * The migration procedure between two ref backends has been optimized.

 * "git fsck" learned to issue warnings on "curiously formatted" ref
   contents that have always been taken valid but something Git
   wouldn't have written itself (e.g., missing terminating end-of-line
   after the full object name).

 * Work around Coverity warning that would not trigger in practice.

 * Built-in Git subcommands are supplied the repository object to work
   with; they learned to do the same when they invoke sub-subcommands.

 * Drop support for ancient environments in various CI jobs.

 * Isolates the reftable subsystem from the rest of Git's codebase by
   using fewer pieces of Git's infrastructure.

 * Optimize reading random references out of the reftable backend by
   allowing reuse of iterator objects.

 * Backport oss-fuzz tests for us to our codebase.

 * Introduce a new repository extension to prevent older Git versions
   from mis-interpreting worktrees created with relative paths.

 * Yet another "pass the repository through the callchain" topic.

 * "git describe" learned to stop digging the history needlessly
   deeper.

 * Build procedure update plus introduction of Meson based builds.

 * Recent reftable updates mistook a NULL return from a request for
   0-byte allocation as OOM and died unnecessarily, which has been
   corrected.

 * Reftable backend adds check for upper limit of log's update_index.

 * Start working to make the codebase buildable with -Wsign-compare.

 * Regression fix for 'show-index' when run outside of a repository.

 * The meson-build procedure is integrated into CI to catch and
   prevent bitrotting.

 * "git refs migrate" learned to also migrate the reflog data across
   backends.

 * The developer documentation has been updated to give the latest
   info on gitk and git-gui maintainer.


 * CI jobs that run threaded programs under LSan has been giving false
   positives from time to time, which has been worked around.


Fixes since v2.47
-----------------

 * Doc update to clarify how periodical maintenance are scheduled,
   spread across time to avoid thundering hurds.

 * Use after free and double freeing at the end in "git log -L... -p"
   had been identified and fixed.

 * On macOS, fsmonitor can fall into a race condition that results in
   a client waiting forever to be notified for an event that have
   already happened.  This problem has been corrected.

 * "git maintenance start" crashed due to an uninitialized variable
   reference, which has been corrected.

 * Fail gracefully instead of crashing when attempting to write the
   contents of a corrupt in-core index as a tree object.

 * A "git fetch" from the superproject going down to a submodule used
   a wrong remote when the default remote names are set differently
   between them.

 * Fixes compile time warnings with 64-bit MSVC.

 * Teaches 'shortlog' to explicitly use SHA-1 when operating outside
   of a repository.

 * Fix 'git grep' regression on macOS by disabling lookahead when
   encountering invalid UTF-8 byte sequences.

 * The dumb-http code regressed when the result of re-indexing a pack
   yielded an *.idx file that differs in content from the *.idx file
   it downloaded from the remote. This has been corrected by no longer
   relying on: the *.idx file we got from the remote.

 * When called with '--left-right' and '--use-bitmap-index', 'rev-list'
   will produce output without any left/right markers, which has been
   corrected.

 * More leakfixes.

 * Test modernization.

 * The "--shallow-exclude=<ref>" option to various history transfer
   commands takes a ref, not an arbitrary revision.

 * A regression where commit objects missing from a commit-graph can
   cause an infinite loop when doing a fetch in a partial clone has
   been fixed.

 * The MinGW compatibility layer has been taught to support POSIX
   semantics for atomic renames when other process(es) have a file
   opened at the destination path.

 * "git gc" discards any objects that are outside promisor packs that
   are referred to by an object in a promisor pack, and we do not
   refetch them from the promisor at runtime, resulting an unusable
   repository.  Work it around by including these objects in the
   referring promisor pack at the receiving end of the fetch.

 * Avoid build/test breakage on a system without working malloc debug
   support dynamic library.
   (merge 72ad6dc368 jk/test-malloc-debug-check later to maint).

 * Double-free fix.
   (merge fe17a25905 jk/fetch-prefetch-double-free-fix later to maint).

 * Use of some uninitialized variables in "git difftool" has been
   corrected.

 * Object reuse code based on multi-pack-index sent an unwanted copy
   of object.
   (merge e199290592 tb/multi-pack-reuse-dupfix later to maint).

 * "git fast-import" can be tricked into a replace ref that maps an
   object to itself, which is a useless thing to do.
   (merge 5e904f1a4a en/fast-import-avoid-self-replace later to maint).

 * The ref-transaction hook triggered for reflog updates, which has
   been corrected.
   (merge b886db48c6 kn/ref-transaction-hook-with-reflog later to maint).

 * Give a bit of advice/hint message when "git maintenance" stops finding a
   lock file left by another instance that still is potentially running.
   (merge ba874d1dac ps/gc-stale-lock-warning later to maint).

 * Use the right helper program to measure file size in performance tests.
   (merge 3f97f1bce6 tb/use-test-file-size-more later to maint).

 * A double-free that may not trigger in practice by luck has been
   corrected in the reference resolution code.
   (merge b6318cf23a sj/refs-symref-referent-fix later to maint).

 * The sequencer failed to honor core.commentString in some places.

 * Describe a case where an option value needs to be spelled as a
   separate argument, i.e. "--opt val", not "--opt=val".
   (merge 1bc1e94091 jc/doc-opt-tilde-expand later to maint).

 * Loosen overly strict ownership check introduced in the recent past,
   to keep the promise "cloning a suspicious repository is a safe
   first step to inspect it".
   (merge 0ffb5a6bf1 bc/allow-upload-pack-from-other-people later to maint).

 * "git fast-import" learned to reject paths with ".."  and "." as
   their components to avoid creating invalid tree objects.
   (merge 8cb4c6e62f en/fast-import-verify-path later to maint).

 * The --ancestry-path option is designed to be given a commit that is
   on the path, which was not documented, which has been corrected.
   (merge bc1a980759 kk/doc-ancestry-path later to maint).


 * "git tag" has been taught to refuse to create refs/tags/HEAD
   as such a tag will be confusing in the context of UI provided by
   the Git Porcelain commands.
   (merge bbd445d5ef jc/forbid-head-as-tagname later to maint).

 * The advice messages now tell the newer 'git config set' command to
   set the advice.token configuration variable to squelch a message.
   (merge 6c397d0104 bf/explicit-config-set-in-advice-messages later to maint).

 * The syntax ":/<text>" to name the latest commit with the matching
   text was broken with a recent change, which has been corrected.
   (merge 0ff919e87a ps/commit-with-message-syntax-fix later to maint).

 * Fix performance regression of a recent "fatten promisor pack with
   local objects" protection against an unwanted gc.

 * "git log -p --remerge-diff --reverse" was completely broken.
   (merge f94bfa1516 js/log-remerge-keep-ancestry later to maint).

 * "git bundle create" with an annotated tag on the positive end of
   the revision range had a workaround code for older limitation in
   the revision walker, which has become unnecessary.
   (merge dd1072dfa8 tc/bundle-with-tag-remove-workaround later to maint).

 * GitLab CI updates.
   (merge c6b43f663e ps/ci-gitlab-update later to maint).

 * Code to reuse objects based on bitmap contents have been tightened
   to avoid race condition even when multiple packs are involved.
   (merge 62b3ec8a3f tb/bitmap-fix-pack-reuse later to maint).

 * An earlier "csum-file checksum does not have to be computed with
   sha1dc" topic had a few code paths that had initialized an
   implementation of a hash function to be used by an unmatching hash
   by mistake, which have been corrected.
   (merge 599a63409b ps/weak-sha1-for-tail-sum-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 77af53f56f aa/t7300-modernize later to maint).
   (merge dcd590a39d bf/t-readme-mention-reftable later to maint).
   (merge 68e3c69efa kh/trailer-in-glossary later to maint).
   (merge 91f88f76e6 tb/boundary-traversal-fix later to maint).
   (merge 168ebb7159 jc/doc-error-message-guidelines later to maint).
   (merge 18693d7d65 kh/doc-bundle-typofix later to maint).
   (merge e2f5d3b491 kh/doc-update-ref-grammofix later to maint).
   (merge 8525e92886 mh/doc-windows-home-env later to maint).

----------------------------------------------------------------

Changes since v2.47.0 are as follows:

Abhijeet Sonar (2):
      show-index: fix uninitialized hash function
      t5300: add test for 'show-index --object-format'

Abraham Samuel Adekunle (2):
      t7300-clean.sh: use test_path_* helper functions for error logging
      notes: teach the -e option to edit messages in editor

Alejandro Barreto (1):
      Document HOME environment variable

Alejandro R. Sedeño (1):
      Makefile: adjust sed command for generating "clar-decls.h"

Alexander Shopov (3):
      git-gui i18n: Updated Bulgarian translation (579t)
      gitk: Update Bulgarian translation (327t)
      Update the official repo of gitk

Andrew Kreimer (10):
      compat: fix typos
      contrib: fix typos
      t/unit-tests: fix typos
      t/perf: fix typos
      t/helper: fix a typo
      t: fix typos
      t: fix typos
      t1016: clean up style
      t: fix typos
      t1016: clean up style

Avi Halachmi (:avih) (3):
      gitk: UI text: change "SHA1 ID" to "Commit ID"
      gitk: prefs dialog: refine Auto-select UI
      gitk: support auto-copy comit ID to primary clipboard

Bence Ferdinandy (16):
      t/README: add missing value for GIT_TEST_DEFAULT_REF_FORMAT
      t/t5505-remote: set default branch to main
      t/t5505-remote: test failure of set-head
      refs: standardize output of refs_read_symbolic_ref
      refs: atomically record overwritten ref in update_symref
      remote set-head: refactor for readability
      remote set-head: better output for --auto
      refs: add TRANSACTION_CREATE_EXISTS error
      refs: add create_only option to refs_update_symref_extended
      fetch: set remote/HEAD if it does not exist
      fetch set_head: handle mirrored bare repositories
      fetch: add configuration for set_head behaviour
      fetch set_head: move warn advice into advise_if_enabled
      fetch set_head: add warn-if-not-$branch option
      remote set-head: set followRemoteHEAD to "warn" if "always"
      advice: suggest using subcommand "git config set"

Caleb White (12):
      worktree: refactor infer_backlink() to use *strbuf
      worktree: link worktrees with relative paths
      worktree: add test for path handling in linked worktrees
      doc: consolidate extensions in git-config documentation
      setup: correctly reinitialize repository version
      worktree: add `relativeWorktrees` extension
      worktree: refactor infer_backlink return
      worktree: add `write_worktree_linking_files()` function
      worktree: add relative cli/config options to `add` command
      worktree: add relative cli/config options to `move` command
      worktree: add relative cli/config options to `repair` command
      worktree: refactor `repair_worktree_after_gitdir_move()`

Chizoba ODINAKA (1):
      t6050: avoid pipes with upstream Git commands

Christoph Sommer (2):
      gitk: make headings of preferences bold
      gitk: add text wrapping preferences

Daniel Black (1):
      submodule: correct remote name with fetch

Derrick Stolee (1):
      line-log: protect inner strbuf from free

Elijah Newren (5):
      upload-pack: fix ambiguous error message
      doc: correct misleading descriptions for --shallow-exclude
      fast-import: avoid making replace refs point to themselves
      fast-import: disallow "." and ".." path components
      fast-import: disallow more path components

Eric Sesterhenn (3):
      fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz
      fuzz: port fuzz-parse-attr-line from OSS-Fuzz
      fuzz: port fuzz-url-decode-mem from OSS-Fuzz

Eric Sunshine (1):
      worktree: repair copied repository and linked worktrees

Jean-Noël Avila (9):
      doc: introduce a synopsis typesetting
      doc: update the guidelines to reflect the current formatting rules
      doc: apply synopsis simplification on git-clone and git-init
      doc: git-add.txt: convert to new style convention
      doc: git-diff: apply new documentation guidelines
      doc: git-diff: apply format changes to diff-options
      doc: git-diff: apply format changes to diff-format
      doc: git-diff: apply format changes to diff-generate-patch
      doc: git-diff: apply format changes to config part

Jeff King (46):
      line-log: use diff_line_prefix() instead of custom helper
      diff: drop line_prefix_length field
      diff: return const char from output_prefix callback
      diff: return line_prefix directly when possible
      diff: store graph prefix buf in git_graph struct
      simple-ipc: split async server initialization and running
      fsmonitor: initialize fs event listener before accepting clients
      midx: avoid duplicate packed_git entries
      t5550: count fetches in "previously-fetched .idx" test
      dumb-http: store downloaded pack idx as tempfile
      packfile: drop has_pack_index()
      packfile: drop sha1_pack_name()
      packfile: drop sha1_pack_index_name()
      packfile: warn people away from parse_packed_git()
      http-walker: use object_id instead of bare hash
      packfile: convert find_sha1_pack() to use object_id
      packfile: use object_id in find_pack_entry_one()
      packfile: use oidread() instead of hashcpy() to fill object_id
      rev-list: skip bitmap traversal for --left-right
      t6120: demonstrate weakness in disjoint-root handling
      t/perf: add tests for git-describe
      describe: stop digging for max_candidates+1
      describe: stop traversing when we run out of names
      test-lib: check malloc debug LD_PRELOAD before using
      fetch: adjust refspec->raw_nr when filtering prefetch refspecs
      refspec: drop separate raw_nr count
      refspec: store raw refspecs inside refspec_item
      test-lib: move malloc-debug setup after $PATH setup
      object-file: prefer array-of-bytes initializer for hash literals
      object-file: drop confusing oid initializer of empty_tree struct
      object-file: move empty_tree struct into find_cached_object()
      object-file: drop oid field from find_cached_object() return value
      object-file: treat cached_object values as const
      object-file: inline empty tree and blob literals
      t9300: test verification of renamed paths
      describe: split "found all tags" and max_candidates logic
      prio-queue: use size_t rather than int for size
      test-lib: use individual lsan dir for --stress runs
      Revert "index-pack: spawn threads atomically"
      thread-utils: introduce optional barrier type
      index-pack: work around LSan threading race with barrier
      grep: work around LSan threading race with barrier
      test-lib: rely on logs to detect leaks
      test-lib: simplify leak-log checking
      test-lib: check leak logs for presence of DEDUP_TOKEN
      test-lib: ignore leaks in the sanitizer's thread code

Johannes Schindelin (11):
      docs: fix the `maintain-git` links in `technical/platform-support`
      log: --remerge-diff needs to keep around commit parents
      range-diff: optionally include merge commits' diffs in the analysis
      range-diff: introduce the convenience option `--remerge-diff`
      mingw_rename: do support directory renames
      GitHub ci(windows): speed up initializing Git for Windows' minimal SDK again
      cmake: better support for out-of-tree builds follow-up
      cmake(mergetools): better support for out-of-tree builds
      cmake: use the correct file name for the Perl header
      cmake: put the Perl modules into the correct location again
      cmake/vcxproj: stop special-casing `remote-ext`

Johannes Sixt (2):
      git-gui: Remove forced rescan of stat-dirty files.
      gitk: offer "Copy commit ID to X11 selection" only on X11

John Cai (3):
      git: pass in repo to builtin based on setup_git_directory_gently
      annotate: remove usage of the_repository global
      archive: remove the_repository global variable

Jonathan Tan (10):
      t0410: make test description clearer
      t0410: use from-scratch server
      t5300: move --window clamp test next to unclamped
      Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
      fetch-pack: die if in commit graph but not obj db
      index-pack: repack local links into promisor packs
      index-pack: teach --promisor to forbid pack name
      index-pack --promisor: dedup before checking links
      index-pack --promisor: don't check blobs
      index-pack --promisor: also check commits' trees

Josh Heinrichs (1):
      git-config.1: remove value from positional args in unset usage

Josh Soref (2):
      doc: update links to current pages
      doc: switch links to https

Junio C Hamano (30):
      doc: clarify <src> in refspec syntax
      Start the 2.48 cycle
      BreakingChanges: early adopter option
      The eighth batch
      The ninth batch
      Clean up RelNotes for 2.48
      Prepare for 2.47.1
      The tenth batch
      The eleventh batch
      Git 2.47.1
      doc: option value may be separate for valid reasons
      The twelfth batch
      CodingGuidelines: a handful of error message guidelines
      refs: move ref name helpers around
      refs: drop strbuf_ prefix from helpers
      t5604: do not expect that HEAD can be a valid tagname
      tag: "git tag" refuses to use HEAD as a tagname
      The thirteenth batch
      The fourteenth batch
      csum-file: fix -Wsign-compare warning on 32-bit platform
      fetch: do not ask for HEAD unnecessarily
      The fifteenth batch
      The sixteenth batch
      Git 2.48-rc0
      Finishing touches before 2.48-rc1
      Hopefully the final batch before 2.48-rc1
      Git 2.48-rc1
      A bit more post Git 2.48-rc1
      Revert barrier-based LSan threading race workaround
      Git 2.48-rc2

Justin Tobler (4):
      bundle: add bundle verification options type
      bundle: support fsck message configuration
      fetch-pack: split out fsck config parsing
      transport: propagate fsck configuration during bundle fetch

Kai Koponen (1):
      doc: mention rev-list --ancestry-path restrictions

Karthik Nayak (33):
      loose: don't rely on repository global state
      clang-format: re-adjust line break penalties
      clang-format: align consecutive macro definitions
      CodingGuidelines: discourage arbitrary suffixes in function names
      refs: don't invoke reference-transaction hook for reflogs
      builtin: pass repository to sub commands
      packfile: add repository to struct `packed_git`
      packfile: use `repository` from `packed_git` directly
      packfile: pass `repository` to static function in the file
      packfile: pass down repository to `odb_pack_name`
      packfile: pass down repository to `has_object[_kept]_pack`
      packfile: pass down repository to `for_each_packed_object`
      config: make `delta_base_cache_limit` a non-global variable
      config: make `packed_git_(limit|window_size)` non-global variables
      midx: add repository to `multi_pack_index` struct
      midx-write: pass down repository to static functions
      midx-write: use `revs->repo` inside `read_refs_snapshot`
      write-midx: add repository field to `write_midx_context`
      midx-write: pass down repository to `write_midx_file[_only]`
      midx: cleanup internal usage of `the_repository` and `the_hash_algo`
      midx: pass `repository` to `load_multi_pack_index`
      midx: pass down `hash_algo` to functions using global variables
      midx: inline the `MIDX_MIN_SIZE` definition
      reftable/writer: ensure valid range for log's update_index
      refs: include committer info in `ref_update` struct
      refs: add `index` field to `struct ref_udpate`
      refs/files: add count field to ref_lock
      refs: extract out refname verification in transactions
      refs: add `committer_info` to `ref_transaction_add_update()`
      refs: introduce the `ref_transaction_update_reflog` function
      refs: allow multiple reflog entries for the same refname
      refs: add support for migrating reflogs
      refs: mark invalid refname message for translation

Kousik Sanagavarapu (1):
      t4205: fix typo in 'NUL termination with --stat'

Kristoffer Haugsbakk (20):
      doc: merge-tree: improve example script
      checkout: refer to other-worktree branch, not ref
      Documentation/git-update-ref.txt: drop “flag”
      Documentation/git-update-ref.txt: remove safety paragraphs
      Documentation/git-update-ref.txt: demote symlink to last section
      Documentation/git-update-ref.txt: remove confusing paragraph
      Documentation/git-update-ref.txt: discuss symbolic refs
      Documentation: mutually link update-ref and symbolic-ref
      SubmittingPatches: tags -> trailers
      t7001: add failure test which triggers assertion
      Documentation/glossary: describe "trailer"
      Documentation/git-bundle.txt: mention full backup example
      Documentation/git-bundle.txt: remove old `--all` example
      Documentation/git-bundle.txt: mention --all in spec. refs
      Documentation/git-bundle.txt: discuss naïve backups
      sequencer: comment checked-out branch properly
      sequencer: comment `--reference` subject line properly
      sequencer: comment commit messages properly
      Documentation/git-bundle.txt: fix word join typo
      Documentation/git-update-ref.txt: add missing word

Kyle Lippincott (1):
      doc: remove extra quotes in generated docs

Linus Arver (1):
      trailer: spread usage of "trailer_block" language

Martin Ågren (5):
      asciidoctor-extensions.rb.in: delete existing <refmiscinfo/>
      asciidoctor-extensions.rb.in: add missing word
      asciidoctor-extensions.rb.in: inject GIT_DATE
      git.txt: fix heading line of tildes
      gitcli.txt: typeset pathnames as monospace

Meet Soni (1):
      t7611: replace test -f with test_path_is* helpers

Nicolas Guichard (3):
      load_branch_decorations: fix memory leak with non-static filters
      rebase-update-refs: extract load_branch_decorations
      rebase-merges: try and use branch names as labels

Oswald Buddenhagen (2):
      git-gui: strip comments and consecutive empty lines from commit messages
      git-gui: strip commit messages less aggressively

Patrick Steinhardt (253):
      builtin/annotate: fix leaking args vector
      read-cache: fix leaking hash context in `do_write_index()`
      scalar: fix leaking repositories
      shell: fix leaking strings
      wt-status: fix leaking buffer with sparse directories
      submodule: fix leaking submodule entry list
      builtin/stash: fix leaking `pathspec_from_file`
      builtin/pack-redundant: fix various memory leaks
      builtin/clone: fix leaking repo state when cloning with bundle URIs
      t/helper: fix leaking repository in partial-clone helper
      builtin/revert: fix leaking `gpg_sign` and `strategy` config
      diff: improve lifecycle management of diff queues
      line-log: fix several memory leaks
      pseudo-merge: fix various memory leaks
      pseudo-merge: fix leaking strmap keys
      pack-bitmap-write: fix leaking OID array
      midx-write: fix leaking buffer
      revision: fix memory leaks when rewriting parents
      revision: fix leaking saved parents
      pack-write: fix return parameter of `write_rev_file_order()`
      t/helper: fix leaks in proc-receive helper
      remote: fix leaking push reports
      builtin/send-pack: fix leaking list of push options
      reftable/error: introduce out-of-memory error code
      reftable/basics: merge "publicbasics" into "basics"
      reftable: introduce `reftable_strdup()`
      reftable/basics: handle allocation failures in `reftable_calloc()`
      reftable/basics: handle allocation failures in `parse_names()`
      reftable/record: handle allocation failures on copy
      reftable/record: handle allocation failures when decoding records
      reftable/writer: handle allocation failures in `writer_index_hash()`
      reftable/writer: handle allocation failures in `reftable_new_writer()`
      reftable/merged: handle allocation failures in `merged_table_init_iter()`
      reftable/reader: handle allocation failures for unindexed reader
      reftable/reader: handle allocation failures in `reader_init_iter()`
      reftable/stack: handle allocation failures on reload
      reftable/stack: handle allocation failures in `reftable_new_stack()`
      reftable/stack: handle allocation failures in `stack_compact_range()`
      reftable/stack: handle allocation failures in auto compaction
      reftable/iter: handle allocation failures when creating indexed table iter
      reftable/blocksource: handle allocation failures
      reftable/block: handle allocation failures
      reftable/pq: handle allocation failures when adding entries
      reftable/tree: handle allocation failures
      reftable: handle trivial allocation failures
      reftable: fix calls to free(3P)
      reftable: introduce `REFTABLE_FREE_AND_NULL()`
      reftable/basics: ban standard allocator functions
      reftable/basics: fix segfault when growing `names` array fails
      cache-tree: refactor verification to return error codes
      cache-tree: detect mismatching number of index entries
      unpack-trees: detect mismatching number of cache-tree/index entries
      t7300: work around platform-specific behaviour with long paths on MinGW
      ci: create script to set up Git for Windows SDK
      ci: handle Windows-based CI jobs in GitLab CI
      gitlab-ci: introduce stages and dependencies
      gitlab-ci: exercise Git on Windows
      builtin/gc: fix crash when running `git maintenance start`
      t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
      t/test-lib: wire up NO_ICONV prerequisite
      t/lib-gitweb: test against the build version of gitweb
      t/lib-gpg: fix setup of GNUPGHOME in MinGW
      t1401: make invocation of tar(1) work with Win32-provided one
      t3404: work around platform-specific behaviour on macOS 10.15
      t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
      t7300: work around platform-specific behaviour with long paths on MinGW
      builtin/credential-cache: fix missing parameter for stub function
      http: fix build error on FreeBSD
      reftable: stop using `strbuf_addbuf()`
      reftable: stop using `strbuf_addf()`
      reftable/basics: provide new `reftable_buf` interface
      reftable: convert from `strbuf` to `reftable_buf`
      reftable/blocksource: adapt interface name
      t/unit-tests: check for `reftable_buf` allocation errors
      reftable/stack: adapt `format_name()` to handle allocation failures
      reftable/record: adapt `reftable_record_key()` to handle allocation failures
      reftable/stack: adapt `stack_filename()` to handle allocation failures
      reftable: handle trivial `reftable_buf` errors
      ref-filter: format iteratively with lexicographic refname sorting
      t/unit-tests: update clar to 206accb
      Makefile: extract script to generate clar declarations
      cmake: fix compilation of clar-based unit tests
      cmake: set up proper dependencies for generated clar headers
      compat/mingw: share file handles created via `CreateFileW()`
      compat/mingw: allow deletion of most opened files
      t6006: fix prereq handling with `test_format ()`
      builtin/ls-remote: plug leaking server options
      t/helper: fix leaks in "reach" test tool
      grep: fix leak in `grep_splice_or()`
      builtin/grep: fix leak with `--max-count=0`
      revision: fix leaking bloom filters
      diff-lib: fix leaking diffopts in `do_diff_cache()`
      pretty: clear signature check
      upload-pack: fix leaking URI protocols
      builtin/commit: fix leaking change data contents
      trailer: fix leaking trailer values
      trailer: fix leaking strbufs when formatting trailers
      builtin/commit: fix leaking cleanup config
      transport-helper: fix leaking import/export marks
      builtin/tag: fix leaking key ID on failure to sign
      combine-diff: fix leaking lost lines
      dir: release untracked cache data
      sparse-index: correctly free EWAH contents
      t/helper: stop re-initialization of `the_repository`
      t/helper: fix leaking buffer in "dump-untracked-cache"
      dir: fix leak when parsing "status.showUntrackedFiles"
      builtin/merge: release output buffer after performing merge
      list-objects-filter-options: work around reported leak on error
      compat/mingw: support POSIX semantics for atomic renames
      t/unit-tests: convert "clar-generate.awk" into a shell script
      cmake: use SH_EXE to execute clar scripts
      cmake: use verbatim arguments when invoking clar commands
      Makefile: let clar header targets depend on their scripts
      reftable/system: move "dir.h" to its only user
      reftable: explicitly handle hash format IDs
      reftable/system: stop depending on "hash.h"
      reftable/stack: stop using `fsync_component()` directly
      reftable/system: provide thin wrapper for tempfile subsystem
      reftable/stack: drop only use of `get_locked_file_path()`
      reftable/system: provide thin wrapper for lockfile subsystem
      builtin/gc: provide hint when maintenance hits a stale schedule lock
      refs: allow passing flags when setting up a transaction
      refs/files: move logic to commit initial transaction
      refs: introduce "initial" transaction flag
      refs/files: support symbolic and root refs in initial transaction
      refs: use "initial" transaction semantics to migrate refs
      refs: skip collision checks in initial transactions
      refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
      reftable/writer: optimize allocations by using a scratch buffer
      reftable/block: rename `block_writer::buf` variable
      reftable/block: optimize allocations by using scratch buffer
      builtin/blame: fix leaking blame entries with `--incremental`
      bisect: fix leaking good/bad terms when reading multipe times
      bisect: fix leaking string in `handle_bad_merge_base()`
      bisect: fix leaking `current_bad_oid`
      bisect: fix multiple leaks in `bisect_next_all()`
      bisect: fix leaking commit list items in `check_merge_base()`
      bisect: fix various cases where we leak commit list items
      line-log: fix leak when rewriting commit parents
      strvec: introduce new `strvec_splice()` function
      git: refactor alias handling to use a `struct strvec`
      git: refactor builtin handling to use a `struct strvec`
      split-index: fix memory leak in `move_cache_to_base_index()`
      builtin/sparse-checkout: fix leaking sanitized patterns
      help: refactor to not use globals for reading config
      help: fix leaking `struct cmdnames`
      help: fix leaking return value from `help_unknown_cmd()`
      builtin/help: fix leaks in `check_git_cmd()`
      builtin/init-db: fix leaking directory paths
      builtin/branch: fix leaking sorting options
      t/helper: fix leaking commit graph in "read-graph" subcommand
      global: drop `UNLEAK()` annotation
      git-compat-util: drop now-unused `UNLEAK()` macro
      t5601: work around leak sanitizer issue
      t: mark some tests as leak free
      t: remove unneeded !SANITIZE_LEAK prerequisites
      test-lib: unconditionally enable leak checking
      t: remove TEST_PASSES_SANITIZE_LEAK annotations
      t7900: fix host-dependent behaviour when testing git-maintenance(1)
      refs: adapt `initial_transaction` flag to be unsigned
      reftable: rename scratch buffer
      bisect: address Coverity warning about potential double free
      refs/reftable: encapsulate reftable stack
      refs/reftable: handle reloading stacks in the reftable backend
      reftable/stack: add accessor for the hash ID
      refs/reftable: figure out hash via `reftable_stack`
      refs/reftable: read references via `struct reftable_backend`
      refs/reftable: refactor reading symbolic refs to use reftable backend
      refs/reftable: refactor reflog expiry to use reftable backend
      reftable/stack: add mechanism to notify callers on reload
      reftable/merged: drain priority queue on reseek
      refs/reftable: reuse iterators when reading refs
      git-compat-util: introduce macros to disable "-Wsign-compare" warnings
      compat/regex: explicitly ignore "-Wsign-compare" warnings
      compat/win32: fix -Wsign-compare warning in "wWinMain()"
      global: mark code units that generate warnings with `-Wsign-compare`
      config.mak.dev: drop `-Wno-sign-compare`
      diff.h: fix index used to loop through unsigned integer
      pkt-line: fix -Wsign-compare warning on 32 bit platform
      global: trivial conversions to fix `-Wsign-compare` warnings
      daemon: fix loops that have mismatching integer types
      daemon: fix type of `max_connections`
      gpg-interface: address -Wsign-comparison warnings
      builtin/blame: fix type of `length` variable when emitting object ID
      builtin/patch-id: fix type of `get_one_patchid()`
      scalar: address -Wsign-compare warnings
      t/helper: don't depend on implicit wraparound
      Makefile: use common template for GIT-BUILD-OPTIONS
      Makefile: consistently use @PLACEHOLDER@ to substitute
      Makefile: refactor GIT-VERSION-GEN to be reusable
      Makefile: propagate Git version via generated header
      Makefile: consistently use PERL_PATH
      Makefile: generate "git.rc" via GIT-VERSION-GEN
      Makefile: extract script to massage Perl scripts
      Makefile: generate doc versions via GIT-VERSION-GEN
      Makefile: use "generate-perl.sh" to massage Perl library
      Makefile: extract script to massage Shell scripts
      Makefile: extract script to massage Python scripts
      Makefile: extract script to generate gitweb.cgi
      Makefile: extract script to generate gitweb.js
      Makefile: refactor generators to be PWD-independent
      Makefile: allow "bin-wrappers/" directory to exist
      Makefile: write absolute program path into bin-wrappers
      Makefile: simplify building of templates
      Documentation: allow sourcing generated includes from separate dir
      Documentation: teach "cmd-list.perl" about out-of-tree builds
      Documentation: extract script to generate a list of mergetools
      t: better support for out-of-tree builds
      t: allow overriding build dir
      Documentation: add comparison of build systems
      Introduce support for the Meson build system
      object-name: fix reversed ordering with ":/<text>" revisions
      gitlab-ci: update macOS images to Sonoma
      ci/lib: remove duplicate trap to end "CI setup" group
      ci/lib: do not interpret escape sequences in `group ()` arguments
      ci/lib: fix "CI setup" sections with GitLab CI
      ci/lib: support custom output directories when creating test artifacts
      Makefile: drop -DSUPPRESS_ANNOTATED_LEAKS
      t/unit-tests: rename clar-based unit tests to have a common prefix
      meson: detect missing tests at configure time
      Makefile: detect missing Meson tests
      t: fix out-of-tree tests for some git-p4 tests
      t: introduce compatibility options to clar-based tests
      ci: wire up Meson builds
      meson: skip gitweb build when Perl is disabled
      Makefile: stop including "GIT-VERSION-FILE" in docs
      Makefile: drop unneeded indirection for GIT-VERSION-GEN outputs
      Makefile: introduce template for GIT-VERSION-GEN
      GIT-VERSION-GEN: fix overriding GIT_VERSION
      GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT and GIT_DATE
      meson: add options to override build information
      reftable/stack: don't perform auto-compaction with less than two tables
      reftable/merged: fix zero-sized allocation when there are no readers
      reftable/stack: fix zero-sized allocation when there are no readers
      reftable/basics: return NULL on zero-sized allocations
      GIT-BUILD-OPTIONS: sort variables alphabetically
      GIT-BUILD-OPTIONS: wire up NO_GITWEB option
      meson: enable auto-discovered "gitweb"
      meson: wire up support for AsciiDoctor
      meson: properly wire up dependencies for our docs
      meson: fix generation of merge tools
      meson: generate HTML pages for all man page categories
      Documentation: inline user-manual.conf
      meson: generate user manual
      Documentation: refactor "api-index.sh" for out-of-tree builds
      Documentation: refactor "howto-index.sh" for out-of-tree builds
      meson: generate articles
      meson: install static files for HTML documentation
      t/Makefile: make "check-meson" work with Dash
      Documentation: wire up sanity checks for Meson
      bulk-checkin: fix segfault with unsafe SHA1 backend
      builtin/fast-import: fix segfault with unsafe SHA1 backend
      ci: exercise unsafe OpenSSL backend

Peter Krefting (1):
      gitk: sv.po: Update Swedish translation (323t)

Philippe Blain (6):
      Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
      completion: complete '--tool-help' in 'git mergetool'
      git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
      git-mergetool--lib.sh: add error message if 'setup_user_tool' fails
      git-mergetool--lib.sh: add error message for unknown tool variant
      git-difftool--helper.sh: exit upon initialize_merge_tool errors

Piotr Szlazak (1):
      doc: document how uploadpack.allowAnySHA1InWant impact other allow options

Ramsay Jones (1):
      credential-cache: treat ECONNABORTED like ECONNRESET

René Scharfe (5):
      grep: disable lookahead on error
      reftable: avoid leaks on realloc error
      reftable: fix allocation count on realloc error
      reftable: handle realloc error in parse_names()
      t-reftable-merged: handle realloc errors

Rubén Justo (1):
      strvec: `strvec_splice()` to a statically initialized vector

Seija Kijin (1):
      git: use calloc instead of malloc + memset where possible

Seyi Kuforiji (2):
      t7011: ensure no whitespace after redirect
      t9101: ensure no whitespace after redirect

Shubham Kanodia (1):
      doc: add a note about staggering of maintenance

Simon Marchi (1):
      builtin/difftool: intialize some hashmap variables

Sven Strickroth (1):
      global: Fix duplicate word typos

Sören Krecker (1):
      mingw.c: Fix complier warnings for a 64 bit msvc

Taylor Blau (14):
      Documentation: mention the amlog in howto/maintain-git.txt
      The second batch
      The third batch
      The third batch
      The fifth batch
      The sixth batch
      The seventh batch
      t5332-multi-pack-reuse.sh: demonstrate duplicate packing failure
      pack-objects: only perform verbatim reuse on the preferred pack
      pack-bitmap.c: typofix in `find_boundary_objects()`
      t/perf: use 'test_file_size' in more places
      Makefile(s): avoid recipe prefix in conditional statements
      packfile.c: remove unnecessary prepare_packed_git() call
      pack-bitmap.c: ensure pack validity for all reuse packs

Tobias Boesch (1):
      git gui: add directly calling merge tool from configuration

Tobias Pietzsch (1):
      gitk: check main window visibility before waiting for it to show

Toon Claes (2):
      bundle-uri: plug leak in unbundle_from_file()
      bundle: remove unneeded code

Usman Akinyemi (5):
      t3404: avoid losing exit status with focus on `git show` and `git cat-file`
      t3404: replace test with test_line_count()
      daemon: replace atoi() with strtoul_ui() and strtol_i()
      merge: replace atoi() with strtol_i() for marker size validation
      imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing

Wolfgang Müller (1):
      builtin/shortlog: explicitly set hash algo when there is no repo

Xing Xin (6):
      transport: introduce parse_transport_option() method
      remote: introduce remote.<name>.serverOption configuration
      transport.c::handshake: make use of server options from remote
      fetch: respect --server-option when fetching multiple remotes
      ls-remote: leakfix for not clearing server_options
      Documentation/gitprotocol-v2.txt: fix a slight inconsistency in format

Yuri Konotopov (1):
      git-gui: use system encoding to show console output

brian m. carlson (18):
      git-curl-compat: remove check for curl 7.21.5
      git-curl-compat: remove check for curl 7.25.0
      git-curl-compat: remove check for curl 7.34.0
      git-curl-compat: remove check for curl 7.39.0
      git-curl-compat: remove check for curl 7.43.0
      git-curl-compat: remove check for curl 7.44.0
      git-curl-compat: remove check for curl 7.52.0
      git-curl-compat: remove check for curl 7.53.0
      git-curl-compat: remove check for curl 7.56.0
      INSTALL: document requirement for libcurl 7.61.0
      Require Perl 5.26.0
      gitweb: make use of s///r
      gitlab-ci: switch from Ubuntu 16.04 to 20.04
      ci: remove clause for Ubuntu 16.04
      Add additional CI jobs to avoid accidental breakage
      Allow cloning from repositories owned by another user
      index-pack: rename struct thread_local
      reflog: rename unreachable

shejialuo (10):
      ref: initialize "fsck_ref_report" with zero
      ref: check the full refname instead of basename
      ref: initialize ref name outside of check functions
      ref: support multiple worktrees check for refs
      ref: port git-fsck(1) regular refs check for files backend
      ref: add more strict checks for regular refs
      ref: add basic symref content check for files backend
      ref: check whether the target of the symref is a ref
      ref: add symlink ref content check for files backend
      ref-cache: fix invalid free operation in `free_ref_entry`


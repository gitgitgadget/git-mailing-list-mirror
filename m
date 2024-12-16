Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D920767E;
	Mon, 16 Dec 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372896; cv=none; b=gOUpJmg1kiz12Tf2rhI1PJy5fVecVcmgiaTnYiHyOSbGSa9KGRm0gz7mZ5Xnf7BD4/3kQ4K46QuEe+vW6TLnZMAPGURDIsaHeJT2dbHENWiG+sT2b9OXO98hwDWce/wOb22tjY+mZ8bmTRKS6gaCTPvKiEioNKd+iefXBgK0jTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372896; c=relaxed/simple;
	bh=ccsX/pTWA7tHUj89JVb/3zQdWo/neMZfpasSn4TLPX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jBghKTQSeimbEPI44yOWt32zYXVKgv0WeXKgmeVpKX/Lxi7rR0qm5Vj3Aj+Ze26ZlRqOfGqtKy+D6i09Quhq43M6Rjt5L9+rR/xOagLq/8FqMP1bLg3v/eIwXGWBo+FwDsAorHxBM8X60ofQHjinuU/S2cpB0Q3qT4gG2AAB9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LaPbWb1T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sjtx9QuT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LaPbWb1T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sjtx9QuT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40F23254015D;
	Mon, 16 Dec 2024 13:14:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 16 Dec 2024 13:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1734372892; x=1734459292; bh=LE
	DliH3c9iqsPOAX9TZ/0uxK5LmEe4Prt3kIVQ+Jl/k=; b=LaPbWb1TSGYY+8Pze0
	b18zCV6qxsdzhfHUIjkUyyRFn9SYpXQxVFqFTNEQcpXX7uLUXYXvR1EZ/WwToSbz
	wr2Jxsv0dG/+z5V/jScKVhDS5VmzM6rbjY4++5DVFAU6UMUd1lTiu1Cqvg0+xKEB
	odOtAPfYmq7gIDgplV9EzQBgCx5MghQT9ltBz/RE16vkeNd4mOistgHOIMXG0XgM
	WA+IeCXD7YSN/H9jTojzNPxz0iSgjmdmW2UPejB6PN07VLffR7F8Nv88/oFOQg38
	FNPMPoAHTvuBCb1noGucatBf4nUnXuU2Jca9PJBRITt+6kd8kEqSvlNycPQFHnKq
	hq5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734372892; x=1734459292; bh=LEDliH3c9iqsPOAX9TZ/0uxK5LmE
	e4Prt3kIVQ+Jl/k=; b=Sjtx9QuTOEIpzLxsL4u3GWioj/t6KHhm35Dde98OyP8l
	HQAJGu+WTHeimExR5EQwNRzvDesM2r0efwRQbcsleWghEpgTCuFDUDzxmBd4Le+k
	izRGwU1B81/d7mqrJnyevyPwwOz1JzbWBJSd6nbBhQ1tBIXkWEheCDzrBLJ5yEiF
	fR2Nki5rn5Z2Wchu3LzH8Zm5C9L8sW3apiAMKUNcfq3x880LCS3oiscRZD/oCA/+
	F9KPp+YRr0gxqbqOrvBVcO8erEGT8sLToGElZ/zXFLMzxZp88ETqgXyWnSXBq7kX
	D3ASq8EbMneHq1++vjxwW8d4WdcMdloAu2U8JONSrQ==
X-ME-Sender: <xms:G25gZxxvZ0STwGlMBvmfmmFtgWfM2xQ39EEUBGxgOkoSb2C-5lul2Q>
    <xme:G25gZxSTowv549DMnrzA4RGUapezNIkvjZ149ZhpOu8pqH26GzTE_K3G2rZ7UXo9v
    E-5WgDhWIXgfKAnPQ>
X-ME-Received: <xmr:G25gZ7XvmdBhLFQ38jq2AKB6OGUYQrcrgemEIbUl6eCSwmetGgmpTY_bwaRVqjO5_ypVlfKMV5VpxUjXM9Ta7J9wJ_ze6sOoH2HiR7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkfgggtgfgsehtkeertddtreejnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpedtgeegtdevhfeivedvheegfffffeffgeeluefg
    hfeftefghfejvdffgefffeegheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgoh
    hoghhlvghsohhurhgtvgdrtghomhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtqdhprggtkhgrghgvrhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtph
    htthhopehlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:G25gZzgap1QWYajId2jp855MXeKd9iO1m11I-euv4NepN0UmjTbKhw>
    <xmx:G25gZzA-mCQzzO8So_mtd6Q811OPE9WTSjd1KFIn8hX8pt-x5NojUg>
    <xmx:G25gZ8I22NEw6V9NCGEHFfwn1gHjC3awZNpLgv6fxupKMnVxfg7WVQ>
    <xmx:G25gZyAut8NigUDp8J9sOB5En4AojcVGmsqQvDF3tyIT_8gA4I4vlw>
    <xmx:HG5gZ-71IO9oOW85Pn9963_gOL1ZRBFoL6WRyDPZydoMJAbmwbIVcxkp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 13:14:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.48.0-rc0
Date: Mon, 16 Dec 2024 10:14:50 -0800
Message-ID: <xmqqfrmn4hr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

An early preview release Git v2.48.0-rc0 is now available for
testing at the usual places.  It is comprised of 446 non-merge
commits since v2.47.0, contributed by 66 people, 26 of which are
new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.48.0-rc0' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.47.0 are as follows.
Welcome to the Git development community!

  Aarni Koskela, Abraham Samuel Adekunle, Bence Ferdinandy,
  Caleb White, Chizoba ODINAKA, Daniel Black, David Gstir, Ed
  Reel, Eric Mills, fox, Jaroslav Lobačevski, Josh Heinrichs,
  Josh Poimboeuf, Kai Koponen, Kev Kloss, Liu Zhongbo, Miguel
  Rincon Barahona, Monika Kairaitytė, Nicolas Guichard, Russell
  Stuart, Sam James, Seyi Kuforiji, Shubham Kanodia, Simon Marchi,
  Tobias Boesch, and Usman Akinyemi.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alejandro R. Sedeño, Andrew Kreimer, brian m. carlson, Dario
  Gjorgjevski, Derrick Stolee, Elijah Newren, Eli Schwartz, Eric
  Sesterhenn, Eric Sunshine, Jean-Noël Avila, Jeff King, Johannes
  Schindelin, Johannes Sixt, John Cai, Jonathan Tan, Josh Soref,
  Josh Steadmon, Junio C Hamano, Justin Tobler, Karthik Nayak,
  Koji Nakamaru, Kousik Sanagavarapu, Kristoffer Haugsbakk, Linus
  Arver, Oswald Buddenhagen, Patrick Steinhardt, Philippe Blain,
  Phillip Wood, Piotr Szlazak, Ramsay Jones, Rasmus Villemoes,
  René Scharfe, Rubén Justo, shejialuo, Sören Krecker, Sven
  Strickroth, Taylor Blau, Toon Claes, Wolfgang Müller, and
  Xing Xin.

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

 * Other code cleanup, docfix, build fix, etc.
   (merge 77af53f56f aa/t7300-modernize later to maint).
   (merge dcd590a39d bf/t-readme-mention-reftable later to maint).
   (merge 68e3c69efa kh/trailer-in-glossary later to maint).
   (merge 91f88f76e6 tb/boundary-traversal-fix later to maint).
   (merge 168ebb7159 jc/doc-error-message-guidelines later to maint).
   (merge 18693d7d65 kh/doc-bundle-typofix later to maint).
   (merge e2f5d3b491 kh/doc-update-ref-grammofix later to maint).

----------------------------------------------------------------

Changes since v2.47.0 are as follows:

Abraham Samuel Adekunle (2):
      t7300-clean.sh: use test_path_* helper functions for error logging
      notes: teach the -e option to edit messages in editor

Alejandro R. Sedeño (1):
      Makefile: adjust sed command for generating "clar-decls.h"

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

Bence Ferdinandy (2):
      t/README: add missing value for GIT_TEST_DEFAULT_REF_FORMAT
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

Jeff King (36):
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

Johannes Schindelin (1):
      docs: fix the `maintain-git` links in `technical/platform-support`

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

Junio C Hamano (22):
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
      The fifteenth batch
      The sixteenth batch
      Git 2.48-rc0

Justin Tobler (4):
      bundle: add bundle verification options type
      bundle: support fsck message configuration
      fetch-pack: split out fsck config parsing
      transport: propagate fsck configuration during bundle fetch

Kai Koponen (1):
      doc: mention rev-list --ancestry-path restrictions

Karthik Nayak (23):
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

Linus Arver (1):
      trailer: spread usage of "trailer_block" language

Nicolas Guichard (3):
      load_branch_decorations: fix memory leak with non-static filters
      rebase-update-refs: extract load_branch_decorations
      rebase-merges: try and use branch names as labels

Oswald Buddenhagen (2):
      git-gui: strip comments and consecutive empty lines from commit messages
      git-gui: strip commit messages less aggressively

Patrick Steinhardt (197):
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
      Makefile: use common template for GIT-BUILD-OPTIONS
      Makefile: consistently use @PLACEHOLDER@ to substitute
      Makefile: refactor GIT-VERSION-GEN to be reusable
      Makefile: propagate Git version via generated header
      Makefile: generate "git.rc" via GIT-VERSION-GEN
      Makefile: generate doc versions via GIT-VERSION-GEN
      Makefile: consistently use PERL_PATH
      Makefile: extract script to massage Perl scripts
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

René Scharfe (1):
      grep: disable lookahead on error

Rubén Justo (1):
      strvec: `strvec_splice()` to a statically initialized vector

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

Taylor Blau (13):
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

Tobias Boesch (1):
      git gui: add directly calling merge tool from configuration

Toon Claes (1):
      bundle-uri: plug leak in unbundle_from_file()

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


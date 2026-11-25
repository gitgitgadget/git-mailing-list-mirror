Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633588;
	b=XKgkbgE5Mu3dtVYTJTwP/A1EWBZzVgIAusFja5BKEFgClE3W25HgoA/U3EWCZ/aYLg+v
	 +KwuxmS4Agu3NNJ3CG3DDIoEpYd/Mh0EICVZq2c+EkfK0M2SkI9nSWulX4D22Hw9CPtl7
	 hvgc0e50uCiwsRFR2ZwAI+t3zaU4qcZQf/Lqjzx/5n9WMaT1bIOu1zk6WYP0vjj7XY7Rl
	 hhPZEWjvRXl6qczSjYUTs2hDY+9oRl6W0+prog6U9ZO9WrYnhd0G9I9R60PCKTJjcY3zn
	 zWg1lehR7b066iSx5Q5rEP8kBP6RK8883t1H6zFgGUZF/NaWapjX57e2hGqqTKc+WJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=BM8FTcggfF76d6uMH0um6JcUiHbQrHcrGGhpvgyknBM=;
	b=DFRlxgkvY0lp3QaRSlkT3a8poFc06PhhGbQVK1MHb20B8sQhV5P1kKGVVJyGlw7hXjwP
	 rv7RGHlIHUOCGbkGZWsF29PUmMFjHAVs04LEBBDmvN0tWwNKl2SrbvfQyaiOcgXiJaKqP
	 Lz5pXtBVKT3V6jca1rmkLpKcWqArAu0QMwuwFWX32nzfR8LJD5I9TIJGtSG6/0XmBmI/b
	 FcsMNDHaJXV7llsrC5jYwc1ywb7Efnd9gQ6OyzYqEGF7est/c8AtJH4Ethyw/ndG6lyW9
	 fpEh0mt2ECpi+MbkCTWUiHUTKXWle5DVxOPXVYQbyDgya5m6FePROmNFxA9uFUBN2sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C94sneNE;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD662606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD662606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C94sneNE
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-862a19300b7so2142130a34.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633586; x=1796238386; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BM8FTcggfF76d6uMH0um6JcUiHbQrHcrGGhpvgyknBM=;
        b=C94sneNEv0xa/9ZJhGzUheBvzWcriIOEqXSGPhrDbR3ehEg8Su7rNGJGb/6whRI0d1
         7ooiaQrvyGLGQTi/+S3i0HNMtXTvPbh1MdTWDZzWdqt0RP5qw1dbN8sEgwaAiQOyEOoY
         V5eRrKJ4jgQ6c3JXRXQMcaZhkUXqKh/Bf5eWL0up5I6EXcEBEnfA/MeboyqHw3m9KB/V
         xOAe7RKHUzAU1K+IzG5R+5j+iWAnC7uotKsQko1P9/JUVFqv7wcqcVnY3Y0J1IABm29P
         qZqq0npRyPQBAZggkD7i9d1xnaDt6/BsZD0d+pkgmjo21hVcABYZgMGWijju8RCrUBsh
         NwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633586; x=1796238386;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BM8FTcggfF76d6uMH0um6JcUiHbQrHcrGGhpvgyknBM=;
        b=iJsiBT3VN8GcGUZILatDi6zhDzIUrv3FBNmWZL73hKaObgbFLhf9Txz9puc7AB8yAR
         /Rlu2g1Sq4AVSKjD+r3LMaL6WbZyw+WH8LhzXC5x+Z9FFmPf57V/9bl9X0Vv7vOLsQuR
         DMcubf4CbY/G2OJBTYeEdSOPCTbAaF3/lZ9U+UsF/2ZPCbF4O7vu5Egl0uf/91iqBUCF
         AT4OLdHU160PvN+qQWBzzphjkx4CylTBvC90U9ymkl2ecNO/Ovy/HiBILmlr+D/qhOPy
         z6IarYOZnwUru8Du2xv2pVCcf/qVBGD3Q8E+FTHgn/cyFdKdPqJDm69CgYllJUaHCF+d
         yNqA==
X-Gm-Message-State: APuU4Z9+rPiJdcZ7oRXiyZFMj3qyiHGQTr0/YB3kaRZJxc/i2+BaZd9X
	IlIeSaABmdVxWmOa+qCv7mzA7ElCmdIZu/WmhXz3cOzR4EzCdL5SpZMj8eY6UQ==
X-Gm-Gg: AZFdTZfZ0Pl208tpFEwvY/WaHZYXKRUp6h/QSbSrkfy/Cb2EcRNSjSn7/X+b4niUwwv
	X+mcu7D7erb0g4YprSqlNkDCFiRfidVZYMqcAwm5zpkm6JvBlgJ3/RmBDISSnF2Bg8WnF+kq6gU
	cEw1bcQ/xxfv3mcoxWNuH9k4KoZVX06qQ5AcPFYcgx4QcURQK13mKzSVtu1oVTE53jCr+Ivs5JT
	889g1w6GnECnPETAiiEN2ZUHjht7r8XqirLuh83LKuZhLQ1iXVLojqQXqZSTnGTGUif/85pqnBS
	HvEcKkPXw53xrCJkFA75SXdgumrmJocFcS7u43MjXHHY/uEAnzuMLxxAWmuXWMNFM0hb+N+06lt
	o7ylwUD+R9eFIqtq4emDmZtqYY6JgHcfyDxzSmoWURbFsm5En42izoehHsVOyF2Ysu5dRSa4ExJ
	Npt9l/oaWX3QYZXGRyaJgdWmwTJcrfdwaAIPzpNpJMyzmcpQuNxw+QR0INmCfsibOFVyW6iVeij
	kxIGvZ3SaRzQGNbwVldY6C/+iD4Nz7AJGBQMk7aDfJn+RqOYkdkwE4OmGV3vGEahuhh1juxv2wk
	vNvWLvQS4pTHG25zThM6I+cbe3WImUs+EnVXlrIWVn35M6QpSktyFw==
X-Received: by 2002:a05:6808:308e:b0:4e4:86b1:f7a0 with SMTP id 5614622812f47-57a0bb73645mr19891286b6e.53.1795633586196;
        Wed, 25 Nov 2026 11:06:26 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bd3008160dsm18078539fac.16.2026.11.25.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:24 -0800 (PST)
Message-Id: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:17 +0000
Subject: [PATCH v16 0/7] fetch: avoid fetching every branch of a new remote in a shallow repo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

In a shallow single-branch clone of a large repository, git remote add
upstream <url> sets up the default +refs/heads/*:refs/remotes/upstream/*
refspec. The next git fetch upstream then downloads every branch of that
remote, which defeats the point of a shallow clone.

This series lets a remote fetch only the branches that local branches track:

git remote add --limited-fetch upstream <url>
git fetch upstream main
git branch --set-upstream-to=upstream/main
git fetch upstream    # fetches only main from now on


What to fetch and where to store it are separate settings.
remote.<name>.fetchUpstreams says what to fetch, and
remote.<name>.fetchRefmap says where it is stored. --limited-fetch sets
both:

[remote "upstream"]
    url = <url>
    fetchRefmap = +refs/heads/*:refs/remotes/upstream/*
    fetchUpstreams = true


remote.<name>.fetchRefmap is the configured default for --refmap, the same
way remote.<name>.fetch is the default for the refspecs on the command line.
The command line overrides the configuration, and at the same level a
refspec's own destination wins over the refmap:

 * A refspec <src>:<dst> with non-empty <dst> on the command line is stored
   at <dst> only, with --refmap or with fetchRefmap.
 * A non-empty destination in remote.<name>.fetch is stored only there when
   the refmap comes from fetchRefmap.
 * --refmap on the command line replaces the destinations in
   remote.<name>.fetch. It now also works without refspecs on the command
   line, as long as the remote has something configured to fetch.

A refspec with an empty <dst>, which is what a bare <src> means, is stored
through the refmap. So this stores three branches under refs/remotes/cabal/:

[remote "cabal"]
    url = <url>
    fetch = master
    fetch = next
    fetch = seen
    fetchRefmap = +refs/heads/*:refs/remotes/cabal/*


In a shallow repository, git remote add turns --limited-fetch on by default.

Design notes:

 * A *@{upstream} entry in remote.<name>.fetch was considered for saying
   what to fetch. Released versions of Git die with "invalid refspec" on it,
   so a separate setting is used.
 * The opportunistic update through remote.<name>.fetch is unchanged. On an
   ordinary remote git fetch origin side:refs/heads/tmp still updates
   origin/side. On a remote that only has a fetchRefmap it stores only
   refs/heads/tmp.
 * Tags are followed when a fetch without command-line refspecs ends up
   storing refs, through a destination or through a refmap. --refmap=""
   stores nothing and follows no tags.
 * --prune only acts on destinations written in refspecs. With --refmap and
   no command-line refspecs it leaves the destinations in
   remote.<name>.fetch alone, and destinations that come from a refmap are
   not pruned.

Changes in v16:

 * Tags are now followed when a fetch without command-line refspecs stores
   refs through --refmap or fetchRefmap. --refmap="" stores nothing and no
   longer follows tags.
 * --refmap without command-line refspecs is rejected again when the remote
   has nothing configured to fetch, as with a bare URL.
 * --prune with --refmap and no command-line refspecs no longer prunes under
   the destinations in remote.<name>.fetch.
 * The --refmap docs and the first commit message now say that a refspec
   with non-empty <dst> is not mapped, and that commit message says "a later
   commit".

Changes in v15:

 * Added remote.<name>.fetchUpstreams to say explicitly that the upstreams
   of local branches are fetched, in addition to remote.<name>.fetch. A
   fetchRefmap alone no longer changes what is fetched.
 * A refspec with its own destination on the command line is no longer
   mapped through --refmap or fetchRefmap. This is a new first patch. A
   destination in remote.<name>.fetch is no longer mapped through
   fetchRefmap either.
 * --refmap now works without refspecs on the command line. This is a new
   second patch. It stores what remote.<name>.fetch fetches through the
   given refmap, and it overrides fetchRefmap.
 * Fixed git pull merging every tracked branch into the current one.
 * git remote add --limited-fetch now sets both fetchRefmap and
   fetchUpstreams.
 * Fixed a leftover remote.<name>.refmap in the --refmap docs.
 * Tests share helpers for repeated setup and checks, drop two steps that
   other tests cover, and the "does not fetch it twice" test now checks
   FETCH_HEAD.

Changes in v14:

 * Squashed the @{push} fix into "fetch: infer branches to fetch from a
   refmap-only remote", so the series no longer adds the bug in one patch
   and fixes it in a later one
 * Moved its test to t5586 using the refmap-only remote, so it no longer
   depends on --limited-fetch
 * Dropped the separate "remote: resolve @{push} through
   remote..fetchRefmap" commit

Changes in v13:

 * Added a new commit so @{push} resolves correctly for a --limited-fetch
   remote, falling back to remote.<name>.fetchRefmap the same way fetch
   already does when remote.<name>.fetch doesn't cover the branch being
   pushed.
 * Added a regression test to fetch: add remote.<name>.fetchRefmap covering
   a remote.<name>.fetch entry with an explicit destination, confirming it's
   stored in both that destination and the refmap's.

Changes in v12:

 * Renamed remote.<name>.refmap to remote.<name>.fetchRefmap throughout
   code, docs, and tests, so it reads unambiguously as fetch-only.
 * Added the missing code path in get_ref_map() so a branch fetched by name
   via remote.<name>.fetch is also stored through remote.<name>.fetchRefmap,
   with a new test (the "cabal" example: fetch = master/next/seen plus a
   refmap storing them all under one namespace).
 * Reworded the fetchRefmap commit message and doc entry to drop a redundant
   sentence, fix a confusing paragraph, and spell out that
   remote.<name>.fetch, when configured, still decides what's fetched while
   the refmap only remaps it.
 * Added a prefetch coverage test to t5586-fetch-refmap.sh.

Changes in v11:

 * remote_find_tracking() now falls back to remote.<name>.refmap when
   remote.<name>.fetch doesn't match. Negative refspecs in fetch still
   exclude refs, and both cases have tests
 * The helpers write straight into a strvec, take the output parameter last
   and the remote as const
 * The followRemoteHEAD lookup is done once, not duplicated in two branches
 * Clearer commit messages and docs: a working example plus a reference to
   49ca2fba39, the goal stated first, an incorrect "used to die" claim
   dropped, and an explanation of why a refmap turns on the inference
 * use_limited_fetch is a bool

Changes in v10:

 * Resolve merge conflict after master integrated
   ch/fetch-followremotehead-lazy-validation.

Changes in v9:

 * Moved the do_fetch() if/else-if/else split out of the preliminary
   helper-extraction commit and into the refmap-inference commit that needs
   it. Preliminary commit is now a simpler refactor.

Changes in v8:

 * Split into a preliminary collect_upstream_from_remote() helper commit
   plus a simplified refmap-inference commit.
 * Fixed a regression that could drop the current branch's @{upstream} when
   remote.<name>.fetch was narrowed.
 * Threaded struct repository * through instead of hardcoding
   the_repository.
 * Minor naming and comment cleanups.

Changes in v7:

 * Fixed fatal: --refmap option is only meaningful with command-line
   refspec(s) firing just from configuring remote.<name>.refmap alone, with
   nothing else to fetch.
 * When both remote.<name>.fetch and remote.<name>.refmap are configured, a
   refspec-less fetch follows .fetch as usual, .refmap only remaps something
   already being fetched by name. Added tests.

Changes in v6:

 * Remove leftover reference to deleted default-branch logic in commit
   message.

Changes in v5:

 * Renumber test file from t5585 to t5586.

Changes in v4:

 * Removed the automatic default-branch fetch. A fresh remote fetches
   nothing until you track a branch explicitly.
 * Fixed fetch report showing "new ref HEAD" instead of "new branch "
 * Reworded remote..refmap docs and commit message.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (7):
  fetch: do not apply --refmap to a refspec with a destination
  fetch: let --refmap apply to configured refspecs
  fetch: add remote.<name>.fetchRefmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: add remote.<name>.fetchUpstreams
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |  17 +++
 Documentation/fetch-options.adoc |  12 +-
 Documentation/git-remote.adoc    |  15 ++-
 builtin/fetch.c                  | 121 +++++++++++++----
 builtin/remote.c                 |  34 ++++-
 remote.c                         |  64 ++++++++-
 remote.h                         |  26 ++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  77 +++++++++++
 t/t5510-fetch.sh                 | 220 ++++++++++++++++++++++++++++++-
 t/t5586-fetch-refmap.sh          | 183 +++++++++++++++++++++++++
 11 files changed, 735 insertions(+), 35 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v16
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v16
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v15:

 1:  02bffb6b35 ! 1:  9c7036a75d fetch: do not apply --refmap to a refspec with a destination
     @@ Commit message
          "git fetch --refmap=<map> <remote> <src>:<dst>" stores the fetched
          ref twice, once at <dst> and once where <map> sends <src>. That is
          harmless while --refmap has to be typed on the same command line,
     -    but the next commit lets a remote configure a default for --refmap,
     +    but a later commit lets a remote configure a default for --refmap,
          and then a refspec that names its own destination would have no way
          to say "store it only here".
      
     -    Apply --refmap only to refspecs that have no destination of their
     -    own. A refspec with a destination is stored there and nowhere else.
     +    Apply --refmap only to refspecs with an empty <dst>, which is what a
     +    bare <src> is shorthand for. A refspec with a non-empty <dst> is
     +    stored there and nowhere else.
      
          The opportunistic update of remote-tracking branches through
          remote.<name>.fetch is left alone, so "git fetch origin main:tmp"
     @@ Documentation/fetch-options.adoc: endif::git-pull[]
       	refs to remote-tracking branches, instead of the values of
       	`remote.<name>.fetch` configuration variables for the remote
      -	repository.  Providing an empty _<refspec>_ to the
     -+	repository.  A ref fetched with a destination of its own
     -+	(`<src>:<dst>`) is stored only there and is not mapped.
     ++	repository.  A ref fetched with a refspec `<src>:<dst>` with
     ++	non-empty `<dst>` is stored only there and is not mapped.
      +	Providing an empty _<refspec>_ to the
       	`--refmap` option causes Git to ignore the configured
       	refspecs and rely entirely on the refspecs supplied as
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	(
      +		cd three &&
      +		git fetch --refmap="refs/heads/*:refs/remotes/mapped/*" origin \
     -+			main:refs/remotes/custom/main side &&
     ++			main:refs/remotes/custom/main side: &&
      +		git rev-parse --verify refs/remotes/custom/main &&
      +		test_must_fail git rev-parse --verify refs/remotes/mapped/main &&
      +		git rev-parse --verify refs/remotes/mapped/side
 2:  f848c9b0a8 ! 2:  72c288a81e fetch: let --refmap apply to configured refspecs
     @@ Commit message
          line overrides the configuration, the same way refspecs given on the
          command line override remote.<name>.fetch.
      
     +    Tags are followed when the fetched refs end up stored somewhere, so
     +    --refmap="" follows none. --prune leaves the configured destinations
     +    alone, since this fetch does not store there. Destinations that come
     +    from the refmap are not pruned either, the same as with refspecs on
     +    the command line.
     +
     +    The option is still rejected when it has nothing to map, as in "git
     +    fetch --refmap=<map> <url>" for a URL with no refspecs configured.
     +
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/fetch-options.adoc ##
     @@ Documentation/fetch-options.adoc: endif::git-pull[]
       	specified refspec (can be given more than once) to map the
       	refs to remote-tracking branches, instead of the values of
       	`remote.<name>.fetch` configuration variables for the remote
     --	repository.  A ref fetched with a destination of its own
     --	(`<src>:<dst>`) is stored only there and is not mapped.
     -+	repository.  A refspec on the command line with a destination
     -+	of its own (`<src>:<dst>`) is stored only there and is not
     -+	mapped.  Without refspecs on the command line, the
     +-	repository.  A ref fetched with a refspec `<src>:<dst>` with
     +-	non-empty `<dst>` is stored only there and is not mapped.
     ++	repository.  A ref fetched with a refspec `<src>:<dst>` on the
     ++	command line with non-empty `<dst>` is stored only there and is
     ++	not mapped.  Without refspecs on the command line, the
      +	`remote.<name>.fetch` values still decide what is fetched, and
      +	the refs are stored through the specified refspec instead of
     -+	at the destinations configured there.
     ++	at the destinations configured there.  `--prune` then leaves
     ++	the refs at those configured destinations alone.
       	Providing an empty _<refspec>_ to the
       	`--refmap` option causes Git to ignore the configured
       	refspecs and rely entirely on the refspecs supplied as
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	} else {
       		/* Use the defaults */
       		struct branch *branch = branch_get(NULL);
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
     + 			for (i = 0; i < remote->fetch.nr; i++) {
     + 				get_fetch_map(remote_refs, &remote->fetch.items[i], &tail, 0);
     +-				if (remote->fetch.items[i].dst &&
     ++				if (!refmap.nr && remote->fetch.items[i].dst &&
     + 				    remote->fetch.items[i].dst[0])
     + 					*autotags = 1;
     + 				if (!i && !has_merge && ref_map &&
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 			if (has_merge &&
     + 			    !strcmp(branch->remote_name, remote->name))
     + 				add_merge_config(&ref_map, remote_refs, branch, &tail);
     ++		} else if (refmap.nr) {
     ++			die("--refmap option is only meaningful with refspec(s) to fetch");
     + 		} else if (!prefetch) {
     + 			ref_map = get_remote_ref(remote_refs, "HEAD");
     + 			if (!ref_map)
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       			ref_map->fetch_head_status = FETCH_HEAD_MERGE;
       			tail = &ref_map->next;
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
      +		if (refmap.nr) {
      +			drop_destinations(ref_map);
      +			map_refs_without_dst(ref_map, &refmap, &oref_tail);
     ++			if (orefs)
     ++				*autotags = 1;
      +		}
       	}
       
       	if (tags == TAGS_SET) {
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 		 * We only prune based on refspecs specified
     + 		 * explicitly (via command line or configuration); we
     + 		 * don't care whether --tags was specified.
     ++		 *
     ++		 * With --refmap and no command-line refspecs, the
     ++		 * configured destinations are not where we store, so
     ++		 * they are left alone.
     + 		 */
     + 		if (rs->nr) {
     + 			retcode = prune_refs(&display_state, rs, transaction, ref_map);
     +-		} else {
     ++		} else if (!refmap.nr) {
     + 			retcode = prune_refs(&display_state, &transport->remote->fetch,
     + 					     transaction, ref_map);
     + 		}
      
       ## t/t5510-fetch.sh ##
      @@ t/t5510-fetch.sh: test_expect_success 'explicit pull should update tracking' '
     @@ t/t5510-fetch.sh: test_expect_success 'explicit pull should update tracking' '
      +		n=$(git rev-parse --verify refs/remotes/origin/main) &&
      +		test "$o" = "$n" &&
      +		git rev-parse --verify refs/remotes/none/main
     ++	)
     ++'
     ++
     ++test_expect_success '--refmap stores remote.*.fetch entries without a destination and follows tags' '
     ++	test_when_finished "git tag -d refmap-followed" &&
     ++	test_when_finished "git -C three tag -d refmap-followed" &&
     ++	test_when_finished "git -C three remote remove names" &&
     ++	git tag refmap-followed &&
     ++	(
     ++		cd three &&
     ++		git remote add names .. &&
     ++		git config --unset-all remote.names.fetch &&
     ++		git config remote.names.fetch main &&
     ++		git fetch --refmap="refs/heads/*:refs/remotes/names/*" names &&
     ++		git rev-parse --verify refs/remotes/names/main &&
     ++		git rev-parse --verify refs/tags/refmap-followed
     ++	)
     ++'
     ++
     ++test_expect_success '--refmap="" without command-line refspec does not follow tags' '
     ++	test_when_finished "git tag -d refmap-unfollowed" &&
     ++	git tag refmap-unfollowed &&
     ++	(
     ++		cd three &&
     ++		git fetch --refmap= origin &&
     ++		test_must_fail git rev-parse --verify refs/tags/refmap-unfollowed
     ++	)
     ++'
     ++
     ++test_expect_success '--prune with --refmap leaves the configured destinations alone' '
     ++	test_when_finished "git -C three update-ref -d refs/remotes/origin/stale" &&
     ++	(
     ++		cd three &&
     ++		git update-ref refs/remotes/origin/stale base-origin-main &&
     ++		git fetch --prune --refmap="refs/heads/*:refs/remotes/none/*" origin &&
     ++		git rev-parse --verify refs/remotes/origin/stale
     ++	)
     ++'
     ++
     ++test_expect_success '--refmap is rejected when there are no refspecs to fetch' '
     ++	(
     ++		cd three &&
     ++		test_must_fail git fetch --refmap="refs/heads/*:refs/remotes/none/*" .. 2>err &&
     ++		test_grep "only meaningful with refspec" err
       	)
       '
       
 3:  1169013f2e ! 3:  f94dd72443 fetch: add remote.<name>.fetchRefmap
     @@ Commit message
                  fetch = seen
                  fetchRefmap = +refs/heads/*:refs/remotes/cabal/*
      
     +    Tags are followed for refs stored through the refmap, the same as
     +    for refs stored through remote.<name>.fetch.
     +
          Looking up the remote-tracking branch for a remote branch, as
          @{upstream} and "git branch --track" do, falls back to the refmap when
          remote.<name>.fetch has no match, so that these work for such
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
      +		if (refmap.nr)
       			drop_destinations(ref_map);
      -			map_refs_without_dst(ref_map, &refmap, &oref_tail);
     +-			if (orefs)
     +-				*autotags = 1;
      -		}
      +		if (effective_refmap)
      +			map_refs_without_dst(ref_map, effective_refmap,
      +					     &oref_tail);
     ++		if (orefs)
     ++			*autotags = 1;
       	}
       
       	if (tags == TAGS_SET) {
     @@ t/t5510-fetch.sh: test_expect_success '--refmap is not applied to a refspec with
      +		refs/remotes/cabal/next
      +		refs/remotes/cabal/seen
      +		EOF
     ++		git rev-parse --verify refs/tags/base &&
      +		git branch --track topic cabal/next &&
      +		echo refs/remotes/cabal/next >expect &&
      +		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
 4:  2e2bc76f79 = 4:  f019dd4529 fetch: extract collect_upstream_from_remote() helper
 5:  ece6bd824b ! 5:  8b43d460fe fetch: add remote.<name>.fetchUpstreams
     @@ t/t5586-fetch-refmap.sh (new)
      +		refs/remotes/upstream/main
      +		refs/remotes/upstream/side
      +		EOF
     -+		check_upstream_tip refs/remotes/upstream/side side
     ++		check_upstream_tip refs/remotes/upstream/side side &&
     ++		git rev-parse --verify refs/tags/side-2
      +	)
      +'
      +
     @@ t/t5586-fetch-refmap.sh (new)
      +		cd client &&
      +		git branch side-topic-2 upstream/side &&
      +		git fetch upstream &&
     -+		grep side .git/FETCH_HEAD >fetched &&
     ++		grep "branch .side. of" .git/FETCH_HEAD >fetched &&
      +		test_line_count = 1 fetched
      +	)
      +'
 6:  e60b61e117 = 6:  1f7845b39a remote: add "git remote add --limited-fetch"
 7:  3f06f7f9e2 = 7:  639a7a5737 remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget

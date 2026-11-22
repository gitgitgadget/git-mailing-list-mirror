Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348648;
	b=qcF/E0t2GQ1Ud3sl58mPAIl/69m9D0sFIsNLvBJIfXmyDYY+UUDxSgqBEOnlkii66Mxz
	 WhYLDlZs+mk2PrZgo77p4iCejcfTyNFiR7vhu+fiIVWRKm6fi7azKxyJQRb9LKPEtKO1H
	 Wc08+PfDYwX8WSJ+1KiUIXF9FnLqamiwTogYUGG8huIW7S078514fve7KLtq1ENXv5x2h
	 Auc0bYsR2mz87vZP2igxN+djLS/tk2jxeciGqag6JvoKm5ygw4Bk2gF+6QdTe04k8bJ3i
	 o0Dvh8ZrcQIW1MB4/f6zJisduln8BTzSK1Iuj5VVRZZsFK2JH3Er+xOuBRd8zTN9BVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=nuvM/iTvM3ezSukjx2smhGaQ+mmOnB/5IlKIpM3VuNo=;
	b=jELBFNSGh0t4NEG1QxH/cy11BULTEufw6sHdabfGo55MuIIA+YnC+jXpynXsQDLq+SY7
	 vQVSeMPoZ1jdwv3M5ud6hgIRtMIm+l8cr9tuCGixdr3gpeBlNUiYL8pvtYNiAVpwPpJi2
	 g1om2XQPDocZxPA5MgcqR27+hoi8wi0F/zzKS6Hho8it/2SjuKmVSwG3iUSylhNYg6IrE
	 ByKTLrPqrD/WCO8vKII5uWdNzxfUDYDna8G+bEDuhCyn8FSOmeVK0y9/o97TScRhKop2P
	 8ue5hVYvCUa6hFgzpNfneQqU9EGvbq44sEkeUcI8dBvVRSwXe076g3VFIoF+OKh95eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKMxHEMX;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83967606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83967606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKMxHEMX
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5280921eec.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348646; x=1795953446; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nuvM/iTvM3ezSukjx2smhGaQ+mmOnB/5IlKIpM3VuNo=;
        b=xKMxHEMXkfcTcdioXabbST/wNVmOjDMNNYzuSupOPmeVaHHszzxsfPOFtjOk3HLDrg
         F5IQgbBmH0XBdVAkW0dAUwE28hU2/DF5VLgGLk2u71QOohOMhmkz3DKywwKwDzVH8oBy
         TfY9hERICC5QsKCo1QYcnB4TSGzVCu/X1qIAtXEOcafNTDo/5RwJ3KUD7W/Vt9jMwCia
         QrBaONC4xYwF+Si6FINr2vPfRvUA57qJ4RbB/XPRtIrQxoXvkTNJir7Voh00X09WnMmk
         pO/B2E48geU1lgirmLvhY8+XYMGDpr94sjCMXSfvVoMU2cha0s7Bee3KxHPxS+4XlUaX
         Rn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348647; x=1795953447;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nuvM/iTvM3ezSukjx2smhGaQ+mmOnB/5IlKIpM3VuNo=;
        b=sKk1l7gSxRc8UGo1v5J6pM927K+wuQhOsLF23sCQScynxS8/T3XUcVfe/DmoCnMQAe
         B/egitQa2mi24bo6zlnU6QIPxGM8zftunTCB3iSJllrHmSWbh0rWwiWzPXpTFG/QrnhP
         9N+3XbS2iPmWLgsIKv2fXzSeVyB+x6FTnppUzICFVQRtLTfM2c8l2NDMHdbRlsq2Ock7
         wDJSjtK0zqurXmh4uFs0ck+CI4nNsP+7Rzj/e5xpdNwI+QlqPDyv4bMG0UELdLEs5tWp
         hDMX4NRzRTWTxhv07Psywrlc61XgEWDqPjzQX1Z11pjQkWKjBKyJbvDTwiq7ajwqUzVG
         r3Ig==
X-Gm-Message-State: APuU4Z/FBT3qCWtlkFivvLLOWsBeHUPCc06UaXxqIS5TkcMzLKJBx/kB
	0Lv7BDskPe9fd+MlqpxzKaOf/y8ZcyOFI/Npk23Go1TcAS8u/FD/EugP5G180Q==
X-Gm-Gg: AZFdTZcQLSaH858qv6OGhyW5IMteDELQmOoFYvf/8dKK0yaa0otC4oTew8EM0M6KIdA
	rgsmf1JQqP3oPtoKJ1/OQBrUsV0IkextVJMWdVV3r2PivzsqrWGHOVnzMIE0y8fhCOfFl5VTrhy
	EiBjN0vQYOfz2EvCAZX8T0PTk09As8F8QJLaoOJmOwePqn3WV9vWDdkuDiTIugrTOgzTC+z6SGe
	zStMG+yWWrFjS7Bu+ve7QbVoqCbi2xD9pR8VcByAIME/tHD8c3qSsnWXLNlnsoL/oz7L0LT9s/M
	CYf1ZgBUF/ZyiV8vC/zKBx+3KlbALmY1Z2CKwBy7KVjMzx8JXck2xh09YLcQqRk7qtTyfnirqe7
	LFATJ4aVgBcx1hF36gkTK4PcLHM2j9DA8f0k1Cs6nv81YRihGsQEUFKKAkniIeMgdCEzckotsIJ
	34xWFlsM4kGeeYn8UK3GHSakNftkZs4Saarrj4pSqqI0Gj1S+qs7VuB8Q94D7gTvSKh1num9a03
	1wdLSNCZgqto8h+9tSVSn5VTD2XsLMTJtu3l366YFWLjok6vFlI06itHp9PA8KHs9yx2Epxuk+/
	u0A2CyFujzCgPNXDYaT+XXFTcaobvsmU7g==
X-Received: by 2002:a05:7301:3f0a:b0:384:8f9:bbf6 with SMTP id 5a478bee46e88-3857180d3b2mr14434204eec.38.1795348646142;
        Sun, 22 Nov 2026 03:57:26 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm25754507eec.15.2026.11.22.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:25 -0800 (PST)
Message-Id: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:17 +0000
Subject: [PATCH v15 0/7] fetch: avoid fetching every branch of a new remote in a shallow repo
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

 * src:dst on the command line is stored at dst only, with --refmap or with
   fetchRefmap.
 * A destination in remote.<name>.fetch is stored only there when the refmap
   comes from fetchRefmap.
 * --refmap on the command line replaces the destinations in
   remote.<name>.fetch. It now also works without refspecs on the command
   line, where it used to die.

A refspec without a destination is stored through the refmap. So this stores
three branches under refs/remotes/cabal/:

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
 Documentation/fetch-options.adoc |  11 +-
 Documentation/git-remote.adoc    |  15 ++-
 builtin/fetch.c                  | 109 ++++++++++++++----
 builtin/remote.c                 |  34 +++++-
 remote.c                         |  64 ++++++++++-
 remote.h                         |  26 +++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  77 +++++++++++++
 t/t5510-fetch.sh                 | 175 ++++++++++++++++++++++++++++-
 t/t5586-fetch-refmap.sh          | 182 +++++++++++++++++++++++++++++++
 11 files changed, 678 insertions(+), 33 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: f7de81456940dd6f3274e461149bba12965de609
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v15
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v14:

 -:  ---------- > 1:  02bffb6b35 fetch: do not apply --refmap to a refspec with a destination
 -:  ---------- > 2:  f848c9b0a8 fetch: let --refmap apply to configured refspecs
 1:  c63699b402 ! 3:  1169013f2e fetch: add remote.<name>.fetchRefmap
     @@ Commit message
          Add a per-remote config variable, remote.<name>.fetchRefmap, that
          provides the default value for --refmap the same way
          remote.<name>.fetch already provides the default refspecs to fetch.
     +    --refmap on the command line overrides it.
      
     -    Unlike passing --refmap on the command line, which requires an
     -    explicit refspec to go with it, configuring remote.<name>.fetchRefmap
     -    on its own does not change what a refspec-less fetch does: it falls
     -    back to the same defaults as a remote with no fetchRefmap at all.
     +    The refmap only says where fetched refs are stored. Configuring it
     +    does not change what a fetch without refspecs fetches.
      
          When remote.<name>.fetch is also configured, it still decides what to
     -    fetch, and the refmap maps what it fetches. This lets a remote name
     -    only a few branches and store them all through one refmap:
     +    fetch. Its entries without a destination are stored through the
     +    refmap, and an entry with its own destination is stored only there.
     +    This lets a remote name only a few branches and store them all
     +    through one refmap:
      
              [remote "cabal"]
                  fetch = master
     @@ Documentation/config/remote.adoc: remote.<name>.fetch::
      +	fetched to remote-tracking refs to store, the same way
      +	`remote.<name>.fetch` does for an explicit refspec.
      +	`remote.<name>.fetch`, if also configured, still decides what is
     -+	fetched. See the `--refmap` entry in linkgit:git-fetch[1].
     ++	fetched, and an entry there with its own destination is stored
     ++	only at that destination. See the `--refmap` entry in
     ++	linkgit:git-fetch[1].
      +
       remote.<name>.push::
       	The default set of "refspec" for linkgit:git-push[1]. See
     @@ Documentation/fetch-options.adoc: endif::git-pull[]
       	command-line arguments. See section on "Configured Remote-tracking
       	Branches" for details.
      ++
     -+`remote.<name>.refmap` provides the default value for this option, the
     ++`remote.<name>.fetchRefmap` provides the default value for this option, the
      +same way `remote.<name>.fetch` provides the default refspecs to fetch.
       
       `-t`::
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
      +		filter_prefetch_refspec(effective_refmap);
       
       	if (rs->nr) {
     - 		struct refspec *fetch_refspec;
     + 		for (i = 0; i < rs->nr; i++) {
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 		 * by ref_remove_duplicates() in favor of one of these
       		 * opportunistic entries with FETCH_HEAD_IGNORE.
     + 		 *
     + 		 * A refspec that names its own destination is not
     +-		 * mapped through --refmap.
     ++		 * mapped through the refmap.
       		 */
      -		if (refmap.nr)
     --			fetch_refspec = &refmap;
     +-			map_refs_without_dst(ref_map, &refmap, &oref_tail);
      +		if (effective_refmap && effective_refmap->nr)
     -+			fetch_refspec = effective_refmap;
     ++			map_refs_without_dst(ref_map, effective_refmap,
     ++					     &oref_tail);
       		else
     - 			fetch_refspec = &remote->fetch;
     - 
     + 			for (i = 0; i < remote->fetch.nr; i++)
     + 				get_fetch_map(ref_map, &remote->fetch.items[i],
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 			if (has_merge &&
     - 			    !strcmp(branch->remote_name, remote->name))
     - 				add_merge_config(&ref_map, remote_refs, branch, &tail);
     -+
     -+			for (i = 0; i < remote->refmap.nr; i++)
     -+				get_fetch_map(ref_map, &remote->refmap.items[i],
     -+					      &oref_tail, 1);
     - 		} else if (!prefetch) {
     - 			ref_map = get_remote_ref(remote_refs, "HEAD");
     - 			if (!ref_map)
     + 			tail = &ref_map->next;
     + 		}
     + 
     +-		if (refmap.nr) {
     ++		if (refmap.nr)
     + 			drop_destinations(ref_map);
     +-			map_refs_without_dst(ref_map, &refmap, &oref_tail);
     +-		}
     ++		if (effective_refmap)
     ++			map_refs_without_dst(ref_map, effective_refmap,
     ++					     &oref_tail);
     + 	}
     + 
     + 	if (tags == TAGS_SET) {
      
       ## remote.c ##
      @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     @@ remote.h: struct remote {
       	 * configured refspecs);
      
       ## t/t5510-fetch.sh ##
     -@@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
     +@@ t/t5510-fetch.sh: test_expect_success '--refmap is not applied to a refspec with a destination' '
       	)
       '
       
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	test_cmp expect actual
      +}
      +
     -+test_expect_success 'remote.<name>.fetchRefmap without tracking (baseline)' '
     -+	test_when_finished "rm -fr fetch-refmap-baseline fetch-refmap-upstream" &&
     -+	git init -b main fetch-refmap-upstream &&
     ++setup_refmap_repos () {
     ++	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     ++	git init -b "$1" fetch-refmap-upstream &&
      +	test_commit -C fetch-refmap-upstream base &&
     -+	git -C fetch-refmap-upstream branch other &&
     -+	git init fetch-refmap-baseline &&
     ++	shift &&
     ++	for branch
     ++	do
     ++		git -C fetch-refmap-upstream branch "$branch" || return 1
     ++	done &&
     ++	git init downstream &&
      +	(
     -+		cd fetch-refmap-baseline &&
     -+		git remote add origin ../fetch-refmap-upstream &&
     ++		cd downstream &&
     ++		git remote add cabal ../fetch-refmap-upstream &&
     ++		git config --unset-all remote.cabal.fetch &&
     ++		git config remote.cabal.fetchRefmap \
     ++			"+refs/heads/*:refs/remotes/cabal/*"
     ++	)
     ++}
      +
     -+		# Without fetch refspec, but with fetch refmap.
     -+		git config --unset-all remote.origin.fetch &&
     -+		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
     ++test_expect_success 'remote.<name>.fetchRefmap without tracking (baseline)' '
     ++	setup_refmap_repos main other &&
     ++	(
     ++		cd downstream &&
      +
      +		# Nothing tracked, nothing fetched, no error.
     -+		git fetch origin &&
     -+		check_fetched_refs <<-\EOF &&
     -+		EOF
     -+
     -+		# Nothing tracked, explicit ref on the command line.
     -+		git fetch origin main &&
     ++		git fetch cabal &&
      +		check_fetched_refs <<-\EOF &&
     -+		refs/remotes/origin/main
      +		EOF
      +
     -+		# With both refmap and fetch configured, remote.<name>.fetch
     -+		# wins: a refspec-less fetch follows it as usual, and
     -+		# remote.<name>.fetchRefmap plays no part in deciding what to
     -+		# fetch, only in mapping what is fetched.
     -+		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
     -+		git fetch origin &&
     ++		# An ordinary remote.<name>.fetch still decides what is
     ++		# fetched and where it is stored.
     ++		git config remote.cabal.fetch "+refs/heads/*:refs/remotes/cabal/*" &&
     ++		git fetch cabal &&
      +		check_fetched_refs <<-\EOF
     -+		refs/remotes/origin/HEAD
     -+		refs/remotes/origin/main
     -+		refs/remotes/origin/other
     ++		refs/remotes/cabal/HEAD
     ++		refs/remotes/cabal/main
     ++		refs/remotes/cabal/other
      +		EOF
      +	)
      +'
      +
      +test_expect_success 'remote.<name>.fetchRefmap stores branches named in remote.<name>.fetch' '
     -+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     -+	git init -b master fetch-refmap-upstream &&
     -+	test_commit -C fetch-refmap-upstream base &&
     -+	git -C fetch-refmap-upstream branch next &&
     -+	git -C fetch-refmap-upstream branch seen &&
     -+	git -C fetch-refmap-upstream branch other &&
     -+	git init downstream &&
     ++	setup_refmap_repos master next seen other &&
      +	(
      +		cd downstream &&
     -+		git remote add cabal ../fetch-refmap-upstream &&
     -+		git config --unset-all remote.cabal.fetch &&
      +		git config --add remote.cabal.fetch master &&
      +		git config --add remote.cabal.fetch next &&
      +		git config --add remote.cabal.fetch seen &&
     -+		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
      +		git fetch cabal &&
      +		check_fetched_refs <<-\EOF &&
      +		refs/remotes/cabal/HEAD
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	)
      +'
      +
     -+test_expect_success 'remote.<name>.fetchRefmap stores an explicit-dst remote.<name>.fetch entry in both places' '
     -+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     -+	git init -b master fetch-refmap-upstream &&
     -+	test_commit -C fetch-refmap-upstream base &&
     -+	git init downstream &&
     ++test_expect_success '--refmap on the command line overrides remote.<name>.fetchRefmap' '
     ++	setup_refmap_repos master next &&
     ++	(
     ++		cd downstream &&
     ++		git config --add remote.cabal.fetch master &&
     ++		git fetch --refmap="refs/heads/*:refs/remotes/other/*" cabal &&
     ++		check_fetched_refs <<-\EOF
     ++		refs/remotes/other/master
     ++		EOF
     ++	)
     ++'
     ++
     ++test_expect_success 'remote.<name>.fetchRefmap is not applied to a remote.<name>.fetch entry with a destination' '
     ++	setup_refmap_repos master next &&
      +	(
      +		cd downstream &&
     -+		git remote add cabal ../fetch-refmap-upstream &&
     -+		git config --unset-all remote.cabal.fetch &&
      +		git config --add remote.cabal.fetch \
      +			"+refs/heads/master:refs/remotes/custom/master" &&
     -+		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
     ++		git config --add remote.cabal.fetch next &&
      +		git fetch cabal &&
      +		check_fetched_refs <<-\EOF
     -+		refs/remotes/cabal/HEAD
     -+		refs/remotes/cabal/master
     ++		refs/remotes/cabal/next
     ++		refs/remotes/custom/master
     ++		EOF
     ++	)
     ++'
     ++
     ++test_expect_success 'remote.<name>.fetchRefmap is not applied to a command-line refspec with a destination' '
     ++	setup_refmap_repos master next &&
     ++	(
     ++		cd downstream &&
     ++		git fetch cabal master:refs/remotes/custom/master next &&
     ++		check_fetched_refs <<-\EOF
     ++		refs/remotes/cabal/next
      +		refs/remotes/custom/master
      +		EOF
      +	)
      +'
      +
      +test_expect_success 'remote.<name>.fetchRefmap tracks a branch outside remote.<name>.fetch' '
     -+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     -+	git init -b main fetch-refmap-upstream &&
     -+	test_commit -C fetch-refmap-upstream base &&
     -+	git -C fetch-refmap-upstream branch other &&
     -+	git init downstream &&
     ++	setup_refmap_repos main other &&
      +	(
      +		cd downstream &&
     -+		git remote add -t main origin ../fetch-refmap-upstream &&
     -+		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
     -+		git fetch origin other &&
     -+		git branch --track topic origin/other &&
     -+		test_cmp_config origin branch.topic.remote &&
     ++		git config --add remote.cabal.fetch \
     ++			"+refs/heads/main:refs/remotes/cabal/main" &&
     ++		git fetch cabal other &&
     ++		git branch --track topic cabal/other &&
     ++		test_cmp_config cabal branch.topic.remote &&
      +		test_cmp_config refs/heads/other branch.topic.merge &&
     -+		echo refs/remotes/origin/other >expect &&
     ++		echo refs/remotes/cabal/other >expect &&
      +		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
      +test_expect_success 'remote.<name>.fetchRefmap does not track a branch excluded by remote.<name>.fetch' '
     -+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     -+	git init -b main fetch-refmap-upstream &&
     -+	test_commit -C fetch-refmap-upstream base &&
     -+	git -C fetch-refmap-upstream branch secret &&
     -+	git init downstream &&
     ++	setup_refmap_repos main secret &&
      +	(
      +		cd downstream &&
     -+		git remote add origin ../fetch-refmap-upstream &&
     -+		git config --add remote.origin.fetch "^refs/heads/secret" &&
     -+		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
     -+		git fetch origin secret &&
     -+		git rev-parse --verify refs/remotes/origin/secret &&
     -+		test_must_fail git branch --track topic origin/secret 2>err &&
     ++		git config --add remote.cabal.fetch \
     ++			"+refs/heads/*:refs/remotes/cabal/*" &&
     ++		git config --add remote.cabal.fetch "^refs/heads/secret" &&
     ++		git fetch cabal secret &&
     ++		git rev-parse --verify refs/remotes/cabal/secret &&
     ++		test_must_fail git branch --track topic cabal/secret 2>err &&
      +		test_grep "not a branch" err
      +	)
      +'
 2:  4ad94eefe9 = 4:  2e2bc76f79 fetch: extract collect_upstream_from_remote() helper
 3:  6724152e69 ! 5:  ece6bd824b fetch: infer branches to fetch from a refmap-only remote
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    fetch: infer branches to fetch from a refmap-only remote
     +    fetch: add remote.<name>.fetchUpstreams
      
     -    We want remote.<name>.fetchRefmap to work on its own, without also
     -    setting remote.<name>.fetch, so a remote can be limited to the
     -    branches already in use locally, without listing them by hand or
     -    touching the command line every time.
     +    In a repository that only works with a few branches of a large
     +    remote, the default refspec makes every "git fetch" download all of
     +    that remote's branches. Narrowing remote.<name>.fetch by hand works,
     +    but the list has to be kept up to date whenever a branch is started
     +    or dropped.
      
     -    Infer what to fetch from the local branches whose @{upstream} is
     -    already on that remote. The refmap itself still only controls where
     -    those fetched refs land, not which branches are selected.
     +    Add remote.<name>.fetchUpstreams. When it is set, "git fetch <name>"
     +    without refspecs on the command line also fetches the upstream
     +    branches that local branches have on that remote, in addition to
     +    what remote.<name>.fetch asks for.
     +
     +    The setting only decides what to fetch. Where the result is stored
     +    is still up to remote.<name>.fetch and remote.<name>.fetchRefmap, so
     +    a remote with fetchUpstreams, a fetchRefmap and no fetch refspec
     +    follows exactly the branches in use locally. Only the upstream of
     +    the current branch is marked for merge, so "git pull" keeps
     +    integrating that branch alone.
      
          Let @{push} use the refmap too, so a branch pushed to such a remote
          resolves to the remote-tracking branch the push updated, instead of
     @@ Commit message
      
       ## Documentation/config/remote.adoc ##
      @@ Documentation/config/remote.adoc: remote.<name>.fetchRefmap::
     - 	fetched to remote-tracking refs to store, the same way
     - 	`remote.<name>.fetch` does for an explicit refspec.
     - 	`remote.<name>.fetch`, if also configured, still decides what is
     --	fetched. See the `--refmap` entry in linkgit:git-fetch[1].
     -+	fetched. If it is not set either, a refspec-less fetch instead
     -+	infers what to fetch from local branches built on this remote.
     -+	See the `--refmap` entry in linkgit:git-fetch[1].
     + 	only at that destination. See the `--refmap` entry in
     + 	linkgit:git-fetch[1].
       
     ++remote.<name>.fetchUpstreams::
     ++	If true, a `git fetch <name>` without refspecs on the command
     ++	line also fetches the upstream branches that local branches
     ++	have on this remote, in addition to what `remote.<name>.fetch`
     ++	asks for. Combined with `remote.<name>.fetchRefmap` and no
     ++	`remote.<name>.fetch`, the remote is limited to the branches in
     ++	use locally. Defaults to false.
     ++
       remote.<name>.push::
       	The default set of "refspec" for linkgit:git-push[1]. See
     -
     - ## Documentation/fetch-options.adoc ##
     -@@ Documentation/fetch-options.adoc: endif::git-pull[]
     - 	command-line arguments. See section on "Configured Remote-tracking
     - 	Branches" for details.
     - +
     --`remote.<name>.refmap` provides the default value for this option, the
     --same way `remote.<name>.fetch` provides the default refspecs to fetch.
     -+When a refmap is active (from `--refmap` or `remote.<name>.fetchRefmap`) but
     -+nothing to fetch is specified on the command line, nor is there a
     -+`remote.<name>.fetch`, infer what to fetch from local branches built on
     -+this remote: remote-tracking branches from this remote that are also
     -+configured as the `@{upstream}` of a local branch are fetched. The
     -+refmap only decides where those fetched refs land, the same as it
     -+would for an explicit refspec, and does not narrow which branches are
     -+selected. It is what turns this on, since without it the fetched
     -+branches would have nowhere to land.
     - 
     - `-t`::
     - `--tags`::
     + 	linkgit:git-push[1].
      
       ## builtin/fetch.c ##
     -@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 	 */
     - 	struct refspec *effective_refmap =
     - 		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
     -+	struct refspec inferred_rs;
     -+	int infer_from_refmap = 0;
     - 
     - 	/* opportunistically-updated references: */
     - 	struct ref *orefs = NULL, **oref_tail = &orefs;
     -@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 	struct hashmap existing_refs;
     - 	int existing_refs_populated = 0;
     - 
     -+	refspec_init_fetch(&inferred_rs, the_hash_algo);
     -+
     - 	filter_prefetch_refspec(rs);
     - 	if (remote)
     - 		filter_prefetch_refspec(&remote->fetch);
     - 	if (effective_refmap)
     - 		filter_prefetch_refspec(effective_refmap);
     +@@ builtin/fetch.c: static void add_merge_config(struct ref **head,
     + 	}
     + }
       
     -+	if (!rs->nr && remote && !remote->fetch.nr &&
     -+	    effective_refmap && effective_refmap->nr) {
     -+		struct strvec tracked = STRVEC_INIT;
     ++static void add_branch_upstreams(struct ref **head,
     ++				 const struct ref *remote_refs,
     ++				 struct remote *remote,
     ++				 struct ref ***tail)
     ++{
     ++	struct strvec upstreams = STRVEC_INIT;
      +
     -+		branches_tracking_remote(the_repository, remote, &tracked);
     -+		for (size_t i = 0; i < tracked.nr; i++)
     -+			refspec_append(&inferred_rs, tracked.v[i]);
     -+		strvec_clear(&tracked);
     ++	branches_tracking_remote(the_repository, remote, &upstreams);
     ++	for (size_t i = 0; i < upstreams.nr; i++) {
     ++		struct refspec_item refspec = { .src = (char *)upstreams.v[i] };
     ++		struct ref *rm;
      +
     -+		rs = &inferred_rs;
     -+		infer_from_refmap = 1;
     ++		for (rm = *head; rm; rm = rm->next)
     ++			if (refname_match(upstreams.v[i], rm->name))
     ++				break;
     ++		if (!rm)
     ++			get_fetch_map(remote_refs, &refspec, tail, 1);
      +	}
     ++	strvec_clear(&upstreams);
     ++}
      +
     - 	if (rs->nr) {
     - 		struct refspec *fetch_refspec;
     - 
     - 		for (i = 0; i < rs->nr; i++) {
     --			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
     -+			get_fetch_map(remote_refs, &rs->items[i], &tail,
     -+				      infer_from_refmap);
     - 			if (rs->items[i].dst && rs->items[i].dst[0])
     - 				*autotags = 1;
     - 		}
     + static void map_refs_without_dst(const struct ref *ref_map,
     + 				 const struct refspec *refmap,
     + 				 struct ref ***tail)
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 
     - 		for (i = 0; i < fetch_refspec->nr; i++)
     - 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
     -+	} else if (infer_from_refmap) {
     -+		/* Already fully handled above. */
     - 	} else if (refmap.nr) {
     - 		die("--refmap option is only meaningful with command-line refspec(s)");
     - 	} else {
     + 		struct branch *branch = branch_get(NULL);
     + 		int has_merge = branch_has_merge_config(branch);
     + 		if (remote &&
     +-		    (remote->fetch.nr ||
     ++		    (remote->fetch.nr || remote->fetch_upstreams ||
     + 		     /* Note: has_merge implies non-NULL branch->remote_name */
     + 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
     + 			for (i = 0; i < remote->fetch.nr; i++) {
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 	if (existing_refs_populated)
     - 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
     - 
     -+	refspec_clear(&inferred_rs);
     - 	return ref_map;
     - }
     - 
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 	struct strmap rejected_refs = STRMAP_INIT;
     - 	int summary_width = 0;
     - 	int follow_remote_head = FOLLOW_REMOTE_NEVER;
     -+	bool apply_follow_remote_head_config = false;
     - 
     - 	if (tags == TAGS_DEFAULT) {
     - 		if (transport->remote->fetch_tags == 2)
     + 				    !remote->fetch.items[0].pattern)
     + 					ref_map->fetch_head_status = FETCH_HEAD_MERGE;
     + 			}
     ++			if (remote->fetch_upstreams)
     ++				add_branch_upstreams(&ref_map, remote_refs,
     ++						     remote, &tail);
     + 			/*
     + 			 * if the remote we're fetching from is the same
     + 			 * as given in branch.<name>.remote, we add the
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 
       	if (rs->nr) {
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
     --	} else {
     + 	} else {
      -		if (transport->remote->fetch.nr) {
     --			refspec_ref_prefixes(&transport->remote->fetch,
     --					     &transport_ls_refs_options.ref_prefixes);
     --			/*
     --			 * See remote.c's handling of remote.<name>.followRemoteHEAD
     --			 * for the analogous, still-unresolved case.
     --			 */
     --			if (transport->remote->follow_remote_head)
     --				follow_remote_head = transport->remote->follow_remote_head;
     --			else if (config->follow_remote_head_seen)
     --				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
     --			else
     --				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
     --		}
     -+	} else if (transport->remote->fetch.nr) {
     -+		refspec_ref_prefixes(&transport->remote->fetch,
     -+				     &transport_ls_refs_options.ref_prefixes);
     -+		apply_follow_remote_head_config = true;
     - 
     - 		/*
     - 		 * The configured refspec may not cover the current
     ++		if (transport->remote->fetch.nr ||
     ++		    transport->remote->fetch_upstreams) {
     + 			refspec_ref_prefixes(&transport->remote->fetch,
     + 					     &transport_ls_refs_options.ref_prefixes);
     + 			/*
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 		 * branch's upstream (e.g. a narrowed -t refspec), so
     + 		 * make sure we can still fetch it regardless.
       		 */
     - 		collect_upstream_from_remote(the_repository, transport->remote,
     - 					      NULL, &transport_ls_refs_options.ref_prefixes);
     -+	} else {
     -+		/*
     -+		 * The --refmap command line option, if given, takes
     -+		 * precedence over remote.<name>.fetchRefmap.
     -+		 */
     -+		struct refspec *effective_refmap = refmap.nr ? &refmap :
     -+			&transport->remote->refmap;
     -+
     -+		if (effective_refmap->nr) {
     +-		collect_upstream_from_remote(the_repository, transport->remote,
     +-					      NULL, &transport_ls_refs_options.ref_prefixes);
     ++		if (transport->remote->fetch_upstreams)
      +			branches_tracking_remote(the_repository, transport->remote,
      +						  &transport_ls_refs_options.ref_prefixes);
     -+			apply_follow_remote_head_config = true;
     -+		} else {
     ++		else
      +			collect_upstream_from_remote(the_repository, transport->remote,
      +						      NULL, &transport_ls_refs_options.ref_prefixes);
     -+		}
       
       		/*
       		 * If there are no refs specified to fetch, then we just
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 				    "HEAD");
     - 	}
     - 
     -+	if (apply_follow_remote_head_config) {
     -+		/*
     -+		 * See remote.c's handling of remote.<name>.followRemoteHEAD
     -+		 * for the analogous, still-unresolved case.
     -+		 */
     -+		if (transport->remote->follow_remote_head)
     -+			follow_remote_head = transport->remote->follow_remote_head;
     -+		else if (config->follow_remote_head_seen)
     -+			follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
     -+		else
     -+			follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
     -+	}
     -+
     - 	if (tags == TAGS_SET || tags == TAGS_DEFAULT)
     - 		strvec_push(&transport_ls_refs_options.ref_prefixes,
     - 			    "refs/tags/");
      
       ## remote.c ##
     +@@ remote.c: static int handle_config(const char *key, const char *value,
     + 			return -1;
     + 		refspec_append(&remote->refmap, v);
     + 		free(v);
     ++	} else if (!strcmp(subkey, "fetchupstreams")) {
     ++		remote->fetch_upstreams = git_config_bool(key, value);
     + 	} else if (!strcmp(subkey, "receivepack")) {
     + 		char *v;
     + 		if (git_config_string(&v, key, value))
      @@ remote.c: void collect_upstream_from_remote(struct repository *repo,
       		strvec_push(tracked, branch->merge[i]->src);
       }
     @@ remote.c: static char *tracking_for_push_dest(struct repository *repo,
       				 _("push destination '%s' on remote '%s' has no local tracking branch"),
      
       ## remote.h ##
     +@@ remote.h: struct remote {
     + 	 */
     + 	struct refspec refmap;
     + 
     ++	/*
     ++	 * Whether a fetch without refspecs on the command line also
     ++	 * fetches the upstreams that local branches have on this remote.
     ++	 */
     ++	bool fetch_upstreams;
     ++
     + 	/*
     + 	 * The setting for whether to fetch tags (as a separate rule from the
     + 	 * configured refspecs);
      @@ remote.h: void collect_upstream_from_remote(struct repository *repo,
       				   const char *refname,
       				   struct strvec *tracked);
     @@ t/t5586-fetch-refmap.sh (new)
      @@
      +#!/bin/sh
      +
     -+test_description='"git fetch" with a remote.<name>.fetchRefmap but no remote.<name>.fetch
     ++test_description='"git fetch" with remote.<name>.fetchUpstreams
      +
     -+When a remote has a refmap configured but no fetch refspec, a
     -+refspec-less fetch infers what to fetch from the local branches whose
     -+@{upstream} is on that remote.
     ++With remote.<name>.fetchUpstreams set, a refspec-less fetch also
     ++fetches the upstreams that local branches have on that remote, and
     ++remote.<name>.fetchRefmap decides where they are stored.
      +'
      +
      +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     @@ t/t5586-fetch-refmap.sh (new)
      +
      +. ./test-lib.sh
      +
     ++check_upstream_refs () {
     ++	git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     ++	cat >expect &&
     ++	test_cmp expect actual
     ++}
     ++
     ++check_upstream_tip () {
     ++	git -C .. rev-parse "$2" >expect &&
     ++	git rev-parse "$1" >actual &&
     ++	test_cmp expect actual
     ++}
     ++
      +test_expect_success 'setup' '
      +	test_commit main-1 &&
      +	test_commit main-2 &&
     @@ t/t5586-fetch-refmap.sh (new)
      +		git remote add upstream .. &&
      +		test_might_fail git config unset remote.upstream.fetch &&
      +		git config remote.upstream.fetchRefmap \
     -+			"+refs/heads/*:refs/remotes/upstream/*"
     ++			"+refs/heads/*:refs/remotes/upstream/*" &&
     ++		git config remote.upstream.fetchUpstreams true
      +	)
      +'
      +
     @@ t/t5586-fetch-refmap.sh (new)
      +	(
      +		cd client &&
      +		git fetch upstream &&
     -+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     -+		test_must_be_empty actual
     ++		check_upstream_refs <<-\EOF
     ++		EOF
      +	)
      +'
      +
     @@ t/t5586-fetch-refmap.sh (new)
      +	(
      +		cd client &&
      +		git fetch upstream &&
     -+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     -+		cat >expect <<-\EOF &&
     ++		check_upstream_refs <<-\EOF &&
      +		refs/remotes/upstream/HEAD
      +		refs/remotes/upstream/main
      +		refs/remotes/upstream/side
      +		EOF
     -+		test_cmp expect actual &&
     -+		git rev-parse refs/remotes/upstream/side >actual-oid &&
     -+		git -C .. rev-parse side >expect-oid &&
     -+		test_cmp expect-oid actual-oid
     ++		check_upstream_tip refs/remotes/upstream/side side
      +	)
      +'
      +
     @@ t/t5586-fetch-refmap.sh (new)
      +		cd client &&
      +		git branch side-topic-2 upstream/side &&
      +		git fetch upstream &&
     -+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     -+		cat >expect <<-\EOF &&
     -+		refs/remotes/upstream/HEAD
     -+		refs/remotes/upstream/main
     -+		refs/remotes/upstream/side
     -+		EOF
     -+		test_cmp expect actual
     ++		grep side .git/FETCH_HEAD >fetched &&
     ++		test_line_count = 1 fetched
      +	)
      +'
      +
     @@ t/t5586-fetch-refmap.sh (new)
      +		git fetch other next:refs/remotes/other/next &&
      +		git branch next-topic other/next &&
      +		git fetch upstream &&
     -+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     -+		cat >expect <<-\EOF &&
     ++		check_upstream_refs <<-\EOF
      +		refs/remotes/upstream/HEAD
      +		refs/remotes/upstream/main
      +		refs/remotes/upstream/side
      +		EOF
     ++	)
     ++'
     ++
     ++test_expect_success 'upstreams are not fetched without remote.<name>.fetchUpstreams' '
     ++	git checkout side &&
     ++	test_commit side-3 &&
     ++	git checkout main &&
     ++	(
     ++		cd client &&
     ++		git rev-parse refs/remotes/upstream/side >expect &&
     ++		git -c remote.upstream.fetchUpstreams=false fetch upstream &&
     ++		git rev-parse refs/remotes/upstream/side >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     ++test_expect_success 'remote.<name>.fetch adds to the upstreams being fetched' '
     ++	(
     ++		cd client &&
     ++		git -c remote.upstream.fetch=next fetch upstream &&
     ++		check_upstream_refs <<-\EOF &&
     ++		refs/remotes/upstream/HEAD
     ++		refs/remotes/upstream/main
     ++		refs/remotes/upstream/next
     ++		refs/remotes/upstream/side
     ++		EOF
     ++		check_upstream_tip refs/remotes/upstream/side side
     ++	)
     ++'
     ++
      +test_expect_success 'prefetch stores tracked branches under refs/prefetch/' '
      +	test_commit main-3 &&
      +	(
     @@ t/t5586-fetch-refmap.sh (new)
      +		git fetch --prefetch upstream &&
      +		git rev-parse refs/remotes/upstream/main >actual &&
      +		test_cmp expect actual &&
     -+		git -C .. rev-parse main >expect &&
     -+		git rev-parse refs/prefetch/remotes/upstream/main >actual &&
     -+		test_cmp expect actual
     ++		check_upstream_tip refs/prefetch/remotes/upstream/main main
     ++	)
     ++'
     ++
     ++test_expect_success 'git pull merges only the upstream of the current branch' '
     ++	(
     ++		cd client &&
     ++		git pull &&
     ++		check_upstream_tip HEAD main
      +	)
      +'
      +
 4:  6cff6786ba ! 6:  e60b61e117 remote: add "git remote add --limited-fetch"
     @@ Commit message
          branches nobody asked for.
      
          Give "git remote add" a --limited-fetch option that sets up
     -    remote.<name>.fetchRefmap instead of remote.<name>.fetch, so that
     -    "git fetch <name>" only fetches the branches already tracked, as
     -    described in the previous commit. It is rejected together with
     -    -t/--track or --mirror, since those already say explicitly what to
     -    fetch.
     +    remote.<name>.fetchRefmap and remote.<name>.fetchUpstreams instead
     +    of remote.<name>.fetch, so that "git fetch <name>" only fetches the
     +    branches already tracked, as described in the previous commit. It
     +    is rejected together with -t/--track or --mirror, since those
     +    already say explicitly what to fetch.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-remote.adoc: the `refs/remotes/<name>/` namespace, a refspec t
       multiple branches without grabbing all branches.
       +
      +With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
     -+that tracks all branches, `remote.<name>.fetchRefmap` is set up so that a
     -+refspec-less `git fetch <name>` only fetches branches our local branches
     -+are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
     -+details.
     ++that tracks all branches, `remote.<name>.fetchRefmap` and
     ++`remote.<name>.fetchUpstreams` are set up so that a refspec-less
     ++`git fetch <name>` only fetches branches our local branches are built
     ++on. See linkgit:git-config[1] for details.
      ++
       With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
       up to point at remote's _<master>_ branch. See also the set-head command.
     @@ builtin/remote.c: static int add(int argc, const char **argv, const char *prefix
      +			strbuf_reset(&buf2);
      +			strbuf_addf(&buf2, "+refs/heads/*:refs/remotes/%s/*", name);
      +			repo_config_set(the_repository, buf.buf, buf2.buf);
     ++			strbuf_reset(&buf);
     ++			strbuf_addf(&buf, "remote.%s.fetchUpstreams", name);
     ++			repo_config_set(the_repository, buf.buf, "true");
      +		} else {
      +			strbuf_addf(&buf, "remote.%s.fetch", name);
      +			if (track.nr == 0)
     @@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only
      +		git remote add --limited-fetch upstream ../two &&
      +		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
      +			remote.upstream.fetchRefmap &&
     ++		test_cmp_config true remote.upstream.fetchUpstreams &&
      +		test_must_fail git config get remote.upstream.fetch
      +	)
      +'
 5:  00f9d44a88 ! 7:  3f06f7f9e2 remote: default to --limited-fetch in a shallow repository
     @@ Documentation/git-remote.adoc: Add a remote named _<name>_ for the repository at
       the remote information is set up.
       +
      @@ Documentation/git-remote.adoc: With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
     - that tracks all branches, `remote.<name>.fetchRefmap` is set up so that a
     - refspec-less `git fetch <name>` only fetches branches our local branches
     - are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
     --details.
     -+details. `--no-limited-fetch` explicitly disables this, overriding the
     -+shallow-repository default described above.
     + that tracks all branches, `remote.<name>.fetchRefmap` and
     + `remote.<name>.fetchUpstreams` are set up so that a refspec-less
     + `git fetch <name>` only fetches branches our local branches are built
     +-on. See linkgit:git-config[1] for details.
     ++on. See linkgit:git-config[1] for details. `--no-limited-fetch`
     ++explicitly disables this, overriding the shallow-repository default
     ++described above.
       +
       With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
       up to point at remote's _<master>_ branch. See also the set-head command.
     @@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only
      +		git remote add upstream ../two &&
      +		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
      +			remote.upstream.fetchRefmap &&
     ++		test_cmp_config true remote.upstream.fetchUpstreams &&
      +		test_must_fail git config get remote.upstream.fetch &&
      +		git fetch upstream main &&
      +		git branch --set-upstream-to=upstream/main &&
     -+		test_cmp_config upstream branch.main.remote &&
     -+		test_cmp_config refs/heads/main branch.main.merge &&
      +		git fetch upstream &&
      +		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
      +		cat >expect <<-\EOF &&
     @@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only
      +		git remote add --no-limited-fetch upstream ../two &&
      +		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
      +			remote.upstream.fetch &&
     -+		test_must_fail git config get remote.upstream.fetchRefmap
     ++		test_must_fail git config get remote.upstream.fetchRefmap &&
     ++		test_must_fail git config get remote.upstream.fetchUpstreams
      +	)
      +'
      +

-- 
gitgitgadget

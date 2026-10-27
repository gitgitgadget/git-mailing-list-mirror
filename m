Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103887;
	b=yhJJ/jW3cnGSRCXN/DQJGonNGV/pVv1TAX9nxQ4t6FldoH4KiXM8uaGqTIX0o9MiC7oE
	 13YQ6SNmtGMf12vgo3IcXmBFfv+lLsE6UXHJHSfMCG0dxFkXMv/6co9HO0Tnvl2G/c0W4
	 do9rrQtVPJ/leIxgjCH35HtKnRcdefvl0ZxQsO3b/9oCJT2ZTYFtlfDQqQsDGC7jTn+Cc
	 NljjTtJsegqq5tfngSPJCRY7Zjt0Bq2PJSFAaYNcVSU7d+X7D11PgYaH2iM/HSdi36OK3
	 9IohGi3VzSVUZVKf5opnOZmHikBU93suOXQ/5PfBPODsrYEt96FciDVeE2HRdKonzmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=N250cbGqyTx5y5yiqHd+Kzt2V+udekjkxhAO/yz70+0=;
	b=MGWcEPQcMglb5bx/tzTpHslFzdnULno48GgyPnMvm22jOsFxV16UHVhFCEkGZq+CBHry
	 1vVMcK5zx9GR99MGhH1ZA8xDewglTGX9+u71y3YP93A0BeiPITQt6qhrOIZD0ffiVAVSD
	 0HIhqJBZbVkXhIRHAUnOQILxDHhwgeFffz6PLE6IM0f0xjLkNOYHPUKE6uKtXm2zkccou
	 gFXErOJoQjwD1TcNhEChpvW838RDpGCGYWeYy4T04T3q8Du3vHnxAhowulSEYyiThd/nn
	 4ZWYFackNAywrSURWYXaSpKK3KYjDyY5B4qpAr7mrh4sCzDRho8vCQ+Giv6ghBTbKbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZ702r2X;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC1606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05CC1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZ702r2X
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67a6cc9acbeso669262d50.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103886; x=1793708686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N250cbGqyTx5y5yiqHd+Kzt2V+udekjkxhAO/yz70+0=;
        b=JZ702r2XKB5cp91bAbSamldb4sgUAhTmq3cN6qjDzOopMjL4O9t3nj91uTxei+bkVs
         CNy5NGRPOoYnEgoU/dBxaL9QYeOVm++I6UXKdZSxckN+bi4OZdigQKutbtl6qyzPt7QS
         /bUPSY5t3xRhr1+nO+eSGgvHyHqMsQeu91mTdgnfmM+XWvz66THgGsLXpZ/eLcybO/v/
         0on3tMHTVUkslGH7Kn/gxwuGQWcbC2108fa9jCe0wvLb69PYhYIbL3/wdzJADdiFJNF3
         Bs7gCymarHC16gYYLlmcChQwesSC1/7sn7SJF6ySpTJkf8FfB4rUhh+0RHLQ8Z6S5d0I
         d6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103886; x=1793708686;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N250cbGqyTx5y5yiqHd+Kzt2V+udekjkxhAO/yz70+0=;
        b=DwF9tpfZcSXkFEDBRaymdBPC+nmeRE5ro3ydvSQFK5hQAvAXvTKsJJ2UEdBq8dsaA1
         ZS3nqTzNL0RAW6oIaMvOAiWiZSq0ZD4vi4eUcsLQ4PjaXX+t2eWItpgOYulN1AhrSFCU
         l7coeBO4a1AhXsFQ7R5sEkVicEnWAyf9JAcc8mu8koXzF/gYqTl3QJevaOR09y9Ha/1/
         P5uNsv9taZ+Ab42n3xKpUY8rmz3ozwu8X5FHZIFJk0Wvo6B5x46vxl2hEU7A7nYNoCG0
         bSyC39i1IWOCLJO8VBN8y6Fd9T0IQ+zzwrhY0vMVA6OCEReUyRHMHD2hjOHWQcG4l6Aj
         PMBg==
X-Gm-Message-State: AFq9FYKTKHYSrYGBCn5dizX+EkfqRD4OJ2eGgR0YgY0SM4ben2tns4F0
	tYmdczuOcfSYc/bfVfpBm1SZKneyAz6R34WvQN4lFXOu/q6LMX/xGbl87EyQkoPM
X-Gm-Gg: AYBFou2LhHDQEBiIagBCtltpvt4Iefj+vPguuuuAk/ygR3bSB3G1jBMMgWmai3Zhc8v
	XoY2oD82vXBD0fLVgCm6M5eEXyEoyhoQD3X7zqbgAHhQD4Kp7ZT124i/pj8Xf7/YjDy/SVt26l7
	M40Qkj807m5Uavxm/7dLIQbkpEDB7nkLF1AXlPhYy+schxS05AW5623hIzeauYa9n2Ws2IvDOiH
	ab6i2xg16isEGdkbDKidaWFNnzioInVbCHpQL6/hTSj/p6HtvgV920eiOfnCf4DFBWiw7a4dLaH
	dgl6DY0CGF9B4IqT7axblP1CB7NQvegs/2nexZJ1tIaGCyh4BBhqf/+VWSqiMzY263ZgLMBY9Wm
	jDRgXlhNNAdmQwwaW/3ABEdReNByqHhfEu5aPz2czQ9nPk8o7aZEzoCrE56xwjC/V7CuLHWMkvU
	kYg3XUUwYn9TNz+grzi7oIKSi2ffYmDqtzVnz4p81wyh8TfVlaAtg0PaT/2HVbRF8HrkGoNk534
	hwSrLkDH+XM2z/BrI7YZnoOehmRHOqgCH8FLZqTSmPNgEsFK8ysuy2+xBXkNBfpXG3qMorHc4Qk
	Ag0tar8=
X-Received: by 2002:a05:690e:812:10b0:675:7032:8062 with SMTP id 956f58d0204a3-67a453ca6famr5061855d50.44.1793103885498;
        Tue, 27 Oct 2026 05:24:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.118])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a461ee4c3sm4663958d50.9.2026.10.27.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:24:44 -0700 (PDT)
Message-Id: <pull.2412.v12.git.git.1793103884.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 12:24:39 +0000
Subject: [PATCH v12 0/5] fetch: avoid fetching every branch of a new remote in a shallow repo
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
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

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

Harald Nordgren (5):
  fetch: add remote.<name>.fetchRefmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   9 +++
 Documentation/fetch-options.adoc |  10 +++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  | 100 +++++++++++++++++------
 builtin/remote.c                 |  31 +++++--
 remote.c                         |  60 +++++++++++++-
 remote.h                         |  20 +++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++
 t/t5510-fetch.sh                 | 130 ++++++++++++++++++++++++++++++
 t/t5586-fetch-refmap.sh          | 133 +++++++++++++++++++++++++++++++
 11 files changed, 551 insertions(+), 33 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 37b3475fb530c14109211faca33716a173db61ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v12
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v11:

 1:  d66b3c0bb1 ! 1:  a1f5e81fdc fetch: add remote.<name>.refmap
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    fetch: add remote.<name>.refmap
     +    fetch: add remote.<name>.fetchRefmap
      
     -    Add a per-remote config variable, remote.<name>.refmap, that provides
     -    the default value for --refmap the same way remote.<name>.fetch
     -    already provides the default refspecs to fetch. Like --refmap itself,
     -    it only maps refs that are actually being fetched, so it has nothing
     -    to do when there is nothing explicit to fetch, on the command line or
     -    via remote.<name>.fetch.
     +    Add a per-remote config variable, remote.<name>.fetchRefmap, that
     +    provides the default value for --refmap the same way
     +    remote.<name>.fetch already provides the default refspecs to fetch.
      
     -    A refspec-less fetch with a refmap configured but nothing else to say
     -    what to fetch falls back to the same defaults as a remote with no
     -    refspec or refmap at all. Only an explicit --refmap given on the
     -    command line with no command-line refspec to go with it is still
     -    rejected, since that combination is a plain mistake to type, unlike a
     -    remote.<name>.refmap configured on its own. A remote.<name>.fetch
     -    that is also configured is used as before.
     +    Unlike passing --refmap on the command line, which requires an
     +    explicit refspec to go with it, configuring remote.<name>.fetchRefmap
     +    on its own does not change what a refspec-less fetch does: it falls
     +    back to the same defaults as a remote with no fetchRefmap at all.
     +
     +    When remote.<name>.fetch is also configured, it still decides what to
     +    fetch, and the refmap maps what it fetches. This lets a remote name
     +    only a few branches and store them all through one refmap:
     +
     +        [remote "cabal"]
     +            fetch = master
     +            fetch = next
     +            fetch = seen
     +            fetchRefmap = +refs/heads/*:refs/remotes/cabal/*
     +
     +    Looking up the remote-tracking branch for a remote branch, as
     +    @{upstream} and "git branch --track" do, falls back to the refmap when
     +    remote.<name>.fetch has no match, so that these work for such
     +    branches too. A branch excluded by a negative refspec in
     +    remote.<name>.fetch stays excluded.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/config/remote.adoc: remote.<name>.fetch::
       	The default set of "refspec" for linkgit:git-fetch[1]. See
       	linkgit:git-fetch[1].
       
     -+remote.<name>.refmap::
     -+	The default value of the `--refmap` option for linkgit:git-fetch[1].
     -+	Used to map remote refs being fetched to remote-tracking refs to
     -+	store. See the `--refmap` entry in linkgit:git-fetch[1].
     ++remote.<name>.fetchRefmap::
     ++	The default value of the `--refmap` option, used to map refs being
     ++	fetched to remote-tracking refs to store, the same way
     ++	`remote.<name>.fetch` does for an explicit refspec.
     ++	`remote.<name>.fetch`, if also configured, still decides what is
     ++	fetched. See the `--refmap` entry in linkgit:git-fetch[1].
      +
       remote.<name>.push::
       	The default set of "refspec" for linkgit:git-push[1]. See
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	struct ref **tail = &ref_map;
      +	/*
      +	 * The --refmap command line option, if given, takes precedence
     -+	 * over remote.<name>.refmap.
     ++	 * over remote.<name>.fetchRefmap.
      +	 */
      +	struct refspec *effective_refmap =
      +		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
       
       	/* opportunistically-updated references: */
       	struct ref *orefs = NULL, **oref_tail = &orefs;
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 	filter_prefetch_refspec(rs);
     + 	if (remote)
     + 		filter_prefetch_refspec(&remote->fetch);
     ++	if (effective_refmap)
     ++		filter_prefetch_refspec(effective_refmap);
     + 
     + 	if (rs->nr) {
     + 		struct refspec *fetch_refspec;
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       		 * by ref_remove_duplicates() in favor of one of these
       		 * opportunistic entries with FETCH_HEAD_IGNORE.
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       		else
       			fetch_refspec = &remote->fetch;
       
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 			if (has_merge &&
     + 			    !strcmp(branch->remote_name, remote->name))
     + 				add_merge_config(&ref_map, remote_refs, branch, &tail);
     ++
     ++			for (i = 0; i < remote->refmap.nr; i++)
     ++				get_fetch_map(ref_map, &remote->refmap.items[i],
     ++					      &oref_tail, 1);
     + 		} else if (!prefetch) {
     + 			ref_map = get_remote_ref(remote_refs, "HEAD");
     + 			if (!ref_map)
      
       ## remote.c ##
      @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     @@ remote.c: static int handle_config(const char *key, const char *value,
       			return -1;
       		refspec_append(&remote->fetch, v);
       		free(v);
     -+	} else if (!strcmp(subkey, "refmap")) {
     ++	} else if (!strcmp(subkey, "fetchrefmap")) {
      +		char *v;
      +		if (git_config_string(&v, key, value))
      +			return -1;
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
       	)
       '
       
     -+test_expect_success 'remote.*.refmap acts like --refmap on the command line' '
     -+	test_when_finished "git -C three config --unset remote.origin.refmap" &&
     ++test_expect_success 'remote.*.fetchRefmap acts like --refmap on the command line' '
     ++	test_when_finished "git -C three config --unset remote.origin.fetchRefmap" &&
      +	git branch -f side &&
     -+	git -C three config remote.origin.refmap \
     ++	git -C three config remote.origin.fetchRefmap \
      +		"refs/heads/*:refs/remotes/other/*" &&
      +	(
      +		cd three &&
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	test_cmp expect actual
      +}
      +
     -+test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
     ++test_expect_success 'remote.<name>.fetchRefmap without tracking (baseline)' '
      +	test_when_finished "rm -fr fetch-refmap-baseline fetch-refmap-upstream" &&
      +	git init -b main fetch-refmap-upstream &&
      +	test_commit -C fetch-refmap-upstream base &&
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +
      +		# Without fetch refspec, but with fetch refmap.
      +		git config --unset-all remote.origin.fetch &&
     -+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
     ++		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
      +
      +		# Nothing tracked, nothing fetched, no error.
      +		git fetch origin &&
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +
      +		# With both refmap and fetch configured, remote.<name>.fetch
      +		# wins: a refspec-less fetch follows it as usual, and
     -+		# remote.<name>.refmap plays no part in deciding what to
     -+		# fetch, only in remapping something that is already being
     -+		# fetched by name.
     ++		# remote.<name>.fetchRefmap plays no part in deciding what to
     ++		# fetch, only in mapping what is fetched.
      +		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
      +		git fetch origin &&
      +		check_fetched_refs <<-\EOF
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	)
      +'
      +
     -+test_expect_success 'remote.<name>.refmap tracks a branch outside remote.<name>.fetch' '
     ++test_expect_success 'remote.<name>.fetchRefmap stores branches named in remote.<name>.fetch' '
     ++	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     ++	git init -b master fetch-refmap-upstream &&
     ++	test_commit -C fetch-refmap-upstream base &&
     ++	git -C fetch-refmap-upstream branch next &&
     ++	git -C fetch-refmap-upstream branch seen &&
     ++	git -C fetch-refmap-upstream branch other &&
     ++	git init downstream &&
     ++	(
     ++		cd downstream &&
     ++		git remote add cabal ../fetch-refmap-upstream &&
     ++		git config --unset-all remote.cabal.fetch &&
     ++		git config --add remote.cabal.fetch master &&
     ++		git config --add remote.cabal.fetch next &&
     ++		git config --add remote.cabal.fetch seen &&
     ++		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
     ++		git fetch cabal &&
     ++		check_fetched_refs <<-\EOF &&
     ++		refs/remotes/cabal/HEAD
     ++		refs/remotes/cabal/master
     ++		refs/remotes/cabal/next
     ++		refs/remotes/cabal/seen
     ++		EOF
     ++		git branch --track topic cabal/next &&
     ++		echo refs/remotes/cabal/next >expect &&
     ++		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     ++test_expect_success 'remote.<name>.fetchRefmap tracks a branch outside remote.<name>.fetch' '
      +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
      +	git init -b main fetch-refmap-upstream &&
      +	test_commit -C fetch-refmap-upstream base &&
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	(
      +		cd downstream &&
      +		git remote add -t main origin ../fetch-refmap-upstream &&
     -+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
     ++		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
      +		git fetch origin other &&
      +		git branch --track topic origin/other &&
      +		test_cmp_config origin branch.topic.remote &&
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +	)
      +'
      +
     -+test_expect_success 'remote.<name>.refmap does not track a branch excluded by remote.<name>.fetch' '
     ++test_expect_success 'remote.<name>.fetchRefmap does not track a branch excluded by remote.<name>.fetch' '
      +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
      +	git init -b main fetch-refmap-upstream &&
      +	test_commit -C fetch-refmap-upstream base &&
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +		cd downstream &&
      +		git remote add origin ../fetch-refmap-upstream &&
      +		git config --add remote.origin.fetch "^refs/heads/secret" &&
     -+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
     ++		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
      +		git fetch origin secret &&
      +		git rev-parse --verify refs/remotes/origin/secret &&
      +		test_must_fail git branch --track topic origin/secret 2>err &&
 2:  f685051033 = 2:  e8af5bc76b fetch: extract collect_upstream_from_remote() helper
 3:  5c76b3b88d ! 3:  aad6e5f66f fetch: infer branches to fetch from a refmap-only remote
     @@ Metadata
       ## Commit message ##
          fetch: infer branches to fetch from a refmap-only remote
      
     -    We want remote.<name>.refmap to work on its own, without also setting
     -    remote.<name>.fetch, so a remote can be limited to the branches
     -    already in use locally, without listing them by hand or touching the
     -    command line every time.
     +    We want remote.<name>.fetchRefmap to work on its own, without also
     +    setting remote.<name>.fetch, so a remote can be limited to the
     +    branches already in use locally, without listing them by hand or
     +    touching the command line every time.
      
          Infer what to fetch from the local branches whose @{upstream} is
          already on that remote. The refmap itself still only controls where
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     -@@ Documentation/config/remote.adoc: remote.<name>.fetch::
     - remote.<name>.refmap::
     - 	The default value of the `--refmap` option for linkgit:git-fetch[1].
     - 	Used to map remote refs being fetched to remote-tracking refs to
     --	store. See the `--refmap` entry in linkgit:git-fetch[1].
     -+	store. If `remote.<name>.fetch` is not set either, a refspec-less
     -+	fetch infers what to fetch from local branches built on this
     -+	remote, instead of needing `remote.<name>.fetch` listed by hand.
     +@@ Documentation/config/remote.adoc: remote.<name>.fetchRefmap::
     + 	fetched to remote-tracking refs to store, the same way
     + 	`remote.<name>.fetch` does for an explicit refspec.
     + 	`remote.<name>.fetch`, if also configured, still decides what is
     +-	fetched. See the `--refmap` entry in linkgit:git-fetch[1].
     ++	fetched. If it is not set either, a refspec-less fetch instead
     ++	infers what to fetch from local branches built on this remote.
      +	See the `--refmap` entry in linkgit:git-fetch[1].
       
       remote.<name>.push::
     @@ Documentation/fetch-options.adoc: endif::git-pull[]
       +
      -`remote.<name>.refmap` provides the default value for this option, the
      -same way `remote.<name>.fetch` provides the default refspecs to fetch.
     -+When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
     ++When a refmap is active (from `--refmap` or `remote.<name>.fetchRefmap`) but
      +nothing to fetch is specified on the command line, nor is there a
      +`remote.<name>.fetch`, infer what to fetch from local branches built on
      +this remote: remote-tracking branches from this remote that are also
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	filter_prefetch_refspec(rs);
       	if (remote)
       		filter_prefetch_refspec(&remote->fetch);
     + 	if (effective_refmap)
     + 		filter_prefetch_refspec(effective_refmap);
       
      +	if (!rs->nr && remote && !remote->fetch.nr &&
      +	    effective_refmap && effective_refmap->nr) {
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      +	} else {
      +		/*
      +		 * The --refmap command line option, if given, takes
     -+		 * precedence over remote.<name>.refmap.
     ++		 * precedence over remote.<name>.fetchRefmap.
      +		 */
      +		struct refspec *effective_refmap = refmap.nr ? &refmap :
      +			&transport->remote->refmap;
     @@ t/t5586-fetch-refmap.sh (new)
      @@
      +#!/bin/sh
      +
     -+test_description='"git fetch" with a remote.<name>.refmap but no remote.<name>.fetch
     ++test_description='"git fetch" with a remote.<name>.fetchRefmap but no remote.<name>.fetch
      +
      +When a remote has a refmap configured but no fetch refspec, a
      +refspec-less fetch infers what to fetch from the local branches whose
     @@ t/t5586-fetch-refmap.sh (new)
      +		cd client &&
      +		git remote add upstream .. &&
      +		test_might_fail git config unset remote.upstream.fetch &&
     -+		git config remote.upstream.refmap \
     ++		git config remote.upstream.fetchRefmap \
      +			"+refs/heads/*:refs/remotes/upstream/*"
      +	)
      +'
     @@ t/t5586-fetch-refmap.sh (new)
      +	)
      +'
      +
     ++test_expect_success 'prefetch stores tracked branches under refs/prefetch/' '
     ++	test_commit main-3 &&
     ++	(
     ++		cd client &&
     ++		git rev-parse refs/remotes/upstream/main >expect &&
     ++		git fetch --prefetch upstream &&
     ++		git rev-parse refs/remotes/upstream/main >actual &&
     ++		test_cmp expect actual &&
     ++		git -C .. rev-parse main >expect &&
     ++		git rev-parse refs/prefetch/remotes/upstream/main >actual &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
      +test_expect_success 'git remote show does not choke on a refmap-only remote' '
      +	(
      +		cd client &&
 4:  417f14d708 ! 4:  97650da870 remote: add "git remote add --limited-fetch"
     @@ Commit message
          branches nobody asked for.
      
          Give "git remote add" a --limited-fetch option that sets up
     -    remote.<name>.refmap instead of remote.<name>.fetch, so that
     +    remote.<name>.fetchRefmap instead of remote.<name>.fetch, so that
          "git fetch <name>" only fetches the branches already tracked, as
          described in the previous commit. It is rejected together with
          -t/--track or --mirror, since those already say explicitly what to
     @@ Documentation/git-remote.adoc: the `refs/remotes/<name>/` namespace, a refspec t
       multiple branches without grabbing all branches.
       +
      +With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
     -+that tracks all branches, `remote.<name>.refmap` is set up so that a
     ++that tracks all branches, `remote.<name>.fetchRefmap` is set up so that a
      +refspec-less `git fetch <name>` only fetches branches our local branches
      +are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
      +details.
     @@ builtin/remote.c: static int add(int argc, const char **argv, const char *prefix
      -			add_branch(buf.buf, track.items[i].string,
      -				   name, mirror, &buf2);
      +		if (use_limited_fetch) {
     -+			strbuf_addf(&buf, "remote.%s.refmap", name);
     ++			strbuf_addf(&buf, "remote.%s.fetchRefmap", name);
      +			strbuf_reset(&buf2);
      +			strbuf_addf(&buf2, "+refs/heads/*:refs/remotes/%s/*", name);
      +			repo_config_set(the_repository, buf.buf, buf2.buf);
     @@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only
      +		cd full-add &&
      +		git remote add --limited-fetch upstream ../two &&
      +		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
     -+			remote.upstream.refmap &&
     ++			remote.upstream.fetchRefmap &&
      +		test_must_fail git config get remote.upstream.fetch
      +	)
      +'
 5:  de0daa8623 ! 5:  a802c9f82f remote: default to --limited-fetch in a shallow repository
     @@ Documentation/git-remote.adoc: Add a remote named _<name>_ for the repository at
       the remote information is set up.
       +
      @@ Documentation/git-remote.adoc: With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
     - that tracks all branches, `remote.<name>.refmap` is set up so that a
     + that tracks all branches, `remote.<name>.fetchRefmap` is set up so that a
       refspec-less `git fetch <name>` only fetches branches our local branches
       are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
      -details.
     @@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only
      +		cd shallow-add &&
      +		git remote add upstream ../two &&
      +		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
     -+			remote.upstream.refmap &&
     ++			remote.upstream.fetchRefmap &&
      +		test_must_fail git config get remote.upstream.fetch &&
      +		git fetch upstream main &&
      +		git branch --set-upstream-to=upstream/main &&
     @@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only
      +		git remote add --no-limited-fetch upstream ../two &&
      +		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
      +			remote.upstream.fetch &&
     -+		test_must_fail git config get remote.upstream.refmap
     ++		test_must_fail git config get remote.upstream.fetchRefmap
      +	)
      +'
      +

-- 
gitgitgadget

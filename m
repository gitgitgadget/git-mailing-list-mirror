Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959924;
	b=hy8hdd8sKUR2DP+HAtlNUM1FFHWyTZnYjYJOnJf6vuxlEVV/OF1luLlUddakgNn9he0C
	 peIiNxInA/XWfM0Pki9jKB6UUE9Y+L9G6bC3NuxMT0JRnpoOL6i1++mfoLEbee3NQ4AaN
	 6DvYqt1shSIXENuwoAoK3fVuMYXpU8FNeRXfQN/WMLdT7ckhAjYFKSH0T+XdH83Gd8SN2
	 rkC6WGpVQLHYjbMtG605enGRYSrv9MYLkpRFNf0/5zpeQPiu9qJ/YqLuEVq3OOhKEytXX
	 UsmAE7DlINjDQmMrJJ+svwn3SN6NqwOT7pU/bWrIhKx6VETcynnY4dUU0H8kW13dzPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mirxJUzkOvPOfJT5L9fHF6rNMK1Kn/dJ9UTYmLK4oVk=;
	b=TGiqNvw/YW25BTQ094n2IhGySNUk6X80fiAlM8TjISfmnCnmKT1ie8O3duDrLDmc0iDh
	 c/OXiyyjkKi0TDT78AwWaxjbjOtwkkP2OyQzY2sKbDshBuKAFDFM+bX3ATAlYWgNByhW8
	 uLbC65hShx2Ml1AHynDWwQro+Fh7SyK6gG9/ciPylHghevLRM+fWwhMsXgtcPuumFJd9P
	 +1CMpf/RdDDRLpBHQgyrcLZJTuyvfDhiHzuzb0W8drVvEVq1UXsPZnhwCMxEj9xsmqUDL
	 /rITNxmN1L7Y3EvjOOaXSlLGp2eyewXMU/uH0RjF+lwrzyyqmGIHVrYNfog6nDOjkjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XCjK+FeY;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C361606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C361606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XCjK+FeY
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35c76e9614aso3861987eec.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959923; x=1793564723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mirxJUzkOvPOfJT5L9fHF6rNMK1Kn/dJ9UTYmLK4oVk=;
        b=XCjK+FeY5OQ9BiXAdj2/A+HhkQPHxqVIjr4RjmrezM0Jyg+GQWs8TqOjeWq+BBXg0k
         2OY/IBhyOMQc6IFeMDPibgWVI3ZtZ4E+fZvsOBw39nXHRUgPthUSAnm6HS8Hd6UEBwuz
         IvdQ3g8rPJJCub8Yov3IooZR9Y3qb96zSdPTJy701bvN7uVl3lwiBzgPluNUy28X+nVO
         Ld7OR2esRubGVPyKIW7FD15OmSeUYcz2A5PoBiQJvKQuLkaNQfivTz1z9m9EvNGbScMu
         +yepWjPTbXQxRk0SQopf1Pz9IZi34jYdGeeo5hMd7H1J46fTewzyzdInrx1Nuzca60vv
         PemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959923; x=1793564723;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mirxJUzkOvPOfJT5L9fHF6rNMK1Kn/dJ9UTYmLK4oVk=;
        b=X/NeCRd0hUu6VD7thN9DC8U+nHmiTdmh7diUm4N+M72NfF6+pxFXpEjaWpacVJ3+UA
         NAflX+v3Y7r9uK/q++hVf5T+wBs8UmFl1cat3NJUWQqbdxVShdvBTKCP2UXmfPAnRAgQ
         q9R/za4OhH50IsetexakJnTttQKg5Pp+RxiX+DY5T/639mMNWc3sJaE0SgBLhMrliFtP
         PZF9V/OshktZfYA68snIrnd3Az3rv5sVmVvVxk/6aK5M5ovGnSKeymI1edm+AnAigW7M
         emM3IkAc85vFTP3iTiewlzBoBXt1jcUOyEgq6IwhjPZnsawLT59tIVX8oDvXhTjXwP3u
         rSeQ==
X-Gm-Message-State: AFq9FYKTXeygLeNFtPg5ChkjK84RAsI2o6fwrVjAlEmnBbO/cksTommj
	+wwbRy7o6RWXnU+mvfk/+wvvwybeGGd9PMLq7dt6Hm4JzmP0k+JW0NP1xsSO4V/V
X-Gm-Gg: AYBFou3N68HoxXs0pvYrmX+DBAgmZhQEBpp3tGhLrPIvZOOlxqmB66f7OPee82C5LQ4
	0lHjRwXDgYqLt0ISMoZZuQarfxSWFhGuXx5yKDMKjzJ1KtcUX1sf2sLnAvKqGRv9XPJsbKdxtfq
	Tu8PStb2EKfGKrJzVm0dq1if/JJDbET3V9IB6sdK0csq2OrUVq4snL9iywc+Nat1r1NDYMWoOBd
	gX6drT59o7pnGK+Eyb1Tdi4aybjDveY/VzLbNiChNyexC+67dvU7YIkfwMSeU+sVovMbH1Ea4PS
	YYPng8joSjQoBKPIsIBh5mKaMVSEyHDuDkIcLeYLcxci/jDGZbc7rHXnOAZchP2SK8bjpGpTQRR
	dhnD4sqldooHIjup4tMSV+cb8gwf1fuE43pvjQaL037HrBe5Pq+9t+oP1IeLBOMuG4/Uc9uxglo
	QYw+FrVMbd002bjWRACCJhuLtRI6Lp3f1xA+Xm+yKnzXyCa/hRukI5BcqnpE5Cwx+szN8e5+1Dt
	ZM0V7HLdgBLvMPgaT1ZOJKqjTn7CW1KndbIdS5uq1IG8klnAL/9XVom
X-Received: by 2002:a05:7300:ec14:b0:351:202c:c7a5 with SMTP id 5a478bee46e88-369e81c4c2bmr11603095eec.0.1792959922321;
        Sun, 25 Oct 2026 13:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.195.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec865esm17730087eec.26.2026.10.25.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:25:21 -0700 (PDT)
Message-Id: <pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 20:25:16 +0000
Subject: [PATCH v11 0/5] fetch: avoid fetching every branch of a new remote in a shallow repo
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
  fetch: add remote.<name>.refmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |  10 +++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  94 +++++++++++++++++-------
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  60 +++++++++++++++-
 remote.h                         |  20 ++++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 | 101 ++++++++++++++++++++++++++
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 501 insertions(+), 33 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v11
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v10:

 1:  ba7f1354cd ! 1:  d66b3c0bb1 fetch: add remote.<name>.refmap
     @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
       int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
       {
      -	return refspec_find_match(&remote->fetch, refspec);
     -+	if (remote->fetch.nr)
     -+		return refspec_find_match(&remote->fetch, refspec);
     -+	return refspec_find_match(&remote->refmap, refspec);
     ++	char **result = refspec->src ? &refspec->dst : &refspec->src;
     ++
     ++	if (remote->fetch.nr && !refspec_find_match(&remote->fetch, refspec))
     ++		return 0;
     ++	if (refspec_find_match(&remote->refmap, refspec))
     ++		return -1;
     ++	if (refname_matches_negative_refspec_item(refspec->src, &remote->fetch)) {
     ++		FREE_AND_NULL(*result);
     ++		return -1;
     ++	}
     ++	return 0;
       }
       
       static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +		EOF
      +	)
      +'
     ++
     ++test_expect_success 'remote.<name>.refmap tracks a branch outside remote.<name>.fetch' '
     ++	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     ++	git init -b main fetch-refmap-upstream &&
     ++	test_commit -C fetch-refmap-upstream base &&
     ++	git -C fetch-refmap-upstream branch other &&
     ++	git init downstream &&
     ++	(
     ++		cd downstream &&
     ++		git remote add -t main origin ../fetch-refmap-upstream &&
     ++		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
     ++		git fetch origin other &&
     ++		git branch --track topic origin/other &&
     ++		test_cmp_config origin branch.topic.remote &&
     ++		test_cmp_config refs/heads/other branch.topic.merge &&
     ++		echo refs/remotes/origin/other >expect &&
     ++		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     ++test_expect_success 'remote.<name>.refmap does not track a branch excluded by remote.<name>.fetch' '
     ++	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
     ++	git init -b main fetch-refmap-upstream &&
     ++	test_commit -C fetch-refmap-upstream base &&
     ++	git -C fetch-refmap-upstream branch secret &&
     ++	git init downstream &&
     ++	(
     ++		cd downstream &&
     ++		git remote add origin ../fetch-refmap-upstream &&
     ++		git config --add remote.origin.fetch "^refs/heads/secret" &&
     ++		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
     ++		git fetch origin secret &&
     ++		git rev-parse --verify refs/remotes/origin/secret &&
     ++		test_must_fail git branch --track topic origin/secret 2>err &&
     ++		test_grep "not a branch" err
     ++	)
     ++'
      +
       test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
       	git branch -f side &&
 2:  aa20604144 ! 2:  f685051033 fetch: extract collect_upstream_from_remote() helper
     @@ Metadata
       ## Commit message ##
          fetch: extract collect_upstream_from_remote() helper
      
     -    When a fetch has no refspec to work from, we fall back to guessing
     -    what to fetch: the remote's configured fetch refspec if there is one,
     -    and separately, whether the current branch's upstream lives on this
     -    remote. The latter is independent of the former on purpose: a narrow
     -    refspec (for example from "git remote add -t") can leave the current
     -    branch's own upstream uncovered, and we still need to be able to fetch
     -    it.
     +    When a fetch has no refspec to work from, we decide what to fetch from
     +    two sources: the remote's configured fetch refspec, and the current
     +    branch's upstream, if it lives on that remote. For example, after
     +
     +        git clone --single-branch <url>
     +        git switch -c work
     +        git push -u origin work
     +
     +    the remote's refspec only covers "main", but a refspec-less "git fetch
     +    origin" still fetches "work" into FETCH_HEAD, so that a plain "git
     +    pull" finds the branch to merge. See 49ca2fba39 (fetch: add
     +    branch.*.merge to default ref-prefix extension, 2022-09-08).
      
          That "does this branch build on this remote" check was inlined for
          just the current branch. Move it into its own function,
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
       	} else {
      -		struct branch *branch = branch_get(NULL);
     -+		struct string_list tracked = STRING_LIST_INIT_DUP;
     -+		struct string_list_item *item;
     - 
     +-
       		if (transport->remote->fetch.nr) {
       			refspec_ref_prefixes(&transport->remote->fetch,
     + 					     &transport_ls_refs_options.ref_prefixes);
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       			else
       				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      +		 * branch's upstream (e.g. a narrowed -t refspec), so
      +		 * make sure we can still fetch it regardless.
      +		 */
     -+		collect_upstream_from_remote(the_repository, &tracked,
     -+					      transport->remote, NULL);
     -+		for_each_string_list_item(item, &tracked)
     -+			strvec_push(&transport_ls_refs_options.ref_prefixes,
     -+				    item->string);
     -+		string_list_clear(&tracked, 0);
     ++		collect_upstream_from_remote(the_repository, transport->remote,
     ++					      NULL, &transport_ls_refs_options.ref_prefixes);
       
       		/*
       		 * If there are no refs specified to fetch, then we just
     @@ remote.c: int branch_merge_matches(struct branch *branch,
       }
       
      +void collect_upstream_from_remote(struct repository *repo,
     -+				   struct string_list *tracked,
     -+				   struct remote *remote,
     -+				   const char *refname)
     ++				   const struct remote *remote,
     ++				   const char *refname,
     ++				   struct strvec *tracked)
      +{
      +	struct branch *branch = repo_branch_get(repo, refname);
      +
     @@ remote.c: int branch_merge_matches(struct branch *branch,
      +		return;
      +
      +	for (int i = 0; i < branch->merge_nr; i++)
     -+		string_list_insert(tracked, branch->merge[i]->src);
     ++		strvec_push(tracked, branch->merge[i]->src);
      +}
      +
       __attribute__((format (printf,2,3)))
     @@ remote.h: int branch_has_merge_config(struct branch *branch);
      + * tracked. A NULL refname means the current branch.
      + */
      +void collect_upstream_from_remote(struct repository *repo,
     -+				   struct string_list *tracked,
     -+				   struct remote *remote,
     -+				   const char *refname);
     ++				   const struct remote *remote,
     ++				   const char *refname,
     ++				   struct strvec *tracked);
      +
       /* list of the remote in a group as configured */
       struct remote_group_data {
 3:  9fb7e77a86 ! 3:  5c76b3b88d fetch: infer branches to fetch from a refmap-only remote
     @@ Metadata
       ## Commit message ##
          fetch: infer branches to fetch from a refmap-only remote
      
     -    Configuring remote.<name>.refmap without remote.<name>.fetch used to
     -    make a refspec-less "git fetch <name>" fail with "--refmap option is
     -    only meaningful with command-line refspec(s)", since a refmap only
     -    says where to put fetched refs, not what to fetch.
     +    We want remote.<name>.refmap to work on its own, without also setting
     +    remote.<name>.fetch, so a remote can be limited to the branches
     +    already in use locally, without listing them by hand or touching the
     +    command line every time.
      
     -    Make that case infer what to fetch: the local branches whose
     -    @{upstream} is already on that remote. This lets a remote be
     -    configured to fetch only the branches actually in use, without
     -    listing them by hand in remote.<name>.fetch, and without needing to
     -    touch the command line every time.
     +    Infer what to fetch from the local branches whose @{upstream} is
     +    already on that remote. The refmap itself still only controls where
     +    those fetched refs land, not which branches are selected.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/config/remote.adoc: remote.<name>.fetch::
      -	store. See the `--refmap` entry in linkgit:git-fetch[1].
      +	store. If `remote.<name>.fetch` is not set either, a refspec-less
      +	fetch infers what to fetch from local branches built on this
     -+	remote, instead of fetching every branch it has. See the
     -+	`--refmap` entry in linkgit:git-fetch[1].
     ++	remote, instead of needing `remote.<name>.fetch` listed by hand.
     ++	See the `--refmap` entry in linkgit:git-fetch[1].
       
       remote.<name>.push::
       	The default set of "refspec" for linkgit:git-push[1]. See
     @@ Documentation/fetch-options.adoc: endif::git-pull[]
      -same way `remote.<name>.fetch` provides the default refspecs to fetch.
      +When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
      +nothing to fetch is specified on the command line, nor is there a
     -+`remote.<name>.fetch`, branches from the remote that are used as the
     -+`@{upstream}` of our local branches are fetched.
     ++`remote.<name>.fetch`, infer what to fetch from local branches built on
     ++this remote: remote-tracking branches from this remote that are also
     ++configured as the `@{upstream}` of a local branch are fetched. The
     ++refmap only decides where those fetched refs land, the same as it
     ++would for an explicit refspec, and does not narrow which branches are
     ++selected. It is what turns this on, since without it the fetched
     ++branches would have nowhere to land.
       
       `-t`::
       `--tags`::
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       
      +	if (!rs->nr && remote && !remote->fetch.nr &&
      +	    effective_refmap && effective_refmap->nr) {
     -+		struct string_list tracked = STRING_LIST_INIT_DUP;
     -+		struct string_list_item *item;
     ++		struct strvec tracked = STRVEC_INIT;
      +
      +		branches_tracking_remote(the_repository, remote, &tracked);
     -+		for_each_string_list_item(item, &tracked)
     -+			refspec_append(&inferred_rs, item->string);
     -+		string_list_clear(&tracked, 0);
     ++		for (size_t i = 0; i < tracked.nr; i++)
     ++			refspec_append(&inferred_rs, tracked.v[i]);
     ++		strvec_clear(&tracked);
      +
      +		rs = &inferred_rs;
      +		infer_from_refmap = 1;
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	return ref_map;
       }
       
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 	struct strmap rejected_refs = STRMAP_INIT;
     + 	int summary_width = 0;
     + 	int follow_remote_head = FOLLOW_REMOTE_NEVER;
     ++	bool apply_follow_remote_head_config = false;
     + 
     + 	if (tags == TAGS_DEFAULT) {
     + 		if (transport->remote->fetch_tags == 2)
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       
       	if (rs->nr) {
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
     +-	} else {
     +-		if (transport->remote->fetch.nr) {
     +-			refspec_ref_prefixes(&transport->remote->fetch,
     +-					     &transport_ls_refs_options.ref_prefixes);
     +-			/*
     +-			 * See remote.c's handling of remote.<name>.followRemoteHEAD
     +-			 * for the analogous, still-unresolved case.
     +-			 */
     +-			if (transport->remote->follow_remote_head)
     +-				follow_remote_head = transport->remote->follow_remote_head;
     +-			else if (config->follow_remote_head_seen)
     +-				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
     +-			else
     +-				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
     +-		}
      +	} else if (transport->remote->fetch.nr) {
     -+		struct string_list tracked = STRING_LIST_INIT_DUP;
     -+		struct string_list_item *item;
     -+
      +		refspec_ref_prefixes(&transport->remote->fetch,
      +				     &transport_ls_refs_options.ref_prefixes);
     ++		apply_follow_remote_head_config = true;
     + 
     + 		/*
     + 		 * The configured refspec may not cover the current
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 		 */
     + 		collect_upstream_from_remote(the_repository, transport->remote,
     + 					      NULL, &transport_ls_refs_options.ref_prefixes);
     ++	} else {
     ++		/*
     ++		 * The --refmap command line option, if given, takes
     ++		 * precedence over remote.<name>.refmap.
     ++		 */
     ++		struct refspec *effective_refmap = refmap.nr ? &refmap :
     ++			&transport->remote->refmap;
     ++
     ++		if (effective_refmap->nr) {
     ++			branches_tracking_remote(the_repository, transport->remote,
     ++						  &transport_ls_refs_options.ref_prefixes);
     ++			apply_follow_remote_head_config = true;
     ++		} else {
     ++			collect_upstream_from_remote(the_repository, transport->remote,
     ++						      NULL, &transport_ls_refs_options.ref_prefixes);
     ++		}
     + 
     + 		/*
     + 		 * If there are no refs specified to fetch, then we just
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 				    "HEAD");
     + 	}
     + 
     ++	if (apply_follow_remote_head_config) {
      +		/*
      +		 * See remote.c's handling of remote.<name>.followRemoteHEAD
      +		 * for the analogous, still-unresolved case.
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      +			follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
      +		else
      +			follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
     ++	}
      +
     -+		/*
     -+		 * The configured refspec may not cover the current
     -+		 * branch's upstream (e.g. a narrowed -t refspec), so
     -+		 * make sure we can still fetch it regardless.
     -+		 */
     -+		collect_upstream_from_remote(the_repository, &tracked,
     -+					      transport->remote, NULL);
     -+		for_each_string_list_item(item, &tracked)
     -+			strvec_push(&transport_ls_refs_options.ref_prefixes,
     -+				    item->string);
     -+		string_list_clear(&tracked, 0);
     - 	} else {
     -+		/*
     -+		 * The --refmap command line option, if given, takes
     -+		 * precedence over remote.<name>.refmap.
     -+		 */
     -+		struct refspec *effective_refmap = refmap.nr ? &refmap :
     -+			&transport->remote->refmap;
     - 		struct string_list tracked = STRING_LIST_INIT_DUP;
     - 		struct string_list_item *item;
     - 
     --		if (transport->remote->fetch.nr) {
     --			refspec_ref_prefixes(&transport->remote->fetch,
     --					     &transport_ls_refs_options.ref_prefixes);
     -+		if (effective_refmap->nr) {
     -+			branches_tracking_remote(the_repository,
     -+						  transport->remote, &tracked);
     - 			/*
     - 			 * See remote.c's handling of remote.<name>.followRemoteHEAD
     - 			 * for the analogous, still-unresolved case.
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
     - 			else
     - 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
     -+		} else {
     -+			collect_upstream_from_remote(the_repository, &tracked,
     -+						      transport->remote, NULL);
     - 		}
     --
     --		/*
     --		 * The configured refspec may not cover the current
     --		 * branch's upstream (e.g. a narrowed -t refspec), so
     --		 * make sure we can still fetch it regardless.
     --		 */
     --		collect_upstream_from_remote(the_repository, &tracked,
     --					      transport->remote, NULL);
     - 		for_each_string_list_item(item, &tracked)
     - 			strvec_push(&transport_ls_refs_options.ref_prefixes,
     - 				    item->string);
     + 	if (tags == TAGS_SET || tags == TAGS_DEFAULT)
     + 		strvec_push(&transport_ls_refs_options.ref_prefixes,
     + 			    "refs/tags/");
      
       ## remote.c ##
      @@ remote.c: void collect_upstream_from_remote(struct repository *repo,
     - 		string_list_insert(tracked, branch->merge[i]->src);
     + 		strvec_push(tracked, branch->merge[i]->src);
       }
       
      +struct branches_tracking_remote_cb_data {
      +	struct repository *repo;
     -+	struct remote *remote;
     -+	struct string_list *tracked;
     ++	const struct remote *remote;
     ++	struct strvec *tracked;
      +};
      +
      +static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
      +{
      +	struct branches_tracking_remote_cb_data *data = cb_data;
      +
     -+	collect_upstream_from_remote(data->repo, data->tracked, data->remote,
     -+				      ref->name);
     ++	collect_upstream_from_remote(data->repo, data->remote, ref->name,
     ++				      data->tracked);
      +	return 0;
      +}
      +
     -+void branches_tracking_remote(struct repository *repo, struct remote *remote,
     -+			       struct string_list *tracked)
     ++void branches_tracking_remote(struct repository *repo,
     ++			       const struct remote *remote,
     ++			       struct strvec *tracked)
      +{
      +	struct branches_tracking_remote_cb_data data = { repo, remote, tracked };
      +
     @@ remote.c: void collect_upstream_from_remote(struct repository *repo,
      
       ## remote.h ##
      @@ remote.h: void collect_upstream_from_remote(struct repository *repo,
     - 				   struct remote *remote,
     - 				   const char *refname);
     + 				   const char *refname,
     + 				   struct strvec *tracked);
       
     -+/* fills tracked with the refname of every local branch's upstream on remote */
     -+void branches_tracking_remote(struct repository *repo, struct remote *remote,
     -+			       struct string_list *tracked);
     ++/* Same as collect_upstream_from_remote(), but checked for every local branch. */
     ++void branches_tracking_remote(struct repository *repo,
     ++			       const struct remote *remote,
     ++			       struct strvec *tracked);
      +
       /* list of the remote in a group as configured */
       struct remote_group_data {
 4:  80028d4f86 ! 4:  417f14d708 remote: add "git remote add --limited-fetch"
     @@ builtin/remote.c: static int add(int argc, const char **argv, const char *prefix
       	repo_config_set(the_repository, buf.buf, url);
       
       	if (!mirror || mirror & MIRROR_FETCH) {
     -+		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
     ++		bool use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
      +			limited_fetch == 1;
      +
       		strbuf_reset(&buf);
 5:  552bf08971 ! 5:  de0daa8623 remote: default to --limited-fetch in a shallow repository
     @@ Metadata
       ## Commit message ##
          remote: default to --limited-fetch in a shallow repository
      
     -    Adding a second remote to a shallow, single-branch clone used to
     -    still fetch every branch that remote has, since "git remote add"
     -    always set up a wildcard remote.<name>.fetch refspec regardless of
     -    how shallow the repository already was. That defeats the purpose of
     -    having cloned shallow and single-branch in the first place, and can
     -    make a plain "git fetch" on that remote hang or take a very long
     +    Adding a second remote to a shallow clone used to still fetch every
     +    branch that remote has, since "git remote add" always set up a
     +    wildcard remote.<name>.fetch refspec regardless of how shallow the
     +    repository already was. That defeats the purpose of having cloned
     +    shallow in the first place (for example with --single-branch), and
     +    can make a plain "git fetch" on that remote hang or take a very long
          time on a repository with many branches.
      
          Turn --limited-fetch on by default when the repository is already
     @@ builtin/remote.c
      @@ builtin/remote.c: static int add(int argc, const char **argv, const char *prefix,
       
       	if (!mirror || mirror & MIRROR_FETCH) {
     - 		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
     + 		bool use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
      -			limited_fetch == 1;
      +			(limited_fetch == 1 ||
      +			 (limited_fetch == -1 &&

-- 
gitgitgadget

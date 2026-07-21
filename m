Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC847044A
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664864; cv=none; b=k6GwlCy/nXexhPe02iCZNsSeYycHP3uCfb8XseFL76YTILQ7jSfQnQ/ShmpJUjT5SOdpX17No4I0g7BTQGcor9F+eh7Lfwl65GwE8mAoydI6jMK29rFpYaFF1RBLn1Sh4f1TNiFP6BtnynB0b4GTUK5x6pxLwQkq0gN3n075WmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664864; c=relaxed/simple;
	bh=6BT1gsZiWZRNLH1WsGQKUr0AWCuihY3DiklIsKzw15k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YB28gBRP47Bv9Xj0vS6ya3ALnqsGNW/yIWBITjW8ZWYqGf5VxRr93daSgu9VFdOzT1Re0Ul0w/91Tk/UBAvAPfJ0hCUe6mHXqNWvaH33THnvB+wJiQP7dmRYo2l10Y4iECj40ZpXFCWJlB528D3PUS1MkLL3gRrHHc44XGTQJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxBvhVLw; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxBvhVLw"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb64371a2aso5123494a34.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784664861; x=1785269661; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mJhtQN4QiFKoxc8KvTf2lsMdwoRGA9TNDhdykWz8Y0c=;
        b=YxBvhVLw4EMlCiZruto7dAFWpRo+WrSWkws4W7bOYkgOeVlJ+WDMgnxp8qn/FdjDzT
         Je+SE8X1qnt6E4XjgWZRm3PZYN0SLwkfxT779lemMA7aGuMEOpXbeH9PvIvsr3ozem0T
         9YErktdZ5YoaWIFmKg8mzJDUwxpOkBi1HiEWM6rKJLL3r2+rxNYmBk02L2PEAam827eA
         3RVBN0PS5/qmbcDe2FMH75INwpoh/mvmEj6DGJda6TyQnFJUs5ryf4z2G5UgBipUakjL
         jBi1CpYIDQm/3Fk9h4WRUTs3ue0DrZLvTiRNyDbtpFfRqLy5WuyPMDkwr6kGNfc7UQpW
         uJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664861; x=1785269661;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJhtQN4QiFKoxc8KvTf2lsMdwoRGA9TNDhdykWz8Y0c=;
        b=DiagszfLhtOaQHuK6GuDyaR5Eh0LkM20YD5Nw5U40IEXZh4QgJeHfj0MbG00EWQpvJ
         vnNAT+cquszU7ui3izleieL0eGMW7kTWEjMkogcGKXVhlu9rL4GILcqEFxg7/JyW3KaQ
         7kv0MAHPf2w4KihFPqr/kHnvBqxsRby6la/8Dp59f0gQLwJ931FABhy8u83HWTzT/U0j
         ZO2QvZAKtOeIJM03BiUNOyBCWZjOC/IVaNMHv35B954WWi5jBIQI2NQhYMct/4sJZ0Lw
         sY+WZBjTPTFbAErVaKlYWwHpoANPbTBhlkYx48BTouh9zu7vZMCK3Jgj4GE2uF6sxd7d
         +eiw==
X-Gm-Message-State: AOJu0YxuK3/CRpMK64udtEpaw6cvHAJbBSl4NQql6JxuuwTD5f/n8C3d
	8xiAy9oH5D/zb06npxXOqIZhunH+kLAJxFppetrw5k0sFLCR4pI6iv+0d4Ihnw==
X-Gm-Gg: AfdE7cmAOCI8z3VmRiAFLN5sG2QP77GqrqWLF9MKKJHXQ7ceQvZFiuQITopnCKQNXkg
	Je+abbYz4U/Hdnkp0DCN6koYk8VArxBVTOoXJZuDvlI0xTezDsIlBvN+zLdZHdY0sdbN6J3k/M/
	I0kmLXXmsNYIMyl1fNX7Z9rc2Io9ms6LWthrsf+qbpsZGBdcJKmFnfoSfCc39LsCt4BQ7iPcouz
	giNZj35LLC/ywxYkLH52lj/tVT/NTLBnxPkiae46s8hdTmZ00F4dkko5+B97Ree7ZbQFR+e/EQA
	5frWfe+KYcxfpJ4ENyRkeYS8W5PUtZoWMARILJF79A+CUvInM3N7fqwFhhbVTNfax447o2ka8Bw
	5GaptOFxEa8BtJ6sYPJCiBgirgCGFw444MX7E48nAUpIWKluUyApcyOk8jrNtZ+u182dhvEnj+N
	GxORMkcA==
X-Received: by 2002:a05:6830:8d0:b0:7e9:ff97:5e3b with SMTP id 46e09a7af769-7eda08f4022mr10143874a34.15.1784664861106;
        Tue, 21 Jul 2026 13:14:21 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.123.151])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf99b337sm11093779a34.21.2026.07.21.13.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:14:20 -0700 (PDT)
Message-Id: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
References: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 20:14:17 +0000
Subject: [PATCH v3 0/2] remote: url-based pushRemote with renamed remotes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Fix git status not showing the push branch after remotes are renamed, when
branch.<name>.pushRemote is a URL matching exactly one configured remote.

Changes in v4:

 * Match against the actual push URL, including pushurl and pushInsteadOf.
 * Clarify how rearranging remotes exposes the git status tracking problem.
 * Simplify and correct the documentation for URL-valued pushRemote.

Changes in v3:

 * Revamp commit messages to clarify motivation.

Changes in v2:

 * Clarify that URL push destinations already work and that this change only
   restores their tracking information.
 * Document URL values for branch.<name>.pushRemote and their @{push}
   behavior.

Harald Nordgren (2):
  remote: pass repository to push tracking helper
  remote: find tracking branches for URL push destinations

 Documentation/config/branch.adoc |   1 +
 Documentation/revisions.adoc     |   3 +
 remote.c                         |  43 +++++++++--
 remote.h                         |   2 +
 t/t5505-remote.sh                | 124 +++++++++++++++++++++++++++++++
 transport.c                      |   5 +-
 6 files changed, 172 insertions(+), 6 deletions(-)


base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2358%2FHaraldNordgren%2Fremote-resolve-url-push-tracking-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2358/HaraldNordgren/remote-resolve-url-push-tracking-v3
Pull-Request: https://github.com/git/git/pull/2358

Range-diff vs v2:

 1:  b1ac49de87 = 1:  b1ac49de87 remote: pass repository to push tracking helper
 2:  6e924a7fec ! 2:  a343af9d50 remote: find tracking branches for URL push destinations
     @@ Metadata
       ## Commit message ##
          remote: find tracking branches for URL push destinations
      
     -    Git already accepts a repository URL as branch.<name>.pushRemote and
     -    can push to it. When a configured remote has the same URL, however,
     -    "git status" cannot show that remote's push branch.
     +    Git accepts a repository URL as branch.<name>.pushRemote and can push
     +    to it. This branch setting takes precedence over remote.pushDefault.
      
     -    This can happen in fork workflows when the original remote is renamed
     -    to "upstream", the fork is added as "origin", and an existing
     -    pushRemote value still contains the fork URL. The URL still points to
     -    the right repository, so pushing works. However, @{push} is unavailable
     -    because Git does not connect the URL to "origin". As a result,
     +    A branch can be configured with a URL-valued pushRemote before any push
     +    occurs. If the remotes are later rearranged with "git remote rename" and
     +    "git remote add", the newly added remote may use that URL. The URL value
     +    is unaffected by the rename and continues to take precedence over
     +    remote.pushDefault. The URL and the remote then point to the same
     +    repository, but Git does not connect them for tracking. Pushing works,
     +    but @{push} cannot identify the remote's tracking branch. As a result,
          "git status" cannot show the push branch, and an up-to-date push can
     -    leave its local tracking information stale.
     +    leave its tracking information stale.
      
     -    When exactly one configured remote has the URL as one of its
     -    remote.<name>.url values, use its fetch refspec to find and refresh the
     -    push branch. Keep the URL as the push destination so the configured
     -    remote's push settings do not change existing behavior. Keep the
     -    current behavior when no remote matches or multiple remotes match.
     +    When exactly one configured remote uses the push destination URL, use
     +    that remote for push tracking. Continue to push to the URL so the
     +    configured remote's push settings do not change existing behavior. Keep
     +    the current behavior when no remote matches or multiple remotes match.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/config/branch.adoc: This option defaults to `never`.
       	repository), you would want to set `remote.pushDefault` to
       	specify the remote to push to for all branches, and use this
       	option to override it for a specific branch.
     -+	The value may be the name of a configured remote or a repository
     -+	URL. A URL is used directly as the push destination.
     ++	The value may be the name of a configured remote or a repository URL.
       
       `branch.<name>.merge`::
       	Defines, together with `branch.<name>.remote`, the upstream branch
     @@ Documentation/revisions.adoc: some output processing may assume ref names in UTF
         `git push` were run while `branchname` was checked out (or the current
         `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
         the remote-tracking branch that corresponds to that branch at the remote.
     -+  If the push destination is a URL and exactly one configured remote has the
     -+  same `remote.<name>.url`, '@\{push}' reports the remote-tracking branch for
     -+  that remote.
     ++  If the push destination is a URL and exactly one configured remote has
     ++  that URL among its `remote.<name>.url` values, '@\{push}' reports that
     ++  remote's remote-tracking branch.
       +
       Here's an example to make it more clear:
       +
     @@ remote.c: const char *branch_get_upstream(struct branch *branch, struct strbuf *
      +struct remote *repo_remote_for_push_tracking(struct repository *repo,
      +					     struct remote *remote)
      +{
     ++	const struct strvec *push_urls;
      +	struct remote *first_match = NULL;
      +	struct remote_state *remote_state = repo->remote_state;
     ++	const char *check_url;
      +
     -+	if (remote->origin != REMOTE_UNCONFIGURED || remote->url.nr != 1)
     ++	if (remote->origin != REMOTE_UNCONFIGURED)
      +		return remote;
      +
     ++	push_urls = push_url_of_remote(remote);
     ++	if (push_urls->nr != 1)
     ++		return remote;
     ++	check_url = push_urls->v[0];
     ++
      +	for (int i = 0; i < remote_state->remotes_nr; i++) {
      +		struct remote *candidate = remote_state->remotes[i];
      +
      +		if (!candidate || candidate == remote ||
      +		    !remote_is_configured(candidate, 0) ||
     -+		    !remote_has_url(candidate, remote->url.v[0]))
     ++		    !remote_has_url(candidate, check_url))
      +			continue;
      +		if (first_match)
      +			return remote;
     @@ t/t5505-remote.sh: setup_repository () {
      +	rm -rf fork.git client &&
      +	git clone --bare one fork.git &&
      +	git clone one client &&
     -+	fork_url="$TRASH_DIRECTORY/fork.git" &&
     ++	fork_url="file://$TRASH_DIRECTORY/fork.git" &&
      +	(
      +		cd client &&
      +		git checkout -b topic --track origin/main &&
     @@ t/t5505-remote.sh: test_expect_success 'rename a remote renames repo remote.push
      +	EOF
      +'
      +
     -+test_expect_success 'adding fork remote makes URL-valued pushRemote trackable' '
     ++test_expect_success 'adding matching remote makes URL-valued pushRemote trackable' '
      +	setup_url_pushremote &&
      +
      +	(
     @@ t/t5505-remote.sh: test_expect_success 'rename a remote renames repo remote.push
      +	EOF
      +'
      +
     ++test_expect_success 'pushInsteadOf URL pushRemote is trackable' '
     ++	setup_url_pushremote &&
     ++	(
     ++		cd client &&
     ++		git remote rename origin upstream &&
     ++		git remote add -f origin "$fork_url" &&
     ++		git config "url.$fork_url.pushInsteadOf" fork: &&
     ++		git config branch.topic.pushRemote fork:
     ++	) &&
     ++
     ++	check_status <<-EOF
     ++	On branch topic
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     ++
     ++	Your branch is up to date with ${SQ}origin/topic${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++'
     ++
      +test_expect_success 'up-to-date URL push refreshes stale tracking branch' '
      +	setup_url_pushremote &&
      +	(

-- 
gitgitgadget

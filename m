Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF7304BB8
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056269; cv=none; b=uCeGBhboJu/M/A8Jsh4v8+jAAOS69aA1kbCdYg08BoZlMYrZha0AqGTOBdbO0KC2NCRwlf0V8pGlNgGeBNPEIAa+bU7BpAXaEH1LfZ7SjVRPfs9Q8JXAgL/lmLRkB9Ko9MIVaho0DROOCcuk5pa5GNtYEA/pW9DY4/i6eYT27Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056269; c=relaxed/simple;
	bh=xFR5TFQNH/xJ29iQLDu0ygU+ZjeOa8xhLXRI19DHZ88=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WzvS+6AuUMHAQm/6LpQFVbU9XyQLKWG5yHLgUpj2wsAjOlmsUBXQfEM7lYFPk+MA7r4DDw9c2Q3kaVxr0zbLArr8S7yQSjE3QpQ31RuRIFf4irbN1Q5g2+qpsceuhmQebgdFzJd0+Rg8r0221G5z0STMLELSQC0Nifi6hnqrqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGs3ZL1z; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGs3ZL1z"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6f21c2d81so6970385a.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 13:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772056265; x=1772661065; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJg0Y8B0kUXui0xVbKLulZ7U3z1nh0GrMDiQYn0Btmg=;
        b=CGs3ZL1zsQzQN3L/Hc/nXg+iojuXieBcSKe3SLDLkAjDdAZZlthRUT3sHl7NqxD2AH
         wZOQ6dJnXj7AHmRy/W3QFFHtW+++VkogSaRiaKW0FF4yvjCZBiqqETW4F3KrSW/7xLV8
         6Hz5/id1dhPlbbCipJc125fVHM1OxoYEmdUABYNiZn+o7w7kK1Jv3hsivhfvGIk0jlJ3
         /++bZyvPAvrn+3ozMPbCEoby+mHT2YBjBxjwRb4nT251oln6/+RiI3MTPKZUUv69T3NM
         rzEIDIOedItko9sbG8gdy/uEq0IEgoUzaMkjW/EsILpjjGpU1RTabh7nrObb4XJxi4D9
         qrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772056265; x=1772661065;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJg0Y8B0kUXui0xVbKLulZ7U3z1nh0GrMDiQYn0Btmg=;
        b=qj0gtY3RnsyInqMxU7awt9i6tvjh74WZLFg21mdBwGZshFRRdPSFy1MmeVGvITDvbs
         GoMuulyCPnThTj5yG6JnAqUx5nbXYluofgJeTcq/ocorhBvCkNWJL7PbbiY9aK+k1aCX
         1DfktKOPBfXkAmVDV2WhbM6qENHaYM2YCjAq7RvofUeJVZ3fh1zeavQlB6zooBtK96dN
         S+oLNCXH7xhgnaQ1d+cPjmYA3qkdNiN7qXvr4eCgh+wPNd0OXX3MGz6C8ASEhI7wzJVP
         sZXPRZyiAFcwz6wNNDyB6ukZajXfnAW/1909dZyHlFOl6T2r0XkpQTBiKQ7DU/+FZijG
         SRpg==
X-Gm-Message-State: AOJu0YyA+Y/INv09KBgJUpahTYt7B53T1PC83Gp3REi2tw6B1Vwdie1i
	geJvjKoDC8Nj+xCWsG8FY1aiNd+/q4NjDNR0j9+u2bnV4yfC/ZrAt+XA5FDKzA==
X-Gm-Gg: ATEYQzydG0YUYFDdI3cRFYmO/N07+/veCKPvCcJxBvIvZshyEiedCe/TwmayncpxCWL
	G8EegCTABJ6d6MppdzWr7uiX8j1hd1PMfNVarBiss9cemRgmQPd5EvQk1QabKO3zGcaau5LlNGI
	pGNjXGXrk8zMHq6h85ocg7oGoqKxAMUmEE7KXZODrZ6QRE87hlFRu12J4f/6Y2UvQYroZXvSKK0
	N4BTBblIYPdrPjSo3cUCJQ06+I5fZPFO+8ntmjWEFdyAZCUPt2Gq1/JGxdhoPYRDznl9MyCFAnU
	h2HhqxU4ji6Ifkd/hui2Zy2j4I3+i4g7lBu0Xur1BB0CPIykTSe/DbJZv50akdp3oA5R46yQ1mP
	NAWioXp4d047DD9Bw+jmKhpuuaXfFEGXWnHzEU/axvYFXS0NTBrCJ1RihTwiJXOJ+r+1C4Xd4w5
	7SC+5A77Zb/j3sfP4tyRNGhhPpPQ==
X-Received: by 2002:a05:622a:178c:b0:4f1:bacc:151 with SMTP id d75a77b69052e-5070bce83dfmr231275051cf.60.1772056264903;
        Wed, 25 Feb 2026 13:51:04 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449874b7sm3289551cf.9.2026.02.25.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:51:04 -0800 (PST)
Message-Id: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
References: <pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 21:51:01 +0000
Subject: [PATCH v29 0/2] status: add status.compareBranches config for multiple branch comparisons
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
Jeff King peff@peff.net

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: add status.compareBranches config for multiple branch
    comparisons

 Documentation/config/status.adoc |  19 ++
 remote.c                         | 180 +++++++++++++----
 t/t6040-tracking-info.sh         | 335 +++++++++++++++++++++++++++++++
 3 files changed, 497 insertions(+), 37 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v29
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v29
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v28:

 1:  f3c8c782b0 = 1:  48db1f4847 refactor format_branch_comparison in preparation
 2:  067978dd09 ! 2:  6a88f41fa5 status: add status.compareBranches config for multiple branch comparisons
     @@ Metadata
       ## Commit message ##
          status: add status.compareBranches config for multiple branch comparisons
      
     -    Add a new configuration variable `status.compareBranches` that allows
     -    users to specify a space-separated list of branches to compare against
     -    the current branch in `git status` output.
     +    Add a new configuration variable status.compareBranches that allows
     +    users to specify a space-separated list of branch comparisons in
     +    git status output.
      
     -    Each branch in the list can be:
     -    - A remote-tracking branch name (e.g., `origin/main`)
     -    - The special reference `@{upstream}` for the tracking branch
     -    - The special reference `@{push}` for the push destination
     +    Supported values:
     +    - @{upstream} for the current branch's upstream tracking branch
     +    - @{push} for the current branch's push destination
     +
     +    Any other value is ignored and a warning is shown.
      
          When not configured, the default behavior is equivalent to setting
     -    `status.compareBranches = @{upstream}`, preserving backward compatibility.
     +    `status.compareBranches = @{upstream}`, preserving backward
     +    compatibility.
      
          The advice messages shown are context-aware:
          - "git pull" advice is shown only when comparing against @{upstream}
     @@ Documentation/config/status.adoc: status.aheadBehind::
       	non-porcelain status formats.  Defaults to true.
       
      +status.compareBranches::
     -+	A space-separated list of branches to compare the current branch
     -+	against in linkgit:git-status[1]. Each branch specification can be
     -+	a remote-tracking branch name (e.g. `origin/main`), or a special
     -+	reference like `@{upstream}` or `@{push}`. For each branch in the
     -+	list, git status shows whether the current branch is ahead, behind,
     -+	or has diverged from that branch.
     ++	A space-separated list of branch comparison specifiers to use in
     ++	linkgit:git-status[1]. Currently, only `@{upstream}` and `@{push}`
     ++	are supported. They are interpreted as `branch@{upstream}` and
     ++	`branch@{push}` for the current branch.
      ++
      +If not set, the default behavior is equivalent to `@{upstream}`, which
      +compares against the configured upstream tracking branch.
     @@ Documentation/config/status.adoc: status.aheadBehind::
      ++
      +----
      +[status]
     -+	compareBranches = origin/main origin/develop
     ++	compareBranches = @{upstream} @{push}
      +----
      ++
     -+This would show comparisons against both `origin/main` and `origin/develop`.
     ++This would show comparisons against both the configured upstream and push
     ++tracking branches for the current branch.
      +
       status.displayCommentPrefix::
       	If set to true, linkgit:git-status[1] will insert a comment
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       
      +static char *resolve_compare_branch(struct branch *branch, const char *name)
      +{
     -+	struct strbuf buf = STRBUF_INIT;
      +	const char *resolved = NULL;
     -+	char *ret;
      +
      +	if (!branch || !name)
      +		return NULL;
      +
     -+	if (!strcasecmp(name, "@{upstream}") || !strcasecmp(name, "@{u}"))
     ++	if (!strcasecmp(name, "@{upstream}"))
      +		resolved = branch_get_upstream(branch, NULL);
      +	else if (!strcasecmp(name, "@{push}"))
      +		resolved = branch_get_push(branch, NULL);
     ++	else {
     ++		warning(_("ignoring value '%s' for status.compareBranches; only @{upstream} and @{push} are supported"),
     ++			name);
     ++		return NULL;
     ++	}
      +
      +	if (resolved)
      +		return xstrdup(resolved);
     -+
     -+	strbuf_addf(&buf, "refs/remotes/%s", name);
     -+	resolved = refs_resolve_ref_unsafe(
     -+		get_main_ref_store(the_repository),
     -+		buf.buf,
     -+		RESOLVE_REF_READING,
     -+		NULL, NULL);
     -+	if (resolved) {
     -+		ret = xstrdup(resolved);
     -+		strbuf_release(&buf);
     -+		return ret;
     -+	}
     -+
     -+	strbuf_release(&buf);
      +	return NULL;
      +}
      +
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status.compareBranches with upstream and origin remotes multiple compare branches' '
     ++test_expect_success 'status.compareBranches supports ordered upstream/push entries' '
      +	(
      +		cd test &&
      +		git checkout -b feature6 upstream/main &&
      +		git push origin &&
      +		advance work &&
     -+		git -c status.compareBranches="upstream/main origin/feature6 origin/feature5" status >../actual
     ++		git -c status.compareBranches="@{push} @{upstream}" status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
      +	On branch feature6
     -+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     -+
      +	Your branch is ahead of ${SQ}origin/feature6${SQ} by 1 commit.
      +	  (use "git push" to publish your local commits)
      +
     -+	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
      +
      +	nothing to commit, working tree clean
      +	EOF

-- 
gitgitgadget

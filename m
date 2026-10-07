Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746E37BE6F
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410170; cv=none; b=gCpsZwVyoAuPWUX53vGDMLvScKHwnopiEpwjENfUr1/lSXbDUnqdNIPeFTs3826JUJ5zGKhIE2CbEDGipMTW92dTSsH8eUuWBTUwwvISxftvxgSGm5mrYJmccNptYweT9OjY4leIt0bRk8j056p9YxXLnAHtGg25Zf5tZystJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410170; c=relaxed/simple;
	bh=Qgn9bDbiM0MBfrDD71EvNI5/taSXTJ8WgpSQNd2dASk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D5Sja78UUHOBCwOMCMXL3jmdkL0aRUi4WQenxKBisiN4hIOSYQe+fAHQJda6GMZsnJ6eXBPdT1ZIhdhAXzXPpylZ4rwGPgn846MfE66TtW3yXKZ8m7v4oxYdrnh2LXtC5HgO7tVt9MNkwhb4AdHGRS/f2tkWGBZdjurUKz+IrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8qBccQV; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8qBccQV"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8249c775215so1410666a34.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410167; x=1792014967; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MO+8BSxKGKjapVw5MDWambHqgbFoPMq0V9MQgoJd4ok=;
        b=d8qBccQVh+VEpH+KzhyruFjxjTRMUwryL34JR2NYTqBb49OztLFwZ2EXBRoUV+e2U4
         wR6NqrbFP8w6uxFtnaVS+3e/OZR5MoXs1X1iW/vuVlIsvvR9MJ2jFQxuAJUkWicd60V/
         QRq3OQ0KD8++B4SQHxg5C9bB+vG4QsQWcecEZ8d/cV+HMGqXeME3hTt2izydX9XKiPZT
         tMEPg0aKcUfZhCC2Q7TicCzKuwXNqPG6oZXs/PbLYAj3WutZ6nSpqkDJSiGOfY3NXN4b
         LkX9NkdqbY+XYWtq7YCM6BoinPgpkmqMo2tet5EawUXTDuuc2i2roogI3r0CP4E1G4ze
         Fp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410167; x=1792014967;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MO+8BSxKGKjapVw5MDWambHqgbFoPMq0V9MQgoJd4ok=;
        b=Tb0nXPdAt+Xse7lgSIfZw1TGON7rlbxmAg4LZ2rTX5ML3PjXOfbETn6dD0ddPkUmMy
         5EiUwu22PD1ZPQiVmqCOFmmB3CxfKEsELDfWg4cJmBF42N0Y6RY8xxxRx5HybJNjvJAh
         B2qkeaqR2FqaohzR4tApTDMUlFNgaMwEgqhAXvnYzibJrCdEVWe2YiKSILY8dwtQX9WF
         9IaKvEmOEPSOHX8VHHMFPA3eSAVa9xEfo5FWYT88al+w+dUXhdva3pwBYAH85jbGeCo3
         8TpI4e4Mr3jg2v9vFV8yeoKsGvCYr4yQ/NI+Jh7OLkatAa2l8YxZmp4CVXlJtQkSSxKw
         XjLQ==
X-Gm-Message-State: AFuF++k27wVPUV7BM8HXBrVXmTOsT3xNODYQqx+Igr13wJQKCejrftlO
	GCrjyL2Kme1QoxJlwViHCWf6nEYEZk05Oqo0PAH8da2/rqhAaq6W5qiDOd8gXLZw
X-Gm-Gg: AYBFou0FgJm2QOx9+MiC/CGJVeRtKdfBJksNnyyOTmwOJX8uniX43nyNXFIK9zymiN7
	I5F4VxwMr5K2zHvHVcsj8utv/8uFf3aY9xRtYNcCZtCLRbZ3++xiwoC0FPdzEoQ9vmV9eRIIqNr
	DDidaFBwapHws9esYDjZ9ciDt54AYEw/WudrcGMO4vPQyevvuuyvE4/8G1JL5ANHBhx2ysIDmqT
	DB2aXNoegttgJj2QtrxDDkvF1aYQW57rEJPJg2jYNRT/RB3YQQAtzP5cowS2gtVxetti2W0ARfC
	dQBf7pcvimops6V2ELTqKP049dtraUnw1/2Z930TD2z12uAhI4eaLdBqWfySzfg4UjlOHoIvXH1
	GYOI/prryCaH4crVFvFvb/0BZod1HmhpA+AxXWEzQnKVosijXfOEegZ7NsEzoohIlStNmtTd9ze
	gmmIoN+TsGVYVjTXScKg5Jl1bvSB2UJ9fBVySQpk5mu9EbflLTIu1EI3TLlWzzjp8oj3gVgpjZL
	49l
X-Received: by 2002:a05:6808:f88:b0:4d6:9273:2520 with SMTP id 5614622812f47-4fc46f968dcmr3367725b6e.60.1791410167181;
        Wed, 07 Oct 2026 14:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.134])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc4953f89fsm3508953b6e.12.2026.10.07.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:56:05 -0700 (PDT)
Message-Id: <pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 21:56:00 +0000
Subject: [PATCH v7 0/4] fetch: avoid fetching every branch of a new remote in a shallow repo
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

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

Harald Nordgren (4):
  fetch: add remote.<name>.refmap
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |   5 ++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  58 ++++++++++++---
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  41 ++++++++++-
 remote.h                         |   9 +++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 |  63 ++++++++++++++++
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 408 insertions(+), 17 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v7
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v6:

 1:  5c31a51bb7 ! 1:  b5db64d56f fetch: add remote.<name>.refmap
     @@ Commit message
          to do when there is nothing explicit to fetch, on the command line or
          via remote.<name>.fetch.
      
     +    A refspec-less fetch with a refmap configured but nothing else to say
     +    what to fetch falls back to the same defaults as a remote with no
     +    refspec or refmap at all. Only an explicit --refmap given on the
     +    command line with no command-line refspec to go with it is still
     +    rejected, since that combination is a plain mistake to type, unlike a
     +    remote.<name>.refmap configured on its own. A remote.<name>.fetch
     +    that is also configured is used as before.
     +
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       		else
       			fetch_refspec = &remote->fetch;
       
     - 		for (i = 0; i < fetch_refspec->nr; i++)
     - 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
     --	} else if (refmap.nr) {
     -+	} else if (effective_refmap && effective_refmap->nr) {
     - 		die("--refmap option is only meaningful with command-line refspec(s)");
     - 	} else {
     - 		/* Use the defaults */
      
       ## remote.c ##
      @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     @@ t/t5510-fetch.sh: test_expect_success 'explicit --refmap option overrides remote
      +		git rev-parse --verify refs/remotes/other/main
      +	)
      +'
     ++
     ++check_fetched_refs () {
     ++	git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
     ++	cat >expect &&
     ++	test_cmp expect actual
     ++}
     ++
     ++test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
     ++	test_when_finished "rm -fr fetch-refmap-baseline fetch-refmap-upstream" &&
     ++	git init -b main fetch-refmap-upstream &&
     ++	test_commit -C fetch-refmap-upstream base &&
     ++	git -C fetch-refmap-upstream branch other &&
     ++	git init fetch-refmap-baseline &&
     ++	(
     ++		cd fetch-refmap-baseline &&
     ++		git remote add origin ../fetch-refmap-upstream &&
     ++
     ++		# Without fetch refspec, but with fetch refmap.
     ++		git config --unset-all remote.origin.fetch &&
     ++		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
     ++
     ++		# Nothing tracked, nothing fetched, no error.
     ++		git fetch origin &&
     ++		check_fetched_refs <<-\EOF &&
     ++		EOF
     ++
     ++		# Nothing tracked, explicit ref on the command line.
     ++		git fetch origin main &&
     ++		check_fetched_refs <<-\EOF &&
     ++		refs/remotes/origin/main
     ++		EOF
     ++
     ++		# With both refmap and fetch configured, remote.<name>.fetch
     ++		# wins: a refspec-less fetch follows it as usual, and
     ++		# remote.<name>.refmap plays no part in deciding what to
     ++		# fetch, only in remapping something that is already being
     ++		# fetched by name.
     ++		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
     ++		git fetch origin &&
     ++		check_fetched_refs <<-\EOF
     ++		refs/remotes/origin/HEAD
     ++		refs/remotes/origin/main
     ++		refs/remotes/origin/other
     ++		EOF
     ++	)
     ++'
      +
       test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
       	git branch -f side &&
 2:  74c177e3e2 ! 2:  fd6864daaf fetch: infer branches to fetch from a refmap-only remote
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
      +	} else if (inferred_branches) {
      +		/* Already fully handled above. */
     - 	} else if (effective_refmap && effective_refmap->nr) {
     + 	} else if (refmap.nr) {
       		die("--refmap option is only meaningful with command-line refspec(s)");
       	} else {
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
 3:  3abcc8915b = 3:  a2208875b6 remote: add "git remote add --limited-fetch"
 4:  84d192445c = 4:  c8fd073de3 remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget

Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136413635E
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766530452; cv=none; b=f/TL8Ove2ZTKEpVzmItjQBksyJpWBf76xvRGfkVtg+K+EijjYYLc5wSkgkoPHDGCRF0rjBYh5P8tCc0rkNDcQ829n8SWh/NyAq0OeP8f7Cir3+PGWj1hisRcgWN7GS84JsD4m1by6UHovD57b66W/lUlTlGPb5TN7g64lv/r74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766530452; c=relaxed/simple;
	bh=ErurR+MPopirwO2toO1MARBtK4JdqcjJ308hH4RFm6Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TpgtGM9qEvLJHod5Yw2uR4sNW8B6y7MO6R1KwyfZbogFQBAVWzCXLULnU3XwqOt7yA8VUkaLSQwjw6XQdm2wywAegraUQ23SMMWQQIKD1rLuS1PgGkxAKSJOy2mUZt/DRxTBQ2NtzXpVOyVhVxtZjQmRp0UsBOl7aQ17vclOuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HujnXmKz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HujnXmKz"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a09d981507so38963185ad.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 14:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766530450; x=1767135250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWXSF17JvZF3MOzAQGFAUoHbFHcLvFqdDt2mZpyxDW8=;
        b=HujnXmKzxPdmkOtOXcdkF8P4w/R8T2/Ruc/F1HGWiqXa7nvKgepFbv5zkzNMlxKvBE
         y9gGy8VCbYyuAHmI3QSzYrTVDEV+zv49AzTqY86w/ACiHBsYPjWlhejIs9RqBH9aNRJ/
         3NR4We3M+59gWYrEkCUz6M/SKzg7V/ljNdXsHgAomOKIDA+I20YSKypJ2ARN1qo7jW/h
         rvi41ulc0m14ONmZTJycl5tX7gSMVfef9xsZsSIJKCzsot4FahFf4AZk2yU5ScynXQiw
         0g2RBVnM9ZATPfD9B13n3DvDGiDkXCCUdV1iAsbttndSnoYjohGrLfxgfMwbP9LspkIB
         SLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766530450; x=1767135250;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tWXSF17JvZF3MOzAQGFAUoHbFHcLvFqdDt2mZpyxDW8=;
        b=dVGuKxAU7Bg6fNMHtKQE2gwVh+7CkEb4JAOdZ7vYZZSlk1skyxAWpHEr+ftfEDonk3
         qxjTfJQnCenGtyevmbSONOTlE74wmr/6H9KARpzoLbJMfPU7qQocHE5Ffi/CV75OYTGb
         bX1XonoMw1+nMVnamBWImvlU6/XPWyYemHVcnbh49iuEEG2JZpsZeJGd56E+1lABnD2h
         oWYJsMcBv3jDtnKnpQtl45EQCYUCwMz4Ns10wk+2cRC/nqlHt2+wp3nSi0fo3k3AFu1k
         k5AtLb6JYVIBeE4Cu4xK7ztGXCq/Wi07h0uyEwX+pZlEHEAAcvqeDzvuQP8JphKooxlt
         lcKA==
X-Gm-Message-State: AOJu0YzS8tstTQE2hl3emO/6HhxSCwQV6ikIc4DaC89qheNdzFpZ9gDw
	lC+q94akpw657AA4zrQzIkDWwLICSeKkCA/dRCEb9lRCmwWfW2hN1QLy8q0PYg==
X-Gm-Gg: AY/fxX45X9w1CgJw1QekazXOutE+gWZIH6FwWnRoY1prmdLjIumSseZRNfIqJKLeSaR
	dREk6j/q917/6m4o87YwoQ7upCpKdeCfOt7VkjlpzV/z8MLkJPmgUxyObtIhHqGEFWTAfAH808K
	BapJOT/9/qzSJXPvpeIeOR8Ddh7CcZU1cm85EYRGsMdaxIkDIkY1Ctauvt2nzHDPpl2Rm296A8z
	H1oD7DA632IwJoqfwR2GneaylxmdazQQhPaNBw6rBPNXSQbDhKYrOuiI8WHXsG1D+5YLTrzuetw
	tKx0Oin+tDlUYC2qeidjxqBgO3GavKwUK6giwQYpY0tefhuQGfPe4nfKP8c7sD2fXqmdAIyoX4h
	cF9UIJA55jYPImDqXkC2ScIutyVsec1A6ZMKl9V5ufU7PvK7bbsCjlVg1GLbD6MaHrKDNoYYd+W
	prBWMwUIpWPAl0
X-Google-Smtp-Source: AGHT+IGyjl1uYB7yhGI73LLF9mWowSSRC1OuDHgqaDyb/L/S8qk8GDuzbJIQo9yz5FenT2fvM/Ygyg==
X-Received: by 2002:a17:903:1a85:b0:29e:e5e6:247c with SMTP id d9443c01a7336-2a2cab16390mr207386335ad.14.1766530449965;
        Tue, 23 Dec 2025 14:54:09 -0800 (PST)
Received: from [127.0.0.1] ([52.160.166.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d858sm138334395ad.57.2025.12.23.14.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 14:54:09 -0800 (PST)
Message-Id: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Dec 2025 22:54:06 +0000
Subject: [PATCH v2 0/2] status: show default branch comparison when tracking non-default branch
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

cc: Chris Torek chris.torek@gmail.com

Harald Nordgren (2):
  status: show comparison with upstream default branch
  Simplify default branch comparison logic

 remote.c                 |  83 +++++++++++++
 t/t6040-tracking-info.sh | 246 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+)


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v2
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v1:

 1:  c27a806dc9 ! 1:  a3800aed18 status: show default branch comparison when tracking non-default branch
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    status: show default branch comparison when tracking non-default branch
     +    status: show comparison with upstream default branch
      
     -    When a branch tracks a non-default remote branch (e.g.,
     -    origin/feature), git status now also displays how the branch
     -    compares to the default branch (origin/main or upstream/main).
     -    This helps users understand if their branch has drifted from the
     -    main development line even when it's in sync with its tracking
     -    branch.
     +    "git status" on a branch that follows a remote branch compares
     +    commits on the current branch and the remote-tracking branch it
     +    builds upon, to show "ahead" (i.e. you have built new history,
     +    while others are not touching it), "behind" (i.e. you haven't
     +    added any work since you were in-sync, while others have added
     +    their work on the branch), "diverged" (i.e. you have commits
     +    that you haven't pushed out, while others have added commits).
      
     -    The comparison is shown as a separate line after the tracking
     -    branch status:
     +    When you fork a branch 'feature' from the 'main' branch of the
     +    remote, but then create 'feature' branch at the remote and push
     +    there, while you still occasionally pull from or rebase onto
     +    their 'main', you'd also want to know how much you have diverged
     +    from 'main', in addition to how your 'feature' and their
     +    'feature' compares. Currently the comparison with 'main' is not
     +    given, making it hard to know when to start thinking about
     +    rebasing onto the upstream default branch.
     +
     +    Show two sets of comparison: one with the tracking branch (as
     +    before), and another with the upstream's default branch (what
     +    their HEAD points to, typically 'main' or 'master'). The latter
     +    comparison appears on a separate line after the tracking branch
     +    status, using the same format:
          - "Ahead of 'origin/main' by N commits" when purely ahead
          - "Behind 'origin/main' by N commits" when purely behind
          - "Diverged from 'origin/main' by N commits" when diverged
      
          Example output when tracking a feature branch:
     -
              On branch feature
              Your branch is ahead of 'origin/feature' by 2 commits.
                (use "git push" to publish your local commits)
      
              Ahead of 'origin/main' by 5 commits.
      
     -    The default branch is determined dynamically by checking:
     +    The upstream default branch is determined by checking symbolic refs:
          1. refs/remotes/upstream/HEAD (if upstream remote exists)
          2. refs/remotes/origin/HEAD (fallback)
      
          This works with any default branch name (main, master, develop,
          etc.) as long as the symbolic ref is configured. The comparison
          is also shown when the branch is up-to-date with its tracking
     -    branch but differs from the default branch.
     +    branch but differs from the upstream default branch.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
       }
       
     -+static const char *get_default_remote_ref(char **full_ref_out)
     ++static char *get_default_remote_ref(char **full_ref_out)
      +{
      +	int flag;
      +	const char *resolved;
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +static int is_default_remote_branch(const char *name)
      +{
      +	char *default_full = NULL;
     -+	const char *default_short;
     ++	char *default_short;
      +	int result = 0;
      +
      +	default_short = get_default_remote_ref(&default_full);
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +
      +	result = !strcmp(name, default_short);
      +
     ++	free(default_short);
      +	free(default_full);
      +	return result;
      +}
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +{
      +	int default_ours = 0, default_theirs = 0;
      +	char *default_full = NULL;
     -+	const char *default_short;
     ++	char *default_short;
      +
      +	default_short = get_default_remote_ref(&default_full);
      +	if (!default_short)
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +
      +	if (stat_branch_pair(branch_refname, default_full,
      +			     &default_ours, &default_theirs, abf) <= 0) {
     ++		free(default_short);
      +		free(default_full);
      +		return;
      +	}
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +			default_short, default_ours + default_theirs);
      +	}
      +
     ++	free(default_short);
      +	free(default_full);
      +}
      +
 -:  ---------- > 2:  417f2075fb Simplify default branch comparison logic

-- 
gitgitgadget

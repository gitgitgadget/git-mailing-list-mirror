Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47A3DE440
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270264; cv=none; b=abMuapvYhHTPR/Mu+9C8+1siGEUBMD5X3nWYXyob3cB4vApqdwpz+/JUw14PeXrnKDaF6ArZOeDGyWLbxQDNw41Tb4M1w5jHr2ItcHvmShkVSOibeHflUYITKuSvuf5/dhTHzTm85M0iordDNsSfk4b/5gbsQz/mcYhOSFZOm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270264; c=relaxed/simple;
	bh=vfYAxVEJRmaoZgqCRc9F1y1UmxSLTjB1mVj23JjYFgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rvqS64AdmUkIzfTbl/jrvWstVO6kXfbSuVShKXb27xE/VmAH74HSRc0dLE2amQFIZ4TvesHwymEd9ujCwtCyNGcPs8DnM+UE/QWlswVfpd1CpBWtiB9IMgT8jt4t95NPS1JgKWomu2fYOyD+OuX1FSynFwJhlEZD18VMG6+C6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi37YTVy; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi37YTVy"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-692205ca47eso1115444eaf.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270261; x=1776875061; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnBjX9uTUQlSV6WZG0MuXXPYMsJJzDfXb58wyFejMR0=;
        b=Yi37YTVyFyqBqg4vdPWz0S8b2y4o/0E2E+u417n6/G7rMIG4YSKL/JV1ahTddzKfHE
         0Ninxyz1lN43p0aAYQhJvBfRRjx0Drr3LtSMndHlC7vMdQGkZbWoODxUVLTAKcCbRHAb
         YYA1I8UKzYYQTXnREkT9pMZabSTvvZ1akMrE6b19pybGR3v8to79axb6Q7XgvlG/1fkK
         7HkL04bd4H0haSivYm+E9ENvDtwBNMHSkONlBzQ7qp9TkUFSyBbaI5GihdOBp44+ZdJH
         7bhidD+I7AuHFRHNLqUXs0F+6MZ/3KM0roLhoLkCe9PyjlFzFrOCdiRljFqvU3NpMAdV
         9E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270261; x=1776875061;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnBjX9uTUQlSV6WZG0MuXXPYMsJJzDfXb58wyFejMR0=;
        b=Bu01EgEPvY1zrlK0xigLOaYQrc2SzNn9pDAFMOXs7t9uefmnwwRbsruZVSGSR5gr9v
         FPK1d7NAoovFWcQzKKf+P1tPyuYd0rX2a31qtZtnl+sJQuDfQDzXYjfPPLJDOqoHHCPC
         BuOIuC3QSGL5a1N1zo7PcOzC8TkHnNU8iiFkag0LAq+H99Ee2E/06eB2JKrAnZSi+cvz
         7z3AXPUWYqiLx3zCMEh0bPULFQndi/I2PC8UMjghjbpWApi5zv1ld69MdXuvt11xhA6N
         3Zcjt3ogH6GTm/RaKXT8E7/lNHSRvUrYWFTcwyvCQF5/DPyBvRJlT/AspkVl3y7BXnxW
         ulvg==
X-Gm-Message-State: AOJu0YyVaZcAUaVKJtuznz6ClAWY+QaKeNrNGUMtI69QGIyBuiaSnggS
	Gj+vX5rKHq+Mai4DvaW1+AKuq2MAaeUdHIvTYRw8BJ1gLDCW3TJOQOKAZSpjqA==
X-Gm-Gg: AeBDieuFbz8W8pE9t3Jy1xt1i57jd8FZky8AwPYO4rNWWcv0uqOIETXO5J7HnZvhATd
	CMG17SZY9/OVo9cWjUkDdu+zjmWEEnlE9Svz4mryvrIXVSDiq6lqXZOJgzqSl70S45xIf/OI1MO
	WgJXc5eV44eeUER6IdC6iRuZP8StyQ6ywzDpWjYbckNY0osKaAJo7SchAOyppvBF/hgXAqyKyy9
	nG9EHwr2HsGJDTstmSynda3FF54akHWWBhIQz4PgkLUrHllhnagQzeKu6+Y8FeN/gqCxXCTAwae
	xat8BvYn+2SFuM3kKepLPlXhDK3XYMmcwQOQ1ypvw3eXPM6P50rDFjNK7kynCk6U0X1P30+bw6G
	R/twx1ZNl8BTxlkuokm2uLIeixUnMDNnBXQBBnhAdhZqMbeql6/bE8gFDwvJ6h3Z5tPaO5hpy0T
	nbgt7e7kQzhcEaUBHUb2Jtwr2S
X-Received: by 2002:a05:6820:81f:b0:68e:4bf4:f826 with SMTP id 006d021491bc7-68e4bf4f9e0mr8996638eaf.17.1776270261287;
        Wed, 15 Apr 2026 09:24:21 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.53])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42666bcbedbsm1678725fac.5.2026.04.15.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:24:20 -0700 (PDT)
Message-Id: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 16:24:14 +0000
Subject: [PATCH v14 0/5] checkout: 'autostash' for branch switching
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
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>

Simplifying the tests in t/t3903-stash.sh according to Phillip Wood's
comment. I believe everything sound be fixed now or responded to.

Also rebasing against upstream.

Harald Nordgren (5):
  stash: add --label-ours, --label-theirs, --label-base for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: rollback lock on early returns in merge_working_tree
  checkout -m: autostash when switching branches

 Documentation/git-checkout.adoc |  58 ++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  33 ++---
 builtin/checkout.c              | 149 +++++++++++------------
 builtin/commit.c                |   3 +-
 builtin/merge.c                 |  15 ++-
 builtin/stash.c                 |  28 +++--
 sequencer.c                     |  73 ++++++++---
 sequencer.h                     |   7 +-
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  24 ++++
 t/t7201-co.sh                   | 208 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 16 files changed, 483 insertions(+), 171 deletions(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v14
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v13:

 1:  43bfdf2136 ! 1:  e18c25599a stash: add --label-ours, --label-theirs, --label-base for apply
     @@ builtin/stash.c: static int branch_stash(int argc, const char **argv, const char
       
      
       ## t/t3903-stash.sh ##
     -@@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit conflicts' '
     - 	)
     +@@ t/t3903-stash.sh: setup_stash() {
     + 	git add other-file &&
     + 	test_tick &&
     + 	git commit -m initial &&
     ++	git tag initial &&
     + 	echo 2 >file &&
     + 	git add file &&
     + 	echo 3 >file &&
     +@@ t/t3903-stash.sh: test_expect_success 'stash.index=false overridden by --index' '
     + 	test_cmp expect file
       '
       
      +test_expect_success 'apply with custom conflict labels' '
     -+	test_when_finished "git reset --hard && git stash drop" &&
     -+	git reset --hard &&
     ++	git reset --hard initial &&
      +	test_commit label-base conflict-file base-content &&
      +	echo stashed >conflict-file &&
      +	git stash push -m "stashed" &&
     @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
      +'
      +
      +test_expect_success 'apply with empty conflict labels' '
     -+	test_when_finished "git reset --hard && git stash drop" &&
     -+	git reset --hard &&
     ++	git reset --hard initial &&
      +	test_commit empty-label-base conflict-file base-content &&
      +	echo stashed >conflict-file &&
      +	git stash push -m "stashed" &&
     @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
      +	test_grep "^>>>>>>>$" conflict-file
      +'
      +
     - test_expect_success 'stash create reports a locked index' '
     - 	test_when_finished "rm -rf repo" &&
     - 	git init repo &&
     + test_done
      
       ## xdiff/xmerge.c ##
      @@ xdiff/xmerge.c: static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 2:  7f3c32f5e9 = 2:  ce29b10264 sequencer: allow create_autostash to run silently
 3:  b279d1dac8 = 3:  73051d1762 sequencer: teach autostash apply to take optional conflict marker labels
 4:  04869314ec = 4:  191058d8e3 checkout: rollback lock on early returns in merge_working_tree
 5:  4b3c6025ac = 5:  86f33df1eb checkout -m: autostash when switching branches

-- 
gitgitgadget

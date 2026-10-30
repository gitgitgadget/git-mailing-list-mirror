Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370106;
	b=doiDDTWdVNWRfeBDRuLw2/9FfGaa+HycvDCNrRU5qTD1//FBYvW9rULcDDD5knXYqWWw
	 hCnQS82V3kZxFvQ+HCOYzmjXgDCsjISYA1yElYQBUYT0hhg85oA8jxz0mdO9muTuAOpQH
	 u6sFvg4syTEfX5AlhaIoVfloyg6rdQr7rpuYxHTie11cUQHLWEYBWZeLl1nykeL55oiUL
	 78vHrt378fZs0qhXG5Rf0v0Gh/2qwpdhwcbyOGYzxNo25tL0Fvr5Nx77Tvr2Lrhef6e15
	 /xz029jwiS+wD720Mxds/9P5bOWYqG+tSJYjb0I4zBVls1c5/yo9RhlUmJ085DVNWUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hbpmfk8abWcdxNuHBRgG588T8FYx9ShDlOS6vJNmcjA=;
	b=pkwB78iOYLZH2f5HKnPxfkHuEytUtsVhNeWz5I10EvaFftRlvi3IZVOyeeBuZLSEi9KL
	 p8OszjLxR2rmBEPMLRY6DZyEtp8bZhT0QFVsnBmvGwzTailyUEpEfkjPj2EqGxuxAWSWl
	 mjQO/El6ZaFXStvcpgimZEkY2hzbrXAE8Fug8QCMLgRqIiGPorW60mU9jTlgymEZg+qC2
	 tetskdCRrHVFLvlb4FXu8/xRVrOGYRkEJ3qE1aj/t0oKXzmZLHDMJyBWB2579hgW5FDjr
	 DcYk8APKYDFQZ5WVON0vxi+b3TLzsuAMtwCs2ogbF591+s6CJHrmZ8I9V0w7tj/WanA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=WVrVsAGr;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E511606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 14:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E511606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=WVrVsAGr
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f2493c28bso67867985a.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793370104; x=1793974904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hbpmfk8abWcdxNuHBRgG588T8FYx9ShDlOS6vJNmcjA=;
        b=WVrVsAGrQNJGhmjbWXr9dzdDGUBe3J+I5UZ6myUTvWA6PT07EeNCMX3U+wSizt0VOy
         gw+0PfV2TrpaPrh5WGf55Bo55UNMFIZSZNWJFjGUbfrKdiwxNZeptoEec3RhO37Vwpeo
         4jo4Xwb2135hL2j9NBdSPrgbKpqNZz95pJ81RwN9wWVb8x0FOM5JyD37lB2Eau1jOXuQ
         xI0YGKAyZbkrAGQqrHCV+HWawgz9CtGcOJ5zPa9QYteM1O4S5/n/dUazIZzpeVyYV0n9
         6Upj5OjBWTvhn2OPmPmDPY5LAmSF117QBiu3IMdna+RQZIqjJiuzwE0suU2hGoCu74Cf
         I/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370104; x=1793974904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hbpmfk8abWcdxNuHBRgG588T8FYx9ShDlOS6vJNmcjA=;
        b=d5Q+kLOkIVLUjG+KYWi1UgGuSix3Yqv8HqKsABJQIlAPK4MTtktHao4QYnBSpvb3e4
         SceI15Fw40CJden1s2Im/z9/8nrJyXiceQkPpO8uynj6dl0DIggIzqYvy6pxV2U1BLYz
         JjR9q+6C0fQDQHEdX5uQ93J396XNj7xtCbM/4Mo5QBGA0jX+1bt7spZ+bVsbZgmEfwZ3
         ZliUEzKf9OnJqeH/NYhImTkhHB5/mXjBcsvwqt8MDHVu/SWrxxDwlrE7NS+OipDkK9my
         EERf65nbnCYHEhRkOyerHBPUOiPX81lLHOhxTw7EjDKS8oOsCO0xXNcvXlBAjhWaKGCq
         gPAg==
X-Gm-Message-State: AFq9FYJoyhD2rKFxAC48iTe5+jSQuBIp30LhUZj81KFUKHxGaqFmus9G
	B8j+kW6vyw5MuTz2C61UrIsGUo0PAz+3M9LhTgPy8U2t3wrQHgigEyaWhvApNvS9dj4JTPfHznz
	dwCjZn4GF4tw7tarq3zlAmxL/DQ60AY97m1wSi8EXETz0Z8OcSne3WI1HMxHsG0/yxo99pJz2IB
	HI12JwXXrCkFQ/POawd0VRd5Qle9a6An7Ywf0fe9+7jv7MDYoc+hEwnL11mUHnBokrOC13U3/bm
	j0yS7/XmWLf5tPuIb7EVyicsHXIAlVUFOHWHE3+xL8=
X-Gm-Gg: AYBFou2Tb/sNgKb2uju64gHX+xNrMToSGUnQXj/v/9mA1rW8wbARblxaAyLAD745isf
	rp57wrhPDLXgKU1n9dp2pi+yS9/1WVA3OvitXg3n0cUrpiAHPDa+bE6L9ekd+k4h3hB3t2U5udN
	zKPHvP3Fz+X/WAF23JOlogibfp1uqMInQPxSEb0RNMaFrrLeFjJexrbT+zA9a3a7zf+Wv+9bVu3
	nU/a0y3VENQSvEtDj15t4L3uwDC0YvxYik9/36/flnBm8JPdT2oXKpKki72vqEyGK/JBMRZtLuR
	+gabWjmXLTcQ27//k5kKU+zoCM2Kp/HaYbsybJAFCmOT5G9ZOcI41TqKt73b9/YPK3hXF76iHaJ
	/puaCqj+bT0aXIf2Mka6644PgEzJckPcH9tKPETBh6HNto+lVdYjH+HUiOn3EmHA+ZbrvXy/pyv
	mjbJ50n/Uyc8RVNLXN/2E/lAOc3Sk8k27QvoDLHKhUcuROHJfzNNNZrliQzqg9gSi0WVl3GL7ti
	d+60WWGfmRFUmbGWD1V4Ud+0kC9cZmkYlUnMneaIq8Rq9WAdU0NhPE8wJbR7RdHqo0F3dVBl5Qm
	EjR61GnUgA/XAf3kCNne9f4KGJ8VPze6dGu7Neh3J5CoTbJRXz5sijuDCtpL6gbyG6FkroxbnUe
	Js6L37k7BUHugrgWVwmjevB4xYlGxtVhKvPOcysDX3WdzbWKcLILCObEuzpZptxIygMJQykjMIF
	W9HL9Fln0yg37zY2Rnqz34SRJU5AKp86oZYSW+ogfMpJiLfXP3YZraSNV+3Jz4s7e73V4a8c9zV
	SQKNyDg/M/ueQb2jnbh9cItRIuWKNYxfB0wOrAWj+y5pWhAdZaB
X-Received: by 2002:a05:620a:618b:b0:93a:2e8:5aff with SMTP id af79cd13be357-94421719dbcmr396117885a.21.1793370103956;
        Fri, 30 Oct 2026 07:21:43 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm153831485a.1.2026.10.30.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:21:43 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH 0/2] worktree: treat a branch being rebased or bisected as checked out
Date: Fri, 30 Oct 2026 10:21:35 -0400
Message-ID: <20261030142137.54750-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024165311.57387-1-me@jaspermayone.com>
References: <20261024165311.57387-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces my "git worktree list --branch" patch [1]. In that
thread Kristoffer pointed out that "git for-each-ref --merged <commit>
--format='%(worktreepath)' refs/heads/" already finds the worktrees of
merged branches, so a new option is not needed. What is missing is
that %(worktreepath) ignores a branch while a worktree is rebasing or
bisecting it, although "git worktree add" and "git branch -d" already
treat that branch as checked out. Phillip agreed that this is a bug.

Ben then asked what happens if such a worktree is passed to "git
worktree remove". Today it is removed, and the rebase or bisect state
is lost with it, if the files happen to be clean. Phillip called that
a bug too, and more likely to be hit once %(worktreepath) reports
these worktrees, so it is fixed first.

 1/2 makes "git worktree remove" refuse a worktree in the middle of a
     rebase, "git am", bisect, or cherry-pick or revert sequence,
     unless --force is given.

 2/2 makes %(worktreepath), and so the "+" marker of "git branch",
     name the worktree that is rebasing or bisecting a branch, as
     prepare_checked_out_branches() in branch.c does. Branches that
     "rebase --update-refs" will move are not included.

Two things reviewers may want to decide differently:

 * In the worktree that is doing the rebase, "git branch" now shows
   both "* (no branch, rebasing topic)" and "+ topic". I documented
   that rather than special-case the current worktree in the format
   that "git branch" builds, because %(worktreepath) itself should not
   depend on where it is run. If you would rather hide the "+" there,
   I can do that in "git branch" instead.

 * A merge stopped with --no-commit is not checked by 1/2. Its staged
   changes already make "git status" report the worktree as unclean in
   the common case.

[1] https://lore.kernel.org/git/20261024165311.57387-1-me@jaspermayone.com/

Jasper Mayone (2):
  worktree remove: refuse a worktree in the middle of a rebase or bisect
  ref-filter: name the worktree of a branch being rebased or bisected

 Documentation/git-branch.adoc       |  5 ++-
 Documentation/git-for-each-ref.adoc |  4 +-
 Documentation/git-worktree.adoc     | 11 +++--
 builtin/worktree.c                  | 31 +++++++++++++-
 ref-filter.c                        | 60 +++++++++++++++++++++------
 t/t2403-worktree-move.sh            | 59 +++++++++++++++++++++++++++
 t/t3203-branch-output.sh            | 35 ++++++++++++++++
 t/t6302-for-each-ref-filter.sh      | 63 +++++++++++++++++++++++++++++
 8 files changed, 249 insertions(+), 19 deletions(-)


base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
-- 
2.56.0


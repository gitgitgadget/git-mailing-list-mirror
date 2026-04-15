Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCC271464
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776297486; cv=none; b=O2sxZoLu03P5AShOZbLaeQsH70BVaDwrPpsQgVotrL8qh/KIOq3sGgQPgArUh4/9/wsilv8GolwVGAtN8k7gn/iaFK0S8SO/lV1qemuWOi9+dCDjHZq8Rg4THOuFevp9ozPp5JDsmykSLJl3Zo1q2al6RJhmUhLhri+6kUmec6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776297486; c=relaxed/simple;
	bh=fNh2WWhZ5IvKZjI0S7icLHv7E8RR9Rd9TZsYBJuSGmc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VITHl8oInllNfTATSeAKFXG7o4hp0QTSvZ816koEa1+uOnqjhZkVllPpLbtVI/Xw5gx/qcAotk1vvc0mzxYVtnPQO9PMdkusNin5xC6TA9ELYtC65HTEkFWJs+1h2N9YSACg9htRygRf3hpSMJHu+46ttgfZck9AvoTsxwbEcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk/AV4yV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk/AV4yV"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d4f78fc9f6so889548885a.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776297483; x=1776902283; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SaYRfmDX4O+jPf+A4zOLGnnePxPG1vNb7YWqMtE2Moo=;
        b=bk/AV4yVQd+5oycT/FTg+FyUGnaquW6afgagJrT2gQt2KwgB9kHDrOVNXxnfoTaEzj
         ouAfi16solVqrzlvBF/E8Jm+FaXHxbxgCghXVF7O6oOFx7K2ZuqoYsOZKhw1OB8daQRP
         677oPt6Trtt8H6ONrOwa5eTDWJrhLbbCFKBsOOKcOKlavU77ir+7LFN+UVOjhn6aYqO9
         vU5LE4dyvXvj+bR1PGtw7AcMz4mwqx8uElPGw3kg019NQocWZWwEpYQXZO+9eO3pu6OJ
         x3naTkSrEtTfBz661/GPPrr0RFdeTyyLy5FFiqY6f4TfNh8YTWKNuoEeGMker4hTvCUf
         mq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776297483; x=1776902283;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaYRfmDX4O+jPf+A4zOLGnnePxPG1vNb7YWqMtE2Moo=;
        b=Tvrt0+EOJoDb/v55OF8Jlx9Aw4tX7mBrEI+bAsaGPHYnL1fLqU1GnAvv7W/1mIVGHp
         lWiHb2W534vFEPMyYRFncZivPNSVY4OacPPrvWJ4j9LUGVOk8yKHLrWLehclF3GebTE+
         tPOuENAazYZgr1QRWj/f5rNH70MHQZsoPZbfpz1sk1a9r7HaCBck671ZhAOue57aWoZk
         SdL/luK+KjXe8+BVYK/tryObjzDf+iT5pkHrjDkn6WVWESoF/dZYY13ObQB1kk9+pcDv
         n0VZbxOTeNTTGMCRVGyzTof3JTbP4M1HKeEyUthqIXVodcaAKHCDEQKy5wXX3gjCNBDx
         2VNA==
X-Gm-Message-State: AOJu0YwXYW7RW4SgC21iHQFfVwrTkisvzMNDlJQubE3GTaLpC4Xlkf/L
	o0QUbLg+xhQqv83FQBJhZHIHMHOr9dA+DHs9B7QR9ZeHCtQoI2LdDe5hsoyikw==
X-Gm-Gg: AeBDievs9U0u1NICITWpaXas6OoSP50SVZ9NNnC+yoOU/1/YkwJCHksX7SMhTj3F7M2
	/Loyxd/nTGcKiwIzN25zWxZL3MTEekU24ay9fNgPLqktcd+tuR3477TvEyB8JIsH1MvF+5jXGC6
	r1jVEIVWlSOSfnA2d5UFqpiAMeDpYNSXfeRG6RhaKXWBEQB2dNchJELAzE7EIyejbXVXYVqOPZ3
	n8DqI866d+vz2ZY7e1kDzuWFs6oQNTpB1L9egpSbFlf4GvVJMD10//2zjmcqVr9SWRhpPYe4epa
	lyM/sIHyGpQYOoVKu56WLxRwcOSWuGAqIqGm4YIl7IRVhgofkTpe7spyU/9VO9RX5oKtf1FcM4M
	uIjJp2Ux+GZhU7fw3FavCDTb+J6vsDta3EWYrB7JcW27zkDPY2NDKwQ3qg3BRNIEJumtNgDYxJP
	CcmUpHc8G6iLWOtqe1cx2QBLTaN2g=
X-Received: by 2002:a05:620a:2411:10b0:8e6:4050:3626 with SMTP id af79cd13be357-8e640504036mr30359785a.49.1776297483417;
        Wed, 15 Apr 2026 16:58:03 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2d037e7sm235764285a.35.2026.04.15.16.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:58:02 -0700 (PDT)
Message-Id: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 23:57:59 +0000
Subject: [PATCH 0/3] Backfill fixes and edges
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>

This topic fixes a few minor issues in git backfill (from ds/backfill-revs
this cycle), although some might see the third patch as more feature than
fix, and the first two patches are pretty minor and probably do not merit
consideration before the release this late in the cycle.

Overview:

 * Patch 1: As a wise man once said, "Sending arbitrary command-line
   arguments to setup_revisions() creates an opportunity for behavior you
   are not expecting. For instance, can users...supply --first-parent? What
   happens if they add an --author filter?" ;-) I think these particular
   cases might work, but other rev-list options don't make sense, so let's
   error on ones that don't.
 * Patch 2: Making documentation more consistent with other commands
 * Patch 3: Tweak the ranges so we actually prevent on-demand blob
   downloading better with a new --[no-]include-edges flag.

Elijah Newren (3):
  backfill: reject rev-list arguments that do not make sense
  backfill: document acceptance of revision-range in more standard
    manner
  backfill: default to grabbing edge blobs too

 Documentation/git-backfill.adoc |  22 ++++++-
 builtin/backfill.c              |  31 ++++++++-
 t/t5620-backfill.sh             | 110 ++++++++++++++++++++++++++++++--
 3 files changed, 153 insertions(+), 10 deletions(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2088%2Fnewren%2Fbackfill-fixes-and-edges-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2088/newren/backfill-fixes-and-edges-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2088
-- 
gitgitgadget

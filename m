Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B723B1EE2
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707155; cv=none; b=Tqh6GQbvVkcK21rntR0FEUf4LIhvEIhpqfymQnL3QTCLBAiBEmwv+bxCa/YVa7xpd/b5YGN/+hs42Rk7pQpiojjFBGjuHb7omeoVoJ5DS6soUsBGYW5kLznlEX1znnm9GD1hS8gOjN0DPTR8q4+4KvI5cu/kOlq6a36d2OIOqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707155; c=relaxed/simple;
	bh=5l9fni4eWntDwBQQKos+7yGh1XzNJDUg6XYjUJDAVaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=djWHlC8jSEJ7Epbl1khYf12GXXbVBzjmuJ4S2Oo21hTP2EKyLckpKI4zTJoUIxRpwhJSVejiVofDWYAoQFkBJMTBPC/xvjiihSj4TNE4HzNAXFgC0w43XXnw1Hy3P6H6ufn41V80U0VFKLWLwcYW+BvAHJJxuUZhPkgsBGHGCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipi6nENu; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipi6nENu"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f33ae12f97so2426982eec.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707148; x=1779311948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=Ipi6nENu2RpSaz0NDHOvNZaEgoC3Cnqa7RxEBvGGOmoH29mj04uBxliVGB0gk20vzq
         HxbQDhsqHFt5U0rBgJY/jqxZnNTKhlZxbfknqVSGl961VZZzWg29cFs/rhC6yaSKS2Z5
         yXBFFAla1EBdgyamWg6IdftcTBrnAGQoFgVzJ1rR5pZR1KqZM1PvLVmuxiT3tEhzOzeE
         PUL0llVpReprGCmmE9Ys7pgdYlySHON9QwygSyJKLdlPDoEdM6vDx2nXjK51oLzvkevD
         tSc2P2UfBA/g8QGYaOSNiNEv2yeMzn8ZkNZgB5cqpBieKPGGflDDPUNRbApaMhZjPTyw
         gMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707148; x=1779311948;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=FCS+SoXynH3eroLr+f5zyygCat139f5+r9A3pWxpMzkdO//8QSMNi5X8A4eRm0+bMD
         ieHhhOrj86v68l/CdNVKFtMpbdnxW2qKqGFhsbaVU3XkHKG96xDD1Tn2If6E/rgDtoZd
         WG6JSiQ2dQDfQwkbzh/0jV8IC6MFAu/KbsJL9UPWLQfJxuTcGDg/iHb+bQLwBqe7qVlY
         jSuEGRoDH5uIbSqGUVbagTrFjjlfrSb2s6omye69yR7r3LYoUpi9mkdx0xgr+dMXG6Qy
         8C95yqBZi5IZNk99iB3RQEKluolPmomeJBHpZzO9qpCaecTSSfltS+dDVgDd5C/Bf4/z
         icdw==
X-Gm-Message-State: AOJu0YwkJo7PIgJyKxPP0lLaM1H0GTrPgXLZjYjPUQeVPtaPA8p6UH0L
	YwCXe2wErgURhYn9CozqbP93s8ouLWmrCWjC4yICT0s5+OWWZPfhSehQuwAN0utc
X-Gm-Gg: Acq92OEyyQ7PLXkjnFwZB7tVuUexRChaAKKQQPykEYuOfM+WBR4sucXs1z3TymSAzA5
	QN2MJ00RQlwoKCkRiU7XiG69yzW6BBy3QnjmiHWgsj5jVTig12vN86RM/NEljCFGrpJFL9nalu9
	PrFOyOTA1DqIrzHt1G5EaWNJguQjknj/ndPRvZTRrAq/46Z3e+FF0mYnH54JGseRqdcnz11sak4
	rza9YSlejWQrPvXyt32marhBPeeeOFIs0BWGRuxafk9xo/1osQZFso78d/YiNhkWFpwHzJOHskv
	p7Al8c6j0Yy3CyjjxLBxTJjFu2Kpxq1sbNdC9tXFXhlYSYycaoPOZeAknnzc1jEKKzt2JGYfO37
	HM0/UUlKKVmE9pDna385iFfJwYhxo1iByOkxK0HNu6LP6iuuyVbUxNlGVxuEXXEN4B8dzy4e1wJ
	Q5jCHlfY1GnaHw94nRQlEFMISOJcGEheRz7MmG
X-Received: by 2002:a05:7300:e105:b0:2f2:6dde:df67 with SMTP id 5a478bee46e88-30118e9ff09mr3224613eec.22.1778707148459;
        Wed, 13 May 2026 14:19:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6e9sm600691eec.16.2026.05.13.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:07 -0700 (PDT)
Message-Id: <f37467e46f3c23b90fc5c772ae24164aafab58c5.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:48 +0000
Subject: [PATCH v4 06/13] backfill: die on incompatible filter options
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git backfill' command uses the path-walk API in a critical way: it
uses the objects output from the command to find the batches of missing
objects that should be requested from the server. Unlike 'git
pack-objects', we cannot fall back to another mechanism.

The previous change added the path_walk_filter_compatible() method that
we can reuse here. Use it during argument validation in cmd_backfill().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c  | 5 ++---
 t/t5620-backfill.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 7ffab2ea74..b80f9ebe69 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -96,9 +96,8 @@ static void reject_unsupported_rev_list_options(struct rev_info *revs)
 	if (revs->explicit_diff_merges)
 		die(_("'%s' cannot be used with 'git backfill'"),
 		    "--diff-merges");
-	if (revs->filter.choice)
-		die(_("'%s' cannot be used with 'git backfill'"),
-		    "--filter");
+	if (!path_walk_filter_compatible(&revs->filter))
+		die(_("cannot backfill with these filter options"));
 }
 
 static int do_backfill(struct backfill_context *ctx)
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 94f35ce190..ede89f8c33 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -15,6 +15,14 @@ test_expect_success 'backfill rejects unexpected arguments' '
 	test_grep "unrecognized argument: --unexpected-arg" err
 '
 
+test_expect_success 'backfill rejects incompatible filter options' '
+	test_must_fail git backfill --objects --filter=tree:1 2>err &&
+	test_grep "cannot backfill with these filter options" err &&
+
+	test_must_fail git backfill --objects --filter=blob:limit=10m 2>err &&
+	test_grep "cannot backfill with these filter options" err
+'
+
 # We create objects in the 'src' repo.
 test_expect_success 'setup repo for object creation' '
 	echo "{print \$1}" >print_1.awk &&
-- 
gitgitgadget


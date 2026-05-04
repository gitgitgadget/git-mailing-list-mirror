Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B203A6B82
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926089; cv=none; b=PLN2+3dxqPmHbT9I1PyjA+r8xcBNRUSIVBUsYl4keGCNdOOFFFDW4Jb6SpgVsRHNOlWw2f8m1EUWRVWKK45KVYhLgeaUvsZIW2Q8yU5UU88cSwphDSoY5uNFff2g6/tqB5SEfnGOsg7dd9+oqeK8nudssQH8a7zjL4hUxtcuC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926089; c=relaxed/simple;
	bh=5l9fni4eWntDwBQQKos+7yGh1XzNJDUg6XYjUJDAVaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o8brngflnThThfH2kKHGBktyvpy9sNEty0ctqVajjVLQk3Jy/GLD3XJciOCyMV4ozIOIfv3Mhzvuyj4IhtnVilZMCMyS0G9P1dPZa1s95NMooq7Dpp1VG2GDGJnpo90wVcpSnTCNTQeCzbZMN4GuMtqAefdeqc4Vz+YeHSKWSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeYzL53A; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeYzL53A"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d87610513so46105751cf.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926087; x=1778530887; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=UeYzL53AKbi3MiQwHerIyxp+02MDcCakqjeMtcqU+kQeYX4N5wOvsnD25bcvSLkuPI
         KHDsHql5u1eyUKA282Ixx3Vliqja5biRIHRmGHvW7QZWCcsPfluRcTXNf/gCfASRo00d
         9QUjvbHPvfUqh2q9CR2Otn4AUFVDfA55fATttJNN5Kus6dmpV3osMBGylOGNNnvc078V
         L9QUIC/+maYupp4Ns0yxQ5npLckTK1kCnlVMV2EAkKi1P3JFLMkBcM8sno/aeDZhCm9L
         s29HLUn3yL5egddY/VKqiOS4f8IE6sHmLCNtwBFEj6RE8USChn3cwqo3WYz/gxJIx/O8
         jyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926087; x=1778530887;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=eARZZvrdQbnD5N3lkKzBTfLNddxgOJg1YuVKCErQPXdhKz5xGipnoKYIAEO0YtIoYl
         eGWp1bgSiqxy+7m+aBlm3GjywRznShiUixTstDrugzTO/0hbUxRhS7hOMC7zNxnynx6w
         cMzW+rVaMSCIs+gJ08woDwsgU+nVHr2z+Kybwl5/zaGw7FVcxsyOYoBBVwIEssyxCcVg
         Xm+8IoGKu8jFk+Vt3XUSYGQ7cF+GmIDqvJ/bQkgCQnXMXyPIuCHOapdLikr4FhTu5GXW
         gvNFQDKVt36Zw4PQt3B74eAhNeKj9DSmh5A2IiiDvFeQWsFH/798SI2F6XhUkn2NXww0
         wWeg==
X-Gm-Message-State: AOJu0YxxzKkX7KOpTiMKQGmnLbIdVvCB/eB33Cdz8ZWMKmZ6B97Rh/be
	6WuX08886AN9vr6NMWMSXVFewp1MAQJDS0Lto39syZlCME79XHerCVb4x2dn8w==
X-Gm-Gg: AeBDiesLOQEW9CF3458k/DJp+uMaK7PdI7voLcPmNai1oJ+kh7lBdAhhr9jTbWUB44M
	1YtQsEZYW+/Pw9S8q/I7OaGhK0ACO7wfx9aGJd4qmyZta+scuQTR0TEXnhepZbiQCqYj19VhQb/
	Fm8Oi26+6oUhxCcpy7Irr46uPX2xdH43hKDLa60NYwprX3RNrOkA0yMVw7SbZW4sj+/KjxltI2U
	s1nDY8uwCKuiXXFylCRuQny4n6Y+sZzB1Cyc8kC8kC5T0tKLSPCPeI/nMY3NVw3defWYmYej+p7
	VVBCgtFP+5qM1TUqrTaKR9fBQDLL2Pnv5OiihXxBZueX5xbDagKHk4057uz9WIWd2e8dUBTICyR
	2V2A8jGVoSbP/e55tqCxoKlOCFE+1ZhAp9phjrqCdzfOI9DMq252daEPfPbBY1Kq+QUIRMHOolc
	7W0tu60+V3F2ODR631Z3kB+5cWO8iztHY01p1V
X-Received: by 2002:ac8:58cc:0:b0:50d:7b0c:35e7 with SMTP id d75a77b69052e-5104bfec394mr170460461cf.43.1777926086540;
        Mon, 04 May 2026 13:21:26 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b35795sm105946741cf.16.2026.05.04.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:25 -0700 (PDT)
Message-Id: <da4c19af42ccdf550b52a247aa688d20393b983a.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:13 +0000
Subject: [PATCH v2 04/10] backfill: die on incompatible filter options
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


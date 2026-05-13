Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D283B635B
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707144; cv=none; b=Pf9vYkgYX9/9/kj/ffSxqAUtBINKbJd3+j9VAxjOsQhawA/7Z1YxDCcTbS6KQzoQDN7Sj/cnh9pmZdu+7phf0V3oqC7PzG3mf8LNUflEBk2gHdIhJS87MEdl4iucAS4jzjXVKCMmrZuqZfcNm8IYiVYivqD9PGzn/Jqfg2/ruwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707144; c=relaxed/simple;
	bh=k2jn3vB5Xll/veRaFYtx8C4+E+Gj61KHTMo/G4UgHQ8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CcqxkySjM3LmgHBB/nPSxzNev8Hx5G2GsjBOtfKnN2hfADxOfBw0RBp0PyfmYqSVLGRuGsYOOHC71tvepcMoR/vJBGVZO1msupF8c8Ad0hwy4xQw4TK7N80A9NWYqQkdPAHdFHzcKyWEadGzYJ2ZzbAgvs2CkxZ/sfY/K2lx+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDymoKS1; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDymoKS1"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso891974eec.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707141; x=1779311941; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82S4mAKNn61wva6ccRQ9bbVnCM3dFkd7+cRosGlVjn0=;
        b=fDymoKS1zn9/B8/ZcFQf1w8InKHKBaV9wwBkXF6tt8UXlKJv0DBU/e4AgCOHOH88ad
         lN02MGpelKhp6xOUdElbxCmpGoYc2El6YM7l/cmpDQvOqk3Wyegi5CwyWB1iFFh/qVGC
         CFM6VGHkGphMxwKF7jIgpCecYh5n+qxvRNlj6EC/xBoH/WMOnb4SE38dN+Enf4evHkbB
         WDTHKetNoL0JyP4dq3OZsoR5oOsOptB3Pqhue1GNfhynxZSZjiUS4C2H2M3kCPJa2CYz
         eGjwAZX4XTjF5y/8xegb2PWVgPGzhI6WbzNVYE9s+lj2uJD4o9Od/DgLH0YpiOj169zl
         IZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707141; x=1779311941;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=82S4mAKNn61wva6ccRQ9bbVnCM3dFkd7+cRosGlVjn0=;
        b=rOHfJZcxr464hwaHPiQCeGWxVMznqBvx/zMOYjOT3f2y+kkwwY7nXrxic1J6Lqgcv2
         SQVTQU/Tne3wV5bNBaNn8XkZmwLI034marUmPt9zpTrmLaQYx9XSYIaWnQRcQzUdeb1W
         QQjq4YAdzq8cxMj4Xo9rIY6/Go4OfuADH5jq0TzBd+fSAcJnb9Fz75o5WSwmzv+OpLRy
         n+5MOTzanyIgL5XDyho87tmCEAQz3XLZXDIb3+mLw5Ug7CC4C17crCHcD989507CCYv+
         p90l0ZERIpZw5JmonWlEYvMNTRtmdSsliaqypF1GFEkruGm3aopXUuF/xZjLBK+zVprb
         CnFA==
X-Gm-Message-State: AOJu0YxtJKYh9L6gV/3sfnYsivQs2ysxprDDyPuRJqQlzxLH5xdcEvBO
	ef46Z6FjLj0y+efGJeSuFXVP9ORU1nkXwK8qDjIvCIOrPnNh97hqDfcput9q3sIY
X-Gm-Gg: Acq92OHNfmvIL0ytp3XAhcBWDgtLhZUAR0zWzHbKHm9cSB1UmVuQDbSEB1tDSU40hsY
	nVuNlq02dQ9n5UPbRIy10Tq2I4bdm3F/TqZBO8XPI5BOZHdNDq8pRzxxHPv5aTxIrdHdZv4bB6n
	Se2rVS00zhV+u1nGqvQeCoLPUTlUST3kxNHOZNJZ1zaqqFJbFlMx9u5dig8NW4bTJIq3kBz8s8k
	9o3ejQ9MApISqGGla550RWMQ7zUBZ2oL5SOOST5BcE8zEc2Z4kgNAYziVwJjs/KaHRPpYLN5qIv
	nJnwjC0tuALn49Fj8dMnYQ24boObUEDx3JYufsRHUuFzATx136fjPMYuBeG2s9ejCMTMN7DXN/M
	/F61BlAqIO+GwOgLRL2kmZWyQkwOFN54LDCU0bEfx2RwJhNjkx40LhG1Ox96XZgIY/l/zuE7t2G
	g/2T23ggdMqdNE2u5Rw/zTSPqcLw==
X-Received: by 2002:a05:7300:5708:b0:2df:7b88:a1b0 with SMTP id 5a478bee46e88-3011a66a2b1mr3078599eec.27.1778707141367;
        Wed, 13 May 2026 14:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6c3sm651696eec.19.2026.05.13.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:00 -0700 (PDT)
Message-Id: <d7c87545f38a2457031bb2e75a51b464a1525ed6.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:44 +0000
Subject: [PATCH v4 02/13] pack-objects: pass --objects with --path-walk
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

When 'git pack-objects' has the --path-walk option enabled, it uses a
different set of revision walk parameters than normal. For one,
--objects was previously assumed by the path-walk API and could be
omitted. We also needed --boundary to allow discovering UNINTERESTING
objects to use as delta bases.

We will be updating the path-walk API soon to work with some filter
options. However, the revision machinery will trigger a fatal error:

  fatal: object filtering requires --objects

The fix is easy: add the --objects option as an argument. This has no
effect on the path-walk API but does simplify the revision option
parsing for the objects filter.

We can remove the comment about "removing" the options because they were
never removed and instead not added. We still need to disable using
bitmaps.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a73d..4338962904 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5190,10 +5190,7 @@ int cmd_pack_objects(int argc,
 	}
 	if (path_walk) {
 		strvec_push(&rp, "--boundary");
-		 /*
-		  * We must disable the bitmaps because we are removing
-		  * the --objects / --objects-edge[-aggressive] options.
-		  */
+		strvec_push(&rp, "--objects");
 		use_bitmap_index = 0;
 	} else if (thin) {
 		use_internal_rev_list = 1;
-- 
gitgitgadget


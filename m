Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EC36921B
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168175; cv=none; b=dDKPsnouT7h9mRf8E+hXSEVzDPzbe1WjirABQGwGzyrP/TP6b+7TxU91i74cM4T/inAkHXL/lbNxA0gUgvR2LMZbIm3m8Ne14Upm+hJKdO9YgYieFlj/xok5lCjzFFk2RwRYm9wQiihiJmMkkynkPSxqqOHE6nZTpuFoEr1Jju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168175; c=relaxed/simple;
	bh=Eq9o0B9i8oLUB12ukA2Fk3dSix2+qaL8Svlw138ppl4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uJfTdKp9cJ4IIm6VOpt3mY/ZuncMlst1bLP83Ukd4EGnDlYLagDbn3dBQVV39GL53kv422qiCmkuPOtC7puGSC47cCrur78hWSvbLB0YTFJg2ABNVSP1WCaP1kLcEtwIpOgar0RsHQDUTblBmo0+yq0BHVqjfQf8NfTlRo28C8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY2Remvt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY2Remvt"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7e2762ad850so2249315b3a.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766168173; x=1766772973; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+2Zs7JUdTtf5V9erL/jv0POHCOkENXLcBhRduisJFA=;
        b=SY2RemvtxAvzqXAf57utERU29ZNNyc1yhKQi7KGNLus5JgXjSADz5IxgKShNd7PYdk
         ge6Y8lt13AMVsLVXnRKDD9D4/4Atw+Qsfdvf81kU6Y7tCq6MpqsVGnIXJ3Svc97h2O1A
         oh8gUe44ogsnl0JIi5yYHIhTtHUZA6tpD7zfalSNl/4HBhNDJU7nvramclPHuzJYdUxL
         UBzDGOHPFw5cJKY6r2jo65r5zxeA4tAV+xaeM/Hs6Fhh1Qk/w5ZIcYu8F1p+5basDiyr
         EevJ1sG+3iLuUthDCrFvCmlgIpfn1GFt1AVAHOv7dS0j6rgJitpctWP9WD2vwDFklNu4
         6NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766168173; x=1766772973;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+2Zs7JUdTtf5V9erL/jv0POHCOkENXLcBhRduisJFA=;
        b=bp8efgiKmQuGNAfFxTZ1nmXw4IJ/msgNmUflO60UpGQ2zL4cR7WsVv4CnlY7XeCz8P
         J6UrZXs6oUclbVefk4lloQlnQg8xL/LPqw8bqwDvlH4oQcCBVLCQ7Ozl9EyLn8Yw98E5
         5Br+0KPCFgx52KA8RgvYY6DKcrAnyIZ5OO9HicsJBqStiU0RxX47eP99Ys69nVkutgfG
         RH6gNnqpRNNiU+yAJLqCbO7e/0nvOHWTfcfDX/XVkjcQYsYWqgVwJUcwo+dprZTln11+
         dy5cbhKLE38Tjg7q9LLEMjBglnPYn2iFHFEOQGSghSe+a6iSZu2mJRlEJ747CB8nlwHQ
         0njQ==
X-Gm-Message-State: AOJu0YyMWDP/6SbOP0ix45Tv8oaw6BwrbUHQc0sFHkJbc6CxVIu9/b4C
	l8JNYtohvTVxBjeA0Z4o36HT2ENZI2wqDPdIKZx7XVT8XnGJb/UiCObg/A1FEA==
X-Gm-Gg: AY/fxX4/aXpzOZhk1dXOBhJh9Y3v9BepVi/Zb1rArL5cKHmJRGdfr2xwEtVNC/7XLuY
	0SgjUt1FA5R6mWWHbZehYybYFul2VoV52LqSVT0XYh9T1rh4o00cAMONonjw8zURjEWvrwfSbqI
	hXS9HaIv6BkxLjUlqD7CPFMTbRRCxdvPQJIrxlU5i/vEN+YEDT3C0s530zm4iYPBrm9CFuSGyLS
	sBtZLMXKtW7D3WLDFhzOiHVW66Uy/+tFs9gJUWMbcvW0YXavSQaNXsStRu9JiDQ9SrqqsfJdWig
	Pv40niq/81h9gBrgKHUsglB0dM5ZpjQf0D8E78tj5q21vQdHMtgeFzL58KWBbGsPqkt6AnK2EnK
	buHTZZrRzwyManiTDwgp2EpWTDy5umUmyv+2qWrhSnYUiE8uLEMhRPZNOGGjz+asZEXNq5tzlf3
	P8M4cbgH0/lLIdwO4=
X-Google-Smtp-Source: AGHT+IGirYmTMWbe5KnVKExR5Tg2sUefFDrOYSkUObLCZBzo17MErCQIZWOwL8Bcxng3ck0t4I1xFw==
X-Received: by 2002:a05:6a00:e11:b0:7f7:a2f:aef4 with SMTP id d2e1a72fcca58-7ff64ece91fmr3302023b3a.29.1766168172935;
        Fri, 19 Dec 2025 10:16:12 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a19besm3011605b3a.40.2025.12.19.10.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:16:12 -0800 (PST)
Message-Id: <ff4732b72a0d8c97c668167308039918362ffb9c.1766168169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
	<pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 18:16:09 +0000
Subject: [PATCH v2 2/2] worktree: use 'prune' instead of 'expire' in help text
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Sam Bostock <sam.bostock@shopify.com>,
    Sam Bostock <sam.bostock@shopify.com>

From: Sam Bostock <sam.bostock@shopify.com>

Use 'prune' instead of 'expire' when describing the --expire option's
effect on missing worktrees, since the terminology is clearer.

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
 Documentation/git-worktree.adoc | 2 +-
 builtin/worktree.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 402d363064..29b43925f3 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -271,7 +271,7 @@ mismatch, even if the links are correct.
 With `list`, output additional information about worktrees (see below).
 
 `--expire <time>`::
-	With `prune`, only expire missing worktrees older than _<time>_.
+	With `prune`, only prune missing worktrees if older than _<time>_.
 +
 With `list`, annotate missing worktrees as prunable if they are older than
 _<time>_.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 82fcbfeccf..3d6547c23b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -252,7 +252,7 @@ static int prune(int ac, const char **av, const char *prefix,
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("expire missing working trees older than <time>")),
+				N_("prune missing working trees older than <time>")),
 		OPT_END()
 	};
 
-- 
gitgitgadget

Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5439B498
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615801; cv=none; b=Kh6w3muBNMzNzc1mH0GsfTYpgTdkGVW9RTEGXNhZGucs9DzkxhXpXpa+wykvZHljNGeZzk7uxsaYF1jEre3UCyTCZ4Wm10oLBESdc7L58p6+HjSd4QCCL+u9LvkvuFjSqneMPAiwYkCt/UUaalE9mMqKa4cr0hFOs3tynI56Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615801; c=relaxed/simple;
	bh=Us2cznKWTfG2jJFptMoS4fMFlf9ugXfM3DWKnR3iTtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=flu9ON/Z8xm+vuq3Im7/tGbo/fOGBhYT1df9NSOjHlpiM/81K5Zbg51O3/O/DC8VvCVX1DLTNiAfvzhOLF0/qpK0Nb1ubBqxkJTVP47RPMJLBEyL72xrkfSHxYWfd9jumIG5z7C4H7huehIl8tZH7bghjUj6/juELMFdlogqKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axs3+tVg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axs3+tVg"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so89870a91.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615800; x=1784220600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=78y+UXU8Pjw551aJ7/d3G2Co+yhJcCuhcOkF2xIMHxM=;
        b=axs3+tVgGBKED3g3ap/UM5HyVBF6TJlORHdUyvRUH4rpbJwdoLyRw+51hnalc6H0bT
         0KyGTV26xaDOQ2ixkf15ULaOgzZD+QjOrFj6rz2O4lFk1xxJWmTtbw34JgWM+QjceU0Q
         YBKWgu1WwA1knTxELc4aMuJYn8bEeLhlAqgUHqOY4Fl78mwkV6opkSmd2ete74eM6dYj
         nIYA+qPJYomVH0W0MflqX7KlHX5Z4X+k7/zclhKOr4Zd+w43OnXlEHevge/QoWy7vlUQ
         bvxO+jPBa2LRUDMdMVodXwTcJdORPv8ZeChD8scqQ9KR9HR4mpVUjlnIxOUmG4hlaVM+
         zHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615800; x=1784220600;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78y+UXU8Pjw551aJ7/d3G2Co+yhJcCuhcOkF2xIMHxM=;
        b=beblTNbdklRui8sdg3vKL/qlBKJfwnAletGhimemvKGlJ5/5Bbjp1ex2FORCSVMEV1
         dvHYahKz30MkYU/ZCfmldF6FG9N0f3yCUySAILGYeWQGIkDjsANgjm/gNTjiYQkpCuZ+
         Cd/Cs3GEcUodd1xELo0YoDkBkajYAztzU2wXGCOdDMtDOfYVgh5ziFuLPPozJHPn99gO
         WxhvxEgov5RX6SGmXXUZlFn0dm1HvGA7VSNhGHCNJTQ/eAVJbbaPaIiwA+sVIWJsW3WG
         /uRiGph13i2u5zRkYXCUJpEG4h3goQw7VTdAWNWyZbUlS5cO6R34Mb4fRbo7oRXHT8xO
         VkVA==
X-Gm-Message-State: AOJu0YytYj7sr/U+Wrw41cBMUmRY8tATt4mIglG+/08ToCDpPW1p2Kuv
	hquG5ORxw9rPEx5OT5PutuRLxE6POTgl0mXjj+946v5qTY6Tf1N4AcqsHacZzA==
X-Gm-Gg: AfdE7ckhiWyuczCu/sgGkAhN28AnjfX6bi1aseRbK0Oc2/DkmUr9rKmMTMk3Nfznlhz
	EZSrQPpPJVx/yjEpTp+k1SJOwWV2koTZ78xRv+rVCAM9spijTvvzj1/s+9PBwo8MwusRE8yUVfz
	ZCVW2E58cAQSsvq/df+pCusFy70R+BRLEMZfmdsD9veQN38o6OaTWyiOAzaBZ1KWfcWwAYKaEuN
	PkVb+Gna91lnsymycN6bMmbKycBydE4UQvfcDCIjGd/Tj73Ju8whCzacoDZlXQDnDtcAXwsoLYg
	EkQ0XrTQdKCsspk3WAtHnoGlrVEIjh6RvvRc925Whs5nBFfDP9/6AqM/5o8WgXRXJYN7I8YR2P5
	l8Gm8uwM1hu9OzYLJOpJIUBFFkwUoCKWZw8q/02fTz40Dkd/eRhdYNe4xWaApIn4pWpUk87dWhU
	mpDhSa6QoIYwJyejw=
X-Received: by 2002:a17:90b:2e06:b0:387:e0db:3d8b with SMTP id 98e67ed59e1d1-3894395305fmr9581931a91.38.1783615799841;
        Thu, 09 Jul 2026 09:49:59 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm33656284eec.16.2026.07.09.09.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:59 -0700 (PDT)
Message-Id: <617960d9cae58fc621ce846dbc4935bce6bf321e.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:38 +0000
Subject: [PATCH 11/12] t/helper/test-pack-deltas: widen `do_compress()`'s
 maxsize local to `size_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Prep for the upcoming `git_deflate_bound()` widening to `size_t`. The
local is only ever the return value of `git_deflate_bound()` and the
`xmalloc()`/`stream.avail_out` sizes derived from it; widening it has no
semantic effect today.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-pack-deltas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 5e0f726842..959705feca 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -22,7 +22,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 {
 	git_zstream stream;
 	void *in, *out;
-	unsigned long maxsize;
+	size_t maxsize;
 
 	git_deflate_init(&stream, 1);
 	maxsize = git_deflate_bound(&stream, size);
-- 
gitgitgadget


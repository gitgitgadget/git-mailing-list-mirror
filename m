Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE77314D35
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479531; cv=none; b=FF9GsnHvzn5zP2XpYeeYQ3CFROR9aPQqOHsTQkzQGGWUEParH7oC0dztre2dMtD6/FML+ueW0XFbdNDBqg3H7j4kl0QtwSVq1HPnb4b23Vtb/SAkYurNmq5cXXACSDzhuUfa5BHXq640FKkBX00fJBQ5c9zC6gHMIzRZfpA+OrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479531; c=relaxed/simple;
	bh=SG/HfipPZFsnKTZ9nwNNHg0Wuu/tOIfsge13vH7KbcQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rqfPOBWIQIAL5jioSijKuLTZYbZkw+hDMU4FX221zaT95+pgyzm6mBOGyYmsnBuP3zYQwenPFw555eQs8qi1tkg7bsQ+vjIKY2klQLfG/AIibCIwMecZBu4uCwCmWsWnWz3vyAMk6aYgLOeN2B1fwRWh2EMNFQ9xR/NC1bw10ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0rVJYLj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0rVJYLj"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899fb2b94c1so39906946d6.3
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773479528; x=1774084328; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PQrx7/ZMvw5p9mTPVU/TP+NXz8EfI6+TAnnvVGGRFrQ=;
        b=D0rVJYLjq3GisotIQsYhYszAKPI52uL4TxT1eSllgXt+aKs9vj8tlPZz8+xCF1fHr0
         iJ7nRHfgXF8/Ua1Jao+5hOgEEhgwjXfkjsZro8hSNKc4UAVC7Kl4aHF9/CJCEHDiTbq1
         X7M6QvZHRD8T0PejL6z7+0owGAiO5Ow++cjcYMGNYYpUcC8vhHw0BaXd9opczBgYKhV1
         YN7m8WWeJuljH5VfISWDwf5f1xsV5M1FBX56dvhZUdHQQ8pS1R2p5Kxsklr27108gRja
         /hEHMzvQ1jEUi+0WNW9ILjuastYQAJO8hR3GzgF3I7283ldNAGHS7Y/L6nP1ix0pIVin
         hUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773479528; x=1774084328;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQrx7/ZMvw5p9mTPVU/TP+NXz8EfI6+TAnnvVGGRFrQ=;
        b=fflXwuVU8FgcuJFC2nURtWayF+8vC7gFTRG6dpqMjkk8Y3MWpIWEGMkTvVOpbBGRnT
         0dryVh2LnMBpcYML8aT4c3tS68MsDgRJviQ+I4ZW3OBodA1Kp7eXEezB0K9VHu10ufE5
         YcSdBRkZAKPyJg28odHl3c+PIhKVQ1cY02dgHikay3PLetQb/kxnvDFvvTurz/qU2Kan
         x8eGWHAVChlcm22QTFkXjmUCWgpMvdtEeWmxUq8NsGc3dKox3NLBEO6KvSGY7T26Xuvj
         iM3EhWEVyeZMOZpty2Mg68XBsPaavX/ErtCq9cBA/8hNpR+4PiVypJ/ngE6LBDu6Z15f
         H01g==
X-Gm-Message-State: AOJu0YywFSx+wyLiCu2dTyboMaDGCGkV4KS8AexPj7tJPK8X51y63oSV
	FKCH6ndUjWE2MaQa1bjnWo1vernJS9ATH7RujfYP/xdx0gKuGP1yeP1Q2Duinw==
X-Gm-Gg: ATEYQzwWd5hfK0tYNuP3358dS8miRIUc0c2G7ERjKnIC/ohDpNRgIIlo1hd8F9ZvzZZ
	4Ts2kCgPgOoS3YO0f7XLgFBxMRhj9507iduZDLxl+A2lrHie54SczUfOiUa3eqnkmePQVOIDp9l
	GI3a4cnZ+74N76ZOTAbMBLp/ewEP+qoEc7SyiCrhySD2pXOqXGMCcAe3+xM3a+/PuP8CBBZ/AjT
	JkZkK1l6g7ONpuPwzqZvUblxGr9M9e5VWfioT6kLPWnRUuMSo5TnpMWwVc9+fP2e4HTRJMPrDF6
	gP9/EpQ/vIzpy3FmRi8YL1jd7rVEY4EHzqTq0smHcvUFek/Mo1XjQ/Dt5kZDJzCiRnsKhvMecdM
	oyG4LhgoSywbDVvse8tmGe9kM4WPcQ7SduG4/SHLOM2YzaZkangp82z6hCgJF54K2N/RKtyxOJq
	BvlYJyM39LMZWWBaqw/p4wu7Fg
X-Received: by 2002:ad4:4ee1:0:b0:89a:258:c1d1 with SMTP id 6a1803df08f44-89a81f72d51mr95472616d6.42.1773479528312;
        Sat, 14 Mar 2026 02:12:08 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.153.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d1579asm76490566d6.47.2026.03.14.02.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:12:07 -0700 (PDT)
Message-Id: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Mar 2026 09:12:06 +0000
Subject: [PATCH] remote: use plural-only message for diverged branch status
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Drop Q_() singular form and use _() with the plural string only.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    format_branch_comparison: diverged message has only plural case

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2239%2FHaraldNordgren%2Fformat_branch_comparison__plural-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2239/HaraldNordgren/format_branch_comparison__plural-v1
Pull-Request: https://github.com/git/git/pull/2239

 remote.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 7ca2a6501b..12136dfa23 100644
--- a/remote.c
+++ b/remote.c
@@ -2307,13 +2307,8 @@ static void format_branch_comparison(struct strbuf *sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
-			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
-			       "respectively.\n",
-			   ours + theirs),
+			_("Your branch and '%s' have diverged,\n"
+			       "and have %d and %d different commits each, respectively.\n"),
 			branch_name, ours, theirs);
 		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,

base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
-- 
gitgitgadget

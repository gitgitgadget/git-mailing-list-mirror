Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59954288DB
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088822; cv=none; b=MOpDZEmBRKYWldWj1FYK/olZNeytF6AZjl1vFWZfAFvqli95IkkP0oRDgot7VwSGXre38DTfCND5NJi64u8Sy12sLv9s87wezbqu+JJPwRPKTu0GZkL8a6h7gvMBHmdEzP97NmbgRL93RJHOSnjn9Z8SbtEAzQrCVx3K14/3g0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088822; c=relaxed/simple;
	bh=HG3v2LaxzyHMchCC7wLKSOVktI6lDxs7n45A3wG3rZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmxz0Hz3uTjKChJCXyh5CMsnINMvCxtQNpHJL79CSsuhSF2TeutBxqHDF+LN3GEAYvecxzrJeKIt3F1abK/n6Aun5s5csxvjQSBhyeWXAq62eTGCp242fenaiDbW5cYbUkXF3a5X+uMrIbQ6XEZcQkOsKOfP5MSZNRhmt88zlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGNX24+K; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGNX24+K"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21f44e7eae4so49574555ad.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 00:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739088820; x=1739693620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6PUmiovXZsbWjwJTrd/5cRAqKcF0hslGXrZuwN6gcg=;
        b=bGNX24+KxCpZtZaEneLF1j1DJl+P/6W0H8Bv9w2KzsDXogGe/gEFwGEZH0dTdyNTOi
         1Z4vN+4SsHbNMXsV3r68WTSmfUFbI2cbxE6N1nTWkUJtT/3VUUTWjwUXQjo0zb/1L9Dx
         A/yeg3x42cLbrXnfwLU1gVh4EbWmBqeOG+QYLADPUOTskQWpZ8TGP8MwuzA1vs2wdQTM
         nVzDcleAuN4cZj0cnod77JYodpXtggwVGp0OFjb7pTnMEn8yLQN4+jBNP8wSIKCW/ONL
         c71naGY1/EkNEbcFcQppbBIwT4GyZia2E+xpqhZg+fGwLy4Kgz6GAizUqUuRPWjt2DfX
         UdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739088820; x=1739693620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6PUmiovXZsbWjwJTrd/5cRAqKcF0hslGXrZuwN6gcg=;
        b=L1LDFPTLBMFS8oQK0NJ8ka2rGp2laCHBo1I7e/JYv6uBVKt8NmPmQq51Xo763UnHC5
         T+Go4Z+13laKEbH39Bklf+KWbLELO4cua6DOB0UfmMwkjVWVuvnRUAePTmNZtm2iKQ0A
         gFFZYjnVYR6GyA3wYBJ6fGU1ex9AH9z7tGpkIeoawvm1P/u/DwBQL7W1pB+7baAErBC6
         15X6kB1Uz/IFEPRVGDmLCS5fMnpm9KgcBA+sw0X4eQlqKJOz1oKCmOYeivH/mGk1nKKO
         lw/YaMZJyEd5PCxohEepHf53gxkGfwhTdWvNDhKQgEjTvaf5k6TJoTlQ0XQaYhFP3FmF
         THLg==
X-Gm-Message-State: AOJu0YwvcAU9Y347sbCZLhz+cn27CSMKwQD78Irlnl/sQjck0O7GxrHT
	4GslG+Ps4zC70O313Is7v4EVleNLsSK9HDtiDgXag2wUt7pEjHko
X-Gm-Gg: ASbGnctU9n1rulDngxdVdWa2iRkjxAmapvANLMWZjBfDa+E7/YLmVq6Y4H2YbaQck4U
	Eub8RWzyok2/JeoodHtJUOs2+JvBcHAZo1g3jxOd5Ae8H+ni1db1+0HwYh4FF3DiN3/R0T4mMIr
	nXoLSIyFWlqJVopYjgl6NP3Cb0Nwmafx+ic4K9sB1osKPvk/ZblmKTtefJexdNbs+zzZTTzVSXA
	oNOmLcZxNazLRDIvPf5uV4ZQLNW/9z6myh2+WgMLdtyvJiFPghHjyF9k038Vh7/FMEVKVEHbRdT
	yPtK6CnBh8+rInpFZp4OW2Eom5CiSkxrMY0Z5iMa9hkocGvYdzm8bw==
X-Google-Smtp-Source: AGHT+IEoux/9CaeaWpY1xCthA93f8AeGHgnoPaV5TH6x5/FF3weQI0no9SbeLrZL758KCVvjUddrHw==
X-Received: by 2002:a05:6a00:2e27:b0:725:db34:6a7d with SMTP id d2e1a72fcca58-7305d5931cdmr14221790b3a.23.1739088820532;
        Sun, 09 Feb 2025 00:13:40 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([103.116.72.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm466308b3a.119.2025.02.09.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:13:40 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im
Subject: [GSOC][PATCH v2 3/6] apply: do a typecast to eliminate warnings
Date: Sun,  9 Feb 2025 08:12:13 +0000
Message-ID: <20250209081216.241350-4-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209081216.241350-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git_hdr_len` is an `int` variable that can be negative and is used to
compare against a `len` of `size_t`, which will trigger
-Wsign-comparison warnings

Cast `git_hdr_len` to `size_t` after an above-zero check.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index b4ae74a5fb..605a0aa2e3 100644
--- a/apply.c
+++ b/apply.c
@@ -1592,7 +1592,7 @@ static int find_header(struct apply_state *state,
 								size, patch);
 			if (git_hdr_len < 0)
 				return -128;
-			if (git_hdr_len <= len)
+			if ((size_t) git_hdr_len <= len)
 				continue;
 			*hdrsize = git_hdr_len;
 			return offset;
-- 
2.43.0


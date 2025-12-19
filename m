Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72F36920B
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168173; cv=none; b=A22V1rOX8MY4RbDOd3B4AZg1upxsLPh+oS28C7YGBc1aVXutvF8sARwY+c4k0VCmkFsuQqV+9d6qF0zmKiNmvYHuirej612PB+XKg1eDQ3lWpYC6teyAuSsihm4u20dPIADS0xoHs5KMCr4Wgs+DboXC3TC+vSWI1xbjkqNDRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168173; c=relaxed/simple;
	bh=q8iJVQjL60Vt9gKZdQqGA9UATAtygSbMuIH6Og8MaNk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Eo5diQUyRnIKa++xH2d79TZT4nQYYpFltUoVGroXn+HMWz5Yl7+sOEEO60sk4Qbui0ulJ+ytUlgk2X9PnrRmxDrfAypngm+hsG0d5TVVxuRvgxyFMy8XsjUH0zarTiPJ+OHc0pZAvCE2Gp3bV97eSnJ1d02LHbD+AJg71bYVu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6qbs1VW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6qbs1VW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so2732408b3a.2
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766168170; x=1766772970; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa6eZb+IGyxw8ehPnsWI6YlMXkFXFp2nE8YfLutyl/4=;
        b=K6qbs1VWHgJ2+Oo5J0j8PXGaJ6qZ8mYrPMUFBMDQOR9KYMAlWRji1H3PU+4XJOqgNT
         5K9+6R566h6WhbTHkqCbBvypRuznUy684xcM7NbTzk8armH8aHupsDa8l75jF+2Ba3cH
         a4BcPkwDaZti3SH6tEq9YkLTfAgSzVhWF62pSF0NUVfEuD3QXY0S1AAgLth1Wj7+YRYN
         RIHD2xlN//autTAZuHY+uqzt4wosslTULZMOq5OgmX9dcEsqpjzzvF06qL64uZ8uDJKF
         UQEiCT1B8nviHPC2i373C4KdjkF3eEIJMv57iE2OM4cPDhB9LZKiJirdL7VSMIYsCi2B
         dqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766168170; x=1766772970;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wa6eZb+IGyxw8ehPnsWI6YlMXkFXFp2nE8YfLutyl/4=;
        b=NUhfpoCfakZ98wEhHat1nSFghWnFp6uFDdw0KiynUwIeiE6VFPjulsFsqPZAAaZZ92
         eOikZJ7KLOtggjH4wcgENoB9itqw0h9p/JJcrX0Vx5TQbT3NZSVaq1OSK7j4oe/Sltqb
         A157yd57NUTWsLBEFjhL2smJFyxWgclOyk8HO+iRzmsbe1K1It6fKCer6BpYBZAuu/HF
         cGTjQmwhgj+gmG8IFwAZBlO6I4+F+O012l6f2UvtcbivEcK1wB5bRshq1OwRS01cw9B/
         Vgl7GG/oGfHupo6Ak9rjw/i0IK91Hi6Al1IDC8Ikgo2Elh0DXwA2TjSrM22/L5nT1Ck0
         q+8g==
X-Gm-Message-State: AOJu0YwuWWDDVGmkf6UBkivz6UOCepVBMbtq/EBKn9uHJT67QC/9UM6i
	fx5ddtpLVeMmuSDVHPoWhgmxCP8YUc0NUyv1Kd81BTVroNPyG0Q9bgCVcba0FA==
X-Gm-Gg: AY/fxX65rBLMgmws0QNbl8wmtanCvryD7QHVpPcAUJl/pMYAP7IaQBnK6ZQBVgJOz9c
	isyjw1OwDDkmtXFl6BMbbd/EbrOCIPw7w6IXqn+qJ74Z4E4c7C8MTdDcjCXafQ6yP7actCOzYmL
	iPchVoE0UlNHPNr1zhHDGmouyTiB1UORQFGhEGJ0M9zSVrAYwrtkrcpN+3u2g62C6Hw0AnnD5FK
	BmWttyhFg5zfguli4FvNkpQsY6vVIG6NcOP2ZjMWvwtm9u1hi25LVeyvQytM/6sq6MLPbLQiJXC
	srUpPSFLy66URX+38GMI7pTcr51dr/1wwck/t4gpjuu/YJvBqj+7zzQH3eKr7jTPKYlSJHQIhnF
	DkOlNt6wl7GYegYavNc6HfOCMPfquYG9Ys6t756p1sGn1s4tN57ZEVCJ9TUddG88owzRJCUR+UZ
	JtXaVnX3bJqmk7tnQ=
X-Google-Smtp-Source: AGHT+IE30AAXq1LwKe7WBP9PGFt21qKDp70SX3sfcdQo4kikafifXjuYNpi5L8IslXzRpvlF+zZfvA==
X-Received: by 2002:a05:6a00:8d8c:b0:7e8:43f5:bd1f with SMTP id d2e1a72fcca58-7ff6735eceemr3347717b3a.52.1766168170396;
        Fri, 19 Dec 2025 10:16:10 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b441sm3026286b3a.9.2025.12.19.10.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:16:09 -0800 (PST)
Message-Id: <pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 18:16:07 +0000
Subject: [PATCH v2 0/2] worktree: clarify --expire applies to missing worktrees
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
    Sam Bostock <sam.bostock@shopify.com>

Changes from v1:

 * Use 'prune' instead of 'expire' when describing the --expire option's
   effect on missing worktrees, since the terminology is clearer.

Sam Bostock (2):
  worktree: clarify --expire applies to missing worktrees
  worktree: use 'prune' instead of 'expire' in help text

 Documentation/git-worktree.adoc | 2 +-
 builtin/worktree.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2135%2Fsambostock%2Fexpire-missing-worktrees-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2135/sambostock/expire-missing-worktrees-v2
Pull-Request: https://github.com/git/git/pull/2135

Range-diff vs v1:

 1:  ddd4191ecb = 1:  ddd4191ecb worktree: clarify --expire applies to missing worktrees
 -:  ---------- > 2:  ff4732b72a worktree: use 'prune' instead of 'expire' in help text

-- 
gitgitgadget

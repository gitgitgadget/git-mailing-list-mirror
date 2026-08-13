Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E304483BD6
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632976; cv=none; b=dRpn5yh6MEnWlHVwHxeFw5e31W+lw7Zx/FXdvtbP+mGQBhTX9HTZ3RVsFa5GtwdMXYFMHbHXdWNFbjzh8Xvh3JjC1rMbxwAt5/3AMTK/TeWZGgXITSkZsK3JXG4rT7pI6990g2B+Xde5DBV2/biwy+JTO9sXBTCCrLtVVLtOvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632976; c=relaxed/simple;
	bh=2sOwCqcRrAPzEpyqVb2L253d74ossFImQrmVFcG9tRU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m+ntWA2cmdlZlifu3aKkSmoSiT7dnB9lbPzm0mZCP/re1DeQDs2GJFp6WsgpnehQsmr5XqRiXhXoLOpWOS9z7V2bqJtzSwomjXNnk9+0t+twcHA6x9TK+chTnMmo8EIBR+xqfHSNmSqNH4dd8242B0klIgY5YdNQ7101ty/7Z8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nuc/tozv; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuc/tozv"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451fd21113cso1391157fac.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632968; x=1787237768; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0QeFPLjkX+BN2XZOxoLWKjLvEHX3v/R4r47jelAKP7Y=;
        b=Nuc/tozvNvaPaxXKC+bHIJWkMEpVvb/2TT0xNl5f3rcpUVrerwy3kJOtWRv91GrVDy
         ygg8tU3bIH++pNAlXJkFnI3h8hZquoPSIsWQ5lu4z0MZ1LsI3/+UDBzRpAGqYVSMIVG9
         lUHJQIM2AkqoGkiPREuynb/oOKnVH6AirEVLJA3TFonYUgGi8lYnC/+PHBBKPsy8xn8K
         CmAnlBTu4+z3ShtQ/x9GSaC3Mv1T74icMvVTiNNwinlVu8ejfAqo0oKBdq/r+Qa3NXL4
         bwTpZL0rCg5e+ZNDWGpfhJ8HDKv3VG8vxON2RQPmyToUd226B9iLBkcYmetHoVkG6r7w
         BPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632968; x=1787237768;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QeFPLjkX+BN2XZOxoLWKjLvEHX3v/R4r47jelAKP7Y=;
        b=gEb2vVvUAFMO3HTe6xk30UnGKb4r8FOCtCHdoog2zlGwwTMQV8oqM8NF1/2p+tG70x
         pDf5bRH77niJhmWJu/z2fksMH3j2xdmJUA9pBZGTFy+8oqgdkdPQAF/n7KOuFc0KEV+h
         VMrzFHOoAUNS+CszGgZMFr/SOXilNvOti2Z8ftw/yiiQfYQXVV+gs7LEiBFBewlZ+DSh
         ZxJ45hzkPeU73kj920bAxno4AKN4cbA95oo6vwhC7LUd+OkqcOhMqdktcvEH8w0nkrnr
         vby5I+OQYaweglB/mXu6bEBA/sm8WiIokQMn2POHqN2fRsfgJ6Ldc7q7FRwpdz6DY+Vi
         rIOA==
X-Gm-Message-State: AOJu0Yw9Oaw3M9TKXAWKDUI/L1+xw/rsac4EfkVdI+aOoWU7YSrnnFzY
	+MHF90bxIeA2QCUz3Pp5Knj6LNS43qBicBDW8uGrQm9lo+lld49ITuSPM3ibyw==
X-Gm-Gg: AR+sD11NAJ6bnZO/8ey729a9UOs1lVB0PeUcyAZBN4zS+Yl0ofL/W8obvsarqWAVTG0
	Vit/UsqKxJ7H2qK+ScwHNwacF96S9EtV3hjjh3Mtk0TSzspK8nMzHC3WB3TJ80AcSI1SjMVpbKy
	NpygMuyYLOowRXbhNKZaGwFmGpUsG2D+In6a7pU6cLIRK9yYZH3m/JJas3D9j+pdyjUf7UR/6n9
	KebHdNa3yjt0xuP4pSU51PcKFhS3V6VPqFVCJIQYbRX9TgE6BXDz32SAFPzcGhurLhE+PJiRvGM
	qlnKKUKT6t1mQPnMSFwQU8eg0jSIgMCiYT99+F1Q0wqEo0jsZcUfpFQ9UIuLZiO7C13g68HKFQX
	LnYpSMLC84FYEl7+CITBMGw1MEuo3bM8tVAwJWT7v1eVM44TH6SJ4RRVsRwC8WgEhAThIA6WBaa
	CHthIsnwQ8nSTYBY36Rfti+MpgzzlLp9iCfx6MSpnqeeLPEkaJhbdg4noWE7ayut1SNQ==
X-Received: by 2002:a05:6870:9108:b0:451:ca58:626e with SMTP id 586e51a60fabf-45e64bdd2b3mr4712193fac.8.1786632967716;
        Thu, 13 Aug 2026 07:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e64f8f077sm1735589fac.6.2026.08.13.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:07 -0700 (PDT)
Message-Id: <f0765f6ed6c13c6942f2ae76e5d4065eeb2ef8ce.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:47 +0000
Subject: [PATCH v3 09/13] diff: widen `deflate_it()`'s bound local from int to
 `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Fixes a pre-existing silent narrowing from `git_deflate_bound()`'s
`unsigned long` return into an `int` local: anything past 2 GiB has
always wrapped negative here and then been re-extended to `size_t`
inside `xmalloc()`. Also prep for the upcoming `git_deflate_bound()`
widening to `size_t`, which would extend the narrowing further if
`bound` stayed `int`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 69eb2f76a4..c14f69719b 100644
--- a/diff.c
+++ b/diff.c
@@ -3609,7 +3609,7 @@ static unsigned char *deflate_it(char *data,
 				 unsigned long size,
 				 unsigned long *result_size)
 {
-	int bound;
+	size_t bound;
 	unsigned char *deflated;
 	git_zstream stream;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
-- 
gitgitgadget


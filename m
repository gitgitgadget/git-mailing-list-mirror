Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188488;
	b=yimAXUanlRcWAdMALrwlInPJECeIP5tcnML2dMtDB7giYUviDzznInVLUO2gVvyj1Ngd
	 9Bao3EU328MykHZo8208tBFkM+XxsRime4IRG6b778SUlGHtOSPDa3Q7c0nZyVZfRBMnz
	 gI4cy1HbK6VPnH0BbFTOYih0zABu6YyeQ/qBuZKVNc3NUSdZdShgK2lzJFWt/wzRH3+7o
	 6EnN0fDIGDzSAzUH2ckK65FErRavpuxr+Iiv8bZrvcGE1+yUsSb73eZ4iP3hH6T+SK1aK
	 JEYoXjsqYyfwJs/oW87i6FvWmq9r1npC6zICU1/sdzVCLEtlJ7YaXBEGOyNxK5JpJUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eImSEKUL0zYuxf8q9lzx/EQkWm9d5TqV3m+iFG4X1+E=;
	b=eG8c5A838t2INgDeQGzPI3beSoO3QfCxJ8GTTxwJnhnmLYew4DxsBzaGA9BKbfIjE3ES
	 0hHVpl15V6mIzTp43y00yBPFtL/o1+axaNXhLIZJmuaJs5GWl8BN6Nzy/G6BY6B67a+JS
	 T6ahf9Omqz6n0JBYmg3q+zYApQsuZrtP08rhSwbaRZQt588bKfDVHdFgw2dTvWXFXo3mr
	 mrDA2Td7dDMrhj48UWxrO+et8Y1SpxdOy/eyHHc7F/BxzHKJ/kPkJELrOqSRGi7ByDWmW
	 yrKD7Ojv6WS2aWVKK20tuJkHoeSKRsNx5YUDbBpvKPjRd/k4wiWgUZIJyw50LYYBcuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PuEnVJSW;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B48606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B48606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PuEnVJSW
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15dd124bbe7so1609143c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188488; x=1793793288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eImSEKUL0zYuxf8q9lzx/EQkWm9d5TqV3m+iFG4X1+E=;
        b=PuEnVJSWMS2Y8d+3pFNb3F8XHfvsxQUzDSKh0boe1mkPyncY0c3OVi87Ot4hWj5SLv
         qgYgAdlp58m9cX+Z7I/nrpsLdgNquytao/L0VXtxp0UcbotOse7vpTyNxNRjFZ9DmzF7
         a5PspKZ38ayRMoKxaOw2NwG4aTP2FZXjBwpIvRsBrGOz4pozMlcacozebLW/uQ9BvGt/
         hx3hTGMzdPfLM9dcVjPXdPYfy1AmPUKiC2iiU6XAMguAGJ6rdsqLIUjl7EY94rvZ9zxw
         +AyMntkSQlewYouqhe1UGiJE8SrBpLxY2Q9+De16hirdhACz4hGKnb02d32Bi+qhLLPB
         ZicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188488; x=1793793288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eImSEKUL0zYuxf8q9lzx/EQkWm9d5TqV3m+iFG4X1+E=;
        b=Bk9/O6m4dlS4TupqvAqfWNL4S7pbnWr31CHe7V2/YnpL6IQmC+/xkMLm/9z912WKq/
         9c5TLnhIWffGxvV3UesF047VRZa1p2sjQ9sZ7NTwkX+82RyyyfayYbEuA9UJcDwgNaD/
         OMNnMidSULLhaMFOB9isNrC4ZtKVh53EqTvQDsm3cvZmfieKMiqZEL/Vgv4bTnGqg+aa
         14ozikh+MfRRT3fJ3a+yjL8HszCW0KMcCUZqkpef5oKyEGzMY2Xx6YeK+i84g5AOAUiP
         vl2Ij+qMDtZSvV/g7Pgys7pBzTZXZfNd0axg0Ul4iSqpijl0tE/cyw4HYBnYxAuFnOvh
         Srzg==
X-Gm-Message-State: AFq9FYINrITXdU7umDExo2WFHPiU0kBeUIsuMCTLiOFgeizuLeJvsa6A
	rGU6J+9VNuaohVBitnbe1mZc0vdXmtgwmFqHoSPkluFPxRWXmHgPNzFGt/HXTg==
X-Gm-Gg: AYBFou2RzhvajAhQV2iJ/HrbfDrLzb0trgLY2JPPw2i/CqlDy9dKqjRPefDs7G2qhed
	spW4N8/vCcB1dUcoEjipwOm7/ISGljBQRohYVNNvkVGbv3x1qwWvS76l9mFGx4ARYGnlBBMHopq
	lugE/3aAa6u+e9bPxtXam1CdjojRfq7c2Ztt0YxuTk+0lSDJk5JDefdig92KH+y2MKe1SSgiC6u
	rUqGgmOirKVRnLCcUAwYbf2TJ5iyKcqtxFJ+AIYVMdJv7RPt5VPcBjBKnca7/P0rbuO5+GxrP9f
	dchuCk9APzTX9lx11Fmp9w+tnAcB39gkFu5hiEuxjZytiLrDZdJBJRRUfnE6k+bsEa8sbdwzKoy
	n7jJ08FSsy8JvYwn7ZqpO6vbcHrkfXD2Z/uqsfjUnWRIz/k6nNixNNEk4qCZMI5bitl3iqcO2VO
	PHTk/9y0NEC+tXod4/nMqAUQAOQ/kCmUnOBmct5fx2kGZy697LianVZvA8ZVIdFrREiKWxp/rR9
	3zstqzaqAEj5Vp1P/iLMB9fM2SLTaVzAFVeO0VSkgKEOMOLYDZvHAhzuJNRmBim2WJHqZPAw+SU
	6dIivhOSYB9Wc8z3wEACf5BVc5G1CUFWAbvnkaJgNEEt5x8BEMTmwllV
X-Received: by 2002:a05:701b:240f:b0:16b:fdbf:4a9c with SMTP id a92af1059eb24-1a6cd7799damr2580607c88.23.1793188487367;
        Wed, 28 Oct 2026 04:54:47 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:66b5:b36d:2c4:846e:bbe6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f7fb28csm6350819c88.18.2026.10.28.04.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:54:46 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/5] setup: normalize an if-else to follow our convention
Date: Wed, 28 Oct 2026 17:23:59 +0530
Message-ID: <20261028115412.169748-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.283.g7d13445134
In-Reply-To: <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else case was not stuck with the corresponding if's
closing brace which is not in-line with our convention.
Fix the same.

This is a style-only change; no behaviour change intended.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 61bcdafe82..4789b2d79d 100644
--- a/setup.c
+++ b/setup.c
@@ -1905,8 +1905,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		if (chdir(used_path.buf))
 			return NULL;
 		path = validated_path.buf;
-	}
-	else {
+	} else {
 		const char *gitfile = read_gitfile(path);
 		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
 			die_upon_dubious_ownership(gitfile, NULL, path);
-- 
2.55.0.1003.g10538fe699


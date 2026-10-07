Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB883BB669
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396320; cv=none; b=sPmrCP3xQTeGgamlBD0yIprhTj8N9cF7Gim3K7dg7YPmcG80Pon4Zhqamvev2ewlYnSqGuX+0g1ZWtRQo4woSD4nb3TGtbAAWg+utnqw1k6GFPH+fwW1fGfhCKYpLSrb4P1NF33jlgmGCEHhDJ0bue261UuC20d7EZrSB6GaQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396320; c=relaxed/simple;
	bh=YF/hBOk9d6oFtBVSpoGF4WfjvyVLgxJjuggBTxMWV8U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=mPqhCFH553nfQOXRCBWEqB4UhE3qOwwAid1rvLypF10Kz6zIeD8qk/XSLEPOMcucCzEA/7AlGJ5ryHb4vc57HgXixRO+Dwz+lqG4QA5TphHvTXQgAKAR00GZ99pWVYcZ9alHUtkmnNmD2vC2OFL5aMNevio/hDRo602K5HblkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4g5eQCF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4g5eQCF"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afb0d2a586so4112377a12.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791396317; x=1792001117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKHUKtlwTWBTJTYNqrRDvZDpdiu7TEKBbTHZq+p/65U=;
        b=b4g5eQCFI5joKl4lzl2udSxTkXanNCW9C1LBaIxN966TDTDUR9hA+NzsvMbgv32bE0
         Dn3vcVatM1/0JyFvwzf6Ea7tsPtU7RUd5xR9DIsOCtooquu6a594koUsAT0o0wpXdUxJ
         0+GRn9nZN8z+kre95Z13ZNGfk53GKJWF8m8B4/tIwaLJCXrx//FikVaHTBuwMtunGA1m
         ghU/d+Uw0l/+Gike25bifHhZsyUGtBWStfXdaMlMNby14vgqMd/wRjtMF4ofjHGJy/YU
         6cNaVdv1D/aE5+Hhuj07r5Ddl8GYLaKeA9w+d0gyXgQi6gttGPdMNSRgSjl4R2vwvTou
         bBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396317; x=1792001117;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKHUKtlwTWBTJTYNqrRDvZDpdiu7TEKBbTHZq+p/65U=;
        b=oijMJ3NJDld+dHdS+gwqiNXzkbwYG0dZFHLSNhOimRM2yGADHR/55MKx1/0u8xWMvJ
         tqm7EQsiraq4fQMUPHY3/aDOnERhKL/nCLHbwa/D66IpXW4NpGPKSV5mf2mgZONbysVF
         V/GxNkL6dkUq5wKSlRKzKkxlEobAS1PyRkuFpC0myKwHy96Qjz0cK03nxDYcl8Gxev1o
         inARHbfDm1ARlUA+l0G3hoiagdjQUinrybIU0cj7XsAYjHLddWnblKtTz7uqnJKrPMSA
         PAxLXMwDzOm644rOxqtOnL2iAhZwif643UyrldGJaNUiHMr3I2m+NPwkkSO23g3xw4PR
         pXYQ==
X-Gm-Message-State: AFuF++n/v3mxcyiXoPE0Dw9PtQyiYIAf3ZXr08CczMd23wNbYTBqA2P2
	6BajJhkExxMnvUIZtc1Nbn8kbkTHlLYMXH9i0AqLn1j1ncmI4vOgtxfi4lhp7AiP
X-Gm-Gg: AYBFou1HkVPzAQRSdC3O9rzDTpTnD3FrgDOaIyI6PCrvXYsNBpTOjcDTTeT3kUqQHN4
	wiYOtxgW1ARtX/EexTL5zY7goUq9wzHoyOaivE6Ao8GKQH2ETSR8zScDQZphHQQFpNfJ1+QtHFk
	Z+IzuYbGh/0uhizoNyTmKg6zpbbYPeCd1VgfKmy23Z1U09vxEbivUUVs7g+Hn8dl0/qVMKMLVf0
	V9OYM+Oj1RRholG+wc4bPMGPGzgHPzZgtfob6P+FxXdyQJf6GOoletbdql5zG+HxM3oOWyFJAUB
	itkFVG9QPqzVeN70aZZMM8A5p2P2TRe+LzpuzeW5qyMQXke+r053gcdjNwSZi8C2ADppzfp6JEY
	n84WrhHs0s/hqlkqfgaqyUSjWa6/U7GIgElxVVK7aTdBW9wyk2FDNntG0tvcKS3Qpsyz2Ql1r/x
	0k03wioFgC81WPiISDFtwP2YC7h/anvnQJzGrzpagQBnxzA2bNR0zuzKiwa4cxLyKy5KnEL5TOZ
	Rv9ZYcaAu9b/mYT3ZCcRKpx/nma9pdfWlm9yRKqD6M9C51vImbwT0F9xxekm7uJXhZfqyBc1462
	8XyOZzQDiVAxv5KeRVDQtw1/k8Ny4Jt21xa/tHVCBdGL+7VShzGjrY8Zp69jy6Hzx3GKPpx5rXw
	hghmNtD/8vAG+q1zZR7XyKn/pyfsYYA1nH8nB4dN0
X-Received: by 2002:a17:907:1c84:b0:c2e:3d17:5265 with SMTP id a640c23a62f3a-c317c06d9e3mr316779766b.21.1791396316659;
        Wed, 07 Oct 2026 11:05:16 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([37.31.50.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2f19bdsm129986066b.47.2026.10.07.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:05:16 -0700 (PDT)
Message-Id: <6d7c146e57b3e626a0469f2289d375652ed8fec1.1791395643.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <cover.1791395643.git.maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791395643.git.maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Wed, 07 Oct 2026 20:05:14 +0200
Subject: [PATCH v3 1/4] refs: distinguish internal transactions from logical
 updates
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

A ref backend may use a nested transaction to persist part of a logical
update. Provide an internal-only transaction flag so that these physical
updates can avoid reporting the same operation to reference-transaction
hooks again.

Keep the check in run_transaction_hook(), covering every hook state in
one place. The flag is deliberately not part of the public refs API.
Subsequent changes use it for packed-refs updates belonging to a copy or
rename.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 refs.c               | 3 +++
 refs/refs-internal.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/refs.c b/refs.c
index 92d5df5b71..00b1b51280 100644
--- a/refs.c
+++ b/refs.c
@@ -2666,6 +2666,9 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ret = 0;
 
+	if (transaction->flags & REF_TRANSACTION_FLAG_INTERNAL)
+		return 0;
+
 	strvec_push(&opt.args, state);
 
 	opt.feed_pipe = transaction_hook_feed_stdin;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c3ac7b556f..0b41f5fa4b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -8,6 +8,9 @@
 struct fsck_options;
 struct ref_transaction;
 
+/* Physical updates nested in a transaction already reported to hooks. */
+#define REF_TRANSACTION_FLAG_INTERNAL (1 << 2)
+
 /*
  * Data structures and functions for the internal use of the refs
  * module. Code outside of the refs module should use only the public
-- 
2.39.3 (Apple Git-146)


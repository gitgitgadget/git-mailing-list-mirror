Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0BE346E5D
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418902; cv=none; b=jbnEcmWuPuSVMp22mQYSi079zN6wEDt/2NsEQ9Kb40hDWaV3WFhslTxOw09ch6IJu83S08ARoyIZbZoNhVkedwuQL2CBDLnxRBx6O7/zlBeQPLJkDJKZAIJtx+iE+9shnhGTuKE5qGZtuEqbZpT3ayGTADRz78ZkVt/9ddQOmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418902; c=relaxed/simple;
	bh=gwmvzsoqo+A/6+YvNVv5Q32ushH2xOKIgVWID3l+8QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xyf6TdfLZkQCG+aM1vpDePkrbEOf1hC19TMNE4mITgK+6XUa4ihdVS3E9W6WY/jQOpd1S8XJy5HAHF8Q3uQlkCZso0rVmQCah5SS8EOJ99ES76S+1s5JZarcjLyAgdktdRbZm4/PNE/+VgOyqtT0m+eAbotdNYCDp3Pl4CZE3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqkEf7C1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqkEf7C1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so1960555e9.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768418899; x=1769023699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sInulRZY326tgVSSRxgxgP50zCrg0/ooE2+k5eikH00=;
        b=UqkEf7C16TsfY2BrheRGuw2PKchJur1HaY8oB7L/e/dy9Lc0Hdh6QGgGYxhmwJluUY
         RAp1z1oO7RoLW79ruSO2kcPw+kJ9YWEX+u7SaK9cBsI/SIRIi2LxFBjMzQZszBw/crRp
         nCVkJpf50J8ekTZgf4wnHNBJaVbXxzr/luDGf6jR6NZlsGaNbYXgQEIaSlv5oXst/Ru6
         CL7iXM2jeEJWz3P2aJf1iXJ4y3BVVd+ZlRfPWlg//BLJrnpqcWhrc5hIUI5/wa3/WguJ
         PMEE1v0cXEsoomXCfE9MWfi/1NM3f8Rvs7Riz4YyPKg04FGUmlukS8Bh44nUxOF50hY2
         hssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768418899; x=1769023699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sInulRZY326tgVSSRxgxgP50zCrg0/ooE2+k5eikH00=;
        b=LodeMIyFhbiK5bqKg/EbgetDypzJ4Qp5S30v5GJ5gIWRpOaUUraz0zxYPdqfBUAkXW
         EuwEE8tGbrH6Lj/64kbHomkifTT9GcEGNFQyn/8xqal1N+fM7Ib7tidaD3G0VnyrWUyu
         xcxx6CoTLRckc+1ejr1DNamQzIIxB+bhGgttRejWXLmCgvYnZbrUokjnay/yBhq5JRHr
         C1ey/MRhaOpF9y4Jc4r/Qytcj/Npf1vEMdls99gacrdsGXbeIGr/KNt0tcsILjguz2oT
         txiYSh30r7mHY6VwBT1bO2F+VFtxhqF2Tt6NDikEaZ9upx0BVPKOYqOVHNbBG+nTrVJe
         XPzQ==
X-Gm-Message-State: AOJu0YwHCDFrI3UxZX1D5dojfzf6V07Uh2KRyxB83T57vGjaoB4lobro
	E364CmFGniWEuEPAoAC5xW8p4V/y7taMMxaJSGD2o9FC1FgSCvZNmnCCsDr7hUhU
X-Gm-Gg: AY/fxX5ER99zoV6rHH/drPXbMTIndXRCxb/FgfiIiu7Qto3FFTKfiY1IfHIi/kL10Mc
	BJI9tB+inTlPaXlpp13cT0XB47OxX5qFmjoaxT+fQ0SqZQlLpimV5AkCluRSn9VWwWqmM4PYXkx
	KzP6No4UM+bqSzhbY3YeDIZxyvPldT2DFgbE+VCOInoR4u2b6cSwqc+5nUe1T78FctB3O5nZvqT
	eqKEazt9iT3e7cnekSsYX1BjriO3/fYn8zGYiQyySl5jBBXU9lsKmNZN1jzKlL+4aYHd7OLEAqH
	i+9j/qrzRzjJ4xvwCFnX3V/C8ntrnlcKLY3l0phxzyJcbli1mFlitHOk+OxJjaQcSplhs+LJ5FU
	NTY+1Ro2zZbULoyStN8QI8a8c4oZfriY1A2ipqFLzKL+K0OOe57fsTqB7NRDyg/EhQN6J619aSk
	X/EmYjVihTp7sMSAkJJbuCF6vUI7UkeKWNi84cZuA+N4Ou/r2oWhZoMNYzAmnY8mFPUJc=
X-Received: by 2002:a05:600c:314f:b0:47a:80f8:82ab with SMTP id 5b1f17b1804b1-47ee335e701mr41736845e9.24.1768418898646;
        Wed, 14 Jan 2026 11:28:18 -0800 (PST)
Received: from localhost.localdomain ([115.98.233.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm8580115e9.15.2026.01.14.11.28.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 11:28:18 -0800 (PST)
From: amisha <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	amisha <amishhhaaaa@gmail.com>
Subject: [PATCH] sparse-checkout: optimize string_list construction
Date: Thu, 15 Jan 2026 00:58:03 +0530
Message-ID: <20260114192803.4852-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list' by constructing it unsorted and sorting it afterwards.

Signed-off-by: amisha <amishhhaaaa@gmail.com>
---
Note for reviewers:
I identified this as a strong candidate for optimization because we are 
pulling entries from a hashmap. Since hashmaps inherently guarantee 
uniqueness of keys, using string_list_append() is safe here.

 builtin/sparse-checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..0a44808ed2 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -91,7 +91,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
 			/* pe->pattern starts with "/", skip it */
-			string_list_insert(&sl, pe->pattern + 1);
+			string_list_append(&sl, pe->pattern + 1);
 		}
 
 		string_list_sort(&sl);
-- 
2.51.0


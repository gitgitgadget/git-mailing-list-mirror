Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCD1CF96
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726441429; cv=none; b=DGfy2zsLXwDuwCStZuOohR5IHvLRHsGjN3yLElZ0i2fxE72bTrgVlcx5fvtywd3D+MSazKyYzlFMKMy+KDNWmcEN9xpWK3VRz3nZ93RM33whV664RlpRERlcz8nuEtSTLeu/YOy4H+h3evyLkwIn24hxfF00V3LZXkyOr3rgDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726441429; c=relaxed/simple;
	bh=7mNe4xU2PV3n77a3/D4osltShFwq+TFlm49svbj+7Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyZ1UT0gVqhogCyJV1ww7RlVGxJJ94lCkea5etNsMjpuVzMCrTBE9n7yJakgHFuX136mJj94R/hUB6wHDCizCpAvrnkkrM1r5N3QCZ4Y7ODdgFJLFQ3K1QCerEpe8YoLk2DrhIX2KSssCmkGsDcR5k/goae6B0zVMFh1NAqfA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrA4gwCE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrA4gwCE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so31496525e9.1
        for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726441425; x=1727046225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQXZpxKtDwVjgWt6PesSDsM75H/RuMz2ZwKthXwjVzU=;
        b=BrA4gwCEYfXdHnLXGGcpBuujpfi5Ne2QLrgPfEIJhPD8RmXFDhqtOQQPc7iCdLUUag
         axv1SsMCmVXQoSA9WHRDxuKGh570Ovxeoer2FVZWDj5eF1vrssabv0mMYsmIF1nbvucz
         S74kTr2LsRHEwGH3sz2UBW7lZ+FrRi027qoj11Xw4CvEmShU0TzM8QrRRYRMAPC72BBh
         /+QrTVEL7A4C5tSSxJlusZYqXTovenTH7t8HQartK+8qBkwJrUL3ZTS6n+r/4UWWDiGC
         OqpAt5wJOsFWTLyH+ocpoenwBBtu09MvUKr4WI7USozw9ShjtWq5E659F3BQyTKsUzF5
         tteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726441425; x=1727046225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQXZpxKtDwVjgWt6PesSDsM75H/RuMz2ZwKthXwjVzU=;
        b=DGbm13PAOTLJLnFzS/yNjIFCwcLaQLBLiILLKhCWyO8Cn7FVdh6vUWX4Cglgdk9NaS
         6VcblUNv3DK+Oof9sExnOjoLU/8MgKlMFYvPyANOBHWMpbVp6lR16ut57nlb1rh+NYU6
         tfWQ2mBA2w1ygJap4hekli3H8VEyu6lzrxUVNQ6oY8gM4V1riB0GA9HfewpBwBG/vvJ6
         noe7KQLNgJqYGFUg1p9rnrU0nzYOwS+sbSABSty6UfAAsnWVIEF9Fhn3cVqL/2sQaRk2
         lqxjTTP/jtK+G79RgQEN7WYZIcQBWUSkk4lSGDSIulXiNBAUB/5dXS+fCqghrsxPglnA
         FnKg==
X-Gm-Message-State: AOJu0Yz2Mts99ixI/vlpLgZke5AABaiX2rqGnoFVwH1l9FIhefTRECeG
	nqTIqdyjO1HF/L8gpGYbqqlHCYUBsgu7Qe+226KE4BIL2OiAqwzqyygsDc5l
X-Google-Smtp-Source: AGHT+IGsYCTVGDfNe4Kve5HbvJLNipusRjR94oqiX4LQgfMTD9p55Z8ypfn8xIfB90SdYDDU8U3kAg==
X-Received: by 2002:a05:600c:45cf:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42cdb547f05mr114416695e9.13.1726441425249;
        Sun, 15 Sep 2024 16:03:45 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm59270825e9.1.2024.09.15.16.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 16:03:45 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] bloom: fix a typo
Date: Mon, 16 Sep 2024 02:03:37 +0300
Message-Id: <20240915230337.129115-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 bloom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bloom.h b/bloom.h
index d20e64bfbb..6e46489a20 100644
--- a/bloom.h
+++ b/bloom.h
@@ -18,7 +18,7 @@ struct bloom_filter_settings {
 
 	/*
 	 * The number of times a path is hashed, i.e. the
-	 * number of bit positions tht cumulatively
+	 * number of bit positions that cumulatively
 	 * determine whether a path is present in the
 	 * Bloom filter.
 	 */
-- 
2.39.5


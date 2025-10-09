Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BB28312D
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046309; cv=none; b=sD9QllbdjXqex343Xj1vy4C2TbASkmZMv1AIJSa4lQcsYLrXIObaDvfdZ7ELsag0JufUIbTRLIwhNoi28BjwOFXdwM3DtFUM2EE+IG6pV2x3BFKDfxriUeGE0Tsw9NLzsL1GwTcfJcs8tmPQEW2XvjezX5jHpCHoqACO+iVZYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046309; c=relaxed/simple;
	bh=3iWYkyIsLEvmeD+UTXsSVEFfRwh+CtXVhFeKA4ttMrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I//VpO8vQ6DHVUfON3wCeBVIOMoZx8CMeyOdnMWIDs5KO3zNQrTyilWrxUEnVLviHVvJTrm5/VV07lUxhtBoKxcQCXAvRdc50BK8DVPezHjVJM+WzDTaUQDw/L0WvS8bmanW5xQQ4VMfOTl0Frq0dit+i+wiAJ45CFsjyr6F5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0GW0ruf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0GW0ruf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so14568925e9.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760046305; x=1760651105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LVDWqwhJzkA+yitI6LYAIM51LcN/x10+4r8eXON0eg=;
        b=N0GW0rufk2/bIYHL7NrNdkUTN9FWCO+xjhM2oghexqV8Kh2w5zlSCErCbyQbJZC795
         93FUa2d+5BL0OvhyeanRaH71VkrVJAvEWhBZ+XiKOJwqvUlBTDzbCpTuhNtKe9gpEVaN
         xAhVtvkysc5YCUGfmES9w7SBVPOuS+TE6ez+qpbQHK9bEV1664qTP2Fq1MZVBVgqMH6f
         Vb+NDHqi7yebHu0RYfAsE4XbUGAjzIkMa2hk4+wuLCPEF9jY4sgwPI18CPk+/2CIZyI9
         tVT/YIZBVIPMkjHKo0Rsz5zUEOPDyXqrqFy8xyynXeCk+3HJVDruTM4SqVo0egD6IsR2
         zGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046305; x=1760651105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LVDWqwhJzkA+yitI6LYAIM51LcN/x10+4r8eXON0eg=;
        b=OVOcrYvV/3xHl+P8ykP21itkFBSVvypZ/76LEPXBrIg2WKtBNbnusd2eOxnQKOILNW
         TM5gh1WerXySGCnKhFz9Z6lMLBPy46nSZGBv1jbtxnuRpIuO2SQs9BQ6e+HcuynDlcj1
         tetoEQODUNrX13hgHhl7Q0TH5nIso10cMldpkpBXnLO2f1EX1GLNrBlemYU5RtjGK819
         isZYLzSpm3KZjTsTfBe3WchWnfVfWwRoRC5lHKImBTCUnM/qIeNizXZmWE94vgLltJko
         srdSXdoX/oxk4FM5oOcTtclKr5Wu2lsrpGmULiGqr1Az4hgnaVzw47TR9hxwY+LiJDL0
         jsbg==
X-Gm-Message-State: AOJu0YzMG1Lh0tCdL5SQE0V4xe83S5IzVpYOY0oNOLtmaMeuhzUWQurB
	Xn10/EkyQB37Z7VdD0u+yOYZvEPH1X6UAOcSm+YHQptQJN2qreTpjcbdFouUt0s0Q9k=
X-Gm-Gg: ASbGncsNYolGoL16MMAr7QRrtKUKasIwEh3DhKityHXXFb0nxs+KISh8/dpfWslzctY
	/1Ojnp6HC2oscu2sh2Kr8BnKxvpjpKrcMStyBONq5+umFmlJSqJhYHnP8BlEkbMnC8j/UHKDO4t
	0SUjx8dkAP0vl01OeEYLUZoxHJB5s8rIo/69k8QXjUDezdDVR2uXMar57XgFb8z8nBnOyU6D4P1
	TjP8WhFQw7qdBU2vy2w0ODN2jUi3bZWzT+pXWAmUwWyStZeBbbfs2vOOvmnmU47yv3uwe0ghBye
	SQP6ZitoWdKM8FFSBKIAN85Lf5Hgg29AkAjZ0teOOp86D5xJrtzbC233soo0YsJiQisccTESJdZ
	CU80StQYP0ZddpQ9GMNvkLSIenML6q3uQbMPUCiGCwv5VkTpX5iTHmcEHPmdMktx7FP/6mxs8HJ
	Cmk9Vh9e3RsALsjjXvAPkXMTbOZ6mWIJR9plsPBg==
X-Google-Smtp-Source: AGHT+IG0IsL+lZv8JNpMsh9fHaQZ3meO79sxYr5d5SoPdI5Yrk9/ntBxXL7V/Vmz2c+Bbt+l89N5eQ==
X-Received: by 2002:a05:600d:62ab:b0:46f:b327:31ce with SMTP id 5b1f17b1804b1-46fb327362bmr15591245e9.20.1760046305257;
        Thu, 09 Oct 2025 14:45:05 -0700 (PDT)
Received: from localhost.localdomain ([105.113.99.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583424sm899398f8f.21.2025.10.09.14.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:45:04 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] [Outreachy] patch-ids: fix const correctness
Date: Thu,  9 Oct 2025 22:44:45 +0100
Message-ID: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix const correctness warning in patch_id_neq() in patch-ids.c.
---
 patch-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index a5683b462c..4a72c2cbe6 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -42,7 +42,7 @@ static int patch_id_neq(const void *cmpfn_data,
 			const void *keydata UNUSED)
 {
 	/* NEEDSWORK: const correctness? */
-	struct diff_options *opt = (void *)cmpfn_data;
+	const struct diff_options *opt = (void *)cmpfn_data;
 	struct patch_id *a, *b;
 
 	a = container_of(eptr, struct patch_id, ent);
-- 
2.43.0


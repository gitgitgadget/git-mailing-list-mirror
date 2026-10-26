Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010380;
	b=sTaZxWJ44DcfZKQoNrUPkbPXXKxs39B12MDRatDO0t5Lo8Nq9USBp+FTPx75YkXpzusw
	 3z/InUAn6o539xD81Hz+TzHrD/jQpXeyNH6P/e8I6QQn82+73aE0o1Qpa9cP/e3/pErIg
	 KZlZa3WGUyeRrXVoJjlqTY0/ZBI/rmym9uCDWWGlbNAARPwlliLOqXVBoIcMbOVWrxtUA
	 CtO5MQ6xjwICOg4kmUNIGRlEVhFu9wZpMqwKRvQuFrHmcfvBoZxsrzBKTnQ4PKdat3TSY
	 tppSYk4kIs3BJFAkhWoxEbAcjRzQLC4ohmPf39SpMN8xwzgHvyxDAcH268v8Tj/9Qsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ivmQtbJSLjVVq58bgQ0rLKZCVVxfG1APlURmtPpUQrc=;
	b=SrZ/xK7i368VHnZaa1pJZ3TwGRSZs2UTe/+0AiZ3v4prtinn7ji5aih2tHSnR0AknWpF
	 JdUqVJ8fPBgsy4Fkg1mF4qJAR6Ayr6veHE/mM1W6W0RA5kQIxC2ATgaa03FfxY07sxxV+
	 ZM7DTj9ycoprjXiS7ketFqsydw1gBKYdRc81RDWRjM/Y2HO9cUEKN44ameu1rgjHO7q/P
	 8jh4IHkKza/vdHh8L8eZcjCLTOmBnuTB6z/gSAcAieE88ck2gIK755vGfBOPL8bAnhcqo
	 +kqj1WfvT5f+vCjG8NB9luXaJxzS4zHJHhshm75nzvkOsywbv4ep9A0bl7xusfcyfDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d5xiJg9A;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C0606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 060C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d5xiJg9A
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a208d93758so32397175e9.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010378; x=1793615178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivmQtbJSLjVVq58bgQ0rLKZCVVxfG1APlURmtPpUQrc=;
        b=d5xiJg9ADcbTyBp6au5ua46fS2D4x4l2rTToh4PMjPbWnOdmffQex4flt3tbLUbRY0
         vaqJFgWESNnmdhGNWU4SXdYheEF22kJpLuaBaKotAs5ztQV4za/niedTTVj0MH5tybat
         Pon7jG8Tuet9ttmLObI2KJauqsS0Cj6P4UmjB5ksz1c0UbjxV+meoATu3HX6hSaeIAXZ
         Vns4nrDGVZ+ZzqPrCl7aM6MnHzaPSsdk/ycNrBFm1cEP9EFBBnl9LlW4QJpRKzO0oPtk
         O9yrO6YKNwqi7GY7m2e5waWDMvQdT6HyDbDSDVXveWKDI39ImGlZnaRmv6BAXCNhuyLd
         gwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010378; x=1793615178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivmQtbJSLjVVq58bgQ0rLKZCVVxfG1APlURmtPpUQrc=;
        b=GHpOcMmCJIwQp8g36Ar2HsfzZ/lunBxKacbyxgFsP1lpGEZmmw+f7/VDa/ixWqLkds
         iDZmdYiscrYFSek838KIEfTa08S8dpVfoYF9gDdtTW9kyqyzG3bVMEVP9hjpELkxC+ur
         FGJUKyeLLdugqQUSax3dGyESY7brbJ/gYYTZ/K0msEyD80AskR8gk/nkcutfbayRE9Kk
         zrXsezWdmzxU6KX3m4obmGEsAJ7uXSGA7Ggnt3YmQ1AlYiShK+d5PLLpAZ2ZMryOQf9U
         I3ClugSaHLYAmAvmwgeMEPGKuo/ZZPaRVvoQciBTuLvC4qclyZpnMmmnrdSaITavZhzh
         xl2g==
X-Gm-Message-State: AFq9FYLsJn6GI4bZs980TPkbdEp1W7miZGpawTg6X48tqHRPHGw8Rrfi
	0fUU+ccriS4baKz8SdHH7YAtt5kQkzNUVqZjbQ4xileI9wNOZsTaDEX8eZvJP2UEiFc=
X-Gm-Gg: AYBFou2HTRM4qdVlVsZTpqLhQYtML2ax29XRbiHIlbjFmQfHDjTuiTnIUnrEn8n881X
	XVUPSpd37oJGO+hoTFjn5SOz6dEoMRJYwgnbIZiE586n8WEHhOMeg1+Isr2Sm30LSzy7HupGBtR
	EdMtn8gSytN/SCXoTzHX1czCBY3L8utq8LezwhJ3OpyYOOEQq1UXLKHnxLrvFm8ruaW888qI1Xw
	zrYuFjOgVYSy+nXfXCmtzhS2qTjNtoZ3tzPjTSR4CDFh/Ugqh+RNOWT1Fsf8RCP5fheMXH8w558
	93GkhGSJzZk+uBiT05h0GZz0hNzbwEC6Im4h8LxbKN56jWsr4ommLF7G5u4DRGheyCgq1yczwrT
	USyOS246ic6ZCz90xgaNGKBbWjevqMlP0cZCKWQFS78psW5Ks7nDydkkhGoswcnhS30ZXEB2KRG
	Dse8y59JjNViKhfOmQriTWlvmlyZzz1PRTYhWB/n4RgbYDyxcO5bF1fRpVePZ5LtcxA4wJuUeF9
	JPs27T72pZ/DOdZGqLRMK6l/Ncy/eKWEjWlFbhtElNvluCAIp/xgmbdVb7Tw+l3XlHKRziHftBy
	quqMAyZToXh/OKo9kO42oiZLJjFMU5dSmJBDkBNuOKTbn+rLp6z1YD+BxUkjy1y726z2udSN/jf
	/+I/hKVeqQFHyB5dXo2hAdalVsisuTfSvex/Xe6CDeXMWoCp883jhGDjsE67BJKnyCAdW8iqMiN
	5V
X-Received: by 2002:a05:600c:3b93:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4a35acb0791mr127494695e9.28.1793010378338;
        Mon, 26 Oct 2026 03:26:18 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a5ea0df763sm94454865e9.3.2026.10.26.03.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 03:26:17 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] notes-cache: read the cache ref from the given repository
Date: Mon, 26 Oct 2026 11:26:03 +0100
Message-ID: <20261026102603.32377-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
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

notes_cache_match_validity() already receives the repository as
r and uses it for the commit lookup. The ref read still used
the_repository.

Pass r to get_main_ref_store() so the validity check reads the
ref from the same repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes-cache.c b/notes-cache.c
index 74cef802bd..ccc071ebd0 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -20,7 +20,7 @@ static int notes_cache_match_validity(struct repository *r,
 	struct strbuf msg = STRBUF_INIT;
 	int ret;
 
-	if (refs_read_ref(get_main_ref_store(the_repository), ref, &oid) < 0)
+	if (refs_read_ref(get_main_ref_store(r), ref, &oid) < 0)
 		return 0;
 
 	commit = lookup_commit_reference_gently(r, &oid, 1);

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0


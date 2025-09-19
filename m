Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496A3191D1
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295009; cv=none; b=Jdnrlf7vtMc+uTYMZv6e1H6EAEgfQQvfJ/Jfx7ICpw0bdfAh1dfCR6Et8Jz1+qHHmso1In8BhNep7O0z13NeVR6oNFQgBOuPElzFCfgCt3lDepkL3CLGbPUz5PIu3/NXhxpuZHwukZf8HJVrPDr9REKk5apDWc10TxFy/MLdxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295009; c=relaxed/simple;
	bh=uIOjxkSjQMhtORk/LXq/CZ06lygjGPl9+YgHKr2p/b4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r5oUpnAubsStkPdpOJ+E1cKaSW20s7oZz+LqPM93JLkWgxK66PnqF5NpTBH8PuK//05f+/C9bQREKjdffDrML4ri4XcXaOmr/R623KOMB3MHLV5oIPyqUVO09T6nzkRkg8LxWklu28VYWgvSz8+CzXBWDPz+6kYORyCToUwZBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns8/2hjY; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns8/2hjY"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6234b298d84so1153121eaf.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758295006; x=1758899806; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUGxeWwiCbTLydwvVNwuYiY4zQ+m9lgJ4VzlvPBzyew=;
        b=ns8/2hjYtWBIw2vRwOX1YRDCuorgPByZTxPCvKcv9+b5eJvI9DZyvakdJk1Iy3SJ1D
         HVsZ+DiYGAAtW6f6YFFv3YA4RkK1Pr6SBNPyQ+KmgjUL5XrvDGvdbhh2LBm0jBd6nmzx
         OtwnT7WztwpyueLHOuv/1X3hAI03PvR/kFZg5A6PQ7ayMgQ8Lr/viTiXsnmcENyuxO3q
         qGzvuvWWNMG8Bmzq2G3v85AW0xwPm/sDQkXfTmfLKrSzJNhcczDpdzcL3XnbzAKikZkc
         JifrU+GQr3BNicdKLi5i6aTE/Hg/YTbB5G8Vu6MDpKonpjDdHo9tEBOm0qwSbYzQFE7X
         kR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295006; x=1758899806;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUGxeWwiCbTLydwvVNwuYiY4zQ+m9lgJ4VzlvPBzyew=;
        b=mwWmtG1T06FExW0dp1tM7bgm5LL7SUTpO3rL6q9rZLmrS5u1va+o/I5ErTTKAad/ng
         b1bLLr2Z6jkZVCWtKEOkRBXPmLoilEQrbLN+hmqoDOV5v2tJdvORky8pY25V1vfaXFFl
         CXd/tJaDHqWqS/ar9AXnp99jxZQ4y95Mz71EQ5gtNnmElC0DLXdczuOX53YlEx2fJIwm
         1ORWYYeg8YpfSE42/7yqk4mo51V5ZS36NZ+bU2fWIw3x9Ig8+GJ37ppPQkuB/eOEmrqq
         GcuWawy5e+zlsqOdTcUO702UoMN7NFvyFyjnNyq34MR7b5g0/7KFcR+BYBjE4hlrfqO9
         YfBQ==
X-Gm-Message-State: AOJu0Yz2SETFxx3Wi/0uXihFL7u+XldxPOzVsAhT4vNs0eH8EK8zNkLr
	+qdGCUrilNtIaAGaXMoMp2++Hr9k2SRj9a7ZLg7kP4Foaq12vUAW706UIePFt1LE
X-Gm-Gg: ASbGncs8ji8+8DkWLzf324pVPIvA58f01w5umBalVpYUfuFZ86BZZsIAiaKiEY0uQYJ
	LHGkd6fMaYwXCuRCGubnlFftSSZ8panlLwMF9DPoy7ly8oanJrpL8s17Hv0IwmvKFoOn0WprhLZ
	rHhQACBR7rqQ+DDruU6qrbQ2mmAAhFB4DnxNXSmCwgQyr4fwqUm+JligSBADoqQTW7YCgVTlasL
	6BxPmcqI2mGv74JO0EmF3BDIpZcPdR5cOm2v0+hdqTyS8taiA0iPllv83rMOdY6yy/+pchOg4+X
	9Sq3bNEWz58B2haKeIvyo3Owr99oXY+tZSNGE40NOL8b4M96+UOP18kQtDl7xgKdkHFVc2cujpk
	FSUsbn00RoubOm4rT0wdhE/gyvQ==
X-Google-Smtp-Source: AGHT+IEbNv9BisRfftqyllOFfMl+FoGAuxX8ALUV0R10mNQZFz5stb4ez/Bpsb/9sXwvivOOYSYkzg==
X-Received: by 2002:a05:6808:2186:b0:439:1193:fd1b with SMTP id 5614622812f47-43d6c2b923cmr1638193b6e.39.1758295006138;
        Fri, 19 Sep 2025 08:16:46 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d546005c0sm2241466173.65.2025.09.19.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:45 -0700 (PDT)
Message-Id: <e1e94107c9722b751d6111460b17e02a7ffd96d1.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:29 +0000
Subject: [PATCH v3 07/10] xdiff: delete fields ha, line, size in xdlclass_t in
 favor of an xrecord_t
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

The fields from xdlclass_t are aliases of xrecord_t:
xdlclass_t.line -> xrecord_t.ptr
xdlclass_t.size -> xrecord_t.size
xdlclass_t.ha   -> xrecord_t.ha

Remove aliasing from xdlclass_t, to reduce future refactoring mistakes.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c39b65fea9..43cebf6721 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -32,9 +32,7 @@
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
-	unsigned long ha;
-	char const *line;
-	long size;
+	xrecord_t rec;
 	long idx;
 	long len1, len2;
 } xdlclass_t;
@@ -93,14 +91,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 
 static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
-	char const *line;
 	xdlclass_t *rcrec;
 
-	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->ha == rec->ha &&
-				xdl_recmatch(rcrec->line, rcrec->size,
+		if (rcrec->rec.ha == rec->ha &&
+				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
 					rec->ptr, rec->size, cf->flags))
 			break;
 
@@ -113,9 +109,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
-		rcrec->line = line;
-		rcrec->size = rec->size;
-		rcrec->ha = rec->ha;
+		rcrec->rec.ptr = rec->ptr;
+		rcrec->rec.size = rec->size;
+		rcrec->rec.ha = rec->ha;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
-- 
gitgitgadget


Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321F489864
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733223; cv=none; b=cmZX5TPK7geZAcdfP+kJGtfZwRDd98s/qLHto3EUXn6zZLABm7gwK5uDjMjxAtHLU6IbHBVG8B5Az2nvqdzDJ0WzrrnWksYIkhdGZVyamvHIxlNn7PfHWopYOXF12y/LG0H56Gb7bN+tWtIJP1qpoTo6YoCw9JLpl6Hz7l/d2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733223; c=relaxed/simple;
	bh=bDRdU6X28jeqk1Nb8Mq3y7crlV0Wbg3jrKseEWa5l2s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FE9FXBVdg3alF9iIjc5X2U4YaoZZrp7Simp+62sT93QRUakf/7Mc3kLYO3+JATPfvspOi6t2Eqdksos1qwFa8Lh2FO4OKux74rvzuYoAnhzF35G0FQSQRFjYPjn2d+CqEIKSXkvlhaZNfqh2sSe7R6/dY1W3DZ4wNzWrmZaPS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0cP0Vgc; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0cP0Vgc"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ee37dc91f5so922695a34.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786733221; x=1787338021; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a3qiuYOgPdZT919EnN4a+XjXqBsrCeqENBZ2aM0SCxU=;
        b=a0cP0VgcVon/YhMcwqzFwqTZghNSUTPCL/QBjP6x18VNtYD4J17qV293vF+Z7oXI80
         L1tfvteodU2YQeD37l39FCItKmxtcJIKo2hcerA3X3N+DxVicjWgBjVrgJigyrv3D6Pu
         DEo7hWMBEHprBrw7h2/X2185QLRRQHbakCia7wb5ywrbc1O/TCv+j+lEXhWYDarkuDHu
         BinK2hyOD3gmQ5eev6DLdi7XYUAavvVU2XKMmijwzAg230SlLgMIVUaS+tLDCwG19r0F
         4zjmR4ATavQo07bSxhOvKACuHG52HNCSQ2vI8qImh3acdMyuusQj37L+3w/NVCF9GqLJ
         62sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786733221; x=1787338021;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a3qiuYOgPdZT919EnN4a+XjXqBsrCeqENBZ2aM0SCxU=;
        b=kKWdpSyCq4P4Nk5Ou58SKe4MyoSP+VVAgACorL6cn69uim/tPIba1ru62+ONrtJS2z
         Y9GvQn/9/tFShCyDwJJEdMtQZHI5UdNUmMOs3A7d5vJdYV1i6jKGGxBcfGah/wOhoZLq
         dW/NO/yYkKbIVGSoC0hUpn6tw3JMASUPyXadUN78Utll4k97sx06mOWCn0wrrkhdSE2d
         taiwpSVg079wT3BTWnryAp8o8fVtRlCRkJ5ZiSLPNMooj9+6ZMfa4nS9/h28gC4N4kEU
         +jtpJ6vwrtUmXQLJmK0PpL0D5XkJt9z+hSWaN4DGudSfhKvxCIFAnKrODiIpsY62PgZP
         5kCg==
X-Gm-Message-State: AOJu0YwMxhi6iH0x3u5gngucuopxREAH6YySTfAa+ETRXGcSywzHWk70
	/s8QFoSmyfNoVHnkNTNVWg9B/t8MlswT/ajP0tDxsNy7o6BTvYSM9CA2wwjeCKdg
X-Gm-Gg: AR+sD11xqEqD2tx01zB2nW7MnN6gddtyzlNe3dfsfl8wqBXwDjk5POSgSznqsE2e9OR
	dgqaPNxezucM1+5JuHD08itND83UYEwNDDi+y2Qe+nUPOy9p3uiYydoIB8/szjMCNxjzrwNHT9z
	Ft/t5/9T/i+4Xalkv3kdBFiMgSS/SDvIHk2HVGKyVbitoGxoHIcHRZBc154rq0nC8fYF29jlUGx
	CcySjXo6FvtvLOI7DSChwWswgbHUdgfvuN072LbPiIIjJ8sSKf9Odb8Mb9XI6tgknKZHHfLlvgA
	deaCuCIu2MCZdoWKK45H3mlETXSMcRstyPUXz2eBb14TdKw4yuVuHoj762MUVvlPC2W3JmCpLJ0
	y7mBF9wAdqzL2PhflBBTUCM8iS8eTnnagup0bSL1nd5+EqjdnnynUexYP+ZFOedRdTCzuyotsNu
	dLUqaRr5XYTSi+M9v9oeJYZa1FSJjWw3Nr/ZVDGtUofQSAdVVQJHmn6MQjUBKlhp8=
X-Received: by 2002:a05:6830:4c03:b0:7e9:bf64:b70b with SMTP id 46e09a7af769-7f3de56575cmr7352306a34.1.1786733221048;
        Fri, 14 Aug 2026 11:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.214.16])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e866c2a7sm1573099a34.24.2026.08.14.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 11:47:00 -0700 (PDT)
Message-Id: <pull.2383.git.git.1786733219160.gitgitgadget@gmail.com>
From: "Swapnil Saste | INDIA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Aug 2026 18:46:59 +0000
Subject: [PATCH] doc: fix typo in submitting patches
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
Cc: Swapnil Saste | INDIA <theswapnilsaste@gmail.Com>,
    Swapnil Saste | INDIA <theswapnilsaste@gmail.Com>

From: Swapnil Saste | INDIA <theswapnilsaste@gmail.Com>

Remove the article "an" before "incremental updates".

Signed-off-by: Swapnil Saste | INDIA <theswapnilsaste@gmail.Com>
---
    doc: fix typo in submitting patches

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2383%2FtheSwapnilSaste%2Ffix-typo-in-SubmittingPatches-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2383/theSwapnilSaste/fix-typo-in-SubmittingPatches-v1
Pull-Request: https://github.com/git/git/pull/2383

 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c269e474e3..c60855f706 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -117,7 +117,7 @@ of review.
   can still continue to further improve them by adding more patches on
   top, but by the time a topic gets merged to 'next', it is expected
   that everybody agrees that the scope and the basic direction of the
-  topic are appropriate, so such an incremental updates are limited to
+  topic are appropriate, so such incremental updates are limited to
   small corrections and polishing.  After a topic cooks for some time
   (like 7 calendar days) in 'next' without needing further tweaks on
   top, it gets merged to the 'master' branch and waits to become part

base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
gitgitgadget

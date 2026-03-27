Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AFF37BE63
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639446; cv=none; b=MNH59raX2ihLbtTaIGxpzJ29QKBqI0zWbiIbLreCT8a9vSFY5OSpAnFjUCwgkWQW9v18HhgA9t8FSIyYnCP3q3YKbFhtVBG021HsyWWYAyA1oR4XhrGh+YGpDjFnr/+khVUODMU55iSbbNfWgL2l/pjgm+mV6EcjaedX2nNmEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639446; c=relaxed/simple;
	bh=BsYr6xo6ltyGFXksY3nnqfxeHch7tDldNgZwhYqLS3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rmFxPM6TcJ1grajVzigsFUv2FLNPToSnRbkbskZl0zz3YkKd71xIsWggxF5Wo3g8lolruY6LkPJBMuFFglfgIotcPL4p7b2HVO8SMvQ6c9x0KG+GVYRN/lorMlCAq6/Z8fhzQddPRiuFLQzXSyjmHSgdt0/tVj9PjC6jcEreIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+D5P/eh; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+D5P/eh"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c0c955a481so2459912eec.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639444; x=1775244244; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9he6Is3IxV1lQSunF+Dmdh8dF7/78h6rZBbm0nKu6o=;
        b=d+D5P/ehHvvF3gHPjo1f7aCl933lXWeC/xNZXVdYiuH4GKN52c4xn3EKrJIENec+ol
         91reFlZY/rQBbqJ0bKEWiQOD/Ek/6lHgSHFTWibV8gyHK/l9UjXCqRf3ICYxyWxSv3PL
         i9iE7h943JYk3GITysR/AyqbCQVYymbuOA65XNssLaEr8TWWYbLrjp+wdM0+/NZz4PTl
         pNfFM4N4OovsH3RDh7IYFJbqmWBFKGiloGWrRgI3LGXFodTT5xRXuE+BsHvfDmDfpg9E
         IfWe2CzAqc+wzTYBmB0eaCXM7PObw4U+i7vcQAXh5nXTow6tuX8AfhL9y4zxYwP5qaG1
         Ic8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639444; x=1775244244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9he6Is3IxV1lQSunF+Dmdh8dF7/78h6rZBbm0nKu6o=;
        b=QYf3Poh4rgH9CYuzLAFX6FZVAPHlxVKbq3JvA+mxvoKTA6+Hync1H7328IoHUJo3KH
         pz6pYdfQTGeAJCO9Wd/zyUo2ewOaUl/UGAqu6KQLU+KgZzXRwOdEXlzfQNIJrU3vkfPS
         kj8fPj53SyLtVDzDod5wUMmQbo4ZpXaS64kFNhMXcgQgeE1sDKH7K41k6S8ktIk+1VVT
         gB/oV3uQySOtiyVQkAvzPASTkZtUozZh28tJjXY3oUBWUxngJFlCUXvf+8QvN3LGiejw
         9h1NxdxM7zsu+5UuLeS3phmwME/Gv17mwX6RIgcqp4tHZWHLWaWaOsmBWG8Wp5bA84uG
         n8pw==
X-Gm-Message-State: AOJu0YyRjvR4KgVqoRSPoKknSLGOpsIuSDp6B9AZRHxOne/P2ZWekHrh
	PXtTUZ7tqUUgZ/H1lAibwz1IZw6c6TBCNvAccFAXBTeD2mBa5NFu2tuVCSmeTg==
X-Gm-Gg: ATEYQzyosW8UdYMLvDll+VMoM5STplX6YFhdjt1m90zVCD5wHAvINGeLgxsFZbAQ4hH
	Kd2cgC8gSnVHIRNy+/QcnEK6nXceNXYZbCvmLGNs4PqFiizeInHc9fmWIgeYvlbcoaPLzo+NHpw
	F0/Hr1zNH2qgaW8lDgNr+BvJOj9igdjpALNoW0giPQKiNGFUOvqqH560RAWz4nOKce054FJQymH
	dDpPHcepwbnyyKqRaYOdGJlcvxmgMtrr7zVmBikSrTf+nfwtmNu5Y2vL4zVf8N8KiLWT4r6LLld
	xNm+o/XlaCXxyAV1uOdS795uwl6H6y/24w5gyw1y+LH6yRIXWKJkGIE8iJVB5QeLZxagpgfbyEI
	fFy2da4M0qUIJ+ZmwmUWvJ9dbWpbL8FFOdHLmJJDCYdybQhM6S6aLmeOmP0j5Fe2MLaE0/DR7Uq
	L+L21eubygZi4iyXiveVbREYGuWvE=
X-Received: by 2002:a05:693c:630e:b0:2c3:3df3:999e with SMTP id 5a478bee46e88-2c33df437f8mr792229eec.17.1774639443762;
        Fri, 27 Mar 2026 12:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda07asm224119eec.1.2026.03.27.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:24:03 -0700 (PDT)
Message-Id: <ecc25be32f394280f3a1a59418140254d7b0811e.1774639433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 19:23:52 +0000
Subject: [PATCH v3 5/6] xdiff/xdl_cleanup_records: make setting action easier
 to follow
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Rewrite nested ternaries with a clear if/else ladder for
action1/action2 to improve readability while preserving
behavior.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 2cf1f8d1a8..3d5c61249f 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -303,14 +303,24 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
+		if (nm == 0)
+			action1[i] = DISCARD;
+		else if (nm < mlim1)
+			action1[i] = KEEP;
+		else /* nm >= mlim1 */
+			action1[i] = INVESTIGATE;
 	}
 
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
-		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
+		if (nm == 0)
+			action2[i] = DISCARD;
+		else if (nm < mlim2)
+			action2[i] = KEEP;
+		else /* nm >= mlim2 */
+			action2[i] = INVESTIGATE;
 	}
 
 	/*
-- 
gitgitgadget


Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996473DC4A4
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890014; cv=none; b=CIX+2ywupcAA7+abXIyxI5k0B13PZATcoZAXfhQQAr6VOl+NKcVylahnlpr4Oc55m46FUqidD6hpm63ATY05VCC8xbR+2hiNTY2JIkdMqNKkN2w9lHxvMr+RlToSUuQBFxRwFlGRI+MIBklEtF340wsSMxnQ3zwU/sDIdpJnL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890014; c=relaxed/simple;
	bh=FFuhpmWurBjKOyq7ATY2jDO3nPkj+6D15TG+n68Zw7o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CNtnu0wNcn3r+AyY8do5rosjsqDvn7qTz0win0O6vubd0ruvVoY17noB12o+XXzvUkDyqs5joO/wtXvTY12CT/Px0s5ljt89UInIOCn4bCgdp4GpufFrHEvmo6mo8YLtrciic41h3tJUhtmJmFXFeeCSWsrenIN9Vzgp6NqUHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSLL/rTT; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSLL/rTT"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7ebe11bffso3866755a34.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890011; x=1775494811; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhRbJUEFrw3P/J0Ivta4Wcfd37QkbrMiHe8YvmCL7tM=;
        b=DSLL/rTTwDjCwqF4CgZ45+2np1/aWvIPp5wXtd+Q3uYmd6T6/sEabUhcpgFsDNrT+N
         foYDpXjk42PucMXnfVhErcV955igCvlZHYE4JwnsbzNqSyn38MPX/DndqIzDq+NjLjsG
         9GVPWYAnrmnEZ4O39ZvzdtT9BMCkd3YHUlcVC/ePGZ9QHN8BwMuf/iIXkg7P1aBEQGj5
         u4fO4L4QD05RQOTU2/sBljw1ekuD5THcHMnkQQLdgC8pbdB0S2yhVBTXRMjaxVItsvCn
         fP2DitvcCACpUEQstD6kR24IjJFhSDyIU5rvS2yCxqPPiqtjXDvAlWUP1ub+464noIlv
         9xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890011; x=1775494811;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhRbJUEFrw3P/J0Ivta4Wcfd37QkbrMiHe8YvmCL7tM=;
        b=Y8ud3OQ0MI58sQbU96U4qeSmmPRWIZjrfXRYO5dVnlLSobjybpA6cAiu78tysIdJuM
         Z4hcFu1uh8gl90NIsVa5YJ3vzZWV1RvNkT+v03iFuhIkaQFe293qkQNIun3aa4OQzY+T
         XL9cRGX/9Faudhr5qA0sPsJ9wjmAfj0eW+WOupDRzU5OMRK2/RtMEvQhgW6+Vm5lQNIj
         MiC+H7cK8SakMh91yiaHfDqeqhVHKCfU5f0dUsdzhbYRmqxnRGXNotMhm2r7fmNFixUl
         5xI0Mpqgbmlq8x/9pXBvZlTlzQmK3bbpV9/1RpP4MezwvLoIeL3YXmZ8nQd3ZxOgHm8J
         tjdA==
X-Gm-Message-State: AOJu0YxOkaNwZiKwMsMGJvUy1G5YEUuGfMKX+arygTuaP31x2J+kEPor
	hA88xPZdNYnhhPhXwSaGGWb6Q21apmhaDR1rLti79HLjw1WarIi+dxofSQnZiA==
X-Gm-Gg: ATEYQzw2VOCmls3JGDgYJ+dd4CXrZ2thoSCWhsJxCAfsa7ch1AvqmASF0NhyDO6MlDI
	V8yTc1RZwWIfhyDQNv2dILDB/+FKZpowdnL+CMYgIfXqV0LqDppnakTxyL76Ay2lrnF3hVVSYS6
	M2fUH67ZvG8hl7+cidGXtdiYrpsWIYYBHlV27fIfAn8K+JtjcbehJ1nPa+cDk8jdRaeuQBD3YSJ
	7d4f5IDfU46wOBvwTDGBjyq52+9j/5DWw3M5XfuE1r/CWYZgzhLYan/MGZHjkbWR2rc0G3wbFpU
	DOjfsP0oSlWoG60Gods1Epy/vul3OGWYiqakVJttGRyg/nc3e9mcGrtS2jRTcEvs9vAZGsXY1Aa
	pJ6jG0lyX2j9m/qExxEU3Gv+9SevaUjrhJYkA0nMQtiQYwxD1KR5zJbO4b26mxuHFpKe3zPmAKg
	f7ujfUZtg4P7M9UVwRR4bENs3T8/c=
X-Received: by 2002:a05:6808:17a5:b0:459:9961:5114 with SMTP id 5614622812f47-46a8a477a8bmr6633713b6e.16.1774890010945;
        Mon, 30 Mar 2026 10:00:10 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a9fe94ebdsm5060125b6e.4.2026.03.30.10.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:00:10 -0700 (PDT)
Message-Id: <75fe3ea1250ab7dfa4e029f49f2ad353185afded.1774890003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 17:00:01 +0000
Subject: [PATCH v4 4/6] xdiff/xdl_cleanup_records: make limits more clear
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

Make the handling of per-file limits and the minimal-case clearer.
  * Use explicit per-file limit variables (mlim1, mlim2) and initialize
    them.
  * The additional condition `!need_min` is redudant now, remove it.
Best viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 386668a92d..bd8baf214d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, pt
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	ptrdiff_t i, nm, mlim;
+	ptrdiff_t i, nm, mlim1, mlim2;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -287,25 +287,30 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		goto cleanup;
 	}
 
+	if (need_min) {
+		/* i.e. infinity */
+		mlim1 = PTRDIFF_MAX;
+		mlim2 = PTRDIFF_MAX;
+	} else {
+		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
+		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
+	}
+
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
-		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
 	}
 
 	/*
-- 
gitgitgadget


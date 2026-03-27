Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49837C11B
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639447; cv=none; b=Nj1S1eXwzPUFVCpzD5C1VwUDyRt6u5XQIVMsJaK3gPKpF4rg8uJE80XDa26SD7lrUXF4tB/cCoRIeT1hxH1FdTrh9koge/SSO14LCWgJeWf+GDgH0mkb6yUgY+vrMstazFmXkHQWbTtyrx9Yzg5HiU2pOGTNYllk/IsnuZiTUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639447; c=relaxed/simple;
	bh=7N8vjwjnsgvfkgbmfsgMhpS+DJVWKnS182FnMKhX93g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=F6aqSnswgXc5qNXgmcFyxNA5ePT1i91LouZzkHl6lBAYJ3NS7410PF0wnVKm27NZv7s9bPZGYubTO4vd92HzLphQgnDpDAAgL7bVmvLr+XSGhZcntrn9WGZ3Jamsgualc/v4apEbqyflGDtyeQfbjy7ezLOlpIn9MLuUR8V9mPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7FUn/OD; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7FUn/OD"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c179d4e1a9so2904331eec.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639445; x=1775244245; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3Y4d38c8IXzwjFOW52mlmYuAcH3hHp94MhQrGhOxN4=;
        b=a7FUn/ODvgQJz6WPxxw8fvJglxB0EMDKe79Q9ZjaJj7MCJabIVsyOUfLhNNZYm/EWv
         QmvfaxmLK1xRtArPaj1SuEXf8YUjaBrC8BXNh32YjvlvVYswB2T0t7j9yQizsqvuvVTt
         UToTnO9L+sZ2pC9y6FJZ0pU4gntO6E653IBl4npGAYbkulkipJfcXooL/08uQyXRt4mp
         pW3rdUFPVJ2yc4SnpY5se5y8iQxSwFd+yg2XSPARepBUQv0DmzcxKk4vAAJiBPMyAM84
         3QuA3HwLHH2+7ui+OX7JdD/VuBfGHHzaq85wYaVWjlnTPJW1GK32KvbyIY1pznzW+Mun
         Av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639445; x=1775244245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3Y4d38c8IXzwjFOW52mlmYuAcH3hHp94MhQrGhOxN4=;
        b=rao8VOCuSFbr+k7AISjEXBZPzufSoTG6hNSMOL/nHVprcim9nZGJOF+K9pLsh7DJNY
         UutbFJ4fGWCkxQlUv7cydvBfIyZ1jKASQWsKBQ5xGKQahFFaFfNrvhMWsXq5gSoiifCz
         m9rIeoNDE4msv0+DKe7ItwjiHdkWlWD3MrCi65nYOEJodHuirzbz/Plbyl5uVPyrByYE
         CAkX1vuylh6lag63rNN/eYY9AHdM1X9+QZklBxVSyEuZzKg3cJ4OGfgOVOPj77ik3U3S
         IvBMA5w3iEZ+L8Abca7xWEGeblfjAy5zrmGlRpQfWE/1DZAkh3fBijBL6eBRyZyHE90b
         SZOA==
X-Gm-Message-State: AOJu0YzBwmdRSAtLRFnVGC3j3i6wgNgFoiDTx/7TE9RwHhgc/BsM3LT7
	0LeDH7vRy8cKejt1/kO4JDLT2RNgplXjVW+/GjYQo0STiignMwymHfhDlo1Xdw==
X-Gm-Gg: ATEYQzxZkL6Yr5uDAxZZYZYExOesAQGEI77UQrTurLZeSJ6O+V/o84TclrVA8DKWD2z
	gSnOq9UW/qq3qFuEbRCcs6e6TAo5AZkDFVzbReeA79POmUv476/6m/0ragibuI0bLchKLS1pxGe
	bH3HEu7GYKPgy9qfUgxK/r279E0wG7+o6Z2FddBfpI1/7f6+/WzAsZBjAK1knmcqvVHoeFuyuHW
	VbpdqFqGdrUDRAkn8emExn+OovtkOauJtcv2R2gCweXBUyqg24fk355Kq1fvFBp0OInFZkLdtCF
	i8MFnzy2n9QADzj1rWOdR5bOYwtFrBtZcoJFoXQUlyINmytSxKpiEjTAHhWGha03KKohnUdbjky
	6jcLW+Bd7g05hyyKAtOGWZ/MA9Ao1vEdW5mpkjpwhzEavwRiyZjlUnjdn1l5kPEIqZd80jwIDzs
	RYu+jTtzkYB3JdPg3Uj3elB/4s5MI=
X-Received: by 2002:a05:7300:7314:b0:2c1:71a8:3845 with SMTP id 5a478bee46e88-2c185e54d8bmr2195702eec.19.1774639445225;
        Fri, 27 Mar 2026 12:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2ff2sm210760eec.18.2026.03.27.12.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:24:04 -0700 (PDT)
Message-Id: <8f4def8814e21f0ca2772ad6a4426b6cca9d1d14.1774639433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 19:23:53 +0000
Subject: [PATCH v3 6/6] xdiff/xdl_cleanup_records: simplify INVESTIGATE
 handling for clarity
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

Make it clear that INVESTIGATE is turned into KEEP or DISCARD based on
the result of xdl_clean_mmatch() which reduces actionX[i] into a
boolean value.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 3d5c61249f..195148442b 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -329,24 +329,38 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	xdf1->nreff = 0;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
-		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
+		if (action1[i] == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
+				action1[i] = KEEP;
+			else
+				action1[i] = DISCARD;
+		}
+
+		if (action1[i] == KEEP) {
 			xdf1->reference_index[xdf1->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action1[i] == DISCARD)
 			xdf1->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action1[i]");
 	}
 
 	xdf2->nreff = 0;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
-		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
+		if (action2[i] == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
+				action2[i] = KEEP;
+			else
+				action2[i] = DISCARD;
+		}
+
+		if (action2[i] == KEEP) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action2[i] == DISCARD)
 			xdf2->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action2[i]");
 	}
 
 cleanup:
-- 
gitgitgadget

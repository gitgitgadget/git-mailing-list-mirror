Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3723793D3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890015; cv=none; b=KkMH6F6Poe/YWjixRhndA/Ce6sPzyX8ND/oOrKEt68pdBwVjTbaZtbReeLJsLaJOmtkisgrQbp4P1bFJ8c+UZ+H2ZfRcLBJz0PXH0ML73fNiJ30fWo7nGF0gWV0ltgxc/97NmcIGgkGQyRP/9wId7HPiSnOoV8LzS2Ts6re9Xyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890015; c=relaxed/simple;
	bh=Xg3vvUdf0r2bEgKD8K5Oc0cxjPBASzpfWNcgksK9eQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XqC3uLh6ojIGyniC025vITSNTnSg6085rkdV6Z4eNfV2dHB9AuBPv/skkka0fJiYxMj29kil1DyoKZyDBuRtaafengboYNIUvAHA1HXY1LYp+EhWMuLfk73DoDgUSXDPV/Ma8ebeiL6xjiBA9gOb1Hpeu28x2lgyOuCaewHZREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZwMCcKL; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZwMCcKL"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d9b1c57a4cso4126806a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890012; x=1775494812; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1pAK0ryeeAXecnEoZZnQkotgHR9g+vtvUR0S01ezx8=;
        b=YZwMCcKLLR+4UZNQ69hgZaN+6Haj9DUOOV2i8bfRMVLpjGgItgZco+EKzmwCC7MDYi
         kPN+aH1wR5pYkxYW/IFjrLaDR75+LdZqYtK1PjpJm2Vr28FSznueyquIcQlG6HIqGjT4
         zq/duBQhuK6wHvlCOUj1ct83pxpJdv9QzOroOdEm2QlSUrAmDUPhn/ufaldujzcIeJm3
         dg2QbbnC2a0lLs+OrU+tJz2s8HAy5GbOgVePjR7/MNaqUmI0/jfHH91fgkYKCcGqLj2Q
         +qIVvczn9k5IV/G5eO2MUp79ktitZ+nWOdPNcXwNmrK+OwpL/jM02luKUrbhrcu4M8Y1
         bxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890012; x=1775494812;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1pAK0ryeeAXecnEoZZnQkotgHR9g+vtvUR0S01ezx8=;
        b=f7HXu3726m/2k4H8GLar0iPsWXsSJZsHtmj2wqEa/QMkxIjTKhopOLlI/JlL80wmde
         BTqI41F2HCuVhIa2UTDjLMCoWTrp4c6f7Fga+fqxspW/kPJvHG4nY+hcaW58igoArTE4
         40VYUXqDvNAn6srOmr5fiodowAYo4wRKfTMEyuCuz4JB0w2thj62zUiRstqucurNjbue
         6HufBEo5pn7oHWpBjcGfycaw83f54n6nqtXpl+HbMeDFTC5F+/nbOXkC3RatcGRY97L2
         ulYhjXr5Y+igEQIZGnNAtNA/jXaT87Ozn7ahnvBnyT3rWfUVkhDVhQyHU2TMTsLB4cw2
         G0gg==
X-Gm-Message-State: AOJu0YwI9D3AQG4vgSl5Dd9NHGyYlFuHz8OBO/GGb/X9/1YIa6LeutWW
	4Sub+6uHDGd6bLLDFIL/8iLMX4a7SyPqnnu2ilGHE+cUS1WSFy9sE0hI5GemQA==
X-Gm-Gg: ATEYQzwBHFhIBE/it8HS9LFvEdbxtkQG42lJRu9kMOR3TksaA/PiIsCb+M+d7IOlQyv
	4an4cJiTguhlJodPSqlFhZKJanoyr3swDo+viXzymDsqIrqA6PWTYt4Aq1Tu6Bwi29Ym5Y7fSFe
	CU10nQD/TnMEtSmcCMjSzJ2tRzmv/X1YAK/Uo6E6cAGrJ4vg+xlHPGAIjQzA4fS27ejhhsc5RMD
	AgQxfL8CcO/D0V3DLQ4lHdwYu3WOzh+72R4E+aDlCp1UEBFev3oqCkbXngC4FkSV5Z4RBzNxmcf
	ANz97zU6z2MHk0Rf8iCF3D2a/vYdDbArKSrJ3IjElgh5JaSHAJfZn5PxkRneyC1Lc/Lv9Msocn1
	WISJ1bP8/wuIHRaHgJ5np1pZUTIRMeNo3DXWmksPSYerBxbAELtIPGY2hh396C1o0FqAVcKNCNL
	nRIBCyWkqNU1kvXZic5yGWE7Xj3u4=
X-Received: by 2002:a05:6830:67cf:b0:7d7:da1d:4472 with SMTP id 46e09a7af769-7d9faddfb26mr9083528a34.8.1774890012263;
        Mon, 30 Mar 2026 10:00:12 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a82760esm6138636a34.23.2026.03.30.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:00:11 -0700 (PDT)
Message-Id: <0cf1412d01cc4895aa945b6f3ead3b2d79716523.1774890003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 17:00:02 +0000
Subject: [PATCH v4 5/6] xdiff/xdl_cleanup_records: make setting action easier
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
index bd8baf214d..471d9567c9 100644
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


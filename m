Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B63382C5
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473074; cv=none; b=gIbeICK6vfGubrMHVwdM6Hm7IajcOigtBeMCdLc/42t5Eb7ktyOsWqTkdDgM0CEmYWqyQelC9IDMcXn9TxIDyhSGxG3z4krAKq0PTNwBvNg9b7SNHNqHUb4DXBE+daA8Ebf5PWqxNyRkwvLsp0n2Ntn2Ay+pGkS6B4l5rgfpKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473074; c=relaxed/simple;
	bh=DcJLORpE0JympVo+xIkJoGLmruU5U+8myRzjyPCRSL4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i0lAEa3tLDC+InC6WrCs+ynk53tUCohoiZT0E5XvieWyNsycFiH1lyZaHnq9st35X/+OvEMxNHqFi6x7XACEpWflqM8Pm9/bSksgY5dtsMr1F5kzKOocLj3yflQaGpPBiVe+C6GZGg47Tt7ytOyBev96uLhkXhRvmTSA2DL1i6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2GqMi8d; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2GqMi8d"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463a0e14abfso158082b6e.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473072; x=1775077872; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBouSEtOq9DnVWWoshE7EiZgyPT7gQ1ADOLVLwYfzw8=;
        b=G2GqMi8drnuqGAvQn7iBC372pFc/H1pz1+uYvXBn9H/I9Eg1OrM5fV/vslsOwJX1Hl
         ynJu4zf3RTvdHfQOYGmlbXlHLikWEg7mORLEs0ZY1+LkE7KzO97YgHyjTvxmMArgGM/W
         yje0YTQiydWfUxyJmgVMrsViF7s/rmbBXU6pNWdoLf/4ylmfvpgWNrQ4Z1E865ozYQaB
         THe1cCXKw2h2JuzZGcPW6Fw3hvA8Vo3Ne7lrzASmljbpDuKitqPSd/WYR5W+VewRHcDc
         T4P4CZn5q/spJ4oQ5lGUaJvm1aj5MaeTWNpTl0HqDdMlR7zfEchlMO0nhXwJtJtGaJi4
         TD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473072; x=1775077872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBouSEtOq9DnVWWoshE7EiZgyPT7gQ1ADOLVLwYfzw8=;
        b=WfUWMqeTqeX7bjZ2a0xeFZ65+aX8Q26AYIw/IUD7DGkI7eC3Hy2izo1bKMSp/LsdR5
         /Kw+a1CnKFu2VLWOKatRshSEWgz+I5AASRSEY/5f0uoEcMWJuHTMFSu+WfdO7nE93qaA
         tFdZvob0+vUW0QIjP/7n1mUIL8Cj8Apx/+V/8BzQ3Po2TIBjPlSZn6hyU4JB+SkvZOEB
         n8sY3zX7Zg35PACV/5dECfpoVfXu3rbWPsgPjbHxRD6W7W0ksSqDfvAei3fshuDWMAlc
         IhDP1G1We/hJ7fpGMat6WEJh2JeakfolZq1vHFHP0B1tCda5Kipp/nfageCjbCW4T+Ly
         scUg==
X-Gm-Message-State: AOJu0Yzlpbi6MP+zMX7q82uWeZVspGQ4tTHlWQaB3JXbYB8NvpAh3ZU6
	FO1WQ1tAJi6b8FEJhtx6H1vo4P8RWu7M6n9Hu8X9AcncDhmy0ViW0uY1UphdyA==
X-Gm-Gg: ATEYQzzbvXtS7WvlkjhohIsc6HT35w6i9a3t4tTIz8X4+PHNKGJpyR9UOlHiDhZQk+U
	SPc3wapw+9b6OSxD39CJz1KE0drXIEuCQMzyMeRAdBmGMfoT8YMVEiBqcPx3YzNv8rFqis+yHU8
	X4KsUQiYaq8jMDEooiOkp5hct/r3oMxo4fOynN72k4+9D28lyQfHc1N44va5EJ4Cw5aRLr0CoSZ
	FTNdAIqhgh79LIK2/pZkTO73CFCpIgVgdwz4gc1dHqECeE7uokCENb4XH1++1kJZXBeGpd/TUre
	v8EE2wPezvCv+FtwFJKprhRmb8EV6rmEdHyePXkYNqs7y97wafKQ289z7EVqE2mK3rKOlTSlhTX
	9P8SSNHXC7qwqFkg4iw4tnIpeaLCOIks2+Pj3AlxbnlDCrBxklZND74ovh1KtHrudbFrmKJawQ1
	9tTZHOvJdf3TR5ebBJXp2gC3DYhA==
X-Received: by 2002:a05:6808:d4d:b0:467:237e:ba47 with SMTP id 5614622812f47-46a5c58588fmr2626823b6e.1.1774473071873;
        Wed, 25 Mar 2026 14:11:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.213.176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a70634329sm417049b6e.2.2026.03.25.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:11:11 -0700 (PDT)
Message-Id: <8be7e4781a9914e7f051a0fc94cb5bb79e258304.1774473065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Mar 2026 21:11:03 +0000
Subject: [PATCH v2 3/5] xdiff/xdl_cleanup_records: make setting action easier
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
index 756a5b8dcc..127848b764 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -304,14 +304,24 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
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


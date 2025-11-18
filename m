Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A42D73A4
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505277; cv=none; b=S2dxB4iYTbo4Fg8Z+UaqHcunZ94s/ac0cbvABmy2DgLpS3ciqmjLiDO8rUn4sknDorRENOu5UHeoW+zsMgJdPNECeIhQYIW+Tltq+9NgyYF0hfwjg5d4s1S2M9gOSAlv0aAZiLYC4YJJB/w+GIwwXXnbxbWwbCDUY0/77ttIFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505277; c=relaxed/simple;
	bh=0l0uNfdTXQwAys1TiFYPI0Eom2VDpTAvt/mLI5cH8xA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LslgQ4I/jQ+vLHaLtniYwM6Em2vJ5ULSNq5OzzII9qz0xJuifH50CS3qy0hHPhz7b2am4rZddbleVByYlbRr8/l8T53E8LWl310HHFQUbueEPUVDUmZoFRhDQVPKL/CCmLAril5teqADw/nEOZXwfzVAG1VBWTl4Qc352GEPfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPL4t+Dg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPL4t+Dg"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so5267505b3a.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505274; x=1764110074; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsZ1kBIkOFLS8l+hVbvwVQygYtNzw/LcMnvfOYjlZ7Q=;
        b=aPL4t+DgxDLnahrvmtXugoWpGDkpCdVZ8v7HzvcAEvSaQ2ARs0s1QPoD5p7yOf6LQR
         V2urTZs2o3kNNh/nt0l0SWRzY3FA134yIdtIECs1E2XKKVEfk5/7IyNX/LjOn09qg4ro
         jMpUuvKpQF8Qq+C9zWUfG7aKmjcGdxwOUfrhmyIUO/rFgsR8R9TRxWWhx5gLiz6+T0jZ
         bQn09fdEMkYyknj55BMUA1SQ8wxd6kBieUPYSjqkkUuLJU604DDb1iHWt5FcdSXjdBJ2
         DBBJr1SxOb3cI5q3lWzUEpx6d9aMDyG9san1Jm435hXeRSSQgBO0DehOCFaem7o8WM6+
         SBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505274; x=1764110074;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsZ1kBIkOFLS8l+hVbvwVQygYtNzw/LcMnvfOYjlZ7Q=;
        b=JEq7foE7aSdCtXKMpaOtxgUZLJDCjCSyAgq2vMHxd7OFd47QkrNTNTBtLARl9kK+NQ
         G3c2UK6w4zQ3+gA6P+NL6BICfkg+Oj85PA+ILsoeYk0KuxQQgAKhzEcevc9UkMG7xWI8
         8dCru+Dk/jjUuv3NOKcEk0pe9H0OCZ1PRWWY2jPcxQXDlzlhY8zvNovd+gBMOiO9tMtR
         tYx5Bukh0MSuNVbtlk/54xslQuvE9ERcvB/b5lVO3R8+vT+NY7RRSkN8lebK5gSA8a1o
         GC2zdK0ryAipca7jr4WMaX1VOeqMVTAZgvp7BUJZC7XrtCNWNy7i0TLIqgSkkqt9cho0
         fiRg==
X-Gm-Message-State: AOJu0YxQ+TsklZFxrtTmPMxUyi4cvEj64kcxOWpZcPWzg8HdnAAnnpQr
	DUI5RQv2pW+i30vpv0m5OdOycsQPxmtrEvxM3z5DJTkL7JHPOWAaoJj/LiZNoA==
X-Gm-Gg: ASbGnctahorLRwXrpCdjT7FIkuIX1lZYrWcpS0IfRBOpGROqtSp6jWe5wDXHSRHcqeL
	uibc/yaAQDvMJaMlPyX+oL95RzMj7UrSTX4SqjsNtQwzGBIPQ53fQ+pm12N6p4h3emcwrw9hCd0
	uRmucwd6RE/99YKy5dc4qx5y8X/HE7QsO1PsXZn5EqfaRKXfdyAxF9+QLEWVoPMD7H0LApkPujE
	HS95Rz/T8rLC+hOA6Aqft28ZQS11iFGt8xMYB1X3UWsadTEhyorz2rDcbYbei1y5ZRCCbMz1xjh
	Z/nWyeGBfx4FMhgVcbJ6s5WWR3GzUeR2e0954DJIbPKTSomdGG4b6iOUHzRu/Dd8GKNjIH+MA/2
	5WjRTToATiUCpDNvcIugecbRx/Cl8RAN2h6ZMskSUBI8yNkQXfqmDNfN/iaCpJoh8o9yvt0lnBH
	d9H6udoX7JQMIV
X-Google-Smtp-Source: AGHT+IHxK+E8fkbCAoLWHRTlwS/B8/vOG33lsAiXOraSxO0iFvXIN8cATzSF2y3G6Z6TQVjTMTtJEg==
X-Received: by 2002:a05:6a00:1151:b0:7ab:39a2:919b with SMTP id d2e1a72fcca58-7ba3c080d03mr19172041b3a.20.1763505274099;
        Tue, 18 Nov 2025 14:34:34 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927731e65sm17555392b3a.62.2025.11.18.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:33 -0800 (PST)
Message-Id: <d1f498edb113e925326039a3e6a7fd31a24ba43d.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:20 +0000
Subject: [PATCH v5 08/10] xdiff: make xdfile_t.nreff a size_t instead of long
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

size_t is used because nreff describes the number of elements in memory
for rindex.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 +++++++-------
 xdiff/xtypes.h   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 705ddd1ae0..39fd79d9d4 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -264,7 +264,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, nreff, mlim;
+	long i, nm, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
@@ -307,29 +307,29 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Use temporary arrays to decide if changed[i] should remain
 	 * false, or become true.
 	 */
-	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	xdf1->nreff = 0;
+	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff++] = i;
+			xdf1->rindex[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf1->nreff = nreff;
 
-	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	xdf2->nreff = 0;
+	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff++] = i;
+			xdf2->rindex[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf2->nreff = nreff;
 
 cleanup:
 	xdl_free(action1);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 4c4d9bd147..1f495f987f 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -51,7 +51,7 @@ typedef struct s_xdfile {
 	ptrdiff_t dstart, dend;
 	bool *changed;
 	long *rindex;
-	long nreff;
+	size_t nreff;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget


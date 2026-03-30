Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492639283C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890009; cv=none; b=fyqSTuht5bTecZkavaqmD8DrcjwaaejH4p6JWQ+nWqV48tJ+iDj2sLXLaZURmR0xLlfN4TFWNTvOXbWzfnJLRhDaEi+D6bWqXY/BWnmo9NO3y7//WAZOXkH/8D1mQIPKooWSXA80WkI8CkgjssRGoW+yqTgAfXrlNHwLjOQLNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890009; c=relaxed/simple;
	bh=Y0cyDhxL8l2KKDiWsH76aKyoj7SjddV5KFro/r4n4M4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=izA7FQM0Cz2WE4IfdzlyqWSVXZnD4v1ImJfPPXhESaSGb7lU6ldC28d0WhgtuHoQ7tt37Gr3P2+8XmR6DtjGHn5S4krobWu14rL0neDRfXc1FAPDWIEK1fiJvkqzBSzz3SYBIhKkeVAzkUiCJtnzmh0jzTBLusny3DIhhH7pM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCIAC86J; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCIAC86J"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d9b21d1461so4105640a34.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890007; x=1775494807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=VCIAC86Jyd+k32jWpTOCmUokZgKrDt+XmWlmEGgSjbpJStF+6IM/HFYvf7+tK7I8WZ
         tIr0Jf4gIHuotJ9wHwsVnoErbKzQ1dpc/PpwL4YEIh3dRO5UF7eNJW05Tdj1T2xqajd+
         S0/rp3KstxdKyoWVgYXvVitk7flJ3zCJxHusUso1m9aW/FmfghqAIxAVqV6kGZUKueXE
         qFzBkjce33NGkOW2Ub1Fg3qUZSnwlekJL0K15xw8E2KZ+lgVgavK/D9qtr050z35Oswm
         /iOiKbY5TECxGGFHOjeqiXt8U5++wLGzdhjoPp49wrVTLLX2tDYp55dLmuXOi1YyzLmZ
         aC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890007; x=1775494807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=c/wVWrV4giL+hsdLRwDas3HrzLaWg2JlOB4MUh37xw9L1GbNkUEe0hlDi+ElGF+7Z5
         QraWIvNsQmBnfZyloBO0nPVDf/Tg1gOo4ivGiPLR7zPUZlCUKhwAsiZwy53AlznKvEOf
         Eb+5KUmzGejnSEG8dnsfFLH+bE9Wfl8ypaflQ8FI4IzSUP7XTb5UcXsW57k9yEOpGJGq
         ijC1Fp9wLRiQgSIjB1YU0Re5JM8pnO6v1kg7Tdfgu9ii0qQ4Za2VaRIG5L+LW9fWxXvI
         bfEIo3R+8UgQHlp8v+GPGeEAMbhUcV0bMUsW7Sz5l5GaAs9D/M+ShpK2DVLqnmkYfTD9
         erdA==
X-Gm-Message-State: AOJu0YxC1w0ZB2FQAMWl/pykuQG6UevcVpzCxWVd8LP/VKBZnG9HLP+I
	rk95Kl+uywUosekaz2qBB1nRhbS3HMRSv96+B6XIWLYpmRH+1eGkRh6mpyNovg==
X-Gm-Gg: ATEYQzy7p9M/AU1sELz+JS/YY6X+L9Xbg1xQgZUjJ08Jme1ZRgNBNnS+KWYFrVudkzU
	XOETYQ6cAmBaU1+Q1MoKuCybWhq/+CFKOgXQhpf9NV29rjFiIvD7S0WFZ6jYa66WehpWy4I/Aui
	lqMliGW0Dsta8+Wv9dT6kEtJHXyjM69QC1mkNlRuPshJ/YTIzZ1ucmduvAP48tbDpISbOW7f43s
	QbM6EPX/lRsN3CrU8YQ7ITm61C7C9CoP2agNT8lp0OAgRTgcbsrqsf6+SDug4ImygB7ZNEbXEmT
	3vNnyN0pNwdME2SqdGCw3nJVXMH5XK598IHJscKtGKeV4GjW/TlAI+Tpv+VNfUI2KDtWTs6PeWI
	BeHsGusaVazwyJtSMhEFm8EV6TwrUNyR9TzJBwg6t0luFBl190jOw/rYKCfgMIpXnn3UGDiGbet
	WHQxHm9lbYqtssSjbLbnpApDVifwo=
X-Received: by 2002:a05:6830:8291:b0:7d7:bf59:2238 with SMTP id 46e09a7af769-7da374ba525mr216297a34.4.1774890007005;
        Mon, 30 Mar 2026 10:00:07 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a7b5499sm6368892a34.18.2026.03.30.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:00:06 -0700 (PDT)
Message-Id: <da32a9747c7bde88b4fe33e43ae48c7092d57d9d.1774890003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 16:59:58 +0000
Subject: [PATCH v4 1/6] xdiff/xdl_cleanup_records: delete local recs pointer
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

Simplify the first 2 for loops by directly indexing the xdfile.recs.
recs is unused in the last 2 for loops, remove it. Best viewed with
--color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index cd4fc405eb..d6e1901d2d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -269,7 +269,6 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, mlim;
-	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -293,16 +292,18 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
+		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
 	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
+		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -312,8 +313,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * false, or become true.
 	 */
 	xdf1->nreff = 0;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
-	     i <= xdf1->dend; i++, recs++) {
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->reference_index[xdf1->nreff++] = i;
@@ -324,8 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	}
 
 	xdf2->nreff = 0;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
-	     i <= xdf2->dend; i++, recs++) {
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-- 
gitgitgadget


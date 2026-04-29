Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A5423A9A
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500503; cv=none; b=p1o197TfHJ14Ps8tU2orL53H9R8blfY2CoUKtamfrlGDdWECPttyp4q6m0jOJNCbhgEiNXAvUfXAYf5dZrfcERb14PGOXJnPA3wPkwA2sUkUjoeTOb+lkSCk7jlA6Xn41zwCc245Ym1ziUsZt8Qya5HxYfaGVLaiRToRM7iGaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500503; c=relaxed/simple;
	bh=Ao/aEfOMWdkk7cG6BaxAqunla7Vo6n4VL55nZxp0zQk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rYCbm4NSdXDJnkCECNLVs9qLgwDMZbzAe5FImJDyWEEi64e7nk1el8yyb26RSGuYkvCaKgs2VDTGns0xlw/hsiAB++ln52nrw3Lo+g2aElpvlt73Z7B/CHufWCN1drbc8JeTjPpgBDbF6xobWjaNnrtIlTx5vjVfbT5/Ode2pEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/biyqYZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/biyqYZ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f83efb5729so30022985a.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500500; x=1778105300; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=p/biyqYZ5Z0jNjFl+UrKYeC92HY/sjLGa4YO3ThNg8cgPhDhArVa44qN51mf/7lHtK
         zG8+AeBw7M5u9VGl2VWowHPRIAMLFgCWeQXEYT5eMoIDvcTUjMIGxAmEsE6uhcfYDAuN
         RqO7zcNgNeXHodHVMRBRQQdGMXmxWHYbDYSExl4dKcO2vzMlFT7f7CJbg6DmQuQr5ZRs
         uu1c4bSTRgQvjmnQv+sJwKjisfr63ZZGQCPmjdMWy91VUnWZHTtJj2+LQ/m+8w6KCOFK
         LkYGOx51OObSiYff44g14m3L2sf3rHXQnf+JMNPBt9axEb0f3kiEMKVIXvWVOtSBYjFe
         Z+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500500; x=1778105300;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=de4a0S6/WDokWchDTFVMPWP5Zra49JuA3u94+TCU3HFELfNnluI9J05b0uoEd4I70K
         cIENsoXsikrf35MJM1bNt3EjarF9ySIj8bV3r3M9qA3LsRw+XXIZL5Ms8Jx8TjqM80/E
         KIoMMRGRbyFIb2gHq3p26LZJv99UmO6Sid36iEc3glQS7vgdH2QNY5hazl6dIZe4nYhL
         Bw6JZWZmC8kNCKZWvJvo92sQcigiZMxruO8tP6K+ZehSPpmxcLBsLq78wG59ETIios/x
         gQr/TA+i9DMSINakOeu9GZvuZ/3BtvBdKEy+pzQ9AZ/1SxmeOz1pERfNFXag7baWaJWQ
         eI+A==
X-Gm-Message-State: AOJu0Yy56zFwjESbWrv+6LlTwpngxhCoBgPbAfs6t+D8MSGdnfMmWZcI
	YCniMSG93QAylIlCBnHZ+c3I3SyLzVwCB4Irm/L6aTEpFvWWKvZdXiMOhsa/JQ==
X-Gm-Gg: AeBDievZjXmFhsBHhCMrxqmMqAC5qx4py9BWgRhw9aMfV7Po1nmAf8TfM0XdJ2DWvyY
	mkz5DqXxs7gfYtlEzvF2hLzotgX+ykkoQTPu4DVreqxUGCLSNhKXbCZKrUlRtkjadMbCTOPW3F2
	wnZ3E27ApBPnraJQbpo44VUnpmRiANvwMuYbRyVXyr7RadqcZuQrwk2mIk50sFSL7zPZfVhC6zc
	kGTchZTl6ZDQC7DEI9qfx8S/EZBbC/abCPFQ3yUU2QFhsnKtG4A+D/PSWxs3hKsmD1GEbjevWbq
	N037LJMU99vUCiwq5yiAjRQ+C/eW0MJL6ZvRJCanojd2Yh/gT5es1ukMNHV9ve4DlOHHs1gEG/q
	bXvmEn/t2kNWjYli9GasGrbRVX8XMtb4Iu8l4/phJw0Fb34hK9gBXV/Dx+AlXEk+ICSXcEJlJhG
	0PUQEcw9LXRkmjwlATdu6LN4cUQPfGLsR2Gr2fsAs=
X-Received: by 2002:a05:620a:17a7:b0:8ea:aa10:7b3f with SMTP id af79cd13be357-8fa864db216mr104553185a.1.1777500500534;
        Wed, 29 Apr 2026 15:08:20 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93fb72349sm269030185a.32.2026.04.29.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:20 -0700 (PDT)
Message-Id: <85aa0da90c62d9217ac2a3f907c37855a95298b9.1777500495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 22:08:12 +0000
Subject: [PATCH v6 3/6] xdiff/xdl_cleanup_records: use unambiguous types
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
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Change the parameters of xdl_clean_mmatch() and the local variables
i, nm, mlim in xdl_cleanup_records() to use unambiguous types. Best
viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 48fb5ce6fe..386668a92d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -197,8 +197,8 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
-	long r, rdis0, rpdis0, rdis1, rpdis1;
+static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
+	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
 	 * Limits the window that is examined during the similar-lines
@@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, mlim;
+	ptrdiff_t i, nm, mlim;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
-- 
gitgitgadget


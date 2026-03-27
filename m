Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D782361DB8
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639441; cv=none; b=AuVdog3q3HXma2g9SfA29yPmPkgdT/6jx2KGRNjEGQEc+HZC3jevTEJhEwQjyWGCxnc/Wg2TI3rC1MQ4K3ZhmzK4RGbGvQKq/K7ToJRFQ+kEf/g5TSkmprTzh3+c2PUHu9jWpbZvWXECNt73tELYxA6NHqVO6EnwN2VJhEcdHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639441; c=relaxed/simple;
	bh=/tMhb1hF8evtEbXZhK5bKT9POH0y47YWJ6PEXp7J+P8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HvEd5Je6phCqQK6AsLLkuaF2a0dmMXBj5L0Cg5K9smyIDT/O4gofV3r81naVggSM4SeskS68gg66LzO9WWs5M+TfrvvLzpc7HQP0gRSDKt93cImBZ9d+hgBoWHWsZkjYBBsVTQECgMlKuF1k785nTM91YAtDxwkdSOTdZL95o0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+f4taSN; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+f4taSN"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c107ef474fso4441349eec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639439; x=1775244239; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=S+f4taSNqhQmSRXalAHIunx3RaU5R3bfYAVPS3n701BIA/CA3iBBKi+tQsbOi5MF6C
         EyOQTIlFghIEPCfH9BvAefMUqZ6wTUttTW3zffFJSCwbo7t1zc5lza/Glnap4cLs8v6o
         osRxFqx2dPN2sISQYEmuhb6TDBahQidpp7r21cDdzC9GhntbNlE5uwGG3EmhDbA6rmpZ
         cgY2J0fxN+oXmugqVDt3TVedhbFGJE4VjhnAa8ViOBTpqC4CF6620sedCRqmGlucabWH
         hJZPd58U/zmbaYjctHlyozfaIoyKHKEI11J19QJDPrSZlhdP89zaqG4MTuY82HVmOqpp
         QChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639439; x=1775244239;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=J/Mf69qK8PrUNbOqbeg9Rp/NIQGHPkZHkkNxZlSGnmD5KlmVl/DAsvhWFI7anHV9fS
         wGZLXS35f/YCJbUY5/iB29M4px5NPHMbCmrbbrhw/HIUHriGJm1QccYEaYBlAnFExLxd
         zaFdCLS4HSPwYeSZnATAwNDlH0KLTztKAXNFcV4xVRt/0McfAdoIjHFMeNovwqz/PzJ+
         axrnuOC8inMw3UPR1u12w5fLvP0Qim8n4tAicGFjwAOINEaddXFrUvk8ANe7Lv21JshS
         GY2SwBViqj8DTgRE3gaBl/8Mdq1dEO5L1/q2Mi/xCWQ2fzWseOFcvz9SArdeDb3iAtei
         9exg==
X-Gm-Message-State: AOJu0YwLBIYtGaytSMTLD0ddbsf3BUAdHs1pRqa8q5Kmg6gZEp7n8aYq
	v/n6Q0obYkhzQGujV7o0jNPTIeRfF9W2OVvNt+c1AHTfL3zfPMLQFzgKjbFkyw==
X-Gm-Gg: ATEYQzxRgSCDiMret3PbXbsqr+U8gDimNvB3iGCY1BL4OfX7sqMSYHBp5Q6UJrlFCW6
	OPBhpnm5nQShVRxnMMKRGxn/IR1LSbIzsum820X6UVZmNTxS+L/oP9apAytr+Nmk4aSuG65Mrtp
	1KYhz9SZ04CN1/0lzKtBhpPWyt7AMPb5E+SbAukb1cWkZBduT/Tl2eCE3XzWEIUhj/y5eOySh/A
	TF2Vj1DxMDExbb4mawOLlmceOnDraqLf2GyDSOZahIpM3cmJu6mPDc59iauzEvMSs7C341/QO3g
	jIDoCsYcFy/13+qljKdOUYmwwtIrJa6RpdG4ijR8jnj4BwgKBZ49gfGwuIb3mm8ZtbKoxQnB4fb
	PAnFY11SD8FQaRQOaicHZlE88jYpYqVdFkaQZYi45foIbl/4ANPpxMYRpmKSdEELQIpjNK2O6z8
	nF6ngF7c5MczS5jZZP8K4nKKNsjG4=
X-Received: by 2002:a05:7300:6427:b0:2be:884e:17af with SMTP id 5a478bee46e88-2c185d9104cmr2012771eec.2.1774639439286;
        Fri, 27 Mar 2026 12:23:59 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm258190eec.6.2026.03.27.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:23:58 -0700 (PDT)
Message-Id: <86b0ad100ccbcd1812b24eabd0abe1987592daa0.1774639433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 19:23:49 +0000
Subject: [PATCH v3 2/6] xdiff: use unambiguous types in xdl_bogo_sqrt()
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

There is no real square root for a negative number and size_t may not
be large enough for certain applications, replace long with uint64_t.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 2 +-
 xdiff/xprepare.c | 4 ++--
 xdiff/xutils.c   | 4 ++--
 xdiff/xutils.h   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4376f943db..88708c12a3 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -348,7 +348,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	kvdf += xe->xdf2.nreff + 1;
 	kvdb += xe->xdf2.nreff + 1;
 
-	xenv.mxcost = xdl_bogosqrt(ndiags);
+	xenv.mxcost = (long)xdl_bogosqrt((uint64_t)ndiags);
 	if (xenv.mxcost < XDL_MAX_COST_MIN)
 		xenv.mxcost = XDL_MAX_COST_MIN;
 	xenv.snake_cnt = XDL_SNAKE_CNT;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d6e1901d2d..48fb5ce6fe 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -290,7 +290,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
@@ -299,7 +299,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 77ee1ad9c8..9a999acdc0 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -23,8 +23,8 @@
 #include "xinclude.h"
 
 
-long xdl_bogosqrt(long n) {
-	long i;
+uint64_t xdl_bogosqrt(uint64_t n) {
+	uint64_t i;
 
 	/*
 	 * Classical integer square root approximation using shifts.
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 615b4a9d35..58f9d74cda 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -25,7 +25,7 @@
 
 
 
-long xdl_bogosqrt(long n);
+uint64_t xdl_bogosqrt(uint64_t n);
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		     xdemitcb_t *ecb);
 int xdl_cha_init(chastore_t *cha, long isize, long icount);
-- 
gitgitgadget


Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04A21C9E3
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921372; cv=none; b=jp46ztGWYKqPMEQd4HGGXXWh81H4LU2Fh3n50w/RD0AFLDnUglCnbP/1LofrKOgaYNnnRJnlYgU9ReQWtcLvqRrhpqFNJaJT0iFYynBxSnpHgxOMl64H7x3ZEDBNVUYC/WOyOUI2n7Mt/DxYVSTxPHPyJtNkPFfj/3sLcehjpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921372; c=relaxed/simple;
	bh=LMHWr/Jk/LCHA9l1VxqyJm3U48rkduLIbJrelWeCdfA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SkyovUbhq5T9DuWFZgmbyZSPWLiSxSFYz3M/ckISF/vDEUbbwLUgbg5jU0mV/7xoh+l1NdwljPCpSIw5eMeqHHO78sVMOQd6acAmTxnWD51Gdz+dXXFEfA6Hq7PkgtBamhHLoAtQ8AvSWjDUdDuk4DxNWUPH2t5a/vAdAppYS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNA9v001; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNA9v001"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so1609272f8f.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921368; x=1756526168; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqOowsYrOMLRM9RauuBk8vQViQlOWdRCXqM9cNH/Jk4=;
        b=QNA9v001lDM8eqh6PnOnJ3ZklHEOyRPYAhPblv1jfrmB5LjnmI1lV35NLaKWLPDeT1
         GeYeyvUDzt6MmC20awyhKK17NWY2mQ2Hd9r4l3gp5kyraBoUYLHhd6ozdwsENbSxoD8E
         hxADRTBXoeunvWdCmyQlIvai8Me0Tx4E+R1sJOz8E/8oz8ZX35owMdCETAU9ML6i4NHc
         llb1fo1rKKY1qLTHXMWuxjzuNLpy7ci4ehNcRM0Jerdf6d14DeVZnaAod1OF0h/0ojwh
         wbnJh/IgdieKBnBT9oPUSt7vCub/PjEjsPx/Fv/vOtN4J8R9SYDmxMkDQeB/iM8IdodO
         Zajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921368; x=1756526168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqOowsYrOMLRM9RauuBk8vQViQlOWdRCXqM9cNH/Jk4=;
        b=jz3nzQjeM/Yp+Qd+fIiVfLkgYXw+MYT3PAA7IJv44Qz2NMvH6xCtuzIheSLNjIwUp5
         1DKRZFcPX8Rj3OifRnl3GEGjzQzLBrPPCyLAOs5CB0dAXRGKhPbeYKqKcEJZ2z+UyYUV
         GDvwNI8N6px9BAZZmUuZbow3e0XIl4Yyu/aw61D3u41TD4OY30lmWILw7Sj9BIsCHyi0
         4y9FPUAQAmwmylSOGiPkn7GEWIJ0c/98U1YmM13a3gHj00qPwu8wkIun5lexY2p5h2Rg
         0z8/18iJrgJ8RPij/rHRgKEwY4+Sfu/zhyO3d5GhpvMt/EdOjmw4KHqRtMBI5g3EaFbO
         cDkA==
X-Gm-Message-State: AOJu0Yx3BZPESOcqNIuwJN4KpCBSOj4P2Eqs341dc4Ch90Gn0KIix+r6
	GN6MXL8UY5adT3CKMiMjmQWNxGCymJJ8WGacOQJLdQBmgLn14qnvR6EpcqA3xQ==
X-Gm-Gg: ASbGncuAZ9hXmSYaMot7G7kajwNKINdo2GLS2jgqblcu7FRGZF9g7BskpUr7wotDuGH
	So6irJPutZBCfYnfAb1lZX7gDldpHzjHyACzLS8Fv7qoOHps3jT4CH9y8b7G4yigcsCh1rm9+xP
	W4UJcW2RwGePfUqgplfphUmxYQbCG63r6dpzhml4phOn12UWJ7RJO3ccZoosuMBBf+LacQw5nkr
	jbonklWARvIZhSxngOoxKG46pwBQ25+8l52wKRP2Kq5HIt0pPqJH6GQCmTJrvKs0uYFle00Il0a
	WNsoFwSeh9MexomDKn5Q9meKFBbnk/1wQEdgBxc01cBYjV8sCsNn2BEWlto3RXLUgFNKPavBmZ3
	pP+aeLqqvGP71YkqyS7vcIe//F78=
X-Google-Smtp-Source: AGHT+IFz6GRKjhG874lwNUz2seTozzgB2gzIvMAXt+QxvL9JKj+Gdr4jYBRel+0c+2Y9ODkY08zxwg==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr4394472f8f.44.1755921368220;
        Fri, 22 Aug 2025 20:56:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f237fefsm1900229f8f.30.2025.08.22.20.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:07 -0700 (PDT)
Message-Id: <7c68ce5349c0a77426f03e898ae15392a3b06b65.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:49 +0000
Subject: [PATCH v3 08/15] xdiff: delete unnecessary fields from xrecord_t and
 xdfile_t
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
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 24 +++---------------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index a45c5ee208c8..ad356281f939 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -91,8 +91,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
@@ -126,23 +125,17 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
 
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	unsigned int hbits;
-	long nrec, hsize, bsize;
+	long nrec, bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 	xrecord_t **recs;
-	xrecord_t **rhash;
 	unsigned long *ha;
 	char *rchg;
 	long *rindex;
@@ -150,7 +143,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	ha = NULL;
 	rindex = NULL;
 	rchg = NULL;
-	rhash = NULL;
 	recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -158,11 +150,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(recs, narec))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
-		goto abort;
-
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -176,7 +163,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
@@ -194,8 +181,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	xdf->nrec = nrec;
 	xdf->recs = recs;
-	xdf->hbits = hbits;
-	xdf->rhash = rhash;
 	xdf->rchg = rchg + 1;
 	xdf->rindex = rindex;
 	xdf->nreff = 0;
@@ -209,7 +194,6 @@ abort:
 	xdl_free(ha);
 	xdl_free(rindex);
 	xdl_free(rchg);
-	xdl_free(rhash);
 	xdl_free(recs);
 	xdl_cha_free(&xdf->rcha);
 	return -1;
@@ -217,8 +201,6 @@ abort:
 
 
 static void xdl_free_ctx(xdfile_t *xdf) {
-
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436efe..8b8467360ecf 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,6 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	struct s_xrecord *next;
 	char const *ptr;
 	long size;
 	unsigned long ha;
@@ -48,8 +47,6 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	chastore_t rcha;
 	long nrec;
-	unsigned int hbits;
-	xrecord_t **rhash;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget


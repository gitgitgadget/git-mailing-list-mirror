Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11524225A39
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784354; cv=none; b=Igy/2tXxwTod+K+5bDmVh8i3EY0XStWIEGxqT/SHNtaZHBGesxsAv2mWwHpoejsdR0qB9vf+zpx59dAiPCa8OlTEICyhRmx4CAMX7Q6HHEbCc5uaHY7mUzvSmMgDzFodZQqa8axQ2YN1F0RLIStteIGffVy9l9zfpfpC7d+9Tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784354; c=relaxed/simple;
	bh=fizz4nq4Uq4fX3kM+0s0N0KXQHHL9sKQ5lQaMNm30ts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QlDdPnP9+BAZC8ezp2swY72ZTXIKoc1j6Sy6hlgcUVwLQP9N4eXwRU7i2NGfKqf8HwQliMEzmtQng3oIcUjcxuQR/1nbBEeqTwwEqvX2z1tspfNZ1zrLZireqtBfkgfCJCpcBIrKjwkluLsJ0Z3UwBBtIZeXd7jV60pGZEk5eFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCTd294b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCTd294b"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso11090185e9.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752784351; x=1753389151; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiyMu8IwFGoQpCf5smaudcTUwXAOju/5Xnq3Q8AMr80=;
        b=BCTd294bLBWX8Ubupbb84Ef0Yt6avmaAZ9Jwqx0Qu+qKwVYh+fPCFUKRfwAQn0wdEo
         lVzvYRYoW94Jh2bmhDTpyIlm4U2s6VF0wkTMdHELlCa1a4Vl5sFptOwCbcnjN6M5o0Wc
         dVI90sluyL0OoESiLYVn6TYG5UTfGRo/DYv+1OsHiwsAGWNotWnixJ18/hYaJgYYAqYf
         KQv6VjKukN8EW1deq3NzDMsRwR/HwSjzqBrFaHdpUWoAPmVIEIuZqKw2fNzxps88fEdl
         qo7k1UVNa+TqBlLXfW7GFg7YXKhtabjGdwgMxMigdXOSQvssSeIlY5dhaYTaOHRMgW4z
         WmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784351; x=1753389151;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiyMu8IwFGoQpCf5smaudcTUwXAOju/5Xnq3Q8AMr80=;
        b=dUsU1KqLAY2bJ8T/Wa72hNN9uwOGYxRw+klVAFI8L9j55X90SGTrw9eqrl+WSzCinC
         V2u83w4AdRYFxBI8s7q5MLEf/es8l6MoY+Aib/x+tkAfh7gF4I6FLCP2/5h0Z6DUOlq1
         /QyQSvpjz71bdWoKmkaRl1cEyPm2f3UDMpoh4/lEavRP3u+cD1nqeeP+cg18ok46Qle6
         IVwjP922tobM41K3m7RvBmkKP+g1s89C8Zf4eL9jgOl8VKx6rmGZKAdiUnsTvdMUIasa
         wfFtK++j0NBKJWkmNxdr/qfwh/uFJItlvJKxRr5Or2z8J1Ww5LVDsnQrnCpenGiSq+55
         RNEA==
X-Gm-Message-State: AOJu0Yyx5PyjC1S+ze9tqhRFAZDZ70Se28NDabvjae+Z8+KY0LLQJxyN
	fM5i92STfen/uk3aFI2uW29f7gKmzLrmGTepJ6pB4hUkpaqC6JmIBh8lItQtBA==
X-Gm-Gg: ASbGncvzAtA4qChujXb+r0+9F+Uxavmu6gOPT/YVDCzekW/3hedZIBgqu/+j0dK1GV/
	fqRaUIAQDrXIv7G/j8ZgyqSSZXMc882JsrkC8pKRgmc3qwnGuIz6TKuh7KFMem027i7w3V824k7
	S1IwR8varxp4QpYz1fPY+lPgEaqZqawHuSbKL3+Yr8rvn+KERh3SHEk1N8p3tIq26haedDB/ZTN
	P1971AmZKnaGT8oGRdN2dlP22xGH6982XpfQUM/bIchVm523tS5tiE3t2ip55b81tkucZJcA6op
	l+Ny4m0EX/xWdHJYuyI+K9cGe7AQDiFZFXhlZXBM0jRfZKNxtfZ5hmBzBhNObYR7EfiKUeL6Wqu
	9zI7c0s8vXq0nXltkZfp5F/A=
X-Google-Smtp-Source: AGHT+IFoEInXInAn8V6Ih7NcX0LzjBz1pxYa/M/gCQNnkpVyj6DLCErilRY/5iMazG1gVxjCsysg+w==
X-Received: by 2002:a05:600c:4f14:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-4563b8d27b8mr1416895e9.20.1752784350939;
        Thu, 17 Jul 2025 13:32:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e57200csm61340605e9.0.2025.07.17.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:32:30 -0700 (PDT)
Message-Id: <2db30cc739efadf8383bd9dc1b7825ce863e8f5a.1752784344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 20:32:22 +0000
Subject: [PATCH 5/7] xdiff: separate parsing lines from hashing them
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

We want to use xxhash for faster hashing. To facilitate that
and to simplify the code. Separate the concerns of parsing
and hashing into discrete steps. This makes swapping the hash
function much easier. Since xdl_hash_record() both parses and
hashses lines, this requires some slight code restructuring.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 75 ++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 747268e4fdf7..c44005e9bbb8 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -129,13 +129,39 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 }
 
 
+static void xdl_parse_lines(mmfile_t *mf, long narec, xdfile_t *xdf) {
+	u8 const* ptr = (u8 const*) mf->ptr;
+	usize len = (usize) mf->size;
+
+	xdf->recs = NULL;
+	xdf->nrec = 0;
+	XDL_ALLOC_ARRAY(xdf->recs, narec);
+
+	while (len > 0) {
+		xrecord_t *rec = NULL;
+		usize length;
+		u8 const* result = memchr(ptr, '\n', len);
+		if (result) {
+			length = result - ptr + 1;
+		} else {
+			length = len;
+		}
+		if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
+			die("XDL_ALLOC_GROW failed");
+		rec = xdl_cha_alloc(&xdf->rcha);
+		rec->ptr = ptr;
+		rec->size = length;
+		rec->ha = 0;
+		xdf->recs[xdf->nrec++] = rec;
+		ptr += length;
+		len -= length;
+	}
+
+}
+
+
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	long nrec, bsize;
-	unsigned long hav;
-	char const *blk, *cur, *top, *prev;
-	xrecord_t *crec;
-	xrecord_t **recs;
 	unsigned long *ha;
 	char *rchg;
 	long *rindex;
@@ -143,50 +169,37 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	ha = NULL;
 	rindex = NULL;
 	rchg = NULL;
-	recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!XDL_ALLOC_ARRAY(recs, narec))
-		goto abort;
 
-	nrec = 0;
-	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
-		for (top = blk + bsize; cur < top; ) {
-			prev = cur;
-			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
-				goto abort;
-			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
-				goto abort;
-			crec->ptr = (u8 const*) prev;
-			crec->size = (long) (cur - prev);
-			crec->ha = hav;
-			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, crec) < 0)
-				goto abort;
-		}
+	xdl_parse_lines(mf, narec, xdf);
+
+	for (usize i = 0; i < (usize) xdf->nrec; i++) {
+		xrecord_t *rec = xdf->recs[i];
+		char const* dump = (char const*) rec->ptr;
+		rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
+		xdl_classify_record(pass, cf, rec);
 	}
 
-	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
+
+	if (!XDL_CALLOC_ARRAY(rchg, xdf->nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(ha, xdf->nrec + 1))
 			goto abort;
 	}
 
-	xdf->nrec = nrec;
-	xdf->recs = recs;
 	xdf->rchg = rchg + 1;
 	xdf->rindex = rindex;
 	xdf->nreff = 0;
 	xdf->ha = ha;
 	xdf->dstart = 0;
-	xdf->dend = nrec - 1;
+	xdf->dend = xdf->nrec - 1;
 
 	return 0;
 
@@ -194,7 +207,7 @@ abort:
 	xdl_free(ha);
 	xdl_free(rindex);
 	xdl_free(rchg);
-	xdl_free(recs);
+	xdl_free(xdf->recs);
 	xdl_cha_free(&xdf->rcha);
 	return -1;
 }
-- 
gitgitgadget


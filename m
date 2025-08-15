Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200498821
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220984; cv=none; b=aShFaYs227keJRA84R3xSkxXnZRr55ZMjuvYKvEDG5c1vJZuDVOFXHyzmVou3r2Ic/0Jjwzgs84rdbJdXxeD+JqhwTK1YzADlVhrut1YbN/1WF9aQdwFGqTBvJmPM0VhYp5Gza9DmgGyCv9sshJ4kKbXl8LamP00dIPsN9D3pAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220984; c=relaxed/simple;
	bh=qpbwRDmWTrU/iMeZlM7UNvGXfjE8tjAS0dE623MraWo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WQ9yDZjznLupadAtLJxQWlkMH1aK119vR7ERaEPaIKr5u/aApxJTfNLy3Cq6FqaGvATg36QtLhCVpjEv6rINqs5qW2N0bymCwnNH27b5nAyYo2bpUBDwvdqLIB8ZbQvYfT7HIgVu3gRc3sQnQ//bZlsfZmyXQpaX6fm93NrD6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLiDfhqF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLiDfhqF"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e414252dso785934f8f.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220980; x=1755825780; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pYephi1PsUS9lGpl+zaJ9ZM/EPzW72T/FVD04OP6/c=;
        b=MLiDfhqFhVqFkoGVICuyFkt3VEXWulHqMAQ5oSh45k51QK5pa19dGEK3imXGDb6SW9
         6fYmb/xyDlmCJTJZYfnCn8N2+gz08TyfrejZFyOa4S6TnFZTABKYYpP1HYSK2pIwhMzv
         +/hiUeAdIYwDIKELhN7kBCVKptXTciyXgrxEa5RF49e51ROkelHOqs1MUCKIs1hTX/Sc
         9w8ugCqDj47sv6BatN2ZcnDbWJHU0uQg6qdsQG8Xmv/3tivU6/if08vDCW6y59oNNx1Q
         wgrF5X2nrhoLTIvYrYfAplRirWJjlq/8/MtkOTUZ5dTvuwmlzdHZRFiKkBPE6G3TqMCn
         7ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220980; x=1755825780;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pYephi1PsUS9lGpl+zaJ9ZM/EPzW72T/FVD04OP6/c=;
        b=KfxeUi3NVRLcl07RnmA29JJmxnxLZD3ObhEBRyyxQ+lV29BYPTmHre49PUqeC5tB3w
         Wt+yP+2TKyFpHHrXHqXTDRHCeI0EqjLFgprBMA6zXUoiVwdavigYhinpAmoyj70hEBFD
         OXjPdPkowJZiTGPGhYTLx/4bIJ3Y/4R9HxcePWTfVuRRZrM3hrnl1vQRVtOZNmYQcz2Y
         BbLM66lHUqYbM3fnmwWeTDkfSDSHadXKl8MTJ9iXu1013kDUfpfHpWJNY7ZLVuM05+ft
         oQZSsY6Xz6RXrP3u+QkeKhRc1Jv5I/c60rqG1ZeA8XP+3CV5igmP1d1+fTBerL9CVEPI
         dy2w==
X-Gm-Message-State: AOJu0Yyu9oULYdwVF0u0UOXW/IUY2cpBQodxM9LF5dd2meNBqz467vqT
	b406qs9KyOpPZu1zj4Jmpn0ouR6bIKUknz0rj1wXHYrELSY4GB40ePFOo6q5qA==
X-Gm-Gg: ASbGncsfcMk3ujDi4RnxMYhEomGElQZOv30B2+7KYicIp/eiZYQ6ion+FCB4PsHuYwY
	MlSrSMdcyxC+hCX8QFTX/tlfFN+TfKam8wbZXGvMAovA+tk2WipxfTZKL8E0sw1zNljvC2hKoTb
	b3fQz18jYg0ltTgN9U0FZBlKYKlwTQGiwS5YfegIL17plzleyS64Zmm5X7p6WGW8jSKGfFX6Zmi
	5mvyBzIqpt7+tubAT8EFoCROx5yTIEVXBYR0xOUxbzpfaY8Nlo792+QJbNa2wU6jmyl+o7P/+vH
	Pz5jCGD1CE8Jfl4cDdcS6GAx7K7ox6c+7L/Y1R7vJeA7TTU7SsX5wz9p/PsTGGFiPG+PWtWHCd7
	6JIN8wa/3q9bBx8dFXmhHQb4=
X-Google-Smtp-Source: AGHT+IHaqqcTMBeczF68/n9BHKTYxIjRcgSi7SQytpBXFWWL5p05bygdUHFp5MrIdg0tBUwz1n1dLg==
X-Received: by 2002:a05:6000:430b:b0:3a4:eed9:755d with SMTP id ffacd0b85a97d-3bb6665cef3mr95470f8f.3.1755220980036;
        Thu, 14 Aug 2025 18:23:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ef48sm100615f8f.58.2025.08.14.18.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:22:59 -0700 (PDT)
Message-Id: <8762349599411de6ce85347c74f2fcaf129124cd.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:41 +0000
Subject: [PATCH v2 06/17] xdiff: separate parsing lines from hashing them
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
index 00cdf7d8a038..031c1752cc1a 100644
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


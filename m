Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5712252287
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496559; cv=none; b=N9SMzxjB6b9RsA6xsUSYwK5sljmv5LI8otDSyLzTSNFIAB3axf0/XTHcYjYfR96pZgqZLjSpeG9v0p7xKbXrbvEO8WDox5tRhl5DBJ/AnaUtfXtSyrI0YZ/s/eAxVY8tntF5WSI3EWpl4dsMblD+zWOnUdJdhKlAp7Reg8C8JSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496559; c=relaxed/simple;
	bh=oFnqDk0TpLA1lRi7Ds88AjIoVZFXY8GRr7eDx8Y0AEI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CQ0bxFNhe97MfmGe2y42IwMzADp8oP0eJm+QeNHvqTQTnfi4uzg7pFH9Fovy6exocj/7du6zeGNpVW6Ezgp4asnq3sPqOr4zkh4hC8dBRjfB36Eg5egPudbPEhE4efMqEJ5TLymmu+R4VQR07K0VLFIW8Inv3UcW1rNJnDCM4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPpBuc4o; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPpBuc4o"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7720b23a49fso2801409b3a.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496557; x=1757101357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CndQ8sdowH4p2w5NGe1MSpI72J2BQUnO+s2em84l74I=;
        b=YPpBuc4oUjixpEBlncxD8NRihr8vwRdr4HQhPj+xBFGba0vvQA9qrUQDSiOPuE+ior
         Erw6LvdLGmgYLFvC0hCJ+++hT2MwbQy9aXE/fc+drZo3UuPjdtD5IcVAezgmYQ9sazSl
         CNgUQwIoSjRWpymuhiC60J9Jz3MFtcF7sWpIt3VTt+qsNXMFL75CXhDKLtSIVONKG7By
         AhrLF5ppbJWh4uS6IACs/VeimlTFNo07chQpNXrY2TNKD0YBAczfy8FjyrfDG17/YAHN
         gZmEGCSLPquuItxr8RuNFKTghFVDIth/PjWCTvxK9cvW7kMqJ28wkmtXHFqomSY8qGhu
         C51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496557; x=1757101357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CndQ8sdowH4p2w5NGe1MSpI72J2BQUnO+s2em84l74I=;
        b=TkTbtWw39IcwhqP86gLGMNmL+/puvWu4U88uQrgtanc8RMqZVrvnwdu+hHaaWtrs3l
         N04zTaR7dNGF97Oovxezp7BeDZlN3tjm0LvBqcGOLaEb1xpdE1AIyh0PSzU+Xw6QzhkN
         BYvVvXYOF5D109Rk6iLcfb18hXU65dPrV2Mz4LTKeW1SAahjN9gKYMZvEmcap6FC1BdB
         kOw5zsewwfJP9krJfRo/YL2xEdRMgcrfbgpCcN7g+BJaDFQ4g4YoKfhhKFPj6Ai7Cx1c
         Eybs6AN/BXDcp8rdLSY3fFq2yvn8abtAmQzNUhycUV032ha0q8+mJpOdSOk6rrE7z922
         05ug==
X-Gm-Message-State: AOJu0YxZLhOZxCmWcuafM6zvIBJogSC8vGT5Mksn9EnZJabAb6wv4d/G
	NErGZHebh+DS5ZEverpfLYq/wJUbeDD+51PXeOxv9h/QvWn1eQsMIq0ZFnyRrQ==
X-Gm-Gg: ASbGncvB50K6ogYwFDGYzD3wL1m7a/dK8TQOTuaxIA2c8XnB96m+2qvatmuP5SPozyn
	kYehmckMLCtsceDjdOts/W5r1J1ZnJ2BbBplYsch0i16Lw/Yu5F0S/eFRuE7h4SkNRdYfn68Qqq
	R2yAti79cL9JWIxa/r6OBatmLu3fWD7vM8qbTwGdqHi9ASIf1xtmTsLVSZRz5geBRBgMGTJ5/Qk
	F7OyxvTCAwk02/saQYVcIRG15lhgySiRPWPWpuNP1i6ri/zGhvTkJlQh4eoZQXrtZLuHz0X1lLe
	02XI2RMiulVtrggUJkZIU9VY5Uq8XzQpJk/uc0h2FLIWoLnV6HPQLmHsFUfqj6jV1/n+Q4qf8Bz
	UxdM/6r9FPkjsfcZLWhem7il3xu002SWRjNnpqw==
X-Google-Smtp-Source: AGHT+IFYqloDJajJX+zX5WMLi61ZEHRAvUJZ2ZX+MqPuQzURGeLpqm60XsTTHnxlJDsklZbp1AFEiQ==
X-Received: by 2002:a05:6a21:33a2:b0:231:acae:1983 with SMTP id adf61e73a8af0-24340c2263fmr42670826637.3.1756496556661;
        Fri, 29 Aug 2025 12:42:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3095df7sm2883754a12.36.2025.08.29.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:36 -0700 (PDT)
Message-Id: <7ea2dccd71fc502f20614ce217fc9885d1b17413.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:15 +0000
Subject: [PATCH 11/15] xdiff: replace chastore with an ivec in xdfile_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xdfile_t currently uses a chastore which functions as a memory pool and
a vector which maps to the allocations created by the chastore. It seems
like xrecord_t used to be a linked list until the recs and nrec fields
were added. I think that xrecord_t.next was meant to be removed, but
was overlooked. This dual data structure setup make the code somewhat
confusing.

Additionally the C type chastore_t isn't FFI friendly. While it could
be implemented in Rust, since the data structure is confusing anyway,
replace it with an ivec whose purpose is to be interoperable. This
makes the fields nrec and recs in xdfile_t redundant, which will be
removed in the next 2 commits.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 34 +++++++++++++++++-----------------
 xdiff/xtypes.h   |  6 ++++--
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 55e1cc3087..3b33186c15 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -130,11 +130,11 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 
 static void xdl_free_ctx(xdfile_t *xdf) {
+	ivec_free(&xdf->record);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
 	xdl_free(xdf->recs);
-	xdl_cha_free(&xdf->rcha);
 }
 
 
@@ -143,35 +143,35 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	long bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
-	xrecord_t *crec;
 
 	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
 	xdf->nrec = 0;
-
-	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
-		goto abort;
-	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
-		goto abort;
+	IVEC_INIT(xdf->record);
 
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
+			xrecord_t crec;
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
-				goto abort;
-			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
-				goto abort;
-			crec->ptr = (u8 const*) prev;
-			crec->size = (long) (cur - prev);
-			crec->ha = hav;
-			xdf->recs[xdf->nrec++] = crec;
-			if (xdl_classify_record(pass, cf, crec) < 0)
-				goto abort;
+			crec.ptr = (u8 const*) prev;
+			crec.size = cur - prev;
+			crec.ha = hav;
+			ivec_push(&xdf->record, &crec);
 		}
 	}
+	ivec_shrink_to_fit(&xdf->record);
+
+	xdf->nrec = (long) xdf->record.length;
+	if (!XDL_ALLOC_ARRAY(xdf->recs, xdf->record.length))
+		goto abort;
+	for (usize i = 0; i < xdf->record.length; i++) {
+		if (xdl_classify_record(pass, cf, &xdf->record.ptr[i]) < 0)
+			goto abort;
+		xdf->recs[i] = &xdf->record.ptr[i];
+	}
 
 	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
 		goto abort;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 6e5f67ebf3..5028a70b26 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -23,7 +23,7 @@
 #if !defined(XTYPES_H)
 #define XTYPES_H
 
-
+#include "../interop/ivec.h"
 
 typedef struct s_chanode {
 	struct s_chanode *next;
@@ -44,8 +44,10 @@ typedef struct s_xrecord {
 	u64 ha;
 } xrecord_t;
 
+DEFINE_IVEC_TYPE(xrecord_t, xrecord);
+
 typedef struct s_xdfile {
-	chastore_t rcha;
+	struct ivec_xrecord record;
 	long nrec;
 	long dstart, dend;
 	xrecord_t **recs;
-- 
gitgitgadget


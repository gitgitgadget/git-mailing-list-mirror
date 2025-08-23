Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAF220F2D
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921375; cv=none; b=EvjBLRC4cqwE4+rXmpDWV2aZLSvu8ekyDpjruqqoi5ZZ6qpPkhZPKdqU0pasrLy3lofF7Qx4Qk4VSrYmPxqcNrFamO4t+ORBb4CULUtX1Ur45EHacTkq+HhWV1sgvlKScLRO0BYqMR/G/8UPZN68RM0CemX1AJfqcRB7u4WW4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921375; c=relaxed/simple;
	bh=OEDQJDBzTvDQg0fDcB+9Q4VUpgdKaa5phwVKI0Fn6js=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u2H/7pFY9BZlupNrDOl/N/m0i4JPp16ihIeEQg27rj3264nGbCtwfYtpURD7zxiV7whhPGNO2cklwcadaEiALmS0sBdjSMf3hS+6hcGElvHvo4tMjuuBkTcFCggjJK3Kkg0rcZz6jiJJ+JOaHCKuwlMFdbdEk94MEjtIYuBNN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAUZ3HFG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAUZ3HFG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c79f0a5b8bso67759f8f.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921371; x=1756526171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKKU5wB8Xj3cdyFnZxw6iKZj2kSBzVZtGYFZ3378f6g=;
        b=QAUZ3HFGkOZooYWA1zfux6xKKm6gR2GX7XK1aWXtP0KYf9mtetYIParAyrdGVXZqdR
         st4DBf/OTMkl2/rSwNQ3Q3gEvFLOfMyfVhc9zI1GMWYB8HcygR4YoQ7bR8gfMUpBHP5k
         09ekAqUYj6B9HGGGDkTxrNziJNE2OtDAhZgbM/T1AboY7obyeDwQPGKLhzKqRfVqP+Rc
         CFbeMzPQLwVgJnqV8OLbAkJk5Kq6R0eZ0ZOsB8dqafdFG4U6+IygGuZam0yhI18AZejc
         h8OJkQkEtAjSOgvE+4GF6cLXHnbMYEJaXhxSFJCBduuQgZWYgwvUNLBFA/fh9UNOyOot
         4wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921371; x=1756526171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKKU5wB8Xj3cdyFnZxw6iKZj2kSBzVZtGYFZ3378f6g=;
        b=IrQ/sxjAN+JFlb7DFtufU5j7KhHQMZVop2L3VTufoUWgTUWf2etPTwuFGKOILRIWvY
         Ui+cgWEpGhR23SNPwVZrrXU1O1sTNXjiv5AMKgv+LZOdcnUQIcaKxJ8cLpxgdztpLVo9
         n246VKVHw5nl2P7hwYXe7vDxWjuwSsuJhJGy4Ox2kRqVx58NRUExnwzHVYwsdX3kc8Jv
         3vKce0ZeIFKCvfKyl2y7iui4aQb990MXWfetkmKgfAzsqY33XUSswYuH1n4UO3JMkkqJ
         2SmtmxM6oIHWF6kEyv2A81E2HeEm3veMpVmxRYmOsws/29CXD5T/kj+l28b5HRbhwdXY
         yv8Q==
X-Gm-Message-State: AOJu0Yy8tpB94A/QKKE8yIGUelCYzTDXlOGsEynyxvPfd8Kky+ZWm98M
	B5Lezk6WX+gwFEwbiZg2MlHIr7TZ574dJ3SOQ3NL7FXWthsUxueBtn4oWw8MGA==
X-Gm-Gg: ASbGncseHXrnOZIPCbTHHpbbXHDlQ/4hxbiGNbtiDw+bxkqqArx/rbmcc8Er64lNRaM
	mdcjaMioWcNtgwlD0HvgHfMTI9zpVsIC74YhyYTjT1RRIgSvHvozMxVsRYkfAXsqD/M5wc7h0Xl
	l5Wd2BtIGhfuUoqOi2+Vb4eC/qls2jKwCXclBhVDqUmdUw83ADBtOFiZNi2aksBQyxy6HyS3CLP
	2AvnSdI0QB6Esu05zhT3DLNct87DYGUUOaxg+xEYpOSHTQagSM2T8FK/4da4930vED3arUYuVoD
	1BzUbEZfFAAogZy1uFrtKM/+Hofy2CFeEUFMDHvGYVyJN85DTrVEy+1/q5oLONljJHyZUWZSH1Z
	NeHuhDMSO59f/wCl+cAQsqUabhUg=
X-Google-Smtp-Source: AGHT+IFiP4VFr2/TOvQBurmOAn1TsnXHyWQv0XRxf/6QyMRFR7SFL8iW/NmLEL6VKECVIk9TnRuRrA==
X-Received: by 2002:a05:6000:1788:b0:3b7:901c:92ee with SMTP id ffacd0b85a97d-3c5dd7b43cfmr4476359f8f.58.1755921371106;
        Fri, 22 Aug 2025 20:56:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57592db0sm19547175e9.26.2025.08.22.20.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:10 -0700 (PDT)
Message-Id: <6ce0e252b3802c63d1969c23a1fdfa5e80609cf9.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:52 +0000
Subject: [PATCH v3 11/15] xdiff: replace chastore with an ivec in xdfile_t
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

xdfile_t currently uses a chastore which functions as a memory pool and
a vector which maps to the alocations created by the chastore. It seems
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
index 55e1cc308756..3b33186c15a3 100644
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
index 6e5f67ebf380..5028a70b2675 100644
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


Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855BB30DEC4
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505279; cv=none; b=RhwKW/r+teXB9XWzhFdwaBZtADSKsQF6ibP6xpdfXlO7hAjPjgr/9bMeq6/ibEt9hSTIKWiiLZgdpyUNzKfXZzKb+cxHYwg0sA8upm2hML/BgnysH0E2emtCQz8PfG+CzS477gyGpvXyKP4msNTvb0AhxW852nc22AU7Q1k5pJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505279; c=relaxed/simple;
	bh=TasYIhMF5VrtJ2AHaDRpRawoliDPTC0/C03aaErMvO0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BAm1wyHShax6aoerg+xOtDoZ7zHZrnui+/cbotKuiTlTxnWlPmj78lTvyslr+9mOPS+I/OThkSexLOJu+GMzh2cDEx6VJo8P6guTShy8v4NhuSd3Czr7FQATFeIPoLnboRCvtqUYDD8S8cd+cOjCzDNkBChawa0YbRTdoaQROsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffc/udwY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffc/udwY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-298144fb9bcso63817065ad.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505276; x=1764110076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV+xE2/+kRrWGZq3FQKpj+NZvOdb3BnWqpzWsKX6HG0=;
        b=Ffc/udwYxRkgJSf0/UEl3LSCKtcupNY4Y2DmVGuwZyKmRmgw7hcA7SHF6cevnQqvj7
         pVluOaveDFi1oe+CVyTcxzw0qCi2XFI8qCxtDnDDutYj5gvSR66sx4bLPUdXcUZxZ3z3
         uicznSsepnEHA6XWZQZtwjBFbxJfk5EE2S7paRSDwxCOTQnBfOlcE+fDxCdSAUEPYufc
         2sI4nD3Cc01qBjrVA0VrUa6Pv4EF7cCJ5UL71OEGOf5vIVL5xpHDKQs4CCqjWDEKYY/u
         Cpp/WYDZ6SNWiF2TcrmaA45QDE6UwyNCh4GkVQh8+L91W3RocKS/JeNAnHxFS96+LDmE
         nUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505276; x=1764110076;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EV+xE2/+kRrWGZq3FQKpj+NZvOdb3BnWqpzWsKX6HG0=;
        b=lJttxp3IhWmWg3yDoIs3UfU3nQQFg+xoXM1oBJP6VAEpcbW9wDlOAjBpCcRCW5MyUZ
         BwfUxs3SzzqaEx82Pe0nKspp1JVvUGEEsUsX25PIdXCu/4FFJbgpukkqfOcYpfu7OWjX
         xQa2VuZ/7NqKeB5EjvRXQVmoKx77kus3uMQkmmCGDgRPgpJuitteBurDU7oAmXUlnICs
         PuEtpzSN7H4jSk5xW3VxA0+Lemci6fxvW7ULFsUPCCskssFSL13BAprDEGSbwLXn0ujN
         t8o6p1ApoNKCwY4+0ZEMONgzX7AIFeUHfh6g0GIhWYf4PCA8xCPjLvNyAQImP7uVVMyz
         FUGQ==
X-Gm-Message-State: AOJu0YzAwU5spX6uwe7XASjuYN5UVMtamj+EdCrxyEfZh+3FVexVqOLJ
	+KS8l6dn1wbmFyM9qv1agqZhFFj4BWKS3ZjQYuUPgL91Epf9IhzPuLxJOKoMqg==
X-Gm-Gg: ASbGnctl26NBbX/psU5BPmapIRdqhBpxCsNzZctc6Tz36BTyfOTj220FaX+xSUafLug
	BCHYNPTuVjvKKGBMMf1bmDmfmYNCX4gd2hn1yt9NLfWElhkTJr7bAc/beLc+YkiWHVUxSyEdFYg
	ZCjpT12cZalLlYGPyIucq+rL1Z0u18vZuuB0va4WVzPyrb/h/mLQKdd03rnn4xvzkSQovRwpJAo
	rSKShCBToRSbXhd0XY9iX0nZ8AweMIiZuKML66CR4/KUkjqq3XRJzL/enMlvAgCFSyf+rkV1C/u
	Kpf/wJiYBksZZPcdBCiyS3z70C/DS+yfE+by9M+/zQutM34rFEKDRqs6Tz7OoQ/EJM84blrhklR
	JPSwEPY3kT+EHTKVnOFLInmbSe53xp8ILJoIWDBMMn0hu9QdT6nVvvWzqAaefzqlW+KTd/aLi5O
	nipdC/Y50FRe6++71Tdy6qIb8=
X-Google-Smtp-Source: AGHT+IHa7t1qXJ/zBJH1pBwZXjR0YCRTFKUAFTdTHY49FzmPIa8TakI3Ts0QX4B0IxzoxOSbD+/I9g==
X-Received: by 2002:a17:903:1a2e:b0:295:f508:9d32 with SMTP id d9443c01a7336-2986a733373mr229665385ad.37.1763505276401;
        Tue, 18 Nov 2025 14:34:36 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2345e3sm183213985ad.1.2025.11.18.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:35 -0800 (PST)
Message-Id: <dcc9d6bfafb69993b83b13e824fc52a9f4aaa256.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:22 +0000
Subject: [PATCH v5 10/10] xdiff: rename rindex -> reference_index
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

The classic diff adds only the lines that it's going to consider,
during the diff, to an array. A mapping between the compacted
array, and the lines of the file that they reference, is
facilitated by this array.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   |  6 +++---
 xdiff/xprepare.c | 10 +++++-----
 xdiff/xtypes.h   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 21d06bce96..4376f943db 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -24,7 +24,7 @@
 
 static size_t get_hash(xdfile_t *xdf, long index)
 {
-	return xdf->recs[xdf->rindex[index]].minimal_perfect_hash;
+	return xdf->recs[xdf->reference_index[index]].minimal_perfect_hash;
 }
 
 #define XDL_MAX_COST_MIN 256
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->changed[xdf2->rindex[off2]] = true;
+			xdf2->changed[xdf2->reference_index[off2]] = true;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->changed[xdf1->rindex[off1]] = true;
+			xdf1->changed[xdf1->reference_index[off1]] = true;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 39fd79d9d4..34c82e4f8e 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -128,7 +128,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 static void xdl_free_ctx(xdfile_t *xdf)
 {
-	xdl_free(xdf->rindex);
+	xdl_free(xdf->reference_index);
 	xdl_free(xdf->changed - 1);
 	xdl_free(xdf->recs);
 }
@@ -141,7 +141,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	uint8_t const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
-	xdf->rindex = NULL;
+	xdf->reference_index = NULL;
 	xdf->changed = NULL;
 	xdf->recs = NULL;
 
@@ -169,7 +169,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->reference_index, xdf->nrec + 1))
 			goto abort;
 	}
 
@@ -312,7 +312,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[xdf1->nreff++] = i;
+			xdf1->reference_index[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
@@ -324,7 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[xdf2->nreff++] = i;
+			xdf2->reference_index[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 9074cdadd1..979586f20a 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -50,7 +50,7 @@ typedef struct s_xdfile {
 	size_t nrec;
 	ptrdiff_t dstart, dend;
 	bool *changed;
-	size_t *rindex;
+	size_t *reference_index;
 	size_t nreff;
 } xdfile_t;
 
-- 
gitgitgadget

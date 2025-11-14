Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2552FDC20
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159835; cv=none; b=t+G1aMO0M+3pq02QKtVbJPJI8fs0kZwuEQT01sEXiJ12iouKBXf0BsQGTAHe6F3Tv6VFHhp6pvlenCc9nkRA04fmL3WNILUkyFyPjEzbD/SUL+GHG90xggwM4zhVcjrEVcyjOh8TQ9XWhwTjZVS2VMsM0rscVvYNKb4ukMuhIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159835; c=relaxed/simple;
	bh=qfw1s3P8Ma6LZqX1lV8VXs697xKK04XtKxf4m1DL/Es=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Thw9wqM3xfe6shlegWARwtoUQ5PebQxsr/ZBe66r6dkSB+5UiPpxot7jtRsc4LdqOOTe9PpbH5waxN+mmLKYj4E3xsp7HLH0H5L1EOIXe5tPRyYtMqwzOAEbxkAOZVIvwBqtZRrYNjr3gay94NRoimJwwFt2I7zwNzIOb3L6xQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ruix4a8m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ruix4a8m"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297d4a56f97so25637965ad.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159831; x=1763764631; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJmU6OX4fxASeBZw8+3vcpjdO2uxAnd1DJg4X0igPi0=;
        b=Ruix4a8mZgenvXJXdrmV5GvnzPJru6Jg/Q5RB2XdynDbnsLQ6v8+PHOqdG6FF+ox9J
         echo6QBYELIRZUn8eQI8amVll0nfArn0lhqacdiZ9QXF4zyNzdtpR3EF2rn2B+f11jRJ
         egK4Mr8CV4pFDAhL1LDtRUG1SGy+ISPKUAqlFz8NS7tTO3AUpXZt1N5HQSI/vUmF4pi8
         qkgI73YRmIVMOU266bQqtnh+6E5ATBG1zSVB+/MXtHqNdqzWEtJdUIA/R84xkGcxTPXR
         f42DmfLcawYsFoh5VkuI65gFuPlRLOEROcDYoPpkxAgXERcKUOnLtgix6i4wcFypX+Tq
         7KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159831; x=1763764631;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJmU6OX4fxASeBZw8+3vcpjdO2uxAnd1DJg4X0igPi0=;
        b=PtKdbPS9xKdxYaXuNCIfVB2IaMrhd6vgEjweA+13FcPm1JvK6CxWYSM8cxTF5apx0C
         AyGi3PGCe63y/bHRhoGnQqp9NqvY+flwdErUymkAngS5ALKYHYapBdlghdae2CbBg3PI
         pSqH6yNfUkOwauL4UfeGlnIHWvzJ6imr/yiED0WbNxjBUKGPGtdm169WKdxolKtw3Spl
         pulGKEuUpK1ZvxLBwGyRhEdmqqR/CM7LjdtF83DkE8ntzd3Rfab0WEIYUu8f7iMFJM+j
         4M0I+om5cH/4M9mmvaFXrDKuqAFeGzbQQGaz4yuMEZ4uPuLN66qojwB++jEvw7Xpb2mR
         z7fA==
X-Gm-Message-State: AOJu0YzL7o306P38UAE+3HBBxLl3sNusXQDclLLF6+SDD41/pc1hxMEq
	FBvQKVHYvAGb8u+c86i6dS5jVbNtkrxoq2Gn+9j0a4ySxfHtWvbNBvfpDiftgeHW
X-Gm-Gg: ASbGncvnwzGYV1rHVZlGBDmmDqdRAqrS7Tr5gqbg18od/kOj9vYImDUR27tVtUcvk2u
	wk90ODlH9tjCmEXjf0Cp4UuWFjDJiSUMJYqADkF5xG3umc8RaJMLVCaed/MNJZBv7AdyWiFaW+V
	oGrejtfB9DPoniAyMd8DsskFYkrG2kjoS5nIpW1IAuLtBE5GjgsAwj0OsJxETasfixxSYPMiklI
	8dlo+rJOO9FIji5sgzen72EYd4HMFaZqIc4G438BuUb4hAWPwLYrgmbsPsmW09fNQQOnScL7YB8
	3WSVwyNpeJChmTR3Iv4Y1qa6U3Hbh5ZECeRCt/yvRUY1x+qi5wiqSLo66gaNqpLPu289y0Nhgw2
	wxNIBLle9dCF+g61/szWPCkOXTiL10FZ9ec8oosd61VG3YGqzUZ8yRhv0FO73937elDmRAbkJpa
	IESQ==
X-Google-Smtp-Source: AGHT+IE6ZgwajZlyiAgqxCjhW+Z33oVrmYw/UcLY8jpKGJ3mJgAyflRijGFtJzuSNJq3YGkZlmpxdw==
X-Received: by 2002:a05:7022:3f09:b0:11a:51f9:daf with SMTP id a92af1059eb24-11b40f89f5dmr1861677c88.14.1763159830709;
        Fri, 14 Nov 2025 14:37:10 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088604sm15080569c88.7.2025.11.14.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:37:10 -0800 (PST)
Message-Id: <950d1e6193877faba44899ca6b9c274a889a22f9.1763159816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:56 +0000
Subject: [PATCH v4 10/10] xdiff: rename rindex -> reference_index
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
index 759193fe5d..8eb664be3e 100644
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

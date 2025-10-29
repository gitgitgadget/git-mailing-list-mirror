Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE5320A3C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776406; cv=none; b=lygqYqibVBjhJDtn5+HqJtDJg10k867AjUFKNdT7WN6MBrcuzlZLEVNvxCEbrdiKpsK2GU//TkOvM1d40KTykSh5Gc9xZJP8vxfY9E+gF7g9V9/yxhLsqjiI0W8YJG9TE6zjMI/3AJ6SKNM7QIXaiO7vTbr9IRhLUpyM4j2FfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776406; c=relaxed/simple;
	bh=nwU+vluQiXE6x57E2eaP4i1FOazc+SbC8r3YuaJViYo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iPSGkD3MumlZ+MyIiNmOSofifbzOmBdJkf00xrEJQIDYHyTqKq0GeDpUJIFS1dc5b3JCQSO++N/qkx2d4kQJwNuZLBZKhTcWhoy+kTHBnBQ0UoDGJoFxuTmuwbfmsq+c03/rlVfkGWvHQjbJn5OmQdMBo9VF3C7riIriyyXu81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bijf4ko0; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bijf4ko0"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-93e7ece3025so17473439f.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776403; x=1762381203; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YToev9cL8iRJ2HJAAGQC0Lvh8SuDUgrr/OVI1Az1ffk=;
        b=bijf4ko0w8Y4cZIjNencwj9RzYdv3o/IEoqnUeBjUyktIvUbt+tNOXjyw+DTndnOoB
         E7g88GlcZ6S8h973ylUc6479lCZ5EquDRcZm5jbGHUzZ74X5D47X0s3Nz7ZqpMiejlwp
         M4bW7rCrGUNNjwGZ5TqHIKmAhm2ZdAY88Dfi9brDc65UD5cNse55trTYBIhvMlHIWYT2
         ICsKQEDujTO6b9aJtdDAv4HBvFZDSivMniSgakmCMBrUIOWZ2fdBr78jUvKpg4vDOcm7
         kOs9h/T+5D7tn0NEJixKnU3gc5TreG7sI3SZUTcuU+1Crs0meR0gP8uJJqG8bGFujTBO
         0cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776403; x=1762381203;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YToev9cL8iRJ2HJAAGQC0Lvh8SuDUgrr/OVI1Az1ffk=;
        b=VPsiz8Kvt8+dye+n65F6geJq+eNlIO98PVdyK0OvpLhs6qpF50VgUNmVdWpX6xbGX4
         JKePw/bAn/c3o3FYGpHHggDi376SpZHS44KMQeSPl7tkJ3SHJd4piw9PeSeo1fOXbei7
         4EYE6+OOfok+bVbpxcrMBzU+WJ4tk8vyCsFXrN5Mx92ZQ7NMJTPAlCc67XUjdIeaLyUU
         YrVx843Zhmj/gfLkZi0XO88ljSBcsAXnzoBjndJPCRZGMhn7y/VncRnAocPnvpASO2Xn
         k3T6d7HULozyN2RfgThpqHC69d0Wnk/WbxRjXy1o06/DAUCcDNnXrMgJIbaUUT/jkUuv
         BpAg==
X-Gm-Message-State: AOJu0Yx8/dM1Xi02Mc194PerDowNnZ65U2jGMwcs4dPn0730fOrTJCu8
	eGN9Jv/0/k55765U9qKmae6y8ooLFq4vs2yLkLfhaixHkr/CXtovpC0zew1cSQ==
X-Gm-Gg: ASbGncvsYWEy9W54UkfuZb/wR4o8jhz4hSjORkRdv3iN76Si35sQ89pUCXfnhHTE/Lt
	F5XkL42k9KxauXjbeC30t9bJRmL7PbrFfinGxgeH5ERnieg4ywNNPEYHwJC7kyhF8dJaCEXWNwg
	LKSDE58mNDoIJQWg/DPBCD3/vLc1Caxp8IBfRQ6ECYq1bu7QD9CiC/LmfPm4UIYY3CZXOgTqF52
	+W4Hnmg2KJu1EM94KL6So/UxOEjV5S2XyrhQqNVJ4u9sxqmHkyXhFeQ9z9n5jLlIfrDOkomfekQ
	v3EC0r9MTj9VTeTaz7H1qMFPRPbOFhSHhP5kV9WG3Mvp8pF+j7giEXGSyB3XyPg8anB/YIs9jKB
	roUewfHw+kezVXezobeyKIWUJRCm7VxW7v9iC2suV7Armnvt5yhRZAXHvSp5SIz8As5HwCNxMgq
	/1Sg==
X-Google-Smtp-Source: AGHT+IH5HTQOTy2SD5Z6D+oTIRAmcf27xLN4K3ofrbCMMH0MIWiZBp2eYUf23zzosZ1brBLK9uKJww==
X-Received: by 2002:a05:6602:1653:b0:940:d3df:39c2 with SMTP id ca18e2360f4ac-9481508e641mr205603639f.4.1761776403436;
        Wed, 29 Oct 2025 15:20:03 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea77ebf94sm5881891173.23.2025.10.29.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:20:03 -0700 (PDT)
Message-Id: <1856a29026d8c3d824723e253dc68b052a5d8b9a.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:48 +0000
Subject: [PATCH v2 10/10] xdiff: rename rindex -> reference_index
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
array, and the lines of the file that they reference, are
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
index c690bafeb1..1dd420a2ff 100644
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
index 3bcc0920e0..5accbec284 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -49,7 +49,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
 	bool *changed;
-	size_t *rindex;
+	size_t *reference_index;
 	size_t nreff;
 	ptrdiff_t dstart, dend;
 } xdfile_t;
-- 
gitgitgadget

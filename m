Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560733DF009
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903602; cv=none; b=hvwQrPh29tD/pr4yQ5LyyKOUE3+pHWT+Ly0dqSZ3cTz5ZQRe8IJS14WMDU1xB6Ie/EFqv2bRTEDE3MqzPVlJrNEIm1jWESiQZw1dovRuooiOGghNiCv/DV3NTXIf7ZvNV9tG6HuHbUhxrWq9kmVbCMoXXNHGAJF/D7oKLKC/96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903602; c=relaxed/simple;
	bh=V3MP7JKMD/NWA7tCOZAyCnRwUvmcYN9mfMkJ+WVnOiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1NGTHI/HwifKPlv5ErCdXel1pae903hGyBb4xD7zNLQnZ3UHg7Cg/LJvMW6YsBywcCFW6zGem4mSafYHCWIw/8Xvp0DafBXZQMVu4EvOCuAtaGg8Qc2rn9DSKVlDXd2vCC7Co8D+O05LoNP7PJWVCbY+2JfYY/0V4hGFFRwLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtBWNjN9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtBWNjN9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so67071025e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903600; x=1778508400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYIIdYrGkhYuFxg3irCaxvKMHAtaBAFBaRdDY1zT4/c=;
        b=RtBWNjN9JYmDPZVeFVVH4cvPyvLPFdn6g1ltrFkcjR1jGpO7upzNlT/4Cq3hD8fVCm
         d3PlKBELLAnv2E3FyqkiOMqmvE1xm+8EcXj05e/fITMHL9tGgirXkWmWMiTGxWmnget0
         ED+GYh+E3ArEgp/tfYDCW3p3yFxQ3sGpRaY30fEE2hNohjkf1/4lX3nymqFomAlNGdtQ
         LSE5Gg4Rwz90KmTz2zg1nk5fL4hrLjOMQRYofkasDEDCrrJtZG7skZVYUVzTENXKhoRR
         UL8Lb015CFEhC7LrCzzXssaT0T3g8qNgD1wGZATsAB5ihfcMtBB0peviQwaCO5Ismqnj
         1qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903600; x=1778508400;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYIIdYrGkhYuFxg3irCaxvKMHAtaBAFBaRdDY1zT4/c=;
        b=kWism6n1HZ7BfOmR7cyQ4GT7A6qg0Len+tzak4a4CjdzKjF8+Ems/21dkvEWk0ALyC
         erJFDLQk8PH0ImSEsdgnfb7nk+1QWcbh2FBdEOov+NWbFTMYhG/Krf19mu/WCGHi2Wwp
         PdJ+1yLJy6oABBdg8UXd6dD4LZWH7DQUAcLB8zs+BDrNJoZXe1BsZhMLmBmRG8juUugb
         MKchkPwe311FWQt1UBFhBh/F5oFur/1h3UJlvmOt7G+rUkgKrkRs37VpZpUSVltT/7Vc
         s3J+WQKhlxHyLlqOsShHPrO/Uu/WH81ku61lkgh/KR5r+bGMthnAZOh1r+PvCADGxF8o
         wNMw==
X-Gm-Message-State: AOJu0Yyn5jhzxBl5zWE7lxjQ6WxFaxpdgjmwTcjhC0KToF1JnsXoHKZ5
	2HAsMYjG8hDT6WEozH5/Swas15WNcM01P/h5C0HGSq38rbBX2eVB/vxeYFxLUw==
X-Gm-Gg: AeBDieuENkAAZuwU6fUQzLLBMrhj6B46HrBU+nn7fytfKYseJMvn4SIdbPfa4fym7ji
	KHHEyXIna6tWzTr0RKh5DxjxZ2B3hjlT4zZd0u3mnGuD4C/QCxP+q0oDwFJx4GOF5SBuALjsEeK
	xOwrGIc5QFVdnM4v4ApItnxMjdUYLxil1hNaexarUIV6PNmOEG2yAX0UpnBLV2JCOJ6Dk+n2BJh
	c99mZIMi7f/Ec+wDrjkdx5/sntZU3VLknU7+TKhva5igUklnse+R1ma56KaaiLVl/fU5cHBaas9
	zWFXbp2MSKpIA9JtFKWGRYdictKJhAvQw7n3S3AXF755ixfwZinwrv8jFxZb4nS2S5LRT/rKenB
	x6KSkWo89zDpywJKjGAjJABlko33MA8qG4rSCy6uaXyimHm21Mu1y0jPRV9v+KD6IqHR0MBhDu+
	XuU0fgRAAwOTTwZ8jZHzH7CPz3Osikus+31rR+GOY=
X-Received: by 2002:a05:600c:698d:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-48a9852f4b9mr158357985e9.6.1777903599629;
        Mon, 04 May 2026 07:06:39 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm390520555e9.3.2026.05.04.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:06:39 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/4] xdiff: reduce the size of array
Date: Mon,  4 May 2026 15:06:21 +0100
Message-ID: <d7cb49a7c9987ea5526226ce45d8351b7fec5d31.1777903579.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1777903579.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk> <cover.1777903579.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the myers algorithm is selected the input files are pre-processed
to remove any common prefix and suffix and any lines that appear
in only one file. This requires a map to be created between the
lines that are processed by the myers algorithm and the lines in
the original file. That map does not include the common lines at the
beginning and end of the files but the array is allocated to be the
size of the whole file. Move the allocation into xdl_cleanup_records()
where the map is populated and we know how big it needs to be.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 7a29e5fc474..11bada2608a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -170,12 +170,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
 		goto abort;
-
-	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
-	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(xdf->reference_index, xdf->nrec + 1))
-			goto abort;
-	}
 
 	xdf->changed += 1;
 	xdf->nreff = 0;
@@ -283,7 +277,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * changed[i] should remain false, or become true.
 	 */
 	if (!XDL_CALLOC_ARRAY(action1, len1) ||
-	    !XDL_CALLOC_ARRAY(action2, len2)) {
+	    !XDL_CALLOC_ARRAY(action2, len2) ||
+	    !XDL_ALLOC_ARRAY(xdf1->reference_index, len1) ||
+	    !XDL_ALLOC_ARRAY(xdf2->reference_index, len2))
+	{
 		ret = -1;
 		goto cleanup;
 	}
-- 
2.54.0.rc1.174.gd833f386ac5.dirty


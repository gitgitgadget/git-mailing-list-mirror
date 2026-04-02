Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F193EF0B8
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141886; cv=none; b=pIl7msmsf2UGtDAepmbEdoVWwRqD3Ko1fCuR2PpqVuiPeDir3KJLJsILnLw8tnlATpOa4Z6noM4Zkr3qR3pYZSdYIO9MyV/T5cQ6kkDyaLN+Qz89P+qmeJBCdtnvV/BFbL+pZT+zwGIdAg7JDNb66kg+VlMY4PdtKVZgQbQgnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141886; c=relaxed/simple;
	bh=1kPrG3mgMAYnlQGLzVDLHeGBh8gGQXRL/qzYyglFo+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4x6H9eekUrJxWA0VcZ3MC9vmE5R7fP5qDyPQVNm8yNEKvTMsbH4LSeNC6pr4NE+OTvtKCGU5GCclPgARSB/gDmQKWD9RtZxDYaL/Bq+f1k+KjrNarl7ITxeSIfNgaAzakEGYi15RmEsnrbxMsX/iynbJ2Og1eAxIFkF1VpjL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJB2MeJd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJB2MeJd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so6542775e9.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141883; x=1775746683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xBcsLdFa28wbXtwBBha9uSh2s9ms7XmD5KGQ+3Gjcic=;
        b=QJB2MeJd42T5VUZ0TMB1zjjZHEJgM2kfMIseVjxMlMHvF6crORiTPJW2joJoeEXs2K
         hWgUCGLdh27eilL5Pqxd26IANpcYAbUxRoha/Pf0BL35/heXr9DMrDBuZ4d+bmBNwoG+
         qDki7lfKmFhN5WL/f/qp+T3skMYsKUQouZJWbNoYo47b/sXhrMxjOFNOr02MwZcCcRSP
         TmmA1gDakEphya8W5ooWWW3YFle03aHEU5tjQJFYzp6dUZZ2vP8mKD9hfcBRwYi9xPvV
         rbCEMVM7nK1nx792mgf8Xrcw+cY7g0tNBqv0WN1nLTLQpQP6hsX22/YsQHaaEkqM+eg0
         FBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141883; x=1775746683;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBcsLdFa28wbXtwBBha9uSh2s9ms7XmD5KGQ+3Gjcic=;
        b=BcbCykya52+59Fimqc5UV+SC2wbkhyTSENFKA3QPUnss1pezc/MpTzMkSqA+Kiz6GQ
         NVSMM+qjIftVPG9wS8OiNoXF5ySulRYFP6cFbK+E03EuyhJh3FmT5xHB4vSu+P2SCQsN
         CTz+Su3lMAI8LNLsyhXSJCOxv++RMQzFSbyoc0HCSW7a8mgavreDHXvKLQRFl6wwdyFA
         SreTXIfGn11kSjfly/6tXjlZNI8wJ1en5HUIL/cl+6E9FjPjvg5AKIAgtnh5ep61kRnC
         JOjV7L7ufQUiIs3I4C4nf1dmlmUhZ4qUXUt0cFsXfSjZl5aVMj7zgISxMGmJJvU4IrKw
         Qd4Q==
X-Gm-Message-State: AOJu0YzgqAkO7Pw6pdacw4tYkG0ceTw8F9vFEUC8ZeVLwPD365ALqS/5
	EbP8ryriFP/kNek4Uo8XUeq+7CBLBWPIr9Uj4ibreEYsjR/JDeHHHfuhjI/qCg==
X-Gm-Gg: ATEYQzw8GNNt44XaQsrVA1XIkwfm0hb8Kq4L+5JYZuSdoKVkkSrWDmVHpd07REcKK8Q
	+Ah/M8c+yQoAF366eY7aJNB85x8bZlzhcTaNmfoBv61HA/6HH7HHkP3mOU2m38nVYmbgNQECutH
	3pxvbdBQgLKSdtsTMBVF/cq+703AfBtol+lqNtXRoHWycMMbqkL8J091B70ZI74aoXyPDiPVFkO
	Na/ZzAGJqMKsAesp1kOCmsTuizlX2ACd9sA/FbCRrc4QkYoyNAWRjBPbOMP15CfcIjRQ8UXZGlM
	NCE5LKgL730NIYdpPVu5A+4MyGyeh9NSj6i1DK6ambqEr4z4hhKOHQiog5IaPzGH4D1FKFgEn1d
	mc9eRvSG3S53PeDMFkgX15+VhRNGROvlYyfQhIjTEN9qRQ7tzVBNzxgd7jFbCjHt0lwnI8/PxbM
	fDNv2ngj7TTYVBi7H79K7cYB+X2g==
X-Received: by 2002:a05:600c:a406:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-488835ccc61mr110859545e9.26.1775141883063;
        Thu, 02 Apr 2026 07:58:03 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b6230sm70913705e9.24.2026.04.02.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:58:02 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 4/4] xdiff: reduce the size of array
Date: Thu,  2 Apr 2026 15:57:44 +0100
Message-ID: <a3438dc09335ce46c0141c80d18d71cefcb96a4f.1775141855.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
In-Reply-To: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
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
index cf4ac34f047..c5a3c9cde76 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -171,12 +171,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
 		goto abort;
 
-	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
-	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(xdf->reference_index, xdf->nrec + 1))
-			goto abort;
-	}
-
 	xdf->changed += 1;
 	xdf->nreff = 0;
 	xdf->dstart = 0;
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
2.52.0.362.g884e03848a9.dirty


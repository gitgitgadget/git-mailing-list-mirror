Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88881F5851
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371248; cv=none; b=Go6a8fsd5gZTnwBab1IOoR6EsSTkF3KurxOBUFMvJzgufJuCZ9jhb0EmAy5H47veCaf5j1IBbJHGo4i5NcmWUNpqLo3XGAoAxNjkvLDSqM5wne6KPMPkv7ArvSjjLkwOE5JoXlIeN/ZNm1V7l2JS+WkxYC6vShe7fcicW6Ldtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371248; c=relaxed/simple;
	bh=DgvDv3Ky2Ar7SkF3BgaKbwfJO0L58lDr43Dc1IlMQ40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0zKVnKReYZ23lD5ka/1z5jZ66HJGQkpnaTZMafIMwN2mqKHDHuGfYqy/8KRP/J8iIsoeuQDAUNirMW0svXYNtjJ/Xng2b9VWXjjaqVT1Gr8cpzaXTFKoqV7Gdan6tmkyONcqt0YucBrISDblyHn8ehZXKzsRdY7aWRbXAhXkT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBMtCWkI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBMtCWkI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22438c356c8so113053475ad.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371246; x=1742976046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KRJSq/HS6oHh+qF3++84kdXC12S4wmBjADRcMDgt+I=;
        b=hBMtCWkIb8EgjFmArkX6mRUbPFL0lOKo/9QSP0I64SNAS9Hh4C4DnIsUDcszByWRw4
         Fvi4QZLgK5LrlJr82soTw8a/nH0C5MbH9iplLZU22PD4xKdp9ycWE0xoOWOwoWDd/pot
         C6APQ2d2kfqKBDDlM8cSO5RgBgxWr3ts+I8RsxOqTGm3BUy2gDdSiL2TQ5VMtUoiZTLr
         Feu112j4fANt/scGMw6L7CTyRpQznMdP6eX2UAU17Y2UvyvHQPM5/kKuDWpKqgj+8FBH
         w0aF6p8yWVt3mefconnPihfSKTiT0e5XE5qz/bvKuhNDxy2h5F52hUmwlIj+F1wrPnVt
         ecrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371246; x=1742976046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KRJSq/HS6oHh+qF3++84kdXC12S4wmBjADRcMDgt+I=;
        b=M2hr/YhAG2jDs+pFvAxZFzOdKGSvVX5biJUK4l6dMfAzM7CcGpfqxpGsleOKR6ak4J
         SnADh4mIMP/HwEZnXACN1CzJvr05bBwPJsWreHeG3mRhQuCgD6ooh4dtWwxHNREQX+8T
         3vBZ/WYiYGP/G2iwr8+Kz12gr8PFGZlTeE4nRF4QP61FEp9tTIEKJrzVTdQQd86GpA41
         zn2UE/f3qGV/5FVXqkUJo+idEF1nk2ox4d4dIhhmJhBJ5FaPSEYmlnkO4+H+GirYqivI
         UvuZP9Dz/BLpMRDn+reEVkMkJxcRLtITMp0MEhe4UfSf9DbKtluVJNbVv6D+zHGRmVGD
         vYfg==
X-Gm-Message-State: AOJu0Yx0MHAriFyLoKBZnQOa1GSt4JBsdxVN7SHzMozEIiw2spf8vnZ5
	0RhV9yYASlcbtsIWfvWyrt4Y9DOQP5Du7vP+JLKyc1X//gbDOHEX4VWvFA==
X-Gm-Gg: ASbGncvtBBlkkKfsFRlJMD+fi/MZiGRx795lOdcv+ppkqeKCeBSZKlOqmm0Kj9HrGvu
	kVSOxNAjFrOkXN6wR/y0KyZVvo/qdy/MPPM6LvPOm4AiSBqDubF4ZgRDihkXeJ3riWLiwYUizpZ
	ON/4SkxsjzODPqK3L+jKgdchi2Etav+uJbQPd66eQtAATaFGwVL3UQJB+GxomscBuE8A1PBkIKl
	Tm6zegBS2nEv0hpImQM5OfWE4BifI/ACEy3Mjjl8xlI/Ovt3P1AKnoIgdkzmnsXvW+j2SHjfcMx
	icTc/cClYuJx5/3ckZxG4WYkQVkYtd/CSKNJUvHT
X-Google-Smtp-Source: AGHT+IFQbhTrLqw8RmHQZV3dC5o2XZwDi8KilN+me38wC6g2T9M5iVs6MxgWEH7GPAfnEz3u5Wbzhw==
X-Received: by 2002:a17:90b:4b89:b0:2ff:4e8f:b055 with SMTP id 98e67ed59e1d1-301be2341f8mr3242518a91.35.1742371245677;
        Wed, 19 Mar 2025 01:00:45 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22629cfbcb2sm32866715ad.176.2025.03.19.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:00:45 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v4 2/3] reftable: adapt writer_add_record() to propagate block_writer_add() errors
Date: Wed, 19 Mar 2025 13:29:42 +0530
Message-Id: <20250319075943.28904-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319075943.28904-1-meetsoni3017@gmail.com>
References: <20250312121148.1879604-1-meetsoni3017@gmail.com>
 <20250319075943.28904-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Previously, writer_add_record() would flush the current block and
    retry appending the record whenever block_writer_add() returned any
    nonzero error. This forced an assumption that every failure meant
    the block was full, even when errors such as memory allocation or I/O
    failures occurred.

    Update the writer_add_record() to inspect the error code returned by
    block_writer_add() and only flush and reinitialize the writer when the
    error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    propagate it.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 reftable/writer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index f3ab1035d6..94c97b7ac0 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -310,11 +310,12 @@ static int writer_add_record(struct reftable_writer *w,
 	 * done. Otherwise the block writer may have hit the block size limit
 	 * and needs to be flushed.
 	 */
-	if (!block_writer_add(w->block_writer, rec)) {
-		err = 0;
+	err = block_writer_add(w->block_writer, rec);
+	if (err == 0)
 		goto done;
-	}
 
+	if (err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
 	/*
 	 * The current block is full, so we need to flush and reinitialize the
 	 * writer to start writing the next block.
@@ -329,16 +330,10 @@ static int writer_add_record(struct reftable_writer *w,
 	/*
 	 * Try to add the record to the writer again. If this still fails then
 	 * the record does not fit into the block size.
-	 *
-	 * TODO: it would be great to have `block_writer_add()` return proper
-	 *       error codes so that we don't have to second-guess the failure
-	 *       mode here.
 	 */
 	err = block_writer_add(w->block_writer, rec);
-	if (err) {
-		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
+	if (err)
 		goto done;
-	}
 
 done:
 	return err;
-- 
2.34.1


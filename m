Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727A1D5AB2
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398193; cv=none; b=XpzrYOEH8+LuSq+BikEdNhS4ZS906tMns32mV/LhQsDJDjVt3X+p72nEBPemVNned1nPOc0nW+GKGgbgrLgI+9lpD7lyKuVqNIf+nkeFyCqnFcSkoHFUnwjd1dFbyi1oh4smmy+RxhUU10kwgrNG6/8hqi/Z9bR5re8+qjL8aoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398193; c=relaxed/simple;
	bh=bpRt6Qmct1IkprOo/qyL3C67MQsxwAyV3RJZj/aLAQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/B2CTQDyoYSoLi6iVwv0d9k7C8syLFrQJpdQcPXaOl4EaH+URt9E0R+rtBtpg7XKjHeYX8uGCfDlVC3wH8+TQpB7DxFWpC4zTxnHB21o5dQHfHDmVVYu87KgORjCnQYmv4WwjvVx0Er1vc9+x9OYGscBn+oPhgwlER8EhFfFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7N+QW6k; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7N+QW6k"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22349bb8605so157450555ad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742398191; x=1743002991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVHrWd7Lb4i+qpKmnMBEF86TEF7UFSfEvV/jH/a5SWo=;
        b=I7N+QW6kYs4XstkbWpEgslvvL8e2A1/On5ybVJWdoYcBuejfPZEJ1WCUVnOEKxMX0Q
         setrU5D3qUxVAu2mC/0ukyFzR3xk0peBfPTqEzMNd4jAEg1GmEpQSxhRBIVmop9Gd4kc
         vyRbFSeBj4cnL6MQFZUsHy+k6bn0sq2VTi+Mims2YmhYbB0GmfwgPk0hOOvGFEKCIdtK
         0+dL8m6dRz0BmL/Yk6hQ5HMfjRFD5rkA3PGjleQNFIvv4t8DarpoVTNnK+3Vb/Hdrt0N
         QusqZ4OZuSLAtMOOtULvSM//dPYtDAmjzDdPO7rqsA3Ibp79af3iCbRr9+m4Xp3n4jux
         /Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398191; x=1743002991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVHrWd7Lb4i+qpKmnMBEF86TEF7UFSfEvV/jH/a5SWo=;
        b=qEf+G4azHeZhiZm1MjjP9YptxeZrWm89qL77FJ/7Ed+RJ0aFXNS9rMvupvEnLmwm+D
         SwD2vZa7f5gIZ0Ryy6YcAHp92dNxAXGcV04FYpg0nfFQx5WtjK/F6pE9UmrI5uUfMprV
         asFhJgewb4OYGXpUlqpcefQfWaP3KmCm3Op5cGE16dhvQtQhFs3CPt17pq+nfgkZa8Af
         pROQ7U9TsR+Hfh8c/sqNfVmvumBI9+dOcnxrn5QyN+iRiV0cyhGbWyfOB2YqOZ6T5LTV
         0Xgu8zmClKjZQC6m8GPuuLsxCnemHzRWO4CtrT0fi7QelbapCTz0/MgHfwQALgDFV2tQ
         imcg==
X-Gm-Message-State: AOJu0YypS/92wL2vnVxYjyXQ2Zakqb4fWtayWV2ASNeEooTXhTRfG4we
	4XIaCtvyWr/mAD00VefdeeQ+wC9NNfCGpF1SoSy4jy2T64OOz6u/fS0FHw==
X-Gm-Gg: ASbGncsswHOCj+yAWpMfGzRU+KkncenZMHISwTTdrEgO6J0v21n+/fEhFtYiTrw6HLP
	YcIcKZ0+2gVNqVQMiOoTO8CAKT/TGyagGGGfiNjo0aGTEIH+Ied1NcXTP5ekyvKw291Di2hGRV9
	j1BQt4Lh8733jJopNXL3HfMFjumjaQz3lPISG70YT298tcRWwI+KSbAWFysVcDjXApTNgwtu3gb
	KdX8q2bt/SNi3A3BREu6i0f0LZqluuc3eYOokJ3pMnKEUD1EEMdHhlIa3+tagH3X0284Z2RGqSD
	4kngH7wJ0meExivWvi9mmCnHkqqoFJ16+/4k0c9j
X-Google-Smtp-Source: AGHT+IHll4KPD3h59wrcuBuFFHVYAw9+b37p4XUdB8nVFxEOGJfxehhT4UlgZzbCbH7jNxsSD/rBlg==
X-Received: by 2002:a17:902:ebc3:b0:225:ac99:ae0d with SMTP id d9443c01a7336-2264992dd80mr66670565ad.10.1742398190880;
        Wed, 19 Mar 2025 08:29:50 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6865sm115889305ad.75.2025.03.19.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:29:50 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC PATCH v5 3/3] reftable: adapt write_object_record() to propagate block_writer_add() errors
Date: Wed, 19 Mar 2025 20:59:27 +0530
Message-Id: <20250319152927.1263033-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319152927.1263033-1-meetsoni3017@gmail.com>
References: <20250319075943.28904-1-meetsoni3017@gmail.com>
 <20250319152927.1263033-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, write_object_record() would flush the current block and retry
appending the record whenever block_writer_add() returned any nonzero
error. This forced an assumption that every failure meant the block was
full, even when errors such as memory allocation or I/O failures occurred.

Update the write_object_record() to inspect the error code returned by
block_writer_add() and flush and reinitialize the writer iff the
error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
propagate it.

If the flush and reinitialization still fail with
REFTABLE_ENTRY_TOO_BIG_ERROR, reset the record's offset length to zero
before a final attempt.

All call sites now handle various error codes returned by
block_writer_add().

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 reftable/writer.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/reftable/writer.c b/reftable/writer.c
index 94c97b7ac0..f48e7cc290 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -620,10 +620,22 @@ static void write_object_record(void *void_arg, void *key)
 	if (arg->err < 0)
 		goto done;
 
+	/*
+	 * Try to add the record to the writer. If this succeeds then we're
+	 * done. Otherwise the block writer may have hit the block size limit
+	 * and needs to be flushed.
+	 */
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
 
+	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
+
+	/*
+	 * The current block is full, so we need to flush and reinitialize the
+	 * writer to start writing the next block.
+	 */
 	arg->err = writer_flush_block(arg->w);
 	if (arg->err < 0)
 		goto done;
@@ -632,10 +644,17 @@ static void write_object_record(void *void_arg, void *key)
 	if (arg->err < 0)
 		goto done;
 
+	/*
+	 * If this still fails then we may need to reset record's offset
+	 * length to reduce the data size to be written.
+	 */
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
 
+	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
+
 	rec.u.obj.offset_len = 0;
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 
-- 
2.34.1


Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D092505BF
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371205; cv=none; b=rl/qSKpYWapgLeQhmulPK2T+wT+JLHcaH1gImOpoOkIFJWfuRPdi+3/c2HW9Vdx5vIsX7cH/E9WmFyyPCt41S2hNauQwUkezMVdekqFMKCpWv7I/yUejl5COBpAVeWFW7DrxC7JKncJffa0krCaBdDAHw+3QqHx8GlhuH/fBzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371205; c=relaxed/simple;
	bh=ga4Pb0P06pCEXo5/nu6deGtIdVT5Jws2Q+zxw7nACLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJLdWueZKJL1yC2rKwLEuqeBGwOk242PYkzjl9IvvBK86CQNZv+TAc0SRZaPHoefeIfJzTCoxcbP6zU86F/Bv3Ita2bFW7O5zhc5OM2GG4eic1TdZ9OXSHXAwgdlWF3MOuO9BXqQDbGCAlO3eLNaizx3R7FRUwhgayBRyPC42NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF3hMKop; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF3hMKop"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-226185948ffso60182585ad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371202; x=1742976002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzPQhCR5k/0ZhGhfXW9EzM0w5vww2LFzXukmkbATTdo=;
        b=aF3hMKop76iKaDzhE0PPCOhYofHQkRJT7PHwoAWdrr9KyB2oi7N+KC3tMLA+5vYcL/
         7fsG2YQDSg9NaLT8XjgEs9Xcm9ux6EpWMoUag2iIJeai6rak2y5+frirqZ2nIM2nAZjB
         5c76xab8kl7g0GEgfQRTnfkXXwCsLrHUCw58k4HHmuCJ+5qrh5kibu6b5iGHVi4dKP2t
         6Hgci0c4n/AXQ79hHBVkmvYLLkZ6yEyBD6v4UATaLf0iCWQylp18Y/1YTdCBg9InUxGP
         LWFN8wVaAAKRQV+G6uQReLAUTkOrxq7DDbk9rTo7nNbywg+D2FanvflZn4pNPIc1573y
         U4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371202; x=1742976002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzPQhCR5k/0ZhGhfXW9EzM0w5vww2LFzXukmkbATTdo=;
        b=iLxHQlJ4Bde2oFXZHDaVJ+wwtG8vsvmfHN4IIW7uh8HMadIyNSxZdPDFp8XTvzaypy
         /C5h4LPBYVrx4CJGQBztwJ/lPsgsA8soBPTBfXXt64ta+Wt2OF0MdCy/m3prpuXTA3V6
         UYckfioayv45xtfjQ25SJd6DNXun609HnHjgcCdg3xp9swpz19M8BmvSZ6OiJkhpxVY5
         DniqLkDjO/JMrz2AYE72JakwPKkTSQl8kzgTbEbqcx1/fAOlwDdvkKeKl7XjuOTrX/oR
         AaU+BdQPvUKnFGtEQpZq1UNnNIQCpcP3A+6yIy8uxFCBqVb4FKLpjulAyBfAfhOlHYCA
         Upbw==
X-Gm-Message-State: AOJu0Yx4rf/fqxHwXKTQOczChV+krbsAZ2WaD8yf7XBKACJ9JC0o4nt4
	y5NbP5XPtcz3cKfvacGmEL+u2oXNrs57LUkkve/xkJ5fevnLHgB+dzfrnQ==
X-Gm-Gg: ASbGncs9VCcSep1OU+2J+/zxw7RhQJ2UHmPtk4mpS0nWX+eQfvALSF/PBQFP4hy0Bkt
	YmVv8WDkFl1wdIoRern7hTfCaK5P2Dmbs9RtGsID+x3BSkAr+5rh5ZtjXDDw/s0Vdlg7kbpuahH
	m9blSeQBg+pYpjk0QULc1S3twVTP2VnsunJn0TIrrIF9HjlF0G3bx6r+W8KKHXBRKFYw6Mup7d/
	o1nN/VelD4Y45wsk9oGY2qvmP496SFPn6gM6ChPGxfZD64q8Dn3r/KPQaKDGRgvIWEvL2u/6DfI
	EteIBsfGkJl63K6kBTCDRx3O/V9JwQ2/4eNck8Qu
X-Google-Smtp-Source: AGHT+IGDG6Xe6s5TmzPqRkvmyIYPjzofgz+ro8grRjGV1biJCRYw/4UXShpl9fB7oQhieKkJtcyp9w==
X-Received: by 2002:a17:903:2f90:b0:223:5645:8e26 with SMTP id d9443c01a7336-22649817becmr20523405ad.20.1742371202091;
        Wed, 19 Mar 2025 01:00:02 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22629cfbcb2sm32866715ad.176.2025.03.19.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:00:01 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC PATCH v4 0/3] reftable: return proper error codes from block_writer_add
Date: Wed, 19 Mar 2025 13:29:40 +0530
Message-Id: <20250319075943.28904-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312121148.1879604-1-meetsoni3017@gmail.com>
References: <20250312121148.1879604-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch attempts to avoid making an assumption regarding error codes
returned by block_writer_add().

Changes since v3:
    - split commit based on the functions it alters
    - add comment back that was earlier removed.

Meet Soni (3):
  reftable: propagate specific error codes in block_writer_add()
  reftable: adapt writer_add_record() to propagate block_writer_add()
    errors
  reftable: adapt write_object_record() to propagate block_writer_add()
    errors

 reftable/block.c  | 13 ++++++------
 reftable/block.h  |  2 +-
 reftable/record.c | 53 +++++++++++++++++++++--------------------------
 reftable/writer.c | 27 +++++++++++++++---------
 4 files changed, 49 insertions(+), 46 deletions(-)

Range-diff against v3:
1:  6ab35d569c = 1:  6ab35d569c reftable: propagate specific error codes in block_writer_add()
2:  a54d440dd3 ! 2:  7f0bdc27e1 reftable: adapt writer code to propagate block_writer_add() errors
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    reftable: adapt writer code to propagate block_writer_add() errors
    +    reftable: adapt writer_add_record() to propagate block_writer_add() errors
     
    -    Previously, writer_add_record() and write_object_record() would flush the
    -    current block and retry appending the record whenever block_writer_add()
    -    returned any nonzero error. This forced an assumption that every failure
    -    meant the block was full, even when errors such as memory allocation or
    -    I/O failures occurred.
    +        Previously, writer_add_record() would flush the current block and
    +        retry appending the record whenever block_writer_add() returned any
    +        nonzero error. This forced an assumption that every failure meant
    +        the block was full, even when errors such as memory allocation or I/O
    +        failures occurred.
     
    -    Update the writer code to inspect the error code returned by
    -    block_writer_add() and only flush and reinitialize the writer when the
    -    error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    -    propagate it.
    -
    -    All call sites now handle various error codes returned by
    -    block_writer_add().
    +        Update the writer_add_record() to inspect the error code returned by
    +        block_writer_add() and only flush and reinitialize the writer when the
    +        error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    +        propagate it.
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    @@ reftable/writer.c: static int writer_add_record(struct reftable_writer *w,
      	 * The current block is full, so we need to flush and reinitialize the
      	 * writer to start writing the next block.
     @@ reftable/writer.c: static int writer_add_record(struct reftable_writer *w,
    - 		goto done;
    - 
      	/*
    --	 * Try to add the record to the writer again. If this still fails then
    --	 * the record does not fit into the block size.
    + 	 * Try to add the record to the writer again. If this still fails then
    + 	 * the record does not fit into the block size.
     -	 *
     -	 * TODO: it would be great to have `block_writer_add()` return proper
     -	 *       error codes so that we don't have to second-guess the failure
     -	 *       mode here.
    -+	 * Try to add the record to the writer again.
      	 */
      	err = block_writer_add(w->block_writer, rec);
     -	if (err) {
    @@ reftable/writer.c: static int writer_add_record(struct reftable_writer *w,
      
      done:
      	return err;
    -@@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
    - 	if (arg->err < 0)
    - 		goto done;
    - 
    -+	/*
    -+	 * Try to add the record to the writer. If this succeeds then we're
    -+	 * done. Otherwise the block writer may have hit the block size limit
    -+	 * and needs to be flushed.
    -+	 */
    - 	arg->err = block_writer_add(arg->w->block_writer, &rec);
    - 	if (arg->err == 0)
    - 		goto done;
    - 
    -+	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
    -+		goto done;
    -+
    -+	/*
    -+	 * The current block is full, so we need to flush and reinitialize the
    -+	 * writer to start writing the next block.
    -+	 */
    - 	arg->err = writer_flush_block(arg->w);
    - 	if (arg->err < 0)
    - 		goto done;
-:  ---------- > 3:  480ac27797 reftable: adapt write_object_record() to propagate block_writer_add() errors
-- 
2.34.1


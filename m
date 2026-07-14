Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AA25CC57
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069335; cv=none; b=lXTaxMYgarY7gJbm/749tD7szbfKoUTH2kdUNxUT/0ykGlCjOSq3w4jP+B47Ax/JMYPReivatKAZWqDt0yz3pzh+3AulOx+7zGOgC0nZx7SSZxg01sqT335T7NZddUpspr+b5qbmpzNBQxETzyZOhehflhSRZ7b9cekVbplbTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069335; c=relaxed/simple;
	bh=pykq6o+rkJVBzzG4gni4Wh0TbfmR1DAGauf5tFS59u0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=as2EQOCaQHAud3b4+PoG8nVjRF3C0WryhbCjMCvuQFhOh63h+sPumObU+Y/luLubB3oviTsMJ6P4edQKu9+Nm5PUhDUcpAKVAM6tV+Lp+SYUGJtM16npI7xS8mhQjR4cdYmbLbNjtwOWN6BZl3dfLxfy1mzgxqWklzR/0t6L6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT538Puf; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT538Puf"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb61bbeb25so871238a34.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069333; x=1784674133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AHqmvGrffoyv/OLlF0JaGtSyN6rE2zkXCT60aAQdDBE=;
        b=QT538Puf3ZC1ao3bcy6BohfDoYd0N0EEbUJYbbfKtsG0uD7djzzB69WlLTBP1TGuB/
         hc+QfIbqa4wNDz4Ut+a5yLB2Sc79qtxFU2TXLNyiWz/HFBoYucsNghNKdVSLb9oLoLe4
         zddcapf5PYIPm/tByqg138tWNX9S+bMW+JgAG3zroWlcL6C7ASZ1GCTWeT/MrQ4jTVsJ
         1VNWwnv4X1BfXB5SCA7Dv0Jz2x3MGWOp/UNPebfX3afDCRxg+3GIUzVpkoLgSiQ4RL6v
         4dkmraWTl+tnCDNHOlbGaQOcmNS9otydx68VI9htJ1WbX0+Lffqqgo8QU31OLF+dIfbF
         XQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069333; x=1784674133;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHqmvGrffoyv/OLlF0JaGtSyN6rE2zkXCT60aAQdDBE=;
        b=F+Zl7SpLD1DCiGZlngTKHHRmd07mMsxE0Ryi2ESsWtDf3/X/eYOAlxIuXbv+Gq/jAL
         KuhiwJWQkJk+HzzBEL1hHN4C3VzGnfDjfk5+Fsv2Jl5zncQLHeNHbP51aaAlm/EmZxlD
         9T72/nixLVJXvMzuXaOwKcYGiprKHqjlmjpcdATdIIxYRqUUTaeiJ+kA2aVka/SxhC0p
         QplMrkcFiCQ+nm6/TByPljWrIOfgiFM4346MqI9M5IRZv6L5zj+j2wJ4nZ+jP3JrFt9a
         QPpzxT9bEXdBrtcPxQKFVGIO9tTNDGvbD/DYMvXzo5jC79F4mqo5PZ16QDOipl3NwTKR
         qvBQ==
X-Gm-Message-State: AOJu0YwXAPDai6+nXDR1ruV129ZR7TsokmtV0R2V6fdzcap3M2fev+66
	I5lQcuni+nmlDZkKzlQHjF3Bi4PKyPzn5fOl/IDB9Hbzc9CaVmkm52A2f8SgJQ==
X-Gm-Gg: AfdE7cmTcZWNhLfPGDUADj3lFSOFZWnY3moZCzb2tyQE2wedMWLxB/q09EGTnEmt1mB
	VRw6iRVlBO6i4KOwAawoHSm/u1BSXmQtuVPPBaxX4eCYmuLvwTxOP6F1HFEEUojKf/kX6Sz0wk8
	3Ir6Bof7v26pz6SoLLlOj6xfaW4vmur5GQ44ak1azBsvrXt46enLHL7cbOmLEKFXjS698OIt3fA
	fLy3z3HJIss7jWQapKFNMfQ3Et/Tedc0Jjb4SiQ2P+S4DW2ioCeLixWzKyYDLCKcDN3CzIkS9jd
	POysG/1LIJ6gsYdlQCFNT0E/oVMg8DWi5nPI30KqIxG0sFq6ykaFEvKYHH/fv1PL06Fj7EJBNLG
	+78s44a69NDVfAFygcytUBNrU31Zj7nXWIg3dKts8sDXWpZ4D4z4Am2GXh5vJhacbRrNIeEBQgb
	0KCSfvnIzMq5Qm2OuF
X-Received: by 2002:a05:6830:2643:b0:7e6:f406:2cfa with SMTP id 46e09a7af769-7ec097e12admr9326538a34.17.1784069333111;
        Tue, 14 Jul 2026 15:48:53 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262da7sm15990343a34.17.2026.07.14.15.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:51 -0700 (PDT)
Message-Id: <9bf7e737c740d8a80467ee3b38df9c86bbf7a566.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:36 +0000
Subject: [PATCH 03/11] reftable/block: check deflateInit() return value
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

block_writer_init() allocates a z_stream and calls deflateInit()
to prepare it for compressing log records. The return value of
deflateInit() is silently discarded. If zlib initialization fails
(e.g., Z_MEM_ERROR when the system is under memory pressure), the
z_stream is left in an undefined state.

Subsequent deflate() calls in block_writer_finish() then operate
on this uninitialized stream. Depending on the zlib
implementation, this can produce silently corrupted compressed
data (which would be written to the reftable file and discovered
only when a later reader fails to inflate) or crash outright.

The function already uses REFTABLE_ZLIB_ERROR for deflate()
failures later in the code path (lines 171, 199), so returning
the same error code for deflateInit() failure is consistent.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index 920b3f4486..ec81fd0493 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -87,7 +87,8 @@ int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
 		REFTABLE_CALLOC_ARRAY(bw->zstream, 1);
 		if (!bw->zstream)
 			return REFTABLE_OUT_OF_MEMORY_ERROR;
-		deflateInit(bw->zstream, 9);
+		if (deflateInit(bw->zstream, 9) != Z_OK)
+			return REFTABLE_ZLIB_ERROR;
 	}
 
 	return 0;
-- 
gitgitgadget


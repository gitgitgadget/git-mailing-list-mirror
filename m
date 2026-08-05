Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5523D34B6
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954673; cv=none; b=NmawoluTGuqN82wdxi6Li9b44v+WO9G/KuKla1eG5vha+CkVfxmA+dZcCIu4U8uvJj2980e06qgylsa16Aa7HvX2PdFbqx0L6RPAmYuiwzLsFPaGui9msZVgahQh9gg28i97tXp4iUUjH7AeIFoKHSjPtJKZuF2MsjGIV4r1OeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954673; c=relaxed/simple;
	bh=pykq6o+rkJVBzzG4gni4Wh0TbfmR1DAGauf5tFS59u0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UreEIRwubBc5FyDEOhyOW40g5UUKwEj8bHJbEcU8XxaRTfzITxn7k43FsQ94VEOC1cs/I+MWMmvNvj4LTNDOq0dr/KYSBcHb06t51iF4BNf+61omZeMPC2QqPdyIHcBQYABsiJRM0vBt8N6uXDHiBKWoVBB4ZePTxkp4hdkqq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1YD9JI/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1YD9JI/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1036139a91.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954668; x=1786559468; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AHqmvGrffoyv/OLlF0JaGtSyN6rE2zkXCT60aAQdDBE=;
        b=G1YD9JI/aaVQLaPcxYWRWyBnbAB/pmA63RTySP67GyQ/60bkqKD54JpYzCzV/AVho7
         WuN8h/zhk+3aOf+EvLmW6dV87SI4349tMwmUKgM6liop2qwU9VXD339gkcXnj7acyRNt
         tl//i+OGM5w19s8kd18+cQf4lj3VMJS0yKqr3pfQDyBPwKPooQwW9T4faWE9avopZDx8
         9lgN2cZn8qs9ez2A/hCGVeXkThgIFLKiuLZ27ZzIbt/OMkhiLuR4f85WVfJ3oGzXhZLc
         NGKtLA3I4ohCyRR+FpdRNvlxB+skYxvgCumVP4FaTkOVcEWe21qLBILNk/MOIdewGjF9
         ajYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954668; x=1786559468;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHqmvGrffoyv/OLlF0JaGtSyN6rE2zkXCT60aAQdDBE=;
        b=CP2k9Hq4CydvkRDKh8VbbttSjGXBOD2W1gLOfAPef8qA0f+nA8Gmeq/4Pr90fRRzqK
         OTUGdCQR6nlcG2MXkwn+s+4EQdiuWDVmC2rgFxlTMzfEtewLpwCZ8Cq030ii6wx5u1P5
         Foc/wQ7BTFx0w4VHQr5393K7fKVogeABjYasR9Fq0ckd0nQY8i+qeqn+lCFapzUYeELN
         HOXxoU3gGqitU46UIBB8zHauF7t7WGMiZYZM+4DIShTf1c2ABIvOm4GrBK/nQWTJvU1a
         WD+sBmWh1+ZbS0pUcdEXxkuE4g/4py8xagemjm7hevQ60qU0kE0fAcXYBaTk9rfLXb8T
         /bKQ==
X-Gm-Message-State: AOJu0YzcsfOSCWb2dEjslq0QOoZUDQRdAGE93MjFWiIlJj56z+JAt2CR
	nrv3sGR0mV977XTlysrNf0oC1KKHqopb48aIXmOLBiQ9tBJuPz0+3l2alV2b9Q==
X-Gm-Gg: AR+sD11GiS5WzzksJ6FWi/wfLrETZo6qRo2HfPzBRSLf7RVVyC1hVJaLuKkWHZahASd
	UjmmLqVPq95xOrQfBShaiNv1cFHQyWFDBdjf298GkChaV78ZBpvX5bSyLzFHQdH4y3B+cnAz/dU
	b+wh8lsYCuFqOXGTkq66R7pP3y5LJl9RWQVOAEq20XTJ91/Uv3YWZujGm0cIISH5kQF/hhtj0nu
	CokubiBztfv6HslcNhgTPNqnPj7AV8fcXcfLNIIL/oiUohfSA5TmXJhiRn6kLXXU5mi+v+6uH+s
	MeQhHotEZ2uReVWXxjWsb8Jx3R/3kwZspvhwi+cDceYXB6s8I+gp/1uLLT1Z/bEuh8855Y6P9bp
	2j3ErrAoUM4BqqQMzvC8v+/T1cJLvt1jeclgIcvk0Bhka7/kd+kv7KV2EEh5VWLQFAA5R1jYZTj
	1mrJdEq8QdjOt98ipRYqp54iJ16/s/iQ4pbjOf/LOSBIoB0N32dp/eoNmeya3HAxp7sMe36cZkS
	JS+nw==
X-Received: by 2002:a17:90b:17c6:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-3903c59330amr8339702a91.9.1785954667791;
        Wed, 05 Aug 2026 11:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f5ab5d3sm1982861a91.2.2026.08.05.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:07 -0700 (PDT)
Message-Id: <9bf7e737c740d8a80467ee3b38df9c86bbf7a566.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:52 +0000
Subject: [PATCH v2 03/11] reftable/block: check deflateInit() return value
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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


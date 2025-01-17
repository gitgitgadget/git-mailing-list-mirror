Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46A1DE8A2
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151410; cv=none; b=FK10kFeTvZWZ7SUGIc/N2YaHk3LFA36C0v//aVo38mjUiOQklALMNXBgk6vlegNx1SlmcUWIUFUUdSHGUTsaRlK0rSU1QbS8I45R/80V9qkik4gRHfcb1OAkluI7B3X9EChupfH0xwzzxL2+mDRnNhhu85qhg7j4x4LiNvLEPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151410; c=relaxed/simple;
	bh=6Sr5D0vo9c5IeE3wtXQeheOl4L07Dh4wqzZMQifXjrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Byq+t9ykQi69cwV/NsMO9yy1Th55dcUbBVZkARYHy/OjWaPTKmonaMb18AMna2yGhi1UwJ/RKJaW53UPXhJgY7t/Z70Jyz5M4elkAE/Obmw0TIRtZd2NwQdcwU/wDL3yG4qPxXmN23LH3OOe/bpBWcix116AUXpKfGOEdrBv9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wRzyYZ6W; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wRzyYZ6W"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e54bd61e793so4999169276.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151408; x=1737756208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoN10/GjMDdlRdDA4HFTLrdK38qB77pmy38zO60vFhQ=;
        b=wRzyYZ6WL+gQGl6r1oWP+cTx/RRotWnI2ZiVmlUQzeaFbrfA7J45LIxT4FOvUqVUt0
         /sZqT/e/reFzCRQETTzhWkKYmTOj5xALRS5Ro4fIelH7GHR9DNb86A/WftCd4OGgawep
         ZV3xwzf4rIjNeLjP90HhQXVIWS2JPKJ1PtzqfghaW3ZuYiyRkkazaM2v1+7kW1SWm9dQ
         kd+57xGQyILT41hAayMEvyDoi1gVPzIojiWCPoQ2fL3Fa/2KWVoc+ruWjkrA6HHW6IxL
         ueIog/Ru9REOSUjsudSr0jKYIcJGM3e/TMHTk5cGLk7GAkJONXxooHcJ5A6AYeFibKZc
         tDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151408; x=1737756208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoN10/GjMDdlRdDA4HFTLrdK38qB77pmy38zO60vFhQ=;
        b=kcWD/qgQFKvfkXSli7i8xHT0soH1QjGOyU8HfCzkB3g6EkO9tKEXz/wI8XPHUT0ivQ
         5mM0vVEFW0gh+TGPZnimAX30rk0pRiX2ISz4QXnpqu+3Ldzls1aGS7hYF/yGBvj/CeXF
         /pqZZGqsUAbi4o18NrZ0fXgzhYp/wGFH+QIOzFvvkrIBcLalLMS99BbjmamGWuIfknCG
         6oB7rfbZJOPdvqzLvJkCq6FwTM6IBqteumwf7vbbbYpHRGRS1tIUQHbdLCLk4X0DTHle
         SpSH0dvcRUZchQ7wFU1eM1u5iekeHPqhpRduzMs3vgOoIE1+1l7WH+TfXoJPK8pB/NxS
         PV6Q==
X-Gm-Message-State: AOJu0Yyg/rCAtY6RujOWFeE4vrhXfONubsLPE9twJUWtg44ra33KbdiV
	5bIsvfstDbe2zyoOLwvSvSlTIHrot18D+prC/MOYsX8z4c7cTPjF79Hypkzx6HvBu3U6Xz1OVDk
	geic=
X-Gm-Gg: ASbGncu8Pn4DLbAWHcAk6sSeXeEDPGPzuq1M0CLypJWam7TE5RrTG4iDIE9eT9hGL9R
	GLSurCkUFQBRlX+3O8MfSlp3AD+16PcXq/spvZ2Pz8+WRxgdUSne3gFrWAmTT9XlwExn3DYdU2n
	LZn3bNSUb9WOx2CCIfkfYnmYrCGMuBWesy7wMmRMErkDk3CcCU7UvgJPyfmS44yBGikZyE0IyLF
	S235EOTmBTZm5Bl30nC+lqPzQScMHWjwsBHHxA7nNUa6dTmdxGC8jxhOICf3Ljhd6jDplEu5T05
	9ePLSmHtDCjyi1voyyzgE424T0iu
X-Google-Smtp-Source: AGHT+IGhqS7P5Xot+K2cQUl/ngK3IN1iax/cYJ95greo1qi2i7RTNAq2NK1kSqedGoBqfUGnPGrE7w==
X-Received: by 2002:a05:6902:102e:b0:e57:9250:b722 with SMTP id 3f1490d57ef6-e57b1036009mr3694324276.2.1737151407920;
        Fri, 17 Jan 2025 14:03:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab2a7665sm584334276.5.2025.01.17.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:27 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 6/8] t/helper/test-hash.c: use unsafe_hash_algo()
Message-ID: <21b175b07ff46471acdaa1afe5fa8b0c2749248b.1737151386.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737151386.git.me@ttaylorr.com>

Remove a series of conditionals within the shared cmd_hash_impl() helper
that powers the 'sha1' and 'sha1-unsafe' helpers.

Instead, replace them with a single conditional that transforms the
specified hash algorithm into its unsafe variant. Then all subsequent
calls can directly use whatever function it wants to call without having
to decide between the safe and unsafe variants.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hash.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index d0ee668df95..aa82638c621 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -9,6 +9,8 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 	int binary = 0;
 	char *buffer;
 	const struct git_hash_algo *algop = &hash_algos[algo];
+	if (unsafe)
+		algop = unsafe_hash_algo(algop);
 
 	if (ac == 2) {
 		if (!strcmp(av[1], "-b"))
@@ -27,10 +29,7 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 			die("OOPS");
 	}
 
-	if (unsafe)
-		algop->unsafe_init_fn(&ctx);
-	else
-		algop->init_fn(&ctx);
+	algop->init_fn(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -49,15 +48,9 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 		}
 		if (this_sz == 0)
 			break;
-		if (unsafe)
-			algop->unsafe_update_fn(&ctx, buffer, this_sz);
-		else
-			algop->update_fn(&ctx, buffer, this_sz);
+		algop->update_fn(&ctx, buffer, this_sz);
 	}
-	if (unsafe)
-		algop->unsafe_final_fn(hash, &ctx);
-	else
-		algop->final_fn(hash, &ctx);
+	algop->final_fn(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
-- 
2.48.0.rc2.35.g0c4d006e6e8


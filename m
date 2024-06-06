Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5113C69B
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715095; cv=none; b=DsnC+oae29HF2xq2hZdqfp5VQMRPribf1LBoUJpzXby8YBxC8rfy5xIx3dH2ZsEl4fkBDemzZyO/rRLzAJ5zJ59ETq+ZohDC7bo5fgHJaLy5NMu6m9B/pCveztLB/PkkanqWF67jGbHwVLU2bvJL9SY4ep/va9fFpO/Lz32BTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715095; c=relaxed/simple;
	bh=70uT6oWdnVRhksH4UXf6R16XooyRLowKxFEdB7GGRFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxTLaGTi0+NNwHhquj75GtOGOrXOR+IOPxVicZMbIisHVOp3Tz33BXUWWpGAlYFFAZnpB5+A3o43Q7KWE1b+ZDoIUgnGrQudwPLF9RWRJ+6BqM34AxF+dFOwvZsyQTdPpvirxgCOvfYjUxCnXRUlTsLG1NdGa5Qx0BpKbvpj6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=B1K1Dpre; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="B1K1Dpre"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4402c88390dso7342311cf.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715093; x=1718319893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMflsJBLy9hc/mmnuCslPG/MubvHD6SplDSMyH50a8s=;
        b=B1K1DprecII5YpUNlgo8/35hZvaOrh1MGdkbkhT4xj8DatjD7T3TYf8WC9HgtQJbR0
         RKkRTR2XKGsDzc+QaTa+RNcfXpOocOM2RnkZ+pzUh/q5EbXohiUbKQzM7Bdw//9+EPlx
         ua3kf9ygkpys+lGcxnXJor5+/0N6WuGDkV72k8zgwNAMHV+I/wrFt74JakzB396fP10J
         qwwtEJxxJG6TTP1/YbL5BowHwhiLO9N1p2/mNpUzllKl2TsRhoM+VnACRgfu/GM9w1fD
         gSqvE+IQtxToLnySkeRzYHSsdvJ2EevyWlgQysA1d5+iEAPBVbgS2Ea0rK+s3HSDY02G
         nzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715093; x=1718319893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMflsJBLy9hc/mmnuCslPG/MubvHD6SplDSMyH50a8s=;
        b=f1dHyuIw4t/n8838ucgB6oDenbeb3S0NeaklnvAAT++Z715ylFaWrN63FHO3RlCHdt
         NFIoNRnQkWJSFzo/b0lXL140u7UOSVyvZUtx19SUsFdl5Ypvf7hL5IO/d/x7eAugwPrJ
         qjAA/kb+HVFOGsWhvtzuZj7e32ywRgxDcbtpaV5+UhL8tXsKo5ksvwGT0YefZ+cv9M5T
         XjUR3JUIVatDaze/UAvztyrgkgrb+pcioRmRqsrtNT/x46IXD6c2v0eVF0VYxTQIq5HY
         z4XnFtMYxj+jxpImBGf8aH5YeKJ2M3wmT+DjrHv2WLKcwnDMty7Glw3nVlzGX+H+yjfG
         1FKA==
X-Gm-Message-State: AOJu0Yzf2N/2w/2DE7KKU/LnwuMGrhl3LXY0d16i5deXom7kgzFhbuC0
	Ob9IbUjrh1dyNuw+/3YbQX/MtwO5laqP6S5AGg3yMaLH/OIXsTwh3nu2XUjDLFML0Xk5RLiyQZA
	q838=
X-Google-Smtp-Source: AGHT+IFlxGeQ3f4OC3wfwX95Q56h1R3t0lfX12FcpDWu2jtwZYvJdrJmr9+daS6AivJiTETKZMVqkA==
X-Received: by 2002:a05:622a:4d2:b0:440:2786:aca1 with SMTP id d75a77b69052e-44041b68e33mr11698231cf.21.1717715092738;
        Thu, 06 Jun 2024 16:04:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4403895e16csm7771941cf.6.2024.06.06.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:52 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/19] midx: teach `nth_midxed_offset()` about incremental
 MIDXs
Message-ID: <c28ebf22c0819dbf6b65b28654362642880b6bea.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

In a similar fashion as in previous commits, teach the function
`nth_midxed_offset()` about incremental MIDXs.

The given object `pos` is used to find the containing MIDX, and
translated back into a MIDX-local position by assigning the return value
of `midx_for_object()` to it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/midx.c b/midx.c
index 7c4f58f7f1..d351dbb7e0 100644
--- a/midx.c
+++ b/midx.c
@@ -365,6 +365,8 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	const unsigned char *offset_data;
 	uint32_t offset32;
 
+	pos = midx_for_object(&m, pos);
+
 	offset_data = m->chunk_object_offsets + (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH;
 	offset32 = get_be32(offset_data + sizeof(uint32_t));
 
-- 
2.45.2.437.gecb9450a0e


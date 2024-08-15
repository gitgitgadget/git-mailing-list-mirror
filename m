Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F915531A
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760948; cv=none; b=URH0JY/qZHTpOQBDHdvnMYhJSRJJTACFesRfxoR1bqLaamwCfNt41iIXYkDFeDzenrybachSmUEADnEQTUR2ZI8DNSHE8YQmCNS8zCTEbBLZrjEcJI+lwPEkbbPr2u94/1UQnAbynWvZUARiEGgOfxHR+0oGXz1+OYHc1xEn5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760948; c=relaxed/simple;
	bh=0UuXiDa6CtY6HXjJk3BitUxubH6xt4gi2qL6O8WFYb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB4jN328CewGnQjEE2IH4kOqODM6Hvd6xeTfX1L+U27MaNIA0DKNPUWnS5lsoC/76fc76GpgSgfSYCVpCgRCYP9eT/7t07HUpGYTCjPatEGKf1jKi9lYmgr5ve62nRqNp0linU8K3ZQq0cBKv/0ejtNIeSR9vuIg82IcamTOrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gmCxA6HI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gmCxA6HI"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-685cc5415e8so14821357b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760946; x=1724365746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fSrcpNaCpuMN/HRO28htMCvmfWZZBMcAta7SD0QG+Q=;
        b=gmCxA6HIeekN3UTWIUF7zFKUNXS6ySPiM7gIjtWKEI4Swni4nJL2zW5sV6b74csBvQ
         0LTHz7FZjg6z0JwjpxOa+zpWnF6ADHoTd+toDhH4SS4v+FlQje0zBCp4zkT9+mUDad+m
         FIabMu2t1COPsQccQENLPxvASJS5ZgUPHsQvmIqzepWuUi29Kj6HbFOdYKPusieT/A53
         +c4lK6D/QDiIh0Wq3KhBPn0zH1CJgv3tZqnUibx8P5ojxJ0BB7SuwbDuz9vLfv999JQi
         UTmtptRdmXzYSK6fKdDT3xU/yf6ioUd5Azikd+cTV4w6ZDfAXQV6PXQ5jZvRjSu0nq9m
         bWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760946; x=1724365746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fSrcpNaCpuMN/HRO28htMCvmfWZZBMcAta7SD0QG+Q=;
        b=WJX74yBpV8YrNzf+oWDswRkEWzDM5U6V7rT1r4msjfKamjOCpZfbfRJ0KKAzD+6ha8
         LTmKowBm9U3shpoDYU8e/SsbV0skD7Q5dQckWxTorEBxKqAD1rVDXdCv13G5+TpYL4+R
         I8DXfwWclj3O/mhQ3VBn9S+KeW5e9hnN/hy89bT03zMJvB8xb4xqdAaXfjBxbT/URXQe
         T74wmIBnXKMh6p5BlPT7ohhCL1CHcFMtsv0BFTeKCDDjanqKrWTVjthcNyJ1wlaiWwRQ
         LKYjY8/Y5hIvl9mR/Dps869IwKDe43QbqfCTbE6cslqjh1VlOtPJDjMjYn0MisQkbOwB
         8zxg==
X-Gm-Message-State: AOJu0YyV28S1WWhrgCGaQ04Htr8URXVgIhjb3bC8KxohwY7uX0U6msfp
	DjOJh228nZ0HqvY5fxMImD0vJdqq2e14hy8Gs93SDo84v51SfDsCxY0DgfxdaLMOOUqIrWUdpBt
	Q
X-Google-Smtp-Source: AGHT+IFi11SJEkAIUbWgK0FTiq6CI3aflkkkvuH+/IQdpB5hZNDCgdJpqmrX+kLPspSuZJphCzlebg==
X-Received: by 2002:a05:690c:404a:b0:6b0:2031:6414 with SMTP id 00721157ae682-6b1b9592c0dmr11213037b3.24.1723760945820;
        Thu, 15 Aug 2024 15:29:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9da111f6sm4148157b3.105.2024.08.15.15.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:05 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/13] pack-bitmap.c: teach `show_objects_for_type()`
 about incremental MIDXs
Message-ID: <b720fe56da867bfa560184fea7c5ede01c2426c1.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

Since we may ask for a pack_id that is in an earlier MIDX layer relative
to the one corresponding to our bitmap, use nth_midxed_pack() instead of
accessing the ->packs array directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 88623d9e06..f91ab1b572 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1631,7 +1631,7 @@ static void show_objects_for_type(
 				nth_midxed_object_oid(&oid, m, index_pos);
 
 				pack_id = nth_midxed_pack_int_id(m, index_pos);
-				pack = bitmap_git->midx->packs[pack_id];
+				pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			} else {
 				index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
 				ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
-- 
2.46.0.86.ge766d390f0.dirty


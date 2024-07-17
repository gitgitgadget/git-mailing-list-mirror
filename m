Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD8180A63
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250746; cv=none; b=irvpM6tw5DXoaLO5jcFpEd8CcM1R0UrqOHDjhZ5+EXVxBvLCbkEp7OdOyWlKzb522vrlIV9EWWFTeWvn4lBr66dKHVhAhIIhmuC0WBQMXlnae4GaAsv54Q84hFoBgvE105l6fCQBFnPuQVIodO/PRXTgqQUA4GVZDBWhndivTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250746; c=relaxed/simple;
	bh=ZotPqOOEp5f2fa3K3TkdKn25ebiG6v+sBu8YiUiogBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWoNGCeQMX9vAn08q5lxsNGw9MHJttsME2u2EqGMqsxci5WBlqwG2rCqMtG6Opi3/HahKvrYJVtL9UcI/lJwcoee66eH/H8wDCLVS6N3GAAnHdRxRzjLj+WODFU0goY38NFWz/8Xx8BExHGgwEnlFFNz7bLfFr6hqdxVpGyQ5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oU8ZznNX; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oU8ZznNX"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-661d7e68e89so952147b3.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250744; x=1721855544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/jpQFS4mTRzksaALfFDBl+2QA3kHR+I+0y1XrKQlBI=;
        b=oU8ZznNXZXnjiNKywuKHTr0poCW0k5+DnbY0+jXpBkOvCCF90e6P2ywzYcFzRS/Mkn
         aMJYTqGAp7/mWCsm2ggXZCh3O3dj/rV5pCNoRs0E0jXfShAkG14Aihj+uj7XGo/Yf3m1
         Ke004tlq0Rcbrij+NdjpztqNqs7qTPEf04d9DeJliAxS+Y8K0xWwm33w2Ob0G04jLSVu
         WCf0PTKTQv/Ka1Kj+/AYqkjvfdYyrNpVdo9ZAzSlsF5K6eXSTYRj5O/JUoKi7Ts9NIjr
         t6XO0w5hbhUQphWJMyjhQOwcNhnHXh3x5pol1x+b7cnL+l+DFZmOr47iFdjwPqw89MfD
         RrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250744; x=1721855544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/jpQFS4mTRzksaALfFDBl+2QA3kHR+I+0y1XrKQlBI=;
        b=YDooHcQurigj18GdnYe8wA6E3vVH+K8LLH2OuVqBo2aMiSTRIVtpZdIo1LUMQ69HTW
         Fz9onQa9pkwlosbJfdSfX/ihI+kYy9r873jiV7aBw5y7PfzOriDa6ZPx7F4D7wvEq38u
         g/OZfVHisYb1VajFegvN7L/Pnx2WZx+GZc2dJl9NnFVNwoL46Q9B3I0LVeQinIaLXwD4
         pjMEYvwedJe+V73W18VsvwyGY0rFZz5/fYTS/H1F0ePXxKNZKk4SdEgXcB4SXWdHndbQ
         sJd67L95LT9hjcMrHbEI9b99vmI+PL7VhCMRLtuHz2r0uDEvkr7uCtspV14QPX3IoqtU
         HdvQ==
X-Gm-Message-State: AOJu0YyL8LpD5jAbaKlj/gucZ7lQ2XgqUL+pu1ME/I2CwCWGI8SB/rYj
	hjqQDvMdd3b7FqWd4oMog8jftGEaU2H2lkxwoVrlmBcWLYXxjFhdkBovwbVi2UD2aSP+WEgMejD
	s
X-Google-Smtp-Source: AGHT+IFqeCiRiYVviULrTIf5nE0PvU40n5LccpccIWHT2mA4TcNeIvQz1vhdYfqr8yyaP/5sZYKPFg==
X-Received: by 2002:a0d:f803:0:b0:630:4fab:a090 with SMTP id 00721157ae682-6660a442443mr4395827b3.22.1721250744307;
        Wed, 17 Jul 2024 14:12:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66603ed2393sm755287b3.126.2024.07.17.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:23 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/19] midx: teach `nth_midxed_offset()` about incremental
 MIDXs
Message-ID: <342ed560331d95fb0a1d86743dbb999ec7327313.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

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
index cd6e4afde4..f87df6bede 100644
--- a/midx.c
+++ b/midx.c
@@ -368,6 +368,8 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	const unsigned char *offset_data;
 	uint32_t offset32;
 
+	pos = midx_for_object(&m, pos);
+
 	offset_data = m->chunk_object_offsets + (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH;
 	offset32 = get_be32(offset_data + sizeof(uint32_t));
 
-- 
2.46.0.rc0.94.g9b2aff57b3


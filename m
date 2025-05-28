Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F79221FCD
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473150; cv=none; b=dgg9/Ee1YhM6Iw+QfZpkIGpO/kITW5CjcWtQUUHi6fNZ+kI28ggt6xL1H+TcedYEieXRdCzApBXxVuOWlyUlUK/VLw4mgQDn8EF1i0fuJ0kxN9CtNzfqWhG6v3RZ9UziNkZZVciMffLgmWA/flnt+hJFbds+rkVZwiqieZKPaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473150; c=relaxed/simple;
	bh=wyPL6KcDU+4qXlAVQ+m0F9C+gm8Fard8C0iP0xejgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikjoPltl0ksnOXpddvynrE4d5jB5VX2QNKGpXDYCPeiGM71d1IKtL/dtYp6UPOdhEGnfHcykToHBkUcw6JMSaP5aeBtz/fAjYftWxAQEj4PCslHwFDuN2P9UfbfC9I5rvaxJYBLvQxZuNZiN087Q6yRJOwvFAY9HAmT65XyZJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=icoB5A8a; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="icoB5A8a"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7c5d470a8bso333493276.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748473147; x=1749077947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOHsAqqKNfG0bDdrnBcBp2iYQ03c1kYxSc4LSL2dlGo=;
        b=icoB5A8aat+IrnUCthuNFlVAJ36/dAUmZOCcqhOnuk1ZhUaVP7sa3XXhOY/JRnmMdS
         cGixUZZH1YsnxAJ7VBhK+yDvwr5KfyFwBdQPuwuNEHqbkGO/CC7jGlaYIfMExfDvQDlQ
         jFD1EOXfyDc5GJksW5hewBcaQ0x3HWHPOyEvsGlfGc/zAvOctO1hPAnyWLTS2WergrAy
         Zmcit1mbBgO70sP76x8EPmRcbHw+xUv2zQdd012qTaDmVVQkefZkN2YcKzeraF5fENIS
         tCQJjlt9XEmXFcLyuuTcxKbWtzFRHDca5jSitDbSw/UyLK6sA8TmxNR1wc0oHKng+Ohj
         9cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473147; x=1749077947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOHsAqqKNfG0bDdrnBcBp2iYQ03c1kYxSc4LSL2dlGo=;
        b=A57EWLT1kbeEDr+mbV8TZ3F11Yx0k9WbbcQFW4S5AehVq1l+BByPUkmeEm5TNt8b5I
         +GDjJky6zwMOdXuC7K0nxCGSPXe2+LRttvC5XYEPSON4kd6WssJ3BiX4vpUnJxIlz/VL
         6/GoSCBpqEaqcgIZM+qYsuq1cYLdxyOkeNj77zt5GI9PGJaPv2cNxg+Cbn0tK2V0H+pA
         OOKMUSclNWsS1KcEMUAug43z7NWG1++ydUMei6Rv6YzsV6qLlksHcG7YnofushO73sIr
         vatV4iRh0HSlU1QJ8mfgz8/sK3uWFnnfI99lH594kgjl9nNkAJbx8mYb8H1Cyu1Rh9lz
         GXhw==
X-Gm-Message-State: AOJu0YyAEeNL0itxiVRS/qGPXTiObo1NBod8o4aFImP8qV/VXmzPftQl
	2GMUgVGhLozNw4p8ag+lOpVdXFPc9oJ7Fk9u5fm0IAb6Gd/CUaIb+IaaPFnerMQnYahBix8RAL1
	5UrhT
X-Gm-Gg: ASbGncucGf6mQusf6vjiLzjo8nuSTqvNzy0P7m/A/zNW0qcIrlcMHMKhGAG4/x0Nsaw
	qRFcEtoQ11WkM1ESs9fiMSb+T7BvQXm+n1vv0xaZ/Bbx6bI5/+rVEqWPmxsU/HR1fq1kYQjwnSe
	1hX/ZV2brRmkWXlOOu97lkrXExChZS5nH0uIZERA5plcWocM5ABXdeSO/2zrJrSm56FrkT7FS/o
	UFFkjsWHffE7WTElIhjTn30U39yjPf0012WEta8Xls5fk1GJt8ULlkR5zEGYNN7Gm4DIhm0MPMU
	Ou9D7VzFsBN189vK+Mwp85Au0gh7BtgGLo/PX23+lNKmzWua8gUGYkN0gpvV2haydXmHoezZbFh
	10j4l3Cxg8V0khvKdY50MhjI=
X-Google-Smtp-Source: AGHT+IEs+ToW5R3X9ESN+z6ai3yFiyOL6JVBvtmEhoJy+ZF8Io+FaV2RUawmnuiF91bTKeyHHYGs5w==
X-Received: by 2002:a05:6902:188c:b0:e7d:5e41:a8ba with SMTP id 3f1490d57ef6-e7d91a2a204mr21189407276.34.1748473147504;
        Wed, 28 May 2025 15:59:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f734febb2sm22921276.40.2025.05.28.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:59:07 -0700 (PDT)
Date: Wed, 28 May 2025 18:59:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] midx-write.c: extract inner loop from
 fill_packs_from_midx()
Message-ID: <e54988bfeaef6d6e886899b30d07b58c84ddea94.1748473122.git.me@ttaylorr.com>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473122.git.me@ttaylorr.com>

The function fill_packs_from_midx() does relatively little, but ends up
in a doubly-nested loop because we're enumerating each pack within each
layer of the incremental MIDX chain.

Let's de-dent the inner loop of fill_packs_from_midx() by extracting its
contents into a separate function, and calling that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 72 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index e4a3830d45..ca2384e291 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -938,44 +938,54 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	return result;
 }
 
+static int fill_packs_from_midx_1(struct write_midx_context *ctx,
+				  struct multi_pack_index *m,
+				  int prepare_packs)
+{
+	for (uint32_t i = 0; i < m->num_packs; i++) {
+		/*
+		 * If generating a reverse index, need to have
+		 * packed_git's loaded to compare their
+		 * mtimes and object count.
+		 */
+		if (prepare_packs) {
+			if (prepare_midx_pack(ctx->repo, m,
+					      m->num_packs_in_base + i)) {
+				error(_("could not load pack"));
+				return 1;
+			}
+
+			if (open_pack_index(m->packs[i]))
+				die(_("could not open index for %s"),
+				    m->packs[i]->pack_name);
+		}
+
+		fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
+			       m->pack_names[i],
+			       m->num_packs_in_base + i);
+	}
+
+	return 0;
+}
+
 static int fill_packs_from_midx(struct write_midx_context *ctx,
 				const char *preferred_pack_name, uint32_t flags)
 {
 	struct multi_pack_index *m;
+	int prepare_packs;
+
+	/*
+	 * If generating a reverse index, need to have packed_git's
+	 * loaded to compare their mtimes and object count.
+	 */
+	prepare_packs = !!(flags & MIDX_WRITE_REV_INDEX || preferred_pack_name);
 
 	for (m = ctx->m; m; m = m->base_midx) {
-		uint32_t i;
-
-		for (i = 0; i < m->num_packs; i++) {
-			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-
-			/*
-			 * If generating a reverse index, need to have
-			 * packed_git's loaded to compare their
-			 * mtimes and object count.
-			 *
-			 * If a preferred pack is specified, need to
-			 * have packed_git's loaded to ensure the chosen
-			 * preferred pack has a non-zero object count.
-			 */
-			if (flags & MIDX_WRITE_REV_INDEX ||
-			    preferred_pack_name) {
-				if (prepare_midx_pack(ctx->repo, m,
-						      m->num_packs_in_base + i)) {
-					error(_("could not load pack"));
-					return 1;
-				}
-
-				if (open_pack_index(m->packs[i]))
-					die(_("could not open index for %s"),
-					    m->packs[i]->pack_name);
-			}
-
-			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
-				       m->pack_names[i],
-				       m->num_packs_in_base + i);
-		}
+		int ret = fill_packs_from_midx_1(ctx, m, prepare_packs);
+		if (ret)
+			return ret;
 	}
+
 	return 0;
 }
 
-- 
2.49.0.640.ga4de40e6a8


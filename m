Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AF2DEA8F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959636; cv=none; b=Xvni0Tg/4GeGWEVK2FcOHrtpc/SFNUaSr5mWlwD3334p2JPrnQ0alkmB+F3Th4Y6TviqIH6auseUCp1gSMftwq37hJ45iD/gEs162VdP2a1S+bVyoncdIOQqbMj7sG2LU7P0vLESSherWFotbyXhzjR+X8y2vwwAW41Tb3/pnIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959636; c=relaxed/simple;
	bh=Ra3VPPcDtXdx2VxFbS9Qtd994/xtz/MFUwvEIn9Iw50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WES5n1tE6LAFME5YNGGZ4GP2Qg1X+uyW6A8m0yjOQYj5f5tmUGDxebUWyGO3xe6tQoDFQKU9DaWKf1zsCx257SrBCe7/dOrBjwcxguYJLWw+m4h0HGllkUBr5+mOGL2FGZ139x4T4J6tw9u4eBa36hYXe+wBlM4asyboGHGZhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DUsUUJ9I; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DUsUUJ9I"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-506a019a7f3so74073161cf.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959634; x=1772564434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iL5WjvMOLBunip6v2GWNjJjEWhYXBEefvVUTtB4907c=;
        b=DUsUUJ9IkNhvznYnhDLJPo9dmp4iTJ9ZwG5vftYSwKOiakoRV1afEdkwrA0yw/zVSx
         QWpATSeWRGYl81GF0gtHJbvi+zdZH36E8F1BVajiJm9iEuRsJn200Xchl+rxJLi798DL
         DR2mEkM72mtT3c3XADN8gUThkJo2uPChpIr7Ibcd2yZ6u2YfZa262O2RIm8b6u6d/jvC
         BHv9fVAq2+uX0LGcAy5741kd0GSKnU49V7Kv+cWu3DbzqOIQvIgs21mQMK8yZnRUV0a3
         ZkEp25ggGComuAo78HIFlf+gua/JgUymA1qfmGty1R7hXpiABfaTVKcFLPZwQAIvK93j
         tASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959634; x=1772564434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL5WjvMOLBunip6v2GWNjJjEWhYXBEefvVUTtB4907c=;
        b=vA7g1j/1J4UlWv4iPuiDy9l2RfTYXjKGRTBSqNm7Nofe2SxaAiUjtEBB2nNjus0O3W
         RGX+Ub24Phie7B10oMo1sv99LjCmePDUZcrEOym/TV2fN3++2q1SIEz4cpeR8+O7k4a/
         O5BDBenyaNSPAtP13MI8TLOIQkyRDtAJ1qhHvrO50fsO0pk88tGHXIp4V+CmF2R9Jk9/
         3a/ROSwcuY/rk4acH3aiSVzMxojEPMrFdQw5K+64dMobf0duH5Fc6z4BwUfddR1M4nN4
         ZLh0Uq1C/59WaY2urW0Ss8NEzGiWq+MXQgF/tGNtlU+gxvcZC/xBCBHpa+4cMAmKZEqN
         QRzQ==
X-Gm-Message-State: AOJu0Yw62z+hRWr3DdJITQye7sj9ZVMephjP3PwT4PVsOc01V+s2+uD1
	E7OFfQprnsvjRWJ4XAR35TzBRsnK2Y/fB7Zgh2g4EjLWVssT5fFWX8mNcyBK1NQsAvb4NRyOJz+
	jzhPodFlMF3Cm
X-Gm-Gg: AZuq6aKwX1nNpo/nmwXoUwfNO3u0P72Oytrkj8v4wTVMQczcDYE/bf26Re9fXm7LtLL
	DPTc2K27Jd60u3C+TXhD1dGBe9cGa3SXcGMxhtjLBeefk5W8PpxNZRAltrLM4sa25E/taWAEkWf
	NUyVLz4m8UhBoUx3UcHbYGpONegBxvCjJTLAd+2no1G8LKX47tc8zPiahYMg0B6kpu+py5htkBz
	VarAulGo3LZplYWsU9nSKp876vGh7zN0VaNzaIvsZsmqRaPxm4h4eJ1+Mv7+SDbZ8jGpi7U0SeP
	AgdUT82tpwq9elig/VGzZP1o2WN0327UtC5jriMzfkmJPwfely0nExvS+oR7lJt+ALN+PmCvmJd
	cpYIWQO4Cl0iN2TmER4SMos/x4X5/GCtXZud+ICqpFx5EeSsso+cIZ9dNgIJnAV8oTNi9zjsj3V
	r0e21VvZozBtpEogSKed3jQt0Np2YAYH/2qRQmk0Z42UUhyOOM+gOZAPi8NGHYAv70GilqRh0Y3
	0JN8uiGR9Z9tRkMLTt8If78kQBFy7b6fW29rHro
X-Received: by 2002:ac8:5a8c:0:b0:4f3:565b:c52c with SMTP id d75a77b69052e-5070bc6b79cmr178240871cf.39.1771959634181;
        Tue, 24 Feb 2026 11:00:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d550785sm127794311cf.11.2026.02.24.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:33 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/17] midx-write.c: factor fanout layering from
 `compute_sorted_entries()`
Message-ID: <3a139575b1576a9ce4d4a2e1d928a60338636f1b.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

When computing the set of objects to appear in a MIDX, we use
compute_sorted_entries(), which handles objects from various existing
sources one fanout layer at a time.

The process for computing this set is slightly different during MIDX
compaction, so factor out the existing functionality into its own
routine to prevent `compute_sorted_entries()` from becoming too
difficult to read.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 80334914d3e..ca2469213e6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -328,6 +328,30 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
 	}
 }
 
+static void midx_fanout_add(struct midx_fanout *fanout,
+			    struct write_midx_context *ctx,
+			    uint32_t start_pack,
+			    uint32_t cur_fanout)
+{
+	uint32_t cur_pack;
+
+	if (ctx->m && !ctx->incremental)
+		midx_fanout_add_midx_fanout(fanout, ctx->m, cur_fanout,
+					    ctx->preferred_pack_idx);
+
+	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
+		int preferred = cur_pack == ctx->preferred_pack_idx;
+		midx_fanout_add_pack_fanout(fanout, ctx->info, cur_pack,
+					    preferred, cur_fanout);
+	}
+
+	if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
+	    ctx->preferred_pack_idx < start_pack)
+		midx_fanout_add_pack_fanout(fanout, ctx->info,
+					    ctx->preferred_pack_idx, 1,
+					    cur_fanout);
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -364,23 +388,7 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (ctx->m && !ctx->incremental)
-			midx_fanout_add_midx_fanout(&fanout, ctx->m, cur_fanout,
-						    ctx->preferred_pack_idx);
-
-		for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
-			int preferred = cur_pack == ctx->preferred_pack_idx;
-			midx_fanout_add_pack_fanout(&fanout,
-						    ctx->info, cur_pack,
-						    preferred, cur_fanout);
-		}
-
-		if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
-		    ctx->preferred_pack_idx < start_pack)
-			midx_fanout_add_pack_fanout(&fanout, ctx->info,
-						    ctx->preferred_pack_idx, 1,
-						    cur_fanout);
-
+		midx_fanout_add(&fanout, ctx, start_pack, cur_fanout);
 		midx_fanout_sort(&fanout);
 
 		/*
-- 
2.53.0.171.gde83996e422


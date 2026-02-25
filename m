Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02C1F3BA4
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978910; cv=none; b=mnKD4PGydHS3OFsSY/7yTdteHkfMk5UnDVLzTwDTDoc0aGfBbOL+43dSA7BtTEDoHJiLJuL/a93ni9H8hg3pHx3PyLUPaYDyFVPS0/pJ5lroOEx1OGVaLKmSLRSI66lPlUvDT0UTPpVv5Io6I0fCbC+RZvhQ3QNKC9jybI02KO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978910; c=relaxed/simple;
	bh=3Bx2Isvw4W1/slKCDSIo4ixrvA4fnLhmSJARU8QAmY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3tPNi9nnIa0cF0eaqPHz5PUkUXwvNtz6r0jXi7RE8JD18vDsGw93DoJ7nTCkmPny/VIotEw4bb5l0c9ud1cSeqGX1IyJDvvYzZpbosiXbaxEoFSj8dUAs2wE34WU3ZZk+2UaOhAIngU1wpst/F0TYFX323ExEbqg3n6uJtKPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jd1Ff+4c; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jd1Ff+4c"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506cb1b63d0so66223971cf.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978908; x=1772583708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVWjHqblkV/8VSCD/f5Z2FDC4itH8e7Z6VpnRLFWvas=;
        b=jd1Ff+4cPCk/PYgrMY4oq275k3et8qicGKNKE1hilqc0refBaFrIDO0PdxkgmJ8eNa
         mkVS3md4BydQ6/DGKud+ifQmMeSwJpDZTNdFN1tggC4w8T7ZSaIjGWj4MsQeQ0MWMivh
         07D5oifLg2s5wuncAwsoP5lCJ7CjDc6mhyjrW40UUtZ7ppERW69otpoZIqIPtb7mR/Uy
         ixw3020JsIn0MVp+GCfBih3EP6grFMSQbUYAfeV36cz1eJml2sjf1IUvyvFRCAStP8WD
         MNOYBijv5A1HMOOLxMU1opJp+gcPwGUvk/LuVj/Z1xfwvafSNTylShMeccVglYlaf6YH
         9q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978908; x=1772583708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVWjHqblkV/8VSCD/f5Z2FDC4itH8e7Z6VpnRLFWvas=;
        b=XZAn8w00Ce0yKvY00d3CNnl3gwMhPi/zdJVR55hkzzFwVBNjX/oQVY/7AjdpG0+sBR
         +GL83Ptw8SAeGzr2erMRlNOb/O/TgrP9yRwQ804EuOZTOUOu2y+2QWIx3SzNJbEbHt0A
         wz19piZTGQRKxGz2yVjl/lr7VyS9aMS+JES0We99bARiiQwNH/MaE8TqxGrT0b1T4o7T
         eeixPPg3t+EEGewNPWx7nQl2Hi0co1NmV1TKLB2o+YjGWgyDNhEZ4CQfTBnvzIBMd5Bw
         FPzhT5fr7WMv66r+vfx6QtmUbDNIUY5JdRSnt31Gtw4v6GFXR0aNQLeW3d2lND+2mCcW
         aT3Q==
X-Gm-Message-State: AOJu0YyaN5JPda4FablkW6QoAKrymoiZS60myfi5PgGQ5uesWIRyd7dq
	WSvIEdaoFwUjQwSNb28JLFGDcCPfJwgloawV7b1RnJfPLGzf/jmscz38lQnHqaTWFY9wMFqsssp
	k7/48C6E8kQ==
X-Gm-Gg: ATEYQzytt/Sm5/KyoQLteQFQoQC+IWsGCfCiLnR2hNHBWlU5DIhD2lyMtN4rtjdVsOQ
	+eJlWPXoIeoAhrVjhfk6lB8jSuEBNIZxWmpwCnoxFRyTZDIZ02jrc+WMzT5dkb2UEDYGC/j78wM
	7qkU/MN7xqVMbBaeLCxpmQpiKpOfennIllbQT4G00O8lv9N1oy0UGTOPkpViW8i9ekIOz0r3fKX
	nbzPr21/jqIyEFMfkp3ErKaQorQIem/pOeiYsW7Af5MysW8cnsgVvoJgJ+XBVNYt+o2e23U/qKy
	g37L1b9YoJUk6SdhhT0HCTCCqFu4ZwyBJoUwe2zwNevcneFkilKactlKZcBGSW4tSVo3ryVt/nq
	08aUks9sbit6FcsKbCyyxqHJWwfvft3XzBmBEIGhQo2T4nriGoEYo3cBZA5g4SDovMDEtp2sO0A
	wr5jKfZk/lHtV71rE3DAB47sExTE+EaPhFiAIHIfSbq5YEqZIbbft0nbYFTOK+zIoZl72H9uddX
	M+QrUWYInl4w7jNkkEo+uPsUz/LPA==
X-Received: by 2002:a05:622a:5c9:b0:506:9bea:3229 with SMTP id d75a77b69052e-5073a35e80dmr7496991cf.69.1771978907829;
        Tue, 24 Feb 2026 16:21:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6dd96fsm109928711cf.28.2026.02.24.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:47 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 10/14] repack-geometry: prepare for incremental MIDX
 repacking
Message-ID: <d81578120945e7bb24aa552a347be57020dbcf62.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

Teach `pack_geometry_init()` to optionally restrict the set of
repacking candidates to only packs in the tip MIDX layer when a
`midx_layer_threshold` is configured. If the tip layer has fewer packs
than the threshold, those packs are excluded entirely; otherwise only
packs in that layer participate in the geometric repack.

Also track whether any tip-layer packs were included in the rollup
(`midx_tip_rewritten`), which a subsequent commit will use to decide
how to update the MIDX chain after repacking.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-geometry.c | 37 +++++++++++++++++++++++++++++++++++++
 repack.h          |  4 ++++
 2 files changed, 41 insertions(+)

diff --git a/repack-geometry.c b/repack-geometry.c
index 7cebd0cb45f..d2065205f87 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -4,6 +4,7 @@
 #include "repack.h"
 #include "repository.h"
 #include "hex.h"
+#include "midx.h"
 #include "packfile.h"
 
 static uint32_t pack_geometry_weight(struct packed_git *p)
@@ -31,8 +32,30 @@ void pack_geometry_init(struct pack_geometry *geometry,
 {
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
+	struct multi_pack_index *m = get_multi_pack_index(existing->source);
 
 	repo_for_each_pack(existing->repo, p) {
+		if (geometry->midx_layer_threshold_set && m &&
+		    p->multi_pack_index) {
+			/*
+			 * When writing MIDX layers incrementally,
+			 * ignore packs unless they are in the most
+			 * recent MIDX layer *and* there are at least
+			 * 'midx_layer_threshold' packs in that layer.
+			 *
+			 * Otherwise 'p' is either in an older layer, or
+			 * the youngest layer does not have enough packs
+			 * to consider its packs as candidates for
+			 * repacking. In either of those cases we want
+			 * to ignore the pack.
+			 */
+			if (m->num_packs > geometry->midx_layer_threshold &&
+			    midx_layer_contains_pack(m, pack_basename(p)))
+				;
+			else
+				continue;
+		}
+
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
@@ -173,6 +196,20 @@ void pack_geometry_split(struct pack_geometry *geometry)
 	geometry->promisor_split = compute_pack_geometry_split(geometry->promisor_pack,
 							       geometry->promisor_pack_nr,
 							       geometry->split_factor);
+	for (uint32_t i = 0; i < geometry->split; i++) {
+		struct packed_git *p = geometry->pack[i];
+		/*
+		 * During incremental MIDX/bitmap repacking, any packs
+		 * included in the rollup are either (a) not MIDX'd, or
+		 * (b) contained in the tip layer iff it has more than
+		 * the threshold number of packs.
+		 *
+		 * In the latter case, we can safely conclude that the
+		 * tip of the MIDX chain will be rewritten.
+		 */
+		if (p->multi_pack_index)
+			geometry->midx_tip_rewritten = true;
+	}
 }
 
 struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
diff --git a/repack.h b/repack.h
index c0e9f0ca647..77d24ee45fb 100644
--- a/repack.h
+++ b/repack.h
@@ -108,6 +108,10 @@ struct pack_geometry {
 	uint32_t promisor_pack_nr, promisor_pack_alloc;
 	uint32_t promisor_split;
 
+	uint32_t midx_layer_threshold;
+	bool midx_layer_threshold_set;
+	bool midx_tip_rewritten;
+
 	int split_factor;
 };
 
-- 
2.53.0.185.g29bc4dff628


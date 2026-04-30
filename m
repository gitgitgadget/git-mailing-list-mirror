Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22534CDD
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508021; cv=none; b=aR11zlKaUebimVYurhZOFkabgnj0oEDyIpQ5JTBBDdI+QCi348Qy3EOX2hx2MUNGMY5FtZWksilVz+yiX3iA+cPktADhv75xk0jVqOacA8LiSGcgjV8r43mOI6xjXqaNARit5xNO67pWtxJEtnrP01mc6afJHctl3nO20KwKFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508021; c=relaxed/simple;
	bh=iuGPzLwg0Dr+vts2mdJRrsazP5EQJJkG9Z5OSsO3PmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD2fhA5/s1ZCVgGbWBJyhfZwB/SwHKHUl9/+BQWuXz/YVMNhuQLlhrzYvbKLT2/j73R06WHm94l7cwZroFg3yxvOl/D3NBFoCvwVFtMS1RqlYLtzj/33tZHXW8RG5S22D4Q7asANSa/gwSUPG2MbwX8jzrOlAXlGvz2n282QPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YmvDtaus; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YmvDtaus"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b23713eac9so3696247b3.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508019; x=1778112819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSRR+LJgrzhih/C3vOCRzAluWBy0kBsQSbhXY1ysw5Q=;
        b=YmvDtaus9u8AGkY4vrhGHauIfYOgbPeWvVMYFcHedOaAmPey6OEWO5HKjLI/BFZpqc
         kbj2qwpSAKS2zL4cGujuWBsSMv5Tcep3L45jfjeTTuRkOVEI+8Ak36n6+ox7GU7fsDxR
         Q5oRqlB7FEnIWgBVb0lnLa1hK84MkXmDD4tbl0/HuDZISyLkRkY3Fki9GmWWEqehoUQE
         Uv78Q8xvkv3HwUrvlDzOOYiVBaInZFYv61D3WQUgo0dkw/faqy7z4WPfk8HzFE3t6btg
         sp+6atWkqCeuHgvkeBXFfMsqQ9y++4nTD2kBqMVhvLCOzhdKD4+IGnMFx/lViPr4t5ki
         7yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508019; x=1778112819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSRR+LJgrzhih/C3vOCRzAluWBy0kBsQSbhXY1ysw5Q=;
        b=r4H20D3btgfkY9USnRdthKDDD4BsSA4WveYWa5mYGaqpBz5owSDkh2/g29MBI5ZKfV
         Mbyt6r+dmwxBfgPj5ZCx2Q9sZnjPu/nV4b3lVfasubrvtSRH2CWY9gbICQ1st8OsZ102
         s/2FTdDeUHu1XZ9DMhL5zqeFrdpoYBR8C0CkQq+ZeslVBvzYgoK33iJ0Do4KcvN3DZWZ
         MfM0vH3g90XeAcZdELZCdJ4/G+w6S4A+htJqM6vHt1ggLRC/3oBOslJIHMUOHsZmAApn
         JCLTuNNbTaeZjJ7XrRLnI49Rwhjx1AKJuy7Q7X0Wfu6xC/kjD0ER/YheSTWI5EcS1jPJ
         NVxQ==
X-Gm-Message-State: AOJu0YzLGUSnoUj4DRJGqyDcyjYCfLtZCSDdmwsiI73/fvkr9+gVFKG0
	4uCPb88YbIPqOIapsNRoUE55o/55hGbFSDpkTd0RfhZydD0e4lmIrY8m0DDmrtD0HJhr2052ibe
	6isMWXGocqw==
X-Gm-Gg: AeBDievpaR7bsCL1x85yt0OQ+pLyjb/ZNfaknLsnwikzC83X0HgLhWqN8pedsYVr2PV
	QlwNUAvJ3b4KYoQTtB2UNR+ihGJuIdq146prXA9XmP5uQ2IYk1RO/K+wOi22nG7yP9UCs1mk1RJ
	5aOMY+PGCyIpDmVxbjWNj6XGJ9/pvT6R9BA6ytWkqyNpPONy8vofdFgEoY8c7W9RtX0d2ZhNSCC
	8fZPu5ZQAt64yjDWQHF0ZhU0rkv6eXkC2mcShvW+erxx9rq0dZ6L0bk97GIVXd9607quNr/gqjC
	vqBfXpKXymIJJP3ElnjsBtNbyiY+jUgSu+xisSFwYoxFqgdjgfILg4+yPFMwcC9vSSMwLwPMPYW
	Sp4RM1G6kfbVOvipXy3loPYQxcKoUdRINUQGncZhCqJA2fnInGU7lbvc4oqww8FdyYv9sBdMXRL
	Id45udVoA7b5WwtndFEgk5j/sgZoClfx0HotO+JRRq8nwU5cO8bPumEHGlB2CTIX7i6+Iu+n6S5
	VGencyqR7jbMUWafwCixfoXWWiIvxgJ6REFZygYr/SBYIwkK19EXhIeWCXSlEh5CWOGucSY9iBw
	O5zV7c6yaE4zYSxMF8WejOJ7N1GWtzjDEh9uOw==
X-Received: by 2002:a05:690c:f15:b0:7b2:6177:2af1 with SMTP id 00721157ae682-7bd548a6e49mr5784757b3.31.1777508018689;
        Wed, 29 Apr 2026 17:13:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b2dd63sm1801167b3.13.2026.04.29.17.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:38 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 11/16] repack-geometry: prepare for incremental MIDX
 repacking
Message-ID: <3d32b9c88daaf632845f0ceb097ce95fbe576c7d.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

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
 repack-geometry.c | 35 +++++++++++++++++++++++++++++++++++
 repack.h          |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/repack-geometry.c b/repack-geometry.c
index 7cebd0cb45f..2408b8a3cc2 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -4,6 +4,7 @@
 #include "repack.h"
 #include "repository.h"
 #include "hex.h"
+#include "midx.h"
 #include "packfile.h"
 
 static uint32_t pack_geometry_weight(struct packed_git *p)
@@ -31,8 +32,28 @@ void pack_geometry_init(struct pack_geometry *geometry,
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
+			if (m->num_packs < geometry->midx_layer_threshold ||
+			    !midx_layer_contains_pack(m, pack_basename(p)))
+				continue;
+		}
+
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
@@ -173,6 +194,20 @@ void pack_geometry_split(struct pack_geometry *geometry)
 	geometry->promisor_split = compute_pack_geometry_split(geometry->promisor_pack,
 							       geometry->promisor_pack_nr,
 							       geometry->split_factor);
+	for (uint32_t i = 0; i < geometry->split; i++) {
+		struct packed_git *p = geometry->pack[i];
+		/*
+		 * During incremental MIDX/bitmap repacking, any packs
+		 * included in the rollup are either (a) not MIDX'd, or
+		 * (b) contained in the tip layer iff it has at least
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
2.54.0.16.g1c05dfce579


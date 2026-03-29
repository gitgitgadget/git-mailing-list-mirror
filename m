Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C043314D2D
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820482; cv=none; b=ZUSy2m0+7xYhv08UJ9+wOcwagSW1x8tlC9dSHA92CM+Y8K0TX9nO59xChgRUSnJOostkr1/YuvT5RXveyhD2ElreFIFzie8V+SKAZ/lCsaCZwykxiJiELfcPOcA2Qq+Y5EXf3BmWk//IX5gReMfiIhSFcclwOick+X/fFBP6MLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820482; c=relaxed/simple;
	bh=t+2F/dQ4lTRjc7fNgfEYOGNNBRMBMOdfokNlEQoyqPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPzCtoVu+Qeua7yJCzhEd0xcfAFhdVeBKeCLleZFiv1TW6nmVJwB3/UeVKFh2pG5jYI9Va//NoWAWQvR0K9q9FaGXUuMgq0kdVaXwlSnMgVAwTkEKEkiDxK/euYD4BRcUbIc179l/HoGLh6Bi06tlC2izElUkKvqUmHZFkMCtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FRSKekpo; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FRSKekpo"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64f48a5c3d8so5268897d50.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820480; x=1775425280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dchLUOtkVaAEtg7GZAIXkkr5oHlDjp6QBVe1KJSLPM=;
        b=FRSKekpoFxeBdl2iOyl6VKxLYrucXFPTrdKHhzEWaD59xLHLqXnSR1y0Cr11iVRhwi
         yons3f4itySpnx2Cywf4JimuR+spIIpxx0aCEIF4u25FCBvxGH0KotBECUv49A7S+ucF
         YIRmyXb2WXeTzFoUwj6CFzAUCxjTL869AWsktGcLYBkcTdnVwwmFQcCEQws8AQyg9rVW
         QkXk1MhLbCFhJ9f4JCv5u3d8F6F9KCAve41CZvfZaDAeH0djEfOXbTPEytGpXleOKhsi
         2QwZ+WKnnLltsH33HMGeHt141C6va9Fss5eO5t/W+8KhY+pI3NeAtEe5y9F1iTiKokPK
         p9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820480; x=1775425280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dchLUOtkVaAEtg7GZAIXkkr5oHlDjp6QBVe1KJSLPM=;
        b=lWfyALQMW4GMchQPhotw3E7E1yhl8J55BtM40XDmCMoBzX6enK7OT7x3bb5Imx8uwh
         b5eK7x9bJNFFc8rXOUvEBG09UZxSfNHnFqslKHNuo+gypDxGh08W0VZtgR/WoVgWAgsX
         gMbt3DRq8xds6WoBv6Wep8biFLCueBow4lP0dEBrtAJppN0Vl+O2ybvV/vVSufAROxX3
         ZO/KR7Tnogwf583RC8qnSXXnUOrfuAt4Pl8Yn1zguJsbb9g/yRAYXUElBOrhPWfVoqrO
         ZqfOAGVSVYeIHT4t85wCjJR8WZGFKc7jZBB/P0JidxK34kc4praHzZXEX4B34/ww223G
         e5Ew==
X-Gm-Message-State: AOJu0YxfP65vdpG5jnE37cL9kYBFZbs+gyGWN0hKu+TH4VQ3TSg7NSWA
	XHkohdCjiweU3B8bhmwyWkXhRlBk55mlcGcpzc76s+8HTRthhojqpXNq9L9t/sshj7dW+7nsajM
	eCOhs50YbiQ==
X-Gm-Gg: ATEYQzxXlOT5xolKixxhLiBZMLZWZCgwzrjAnY9kEzzEdRNBLw9Ur4XfZAWVt9aaOvL
	8mtq0iTF9Z6ACT/2mHk3j3eAf/ab6fmMm01/kw0H0YDOvzS7F/k8ZW7pe2tOAHXoJGwti8NeBtu
	3GardEjOGtOR9dyzT/K2PdRxINysWFbx1HhtLR+ha3Nhkq4zOvazGNUuhnz46qtY6SarspyyRhp
	LAKpDqTVUeGsjH2FzcilmHnNt8RDXjP3GSyg0RJpfJ7i8A/qAjZoWNffaSZqOZ/AftBGQxKuwXQ
	/dz0xvevJSdmaT+ua0aTb/d47L4FRE/orv5ZZlk5WPegX7yKwXm5rE1qj3yFx3voG5hpqJqL8Oh
	CCdj8x8TomRPkxZ9JBcmdurfKEIlkBvI9QtMuL7rmvVhNYYLAQjY1NqvDp+ngEPX387z4bB909T
	SdEVpazKX8UThb8Y3wv5C/nxOLvauAIMlgE2mpGECgUITZWZW0Rxp79Zr9xXuBZUqlDeGnQgqUH
	VEV2YXwJh2OZl3NpKHn+XkS/ZPZ9A==
X-Received: by 2002:a05:690c:f13:b0:798:1219:c785 with SMTP id 00721157ae682-79bde0ee227mr101605427b3.44.1774820479799;
        Sun, 29 Mar 2026 14:41:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7c05b88sm26603887b3.20.2026.03.29.14.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:19 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 11/16] repack-geometry: prepare for incremental MIDX repacking
Message-ID: <d2c667e841300c3310e3a23493ac27eb2b08992b.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

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
2.53.0.729.g817728289e1.dirty


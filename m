Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961861A6801
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206298; cv=none; b=UL/km6n2EAW64TlVXHgOrxgAHbpekeLDKJZS/6yBo/tDmroZiU6GWrHuXqyx3aJTA/qOSxrgJUCzjPySon+quz2J8DOXKeXguwlX7rQd9rHtWIAyE/Dht2VIEJvAOj0WwmEzFrgEHH+XANE0lgpbXQULr9EvLG5xbDTQMLg+1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206298; c=relaxed/simple;
	bh=iuPwURDU8ysO3gCpn1QOhzyotD+aAwrxrhdSQKN62Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfGPlfTsv6AafQToqAluxxYx4GZUteei5v4Tzbpkdhc20GufpNLlHx7Vf9B+pl7rJNUDhePVbUhFgylMzKlIgnXeXAand7j+Y5Hn9dnIkhTKvXALyn+3m7tQr7y65t6tcOuV1KB+1f6S9NlRr33003X0J9kUThvWVMmrufGRfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZQ6VHcpJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZQ6VHcpJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdc947aaa3so31486867b3.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206292; x=1779811092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HNbKWs2TutWfe4opmBvO1a4XcroG668M3Pp8jFxb9s=;
        b=ZQ6VHcpJEDTIlHMkvpbhIf60HHcFLfBQi8PETI+b7xhzcQ7NdTbE3yDqH6eYw2cVZ/
         m3kUs71e4/M/xOb1pNZ0ckr7mBd/gkeTWZbHYTyJ/10jvSA4LgJh625IKl6BDvw/82qz
         Zs2cgF+kllLCohX0GH+PNYpu9dYJENm01KR2JIyH9g7HAKTKsC2JouJRCXH8mIRYxFO+
         649d/yfocE8LctTTF/aPsBtqeC5tAYF7NTb63VSW3IpvoBEK7dyArqjZ8h1en1O54phf
         9eo0hdTYEEMRHz58QrcEPqje4Jpp0GkYW1UxCVCapLx4G+Y7wbEaRS1dZEyf2lZF4F3p
         frng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206292; x=1779811092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HNbKWs2TutWfe4opmBvO1a4XcroG668M3Pp8jFxb9s=;
        b=PAkg0xt2DizDKjoom+ABvm9KFyRMievLrYls9DiN0WDVyQl2Gij3O3ML6mvDv6j1Ti
         nF8I1SOJ+U1DZEpoexH2slKhbHUmgTteY8WU0vQv7abhKP/8jXF3CJ9bJvVyBqpxwFfZ
         IkPgYLar/BBxzQ8n+/k6NGZw5aTNHC8ovXZzGzWilos5q4gVx36gx3FvLaubzjnUqdtB
         HBYFlenLxphkD2UFhK5UO1rPMe9vzh/j+G3VXf2yTt7kg3jWDG1mreHXM3dBhU0m4VVo
         cCrbT4B5oolAPKRGuLgwTa1Sjlm7wKW8FuVAB7VGdf8mv78gQGKz6/UBtcGmST92GyHY
         Y4eg==
X-Gm-Message-State: AOJu0Yx2pB1JOJt8clwRQ4q+iNLwJ4Nh24hoXCMWbMIv0w2ShFhlbFdd
	UzHc8ugE+LMR/3LNdUUjblQ5ASbH5jR0INKKGtQ91Q0D/kgCCaAJ0Mhi0usJRX6ERpnVBjbH6p8
	oiV9hsk380Q==
X-Gm-Gg: Acq92OHc+ii3EItFN58Qu4YmBFtwxxC656JZyzprDhjQwtXhNKMBXPUFEZRWpfBdjZc
	Prn8d0xwD5cCNS0Zv15an1CNg91xrnNevkXgdVipva6OXiq9TSa1QAS4cqIY6lEIqFHrr6acVWk
	UyIbeNDDesvdxN/0JsvP5Qppk860iqgC8fP1CKXdI8/TMtBx7RrU80kzd47bJJZf/NzZjBe547w
	2fDitgDwUEuPHHKvMAV7B92LVF5T/tWr+03u9kc/IZaQns7r44SxJPT5Yguld+Ry8GCOQ7Zm+lA
	yyG0MVkXOiY1Ll9hujktdn4ERPzOabZSvDD/O07Nxt10SBwkej1pHXjA5A8vyJ0VVdJPx41JvV7
	deVrY2xD2az0w0pEV5xRqLy6LWeIdGPwxO/Lr/JaiBlqea142of1hxc3DE/swzYltW7nU3TLQvZ
	pxkWGbhxIUXeJO6M3XPrwtA2DYMplLZSmEnq/jjElytPoAsEL8+0Um0m2j/hVhNS7O9Zc52Q9rZ
	wYJ1bW84l4divgghe2qlrdnKXu3SivSre3+ZUODuF61+pwdSQCXtJ3MbEqlmJ4V0Z2413mtGy+4
	bzCabq35PaI38hfh
X-Received: by 2002:a05:690c:e1d2:10b0:7a2:3d38:337c with SMTP id 00721157ae682-7c95bf1259amr159323127b3.32.1779206291774;
        Tue, 19 May 2026 08:58:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccc4sm38678457b3.31.2026.05.19.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:11 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 11/16] repack-geometry: prepare for incremental MIDX
 repacking
Message-ID: <9665f1b3a6404f1e69939db218a59cd2f3a14417.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

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
2.54.0.175.g8bd0ec98dc3


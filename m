Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1B381B1A
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803860; cv=none; b=RjaOrJ1d1rbD1dmBTERoOTtsdjZPABo03yEY7lxZx10fyhdTehsbgJ86dQFPUuQQweG4ySVBn042RM+FtBMyywUXT7hqJFOeqEpb/lw2iB/7foLxFw0PQQDT+Aryhr34arjRW8k/iTerYtfKjZLrZk0s7o+3ozC0mkhJ3JSjlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803860; c=relaxed/simple;
	bh=F/+DVyIFBLAkjNUSHcTudVhy5FDIT5g5NpANTMcusG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHBEvrBEInUKGdMiaSH1pjQamoR7uN6NbToMdEmTInzjNv3Ewm+6ASYr8DZp420i2RluyNk9n77XzYWkzd7bZA+FSeZOET3j3dNmsMQhPQ4digsSWzVKT3g7uT9zMuqsGhT5b9CbBOGpH6+GWzM1YTp9gIT3pQrDbhJL0H1PeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YdO3dlJp; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YdO3dlJp"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbd23bc684so2740525a34.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803858; x=1777408658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTDdnKO8ZeRLq16uKW5v3rfSCzOHweB1cn+rFUji/aA=;
        b=YdO3dlJpL+FD+d1a2NB6F8uzgqpUpTb6DhyrmQTuqCtjDNIozzigdQVw6FVw0mToXi
         DeX/TvX5SS3C5n6rgY2YLEMzKQiEMRXF81LR+BcgyvEbJMgzCU5fd9zqTKcuh+glW0ZX
         ro0pGYgxqDqYAeuGEneLMdIR/3uU28+rwVkp89sbRtwfb6pJie5PoNFYWGLNblGNHyHy
         V7IiFPwflAcGN7Zb75NcuIgsnoT5uVz0Fc9MCKbkWMB6SSzyqhvoBgzpMkXoq0ELZerd
         ifHOIinRoIVoZGp32zUVxXrf/zkH+K3n9hgjfeemiEbXna/138FTilgeHYl+YrOg/yBk
         9TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803858; x=1777408658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTDdnKO8ZeRLq16uKW5v3rfSCzOHweB1cn+rFUji/aA=;
        b=tQMCs1ai93w7Yd7AO6/pr7PiJbbetpPLb/WoijjZ4t628L6nHEIAAAFPSyVNQYukUK
         yD43QjVWLgLZBTLGMF0hQIDJ33hvTseC+zUxT6hmMzInxFiPbusOXAMqxrUgsQYRFZFX
         dqR8/a83BIwzqT/k5wPyl9DeZPruKQ/3WOgKgAcJjiKFjhSgc5FAScTb4FdWQdtYYN7Q
         /T1g5ErU8eMppdeDlDBVrgqsGdMNIN5YlgghIfhdmBw3GnGZsALEX7fR4Zqet+8P0IC+
         X4E/m3nLJF7/K9Ie01Lz6IzIu4zAiOyEkWUHbStAKnFt/WId7zTK6+KWEy1zV9IrtTzV
         xqpw==
X-Gm-Message-State: AOJu0YxspNZteC84VOH9tgTwfYMdEJu3tGCCFikJAIdQhXJRGIQekJ2T
	oxxNdZSgbqf5vlai1jVuzpFI+382qYIeMYindYfPjsxPgxZWQjVMT0q9tAsEgwN1mGHZtvYfbFJ
	p55uJ+KQ=
X-Gm-Gg: AeBDies6sK45cTY2RH64HBNE97zx36qWc5oQ2R8nxZRIMbhFqLYpxZ2x1t2iIPgWczg
	dnjUoNJr13kx9gsqL5FEvMGneVPnObSdJ7BQ2tDSVTsc0fkEXPdqSTptC6Y7Eo1EYm2yAa1Z3IF
	gyczAWC9IezBOSelcIe7P6nNDamNK/JScNOTOtmhmnmAieI/jhPBzJV8P6QXBmLGf1Xa0wHsinT
	Aa/gHBmdBVUTS4Gf9Ix4+WHP10s4c/FL0rQLH5T8KY+/Nx396QPNZjVx8RsHtol2QGkCbiYyA/L
	nYCSXhrgr2c2v6UmNN6IVnKrIRZxhBAEOUlgPtQGzOwuOVWMVNEC1LRpoNm+KVuPzxaZFAX2OyH
	tedC3GRYC/Vv/EXZ+82b+JNllizYY9XwYy9qo7xzCfsXDtaAoLRod2QJaen0MgnRNptNZDo1qSY
	CuPXZVfcojmyEYb4IefFs1YYPWwxB4MxOq7fvf89NV2+a0ZDIxXV9u6zi0s3VSFTmKNFPSPc4er
	pbjo+LvEGVaqOyYx9wgzu2XmfPl0kFaT7vpT5OiFlOFmdxQ6jSwS2xZNUSXI/M1ggEbLBfY3VA3
	9VOb/Kc1gJzcGLtJcioH8MWJQVD3V/2JJ30Ebw==
X-Received: by 2002:a4a:e846:0:b0:685:ecd2:40e9 with SMTP id 006d021491bc7-69462f5d68bmr11018985eaf.59.1776803857912;
        Tue, 21 Apr 2026 13:37:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6949127c1e2sm3207954eaf.15.2026.04.21.13.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:37 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 08/16] midx: expose `midx_layer_contains_pack()`
Message-ID: <d3ac65c1f11656d11ff6c17fe4e5b02a916585d5.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

Rename the function `midx_contains_pack_1()` to instead be called
`midx_layer_contains_pack()` and make it accessible. Unlike
`midx_contains_pack()` (which recurses through the entire chain), this
function checks only a single MIDX layer.

This will be used by a subsequent commit to determine whether a given
pack belongs to the tip MIDX layer specifically, rather than to any
layer in the chain.

No functional changes are present in this commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 6 +++---
 midx.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index bcb8c999015..dc86c8e7fee 100644
--- a/midx.c
+++ b/midx.c
@@ -667,8 +667,8 @@ static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
 		      m->pack_names[*(const size_t *)b]);
 }
 
-static int midx_contains_pack_1(struct multi_pack_index *m,
-				const char *idx_or_pack_name)
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -709,7 +709,7 @@ static int midx_contains_pack_1(struct multi_pack_index *m,
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	for (; m; m = m->base_midx)
-		if (midx_contains_pack_1(m, idx_or_pack_name))
+		if (midx_layer_contains_pack(m, idx_or_pack_name))
 			return 1;
 	return 0;
 }
diff --git a/midx.h b/midx.h
index 77dd66de02b..3ee12dd08ec 100644
--- a/midx.h
+++ b/midx.h
@@ -119,6 +119,8 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid, struct pack_entry *e);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
 int prepare_multi_pack_index_one(struct odb_source *source);
 
-- 
2.54.0.9.gb905fd5d0ae


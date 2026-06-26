Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1138C40C
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500554; cv=none; b=uOVcmxU6jEVmNVBOcZM5eHh/XeOW/AXPF/cmpaIQAWsxGZHoJnxmvNlogDeS2Dg8M5wTD3iAAGS10hAdxDffBk1rmxvOG/9WIz1r4la7iWOUAtgHfxdtd1tY0zGufcfhIJflEyHexM4RuYWj3IDjFRgx3dGjPEF4K2KDVo8zpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500554; c=relaxed/simple;
	bh=e5GYD2oZY5WUl983FYVxXWCxmDfWDKKWhQzbKCa9Y1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwoad0o2zEZECSQLXfj6NbpG8OlHTCxkIIhv2SVoHiEqKFazdQWm+4nisY2pVxK9mBYsW5M45jBvNC5QggVEl2TjfYkGOauzQsgY+Wmqjt8rRKTHslDDAzHijSlebJ4h+r/rotCUpZ4vB+5zm8cQss+fXS9k8WuTg/VWcGhLPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=esz0QyWc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="esz0QyWc"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-806449d108aso20307347b3.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500552; x=1783105352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zKgFWPl2aTTU0LjuBxc4+v9ZaQvBSCD0DynVl3CD3wQ=;
        b=esz0QyWcBI9ogD8KnZ5v0MPl1wLqGgKsGwtuGdsmKqRFl0ZPg5ppCOmF8ouACQsAyZ
         FwXD558J3v5nLZT0tKkLZrYHNJ6aib3E7kIYUvAmmV9fN2QUAtLLu288RwLIAYjG05gS
         BgPgjX6EtB7WJH8uZakdllIexPwOhjcnxX1LZr+Y3UL6lDazvJgIBj0ymi19Mr+DsEUP
         XGKDwyrBmFSCIczhf6k4wTL6YxNnk10AXI/uJ+hsO/VyVM77ME/kaN2ldnkg46A038uE
         mxaWonkTFYsHfbOuJSPjR86L2U7cjebebgQ3Tr7fl2YVlPqmEXF27SeMONeFKfxeWonf
         NG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500552; x=1783105352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKgFWPl2aTTU0LjuBxc4+v9ZaQvBSCD0DynVl3CD3wQ=;
        b=REdr84XRmaAdMa4u+8Dq9qPXePqEetJBiibLdS3XFeHavITXhye2A1M5SRBl8VXzk6
         q8zw+bnSDGnYSCTy0QVyjk58pgL8u07eYhjnwe2kwN5vlOXipKk2Y2IXZevWzlLRL/i1
         6Xhz+iqMMNTOwVr2GIWcf64kpX5YKu4WTzVGXN7Qi09W60kxfiqXhuO8gVf0C8Jf6DOW
         buXgZUX0pKFXytSUuOLFvLmhgR66l0xdlUfZhxyMyit1c9Nyp7SaedQzZlSDKIouM/XE
         hjQ0925hpLw8JvhwXrkZ2M5K7yEDqGKrYznrzBCbPXU0tzS0wCifjQsIh2xbPPCKevXI
         Wtzg==
X-Gm-Message-State: AOJu0Yzc78/wQ4eU8DfTUFioHeWCkh7ktylCmVG3u6dg2Gy6875fq05+
	vH1s77GNfkwYnSso+pGBHIIkUX7rcEGrMNEnntrfXGC4GXgPpieONGP2lI6ecSj34lQUvUbWr5C
	O1pkaMxVMdg==
X-Gm-Gg: AfdE7cmRZnUqEGqlAd5C1OxH77JKqaVIkvaNsiRk2CnF954DlMqJ/3UXmLRe4aVuUok
	BzOzgGlsBm40Xoy7daqgMBI3Uq9V0k4bIlB99hh/k82aSPxYz6HrJn+IE5PHQqP9NM+89e26K6D
	NzvUga1otmbt+/vaXZfnPJbl68o1PIkc8zu9iyPDCHp/Lx2uRuB0OF1uzPn5egcLKGT35chooVm
	GDsHugNksclvvugJCqIaReilbg1RA8vKROwjvmMifWY73Vps9Sw3f8G5pMDB670H1/ZSgPKloGK
	8QgtEtrVXdDQGDmexPLz5TQ2l8+dKw8Bu2ivDt8OKl6FOxG+lx3kwlka1efn2tiBxM3bgh2TmDn
	m2LWPuFPiUtDW7vWhJNDzi2T83fEj7c0JHVH7vIAv7ecO4d7xRkRCPYzlZrWDTP+WeGJ0QV5kke
	0D4n0WpppaWmVxbklDpKqQxDmmC0mm71+Q3EASyJDgqVTwL62gY7xMmHORSOQFZ2uDsCh0bleU+
	cMM3JnY1r/JxWL2iLziy7yXC+75oIYIQS0lQPd3eHcN9BxOokplhn2oDfemre5sANimYPPYdKvh
	xHK7Fw==
X-Received: by 2002:a05:690c:4c11:b0:7dd:73e7:84d7 with SMTP id 00721157ae682-80a6a8a408fmr79609827b3.41.1782500552034;
        Fri, 26 Jun 2026 12:02:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-808ceb8ced7sm36673627b3.40.2026.06.26.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:31 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 06/10] repack-geometry: drop unused redundant-pack removal
Message-ID: <ce7e4bfb3c7b3775def25d9fc78827e98952e3f5.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

The previous commit stopped using pack_geometry_remove_redundant() when
deleting packs after a geometric repack. The existing_packs machinery now
handles the same removal after geometric packs are marked for deletion.

Remove the unused geometry-specific helper and its declaration.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-geometry.c | 44 --------------------------------------------
 repack.h          |  5 -----
 2 files changed, 49 deletions(-)

diff --git a/repack-geometry.c b/repack-geometry.c
index 2064683dcfe..c75fa508612 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -245,50 +245,6 @@ struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
 	return NULL;
 }
 
-static void remove_redundant_packs(struct packed_git **pack,
-				   uint32_t pack_nr,
-				   struct string_list *names,
-				   struct existing_packs *existing,
-				   const char *packdir,
-				   bool wrote_incremental_midx)
-{
-	const struct git_hash_algo *algop = existing->repo->hash_algo;
-	struct strbuf buf = STRBUF_INIT;
-	uint32_t i;
-
-	for (i = 0; i < pack_nr; i++) {
-		struct packed_git *p = pack[i];
-		if (string_list_has_string(names, hash_to_hex_algop(p->hash,
-								    algop)))
-			continue;
-
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, pack_basename(p));
-		strbuf_strip_suffix(&buf, ".pack");
-
-		if ((p->pack_keep) ||
-		    (string_list_has_string(&existing->kept_packs, buf.buf)))
-			continue;
-
-		repack_remove_redundant_pack(existing->repo, packdir, buf.buf,
-					     wrote_incremental_midx);
-	}
-
-	strbuf_release(&buf);
-}
-
-void pack_geometry_remove_redundant(struct pack_geometry *geometry,
-				    struct string_list *names,
-				    struct existing_packs *existing,
-				    const char *packdir,
-				    bool wrote_incremental_midx)
-{
-	remove_redundant_packs(geometry->pack, geometry->split,
-			       names, existing, packdir, wrote_incremental_midx);
-	remove_redundant_packs(geometry->promisor_pack, geometry->promisor_split,
-			       names, existing, packdir, wrote_incremental_midx);
-}
-
 void pack_geometry_release(struct pack_geometry *geometry)
 {
 	if (!geometry)
diff --git a/repack.h b/repack.h
index 90c89630ef8..4295829cea0 100644
--- a/repack.h
+++ b/repack.h
@@ -134,11 +134,6 @@ void pack_geometry_init(struct pack_geometry *geometry,
 			const struct pack_objects_args *args);
 void pack_geometry_split(struct pack_geometry *geometry);
 struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry);
-void pack_geometry_remove_redundant(struct pack_geometry *geometry,
-				    struct string_list *names,
-				    struct existing_packs *existing,
-				    const char *packdir,
-				    bool wrote_incremental_midx);
 void pack_geometry_release(struct pack_geometry *geometry);
 
 struct tempfile;
-- 
2.55.0.rc2.10.g29e31820dce


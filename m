Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B11B7FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482300; cv=none; b=dwAoInEEU+nucWnc3jpp856P/IFwN+QKZKrkfGipyL/lTx4Y8PShWObCKKD4+G/v68aHFzA8ISI5UvIxAohbZZVfRSuHlJghpGp0st1m+IzIZwiarBYq2otVCHCMgvOPDnU4leKo+MjOAfNFhWkHXqbAaukY9osxIbfJEIUm1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482300; c=relaxed/simple;
	bh=xVCZ3Ypwgu0PBwWR1lCoNPt5uuHM1mDSHmdRA+dUUsI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYht/oG/ATub7F/NBPW3XHF7xrg7twtbZ3jcPrVZEHv3oF3DCM2MWFqEyDw4hS4UnZVZsUJoLBIiLa9GcVD4u7V481lUph8gBqXt1fqznXduTTxCWM7LWJrOqYz35YFKLjZFeRG0ubIlWNqNv1j02vjzUKnFdPnihWKIX7lJXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EogCyZ+b; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EogCyZ+b"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c99501317bso3152295b6e.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482298; x=1717087098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUGSTQ5ZEP/VfHPFtdC4NsjLcbjdVBBQdzH3OFMbxdA=;
        b=EogCyZ+bLw85GfDjxBK1tCyeFbm+XqM6BGZoAOxhWkm24LNEAtlwQKbYC14+3rOzFC
         OLv4dBnpWsGv+K207/bQIapioxQSb8YGG5pBo8srSBFfey9tcns/m+Ot6+yqYT3hPg8b
         S0F5sr8I4NgqbfAQBsUl8VKgHB0Jb5ATZm9OUZvPev+ZvAOxoxMxaojlP8QQYZ11fqWE
         nmzsbmOp3CZ7mIbVisj6ZVF/adLJ6j2jRYa7WT6IbZq8t9rW1+jpF+G+FipQOmJsxJaJ
         41EbQVvbWcJGEmrQbes92c3TY5wZs4DmNrutkxfCS+qjeNllNmcLMTPJ5kboLg7HbJNN
         OCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482298; x=1717087098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUGSTQ5ZEP/VfHPFtdC4NsjLcbjdVBBQdzH3OFMbxdA=;
        b=hAerMhHWE8e3GeEkvrPb9Pc/i2p/nHnRJLtae3Lt98wsqpnPGqfYDOINtL9bC7VhIF
         ItibsapLOLWBih66OcLvKpx/TFsrcZq9BNTceXlEpYSk2cP8IieqA41QcrgogKBMSw5G
         oxZeWVKHs4DzT0+VjbL3KW4rgZj4Rr6e+suv7OxeQUyBG4uyIq87tuk5Po+eAp87AXoH
         994g6/Z9ejZepDdRxmDYkQy7X1s4ON8eW07QT2gNI0c2VEWkHHeT5ZNI/WoI538y2WpQ
         WaqKRZpbZYSilVwDEPzxOAd12IC3aIlpr7uQIWclfw4qGCMMKmLmerTZdO8b6PmrVjZB
         Vx8A==
X-Gm-Message-State: AOJu0YzaRq+Lv7JCC6vDkoDMIt/bUOoHsZFvknTGVi2AVpmtslM9rmy1
	6fmCPaVHSXnL1icwWsDAIW9WBNONT9VRdkoeMBydqaPkg0CGyKzMA706iQzYEljJUl8nOtV+YQd
	g
X-Google-Smtp-Source: AGHT+IGgBjHZh2vUe8e/sEFkr4XsnoxZqE3nBe3oSizX426e1UOSJwSz7IPpNRi5YWAln3q0p1J84Q==
X-Received: by 2002:a05:6358:7305:b0:186:119d:8c16 with SMTP id e5c5f4694b2df-19791dded60mr849729655d.23.1716482297923;
        Thu, 23 May 2024 09:38:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd250sm145656586d6.98.2024.05.23.09.38.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:17 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 5/8] midx-write.c: extract `fill_packs_from_midx()`
Message-ID: <dc813ea1cad4ce50694f21c3bd44174bd414f2d5.1716482279.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716482279.git.me@ttaylorr.com>

When write_midx_internal() loads an existing MIDX, all packs are copied
forward into the new MIDX. Improve the readability of
write_midx_internal() by extracting this functionality out into a
separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 68 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index f593cf1593..9712ac044f 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -885,6 +885,40 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	return result;
 }
 
+static int fill_packs_from_midx(struct write_midx_context *ctx,
+				const char *preferred_pack_name, uint32_t flags)
+{
+	uint32_t i;
+
+	for (i = 0; i < ctx->m->num_packs; i++) {
+		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
+
+		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
+			/*
+			 * If generating a reverse index, need to have
+			 * packed_git's loaded to compare their
+			 * mtimes and object count.
+			 *
+			 *
+			 * If a preferred pack is specified, need to
+			 * have packed_git's loaded to ensure the chosen
+			 * preferred pack has a non-zero object count.
+			 */
+			if (prepare_midx_pack(the_repository, ctx->m, i))
+				return error(_("could not load pack"));
+
+			if (open_pack_index(ctx->m->packs[i]))
+				die(_("could not open index for %s"),
+				    ctx->m->packs[i]->pack_name);
+		}
+
+		fill_pack_info(&ctx->info[ctx->nr++], ctx->m->packs[i],
+			       ctx->m->pack_names[i], i);
+	}
+
+	return 0;
+}
+
 static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
@@ -930,36 +964,10 @@ static int write_midx_internal(const char *object_dir,
 	ctx.info = NULL;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);
 
-	if (ctx.m) {
-		for (i = 0; i < ctx.m->num_packs; i++) {
-			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
-
-			if (flags & MIDX_WRITE_REV_INDEX ||
-			    preferred_pack_name) {
-				/*
-				 * If generating a reverse index, need to have
-				 * packed_git's loaded to compare their
-				 * mtimes and object count.
-				 *
-				 * If a preferred pack is specified,
-				 * need to have packed_git's loaded to
-				 * ensure the chosen preferred pack has
-				 * a non-zero object count.
-				 */
-				if (prepare_midx_pack(the_repository, ctx.m, i)) {
-					error(_("could not load pack"));
-					result = 1;
-					goto cleanup;
-				}
-
-				if (open_pack_index(ctx.m->packs[i]))
-					die(_("could not open index for %s"),
-					    ctx.m->packs[i]->pack_name);
-			}
-
-			fill_pack_info(&ctx.info[ctx.nr++], ctx.m->packs[i],
-				       ctx.m->pack_names[i], i);
-		}
+	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
+					  flags) < 0) {
+		result = 1;
+		goto cleanup;
 	}
 
 	start_pack = ctx.nr;
-- 
2.45.1.217.g9bb58e2bf5a.dirty


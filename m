Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F101CB31B
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023340; cv=none; b=MJNdrQK0Ap0tceGeV44OuEpOAa1B84F1ZPD7TsS9qaFvltZkdYal+yKl+ucDARV9KMUNUHvVdOeLw5kHb8ZIiojyLcUI02aI6FwpRehcn8r2MOADY0fra7Y+vbpOAjuZLji4V1zCP36y/zOZJgqnNal740wEVoo31HapwmGxcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023340; c=relaxed/simple;
	bh=OH+ZXOWuaWbHXLfzLFS4LJf/1r9XV3xOjR+8f4pdeGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puU2LABM3DBcNCIm+lQXQHySpWdyiC8dzwd/sZ90AdT1N15YSjgCYWUuGaWWLupTt20o3CR8qvzNbvQajXID5NMXl+aXHo/zJo1bNj9nJncCZV8RxWC+nvsFNS/vA9QNPnK7y+aadZxmq/oSoY9OnDdJ+KsjqiPKUnzbhbfGoFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OuJOhNN5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OuJOhNN5"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ab9e011f62so5036996d6.0
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023338; x=1717628138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjazu+Ufq2AIDDiAtTjbXZ571NaUKcrxOM7b/1ju0f4=;
        b=OuJOhNN5Tm+Y3Gy8YIVuLMTJJ4LFu0Sa505x5guyRchDB8pHrmA+51SzCRpY1/Kr/f
         qmwUkM+VHwu4nPmSOtwr7ssWk0U06bBg+mZARx3JPiBFEmfn2lVw7HAmET8YG+KUgkSF
         zFkmsdowFlq7IJQIZmxMQL3NGnxXEeiRmrXUDrogperzl/55hV265Bm/m3vw7l/rWtmP
         LUqwJMTPGzH2d6KNxAiUVnzs6lSw7+pBTKRiaE66Jjg0jGBlsVXQCIKILY+x++fbxmRx
         eHLLDMo1GxsNq48XR9Mt8CIEUFeJxBA0wnDdriG3T3oax8XVtIRYe8JksUl7YCaeDxHF
         s4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023338; x=1717628138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjazu+Ufq2AIDDiAtTjbXZ571NaUKcrxOM7b/1ju0f4=;
        b=mZFyOWtBnbDlroVFz8GsNmdl+GXlFA6Gy9oISCkZ15rNMPnKV96P/bh/ywDtocr+wn
         MqaTCfNaQd+cKhjuLvvnKxXaVDAKmhwu+dmiVbj1xg6vVmzR5ddjRPD+641P0cSUpqhU
         8kfNi/6YDTJBXr+zh6vzfmdYZvUfYr+b9K1fysQbPBcHI2s0ho7zz+fuZ2i/5oL1eqGw
         xo6Q8JxIpKI1pfd+DEyjtIf11rElAg1V2G93+cFFIalJgi8U/y8v01rb8OaSKUl8jox7
         2QsOxho65+95ZKWHiTSmx6ovx25mZAagiPwaHVDfbNcvwUQ37x6gLeAyDXVyo5fZMIyE
         /XUQ==
X-Gm-Message-State: AOJu0Yy324ti6E2dF7AD3g1qDz9v1tHSXXhWr0Y537+qVKcC6pCTZw9P
	2zN1qWwr7wcPKsUW81dgpfLW39aTRD9PB/snuzBTcJqWvbuRv8arv0b4J60xWcx2sEfiPwFWlIc
	41Ms=
X-Google-Smtp-Source: AGHT+IF5sCULN1LiyDGnjfjQlY7uxfjm8qZzGbOTKRXnGbTzeJ/efDymRmmJAzYWAt46tM25PygNxQ==
X-Received: by 2002:a0c:c308:0:b0:6ae:ff6:4d17 with SMTP id 6a1803df08f44-6ae0ff64f70mr2145656d6.32.1717023337651;
        Wed, 29 May 2024 15:55:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae09b63a84sm3400826d6.73.2024.05.29.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:37 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] midx-write.c: extract `fill_packs_from_midx()`
Message-ID: <1bb890e87cf6db9e464d7753e781a9e5d70e0b12.1717023301.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717023301.git.me@ttaylorr.com>

When write_midx_internal() loads an existing MIDX, all packs are copied
forward into the new MIDX. Improve the readability of
write_midx_internal() by extracting this functionality out into a
separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 68 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index a80709726a..c93e1ae305 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -888,6 +888,40 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
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
@@ -933,36 +967,10 @@ static int write_midx_internal(const char *object_dir,
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
2.45.1.321.gbcadaf92783


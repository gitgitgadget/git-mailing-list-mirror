Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DC1CB31B
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023333; cv=none; b=K0MMR7D3Z+W22RqrXHH8rglLKbilVjRUzmdZPKnAX3k8F8LWrWlyp6Myfsyde9mW5rAzZnMOXcBJ1DkfJJPJKmspfppGnXo7Le62PUoyvrjk6greN5YKmBd9ZbbEH5QoqE6J4nA5fI4SpmFofULq9chXsbbo8ep9+CW/nDCL+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023333; c=relaxed/simple;
	bh=UGg7U1T4RfZOkgeOhgOrGv6/wfK1HYUq41dRSyIoQ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt9AQldewaO1dCNXno70Pa8nXNDWFRg77maQU3rNP2Z45w6eepkxQAg601kn4MzPF82J+OOpDIRc59g7w6bkaWTcx6SgsL5J0JiuwYg9unxPYDwzsNIgibzFORss9VXLFFuVj59UlQ5iSOI1SWyMxCJDcmR8w/1i7uyGOitapP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cey+pUZX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cey+pUZX"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43e23ce7b07so1088051cf.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023330; x=1717628130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJcXgSFD2N6ZIbBhxeMGvaAbGOu3HrfqZVycpkjFW8g=;
        b=cey+pUZXcWz/h1M3j9S2lleySxuCUPv+35hrNwF12X6z97hiBE9mtUXZbTzG4zBtMo
         FIY1baGYA4zCP3zyuXrBWc+yFCGLXXEbX87uGO/8i68RYltJeL67TRzsVxp809KlFyKw
         fDYJfcATUzj14Bdd/ZvUI7/wB8RzOI2CzoD9y/WRzSlj4aqooUbwAl6t3SvvteXqwhGi
         +5KkTYkFuy91OHPLyE4nhvk+EqAqRV/5aBAZllG9S2iTBLd8SaKf9fnJ/EitFofwNz9J
         9MSW3M42OSgoNQy3dq9JIqzDR4lgjwBVMz2fbC4DIiBuVw4lA5ExJmMhEc62B/ZE+s/D
         f7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023330; x=1717628130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJcXgSFD2N6ZIbBhxeMGvaAbGOu3HrfqZVycpkjFW8g=;
        b=BnQTlMMjRQGIBAIzZ+C8kcIIX0mH5mtNnReQ+kpCyss0RykviBt+zwQtIP9ajj4IiS
         ozmRw5n9rjqEJwencmKHu6wchKC23KWP2IRRGmN9OKNFnM4RmWSc4dUzijbR/T1x8Jkx
         1c1e9Q9lzYBBKw3SGJKCzbVEESzjMS0GEFfdLq5wuElOVgIc8KvuKQkhfFu7X5ZsONuL
         eI0uVuJU+29kaq5waYPCrDMlJA63b/xmyEkLVmduFEbAC+nxCYl4/G7lvhdFsMvbYl1M
         KFsei3enNrWFOX9AA4NICsfNLSCNEBp3r+EsVHs/LbH+17POqmFZroxnj+VZ3K7coMcv
         H9gg==
X-Gm-Message-State: AOJu0YwM90Ic5kC3EVznvKmR5fDSUlc8Ko7Qb0O1JRGOk1sC89G/JAwN
	kAalITlvi5pQf1hPQxvPG7FEu/KvNXt1+6Is+Zm8JtTbeA1YUpoAclRu1MKwZrz82d0hUImexyo
	K0aM=
X-Google-Smtp-Source: AGHT+IGB4qErMSv+ELYwQhog3ufp+pxICmuynzhDmG33+nNABnuj0qz6jXeeqrhHWV5Zv83xZ7BZNQ==
X-Received: by 2002:a05:622a:1491:b0:439:b41a:56c1 with SMTP id d75a77b69052e-43fe92ccc10mr7807931cf.34.1717023330061;
        Wed, 29 May 2024 15:55:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17fa357sm59135961cf.45.2024.05.29.15.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:29 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] midx-write.c: pass `start_pack` to
 `compute_sorted_entries()`
Message-ID: <e81296f8ccf8b47758d0ec4fbb04f0f2b356b490.1717023301.git.me@ttaylorr.com>
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

The function `compute_sorted_entries()` is broadly responsible for
building an array of the objects to be written into a MIDX based on the
provided list of packs.

If we have loaded an existing MIDX, however, we may not use all of its
packs, despite loading them into the ctx->info array.

The existing implementation simply skips past the first
ctx->m->num_packs (if ctx->m is non-NULL, indicating that we loaded an
existing MIDX). This is because we read objects in packs from an
existing MIDX via the MIDX itself, rather than from the pack-level
fanout to guarantee a de-duplicated result (see: a40498a1265 (midx: use
existing midx when writing new one, 2018-07-12)).

Future changes (outside the scope of this patch series) to the MIDX code
will require us to skip *at most* that number[^1].

We could tag each pack with a bit that indicates the pack's contents
should be included in the MIDX. But we can just as easily determine the
number of packs to skip by passing in the number of packs we learned
about after processing an existing MIDX.

[^1]: Kind of. The real number will be bounded by the number of packs in
  a MIDX layer, and the number of packs in its base layer(s), but that
  concept hasn't been fully defined yet.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 15965ceb70..949a66e973 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -299,12 +299,12 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static void compute_sorted_entries(struct write_midx_context *ctx)
+static void compute_sorted_entries(struct write_midx_context *ctx,
+				   uint32_t start_pack)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
 	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
-	uint32_t start_pack = ctx->m ? ctx->m->num_packs : 0;
 
 	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++)
 		total_objects = st_add(total_objects,
@@ -889,7 +889,7 @@ static int write_midx_internal(const char *object_dir,
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
-	uint32_t i;
+	uint32_t i, start_pack;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
@@ -957,6 +957,8 @@ static int write_midx_internal(const char *object_dir,
 		}
 	}
 
+	start_pack = ctx.nr;
+
 	ctx.pack_paths_checked = 0;
 	if (flags & MIDX_PROGRESS)
 		ctx.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
@@ -1054,7 +1056,7 @@ static int write_midx_internal(const char *object_dir,
 		}
 	}
 
-	compute_sorted_entries(&ctx);
+	compute_sorted_entries(&ctx, start_pack);
 
 	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
-- 
2.45.1.321.gbcadaf92783


Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3B1B7FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482294; cv=none; b=ZZ4TtP210cgAf0Gd2+YiHd7l525ig8ENe0FeennjTtJmK47pPGJRGiBXcL6Kb1Z4a92HGv8bwLoL1xBKmaL3ZRSS5HhOlcPU0vqR/q1ltVCaqQkZe1i5p2HJ3Q+PM5x8wJ2ezYwp7OmWUe0G0BbAHaKq3TQtHSUsKpg1okAeE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482294; c=relaxed/simple;
	bh=gbR48D26zhvme0vFimQ50jGk/WDH0xdrkPg8hNzctck=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+45es4TzJEGxpQEoWssAKvAB//IO56q62UZCU8qr4Gg1hj8tneiULYUc8OZ3HfzohdvjVadu8GL4A+AiUsj++ksfjLUhCwRBk2BZJ+eWdtdWeDeK+LR4vlQj3Hz7wyj61Uunl60pgYDicd6nRv4pJqGej9Xb01O9h4fU2zFrTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qNZzoaRY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qNZzoaRY"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43df052337bso6996951cf.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482291; x=1717087091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz1tGE7pSt1jwGAO9LCpidn3GllthPkuTtX/D1wUtY8=;
        b=qNZzoaRYS07yDTsXQ02i6vsZ53wwoUA/KJkWeMWnHr+AEbsD9RFs9zpWYrP+6oRjh4
         oQnFBLAeiEg4JVia+RkLhQH0xz/x5YcccEta8rwFZxnHaAwubplmr4cRQ32yceMO21sC
         raHZ54WBS2oGc7jrUWJevKusO+nGXVtUQRBrIXsAO43m7TzJz+paDOZR5Yp9ofFZTfpx
         JT8CGZ5ga+JvFgtf5aQw/KFTl5Hej50C6NLkZKjxVfyGhqLAXgS0br3NGvwuMcC3NKRH
         9avTelWB3DkjW+vh0wPg9Pr07/T5FKrkRNW0rIGo0lyEkRmoLUfOfPdQw2FbpSfmbAsx
         ET6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482291; x=1717087091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz1tGE7pSt1jwGAO9LCpidn3GllthPkuTtX/D1wUtY8=;
        b=KlfjIdSuU3TW7Eojw1OQ9i+56OSBAeb/mb0dENzQvce6yXE9ygRkAU6/osKaF3TEYw
         nDK0yB+T1zILn9rNs/jmiSKmE8Q2IRZFsd4fqth92KqsjdkwbhwGIuiIxPK1ruD2SP51
         wEvCcLuhx4TaZAG2hpo7lzvHHx/6m9rbd33PECRrm6GigPsDLpLTi3npiuyrmTiYcRvE
         fViUQhTlCRmzOkkg/Z/sl/v/WUSbAy32yOkZLotM0LEObfUTJgyDvnd1a4UeFAbhS45J
         RXhrUnp0FiidKU4Ah1mDXrAzJUSzvW4f822Yk4zdrynzsPcDiAaTDbmPFp1QpX1C7gAK
         1sJw==
X-Gm-Message-State: AOJu0YwQb7nSmnCmtcdlGqHK8mCSIABqmXQMbHrCTk1fxg7RGHu74fMX
	wibE2vwd7r+w8uWqu7yODhr7/VXUZgILsgPe+fwYxtvc/qP5lRh9HiX3xStR1bzPoagyu9DKnyI
	G
X-Google-Smtp-Source: AGHT+IFnOq5LcL8SxElf2qe4Jc4tBlAbmrAfwpK05k7Cpi4nMiEBPJxEnoJg344gra/exQhb5LLHig==
X-Received: by 2002:a05:622a:1111:b0:43a:b531:5e88 with SMTP id d75a77b69052e-43f9e172db8mr63707151cf.68.1716482291329;
        Thu, 23 May 2024 09:38:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e046467a4sm169848981cf.83.2024.05.23.09.38.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:10 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 3/8] midx-write.c: pass `start_pack` to `get_sorted_entries()`
Message-ID: <7acf4557dcb2240cb43eadebfd21b5c37515ba7f.1716482279.git.me@ttaylorr.com>
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

The function `get_sorted_entries()` is broadly responsible for
building an array of the objects to be written into a MIDX based on the
provided list of packs.

If we have loaded an existing MIDX, however, we may not use all of its
packs, despite loading them into the ctx->info array.

The existing implementation simply skips past the first
ctx->m->num_packs (if ctx->m is non-NULL, indicating that we loaded an
existing MIDX). Future changes (outside the scope of this patch series)
to the MIDX code will require us to skip *at most* that number[^1].

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
index ad32e8953d..cf7e391b6e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -299,13 +299,13 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static struct pack_midx_entry *get_sorted_entries(struct write_midx_context *ctx)
+static struct pack_midx_entry *get_sorted_entries(struct write_midx_context *ctx,
+						  uint32_t start_pack)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
 	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
 	struct pack_midx_entry *deduplicated_entries = NULL;
-	uint32_t start_pack = ctx->m ? ctx->m->num_packs : 0;
 
 	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++)
 		total_objects = st_add(total_objects,
@@ -886,7 +886,7 @@ static int write_midx_internal(const char *object_dir,
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
-	uint32_t i;
+	uint32_t i, start_pack;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
@@ -954,6 +954,8 @@ static int write_midx_internal(const char *object_dir,
 		}
 	}
 
+	start_pack = ctx.nr;
+
 	ctx.pack_paths_checked = 0;
 	if (flags & MIDX_PROGRESS)
 		ctx.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
@@ -1051,7 +1053,7 @@ static int write_midx_internal(const char *object_dir,
 		}
 	}
 
-	ctx.entries = get_sorted_entries(&ctx);
+	ctx.entries = get_sorted_entries(&ctx, start_pack);
 
 	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
-- 
2.45.1.217.g9bb58e2bf5a.dirty


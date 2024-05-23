Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A341B7FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482291; cv=none; b=QJYcZXR3YbXW/3bM51eaSBWgCU1kIU24wFqgTOLJ9BZJFB6HXemGnraT1jxv9L/IdMU6j425ZTgG3EAH03vJYfFcuOVsJpb/phhNMcVnRUVtSHNxPhLSlxV+pnKmX9mI2yDN+sLYjzvXoR4hO7ppFG1apklNPgpnXcRY5lbU2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482291; c=relaxed/simple;
	bh=ZyceiAae5RU+OvI+I3CaLTBJM5AnmJq38BTdXfF/N1M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzQZzKnBSUQI/ioEc2gksDoDXoEwUelrhOFj8ImrjQsjwQoh+2J1NT0fJjIMb+B3qzUnmjyGoqfzQGltJAoFkQTIXNfGxvPoVf9cONtdfGjTSSSK3aQlfhlwSFfZyF7Ycvxvj0OrAFkwX1jAA1Cnj8BpSWzD+U7/dM4eU1+/keI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PUZHBIvk; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PUZHBIvk"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b782287f9so11963476d6.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482288; x=1717087088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vuq7/weQdgsrPaJmu+zeXqY9YtNhcV5N63jj8imtUjI=;
        b=PUZHBIvksSlyGtwuGP7s9ejmyXt4kxvbprJlFqrYfW00CZZgoajyPJZoMXxFKV+004
         KXKG8d8FJILafhBcjJo1RFWXhJpgGpt6tZgbKjGkBf1fJUW1KOycOrdssi3oFH4LBTPL
         Euwk155k8xWFz6r1iUavuvf6BE402TEDewVbaFvC3nv4TNCEo+0y0awih6U0hdX+s10C
         qOc9SG1wH8W7WdN484I4YKaY1gnq9Rv0nGdV5vm7ZG2T6dtMb2KXxFGtUplrohAeHuQ3
         4DWZ0voN2/Qm6goObeiaLGMOjiMYGnm9xbcnDHllGnFnqJcGbKJA7rdFf4kiuOngnQy8
         ssJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482288; x=1717087088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuq7/weQdgsrPaJmu+zeXqY9YtNhcV5N63jj8imtUjI=;
        b=eV2LOKQ+hz28qR6UqTGkZtDAWb/ogBmLt5qMH0sQ/JRkP/G7CLolrxp/ZIa+ydEq7z
         qZgIJJK95Smmsmvoo8oAcudn0BuKZmOo25k1wTD0CCJRnhsEL6+QwqsGSL5azQGn2Lx+
         a3d+AHLfxWxpZxGdRZJ95pw5cBW5NhVZ+3kddK0tn5sdHADnsfZvxecrkpqrHfT5YtTD
         BojO/Juu4EWq5jEbUgO0E/oCiNlO0ExpSNw0HhV4EzHdeGcdr7bHLcDLZhF4Dc0PoJ09
         qcXaEXajEXhBioBAemrKwBqxn03+opN2yGxsnK5eiQsqFfVQublM4J2q3YJP9X7EQtQL
         tZrw==
X-Gm-Message-State: AOJu0YzfuinPtIEU3bB1hsC9BhknDC/i4dCxlhkzi5VqEoq3PCEp6i9y
	fdW/qr5sFKpuR0O/N/f/r+Vj0h5yWO029H7ZCsx9hp2Z0AleCCmbs7SS5mfntEtzGzEwaQgkXGZ
	m
X-Google-Smtp-Source: AGHT+IG3KN9kRLGk/mUywVRDeRUQQfL1ujLRNWYGWhmUh3+iHwa5MkGQoSvbrRRtpu107mJ+21WcXw==
X-Received: by 2002:a05:6214:5d86:b0:6ab:97af:9aa6 with SMTP id 6a1803df08f44-6ab97af9be4mr14628926d6.8.1716482288162;
        Thu, 23 May 2024 09:38:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f17966fsm144331786d6.23.2024.05.23.09.38.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:07 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 2/8] midx-write.c: reduce argument count for
 `get_sorted_entries()`
Message-ID: <07dad5a5812794be6e355b1e0eb3722d452f292b.1716482279.git.me@ttaylorr.com>
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

The function `midx-write.c::get_sorted_entries()` is responsible for
constructing the array of OIDs from a given list of packs which will
comprise the MIDX being written.

The singular call-site for this function looks something like:

    ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr,
                                     &ctx.entries_nr,
                                     ctx.preferred_pack_idx);

This function has five formal arguments, all of which are members of the
shared `struct write_midx_context` used to track various pieces of
information about the MIDX being written.

The function `get_sorted_entries()` dates back to fe1ed56f5e4 (midx:
sort and deduplicate objects from packfiles, 2018-07-12), which came
shortly after 396f257018a (multi-pack-index: read packfile list,
2018-07-12). The latter patch introduced the `pack_list` structure,
which was a precursor to the structure we now know as
`write_midx_context` (c.f. 577dc49696a (midx: rename pack_info to
write_midx_context, 2021-02-18)).

At the time, `get_sorted_entries()` likely could have used the pack_list
structure introduced earlier in 396f257018a, but understandably did not
since the structure only contained three fields (only two of which were
relevant to `get_sorted_entries()`) at the time.

Simplify the declaration of this function by taking a single pointer to
the whole `struct write_midx_context` instead of various members within
it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 03e95ae821..ad32e8953d 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -299,21 +299,17 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
  * Copy only the de-duplicated entries (selected by most-recent modified time
  * of a packfile containing the object).
  */
-static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
-						  struct pack_info *info,
-						  uint32_t nr_packs,
-						  size_t *nr_objects,
-						  int preferred_pack)
+static struct pack_midx_entry *get_sorted_entries(struct write_midx_context *ctx)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
 	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
 	struct pack_midx_entry *deduplicated_entries = NULL;
-	uint32_t start_pack = m ? m->num_packs : 0;
+	uint32_t start_pack = ctx->m ? ctx->m->num_packs : 0;
 
-	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++)
+	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++)
 		total_objects = st_add(total_objects,
-				       info[cur_pack].p->num_objects);
+				       ctx->info[cur_pack].p->num_objects);
 
 	/*
 	 * As we de-duplicate by fanout value, we expect the fanout
@@ -324,25 +320,25 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 
 	ALLOC_ARRAY(fanout.entries, fanout.alloc);
 	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
-	*nr_objects = 0;
+	ctx->entries_nr = 0;
 
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (m)
-			midx_fanout_add_midx_fanout(&fanout, m, cur_fanout,
-						    preferred_pack);
+		if (ctx->m)
+			midx_fanout_add_midx_fanout(&fanout, ctx->m, cur_fanout,
+						    ctx->preferred_pack_idx);
 
-		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
-			int preferred = cur_pack == preferred_pack;
+		for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++) {
+			int preferred = cur_pack == ctx->preferred_pack_idx;
 			midx_fanout_add_pack_fanout(&fanout,
-						    info, cur_pack,
+						    ctx->info, cur_pack,
 						    preferred, cur_fanout);
 		}
 
-		if (-1 < preferred_pack && preferred_pack < start_pack)
-			midx_fanout_add_pack_fanout(&fanout, info,
-						    preferred_pack, 1,
+		if (-1 < ctx->preferred_pack_idx && ctx->preferred_pack_idx < start_pack)
+			midx_fanout_add_pack_fanout(&fanout, ctx->info,
+						    ctx->preferred_pack_idx, 1,
 						    cur_fanout);
 
 		midx_fanout_sort(&fanout);
@@ -356,12 +352,12 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						&fanout.entries[cur_object].oid))
 				continue;
 
-			ALLOC_GROW(deduplicated_entries, st_add(*nr_objects, 1),
+			ALLOC_GROW(deduplicated_entries, st_add(ctx->entries_nr, 1),
 				   alloc_objects);
-			memcpy(&deduplicated_entries[*nr_objects],
+			memcpy(&deduplicated_entries[ctx->entries_nr],
 			       &fanout.entries[cur_object],
 			       sizeof(struct pack_midx_entry));
-			(*nr_objects)++;
+			ctx->entries_nr++;
 		}
 	}
 
@@ -1055,8 +1051,7 @@ static int write_midx_internal(const char *object_dir,
 		}
 	}
 
-	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
-					 ctx.preferred_pack_idx);
+	ctx.entries = get_sorted_entries(&ctx);
 
 	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
-- 
2.45.1.217.g9bb58e2bf5a.dirty


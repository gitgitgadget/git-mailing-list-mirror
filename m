Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F061E5B90
	for <git@vger.kernel.org>; Tue, 13 May 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158450; cv=none; b=uS6bhWV7ahM0eYDdWOPHOgyK/dO2BWlYU62CgXdzmbWi4E7PBr0Z2K53wfnWFXDG3/Co7YXn7Vh4Cx8SMMV7VgQgu8nqojgjWePXYxDziwlTR78U99ndSSq5iw31bViQ3bTIKW8rpvFvQvWze31T9jgCqmJW07h5lU/dVQFpJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158450; c=relaxed/simple;
	bh=j3I4i/JzCUDRhCWvMXUkgPFqi+ZBtbks/tPrhe1A/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuLY9EaHL0zzzpvXpjSZSc4iZm/MqTMIYQSZUcOi+QNCd3/7C/hqBjJQw9skovTGj4hV/O6qSaV4dAVr54zuifgxJtkWB1W2DO3yyp4Ps4TDneMjRXa74nLlu+vrfsQXHTQNDq1uYmO0oQYKbMLT1TZADBOTrfYskMclY9U8PNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RIw5wjDE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RIw5wjDE"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4811fca8658so80758831cf.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747158447; x=1747763247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kSVpi8xt+Il+O2wbovvYPDgqGB6PecpAAH7nneR2GH8=;
        b=RIw5wjDE0MfoW+vC82NqS0bQsziL1WsLFhz/br4QbEEdTg+jI23LmhGqhGo/iEn1Ce
         V+jFv1/gQxbUypR98ayXbU0Otm6w0Gi3ORqhlOie1sB9Y36cl+JgCueznsV/G83sILXa
         I3bjpVSkBRM/lfjJo7fwgBuSztzqIwXhExmFNJtI+cqep19otAHwVpBdFz7EPXFiUXCx
         Ox4VzpvRqfNaUaOk19F2yN5mnjahnrDZSdierYju78lMdNIr8hl/znHMtOd0HOx4yPA9
         qG6PC+2CDYD6diu37QUCfSSU+6F24AT6oFgvl3VoMFx0Es2Je6Aaf3OIIHXZ/4hT/vgH
         MPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747158447; x=1747763247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSVpi8xt+Il+O2wbovvYPDgqGB6PecpAAH7nneR2GH8=;
        b=cP6uoyuIF9Dq2sfr1Qi36nmc1qWfoXEFJOUAumgnx8VQEJFKRpD86LvuM9MdQldUXq
         bieuOwjDkq4GtmP03UJ0WzWpD4u/e3ihidy7mrmi1DNOlhHritwx/rceJML59EraJi5u
         IHBPLL19nrMwp7E5B7BjkPtN17CcCTroojDsf4m2I/gBJovHNGVAK21tfwlhSlWQu663
         lk4td276JZY3fomwG1LkDPeqD4OEuFChK2tizygHbzg9AyOSe6YsnFT0D6UYo5VlWt3n
         z9DazlrtYkLOlOU9rlJdNddzCsC8lEYshe8t38r9dMRCY8bcVGn6ZWFq9vt9rS+0zvge
         YA3w==
X-Forwarded-Encrypted: i=1; AJvYcCW35r0HJdSUKmWUcE0hbxMl1wdlcB0PxNRoO3lAxhdpMgzNcj/DTcGwIjPVM2bwUjndF90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hF7nyJSsVRkuND98ZWeQSDK8qhFipX1xGCz/wqUwvfoIs/bC
	SSlqSiGXRdzfrmLMjsBLtYFpTPLRU4YwHdXp3gNZOddDWd3P/QeGcFeWVkg4jXfvNHUdaoTHtPf
	9
X-Gm-Gg: ASbGncuBg8NSDCNVfl2/5Umq5fs3kg1FF6oCvv5jqGPdDBEvCjqrdCg3J6l2CmAJTZ0
	N8pz1v9/a8kqEgDIK6qHJEp2wWrenTnfkIu3X4cDMGCuEU62khMSveKdFE5PC77II5MCHjsQlOx
	Unix1RkaK7h/XC07Wv7sCh94Nko+2B1cnIRRW1+WoRJNEgA4eGdJPNOj/R+q4ftsANIQP2hzWEw
	/cz+htO1rNAbkPUBeoCGsxuTjdgSOT+o+9JvSOSqYRg/Ndn0kKHpSTYmyCW5reXmNle5K3oWOkB
	sztwW7trHhg0cSOJTH5Was2A7TRf8OMszYNz8BA6SHjfJ7RUUfoU6hXVrCzUd0t3YqpZo9xTZNG
	P0OVPMLD4gvl55z5AiWS9RHE=
X-Google-Smtp-Source: AGHT+IFnTXaEGXas3zslYFATh36AhktfCtfKxychmrbsbqqR9eiVoUyjjXYtVik15v66VzPIjhWcQQ==
X-Received: by 2002:a05:622a:994:b0:490:8cc3:d111 with SMTP id d75a77b69052e-49495cf8257mr6026441cf.27.1747158447069;
        Tue, 13 May 2025 10:47:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49452583e88sm67793911cf.63.2025.05.13.10.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 10:47:26 -0700 (PDT)
Date: Tue, 13 May 2025 13:47:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
 failed
Message-ID: <aCOFqYdnPp1Lne4Y@nand.local>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <20250512131315.GD1191360@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512131315.GD1191360@coredump.intra.peff.net>

On Mon, May 12, 2025 at 09:13:15AM -0400, Jeff King wrote:
> On Mon, May 12, 2025 at 12:22:10PM +0000, Lidong Yan via GitGitGadget wrote:
>
> > From: Lidong Yan <502024330056@smail.nju.edu.cn>
> >
> > In pack-bitmap.c:load_bitmap_entries_v1, the function `read_bitmap_1`
> > allocates a bitmap and reads index data into it. However, if any of
> > the validation checks following the allocation fail, the allocated bitmap
> > is not freed, resulting in a memory leak. To avoid this, the validation
> > checks should be performed before the bitmap is allocated.
>
> Thanks, this looks correct to me.

It looks correct to me as well, and is a strict improvement. But I think
there is a leak outside of this function as well that is not touched by
this patch.

> > @@ -388,10 +388,6 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
> >  			return error(_("corrupt ewah bitmap: commit index %u out of range"),
> >  				     (unsigned)commit_idx_pos);
> >
> > -		bitmap = read_bitmap_1(index);
> > -		if (!bitmap)
> > -			return -1;
> > -
> >  		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
> >  			return error(_("corrupted bitmap pack index"));
>
> I noticed that this code is also within a loop, so we could still return
> early on the next loop iteration. But by that point we will have called
> store_bitmap() on the result, so we only have to worry about leaking the
> bitmap from the current loop iteration.

That's right, though I think there is still a leak here.

After going through the "failed" label, load_bitmap() will return -1,
and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
will then call free_bitmap_index().

That function would have done:

    struct stored_bitmap *sb;
    kh_foreach_value(b->bitmaps, sb {
      ewah_pool_free(sb->root);
      free(sb);
    });

, but won't since load_bitmap() already called kh_destroy_oid_map() and
NULL'd the "bitmaps" pointer from within its "failed" label.

So I think if you got part of the way through loading bitmap entries and
then failed, you would leak all of the previous entries that you were
able to load successfully.

I suspect the fix looks something like:

--- 8< ---
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5299f49d59..7f28532a69 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -631,41 +631,28 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 	bitmap_git->ext_index.positions = kh_init_oid_pos();

 	if (load_reverse_index(r, bitmap_git))
-		goto failed;
+		return -1;

 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
-		goto failed;
+		return -1;

 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
-		goto failed;
+		return -1;

 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
 		if (load_bitmap(r, bitmap_git->base, 1) < 0)
-			goto failed;
+			return -1;
 	}

 	if (!recursing)
 		load_all_type_bitmaps(bitmap_git);

 	return 0;
-
-failed:
-	munmap(bitmap_git->map, bitmap_git->map_size);
-	bitmap_git->map = NULL;
-	bitmap_git->map_size = 0;
-
-	kh_destroy_oid_map(bitmap_git->bitmaps);
-	bitmap_git->bitmaps = NULL;
-
-	kh_destroy_oid_pos(bitmap_git->ext_index.positions);
-	bitmap_git->ext_index.positions = NULL;
-
-	return -1;
 }

 static int open_pack_bitmap(struct repository *r,
--- >8 ---

, since all callers of load_bitmap() will themselves call
free_bitmap_index(), so there is no need for us to open-code a portion
of that function's implementation ourselves.

Thanks,
Taylor

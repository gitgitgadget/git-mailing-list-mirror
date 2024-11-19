Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7F1C1F0B
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732057709; cv=none; b=g/b9/1ofphJwiexqcP8/C9zBjnZOCmzVDvIUfOSKy6l+IiRZ39H/yNEN43tp3s+VzvXN1iRBeAtts/7uoAPRzJXTYzfWCTOrwHJ2BHWuyo6FgSU2qIGAd0ACsnz7mr4IwKQZ4rAX8UKwA+9Mui+fOaOaPquMAUhvsLPiukD3QTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732057709; c=relaxed/simple;
	bh=nXI1J2SWlK+dY2SD9JHfKPrIcDhEFOu+YQvc1JtsYGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpF9V9EA0X28Do6A85DjtBEHjoKap0Wgy+sAYvmf48X/bnxoLQuQ/NIgw/rr2jaA/4CTDRG62TKSBTHQf2l+NJqXD50dZa4jQGfocRQuti7ckdW7yvgzKcNkfONBUs8HG7CsVzmnvdlXu/C9WYokjeZ6R53zMJaMwIOijecbvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lzGF3fvp; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lzGF3fvp"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee8e894deeso26499107b3.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732057706; x=1732662506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uo9ZoOglYF1fSw48XzTlvIIiCnfJahwSlkIpc5JIK+U=;
        b=lzGF3fvpU3G7ltV7yWSsf5EFn6Zmr3CRZjhHT7KSiUEsfG1KoUkF6SkZ9t9E8cZUsR
         lUNy4gecKWOthcXr+A5T8NCvEQtzy7mFLCr9wkPvz2DvyNW1bUxdMv3rZC5bh8px/ArP
         giNXYE4aNrf0Fxr08an9zj4vwH3m3mysygBreoO53Xbs/IbP/OFK0Ezq41JyXh0fXLdC
         H5YZFR5obUG9xXsmUEHZqG766A+gh6F99B8+S+kub3NwF4PRKQmJmlr3WQt0YXTl2At0
         rXJRL2FaqQVuu+vIYEAePkczWTlrW7zwj4EUzEkF6ZcpZRR86jD05Fqzkv8YGDDD5Z7b
         c1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732057706; x=1732662506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo9ZoOglYF1fSw48XzTlvIIiCnfJahwSlkIpc5JIK+U=;
        b=UskeKK1VQ1ox2Zb7a0nHh0Xbf08Ym9NEMRhw3+AbzFiGeKmxP2ftLducTZU81FZNwM
         wF/vBxA63ZS2BHr2vryejeW97HLco3Qg/W6CSdrgWEsqPssLSJk4t8bXPcKetuMC1vpR
         fg3JlTlrgCv1jKoW1Xav6opuTTr49FSfvVpCVEyVZLzxlelQLmN6rPoP/AbQZFbTuwcF
         ocXIqU6ASxUl4Zsb2RTav1QZd6+yzxXU4HeVrvkrNEoIT51lzYkdYzPWqdzCNUlQozum
         aO7erDXqvYwFQHR50p7OTONzEDWOD3NJaUv/YmExZ+TUC0F5LDxJlIyANWdYQtluVJLO
         AuFg==
X-Gm-Message-State: AOJu0Yy9BM6uIZCU4v+bUGxOaMK8Zyi7Ba6WlG/GhmdT1/wAfsXpXlbE
	G4vSp9M4hdtUpM7Og9fESpWml0KX9NQfKQh24Qvm5mZ6a+e5rpKlJwnWmIodV1klKOw0unAc6XY
	7
X-Google-Smtp-Source: AGHT+IEZcXkz3IXLoEJbwVX5EjAhls13dFrmoIIAgw2hiXypDu/vVlnCT2W+QJ6Jjv6MjTuCnaUhng==
X-Received: by 2002:a05:690c:a94:b0:6e5:a8ce:dd0a with SMTP id 00721157ae682-6eebd2b0d40mr9810667b3.35.1732057706595;
        Tue, 19 Nov 2024 15:08:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7137f306sm19548387b3.123.2024.11.19.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 15:08:26 -0800 (PST)
Date: Tue, 19 Nov 2024 18:08:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <Zz0aaPdHiFyoRkKg@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <20241011083838.GI18010@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011083838.GI18010@coredump.intra.peff.net>

On Fri, Oct 11, 2024 at 04:38:38AM -0400, Jeff King wrote:
> On Wed, Oct 09, 2024 at 04:30:52PM -0400, Taylor Blau wrote:
>
> > The first optimization (cross-pack deltas) should help clones and
> > fetches, but the second optimization (thin deltas) will only help
> > fetches, since the 'haves' bitmap will necessarily be empty for
> > clones.
> >
> > Of course, REF_DELTAs have a less compact representation than
> > OFS_DELTAs, so the resulting packs will trade off some CPU time for a
> > slightly larger pack. But we're only talking about a handful of extra
> > bytes, and network bandwidth is pretty cheap, so I think the
> > optimization is worthwhile here too.
>
> It would be nice to see some numbers, even simulated ones from t/perf.
> Of course we'd like to show off any reduced server CPU for generating a
> fetch response. But I'd also like to see if the extra steps to find the
> cross-pack bases have any measurable negative effect (so the ideal there
> would be a big midx repo that doesn't have a lot of those bases, as it
> would not be helped much by the optimization and would be hurt by the
> time spent trying to apply it).

I put together some loose numbers for this, and there is a definite
measurable slowdown imposed by this series.

The setup is getting a fresh copy of the kernel, and then repacking it
with:

    $ git repack -da --cruft --write-midx --write-bitmap-index \
        --max-pack-size 1G --max-cruft-size 1G

, which on my machine produces the following pack structure:

    $ for idx in .git/objects/pack/*.idx
      do
        echo $(basename $idx) \
          $(git show-index <$idx | wc -l)
      done | sort -rnk2
    pack-8dc61c00e623765c54cbd332f31795bad7edf142.idx 3385859
    pack-d84e88715cde55d4d1b09afb23254617a123e668.idx 2064396
    pack-cd408bebd5c02719df7621941d92415f4dbb313c.idx 1805431
    pack-b11c6ac57f5ecf338314ee59134b0d724d257494.idx 1036443
    pack-a42cc1b409940d7e38a4673bca1150d320392bf0.idx 819701
    pack-93d255a1000f438a77528907c480c06b277e225d.idx 755019
    pack-600621b90dc29c761ee168cc4237b2ff2956b0e8.idx 609754

Generating a full clone[^1] with multi-pack reuse enabled (based on the tip
of tb/multi-pack-reuse-dupfix) gives me the following timings:

    13.94s user 0.27s system 99% cpu 14.207 total
    13.93s user 0.30s system 99% cpu 14.223 total
    13.90s user 0.33s system 99% cpu 14.229 total

After applying the series, I get:

    14.94s user 0.33s system 99% cpu 15.279 total
    14.92s user 0.32s system 99% cpu 15.244 total
    14.87s user 0.40s system 99% cpu 15.280 total

Or around a ~5% slowdown. I think what's really killing us is all of the
back and forth in pack-bitmap.c::find_base_bitmap_pos(), where we have
to:

 - Find the pack-relative position of the base object given its offset.
 - Convert that pack-relative position into a lexical position (still
   relative to the source pack).
 - Convert that lexical position into an object ID.
 - Call bsearch_midx() to see if we have a copy of that object, and
   record its MIDX-relative lexical position.
 - Convert the MIDX-relative lexical position into its pseudo-pack
   position.

I think that the first four of those steps are unavoidable. But I think
we can do better on the last step if we compute a forward index from
MIDX lexical position to pseudo-pack position.

A cheap way to run that experiment is to just add a temporary field into
the MIDX to store that mapping, compute it at runtime, and then deduct
the time it took to compute that mapping (presumably you'd do it during
MIDX creation, and store it in a chunk, etc.).

Here's some code to do that:

--- 8< ---
diff --git a/midx.c b/midx.c
index ca98bfd7c64..2bd892f899c 100644
--- a/midx.c
+++ b/midx.c
@@ -988,3 +988,18 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag

 	return verify_midx_error;
 }
+
+void midx_populate_forward_index(struct multi_pack_index *m)
+{
+	uint32_t i;
+
+	ALLOC_ARRAY(m->forward_idx, m->num_objects);
+
+	trace2_region_enter("midx", "populate_forward_index", the_repository);
+
+	for (i = 0; i < m->num_objects; i++)
+		if (midx_to_pack_pos(m, i, m->forward_idx + i) < 0)
+			BUG("oops");
+
+	trace2_region_leave("midx", "populate_forward_index", the_repository);
+}
diff --git a/midx.h b/midx.h
index 42d4f8d149e..1ef755fe45b 100644
--- a/midx.h
+++ b/midx.h
@@ -65,6 +65,8 @@ struct multi_pack_index {
 	const unsigned char *chunk_revindex;
 	size_t chunk_revindex_len;

+	uint32_t *forward_idx;
+
 	struct multi_pack_index *base_midx;
 	uint32_t num_objects_in_base;
 	uint32_t num_packs_in_base;
@@ -74,6 +76,8 @@ struct multi_pack_index {
 	char object_dir[FLEX_ARRAY];
 };

+void midx_populate_forward_index(struct multi_pack_index *m);
+
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 #define MIDX_WRITE_BITMAP (1 << 2)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e8094453ca3..1eb72347c02 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2092,9 +2092,13 @@ static int find_base_bitmap_pos(struct bitmap_index *bitmap_git,
 		if (!bsearch_midx(&base_oid, bitmap_git->midx,
 				  &base_midx_pos))
 			return -1;
+#if 0
 		if (midx_to_pack_pos(bitmap_git->midx, base_midx_pos,
 				     base_bitmap_pos) < 0)
 			return -1;
+#else
+		*base_bitmap_pos = bitmap_git->midx->forward_idx[base_midx_pos];
+#endif
 	} else {
 		/*
 		 * We assume delta dependencies always point backwards.
@@ -2316,6 +2320,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	assert(result);

 	load_reverse_index(r, bitmap_git);
+	midx_populate_forward_index(bitmap_git->midx);

 	if (!bitmap_is_midx(bitmap_git) || !bitmap_git->midx->chunk_bitmapped_packs)
 		multi_pack_reuse = 0;
--- >8 ---

Then when running the same command, we get results that are quite
encouraging. The runtime jumps to 24.213 seconds, which is ~9.73 seconds
slower than the average of the baseline measurements. But it takes
~10.418 seconds on my machine to compute the forward index. So it's
really around 688ms *faster* than the baseline, despite doing a little
more work.

The fact that we can improve on the baseline rather than just meet it
suggests that implementing this forward index may have some benefit
outside of just this series.

Thanks,
Taylor

[^1]: The setup here is:

    $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in
    $ git pack-objects --stdout --delta-base-offset --use-bitmap-index --revs <in >/dev/null

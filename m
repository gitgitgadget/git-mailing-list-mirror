Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894FF1DED6C
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785952; cv=none; b=ZASgiKck5lEkTC0iYiN+fbUDxYlAcqnwIFHfWPQ0p2qk8K2MIqzFTqNFT7eYzhirmYwKj4qRoCRjpNQXAlTJcmG3G3tawRA+wIjZzbzqH1l9dj+1tRJElhnJLltTsVD7tYLgUg73H6PRfoOzHmYwN9XUYm8o2VxJVGLk7XBL60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785952; c=relaxed/simple;
	bh=5pp/nR2GFv/vNfi9RPLWo/YxS5dnOgz8h5jLEU4J46Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPBs17/sZASDdb00BFXySVkTjaSp7DSTA27PTkpGK506mfDBZpbYTLcet4flbVdRjRIN+1aPUI70MwcCFotUh6BSSZXOVHRupz0OwOzVhRh5XWWwiMQmtOwkgXzcgbpxxc6VgiZ+3EFCKeoL+XP1wCof5irC3bzLM6qwX/1kmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=v4DntNGw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v4DntNGw"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f6c90b51c3so24698997b3.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 15:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740785949; x=1741390749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkdvmcoWNBCaNDByV1YdMhIZ4wLs2SfMZAEHqFvHjHI=;
        b=v4DntNGwUTslczT/aRrS2JT/b5CIWfj6DCAIoTCPZXkdBBxg4/zXiggAJvuni7OUJi
         XLhs5H6MTGeZl3eS4oAXUQsXg4nIHPTj43VMPKSYYOVYHPkQ5LYAPInDins937mtMHxZ
         XuvRH1HZgupTqhHyS05DaeoE3OY/lLy3EKO0RLkoTJp+hcfsFDnByFShH+uLrhhRoHjn
         fXKx8x4kknUpuFcoOfnP+BsPl6YKqPHziQncFfsLAbF7SvbV05P7uBIBYOAB09UKf28x
         0+KCugN6REcTbfuP8gF7bAzMB9nhDfAXCQFIuRTQGvA3nQaLDZjzVbPQTh4X9FzjhiBV
         fT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740785949; x=1741390749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkdvmcoWNBCaNDByV1YdMhIZ4wLs2SfMZAEHqFvHjHI=;
        b=Eb4BD38MErjlfthzw/aFpb0Xob+siekJuuACQMlJ209KN9cAF8Tib2JDivI57fJJ90
         64iC29CcVAZeSrkUlUJULeNpW/jxJEQaRGj84Bdd9Sr4R2iqS6GjcIO4o+HqS4Hnmp9K
         MbtiIHysl5VDsmHIMHFlITNnQ+9W/dDC1PMkPrQDCWtyMsbWc0LJ8+02B1hEriIFOyyy
         pXRclBbXtMqrEKG/Jw/OWXzgGu9Bw/hSlJXJHo72rr7AHQy0nf5iTtJcwdZAXvtKF2hv
         kTxH3jPRfVhODkFvwedmZdWwT6lC3XeAUT9PcsLobvIxEO4a55C/rty2jJHuCZ5s8f4K
         Ik4w==
X-Gm-Message-State: AOJu0YwDqdELpl7egepYTw+2gIE9FJErnj6O3uT7ZSq+RE6niC8hsZeB
	t2c0X0IH9v1ty4QZ0ygZYFMCb5na8QZLlRm9RcU3LBmRVlXR4SL9CEKnJYCAKW4=
X-Gm-Gg: ASbGncuv4Q+eI3MZK+H8lndWezUfEFIIs5QsUhNV7Y3HCsnvCR/tLN9n8uYh5y+RBYL
	R04CK5oShtc/22Ecs1l0aQAMjAJKV7FnqnFteu3T4z3WWeU9+aUlzPW3SjBtGOHamzwqX/nky3W
	uf8PiVtTDtL4WE3O5x0spoonCABmygmPk251TgSRzzvVab3p1ndnYMmega8EWqd+1/ZWxeMD575
	bNHfrt6kS5sykmSP+I6Iu0mvqe53svZSFZZHaJzv2PGuLcM2T5OlT0/8E9Ko1c1AB0B0IHWhg+5
	horcYqWtycAiOtMkWREQ9DkqdoLBUVWREmV7zjXH7kf1Qrq6gJDniqzDGhcojev2fm1TIjWdkV8
	++KiDFyLY8VB+eekS
X-Google-Smtp-Source: AGHT+IECdLRT9y7AFOT5oyzl1gvHLrqd8uJTOi8uaSXOwSyPoifvVGUZTyzvJTqGYQ67eMxvyACiKg==
X-Received: by 2002:a05:690c:6203:b0:6f9:97f7:a5c3 with SMTP id 00721157ae682-6fd4a0932admr72180427b3.18.1740785949312;
        Fri, 28 Feb 2025 15:39:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca0f4adsm9444217b3.19.2025.02.28.15.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:39:09 -0800 (PST)
Date: Fri, 28 Feb 2025 18:39:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/13] pack-revindex: prepare for incremental MIDX
 bitmaps
Message-ID: <Z8JJG5EX1MUtGvss@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <b902513f43697e94976c1baf5598222fe2e3b847.1732054032.git.me@ttaylorr.com>
 <Z8GJaFPMQtslEEt3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJaFPMQtslEEt3@pks.im>

On Fri, Feb 28, 2025 at 11:01:12AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:22PM -0500, Taylor Blau wrote:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 4fa9dfc771a..bba9c6a905a 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -170,6 +170,15 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
> >  	return read_bitmap(index->map, index->map_size, &index->map_pos);
> >  }
> >
> > +static uint32_t bitmap_non_extended_bits(struct bitmap_index *index)
> > +{
> > +	if (index->midx) {
> > +		struct multi_pack_index *m = index->midx;
> > +		return m->num_objects + m->num_objects_in_base;
> > +	}
> > +	return index->pack->num_objects;
> > +}
> >
> >  static uint32_t bitmap_num_objects(struct bitmap_index *index)
> >  {
> >  	if (index->midx)
>
> Okay, despite counting our own objects, we also need to account for any
> objects that the MIDX layer that we depend on may refer to. I assume
> that this is basically recursive, and that the base itself would also
> account for its next layer, if any.
>
> What is interesting to see after this commit is what callsites remain
> for `bitmap_num_objects()`. Most of them are converted, but some still
> exist:
>
>   - `load_bitmap_header()`, where we use it to determine the size of the
>     hash cache. Makes sense.
>
>   - `pseudo_merge_bitmap_for_commit()`, where we use it to compute the
>     merged bitmap of a specific commit. This one feels weird to me, I
>     would have expected to use `bitmap_non_extended_bits()` here.

Great question. The reason is that this function determines a bitmap
which identifies the parents of a given commit, and that bitmap is
compared against the set of pseudo-merge commits we know about in a
given layer to determine whether or not we have a matching pseudo-merge.

I left a comment to that effect nearby since this is far from obvious
(including to me -- I had to take a few minutes to remember how all of
this works!).

>   - `filter_bitmap_blob_limit()`, where we seem to filter through the
>     bitmap of the current layer. I _think_ it makes sense to retain.
>
>   - `create_bitmap_mapping()`, which feels like it should be converted?

I *think* that this is OK because we are only remapping one layer at a
time, but I'll have to double check. I'd do so now, but I'm trying to
respond as much as I can before my week is over ;-).

> It would be nice to document in the commit message why those functions
> don't need to be converted to help guide the reader a bit.

The conversions here are case-by-case, so I lean towards documenting any
non-obvious ones inline with a brief comment (like the adjustment I made
above for pseudo_merge_bitmap_for_commit()).

> > @@ -491,7 +499,8 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
> >  	const struct midx_pack_key *key = va;
> >  	struct multi_pack_index *midx = key->midx;
> >
> > -	uint32_t versus = pack_pos_to_midx(midx, (uint32_t*)vb - (const uint32_t *)midx->revindex_data);
> > +	size_t pos = (uint32_t*)vb - (const uint32_t *)midx->revindex_data;
>
> Micronit: missing space between `uint32_t` and `*`.

Great catch, thanks!

> > +	uint32_t versus = pack_pos_to_midx(midx, pos + midx->num_objects_in_base);
> >  	uint32_t versus_pack = nth_midxed_pack_int_id(midx, versus);
> >  	off_t versus_offset;
> >
>
> Okay, the calculation to calculate the position is basically the same,
> but we now also offset the position by the number of objects in
> preceding layers. Makes sense.

Exactly.

Thanks,
Taylor

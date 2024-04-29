Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F8839FD
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420042; cv=none; b=tGonWq3jvyeSqyJY+TlH4xdeiPMdoV/vUlyieuVlHlpL6OO6z58T247eEzQfYh7Gj8nepEUhCV5D70WN+Px4bSu9TCeijMBMJtmCjVN4FE7rvxSEIwyGIMq3T/fitP1appBSB4/kukG42D5JKnXRlHypFZh6cTQMNdbxRwtt1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420042; c=relaxed/simple;
	bh=w/x+/rpIj+qq6XBa8ilsXi/m0R1tKgkkQrIbmSpezUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khmSKYPHp9EvNMaNEYMwj141m3fqi4LNA8gbNMsxnohToVqT7DH5evI/rbuOg3XdLh6A4BdCjMUt4SqqUK29PPHgGHp9S8JrOXDAcUH5BogOnQFDRKhcMhVqK08dy5LBy0T4E9OJ7zVEaAPFyz8uWwkkjHUK8nAxC91b4Ik+R8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MxsRRn6j; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MxsRRn6j"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-436ee76c3b8so38905231cf.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714420039; x=1715024839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDz4DRmoT72aQLp06EaAXtTcGmxQHO7q3pT4x1S8m4E=;
        b=MxsRRn6jhUOWEPPQwsyUr/XkKJXi+J33s/eQukS8ILyX1TuUJimJPfc0lkMqyQSMNr
         clpXfyxyZGhzLgdiAhL6t8iCNFw0EEe/0uyyCgzRop918zstQEbHIJ45+JkH1WMDZSr5
         cP1UFy78/jYTZbbSk+2S6Ft9vk+soKewSSZGcWS1XSbWblWK0fQeGSLkU5LdE+jZc/Yu
         vEs0qBHdz9YnaD6zd2y7+2kjpi8dhIF2arf6YJSniWafdzjBlbuVZL8sggJGS/KE/Xa6
         SxW+7F61ybnyVHsg1yjA/RdqDLSy9FKLvhgD3goH+v+GEoJp9xJGa2FTidRdoc6+JwT3
         sfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420039; x=1715024839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDz4DRmoT72aQLp06EaAXtTcGmxQHO7q3pT4x1S8m4E=;
        b=QjyEfqT0v2t7vlYTaeaD1wrGSLmMDVrlKHhkCELAzqu8pE3CdjThie42ccS9fQUucT
         /pKdaOmmCfk2RQdSykPUgeDmatTICBXASpePAw4qxCC0jj6rKpDXf4rgKrZP+DVT0tga
         UccyvuPLyeEgSgNwJafmKnGAWEzwFp7+D1OrOjcrLMW91KNQ6iw9CEmcMPYpUVoqsQBq
         TqvlLyCfUH7x54AL5X8Su/hx6gLZUBLkhAXnunwBsCX8z4Zdl5UzsnS2fNPRpO1UFw1w
         FxLGZ7bWghPix2Hsa6FbicqMRo7puj6Ov6Cm1HRy+2syM6tqAFU3U4NuG5zkpOjUeucz
         DMqA==
X-Gm-Message-State: AOJu0YwrYLh7seMDGsFOGK9VzbyZj1cZjG+ZbEzNrmElwP4KEVfwA4rN
	IrBK2cv+J6XqTsTEoiS8EMd5O4CC7JCulxQC3bzzwGDIXCbN5xQi0iUJ10BKfg+Gmt1Lhe7v/t3
	zOu0=
X-Google-Smtp-Source: AGHT+IEqQsORbKEPBwc7GxKzLveqdHFhySIPjH9d0pLYerJTJHSQzfbXuDTqB97t68n+ZJ8swYNgyw==
X-Received: by 2002:ac8:57c4:0:b0:43a:bee9:eb0 with SMTP id w4-20020ac857c4000000b0043abee90eb0mr6156027qta.35.1714420039605;
        Mon, 29 Apr 2024 12:47:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id kd11-20020a05622a268b00b00432bb012607sm10735785qtb.47.2024.04.29.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:47:19 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:47:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/24] ewah: implement `ewah_bitmap_is_subset()`
Message-ID: <Zi/5RWSFTFadna55@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <1347571ef4ca6329de58394bfea71927c8e08151.1710972293.git.me@ttaylorr.com>
 <20240410180505.GB2260545@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410180505.GB2260545@coredump.intra.peff.net>

On Wed, Apr 10, 2024 at 02:05:05PM -0400, Jeff King wrote:
> > This function makes use of the EWAH iterator to avoid inflating any part
> > of the EWAH bitmap after we determine it is not a subset of the non-EWAH
> > bitmap. This "fail-fast" allows us to avoid a potentially large amount
> > of wasted effort.
>
> Makes sense, as we have an expanded bitmap_is_subset() already, and this
> should be more efficient.

Yep, the idea is that we already have a deflated non-EWAH bitmap in
memory, but we're comparing it against a potentially large EWAH
compressed bitmap.

If we can determine early that the EWAH bitmap has bits that are *not*
in the non-EWAH bitmap, then we can avoid inflating a large part of the
EWAH bitmap.

> > diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> > index ac7e0af622a..5bdae3fb07b 100644
> > --- a/ewah/bitmap.c
> > +++ b/ewah/bitmap.c
> > @@ -138,6 +138,49 @@ void bitmap_or(struct bitmap *self, const struct bitmap *other)
> >  		self->words[i] |= other->words[i];
> >  }
> >
> > +int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other)
>
> It wasn't immediately obvious to me if we were checking that "other" is
> a subset of "self" or vice versa. I wonder if we could use different
> names here to make it more clear (though really it matters more in the
> declaration, not the implementation).

We check whether 'self' is a subset of 'other', but I'll document it
here for both functions.

> I think bitmap_is_subset() suffers from the same issue (and is even more
> confusing because the two have the same type!). Maybe just a header file
> comment would help?

Yeah, agreed.

> I think your use of the phrase "proper subset" is a little confusing
> here, as it is not a subset at all, let alone the distinction between a
> regular and proper one (in the mathematical definitions).

Thanks for catching, this should definitely say just "subset"
(indicating that 'self' and 'other' can have an identical set of bits in
each and self is still considered a subset of other).

> > +	/*
> > +	 * If we got to this point, there may be zero or more words
> > +	 * remaining in `self`, with no remaining words left in `other`.
> > +	 * If there are any bits set in the remaining word(s) in `self`,
> > +	 * then `self` is not a proper subset of `other`.
> > +	 */
> > +	while (ewah_iterator_next(&word, &it))
> > +		if (word)
> > +			return 0;
>
> OK, so here we keep expanding to see if there are any bits set, meaning
> we may read past a bunch of 0-words that we don't care about. I suspect
> this could be optimized to just ask the ewah "are there any bits left?"
> but I don't think we have an easy function for that. And it's not clear
> to me that it would produce measurable speedups anyway, so probably not
> worth worrying about.

Yep.

> As above, ditto on the use of "proper subset" here.

Thanks, fixed.

Thanks,
Taylor

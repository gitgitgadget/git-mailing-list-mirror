Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1823F380
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786548; cv=none; b=VWOcddzNIJ3Exxb1/INIFAXZMBypoXU/ca+aYpDvHbAkLfl0KqDOKvP3UMvT0Da4xB681GfE7jyQVwTf4tqiJnI8c9RYOJ7mFWIilSW56WKqC/2bX5TdMjmq7tLzokXO9eHVqZ6FmG0O6n9/TgcW2MU1P1UIMzCGi5EcJk3J4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786548; c=relaxed/simple;
	bh=9OuwTW1shC7qkERpfWL/LA1iwN7xZsT7jzbSQIuEr3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtG6olecboKGm8zu9zkdkEcMx+8Z61skCQfnuZWer1rFDxQuIxkeJj9QV/9BI0euBsPV/nBtAgBBLViY9lNfsX00WLBoRKAvvukInAa5HWlXDz39fBIMmX1/S34ajJY4JP9SEUdnkH7UJ8PqGSr6ffhU+hCk8pfzbVjIHzGsYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=G8DH6czO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="G8DH6czO"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd47dfe76cso17854407b3.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740786545; x=1741391345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tX1vD0RkceXWJO+zyJ4XPxwenYuMUbw1gzPULGA8NSo=;
        b=G8DH6czOwm/C75UPfkJ5HA91fbLnTxIaXQedQQjQVAJ1FEozgNmvQ4Bfq5CPvNW139
         roHKz+ilKCQ6EZnEP3ue/p9hg98uEi4om4mefn+LxVWY11Mo4KVnO5u7p5cXBJWbufEL
         I4hniJVl3L5mjCsg09GLWeaeAhL19q46AUy8vWq5ixIbGop9qdWPRfQ9FjjcigcJhjda
         EpKKVY/WDLWnjJGA0NWN0HVWRqTN+AGldy/RXU9RrePhIrlLrnKE7iEkEjWYsHJ5Dkpi
         H+l8KaiwJlJQbKcJfaZb2oS7splyPGUpDLRzhUu9oDxJ4oFonpiwLwS+hoDsITVdRJlA
         B9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786545; x=1741391345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX1vD0RkceXWJO+zyJ4XPxwenYuMUbw1gzPULGA8NSo=;
        b=lPivvrhSxgkXSGM+TeaMT9DzK8XL7AzdPwGl39PkMrr8BS7E1WV/xIddyhEeP1LLRf
         V6ERO7Poae0xz5iXqR871moLdi012R5yOWahCO6ek8KrSMX15dGRLSZqoPCr0eFSu74H
         lhzE1B/RFc18PWinsSimCcaB+jUG15W5O9JqbZwstWd0uN1YsQCEW4oPla3JyyBrwnGe
         gJ4E+w0ui+GxmjEVKlwwydXC1Kev1aJxaudSZqD36+qp7VGvCtF8+614YA7sh5Vx0BCd
         oZ7K8z37+rJBqE/WbD1FjmvY+GCykfGh6RUSpYIB0ToNpo5LRjSOOli9mgeqWpmxwzvL
         a7qQ==
X-Gm-Message-State: AOJu0YxBXyJvOlpabed5AcDgPeWQfQlo9BsAf2mnyw0a7xFvIrPZory1
	hOvc5P8e0+s8Qv1svNH/s+aW6yyZV2Vgg+/lt++a16iHhsYQLd32SXvH0oryGIfv4iXbd5jnjXd
	d
X-Gm-Gg: ASbGnctmpa7LLbbFYYiHBrISnqiGC+ov4Qv4StIMIuM6rr7l6d6sdfdCFKTH8Sstr4g
	hy567mBaRRmHgaasbm7fleyJ3DPeTKJ+lCpBXvbzKcY/maJpbYYX1rSbPDKgZ7AxMbsaBLqxpxu
	hcKvDlXxlDmRaJPBzKpl04h/6Es6dhyqRhhp52qmUw9B7jxRTy8DePueSBd+MF5eszJrrKlorxA
	qTpLhkSBaU5R8bm25JuMCUwrG9ZvTnVVmSrfLjjmY2dfzst+774f7TMOZ/oIrJbaBWBI/7FoRv5
	ysEfZbGXaPya7NJOdMjgWY0ahqdPeT24dNYQ/uYavLLJA3Tjn9seF7Jlzg2SrmRGNcRuNk7e7un
	Pb3MO6U6gm0/770zN
X-Google-Smtp-Source: AGHT+IE0tzKYiTp95Apzk5rqMFrnbAG6xcd1408p5/cwP0BRjP60i2uXoLSwmqo344tq2F7a6Xl4PA==
X-Received: by 2002:a05:690c:3387:b0:6f7:ae31:fdf with SMTP id 00721157ae682-6fd4a067df4mr64046357b3.12.1740786545300;
        Fri, 28 Feb 2025 15:49:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca633casm9502207b3.53.2025.02.28.15.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:49:05 -0800 (PST)
Date: Fri, 28 Feb 2025 18:49:03 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/13] pack-bitmap.c: open and store incremental
 bitmap layers
Message-ID: <Z8JLbxBQh7XUpplz@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <5b5d625cbe02560a20c12b7dd20aeda4979017bb.1732054032.git.me@ttaylorr.com>
 <Z8GJbOoY9Z3VMSEM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJbOoY9Z3VMSEM@pks.im>

On Fri, Feb 28, 2025 at 11:01:16AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:26PM -0500, Taylor Blau wrote:
> > Prepare the pack-bitmap machinery to work with incremental MIDXs by
> > adding a new "base" field to keep track of the bitmap index associated
> > with the previous MIDX layer.
> >
> > The changes in this commit are mostly boilerplate to open the correct
> > bitmap(s), add them to the chain bitmap layers along the "base" pointer,
>
> s/bitmap layers/of &/
>
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index bba9c6a905a..41675a69f68 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -54,6 +54,13 @@ struct bitmap_index {
> >  	struct packed_git *pack;
> >  	struct multi_pack_index *midx;
> >
> > +	/*
> > +	 * If using a multi-pack index chain, 'base' points to the
> > +	 * bitmap index corresponding to this bitmap's midx->base_midx.
> > +	 */
> > +	struct bitmap_index *base;
> > +	uint32_t base_nr;
> > +
>
> It would be nice to point out that `base_nr` is not 0-indexed, but
> 1-indexed, which is rather uncommon. Is there any particular reason why
> you made it 1-indexed?

Hah, I have no idea! If I remember correctly, it's because it makes it
(slightly) more convenient to do:

    ewah_or_iterator_init(it, bitmap_git->commits_all,
                          bitmap_git->base_nr);

, instead of incrementing 'base_nr' by 1 to determine the number of
sub-iterators to allocate.

So I think there are a couple of options here. Short of doing nothing,
we could:

 1. Rename 'base_nr' to 'layers_nr' which would make it clearer that the
    count includes the current layer, thus making it 1-indexed.

 2. Leave 'base_nr' named as-is, but make it 0-indexed, and have callers add
    1 when they need to know the number of layers.

I prefer the explicitness of (2), which is how I adjusted things
locally. But if you prefer (1) or some yet-unknown (3), I'm happy to
adjust it further!

> > @@ -397,10 +409,17 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> >  {
> >  	struct stat st;
> >  	char *bitmap_name = midx_bitmap_filename(midx);
> > -	int fd = git_open(bitmap_name);
> > +	int fd;
> >  	uint32_t i, preferred_pack;
> >  	struct packed_git *preferred;
> >
> > +	fd = git_open(bitmap_name);
> > +	if (fd < 0 && errno == ENOENT) {
> > +		FREE_AND_NULL(bitmap_name);
> > +		bitmap_name = midx_bitmap_filename(midx);
> > +		fd = git_open(bitmap_name);
> > +	}
> > +
>
> Wait, this looks weird to me. `bitmap_name` already contains the result
> of `midx_bitmap_filename()`, so you're essentially retrying the exact
> same operation as before?

Hmm. I have no idea, but you're exactly right. I dropped it from my
local copy.

Thanks,
Taylor

Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4D13B7BC
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215159; cv=none; b=QGElkZdJAr642B9Dpi/rPmEWQp+SJll4+YVcQswe8BlHmB/M8h+wzIvtcuXJyM4kxIK+0KgLb1mcdEkcls5XAA1gKr/Ok4bAomy1wmfG8IzkVdLxjgj5/itiWUr9DVtG8DW2v0T4Y64m+wEdY6SSAyD8CLuPWCaWgbJ+s4mC2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215159; c=relaxed/simple;
	bh=mJC5DQI0hEqFUHoiRKT+Ey78W+3P/DLwymIzi4c/O8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5yyixipeag90qKYiVRlB/UgZvuWmGCayULZg/Indk6EJbgXUKqIBF/0BHQasfCwNyIpBUB7VF+DQcQE90vfN4MNI0B71J3O4fvM2uHWC4NUhcrGe4a/6vSGaLURIBIdW2a26QYXrnWlULgfE7S89QqW6yhHId6YSvwox+FAQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oDMQz37G; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oDMQz37G"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2226b9f246so4933560276.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727215156; x=1727819956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBu0qD3yNx2iv5ViqfWIqtiNTzGbK1iH1b5P6ok1O8Y=;
        b=oDMQz37GdvzsVMpNJt/CtVPyT9EZ5LF2yKy0wpT8W2lTrx7Aob1kTliy2abSv4W9co
         Y9HeIlSv5IFk+H5OGQQJAHLQ6r9OFm/xOnCwoy3nR4L5pLp6275yDp+KZ6FUZXnB0WFj
         zFSpoEccnSbllZgOoi5TMAxWK+zoRCjW7jpMIgrWHqLDBKjW98zB9WOP+Ur1ho2gza/U
         lrEvpOJQyicG+DPp3EcpLk6l800Gzje9t8dn+lZ0hiZAdbT3dOHQs08sYeGKC0NZraQC
         MdhwpDjMRJZQp0dx2bC+Wn/zBj0iX9EmPM00fgBUxHCtd2+A/ufzL+vI9TjL9SK/LR4T
         Lq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215156; x=1727819956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBu0qD3yNx2iv5ViqfWIqtiNTzGbK1iH1b5P6ok1O8Y=;
        b=DbZxRaIiNsQ/ot8hi32ue8dZrx7FsnPpCItKTqZfdwZFyQ90AnI893DdsRtLvwQXl9
         NRYH/TEegJcW2/aIZF7+y1FRTJ3NrZU3f6BlR0wun7ucYsEOo39PyBHCX0xu0KhtSFAR
         S29DKTLaCiZjwY6AVhdZTIvOX5opdLzibuFz9nQVgW6VfbtRMFXSfIEav+NUtdzXOZXy
         6r02CzCd1EvC/G3GspDPVVlGyVo9zCVT0UbaiwTlvh8oN+j2GEWcY3NInFaKVnqFpCUi
         4lb9h6qkOlAdm18lpB5RwcYCCR2hZK9z+LpH8zKCOJJfMGRJA00jXLtsW4uFkL89pjgu
         IyZA==
X-Gm-Message-State: AOJu0YxnWXn70lIULI2qlwcCYjaRitMHahUs1zrT+ZUuqbejgm52+Ype
	uM9ojWKiDUZNFOnN0w8JWp9hqBa5RdN3HHwPycUErPsFcPHigvs/Wy9lXpFq8dk=
X-Google-Smtp-Source: AGHT+IFZYy17zm9AhrTFDSZaQeMpkpqQzOfFEq0ylJfN6uNSB6wy//WPrPo8QRS/izXaotS7L9MbDw==
X-Received: by 2002:a05:6902:2483:b0:e13:eb67:6a62 with SMTP id 3f1490d57ef6-e24d85abbcfmr635597276.26.1727215155874;
        Tue, 24 Sep 2024 14:59:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2499c6203csm398609276.49.2024.09.24.14.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:59:15 -0700 (PDT)
Date: Tue, 24 Sep 2024 17:59:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] finalize_object_file(): implement collision check
Message-ID: <ZvM2Lkb0/LPrqizO@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
 <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
 <20240924203718.GA586150@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924203718.GA586150@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 04:37:18PM -0400, Jeff King wrote:
> But I think we can expand the argument a bit. I don't think this is a
> very good place for such a collision check, because race conditions
> aside, we'll already have bailed long before! When we do a write via
> write_object_file(), for example, we'll hit the freshen paths that
> assume the contents are identical, and skip the write (and thus this
> finalize) entirely.
>
> So if you want a collision check, we have to do it at a much higher
> level. And indeed we do: index-pack already implements such a check
> (through the confusingly named "check_collison" function). I don't think
> unpack-objects does so (it looks like it just feeds the result to
> write_object_file(), which does the freshening thing).
>
> So the argument I'd make here is more like: this is the wrong place to
> do it.

I think that is reasonable, and I agree with your reasoning here. I'm
happy to reword the commit message if you think doing so would be
useful, or drop the paragraph entirely if you think it's just confusing.

Let me know what you think, I'm happy to do whatever here, reroll or not
:-).

>   Side thoughts on collision checks:
>
>     I think index-pack is safe in the sense that it will always prefer
>     on-disk copies and will complain if it sees a collision.
>     unpack-objects is not, nor are regular in-repo writes (which
>     normally cannot be triggered by remote, but on forges that do
>     merges, etc, that's not always true). Both of the latter are also
>     subject to races, where a simultaneous collision might let the
>     attacker win.

Yup.

>     That race is kind of moot in a world where anybody can push to a
>     fork of a repo that ends up in the same shared location (so they can
>     actually win and become the "on disk" copy), and we're relying on
>     sha1dc for protection there. That's specific to certain forges, but
>     they do represent a lot of Git use.
>
>     In general, the use of unpack-objects versus index-pack is up to the
>     attacker (based on pack size). So I think it would be nice if
>     unpack-objects did the collision check. Even if the attacker beats
>     you to writing the object, it would be nice to see "holy crap, there
>     was a collision" instead of just silently throwing your pushed
>     object away.

Right, I agree that unpack-objects definitely should do the collision
check here. And indeed, that is the case, since that code (which all is
directly implemented in the builtin) uses the regular
collision-detecting SHA-1 implementation.

>     I know that GitHub only ever runs index-pack, which may give some
>     amount of protection here. In general, I think we should consider
>     deprecating unpack-objects in favor of teaching index-pack to
>     unpack. It has many enhancements (this one, but also threading) that
>     unpack-objects does not. I have an old patch series for this (sorry,
>     only from 2017, I'm slipping). IIRC the sticking point was that
>     unpack-objects is better about memory use in some cases (streaming
>     large blobs?) and I hadn't figured out a way around that.

Only seven years old? Sheesh, you really are slipping ;-).

> Phew. Sorry, that was a long digression for "I think you're right, but I
> might have argued it a little differently". I think the direction of the
> patch (skipping checks entirely for loose objects) is the right thing.
>
> > As a small note related to the latter bullet point above, we must teach
> > the tmp-objdir routines to similarly skip the content-level collision
> > checks when calling migrate_one() on a loose object file, which we do by
> > setting the FOF_SKIP_COLLISION_CHECK bit when we are inside of a loose
> > object shard.
>
> OK, this is the part I was wondering how you were going to deal with. :)
> Let's look at the implementation...
>
> > @@ -239,11 +247,15 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst)
> >
> >  	for (i = 0; i < paths.nr; i++) {
> >  		const char *name = paths.items[i].string;
> > +		enum finalize_object_file_flags flags_copy = flags;
> >
> >  		strbuf_addf(src, "/%s", name);
> >  		strbuf_addf(dst, "/%s", name);
> >
> > -		ret |= migrate_one(src, dst);
> > +		if (is_loose_object_shard(name))
> > +			flags_copy |= FOF_SKIP_COLLISION_CHECK;
> > +
> > +		ret |= migrate_one(src, dst, flags_copy);
> >
> >  		strbuf_setlen(src, src_len);
> >  		strbuf_setlen(dst, dst_len);
>
> This looks pretty reasonable overall, though I'd note that
> migrate_paths() is called recursively. So if I had:
>
>   tmp-objdir-XXXXXX/pack/ab/foo.pack
>
> we'd skip the collision check. I'm not sure how much we want to worry
> about that. I don't think we'd ever create such a path, and the general
> form of the paths is all under local control, so an attacker can't
> convince us to do so. And I find it pretty unlikely that we'd change the
> on-disk layout to accidentally trigger this.

I thought about this when writing it, and came to the conclusion that
the checks we have for "are we in something that looks like a loose
object shard?" are sane. That's only because we won't bother reading a
pack in $GIT_DIR/objects/pack/xx/yy.pack, since we do not read packs
recursively from the pack sub-directory.

So I think that the diff you posted below isn't hurting anything, and
the implementation looks correct to me, but I also don't think it's
helping anything either as a consequence of the above.

Thanks,
Taylor

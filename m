Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D552253F2
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989638; cv=none; b=qSBOrJoGrnbB1y3jlCdLS0bvxjhEMljBmuUNv0Q99+H90NnM7+G9VqU+LIoUNCrMW/a0Dw7vJElk7j5Xg4aoccaCA/NDdNOPuItzicql4EDdq3UzHIYcjfvgfQii08OLVaLquYWkIpyKsfNvrGjPqQyvgv76xa/nmAFZKV4b8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989638; c=relaxed/simple;
	bh=iWYHm03zRR0/ljjnNRNpSHE/6eZ5hPvaRxeYBVPhgDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVzac8NxiFqF3ZN5JthjGU2Y/5fMV5ny6wIyP+xU08fK4gQ4wmOi0pLEf/cF19z0ygkJzBRNTINtZGUkJR5gmI5NJxEP+sYXLD2Mv/ZAyOFPWJMCQOk3QLE0cSl0BuYkNVnkuzzCkLxBLLEdA3v5YWL5tZNWJlr/gtzkyqNJEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=phO+ay5V; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="phO+ay5V"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ff4faf858cso41701667b3.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748989635; x=1749594435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PjT+RhmSuHYPh4jtHUb9hMgPIx3ryCn/kEe7EwPXuo=;
        b=phO+ay5VL9kqwna3fN2GHVx/vI2PVR+qjKQI3rKVtI10iWqSIjf9ZpzS1WhwG9QXj/
         9vgq9IJqzuf6afFW6KcC5luIs2EnGgveNX1YEDTzTyWNSZUfk/piu8f574Pt6oao28nM
         ipbVui6oGUEqnz4rzRqFH7enwb9vc2/a29XBg+00ayQf+C93neQ+Tw2CO5seLpHwkuyW
         Ntzq/8akiq/zhBnyxBd+Uu6QsrM9rHgfq4sUV44cnFk+Jira1zY1aLNPnUvepLZwR0Vg
         lMW8AmF16JALcjvqCVAlTLlI2U3Lv2b4t1IziROYBOxYwTk6zyI5U9IsvQrzxu0IVf7A
         q/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748989635; x=1749594435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PjT+RhmSuHYPh4jtHUb9hMgPIx3ryCn/kEe7EwPXuo=;
        b=JjRTgkrCBJClGwpwisqNHjvyOPTXEbFFckU09LkUrUtZoIZW+VzsDD77ZGA4uEjrN6
         qMDTkOQVkqimcfCQeJ9tmvrdakplgq5uV3aCUcScRJ9d7i0nxzKyZOaCo6f9VSFx8k38
         PNTlHyjEzsPqgnUuPT/y/txlUuhGNqG3idX2+qKQWr929mjoMFHWt6kdjKu5Ur4tUHxX
         Txrbc6mGjI4e70mKmr9wz6nmuOw1HgRyd3ezeyHM7WLxoB33Zh8TfF85I1MEPkSmzPas
         rVaDMnazfHDQS5C6FraGogqq1Vag2ivki22VTRmYNvP/0z3EldDWVQOC4N3IBfNZOeCd
         d6yw==
X-Gm-Message-State: AOJu0YwVrnBxcLKIHLBvmpJHse8goRDCpMzAD/vk2YxjCm71A3+LKJky
	+5Cu7wHLHV2VEHe/BYSuF4Ez/aDjEQiUafq9fJqeaH8LOqoRHtF44bVl7Lt9KfpYP+40WjmeUIJ
	AVRmw
X-Gm-Gg: ASbGncu+IzGg7HagMwQCG2ULOogwPy8eECQ15Bizw8/Sp/HMQXxophtUHC2VyhP7ZV/
	v/f/yGU2e41nWXrpMvVj5RFBs8I7pBve5UUKaMIZ9Adc7PxVEeQFSNcDbAkIlg63GpL7gqAmhgm
	Cn2SCQ2ror/t2ShNWxESjPAQIRluP5NuUjSvPHFtPpBZID6aSLi1qW6sC2AitpVqkukYhabkTHG
	+azDm8krMd3URaxgaqI2pZFMFVBL6JiySNXE14m5qPspETrMNac8f9PG7VSv0xMMov5ixTFoRk8
	an9PPLc8AudqJXophDJojBKDMYvTBVH/SmDrK4n0I3znLK3HROkPpny4h+1IedBfv6TMRzU8hz8
	Hr0Gw9f2YLrTmc6IOQqt/4cQ=
X-Google-Smtp-Source: AGHT+IGvkQN2RWJYj0YZEb8IDTuZ9CiuNBHcx+nak6UZUEOQ0/sZlEuH0QeqT/yJbWYcgb7QDrkCjQ==
X-Received: by 2002:a05:690c:28b:b0:70d:ecdd:9bd3 with SMTP id 00721157ae682-710d9db78cfmr6929217b3.27.1748989635394;
        Tue, 03 Jun 2025 15:27:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8ad007e2sm27276727b3.108.2025.06.03.15.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:27:15 -0700 (PDT)
Date: Tue, 3 Jun 2025 18:27:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
Message-ID: <aD92wu6Mk/S9Qm4t@nand.local>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
 <e3e21db673f3ae6e574333d4678a0450fa44fb9c.1748473122.git.me@ttaylorr.com>
 <20250530065034.GC1321283@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530065034.GC1321283@coredump.intra.peff.net>

On Fri, May 30, 2025 at 02:50:34AM -0400, Jeff King wrote:
> On Wed, May 28, 2025 at 06:59:09PM -0400, Taylor Blau wrote:
>
> > Let's instead have prepare_midx_pack() return a pointer to the
> > packed_git structure itself, hiding the above as an implementation
> > detail of prepare_midx_pack(). This patch turns the above snippet into:
> >
> >     struct packed_git *p = prepare_midx_pack(the_repository, some_midx,
> >                                              some_pack_int_id);
> >     if (!p)
> >         die("could not load pack xyz");
> >
> > making it far easier and less error-prone to access packs by their
> > pack_int_id in a MIDX chain.
>
> So obviously I like this direction, but a few small comments:
>
> > (In the future, we may want to consider similar treatment for, e.g., the
> > pack_names array. Likewise, it might make sense to rename the "packs"
> > member of the MIDX structure to suggest that it shouldn't be accessed
> > directly outside of midx.c.)
>
> Is this note still valid for v2? It looks like patch 1 adds
> nth_midxed_pack_name() and tries to use it everywhere.

Yeah, we should get rid of this. I had written it before I wrote what is
now the first patch in this series, and neglected to remove it before
sending out the latest round.

> > @@ -1649,9 +1646,9 @@ static int want_included_pack(struct repository *r,
> >
> >  	ASSERT(m && !m->base_midx);
> >
> > -	if (prepare_midx_pack(r, m, pack_int_id))
> > +	p = prepare_midx_pack(r, m, pack_int_id);
> > +	if (!p)
> >  		return 0;
> > -	p = m->packs[pack_int_id];
> >  	if (!pack_kept_objects && p->pack_keep)
> >  		return 0;
> >  	if (p->is_cruft)
>
> The ASSERT() in the context is from earlier in the series. But do we
> need it once we have this patch? We no longer look at pack_int_id except
> to pass it to prepare_midx_pack(), which handles non-base midx slices
> just fine.
>
> So we could loosen the assertion now. Or we could wait for later when
> somebody wants/needs to do so, but I'm not sure how easy they would find
> it to dig in the history. They would find the commit that added the
> ASSERT(), but may not realize that this later commit made it OK to
> loosen.
>
> I didn't check the other ASSERT() spots from that earlier patch (IIRC,
> some of them may actually look use the pack_int_id for other things, and
> wouldn't be ready for non-base slices).

We could loosen the assertion here, but part of me likes keeping it as a
self-documenting note that this function is only intended to be used for
non-incremental MIDXs.

> > -int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
> > -		      uint32_t pack_int_id)
> > +struct packed_git *prepare_midx_pack(struct repository *r,
> > +				     struct multi_pack_index *m,
> > +				     uint32_t pack_int_id)
>
> We used to return "1" for failure and "0" for success. Now we're
> reversed: we return NULL for failure and non-zero for success.
>
> So code like:
>
>   if (prepare_midx_pack(...))
> 	return error("yikes");
>
> needs to be updated, but the compiler won't help us because it is happy
> to convert both an int and a pointer into a boolean check.
>
> Should we rename the function to make sure we catch any callers for
> topics in flight?
>
> I'd have thought we could call it nth_midxed_pack(), but that seems to
> exist already, with the caveat that it never prepares the pack, but only
> serves what's in the cache. I wonder if we could simply replace that
> with what prepare_midx_pack() does, but it may be more conservative to
> leave the two separate. So I guess nth_midxed_pack_load() or something.

In general there aren't a ton of in-flight changes in the MIDX code at
any given time, so I think we could get away without renaming it. But I
don't mind erring on the side of caution here, either.

Thanks,
Taylor

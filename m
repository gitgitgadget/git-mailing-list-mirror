Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723942135AD
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339474; cv=none; b=m7ZO8VX0kYWnyTEG0UvJ9OyhIb9f+jG0E9c0Y7e603XfN9TBsyYerzPWKSt9wrg229VHiX0THoTYNV0Ihf40isSqcApMGndfBHsV9BDozTUYMtolmLRoW2aa8AQapnzEgUBzjRFdr+n9Pz4ra2HstkxamLzEVnFJ9mLNffToAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339474; c=relaxed/simple;
	bh=hSOKcd59XV2fEs7hSm3Vykze9rDXz41stPFt0nXE/OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6BHvoBfiF9S3C5jpeqQtRhxAtbYgtSOew2WzKpTS+oNhEVjFyZKQ0Sf5SWtgxuuVeRK07o25wj/L5w0Lh0g6n88He91hVITaiHsQJ41HhjIyppM9efWkHvUPAGbR55lgPLMAYgbZxk8nAYVxMwF8L8RsMVp+fkawKTlTnsYUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fLR2247t; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fLR2247t"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47691d82bfbso49817661cf.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742339471; x=1742944271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSOMMtjJIWoosSFKnBxWruSVLte03Hpb3xyBYwZ6muw=;
        b=fLR2247tFEO6GqqkREsFOiRAnFxFVv0A/lfWPYFwxm0Tn2Jj6KsRL8VsL3sgqRrwMC
         Bl+rgCVrBP7hZqNMAHoVoXaRmqvkIn+9GUVu4lBeD4Y+7ciYM9IdNW2Ad79c0x94zZXU
         KdVp6XoCNiuQMjjvu305o4oCu0GxpMr/k5SN8Mh3p95cRdjXFNqWGDWaMjnFJf+/jhYW
         2DuzC061pQwdPG/+ZARgM/sVf5jI2iTM7h/JL5SnofvsyTsgzz0pSM6cm9zm9gKZzz8n
         bCYyBm6JRfl2A3s0ZukqF12kUBJuetpWMMAszVxHa4jfzXsFTziSq/WCXRQuhE93gia7
         oluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339471; x=1742944271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSOMMtjJIWoosSFKnBxWruSVLte03Hpb3xyBYwZ6muw=;
        b=ljYUw0UAYsjxlqkM8OocxYZvpmImsXQZV43bFi07zphC333yfhJuKV2Jux5dHwoekV
         oQ5xh5NNBtNLjmj6kCFmejf2jvpIx1zq/MgQ8PhYAnMIM2hplBu/kMCGztVjoC6aiP4U
         znbg6iPjWGL8V8lJ7PjfEBZk/IE6aP/ULLKWNrHEbwLkTQ9yYqVz8mlHNuyCQPuh/342
         mcMBA5fgJrsfiC/BuMv8CQoCMkxOisfdwqpNiZ+gC2o7UjwYh7jGKoRxP4JH0lZ4GP7w
         HE7q+5HcNy7H622PfXCyexn9l3ji8l0Zq2Vz3rqqHlHTCGH+55Oqu/+OAzHLg3QYAGw9
         HhAQ==
X-Gm-Message-State: AOJu0Yyv+GDIAm3qzDbydhCcDtXsXIm7BPYeM6IdeFuJqD9f1sYZtUQb
	VUj/Av75z4/zNicTJgr+mCwLRHa1KvTSOoqTa5kcfKFlu/UgxWz0fx1Sw8fxKPBqJX5K/HBeW5y
	g7/4=
X-Gm-Gg: ASbGncuIaz+VYICqPpNxX+TQXsJTVT5kOykj+zdKhPrDl+Vfuv1A3aRa61jBOzx655F
	lHVMBULGYG98C/zzRQvneI0r3tQYazh/Z9JuxCleiXdReZTqHpguUCIEmEmRel/0Fd4i3AutGtE
	sETcoOlCnWbytFVBGdvANDgom6XBPPxYh8vnf+3ACaSZElUFqRvaBjsRPKqHT6WuSWAkp5STzD9
	0IdJKsudSb9Qjf2PgGa6OcVUGbBDdTgRiZA5eXzvjy1QIj+pifJMC1iVDQFsVER5yUYOl7kzliM
	yA8yGIJyA/KGC+pRlIq7wkGgvpNDLh8lVLdirzIaLpsHdHnITXwYDXFiuPnQf9mnZSiWsvxZacd
	zQiN9O8axb29EnewE
X-Google-Smtp-Source: AGHT+IFpBWHWKSrmuDcO6+zIuge/d2ODX59kJBn06c/X6ejdu3ebAphhHD9qy/DkNKbV2vUz5gnvFA==
X-Received: by 2002:a05:622a:4811:b0:476:8df3:640 with SMTP id d75a77b69052e-4770835aca9mr11277951cf.7.1742339471314;
        Tue, 18 Mar 2025 16:11:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb82a5c4sm72289971cf.68.2025.03.18.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:11:10 -0700 (PDT)
Date: Tue, 18 Mar 2025 19:11:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <Z9n9jf7GDBMPyM2R@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f565f2fff166bdf4bb2505f4a8853215a5365b17.1741983492.git.me@ttaylorr.com>
 <20250318011618.GA1471939@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318011618.GA1471939@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 09:16:18PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:20PM -0400, Taylor Blau wrote:
>
> > +In the incremental MIDX design, we extend this definition to include
> > +objects from multiple layers of the MIDX chain. The pseudo-pack order
> > +for incremental MIDXs is determined by concatenating the pseudo-pack
> > +ordering for each layer of the MIDX chain in order. Formally two objects
> > +`o1` and `o2` are compared as follows:
> > +
> > +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
> > +  `o1` is considered less than `o2`.
> > +
> > +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
> > +   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
> > +   preferred and the other is not, then the preferred one sorts first. If
> > +   there is a base layer (i.e. the MIDX layer is not the first layer in
> > +   the chain), then if `pack(o1)` appears earlier in that MIDX layer's
> > +   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
> > +   appears earlier, than the opposite is true.
> > +
> > +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
> > +   same MIDX layer. Sort `o1` and `o2` by their offset within their
> > +   containing packfile.
>
> OK, I think this ordering makes sense. I had to read this description
> over several times to make sure I wasn't missing something. The earlier
> part that says "it's just concatenating the pack order of the layers" is
> a much more intuitive way of looking at it (modulo that you might need
> to remove duplicates found in earlier layers).
>
> But I think an even more basic way of thinking about it is that it's the
> same as the pseudo-pack order you would get if you had a single midx of
> all of the packs in all of the layers (in their layer order). We already
> have to deal with (and have documented) duplicates in that case.
>
> Not really suggesting any wording change here, just making sure I
> grokked it all.

Yeah, those are both excellent ways to think about it. I hadn't
considered the "the new ordering is the same as the pseudo-pack order
you'd get if you had a single MIDX of all the packs in layer order"
thing before, but it's quite intuitive.

As a side note, it's somewhat hilarious to me that we could really
write:

    "The new ordering is the same as the pseudo-pack order you'd get if
    you had a single MIDX of all the packs in layer order, which is the
    same order you'd get if you had a single pack containing all of the
    objects in MIDX order."

;-)

> > +Note that the preferred pack is a property of the MIDX chain, not the
> > +individual layers themselves. Fundamentally we could introduce a
> > +per-layer preferred pack, but this is less relevant now that we can
> > +perform multi-pack reuse across the set of packs in a MIDX.
>
> Calling this out explicitly is good, since it's an obvious question
> for somebody to have.

Thanks, I think this was an addition from Patrick's earlier review of
the series.

> OK, so each layer's bitmap does depend on the layers above/before it.
> That obviously needs to happen because each incremental midx is not
> likely to be a complete reachability set anyway.
>
> But I also wondered what would happen with a situation like this:
>
>   A -- B
>    \
>     -- C
>
> stored like this:
>
>   base midx:
>     - pack 1:
>       - object A
>       - object B, which can reach A
>   incremental midx:
>     - pack 2:
>       - object A
>       - object C, which can reach A
>
> That is, two objects B and C both depend on A, which is duplicated in
> two midx layers. Even if the incremental midx is complete in the sense
> that C only depends on A, its bitmap cannot just be "11". Because the
> bit position for object A in the incremental midx does not exist in the
> pseudo-pack order at all! It must refer to the copy of "A" in the base
> midx, so it's correct bitmap is "101" (A and C, but not B).
>

Right. Since the base MIDX has objects A and B, B's bitmap here would be
"11". C's bit position in the subsequent layer is a function of where it
sits not just in that MIDX layer, but how many (de-duplicated) objects
exist in all prior layers. There are two, so the earliest bit position
possible to allocate towards C is the third bit. And since C reaches A,
its bitmap would indeed be "101".

> Again, just talking through it here.

Heh, thanks for saying so. It's good to know when we're just talking
through examples versus asking for changes. (Of course, the mere fact of
talking through an example is sometimes enough to suggest a change by
virtue of that example being confusing enough to need to be talked
through in the first place).

> > +Note also that only the bitmap pertaining to the most recent layer in an
> > +incremental MIDX chain is used to store reachability information about
> > +the interesting and uninteresting objects in a reachability query.
> > +Earlier bitmap layers are only used to look up commit and pseudo-merge
> > +bitmaps from that layer, as well as the type-level bitmaps for objects
> > +in that layer.
>
> I'm not quite sure what this means, but I guess you're saying that
> internally as we produce a bitmap, we'll always use the complete bitmap
> over all of the layers?

That's exactly right.

> > +To simplify the implementation, type-level bitmaps are iterated
> > +simultaneously, and their results are OR'd together to avoid recursively
> > +calling internal bitmap functions.
>
> OK, I guess we'll see what this means in the patches. ;)
>
> The general rules for the data structure make sense to me, though.

Great, and thanks in advance for the review as I work through the rest
of your emails :-).

Thanks,
Taylor

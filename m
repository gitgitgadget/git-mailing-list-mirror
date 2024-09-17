Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06D15C137
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567095; cv=none; b=JaknjoX+fB455+QO83auqKieIYpUZYSkF2KkDHFmjXliC2FNjxQUeG6IF2tZPQu68SIH3905gBURSD2+oOWZCEk/HKaNFya6SzUjdZYUxz72mj9X5pCxWdHb4coOLqvFXGlW2S7983FEMuuMuGTLjR5A/+uE0YSAUBg+UZZkGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567095; c=relaxed/simple;
	bh=R8RrLMDNvMFYjSmwp0t1eK658RHTh4fGwIdnuPcDwqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVEoLAD27QMYVSpIY7RvUXNbxQhj5LuVd2mt4U7J0V4ItYvd4EmskD2kil9RVJWseafjLeYtkK3Zd4zlcEbAuFwD4JroV0lo4bDX/PqX/gCcAffCB27t14nvNNxrThRupm757oK9hZR8siV3mjkS4WG0Y0oHOIaPxHaXMOxljx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Js3g6+MY; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Js3g6+MY"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cec47242eso198795639f.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726567093; x=1727171893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KK++qilgLmBRUvXlZyA6bBsQFb0RmG2/oykcol2sB2A=;
        b=Js3g6+MY5ioZFNGXOF08a6zzFI0899WRY7ODDJGoEW96DZM4+BPHFyoeb/zImQ9Mr8
         WYB7Q8Yd4YGanMnU4nHdmyN5UWIqcdR7/x7jIfJOzDDTjktYDwbKD/TqOffdAdn8B+cP
         cqQy9k47E5G8h3FpWubdF2IZCUg0tgU1EVQU30S+GwDkzZw9ZQD5m3zUHxqLV6K22Lwt
         EknM8tKvIArjlOMuW9s4xjXdgdqThdq3B3NV9l2GTlFxuJ+5bmnwdGJHKJuvsZ0iisVR
         F2mAWEljivF0bXjz8tfCkEAGuprTxePLEmTRyl1JcnHtSrVVn1igDaBFWpRKnZUzrxO6
         EF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567093; x=1727171893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK++qilgLmBRUvXlZyA6bBsQFb0RmG2/oykcol2sB2A=;
        b=UH+BSadp+T5c41qZNaR+PfdMGs9f2VCrQctIHxqCNnN7r8wE/RA9ueU2ch8Ik1qNfJ
         W+LjCxR/gpdUPHeISJp6WjOg/wsCmSNVG+BPdB2hJkcmt1hnf9eKi6XcCHoaGDxCcDoT
         uSVI6c32DI7wr7y979sAIYcD1lYq/wlvoC34qdYzUanyCtg350Ttu+aNuHJVHliqSEjg
         UIH4brrQ017T8I6cEbPYvgiXLvzOrPFaugifFHxLgMUuf9PYY32ssBDeHfytCrRrYiP/
         Qjf4/q45OA9Qghz/PM1cQf7UZy1lcBpr8S3GER3PdeTIW/vhBPqAYbLw0T8PGFUkJ2Ac
         skLA==
X-Forwarded-Encrypted: i=1; AJvYcCXhYegHKdOJWrHCKKbM8gMU5dP07pf8tejnP6RYld1QuWNeYoucxLkKL9h0b6CU0vWXSaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5OF89WSvb6FnPtqey8UnZL4Be9YsfMjoavsmcvaG7/93ytjj
	DCBzM2L4sMYMO/72AdCN0SJFDZmrZuyy2kCPqyXhPN3SbhQasceh/RQMee1FGhE=
X-Google-Smtp-Source: AGHT+IGxmODrehqh9ni0VaEP6nUGKNu01ZBQmBH1XdCn86XRqAznrvwIsevBDWIsgR48t8DOwNp9OA==
X-Received: by 2002:a05:6e02:1a27:b0:39f:558f:dd8b with SMTP id e9e14a558f8ab-3a074c9928bmr181357765ab.12.1726567093503;
        Tue, 17 Sep 2024 02:58:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec206c2sm1959424173.63.2024.09.17.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:58:13 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:58:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] pack-bitmap: tag bitmapped packs with their
 corresponding MIDX
Message-ID: <ZulSsfi/XouIlWtq@nand.local>
References: <cover.1724793201.git.me@ttaylorr.com>
 <1838bbcf7fe6daa58a7db78b81a2d08138fe176e.1724793201.git.me@ttaylorr.com>
 <xmqqplpt5wrt.fsf@gitster.g>
 <ZtDEy/teamtXMAbn@nand.local>
 <20240905090024.GA2556395@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905090024.GA2556395@coredump.intra.peff.net>

On Thu, Sep 05, 2024 at 05:00:24AM -0400, Jeff King wrote:
> On Thu, Aug 29, 2024 at 02:58:19PM -0400, Taylor Blau wrote:
>
> > On Tue, Aug 27, 2024 at 05:14:14PM -0700, Junio C Hamano wrote:
> > > > diff --git a/midx.c b/midx.c
> > > > index ca98bfd7c6..67e0d64004 100644
> > > > --- a/midx.c
> > > > +++ b/midx.c
> > > > @@ -496,6 +496,7 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
> > > >  				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
> > > >  				 sizeof(uint32_t));
> > > >  	bp->pack_int_id = pack_int_id;
> > > > +	bp->from_midx = m;
> > >
> > > Do multi_pack_index objects live as long as bitmapped_pack objects
> > > that point at them live?  If m later goes away without letting the
> > > bitmapped_pack know about it, the borrowed pointer in from_midx
> > > would become dangling, which is not what we want to see.
> > >
> > > "None of these objects are released or relocated while we are
> > > running pack-objects, so once the .from_midx member is assigned
> > > here, it will always be pointing at a valid multi_pack_index object"
> > > is a satisfactory answer, I guess.
> >
> > Good question, and good answer ;-).
> >
> > This is only relevant in a read-only path where we're generating a new
> > pack from existing packs and not altering those pack or rewriting /
> > deleting the MIDX attached to them. So I think we're OK here and don't
> > have any lifetime/scope issues.
>
> Do we ever close/reopen the midx? For example, if a simultaneous process
> wrote a new one and we triggered reprepare_packed_git()?
>
> I think the answer is "no"; we might read a new midx, but we never ditch
> the old one (just like we do for packed_git structs). Which I suspect is
> needed even before this patch, since various other parts of the bitmap
> code (and probably others) rely on the struct staying in place across as
> we read many objects.

I think that we *could* close and reopen the MIDX via a call to
close_object_store() (which dispatches a call to close_midx(), before
NULL-ing out o->multi_pack_index) and then calling prepare_packed_git()
or similar.

But I'm not aware of any such codepaths that deal with pack reuse and
calling nth_bitmapped_pack that would do such a thing, so I think that
we're OK here.

Thanks,
Taylor

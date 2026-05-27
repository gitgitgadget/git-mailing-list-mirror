Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20B271A9A
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893174; cv=none; b=fmwUOoWIfGU5tPAm3cZM/7ct63FRq7TJtcGlqEYC8G4LVYo53+sIULQev9aSOUIBcs83wfLcHWtSAK/9KTDvheljT/wY9eDifSYqD3R7Ey4/h0+RLqkZnR6HhZptNYjHcKcspsXxSTngKNmL4QcAsPTR4KhHwbwX2jbOUK3izI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893174; c=relaxed/simple;
	bh=7CWv7RtO0YGCCrT9JRh3/sb2SLuU7OoBWT+WZrx/rJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqhybnN+Xu7SxuxQtexIXtZbF2vyvxVR4v3hQGxQ7s6TbFaiuKHcWpLHTV0fzt/so5PXonJXB15TeLjxjSajH+BBq8slPvpl3e+LXdSkeUxpKxcViq4Yu0lZIBtMEGCLCkHeDip/eqbO1D6QYsMmMU+/kIyyeSWnWJcEQDVK4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EWeZB9uZ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EWeZB9uZ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7de431da8fbso9805408a34.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779893172; x=1780497972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fxe1Lygh5XPOl9E57WrdTplX5V8DTCb5iQF9ZIVDps=;
        b=EWeZB9uZEdBrH/QhiYid0+orw7lyfwqIWiWiyYjjE1qs/OJUYoKARasmwr2/+taCJe
         E87fCAQXXvVOFRAyU99xoI2OJR/Ae0i++kBdj7cGnSwSThkeztL8+C79LYExGRv5twwJ
         vPzOMwsVumzWVngK+ZHg4g7Ecg91DwTrKt5Tgv2YpCzNIqxjs+ucSznyUkmP1RP+UVvq
         FspxoeXNkXGXUk7XfVvuuKPFheUAIBwzIU2ayQyhg0s7mj3EYC9yWap+HYk2+YyST+WO
         5K9gK+DpV6rDQidDFqxb/kk2JXBfimVCGbQsCRR26D79hLZ+kdeBrQPVlUwuOBcDHN5r
         VLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893172; x=1780497972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fxe1Lygh5XPOl9E57WrdTplX5V8DTCb5iQF9ZIVDps=;
        b=J0jMsnPh65Is/efFwmyF0hvx6yqbqSl0XrGA+JbI1JSxiAkA+l61Ljnfip19Xmq8YV
         AIIxI/M8S89os/qNjoygxeKMeBHEXbEs9+0Dx6NPgYIY7GJTl8+L9xLutg9rar8wrFbg
         kftmWNqcdKwHHdWSYQrLEUy/1VHf41pwEgkPz8UlISvkGpdSxIigEE6t5EUi8LWvvdyX
         2drpUrixaiNSPx4oqRjmwofp/9oYl3WcWFrt4zkQ0K6jllNEldUGs4CGtsmRG2dsX6lw
         eY+pUzcfboCEMDyCryD53OwXljq+ouPaS6Bb5YQ7P0F05HTFFVduClqKxGQH3G2yCVNE
         m8Pg==
X-Gm-Message-State: AOJu0YxP0a7DVus15ZKSDxpbrJfxaEGpyeIrBxtx0QeEjKs24DTyojVA
	myPtiYPZWiv0gT0YDWiPHymLLhq1NWt5GcSAdYJd+r1W/yRb1XXjImTO91pb71E7BFY=
X-Gm-Gg: Acq92OHYS2aPd0YSPLrhITpnJ5vZ6mPX0Bk9pFsd7TjcsCSUxi9AdAsmGN8UAStkGud
	4paDMvKrzBiSRIns7BX3muyplUpeEEArHJsrm5qxeD0amq/nFWqXroPs4lNZDs/WH0NnXMlSR0J
	WLAjkWxqdQnZHcUjwDCb4Wb7n3YV2FDxmtZ5TcaoqDDLUDD6AH1cLDsFKsZMVw6qbxQvAhVCC7k
	8TDchK1LNIyyIUy67whdRO0upI3wfG35tzb3hAXG3pTjTfoq4lWUnYN25BPF6gGrFkZPDeTZEqz
	oGP0Qda8k+uz8/9mEWDrfUWEh3xAXUDg5miZcCgqzFKD9nqfzmUlKy5ZuAAp3G0iAPvuj1JukJ9
	9lBpizgyLccGylJz1JUQrHJRXjgFjss3Vh6xB61U4/qAM2/AMUkoldBQK2gNB5aVYQjAzDqATPl
	GQmMDjcTYBFjjcUoVoqATVdSJK7DAW084tHq3tQCjcP9WezIF0zP4g1MAbJF8ImKNuMReqT8ENB
	NprXHut/QJnVxuthjPYYYUd4vKkHMYxCPwV72ZOcDAqDEjbmMVZVd7CplAbH3Vihl2/AjSaERx6
	AI8Sdp/HbeWFtshipZHO7S1yyts=
X-Received: by 2002:a05:6830:7306:b0:7e3:7dcf:9d3f with SMTP id 46e09a7af769-7e5fee5d921mr15143014a34.16.1779893171888;
        Wed, 27 May 2026 07:46:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60645a457sm13333582a34.5.2026.05.27.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:46:11 -0700 (PDT)
Date: Wed, 27 May 2026 10:46:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/8] pack-bitmap: cache object positions during fill
Message-ID: <ahcDsgYTJurWO7X3@nand.local>
References: <cover.1779207127.git.me@ttaylorr.com>
 <e43ef6a42d13578a6b7a4a346f491e51a6edfd14.1779207127.git.me@ttaylorr.com>
 <20260527094535.GF981444@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527094535.GF981444@coredump.intra.peff.net>

On Wed, May 27, 2026 at 05:45:35AM -0400, Jeff King wrote:
> > Combat this by adding a small, direct-mapped cache to the bitmap writer
> > which maps object IDs to their corresponding bit positions. Size the
> > cache according to the number of objects being written, with fixed lower
> > and upper bounds so small repositories do not pay for a large table and
> > large repositories can avoid most repeated packlist and MIDX lookups.
>
> Introducing another layer of data structure feels so dirty, but it's
> hard to argue with the numbers. We are looking up oids in the packlist,
> so it's already O(lg n). Your cache here is essentially a hash lookup,
> which is O(1)-ish (with collisions causing eviction rather than growth).
> And it presumably works because there's a lot of locality in lookups
> (between commits X and X^1, their top-level trees will be almost
> identical but we have to resolve the bits to find out which entries are
> new).
>
> It does make me wonder if we'd see similar improvements if we just
> turned the packlist into a regular hash table. Or maybe not, because
> then we'd have to do actual probing.

I haven't run that experiment directly, but I share your suspicion. I
wrote a 2- and 4-way associative cache implementation as alternatives
before settling on the direct-mapped approach in this patch. I found
that associative caches regardless of cache lines nearly nuked any of
the performance gains that we got as a result of this patch.

> So this really is a somewhat unique situation. It _might_ be applicable
> for the reading side of bitmaps, though. When we do fill-in traversal we
> end up with this same "read a tree, find the bit for each entry, and 99%
> of the time find that it is already in the bitmap".

I think it's certainly likely. In my experience, many object to
bit-position queries are extremely cache-friendly. And in practice, many
large repositories have MIDXs with many tens of millions of objects. So
even on a O(log n) lookup, caching seems to help a lot.

> > In our example repository from above and in earlier commits, this
> > results in a ~9.4% reduction in runtime relative to the previous commit:
> >
> >     +------------------+-------------+-------------+---------------------+
> >     |                  | HEAD^       | HEAD        | Delta               |
> >     +------------------+-------------+-------------+---------------------+
> >     | elapsed          |   324.8 s   |   294.1 s   |    -30.7 s  (-9.4%) |
> >     | cycles           | 1,508.6 B   | 1,365.5 B   |   -143.0 B  (-9.5%) |
> >     | instructions     | 1,436.6 B   | 1,389.8 B   |    -46.9 B  (-3.3%) |
> >     | CPI              |     1.050   |     0.983   |   -0.068    (-6.4%) |
> >     +------------------+-------------+-------------+---------------------+
>
> I show a 26% speed up on linux.git (1m37 down to 1m12). Very cool.

Glad it reproduces ;-).

> > +static uint32_t store_cached_object_pos(struct bitmap_writer *writer,
> > +					const struct object_id *oid,
> > +					uint32_t pos)
> > +{
> > +	size_t slot;
> > +
> > +	if (pos & BITMAP_POS_CACHE_VALID)
> > +		return pos; /* too large to cache */
>
> Cute, I wondered what would happen if we went past 2^31. I suspect there
> are other parts of the code that do not behave that well around that
> size, but it is good that we are not introducing any new surprises.

Yeah, I suspect that there are many breakages past the 32-bit unsigned
maximum number of objects. I figure the easiest thing to do in this
patch is to avoid making that situation worse by simply not caching
objects that are near that limit.

Thanks,
Taylor

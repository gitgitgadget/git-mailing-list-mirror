Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95471FDA
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133399; cv=none; b=lwGKi7TM7k0g6w8Vb3QdLH0jQMjtZJN0177RvXdnNs5Q37fDLEbuBoCUCk9SShA30L972yhhw2BF1wtracgeZK/vTcaBr1Y+8vkDNzvHNKRgEPTUduup9GaflXQTJV2D+s2igjntyK4KkWArmJPmQb2+RmtpvJrlFvf6fOWG7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133399; c=relaxed/simple;
	bh=ogx5gSLizVT8X9pplKnUBv8CdPVkEySiUNImkvAbkmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXEcNJyUt0c+PaTV7GnZu1l5NQqmHhmE7WWdUA0WJ+b0jR6XXWdJ/VpQe/AWdodcGX2tBhtWaH+cJmw1zUKHB1D7Uz/ZEsT5a8yUmBZa+3s1sZMHuucjzUMV/SlxK3DNCvjdKSpDolKqrjwmM9yAXD+MGI7VIrCQae5HRFx92Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XCUv5Jk/; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XCUv5Jk/"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so5292329276.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 16:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741133397; x=1741738197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NSDxA9I0lMQ08VBnMg4ZB4Naf2Heys93dgtp4X5Wnk=;
        b=XCUv5Jk/zO+DSXLwr547kidENnARUaH4lKEmuCZONcrYeUNyG7+AiQ/eOTFxY71z//
         wcAF8UiSWV/6yUk7jAFI88zrvek9RcK3pHK6oxZZdzmtvYJvAKpDcKklE/LR2YKEJWIf
         Fgn+NBwwOlYvmeqldG2ffHywtoLG8bMS6eKKkn6fCo5j4Uc83+JIEaNAUzwlKLYPA1hU
         iQ3dRhMZqmwbpmLQx0TD5pjT2JvcZCB2rGKxcP8urbFmYi3Fd6WTWDOZZTlLBqOFOO/s
         tAwX4NQdruRd465ESr6gWpdMdxNOuq9qKtDvb42rpRDYAh5m6OLvJoTNLNPwir1XfG+2
         f4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133397; x=1741738197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NSDxA9I0lMQ08VBnMg4ZB4Naf2Heys93dgtp4X5Wnk=;
        b=t9imY33dXju6IUkSZtKQxuYGb6gMUgcyLZm1IA/GnPPqRYfNiBmgyKzcpmeM2Fv/sa
         rvtO4Wj0xyd3ycHRtqhw6fDkdXok7xSEHa/BsfAM/C/jXBdXscQ7rU8tWj5uETnnYUYm
         GFS+c3T5pbizFVrhCzg889BPek6t9tnai2m1wdQSQ95/MUvvv3/K9m1ZPGoCdMisY2kt
         6QE6DhMkm2tQzsTDPWTE7rmpTvtAGq/g+hG4bnZ7r57lopwX5vn5YdPXV5DD0FYQNAZH
         WGQ5MoW2NRAoSFzmevCI/6tkTqv+QS37qYUjPzMYiqFpkCCfJR/z0jnMmWog65bB0vRA
         bMaA==
X-Gm-Message-State: AOJu0YytlzPv1YiY/m0L0tLdMUFEGoAo+jN3SNtvn0uxkBxFP0/MqONa
	k377+oOcJnV3Io/IctHsEYP6VgLdCzrRFKv98JNrroHlItwdNl+f3EiuYT0tSW4TN8IknGl/Bi9
	4
X-Gm-Gg: ASbGncsofNFnDPD5LIpggt7IIu7vw0s7SlIH20mnLAykWfA+QalvNgsJJfoRRxhsHlp
	UGybZGB5/HJ0l3a9+lLA31ZSeM8fYd12ZPhWDzL4eipei639LNjh2343lCKLFtVVdpPmD2rQ9ZP
	jpaCfEFZ9DMDyH1PnJ1AXTQPaUM3JdGipyDGFGIH35Tx2aIy2hoYDPqSUy512y/RfKg0PML0GOV
	Tq8TA4xLdPQQ9nQ0ftf6pY+PvQa8ZWBZRjAevTmatC+ukIAznAko3ef9hdjzl9lHJw0tMTZtMWQ
	BUTen7IgkhCWJ+6d609Y2cQAOlni8ftRKz8OqvBw9BqOZUJoP6IGRkdiST1jodjN0XUoUQZeKAd
	aizq/E1JlwNfD7YSf
X-Google-Smtp-Source: AGHT+IGSAKZtkfzeraTf6yNToVQQZnOWfIQFURLxkST48YwK3RPXpMJsB44AbCyp8zKiq/iGfWIUBw==
X-Received: by 2002:a05:6902:260e:b0:e5d:c639:eb33 with SMTP id 3f1490d57ef6-e611e30259bmr1599482276.19.1741133396769;
        Tue, 04 Mar 2025 16:09:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3a2d11bsm4045630276.13.2025.03.04.16.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:09:56 -0800 (PST)
Date: Tue, 4 Mar 2025 19:09:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] builtin/repack.c: simplify cruft pack aggregation
Message-ID: <Z8eWU2G7Q8WYptl0@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
 <Z8FrIfAj_oVwxz3X@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8FrIfAj_oVwxz3X@pks.im>

On Fri, Feb 28, 2025 at 08:52:01AM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 27, 2025 at 01:29:28PM -0500, Taylor Blau wrote:
> > In 37dc6d8104 (builtin/repack.c: implement support for
> > `--max-cruft-size`, 2023-10-02), 'git repack' built on support for
> > multiple cruft packs in Git by instructing 'git pack-objects --cruft'
> > how to aggregate smaller cruft packs up to the provided threshold.
> >
> > The implementation in 37dc6d8104 worked something like the following
> > pseudo-code:
> >
> >     total_size = 0;
> >
> >     for (p in cruft packs) {
> >       if (p->pack_size + total_size < max_size) {
> >         total_size += p->pack_size;
> >         collapse(p)
> >       } else {
> >         retain(p);
> >       }
> >     }
> >
> > The original idea behind this approach was that smaller cruft packs
> > would get combined together until the sum of their sizes was no larger
> > than the given max pack size.
> >
> > There is a much simpler way to achieve this, however, which is to simply
> > combine *all* cruft packs which are smaller than the threshold,
> > regardless of what their sum is. With '--max-pack-size', 'pack-objects'
> > will split out the resulting pack into individual pack(s) if necessary
> > to ensure that the written pack(s) are each no larger than the provided
> > threshold.
>
> Hm. So the result would be a new set of packfiles where each of them is
> smaller than the threshold, right? Wouldn't that mean that the next time
> we'll again do the same thing and try to combine the new set of cruft
> packs into one, and basically never arrive at a state where we don't
> touch the cruft packs anymore?

Ugh. You are most definitely right, now I remember why I wrote the
original series the way I did ;-).

Of course, I read your message after sending a new round. Let's abort
that v2 and I'll send a v3 which just contains the second patch. Thanks
for catching.

Thanks,
Taylor

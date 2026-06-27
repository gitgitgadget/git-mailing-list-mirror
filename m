Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06521C68F
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782527196; cv=none; b=ulVTovDOVEiA2Q2xF+YbgfXKGMMKs/C/tBXgwaMV/8ZDdOM8cNS2/LOMTv0CFxVB4U06UyDrG0mfBc45yY1Ipwc25hZdsmXKkJURRF34WYVGnmXqifUY+GmcX9FQrGRN/Ykj+XuqtDWGP+2MvjFvyuqLI0tlQ3clCEz8yysGfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782527196; c=relaxed/simple;
	bh=GZ2fGoFyfxGjEj11pNFufPphBz7V+pPH/QcXSYG6lks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKrhlxj4oUcW2LeuRVedEWsjSDIwowXqaBWA1mEfjVBh2K82ipLoobCkkFUsiMDeifjooYJb5KqEFZhO8t71KG6j3e2tHsc6LmlBS0oEr2raWAmDYIebPv3JYTjausXA1u595dtbWdcPDgQR1X/rOxBGqBCcI3lyQ6W0qBk3YI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Af8NKOK9; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Af8NKOK9"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-662ebb1329aso985785d50.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782527194; x=1783131994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5j+TvFrGjJbYSRcKO6gcyb+D9HlmPYd1YC/06WWveA=;
        b=Af8NKOK94qZD4daseho1oY7bNGOU+4mHhnK3cwF/IYm90QmL61bgO7dU4/1C5ujand
         z9zmY+mM7jAchsNNiGdq+N9lS0m2JpmeCYWHfI+6D2cBSYjIJfwhFhyPwbkfIckXtzOq
         WgxSoR1LCvii7yvvFtO98XWeHc4JIX8Hzq0WeP7YB7BxuJBS0sgGLv6wRcg03xYStrfT
         99dLYoj7kehFPj+4rSaLBupYeq2RXybt1mrB2yPZIChkFst7gEkdHYhz2gHXrMId1fFw
         j3NMzJupsIWPrV7VOig7T5w7scsn4wSuKO3oEGws5Q9ZBXwaTlPAQKcBDND9t4JyACkU
         wVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782527194; x=1783131994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5j+TvFrGjJbYSRcKO6gcyb+D9HlmPYd1YC/06WWveA=;
        b=ono1KKO8hWoTXFb8nXxVoJItVeK4WrVXIhc9sn1pZbTxBqOn4Ym1nWgpxgHO0yL2tG
         gj1QXs++jYou0YcZA0ytLDjM4Oh+U0GU9FEvjPIL0xyH2bfpb57nOj9UaQ9mSwnkn0K6
         HWdHO9s18bdrvmomVfxFJ7VC/YZXTnZlzRRrncx5B3dpO3dnEKTCRgp0svgKAR8pASL8
         lLg/O2ds3omTiVvT+r6K0lxtKKRyrRKO4D9g/V8yRSfgBZhlW2wLVC5fsHspl3pzVYR1
         L+Xbc1tnCUoVHkqiyga33U5z+deVeyTRUBpCLv3X8VJKp+zCkul6CNas6OG+uGOrDZuD
         EErw==
X-Gm-Message-State: AOJu0Yy32a/9HHzLtjGTS5GoUzuspWeG6LTwkd5xVffbn74bQXl76ZWX
	gL6az47kKfBWKYLonSSFz8YqtTfmJ5g5E3L5xraR5E3+1G+kxE2H8oB8ZWgZTanghHw=
X-Gm-Gg: AfdE7cmFa62ng4niIKS0dYq4H+VNAdhjFEkW00a/BWwOALzBI30HkaL1V9agMw30uyB
	M1xdbpRta2oF14yYVi5IX76pHE3sdfGzB3HhC1Av86Z1er0Rwk5U5YTchbB9b5WK9j6NTgjM7yB
	C0XTfvgL9fuyn4MdJU+zl3yTHr5xMw0LyBSMBktmbLk2GklSfvInWVE6u+xrrTE0IkqQCW9RnAd
	r419AHpe7bFcIK30bQHrIIS1hgTn0WPAVgKbrOWOmsq6tYy1/tj3QSzExWn1yDtWC+BfCX6CR9c
	gXcZzAcuIJGgepjpzvaZHm+HgeLDA5Px+nUSFOb3sUIJE6h+B+OrIwyJ0hpjiyVb0RxIPbF29/i
	aHj1Jz230UsWIgv6Y6Q9VE1NwPTCJhm5P93edoSZ5W5Y9uy6WUoyxisu5eH36LP2/PZwQCyPCen
	AtQLmFV1wHaprSryZT2gIfHSb9ENsTAWU8CeZtQGFilXJ5CHI5sLkeUjsMP3Sg+Q30DenQqPIgN
	1OYJb7YRxqKUBjqau0/OzPhwmuv4627t72o3GNgex3peRyHCxm1yJGcmDaGl+Nsc4qXJlF6S3Kh
	xLEGJg==
X-Received: by 2002:a53:ed06:0:b0:664:ae6a:eef with SMTP id 956f58d0204a3-664ae6a10dfmr2135317d50.77.1782527193831;
        Fri, 26 Jun 2026 19:26:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f957405sm3807146d50.14.2026.06.26.19.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 19:26:33 -0700 (PDT)
Date: Fri, 26 Jun 2026 22:26:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 08/10] pack-objects: introduce
 '--stdin-packs=follow-reachable'
Message-ID: <aj801vo5+MZ2C3Va@nand.local>
References: <cover.1782500507.git.me@ttaylorr.com>
 <e3d2e46443d0b32ce29215563dde04ebcf850679.1782500507.git.me@ttaylorr.com>
 <xmqqpl1d56dd.fsf@gitster.g>
 <aj8cOhH6hGVZIFft@nand.local>
 <xmqq8q8068f7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8q8068f7.fsf@gitster.g>

On Fri, Jun 26, 2026 at 07:09:32PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > +	if (packed_object_info(p, ofs, &oi) < 0)
> >> > +		return 0;
> >> > +	if (type != OBJ_COMMIT && type != OBJ_TAG)
> >> > +		return 0;
> >>
> >> We do not care about non commits, non tags.
> >
> > This should not be an &&, but rather an ||. We only want to handle
> > objects which are either commits *or* tags via this function.
>
> My comment above did not mean to say anything is wrong in the code;
> I was just thinking aloud.  We return for blob or tree because they
> are not commit and they are not tag. [...]

Absolutely. Sorry about that, I have no idea how I tricked myself into
misreading the patch here. The second sentence of what I wrote above is
correct, but not the first.

Thanks,
Taylor

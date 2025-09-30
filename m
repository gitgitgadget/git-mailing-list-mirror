Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C71C862F
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262555; cv=none; b=m2ge3U3twfzhp74LPQbMnIURvvaR4ItsqkOJgMS51SYfyxPDeu0kLUFUG/w6sz17J22KsksU/YsDn+A6w2du5HXrq9NF7zuVmLYd5DyJ2fhsCKy+hjLLPDibdlwT2z0DRHbYT1X0k9bMdgPV4srg7vRJuyc3ttT6BBZAwefqxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262555; c=relaxed/simple;
	bh=Kp9WfDOW2mAdP7Y08SQJhlZQ6YTg+FN6i3LuCA+o/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfVgE1H7I3sKOHUiRlfaWQUNqfIZ2YoPjq/5mUgZys+TusmzjtlMhNwrtI3/XgIxETBecHb2nOClsKBiMlp7jkk/k3N0wpK9+6oVC7Anmuskx1preBHisPJiPAfADm5vS6tvO2GNmv3bctwkNMMp/iSapat8hQKIjMMTVxOpi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IbO97BjY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IbO97BjY"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-428f0147279so38194955ab.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759262553; x=1759867353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UMTVzh3Tzr+aFXVp+BIk9PY36EPf+aGL18DtPvCdJw=;
        b=IbO97BjYzHte8Ek7OkiJw5sFjrI9ovNz5aLAbkijW0uPAhCWJE90i+dOWCokKyqqTE
         /fApFsWRPwW9BBE96h8IaF30YzqjBFrwKKaMOWK8D1M61pKwUjic9+BxJcFb8wn1gChr
         VRm9E2iAizwuQAe6BMSmO/yvjunswC0bZ9hrGZ3bEWmodXnMFwpMBfTue3kAfU7aStuR
         bYbO9UfE5+9UbCFD5qr7LRm6aKA4NwRoqksGXlt/ZZWz5/N3tisOb9pO1bCuAXoYvFew
         3odpQqojKpiUCEw1OyMhrwibOkGBRCGCjH312QLj6R3wdN0PKM78KrjCaFEwH41afPAu
         s0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262553; x=1759867353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UMTVzh3Tzr+aFXVp+BIk9PY36EPf+aGL18DtPvCdJw=;
        b=NSXuhIpy3NUUURYdBaRErFvLsLZoiEhblSDWVhhfGMbZTc83Cwnrg6/UCeHNJz1WLb
         nbqmOrfnVvE9V5AiFpTeTGo0lOTjQJAKxbXZVk7IvcvzYC3GPSyfCRXDMQy4PoUefa1E
         JZke5H+scC737RLwBfpR5U/M8Zemz5nZUuAMcdMaXgGDGTLb9DmiSZvADaQnMV3Esa3j
         Hv6cplluAVdse4c3YPj5+Wlk9pURnwiMIbBZIy1eNmmE5GyOc/og1awKEdFvqxLIoX+W
         OF5LQzgAXzvuh14R62qbBwucB98HuYiX163CnpQY31C60GdMnN4aih1VQvKXx2XIYhQv
         ZfSw==
X-Forwarded-Encrypted: i=1; AJvYcCVR5FGFdVj9XRj03KW9hM4cakrZF/2BQ49s8ATccnvBHd2ruoVTavnsryHd9mnpQDD2cL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01Jy1CIpQBqY+yqfbvtt+8Khja/jXPb/pMbs2Xrqlw8OnWzlb
	RWiYtimxHqUi1RUFfigpOZP7zk5jkrLV9NB3220Xz0WP0Byt3vcuha7qmrl+IHFj6du4+1fTP8e
	OkeSTB8pFEQ==
X-Gm-Gg: ASbGncu9/S/FtfnKpX2Mp7ztabaeNsCnqIgo2Iu+e24OIEFd074/5LQ3u9WVUdllBZz
	kzs0Bz6ir4bj+irf2q9lees3PYMGxSSE5SRWVm326NoKCRlHIb8bL6WwKB+rkVmm0YZWKKOUf5M
	GBcP6pGJK7ubPS9vJ8x8elibQANyq+4JcJzehMJg0Hf0VL7O2H5URrpcJfHt+HqSCnNwb78Vuh9
	kKWu6s7aCxe4YR/Q79SWoe7NIfGpNGOjqlaBTOt7Au6pyrrmz6JWGaubnWAtOPfA2moYKNxAmuk
	91vb+0tt+q22ZI691NWLnfqYruAm07WxukI9MLV1A0vPW7b+Z0cMNfUqLzW7tk0DGzyl+MaacUs
	8g61MPXGdRyolx60qcQG/TvRHkCD+T0TANwGPfILhXdPmkdfVn+iyWsGPwkerjgbuCaBENI8coA
	a/xJWRnnemiXnOPl3lNHVD6L261Te/2CicK1jXlss45g8UHB612w==
X-Google-Smtp-Source: AGHT+IHXkrlYHh5NjiQ4jGJMR2QFrnyL/nUhrYZErWEDvj8/9U9sI0f8oL5HD/n4ihgDNENe7EmwRA==
X-Received: by 2002:a05:6e02:216c:b0:424:7bb:775c with SMTP id e9e14a558f8ab-42d816975b0mr17434225ab.31.1759262552439;
        Tue, 30 Sep 2025 13:02:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-428a3b61d48sm47191215ab.13.2025.09.30.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:02:32 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:02:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNw3VY7npZvHDU7i@nand.local>
References: <xmqqldm0am4b.fsf@gitster.g>
 <aNhX9AJ/zq4IYhmW@nand.local>
 <xmqqseg777k8.fsf@gitster.g>
 <aNsG5Jd_YLgrwarI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsG5Jd_YLgrwarI@pks.im>

On Tue, Sep 30, 2025 at 12:23:32AM +0200, Patrick Steinhardt wrote:
> > It would lead us into ugly awkwardness when we start clarifying what
> > exactly "contributor" is in the new sentence, though.  If a person,
> > whom none of us have ever heard of, sends their first message to
> > this list saying "Ack", does that count?  If an active developer,
> > who is known to be sloppier than others, sends an "Ack" to somebody
> > else's patch that was posted 3 hours before (hence there wouldn't
> > have sufficient time to think through the issues), how much should
> > that "Ack" weigh?
> >
> > Perhaps rephrasing it to "those who have helped in polishing the
> > patches with their reviews and discussing the issues with the patch
> > author" to tighten the language a bit may help?
> >
> > I dunno, as that would still give the "ack right" to a random
> > noisemaker who threw a drive-by "review" that did not add much value
> > to the patches, if the original author responded "Thanks" out of
> > courtesy.
>
> Despite the potential awkwardness I have to wonder whether this would
> even help us with the goal to speed up the overall process. To me it
> rather feels like there's another step now that a patch series has to go
> through, so my naive expectation is that it will rather slow the process
> down even more.
>
> Am I missing something?

The idea is that it would make things possibly quicker, but never
slower. Since the maintainer is also part of the "trusted ack-ers", the
only process change would be that the maintainer could choose to avoid
reading a series closely if it has already received an ack.

(As an aside, in the pseudo-patch I wrote above, the maintainer could
choose to bypass the process entirely, since it would continue to be at
their discretion. Perhaps that's just a semantics thing, since by
merging the series the maintainer is implicitly providing their own
"ack", without actually saying so.)

> I guess this is especially an issue as the most active subsystems tend
> to be the ones maintained by hosting providers like GitLab and GitHub.
> Drive-by contributions on the other hand tend to be more cluttered
> around different parts of Git, and here it's unlikely that we have
> enough people to serve as subsystem maintainers.

Yeah... to be clear, the "subsystem maintainers" idea was really just me
wondering aloud which of the two possible interpretations of what Junio
said above would make the most sense to me.

Thanks,
Taylor

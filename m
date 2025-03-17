Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B74203705
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247257; cv=none; b=CJiLwkoUQZkOBfQPk+BGWWaj6bIs6Bz5Cr5zDn0aAuu/7/hSNjACotZqJNDetX2jPAc4Xc0YgeOkopltFx8qelR++nQHsy6ggX7kkn8dfAHi2Z29giu+WjqQ6GJ3l30CeQaaJGXRMeAq6a0cKYtQBm36olz+Ffk8wkEX2nab5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247257; c=relaxed/simple;
	bh=6KfPiIoUs4nevRTW2ojAE5iU6xVx72LMpTjmM8GxKHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUM/BOc038V2vhfj3+THqyzyQoJnQSimBxBufsKNvZu0zWvAFLjjZX5mby2tIQRs6jkoEtkcXpLwcs9FjbqkXTwMm8qyQrkvFqX/+SFNPUwirxvm7suVTFvgfSXzGZd8/rkQKtWqPtmnOF9s896Cm/HTYAd+RtpqfUKMtL2UOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lgl0P69l; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lgl0P69l"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8ec399427so39421426d6.2
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742247254; x=1742852054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KfPiIoUs4nevRTW2ojAE5iU6xVx72LMpTjmM8GxKHk=;
        b=lgl0P69lbpDoPDDGRPmYyYtTeYYAX652pR9uFTa3cALFHRWvF3RXjTXsZjmfqud9oI
         apqH4csQRru5c2BuYdiFT13wz1h+5aQTyStOtyYUHe1NjlfF7SGm6BMLZ7GN0wHEdxPe
         MdY7MtwlRNQLZcU40Fws1u+SAv9ubbgA7POIpen4spPFzSV73GjT9G+fwt4c6lOjYUtg
         ePNJmDN9dvPLmHzzbzOi9+l2CM1inVkqPiJsJ1fSnNx3kTCgE+ftj4KdfL7eQ8tMh18s
         rLr1+zSikIrcPCHVhIFtu3iTwFKugjZ72nIrgrE06v5LSLsr7Py/bWQYMG3oKEd7Mpbx
         bv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247254; x=1742852054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KfPiIoUs4nevRTW2ojAE5iU6xVx72LMpTjmM8GxKHk=;
        b=ZgNqhPQhmFQdxmnQw7bJRmgUHM4s2w8DNtj7NDAMmc8IELGo1KRrT7ClrXQv+vyeWD
         AJ5uSLS91bSej9EIESedd8ikiP10JxcLOQTeVoyahGwchf4wUQFTm7qw9XIm8zSGICk0
         mzChK/YAY8LhNIIWvaBY/pKc2j7fNZ/R/PnSX32qrQ19IkQxLl31tVHpznpgodALG2l1
         aMxORmLj2/TQn6WqSBmOYeUW9mh2uKea0X4xftY4uAT2pkk+hxT+7Gpxl+o3I1mmr7Nq
         t6F4rPe9eCjSc5MlMpztiYocF6VZRksbxD0bRGVvHYTB3tLLUhwKuWoeQftR33dG7hVZ
         /34Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFPpCmLQ02apdOR9fdEIisA82QhV7OVdh+fGKGWUpewZMJ10RqgxVyUvMCI1JKlDyC+dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuucqR0v4cQvlUm4dUcdtw64KjiLKpf+sKcs7B/nfEFwjXIrHd
	y+YCOhOdMQhJDBAIqJ0cCGRAmk1T4dPQ2s+tKgsDRI+OZ87nfRYg6YNgR8+qfhS+Q7QCWxEHlH2
	hHIs=
X-Gm-Gg: ASbGncsbtg6xezPANYcXoEWBo+rLKwVJUxPsL7k4UL9zcw3LZr42YIApdq9auapKx7o
	rj1jV4kZoITMdTtd7vHRc2W3xnxaiy4c/ym47IHV+lCiPtLBcy1ED00G5gty9lsFFhhM0P02b+u
	+OVZhxpRft0bdBVGz2ICJ74E31TMbtEzP/p0khKt9scZNK3IjXOrn/wFertAepqfBXmXSoB4P2U
	Beom2xN7msusuR1IdAWsGmZ9Q5rrI1lwKTFT9czzzMBdUJLdTzoNM+xQTPJHn2jDjYnmVejiKdL
	2asgOMHqFcDrOxTfeq6ZF3eWdsMCo5cPdUfYGBFDnIW7OzNVkX97MmuH7TqHBgleCzoH3h7kCXY
	T3YkU/4izbgyILwb9
X-Google-Smtp-Source: AGHT+IFYy/uhoDCnYcr1EQvzAmeY3CSlBrcEX+bINXI1TA9uTj3/mu6VKxBeraA5yS/wQA3owG2nPg==
X-Received: by 2002:ad4:5c48:0:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6eb1b891dfbmr18470236d6.25.1742247254478;
        Mon, 17 Mar 2025 14:34:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade236776sm59262376d6.49.2025.03.17.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:34:14 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:34:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] docs: clarify meaning of core.commentString=auto
Message-ID: <Z9iVVD988M4XUyYO@nand.local>
References: <20250315140913.577404-1-oswald.buddenhagen@gmx.de>
 <xmqqv7s78l8t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7s78l8t.fsf@gitster.g>

On Mon, Mar 17, 2025 at 01:17:54PM -0700, Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
> > -If set to "auto", `git-commit` would select a character that is not
> > -the beginning character of any line in existing commit messages.
>
> This is so far in the past but I suspect this was deliberately left
> vague so that we can add (or subtract) the set of possible letters
> to use.
>
> > +If set to "auto", `git-commit` will select the first character
> > +from the set "#;@!$%^&|:" that does not appear at the beginning
> > +of any line in the prepared commit message prior to editing.
>
> So I am not sure if this is an improvement.

I had a similar thought while reading. The vague wording of the existing
text gives us freedom to change that set of characters in the code
without the possibility of the documentation becoming stale.

That's pretty academic, though, so I don't have a strong feeling against
this portion of the patch, but I do vaguely prefer the existing wording.

Thanks,
Taylor

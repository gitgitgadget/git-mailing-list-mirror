Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F76538A
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730072727; cv=none; b=cbmNn9y5OUREOQdjGPEGXX4qe5yEF6ErT6wJjpIBbYIPLukBlNytqy4/yWOVuuh49vHYFCIv+tWcZATx7MGKgq7xvB7I+Plmo4cAN+piqCRpr46SFJ9n3I+fTK2/K4+6J9THUklfu7Zt0yPidYmd/X2fJd0o3CXk4m0sA4VgjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730072727; c=relaxed/simple;
	bh=i+RcYlSmMY2ZBkNf1hOFNP4ayzKykmA4JaRC2B4yKe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyFwP/3Sj8g3+xwWRUNOZwODr0F73oris39dBPVp4cupMzhOMR1DAkC2ArlOQL0dSdN/hvet7YlRdVWtqN4LTc2nNFbk4wXNdFVPEZZFe2GPtI2pqpYNYCTjCYKIkUUuqO6IwqwCzwJyRfvyHOHlzmmIecnyh41qTGxN80f9LMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TAwnj+YL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TAwnj+YL"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e34339d41bso33504607b3.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730072724; x=1730677524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtljyS7+qHdxiJQ5mOubr30PqKR+Wvu0qWR7WolPags=;
        b=TAwnj+YLOqEiYR8fvCMvxM+wNUjG6IdaHy0raHOBqoCtC/eJT7h4SVbs49eFEddV7v
         0r4kePCqWAQbSUtW7bg1tum2XuO7qx4HGC5f9RrZlboS2ZTbcdH8BYnBVxY0ohxXV9fu
         Mwa8rowOFoVlC2wyXwDmN5GBYfZCHvusT4FI2IFdsSnRYUBOye2GvHZl2iwbX9LuumrR
         F3m4MdX0lk4LsThiANZhjGAV5AE/ljXpIMXVgUB8M7Xc0zkmYn9eLQhqz6sp4bL4z2iU
         GdhUrk0NlEfDeyXXOPCElES5UTSj4aB86PoJ4XRh68uloJiFfCLrY6cY+CGAvPb6kw14
         iMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730072724; x=1730677524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtljyS7+qHdxiJQ5mOubr30PqKR+Wvu0qWR7WolPags=;
        b=e3btzpRRLbCiNobYQ0gD9xFF0xi2ky8HzftBm760AZAnnxanqrz7nmCY6mqO2v6mUt
         CyFtl6qNTm7AQXOvVQ/S/fGr3g4L8ouxkiVZiiqb8V3R4wVvy9EEHZJvGHQuuXfcAIYm
         IIWRj2kPAU24MHt2Q8lSXFXH1uB7rWYuus5nhmgDSXLrij/6YYqrcuyVF2GA1O7yVkep
         N7oaubv85QIfIq21d7ZXaMk41Ht9pTdcVFnRmpm1jYjONxfPhUixOjjhE1L5VvS1lBUF
         Q1clVvOrpZKCrOLRGczCdU/Rv1r872Bel4mqpx2SgMhVdJYlS6V9sPU8I5hdOONd73RV
         Xefw==
X-Forwarded-Encrypted: i=1; AJvYcCVxdlxCg/4LKqGX8qg2H1BGq1R/3/LQLt/ZlYbw+ybb5GFRtbdJTj5v2OQ7eiRFvmBOpD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzNv6Ty4WC0bERq0V5e9GmkKAt6zpM2Eds6V5hIcKT/6eEhfs
	ceA5/fxluzuea8weidQ2E4jtl8wpeAzj9HB0FKnEIj1W8d91s9TOzNUJfE5B2bg=
X-Google-Smtp-Source: AGHT+IFXxXZ85HQfWrDhtyzLSkS8+ZFvB4QJwFAfGxYA8Lbpsau5eZn5CdFJWrZAW/X7ZS+HuC5jhg==
X-Received: by 2002:a05:690c:ec7:b0:6e3:39c1:1686 with SMTP id 00721157ae682-6e9d88ed1bdmr59979997b3.9.1730072724186;
        Sun, 27 Oct 2024 16:45:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bdbf92sm11904537b3.37.2024.10.27.16.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:45:23 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:45:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Message-ID: <Zx7QkaQ5IKxQFskK@nand.local>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
 <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
 <20241023215618.GA821188@coredump.intra.peff.net>
 <D549EIKDKGDS.2AETZLT4RTB44@ferdinandy.com>
 <20241025062438.GA2107756@coredump.intra.peff.net>
 <D56XI8GBH2GF.3MP02MGQGP5M@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D56XI8GBH2GF.3MP02MGQGP5M@ferdinandy.com>

On Sun, Oct 27, 2024 at 11:07:07PM +0100, Bence Ferdinandy wrote:
>
> On Fri Oct 25, 2024 at 08:24, Jeff King <peff@peff.net> wrote:
> > On Thu, Oct 24, 2024 at 08:48:29PM +0200, Bence Ferdinandy wrote:
> >
> >> > So I think rather than "branch --show-current-remote", we'd want
> >> > some option to make "branch --list" show only the currently checked out
> >> > branch, and then you could apply --format to it to get whatever
> >> > information you wanted. Something like:
> >> >
> >> >   git branch --list --is-head --format='%(upstream:remotename)'
> >>
> >> Thanks for running through this in such detail! This would be more widely
> >> useful for sure.
> >>
> >> I'd probably call the flag something like "--current", "--current-only" rather
> >> than "--is-head" though. "--is-head" sounds as if it would filter --list but
> >> not necessarily end up with a single entry.
> >
> > Yeah, I think --current would be fine.
>
> I was looking through git branch and there is a --show-current option. I was
> wondering, would it not be better to teach --show-current to also obey
> --format? It would avoid having a "--current" that only works with "--list"
> besides having a "--show-current".

Yeah, I think that supporting '--format' specifiers via 'git branch
--show-current' makes sense.

In the interim you could do something gross like:

    git branch --list --format='%(upstream:remotename)' \
      --end-of-options "$(git branch --show-current)"

, but... yuck :-).

I think the right thing to do would be to teach 'git branch
--show-current' to support the full range of --format specifiers. And I
think the way to do that would be to treat --show-current as a special
case of --list.

In the existing implementation, we special-case handling the current
branch with --show-current via a separate code path in
builtin/branch.c::show_current_branch_name().

It would be nice to change the implementation there to pretend as if
the current branch as the pattern given to --list instead of handling
printing it out separately.

I think that would be a nice small-ish project for anybody looking to
get their hands dirty in the 'branch' builtin's implementation.

Thanks,
Taylor

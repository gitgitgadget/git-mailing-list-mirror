Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C377EACD
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137255; cv=none; b=AtQFLmGyB0S36dweZKhYdKtVxs0+454MyW7B6hAQE2iCNDEQHyaMPwaHfmfAlvNlg0CwCFLjlL4gz/oz7c6chrnuudMW6DapUIWJokptl0gCZUwRE6K0Wt+jQEngiG9Q5OtBoA5ze6w1DqJhL3mIRvQvBzxrKehZh3/USEre8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137255; c=relaxed/simple;
	bh=TOXLJEyP76u9XsdsIFxbS/xbune/hJoQQXxIOeUR0Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhMskXRq9Py6LLZsmtr1dkROKb15aP4DX1EiGmo8ecK/bLgrqr5F4ylinPKw1l4vfBDXy0GdK+VFj2bx5bHiQjSJ+5ql2+6mOzm5a/6qPxeFA1QW+CA6kO9iflxeBhklCs7Kb7RFp3QHFSmg4VAY1FuH4DIciSVzcc8sdbRnc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=glkVBoWZ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="glkVBoWZ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6353ff1a78dso2468692d50.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760137253; x=1760742053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTR/KvBhh1/3ZWhqEEm6CDNx/eeYjWMgr6rj41rrI7E=;
        b=glkVBoWZhu9Frp225NfsN9Cyrhs+bVcHWT3L649oSi98uoxIcm41OEYG69ByH2MRDX
         Vt1dg/rFfoAxytjEV01Jb3SB7exyK18gk9QSDvL2jV9WNHlvtdShoYOEfxTz5CATWxBV
         eu8vGsD0sGGdY3Qa11eGmdIQI4YaDrlpwuJJ82LlxDjnwOeywykMy9S4RF6cUcs4bUhO
         /thZRD/0VRf/WIu1+uXplGFVFE0RFIPR+27/3r2gOxoNjoGiiD11WErdCRHWNabK0mEp
         s0v8l8rx3YpodbGEKurWW2KUU5eIvwQ83W6dB7qe/Sd7NXLriV4qIQK0nZGCCLFlwren
         z/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760137253; x=1760742053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTR/KvBhh1/3ZWhqEEm6CDNx/eeYjWMgr6rj41rrI7E=;
        b=XP+ZsOiuenuZgFFZf2QxCpH1d+pszk0iE6HZ8zlhTM4/jOMRjDl3Lga3Gw/xXR150S
         FWRJUCbcUvUKlpiiH3fT8Zpy78cYt52fUZu8LDgXtUZfmeq1ZIVcQndGbWM8L/hJdVvY
         PKHB6xUVb9HxlC9FZLK4CWNF2DQajb1DWPJu2+xTkfDqInjdj1crEguoNevRD0D+kn99
         3NHHRI+IXFfmBw1JOjQHlyRyYGeRYxFrw+85xpQ+Zo5SBZ3KxhzjGav4EBpxXhBQKSnF
         nEuI+zJKlz1MmyHT04kxj6fYYxgIqbBJmG02bV8aN8CI1og7q4ABZiMBvck4RRvW533M
         XPZQ==
X-Gm-Message-State: AOJu0YyprJzZCl8raq4fc7GQU2snXX8YeB0VIDBVOSBeoT2LybidFiuJ
	5/f0Q3xlyQ+V8FrEdHXJQ/+9d+yrgC4XQ0XhRS8NF4CGOF8SHuj3weiXU49y92tyGVo=
X-Gm-Gg: ASbGnctuvqWNEz+k4D1Qeb0uxYn2o5hPUSUJIT7vIXRwf/+sypCiJ1rqB0TpzdiOjvO
	mzN2E/AVn5ocFqnLAKHherAVSWN5zaz+x3eSpv7LbgoUjExSvlsEQUtWXfJ2GM4jNrjZ7A8DYlD
	5/kAcLcdNiZ7mkiPLq8tlAaS+v1dd5PrJXZBqe//MXbGyuPn+LhPFepUz2fPZlEu/GmNKU+UkdK
	YJe9ANoasCMRU8Cl3GGttGOAxI5tVklKQKteVbXIjf/eanbSrcnwWn3whDdGmWSHK3JlO5PHE5r
	pF89PRuWRr5kUx5c0H5Ctunuom4qe7MoLgF6rW59NbkJN7Cl5nykQe1Yf9Ip/p5/aCz26N0Vmhn
	oOSJ4KDLwMpUtCb6+9OE8vOYOAMLIdLIS9+oInl8V2Hj9dIUQ7Ou8z1kuL9Zkf9DoMNojzo/ijg
	aHgakgqL1+iivFbb345r/YyCgesCrG98Ti0+qdeL9NIWIA
X-Google-Smtp-Source: AGHT+IGaTgDPSqyTs48w8HiItO8rPyCFH/qAu7g3vXLpqsdF62XS8bcEBztbbr1uM/fAlyqW7VWEXA==
X-Received: by 2002:a53:ccc3:0:b0:635:4ecd:75a4 with SMTP id 956f58d0204a3-63ccb8ef453mr9741214d50.50.1760137253186;
        Fri, 10 Oct 2025 16:00:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd95f5485sm2069145d50.30.2025.10.10.16.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 16:00:52 -0700 (PDT)
Date: Fri, 10 Oct 2025 19:00:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 27/49] builtin/repack.c: rename various pack_geometry
 functions
Message-ID: <aOmQI+hpd9OlN/It@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <dd67366476172eb1b5b0d2bb2a4dfe92b96b83ba.1759097191.git.me@ttaylorr.com>
 <aNsUnfRPi8cYwGkm@pks.im>
 <aOV6SaGhyHYsU3Bu@nand.local>
 <aOXn9Vd6t_xOjWpQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOXn9Vd6t_xOjWpQ@pks.im>

On Wed, Oct 08, 2025 at 06:26:29AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 07, 2025 at 04:38:33PM -0400, Taylor Blau wrote:
> > On Tue, Sep 30, 2025 at 01:22:05AM +0200, Patrick Steinhardt wrote:
> > > On Sun, Sep 28, 2025 at 06:08:54PM -0400, Taylor Blau wrote:
> > > > diff --git a/builtin/repack.c b/builtin/repack.c
> > > > index 18c3df7200..2ce1ae3364 100644
> > > > --- a/builtin/repack.c
> > > > +++ b/builtin/repack.c
> > > > @@ -332,7 +332,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
> > > >  	strbuf_release(&buf);
> > > >  }
> > > >
> > > > -static void free_pack_geometry(struct pack_geometry *geometry)
> > > > +static void pack_geometry_release(struct pack_geometry *geometry)
> > > >  {
> > > >  	if (!geometry)
> > > >  		return;
> > >
> > > Okay, this function also gets adjusted for the new naming schema we have
> > > around free/release. Good, but it might be worth it to point it out in
> > > the commit message.
> >
> > I wrote the commit message to be generic to cover "various pack_geometry
> > functions". Did you want me to be more specific about which functions
> > were renamed?
>
> Not in general, no. But I felt that this method here was somewhat
> special because we not only rename to have `pack_geometry_` as prefix,
> but also to use the correct verb.

Aha, sorry, I see what you're saying. I'll make that clearer in my local
version, thanks for suggesting it!

Thanks,
Taylor

Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E261D223A
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392415; cv=none; b=Enq06+P94w3AKyzbJixFayXQLUv9ni69Nxde00ju8K3uiUontq9OuY7v0ze3IdzYlPSUjJqyDRY0HbF7coXtSTtgBYPRfdsQvIpkNMaLIQek8KjXLFQXwpUiSiWApSEWq9B4rnFtCPxT8PMUX9KI4FyhIy8Z5CvBScUoevwfefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392415; c=relaxed/simple;
	bh=HGYilpS55BkIEyhObr8iP+LzBRRrygt05ugr0mLeoR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8G9AlXkbfSgsCjm83VChBdQSGtlLi1Hkhr0N3hUcOp9ll/8F82mu+nzTIfOGUc7ObpNyEn4qTMrNR/n17JvLynI6Le+Jyr13d3klonY9zRCg7VWGZ8k1JhT+RqY2lrVbvHcEHYR2jB4r7Ipw4MurOZRPTk+9A6/EpuB5q8cMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lvZxdzhq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lvZxdzhq"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b4412fac76so45760067b3.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725392413; x=1725997213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGyx3uTqVEOxu7LJC5JUmrjtvbBJHgo+hVnM9OlYyko=;
        b=lvZxdzhqeGIAoDL8HKTJNDaremvYc3oHqG4gBLLg2O91vl5Uqq9tD+zMWyxDylY5rH
         P5C8GxIan0x7oRFVb2wj9MdsRgx+v5icxZL2qquJxFNZO+zAxgZniw25isk9fr1TYrXH
         6dPv8jwvzsMi6NVOzViERkcAoqgvaXX3lqt9WShm7h4dof5JpJdxY45E0zd4xu7fw8pr
         08DgyestCb/clUlO2m+jWq41D5zx3jlPW9rh35258Npe9Tb5diYLsTjLyvlLTXKPNbsb
         XSwuuSiiVpzlgLuVuuFplhquwRCx858/AWvo1NiY5Mi5Kw+dVDzJqd/tnwqHvoWsGGpK
         THhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392413; x=1725997213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGyx3uTqVEOxu7LJC5JUmrjtvbBJHgo+hVnM9OlYyko=;
        b=CicfX1l9VzC9sKvGmLrWFGUEKye2VCi2ekNMUI1uilfBvdWnMMTqhONlCUP0BqWZ+1
         +qFhfxe7esd3kWo9PicY5Bvk5Y4+jeBxaukMcdZNxorPaIueIfGqhMrp6ZFlSc9XwNif
         fouzkkkN6veZk93GmNFmMwRHGfCdRoNppP6pIYJBYxZlNE+eg7iJX9VI+2FvGgZffxNa
         dAwACi+lNh0TRfcWwhp080W3V0tRQbhPi5mWMFK1g1hIWFtv5j6mG0qDpwSu9ngZ3kz3
         WhLo6IAzux1oNqFstasreEzTM4vwS4zHIrvNj7KOP65/klq4Jn9gY5gU/gUo6JL1Brop
         vVeQ==
X-Gm-Message-State: AOJu0Yx2piSpyUG3F4Q14ofhdATGnAW/h63sFcjbY7RX/lknPSHDw9vt
	sO/AovLl6Vvedt3w3/Xht7KxWIIeiHhojXVshmDFXZBTjUB+J736edlJ9MX9vqZP0HfZkiCUCCX
	6nYE=
X-Google-Smtp-Source: AGHT+IFI2aTGnP01x+gJGSR4IYlU6QZzS6mZiHWmCwJfxVJECm2WPILJvYXzFhTUOGMqe6XShrfbuw==
X-Received: by 2002:a05:690c:102:b0:64b:4a9f:540d with SMTP id 00721157ae682-6d40f9286f4mr141556507b3.31.1725392412834;
        Tue, 03 Sep 2024 12:40:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d6d99b0b1csm9642197b3.109.2024.09.03.12.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:40:12 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:40:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
Message-ID: <ZtdmGwuEgOdLCglF@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
 <ZtXAhP69zu7cDnsA@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXAhP69zu7cDnsA@tanuki>

On Mon, Sep 02, 2024 at 03:41:24PM +0200, Patrick Steinhardt wrote:
> > This commit does not actually introduce any new compile-time knobs to
> > control which implementation is used as the fast SHA-1 variant, but does
> > add scaffolding so that the "git_hash_algo" structure has five new
> > function pointers which are "fast" variants of the five existing
> > hashing-related function pointers:
> >
> >   - git_hash_init_fn fast_init_fn
> >   - git_hash_clone_fn fast_clone_fn
> >   - git_hash_update_fn fast_update_fn
> >   - git_hash_final_fn fast_final_fn
> >   - git_hash_final_oid_fn fast_final_oid_fn
> >
> > The following commit will introduce compile-time knobs to specify which
> > SHA-1 implementation is used for non-cryptographic uses.
>
> While the property we care about in the context of this patch series
> indeed is that the second hash is faster, I think the more important
> property is that it's insecure. If I were seeing two APIs, one labelled
> fast and one labelled slow, I would of course pick the fast one. So I
> wonder whether we should rename things accordingly so that developers
> aren't intrigued to pick the fast one without thinking, and also to have
> a more useful signal that stands out to reviewers.

I tried to come up with a different name myself when writing this
series, and wasn't happy with any of the others that I came up with. I
thought of "insecure_init_fn()", or "non_cryptographic_init_fn()". The
first one appears scarier than the second, but both are mouthfuls.

As a middle-ground, I updated the comments to say "fast /
non-cryptographic" in places where they just said "fast" previously. Let
me know if you think that's sufficient, otherwise I can try and come up
with some more names.

> We may want to apply our new coding guidelines around nested
> preprocessor directives, which should also use indenting.

Gotcha.

> > @@ -222,6 +249,21 @@ struct git_hash_algo {
> >  	/* The hash finalization function for object IDs. */
> >  	git_hash_final_oid_fn final_oid_fn;
> >
> > +	/* The fast hash initialization function. */
>
> Providing some context here why there are two sets of functions would
> help future readers.

Very fair, will adjust (as above).

Thanks,
Taylor

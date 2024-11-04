Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FE376E0
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733506; cv=none; b=fZAGmm88RJRQHKE1HkincYt3mL+6rTjDvBM4Qo7luS6gX/KuhZUD9MNjUW/UdxM6BkkMW66IjRH3guFd/8TLy+4FFXYn9dcgiEXpnyzfC32Xzfidar+QN0tNHid6/256CWrgfXuQ096fhdoPmaH4pmUjNOTsmv0N8C/OpdwJodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733506; c=relaxed/simple;
	bh=u9NdV20eL69s87cXB+3DV3NrJOoOLXmEgLsnH13nP6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRqBTsO7WuhwDw1qXA8ywT3s9HrBILplSvxSr519Ejw1rn/mia4p9Zy26asx7zI4L0DBqxvTHfi85CXRBjccbrjPzbFUzxS6invgThzDe+Qm3U34OXXoEKgJxzECc91MLvlgfPy0CphMBW/HEnSafTA9NSod2ktEXwOh2Bn8R1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yZNE9xxg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yZNE9xxg"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea8419a57eso15608177b3.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730733503; x=1731338303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn6b2TEyzf8foBEH4/22bwr5Ir6kKxaFWVFYQCScOJA=;
        b=yZNE9xxgCZso3vq4070M4yXZjFRDoFA7O/yJItYjLIIyIuM8NemHOzjmxQQYl5FwZ2
         EGnIwp9tgboBQ3OtVsKOr71u5q5zxgk/s2xJ4NYHba3sQ0+N8co0dOJ+RtoFLJ4SI7Du
         Svw6P/R/IRMpMihCh4jVTEI2e6uLo4Jc9h86q909kri6Jbq/clj3vWN51g0l31sX3n49
         144UYx99vG7RPCs2SasjjI1N9aHQf51EJ01sgJpBDRo702nOlEqNkQsp70aAoK76IIOo
         ntDwYEqGuTO3V7ATBgwzR4Hs4PmB4JI6EQCILByD9NZBHr+X/Tfwu1kSevvKdKWXcOu4
         ++Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733503; x=1731338303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn6b2TEyzf8foBEH4/22bwr5Ir6kKxaFWVFYQCScOJA=;
        b=lWVRlePggLWFdXjd3KjNUbyKeMMRLTNlUB5wmUqodJOVCJH5LyNrLQJhHiFrm4nlbU
         U8TonAnnXr2u946gLD1ou0N3xnYt3yxwrZAxWJHUygrsgy2yOsBoaN3DaFr2VrlaoNf2
         kybjSFYqXmmSNdFt4jlOW2Preo89oibrgFXYFna1dhIWY0JWo1Wkxi+J2AIB/GjCLFxe
         y+1KBU7f+NHuzWDKcU+8wodN9CaXeNgNyrBV4QhjErt1S7xvF8WLT6J8gvNuL7rXGAeN
         66PK6yC2XkdDRqbCWXpLXw8gK+3BybswT1NB4K/Nx8MguVOHDgjoIw7khUTd5RQ7edU9
         2bkA==
X-Gm-Message-State: AOJu0Yyynpah4NgRx6GBb/q4EgYKGA5XkHjEKInB6q6HDR+yrNH3axdI
	2pYmSY09VrWZYVsR2+mTpTEnfDVQvKBBcMVMQ8XTZQizRC0UNx5etgBvD2uStzk=
X-Google-Smtp-Source: AGHT+IH0gZLFDmiXdc9oJCcNfOpOOTdrbRizIUiW/1WR3IngCHN+JQ1TVn34kvkQRgWjttAwjggnjQ==
X-Received: by 2002:a05:690c:39b:b0:6ea:408a:3aca with SMTP id 00721157ae682-6ea408a3d83mr165344487b3.12.1730733502544;
        Mon, 04 Nov 2024 07:18:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c459f3sm18091137b3.95.2024.11.04.07.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:18:22 -0800 (PST)
Date: Mon, 4 Nov 2024 10:18:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZyjlvNJ4peffmGZ1@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zyi7PA2m2YX9MpBu@pks.im>

On Mon, Nov 04, 2024 at 01:17:00PM +0100, Patrick Steinhardt wrote:
> > I admittedly have a hard time squaring the benefits and goals we have
> > with Meson with the cost of learning a new build system, and/or moving
> > away from Make entirely.
>
> I guess this depends on the exact persona you're optimizing for. There
> are three main personas involved here:
>
>   - Long-time Git contributors. I don't worry about that persona too
>     much. Folks in this category tend to be highly skilled, and they
>     should not have much of an issue with adapting to Meson.
>
>   - New contributors. This is a group of people that I think would
>     benefit from Meson. They get integration with their favorite IDE,
>     have easy ways to discover how to tweak build instructions and can
>     use standard invocations for Meson that they might already know from
>     other projects.
>
>   - Packagers. This is another group of people that would benefit from
>     my point of view. This is mostly because Meson has certain standards
>     for how to approach problems, and thus the packager would know for
>     how to handle things. They don't have to manually track build
>     options and changes thereof, as these can be easily discovered and
>     because Meson will error out in case invalid options are passed.

I appreciate your thoughtful response to my concerns here. Please feel
free to correct me if I am wrong, but I think the bulk of your argument
is captured fairly well by these three points, so I want to focus my
response here.

Responding in turn, I think my feeling is something like:

  - Long-time Git contributors are going to be the ones who will most
    frequently use the new build system. I am definitely sympathetic to
    getting too comfortable with our existing tools, but so far in your
    response I have not seen a compelling reason to switch the project
    to use Meson.

    What I really want to say here is that I don't think we should be
    over-correcting on things that we are all comfortable with when they
    are indeed not the optimal solution.

    We can and should challenge those assumptions. But I think what I
    see here is us challenging the assumption that 'make' is not the
    right tool for the project, and (at least personally) not seeing
    that it isn't.

  - New contributors are a group that we should be optimizing for, I
    certainly agree with you there. But I think there are a couple of
    points that your response glosses over:

      * New contributors should be telling us what build system they
        prefer, not the other way around. If we are going to switch to
        using a new build system to better accommodate new contributors,
        it should be because either (a) they have told us what doesn't
        work with 'make', or (b) we have a bulk of evidence that new
        contributors cannot easily build the project.

      * New contributors do not interact with build system internals
        nearly as much as more experienced contributors. I would imagine
        that the vast majority of those interactions are simply running
        "make" or "make test".

        You mention a handful of other niceties that Meson provides,
        like language server support, but I am not sure that I agree
        those are (a) the responsibility of the build system to provide,
        or (b) that those needs aren't already well met by the vast
        number of existing tools and IDE integrations that can work with
        ctags.

  - Packagers are something that I admittedly have less exposure to than
    the other groups listed here, but I think my feeling there is
    similar. While they are more likely to exercise far more parts of
    the build system, I think we should also only be switching to a new
    build system if there is evidence of significant, unmet needs by
    packagers, which I have not seen.

> > I feel that if we are going to pursue Meson over CMake and/or Make, we
> > should have a clear plan to either get rid of CMake, keep it up-to-date,
> > or something else.
>
> I fully agree with all you're saying here. Whatever the solution, the
> new build system should be a proper first-class citizen and should be
> exercised by our CI systems such that they don't silently break.
>
> I also agree that it's going to be a hassle to maintain three (or three
> and a half if you count autoconf) build systems. But I don't want to
> break any users out there by dropping everything but Meson immediately,
> so I think we just have to accept multiple build systems as an
> intermediate step. How exactly that would look like is certainly up for
> debate. My take would be:
>
>   1. Adopt the new build system and start exercising it via CI.
>
>   2. Drop CMake.
>
>   3. Drop autoconf.
>
>   4. Drop Makefiles.
>
> This should happen over multiple releases such that every step will pull
> in additional user groups, which will make the new build system more
> solid overall. I could see that one step corresponds to one release
> cycle, but I'm also happy to adapt the pacing as necessary.

I have a hard time imagining the project ever dropping its Makefile
entirely, if for no other reason that make is available nearly
everywhere that we want to build Git, and the Makefile is the product of
nearly two decades of work to make it compile anywhere.

If our tree really is going to have a Makefile in it forever, then I
think adding Meson (even if we remove CMake support) has many of the
same challenges as the state we're in today "supporting" Make and CMake
in parallel.

Thanks,
Taylor

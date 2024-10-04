Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D8231C9F
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081348; cv=none; b=hhUmxTmy5Lzj8NP8D9LNUbrdabfe6AaxuXFlFQp0Kink1DI+P4+Oo8S+B6oEh0/IzJ8U8PtoHPMmJs8Vtj5IMyN3x6gJkTwLOAwAdj3uxTmFDzIdumOYtA/3fXVbi/xe62BwB8bKq71zmP8soqPIc4ciu8/MXUnSwgnRZaEOYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081348; c=relaxed/simple;
	bh=MCZJzZE2Vr4HVyuBf9K5YnhEkdTL4pNWXjY4l4Wpoog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNgAS6Zm7aF5331o3Lr8U9qQ2jvteVfoEBgGjejUMqcU2451xG8xmiuZEznO3oZOQzclFkkZHGpTo4SGCgjmPwMwWA6/QQjpw+zbSp/jP1wZZGtd/xK7hfjUCavvjduqxWWPwuaTpY0HAuGeSRiHVHOA0V1mpnew5Ql0jFicUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tIWilje/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tIWilje/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e129c01b04so22828427b3.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728081346; x=1728686146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vy7Emusb2cPJMnYbtW6vbo1aJdNvlkUkVlUD/FC2+UE=;
        b=tIWilje/6hflPCoUQM0X8FznMKwHgWYNBtrS1fEypknwGeHdSVfnagDfNXBkCIkRdv
         ZyCh2PSWdOgQlkbEPngSugeRykLWEMrRDg/SVZFWnM+IB6Y4xJt6KZ5VugnBpTIxZ0W3
         RMPw85nWJ7o24cjbleCkXejv0KzglgCc5WgHfYwak/9qV4JUgHwunT5RVEhECYUzn75y
         P3IDsctg2l4DDSEW2RXIe2XNN2QiOPgDp7IrKbg4HiEjxcUaeNO4ceAK0Uxttucv1Nth
         nQrD0PjDuWjwkD9guMKIUhAnVAJVkUnYvp8yyhDW43lbuOASwMXFYbGu/fxdu9yjSIe0
         W0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728081346; x=1728686146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy7Emusb2cPJMnYbtW6vbo1aJdNvlkUkVlUD/FC2+UE=;
        b=Cq3ZxUAupoh2Pwblac8870MgPpf8V+CezA89YjhjgU2id9/GUxJb6Ri0lkbU61Yp26
         gtE3vTGgOsM9djTY8o/0Ivm++5sFWop7GAkarT7TuhDAW07tnOLiX9QasXuEyKk7vn0b
         VvNTTbclVPsP7wTSOTujbwpVEwGLIafEywY2WU/mWU+7zkxi2JEn3hlGfMtySrhLwf/p
         MgJqV7QcgA2k9qXvcYhjkaXhSx5cMDdVVNbmgViFdmGhWSWCNICCDgfbhxTAL8kICoRz
         NY51n5SqkHk0Blr7zdtLfvglJoz74NBUNnkteC0UFwIe2mIpIsKXouXzh6L2n5GRYTqR
         DENA==
X-Forwarded-Encrypted: i=1; AJvYcCVn43Oj09+TWgeM1P/UlZNgY4ihnMCQ366uaDw00iYhzwSGJ5Kf93dhD44myJ0cX5YSjV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbePcWcWZ0UFDsktU+l7btmOKcWw0Lx31kSO1ih/yxKVEfiO4
	Yr1w+anoPp7zK26I/CMSNMpbr2rVqHO3rz2OTUPMsVbCFvWx9Zm29R0AwLw7QB0=
X-Google-Smtp-Source: AGHT+IEB+BAbwvvvohavn3oQRX7a6Wjs6nA3bd40SlbhyCt5K38iYYEPTpyN1Mr5FwOV/7z2T30ykQ==
X-Received: by 2002:a05:690c:fcf:b0:6dd:d2c5:b2c with SMTP id 00721157ae682-6e2c6ff685cmr46287727b3.4.1728081346135;
        Fri, 04 Oct 2024 15:35:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9377b16sm1200387b3.30.2024.10.04.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 15:35:45 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:35:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwBtwFeVYmu6/Sc0@nand.local>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
 <ZwAYccsboGIhGVIx@ArchLinux>
 <xmqqmsjjereb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsjjereb.fsf@gitster.g>

On Fri, Oct 04, 2024 at 09:58:52AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
>
> > On Fri, Oct 04, 2024 at 05:22:27PM +0200, Patrick Steinhardt wrote:
> >
> > [snip]
> >
> >> There are two maintainership models I can think of: either a single
> >> individual or a group of people would take over.
> >>
> >>   - A single individual needs funding. The ideal situation would be if
> >>     that funding came independent of any of the large forges. Or
> >>     alternatively, the big players in this context come together to all
> >>     pay into the same pot to fund that person. In theory, the role could
> >>     be elected and serve for a limited amount of time so that overall,
> >>     the community is in control.
> >
> > Well, I think we cannot easily fund a single individual. It it is a
> > full-time job, we have to also pay for the insurances. I don't know
> > how to hire an individual in an open source project. But intuitively I
> > think there would be a lot of trouble here due to the laws.

It is definitely true that the Git project alone could not fund a full
year of the maintainer's salary [1].

> I think the model Patrick has in mind for the above is like how
> Linux Foundation hires Linus Torvalds to work full time on Linux,
> while the Foundation is funded by large industry players.
>
> Git has become important enough that such a model may be workable,
> and that may make it easier to maintain appearance of impartiality
> by whoever is being funded.

Sure, though I would add that my personal feeling is that it is a
possibility, not a requirement, that the maintainer's funding come from
either an independent entity (like the Linux Foundation) or from a pool
funded by industry leaders.

I say that only to point out that while Junio is employed by Google, I
don't think any of us would doubt his impartiality with regard to the
project.

I think as long as the maintainer's employer does not unfairly influence
the maintainer's decisions on their behalf, then it is OK.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Zusxcweod1O88h7j@nand.local/

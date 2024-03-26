Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33601272C6
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486680; cv=none; b=u8V0DPJuO1mkBSDQzYWxyCv9+xqooHXQ9N+XtXIjHOfvdC3rsEThOZTKKSkJyEeTeu1N4K+A3ERZPu6VxJamC/eNjGZ/dwRpQRjkIdq/EcbmbpXkrniiiF7IN0Y1bWGL/tMpOJrGZE61A1hOMMW3/Ac8bx7arEBuTTRLoxh+wjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486680; c=relaxed/simple;
	bh=aQDXEA21Lm7V6BmaWZ21T6EL93k2go6UyeE4LHtMYTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4x7awn6iBZ+Afbwmf++7miAZCMw24DW4C2RGLhvLGIU9fxUIX1kKHVxdwvO6T3IjJBa3EcbqkY7bcGzNtgTVvQX+9sqVcTdD61f0oORvj5CpFUyyubEjQekqDTLh6vzZPywdy12F8k+6gRa0CCBfM/3Y4Pl4SGLNS5q9fsHmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NQTd5MG+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NQTd5MG+"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6964b1c529cso51670976d6.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711486678; x=1712091478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HegFSS9WWCNPUg1A83Qo1cv4ngcB+G4N72xMR0XAfxc=;
        b=NQTd5MG+b6XuIokin2MJY0cAypWkI4d748MPGTORiOjngWQjL411pzBiZMjS++m7o7
         IlK/C5uy7IxQ63AY+PYz0en+DbgDQcUVaA4dIYZBrjRCyg1oYJMZzp2ZVFFcFh6yvCUr
         /ycAN/vAfYF3FxAHzEYToyEqPVgc83YiiCTYbSuMVTMmFyMt0jc09kiq1tZanHxGZt/k
         CJVTUpeRBGsxvqHhCiGieQ7FukNdWdSmjrfx63WHMK/Gdno8+Y4OG5vIMhn3HpRaB+Uj
         NFp2bpkMw0r0xAjxsyPnGLf03sFgrBC8MnqOYYAJjYsp5iutZwckCzrmxv8ajn6xXghw
         Z9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486678; x=1712091478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HegFSS9WWCNPUg1A83Qo1cv4ngcB+G4N72xMR0XAfxc=;
        b=oUgsAch/Oc7vQ5fvJzl8ldLvsPvyVGfsG6kdfjzvgom5N7Koiu6NPYVN67DPhs2esy
         NYQH2dZsAeeRPJ0vZaBno2C+Mo0oqesibvICNRgnC1eTGsfQ4170rUrKFIrTovPfTTw/
         VpURWKIbifk09lf/609Q6/NNpzK2ix2ZC2+8BA331fuuAvT2kgx+ushwvlEjeniEF+BH
         9UYRNBH6ZQV683RTGFiwyIRZmeTFpqD/Eg+bZMO2rq3HOteLStPFspqYOneyllvKfIYM
         rnjL5oJ0Ogjh/R6lqc3PoSK3bPF7Jv/p5K9ZF4rc9c9dn1MmH/ZjeJMejJ0Xl+XwQMKr
         hPwg==
X-Forwarded-Encrypted: i=1; AJvYcCUVjQQlAZOVmuQqP8wTzXJZtLe84v2GnZLNmRFlGo9sGbcRQ5mePATCsuVD8qBlrwvNUI+br1AaupvZjldALcr8LmxA
X-Gm-Message-State: AOJu0YylFukbsFmR8w8/QpCKoa66fgIqSLHP9DBCHdTDoigurFmO0KMc
	T4YWN2yqtk/x0LUUY8koOwwiDQ3nSDJZreS7918gkZbPCO2MZO9aTHxrmBLpcCZLA3/JYKMrnXn
	QX/o=
X-Google-Smtp-Source: AGHT+IH4efoglYqI88dP2s7YLAPqVvrNsJLMVbJjXhbB51T0E21jB5ncvijnQWvbpmeO7+AjR7/Qig==
X-Received: by 2002:a05:6214:411e:b0:690:a800:8ffa with SMTP id kc30-20020a056214411e00b00690a8008ffamr3883238qvb.31.1711486677722;
        Tue, 26 Mar 2024 13:57:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u9-20020a0562141c0900b006915269936bsm5528764qvc.25.2024.03.26.13.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:57:57 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:57:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #08; Tue, 26)
Message-ID: <ZgM2zMykhkIAaXro@nand.local>
References: <xmqqle64algt.fsf@gitster.g>
 <ZgMwaG28aoC7Njcg@nand.local>
 <xmqqwmpo90xk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmpo90xk.fsf@gitster.g>

On Tue, Mar 26, 2024 at 01:45:59PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >>  The pack-bitmap machinery has been extended to write bitmaps for
> >>  pseudo-merges, which are imaginary commits which act as octopus
> >>  merges covering groups of the un-bitmapped parts of history at
> >>  reference tips.  This is good for ... what ...?
> >
> > Instead of "this is good for ... what ...", let me know what you think
> > of:
> >
> >   This allows for greater bitmap coverage (and, thus, performance when
> >   using bitmaps) of repositories with many references which ordinarily
> >   would not receive full coverage.
>
> Much better than "god for ... what ..." ;-)
>
> Now if it gets summarized in 2-5 lines, we have something we can
> use.

Sure, try this:

    The pack-bitmap machinery learned to write pseudo-merge bitmaps,
    which act as imaginary octopus merges covering un-bitmapped
    reference tips. This enhances bitmap coverage, and thus,
    performance, for repositories with many references using bitmaps.

Thanks,
Taylor

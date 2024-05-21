Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CA1482E7
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321600; cv=none; b=Yd3EDvtmZEdmNTyXqwcV2KSiNbSWA144yoqy64cDETQmdcF660eQUHsxPy9TneeMUrcSSjX8oJJ01Q0CTPT/dqP7H3yq2XJKpP2o6vNd+PxtxG/+Jum7PCp9jF0b7z/NJEqDMBYcFNI1hx6Mp5D5KKjUfsc8Hdr1I39atoAbaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321600; c=relaxed/simple;
	bh=9S/a/cw3SIcyxkI622DISI8TvQyeWa2Gt9qu3E+rlYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfjllnocLIyrvg+YMSqUUUCyIe78hERSt4Hdr1oaZWNyitJtw28rMs1zOSXuEokpim3K6gWCICPOqMM+IDzdzZn46ZtTo9GmW4TDvGkuT6fKdAWrtsJrrCOTDP9ZMS8ch/VQ9m6+3xowvWWwx5dD7NjLKGGklx+B8NLDosCo+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utw+RArA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utw+RArA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420160f8f52so822445e9.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716321597; x=1716926397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvns8YxT8BVeAbct3Ia6lBx/hp/+hr0OJ0uw/FlzCJo=;
        b=Utw+RArAWCXca4ANayZbiYyHLLg1OEDr+6qjfh8uf2lm34dcWAXT6Fv2pMRNSk7sZp
         oCavqT+Z7Zl72Tjqvynr78MUC7+Y92hSJI8WT77BJjs5M7XC1iFWIL165RU9Vspyk6NL
         UmINoK03p0YoqcO2Aum01BzRedeH7Yx0PN5x5aaIA/avJ1vYb9D70A0v6oE27QBKOMuS
         KlpBUGF1dqgFbeBqQcWuq/oQkmI9mlbfCl2M0ReCAyCM667BD05YVYS/hPtxXCTBP+cm
         Qw7irT5js6cKGXu4efxQ4AluCUyc8bxBMc1JIDY+1H19c4FBwl81D7FuujxLDJ/lNaN7
         O2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716321597; x=1716926397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvns8YxT8BVeAbct3Ia6lBx/hp/+hr0OJ0uw/FlzCJo=;
        b=JWQZa4hjfc6o9oU8GONPQ4XkDao/cStlMXoXJObV4wA3X6Uqal7FjYOdvQlt7laC9A
         x+1Qn1n1W7uribZXcQmchNRo3P45JTzD/Mm8/6sviowOo1IPPo5jQhfUelYqTw4Dg4jp
         cuE/lqXse9iFkwhflw2WLvaVg16rJXxTsG4rgfHCCthsDjWCougYdF7Thyt4+ZS89/b1
         vMcpmV03GEjFeoQ6MVmMjI9VwdjI7g1v2m/MSxZ+nwDaDFdxS1Vc3sGdVflW3Fgv2IE7
         9ydA/jXYCU0DRWvtuxuuqeyOnRuMvVjLDaTfz1F4SiJ9g2lp92ibxxWZODXDWDVd/2Wi
         45hg==
X-Forwarded-Encrypted: i=1; AJvYcCUxd4vbv4fXpwZjf/fpPWo1btWG/cchVUaZfxfY1maARiTHNBFz/h+Q4sQc+4WIlTUU7zR8AEX0K7mhzxomEWNBdrl4
X-Gm-Message-State: AOJu0Yzl0CEVWrCz/St0/FTOezOq/u+hPAtP9V/5xioqUZQlwT38BouH
	9glRXStLIeduxb5curfhEBqVHM/C7E5Oz+fb4w6AcHqlKgEIwLlSaDQfmw==
X-Google-Smtp-Source: AGHT+IGHpFkqWldqydgD8bboukKXvJqFK8Lzw0HNlujebpYC8LWPCqYhuYckh7Sq3ijIBg2Et8GICg==
X-Received: by 2002:a05:600c:1e04:b0:420:2983:2229 with SMTP id 5b1f17b1804b1-420298323e7mr118095135e9.22.1716321596952;
        Tue, 21 May 2024 12:59:56 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201916e7c6sm332518975e9.12.2024.05.21.12.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 12:59:56 -0700 (PDT)
Message-ID: <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
Date: Tue, 21 May 2024 21:59:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
To: Jeff King <peff@peff.net>, Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com> <xmqqh6esffh1.fsf@gitster.g>
 <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240521070752.GA616202@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, May 21, 2024 at 03:07:52AM -0400, Jeff King wrote:
> On Mon, May 20, 2024 at 09:45:51PM +0200, Dragan Simic wrote:
> 
> > > Another, ulteriour, motive here behind this suggestion is to
> > > encourage users to work with smaller hunks.  Being able to scroll
> > > around and view lines on demand (i.e. use of pager) is one thing.
> > > Being able to view all relevant lines at once (i.e. not wasting
> > > vertical screen real estate and making things fit on one screen) is
> > > very different and much nicer.
> > 
> > There's another thing to consider, which makes the introduction of
> > "P" as the new option even more desirable.  Let me explain.
> > 
> > With the upcoming changes to the way less(1) as the pager works,
> > which was already discussed at length and even required new features
> > to be implemented in less(1), [1] displaying anything through less(1)
> > will not leave an accessible scrollback in the terminal emulator.
> > Only one screen worth of text will be displayed, even after quitting
> > less(1).  That's what we have to do, to fix age-old issues with the
> > pager-generated scrollback that easily gets corrupted and actually
> > becomes misleading.
> 
> This feature can be annoying even with current versions of less,

Hopefully, reducing the blast radius to a new 'P' option, will make it
palatable.

> depending on your $LESS variable. If you don't set "F" you'll get a
> pager for short inputs, and if you don't set "X" then even small hunks
> are cleared from the screen while we ask about them.
> 
> So this definitely needs to be configurable, and I'd be tempted to say
> it should be off by default, just because we don't know how the user's
> pager will behave when invoked for multiple short snippets like this (it
> might not even be "less", after all).
> 
> I don't think setting pager.add is enough here. You'd also need to set
> pager.checkout, pager.reset, and so on, since their interactive modes
> all invoke the same code. We'd presumably want a single config option
> (and possibly even one that could be set to a distinct pager command for
> this context, rather than the usual one).
> 
> -Peff

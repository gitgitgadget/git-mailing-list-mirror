Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A5221FB4
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869519; cv=none; b=QOV5vvWmnM+t0K9ykpqq98OWl07q1OOsJzzuPHSrNT7os/f5xFQiP6UV6dXYY/0Kl4Nmk6Nvt7V3ha2e0ogKC/ETHJ3ml9T2uMDonj9EE7LTFWFIZms8uSWBOhzwI1AZNvCfQJljsg4gdKBVUWo/cikiutE+wkU/16DrZhASfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869519; c=relaxed/simple;
	bh=vEjDKOn2nuR0uxH7y++ZDCxdXGURl0apnPMHZEKYq5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnDwVD2f6km114YL7KWk+k/Wsg/WTkAFyzKQbYgQ/9DlMiki8X0W7xRLZggxprGrzmFZEwQzy+bXNkRGeqiSMiGngm7pD3N5LNx8/W+K0QHnIqK4x91t1ac+ajNT4oCLzRPxDmrT/zbpwSd9SZH9+Sp8wkJcA42wDzyY3CKJrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Y7+m89pr; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Y7+m89pr"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-92b92e4b078so281002039f.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759869516; x=1760474316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GH6hPPGZCE9qFa8n7cNRBCuMhtSfuowk0tOBlwVpnO4=;
        b=Y7+m89prGOQZJFQ11ONzBOAmdD2KXHesQjRTQWxUR7GoEBbeLODC5ROpeveLkTamiG
         D4/ASZCqgmb9dcOEFQQY4uFO9zsO8Vh0OuXCf/DGHMuWjp2cipgLtvk+Ef0vj7C5zwxZ
         o02MpteI8yyun7CUvh0sAI8vkonr9NPf4rJgvrq3PwGcm/XB6Vd7HbakY4dm4EcAJxCg
         PDf7GSpsyZ0a02vc2qzroW3p3HU30A2QTr0L5UCWY3ctVU8p/jhvkD7f+V31NNwBWHGN
         50XuxymnjEEpnELTURDcauutkbFSKTnqJekGnsLQ+ltGukkLi5iENaBCQu7t5v9oGa5p
         yJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869516; x=1760474316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH6hPPGZCE9qFa8n7cNRBCuMhtSfuowk0tOBlwVpnO4=;
        b=sl3KpdkEcM3ShqUuAPCe9gnzSzuF8nq8ROIEEMVd7twldDEji+5hCcPThYE7nHRA+T
         JsEKAspiN/weSh/upD0BV5NpjLj57ogi4ginXnak15G8hVABPeFldWwwzUVSi7yAiqND
         tKNAalAUjl1TDCT7IbgINYmu7r2rCK+i9EiMBlk7eyDyktI0Lz+nrf7MMXW9/xmWwb9M
         rcWzFVq4gZIDn5hqsGu9waeb9u5AnU9/2wEIfv/e993NUcX1KmRZ7I4lW9/kAJu0nYJ2
         jRV7Dd68rq+54en5+fdChNwyf+oLHj438KgZp64Pfk9uOM54GDDmHIuK7UAokZiSfI3t
         arxA==
X-Gm-Message-State: AOJu0YyTW49+L2GXzW21jK2d5Co0TPPq53aEQRmlCWFTh5VuEgIzh4Si
	bxKcrtTjkd9UVYUvez3AxkwO3eSq6twuPYMGZprPOnW1sLJaGX+WTN7VLGHQyMIk8Ss=
X-Gm-Gg: ASbGncvwQzE+UAG9IUyR29qcSMMmFRxzwLF+0uSRsYcdypTFUbTq3+1AwCdVnfTp1uT
	SJV/pnrpOI5N40W9+6MyEIy6rNBAEx8ug++BMcZk0QJMvgX69/v7+oSJlF7of+gnQG2IRr3/P14
	k+5SqF0HTo19Y8TY6yCwwDLe8wM2Kr+VBfR/CABw96/TnJCHAMPnhb14fHrSHJ4Pv1Ba4WOhthS
	WFQfEpYO8Vr7Y2u4u17yQstWPSgl3TKwNDQw4T+aq0gjhVeK+LuY1ou1ma/OFkFsx6fegB2/0PE
	BeCHT9QsC/YpQQheiSmOs+/bTUtQU7a+uw9vkFadUkMbuhgOw/fZsFTufq11XRJoH9daIm+1Xrh
	q3o632PejPHQWBuHU3xmP61wYexdxAlFZ9kvnJb0Vn+m6oJxx3Dtm0726XOLQWq/N3iUF/wWhx3
	n/w3rIAMamEjRmeTymkcYLeUOavRSo3kKj73FY0Usyhg5Lp1823A==
X-Google-Smtp-Source: AGHT+IEit9iK+TJ2hf2f6kS0FYq0s+H136PvLRGCAVWXiFzjvnT83fKuvN6E+84ep/fgfeEnIQpwqw==
X-Received: by 2002:a05:6602:2cd0:b0:918:31ac:52ac with SMTP id ca18e2360f4ac-93bd178543dmr85849039f.1.1759869515756;
        Tue, 07 Oct 2025 13:38:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a885888c2sm623635839f.19.2025.10.07.13.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:38:35 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:38:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 27/49] builtin/repack.c: rename various pack_geometry
 functions
Message-ID: <aOV6SaGhyHYsU3Bu@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <dd67366476172eb1b5b0d2bb2a4dfe92b96b83ba.1759097191.git.me@ttaylorr.com>
 <aNsUnfRPi8cYwGkm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsUnfRPi8cYwGkm@pks.im>

On Tue, Sep 30, 2025 at 01:22:05AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:08:54PM -0400, Taylor Blau wrote:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 18c3df7200..2ce1ae3364 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -115,17 +115,17 @@ struct pack_geometry {
> >  	int split_factor;
> >  };
> >
> > -static uint32_t geometry_pack_weight(struct packed_git *p)
> > +static uint32_t pack_geometry_weight(struct packed_git *p)
>
> This rename is a bit of an oddball as we don't work on a `struct
> pack_geometry` here.

Agreed. I made the change because the concept of a pack's "weight" in
this instance is tied to the pack_geometry API here, not an intrinsic
property of the pack.

> > @@ -332,7 +332,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
> >  	strbuf_release(&buf);
> >  }
> >
> > -static void free_pack_geometry(struct pack_geometry *geometry)
> > +static void pack_geometry_release(struct pack_geometry *geometry)
> >  {
> >  	if (!geometry)
> >  		return;
>
> Okay, this function also gets adjusted for the new naming schema we have
> around free/release. Good, but it might be worth it to point it out in
> the commit message.

I wrote the commit message to be generic to cover "various pack_geometry
functions". Did you want me to be more specific about which functions
were renamed?

Thanks,
Taylor

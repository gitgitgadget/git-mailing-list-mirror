Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA611DA54
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2t2mBu8v"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D630DC
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 05:15:13 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77897c4ac1fso52622785a.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699535712; x=1700140512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yk8Cxy7r/klmSuFReWW+f3jxitEczSstfjueCqGbFIs=;
        b=2t2mBu8vWwOlXJE5X1QAlkPeBSqDhDe35/alciIHeFdQLDN1Yp3r3qhOBux0sylv2F
         wCaUTj3wQOl1Tmw6YnP4Cy3e549lmuSeiuqNR5LPmcOw0C+5Bqr9CfRp9pxsSmnms0ex
         94D/Rl/2fX+1YEAJeYxMmCv6lMS0I1A6Rbo0EF3UGFxTSn7IERyj3T2Fia1bgGv49IIp
         7Hv5vG77GZvypKR4k002OVW4CcQX8L2CweOcGTPbX3LT/zsK0so/0fTkSUQRrLvl/HZW
         x1kwDDKKx/AVKIpb2DaE/CKvbnzRdG1ynZtgDxT5byvECJpjT8ehy3vsYn0URjZMwNxD
         K50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535712; x=1700140512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk8Cxy7r/klmSuFReWW+f3jxitEczSstfjueCqGbFIs=;
        b=sJVgTOqc538rKQvK9ziqY7GBtt/2IofqXe4lQHqOa+up7IzjL0y3rP0tH2ooHtVtrb
         SdScum2NsaBIDlBT/2wiJwsLUG5ai4MfU/S6mb6rLi/HwmD8DQkh57bZepT5QRaD8xQR
         pU8Ax24OUt3n05ic4J4ZA6B5vhNtwVtYp/4B/QK6LtEKzEclDsJmMHM6JtNBWKwOVizI
         czIpbCN3hGuEwLDKTGXxaWLJy9VIzjAwipYb27jwLsFH1ny9bMk20WRP/feymbcHX4MS
         R7fpGLWiL+vhoxpJ9c4UY7FzaSE1c5mX9lnguhysYfmqn1AneuIG4hmP0LwJn5Ex1khr
         X1ag==
X-Gm-Message-State: AOJu0YxAUv4o+cK5KaKFXbhpr8XqgdonotrZDluCSkA2MCzqKLv6Q8rv
	dkmk+qAFmBtySmHOi/9z75JvYw==
X-Google-Smtp-Source: AGHT+IHCdOq4fRn8UnjjFjkPKGjkbSR2hGyv8e/+80Er7z3fLHmpPx7wW2bt9v/xdrxJQJmEc8eGeg==
X-Received: by 2002:a05:620a:6605:b0:778:b559:4744 with SMTP id qf5-20020a05620a660500b00778b5594744mr4948740qkn.58.1699535712558;
        Thu, 09 Nov 2023 05:15:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id oo21-20020a05620a531500b0077890c8896bsm1981875qkn.134.2023.11.09.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:15:12 -0800 (PST)
Date: Thu, 9 Nov 2023 08:15:11 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2023, #04; Thu, 9)
Message-ID: <ZUzbX1eiwYuWvkN5@nand.local>
References: <xmqq34xg5ek3.fsf@gitster.g>
 <20231109075052.GA2699557@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109075052.GA2699557@coredump.intra.peff.net>

On Thu, Nov 09, 2023 at 02:50:52AM -0500, Jeff King wrote:
> On Thu, Nov 09, 2023 at 02:40:28AM +0900, Junio C Hamano wrote:
>
> > * tb/pair-chunk-expect-size (2023-10-14) 8 commits
> >  - midx: read `OOFF` chunk with `pair_chunk_expect()`
> >  - midx: read `OIDL` chunk with `pair_chunk_expect()`
> >  - midx: read `OIDF` chunk with `pair_chunk_expect()`
> >  - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
> >  - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
> >  - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
> >  - commit-graph: read `OIDF` chunk with `pair_chunk_expect()`
> >  - chunk-format: introduce `pair_chunk_expect()` helper
> >
> >  Code clean-up for jk/chunk-bounds topic.
> >
> >  Comments?
> >  source: <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
> >  source: <cover.1697225110.git.me@ttaylorr.com>
>
> Sorry it took me a while to circle back to this topic. I posted a
> competing series just now in:
>
>   https://lore.kernel.org/git/20231109070310.GA2697602@coredump.intra.peff.net/
>
> that I think should take precedence (and would require some reworking of
> Taylor's patches, so you'd just eject them in the meantime).

ACK: that sounds like a good plan to me. Thanks for picking this back
up, Peff!

Thanks,
Taylor

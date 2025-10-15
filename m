Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911B2FF66A
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563098; cv=none; b=Xa5SFtq4aI3C0txlqBUXqZOO+9uSA17IJCzsqFaYfWpMwSPtPeTX44mmyle+sDrnNVDaMG3K9mtg6yp+rxmEG8GGNy/ZvQWZFjabIGqNnx6z8sHvwjGEOGhkiq5gqOLrnJnJQcZNEQMiZ6i2e03bVVAjAWIoxYVT5b3cB8/TtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563098; c=relaxed/simple;
	bh=7Q08HWp3P+Whc+FpTt/rki1VYSJ0Y2wkeye25jI8ABw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2HJ3y1cu3BPAgJzM4XkoIJTY9x7O6CkqeDICVUnDqo/TzS/pdRtT3ca/woDiJc6kdXrymlIHS96KKOL0U6sNIy5IM6Qio52utmOF62nNhfajbh9FNCmHcFhFPzBBtQJzRsOuit1Ki35gpGUQGh+0xlEinMBHeOh7A5VraIBwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=c2VV3AjD; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="c2VV3AjD"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63497c2a27dso93157d50.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760563095; x=1761167895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7h3pIYLqzgmQzS03sJJRJ/rKSPJkBZYe7Qqa/2M6cvc=;
        b=c2VV3AjDBveT+RZlL13UHL4vtm7lFt76uZ8fruX6t/fsyj23Wio2D86D51S7AIML/a
         cln3TWyUEtUJp62LurcNVU0maWGyqnPxTcrP81zr9PbALFE+kZHrtSFMF8/Mb+LmfOt3
         r2wyXVIDdvvGPR74nfiDot7iRrCTK5jaEVD6Loepd2yc+J8iZJ6hOoPFWR2c+P0cFTxk
         mfuGZGHJAwkp1E97xepV5/Qq2OurRavA/FvJ3AGLppz4dxYuerHnwkb1u0cjbdyE0efs
         njRbw2hTG7zaaVmbAtvMyEEzYTzQeB+sFtuiU7Bw893ky8gvUj8SYRWGfXpvq5qSPvEK
         wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563095; x=1761167895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h3pIYLqzgmQzS03sJJRJ/rKSPJkBZYe7Qqa/2M6cvc=;
        b=wCQGnDcAQ8CTGChBM14MvPFv80PKkl+0tY3u5HwdFcgDJ1NrMmdAKsVZgSfxZqddCZ
         KqurmRAkahjs4EOVU6Eh3YTqbyO8wbbE9PKEx2VntZnl75CP0XnEcKIFqCuF6w7gm4Wj
         ZavSVZB3c9D6C5QLXP3HJK6lQqPJ4Y9owo7n8jhmXUBRcpcvTGWREfImxztigJ0cdZhn
         yLGp25i/TTh0drtE2JuMxIb2gVS2hXV4qEMFHPYlZQ5EcG1a9K2CXIKC8p7JMgdmb9J1
         NgGqYEq3pY34Zw/zSxvuGbag45a+ZOTcW2Rhw0K1d4P++tu096D/DQNKINkmti0GE7Iu
         9hRg==
X-Gm-Message-State: AOJu0YxNcylX8xmqqKpljxh1SdQ/XYpXAC3LXBGQbfD1L3S8Y1CYNJBa
	9TQm7lZOFmn5UbxUMYdKjc4hFp7diimpRCzsTFgj38X/vrktikeoIVBsgI6q2pJx0CE=
X-Gm-Gg: ASbGncvOtxS7DvUqa813WLXJPCfA4X2dMSKWgoc1GuMd1NHmU0z3PRc3H8EEP9a2T8R
	AP2HHMxoA7wtK9/oCJhvzoVvPul56g5s4cy2qKCfq1fSIKUJ6d+rJWrAQjwJ6q+k9Pmi65chDyT
	6dfQgpxpam8drBTVhBukZuSrwcqEmsd6xYiVKpJ5O/R86qlObJSMszE4f/94nFp/wx1AGrcGNUo
	6+72/J2apODAmP1CpAE2YUPOctjkdhlGopWKf203qxFOPsIITps68a2PUKnbjNqRON45Usx/Nip
	LORXB9IfNod/3DEmfOAdmnh1XME90GubNsam6mtTLM0Ahf1LIYLw7XHgLd++saeTeS42LlRtG16
	+WW3Rf4DGNwKy3YdqG+z/hzMcvB5IX8KIY8FRrTvaM1vsRwHih9UBlcrublPycjxTPllORZgt9M
	rnLCTZgZvwfCRy3rJhCvMQZJLJ/5CHQysFHwmviimdHAzTWqXezqiq+OlMW0VG94hjOfafJHwvN
	Ymwgb8=
X-Google-Smtp-Source: AGHT+IF40Kkag6Foe/UGFCVjkACLqYjLVl+KWTDAum8/Exk3ZfoEGGfoQrV1A9uvnWx41siK7t0bfg==
X-Received: by 2002:a05:690c:c8f:b0:772:3578:2ec5 with SMTP id 00721157ae682-780e1370bbbmr450023297b3.0.1760563095296;
        Wed, 15 Oct 2025 14:18:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cda556e5fsm5853049d50.8.2025.10.15.14.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:14 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:18:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 40/49] builtin/repack.c: introduce `struct
 write_pack_opts`
Message-ID: <aPAPlb1VvhKfcEJb@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <109109618687efeb932bee7dd5882557ab0576f4.1759097191.git.me@ttaylorr.com>
 <20251015102833.GB2250228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015102833.GB2250228@coredump.intra.peff.net>

On Wed, Oct 15, 2025 at 06:28:33AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:09:51PM -0400, Taylor Blau wrote:
>
> > Instead of repeating those arguments for each function, let's extract an
> > options struct called "write_pack_opts" which has these three parameters
> > as member fields. While we're at it, add fields for "packdir," and
> > "packtmp", both of which are static variables within the builtin, and
> > need to be read from within these two functions.
>
> Makes sense, although...
>
> > +		struct write_pack_opts opts = {
> > +			.po_args = &po_args,
> > +			.destination = filter_to,
> > +			.pack_prefix = find_pack_prefix(packdir, packtmp),
> > +			.packdir = packdir,
> > +			.packtmp = packtmp,
> > +		};
>
> ...since we are now passing packdir and packtmp anyway, and pack_prefix
> is derived from those, should the called function just do that
> derivation itself? Or do we expect that some callers may eventually use
> a different prefix?
>
> Probably not a huge deal either way, but maybe an easy way to tighten up
> the interface a bit.

We do this a little further down in "repack: move `find_pack_prefix()`
out of the builtin", which I tried to separate since I wanted to go
incrementally here. But I should mention that that patch is upcoming to
avoid readers wondering why we're not making the change sooner.

Thanks,
Taylor

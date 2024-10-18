Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479116D4E6
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287966; cv=none; b=ZSnKorECTPBjQQqNeNpH7QLcKwXuKDHoM/pEY4ANjgi6PdKiYUEyqw2CVXuyCJkocPxonWuf+Rx9HmvPkufsUkBTyWugwABEKuLDrLyFvPcyua8lZz2WgceCyWZrqeEzbkAoxw+0ypNYkCC76sFt5dKowMjVq552rYMND8RytSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287966; c=relaxed/simple;
	bh=wx8lbYVwWHbgV4ZpoW28PSXlLP6v3vzpncwixhsCsm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS7LYsUqbFZrahpgI3CXJskgJdUUPWhTJ+fdQhMMlUxutXiv5WgAu+tVff+SsEy9yUuTcXJB/14bAZCaPHvwAl7zn/bZcfpDuW8AZCEU1UJ7ZzN+yLAyWM8poxESJoZqqmR8v0NMItsnM+DRmpwSFySkmlF2cX007ZvIK86uIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZiCLjf2S; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZiCLjf2S"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e3cdbc25a0so29724457b3.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729287963; x=1729892763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir2eeYMoQmdL+8vfrUrMrWEyfwON1dRgSdrNFrzL+QU=;
        b=ZiCLjf2SHpmVf1sK3WADp5uppsPXumHkxdnQk7jWFOGQ7k7OT49u8s6titSazZKGKa
         pczQvmaeFFCsh2HQk2zjHOBH38zxYnYkPqc5iIwbQZ/Row7wXooZdZbSb0ksiGzpF4qZ
         hpRoUMEGD2UP1kKo3Bfh8bIa7MWlPlCKLPwbi/WFaIDHZy6/OqraUSMdKnel7hSs3rQi
         ddRAIX0gLfofSiHIlZ1RKAn+z0sI3g6NUXSaDh294rme9IuLv8obRQWDcC2EXYblek4t
         NRoQn3JeSaSlWBI+VBsJ3vZfSFDjY1+dwcwpBuh2/0qImdMPyqHp3b4lHHOsOMgLvyd1
         5I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287963; x=1729892763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir2eeYMoQmdL+8vfrUrMrWEyfwON1dRgSdrNFrzL+QU=;
        b=jH6IIub0nIwlpiiHyK/XxZXe7POFErrBBhjryZcGYG/j7F9YOWCyg2WcPl2mHApm4f
         9s+g14bZTvYG6YFImZhvn5ViC1oBPOYQRN4E5PAr8Uoyq1ktdy3DgpsgrTwr7wh8iOEM
         MTX4qbDZstpPFKhq/yS5vOUerqB5zX3tRX0FSlg4KwqbBw+FdI6I5oZeM8BJ8hy6y63n
         /W5dCJFCLHbOli5VjRcMKQvhjChBbSaXaCdvRxP06hhc3aEZsRtsMxMlMHynEb3P/mM0
         rVapTCJnKA7KNd//AwHNhNjpm0/IeFwGK8EqIPb/28cA4PKCDQQRZEu3uGoLufog9V9r
         Rwqw==
X-Forwarded-Encrypted: i=1; AJvYcCUeY/Q/edIroqRyl8l0I7CdCw+fay1rgcOdz8xvBcSJFKcr4E1N48565xBvggxD1pD/V7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81WmyeQgDfdLrnlg+c8leg5OWVCafHlDvLGewIyglILnG3O58
	8nm7nChFaJwjIr4Lba9572KN2OnjRyr1ZhvTG7oNrx/Q+jF325tiDsNdysY71p0=
X-Google-Smtp-Source: AGHT+IGGsKPD3iQ7r71gsMyX0wHB7GBkNF2ghptrEpm7KcQhMGg+n1w4vZN4zw/oQ8oNdwGwvTmV7Q==
X-Received: by 2002:a05:690c:6681:b0:6c3:7d68:b400 with SMTP id 00721157ae682-6e5bfc8c82amr44165797b3.10.1729287963175;
        Fri, 18 Oct 2024 14:46:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c00e4fc1sm4843157b3.41.2024.10.18.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:46:02 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:46:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Piotr Szlazak <piotr.szlazak@gmail.com>,
	Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	David Turner <dturner@twosigma.com>
Subject: Re: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
Message-ID: <ZxLXGG8+VUWydsle@nand.local>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <ZxAttC1dQUllR76m@nand.local>
 <20241017023735.GB1858436@coredump.intra.peff.net>
 <ZxEr4+sb4DfmtrKv@nand.local>
 <a328b6d5-e604-4517-b041-59db19e1f66c@gmail.com>
 <ZxFblRri8Xo/lGsK@nand.local>
 <20241018043306.GB2408674@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018043306.GB2408674@coredump.intra.peff.net>

On Fri, Oct 18, 2024 at 12:33:06AM -0400, Jeff King wrote:
> On Thu, Oct 17, 2024 at 02:46:45PM -0400, Taylor Blau wrote:
>
> > > Rather not as config file is parsed only once:
> > >
> > > https://github.com/git/git/blob/15030f9556f545b167b1879b877a5d780252dc16/upload-pack.c#L1368
> >
> > I am not sure I follow... upload_pack_config() is invoked on every
> > configuration line that we see. So the first time when we read
> > "allowAnySHA1InWant = true", we take the first path through that
> > function you linked. The second time, we take the else branch, and
> > correspondingly unset the bits from ALLOW_ANY_SHA1.
> >
> > So today that is doing the right thing (it will end with the same bits
> > set that we started with). But under the proposed patch that behavior
> > would change, and the lower two bits would still be set.
>
> Reading Piotr's response I wondered if upload-pack might be using the
> configset API instead of a config callback. But no, it does look like a
> config callback.

Yeah... I was pretty sure that was the case thinking back to 6dd3456a8c
(upload-pack.c: allow banning certain object filter(s), 2020-08-03),
which somehow was already more than four years ago :-<.

> But it does hint at a possible path if we wanted to process these
> independently: we could read each of the config options separately,
> resolving them in the usual last-one-wins way, and then turning the
> result into a bitfield. Something like this, outside of the callback
> (totally untested):
>
>   int v;
>   unsigned bits = 0;
>
>   if (!git_config_get_bool("uploadpack.allowtipsha1inwant", &v) && v)
> 	bits |= ALLOW_TIP_SHA1;
>   if (!git_config_get_bool("uploadpack.allowreachablesha1inwant", &v) && v)
> 	bits |= ALLOW_REACHABLE_SHA1;
>   if (!git_config_get_bool("uploadpack.allowanysha1inwant", &v) && v)
> 	bits |= ALLOW_ANY_SHA1;
>
> That makes the config flags independent. But the features themselves are
> not really independent. If you do:
>
>   [uploadpack]
>   allowAnySHA1InWant = true
>   allowTipSHA1InWant = false
>
> it is still going to allow the "tip" flag, because it's a subset of the
> "any" flag. And you can't escape that.

Yup.

> So I still think we're better off to just document (and of course in the
> long run all of these become less and less interesting as they are
> v0-only options).

I agree completely. I think the consensus here seems to be that, if
anything, we should update the documentation and move on :-).

Thanks,
Taylor

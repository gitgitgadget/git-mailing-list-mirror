Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525CF2F7EF5
	for <git@vger.kernel.org>; Tue, 19 May 2026 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234817; cv=none; b=r8k5pQfL468SpR7zhlK9J1HMhe0OPx3fAyjJ6okH2CekgDJFziaMcuw2xXGn8rH+hfI4vKfexRllbcEx2ji8n2/33wHxItB8NG+h3nDztALGndK1PR8LcVONt/5Z0HvLzbSDqssIpd81oCI+fHiJ65ilitXGHOsIGH0pw6zXyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234817; c=relaxed/simple;
	bh=DibVpD2qi728e+UQ9fibbrxZDCrlCWTV0/C73AxoGjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geSPmOMhzqcb5DrvxcU5faLOcybo8eRec71nGY3HOY7sBJrOQyFX3fdCroCiM+W4opZPjmtkiFurHsr5J6AD9IX0uCeGv6Lx1ZL2o28UEdFTKGfbf6KCibnUbnJZkEUgDp3R84GGZ+WOrqd+ZrQwucY+HJXg+SjAUOtJQ0FU0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fGnSizQY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fGnSizQY"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7cb345cb5bfso30897317b3.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779234815; x=1779839615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbfIi9Ks385gZbmwJPDC7L/cLwDwbo/etQaJglv+634=;
        b=fGnSizQYp0BZ+6RPJWC+frNxWCj4mUT+VIM7DqEcRh4jdk8BJDaDL7lNugVGrkqiV4
         D+LpAUssiLRZQh/Qj7s2+DininS8yuAe7nu3ZWhhl3gIgxIQp1fimlxXt8YQJY6n2Nyi
         xPWQ/OHBN4aI7Y+yaLWVEWSuBGX1o/PdB9H11Gwwdy7OADckNeeRC0h3dUJE1bWYURL7
         2ib9mV9N3FcJmt8PNc+d7Mr04ErM9niVkIyQCtL60y1d3WzlJIjLTUrrNwZgKKnyLpZX
         vlwgThV9fvr7EHbZRWn2RHoWzLUqM7b+lxxirz2fuuczwdvAXHqSo7MSI1UXPRGA9yG7
         ornA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234815; x=1779839615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbfIi9Ks385gZbmwJPDC7L/cLwDwbo/etQaJglv+634=;
        b=o0UuVyI7Ofo+NeDCjb1K0Cu8Rm1yzV+wjJW3YLrfcmpH+MtnJP+az/WJkHDJeSTiuC
         kpU23NAPhZwYMiVsyDE3gZqqxiQYv0A/RTubBKfu9JZ49AAj0c75A7yjfbzR0Uw+S2aC
         fesw6CaydN1xpmbqtTENB2CDGFe2A++VvpA8zp6QbmcnhfZ6cv/AzTCpQcNttXyI0ZU8
         fs8HP2hAc2udzGQln6aVfEIgZAk3MA3SKaq6lUnAdE1H0KKv/xDQHF6jBO+IltRoTeP+
         LWuiNgq8ShQu0HhPY7Z1N6p/4COvsVwylg8GWWTNGWwkoQuvOdgZJYEqrn2k+Zde6vPg
         bTEg==
X-Gm-Message-State: AOJu0Yy7ZK6/3OckAJxJgvHIGe3LL3KhSuJJratHvhP0ayd5rQ5AHGbd
	bs/WnCjPcDQ+9462DLQAR/3q3jeVxS2I3B63752jZ4U0RVBukJ703/k6CsQ9jVlQoyE=
X-Gm-Gg: Acq92OHWkXvPWFe+J4LklkmL47u3XPb2+7MA5JRxNWxN9NYXHnQXxsVKQ1M9/sA8iwK
	R6VIPbyvm7Nng0AB2RoF47mmtoicp5PmLywhHCkW+gPkv1H5PlRy4oP1SmYYdt7o7sQSPPMdOCb
	langWlZxNeg/MHUw6Roqi60+h1t+rlmSp3PC39LXvmViRnddP1LhSbNcCtGWZY6mMtlTV1qeB83
	bIXBQjgfwZePpUW3CyLYjNPU1MN0OYpuozmMr8fLBqNkNn79tKTl8065tew1G0A3VxdEIzTb+Jx
	ax7kx0eB3fdkgaN0SH+O5vya844RELRDvh6QLIMdwV9MXg5o7ydcybHegeQW0ObEjSl0oYks1bR
	d+ER630LpkIB7/WSSg8Z5h3XoiQYVWk9g/6zTL7pQjeeiKrF2tSkc0UvqE5cgGJeUsTHnv0g9aa
	f6i6zQuNA61YTU2OjrqJy0BBcq4lSEW0pruHJqqgdAPW00iU8DuYyUyvi31BNdan2SFN3jTz8Kw
	gMvr+j3476egIz67i6aFlSXE8cMHS5sxfrbr9XdfRsDytRfToA8YtDkeEbzfBgjw9Scm4ZY5Nf3
	dpOtN10hIjE1iQI5
X-Received: by 2002:a05:690c:e3ce:b0:7bd:d4f4:261e with SMTP id 00721157ae682-7c95b33f043mr222941707b3.31.1779234815335;
        Tue, 19 May 2026 16:53:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18dcddsm44336637b3.49.2026.05.19.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:53:34 -0700 (PDT)
Date: Tue, 19 May 2026 19:53:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 00/13] pack-objects: integrate --path-walk and some
 --filter options
Message-ID: <agz3/ZxZZHBKofR9@nand.local>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>

On Wed, May 13, 2026 at 09:18:42PM +0000, Derrick Stolee via GitGitGadget wrote:
> UPDATES IN V4
> =============
>
> Thanks, Taylor for the careful review.
>
>  * Several typos are fixed.
>  * The performance test is corrected for issues around piping Git commands
>    and made more robust to the existence of submodules.
>  * BIG: The tree:0 patch is significantly updated in this version. Taylor
>    correctly smelled a problem with the new logic to emit the /tagged-trees
>    object set, and that signaled that those trees were previously never
>    emitted. I update the test to demonstrate that changing the data shape
>    (including tagged trees that are otherwise-unreachable) doesn't change
>    the test behavior, signaling a bug. The behavior change details all the
>    complexities of visiting only directly-requested trees under a tree:0
>    filter and recursing on all trees in other cases.

Thanks for the new round; I gave this a lighter pass since I had
reviewed v3 in detail and the range-diff here looks good. I focused in
on a few patches in particular, and left a couple of minor comments.

My main reservation is that the "path starts with a '/' slash character
when directly requested" behavior feels brittle to me, and I am not sure
if there is a cleaner way to express that.

I'm curious what your thoughts are there. I think barring that things
are near-complete here, though I did note one issue with the t/perf
changes (that is my fault for having a bad suggestion on the earlier
round).

Thanks,
Taylor

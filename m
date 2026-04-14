Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4D313E07
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205455; cv=none; b=XrpNdtkdwDI3UHZQFPyas3C5M7iyvzURHL/rQqNUKbon3AYy1A6Dx5DrAoezBmOVsBTDmmdDQwVX+mpI8bPpNA9dSyJKhwFncoc/FGXYa16YRfH6W8fKrLJeCeSq3ym7UjO8Ya3GMRfo5qDUsXfbfYo2jLZDObvd/jcI/oiLOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205455; c=relaxed/simple;
	bh=S8mlixrJWa7glc1QLvnPtZaUJLwzXSrXW2XyQKmAue0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb/b50V/DYK9ztq9eQQOvWY9RB5TwqIF0hZYYuxMS0VExz6HMVDEPTeb4Mmvco1g7wcow5tCRXroa0TGj6X8GsFYwKIv/k85Xn60A0Gai9IDEdC66zbYi7940BbBNxXnzqbqZlgpYrBgLmDEb7CbCFPsX0UiywvJWlE6d7f/McI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TUJIoMdi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TUJIoMdi"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso51048747b3.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776205454; x=1776810254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciEL3ot2QItY1nobHqqC5oyyzt0H3TgiqcN7Ainv9Vo=;
        b=TUJIoMdiPDOWm1uJYSpCS2b0F7kVu5bLaWtQHUkqBzKzVVNToz2vqU/0GvoGpDJRc5
         OoG4n34x1w5DtOp/p2ZAAE8YnoQhW/nI1RjZSYvJPgRhuzxUwKgbVTZynV4MxMScUtM6
         EKI7eOVbYVy7lUEmiQFd3sW9Z9rRAn00BWsI2s3zaddhiwCUb2Msbl0kyl2cllqfGFDO
         lbE6uKddTpH1r/WQNLKjOchCxeCxdHAD9szrBsyxQusrgRGzx5KzIQYXRRElyqUPDgQy
         esnNd/Yf4MBRsko9YGgdsAaOuduy/bPa/LkgwJU0zk1FkmzSjLCrBxl/GmvVVgz0KNWY
         AFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776205454; x=1776810254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciEL3ot2QItY1nobHqqC5oyyzt0H3TgiqcN7Ainv9Vo=;
        b=N+pp3CLnXAqtETAZKEpVxMt4bwO4Thg2Aujv7yG+zv4uwcJEZ2Fk8AvnrDUuzZxSQF
         R7Yzt6UWwtDq53fUBVQ8gSLDDDe5zGJ0HBV1LhhgaH6UXPTEF+7wix5+Sawjjxt4K4Gt
         Ct1a3+ohDxLFoCLF3gByDK+iOjPzGKFBRAQ7dw/1KNj4+5s4ZIOWQbISHuTc23p32K7o
         EyT2BFYMyY9U7EIAeMRZPlfMX11LktxzpW+v9qVyyv1mEe7F3ECYoYxcD5gxEpd6C0/E
         ikMoilWth1y3kNCdm/ktL4obdq7Mp/JZmRsYdwDniy5kR0YXHTON8DmpnsoeR7tMXEdm
         8o+Q==
X-Gm-Message-State: AOJu0Yx+Cj5k7yl6YHTkzxoQkBQp1nq08uWsU8s1Iyb3Hj1M7LRGQmqJ
	JyXlWEqoaFJQtGHIaqNnolLa5xcsZ+PrHBm6frcE9DgkpRgfPGid99kZlWHxpeiRk98=
X-Gm-Gg: AeBDieug2qRr/Gafgkq6XZ8NSnQTYiWFECfpaakBV4/ft/sRud5E6nUXWw3/IQAZwVX
	dkA/L/42e7GUOyduZ/iZ6qdaHJISXJiET4TyF5cLE4irRM1rIOu9vi9W4X8ugvWKfVfQSvgA+BU
	36i389QuiU84ZonV/BRNTIl/BqFVa1zkovg2ysvj8v0nyU3BvFC6eij3w6DSXSy4FYgI5fTPIcg
	JIt3kphsvEQ+tQqEcKTC9gUZVF5PrUSD04vGiqaWY3inJAqgLbTdfOSZCyg3K8eGpsS1oNlrt6M
	R6Cw4YGu1G9stfNpwCN/AXVIowXWmi9L09kTAYYaGA/jdaSYPp6x5NjaHZgpqrFOq2EWFEiGzgi
	DHHRpWAWJwW1bKsj+kpsf1i9pHtYVh4oK8BqlA5+bARCqfjtFrz6Tx6jVCC24NNgY3MWXxvevSV
	opYmcBzodc+NgWWTfHJNd0B9DJ+jo7sAuB1rdcDIE+ek8G9rx4IoDn03oyRyGN8leXW2mY8Pz9h
	fD/h4sD2PQgscDMFJrXeR5lM0SxG3i0UMhYPXrOgZSu06FxtqTL2btvRuJPWcarxfSM/jHx47PC
	LX2OfGWcc8Dsi4pWBEhDKRW0WGQ=
X-Received: by 2002:a05:690c:6d84:b0:7b3:5872:693f with SMTP id 00721157ae682-7b358726eddmr99993547b3.24.1776205453642;
        Tue, 14 Apr 2026 15:24:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b76941160csm101687b3.41.2026.04.14.15.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:24:12 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:24:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 07/16] repack: track the ODB source via existing_packs
Message-ID: <ad6+jMHcwatRRcQa@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <2d377f534071ad9def3fb4860b2581197d02726b.1774820449.git.me@ttaylorr.com>
 <20260407060439.GB714878@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407060439.GB714878@coredump.intra.peff.net>

On Tue, Apr 07, 2026 at 02:04:39AM -0400, Jeff King wrote:
> Makes sense. I wonder if we still need the repo field here:
>
> > diff --git a/repack.h b/repack.h
> > index bc9f2e1a5de..c0e9f0ca647 100644
> > --- a/repack.h
> > +++ b/repack.h
> > @@ -56,6 +56,7 @@ struct packed_git;
> >
> >  struct existing_packs {
> >  	struct repository *repo;
> > +	struct odb_source *source;
> >  	struct string_list kept_packs;
> >  	struct string_list non_kept_packs;
> >  	struct string_list cruft_packs;
>
> since we are going to mostly be operating on one odb source. But I think
> it gets weird asking about things like "which hash algorithm to use",
> because then you end up back at source->odb->repo. Plus there are some
> parts that seem to look at the whole repo.

I think that doing so is possible, though it's not totally
straightforward. There are a handful of places where you really truly
do want to work with the repo (e.g., when calling trace2_region_enter(),
which requires a repository pointer as its final argument).

I do think that we are probably over-relying on the repository pointer
in the existing_packs struct after this patch, especially with the ODB
source refactorings that have been going on.

> So I think it gets complicated and is well off the path to our goal, so
> not worth thinking further about for now.

I agree.

Thanks,
Taylor

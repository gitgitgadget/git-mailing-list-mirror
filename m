Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692DC1F4262
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176528; cv=none; b=kDuPqP10/o1vZ0a5aVLT03nzvQoVKicSl7pMZa0pzLFhkGt0Osa1GPMgLCcdcGq2ECsbh5JmIpou8jssogw/wfYrOXKYRebpaWux2KuptE85irtEM2W+1kRXoqVQ5uaWwhyGLq4rBXwiRZKExG04nIZlzgwT4XDCbelKgDFklkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176528; c=relaxed/simple;
	bh=YJbDwHVIKcofL1A+sEBe3D9Je8WXbl74pyKWtIxGo7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSsWZsSJ2f8kw/jaobdl7l5f/InxTwphbupD3EZXi7MZLysR3rxypb7dO/yJg9HhWtaBGCKe4Jce6xDDBi7MLsgzTpiF2ps9MedEIiKlBVwOSBMmVFuqwBIpzIFQNG0qIBkczWcGLMSUiach13gjQ2SUCEbBBG09STZ1uIjz1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxuct7jI; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxuct7jI"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-449409cc2f1so40555b6e.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761176526; x=1761781326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePIzNSJ/C0XFGAiNpDXa7vLasr7O8tRtef+s4QGe/aw=;
        b=Pxuct7jIeuvSHHcMOc3WdXpjgSbmyl7ztCtDD3kz/2fokT70CDHmZ1Di9mIo8zBl5w
         gCChYe5VbOdZ5kKNP/0AHb69V4zF6AusQQsBfG31E3BPELXCOiJxscIdLdybiUaUoSXQ
         aW6UGUdE6I5L4gVrOED5sSREIXb5CHb8zanBWBiMmF1tSFqnafywNbTXCtvSzp8GuRhf
         BWCTWeXIlcY/TBWXDiJwWpaeMf8at1SSyQBJaO7zpkQgqeqoNhFnEjw3PdonyOIXHwuc
         cUXZqpQEBLzIJn4ozGfkNMh4U/7n2EMpGX/HTh7ICPjzzd1nhCicR/XNFN5F0QGtlCDU
         QguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176526; x=1761781326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePIzNSJ/C0XFGAiNpDXa7vLasr7O8tRtef+s4QGe/aw=;
        b=nLe2X1+Rs66+FA0QA+2G/EB0St6MFtHedmxauIfLHRrk0GTbdBv176VsNY+fM1Z0b0
         lFxQBUKm8wdotWLcAUa6h+gqoBnR/Yj5oElcWHXiv/iUqxkt2YVDUjcjow20GFApY0fh
         4/xuOjKkvDV/ZAwMPInMXoTreyhLwyX8ne1+FKsnM+OW246IwfCD3q4PrM2y4Xs976EN
         UlK+vI6envHXdwqOGfCxd1MhJKFDZaeCVGsShrCgmN4xlNL60oDoz48KthqDS0hlYNp5
         69T83k3qP7zhO+BIfPt3hEqvwatlCepSBHoUfxgichxh6yPjXD0s33jtpSYCWJ3oQmmw
         cZ5Q==
X-Gm-Message-State: AOJu0YyXQKoJjeAVDhdOImi85ns6TWNrPVZCV/lh89BLIGalRBwr4+J+
	33nPlFPEi2Ar9yTwz5eQfd7nGa4xUpbId72i144BM0FmF6vbsyQNUK15
X-Gm-Gg: ASbGncsv71/nrm0Zg3BVrV/o/bS0KWltvfiGrkoKM1e2uHeZbAKsEL+mxoPQcg76af4
	nwpsFSMsO8WgDlJ1+xehHJRUKfAq3uf2CzN4krp+L9muk75odzU1jTEFMY9VQI1QfxYZz12agC0
	a5HEIRFEM/8qGfT6hGuYzmni3WX3ivLCRHonMWRWNup3u1eHSKOUvoeQscwVnQDH+2xBi5Q81ui
	vD4DQCQrqRsWnCUbejEQ/jcQdRLQqGXaW3k010YoaJSnzfxygSvBlGlhvHwp60739b/imLDcgRg
	36bXy+IynuPb9X/0s4s0yMrL1c+TeAblxvHfU059LK0wggQ9pvtTGtI4FVYRGu9LchL4ywcOmUc
	Xe4gJl8F72bhefgQ8MoimSAX+CsLGbsrYcVz3g4Op2tFAPLlvd+7EfoydwX9lgu7ID0nVKg==
X-Google-Smtp-Source: AGHT+IHcJIztYxeLGJyOmMQCkBt4ePv/mSE1nOx8h9utwG8CtK+ZxXA2mTTQbkfdDM1HRusEml5YDQ==
X-Received: by 2002:a05:6808:318e:b0:443:a155:d833 with SMTP id 5614622812f47-443a30b1352mr10049186b6e.42.1761176526169;
        Wed, 22 Oct 2025 16:42:06 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44bd44bfad2sm117068b6e.18.2025.10.22.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:42:05 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:42:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	sunshine@sunshineco.com, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 4/7] builtin/repo: introduce structure subcommand
Message-ID: <wmprwnikryda3zairkyyqyn5lapernapivgq63ckhwlt2ispqu@onebdrpp3axf>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <20251021182601.2687284-5-jltobler@gmail.com>
 <DBB5E6F1-D2C5-4A3C-9FA7-89147D64BCEC@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBB5E6F1-D2C5-4A3C-9FA7-89147D64BCEC@gmail.com>

On 25/10/22 05:15PM, Lucas Seiki Oshiro wrote:
> 
> > +static void stats_table_print_structure(const struct stats_table *table)
> 
> Question: isn't it possible to use the tables from column.c by
> allowing them to use a cell delimiter? This table formatter seems to
> be useful for other places, like git-repo-info itself.

I opted to create a table formatter specific stats output so we could be
more flexible with how individual column data is displayed.
git-repo-structure having its own table format allows it to more easily
configure things like cell value alignment column-by-column. Also, in a
followup series I plan to introduce measurement units to values
displayed in the table, but I still want to align values and units
separately while still being in the same cell. This sort of
configuration wouldn't fit well in the existing "column.c" table format
IMO.

I did try to design this new stats table format in a way that its could
be reused by other git-repo(1) subcommands if ever needed. So we want to
use it for git-repo-info itself in the future, I think we could do so
relatively easily.

-Justin

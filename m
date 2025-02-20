Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18471D5CD9
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063555; cv=none; b=HPhqA20ArvXuvmwJNJcGd3/RyaFWx7ZX0bFYw6HOSOmKFAuE8gur9ZOEZXPewwzxIRB5Qkn70TZ3DZKBbtYWIKSkkmtu2vKaywXlkuhpZggXoxl41sLs2k+SVkw5EDMrpyiK2zn0eJCQF9xQtJqAP0oynqed34zpOjHxtSrhAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063555; c=relaxed/simple;
	bh=42p6UL/gfo3NSJMPpYlPFhzveYnEWXLno8mA3RFDtI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj+4E2bA2dOQDvkxo9fNXOaylUNjks0iuufcgSiKeSEc+1yjZlidlDRRl53wLMr3SI9/NUy2itgG19ISHAvXqksf481St/nU5Xc6NPBrgn9DA1uVihJdo63dzNcz/l+jsGNI+bLwcw2QVz467oOZ5SuWQ6a1Rzs8s5LHvqp5nCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI8OTBZ8; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI8OTBZ8"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2bc5212b2easo438100fac.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740063553; x=1740668353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cL8ORTxfwJzXeGDBLZnCXOP+ai/U8roVUPSVx1u/Mo4=;
        b=aI8OTBZ8kXoI6/PxmGlwYHZ8FMw3UUlKpYAWyEKDfOntNtRqiEVRMwFfdL2aHdrLe1
         40Gxzjba4oqLs1v4O+Q5UpjVhJpJsbIBMSv/TyxsZ65hLQcUvb8EV7QEXj9z8sUv4Bp1
         jl6PiYq90rOp08CIU9L15LxL69NSoWiHJdT5An4tT7Z+eTGMoSXYm2Tvtmmx93DrqwCq
         DowGneV8+6BhCQFLGMZOKwSZlsjf4cdTEPZAF3aD/rtCyoIogYdwPqE2d0EcNfbDS70e
         O2y5t11AlEFlz1InI6EUaal80clDE7N3VjIoLZe811im3SPUO3CbQRKobYOogsNfH5AZ
         x20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063553; x=1740668353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL8ORTxfwJzXeGDBLZnCXOP+ai/U8roVUPSVx1u/Mo4=;
        b=anvTh2osRCY13sDISx3Jk4eG3etUbaNpk6BPu+0fIAB1RgegIt6uXj5yioHySgr0+F
         bwW3UmdfdGJ3vSt5YTME3WYh9sFNQF9gGywUBALoNCeXuPzWN5NZuD5byf40/PMeP9md
         u0g/zNS3tTa/sbvmVmhJ48noOEUTwe9bmA6yrSVCPeRiU3+OWGHgc+buwU2TyQjjD7m6
         0vUzkZ91sPx3oDL9NUSIGmGyHLlyZLiA1gqfjuI7+3fPl96FMONn7qu6d1+APHooMHe1
         sgbzIl9ZplROQShhYWGKq2wH4eLLdOSKynbsPemx3CgopvKTx0LnIXViYYmOPdu7LrkY
         pKQA==
X-Gm-Message-State: AOJu0Ywls8leArwVHl2ZVmAr46Xr7gn1cDnXD1n9J3u8h+EGPQiqf3yl
	Kv+lGWXuRpeIkfLvqAnG56Qgo0FzlzltmaiUatboZ0ujjvT2inaH
X-Gm-Gg: ASbGncsOMITG29v1aO78lG5MsRfvtYUamWevLrs7BFXMgv8zZyyiE76OUt8/mdqT2SH
	eZ9IoSlGMmQuSHn5Oa7pQkSLGvuo2gSUawGp9wQXgQOgdFAzVlAe+4WWiF9c0oCiTLjYmNSkJUF
	stChIcUtNQ8bQg7TBs8FC3p8aX4yLpZu8GAECncLoKHYihSxePhg08SilJSK8X/l/QUHerVtWQ0
	dFYoCkVdrOVjXvktsb3NlmMkUyrnYqPsLxcKL6/Xuene811FOBEETUSO1MM2s7ogdWvWcA876Ew
	38yvrOHe
X-Google-Smtp-Source: AGHT+IFKenGt3+Ra9mg8GGMgpP8xJBlpZNkekjANKXW4i8spo8PNnX/BuaafzlHRB3c8/ycB2kB+Yg==
X-Received: by 2002:a05:6870:e387:b0:287:471:41eb with SMTP id 586e51a60fabf-2bd10156628mr6547732fac.6.1740063552182;
        Thu, 20 Feb 2025 06:59:12 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7273445516fsm1421944a34.67.2025.02.20.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:59:11 -0800 (PST)
Date: Thu, 20 Feb 2025 08:56:02 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
Message-ID: <3bf7llbgpb25bfiuqbsyz4iibacwnfgrumfede4nebz3vw2grs@xarsh4rzohle>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
 <xmqqldubumxf.fsf@gitster.g>
 <5uwp2vdm5tzv6n26fu77g4xys5ntjy2bj4hpgiuwpamxkij4zk@77jn55tynwse>
 <xmqq1pvtfrq0.fsf@gitster.g>
 <xmqqwmdlebua.fsf@gitster.g>
 <4ch3hdlv23qtwi32mgilym43eqtjefgxi4yi7577xcw6df3lbv@eiemmoap22y7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ch3hdlv23qtwi32mgilym43eqtjefgxi4yi7577xcw6df3lbv@eiemmoap22y7>

On 25/02/19 06:32PM, Justin Tobler wrote:
> > >> The tree objects in the input are not expanded. With `git diff-pairs
> > >> --raw` these objects are just printed again. With the `--patch` option,
> > >> they are just ommitted.
> > 
> > >Instead of getting expanded into its subpaths?
> 
> The current implementation of diff-pairs is rather simple. It relies on
> the upstream to feed it the file pairs with all the info upfront so it
> can setup the diff queue. This means input with tree objects is also
> queued as-is without being expanded further. I could maybe see a future
> though where we want diff-pairs to be a more robust backend and supports
> expanding these paths via -r option. Following previous discussion,
> maybe it's fine to keep the initial implementation of diff-pairs on the
> simple side for now. We could make diff-pairs die() for now if the -r
> option is explicitly set.

Thinking about this some more, adding support to expand trees in
diff-pairs would alter patch output behavior. To better enable backwards
compatible inclusion of this feature in the future, we may just want to
die() for now if any tree object is present in diff-pairs input.

-Justin

Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8E1386DA
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814972; cv=none; b=NNdtVv6ttGO+13YaCu1Gfrjz91ZgHqC1mdhpayRPJKeTy6TVGrYv1MK3CY7Ex3IzRM4z/xCxpc9N7L5GER/btaUNHTeJLQyfoeDvcfSka6xCDV+VC26h7pHiSfhGWDDnHsBCULt3JcpHPu2c4PN7GFN012Ct8q+ES1HLLOpEtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814972; c=relaxed/simple;
	bh=TQnghU2KwWJwKKcXd9GOxWAE4cB/t6811jDird+MtYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA4UJYdpkXFJm6nMNHN7bkY+egC1IS/v/gdMEmXhxgnTEq1fyE6O7Q72AlyCnGV3HTcHASW9pPzUjq3NbKgn9Q+hWQQ1ycbYxDm3yB1i5U3omjfw7MeELu4QZoawTIsumxWksfuZwcE4ux1wBMm7QuWN/z0g5Na/HBarajqvct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cnwNBMjB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cnwNBMjB"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f768e9be1aso14812367b3.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741814970; x=1742419770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfup9kW9+I8tsxka2rU8z0QsqJNf0i8ft9AudQsKlQg=;
        b=cnwNBMjBystEoMd9Oq4cvsYT98G/IXOVspQhlex7AgUNokxY5CtEBrssJDmh3bHdLg
         oHEB+vBdzPZAYAXVmLv1oSCLRW50oeVWngoNkL60Rwv0VKcQtxQNdxrvjxvSRzoizKot
         mx8Fu/56v1i8RBFG+ftsLshS43uiSTNBEkzBhnt6fCPNbzUv2WcL92ozoyGdBOExblsv
         7GWPHA/Ot8v31WX2nIAnzjPyN1sgGWKsTEAktnnckqJVGOlTGX3VbYQ+7V61K4btNMgQ
         oQFhZk/IheosURoxcYkzK18W4/Tb1LUdlZmLrJAHbwqHxe2lpNQg9i1hgELb/ApsFMLZ
         aiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814970; x=1742419770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfup9kW9+I8tsxka2rU8z0QsqJNf0i8ft9AudQsKlQg=;
        b=f4Ah4pv5Q9bEJn+uFmgx70jm057AHbQC8PqcVOrzcmhoZqb9nhDZNE+TFBgwHvi/px
         9hZxY54MEhsVdpKsbT9vtpK2kt+D6J/tYyBFwhkPTZ9PVdebfRU8cO+8+ZSMHcAr/FYZ
         XEqQ0Y8oaK2CC08jE4/BsHg8i1EpwXYIBXWmsGvzFqRptvSqIxcxhNrH03KnVxGSDe8V
         BAzeaQtjQlkzUhwltEd6GtRePj5twa3NIXcjdOq+lpHkKlosTeGChoKG73ZP3SzpOV/L
         eFEZBlOILgvZR0W5rOfxl3tskE4BBmNjlaCRoghI65TlTamCmAAC6e5MOmnDjo8lu3iX
         49GA==
X-Gm-Message-State: AOJu0Yxv8uf/NiapPORwizSP/WlRAzqgfmKan4PkSlliJmkEUon9uHpq
	hQhKR1suKu96Ky+Uhj6UiDSmotSD4Y7/mgAW6jxCno1uX3HRYSf8crvjWb1Bhl0=
X-Gm-Gg: ASbGncvRaQahmdYpHoArHBrS05by12U+x3Bg1jP7PZZxqy6ngwCFtAHOOeS2SuhBhXX
	YkJQCnY5B/m3v4ccDiJan8OLlxCB8fvAGw6/xT5rX7f/nKhLimppf7z+xGO79Nr8CCwMaUaB0jk
	Y0p0Pk/Dc1+5nsctxhPdeXmgKNl9OK0NkGOCaXS6xPBS5WzNdyKX6kijPdxBL+6kW9aeXZKgUd1
	6eyjj7gre6IVC+YQ3aCtn0DqnIbL4778+PtlA1BCYwry6/C17OwVwm+ExutXt2iO5LnSOuw3jrl
	LAcSrlwcU2gCqYEOcPpCy+6LmScK2z63UY5AoZ/xT7YNTmD/AeWRCsqkGYujSaKlkOPqjCH/5wR
	wOzkg5Uve9rPfmrKy
X-Google-Smtp-Source: AGHT+IHd03cW8FqYYbUzIGQIb7Zm98LBPRKbC2V8vWeF7BsuX/cjN03Uo61+4mP0EN49k77Bw+3L/g==
X-Received: by 2002:a05:690c:4043:b0:6fe:bf32:a427 with SMTP id 00721157ae682-6ff2f48c34bmr1803357b3.0.1741814970170;
        Wed, 12 Mar 2025 14:29:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c474b8sm33347067b3.111.2025.03.12.14.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:29:29 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:29:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 0/9] fetch: further ref-prefix cleanups and optimizations
Message-ID: <Z9H8uKevHUxasE4S@nand.local>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
 <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

On Sat, Mar 08, 2025 at 10:01:01PM -0500, Jeff King wrote:
> On Fri, Mar 07, 2025 at 06:27:03PM -0500, Taylor Blau wrote:
>
> > Peff and I talked about this today, and neither of us could find any
> > reasons not to pursue the approach listed in the footnote of
> >
> >   <20250221072558.GA572877@coredump.intra.peff.net>
> >
> > , but this is a more conservative approach that should fix the issue and
> > apply cleanly on top of 'maint'. It may be worth picking this into 2.49,
> > even though we are already quite late into the -rc cycle, this is a
> > fairly nasty bug.
>
> Yeah, I favor doing this simple fix first, and then trying the larger
> (and slightly riskier) change on top.

Yeah, definitely. I think fixing the issue immediately is the most
important thing we can do, but cleaning up the code (once the immediate
issue has been resolved) is also worth doing.

> I started to write up that larger patch, and found a number of
> interesting things. ;) So here's a 9-patch series, which would apply on
> top of tb/fetch-follow-tags-fix (but can very much wait to cook in the
> next development cycle).

What?! You found other things to clean up along the way? Blasphemy.

>  builtin/fetch.c        | 46 +++++++++++++++++-------------------------
>  refspec.c              | 22 ++++++++++++++------
>  t/t5516-fetch-push.sh  | 12 ++++++-----
>  t/t5702-protocol-v2.sh | 44 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 85 insertions(+), 39 deletions(-)

Kidding, of course, I am looking forward to reviewing it now.

Thanks,
Taylor

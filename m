Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC11BDE9
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XBDA6IIf"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-595b208a050so983367eaf.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704301256; x=1704906056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsM4NN6owLyECW3Y0oAEH1dgh3wc9Oiy6ZCRnUEVKbc=;
        b=XBDA6IIfdQ2AWEDRY2m/nd44GtW5ISTCVHnHBsNTngBje/Jef22DW5Hk1mWQFd0FQR
         lPuxhQzqu3hQL1uSdkBDZuwqqTnQp/oVuo99+rheJPp7uWf73MCbazZ+RKhvAc9lcDmJ
         PyyE4kg68WTqr3JARltLwB/8aG081aioJSfM1zFb7hgLKRUqIPB4nBHh9hGX9wepUrs5
         PH4Pw6+yoLAFEALxAuW2ZoVp5A9zJhvL1RURNBhicie/U7lq4ITSqitcsUjiQ0ZmghAx
         HoUUWdI7VgvTnM1mg38W8wtq/nIDqeIQMLJ6KJls6IlLDQPlySVHPrzq7le5yfhXK4V4
         f5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704301256; x=1704906056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsM4NN6owLyECW3Y0oAEH1dgh3wc9Oiy6ZCRnUEVKbc=;
        b=oCRxO1N6CWCR7WOCLe5CvTRqyqjHuqzOHCxeFsushXIS6vENGfz0PPJbaS/X7NO/4O
         PR5FCrPrKI92//4raFWK/2z96VgsksJ1FGxEq+hlIBfJz5yP/k209eb2C3YUOsqG2+9K
         vPc0VgOmboi5an5GZgMV8xsVtCP7eZ3aMvOdVzs1sRnNUsQ+hNZgjY7Np4gBUyxuGmiC
         WtG08oeLbE9vJCKArGBz5pqBouPlxy5dgpl2KphgMh9pZ8xr2er5GiCiWwrnNp8TheeB
         Y3JKInAwH8zu79nJyyDxETHFA3xrBu8OJPOeIPjvjowRXHJhcdkwRZs6/66Z0ct0KY0U
         hbIA==
X-Gm-Message-State: AOJu0YzXOnqqi+GF8Mxfei7UlEY2XBUuWi74GR2DZdEV5xPJ1jvepxwV
	HjJfWYA0QKQvhSNuI1uh/aRH8gp8roTp2g==
X-Google-Smtp-Source: AGHT+IHIiPSJv5O16MwB25puTZLsPDbJfENhXR2TWsdUHe9LNVC8Op4ZyvXSePgdYd1v2SvbSGBf7Q==
X-Received: by 2002:a05:6358:9387:b0:174:f48c:3871 with SMTP id h7-20020a056358938700b00174f48c3871mr13015079rwb.43.1704301256416;
        Wed, 03 Jan 2024 09:00:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w39-20020a05622a192700b004283babeeacsm456862qtc.4.2024.01.03.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 09:00:56 -0800 (PST)
Date: Wed, 3 Jan 2024 12:00:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZWSxyv4QxSPQOSd@nand.local>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local>
 <ZZUgUUlB8A-rhep5@tanuki>
 <ZZWBLafB3pIlZqpw@nand.local>
 <ZZWCxIHf9ySEOWEJ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZWCxIHf9ySEOWEJ@tanuki>

On Wed, Jan 03, 2024 at 04:52:36PM +0100, Patrick Steinhardt wrote:
> On Wed, Jan 03, 2024 at 10:45:49AM -0500, Taylor Blau wrote:
> > On Wed, Jan 03, 2024 at 09:52:33AM +0100, Patrick Steinhardt wrote:
> > > > I tend to agree that the special empty pattern would be a good shorthand
> > > > for listing all references underneath refs/, including any top-level
> > > > psuedo-refs.
> > > >
> > > > But I don't think that I quite follow what Karthik is saying here.
> > > > for-each-ref returns the union of references that match the given
> > > > pattern(s), not their intersection. So if you wanted to list just the
> > > > psudo-refs ending in '_HEAD', you'd do:
> > > >
> > > >   $ git for-each-ref "*_HEAD"
> > > >
> > > > I think if you wanted to list all pseudo-refs, calling the option
> > > > `--pseudo-refs` seems reasonable. But if you want to list some subset of
> > > > psueod-refs matching a given pattern, you should specify that pattern
> > > > directly.
> > >
> > > Where I think this proposal falls short is if you have refs outside of
> > > the "refs/" hierarchy. Granted, this is nothing that should usually
> > > happen nowadays. But I think we should safeguard us for the future:
> >
> > Hmm. Maybe I misspoke, but I was thinking that `--pseudo-refs` would
> > imply that we list all references (regardless of whether they appear in
> > the top-level refs/ hierarchy). But perhaps I'm misunderstanding what
> > you're trying to accomplish here.
>
> Ah, okay. I think in that case it's simply a misunderstanding. To me a
> pseudo-ref only includes refs that match `is_pseudoref_syntax()`, so
> things like "HEAD", "ORIG_HEAD" or "MERGE_HEAD". So with that
> understanding, a ref "something/outside/refs" would not be included,
> but I'd very much like to see it listed.

OK, I see: you're trying to add an option that lists all references
(including those outside of the top-level "refs/" hierarchy). But my
proposal to use `--pseudo-refs` was to list *just* those references
outside of the top-level hierarchy.

I wonder if we might want to do something else entirely, which is an
option which controls the top-level "namespace" of references that we
want to see. The behavior would then be to list all references under
"namespace" (which presumably would be "refs/" by default).

If you want to list references like something/outside/refs, your
namespace would then be --namespace="".

I think that this would be a bit more flexible than the current
suggestions, but I am also not as familiar as you are at this particular
problem :-).

Thanks,
Taylor

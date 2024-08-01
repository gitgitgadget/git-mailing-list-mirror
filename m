Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0F4087C
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544909; cv=none; b=pMmhBAv4+Lk4oCH4ilLODPq+dwRLqfepw6NV/VodvsvqeQ/1xL1rbh5tGRlD6nbomowMK52+zuOiYe4gKeRMNG/9BHz4IHuIffgMmRxvh4xyDWih5XXu4SDiNi12gKEOEoZlsvXF1VMTxUGLwil7cY65+V08LefLp17wh75+q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544909; c=relaxed/simple;
	bh=pU/wfvI0SjIXk5khoP40QtstMb9q3Co3UyMrMVS7jaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgXTib2HcD8ScAT+758Dttl7BO7t7tSOLkhjYgXsagCT9aMIqMMhjSmivwINvbVfccIf/5VKiOCWyrVUTCWhEZ/D/gIjzc/T3SSR7xETkH4Kup3ygH3b2gKu44/IGXMx69CvSUKImOijsVuN58VzA5xNca6K1z/8XF1OGUU6/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ViVg8cEY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ViVg8cEY"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1e1f6a924so461320385a.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722544906; x=1723149706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3LHepXp0tVi0hvysluek3HFcAw4cCGDdAfdChSMPM4=;
        b=ViVg8cEYJe4/C63QYK4aep2ys0UU/HkL0/bEMXKGIyuc/fW8b6fm+uBRMXLHeLBPlv
         AS/pmdaRcnmrGP+nf3sCCIJWgS5a0jwV+VxOa7E8i9DyFA3cjqeb/GoqymI+QVbWcvMI
         lOsm90FF/8VooI63CI5n5a4G1T65Tk4PyGWWOC30MeCdBC3bTgGMh4bdabvfGXS7yLci
         RSLhRO/6hWmeRoxN+2dT2wOkMgyUFquTszZ7pf/N4zr1pPUhgaBq08Xq43WTJXqWpwnx
         UNLYOIzLacVBWseRNU1wjuR5vb7JmeMmHfm3US5Xt/iqTCncTZDo0nALzg8FQ34kGc0Z
         WkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722544906; x=1723149706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3LHepXp0tVi0hvysluek3HFcAw4cCGDdAfdChSMPM4=;
        b=m7JUMV4nFbHpq+qBeNEQ3j3nmuVYOEBkVUPL6tA+vBGUp7/MnGpVyzik9mE2uX6gE+
         9CfEoROaqt0mBGgqGSYmz+1+KeKqBGdLuYDgeKCowyk4oj8JcJLnYHv5Q0FyVNPvC88e
         4000fPTYh9HKK9ZzD2GE0iDC6ZvsqRdeLZfrpR8tqZErSXs/Dnkbe4ceGaP142mzljuC
         qfECDQJw7623nQ6g4SWj1VTUaFq7BN0JQKul1opEaZQRa992WVUWCzpKuenYLr5JS2QY
         eYZvZQoO67FLnqK4b2RY6Qs0qzEwyZIbrnawLv4Ge+q344Dtf/Uh8sHshOQ4OCfMU6ey
         49Pw==
X-Gm-Message-State: AOJu0YzyMusF5phheZ6+3pQqoygXSmrRb98MaVYlFEiX1SdgOYHUTmPw
	ynSd6WW7GbB0MgUb8Y1h5e5UsZHoTIStyQiTZuuYP+a8NqaUMRkC3qJcNf92M3s=
X-Google-Smtp-Source: AGHT+IF6S3LzLtD6L74jPtm9Az8/3d4LGGePjbUpLA0bGDMslTFYBYnO8ESR4L7qYLFjRzXiW0w1Mw==
X-Received: by 2002:a05:620a:2481:b0:79d:59bb:639f with SMTP id af79cd13be357-7a34efeafdbmr132530085a.65.1722544906557;
        Thu, 01 Aug 2024 13:41:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6ffdf7sm26515185a.71.2024.08.01.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:41:46 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:41:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <ZqvzCUHgDKj6TNQK@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <20240801111410.GS1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801111410.GS1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 07:14:10AM -0400, Jeff King wrote:
> On Wed, Jul 17, 2024 at 05:11:54PM -0400, Taylor Blau wrote:
>
> > This series implements incremental MIDXs, which allow for storing
> > a MIDX across multiple layers, each with their own distinct set of
> > packs.
> >
> > This round is mostly unchanged from the previous since there has not yet
> > been substantial review. But it does rebase to current 'master' (which
> > is 04f5a52757 (Post 2.46-rc0 batch #2, 2024-07-16), at the time of
> > writing).
> >
> > Importantly, this rebase moves this topic to be based on an ancestor of
> > 0c5a62f14b (midx-write.c: do not read existing MIDX with
> > `packs_to_include`, 2024-06-11), which resulted in a non-trivial
> > conflict prior to this rebase.
> >
> > The rest of the topic is unchanged. I don't expect that we'll see much
> > review here for the next couple of weeks while we are in the -rc phase,
> > but I figured it would be useful to have it on the list for folks that
> > are interested in taking a look.
> >
> > Thanks in advance for any review! :-)
>
> I gave it a pretty thorough look. Everything looks good for the most
> part. I left a few comments, but mostly just thinking my way through
> things.

Thanks very much.

I squashed all of the feedback that I got from your review into a local
copy, which I'll submit as "v3" (probably next week, as I am gone for a
long weekend starting ~tomorrow and would like to leave others some time
to review as well).

>   - the changes you did make look good, but it's hard to know if there's
>     code lurking that still needs to be adjusted for chained midx's. For
>     that I think I'd turn more towards testing than code review. I'm not
>     sure how much interesting coverage we're getting from the GIT_TEST
>     variable, just because the repositories made in most of the tests
>     are so trivial.
>
>     I'd love to see the results on a real workload (both a big repo, but
>     also how things behave over days or weeks of repository maintenance
>     done with incremental midxs). I know that can be hard to do, though.

Yeah, I agree that this is the biggest gap in this series and the
overall plan right now. I have some more detailed comments in [1] that I
think are useful to the overall approach.

It basically boils down to declaring the feature "experimental" and
letting users that are comfortable testing on the bleeding edge help us
iron out any bugs (along with rolling it out at GitHub once all the dust
has settled on this and subsequent parts).

Thanks again for a detailed and helpful review :-).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZqvcAQABDIthFUPH@nand.local/

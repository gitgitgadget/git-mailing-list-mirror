Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45E125B9
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112584; cv=none; b=FttJoNtnSUt6oA325YUGu4obZOEilyeNDGNJi5yjnhUjuncDzmEed0zGL8bHbJLnt9f/bR1UCGqSbezONsPVEgROd528z6fcOx1fEp54xcvPDVI4gz/QBgMiAKaYo4OTsDZR8jntOqnEneuUcwl21xhs2+Wfi3rGikW5vU1GSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112584; c=relaxed/simple;
	bh=jjqes4DVvohkaQWnpJI31rT2/9Y33EcUptjZJ10inv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPIFuh1z3gVeyKSNsEHNSiN5uof9ZuEfrcH6QBbXBT03bYovlv96fAiTF3HMAxhEYR9ngsXfD015nK5qzy4+51rQ0SFR5jwd3rp5pQJWyQIK9cKCC0MQis4vD/OUzgNjI1uZ3sidXt/ddEGjTBnMDRS87ckGOhCWVR9yLmEI75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Kyzm52rR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Kyzm52rR"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e59a9496f9so4285697b3.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729112582; x=1729717382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRJq1WaUVauaH0NrxFRv+N+/t6YeVkCcykKZIPJGKYo=;
        b=Kyzm52rRMyLAUnw4PveiMzywaQL9oU3OWqFeBMEpvMmStwUJyAANmgcsWwUpQ+xum4
         Ei+6K45+XxIkBo9FrzREv5KJ7HFYZ4HwtVlmxq1gOW1iCjWc52ZwYuFrIkCECZgWa1yh
         oXtCUV4BIcCpYnJy1tNAVt3MxeQy0vO3mR5b201mBwPgCdtZsUN3XipNsL4A1W4YUCj6
         Gxg67DffJ0EM4CuWtjPApT0KQbb3wNxs8CLwCZJp9eMnYBMIIgctbAv6+BEXaeSE5UC+
         7ZPF/TmN+EWah8+YhpRcmJUD45IrsDfp/zbJdwEZ5q8tjFPnevUpwLfnZv3U4lz+hPgW
         sM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112582; x=1729717382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRJq1WaUVauaH0NrxFRv+N+/t6YeVkCcykKZIPJGKYo=;
        b=FoNwn3zLdRTntke8MbvYDaOoNUskhQOQT8tp8yaeT6PGSKgZceQ8OtDagJWEchgaXN
         Pr5xZikVvb7Iu/mLrYw+FebDaHqcIReWGsQ9WJ6beIQ9qVTAf/mNjdV8E8+LgXkx+wBz
         +6e8BeTsvgc+JLhhJdW2j2wCVe3qaRWUlh2Y2hx6FrDtyC2zJKY6dVgXVCK3q8ziLg4n
         7tupcEAYY9/TTJBBnxhmxZADKnrdd4mYDyBzyeMeL1ExIPMKWD8kWeRQgObQ2kVVoexO
         bhuQ/ouV5wMFglgiT2uia2JVNUw9sPZmTIhC0oce1qNSFmGxVaaeZ2k4k67DpjuMiDoh
         /Vvw==
X-Gm-Message-State: AOJu0YxXGtgDzeTX5GKf7LX5w9/8K5/fPQsBsK0eIqHuJsv0JpyOUjjA
	au8ZF1ubB9/9mJeM4xFvXeYh3TzZr4btYefPFJmL+VEEaGSj8+ZMk1P0ePJMumY=
X-Google-Smtp-Source: AGHT+IHT1PvGwMj35bY13xghB7Q96CW1ee9AFD3pa1zeFdPsQrEW8z2tmExCnf3XpFJtcu30k7odZw==
X-Received: by 2002:a05:690c:3686:b0:6e3:3357:9106 with SMTP id 00721157ae682-6e3479b967fmr184887147b3.15.1729112582285;
        Wed, 16 Oct 2024 14:03:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae8752sm8709197b3.7.2024.10.16.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:03:01 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:02:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <ZxAqA+iyz8EIOeNC@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <f6a8582c34a7b77aa3e2e45298208050333c384a.1728992306.git.ps@pks.im>
 <Zw8AaF4VOaQO+P2M@nand.local>
 <Zw85joY3Hqzx23xc@pks.im>
 <ZxApLn9Qf4hdAlBL@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxApLn9Qf4hdAlBL@nand.local>

On Wed, Oct 16, 2024 at 04:59:26PM -0400, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 05:57:10AM +0200, Patrick Steinhardt wrote:
> > On Tue, Oct 15, 2024 at 07:53:12PM -0400, Taylor Blau wrote:
> > > On Tue, Oct 15, 2024 at 01:45:11PM +0200, Patrick Steinhardt wrote:
> > > > Further note that there are several "!MINGW" conditions in t4201, and
> > > > all of these fail due to iconv-related errors. This is quite likely a
> > > > leftover from times before dce7d29551 (msvc: support building Git using
> > > > MS Visual C++, 2019-06-25), which switched Windows-based builds over
> > > > from "NO_ICONV=YesPlease" to "NEEDS_LIBICONV=YesPlease". Consequently,
> > > > adapt those tests to also use the new ICONV prerequisite.
> > >
> > > This appears to break CI on Windows when I merged this into 'jch':
> > >
> > >     https://github.com/ttaylorr/git/actions/runs/11355564982/job/31585450667
> > >
> > > I'm going to temporarily eject this from 'jch' and 'seen' until we can
> > > properly deal with this.
> >
> > Ugh, I'm looking forward to the Windows jobs for GitLab CI being merged
> > down to next so that I can finally see such regressions before they hit
> > our trees. Anyway, thanks for the heads up, will have a look.
>
> It's OK. Ejecting a topic out of 'seen' is relatively easy as it
> requires the following (after removing the line out of Meta/redo-seen.sh):
>
>     git checkout -B seen jch
>     sh Meta/redo-seen.sh
>
> I was mostly confused why my build of 'seen' passed 'make test' locally,
> but failed CI when pushed to GitHub. Of course, I'm not testing on a
> Windows machine, and you didn't have easy access to Windows CI runs on
> GitLab (for now), so the result makes sense.

Speaking of... I have 'ps/ci-gitlab-windows' tagged for 'next' in the
next integration round. There is some duplication of patches between
that topic and this one (as well as ps/build).

How do you want me to handle the dependency?

Thanks,
Taylor

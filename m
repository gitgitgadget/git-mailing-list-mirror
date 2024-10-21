Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E11D1744
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545257; cv=none; b=WJq6OcXAKoglZ6hMzza8nFoG3mtgkt+ctG1ONGAT5jhIFnePj+fh7kl+Hw9rEMqss+OGcAbBtmpIIndKf85vfcDFP7Guk6kLPxR0uBVa696kXLK4giAHeP32YoM3BGDTJmX0KRSXZ6b8caOVFFwCU2Vt+Tm6Dn1MfBXf036+l+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545257; c=relaxed/simple;
	bh=9txg+/Yt89r0yKheWTsWrgyEcxPZTNtr2E6JZa5wV+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2rWALJDtTsa9GhMXzGmP79Dtam5eJ+x6P5AhDP6GuwPrxBnpoWin48B7RjMcx1/S5Y4A73kgKWnyYUHgkHA/QE2lnknE8alGvSlIXwjwQOoPM+bLrdcDgHASv7gMDOdwyd6NoTRq98RADHs6/Lq2uyqUUoLl5eOsOHCR7khvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=at+GZ9Hu; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="at+GZ9Hu"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e2975432b8cso5235431276.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729545255; x=1730150055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9txg+/Yt89r0yKheWTsWrgyEcxPZTNtr2E6JZa5wV+w=;
        b=at+GZ9HuR/83p+1GFfGOLytA3y+qJ+ZK9eTNJKJJPOpoJZ5I0pgbQ3vEVokT+9Ybu8
         47cZb9xfhV+6fzozKC25Ll2c+vSwak1cIBFj5IdMlIn59UBO3mTbAF8cxROgjvpc3acK
         R/6odzSBX0U9KYxKlKE4UucV6GuKeOWq149WHKvoUHjKU5iGJpddQPcqSueBqzXIM/Dt
         S7pE8rLhgtM2fGQJplB5hXqcuPz/1AKhJN5xJAEwDIVh6Za5DOrsg74of7aZwMpfRN1L
         UPJhVEBSn+nOmRLnssJzl5Mp89QP/FhHygg50pl/jUyD9KnZ7VnqeLrBY7lFfYW6c0Yf
         Oxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545255; x=1730150055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9txg+/Yt89r0yKheWTsWrgyEcxPZTNtr2E6JZa5wV+w=;
        b=dW7rlIZrhdwWqvyne7XmW/hVDCO2BnX6t74UHHjaSqPd4rIveEgN37LfDAQGMLk6/+
         Y9NHoqOtJKfDzFI9FTNvRiend0HLpoi7fRX9/G1ap4gcrYw4CO542/89tFidAPhW8pC+
         QDNsSPG/UqD2D0JC2tDBiq+pKwCOojFe0FRWs9ojpTEqYAUUrh+6AA5kmgBFII7keLYB
         mVI9BEIxmYU+7pK7TSNirfD5VoabV7f5roM69evnRvczNk4K28mwR+y7JRbZ9IvwajR3
         HEczd3koZUH9noevfvoAUVvYuvpMiZfqerQSLKA8vzKQwSVpLgk4Whf2EN1NDf3QNt75
         RwuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGFQRVfFl27J6yoR4YuMhZM95Mz0LY63kXT4JYf+1/1M3tukJy9MiJIFQyqiCIwD2tDik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSV9mraGd3BZZNclih9+VTc7SfmX/ikgJILDB9O/is0PyXIf+
	loD9wyWwP9Og0B+jtLdoRN1Ld33HBz39jYUqEeVJYtqecxUf4bcvJ34+SFuVXcGw+9Qe9aPN6j+
	0
X-Google-Smtp-Source: AGHT+IEpzVPbSN73f8YoTd5t3HWkdT+iKO/bvU/q3pRdAlaycd5hN4ZZ6mHQ2X5gAtY1iaZ7BvZWJQ==
X-Received: by 2002:a05:690c:3104:b0:6af:6762:eba1 with SMTP id 00721157ae682-6e7d3ae693bmr10745997b3.20.1729545255186;
        Mon, 21 Oct 2024 14:14:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a619afsm8271587b3.56.2024.10.21.14.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:14:14 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:14:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t/meson.build: fix up tests for 'seen' branch
Message-ID: <ZxbEJbigarbklNJq@nand.local>
References: <8b08b64a-aa5a-422d-9815-e67911a703e0@ramsayjones.plus.com>
 <ZxXu2rG1ls8UcXug@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxXu2rG1ls8UcXug@pks.im>

On Mon, Oct 21, 2024 at 08:04:16AM +0200, Patrick Steinhardt wrote:
> On Sun, Oct 20, 2024 at 05:00:44PM +0100, Ramsay Jones wrote:
>
> Thanks, I'll pick these up.

Thanks. Please make sure to let me know which topic(s) that the new
version of ps/build depends on as a result so I can queue it properly.

> > Hmm, this is going to be a PITA as far as maintenance is concerned! :(
> > If I am reading it correctly, the cmake solution uses file globbing
> > to get the list of test files to run - could meson do the same?
>
> In theory we can, yes. But there's a big problem with it, both in Meson
> and in CMake: the instructions to deduce source files only get executed
> at configure time. Consequently, when new files get added, the build
> instructions do not get updated accordingly and are thus broken. So
> CMake does get around this, but not in a way that is feasible for use as
> our main build system, and the same would be true for Meson.
>
> For our integration-style tests I'd be okay with not listing the files
> individually, such that we instead use e.g. prove(1) to run all tests
> via a single test target. It would be a regression in functionality as
> we now cannot easily run e.g. "meson test t0000*", but at least we would
> not have to maintain the list of test scripts anymore.

I quite like the ability to run tNNNN-*.sh individually when spelled
like that (i.e. including the test number, but not the full script
name).

I find that for the areas that I have worked on most over the years that
I have the relevant test numbers committed by heart, but often don't
know the full script name. So it is nice to be able to refer to them by
number only.

Am I reading it write that this suggests that Meson would lose that
ability?

Thanks,
Taylor

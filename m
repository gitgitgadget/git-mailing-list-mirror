Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35388155723
	for <git@vger.kernel.org>; Wed, 15 May 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788720; cv=none; b=LZdOw3D3fXzNnpWWRpcWtI9yJ/j3vreJu02+dzOVniy2m1mh3cw2F6De0RnxiPrBY2H4BrlVjfx8PLOJDs5PuALd2zK3ZiT+ZNj6PKUb76c/9oNzN8TZ1EOSCXnggPLajAIyUEkw5e6a1N0eny9t9MnhuxgfhieLbnLqOet8mB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788720; c=relaxed/simple;
	bh=IHqNZNSzJxwgh0EzkSjPLc0vVS2XZ3dUMMZbK0NmjKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc7kFiaTGBhHb9AnC9e8MkObmaPYLaxw93izTQTtkOvHSyP2QbqigCYfBHy/qTWto21hBaK+ftmQdLlR3EEAnKvOpwiCsX1t0CnRBwmj7UXUcSMxHV/iBNZ3gQ+SXgjYSlL66pys9po/VyxKyQfq6W471o/uxmKInj8w9FvYxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uEjiNJg/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uEjiNJg/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792bcfde2baso596493485a.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715788718; x=1716393518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHqNZNSzJxwgh0EzkSjPLc0vVS2XZ3dUMMZbK0NmjKs=;
        b=uEjiNJg/QUE/GvEV5P2fbh8t05iwY0ZZUpylOdUX0x2mrHixBt1B+2gyC8iJyVi/f/
         Ay5dMGSn+KKC54aGc+Uuzn0RbBaR5fX2S3x/wdxtkP7mQ1yJ+ESms3Ka/y+rxMUyXDDf
         3s1d6/oG0ptU41Ap4xAQW5g2+vjMpWtcSB923AG8BT1RxrHmUZb+gjbRntHBmvMN0zmT
         ZZzQv8ElVJiObDOtnDnxGnnnAITj5v/7jgrTM3CJFnFx/GKpBNSE1+aKSbCsoWOxFnLd
         mlSoHDbPdSM0L795UwEtSQCDRTTYn4G7NvaoRP99vW2Va260fVBOY+qIT90rGhnHgSTb
         tpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715788718; x=1716393518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHqNZNSzJxwgh0EzkSjPLc0vVS2XZ3dUMMZbK0NmjKs=;
        b=lmJEyBTbacU3NvgApncJ5lGPfyL/CCAMU8D2IDwrY93NuZ1Hc6ysKGBCbsZTfXBigt
         LzRDWhSCq1sBuYelyw2bCEgV2MUoIO9YR81s5rRTvysXbJc8hWS0uL66KBgscyFWyle+
         tcirH7WHcFdkGC3ZByDWY18mFyUqX0tdmO6zlaQbv0b1H9GbPhwxStq9mAW6Us0MAzV/
         tNC6dB6AC4lHtz7/iHwC0hWKiXLqi8ScqBArn7BHX6gKaHr6h9ObktWtl4ksthIWUnp3
         ATDutc4zZugBRe3HySxQTBnrAqMrwbNdElxgS9Fdd8gy4s4uec5bhluHlbT53QpyJsad
         pxTg==
X-Gm-Message-State: AOJu0YzDJbbykw5KlYtmqUa+vF+KcpnrOPACg5BaXzJM4Yya9/eBmb21
	cyYg70EYdjnDjOm3YOwgHkeWl4nRvx/JrYn7h3u7RQPajX55hngj5wJ6hgmUf0M=
X-Google-Smtp-Source: AGHT+IHtsuNcEfrkZNxZXJn2Ffd57halZWXvMWV73EMgUfd3VO5ggiU9c0ObA4r8Ip90QOb1aqxglQ==
X-Received: by 2002:a05:6214:5c42:b0:6a0:7cef:9883 with SMTP id 6a1803df08f44-6a168152c8emr196076716d6.14.1715788717826;
        Wed, 15 May 2024 08:58:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f185151sm66126806d6.33.2024.05.15.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:58:37 -0700 (PDT)
Date: Wed, 15 May 2024 11:58:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] pack-bitmap: various pack-bitmap-write cleanups
Message-ID: <ZkTbrPjTqMEQGonv@nand.local>
References: <cover.1715716605.git.me@ttaylorr.com>
 <ZkR61b5fWoRCv18D@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkR61b5fWoRCv18D@tanuki>

On Wed, May 15, 2024 at 11:05:25AM +0200, Patrick Steinhardt wrote:
> On Tue, May 14, 2024 at 03:56:46PM -0400, Taylor Blau wrote:
> > This topic was born out of tb/pseudo-merge-bitmaps, which has a few
> > quality-of-life improvements in the pack-bitmap machinery.
> >
> > The main changes are to remove the static 'struct bitmap_writer', drop
> > one unused fields, and start using another unused one (see "move
> > commit_positions into commit_pos fields").
> >
> > There are other smaller changes, too, like cleaning up the flag
> > allocation table in object.h, as well as introducing a new
> > bitmap_writer_free() function.
> >
> > The next round of tb/pseudo-merge-bitmaps will be based on this branch.
> >
> > Thanks in advance for your review!
>
> I've got some tiny nits, but overall this series looks good to me
> already. I don't mind if it's merged in the current state if you don't
> think any of the nits are worthy to be addressed.

Thanks, both, for your review!

Thanks,
Taylor

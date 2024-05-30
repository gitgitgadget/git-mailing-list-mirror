Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F3186E2A
	for <git@vger.kernel.org>; Thu, 30 May 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077548; cv=none; b=QwSptNKoa5a1RBg4kIptMAOMuXe2yOR/PebDaiRgna8AKKlDMoNamC2NOcA1D/S/yp4w8QktIyndX8IlSOJtva1Wi4GXNaiwss+NzvAFGYdlPU9mmiMJT0u5WbJlm+xiyMH2DIqTfwPsJzKVz5tsCB4fNVWTh1m9vW0hitXQt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077548; c=relaxed/simple;
	bh=7TA45615faKR+rKlNnV3DKGAqyO7qB1eInshP/mobKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHIllGwFNnztyqW1gBTg+pFjMeEUl9fcOCiUaummmnzHIXREBWG2xAf1HdksSYmpJuoBe35Z5/ezIAuA8imPlwQGWKo3CUFUniqpq6iyWjzcYwXdObtsfWROphSdJxRgP2vY2GPstWa1C1U41HzqxFaLE5Go5g7IqwSES4epx9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dYW6/YyF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dYW6/YyF"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-794c3ae6db2so65209185a.0
        for <git@vger.kernel.org>; Thu, 30 May 2024 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717077546; x=1717682346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TA45615faKR+rKlNnV3DKGAqyO7qB1eInshP/mobKM=;
        b=dYW6/YyFov+IRsTzxmOJem3Baj6oANY4spvHQGlb/JOGkNKqYQkvuXwENPIFf14MxB
         gWlDryfHIOS4pYWwIkhI/CcFgi2XF20UOEE02MZr7ZTsHGCvORLdKuF5HSeDfaXjgLUR
         /Ft17XYyLr9sOG9QbsiD+HsZRgIIRrn0tjMmHd2mP444iEQdXPfcJbs9LdByynJWJXYg
         2/uA3OQocJ0b2CFnpXCDuypIOkusv74OlBA/h7M7/xSbmG0KxJ4P79KBUoDEgDnApCwa
         j0SkuN8lg0k0kLst3X1XFrPv4l5kpqhDjBLFNQx7DImr7UcV6Od+iUe8fNYhDk5Fzhqv
         hi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717077546; x=1717682346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TA45615faKR+rKlNnV3DKGAqyO7qB1eInshP/mobKM=;
        b=NCm2RCgFSNQow2QUGOZIMpiIYT2J1RnY+UB+efZoB8Vd5FDE1KxMzYPExrVMGNJeqY
         EvI3Mi0YrBdGcV4bb+AqzvXp0teAwDqeg0bricDmbmH870FVtYGxA3lUg0cC4Odnfzy0
         sCIAlAIWL38wiox1RN8eOTkFAjc7dHPwsUPXs8eWlfoIKCoriLSv+1ECuC4ICRPTka6D
         lEbsk16EYsJTMqLCvTPhItKEOd4pMxquwTxbUEOalIWOfGdFUvtBPUKg3HW9iRYunD0l
         mhchEJf/JQ98yUdBQ3X6gvhUocxOxQXg1A2yHFZDWWS8Jt8y1qgpUiljPOYcU3ouq6O7
         IDMA==
X-Gm-Message-State: AOJu0Ywov41vX3Ke4nGbSFAj/VqCM/mSymDFygFUKB/jCBR4hPoiNeol
	e+9skRSs6KeVBQGHCmUPJjNPspmLVibWy+bmHy9kWUDSxjy/VKZNqmmomL6eOhs=
X-Google-Smtp-Source: AGHT+IF0uq/dOFXJL8DtVKksBoHDiLcRhrZ6q/mXEaHjjtQkQoVo7rYFZcPRaF2SWnebjOJzN5euAA==
X-Received: by 2002:a05:620a:1270:b0:792:c037:abc7 with SMTP id af79cd13be357-794e9dab2aemr202578285a.25.1717077546091;
        Thu, 30 May 2024 06:59:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca59f8sm556902385a.13.2024.05.30.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:59:05 -0700 (PDT)
Date: Thu, 30 May 2024 09:59:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] midx-write: miscellaneous clean-ups for
 incremental MIDXs
Message-ID: <ZliGJ0EYSfj2LhyY@nand.local>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
 <20240530071432.GD1949834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530071432.GD1949834@coredump.intra.peff.net>

On Thu, May 30, 2024 at 03:14:32AM -0400, Jeff King wrote:
> On Wed, May 29, 2024 at 06:55:15PM -0400, Taylor Blau wrote:
>
> > This is a small reroll of my series which has a grab-bag of midx-write
> > related cleanups that I pulled out of a larger series to implement
> > incremental MIDX chains.
>
> These all look pretty reasonable to me. Thanks for breaking them off of
> the larger series. I think it's generally nice to get things in smaller
> chunks.

Thanks for reviewing! It is much appreciated, as always :-).

> Sometimes it is a little tough to evaluate refactorings without seeing
> the larger context in which they'd be used. But all of these were either
> immediate improvements, or didn't take much imagination to see where
> they'd make later things easier.

Yeah, I feel like this is something that I'm still trying to find the
right balance with. I think with the pseudo-merge bitmaps series, I
erred on the side of making the series too large, which made it
difficult to easily review.

Seeing the review process on that series made me a little uneasy about
sending the incremental MIDX bitmaps series, which was growing similarly
large. I think that seeing these 8 patches or so get sent in preparation
makes the later series easier to review, but I agree that they are
somewhat unsatisfying on their own.

I think in this case it was a reasonable trade-off to make, but you
could probably make a compelling case either way there ;-).

On the bright side, what was once a ~30 patch series is now three series
(of which this is the first one). The main series is now 13 or so
patches, the end state of which is to have incremental MIDXs working
without support for reachability bitmaps. The final series I'm planning
in this area adds support for reachability bitmaps with incremental
MIDXs, but that series is only half a dozen or so patches.

I'm hoping that by sending it in chunks, the end-to-end review process
will be more straightforward and approachable. If you have any other
ideas to make it easier, definitely let me know!

Thanks,
Taylor

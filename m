Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87062372EE0
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800462; cv=none; b=B1XIPzz4RITjkkEW11XY/tXvsFIxaAW/j7H0AoWKvEsmsqkec81/pQODLvp4u2ld9dD4MjJI2+iMqzz0OWSG/+TQQilvgh4+0J1kEqAeJWDSbqGHRbu9vYickQB3nOAI1y2d79GS40CR1a4jcrEopFSYx/WJsT8euw4diHnzMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800462; c=relaxed/simple;
	bh=igXOhVAxljDbGbrwq/kd+T+wiXByOFyGeirg1xYx9WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgEiHF8Ac5vIgs5y7PIYyVtFRV2wmsHyqCO+EMENmsrnhwANn8j6R5f2usJqWnPwnpmsAxjW11bQLm0nINY0FXSvQZTatX3rV0XEapmYsWz4GSOG/2ivMZblxCGeLePvsx73zlk7TqSCeehkRg1Sp22kJVH1mC/sTt216Hvb5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gvcEexDd; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gvcEexDd"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479d5ff103aso1158512b6e.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776800460; x=1777405260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZHRV55gQ9V4/CL3Zgv2ARNRJpuGcokwJFBdVIDIemk=;
        b=gvcEexDdcW3gOGVvmH0noQJbnDe223a5OoM/ohmEYkDfnTJlhx4W0F3/O/wTNi6gwu
         C1/c5xcNKmMAEuZe5pvD0AEqwCsyzmTOwLcFZ/TK6Cu0nAAFCuiQ+PbmePX8BiHEnL/i
         0zMWwvBz8P9incRBldy6HkYxn66yPOEJerPVYXgihKNdDoHPMWQs0h2VLvGs+TksAaxc
         gUicUKVABXyzkIW8aRuNiYr4xc8ntY78eCVaF40eq28KMiIdiF4RxISw1OG0AACJgO4G
         khphVeQjucR6rDHPvBHUyhnVsW3SdQInqe5VZ35cPV/ktHvJKZxmrOd8CofeZNtmgiey
         A89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800460; x=1777405260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZHRV55gQ9V4/CL3Zgv2ARNRJpuGcokwJFBdVIDIemk=;
        b=HZXCgcKo0w1mPCtW3YPAJoS4Wc+HaXJA5T8JXnCCcXA7UlAq/2peUC83DYeRbLKKMX
         6O20idOhxEsgr/OERb4g4bltSmzT2GxAegxdnHfzqwgySZijriQ9UTHRTRzpVuHV8ziG
         AZF4kK25BXBalOgd0jkZ7Ea6EawofGSJS6JV+p5cBHO7R2riff6JXxzSzkJALlVRB0Jy
         f+W20mYWlVD4G4P6EO+HMPJlA7VRpshbdLMwOMBSMtRMw5VozEhuNoedKB4VHVhBXjP5
         H8kmWydXXvQZps+sRex0aU8lckn6h/hG2g+V6B9O4C02ItrbDLuQdGoTEQ5QS/f1TUK/
         TFmA==
X-Gm-Message-State: AOJu0YxydcXNxiwzDW5JCmsa7Ektr96C0IKfke1XruIcR1X/qEAuhPhU
	5Ljp5A5CBVxmlR5c1OEgE8sEaw5KUoAtKauElNnGp3WLVgJY1MgoAtDXJEXzcqB5pPE=
X-Gm-Gg: AeBDietkgy7GYqGzszS0xdjnoughb3/3yHMysf3knn0MDqYjgRVHOofL/zuY6Ycv2o4
	q03N0B3eQLAaX4g8k1N2fsnrbmQT2sLx3n5xdjRhgxBRfkqTYNjQZUOGQgM5EtUdbfWznAfeGwt
	TVtaos5AWD/dy3vob5mhZAUyGDkDiWRbVuMDYPgA4NsDNDAdyi/x6QTcl+d8lWsqEDGPfGwmAWS
	KSyIBb67CLS7tHZbSTOQyUw1p2isrU9NzTLo7xRGEnlPF8fKRBJtMKis5q6kk2ya2QMqlgHtPYv
	6vY/ysnmhiDa6J0oYnlBB4zps8X76zVxD3lTeI8gsY+2ALusC1X57jG78lnt4Tx3E5K6XriHCle
	ZCPXid/Sm8AfxBvBOMHnktL0fm7wavermqt+VR4Iei/suzaNxWBu4wvtk+UngM8fZ2v5d6Bcz72
	TOXI56zMxjyhiAYfDN0fGDZErkm27VbrpSJ8vN7hzFpHkyD/xOyA3txFwlGDlS0xot5tKhhNePQ
	OqUIKHAU6Q2owfus+9V8eJNFcv87Sq1vyx8rjzSX82pYAFPQCyMlpr1vQTEln6Cln7tQpdSi8rh
	qxiOCqK6Yfsii8Ldief6z9SaMgRbbuysa5nFbw==
X-Received: by 2002:a05:6820:80c9:b0:694:8ed8:e587 with SMTP id 006d021491bc7-6948ed8ec6bmr4605490eaf.49.1776800460483;
        Tue, 21 Apr 2026 12:41:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464e5e752sm8805272eaf.2.2026.04.21.12.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:40:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:40:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 14/16] repack: implement incremental MIDX repacking
Message-ID: <aefSy92LC3Uo3hNW@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <8d5aa3d6fa70d408fc02561f2203ae1a48186c91.1774820449.git.me@ttaylorr.com>
 <CABPp-BHuj8UKG3Mh9opniHMrgNkKiWLKv7pqVAex3PeAX1+Ydw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHuj8UKG3Mh9opniHMrgNkKiWLKv7pqVAex3PeAX1+Ydw@mail.gmail.com>

On Thu, Apr 16, 2026 at 03:53:10PM -0700, Elijah Newren wrote:
> Although, midx_split_factor is defined here, it isn't explicitly
> initialized anywhere.  As far as I can tell, it's only initialized
> through a designated initializer in builtin/repack.c with
> midx_split_factor not appearing as one of the designated fields and
> thus getting a value of 0.  That would result in a divide by
> zero...although, as you noted in the commit message, this code isn't
> yet active.
>
> Still, would it make sense to initialize opts.midx_split_factor in
> builtin/repack.c to something non-zero as part of this patch?

Good point. I had avoided initializing it because this code is all dead
as of this point in the series, and I didn't want to touch the repack
builtin until we actually wire it all up.

But I think the point you raise here is very fair, so I introduced the
constants in this patch and used them in the initializer, then adjust
them in the subsequent patch to use the given values instead of the
defaults.

Thanks,
Taylor

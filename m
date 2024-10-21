Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB81E284A
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547289; cv=none; b=N7mBhFOLn//y6xy7ZapC5zNIx6Z70NgeiGd6DribLiw3pk7UysaMpxngGhFFenBIez9EXhzPkPy47DHggLRi/rarN/9YKpYh/unFXRIvRfB3qQ2ti72KwddvKuTVlMz1NyK7XKMimzZPpaoIAviy+ic4V67aJL6kpA0tUfCMqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547289; c=relaxed/simple;
	bh=E7f7KFph9RhTm6CO9Oj7XpXXs1V2nCQj+fr3DA9nXB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgVlhUYGhHRimcG47CVTgHVqCPNBs9zZ3e2WM/oh07dupKUAK5q8NOyraViM25jNWELMuNGeAxZWqzsHSxXOeci2WuD2kQPQghL3kvJrSAGstYnVyPqfhhJlMb45KxdAIzZMpwGgOx7bN740DNVvkWpWrMHfU57zNLhBUz8jZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DPetQYPV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DPetQYPV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e38ebcc0abso54189017b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729547287; x=1730152087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hTFAoQFlgGgS+n9+CTWi1Adc2zN+UaKYXI8+BKueepY=;
        b=DPetQYPV7KaP/by+K0q24DjV2c1ooS+DsbKK2R307Rt7uEfRMrxyHEGs/vUuNR1dTP
         VaxL1Mr/5ez68emGjMPCuWccNFLO252NDk7/gUZCq8rifCYagLOWZcZWLHIbFqU66zP8
         2irvFWW+JPtFcFgSsX1jO9Pc9JWVuVk6xCtJl58ROerKJA9aGrpkqbzCd8oF5su0Uiem
         yXd/V9P8leUd0iR5RwLgLQJxUpRDq0dM5q7Jc6mWpkMRVx0E6bEWoAARHa0tHMy9K+kL
         PSq8JdQbauz7Jnp/hZQ7xAqKmVT764ckS+jvgGBTDCv269SKkhR+WWqTTKBboDVJf4NC
         NDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729547287; x=1730152087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTFAoQFlgGgS+n9+CTWi1Adc2zN+UaKYXI8+BKueepY=;
        b=oU9YoYRcuG+hN4cuwhummY30djkJAqJBSUB0JaYqf50R1TgmWngZVsKVJSYLCNoqr1
         mm8dR3BT+ewv/MtH9/9qgIHDcBz3TfbGv5rU1/OE+vDSyVNkZrc0WotR9FPL/Tj1vTdi
         WbhtKZ+oShEzcmZzx8iFQpvG/vEAmEN6ruvhYxfknheYHmb8bUOkSNf5ikc3v2bvd+mn
         AgpOOW7LW0BbkpvFlNtCiaXBqH43tHlcetgX07InQiPnkRUIs8c4ZKWZ9CBt7Vu59lA5
         26iVWMmo/VO2M/dzdT0UacqiThSVwQCwVOULEefZLkQU5REk4Ctt9ryR9I3EDnV3IOZY
         9gsA==
X-Forwarded-Encrypted: i=1; AJvYcCXuLb+B8KT1aoCAqaY9hCHuCjjByPEREr4j3tOL+r1mXiHCuF8WJJhseToLFDTdlnZ5+eY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw633jQJPo7Dvjb2/QEequtIxtuDsN9ota99+WwgDUHPA79TBwE
	jQH23cGXGuwpVj/V9fwaq1IVBZ0Rcx2kqb3Qqr2CzTY4gEy6cUx9hBJQi3UbDD8=
X-Google-Smtp-Source: AGHT+IFCBiLyA/AQ7wPkVnxg2jqb4kF7fu88Fh0XUDd5azNADb600B4KgoCHckJENUWm6XsS7Ff8Bw==
X-Received: by 2002:a05:690c:7288:b0:6e3:32e2:ecbf with SMTP id 00721157ae682-6e5bf9ffee8mr129665737b3.24.1729547286741;
        Mon, 21 Oct 2024 14:48:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a502d9sm8356337b3.47.2024.10.21.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:48:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:48:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1016: clean up style
Message-ID: <ZxbMFQSL1brz86f+@nand.local>
References: <20241020121729.27032-1-algonell@gmail.com>
 <98c5e44f-42c9-47c7-9fa1-e6cc3b35cdb4@app.fastmail.com>
 <ZxbLlA0xbuhP7DJK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxbLlA0xbuhP7DJK@nand.local>

On Mon, Oct 21, 2024 at 05:45:56PM -0400, Taylor Blau wrote:
> On Sun, Oct 20, 2024 at 02:46:18PM +0200, Kristoffer Haugsbakk wrote:
> > Hi
> >
> > On Sun, Oct 20, 2024, at 14:17, Andrew Kreimer wrote:
> > > Use `test_config`.
> > >
> > > Remove whitespace after redirect operator.
> > >
> > > Reported-by: Taylor Blau <me@ttaylorr.com>
> > > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > > ---
> > > As discussed in:
> > >   - https://lore.kernel.org/git/ZxFyKXDCJkRZYYQY@nand.local/
> > > […]
> > > -		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> > > -		echo "Hellow World!" > hello &&
> > > +		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> > > +		echo "Hellow World!" >hello &&
> >
> > What Taylor wrote:
> >
> > > Thanks, both. [Andrew] -- it's fine to do this in the same, or a
> > > separate patch in the new round. Thanks.
> >
> > You’ve posted a new, standalone patch.  But what Taylor asked for was a
> > new round on that typo patch where you either squash these changes into
> > the original patch or have the typo patch plus this one.
> >
> > At least that’s how I understand it.
>
> I said originally that either was fine, but then revised my statement
> after remembering that the original topic was already in 'next', so any
> further changes would have to be done on top.

...but after queueing, this patch does not apply cleanly on ak/typofix,
which is what this patch should be based on AFAICT.

Andrew, would you please send a version based on the aforementioned
topic?

Thanks,
Taylor

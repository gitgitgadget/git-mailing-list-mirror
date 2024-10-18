Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707913541B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285463; cv=none; b=AWdTc1WiYre8zJ4NoKQpDgw0LDEsSK3F/FiZaxhqdvs0OVg5susMXiYKXy3Ijhh6keiTgoqLX4oRC6LgEM6G36SGPO4R21v4BoVnbQlhlVhwy8+IP98wHEo8Bz1nfbg7/89PG+GCHKWf32NuJm7A9fv+pM/FKmLg9V7UvnQ8nA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285463; c=relaxed/simple;
	bh=lGT0r8TsEt0GYh67+koA/ViWioxh6VxwRfD4uq1BtwY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPKBOMD2Y9K13Q6B1HJUYt/qN8ROSPBPhjCxfRkOQfF6A+FE3XMbv89RKjvX98L4NNkLUcMJLYiCUxVHcS14/8SMAkJtgs0IMxLnPEYmiy4HEgodhILkF3jdIuRPG9kfoY4SSatGsXJgPx/dWUwMm1cKiKa2QvGCreS8pZesTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=em8CJoVq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="em8CJoVq"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6db20e22c85so23111027b3.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729285458; x=1729890258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJQ0Hk+7cCiJqKqZLuShdTJvLodif2+ocpAA+10j728=;
        b=em8CJoVqzJHOVgsuP5y9IP75hx4aC28YFKVufpuYZFEMHs9yQVhI9Ghyw3HoJ5fvLT
         djZkF2d7MduxouNJqdth+HuYpE7J/1hk7m6I5HCjbNRgXEvGNSyBH8w5423MDfJ54ffq
         W1EkzFLQR+AVHlUWJa14t6yT5dDHIoJkLuKRUtOtcKSFxgwHQ9C15CgScRv4+uRSTtee
         KZE3tTmwpFWJQT18ArbL3JM86pJW00Q9KeOrc1YwJzK2cQMxNtlYKDrjtfZQDsMrdEPx
         ujPgTBZiV9fzn7pYrvVxzcBDmF4FV5pLy6Enh10dUIVs6wpWheeaewDG/o4eUHdr3MUE
         DXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729285458; x=1729890258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJQ0Hk+7cCiJqKqZLuShdTJvLodif2+ocpAA+10j728=;
        b=gmzTIvNLEycGuoqz09hF2753b+X7IKaosla5zukw1ei6OC4GjjUqK3pSfs+PFPc5K5
         ZJxGsvs527TvvkEVYeWKavDVz58iu+F6Jg5uTGC+gQIEwj2/UvuOf63WyVMOsKG3kTBP
         0uuUL0Uq6HJEojWiJAkrth682s8R1YPgkXvJQDGrjNEjXAFs46kBqz4Gb75A9c00aEQP
         uwMbdlMBtp7x/DDZlgAVnMSjXQAK07T7cN68hN64TyR28rQjiHrTKCpPOI/Y3KGbDFyA
         xHXXezaiil/bMv5ocyqbpz0zB3qK6QGykMIAiDHOtWWMDJa6LHMVijv3ZlPTE06667aF
         BcsA==
X-Forwarded-Encrypted: i=1; AJvYcCXLfMZxbujjMfOYiUjyNUUhVoqptL2pSIaUuIj7XCvez5r3GlkYZiS0zF/BW8PDueIoFKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqopRWbwmJuQpRLyVMZYogK+KKpRlj9bWkG/ROVQNYrThJdq7
	WFtS8kIgYZEMWX7+fr2/mcygRQu00f/TTJwvqdrStMsJNMexiuUvK7P73E7/OFM=
X-Google-Smtp-Source: AGHT+IFIQd/ZmqZsBFocIO/nTbr4bps4okDHjPVFam47EoT+GPGr1ELTrdpalZsaFlA5R0Iv1TPdBw==
X-Received: by 2002:a05:690c:dc8:b0:6e2:f61e:8c9 with SMTP id 00721157ae682-6e5bfd4ca84mr45443567b3.30.1729285458137;
        Fri, 18 Oct 2024 14:04:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c024bf8bsm4638307b3.123.2024.10.18.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:04:17 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:04:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	David Fullerton <david.fullerton@alexander-dennis.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Install Error - Failed to Expand Shell Folder Constant
 "commondesktop"
Message-ID: <ZxLNT3GSPrUVJVF1@nand.local>
References: <CWLP123MB4691D6EC228FA467749267FCCE402@CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM>
 <ZxKw66wR3UzCuj_b@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxKw66wR3UzCuj_b@tapette.crustytoothpaste.net>

On Fri, Oct 18, 2024 at 07:03:07PM +0000, brian m. carlson wrote:
> It sounds like, from the message, that you are probably trying to
> install Git for Windows, which is the most common distribution for
> Windows, and so I'd recommend that you report it to their issue tracker
> at https://github.com/git-for-windows/git/issues, after first checking
> to see if it's already been reported.  They'll be able to better assist
> you with their specific installer and any issues you may have with it.

Thanks, as always, for giving our users some helpful pointers.


Thanks,
Taylor

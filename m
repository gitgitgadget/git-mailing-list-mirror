Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC420371D
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270298; cv=none; b=RBDsTwRaEnD3qABtkwma8Uf9NOp34V/7iBGhb1ArdjNH5d9zrlo9TkaLRCRUIkSHBeR2adx/xbNUS+IwdL1QZLaKx7ISaxeoleCEKU7uhy4faSbWfRgwQE+RwdBV4fi2w1LcBKoG3rXmBFoO1ip3f8yETKtSpCGqckwk2mRmmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270298; c=relaxed/simple;
	bh=HIBUnBvOFISjRaiHGiOp6OuC2WPCnUqlsTQDLkjMO3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWG5uKYDnFVQugqMWe6uf2hU5b0RywtoHN91aNUiwSmO36/I5CcdStNdysYcHxWKh6O1/yztxqIYlyUzX/hvbn9H8EfKrHPSY4j7eQihKmajbVTMsVDe4G30brwTIkPXnfY1JhkghXaRLJ551EzxpBXjWQtu9LbfThxvPvRKdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDvsDx8Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDvsDx8Y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so2599468a12.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729270295; x=1729875095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XI2LsTHgvyZqnSAD+IhFQSimP2w2WuK6FZ1dGGnLOcA=;
        b=LDvsDx8YTHIpY+FYCgMV3xktgBbziwaouXhP2k3Z86BEBjQiibwuDeC+soJsoI69CY
         iPL+jQW6FvcyWmk78wPf0E9urqJ6qeFK9Q77QsIJzWoK9dQPxe9ZlejZczDD5RnsfUIM
         /tG5Tm0yagupsKqIAUH7AWO7XxtqktE1gwdH1Mo+2dGsMj8+qxpMZj7wDv2B9PzYRy8R
         5eXufVPm+wi+hq6mmyuHGLVzjiQI1vk/7+i9Ri7pGBN7DikFpiPb66mD0PTE6y3tL3kS
         CfA49WJVVNo8r39wdxJhgerUJv3swpDNE/znr22wz91AV+CBJOO/uOTAFaRbzsrv1W1E
         aw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729270295; x=1729875095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI2LsTHgvyZqnSAD+IhFQSimP2w2WuK6FZ1dGGnLOcA=;
        b=wXKx9vh4WlM4iXS0t8G4hkWmKQvEllxQzHKmRGu7jepLdhtc945b1UGEUdTlzYLzrR
         kt6E84SO1A5Susrx/XZ95n0mqDyolr77fGGNrLxBnZ2LtdDsvo34NI9i+Q9ejPyt68Vx
         +yeKsYzSqXQsMqwuNvLGtfymco2nv6Hk+3SK0IqOvi5+ovgA3qZkP4mTLZCyyAuxxKI5
         PXYwT6JkSBpCl+psVXnYRgJLHoSwQFAmPEHsrqwf5zTnVIZvB+8UgD40YiAr66p3BcTO
         pdXQXv8ufvPDUdnjogZ83XZqwKqlz9kouyPeLxVyiuWQXsAXZsWLmKnz5zQ/Ybuh6mSP
         DDaw==
X-Gm-Message-State: AOJu0YylaAxCvNDApDhjS4/Ep9o+nFTg/VQm6+eSB46t6h+83d0E0tVI
	xDo9mscNUelDj9x4wwE7f3X8EVsRFm7+EhkrTLnNS1Esh+MlA9KPFGwR4g==
X-Google-Smtp-Source: AGHT+IGkq1Bu6G6H19Oj9msB61H5qAQTd2x82FhSzcb3eRScJzxrmJ9balBKKljUwbPlwJ10ptJ/XQ==
X-Received: by 2002:a17:907:7296:b0:a99:8178:f7ed with SMTP id a640c23a62f3a-a9a69969b1emr328473266b.4.1729270294751;
        Fri, 18 Oct 2024 09:51:34 -0700 (PDT)
Received: from void.void ([141.226.12.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc4b82sm118001666b.140.2024.10.18.09.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:51:34 -0700 (PDT)
Date: Fri, 18 Oct 2024 19:51:32 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxKSFBl_pV2r99dY@void.void>
References: <20241017112835.10100-1-algonell@gmail.com>
 <ZxFyKXDCJkRZYYQY@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFyKXDCJkRZYYQY@nand.local>

On Thu, Oct 17, 2024 at 04:23:05PM -0400, Taylor Blau wrote:
> Please do not base new topics on 'seen', as it is likely to change
> day-to-day.
> 

Noted, thank you.

> > @@ -117,7 +117,7 @@ do
> >  		git config extensions.objectformat $hash &&
> >  		git config extensions.compatobjectformat $(compat_hash $hash) &&
> >  		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> > -		echo "Hellow World!" > hello &&
> > +		echo "Hello World!" > hello &&
> 
> Not the fault of this patch, but there is a style issue here that there
> should not be a space between '>' and 'hello' (i.e. it should read
> '>hello', not '> hello').
> 

Do you mean that '> more' and '> another' should be handled similarly?

> Likewise with the 'git config' use above should be test_config, etc. But
> this patch does not need to care about that, since it did not introduce
> those issues in the first place.
> 

Will try to address this one.

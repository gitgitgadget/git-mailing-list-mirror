Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD82217F20
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729891733; cv=none; b=U4PkHgDVl+zcGO2a+HCo12zREAe+ubXWfCpNjJs0nAhtqVHSqyf3rEE2rPJpKLudny+KO15AquMA8/Eqm+eZmH+MzXRrsjFR25isuWu+vj/lxdETrBEHtVw5qGDYtuFRmPVvC7AkBa4mtHMVS1mOc202CBnDy6ZfMlO5ziI2W3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729891733; c=relaxed/simple;
	bh=gz/DavKz5yO89Pf+U0xLTcdcXfzi591RnXW+ub0/WCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozPFK471xSbkgNcmS/st8RnQLQOFYCYsxh7l01aH7mBMQV7B1sc1ECoeDH9hFJrBeCpmzPWVQcjrRN2S9+mZQks1myaEIJcBgesQt1Y11a+I+/CXToBA3RevPUzpmhDKZgp9fFdVka/+6EgqguhpofD8TWg2PpBi4PDSqwgG7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ns3W25GP; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ns3W25GP"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2972abc807so2775879276.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729891730; x=1730496530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gz/DavKz5yO89Pf+U0xLTcdcXfzi591RnXW+ub0/WCk=;
        b=Ns3W25GPDxUab2vgepQTN30rxXdR2/NvPpHKp6Hha1KpvBeaf7/rX0wQYEXrmJBTHV
         ooyQU0HGAA8c5O0eAFie3j4OVsdboAJGTcAfI8zzoH8ld2pEhmXMdqm0qtf/ClENt9Al
         kmMifYeUtQhynt0b3wLchedstYvTMuNq+mvsPk+/+ZonBBkuua81ZsAXbNEjqJBtZAQd
         lDglMfRND4mfiVr0lGTInrebAH5yfyuzdSJ9axeWqzHU/kSXFDiw4qYo+nV8hx8cjcuY
         Id+xqabbo/IQoNi9lOqOOvvAC5k6OoeStgmXfcAoZ28KCbFgC5RCBytaEpFvA3E8ebXC
         1vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729891730; x=1730496530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz/DavKz5yO89Pf+U0xLTcdcXfzi591RnXW+ub0/WCk=;
        b=X6qp/L6Dm54UzYNVqB8LivgklOtjn2VxSDEqFKGDAlO3EAvaJ4uW5d5UeOs+k80NCp
         RuUEzo5Cyg5RGZKyz2zBycjpgz+6F2wFb1S+Jf6vxEFuTrf7oDxDg3Xr4tFhVVGgm/e7
         /aT/B7DziMhh9p5nHMGzEbwGZKV7DV3UWnYP/QUJYrhc3ldrW02PDbLZLyOF38oTh2lf
         8xGpUsogaEB2G+zAIPa3fxjRDZn8BdyX8u8T9LVuuwfJC6BVQXGRKx8Nh8DddepJ2cOo
         OfaIuD6OgT2UQUVUWu1bFjcQ44f4zK4sPo5bmYoTcTrDAfMhNpslgGx2PE7OQm0T60AO
         og4g==
X-Forwarded-Encrypted: i=1; AJvYcCUJcg5w8ggPr6Mx8SNizKv8/QV6lyQOrCEngLQa48f4+SK4he584jP+WsvQV935aTCPm0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLFSn10FhE6UFqV9R+86wMV0+GJHOfCBIXLKp5HvnZ1hdfPls
	+lph5ff4Wxdfnq3mkhmaSVQRJBeluhzBkAq4icniqZVsdG8EuPn74fdI3OJoDWw=
X-Google-Smtp-Source: AGHT+IFX+PAdbYWwvx2asg2S3sq2EG0+/my/hNMzWkfxLHH/mHHa5IzpO3BrlDKSAQ3bQ4KvDXQHtQ==
X-Received: by 2002:a05:6902:1201:b0:e26:29dc:8dd2 with SMTP id 3f1490d57ef6-e308794bd4bmr1111025276.6.1729891730154;
        Fri, 25 Oct 2024 14:28:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a03bf62sm366293276.53.2024.10.25.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:28:49 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:28:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 07/11] packfile: warn people away from parse_packed_git()
Message-ID: <ZxwNkGlnwX6esIEE@nand.local>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
 <20241025070222.GG2110355@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025070222.GG2110355@coredump.intra.peff.net>

On Fri, Oct 25, 2024 at 03:02:22AM -0400, Jeff King wrote:
> With a name like parse_packed_git(), you might think it's the right way
> to access a local pack index and its associated objects. But not so!
> It's a one-off used by the dumb-http code to access pack idx files we've
> downloaded from the remote, but whose packs we might not have.
>
> There's only one caller left for this function, and ideally we'd drop it
> completely and just inline it there. But that would require exposing
> other internals from packfile.[ch], like alloc_packed_git() and
> check_packed_git_idx().
>
> So let's leave it be for now, and just warn people that it's probably
> not what they're looking for. Perhaps in the long run if we eventually
> drop dumb-http support, we can remove the function entirely then.

That seems like a good step and the right place to stop rather than
exposing more internals from packfile.c. Nicely done.

Thanks,
Taylor

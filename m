Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1BE14F9DA
	for <git@vger.kernel.org>; Fri,  3 May 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750637; cv=none; b=D8d2oaRHwrcB8XHh0gWHv45z1sKWgdrOIwmula7wXI6gLQSpqSjh5Pwvf+zlvahrqjh9wN07UHhFOUDt9fNub4tGQ9hMCPm69K60V0bcHlXC502xpjkgk5mh/iUEN5lo//lNzbsM9PD5AbSMxTZGsm6H9ruWP5i5WT+y9yFNUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750637; c=relaxed/simple;
	bh=mW+nvElmNC2HOk8X/7+xZLV9vsgd0gvDbt/cuMcnlyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEk1GeN5z3TzpJF3WSrYN58RQqYFbuk2d+e48ip3zTwql2GiHABX+uxwjdzCZr8GZoVqV3KPdAEKwBPLljokGkKPr54fSNF3lb6+beFTO1gqSHTDpBWW9OFpSHXZi33HnTmluQ0oB8Ni3n6U/L8aNHDzXX2233N/9S3yJsYrynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIT0EF6A; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIT0EF6A"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ac90ad396dso5001573eaf.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714750635; x=1715355435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xssaXy3fWEsXP9ms4v1st13N+H/zzmMdU1Y9h2IjcOE=;
        b=jIT0EF6AjrBDMy8kV9Dyg8brcEOSACDeez/FTFx63RUhScZlOHmqgDTHDlHAFsHqe1
         UIyoYkcsTC77wra3IR8otAy6JUAAuysU/cLp95rEWT/DDIoAfZzDu91U1xqXakqV8SZ8
         kqlehtAdbJ9r97brsWUVG2H8EQPeYAavXcVI5VT55+KpPJSv5dLQ80rI5wsfPeO9dh45
         5l9KtrXklEqrJgtCC5kSrIbAiRe/Io6BcWs3G6NcE0dcLUQiwm0WJtwF8nIaE655SyFw
         Pp6zCGHRGa+XEh4KzaZ/2IjyJqbNzPGDGA8YgG0jZbT7Al8btDAL+t3TiBP3hYJMU5Pe
         Yuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750635; x=1715355435;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xssaXy3fWEsXP9ms4v1st13N+H/zzmMdU1Y9h2IjcOE=;
        b=lRgPzrBwsEU4qR6qmhRLFIjrVDl3/1FA3dvVoQAj0j5flx0AwLXo61d9jTXx7dkqeB
         5t5Vn+8pPThobeqA5Up/sjj/hKc4YrHOyXHluP959qg2rzhaVvd2nUYs9e7GtV5d3JY4
         mS3aXsOojNONboZZUfERFGTFrOj1xCgdgMaCmo7DpJVyf8C01qgaU3fZ2PLqeH04IklW
         AVkE9lmAAw02t8XJUl9Qz+MbUI61f9JygtEpJd9JQNHgaBwqP08FhaHUy+XW0dNSVOre
         5aburaiHB8GzimHcX9X5tPoxjjWUJWF5Ijl7cE+dhrtJqcv58E5xR7sX3PFVjKZhxpE0
         ciFg==
X-Gm-Message-State: AOJu0YxvONc3TStcnxfN3MgYA16TDv9+bKe5Nxy9nwudGnocdX0p9Wys
	Vr8szq4qemRVo8OFKhV1qRIkXYcJZRAuMMYK9tcTKZhW1AdcP9zZ
X-Google-Smtp-Source: AGHT+IHLmwSFKqfUr9ye+RGRZYe16CU04vLWvxbRyVNxp8ncmvaurPu/9ziLH8ZewLBy7rVADNja/A==
X-Received: by 2002:a4a:d07:0:b0:5af:739f:1b83 with SMTP id 7-20020a4a0d07000000b005af739f1b83mr3007401oob.0.1714750634901;
        Fri, 03 May 2024 08:37:14 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id i6-20020a056820138600b005afc4b394bbsm692906oow.6.2024.05.03.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:37:14 -0700 (PDT)
Date: Fri, 3 May 2024 10:35:57 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/5] ci: make the whitespace report optional
Message-ID: <3xwa3bvda4ccctnaqerq45qsmrzq6hf3fqltzns2rcblyvnifb@ycoui7hsbkxr>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
 <20240502193840.105355-5-jltobler@gmail.com>
 <ZjSKsGooraoQDU2I@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjSKsGooraoQDU2I@tanuki>

On 24/05/03 08:56AM, Patrick Steinhardt wrote:
> On Thu, May 02, 2024 at 02:38:38PM -0500, Justin Tobler wrote:
> > The `check-whitespace` CI job generates a formatted output file
> > containing whitespace error information. As not all CI providers support
> > rendering a formatted summary, make its generation optional.
> > 
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  ci/check-whitespace.sh | 45 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 33 insertions(+), 12 deletions(-)
> > 
> > diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> > index f57d1ff5f0..fabd6ecde5 100755
> > --- a/ci/check-whitespace.sh
> > +++ b/ci/check-whitespace.sh
> > @@ -1,9 +1,20 @@
> >  #!/bin/bash
> > +#
> > +# Check that commits after a specified point do not contain new or modified
> > +# lines with whitespace errors. An optional formatted summary can be generated
> > +# by providing an output file path and url as additional arguments.
> > +#
> >  
> >  baseCommit=$1
> >  outputFile=$2
> >  url=$3
> >  
> > +if test "$#" -eq 0 || test "$#" -gt 3
> 
> That check is wrong, isn't it? Based on the usage below you either
> accept exactly 1 or exactly 3 arguments. But the condition here also
> accepts 2 arguments just fine. The following may be a bit easier to
> follow as it is more explicit:
> 
>     if test "$#" -ne 2 && test "$#" -ne 3
>     then
>         ...
>     fi

Ya, good point. We should only accept 1 or 3 arguments as valid options.
I'll update this. Thanks!

-Justin

> > +then
> > +	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
> > +	exit 1
> > +fi
> 
> Ah, you make the output file optional here. Fair enough, then you can
> scratch that comment from my preceding mail as it did serve a purpose.




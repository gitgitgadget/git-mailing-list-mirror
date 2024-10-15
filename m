Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC411CB9E2
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022096; cv=none; b=fcaZv7pBVbKOIMapNFwH/OatCWLM2dVpLEHT8Tjkx09GTOrx8c+goLXEn9zPhPm0WcRksofLaOUuRh1Wvz5RbhiiMm778vDLSjtdjDuVrLYKSUN6SIdjA3yjVOpmbKGOE0lajMJc3rDjY+pKpabITyxEIFBQED9B7YUQWgvj0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022096; c=relaxed/simple;
	bh=IMX9UUr5zWvHy+7FeCvVPpDns/y0nnk+sxyalATzmjY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddRs6xPzQAYrJYiwrgpVEEUz5Yy9eh4kIwIwtZFqqLUqtqWM1+B+IWcIvqmRWmuQXZKl+O6bOJ9sD1HA7QtZ2GATbrT8n7Wbp8TLxI721aM5nZf2ehZ7hFixR1O79nhvn3lAlUKsbGmh+rT+S5U4yV4iyUbj1jPEothB31ABC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IobFMP0G; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IobFMP0G"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6dbc9a60480so48536967b3.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729022093; x=1729626893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMX9UUr5zWvHy+7FeCvVPpDns/y0nnk+sxyalATzmjY=;
        b=IobFMP0GUyncMlQkjA9X/ZXDCHYcs6zuXBSXPz7iG3XVnm6N+HqdVWf0a1qjqe0Ry1
         w/+wKorlC3e8PRVnOfxaqByS5xzVBhqs0D8bsvMnibg+r+x8p6t/dlzbxVvB8+WCOIem
         iBjd0maiSIuwnBM82Om3sGcq5wGkqBa1nGu4cCtyj1RBR3/pAxR1Q5gy9X0CaPl5s8pl
         BC471Lq809IqB/3uSMlhb59WHDh/Gh9sywp1zQa/RSZ4z7YUtPQ3uBKCzfRxgS6xrGq3
         s+27+fWBupLtU4f3Ynjix4knuVgl8Rlkk+2k3BAyewFzmqyYG9ae+8GPH9tkzO7D3NaG
         Wm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729022093; x=1729626893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMX9UUr5zWvHy+7FeCvVPpDns/y0nnk+sxyalATzmjY=;
        b=lCg65nLhVYUPgxfA4L8Zb/XlFt+fcClKIKmzG/7tDregAS+dZw3XpPj8zCRuOl47Xr
         Nj1PNmQDlfFiAm4gXwSejDdwCWk54fT/OUmlfp3GNuYaZQ5rQTumVkZ0J+f2Vz5rSfVI
         JmZ8Bymda/mQXItf/+CzAB572nNOBzPG75AQrZhib3AhBxVzISwVJHuHfgA87TbJCSaH
         UNEN53tS1u2Q0vqgT9fJ8Ryl/fN2OE0Z7LbwtoZCBADmi403lUH//M9nyhAB4RP8x15G
         8b7XNnsj6/1zm0I+56womYZ4lR+iXiju7ApmettCrcUDUxk6ELah4qqVyAYQk0We8KEP
         KjmQ==
X-Gm-Message-State: AOJu0YwRfbOoAz2rzgH1yYvHyhhSvtB4Cpgf1FGhCccLMzD45melE4wK
	un3OQf+XZifdHhKoM+tI+nx4agg9Yyrnvy8S7GpUERqlot/ZY8tErmbR+7p1C5RGidvdvY92LLs
	K
X-Google-Smtp-Source: AGHT+IG2E5TnQi73gZEl9J7uXd7BSSBy8mIJf8Jp5yvx3eqe9m+cvf4dlwWoM9c2Mx/KcSHkCddhIg==
X-Received: by 2002:a05:690c:2505:b0:6e3:21fa:e50f with SMTP id 00721157ae682-6e3479b95bfmr138642607b3.13.1729022093111;
        Tue, 15 Oct 2024 12:54:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d81ce8sm4118027b3.140.2024.10.15.12.54.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:54:52 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:54:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [RFC PATCH] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <Zw7IiwK5mi1rmqFN@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>

On Tue, Oct 15, 2024 at 11:33:35AM +0200, Wolfgang Müller wrote:
> On 2024-10-11 20:34, Wolfgang Müller wrote:
> > Whilst git-shortlog(1) does not explicitly need any repository
> > information when run without reference to one, it still parses some of
> > its arguments with parse_revision_opt() which assumes that the hash
> > algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
> > as the default object hash, 2024-05-07) we stopped setting up a default
> > hash algorithm and instead require commands to set it up explicitly.
> >
> > This was done for most other commands like in ab274909d4 (builtin/diff:
> > explicitly set hash algo when there is no repo, 2024-05-07) but was
> > missed for builtin/shortlog, making git-shortlog(1) segfault outside of
> > a repository when given arguments like --author that trigger a call to
> > parse_revision_opt().
> >
> > Fix this for now by explicitly setting the hash algorithm to SHA1.
> >
> > Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> > ---
> > I think there is a much cleaner patch here if one would look at
> > disentangling the parsing machinery split between cmd_shortlog() and
> > parse_revision_opt() such that the latter is only called if there is an
> > actual repository, but I'm not at all familiar enough with the codebase
> > to do that. Like the commit says some other commands were fixed like
> > this as well, so I thought to send this patch your way.
>
> Was this topic maybe missed? It's not a critical fix but would solve a
> segfault that is pretty easy for a user to trigger.

Yeah. It looks like this was sent out on Friday, which was Junio's last
working day before vacation. I think we probably both assumed the other
picked it up ;-).

Thanks,
Taylor

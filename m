Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194313A87C
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408539; cv=none; b=KYYOAbBDuCMgA1a/Cujs7Rsk2lR7fz36DO21IODgFRf93FL8MS4rjqaM0j43w3a+fryHaVKa8tfQrCmVXpDRxdr8K+Y/9PIyxpT3xdW9d6dfNYFQXnH6BGU6SLhYn+ZDM1gmChYOHbT2q9CEMSIgDC0/VNpKBmXbGjmb93/9FIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408539; c=relaxed/simple;
	bh=69DDyiXoPD3fG3zYSRS0VkZbF5UxwNI8gtW5BY9ersw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiwLNH5/IFV6GPQOKrn88kS0OeWkHLngYWpH/WFvDXdqlFy4jDFiPVk021KTD14Zr+E913oXawlxqY0Ss/qldGStVWNE6QTKpOUA9PdUCFcqDnn3nJ6F5ZNZGeUJMCZ2r/ZiwZCAwvixuzYmXtKl6RaYMcgaUlG9RMiQw6FCTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=m1QlEUh+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m1QlEUh+"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e292926104bso1258910276.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730408532; x=1731013332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69DDyiXoPD3fG3zYSRS0VkZbF5UxwNI8gtW5BY9ersw=;
        b=m1QlEUh+aZcq3o4qcQWIIvQt+VdT6X8HZQYtaV+xzfBBCkIgDgMYuZmHphrbremK+W
         88JKSYp4VkfMMQPr7/B08q8DvS48SaOSd6ZR9VafGDz38RrkwclT13Th29/kiXWoxIPi
         PZ0JXUKt6081YsvLPDewdJHCVJ8z7iUQ3t9TJuLhJc+taOB/rt0+YlhA5sH+5rdRtZiy
         8+nfbUjdEQipy4ZvJi/uX0OZB4ksVFsfxhAYfiO54gDRMvO1IJX4AJkQry9zicI7Hnvn
         uNUMijK70PxzzKzycnQB79vdOHZE7zb77EAEZoOW/FQYjpMhvcrSRs8jfNP06DDElQU0
         dovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408532; x=1731013332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69DDyiXoPD3fG3zYSRS0VkZbF5UxwNI8gtW5BY9ersw=;
        b=qOdAdoTqsv2ZE5UO0TEzAOe9ImgDgyPlK6M6Q/2oE4ULaNoIvJ1vH2KbekMhL0d8FC
         9mEOpsSVvLjPGCpVO6pcFSCkh9t42aE8P0GFaWwcDY3edU3qBAKt+LTVB90CCze4mOyU
         N4qvKBpDDMDDAejkRhqL9jDzPXh5QtVo37ZTI5BavbQO1tysjgJxESrqUcZUHzeYJ7pf
         lW+RUJ/DEd2XXmVeHQOUC4yqfSjhyXkacyr9+kTIq6R+aVgbGBMTfe6yxX8CneqwdvNJ
         yFHnvNgNNMtmZbzyllW3LwyWClqovCEJrlgvY40AsZb++Ld5ELEf5OQWIw0P5mp9/nwe
         vG0A==
X-Forwarded-Encrypted: i=1; AJvYcCWx1Swwu83TV+e5v01UROJm3z+Ik2SK1SaGtXH5zE4QofoiwTupeHu0zcettnyfSr7aHhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZ4F5JPPhCX1oHP/fJ1XNYSHUVTuVc1KbM/fmIYF/Iad47Bpw
	UxTpMpC9PG2Kh/euvleKoljPm2DSFG8Y54nXoS6xI3zD7QgjQ80ruO5vHYh1Vdo=
X-Google-Smtp-Source: AGHT+IG1AOc5xKn2+GryfrNtKykGU33Dj0LYvLr7Tr6HR6X/VUSJJhMH0jDglX5A7+ukqmvVGf5Z6w==
X-Received: by 2002:a05:6902:1607:b0:e2b:d7e4:e5b4 with SMTP id 3f1490d57ef6-e3087c34e5fmr21172564276.51.1730408532474;
        Thu, 31 Oct 2024 14:02:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a92847sm434660276.31.2024.10.31.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:02:11 -0700 (PDT)
Date: Thu, 31 Oct 2024 17:02:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
Message-ID: <ZyPwUmYI59Ov0peR@nand.local>
References: <f8ee11d3003e743affb39835ba3583dd2498e576.1728396724.git.gitgitgadget@gmail.com>
 <20241028195404.4119175-1-jonathantanmy@google.com>
 <ZyEkWyB/C/lGb36b@nand.local>
 <1dd36099-1f3f-4078-9009-6c142723430c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1dd36099-1f3f-4078-9009-6c142723430c@gmail.com>

On Wed, Oct 30, 2024 at 10:14:08PM -0400, Derrick Stolee wrote:
> On 10/29/24 2:07 PM, Taylor Blau wrote:
> > On Mon, Oct 28, 2024 at 12:54:04PM -0700, Jonathan Tan wrote:
>
> > Is the thinking there that we care mostly about 'git push' and 'git
> > repack' on the client-side?
> >
> > I don't think it's unreasonable necessarily, but I would add that
> > client-side users definitely do use bitmaps (though not delta islands),
> > either when working in a bare repository (where bitmaps are the default)
> > or when using 'git gc' (and/or through 'git maintenance') when
> > 'repack.writeBitmaps' is enabled.
> I suppose some users do use bitmaps, but in my experience, client-side
> pushes are slower with bitmaps because a typical target branch is
> faster to compute by doing a commit walk, at least when the bitmaps are
> older than the new commits in the topic branch. This may be outdated by
> now, as it has been a few years since I did a client-side test of
> bitmaps.

All true, though it's hard to estimate the size of "some". I share your
intuition that bitmaps are often a drag on performance for the
client-side because doing a pure commit walk is often faster, especially
if the client has a reasonably up-to-date commit graph.

Thanks,
Taylor

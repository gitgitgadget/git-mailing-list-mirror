Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202B15A876
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567638; cv=none; b=B5UHWTUhTOw85LL0UIhXbnB7pW0Q1LBu0FRPl+Zvh15bIjuqya6as+LcyrvWCARWJ7tg3rSaUn8gF8oMnL3d1j7r71bIOheOImldaIfUmpzaqOzcSb2Ty+MVyN1xHEwfP/KHBYQiV8fjvE0iGWgvp/pgVnaOV+EAaqucQWbrfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567638; c=relaxed/simple;
	bh=qt+NP+9LAjNeN6RtqtbakO2RAl7YWictjBa3TYzNN7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN+XnmA/5VpDnayUmtD/goKNUqc8mrA39EIlFbgH3Q8hdaiysQY0gmK9/bSg+CL2LBPWpu5fMfuuH7QxYrqVWJJZL2OwlKlSJDZ/7zxdTdXzIlD3UtxehtMy8dfO8RyOq+ljQlTHdswpH2h1ptj5cqHtteZVbLlHnemyYnzKWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KdY8801G; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KdY8801G"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-829f7911eecso314825239f.1
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726567636; x=1727172436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yr6JVG/eF259ezlfNuUrMPXEb3hWYd5PFjTfd8nzszY=;
        b=KdY8801GskUgfrYMO3CRpFY1SsJF6yWhyWnKf5OR13alliHFvn1BxXMM05dzM/zJA1
         2fzXSLKJaihSq3BaVCGvlaNKdLXKarL2iU32Xa26H2GOxGEaK2Zx7niMP4Jh/pbguS7G
         yvIG/vX0p2s6dsaS7NMeNbnK71Rkk/jdXDY1Ckq6JPzKfGlUFG5rbSoK+cCvlNB5zfnz
         /MBBE+2uo75QkLv9OHFIh2mFkoVnJkT6InSnWgx8MxLP+1tdICMIIwSZgbU5PfxFWyya
         8gRgwVxkLjeyM4Vqgw03biDhApJEy+g7540/TGo7/Bt/eJjblW25I3cMCo+TFU4AhRGC
         vUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567636; x=1727172436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr6JVG/eF259ezlfNuUrMPXEb3hWYd5PFjTfd8nzszY=;
        b=ht1YqCuLCXOKayN7/VDpW7Rlzif76W7U0gL+YbexNwMhh5GAATWQ4LsedrPki5CQGX
         ZZUSH2S2dWkJVJBRkhsxFqa6RxOEJntQXJTaYbqWyM6AOknc5FRP+PY8I0hPaFw5lal1
         IU9j2t802bV1hu9MVOdGyy0d3y9RhyG5861oqJaLQtLg0rSOf3TLLV2xSaw9gWY/15uG
         manDP7ap6ILHhx1b2cSsXgjnnfXDl592LDIEKe9HAU0T+pxrB+Z7h793+k6sMKjziETa
         VmhLwHDkb2udTVOXO10HUOptFkL65pA38CA8WTrnOKgOx00FFSLlFvSinVbVm7YOT53T
         v/1w==
X-Gm-Message-State: AOJu0YxuYNQZL7CkRxYWLSk7mJWVslyrBphGPPTBfIu4t7+i5XtOkVac
	gAUfK0Ki7qQ5xk1IytvmtDL8jEESDpbh9UUJZnFHmNS+utSKrh8GALklqXqGi6A=
X-Google-Smtp-Source: AGHT+IHl8Mw3LUMgBglHWpyl9K6YJhgb8nZWWk4H6q1VLfeWaznd80crJxN0TAUoVEIT63iImI3h6Q==
X-Received: by 2002:a05:6602:3420:b0:82c:f30d:fc9b with SMTP id ca18e2360f4ac-82d1f982f5dmr1462218939f.13.1726567636157;
        Tue, 17 Sep 2024 03:07:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d493384c4sm199268539f.43.2024.09.17.03.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 03:07:15 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:06:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 01/10] packfile: move sizep computation
Message-ID: <ZulUw6nPfjE/aC+f@nand.local>
References: <20240823224630.1180772-1-e@80x24.org>
 <20240823224630.1180772-2-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823224630.1180772-2-e@80x24.org>

On Fri, Aug 23, 2024 at 10:46:21PM +0000, Eric Wong wrote:
> From: Jeff King <peff@peff.net>
>
> Moving the sizep computation now makes the next commit to avoid
> redundant object info lookups easier to understand.  There is
> no user-visible change, here.
>
> [ew: commit message]
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  packfile.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 813584646f..4028763947 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1536,24 +1536,24 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  			type = OBJ_BAD;
>  	} else {
>  		type = unpack_object_header(p, &w_curs, &curpos, &size);
> -	}

Omitted from the context here is that the "if" statement which this
"else" belongs to is "if (oi->contentp)", so placing the "if
(oi->sizep)" conditional within the else block is equivalent to the
pre-image as you suggest.

With that additional detail, this patch looks obviously correct to me.

Thanks,
Taylor

Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4021292CA
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419602; cv=none; b=bfJk/+ImXA8nNcyVA55HEcGa30YC46wNT4KiH9M894osJ3S/TEHsESfOwZbXbPtq3WPw7g5SN4kpWyp8HSp1c5dlYQEUsMRSc6lpM3Ay0dniNGs69Y/NGJKgvlOEhKSmWHKL2gC2UCuGNSfD/npnh+c8xNAehbG0ddH1FLHvDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419602; c=relaxed/simple;
	bh=IWNgCq+QGEgE5ef9uAN34qhHB9ZCxtlOgrUVGQ3ZTEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPXKg8Y9BbnYeyCWo2jTEt0q/qR+FmpvlAWraRfXnPvD+Y3dXw9TdYXLzjpdOuBvkzO6rvfRko9LMx18/bDXDLsQwWNmdxdf2EzfXYsXn2VwcAvx797BaBK1H/yn5zv6NK+4+UchVGTdT2i94Id4/+61aEv4kp+QCqsGyIzLSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JIl+WN+f; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JIl+WN+f"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a04bae512aso26859526d6.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714419600; x=1715024400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWNgCq+QGEgE5ef9uAN34qhHB9ZCxtlOgrUVGQ3ZTEo=;
        b=JIl+WN+fU/WHAU5jN4aXJz/VpSnW5flmWk6xJ/tNrEVTeG84eR5myQ+ANeR7hUjbqo
         MtuTIRJpm71L56JwCa57528gBmGL+GhRfkX0xx/TuDnSjs3i8D1uVmZGzFQlWYSYhnLR
         nAvfH01/Z/aMMYgYOWauAA6n6ekcC8pxCygUZuw9H33g2e2bp/YC63ftyhd+ODoD2td7
         wmwsO0emX6fVD86m/rD8OHlyp18xJ7mcM/t5Xs4AzlHAGGizCHpR7EfgoPRpoWKO/FkJ
         SLgJlpXVbAs9Em/ZYY00+ytXuLogxstcXvbTQuNlYTowGD6qhxlhl0MerRcosrD9VB6f
         dukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419600; x=1715024400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWNgCq+QGEgE5ef9uAN34qhHB9ZCxtlOgrUVGQ3ZTEo=;
        b=BHAR7b36v9r4+dayWxYDaLzLh0fMgxNs0IWkkNheCuB+IzsiqAF5UeZ8fDkorcdCfK
         gCCsBxiLAAmvh6rxwEvCiCXcx+aOhMfWTbCsBEBqkTwn8FHSsHmJxyZBJvwu1KAtwvxz
         qvYr2f3iTwgJ3WeVAlNaEqGsO5g59XcpIQ/byw0jvVRbCT1BGODmYYu/uFIn0abMzuSd
         YhUxYOBG029Wk0etS72XkoaWy2iEvTbMPQVOEB92+t7jsOfATi23nxw/sIxd6UaX6nyh
         P6IYIu2ijezO5OzqHJcA7u0tXcK1H70z/DBjJm7q6aT+pQjSIqEdwVhBtdWFVTjivpY/
         38aQ==
X-Gm-Message-State: AOJu0Yz+XeEzL3WsPASEJ04t8nQZKclJYfLmCx7xkJNgrRAQEoobUmWq
	+2zdLBIL2JzhIyEe1Ci34YjOOYGTDKwBfgsFrYZbEjPThLo2IOGQRaAkTVJxU9mTFb8IGIkTc7x
	mroE=
X-Google-Smtp-Source: AGHT+IHgw+JCi1Ji19gmkNWanumVCDKMldrddbY5UiCJV9gUXSap24OrsVPWszx0RsfftictADpD+A==
X-Received: by 2002:ad4:5c45:0:b0:6a0:af44:f21 with SMTP id a5-20020ad45c45000000b006a0af440f21mr606911qva.36.1714419599656;
        Mon, 29 Apr 2024 12:39:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a8-20020a0ce388000000b0069b2064b988sm10727507qvl.131.2024.04.29.12.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:58 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:39:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/24] config: repo_config_get_expiry()
Message-ID: <Zi/3jRyTQ44dCtaX@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <21d8f9dc2b4ddc8ac3f4e8f6b21bfb762fc6ab77.1710972293.git.me@ttaylorr.com>
 <20240410175432.GA2260545@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410175432.GA2260545@coredump.intra.peff.net>

On Wed, Apr 10, 2024 at 01:54:32PM -0400, Jeff King wrote:
> > This function will gain its first caller in a subsequent commit to parse
> > a "threshold" parameter for excluding too-recent commits from
> > pseudo-merge groups.
>
> So presumably you call approxidate() there in that new caller. Looks
> like that would be patch 10. But I don't see a call to the new function
> at all! It just uses git_config_expiry_date(), which does what you need
> (it doesn't use the configset, but it looks like you ended up doing a
> config callback approach anyway).
>
> So can this patch be dropped?

Wow, yes, definitely -- this patch can be absolutely dropped.

I suspect what happened here is that this patch is a relic from before I
introduced pseudo-merge.c::pseudo_merge_config(), which is a standard
callback for `git_config()`.

I *think* the reason for the change is that I wanted to use the
parse_config_key() function to parse different named pseudo-merge groups
separately. The idea of having multiple named pseudo-merge groups was
introduced after I wrote this patch, and I suspect that I never realized
that this patch could be dropped as a result.

Thanks for catching, I can cleanly just drop this patch from the series
and everything works as expected.

Thanks,
Taylor

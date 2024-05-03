Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5857C9F
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761885; cv=none; b=Wd6xdA2xDvdauwWrtzNIwEsrYXKrXNLh1QzXOsLsiboEQP1N8w1moFKw5I0ZuSUXKO3XtxHKn4RaHiKU3UsGNAfZrL4Z1O/U6aTUtUpnwLaDagGV6iqJMXZ1tyycSvnc75TUeKDYQ7nI2eyvzGtC6SsssO3r1jBGkx5I8oC1TKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761885; c=relaxed/simple;
	bh=+jFLWl3fqwbkB/CRSuXdyc/X7sRe3cGaVQL08wU/ZG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMwZJ5LQCXxGUtguZXonyGgK6JZ/iNgsqog3BAGIH5vVE6lAC+GsVYhWt2Gwu+mC7FLHELEY2e+H5N60ItNCr8L0vDENbO921OkEgWLOw0+RhLBfL/kyIkrNf1fqtz3MEr0qdpuun6e1JgSW4vAl+v2gtW3OBsx0e5nJsU1tP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jgzdp+oH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jgzdp+oH"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f03917484so643052385a.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714761883; x=1715366683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QI+Y3Pzjl4dszsZ55xlyZ+cLpVxUU8/JtkbUcvyvqv8=;
        b=jgzdp+oHPobYEAV0vSzJq2dD7Zza+UkOn/CsDuAWj4cTOHk7uCOKC4KyikGCDHpgjc
         yr/7n/2OKjaEJLP+0017Yvm5sG6WQ/sNFh2I1zWfIAVZEpBoLWAkxKOp1F+mV57dRqFs
         qRP7DSQF7D8Z3IHKSDQFqCvVoS1wP2dYhR98srwwaDTGFuefyBMHtiPh0FP683pywVQ5
         2XwsOdh9YFbeI0CDMaZrHIq6sEhuKL/4DRwRRQZllcYLNkRKQoJ4vi7CoZhuEYV86IRp
         T3RlTJyigxDVjfubGVMYoE1hQK0X9LkapPdpO+tAHRStmzTwHfoOpuIDPjzusmLqIhoX
         ufgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761883; x=1715366683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI+Y3Pzjl4dszsZ55xlyZ+cLpVxUU8/JtkbUcvyvqv8=;
        b=uGCVV0q4vn2C64ZcO7MTyz+OJlAP8eIWm4oQztVfrNauZE+JMNGJ/YZ7NB53fGLpTo
         VHySizn5tzF+GnMpR8FCW3dNqUffbcfQBgLfAZNo104xLw5foRzvQGo1Rck7GfO7EzWw
         sgGn09nn0jx7GFSWGuFgob/hwoa/mH9m7XmWBHJCPONokFjKZTIxWbSHRFAkaziZk1yY
         0OWgabLYYb4rcD3ogHZ9gTybKkMbLjfOU5ApDOOqHYOC/9VT2vRW84+zC0Xzf01TUrTV
         Ouj5TkR8Q6bYOwkZqe0wYiS6duUrmBganvG5Syy5TpsDDRplUMsNQ93K4d0K/jwQScjR
         Mpkg==
X-Gm-Message-State: AOJu0YydfoQJmG9gezO0R3uLRUVQd+cYgwNke5vicz2abzlBsimNJfhb
	ioIrSXd9Zs+tgLuBUk4BHmgKHXgW6IR/S67TKOP60YAxy3D0+Qlu3oAOB1vmOELKSW2c7Do+8eD
	E+iM=
X-Google-Smtp-Source: AGHT+IGzUEYZNR00r1Q8k17DKfdPkd/s4vnxEw/5rRxhPR4H+P+mU4D/p3mzBmu+ZDO00IlXbGrwEA==
X-Received: by 2002:ac8:5d0b:0:b0:439:e95e:5bc0 with SMTP id f11-20020ac85d0b000000b00439e95e5bc0mr4042373qtx.40.1714761883148;
        Fri, 03 May 2024 11:44:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bz6-20020a05622a1e8600b00439c1419553sm1842793qtb.44.2024.05.03.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:44:42 -0700 (PDT)
Date: Fri, 3 May 2024 14:44:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: add `exclude_patterns` parameter to
 `for_each_fullref_in()`
Message-ID: <ZjUwmeghHMH254w0@nand.local>
References: <cover.1714717057.git.ps@pks.im>
 <4f34bb2e03479b4987ef30330f096650de354b06.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f34bb2e03479b4987ef30330f096650de354b06.1714717057.git.ps@pks.im>

On Fri, May 03, 2024 at 08:28:04AM +0200, Patrick Steinhardt wrote:
> The `for_each_fullref_in()` function is supposedly the ref-store-less
> equivalent of `refs_for_each_fullref_in()`, but the latter has gained a
> new parameter `exclude_patterns` over time. Bring these two functions
> back in sync again by adding the parameter to the former function, as
> well.

Much appreciated. I think that this one is my doing from b269ac53c07
(refs: plumb `exclude_patterns` argument throughout, 2023-07-10), which
only touched refs_for_each_fullref_in(), not for_each_fullref_in().

Thanks for bringing the two into line with one another.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/rev-parse.c |  4 ++--
>  builtin/show-ref.c  |  4 ++--
>  ref-filter.c        | 10 +++++-----
>  refs.c              |  8 +++++---
>  refs.h              |  3 ++-
>  5 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 624182e507..2b28d43939 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -908,8 +908,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--bisect")) {
> -				for_each_fullref_in("refs/bisect/bad", show_reference, NULL);
> -				for_each_fullref_in("refs/bisect/good", anti_reference, NULL);
> +				for_each_fullref_in("refs/bisect/bad", NULL, show_reference, NULL);
> +				for_each_fullref_in("refs/bisect/good", NULL, anti_reference, NULL);
>  				continue;
>  			}
>  			if (opt_with_value(arg, "--branches", &arg)) {

Here and below, passing NULL for 'exclude_patterns' is expected, since
we have no such patterns in the first place.

Looking good.

Thanks,
Taylor

Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06C35580E
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653016; cv=none; b=PCBhvXKPG/0O+Fdhzoxz2Un8MtRwOyWQiCi7AV0bMygz8HgkAodXMgV2eGao09VATaFaAk9IPn2bHcuSRnkYKhn/BWCEsrsIOuQo1gQpc3Yy6o/glSDlJwtoO2hlnfh2yGyAVZjBRxWmpmOFOVQD/yUj6+0iqmUNut0NKJ0Be08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653016; c=relaxed/simple;
	bh=yKYfiX6rfZ0hb1nQGhYmRkcWnK2EJ3T7Xyr0kqKpMI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIGGxwne+rn5gxc2v94I4bYFw+SSkVwpmrB/YqkbPRufeB5V5T3bFMGB4ce6xFQNMk43kmgHrKUMFxTy1kvARofcYVmJqznoUGHhOhrCuyAOjQ3TAF3ynaNu/9UUdqAefNYv54YlJpxI6PPAzfx72JjC/8klEBXa7jSwaIyqJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EHGqY0x5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EHGqY0x5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-793fdbb8d3aso4816427b3.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 18:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769653012; x=1770257812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPaQ6+aEUe6JZzesuXWcwByoAFtY7AMYqUN60q8djSU=;
        b=EHGqY0x5y01yf7Hl6Al/VpDrpl1O/JgJNmaZA71iJX2SN8tXAQiPqddx0+is7vCtba
         sMD+1wsvcVqVAxIFHjfR17qGRZegSI7fVrCg/qewtAf3EGwMXll3nP6/U2V38sWxL5Vc
         Ad7ZmmRLE/+WhJAC8kjIDXqJkXjpO65n165UMFyfWgJPhLHgCo+yMZIjLiVKDu0tJOfr
         0yZv41aPSfpUZZrqbJJ5YbWnHsZXlLxmMor/8m8R5aE5yV+gvPbSh4xSdaBCvch9YZA8
         sG6+9td71mF3cEaH0caC8RE0TMo+35hlmcrTAWik+EM/OFNG4ImCvqxV5237dfI90fuB
         5XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653012; x=1770257812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPaQ6+aEUe6JZzesuXWcwByoAFtY7AMYqUN60q8djSU=;
        b=m2kZG3j0JcnWzTngKSclh12cdkxFqOVNiQWSxOzoP9ri2hELZVxtuetdTTUu9dht4K
         Wht8koNqlvW03Ojylm8Dan66vSoczIc7rbK4ErtlI5ecOChgNljYNS3HlbR80cbTibhf
         RcSbLvjWkZ+rjuwnUPbYdgahHEYkinoC8nwZB6poPKvuz818e9iMyEuEcc4mjsqefXSn
         xGeBYMPXrwmqi2PbS80fj4QAimm5+GvbkodAatixRMh9mR73qPA7BcndrFoACyE+dE6k
         M0eUfjReAhn7Q91AxzNXK3GqBi/P8pGP/xSukg47lgpHkmLAi6zWzTdyyiajGHNiXKCz
         J8gA==
X-Gm-Message-State: AOJu0YzyHWPBeS1Ldfvl+T+4PZOS4yhwk1VKS3A7UpZLtjDYFdAG2wQn
	Gb/rTYk/kyWhUailX746ZRydG6AFme+YwkOXLbpA1eOeYLBA9n2SlQ2m3zM4jEAwi+k/AdTln4c
	qIySQuCA=
X-Gm-Gg: AZuq6aK9ZY4RafIkrSBJLtt/6Vtwwwoq9CRaip+oKEi0eSy/0uJvPt3wgxZsLcb9FTc
	JYlSYLdm/UPzBhUkIyulbl2QY8N8mO0mIPizFLaZiZsYdd3xov1gD9u4ss024uugaq6bPz8fPh2
	mg0iFruhJHKsoE37T8VCxN8RcH/JOVcasE0VotBntgIPbsxVS43RMEhr/tSilKtqgrs+6HZJWcn
	rjP92D12D+sij606jWq59OzrAST1+lIto/u9pxkyC9PPllCC2mKjzs0MihD61fEM8zXKU2K1pah
	5NnAoWoHzc1bKsBw/Cm/WK27SA8ww6Ya4BjvEI1Mefe957nIDeAGHAEizenS6nL0VbqqF+1e6BQ
	hVz0+OEZZX4mNGt3TMrEHHIruonLpAPCp7Ep80Zqg6w5fWIoziPYPNAsrNcVfd4O1FBElJt/TiN
	gQYHzp7bhva4T0YJqYDzKjiyBhqICSJPQ/2XZaJHs471eqByumG1r33EGIk1NKlmfzRHJyzw9eX
	Kyi/PDC0kgYgY0E/A==
X-Received: by 2002:a05:690c:62c7:b0:794:7866:263a with SMTP id 00721157ae682-7947ab160b5mr60680157b3.10.1769653012405;
        Wed, 28 Jan 2026 18:16:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482762a23sm19334997b3.3.2026.01.28.18.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:16:51 -0800 (PST)
Date: Wed, 28 Jan 2026 21:16:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
Message-ID: <aXrDD1H4lvBR1sF8@nand.local>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-1-deccae3ea725@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-1-deccae3ea725@pks.im>

On Wed, Jan 28, 2026 at 09:49:20AM +0100, Patrick Steinhardt wrote:
> We have two locations that iterate over the preferred bitmap tips as
> configured by the user via "pack.preferBitmapTips". Both of these
> callsites are subtly wrong and can lead to a `BUG()`, which we'll fix in
> a subsequent commit.

OK, so there is some bug here that is shared by both call-sites (one in
the pack-objects case for single-pack bitmaps, and another in the MIDX
code for multi-pack bitmaps). That bug is yet unspecified, but that
makes sense since the point of this patch appears to be unifying the two
implementations together so that both may be fixed at once.

As of yet, it's not totally clear to me what that bug is having just
read the cover letter. I don't know how much detail it's worth getting
into here since you'll end up covering it in much greater detail in the
following patch, though it might be nice to include at least a taste of
what's to come beyond just "[they] are subtly wrong".

> Prepare for this fix by unifying the two callsites into a new
> `for_each_preferred_bitmap_tip()` function.
>
> This removes the last callsite of `bitmap_preferred_tips()` outside of
> "pack-bitmap.c". As such, convert the function to be local to that file
> only.

OK, I think hiding this implementation from outside of the compilation
unit makes sense, however I am not sure that we should keep it as a
separate function.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c | 19 ++-----------------
>  pack-bitmap.c          | 18 +++++++++++++++++-
>  pack-bitmap.h          |  9 ++++++++-
>  repack-midx.c          | 14 +++-----------
>  4 files changed, 30 insertions(+), 30 deletions(-)

> @@ -4710,7 +4694,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
>  		load_delta_islands(the_repository, progress);
>
>  	if (write_bitmap_index)
> -		mark_bitmap_preferred_tips();
> +		for_each_preferred_bitmap_tip(the_repository, mark_bitmap_preferred_tip,
> +					      NULL);

This one looks good to me. The function mark_bitmap_preferred_tips()
here is identical in its implementation to the new one introduced in
pack-bitmap.c, and the callback is reused. Good.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 972203f12b..2f5cb34009 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -3314,7 +3314,7 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
>  	return !!bitmap_git->midx;
>  }
>
> -const struct string_list *bitmap_preferred_tips(struct repository *r)
> +static const struct string_list *bitmap_preferred_tips(struct repository *r)
>  {
>  	const struct string_list *dest;
>
> @@ -3323,6 +3323,22 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
>  	return NULL;
>  }
>
> +void for_each_preferred_bitmap_tip(struct repository *repo,
> +				   each_ref_fn cb, void *cb_data)
> +{
> +	struct string_list_item *item;
> +	const struct string_list *preferred_tips;
> +
> +	preferred_tips = bitmap_preferred_tips(repo);

OK, so this is the sole caller of bitmap_preferred_tips() you were
referring to earlier. That function's implementation is hidden from the
diff context, but it's effectively a thin wrapper around
repo_config_get_string_multi().

I wonder if we should just inline the implementation here into its sole
caller. Is there a reason to keep them separate? I do not feel strongly
here, just thinking aloud...

> +	if (!preferred_tips)
> +		return;
> +
> +	for_each_string_list_item(item, preferred_tips) {
> +		refs_for_each_ref_in(get_main_ref_store(repo),
> +				     item->string, cb, cb_data);
> +	}

The rest of this function looks identical to the one from pack-objects.

> +}
> +
>  int bitmap_is_preferred_refname(struct repository *r, const char *refname)
>  {
>  	const struct string_list *preferred_tips = bitmap_preferred_tips(r);
> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index 1bd7a791e2..d0611d0481 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -5,6 +5,7 @@
>  #include "khash.h"
>  #include "pack.h"
>  #include "pack-objects.h"
> +#include "refs.h"

Oof. I wish that there was a way to forward-declare the each_ref_fn
type, but there is not AFAIK.

The rest looks good to me.

Thanks,
Taylor

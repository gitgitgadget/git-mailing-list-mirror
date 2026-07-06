Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E9435A84
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377222; cv=none; b=acw66GBoWV6VKtguJrKVp+NQNE0SPFgrX9QPK4eo1++4QKoTIZdh04d1nC3Zn0Fz1uy7lP009RMveUlces/BxRO67Mg9gukTH7mLpBQpojduEn87x7dHUcmgQSV4mzaT+u1rVggBWRQ6AG35SW/MRznKlOUP6i86C/faMDrX7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377222; c=relaxed/simple;
	bh=GCdI3dcb/O6DJlOOIsEWjtESzIAvo7Byw3vwIVKK8zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jioE41BW+yo1BwzZ9pJ3QZYgQ0ReQwUpIMQoajYssqk/nAy7EhBp6g9oy/NFa/xK2uh0enbugCZ7VdxBuT7ethIt5Hs9j0ma8TGi32dFiZ0XNOQpGu3L//bsdR0d2BIbrBWehPpaigcoKfXNz8Cbb3sGwoEabjtgO4oPzEGW+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/ovlmxj; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/ovlmxj"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f6b94a49so1993002a34.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783377220; x=1783982020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RlUipA2ey2kCmON9nToJRohdn/zdTW51VduOY6K3u7A=;
        b=c/ovlmxjnC4aI2Gfs66fl7/V4Wy1RBECpqJ06ZPP5HWQLlQmRbbzjAwthAZ0bwoj27
         IK37obnMCtqoKhiz91xYotdtLaCtoS+pPktCIxcFn8HZ577Lvh4wwyV9vppSranFKBuj
         HKpd7KNe1jliKRR9kE+Q1Tgvka8I4+3bA5sawRnrwUjSwh5xw7i9L7NrZTPVpf0KH3MD
         QK3zQXCbU7G18jB9jyiEjSc2m7DS6lbbuKHl7ZSdT8CQORVD7Udzn98+RyRvTmEI1d2T
         TIu5BjvJKihu+OSF4jz/zxCVKIStVa4WvFBz0Yp0RxpUEa2nQMgF7Cfz/gIzXeuU85Lj
         gTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377220; x=1783982020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlUipA2ey2kCmON9nToJRohdn/zdTW51VduOY6K3u7A=;
        b=sGGOwj5HT/pmpFxYrvdRvpR9ElXtDgfYyufRmwW7Y8hFy6BsVlcnjhJJ/9utoU37b/
         GkcAOaNQOtBGyPa1Trl+ZhyL7BRy2lFaYa1HZZmH/XKjmqs1C2KpGq/Q9yIETYvj2Nek
         PokOAfpGnNLyzf90FpgqDoBKeOKjm1sZwpIRpDhZV/LHc1hFOVlaFHMjc7cPgb/nZCDM
         nzy05j0lRG5sxMd24D/ce7j/3xKaWAZskgvWAiA2Q9a938p8AOkSdouxM9CVvIuWL66s
         5jnmjvpnQKM23hXxaFNZPNgXyT0rxTsL5hbMDpeMHkUIlqMpcaXi0nxBKBR0JTwrXKrn
         aHGg==
X-Gm-Message-State: AOJu0Yw+CWEDV0u2sZrFYbsIgUjHfSQ1vRJ56wmAPaw4nqH26guRwJgO
	2uaOpkmuInQkxjVKTe6McZxGDPDwT2q+WhXjUBoSIy5MLiDPIMc98oH/sqJ/gA==
X-Gm-Gg: AfdE7clhQPR7XXPot6TpkaYKaGnz0gaMwBh0YBtHtIOvs0pVB2OHh/eJPCkeqPteWzK
	GO5nn2FU+R6CtVh0BD7m+Qf8ssqseXe8XzFsAJdiDQ0q0ZU+Aovr74an1aewSKq3cI4Po/A8oyE
	k8i1s2sdN+Mh7oj/KujLWL01MMzvEeu1l4pa2bGXz7Osg7vTImPUyqK1guvqOSV6MyoE6PImNiZ
	ZuPG4XmfakWhF/2U6XKFAYNdKsPuQhaZLPGXZrOqeqUnV4F1SqEuNDz2dZkdek1QrGUacIzWOHK
	AlKaFPr0y4oGsYPC7ol7c8IO5XSqNGwM7FqF54BOiwbL2SMe4ujV4m4mDNJaRK5qTcCe67qWEGr
	4m9X131Pp4T81CHFJ5EtYHa534qY5078ldRuXvz9oCGB/d4trsb6UHGfaRpOeL8nUqxfP8R6e7q
	bMuISK2uJNrU3zjSpE
X-Received: by 2002:a05:6830:3490:b0:7e9:e342:3e0 with SMTP id 46e09a7af769-7ebb2339f8fmr1640182a34.18.1783377219844;
        Mon, 06 Jul 2026 15:33:39 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54291227sm12670476a34.3.2026.07.06.15.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:33:39 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:33:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/13] setup: move prefix into repository
Message-ID: <akwq5fqlxk-ndw_8@denethor>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-7-13864eb5a032@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-7-13864eb5a032@pks.im>

On 26/06/30 01:47PM, Patrick Steinhardt wrote:
> The repository prefix is currently stored in the startup info. This
> feels somewhat awkward though, as it is inherently a property of a given
> repository.

Agreed.

> Move the prefix into the repository accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -832,7 +832,8 @@ int cmd_rev_parse(int argc,
>  				prefix = argv[++i];
>  				if (!prefix)
>  					die(_("--prefix requires an argument"));
> -				startup_info->prefix = prefix;
> +				FREE_AND_NULL(the_repository->prefix);
> +				the_repository->prefix = xstrdup(prefix);

git-rev-parse(1) has an option to explicitly set the prefix and we honor
that here.

[snip]
> @@ -2105,10 +2105,10 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  	 */
>  	if (prefix) {
>  		prefix = precompose_string_if_needed(prefix);
> -		startup_info->prefix = prefix;
> +		repo->prefix = xstrdup(prefix);
>  		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
>  	} else {
> -		startup_info->prefix = NULL;
> +		FREE_AND_NULL(repo->prefix);
>  		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
>  	}

We set the startup_info prefix here is `setup_git_directory_gently()`
aleady, so we might as well just set it in the repository. I think this
is a good change.

-Justin

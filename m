Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58271BDCF
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703977; cv=none; b=eAqGNxo1b42O4DRpVLTlXbfjeQEBFE6roCgZcZymEycm4U9nOuVsSSRDheVgoMVXw/jF3oNE/z3tbVg9YAe0GuZewVWavJFbuTnRjt+1aRGrneMxUWo8nVZZHVNIdyC8Ye4G35q0VO0y9b22n74yT6M2gCKuC8aKg+JuQQdDpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703977; c=relaxed/simple;
	bh=tgkexHeYZHE0ZjjytZ8GTtRLTEwRfKK66Mxq6c5zaGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of2zzwAfvrGqt5yKpTOKL6GEUSzl8CYXPC430r06Jv/+6x42uKjeTb/uPrqBCo/QNhhGS5y5QeF2CK5b6xWTcut7KZAFkcdLT6HeqaUIoL0LG55+ksF+5K6E17pYTPIMRj6muuERwo2El9aUrm+A6ZL69tAVTQbCgvrEEu4vUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjY5GUCf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjY5GUCf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso8337998a91.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741703975; x=1742308775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YObjQJhjImBrN0QP6BJdk3CW8gN3WsPvz4+BC3H9SOY=;
        b=fjY5GUCfv+JkO+Xv1VYFgcAhb7A/juyVP64aQD4yNiJCs7UmktZHRAnKjSmW9VBGi9
         vCVI9K6g4gsVyWRfx2fXlkhfcAR9ZyzVotNmzV0d2N8S4BmkSWlu/pwNHrgg6Dx6dqga
         +tkyLUwJxe8MNK93qTwYrkbgZFw3xv7YgUzoqLCE9n00prQGfd5jxrfNA2oXnYH7Q+Im
         wAr6HTVUm6e0rJT1ijk01SDnNo7nUHvEKnLRvnafD4VXkAv71BPPDmfZKAh6eZl78fYL
         RmgZpBEgMUR4Q3pXnbGK1cLQg/Ju/49zhvuI39HBeC5IcgH3sjoBls3F1ufpmM8uKBhQ
         6Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703975; x=1742308775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YObjQJhjImBrN0QP6BJdk3CW8gN3WsPvz4+BC3H9SOY=;
        b=ReRugyBuDUnIbMF/8DG9YgR3WxQlFEX3dpqxs1JJFZfiwr7ZTLqgxOvCHqR5yxgHO8
         bt31eibdL0RFq/3cYFnDwUhI0hyqqKWX6vOhUufcMpvfLU+j3rDxp2ZBFkBmFA+KsuKU
         KYWfi+2YduBxl1QOO91Ei1ioG8kzytR5i8BOokffJjKgG1wuyXSsXeATstL6SFl/PZPE
         9GayL2e4Y/Lm8GyWfOlPlt6KKxMxJbUxxSmH2D5yNNlH5GBx9UaDmQ3a3ZsWmA6beUqe
         RwAmeJp5HFcK8wF7zZ9iCiJglyeBWWXiI8Ha+Xkodh3YIdyGk2PKXQlXcy2yAoEHxiWf
         ViRQ==
X-Gm-Message-State: AOJu0Yyzln/67dFEvPsF7fguyoS6i10AJyYEVpMhF/R4hqC0SMcAN1Z1
	f9Ow/vLp1OxbESppKKpItIyJp39bl4mKmmfIOBGxrJTKuQALH1SS
X-Gm-Gg: ASbGncuhjK9vIN+uwj/gEkgaSSmhJqfG6j85CdVVa+2GepYZM5fM9GGh4MJrx1HSNAh
	Wly7KriGncTqcctVwtzL81gIK6rMo0k/hqK4z91fFFyA/fopWNZwwvzsvIm4h8JMRWk+bMhE2KA
	tTVDlFfzxjO6/ntSR+owSEpLZS05ih5dRhg691SkppBNcAPlelby48wMh/BeT8Jblotsc0jTwOv
	ZLRdGlIEuELI4Ppz445CZ984jiVaeSYkO3WhyQ3Bm47HEaa4YOFQRLZkshRpfF1XKNoGP+75Ydx
	0tmVv7Z3q2AK4PgVc+o3gd9qQy8VAp54SZvvN1Ut
X-Google-Smtp-Source: AGHT+IEGu3MZDbENzVvJWxSNBV7o1ze3LU5Flkj8ZpZN1LcXwAGEpY38W2B/aWoyTkl6JckWahNDaw==
X-Received: by 2002:a17:90b:2883:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2ff7ce89574mr30347021a91.16.1741703974747;
        Tue, 11 Mar 2025 07:39:34 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e7747aesm11854016a91.20.2025.03.11.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:39:34 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:39:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [GSOC PATCH v2 2/2] attr: use
 `repo_settings_get_attributesfile_path()` and update callers
Message-ID: <Z9BLMLXJ7Desl-n6@ArchLinux>
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-3-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310151048.69825-3-ayu.chandekar@gmail.com>

On Mon, Mar 10, 2025 at 08:40:48PM +0530, Ayush Chandekar wrote:
> Update attribute-related functions to retrieve the "core.attributesfile"
> configuration via the new repository-scoped accessor
> `repo_settings_get_attributesfile_path()`. This improves behaviour in
> multi-repository contexts and aligns with the goal of minimizing
> reliance on global state.
> 
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
>  attr.c               | 28 ++++++++++------------------
>  attr.h               |  7 +++----
>  builtin/check-attr.c |  2 +-
>  builtin/var.c        |  2 +-
>  4 files changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 0bd2750528..8f28463e8c 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -879,14 +879,6 @@ const char *git_attr_system_file(void)
>  	return system_wide;
>  }
>  
> -const char *git_attr_global_file(void)
> -{
> -	if (!git_attributes_file)
> -		git_attributes_file = xdg_config_home("attributes");
> -
> -	return git_attributes_file;
> -}
> -
>  int git_attr_system_is_enabled(void)
>  {
>  	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
> @@ -906,7 +898,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
>  	}
>  }
>  
> -static void bootstrap_attr_stack(struct index_state *istate,
> +static void bootstrap_attr_stack(struct repository *repo, struct index_state *istate,

I have scanned the definition of the "struct index_state", there is a
"struct repository *repo" member in this data structure. This makes me
think why do we need to pass the "struct repository *repo" in the first
place. A design question, should we just use `istate->repo` directly?

>  				 const struct object_id *tree_oid,
>  				 struct attr_stack **stack)
>  {
> @@ -927,8 +919,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  	}
>  
>  	/* home directory */
> -	if (git_attr_global_file()) {
> -		e = read_attr_from_file(git_attr_global_file(), flags);
> +	if (repo_settings_get_attributesfile_path(repo)) {
> +		e = read_attr_from_file(repo_settings_get_attributesfile_path(repo), flags);
>  		push_stack(stack, e, NULL, 0);
>  	}
>  
> @@ -946,7 +938,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  	push_stack(stack, e, NULL, 0);
>  }
>  
> -static void prepare_attr_stack(struct index_state *istate,
> +static void prepare_attr_stack(struct repository *repo, struct index_state *istate,
>  			       const struct object_id *tree_oid,
>  			       const char *path, int dirlen,
>  			       struct attr_stack **stack)

If we use "istate->repo", we don't even need to change this function.

> @@ -969,7 +961,7 @@ static void prepare_attr_stack(struct index_state *istate,
>  	 * .gitattributes in deeper directories to shallower ones,
>  	 * and finally use the built-in set as the default.
>  	 */
> -	bootstrap_attr_stack(istate, tree_oid, stack);
> +	bootstrap_attr_stack(repo, istate, tree_oid, stack);
>  
>  	/*
>  	 * Pop the "info" one that is always at the top of the stack.

[snip]

Thanks,
Jialuo

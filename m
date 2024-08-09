Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5D16849A
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236520; cv=none; b=twsLLOC/SFkD4eavUI85B9Km4HVRcGUL7mgOnofQUEcX24Vesl/3DLT5bb0cJxP4Yq5o3fkmCY5r/B0mseTmlGCUuprZgzEF8nFbl45OraVbyea7YrV41tXnJzyfkMYg1bxz0062JWQtK3/Ei2ako/Rpu8pd08+mx5z0e7AmeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236520; c=relaxed/simple;
	bh=YY/hgaqfZ75H737F/jDHX5199Lk+aO60peF+92v0SwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIZlf79Hx52X/tdHMaerr+n6ezyq4KBXsCCaycItPfFGY4VZ+dFbAAEt78kYau8hRe0qm0pMdRfpmRB4XEkHeTvFz8lf3k+xoEiESMMr21cpskWdy5aALFsmuGKE+8vf7NRB+Zv36m/Wac5zsrrszyQ/tD2pLP4qb2X0E87OfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmzVhecO; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmzVhecO"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db23a6085aso1284676b6e.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723236518; x=1723841318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNBEQE0QM56l5ZKsBZfk1WPwbBcAlZTGGZgSDwSeQrY=;
        b=ZmzVhecOiWB/u8SxOy1KK1zf/ZbNtyOaC+8nEKkLNCZq42wOy1vmevN2z142gx150V
         uV6g+6Os5XguwbiWmctBXA3Nnh74b0InsDbE5afwKyFhNsC0BWucNGa2f0CxyXWSPBio
         Ln0hz2fKdsNCZz3OHKR+hLznfH8NxF14BHdfmDYPk6rukq6RW3j1wfvf8Z7HUFDDu8TM
         d0eFczGTBQjEvI+OqaIYNcCZ7jvQ5UoTrHDGBlUQAuwom4Dbbgbg20XNH3dZVxAetKqi
         pVnU8wM1uUxMOJ6CSgxbGZdGjyCFpnONpK9p4/j0NnIOnmqowHfpfK3dhrE7doToU1RI
         0tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723236518; x=1723841318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNBEQE0QM56l5ZKsBZfk1WPwbBcAlZTGGZgSDwSeQrY=;
        b=lXRLkTAlx+9eoDyB3tNKbvvupPeCkRaBrpaqx7uV9u76UFGcwHU4go0+tOGgeh6zRC
         u24590GJQM1YFv9Fo/v/pMH5ONRTcYNkk2cdNDmD5Gdz68cY+nf3Om+XSn9/Zt7bqwsa
         5r9bnzqDps1DagYnpETSAoKz3NRCWOS1c8Qmgik+4Bv8AOj6xNY/jtSAlA2O2F+vTyXh
         vyzxwAiXKzGrdy8c4d2uj/izvCqN2P2Zww3PavVFERqMWUrhB8gMkVgG28UaAsaJ2lDZ
         uOHmOPGxxVvtGd8jVgyhttFM89eyAgeBNu69Tt7+iugbpeLtJoqpxDJAmj1sQzx0uxzY
         yc9Q==
X-Gm-Message-State: AOJu0YwthU5oE4mxnOLvaERKg+V0CdbFDvcb3+7xe0xRmRX6wEihEmFy
	SStNDkfG0Vl4Lq+od6V5BtvhtsCUW4Bb/Ybn4oClSNRroxh878rY
X-Google-Smtp-Source: AGHT+IHMCDF7X9LNsTnNfF6KntVzIv6jweRkza3ZqdOuYIc8lkdNy09TF3/Z/9rviUxJC7OJB564Tw==
X-Received: by 2002:a05:6808:1485:b0:3d2:21a5:d3bb with SMTP id 5614622812f47-3dc417b17e4mr1079523b6e.22.1723236518201;
        Fri, 09 Aug 2024 13:48:38 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd060bcfc8sm60215b6e.58.2024.08.09.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:48:37 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:47:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 18/20] config: don't depend on `the_repository` with
 branch conditions
Message-ID: <unahz22fciepxsgt74jdk63i3yminzjwsdqee3ti5mrii2cz3s@jf6ussbyx637>
References: <cover.1723013714.git.ps@pks.im>
 <d8530a300b4cf0f854f2b0d03c79876c11d81116.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8530a300b4cf0f854f2b0d03c79876c11d81116.1723013714.git.ps@pks.im>

On 24/08/07 08:58AM, Patrick Steinhardt wrote:
> When computing branch "includeIf" conditions we use `the_repository` to
> obtain the main ref store. We really shouldn't depend on this global
> repository though, but should instead use the repository that is being
> passed to us via `struct config_include_data`. Otherwise, when parsing
> configuration of e.g. submodules, we may end up evaluating the condition
> the via the wrong refdb.
> 
> Fix this.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  config.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 831c9eacb0..08437f75e5 100644
> --- a/config.c
> +++ b/config.c
> @@ -300,13 +300,14 @@ static int include_by_gitdir(const struct key_value_info *kvi,
>  	return ret;
>  }
>  
> -static int include_by_branch(const char *cond, size_t cond_len)
> +static int include_by_branch(struct config_include_data *data,
> +			     const char *cond, size_t cond_len)
>  {
>  	int flags;
>  	int ret;
>  	struct strbuf pattern = STRBUF_INIT;
> -	const char *refname = !the_repository->gitdir ?
> -		NULL : refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +	const char *refname = (!data->repo || !data->repo->gitdir) ?
> +		NULL : refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
>  					       "HEAD", 0, NULL, &flags);
>  	const char *shortname;

This works the same so long as `config_include_data` always has its
repository set. I wonder if for `!data->repo` we should instead signal a
BUG? Otherwise we would silently return NULL in such cases. Maybe that
would be the desired behavior though?

>  
> @@ -406,7 +407,7 @@ static int include_condition_is_true(const struct key_value_info *kvi,
>  	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
>  		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
>  	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
> -		return include_by_branch(cond, cond_len);
> +		return include_by_branch(inc, cond, cond_len);
>  	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
>  				   &cond_len))
>  		return include_by_remote_url(inc, cond, cond_len);
> -- 
> 2.46.0.dirty
> 



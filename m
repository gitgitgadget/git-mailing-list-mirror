Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CF1581E3
	for <git@vger.kernel.org>; Fri, 10 May 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333362; cv=none; b=C1ZJF7Qiup3R43tXt6R21z2fEL0DQJStLB1F3ksflnSCcv0uzHZaZy3uZlp9gEAP3PVNSbxO4vs7qTywioSybVDU7idVX5jSOaR94MxQqXQ/87wNlHHfPgo8SfVaFn80t8jtQuOO2zHDrxFpXQjmzvZBy43tVPNVnJiW93Qd9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333362; c=relaxed/simple;
	bh=hnF8vvKgUBAHYUTGsrIeFvPq79xkOjkcgq0XlcVZDko=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=lmsh2qi42HXq06lNRiiBGyjFy+BTCa9YlFT9pc/47AYxs8ZPowtMOT2O5gAjMYS3qbQUegd3TGOYzW9VSWcGivsure/qlpsxvjW/4ayyHNpftIYhNGYcvfjmAABYthqZjEqnAUyx6VOgpHlem93T0hD7Kx36VVLd0H37+/RUPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z23CU+j+; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z23CU+j+"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23d621abfb7so786147fac.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715333360; x=1715938160; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnYaLRRevaFHL/4F8o5+a8/mmZbcVEUWAEPWVMs3zMY=;
        b=Z23CU+j+uxdjMfkYQGhsGW+Yj2irEL8DjChe93euVb2QS4byXmcFcUFI8N/UuiAZyp
         GyVO9FinEOllAifdlnoria1/6aq4+OW5AU0PkH+y7lpmnQMWkKZaWZktrPJiebr5eQC2
         eEZjSSUeTgaGYFVH8D2ZYePWv84ezRFKULuVjb+qd+F4me2GD+QNDlOc3r7SOTc7Dydh
         RxfbJI4J3qwvY4qAfoiE4XwONqclsFRtdiq9L/H4OaLTB8sRyaa9i+UpeQVjONekvQoB
         xShaAty008KWzMCO7JfYWYHTvRQWNj75YR7VTd33iu+5EGliL243kZ6rEQdhRYhKMQ5J
         RBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715333360; x=1715938160;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnYaLRRevaFHL/4F8o5+a8/mmZbcVEUWAEPWVMs3zMY=;
        b=v8r5V0/iFbxQviHzxgTdBbOG/4xa95SHqHy2CiFp+AFeiL97CJVAN/RSwWP5Hd75mE
         Lp7R2+4KQCzYQioiWKl8c4QOqntaK0BmoaF4nHQdyf7r4uC/DCtMV1ULDtwJdhhA40C9
         IUS5zVAQKK860JDUo35xrTZMswa34vKxGFxmkg7gaBOqtCPEmOcwF6taBC/4f6hlA/NW
         WUcCi319nCP27eA4SvD6qkd3Ct86rUGjuxHiP7cWgmtanAwY6wzl7XriVQaL29nOfRLI
         pKNLpB4t/wl3exteiCPmP9yzUcTEsTWTM5qnxR7dy9F45vFmwacHt6D2AA4xCFY7y7EP
         1ZMg==
X-Forwarded-Encrypted: i=1; AJvYcCVEmOBsYC2Z/bnV3fwvxp6AOnDLx/lXzQ6R+RVi7HKKkRv7VvJ1lQX/Qg6w/YNYudWDsDT9L3TtQFt8+wNo7ydpt2B4
X-Gm-Message-State: AOJu0Yy/6ax812Zmh1Rtc/hQuPWtgABfDF9Wuh7iAiAhITAqjcZK11xZ
	IFmnsYT2yl6Gcn7BMAKGe5zJojnHWCQYsFS/syu4ziH023F+GSXlnOdZynWLExOhf8GpnLArKm5
	b3wSOLsujhUpkyYeMdPlsnTg2LkY=
X-Google-Smtp-Source: AGHT+IGGgiiV0VVrKh8CF4hAuX8PfzDLhyx/8Gvs/rqxUF12NxsQbvuQD2DL64cFQ2KrljvLDX2Fh+DAdsqHhGQEwXI=
X-Received: by 2002:a05:6871:1d2:b0:233:73b7:5379 with SMTP id
 586e51a60fabf-24171e10362mr1071806fac.21.1715333360367; Fri, 10 May 2024
 02:29:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 02:29:19 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <b4e4db5735beb106511980adca48dc416c4b0d95.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <b4e4db5735beb106511980adca48dc416c4b0d95.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 02:29:19 -0700
Message-ID: <CAOLa=ZR7=hVXyGr2iSZW2C8mtwR2SHLikuCVKS-qTB7AE+0+hQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] refs/reftable: allow configuring block size
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009dda7c0618162b02"

--0000000000009dda7c0618162b02
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> @@ -230,6 +231,23 @@ static int read_ref_without_reload(struct reftable_stack *stack,
>  	return ret;
>  }
>
> +static int reftable_be_config(const char *var, const char *value,
> +			      const struct config_context *ctx,
> +			      void *_opts)
> +{
> +	struct reftable_write_options *opts = _opts;
> +
> +	if (!strcmp(var, "reftable.blocksize")) {
> +		unsigned long block_size = git_config_ulong(var, value, ctx->kvi);
> +		if (block_size > 16777215)
> +			die("reftable block size cannot exceed 16MB");
> +		opts->block_size = block_size;
> +		return 0;

nit: unecessary return

> +	}
> +
> +	return 0;
> +}
> +
>  static struct ref_store *reftable_be_init(struct repository *repo,
>  					  const char *gitdir,
>  					  unsigned int store_flags)
> @@ -245,12 +263,24 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>  	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
>  	strmap_init(&refs->worktree_stacks);
>  	refs->store_flags = store_flags;
> -	refs->write_options.block_size = 4096;
> +

Nit: do we need this newline?

>  	refs->write_options.hash_id = repo->hash_algo->format_id;
>  	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
>  	refs->write_options.disable_auto_compact =
>  		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
>
> +	git_config(reftable_be_config, &refs->write_options);
> +
> +	/*
> +	 * It is somewhat unfortunate that we have to mirror the default block
> +	 * size of the reftable library here. But given that the write options
> +	 * wouldn't be updated by the library here, and given that we require
> +	 * the proper block size to trim reflog message so that they fit, we
> +	 * must set up a proper value here.
> +	 */
> +	if (!refs->write_options.block_size)
> +		refs->write_options.block_size = 4096;
> +

Wouldn't it be to import and use `reftable/constants.h` here?

[snip]

--0000000000009dda7c0618162b02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 15f12e2da8953f9a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZOTZPMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHBJREFDU24zbjcwbmhDdTU2LzZqbmhwRE9uR3d5dgo3WUs3cWZLSTNv
eWxOWnRhaUhjUHVMZFlFbWFFMHk3THZxT2oyVEg4WkM5TFo3a2VWbS9kb0RHUTZiS25wZ2pICkZD
MVE4cXlISUkyTkdQd3FYQjVjd3gyckVUN3l4bytVQWhYZzlPRzBpRzBoT0RxM28zeGNERi93WFlr
eDZPbjgKYzFibWxxMmRBaWpPNFdTLzI0UXc1YmREb3diZlR5K1A4YUEza1hGb1IyUzZ3dll5dmcr
RTh5WVlwOXBGaTEwdgpZNHBXSFR3aDNxQ1k5ci9Qb01tYlRKMTcrZUFnWWtCdE5HSllkeUZRSmhu
UjVOS2FTaHZjTm5rbmxOREpvdC9RCnl3MTFiOGtwVHljR2FuK2N4Wk5jL3dodEx6SHhsWTdUMFBs
dGFrZ0E2MXZ3cUlCV2pkeVNPaGlSRlFLMERjd2EKNytPVURJamhubndRcFVJaFpuclFWeHFHMVNj
VlFSWkJpR08yaDRGdVNyblp6T3BPbUkzSHJLcmI5MDFwREVPMQozUWZEakRCaFZCSzljT2JKSGx0
aUw0MEtMb2FDNDJOL3hFQUtYVENVK0hwOUl4aTdhSnVZM0hUQjBWVU8zSjRqCmE1U0QrbVVKVGlC
RkREQ2gvZjhJOC9aUTFWVUt0dlJpb0tOMjJadz0KPWJtYUUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009dda7c0618162b02--

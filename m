Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261162;
	b=j/qGlIfoYt47+SW/p+kBysiwh/YU6kP/IYZLaafHMpvj+v0QDraepm8UghS3Rv03QWf3
	 GrwVHItySUEihLybf6C8HKP0Ib5inCZMPPHxew50kDCQZ7/OCmKDb/+aQG+6K3oSyn2xV
	 vkx2V99FAp2xGUDL5deB7Uf53FVsQz9OjoHpI5Oi77Pz7VIzYMVzTJ6QKKRv8mv8IkDL/
	 ejgS6lErPvjdaWmWLX4W9FtYYLMRYFNYLnInDEqVxumWRr08hUs/km7t3vor4VjSmjjhx
	 bOgwpI+CUCyrVASvRFNPMCO7AXJ4dguVxs+mnHesOSBawQhL2bbCK8sOOxLZ9yVJ4yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261162;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4KDsbF+FQpZ5RCe0HfXDucc3tmN7L4+TJKml41GyKQM=;
	b=f898SXxSPKF0OxPn0T18w0vybDaVXh68L0+OUSOfodHZ+05oyAsU51JS5obd0WOneV7j
	 rq4bFTdC71sQ/cSk8B5o60c8akQuiHOEVUCW5jx3M2XPyTlstgR3lK9C2j4T5ulJO8A0V
	 uf0H8cu2X3frSmc/EKnsJFUjy6rQ6G3e1eK1ofTQAdNZ7H2D1RC7QITkaABr3XT+dSWr1
	 FEP/4DBQvCn+1jXQY3bjp9sICYBLKPZJuPnAwlzC25FwBdvBlUoIIOcLiuS60C7cWKCJY
	 0qctgEmLF18Se34F4bMfrRmk8CKD/oHxG9zKEnhEh1OSjHz9a+4vXlhrFAp/EmTOJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TEWcTKxL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JhvGJzkL;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21100606A324
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21100606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TEWcTKxL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JhvGJzkL
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DCD27A00E6
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:06:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 04:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793261161; x=1793347561; bh=4KDsbF+FQp
	Z5RCe0HfXDucc3tmN7L4+TJKml41GyKQM=; b=TEWcTKxL7I2PWY1Xr02coZsuf9
	XDic/BjMV+cqALeV66SYadWYvYeCZ+gYqrezg/3mw4fGBf2AM6vluPcgmXjZFeHQ
	jiklcSwcmL1mSG6z6WNGN+D+2DSfi1w6mpZ90iK5Cfht7vAOqoc/cL1FpaV84z8h
	ec23UALgIl9rTjNGiJE/oHVlMpgBCrFK9uBmR9xGUtgnSW3QxYXttF7SD94JUwVb
	XqX4cXhc+Dlt9Q1aDFFakkiUHvLeV26WQRqYms+0OpP3aafYZ3Or7WsM705RbRfO
	6wVtOldxmlA4mcdxKmAWyZ17hZZl4WgeZ5I/SbcSMIyhVeBfnqDiEfWzwtpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793261161; x=1793347561; bh=4KDsbF+FQpZ5RCe0HfXDucc3tmN7L4+TJKm
	l41GyKQM=; b=JhvGJzkL6Pn+i9rsA4vS2EnP4MhrmXXc7FVZ/YRsEIqdMl3GGM6
	wmeec7XmX6mV/bNmMi1LC7Xs/AqyvsKPidsSG2jZzu2dUSbaXox9Xg17W+EKEl89
	ngg1WzBJ8ixVis7CuyCFpNMH6v3cAFGqRwl90Fg0SIP6YEBvp1PqTnyp9jSxIU7K
	FVQmn5S4d5IFVC0K+gNMoEl83f/8tmKNiZyx92Rk/DP4TlMxdpV32zKtpMKpIL2G
	9SH8XAtFV7StLum26/x72ftbZU2pldYoPE7WxHHFwBRFfC0tY5G2NFMAG9CQy7bz
	ksOoe4THmPj7b9Zwbscv8ATtNmphm6yomQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793261161; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TA1wOqIZ/FiofqcOqg4Rfs+fANw0Kdeo8oCKJwZfSwWSYQQ
	Dd+yRO0ATT3sAzsfwajooEJgHPPndtHe+2d4ebrK+WLRUSDKAjtOexOoQOlW9Y/j
	HQI1kiBmv3lYkGwOj/eL3Xso3NFA9y2s2d2tCDT1/dhMeEh1wlFCsGXs0Swar39f
	bqqZJKGEdagOKnZ9YsePSGihlwz0i/DR/4+cF+/zYDoLO1UrwRBVH3vg9i3BO1Mh
	1YMlCifBlsCeaPSwE7o8yAEtsaN0iFTpmA3nTy3TDdpM3TwZmyfNCMyxUqx0tdcn
	H2BE/EBA51r9aEa19zLzhMCYYPIuFyRVP0vquqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J916sD/fhAJOtl8wD7k+b7Wr422dnvfNMVWTYVSTEJ4=:b2ydZ8mPZRCkYGn2qk9w5BMayNBSSW0ntAon8zeysik=;
X-ME-Sender: <xms:aP7ialOce1cq5MhStntP6zPyje2XlKv1mPpe7kgEpi5K9DYZ05KzBA>
    <xme:aP7iat_AKz0Z-yZ600nRTABQICVY8Y6ImOHiQ8QHWQ6gkpWdwPT1js6pYw24InS9o
    WlE7fOv_5zaz350IdpL483gOKu6Xq5J5DNe0h1ZvZFzNtvhbRZxwlXS>
X-ME-Received: <xmr:aP7iah5vxr7A-TXBhmDKGmVNJoKteQZl3_7Wx8dMLvO0k5ed59YxFA>
X-ME-Proxy-Cause: dmFkZTGqBlAqV5NiPaa2IyQGyoZVMr4ZL4JDnXi0nb5q6x4M6k+yOgLMgSRaUvsjw29tp9
    6ybOws7DWbWyzf+luHdxEbKGlJStYsAD7oLLBZc7ETC4zlMdss5nr/U5hmYznZA5qCPNcd
    f1Zk9M21/LWK5YT0/36Th83QHawa8BLLwkRULWf1K7tkeNPMShhLWuBDOosOk/9mArOgAL
    MqDWHvMXDQ+gZ+QHj2OuQ7G+xzSer8Hn+FWYikzYA9WrsW5fVqjAZUlfoVA5DWnrru6EZg
    BXpAeuJ3F85zRuP3bLgfmvjr0OCs+Sa4n4EBJOY/g7dVLuhEMuEHDhUbUorG2QPwyy2KBp
    klRZ+N1Z7co7IgsarxyRlXCRRVX03/QBFDm8w3/BrWr3j+Uc548mQ8JseghEldqnsC1wly
    1wjvIT7MQf7L6H3+UK7/bp+Jw2XqzCciz/czTN/DmLMz5frl/NZ+WJ0q2x7s57mApB4qD/
    k/1RI96T6dUn4tWLngq+Zy/J10vnPHzQqOMIO4K2s9KpZK86gsVgqYR7F2PnOvCSc/r/PG
    3H62Vm5pw4YUy6tioRjcaKhaGD9Ab2/8QpHcTzxfz1hyXclhhw7dDFa+1Vb0MH25qREsD9
    DD/llMvB4ap2yjL/HgU43BOATRlASwb+6A2tF0Ys06Pcc06N+oale545MyNw
X-ME-Proxy: <xmx:aP7ias2M1B3EPStoKWkPZ8ilUR092eV_Ih2a8Ultyakwt_xiec3vig>
    <xmx:af7iagCfwiaR_okk4syEYC3ynfuVmrH3YfR5xPWbPKUC7B74jdgiqA>
    <xmx:af7iam2eT43nuqDEN-fkwDkBdy7HvxtNnDs4qqTGxarm5SqCEUSIEg>
    <xmx:af7iaisVTSGqjbTe9HbeNqFYNMl10hx9jeNuw_cdovozSECVPfxXWg>
    <xmx:af7ian_kIKQt93aM9XcymISMD2ylGqeMx7QneFgiQbSUgwYjrIAgZodJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 04:06:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0bfe825 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 08:05:59 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:05:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tmp-objdir: merge loose object index when
 migrating tmpdir
Message-ID: <auL-ZBontaECu8vo@pks.im>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029002413.3291184-5-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029002413.3291184-5-jltobler@gmail.com>

On Wed, Oct 28, 2026 at 07:24:13PM -0500, Justin Tobler wrote:
> diff --git a/loose.c b/loose.c
> index f2e111c25e..36da63684f 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -311,3 +311,50 @@ void loose_object_map_clear(struct loose_object_map **map)
>  	free(m);
>  	*map = NULL;
>  }
> +
> +int loose_object_idx_merge(struct repository *repo, const char *src,
> +			   const char *dst)
> +{
> +	struct lock_file lock = LOCK_INIT;
> +	struct loose_object_map *map;
> +	int ret;
> +	int fd;
> +
> +	loose_object_map_init(&map);
> +
> +	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0,
> +						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
> +	if (fd < 0) {
> +		ret = error_errno(_("unable to lock %s"), dst);
> +		goto out;
> +	}

Okay, so this explains why you didn't want to pass a path to
`loose_object_map_write()`: we need the lock to span across multiple
other operations. Makes sense.

> +	if (loose_object_map_read(repo, dst, map, NULL) < 0) {
> +		ret = error(_("unable to read loose object index %s"), dst);
> +		goto out;
> +	}
> +
> +	if (loose_object_map_read(repo, src, map, NULL) < 0) {
> +		ret = error(_("unable to read loose object index %s"), src);
> +		goto out;
> +	}

It makes sense that we read `dst` under the lock so that we don't risk
losing data that a concurrent process writes into it. But to minimize
the critical section, can't we move `src` out of it and read it before
we lock?

> diff --git a/loose.h b/loose.h
> index ed663ac550..35b46f4be5 100644
> --- a/loose.h
> +++ b/loose.h
> @@ -23,5 +23,7 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
>  			      const struct object_id *compat_oid);
>  int repo_read_loose_object_map(struct repository *repo);
>  int repo_write_loose_object_map(struct repository *repo);
> +int loose_object_idx_merge(struct repository *repo, const char *src,
> +			   const char *dst);

Do we maybe want to add a comment to this new function?

Thanks!

Patrick

Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FC194AD7
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645282; cv=none; b=XALcsQwy6YYE2HxpVidDU2pbmE8j8Sg+gsf0AHJvAs19faidHqa8BFgM4gZJn3uFReyajfxQlHjPhwf+acmCg+ZAVUW77489PuJDicjtZ8YO8DaMZHxnMwopzVuv3K6vNaODDSAyCiG1o0wPdHZytjnq7kVlyD1nq2TMbH2KIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645282; c=relaxed/simple;
	bh=ZgQd6tcKiPmanMueVWmuN70uPEV1ONjZTO6PeGCxMRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JArSzwC7thJq3Otsg8rzPz2F8EeIH7pkAtHp9M+0CPKqato2rYwC5bnntWqIonhj0g5p9W881UzKMv3zrDX6cqpJrUAk4oGhG0YzHYccw+sXZZcCg5TUMvkIU2LFTaVd1yPyYpM3Kz/mqFng15aa3hODygepMPfsFcryhzn2MXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrML8XRC; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrML8XRC"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3c711b467b4so663738fac.0
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760645280; x=1761250080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtClEeCkCkBo4gA8eOeTqdK07ADFRcjA7F1/JVeKEdQ=;
        b=CrML8XRCvhWPT64bq6zdviYLB3CMD7SEQBiaxXg0NRzlci7w+LFkMUwbZm9fpxD4AK
         o+rG+Y/G/yeUt+ghF/g0jyJCFClnF42JttDDV46Dnz4Xd59J0RJkeQCOUXVLlMI3pkhU
         PbuOFx1EFAimEuAQ/7DVuWJMhdK33NeUb9LpBwYy9qW5l6Cing+i7c7qkL6D+RW4Yecx
         1O35S0m5MHS/UMUHrvUr5qxsZqIGTfg4YjblNa1dZ5bCTxUjZw5YTOOVCH/xJwfITSZm
         yMFeaeFC3oi9XlA8u5qqp96L5a/SSHYHdDBi9LDDIEoAfObbv05rie6tuQdtBwRWGg2p
         5eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645280; x=1761250080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtClEeCkCkBo4gA8eOeTqdK07ADFRcjA7F1/JVeKEdQ=;
        b=rcAvdqoj+WloOB9EfuHEfhS3k/gE9U3GhTGND4Z4W8IpQEgpTmawv3fINUoVfEiX5X
         1DmPBzULxkoQvIKyNjiVm5ngPLf6wqIu1HMHze17qckNREAU3P1C7JDVEG69hKAgOMNd
         zcGtYk85RYr2dIYDSBrdQHLd9BYtmDM6DP7nSSqCSSPmWTv2fr+tIQbxErhUTlKEldWY
         eTl+UTwm8uxlYUAClCiHmvzinmXWH6DkvzXTZkd2fc4yI4THT7DBIHni7ADLWmDlbUQW
         cKx3E0NAVjxvz42zxSPn6+4ZHt4raBzKqma7hIm4yBbCyuBhioXi4ef7PYkFFlJbVUms
         LqsQ==
X-Gm-Message-State: AOJu0YxxjFVksNNCYWYV2vdcDOh5mS/YMGOd2y493wxMUSO4nY7ucCwR
	q7fpDhuz8JpaO4L7GNdq124qWkNX7CSO9gIV+jtdSegqDE0UmSToTU+r5jKKSg==
X-Gm-Gg: ASbGncstPd0uJxPeJwOt0xIHh+lLb0ZKC5vw9ph+r7FT0qeE01+0AupK2ATg/NNTD8/
	I9ewFpVCf6s+N7PSKKIV41wBSQ0SPVW4v9UuMR4NoWlLiYTGLZUFSgUeOU6AauidrXE1NlzcWv4
	/Hob/nXOxDvhsxudGP6Xbt01RkMhpnxQ4vIM3jG4l8aDXP2Wxu5ty+Hsnm2tVBJnDIw15ktSaYQ
	kgMT+lQvYo4G+n3xFHZ748iourtggyYy1Jk/7UStGoMi1oSOZ09KoyRl7rmQDf5AvkszLqnT+Pc
	WgVi1yPSIJUVyvloHbiYyRoNuXmzBIh84nIR0wYYPzGed4woVkEjg0y7/iIRS7xfD4wTCcfabCr
	JGSLXu6pDhW8s67xck1nmansJUO3BNdUO2YR+9jJy2aZXa8H9gWXPBIX07a5A8nLnVp3DrWsOk9
	E3dqu7
X-Google-Smtp-Source: AGHT+IEgkvX9Sp1qkT1sT0vIj2DsQyPoamJL4BAMW0QW/vu/cwWsDrc5mzU+jq8utKKd6yUGXy+KdQ==
X-Received: by 2002:a05:6871:1c8:b0:3c9:415b:a28a with SMTP id 586e51a60fabf-3c98cf733cbmr545151fac.11.1760645279629;
        Thu, 16 Oct 2025 13:07:59 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-3c98687601dsm447996fac.5.2025.10.16.13.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:07:58 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:07:55 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] builtin/gc: remove global `repack` variable
Message-ID: <uaw3lnxa2yi7mgwmkm2l3lpr7hkfwludzjai53an5nhjh2woif@2kgtzxpnp2ma>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-1-18943d474203@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-1-18943d474203@pks.im>

On 25/10/16 09:26AM, Patrick Steinhardt wrote:
> The global `repack` variable is used to store all command line arguments
> that we eventually want to pass to git-repack(1). It is being appended
> to from multiple different functions, which makes it hard to follow the
> logic. Besides being hard to follow, it also makes it unnecessarily hard
> to reuse this infrastructure in new code.
> 
> Refactor the code so that we store this variable on the stack and pass
> a pointer to it around as needed. This is done so that we can reuse
> `add_repack_all_options()` in a subsequent commit.
> 
> The refactoring itself is straight-forward. One function that deserves
> attention though is `need_to_gc()`: this function determines whether or
> not we need to execute garbage collection for `git gc --auto`, but also
> for `git maintenance run --auto`. But besides figuring out whether we
> have to perform GC, the function also sets up the `repack` arguments.
> 
> For `git gc --auto` it's trivial to adapt, as we already have the
> on-stack variable at our fingertips. But for the maintenance condition
> it's less obvious what to do.
> 
> As it turns out, we can just use another temporary variable there that
> we then immediately discard. If we need to perform GC we execute a child
> git-gc(1) process to repack objects for us, and that process will have
> to recompute the arguments anyway.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -1269,6 +1272,19 @@ static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
>  	return run_command(&child);
>  }
>  
> +static int gc_condition(struct gc_config *cfg)
> +{
> +	/*
> +	 * Note that it's fine to drop the repack arguments here, as we execute
> +	 * git-gc(1) as a separate child process anyway. So it knows to compute
> +	 * these arguments again.
> +	 */

Also we don't expect any arguments to be configured ahead of time so we
are good.

> +	struct strvec repack_args = STRVEC_INIT;
> +	int ret = need_to_gc(cfg, &repack_args);
> +	strvec_clear(&repack_args);
> +	return ret;
> +}
> +
>  static int prune_packed(struct maintenance_run_opts *opts)
>  {
>  	struct child_process child = CHILD_PROCESS_INIT;
> @@ -1596,7 +1612,7 @@ static const struct maintenance_task tasks[] = {
>  		.name = "gc",
>  		.foreground = maintenance_task_gc_foreground,
>  		.background = maintenance_task_gc_background,
> -		.auto_condition = need_to_gc,
> +		.auto_condition = gc_condition,

Now that the `need_to_gc()` function signature has changed, we use a
wrapper function that provides the repack args. In this case, only the
args that get set during `need_to_gc()` are required, and the args are
not needed afterwards, so it is safe to discard.

This patch looks good.

-Justin

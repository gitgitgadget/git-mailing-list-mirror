Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CE80B
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760310; cv=none; b=V4CkEGDSOuxV+kas5pl2oFvMWZABWW8xG7VTlDIG6Dy5Ot+G4hux82Ot931KCXac9jvrC5RhmIG8VamJNSUWkqdf4UDgTdFzatIOG0lc6Z5ySNdMghTmy/wwuwMmmeqZocmZgN1TeN++Ri+dIsatjUYrWL8ne/mVXq2D2NuGgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760310; c=relaxed/simple;
	bh=yOJp3RHM2zSzLSXlqmCMzTU0Grz/EhbGrBsXQRtZsxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofaBd15NEKSUzIVBJLedNFHoZ56ES/B3Z+q4ftdxK/WqaVas/BKgEc6hjREHr4ZykTWB6g7HZU2o9m/O84+4aNSFy0iDRM6eg2bZNpLCL7320GVxe82VWfnlNgcUlFg43jmF5e4JNfe0vtQjsoQeKYq9lOa9iEMlFTKphq1UKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxV+BsB5; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxV+BsB5"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db14cc9066so920335b6e.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760308; x=1724365108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKh8nGSfWnWanwbWfR4R/LAjUN+bdSkZZQEabi6M6h4=;
        b=mxV+BsB5v9Fek/7sw/u5fmD+YaDSlE2tlZeXRkpy9+a7iR+KbV/VMyZ0L01CIvQsyc
         r1Py9mnvZkCA14DVCd4ol+i8QGC8Xf6UE7HB6aBQxQec1F+6I0OQReE37biwxFYS4Gft
         86TDyNCAGDv5Lo6VbrP0Q4ahzNzmjY9OXxUJ+yW7mF4RsdxSIjhTlWZE+43yfF+uu6bd
         JK84+KK5/7GNqsB5Nr+kc2DJKN+ZYfCfjG/Vzssrku+2qpsu/96wwCCw1B08OTCkpDb5
         VApCbG+3RM6uFb8OGI8ovmO+AJ6c4ZOoJL02tmWVuUv+5j81WTGJWQh2NgN72c11hSmr
         Bo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760308; x=1724365108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKh8nGSfWnWanwbWfR4R/LAjUN+bdSkZZQEabi6M6h4=;
        b=Hi91egalpNTwS4hrNiMKjFBhMuEOmpiCD+epKXMttztPRMJxstDWV5ERSo7m/XB/+o
         pq8erlw15htX2tHpamtV010V//Is0j6yfIZ/cplqaT0R6fgVur7eohBM6ukqGimqJjX7
         wRWm0nWyphPyeGI+3flBfEnuV6mfz7unCxJ1zWe7qPqHFka072hHIpo2DJASsuON2JXz
         5k7a+ljxGU/P4J/RQEn66hmRzAOKPb/7SLNqPD5FRifepAe6VFKjrjVLdF/J238AG4Me
         tVQouB7bVvyO3pdenlye82zF2WvXaOMYa9o80G8FaQf8pmIBMF++IjQ8TaMawXUVpzEf
         GqKw==
X-Gm-Message-State: AOJu0YzYJQXHcKobPbiNaHZAAX9vfesc+EVYeRlpSmaNDg9+9OK0qYOW
	0hipheCt1BxS+yJuvWBEETEnd0xTPR1Odt7FgXw9hHg2qIt2w4Rd5uqW3g==
X-Google-Smtp-Source: AGHT+IFjCrtlMNhIBoQ6kVpFhmQSp1EoJu9/vyFyHG1I560V/Yk6nf2VuWLrJ3A55nM8rpG8lEkH8g==
X-Received: by 2002:a05:6808:f03:b0:3da:a032:24bc with SMTP id 5614622812f47-3dd3ae55380mr933032b6e.33.1723760307630;
        Thu, 15 Aug 2024 15:18:27 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d590adsm441111b6e.16.2024.08.15.15.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:18:27 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:17:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 4/5] setup: make object format configurable via config
Message-ID: <pvd6gvizns4wrwi6pq4gpouqfqxgycy7vkbdxhkgdcbcmcrw4n@7nlczody4vek>
References: <cover.1723708417.git.ps@pks.im>
 <e1cdaf0f0edec578d1cb9358fd4c6f6b39aaad3a.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cdaf0f0edec578d1cb9358fd4c6f6b39aaad3a.1723708417.git.ps@pks.im>

On 24/08/15 10:00AM, Patrick Steinhardt wrote:
> The object format for repositories can either be configured explicitly
> by passing the `--object-format=` option to git-init(1) or git-clone(1),
> or globally by setting the `GIT_DEFAULT_HASH` environment variable.
> While the former makes sense, setting random environment variables is
> not really a good user experience in case someone decides to only use
> SHA256 repositories.
> 
> It is only natural to expect for a user that things like this can also
> be configured via their config. As such, introduce a new config
> "init.defaultObjectFormat", similar to "init.defaultBranch", that allows
> the user to configure the default object format when creating new repos.

Adding an option to the Git config to allow the default hash algorithm
and reference format to be configured makes sense. In my opinion it is
much more ergonomic.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/init.txt |  5 ++++
>  setup.c                       | 40 ++++++++++++++++++++++++++++
>  t/t0001-init.sh               | 50 +++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
> index af03acdbcb..d6f8b6e61b 100644
> --- a/Documentation/config/init.txt
> +++ b/Documentation/config/init.txt
> @@ -8,3 +8,8 @@ endif::[]
>  `init.defaultBranch`::
>  	Allows overriding the default branch name e.g. when initializing
>  	a new repository.
> +`init.defaultObjectFormat`::
> +	Allows overriding the default object format for new repositories. See
> +	`--object-format=` in linkgit:git-init[1]. Both the command line option
> +	and the `GIT_DEFAULT_HASH` environment variable take precedence over
> +	this config.
> diff --git a/setup.c b/setup.c
> index 5dfcdc99dd..770ad1393f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2284,11 +2284,49 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
>  	write_file(git_link, "gitdir: %s", git_dir);
>  }
>  
> +struct default_format_config {
> +	int hash;
> +};
> +
> +static int read_default_format_config(const char *key, const char *value,
> +				      const struct config_context *ctx UNUSED,
> +				      void *payload)
> +{
> +	struct default_format_config *cfg = payload;
> +	char *str = NULL;
> +	int ret;
> +
> +	if (!strcmp(key, "init.defaultobjectformat")) {
> +		ret = git_config_string(&str, key, value);
> +		if (ret)
> +			goto out;
> +		cfg->hash = hash_algo_by_name(str);
> +		if (cfg->hash == GIT_HASH_UNKNOWN)
> +			warning(_("unknown hash algorithm '%s'"), str);
> +		goto out;
> +	}
> +
> +	ret = 0;
> +out:
> +	free(str);
> +	return ret;
> +}
> +
>  static void repository_format_configure(struct repository_format *repo_fmt,
>  					int hash, enum ref_storage_format ref_format)
>  {
> +	struct default_format_config cfg = {
> +		.hash = GIT_HASH_UNKNOWN,
> +	};
> +	struct config_options opts = {
> +		.respect_includes = 1,
> +		.ignore_repo = 1,
> +		.ignore_worktree = 1,
> +	};

As these format configurations only make sense to be included in the
global config, the search radius is limited accordingly. 

>  	const char *env;
>  
> +	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
> +
>  	/*
>  	 * If we already have an initialized repo, don't allow the user to
>  	 * specify a different algorithm, as that could cause corruption.
> @@ -2304,6 +2342,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  		if (env_algo == GIT_HASH_UNKNOWN)
>  			die(_("unknown hash algorithm '%s'"), env);
>  		repo_fmt->hash_algo = env_algo;
> +	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
> +		repo_fmt->hash_algo = cfg.hash;

The environment variable takes higher precedence than the Git config.
Makes sense to allow the env to override Git cofiguration.

The way this patch is setup should make it easy to extend for a default
reference format config. Very nice.

-Justin

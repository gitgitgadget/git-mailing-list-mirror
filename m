Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ECA158218
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116978; cv=none; b=tWbcPo7e1owFhi3HisMlmS/vpe1GWahJsv/Y6ZiO1IYeVfGNIoyLaabL/YIuYZFEkpsiBsV6Oja9jy2AgvHcunLNA4ErHCsOYTsOLGynXINA6Yc216W0m0TCdPjAbilYxqKJPXIxO+jUDgH5e7/N5mHPnM1DUNCe9dsOmO1dizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116978; c=relaxed/simple;
	bh=kq+YJFJERPnHSCy3dlLlS/naFwGwHNYjjA/pAk0wJMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv4txrHzDHPsXULHhfMdcuif7fGztBfj2jVgsn68i0idEXiC8VMKvBwmDIcW8JR0cfMU7Z22DQpSJmpoy0itQlqDHZ2faVBJXmD24X/e5Yr9R2vDvKZtEYH2vTzJQJ6wTDhcUjwNOwSkaSB0txCjXHyfP3gUxE/PBvgdFU7wtMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMp0Bcwx; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMp0Bcwx"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fc6fe05460so3418802eaf.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116975; x=1741721775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ0Za8QngszMdYM515shdjEik2SxHETJImZSttxxW4s=;
        b=UMp0Bcwxru4C+rxZHfSZRUHfgfsXw5M3iJWlfsQY2k734VazsBN/+uuFzrrCHxjaJR
         WKFZ/do3AqYTcprzJHb3KH6yaggZ0AzH2lRS4MFCbtE0XFgCtkljDerrxIjl2oYhsasm
         6LkfqGYy5fCvH7BApku8WtNQVOlMVPUCnXBQu0IuzVk53IVpXdssD64DNcYMHfBsjdmA
         sxFcbsp3TLv0UH4dgHsUecGlbHk/iM2iMuQg5dZq7tI5ebH7IdiMqwGDCqkKA6q6tGxb
         eJYuSiUlC5OEn4+393iNy9WivuXF/ienf05QkxI13ebSkfpU3W4Hcf+7hD9Lix4fe9lG
         V0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116975; x=1741721775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ0Za8QngszMdYM515shdjEik2SxHETJImZSttxxW4s=;
        b=YBGn2oGD/YHK7H56VwS4xy0DhYxkSyOU8capqTl/XOtMMLrx7/d3AF+Q1Z96Rsd8rY
         WSpPHaACsZakpFiME2RNfFLA3i+RfxykMIJZ/5DVaaE5XN7JQU/ZhL34NAqI1XY+PXFr
         kIomUBrnv+C19grzNedVSBCficd5kLcdkS+HZlbuRRFxiLmP+xMF7PDZwGeCxuYqq+fC
         A8JNL1Qe3XwPz+W3ft5syJZk/cOdJMMx87i34efEKfVSAZARWULFNeI3JzaC+PfWanTP
         A8jJ4Muvophzwe7XU1gWBlQT9I8q94t15IfsS+HhhjATpVQmbRTucBky7rTH6nWC1iFo
         cy+g==
X-Gm-Message-State: AOJu0YzznZZR11ShOZBB/pjtBerQ2Rj/RCjUcKfGrfrRRcJ64Y8jBIOB
	Wmz/JbZgtVhMjHP4cgGQ/uBWzWEnodYTbejz8dW6NwcIGuv/LM5mQ1NFxg==
X-Gm-Gg: ASbGnct2zrE7h2gd6QAOB3r6Ldr3jDh2ynaIJehNPFIBNu5kQ070t3h0q6twZlWudif
	tbY6sLr+a7T668KXAwabPs5QUv5bQrv7QYwQozktldxdOY+mTVLhZEl0yF7ZE+9eTNOYelBqwAC
	aFAzsRI7KQ6FQ4f7p1HhNLCfZckJRtBeZPR8LQSRTvQA/05IaQSbMYl4h1+VB/Z0qMzoHiJNHFl
	hnn8ZOXHqbr2Yy3ab08TKa7X9fa+ek2VwBlZavuxmtCrdi/R08EfaD9vMDX6xIEPmDmy9YjLFKh
	CeG0FrLp42KKbe+EBbBOtc9cQ/S410/J+cjWIA==
X-Google-Smtp-Source: AGHT+IFhcc8jUsYu1KTsoY2nI8FXZatr4DwgmGcYYWGUPMDq+LoSZW55heD9OX8VOjtXZxJJfQqqEA==
X-Received: by 2002:a05:6820:1b1a:b0:5fc:b7f4:c013 with SMTP id 006d021491bc7-6003358e57dmr166820eaf.5.1741116975004;
        Tue, 04 Mar 2025 11:36:15 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6002deb1a7dsm187026eaf.33.2025.03.04.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:36:14 -0800 (PST)
Date: Tue, 4 Mar 2025 13:32:53 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] environment: move access to
 "core.bigFileThreshold" into repo settings
Message-ID: <rjhdutonrott3a3gpmq6t7qc7qtc4covk7gnp7kqvt3nh2676d@l3wkgwyotv2t>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-4-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-4-c5dd43f2476e@pks.im>

On 25/03/03 09:47AM, Patrick Steinhardt wrote:
> The "core.bigFileThreshold" setting is stored in a global variable and
> populated via `git_default_core_config()`. This may cause issues in
> the case where one is handling multiple different repositories in a
> single process with different values for that config key, as we may or
> may not see the correct value in that case. Furthermore, global state
> blocks our path towards libification.
> 
> Refactor the code so that we instead store the value in `struct
> repo_settings`, where the value is computed as-needed and cached.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/repo-settings.c b/repo-settings.c
> index 67e9cfd2e63..4129f8fb2b4 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -20,6 +20,13 @@ static void repo_cfg_int(struct repository *r, const char *key, int *dest,
>  		*dest = def;
>  }
>  
> +static void repo_cfg_ulong(struct repository *r, const char *key, unsigned long *dest,
> +			   unsigned long def)
> +{
> +	if (repo_config_get_ulong(r, key, dest))
> +		*dest = def;
> +}
> +
>  void prepare_repo_settings(struct repository *r)
>  {
>  	int experimental;
> @@ -151,6 +158,19 @@ void repo_settings_clear(struct repository *r)
>  	r->settings = empty;
>  }
>  
> +unsigned long repo_settings_get_big_file_threshold(struct repository *repo)
> +{
> +	if (!repo->settings.big_file_threshold)
> +		repo_cfg_ulong(repo, "core.bigfilethreshold",
> +			       &repo->settings.big_file_threshold, 512 * 1024 * 1024);
> +	return repo->settings.big_file_threshold;
> +}

Ok, if big_file_threshold is not already set, the config is read
checking for a value. If there is no explictly configured value, we
fallback to the default.

This matches the existing behavior.

> +
> +void repo_settings_set_big_file_threshold(struct repository *repo, unsigned long value)
> +{
> +	repo->settings.big_file_threshold = value;
> +}
> +
>  enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
>  {
>  	const char *value;
> diff --git a/repo-settings.h b/repo-settings.h
> index ddc11967e01..2bf24b25973 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -64,6 +64,7 @@ struct repo_settings {
>  	size_t delta_base_cache_limit;
>  	size_t packed_git_window_size;
>  	size_t packed_git_limit;
> +	unsigned long big_file_threshold;
>  
>  	char *hooks_path;
>  };
> @@ -88,6 +89,10 @@ int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
>  /* Read the value for "core.hooksPath". */
>  const char *repo_settings_get_hooks_path(struct repository *repo);
>  
> +/* Read and set the value for "core.bigFileThreshold". */
> +unsigned long repo_settings_get_big_file_threshold(struct repository *repo);
> +void repo_settings_set_big_file_threshold(struct repository *repo, unsigned long value);
> +
>  /* Read, set or reset the value for "core.sharedRepository". */
>  int repo_settings_get_shared_repository(struct repository *repo);
>  void repo_settings_set_shared_repository(struct repository *repo, int value);
> diff --git a/streaming.c b/streaming.c
> index 38839511afc..018b794d252 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -431,7 +431,8 @@ static int istream_source(struct git_istream *st,
>  		st->open = open_istream_loose;
>  		return 0;
>  	case OI_PACKED:
> -		if (!oi.u.packed.is_delta && big_file_threshold < size) {
> +		if (!oi.u.packed.is_delta &&
> +		    repo_settings_get_big_file_threshold(the_repository) < size) {
>  			st->u.in_pack.pack = oi.u.packed.pack;
>  			st->u.in_pack.pos = oi.u.packed.offset;
>  			st->open = open_istream_pack_non_delta;
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index c71932b0242..5be273611ad 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -6,7 +6,8 @@ test_description='adding and checking out large blobs'
>  . ./test-lib.sh
>  
>  test_expect_success 'core.bigFileThreshold must be non-negative' '
> -	test_must_fail git -c core.bigFileThreshold=-1 rev-parse >out 2>err &&
> +	: >input &&
> +	test_must_fail git -c core.bigFileThreshold=-1 hash-object input >out 2>err &&
>  	grep "bad numeric config value" err &&
>  	test_must_be_empty out
>  '

I assume the test is updated because core.bigFileThreshold is now only
computed as-needed. Is that correct?

It may be worth mentioning in the commit message.

-Justin

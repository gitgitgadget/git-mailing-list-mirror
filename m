Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FD17BEA5
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729842; cv=none; b=iXloGvIB/XL96Rxbc9FQ77hnmH/GMGKTX890R5Q0Y+XD0IOrxMdi/W5HKsGFauraOnbPwPI7WuuGEWG1UnRs6xwPjF7OAeRntKzRFSCyis3RUEeDTpRFSAmRUX9BK791l9LrkSj+DmjM93+p1C9mnQfT+JGgFwgaQRMLv3AA85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729842; c=relaxed/simple;
	bh=8VjjiRjiQ8bKu++NPnAydF80XUDje1FNrXn8Epsp4dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rZK4OiAywTQN8syWmtWsK7qSsIP8I9lAo9CfymMzGeGmhWZBtJ3SKOFXNsF7S/Q6FPATxdyCY8csmNDVVbfBl2HEucUrZ4ao54zjoODTzPZgz4c40SAXog52zSYoTu+CoavuR/SiJTwUJ6PzUY13b2Qe3qWHOWe5LPdtvfvLmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6MhFBLW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6MhFBLW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1d0fca58so557171b6e.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723729839; x=1724334639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3cmqwi66dvxSkaBZXvE75kluAvdIsSTLowwGgIiixk=;
        b=G6MhFBLWCSu7ldz9i6rtXGsSIL4GItHo9nX4yvbEYVEVkvOdL9RagBD6iMhRSo6WwD
         VrT6T8liYHubJV1JotdLWooJYzetOxz+lzBw17sFI7QhbzGB+1CPImhF8mW5p8kgFqMz
         JWlE3Vyt/7b03Wog/Q/kuJWeHRdS+8w6+VloVDPOnEvLBBQ8pqCBCguKQpt44l+327oh
         JoNnCA5DxDtKFhALAFpprMLPIbgBadFvoQvMqcjlymqW/Gx5MLJHI7opu4z+40hcgJUp
         t8Rg54O53/2hZRyU3xSayvLQrn2UOeHZ0YK47uxEnbI701ZNlKBoJNtt8qG0uomv7mni
         22iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729839; x=1724334639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3cmqwi66dvxSkaBZXvE75kluAvdIsSTLowwGgIiixk=;
        b=GjKuPKUj366usnEF/tDCQRD6ce646k3eX9dzHoKRwOlEy2skgI/KHAVZK1l4K4eFqx
         arqkGVonf6PqZwcv4EN9BznuPazQECqmAU6c7jhcTZPuKcTEle4r2IvJdijv02iMI5er
         gqbhKudxenUOAwgyayxRWzgMJ18K0xgzbIY2lr3TOjf1azwpTQSljFziq8kSZXuexBuE
         WET+SBXu9x2wREWMKrcyXJiwkRYGnuJLF2mPR8X5xkCrGC3TLQ9jbpqd+jGfhU39SUTb
         HbpFxZUAaXkWdJ882BZyHTnb0O09qGuQyhciHONk5lG9ugIlcpfN1PqJF3PZHdC2AANr
         rX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5zo1BDPSEpXIGhzvmUw/UZJ0te44tx5tEIAZ2KeklH//KD55+NQkkdcnekfspZbsLR/4BXIOp8N88fGNrKaQCW5yM
X-Gm-Message-State: AOJu0YzDU+U+4T4li0MX6STqQxNymNAEraCiPbJSdRQpcpBSgpvmzYVi
	CUPjqA8EC13ZwKFV5BjPAsW7pRQExpwBmwVq/+phvt310YQSJKaTI6ojROUx
X-Google-Smtp-Source: AGHT+IF/8FluOmlwanq1/cXUQ2yh2YSqgLgUX4eYLKz07Ic7jgkix3FyBpHaq+ds6Kx4lLlTzvhUQQ==
X-Received: by 2002:a05:6808:2289:b0:3dd:3173:fa87 with SMTP id 5614622812f47-3dd3173fea6mr3036787b6e.23.1723729839440;
        Thu, 15 Aug 2024 06:50:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:69ca:a1c4:ca16:9d53? ([2600:1700:60ba:9810:69ca:a1c4:ca16:9d53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b63694a1sm1112923a12.92.2024.08.15.06.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 06:50:39 -0700 (PDT)
Message-ID: <23188674-a465-4af8-ae5a-2404ab6d4c1e@gmail.com>
Date: Thu, 15 Aug 2024 09:50:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] builtin/gc: fix leaking config values
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1723533091.git.ps@pks.im>
 <310e361371efc156c3aaac94439bdbeaa965155f.1723533091.git.ps@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <310e361371efc156c3aaac94439bdbeaa965155f.1723533091.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 3:17 AM, Patrick Steinhardt wrote:
> We're leaking config values in git-gc(1) when those values are tracked
> as strings. Introduce a new `gc_config_release()` function that releases
> this memory to plug those leaks and release old values before populating
> the config fields via `git_config_string()` et al.
> 
> Note that there is one small gotcha here with the "--prune" option. Next
> to passing a string, this option also accepts the "--no-prune" option
> that overrides the default or configured value. We thus need to discern
> between the option not having been passed by the user and the negative
> variant of it. This is done by using a simple sentinel value that lets
> us discern these cases.

I'm glad to see that you are correcting this in the very next patch
where I pointed out my concern about it. Excellent.

> -	const char *gc_log_expire;
> -	const char *prune_expire;
> -	const char *prune_worktrees_expire;
> +	char *gc_log_expire;
> +	char *prune_expire;
> +	char *prune_worktrees_expire;

> -	.gc_log_expire = "1.day.ago", \
> -	.prune_expire = "2.weeks.ago", \
> -	.prune_worktrees_expire = "3.months.ago", \
> +	.gc_log_expire = xstrdup("1.day.ago"), \
> +	.prune_expire = xstrdup("2.weeks.ago"), \
> +	.prune_worktrees_expire = xstrdup("3.months.ago"), \

Using xstrdup() is now possible that these aren't globals. Good.

>   static void gc_config(struct gc_config *cfg)
>   {
>   	const char *value;
> +	char *owned = NULL;
>   
>   	if (!git_config_get_value("gc.packrefs", &value)) {
>   		if (value && !strcmp(value, "notbare"))
> @@ -185,15 +195,34 @@ static void gc_config(struct gc_config *cfg)
>   	git_config_get_bool("gc.autodetach", &cfg->detach_auto);
>   	git_config_get_bool("gc.cruftpacks", &cfg->cruft_packs);
>   	git_config_get_ulong("gc.maxcruftsize", &cfg->max_cruft_size);
> -	git_config_get_expiry("gc.pruneexpire", (char **) &cfg->prune_expire);
> -	git_config_get_expiry("gc.worktreepruneexpire", (char **) &cfg->prune_worktrees_expire);
> -	git_config_get_expiry("gc.logexpiry", (char **) &cfg->gc_log_expire);
> +
> +	if (!git_config_get_expiry("gc.pruneexpire", &owned)) {
> +		free(cfg->prune_expire);
> +		cfg->prune_expire = owned;
> +	}

Ah. Good logic of "if I get a (possibly NULL) result, then free the old
value before setting the new one".

> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 1f1f664871..e641df0116 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -7,6 +7,7 @@ test_description='prune'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true

Fantastic.

Thanks,
-Stolee


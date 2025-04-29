Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24897082D
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956927; cv=none; b=RBX8t3bF78+hTPS5ij62BUdRuaHWl5cO21cXuJWBx5nqTRBuJOwgEnWNINrhjC6SKoIGcd4kzlezfHUnXZHXYWBDmZrRPR/EIm+V7w9XTtiHe1+Q7NJ5YPPGG7F/dqNtRPx6MeRVFM3zFk1GFToEsM/AziBs80NAOufaLOtjl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956927; c=relaxed/simple;
	bh=yr2VJhrPrFRwOhtIjyGC1EZ6Yd/72Csn2LGGXKzlCfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rz7Iz/Rtqdl1dyjTmx5JK0owBKz0xXZtYrSzrmmFj23I+JvOqFl+3x5yIyzsOSKThfdXLdt3p/Au8uh2/tHcYnPEbM+MZIFFz/oIqHdLwkKZSd/fyKSDjDMrhO+t6I5qYDAHS1EQhjC2ajiErK1vHw8EYlILI5/e1t4hlqZOiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf7bt15L; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf7bt15L"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e72bb146baeso5349400276.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745956925; x=1746561725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTakVStmHfRT7bCe+q4CdV7HHFO0vZZ+QxMMG1BmCGo=;
        b=Sf7bt15L4+jrKKBcnrOfYDoUGNdLyIMGkOcyHfFBXzFg1ITmYDEatx1gFkdpoEpyub
         TsC5v0z70GaWopgcXt+VOm/Uw3yCXZJmO8xq8OXDXgrFKlT7wZdFJ8gMmve87UksAYoK
         O08T1DJNbu44f3lJTVbIzYlRrn2oOwa+UVk5xPANDViG7P/aMIH4OQPC6JiOqdvRr1U/
         Fn1FV1LyP9Wu2OYt1bfimrlol4W9cq8bvKQKw/Flcf/mzeXb8DufhY4/lY+al88+U5uo
         yKyTpZZPPQKev0C/VaSeI43NbIInxcElmSdqjPbT1eMKf4LflW1npyJdTMM+jofP9ADG
         YgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745956925; x=1746561725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTakVStmHfRT7bCe+q4CdV7HHFO0vZZ+QxMMG1BmCGo=;
        b=AxYG5t+c2Hh9wNWOR2Ab6EKA51T4SwJsNlxrdGuFARspw/E//Djkcx86Fe7zWLEeC+
         KlwfNuRXqlHfEY3sW+Bxee9fEzYv9nM0x6BK9/qmnsKbcfyuwfSCVwu7gjgjHI+nsfZK
         AHoXRxeV7Fy03xbfNbTEguWj9vdyaR8XcHqkdKIllDzN6sKohY/NN9sjdOOJ1OjEoD/a
         5Ni1L51zNpGPoxsUOVbfhiaZt6KM3GlKWC9ImFPg5gsqehNB0fyd8UtWsWSOiQYnDnNq
         ilSMlsgH2CDyoqo9jYl0pNRqkAbKlKTRoXjGIGoYquxvJYCf4ZrGntlYECLEg3+0guNI
         6CkA==
X-Forwarded-Encrypted: i=1; AJvYcCUz5t7YX8Hc5+S8vpLhM2tZYjdTGYNEq91CAH/MAz2EayV2CGQLplcfwTHEblr59sj9KJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7JGV+4j2OkZkcWOsQ+Rm4kyGdg8JIT/NIg/RrI8NPFXTjLoGk
	/mZgqmHL4ZbKixJBuDFadgYQMd4XYqmnetOhGgiK8b/OIw6prducQ6HrOQ==
X-Gm-Gg: ASbGnct8YezfO9h9TrNzzzNuDKdMipa3dNJV0BqMyJQ1mKWJbqLievPOY2nhvxVblNb
	XuhH5Yhwno8AcXcnauz85RPuj/O6JwbL4aHYuKa30p8FKEkCsUubUFVtchbRnGtuFiesR/E+RQh
	0b33MDE0WJfKVugLM2G3DSVnNHUkeOsGaxSAER4LGurIm7cKMjnGUV1V17l6CWmsYiO9p39ot2O
	RDXo0BZAFWHzH8rq1DsV6hEqcPqrxTmboxVhcG16RJMVMSZInq2o6p3uyCbyL7pODIOgeWuthGi
	p240yYqnCioJLlxpFmize9X3JV4WatuWm5ezPnDZNa1x00PC1ERhflunUzREAvIc0LTKzY2ZS7m
	rmuNcOCQMABiiapdh
X-Google-Smtp-Source: AGHT+IEraDwEv4DSUSd/3syVuRv0DdcZtQB6WjIS34Kp/STw4tc8wfrfOAkCICQHRPH0QAeFzS22XQ==
X-Received: by 2002:a05:6902:490d:b0:e73:1907:a9d9 with SMTP id 3f1490d57ef6-e73ea21124dmr822600276.2.1745956924677;
        Tue, 29 Apr 2025 13:02:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:ad95:6981:343a:ce99? ([2600:1700:60ba:9810:ad95:6981:343a:ce99])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e73fae69200sm29639276.16.2025.04.29.13.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 13:02:04 -0700 (PDT)
Message-ID: <c629f845-180f-4ecb-949f-a99f184f812d@gmail.com>
Date: Tue, 29 Apr 2025 16:02:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] builtin/maintenance: introduce "worktree-prune" task
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
 <20250425-pks-maintenance-missing-tasks-v1-5-972ed6ab2c0d@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-5-972ed6ab2c0d@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/2025 3:29 AM, Patrick Steinhardt wrote:
> While git-gc(1) knows to prune stale worktrees, git-maintenance(1) does
> not yet have a task for this cleanup. Introduce a new "worktree-prune"
> task to plug this gap.

I initially thought that this could merge down into patch 3 (move pruning
of worktrees into a separate function), but...

> +static int worktree_prune_condition(struct gc_config *cfg)
> +{
> +	struct strvec worktrees = STRVEC_INIT;
> +	struct strbuf reason = STRBUF_INIT;
> +	timestamp_t expiry_date;
> +	int should_prune = 0;
> +
> +	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) ||
> +	    get_worktree_names(the_repository, &worktrees) < 0)
> +		goto out;
> +
> +	for (size_t i = 0; i < worktrees.nr; i++) {
> +		char *wtpath;
> +
> +		strbuf_reset(&reason);
> +		if (should_prune_worktree(worktrees.v[i], &reason, &wtpath, expiry_date)) {
> +			should_prune = 1;
> +			goto out;
> +		}
> +		free(wtpath);
> +	}
> +
> +out:
> +	strvec_clear(&worktrees);
> +	strbuf_release(&reason);
> +	return should_prune;
> +}
> +

...this implementation is new and nice to have in a separate patch. I
initially wondered if this condition needed to exist in the maintenance
builtin or could be relied upon by the 'git worktree prune' command that
is called by this implementation.

If we are trying to match the behavior of 'git gc --auto', then it was
running 'git worktree prune --expire...' every time that the generic
--auto condition was satisfied. But when 'git maintenance run --auto' is
executed, each task is checked to see if it should run. If we can avoid a
child process startup, then that is very valuable (especially on Windows
where process creation is expensive).

So I think this is a good approach. Similar thoughts apply to patch 7. No
code change is needed.

> +test_expect_success 'worktree-prune task' '
> +	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" \
> +		git maintenance run --task=worktree-prune &&
> +	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune.txt
> +'
> +
> +test_expect_success 'worktree-prune task --auto only prunes with prunable worktree' '
> +	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
> +		git maintenance run --auto --task=worktree-prune &&
> +	test_subcommand ! git worktree prune --expire 3.months.ago <worktree-prune-auto.txt &&
> +	mkdir .git/worktrees &&
> +	: >.git/worktrees/abc &&
> +	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
> +		git maintenance run --auto --task=worktree-prune &&
> +	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune-auto.txt
> +'
> +
>  test_expect_success '--auto and --schedule incompatible' '
>  	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
>  	test_grep "at most one" err

It may be good to double-check that the gc.worktreePruneExpire config value
is being used here, especially since the prune condition is operating on
that value.

Thanks,
-Stolee

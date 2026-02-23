Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72E30EF80
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862516; cv=none; b=XjbgCxA+AJxhqDH8t/ATfJ1FCvAr2HM5BvAizILY5yeYPO61FW40btDbyFVYZvo2IVeEnqqhqkN90cywWokUzG5cgun7GkiKMu5aTpy/87m6uv1dDmHScoPGZnMZX08KNFBXolE3QO7LTkryEdEWHD9zz96JsvDQSB/ufKVJTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862516; c=relaxed/simple;
	bh=UKmWtS2fLaPXZSsEA0Auy8uDslV9nzLuKsljT39PxUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8w9iLKJHnWopKSerYS4epTwWGMSmJ3h3+7xZGOLL6vDmJLoUpPKPEiIimuFc8PkFF4TXXjlNI6Hrkgok358Qz9VWWtgS9WUAooUA9eFLZPUtY8/1jb/Od2C/IqlKuXLcvXv5VlMwVXOFyE9WiVuL/qyhG8VXEAp8BPA5MUlpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbP8rba2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbP8rba2"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67997ce9e1cso2596442eaf.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771862514; x=1772467314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swwUWuk13egwdh4qES5CXIgwfg13Z4JCZBRRBgL0LcE=;
        b=SbP8rba2I5P7Pq1TlIgHrSAGf9qHNTYViBG9Y9gblhv4uI/K+XFW1NIxAq3UN+8Ncx
         GyOZ5NMxtFWgVr+0bJWtQXChfhYBfky0hvOMebA2Ph+hB9YtmRoSpnCjzb2YZSHNGqPh
         XzUaYVW085UDaniRjARZY5tRYBRpkWnlJUkMS9aVMnP9ik169Wt6olLCzgQEeHmtnk6Y
         3zzl7ifWy/zWOgNBsXPX6glpKkczTWIU+HoDAl85I+9U8+2ZB5BwKQK6YLKVnVf8clJl
         oMluJmvwSZIhCVxykGiMmPc4pirMdE2gknxFXgey8F+Gd9pUGafh9MZ5XUjSaXtiz/4i
         TvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862514; x=1772467314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swwUWuk13egwdh4qES5CXIgwfg13Z4JCZBRRBgL0LcE=;
        b=BsxDv28qQtNqmp2beT2aVeg38dbe00p4RX1Yq1lINBNI7plwOIO650b0n+RedSjfyJ
         l9CGCmeGb/Qs8/EClRLO2bm0Ck/68OgYLWRcbJF7rT842VvzYk4KhmA5gqUBxz+uDHuZ
         oLELzEIh+aM2/5fT+o9lIkFRCOA/fKAwaeyMdfetdf/0w2D8rHEbVhmglU6YJIFyuq+n
         mR9yjoIofXFpu8pNHNYGW/yxAtLd/+mecnLtme80aoOH4UU7wrOqlZ0xrTe+Wz21jbFR
         Q7DxC0/Sf32AjiaeuBgxOFiHaCEXJUWzJjqwehuv3iz61VUenBAi7NC5F/Qb5FbM9FcX
         461A==
X-Gm-Message-State: AOJu0YySN08xC2Ag1l9MKVt+aRVCdWi3f5BjrByxhx9nQ3a5I9SkNKHI
	a3p0sNWsBQlkub9K4FF013N+Cd/9v47l5nuzdur8TMbHqxlCfWh0QpoSUWsHRA==
X-Gm-Gg: AZuq6aLlfaOnoANN+Jugh1gQ7LhmgJZnGjPlrFWBT1Nna76P7/N1Vvf1uX+1eQDIUMs
	W8bVhbJP6vwEI6C8bSR1ofDLvLhAuOUJBmkgA4NBcE96jRhgAj2Bus8LAqOVfzNlcmtDp0/qVBK
	3tbas52MmrSKbhSGFLrxNKe4G4WRTef9o71ZdfZhMUclZRQn+gv28CFWMqB2mR4HilaBGtQ2hiz
	yVK/fRrB8ZlMNQnT9Pk7LNJuAnXiGwf9umsATFxpwcXTJOgCJCC+fSa2sbWRSRsmM0xeWy8N731
	gJvGx6rOwZLaDKu5IczWiOGSh24jQGog8hcmtINrWXl9UPn7RMHw2netxcV0x0pqACyc+WeqcOU
	7TpoRIjmPmBlRQvpD5Od+zrCUJYfjqBc3srdmmaH8JHsNRKEIwdLtEqlt3FagSw/K9KSe9bRpQe
	Lkz9AoAXK0mdr16eEd
X-Received: by 2002:a05:6820:2013:b0:663:40d:4893 with SMTP id 006d021491bc7-679c425a323mr4476042eaf.3.1771862513412;
        Mon, 23 Feb 2026 08:01:53 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56ec56dsm6418842eaf.12.2026.02.23.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:01:52 -0800 (PST)
Date: Mon, 23 Feb 2026 10:01:48 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
Message-ID: <aZx3NCv9hjap_yoP@denethor>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>

On 26/02/20 11:15AM, Patrick Steinhardt wrote:
> Many Git commands spawn git-maintenance(1) to optimize the repository in
> the background. By default, performing the maintenance is for most of
> the part asynchronous: we fork the executable and then continue with the
> rest of our business logic.
> 
> This is working as expected for our users, but this behaviour is
> somewhat problematic for our test suite as this is inherently racy. We
> have many tests that verify the on-disk state of repositories, and those
> tests may easily race with our background maintenance. In a similar
> fashion, we may end up with processes that "leak" out of a current test
> case.
> 
> Until now this tends to not be much of a problem. Our maintenance uses
> git-gc(1) by default, which knows to bail out in case there aren't
> either too many packfiles or too many loose objects. So even if other
> data structures would need to be optimized, we won't do so unless the
> object database also needs optimizations.
> 
> This is about to change though, as a subsequent commit will switch to
> the "geometric" maintenance strategy as a default. The consequence is
> that we will run required optimizations even if the object database is
> well-optimized. And this uncovers races between our test suite and
> background maintenance all over the place.
> 
> Disabling maintenance outright in our test suite is not really an
> option, as it would result in significantly divergence from the "real

s/significantly/significant/

> world" and reduce our test coverage. But we've got an alternative up our
> sleeves: we can ensure that garbage collection runs synchronously by
> overriding the "maintenance.autoDetach" configuration.
> 
> Of course that also diverges from the real world, as we now stop testing
> that background maintenance interacts in a benign way with normal Git
> commands. But on the other hand this ensures that the maintenance itself
> does not for example lead to data loss in a more reproducible way.
> 
> Another concern is that this would make execution of the test suite much
> slower. But a quick benchmark on my machine demonstrates that this does
> not seem to be the case:
> 
>     Benchmark 1: meson test (revision = HEAD~)
>       Time (mean ± σ):     131.182 s ±  1.293 s    [User: 853.737 s, System: 1160.479 s]
>       Range (min … max):   130.001 s … 132.563 s    3 runs
> 
>     Benchmark 2: meson test (revision = HEAD)
>       Time (mean ± σ):     129.554 s ±  0.507 s    [User: 849.040 s, System: 1152.664 s]
>       Range (min … max):   129.000 s … 129.994 s    3 runs
> 
>     Summary
>       meson test (revision = HEAD) ran
>         1.01 ± 0.01 times faster than meson test (revision = HEAD~)
> 
> Funny enough, it even seems as if this speeds up test execution ever so
> slightly, but that may just as well be noise.
> 
> Introduce a new `GIT_TEST_MAINT_AUTO_DETACH` environment variable that
> allows us to override the auto-detach behaviour and set that varibale in

s/varibale/variable/

> our tests.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  run-command.c            | 2 +-
>  t/t5616-partial-clone.sh | 6 +++---
>  t/t7900-maintenance.sh   | 1 +
>  t/test-lib.sh            | 4 ++++
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index e3e02475cc..438a290d30 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1828,7 +1828,7 @@ int prepare_auto_maintenance(int quiet, struct child_process *maint)
>  	 */
>  	if (repo_config_get_bool(the_repository, "maintenance.autodetach", &auto_detach) &&
>  	    repo_config_get_bool(the_repository, "gc.autodetach", &auto_detach))
> -		auto_detach = 1;
> +		auto_detach = git_env_bool("GIT_TEST_MAINT_AUTO_DETACH", true);

So now if "maintenance.autodetach" and "gc.autodetach" are both not set,
we then check for the "GIT_TEST_MAINT_AUTO_DETACH" env before defaulting
to true. Looks good.

>  
>  	maint->git_cmd = 1;
>  	maint->close_object_store = 1;
[snip]
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 7cc0ce57f8..d11d6f8f15 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -6,6 +6,7 @@ test_description='git maintenance builtin'
>  
>  GIT_TEST_COMMIT_GRAPH=0
>  GIT_TEST_MULTI_PACK_INDEX=0
> +sane_unset GIT_TEST_MAINT_AUTO_DETACH

I assume here we are unsetting the env for testing purposes. It might be
nice to leave some sort of breadcrumb comment here to explain to future
readers.

>  test_lazy_prereq XMLLINT '
>  	xmllint --version
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0fb76f7d11..aa805a01ce 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1947,6 +1947,10 @@ test_lazy_prereq COMPAT_HASH '
>  GIT_TEST_MAINT_SCHEDULER="none:exit 1"
>  export GIT_TEST_MAINT_SCHEDULER
>  
> +# Ensure that tests cannot race with background maintenance by default.
> +GIT_TEST_MAINT_AUTO_DETACH="false"
> +export GIT_TEST_MAINT_AUTO_DETACH

Looks good.

-Justin

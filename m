Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CB19C542
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863320; cv=none; b=HdTEIRr6u99u0Lnhimedif2HANoWIKs+dwtermMz0EdXA8w+xhXgYvhzNu5JDZhCTLVpIgE5rMBjj09o7Udp1+FghI+lCFtL9NMXVyriMOKbb/UJe2zwT+MecbzGsXG0kdeO2XHlZj7hrFGPvrb9po3ArgbRHxe2FodBoKCSDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863320; c=relaxed/simple;
	bh=IZG4nxMFOYiHiZJClm+yP1hADZIsfYtAgn1kZdCdkr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f51FexwlttQPUQdrugJePBZA3d3ADl0a2L0hF4wIl7M577dusCLw17Bt5Dx0MMNAUA0gym71jgEHJC+Orc1C0aW9xC0ep7DK4+ixfnGoJanYF5QOGUiWHoSS4mZOEgkwenKrZnhWCFdtFN3hcgiiFKrvJnk04D8ogXAZ+1LuiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWZ7ophp; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWZ7ophp"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-413d8b8e98aso1771854fac.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771863318; x=1772468118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=muLa09o/q+rcmpnHRVLp4Au6MXo+y/I9GBujfb8PVtI=;
        b=eWZ7ophpDXOY4KvFMznqhlwgPMEdmdME9txHyg+79jpn4iFEiaYAOGgIuLWy6opxIo
         W8OeVcQ0pqBs6TR/n3pXE8iQEZyWfnActqg26kpQqitbu4ylw2ovQfq0vfC8OrVqM03t
         iUFPKeiA0FRPe2YfNcpvKqiyKAX4SOeMQlQMGToJq2QMRzX4yr7PDgm+9vLaQNAYUQjY
         KGRugXTsmPVo2JYzzeND5WOr53MHcenMAwzck/1TAzbtmTPQGAYT9XAeaVbtVsO/9y/N
         Sv18N3f5A4/ePbmQ/+0g7ZEj76to+Gma9GsXZVQHx7vVwwleGVakAzF/p+IwBjeaaIaP
         Plug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771863318; x=1772468118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muLa09o/q+rcmpnHRVLp4Au6MXo+y/I9GBujfb8PVtI=;
        b=d0npchAxcmdUqCDeA3OqQL4N4yFzaEizhFvdnIGWFoLh0HQhgcdLTOGPxURzlhHiNC
         t6vBu3ngReWSs0kO8mCaA0GfJ1GJQyNpyuEjd3bnesBbwW8mikzKBvZVpLJP1Zk6pMMA
         CsD7doqQqPB3xkxpXM5qTXdTMpxDVNMzOHSNHFARPYlpBCdKx69syiA3jW4RvpYYLtla
         jiYJ5lCBeuRQ6QHfAD0uTwMfoLKONZkYh7dBxq6ZKqBWPZQfVMeAUQ1YMupUlBBoQjgy
         YR6B1drwhE1LeEt0bxb+fD+nrrzN5H5gw7MkEeUn1S4JU2tccjKyJIF/SqLEx4HwR+NI
         vWlA==
X-Gm-Message-State: AOJu0Yw3OyTPfNRtTYY5Qfck8gJFSaPth+yVt00wPNKDXSzO5VYM2xao
	VFs9hguHdmn+AFsabb6YEQo8ZVTyReV7uA1tdmGJt1IUaD4bF2L6whT2
X-Gm-Gg: AZuq6aJvN9hzx6yDbl8VyUgYkC7CYA8VmYr3F3ffBCEV/zwtLGDP1xZTzRDs1Wh4hzt
	sMXj4VOQEckp6zb+0IiUlaSGyaS7MO8idt+RHHke2J0FGnJFfkpk1wmIw0hJLon9TZGIHcIZUec
	nRFk2dsWIOPk1BEai+cYJsWQvjvSeAUl74jRYAHGfDV3N2tAfU1pQJK7qbM/hqyQsZ04lBXrttW
	M4nHDC8PIEzzOBoSAqifzU/v7/X9U/hvSDo87GufRDs0rE54axmi/Mg5mgM6Y2naxGS1qboP1vp
	qGZNqgQMc4yAH8PGv2HFi4Y+1+fi3OwYWp3B54qjeATXn+ZPPohaIP95jftsXiEco1WvPvqbaBQ
	0Xf/FNBFVrGoHLsXxSGbGB2dTOvCHA5VktpMUcFASbsndgAJDiRQvir3FB3t0MgpffNyWq/E9bE
	Qq+Vng7pGwC5Pw0iXA
X-Received: by 2002:a05:6808:178b:b0:45f:1252:b717 with SMTP id 5614622812f47-464461fde70mr4732304b6e.28.1771863317870;
        Mon, 23 Feb 2026 08:15:17 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a010a61sm5316162b6e.5.2026.02.23.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:15:17 -0800 (PST)
Date: Mon, 23 Feb 2026 10:15:17 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] t34xx: don't expire reflogs where it matters
Message-ID: <aZx72rF8OOXryMc5@denethor>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-3-faeb321ad13b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-3-faeb321ad13b@pks.im>

On 26/02/20 11:15AM, Patrick Steinhardt wrote:
> We have a couple of tests in the t34xx range that rely on reflogs. This
> never really used to be a problem, but in a subsequent commit we will
> change the default maintenance strategy from "gc" to "geometric", and
> this will cause us to drop all reflogs in these tests.
> 
> This may seem surprising and like a bug at first, but it's actually not.
> The main difference between these two strategies is that the "gc"
> strategy will skip all maintenance in case the object database is in a
> well-optimized state. The "geometric" strategy has separate subtasks
> though, and the conditions for each of these tasks is evaluated on a
> case by case basis. This means that even if the object database is in
> good shape, we may still decide to expire reflogs.
> 
> So why is that a problem? The issue is that Git's test suite hardcodes
> the committer and author dates to a date in 2005. Interestingly though,
> these hardcoded dates not only impact the commits, but also the reflog
> entries. The consequence is that all newly written reflog entries are
> immediately considered stale as our reflog expiration threshold is in
> the range of weeks, only. It follows that executing `git reflog expire`
> will thus immediately purge all reflog entries.
> 
> This hasn't been a problem in our test suite by pure chance, as the
> repository shapes simply didn't cause us to perform actual garbage
> collection. But with the upcoming "geometric" strategy we _will_ start
> to execute `git reflog expire`, thus surfacing this issue.

Interesting find.

> Prepare for this by explicitly disabling reflog expiration in tests
> impacted by this upcoming change.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t3404-rebase-interactive.sh  | 2 ++
>  t/t3406-rebase-message.sh      | 3 +++
>  t/t3431-rebase-fork-point.sh   | 2 ++
>  t/t3432-rebase-fast-forward.sh | 2 ++
>  4 files changed, 9 insertions(+)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index e778dd8ae4..5e4623f7f1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -31,6 +31,8 @@ Initial setup:
>  . "$TEST_DIRECTORY"/lib-rebase.sh
>  
>  test_expect_success 'setup' '
> +	git config set gc.reflogExpire never &&
> +	git config set gc.reflogExpireUnreachable never &&

As it may not be immediately obvious, it could be helpful for future
readers to explain in a comment that reflog dates are hardcoded to a
date that would be immediately expired and thus the need for this
configuration.

This patch looks good to me.

-Justin

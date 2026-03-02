Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250136D4EF
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471518; cv=none; b=qkj3qVTWf3ur61oUBdZB4a8Bb2iIkEQy7sTrUviC/QcmgcC9g05hiiuDkCApbRux3T7GDtn1ozR2hQi73+yCDeDIPyPYzayG+HvSo7zgIO2Gud2ZvK1+8AhbvADZIEKt4aelQ45vR6tUWWd9V1gFOcm48YvIoO41x9Saiobz1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471518; c=relaxed/simple;
	bh=QVYsij6CAkXOcwxvdupr8wdQrnTAQzaEEjWkJ0Ujv7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjtfNtsCHvxEE1WVEIL4LN+E6gHHBCVAcApJzKY9ghahEfYYGyJI1FGpOs2g7McZDZ2dUc1LH/LPuRzlepCJc+BL76R1Q1sL/dWfDCog/7fTHfcLmz4l46JTvtnKT6ZegHa8P/QxMns8g8fIRU/ukYQDz7kF4z5zZy66tieMqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZxZMxag; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZxZMxag"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45f09874c4cso3496131b6e.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 09:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772471515; x=1773076315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKlFZ2cMYlG4ss0RggItF6J+zYC6DDBulq4Q1Jlk8lI=;
        b=aZxZMxagJNJklMbyqa9OrAtld3RI06+HQZ1+i6Ml1ekVeRfdC9CinDb+/KHJxNJ9oD
         TIve6t2LohfUZIafWZWufaBtpqScRD7/10jqWr7toT7zvROUPHUFQd2phQY5CXWEXoQ1
         ce1bBnJn7SA1OzBfwuiP0aWzfubhsuIm8waijcYdNIrb7jJuCjWkrgUw3SO6s9UJMUOo
         IygXhF1wjOHA3okQ4xzMu3x/LkaszrGv+b5NYz32RfwXPG1RTllB/ZJDYqcAn+YHPuhF
         FXjREnMdgUFmpFCK2n91giWLKd+teyW7RNio6tHa4fF09rJEhK+8Uir2fgBjfDC+vDsH
         ZK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471515; x=1773076315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKlFZ2cMYlG4ss0RggItF6J+zYC6DDBulq4Q1Jlk8lI=;
        b=ofkvlgUJiVqTSrNfWHpHOj3VN11r3hxNaC1U96QKjm3860Y3EOqy5PcIsbW7DpWWdN
         6jWcnspr9ApSDpFhFanMzXgdAwiUU/Gybc0TP2hoY8YzNizb3pDAWvyUkS0mXkpqF0Go
         e+dk0kH0TG4hApPxDghHZHl+Q2qIVwOKrTJBK/HWpIV8ZlBH8Fod8H4zXXfgmQ+kcWvO
         RDirkeSpOKVN6h+fx6V8BbZ/uM1QvnL0D1VpzB5Cc0Iwyj0qVWotj7xlNfcZPr0HGM9h
         5vA8a2ttAEjqLPrYErV3vA9St3JCxwhVKWKS+/FELLCJSsWpTnKhfFGz4WVgR/UcsD/z
         BXJA==
X-Gm-Message-State: AOJu0YzAj6DmpVp3oWG1a/BJp1oB+P0dKognLFyufaB4S8YNedHKh2Zi
	tx/tVqWLAVuGClE5fzQUpt866vW46snm7TkT/CMQytZGZwESWVpb346798MBOg==
X-Gm-Gg: ATEYQzxkBysE3INf8YGxgvwDvaI/wpu1o8QIvPiOtFtrM9L/dXvf0yM3G6RdY8UrHF1
	mBAdV64SV7wDjsQ+e6n1ZkMHMUgorSWR5j5I5wXabuNME/+7cRmaaFV+EhU2/MW/aQnY75PhiD3
	+PVupnDrv18sSUwrP100QNH+q186Yy0mt+B1VeldyRtETFTcmTFHRiKj1vRfTis+g8AsGHlpZ1s
	fFSsD5GTGbU6Ws4MAq8iMF/KcRfdXfG154q45FPLcD0PfvNcFhXSktRC+qEN3VfZuLeU2Ag3Z5l
	2GyKx7Nhu2fCBEfNWyN1GdI7ExFPMlZYZtYrOn4c4I1JcXlRoc57gFEwg6BtcjX3oPET5Di4zOT
	D89Zc39CfYzN/wqUkx/BSEF3x9x1W+bUO75lbV1Uh0E9nRYZaiXxd6ks+iLQyIGk3PF9Xci/GJ/
	aEbBysik5WKc9ZSTci
X-Received: by 2002:a05:6820:160d:b0:679:e7ba:79de with SMTP id 006d021491bc7-679faf648c2mr7279181eaf.67.1772471515492;
        Mon, 02 Mar 2026 09:11:55 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d9e8d6sm9055550eaf.13.2026.03.02.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:11:55 -0800 (PST)
Date: Mon, 2 Mar 2026 11:11:52 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: unset GITLAB_FEATURES envvar to not bust xargs(1)
 limits
Message-ID: <aaXArnhYbtX9gsUU@denethor>
References: <20260302-pks-msvc-meson-xargs-v1-1-8e42abd879ce@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-pks-msvc-meson-xargs-v1-1-8e42abd879ce@pks.im>

On 26/03/02 12:55PM, Patrick Steinhardt wrote:
> We have started to see the following assert happen in our GitLab CI
> pipelines for jobs that use Windows with Meson:
> 
>   assertion "bc_ctl.arg_max >= LINE_MAX" failed: file "xargs.c", line 512, function: main
> 
> The assert in question verifies that we have enough room available to
> pass at least `LINE_MAX` many bytes via the command line. The xargs(1)
> binary in those jobs comes from Git for Windows, which in turn sources
> the binaries from MSYS2, and has the following limits in place:
> 
>   $ & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'xargs --show-limits </dev/null'
>   Your environment variables take up 17373 bytes
>   POSIX upper limit on argument length (this system): 12579
>   POSIX smallest allowable upper limit on argument length (all systems): 4096
>   Maximum length of command we could actually use: 18446744073709546822
>   Size of command buffer we are actually using: 12579
>   Maximum parallelism (--max-procs must be no greater): 2147483647
> 
> What's interesting to see is the limit of 16 exabits for the maximum
> command line length. This value might seem a bit high, and it is indeed
> the result of an underflow: our environment is larger than the POSIX
> upper limit on argument length, and the value is computed by subtracting
> the former from the latter. So what we get is the result of `2^64 -
> (17373 - 12579)`.

Ok so the problem here is that the environment variables are taking up
17373 bytes which exceeds the upper limit here of 12579.

> This makes it clear that the problem here is the size of our environment
> variables. A listing sorted by length yields the following result:
> 
>   $ Get-ChildItem "Env:" |
>       Sort-Object { $_.Value.Length } -Descending |
>       Select-Object Name, @{Name="Length"; Expression={$_.Value.Length}}
>   Name                                          Length
>   ----                                          ------
>   GITLAB_FEATURES                                 6386
>   Path                                             706
>   PSModulePath                                     229
> 
> The GITLAB_FEATURES environment variable makes up for roughly a third of
> the complete environment. This variable is a comma-separated list of
> features available for the GitLab instance, and seemingly it has been
> growing over time as GitLab added more and more features.
> 
> Fix the issue by unsetting the environment variable in "ci/lib.sh". This
> ensures that the environment variables are now smaller than the upper
> limit on argument length again, and that in turn fixes the assert in
> xargs(1).

So if we unset GITLAB_FEATURES, that puts us at 10987 bytes (17373 -
6386) which would be under the upper limit. Unsetting this environment
variable seems like a reasonable means to mitigate this problem. Naive
question: is the upper limit something we could increase for the
environment? 

[snip]
>  ci/lib.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 3ecbf147db..42a2b6a318 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -231,6 +231,10 @@ then
>  	distro=$(echo "$CI_JOB_IMAGE" | tr : -)
>  elif test true = "$GITLAB_CI"
>  then
> +	# This environment is multiple kB in size and may cause us to exceed
> +	# xargs(1) limits on Windows.
> +	unset GITLAB_FEATURES

Now when running in GitLab CI we unset the large envvar. Looks good.

-Justin

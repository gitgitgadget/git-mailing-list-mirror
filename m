Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61E38B7AA
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493604; cv=none; b=gBx0yFjBdI5JTtpG1ohs4Pg6D6u50JZJ1M39YDudtYoDsfD4VMCWfmgWmog2B0QPivVRZE1dVsXhkVZ42zVm44E12qsKkvJXxrgv9L0e3I4Y8TZk+hGGknTRa+jaWCZWEQHFnxYGuW++9tcWOLqhCEJomP50BhF1T2JnljPrho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493604; c=relaxed/simple;
	bh=b9Gi0OEmdKp2dcLhfiSh/i0JirAmygsUlMoGgq3QDqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMFFUqH5/bL1bS8GRAZ584PRoHoGA+Q3d8cxfu+qoC8CCDZkKSuxXqDk+PvU+S5oA6/D0QlHmxSFq8TjyJjhbQIEW0oBqmF1SccNeChbe6zuWnuyCJ546Wjn1w6UISWbjc0rdGiXrnv4mXeKG8bJWv7t4mLeQywAKZCgADfpaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4eKjOFO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4eKjOFO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so6306035e9.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775493600; x=1776098400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ES/ys7lGyxb3ZR15hkyfPNMeQHq9fjsAxWAqDRLW4=;
        b=f4eKjOFOmjp92AI1T0XJGo/R14ZYzu/gK3UpeUxWmG72h7J3BVGqdxXkJu34QpClEv
         Z5EYXtEhkbkUgHnoqbgZHTFGj/SBWMHicWkvml2wuXSffHkANsCrGoRnt1HL+ArtwOfK
         vzeGro6yNp62txeBxPiscO32i7gF0Q4wdoQT5Raxc+UhKUoe7CrSQUQv511HPbfabrKR
         T4FK+m0+8zt3ctF6Rk9D7zD5mWvVzMcBc4P2FHhXJ6FEMzu0tk6b+3RFpgWgJu4Z3lBb
         jaL0c/4QkQeeHg8wFYu4opl93kbWuXTan/9bvYSUhvAPZOBsN3tBvpRpLdc7XKFLwQu2
         Ki3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775493600; x=1776098400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2ES/ys7lGyxb3ZR15hkyfPNMeQHq9fjsAxWAqDRLW4=;
        b=TizPvfcfK5mfq6EfX5hIrsy3VlXUeR6yQ4ywnMMCQ+rDUUC2J7ENnzw+7lzuCsj23L
         w8hgrxGfrdpyYciTK2ZVsM/PZtiD6ARuO8Xa0s9EH68FNLHQSef+pxftbY2myzdP5bYK
         Ab5hW3eZgBAQi+3RAWpSKAB4zRNNYWXGbcm9+fgQjbRrOYUmAJpnHuRJ6OOS+v5RJRHr
         /hqLGN4s7Fxtz28rOaCWkIEXWLQOKDgEQbC8jK3N02XtUby2akreWXTvADM3w7VTPmuu
         jOd0utU72onDoq7LLDbr99uR8fMoJ+hrQoGhjc86bYXa03n03B6TS9xmsJHib+/a5mua
         Rx7Q==
X-Gm-Message-State: AOJu0Yy3LMABFdmQ0TRT4f1j79VM0jhDIg5FP3wbpg33ZgPnzWeXUQDF
	1VqJKAOd9ovOrfRGuHpQGisPjSk30VQFVlJ2OJffRotkGYC4cNi87Jyj
X-Gm-Gg: AeBDiesQwPEOX4e0J7pOKrBT0uDKedfdsPjcqsPIjQK8NDMnpAMxEY/+h38eE0oBJ/1
	WrV6zERQbHkew2GXSWBigYi2gpN7opZJcQeFatPpUl/h7lxj87VXXmCZUQl9ObN9XbnlMYJqaBu
	X6ORhNS8VxOBJ8emxSTgCKIwKHo62TOuKY6xeVEt2dPGJkjRZymhDtffRFhmvqauxKqSSDU/M6j
	+oFZStoeG9dkNPC/qoM+zPAiNmnOO5+tYLaTN6J3aXZlGH0rctRlXqjY3pmuH6j2DoJXMXbYRsO
	wiRvdiavp/XHfNWCPdvDhy4mjRSfXK2VvcRQ9l+UGZyqIcfFTRj/l/xZhO24pr6GY4TKHAgjzVR
	eBBUowgMruqONkUyKCZxk/PUJ4e+YYH40cbYlsFbRFyLL7k1fBD4AJViphYt80BriILOBSUBZBz
	Dq4wWNpgKFN2zeU9pdafnZ6KkMteVfY9whLNFLR+rrUJOy2gHneaXl
X-Received: by 2002:a05:600c:c16f:b0:488:aa3d:faca with SMTP id 5b1f17b1804b1-488aa3dfd4amr92539235e9.18.1775493599637;
        Mon, 06 Apr 2026 09:39:59 -0700 (PDT)
Received: from localhost (78-131-14-223.pool.digikabel.hu. [78.131.14.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm37598820f8f.28.2026.04.06.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:39:59 -0700 (PDT)
Date: Mon, 6 Apr 2026 18:39:48 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 05/12] hook: include hooks from the config
Message-ID: <adPh1GHnPH034u3V@szeder.dev>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260301184500.1488433-6-adrian.ratiu@collabora.com>

On Sun, Mar 01, 2026 at 08:44:53PM +0200, Adrian Ratiu wrote:
> Teach the hook.[hc] library to parse configs to populate the list of
> hooks to run for a given event.
> 
> Multiple commands can be specified for a given hook by providing
> "hook.<friendly-name>.command = <path-to-hook>" and
> "hook.<friendly-name>.event = <hook-event>" lines.
> 
> Hooks will be started in config order of the "hook.<friendly-name>.event"
> lines and will be run sequentially (.jobs == 1) like before.
> Running the hooks in parallel will be enabled in a future patch.
> 
> The "traditional" hook from the hookdir is run last, if present.
> 
> A strmap cache is added to struct repository to avoid re-reading
> the configs on each rook run. This is useful for hooks like the
> ref-transaction which gets executed multiple times per process.
> 
> Examples:
> 
>   $ git config --get-regexp "^hook\."
>   hook.bar.command=~/bar.sh
>   hook.bar.event=pre-commit
> 
>   # Will run ~/bar.sh, then .git/hooks/pre-commit
>   $ git hook run pre-commit
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---

> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index d1380a4f0e..3a95cfe16d 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -1,10 +1,26 @@
>  #!/bin/sh
>  
> -test_description='git-hook command'
> +test_description='git-hook command and config-managed multihooks'
>  
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>  
> +setup_hooks () {
> +	test_config hook.ghi.command "/path/ghi"
> +	test_config hook.ghi.event pre-commit --add
> +	test_config hook.ghi.event test-hook --add
> +	test_config_global hook.def.command "/path/def"
> +	test_config_global hook.def.event pre-commit --add
> +}
> +
> +setup_hookdir () {
> +	mkdir .git/hooks
> +	write_script .git/hooks/pre-commit <<-EOF
> +	echo \"Legacy Hook\"
> +	EOF
> +	test_when_finished rm -rf .git/hooks
> +}

There is no &&-chain in these test helper functions.


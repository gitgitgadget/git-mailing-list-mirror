Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429171C6B9
	for <git@vger.kernel.org>; Mon,  6 May 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000207; cv=none; b=V5y+0Vx11+vgNm/70C+CFN8G2ddPKQ7j9AWHqXaS01JZjp/c6EHbLrZJS+P3lNdVZMHPbH75J1fTIHGnjc/aMOT4tid49rHZvuwbkHt1y+Y2ptXG5h+59bwM1YhIbW6PL4j/80xma7cTpkvsHwhHHACrmYe26X1FY9RKlaBE+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000207; c=relaxed/simple;
	bh=ZCUmzfypst2SqeL/TGuvqLcQsN3d5QRM/D5wedeisiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgyGc/HxTZAst1IiDjKkMFUAM9wI2/JeufyQF4psn/JQVa7/JImf3V3qyGVFr9T6AJl/ywzDncllP+kXk8byf16Ek1cfvoJ8n58pZ5XcDPq8cCis8Pnw3Mg2TdR/E3IfznqkaVv1vROPYDAkf7FD9YC4pV1Rc9ljONIhAxiDHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfYtRS6X; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfYtRS6X"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f04f01f29aso764204a34.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715000205; x=1715605005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMQUBJwDPk7rZ7+aBzqDG8FAN7Rjwp0acvpthnZcjGQ=;
        b=kfYtRS6XAhE77ZDyYf+r7ITc3RZxXFTEAINwauQ6tGeO4eUzdR3LZHTFYznhLCJS2s
         quDbIhd4tgPhlBcd5M3CS4AQ4Tv/NcWes1ODX+pZAn9FviVE0+KDeK3GxKclC5KmlN4K
         Ph/ah9drLWLLPb6mF+SytFgP6pYVpgLyHx8PEhWPYMxkxuMa3zRQRlkBR64bzHnzEqBX
         JT8ZyV9DIIHJ5VonLpDUPyGqS194J7GZ0X9TxBX/aGgM5aL0bsNMuM909igvnD4mbfeO
         pKmCSsDql9swO9E583HXhFUz1iHOM1kcmOe8JkvDQrhEu4sV1RTxxuRuHLzJCsdcwEur
         aOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715000205; x=1715605005;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMQUBJwDPk7rZ7+aBzqDG8FAN7Rjwp0acvpthnZcjGQ=;
        b=iBAWRx/5BEcKdHmkx8zcEi9XLKSFTozEwvI2qf5rUsJz21Cv5mcCw0U+8lTwSSiZ2Z
         q7M9kEwEulouokS7OZX4uSPVSfqNCL2gRBrnjWVyTVdi7WgMhEhmEBs6YLUeHq2pQSzs
         EhwpMI12L0EYTTfhiicKt5NNTERtAWT6fTK78gvmIw7IMjNlUWP9JWd2ODbVDSnKLPca
         TgIdUnfskEfyOQfsaACuqzMLfXnCb/S6G2O816WPmhtnqmqCukV2tAZT3sotjp+85I7n
         /vDF42OrGzHAf6EIjcQkL2K3cRvuT70XrUl1wVSXkMf0J8Dj/aKPPSdeWcn98HRYgdcV
         4Biw==
X-Gm-Message-State: AOJu0Ywy2o/+qTPFoy5vrA5Dy2Nn4caV7k/SNjlmZ+fkIQLo/Clpe50c
	/MmhXkNMXCnM3Gybc0llONIi3gjCgkEIWFttwdZOAyy0f54K/mu4
X-Google-Smtp-Source: AGHT+IGrGCf/YGb8VLFCuRr7iYqua6L9M7gL9O94ExmdT7+leeGS/UXa48wGii6/TGuxs8V9EpJOew==
X-Received: by 2002:a9d:5c04:0:b0:6f0:55fd:2df3 with SMTP id o4-20020a9d5c04000000b006f055fd2df3mr3066518otk.6.1715000205014;
        Mon, 06 May 2024 05:56:45 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm1866313otb.65.2024.05.06.05.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 05:56:44 -0700 (PDT)
Date: Mon, 6 May 2024 07:55:25 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jtobler@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci: fix Python dependency on Ubuntu 24.04
Message-ID: <c2dyqdqge3ypc7syissjm3mh6fqftojvincu4qizkuravc5ll6@bjgjlcas7n4k>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Justin Tobler <jtobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>

On 24/05/06 07:35AM, Patrick Steinhardt wrote:
> Newer versions of Ubuntu have dropped Python 2 starting with Ubuntu
> 23.04. By default though, our CI setups will try to use that Python
> version on all Ubuntu-based jobs except for the "linux-gcc" one.

Naive question, why were the "linux-gcc" jobs the only ones using
Python 3?

> 
> We didn't notice this issue due to two reasons:
> 
>   - The "ubuntu:latest" tag always points to the latest LTS release.
>     Until a few weeks ago this was Ubuntu 22.04, which still had Python
>     2.
> 
>   - Our Docker-based CI jobs had their own script to install
>     dependencies until 9cdeb34b96 (ci: merge scripts which install
>     dependencies, 2024-04-12), where we didn't even try to install
>     Python at all for many of them.
> 
> Since the CI refactorings have originally been implemented, Ubuntu
> 24.04 was released, and it being an LTS versions means that the "latest"
> tag now points to that Python-2-less version. Consequently, those jobs
> that use "ubuntu:latest" broke.
> 
> Address this by using Python 2 on Ubuntu 20.04, only, whereas we use
> Python 3 on all other Ubuntu jobs. Eventually, we should think about
> dropping support for Python 2 completely.
> 
> Reported-by: Justin Tobler <jtobler@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> 
> Note: this topic depends on ps/ci-test-with-jgit at 70b81fbf3c (t0612:
> add tests to exercise Git/JGit reftable compatibility, 2024-04-12).
> 
>  ci/lib.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 473a2d0348..273f3540a6 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -325,9 +325,13 @@ ubuntu-*)
>  		break
>  	fi
>  
> -	PYTHON_PACKAGE=python2
> -	if test "$jobname" = linux-gcc

With this change, "linux-gcc" jobs using ubuntu 20.04 will now use
Python 2. Is that what we want?

-Justin

> +	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
> +	# have it anymore. We thus only test with Python 2 on older LTS
> +	# releases.
> +	if "$distro" = "ubuntu-20.04"
>  	then
> +		PYTHON_PACKAGE=python2
> +	else
>  		PYTHON_PACKAGE=python3
>  	fi
>  	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
> 
> base-commit: b6db6b1598946fbf777e55ff0d187b11ff3bd21f
> -- 
> 2.45.0
> 



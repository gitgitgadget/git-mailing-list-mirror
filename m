Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029D371067
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950313; cv=none; b=euN7w2n94muyKi3Jnz0FVTixe19NPtB6/SnhNaDvoX5UsRc/NSxNc65ia1EbpR98oxtP29ytUMIYqCqZaPQz+Uu1CRrD+aDDrPX4S9xibryVCLemoMqGdNkGlXpv7TtaYyUbnbR158jES046KhLp4GGI5g5hVEq82zVX0Pfy9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950313; c=relaxed/simple;
	bh=62+Xlm/qlWlm6+vkhtyUmeeTy/x7VWX6Ovl0ccSPk0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alAe0cCFU4D7PTQOmgwnHlTWZy0Ve/17sOYc6bf2zrZ768zA/Za/nB+2YqHmG1PVXM9L0E/31H9E6fyEV2gRR7SK2jEJ2OWqzS68Oh/H4a6Q90Naiom75L11MXPbF/PMTMcflzbYPmJQG815MsQmCU9r5ioEfYR1uf4rEt7F1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCOyaowg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCOyaowg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0280d4f56so671715e9.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950308; x=1791555108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xQ3Qe02Hg7i4aKjWFEhzqzVgl5X5tVQBBe80ipktp3w=;
        b=eCOyaowgXvWU5KvBSApXFjv07YT4wjwN/9E++jeoI8om6er+C/o2FKCCOy+1/7sM00
         dUJxtAYRUyQ7sODOkW+7f9oqcamJcxH7FyAd4yH2FI8/CmSQY0DXHfVHWUHfJJBADxVe
         XpbvnDAEAEYz7Ho+fvBwBuqeyFPgRkCug1DtGGAUtiNZyAZD0oHTzHWd8p1z/pQFEvLS
         8DCpTilyQ5HFo4XAPoYUv8MzpB9Bx/TIDCOHBwliV6W7F4qWGJ3LCwAER6XNM5pC/xl3
         J8hwg9mxB2xfFVwOGhS8UKAMSo2Go3/LhBXdvnKehTdHD7TZaeu3ABB2F2nUXoUpyPrK
         3xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950308; x=1791555108;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xQ3Qe02Hg7i4aKjWFEhzqzVgl5X5tVQBBe80ipktp3w=;
        b=hyxMW9wmyRFTPvgCk/Mwt7S3ou/UnUfTafnKbrax+kOgS0MrrHPMORmWcSXJj99dq9
         XdS1UUj0+qSaQbpeTyNRDmN/R1A9YQJyWKrKgmDlKZdlmRvAG6aCvmPqHRDoNGSd+2zI
         axQ4BfI1OvT9nrIENU6yroPXSPr+U+K5Tk8s9edcLq2DLgvUumXjCWLJvbCmnlT7Ewxs
         XJCR8qqyIeqtqghtlqniwNfwmh7JlzwWcbhU7RRozgtGw6lkMFL/fi8CHqSMkZUAhjRM
         rpUtlyWHCugc7HZ7doZXQsJW2MuMbP0O5bUTdzNQKF1jqzDUg1s1NXsta+p95ZCDiYCl
         rfYw==
X-Forwarded-Encrypted: i=1; AKwUvBx0ApzGCMwWmr63snEa4p0dqDIdF+wFK6pDxPrDFrhM9ow2JqvIfBZF2fDdPAphKB3IQBM=@vger.kernel.org
X-Gm-Message-State: AFuF++nhI1mAnFdPRaAxkmMpWAtiTKOWcerR5xzlzC6eS6jELndrLy64
	+/rRgj9OXpe/vgbKggbp18buaeGOEQqueBPDQjQaxVyWvv8N+Cupw0Os
X-Gm-Gg: AYBFou2SgU3qag6gKH+nxU8Kbfs0Xw3fqAQD7606Ccq5GC3V8AkXOPWWqYmZ2YfKihW
	u4zZpCKYQTj3p4V4kRfl8DWklDMSuSNfanAJjozdef7hrfvxLwnDhJoQ1U+P4MkO1qTFoKlnyP2
	Bgvlsai0vmBR+jF/MsnHCt92/3CvyyDz8I+TPTtMiBQ7r3RzHjBjEZr1lJKgHSvlAjdXAEJ2GkN
	F6JySKTrOPawdxmLpY0o7nUbomkF3UH+7+dsGf9rCeJGOt6W48cs0GvaMaCA4OlesY5QUwiPvuC
	z9fQy0qiRdpoIWOpEwqY+gjuTR3jh1Vt35cm9pT/trz7ZIjJbspV2+WjIBjMJ+nMOHXFAoPjWmL
	tLy8w5ikaBzCDPz3YJRjbH9zvfbq2SKwSwz/yUSR9Mr4+fc0omnhliN8GFWdGEKRoiHVYD/f3k7
	cwvbJ4Z2O2pxbO1S5Zu4ZQELZZMk7DL/es3B+nAqaM/b8PF/l6KM8ye9VVcjFsHGY27PUlWdM00
	zNE9PrS1hfWgOmpVkWN/ltokCcDwVvULRlKQnUu33jeXlWlTRljvg==
X-Received: by 2002:a05:600c:1387:b0:49f:ffd0:9a9a with SMTP id 5b1f17b1804b1-4a02769cc07mr50578055e9.25.1790950307608;
        Fri, 02 Oct 2026 07:11:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38103856sm6342644f8f.25.2026.10.02.07.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 07:11:47 -0700 (PDT)
Message-ID: <cda2dd01-9dab-4842-86af-9b77767dfc52@gmail.com>
Date: Fri, 2 Oct 2026 15:11:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 3/4] var: accept more than one variable
To: Andrew Pleeter <andrewpleeter@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood@dunelm.org.uk, ben.knoble@gmail.com,
 peff@peff.net, sandals@crustytoothpaste.net
References: <xmqq33va1lcg.fsf@gitster.g>
 <20260926162048.30853-4-andrewpleeter@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260926162048.30853-4-andrewpleeter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew

This all looks fine, though we typically avoid using test_env() because 
it introduces a hidden subshell. I've left a couple of suggestions 
below, but unless there is another reason to re-roll I wouldn't worry 
too much.

On 26/09/2026 17:20, Andrew Pleeter wrote:

> +test_expect_success 'variable without a value is omitted but is not an error' '
> +	test_tick &&
> +	cat >expect <<-EOF &&
> +	GIT_AUTHOR_IDENT=$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
> +	GIT_COMMITTER_IDENT=$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	EOF
> +	test_env GIT_CONFIG_GLOBAL= \
> +		git var GIT_AUTHOR_IDENT GIT_CONFIG_GLOBAL GIT_COMMITTER_IDENT >actual &&

There is no need to use test_env here, "GIT_CONFIG_GLOBAL= git var ..." 
is all that's needed.

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'a single variable without a value still exits with 1' '
> +	test_env GIT_CONFIG_GLOBAL= test_expect_code 1 git var GIT_CONFIG_GLOBAL >out &&

Here test_env is also not needed, "env GIT_CONFIG_GLOBAL= 
test_expect_code 1 git var ..." would be our typical style.

Thanks

Phillip


> +	test_must_be_empty out
> +'
> +
> +test_expect_success 'unknown variable is a usage error' '
> +	test_must_fail git var GIT_AUTHOR_IDENT NO_SUCH_VARIABLE 2>err &&
> +	test_grep usage err
> +'
> +
>   test_done


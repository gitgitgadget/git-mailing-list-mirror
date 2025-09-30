Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA33043B8
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246001; cv=none; b=aX0w2V/0Xi1AvDCssUJDOp6po3k0iju3vKxmUlanfs49ScX+2F+MQpP/o1hWRbIuygNGHzcEcJlt0yQs5bodxZ1B4xULS7ZG/vLbNYqzwUs2uGu1MsBH4y24HFS/50pGKD79BP9Yxl6yRQ13Hph0EoaoJU9sVRrjGTPZpq8Vn20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246001; c=relaxed/simple;
	bh=Kth8StXR8haNmLzsREwpEz4d9flyUs0iRCEXIyo6oGM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jqVMriOIL3WCJHMJ9LGff6ry7DJXZtTpZBkPiatQkbPZhXS7YkERmgxcufEZWLncvCpmSBI3TzUkzzxsIT2Yy6rxNXZzYhhzyA7sT7GoHsmvwrkP0VlJIsqfZYgHs95YFTnYxz9tdi9icUo9q4cPPRxSIbQoyhgCQAwG1gdHgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0DbSz0I; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0DbSz0I"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so3855993f8f.0
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759245998; x=1759850798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvhcK+ZktvDVLjs7h8o/57mvZIq0H0N4visX9bqTcmQ=;
        b=g0DbSz0IYcvvYxUNtyLHzgAsY3w6TsSNgEsnCYt9NUlCm0Swyd5wcwZhh9w/82pwe7
         e7LxKRk5QGQH9VtQC48PQGTuk2nENtzcBKhTwDSYTQvH/CrawStoBPz3wDq+ctJwP2gX
         RT/4cn/P395GhOR3u83c8Zsi2qAp0e3bS/5e5dq/AYxqZhgpkyCwKJ1kilS+CNIRc2o2
         vfrtpmqXUpWrQhWkir/KlF4flEzUYhSBjMMd2Ob1L98urWa6xWArxo+ywVHD4TIEgcuQ
         Sl0ie5FH/Pa9pBsFsc3TpEMaIIZrZM4s89tYl81uS4AM+FeiwTQnftZQztNWuVT0d6N1
         rNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245998; x=1759850798;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvhcK+ZktvDVLjs7h8o/57mvZIq0H0N4visX9bqTcmQ=;
        b=NcI1pFo/0dv9uzl+N6Jx4gnUv/Eic4jg1UFJRXbx35YspJdp6zVFQ8ZlF+XE0ln4iR
         uavZEKeYo6wWKN83gHp/m8O0xlRr/hcz51+vJj6tEhMhXZCnHbt7MYLzgo39NNpoHCLv
         P5DvUOwzW5LEOcSWsbeiCpIPU/w/7KyqmvXgqgWGfzxtxkYvU3lhpvPSWQQMSHiH892W
         cmutIgsBSKX2QGynfvnHRHRmi8WLH1dcUKOJcqPqqjfpEiAFRi8K6JkS/+eQVy66A/eb
         5QjjR6/RdXZsn8yHW1PcjM4D06NtKCw9TfFOORBQbaGvKGMZyr4mzR58XKk4+38nOKSX
         yeyw==
X-Forwarded-Encrypted: i=1; AJvYcCXDm1tZ8fnQeD6UGA1IE40Id5ceTF7ycg5CB7Jmv3SJwjVKogYq1UgsKiZdjzv4hWt9D1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpVG11C8JIdnziEJzsfum3I3DUssRBCm10t77Gd7S9z8tVANq
	rxFhwpCs1K9+fPk1MCcx1lKyFw4R7QsF0hBGPUegWklieNR5Mqtn8zZC
X-Gm-Gg: ASbGncuZ02jHQ/JcxOPYrsijZ5QyKoT4vjLqDGM8GYrbswXhPD/Nv1r/Wlp1MMjukDq
	DJWN9qSZvRAvEhdjH7wKs5v8EaY1TeFFCkyvzg6LYJ9+D9m0J+LHdS+7JTre4MQG/cg8wRiirDt
	mxEi/ibDLVb8VfuvXN89W+L3cSf193Fl5Qcoi3E44D3Uea1oL4cSOznIx8vocQaMTENmvPoJFbX
	NduosTEf4Rxc3Kz6+tYt309znut27ysDDFxUi3ArXET3YJPIHteqlK+5QOfIC1x5cDWyvI5yHf5
	SE19Fr+PzoEwpxN+S61DFxqzQeu2F1UcNVlCT/7jlc+3qP905DgHaQQgL80WxKniTH9w9cIsQk7
	qTW5rWg5Oy0lVBZRBGWflj5lCKnM7/xjDYrMJn7dxQVlxur26NuGUweP84JOKnMAvBGVKB72+vV
	JsRvpPUlVHO8HLTcgk4xCVBw9hLOyXCeEvFA==
X-Google-Smtp-Source: AGHT+IH2BmlsIgYeIz9dEBbUkNn7B1PRRQpV0pOVKlh/KigirPUNe8Rftjrf476g24CzFa4S5+U1fQ==
X-Received: by 2002:a05:6000:2313:b0:400:818:bae9 with SMTP id ffacd0b85a97d-4255780b7a1mr107138f8f.32.1759245998147;
        Tue, 30 Sep 2025 08:26:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm22941822f8f.33.2025.09.30.08.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:26:37 -0700 (PDT)
Message-ID: <a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
Date: Tue, 30 Sep 2025 16:26:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed
 with :(optional)
Reply-To: phillip.wood@dunelm.org.uk
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Noah Pendleton <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Thranur Andul <thranur@gmail.com>,
 Michael Grosser <grosser.michael@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Taylor Blau <me@ttaylorr.com>,
 Matheus Tavares <matheus.tavb@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Calvin Wan <calvinwan@google.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
References: <20250501214057.371711-1-gitster@pobox.com>
 <cover.1759094936.git.ben.knoble+github@gmail.com>
 <5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 28/09/2025 22:29, D. Ben Knoble wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> Sometimes people want to specify additional configuration data
> as "best effort" basis.  Maybe commit.template configuration file points
> at somewhere in ~/template/ but on a particular system, the file may not
> exist and the user may be OK without using the template in such a case.
> 
> When the value given to a configuration variable whose type is
> pathname wants to signal such an optional file, it can be marked by
> prepending ":(optional)" in front of it.  Such a setting that is
> marked optional would avoid getting the command barf for a missing
> file, as an optional configuration setting that names a missing
> file is not even seen.

I think this would be a useful addition, we've had several people 
wanting to make blame.ignoreRevsFile optional and this provides a 
general way to do that.

> --- a/config.c
> +++ b/config.c
> @@ -1279,11 +1279,23 @@ int git_config_string(char **dest, const char *var, const char *value)
>   
>   int git_config_pathname(char **dest, const char *var, const char *value)
>   {
> +	int is_optional;

This could be bool rather than int, the rest of the implementation looks 
good.

> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -46,6 +46,15 @@ commit_msg_is ()
>   	)
>   '
>   
> +test_expect_success 'nonexistent optional template file in config' '
> +	test_config commit.template ":(optional)$PWD"/notexist &&
> +	(
> +		GIT_EDITOR="echo hello >\"\$1\"" &&

when git runs the editor this will be expanded to

     sh -c 'echo hello >"$1" "$@"' 'echo hello >"$1"' path/to/file

I think it should be

     GIT_EDITOR="echo hello >"

instead
> +		export GIT_EDITOR &&
> +		git commit --allow-empty

Maybe I'm missing something but don't we want to ensure that we have a 
non-empty message here? Also as it is a single command we can avoid the 
subshell with

     GIT_EDITOR="echo hello >" git commit

Thanks

Phillip


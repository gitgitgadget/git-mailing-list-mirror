Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847540A924
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317959; cv=none; b=AgB4xK+USVNtr8+UVw/qQu2MAiMTR1jS2/CIoY0qhAZ6dwP8fjtb7rp+eAjwjw7o9lAptmGNUMf2BWPKV5ur4KleBAJpKBV5DHR3taCgL8V/pWIhuqT8QNSKpqd1VUPjJSXn9la3dwvjkYuZjKnvBnY9/azQIsyluBroxzbjxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317959; c=relaxed/simple;
	bh=r2ZEOmlAedUk4a1f8y5z/DF4vNraTWMlW5nS1tZ79IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG/u9EF6af60Z0wOSFRChYUL6zAkIAO+pxNIX2A0pvp4aKzyaEJjRhTLgx0AbQbcnAgo+MbS33HyQePb+kY8mCtjA9PwCIlTaTrNEIGS2By34xU9CKe6XZECMMl3f9Wxw7S2fepzLL3/wGm2c+1hrRxpcOZaDl3spAeCm905Jlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwjV8+Qf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwjV8+Qf"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso1054929a12.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785317956; x=1785922756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iJPytyYeXFQo9luIQ+MaHAgszAE5ZbBoPufx12KHvpc=;
        b=nwjV8+QfQ7b/5Lr+KBBhKmHpYEIEbuTIGWE75ern6fNkWuaG5AQmfLLMUYDIW3d56f
         y4Vq0X494z27KK3Qw5nSVrN9L/nznxRaMnaO67WiM41wS59NVg+T03VEfSf3vgD12sOr
         mH5sOElB4diMqvG93LGaWUwGzLrDRttdjPVXdzjohq5o98P3b4NwZKVUQ1IMfsvkA4fg
         JJnaj55OlKqqy6HAAQYDvBqeyGGelqtR9Wd5L2Ht2JTOtLCpfHHlFBpzbvxfMRT33ECM
         RxT5w6JSvBnSA1pep73Or3avG33o9bQSEE4YuESR9w3Nnoiy4l1d/guQ7w8XzVaD0cbJ
         BuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785317956; x=1785922756;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iJPytyYeXFQo9luIQ+MaHAgszAE5ZbBoPufx12KHvpc=;
        b=cDY0qK2DL5g3Vk9KLjKMBAwF1YUGUyIdt6mhfo5TPOIrGj+y1TXAVQxMt0qgyKDDtS
         aYzIUu6BWNo8y6LH+SNqIMt8UJbZKL1Ta9YzIWGl4+Qgbi0oQLcwuE4DYo9nhrCrdQlH
         pnHd99L0ENdHDFixBmw82sELw/bnBAomfov5S1TdK/WFfpKPsoRKM1zgvFPxKbfSRC5l
         yViSWDTnwb2l/8zrfHZlBkuP6ZcPY3bo1Xf5r17uUp4Cgls6MtuNZwOyEuPYcSJDTuub
         iOfp7H1niIuQqgzy0LZ0rb2tDL5xjgHRxYEKAy+aSwtFhXDEDjPIT3U/gG322ImOLz/y
         SK7g==
X-Forwarded-Encrypted: i=1; AHgh+RroHe7AlFmLk0eYG/10VcfqUEuveSL2D9jeMYYeAYDG3fMR0MgSCEFUXqdzhTQ0aM/DTbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypl20foTX6Mh5EVL+yYVfqUzlV6sOc4jF+FT6sd+QHMi7sUytp
	QE5fTeZHx+bpaOyYNL6FbMQKVpJutLgCq09V/YLo0p9jqizLulYiniYq
X-Gm-Gg: AR+sD11k04LQ7Xdz/g3lMCFDsZJxPlOYwq5LAcSzYMWV8RCBqCDOCUVUUXHcpEqwM8C
	doY+M5qgXd1CODir+/k2sCNqUnZZT7DN6JKmze2N0G2iy2NObaI/7BvP6znaSLcWJ4oySapSUvR
	XjUO0b6HvXe9dhdYjbRKnpwDmel1Po+rxWTKjYUin7ZrC6plQt2TQqotXX0Y7q9CdO67b+ghcp3
	Ms8g99sFsAs+D3XjD47X1SI29fBLaWk5+3sJvtZb+PdLUUD13EvjP/oBrXVphzGhTvhPJ/+Tu3O
	CcSVpWCg37hHiiGDWbbdf5DpiUNARJbtd3x+m+BQmtrC/arCfOOlVUF/GdpBqR5kfA3sA7m2gcw
	I4ey7pCNlee3I5g7EVcdbxBcMgldsHTt36fF5xxQhyGbMrhZPBwTjogIcvmcTYp38GHolijsxiC
	6vKOmXEGoB4iLvOvf2JgjGoBfDXmziOInn7jNuCHcA+JSpjCiPRZkjTDbFLz9lPwk6RPVwMqlHd
	NWteoGZ/S4wUGjvi2iykBTNbgJEYRUXNOAHxZrx8Mg=
X-Received: by 2002:a17:907:e1d1:20b0:c19:6d4a:4261 with SMTP id a640c23a62f3a-c1f72510400mr223130166b.63.1785317956068;
        Wed, 29 Jul 2026 02:39:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cdf452sm89770666b.14.2026.07.29.02.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 02:39:15 -0700 (PDT)
Message-ID: <9a47d529-6195-435b-90a6-e511856f128e@gmail.com>
Date: Wed, 29 Jul 2026 10:39:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] merge-base: add tests for --is-ancestor
To: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
References: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nikolaus

On 25/07/2026 18:00, Nikolaus Schuetz via GitGitGadget wrote:
> From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
> 
> `git merge-base --is-ancestor A B` is used a lot in scripts but has no
> tests. Add some to t6010 covering its exit codes: 0 when A is an
> ancestor of B, 1 when it is not, and 128 (not 1) when given a bad
> argument. Also check that --is-ancestor and --all can't be combined,
> and that the resulting error names both options.

Thanks for adding some tests for this option

> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index 44c726ea39..d28d9dab2c 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -305,4 +305,38 @@ test_expect_success 'merge-base --octopus --all for complex tree' '
>   	test_cmp expected actual
>   '
>   
> +test_expect_success 'setup --is-ancestor' '
> +	git init is-ancestor &&
> +	(
> +		cd is-ancestor &&
> +		test_commit one &&
> +		test_commit two &&
> +		git checkout -b side one &&
> +		test_commit three
> +	)
> +'

Do we really need to create a new repository? None of the existing tests 
do that - can't we just use the commits created by the first test? 
Having said that, the tests below look good. We could perhaps have a 
test to check that it fails with one commit or three commits but what 
you have here is clearly a very useful improvement in our test coverage.

Thanks

Phillip

> +test_expect_success '--is-ancestor parent and child' '
> +	git -C is-ancestor merge-base --is-ancestor one two &&
> +	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor two one
> +'
> +
> +test_expect_success '--is-ancestor self' '
> +	git -C is-ancestor merge-base --is-ancestor two two
> +'
> +
> +test_expect_success '--is-ancestor diverged commits' '
> +	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor three two
> +'
> +
> +test_expect_success '--is-ancestor exit 128 non-existent commit' '
> +	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor one no-such-commit &&
> +	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor no-such-commit one
> +'
> +
> +test_expect_success '--is-ancestor and --all cannot be used together' '
> +	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor --all one two 2>err &&
> +	test_grep "options .--is-ancestor. and .--all. cannot be used together" err
> +'
> +
>   test_done
> 
> base-commit: f60db8d575adb79761d363e026fb49bddf330c73


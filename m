Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A926299
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610288; cv=none; b=JH0F6b6Or/6LWHdaGxgvV8MiZ+XNB335OuHtuJu4Fy4It30DdCnY7DA497pFMUtSaMvXFZRT3oWvj8a/kEu9ww20sJwJydJiLVzPmRmGk71wenoQDiW0I95bXbsuGwWcquTkGFDhK87blI9pJAb+jXk/esj8rNeTwoiBE1+C1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610288; c=relaxed/simple;
	bh=SN5rOv98gfghY/LZkD8A98qBz86K6G/H/1lLR3moO0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkcMD6Ttigyt83az3tsqgTSNwrdEGAyCay4jxGQHAQApJ8sYeDl0FxU0dSlHpMpBbqnq00E0uv9XDYeLVja5sr1RJvMFSFZhOvIgWqBnvktpZkxb1zizdNrzRy+W6KIS2E40XR/F106WkP2X2es1vQaVZ7AIc1nclv1zsoyACVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnmoZ4OC; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnmoZ4OC"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso10017975e9.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610285; x=1791215085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IVdNfC1nhNRX2MJPmqn1Va+A2547TQVz0Hc1T9dWUTg=;
        b=gnmoZ4OCJGNXVMI14nsBuHP1qu3nR+ORm6M59Qc65VlIqBdeWXKAR8ny6EEOpY8003
         dfkAZobEqqc9l1Q73R5I3lLp3tkHue/efUixcPoLki4yGsGcfCOmRnJFWlYUHU9AApN9
         1z0ovxVbFTaU386wEaPodiu7x/mu5efpOeBiS2yvAQWhGPrCVQEWmpLRDnp7NgJroD2o
         YrmDOQYEeoPHjJtxL5TNWMOq8DcGP4tq5rcaH+18aHE/Aiq4K74Zd2Ni9BGey1OQR5pG
         SOyzedz2U+3j6gA33hqX/kpEzkyuV92rCWGSov2OKfG8Ork+a5/DM4yeXcUv2pu8q1gd
         raCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610285; x=1791215085;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IVdNfC1nhNRX2MJPmqn1Va+A2547TQVz0Hc1T9dWUTg=;
        b=mXZ8bPIy93zhR85O48bXI3Brwl54rfI1MbD2kMNQl+o87X/SPo0rVufEru5Z+WjyE/
         c8TQ2en3pAejyQLdsMWuJug5loOghB2KJKWmZSmu0UgRKRMaJqjteprwHRQlCfrxM0PQ
         t9FFG0UsGLGpXwJTQMJ957j7FNw6CEXkPHWBrOak8nOPF/GqSsSJCjwV/SMhJn2DtLwc
         KbyxEjfBrdkFarKztyOQjYI1kaQbUx+W7PlWxaQB+CUv+4ysdtv13G2q71vV7AFH7c23
         SoVL0D2XJi6jMoax/nQ4jmMFWnw8QZmT31W91lR/vSwGohIqeeKAPwCthCQy3XTUC4mV
         e8rA==
X-Forwarded-Encrypted: i=1; AKwUvBz63j0unYg8M3f/yOYldE/XdvZcehJY9Pc6nZDd5M1EEoqAngQvHQ94Fj1UIpKthlMf6PA=@vger.kernel.org
X-Gm-Message-State: AFuF++mP3qbBdYxIURL6Ud7Biuf7TPq5vz74A5gE67ArkJeL3FpRErrW
	Fzsj2qUVDEwGxQOA2GCjDFQfN+MkhFWewgV2e65jaZqAg9bGTjFL9mEX
X-Gm-Gg: AYBFou1WEMyJ0V+sMyL21TVeDRjRfJlztzxGansGyLRB0BgfziG4JlAZqdjbAdCL8Wl
	zazaWv1Ggi6vQCOYFSXSLgCirwwNCHHzMm2Qe7aVbtkUGe4DjlYgin8jSgNHXIG+1Y9uxeXeD6i
	13GGg/W2ARQn4X6x4PbA1OFSFVfIH1mM6hd7/0NRF1y5t/xnEUaevCGXMVY8cm07KKjrHrKT5Nn
	Frif8ksduT7sBRqs3ryscif22UOuHm631uLYDna/fdRvr4Tg2AcW8OYHzi94O99Cc8NzD+3xczA
	GStxj7DOmKrWimiVyJ7Jnb4pHMkWEWVUZTZmKroSdlJQDnKiYrDDg3NMLkkV8Iii5QjDZ4FiViM
	X5nlHguTLxe+lz3beklOlEc9oPOI3icAD4qJ6OhsuH0obAAYpPeYUHNgxl4K5WcemRP2qYABAkr
	ZgNY5hOGZ0QWEzDzyRa7dFYOL3CPLNrjy2cIKU4Pjd6TYXOemAbJSAeVj3yLNWbB3YyUGk4HwZ4
	UtGfczuO6kCFgasVnpNj8vwBPO83hlC7wMGLin8jvk3QTVwcbF0FQ==
X-Received: by 2002:a05:600c:4709:b0:49f:fbad:29c1 with SMTP id 5b1f17b1804b1-49ffbad2d61mr108227465e9.33.1790610284799;
        Mon, 28 Sep 2026 08:44:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a648895sm28431498f8f.28.2026.09.28.08.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:44:44 -0700 (PDT)
Message-ID: <97f86d82-b5ec-44df-9ccf-8e6cd93e45f4@gmail.com>
Date: Mon, 28 Sep 2026 16:44:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/5] t3903: test stash --index merges
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Elijah Newren <newren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
References: <cover.1790168285.git.ben.knoble@gmail.com>
 <cover.1790425008.git.ben.knoble@gmail.com>
 <8b5ea5e6f47ee9a57df3a4d97a457d024b3dec00.1790425008.git.ben.knoble@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8b5ea5e6f47ee9a57df3a4d97a457d024b3dec00.1790425008.git.ben.knoble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 26/09/2026 13:16, D. Ben Knoble wrote:
> A future commit will refactor index handling for applied stashes, and we
> need to take care to get the order of trees right when merging. Add a
> test that covers this case.

The test looks good, but without the changes in patch 5 it fails and so 
adding it here breaks running "git bisect" on this series. I'd squash 
this into the final patch and I think we can probably replace an 
existing "stash apply --index" tests that are not so strict with this 
one, rather than adding a new test.

Thanks

Phillip

> Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
>   t/t3903-stash.sh | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 721158606f..9bc99fa252 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -374,6 +374,27 @@ setup_stash() {
>   	test_cmp expect actual
>   '
>   
> +# the later "stash -k" test is not expecting us to muck with file so much, so
> +# reset when finished
> +test_expect_success 'stash apply --index merges the correct trees' '
> +	head=$(git rev-parse HEAD) &&
> +	test_when_finished "git reset --hard $head" &&
> +	test_write_lines A B C >file &&
> +	git commit -m setup file &&
> +	test_write_lines A B staged >file &&
> +	git add file &&
> +	test_write_lines A B unstaged >file &&
> +	git stash &&
> +	test_write_lines committed B C >file &&
> +	git commit -m to-be-merged file &&
> +	git stash pop --index &&
> +	git show :file >actual &&
> +	test_write_lines committed B staged >expect &&
> +	test_cmp expect actual &&
> +	test_write_lines committed B unstaged >expect &&
> +	test_cmp expect file
> +'
> +
>   test_expect_success 'stash -k' '
>   	echo bar3 >file &&
>   	echo bar4 >file2 &&


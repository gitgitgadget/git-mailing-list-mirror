Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDA3264F5
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294368; cv=none; b=UgPqCdxXk3Vkn4NR+VN2gnii4xvs+3IIdqh6Jn1XZTcH8DEwxg1aipo3jzOfn6KTmTtKZF1e527D9zK0VyFD2TCo1snDv9kqtxRAMSM7QY4zu697xrmDdfY7ayNNAPgtlkHWqNNrTJU3uo/SGH/r2C1Db524YDRX2AfSiNb96HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294368; c=relaxed/simple;
	bh=TZPcutmm48HvM/b0Kq3pybmpFxQeLCn7LJXTxKMyHIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg816cOPCnKsw7JpQzjeaXq0hDvgVUA2plf6Mg1pD0eBIYR8dmCydb0/8D1U3Mgv6vD9PJKC1AsL0yryr+wi1ys5Og20IG0wSCHgED6wpS30kdkhECtEyhTXwn7sNqNL5wmqxGjj5RGS5Kxy1bEaSlD4Lykf5d2qoeZdsfcNwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNDkDaz0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNDkDaz0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986fb839f5so45585877b3.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774294366; x=1774899166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giIAsbuWd2PtDCDiasgFGkEMbxnbogmS2fNwxhYtwAk=;
        b=HNDkDaz0QQTd7K6HdpZyu0sHcLpveFt6OvD1aE/ZNyVAdKqEe1/0n+/BqlvzQrmaTz
         vz1zDNlH7+KH/Z6iPOJTjtC0zxd4r7XiaisyUBXcnIvKL+LLSt+/YzKZBUFyA7mwx/0I
         CAo5czpK6Eqtrgz9pxdieXXc90azSn8OkBjZBTOe+EnFOUiRggpD2Au0E3n4DNjXrGms
         9M5Qm/M5HmwcCf3guJdIlrIb3Og1ePrwofbSG00OlPJBJo0WWqDAUYPtSY25oFmrDXOo
         mTxh4U3GUEb3eLI0+tQ/cs/mJiTqttzJKhzqnWh4RQjXG/U4RYn/eFyhyrQNdokW6deA
         603g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294366; x=1774899166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giIAsbuWd2PtDCDiasgFGkEMbxnbogmS2fNwxhYtwAk=;
        b=cfshZwI2VychWC+FlttvGCgzO3LfJz18ovi9p+KTBbJt1fnrAbr32VxnIsG7O05GWU
         3zpk4cVgpDAZdCBUl3OU04vYBEJ1NWtq/OkM09kQHJTgmygrzu93smwSNv6tvT0px+/Q
         qlqa08X3U9tli9jPaEvalQXYjGD6Fyq5Zpk4N6EcTm6Ublt33osK/BYdtS5fZNjP345v
         wf4T0/aOurz++7SJYhViIHgGaDu+Hmty/EksWhTUSJ2P5ikFGKz+AcABwT30gBHVrOkJ
         +ewu86RvnXKm39qcotnfNZCGGzPaolHJi4MK8orV9/8Op6UWQXt+KqIldPcNt7lBqG7g
         48OA==
X-Forwarded-Encrypted: i=1; AJvYcCV3gFgNsmaczZpgsTF1eYBcg8eExcns/3gYnUYmOrz5OBW14f3TrqB/HEIY7A5sPaLTKR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRFU+odbqj85mhpkBH8lBqtjwADrXFlnrwJMFAZqjjXIzN6Qj
	5XdXG8eVegNYP/w0vbQCoH5ws6O4COUtN3tTi1ERRp3/ft3pQfB91EMJ7Au1Yw==
X-Gm-Gg: ATEYQzzGA8xNWsJr9v1u6aNRFRM7FlKhci46cazL9y6ODs1T7XYgdKp99N0FFQreChd
	IQ/Gy9ORbnAOyo0jZ1qZEdxftBaXcG+9FNpYeWx4QBMeGCUJyukQWijdrv6Sw5jWIYSM/hvcN+V
	B+PrI63wjch7V2xNzmh7a1JldKoX1TG2zJrd0CUT5IboGRRAOK1vMyn+bE/8AJYYbAhdrEBbqZq
	1qDcEgcVthYBoSeSTV4/FAO6L7YDM/63b0zECoL5nnPJvUrjHwK8hdj6JIQCKcrIeUsz09ZBLIP
	m08U/vRegFSufu6oiAmRoy7wxS/x88RkqLvwMbNZX1yytmtehJecFK0WJ1it4tlehjFCSV3yltK
	PoFn0hV/GBjqdQT7eEAijnZycrQbmXcZFmFiAIGTkWCB8liePlMdSRYSjrdoRWjr2dzXdgKRpV6
	+V1Tq62Eru+iLfBOESYP3PK67jlICRAeWz3tU2zaWtF5tXeQfPEJHSa1IOClycWV93pb0lSr8+V
	iV2aYPl
X-Received: by 2002:a05:690c:dc2:b0:785:cecb:4b19 with SMTP id 00721157ae682-79a90a89acbmr144657137b3.5.1774294366154;
        Mon, 23 Mar 2026 12:32:46 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903a33acsm62898547b3.3.2026.03.23.12.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 12:32:45 -0700 (PDT)
Message-ID: <ab38c06c-29de-4c41-9aeb-5e465f6af532@gmail.com>
Date: Mon, 23 Mar 2026 15:32:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] repo: show subcommand-specific help text
To: Mahi Kassa <mahlet.takassa@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, lucasseikioshiro@gmail.com, jltobler@gmail.com
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260323152937.257406-1-mahlet.takassa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/2026 11:29 AM, Mahi Kassa wrote:
> Use subcommand-specific usage arrays for "git repo info" and "git repo structure" so that each command shows only its own synopsis in help output.
> 
> Keep the top-level "git repo -h" output unchanged, and add tests to cover the subcommand help behavior.

Please wrap your lines in the commit message.

> +static const char *const repo_info_usage[] = {
> +	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
> +	"git repo info --keys [--format=(lines|nul) | -z]",
> +	NULL
> +};
> +
> +static const char *const repo_structure_usage[] = {
> +	"git repo structure [--format=(table|lines|nul) | -z]",
> +	NULL
> +};
> +

I did a visual comparison to the synopsis in Documentation/git-repo.adoc
[1] and these look the same. (I suspect that they also exist in the
repo_usage struct outside of the patch context, so they were easy to
copy from there.)

[1] https://github.com/git/git/blob/6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad/Documentation/git-repo.adoc?plain=1#L10-L13

> -	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);

> -	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);

Nice and easy here.

> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -148,5 +148,9 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
>  	git repo info --keys >actual &&
>  	test_cmp expect actual
>  '
> -

Don't erase the whitespace between tests.

> +test_expect_success 'git repo info -h shows only repo info usage' '
> +	test_must_fail git repo info -h >actual &&
> +	test_grep "git repo info" actual &&
> +	test_grep ! "git repo structure" actual
> +'
>  test_done

and keep whitespace between the end of the test and 'test_done'.

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 98921ce1cb..0f7ec4da10 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -224,4 +224,9 @@ test_expect_success 'progress meter option' '
>  	)
>  '
>  
> +test_expect_success 'git repo structure -h shows only repo structure usage' '

You preserved the whitespace above this test. good.

> +	test_must_fail git repo structure -h >actual &&
> +	test_grep "git repo structure" actual &&
> +	test_grep ! "git repo info" actual
> +'
>  test_done

But here we need some before 'test_done'.

Thanks,
-Stolee


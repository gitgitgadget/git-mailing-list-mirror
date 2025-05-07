Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11313D521
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581104; cv=none; b=dTrsYYyfzkzrMTQwAqzHtVsaUwYBBmsd0tf5Pmnvtd10u10iC5odJ4ylLPkmAOygONMowmy6otbOVf5WpAEF5ymdaVp0d/9HPN6gBYb+/8oLkTJm+BLb/KP+fB73hh4aYqWvp7bBY59sNPY5ZwTzF6reotOdIelDPg3cGRVm6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581104; c=relaxed/simple;
	bh=BTZWC1O3p23KUD9kFXahiXU/a0BsOYLTN4iLQotvqCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MAQwaiCevRFr/cH+Tn7dMonfybaRqKzzr9mgg8D+KKC9OskZZ/zNHx7dGGlAtYDLHidhRuw9dsv6uSizpGxrNvXK7eCzivKQvxv0KBQD3vmdjpVeTmoYq52P1tD68igq3ERUcbMIjZEbgyv7nIQZxwLf1aLPMcnHbu7JjIwWLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+nD3JWW; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+nD3JWW"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso5851060276.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746581101; x=1747185901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZcPa2/MOaImrmnfaA1yNKRnLCtf8bm62HzFNkyxcaE=;
        b=a+nD3JWW7f5oHDaH0O1wugkHJeMYGM5/GHi/LAHhMGbbT9Cq33uzAJ07Y2Ka8edJQq
         qsN9smHW2a/MvIbvVhNPerMllO7ZUXzOgX4aU+W4mMIXknWtMPsxo7aUMFxmLGipn47R
         mBf/KqqcwU8sS5K/G2g/YjB+Z3fGb1ERQ9GeQaX+ChNLA0az9BzI8RW/KjfcyhM3VUsU
         R+QpOU3SSuKXkAy//0ERu1InnRxGOLFkPb/bRVTNHD+g+cvyvIJP0NnWQBcOWVtVX5Q0
         LPhar7usvIDvkQ54aMPmwh0PEgQ73Pw6sFGaDnyKEmnIw2Uk6Na7IMf4gVR9CORBp24d
         OGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581101; x=1747185901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZcPa2/MOaImrmnfaA1yNKRnLCtf8bm62HzFNkyxcaE=;
        b=T6ZU8WUnCnQi3pAYc0iorO9d3J1n7hhfWYly/6yNspyhqSUaoc36H/ryai7YScUPww
         OJczyOlgi+ebRjykkQ4/bTfPlCCDe4mhxnYqD2fkTrmbANIaHdpUaZMIu4K5dW9KTCtQ
         GFnup6XuXBRZAv+U1iG6iXxwkfYyW4MlpBKHFdtw7pJFj6ccLUKErU5My2T3DebQyic2
         XOtSt3UgKgWm4R0DXrmBzbnM8xiLyapxewkKaUyocS2xNIEdQoDeIfIm04dNfRLTIBCG
         eBhn9Ii4FMKVSyanNdlOvgs25iyguPnQ1LFVbV9LYcffmQoLM54do0oJQyHcYus8n1jw
         Wjjw==
X-Forwarded-Encrypted: i=1; AJvYcCUPMKo6lirV19D/BvRftWsc1QMEOJgApBfGohKXGUwOhlPL/6zEwRQ1yATbF4dR2YZ/PxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yP4Owx3bVzC1g0qffnk/mbTREaF0nJyVejYtIbRMPNF9CThv
	41sRhj/lF2BxofelPu8RCbJytdukUtMzcGRvYmW0eqaya9MfTrkT
X-Gm-Gg: ASbGnctunh7Bh9wWvm6xa4GKpeLsWRJRQAhDebR5XWVz2lBYb6j2tXidE4JGf2mUpw/
	PfAeCR0Dx5WTk5DejEqcxTgOmXyjZlPcWCylinTe0quaJqLGexpzUK5YEOpMpZ2w7X+RbWWwQc4
	LgQydr+L3Slji4Tgni+DxkBbJ2vzSzZB/dMGENd4tb06x1lFzSXPbE5/uPBW8imD1sgLmY9K0wv
	/8i59QydIvmeduzYfHQT2SRoVMzBZDluxUSJdh2B0iwgMmuh9YGmprdzSnlr4r9VtmW55rq72Lv
	kUDF9OkjA/e1QrtGWoQbIw8DwSrV2MzK5m4Oss1fw+7mFecVMOkCzSgRzWW52N2nztDYYaHqef/
	1mGO83v1sv/nDN9v5QzVtj1w4FDOO
X-Google-Smtp-Source: AGHT+IGzaSmCqhx8tLOwW4V64g4ORAUBUPGUESkZ+crN0+yvwZ4l4C9ZXi3TUNIp4aURRHZlft6ziQ==
X-Received: by 2002:a05:6902:154b:b0:e73:2c64:5666 with SMTP id 3f1490d57ef6-e7881931b6dmr1945864276.35.1746581101595;
        Tue, 06 May 2025 18:25:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e755e716696sm2725059276.31.2025.05.06.18.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:25:01 -0700 (PDT)
Message-ID: <a715e7c7-20a7-4a2f-95e3-28d4d4bc8995@gmail.com>
Date: Tue, 6 May 2025 21:25:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] odb: get rid of `the_repository` when handling
 submodule backends
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-11-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-11-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> The "--recursive" flag for git-grep(1) allows users to grep for a string
> across submodule boundaries. To make this work we add each submodule's
> object backend to our own object database so that the objects can be
> accessed directly.


> +static int register_all_submodule_backends(struct object_database *odb)
> +{
> +	int ret = odb->submodule_backend_paths.nr;
> +
> +	for (size_t i = 0; i < odb->submodule_backend_paths.nr; i++)
> +		odb_add_to_alternates_memory(odb,
> +					     odb->submodule_backend_paths.items[i].string);
> +	if (ret) {
> +		string_list_clear(&odb->submodule_backend_paths, 0);
> +		trace2_data_intmax("submodule", odb->repo,
> +				   "register_all_submodule_backends/registered", ret);
> +		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
> +			BUG("register_all_submodule_backends() called");

Did you plan to create a test around this test variable?

Thanks,
-Stolee


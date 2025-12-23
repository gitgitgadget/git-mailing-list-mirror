Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A52337B81
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487519; cv=none; b=Wbm5fSxs3wdM4q5vx4NIULH+aYP4+2D7tztfT53oUv8l0BxUnS3lGwbFglZul5AcpfxoZt2rjDlyDLZ63ubpffGrQscSN4Bl68+uqBgSG48D06ztFmzdcHSF3aOzLggjsLEIJbdPsa9d9C+mcxrpHWfvSL93Q58AJ2IIr5Dl7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487519; c=relaxed/simple;
	bh=Q62GjBDw9VCnt09pcLzdDH2jK3gPb1o4Ho7rYFaRhUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FITgsDxZVhaHvx8dNgmA2zA4kTwZZaB9UEEc5V2W6XsU7g4LEYjjZoOI6VHd+glJM+htG4jDrYpBnbWRaXtMpPrznZiNGAB2+SKVVc90n+tmXNF7rTXrHz9hZF53TAwnVpL1Hzlw8ZrPQbXV0hrKWWJEOnWB6Fb/MlVNy9mtTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moswlAAU; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moswlAAU"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so38673295e9.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766487516; x=1767092316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g9tUrDZXYftK3lPaCziV5L6N9F56A2A4/l3ZUFdvUds=;
        b=moswlAAUWeApYPW/adH3BiY8KYOfBsJdqwevI/oE0zfoOKbGoAh6E4F4LnnmEgc7yl
         NBzKry3HXOltQWOCeH2e1ok9z9JKRq2E3Fg/EcJum3rizMTEuylkCVYv0oB1U3xlJdrX
         pO3yptEIYeQdv6grHntIOjZovjlJmqF0aw0zKsVVoDQOpgjh6DgLUFbQP8sd6PY9h2Ci
         HnN7G596P+yN9VouUdApVX8ZLZ3aLrCSgM/DRLFltceJm2HHGKhvOtHhWTacV7if28sV
         NRlgfFxexALltmxLFNi7Q4zG/BCzDzVRxIuES2dy+Zf4lgwBlpNKIKu6uR/WNZfohQsM
         YyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487516; x=1767092316;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9tUrDZXYftK3lPaCziV5L6N9F56A2A4/l3ZUFdvUds=;
        b=LZJcEhgFcZwRU8m4+YtYjV8DGED2Ys4PV4Gb9YHnnGmR6CEdNCOz1e7adUeVvcK+lO
         Bqif6REMKDDPmFME+IRxXbCUv42cGbWOODz1h9EoliCp7HPUxjH5Yw/k3BacCvv1eMOw
         hLMbYXvapx7/X0vmkHCPP7lXuCLnax1Si7StXLRd46QuvuxLtvNuPWktSBMEnU6sa8Nz
         t+wXZvcFMBAhSbgrNDp1nevgGcuFes0KUovjEt+JID+od8k2MK5mMWiIB54d+RLDnSCU
         oYwx+4RKUvsDmgRZoONfmGHVFM9SNvCCXM6GRtIVVjD3iaUwCFVsldXf//3xo+ulzmMK
         KLcw==
X-Forwarded-Encrypted: i=1; AJvYcCVjUkmTydVe543JGgbvbqGgmfvv+nvYxfDEOb4lKo2IdmXW+iX2LY+JFNt13egKcx6rMfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPA9ssJwBsmgiBAngzB1N8rwom+s0qp7UKflqybmESg1bHRFQ
	dt6qSBbTmcwBKoI/cnX8ltLRxzq26HUa1ZsMRCz27cFvPwnsrcxrhWsBrusAluqL
X-Gm-Gg: AY/fxX4U38MkNbLKfOWclaLugKOl44LuJ8HSArBoogHcEqsiypfu4JGyLRRK+Ex3AQa
	kkRkg7XUpqMU2sXZveZzwOh5CO1KtQdHbypOE8vtoqs4Wnr+MyBZPqyY5lLlt2bUk88hfnyiRjw
	3Pupjd8h2EQvYUWCVeCVsi4R3Zl+Ac+Eg2Bdod+cD0to3CHsqQBA9/ofD+MhWlKzypyp6bemn3+
	1cbVg/ymsRANsGlfa3BUwZf3UYd/bqSSRPtv49rCK3dy1XD1GXVELJhyP9NZkuSt2ynFeGvvXa3
	G3BTPywJK41C8DhV68ybCXeKiVaGaLKaQLL5Y72N+fEkapNAC4eB0+S2+NGjvmP3iwLcNwzQ7Bb
	NKBulkY8rBNG4dxQLxwT2Z13odYpPEv+QmjbNjvJumdWfaauSuKIuXjDJf3vH5bRiGSkgvnkk6A
	FVGXWU50/4n6NX89Ctd4rQnu0OXinc2dbOfKw16r3cwcBGkq9tm6ezEm9koqsGhwaDWw==
X-Google-Smtp-Source: AGHT+IEyl1sD1Z6XRIbFwfHCYLEfQxxxMEiKRDvjMscVpq7XerP7zbBzsBr4sbY1lKBWPYNsXJiWsg==
X-Received: by 2002:a05:600c:1550:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47d1958af3dmr136249205e9.24.1766487515804;
        Tue, 23 Dec 2025 02:58:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm274819855e9.9.2025.12.23.02.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:58:35 -0800 (PST)
Message-ID: <65d19cff-33cd-4209-af3d-6a518254019a@gmail.com>
Date: Tue, 23 Dec 2025 10:58:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] t3650: add more regression tests for failure
 conditions
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com,
 newren@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>
References: <CV_replay_die_descr.13f@msgid.xyz>
 <replay_regression_tests.141@msgid.xyz>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <replay_regression_tests.141@msgid.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/12/2025 22:04, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> There isn’t much test coverage for basic failure conditions. Let’s add
> a few more since these are simple to write and remove if they become
> obsolete.

Sounds like a good idea

>   
> +test_expect_success 'option --onto or --advance is mandatory' '
> +	cat >expect <<-\EOF &&
> +	error: option --onto or --advance is mandatory
> +	EOF
> +	# First line is the error; rest is Usage
> +	test_must_fail git replay topic1..topic2 >&1 2>&1 |
> +		head -1 >actual &&

Using a pipe means we lose the return value of test_must_fail here so 
the test wont fail if the command succeeds. Everything else looks good

Thanks

Phillip

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'no base or negative ref gives no-replaying down to root error' '
> +	cat >expect <<-\EOF &&
> +	fatal: replaying down to root commit is not supported yet!
> +	EOF
> +	test_must_fail git replay --onto=topic1 topic2 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'options --advance and --contained cannot be used together' '
> +	cat >expect <<-EOF &&
> +	fatal: options ${SQ}--advance${SQ} and ${SQ}--contained${SQ} cannot be used together
> +	EOF
> +	test_must_fail git replay --advance=main --contained \
> +		topic1..topic2 2>actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'using replay to rebase two branches, one on top of other' '
>   	git replay --onto main topic1..topic2 >result &&
>   


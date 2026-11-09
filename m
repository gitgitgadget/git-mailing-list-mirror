Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231137;
	b=I0FVekn9kG0L65MXa7fhFa8MIjB99H5ALlQcpjyR1RNAKlpqXZeKfQGjDOi9WpNn2gaC
	 AhhuNJg2Y1d/N0VGwm4O/vahR2brdsy2xiacKsh8JGODOlGUEMpt2X7bDoWeujwiSTugy
	 lC11ouZvUGrVJdR2UjnyEhaAA1/Bq0SB3FcvAk40JA7VVgVr7lr9ciIv6xwefJIrrzpHD
	 Z0h5IZGpO+VdjgZ3vPI8MpX7LDwd7SeCMVBYAy3NlXarcjctToxxfN9dYz2O1swMDMyRw
	 9XaYvR6UZTalhwXQ8rGCOElqcPeu0Ljbex4H7uMuS/3PLFrxvRJyxTjPriL81xr3M/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0/y2H+a4oHfbp2FPS2uP2H/FLcdgIG5xdLFtJweQBzM=;
	b=Cv0ozaq24sryJs5n/Z3EDUnFdEqR2oHpFry+rV5buV1+n2NBrPEha2xrMKGtaSZizXFF
	 /mh51cwWsTMkjK6JBX8ueNPBHPOcIekFZ72gWbDkBBmMcxsQbU3vNnzCNNMm7cpnsISqk
	 NljTnw99ywjnp0oE3RciQu4mpmaXSlvZwpvqvWyNxQ38DBtZOJSwNGQ2C/JwlHRVCtJH6
	 053gO8Q/rM18GqDxvnjKguJzvh7CVBde20sSa3aiHKJ4C2lVXIeESxUbC24lbFgbcgkT+
	 eILNX6aZ3XwcMoQEZuYJhe0ie6HS805E+qXCG1JhHJhKHS94PQrWu96Hw9qA36G/LuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sxh68Ssg;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E66606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sxh68Ssg
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93ece7a73b9so96822685a.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231135; x=1794835935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/y2H+a4oHfbp2FPS2uP2H/FLcdgIG5xdLFtJweQBzM=;
        b=Sxh68SsghRM2sTKDr7GMq/lNhKwOE3/nRy0n/s5nFYha/cByBnE0MFwebuJVkupyq/
         LWnFXQhx/3n+1xsPwVaibjtvZNWbr1VY2evNOew22kOO/zwwgbsAwASLAutGjVUf4WuR
         dH6Zrv+P5rlP8+loNT+lCOYH0WOmG43h1JcCNXNRPONKdhG8rKjzN2ZTrYeR6tcag3vb
         jUfX95OVSfK8L5ZKvkUXrZst8sLxBoDSdoqcwCxFvmbP5JiTKGlV+fDSpeDBS+IX7bhp
         xIlcZKN2REWfTPGIX8qDow0YYCMGd8J7o38rdxd5rLsj40rkaak8zh2aC/ZbOwtvpW8t
         1ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231135; x=1794835935;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/y2H+a4oHfbp2FPS2uP2H/FLcdgIG5xdLFtJweQBzM=;
        b=q+mVfw+RoEM+G6O0SmsCAyOdp/Og9eFqaZKhYi5I0pe0+EXPbaAJRP4QciCj88O9ew
         gLi0M0RhWiSEr3k8uNocUzyCaJuZEFZJm/zvl5RhCvSTNs0j7dQ3nS2qqPwvfs+G140p
         BM1UTJu0jUOq0wtzV42VL6cTSRnkhnBg76MyfA9lcMksOh2jAhK+OyRZ42k7Ua/q5Fb8
         KxX7ER8hHfxp2FAKFDDgAVcnDnHbDEBqo7WAWL8VjwzCJWM8lw8tgoznNxVGVsJcQjgl
         CSUZalJS9WiPQYrcAiFxZEzVB0hsDPoSS+gwle6M4JpRvwqeK/dNnli3/KJT0VuX11CI
         S8pg==
X-Forwarded-Encrypted: i=1; AL+hErH5+ioxQd8pTq6n+VMoVkurNOKAmYtdWzVN5gBSKUlC4CDPkRNc9pSLg2gbKkddLSEeuUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+950xUgGduvY6AXxi8bmYO+JEjdbsAjQstvrhMxNXxurtCBG0F
	BrWZUvq+wejOENIMalEeQKeBAXGqRvO3I2Mt9cAEvcIp/IDuhlQE7MsQ
X-Gm-Gg: AYBFou3zvIYcwZdmevmTfpcIR5d07Qr0Be9SSwcjOGSEzNi98wtWgOhqj1suITCi6U0
	GV4f5Jl7yMMo7irOhTFh1ru+/FBiKbV5o4DfD5iYQ1zP+aR5dlvxfqIsWveEdT0MRssvTPgm5BA
	kqOwFCvWqgDs1Lb89Au9FMAdg86X2UYMvwi4B9lJV5LvjFTNM9rftpsyi1Ij93u177CHKJbkty0
	g82ADwTgk5Ggq1Iorxgsk3w+NoHix/G8LWVuA0KNKlFW2sPR5g9xBLuM4tg4SbZgZL8RaJIO2pb
	9D+RI85quK9gxeJckAmo+f4DqLcIcy6mTmUNHSVarrmj4EL5Wdt0OiXAgCGtLbe9pZWioxSBcIV
	CRdLlTDd+Gsi7knT5j1Pa062YZRhur9Q055ymSZoSbwO7XmMpkXbcFyi77dMhg8UglFYrfP0PMf
	N3E0lwOrAJq9jP54WAh5uV2lTeqocjDKcYn8k1VtbqrWmaPqMDpkZwmjVSexOooSXaCzBsemt9g
	RRDl9aNHcNEv2m/wJz0uv+4fx6rKIai3gt+hWCkfyaFTr/gt8bbSWZ9/NU1OgotkGT0MmfuU038
	EMQuQo0kTt+JzqJWMijf5uBiMToim4DbcnNdj9aREHEjczlgXfgSrcY6M6m404IneuXRxmeOKVa
	xopYXpQFsicl5BZb8IF2h8hyQEgNLIohgPiBLS6edyO4Bb4yrFpwPodZetEh6vBBlwh3soToCBD
	tWL7bTzBgHp1/JTjs17r7b7HAfs0fm/BzgaaUaLoVxMHY50AWa/IrOag==
X-Received: by 2002:a05:620a:4612:b0:945:fe1c:82bf with SMTP id af79cd13be357-94784281ffemr675711785a.61.1794231135003;
        Mon, 09 Nov 2026 05:32:15 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782dacc94sm472021785a.29.2026.11.09.05.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:32:14 -0800 (PST)
Message-ID: <a595120a-c0d1-4618-b180-886d96aded8b@gmail.com>
Date: Mon, 9 Nov 2026 08:32:13 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] scalar: handle NULL value for scalar.repo
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
 Colin Hinton <colinlewishinton@gmail.com>, Matt Hunter <m@lfurio.us>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <b4bcaf19ecbf0fc0e165f098c00dccf42985fdd9.1794040968.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <b4bcaf19ecbf0fc0e165f098c00dccf42985fdd9.1794040968.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2026 3:42 AM, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> A scalar.repo without a value makes "scalar reconfigure --all"
> segfault: get_scalar_repos() passes the NULL value to
> string_list_append(), which copies it with xstrdup().
> 
> Reject a missing value with config_error_nonbool(). This cannot break
> a working setup, as "scalar register" always writes scalar.repo with
> a path.

> -	if (!strcmp(key, "scalar.repo"))
> +	if (!strcmp(key, "scalar.repo")) {
> +		if (!value)
> +			return config_error_nonbool(key);
>  		string_list_append(list, value);
> +	}

I had to look up the definition of 'config_error_nonbool' to
be sure that this was the right method to call, but it is:

/*
 * Call this to report error for your variable that should not
 * get a boolean value (i.e. "[my] var" means "true").
 */
#undef config_error_nonbool
int config_error_nonbool(const char *var)
{
	return error(_("missing value for '%s'"), var);
}


> +test_expect_success '`reconfigure -a` rejects scalar.repo without a value' '
> +	test_must_fail scalar -c scalar.repo reconfigure -a 2>err &&
> +	test_grep "missing value for .scalar.repo." err
> +'
Thank you for testing.

-Stolee

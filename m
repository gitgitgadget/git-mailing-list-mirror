Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007790;
	b=nNcJGSIuncFJsYsKr5vcOdLNtjE3x58MM/kyuTkwWza8AcxFGzBBqfDSRFi8CKOOHnqz
	 NTXTcSbqXjiwpQDoBKMQXcWzO5tB1HHyxPue1fBabhaCQNXzwX6rFzwQBMBVlkkviPJJy
	 wOc5QGvolwYyiAjMV4GiApviKQf6DT/IhhrYbzI1Fe/+GB1xfjtkPehetp0HufBqfQWfY
	 87wzj8blcrt3bYnZ7ja9/g950U49dj8PHqx60ktctX3vUKNq74yD4L/QPEuBz0ATGHat7
	 Oap66f5R5jPf64apaIgKKeacTvNB/0NBbXcDhAlqWQbce/vaP0NDsuHUClpD1sAJZ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TwzvTQBZ3iRmYR4nSL+d5hZG9/B6SV8f2yZkBwbDR20=;
	b=eh+Q1ONx+iXds5cMumXBMpK0bHj1REH/ldpQBpz8sqj7zeVGkmMVU9gcHRq79Se//TZu
	 8nIqz78nBLNwf9o6Jf+BgjYExOTByvhsxRB034sPAttisHj6upKUaka0tDkJfZYeg4Sb/
	 FVDEHZWrwoIwZTBlEMRPT+ndYReag9TdZLm8ILZ32ZLm4m9C85+8X1/RFrhnzMfRRhOru
	 CWTMNXBNkyWvqFwC9WF4e8DOX2bh+BQ1adki5w/tr8LSWjgcZ6UnojFDLs98n7OSSOn2J
	 8bvseWmeON9GvrlJWGM4CasjjC062B7DYmt76rjXgIz0mZV84oZKjuAEWyWH5IYvvDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oe4nIPZ6;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FC606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 756FC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oe4nIPZ6
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso1596236f8f.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793007789; x=1793612589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TwzvTQBZ3iRmYR4nSL+d5hZG9/B6SV8f2yZkBwbDR20=;
        b=oe4nIPZ6gqG04UiC5w8MFsxogfdqH3T2WGHcmpk89JObT6Fnp2st2GXHpKFYJzNmfq
         ynmGmAOjQs0aWg5U/ir3wtE80bDcH2yXbSEV/ogBpKPXC/CYu4xJaX2txtqg7VYTe61x
         D85TlyWVfnHL4TSzCXV1reB0Fm+fUUlnK3ea+qUSjQhzxpqGIj67Bb9drs2qp9QbvVfD
         yQ648M7vbSBzr47du42idbG5mzVXRwOrzHoUyQ6FlJiAh38p1MmJq5/78nz9YpkzEk1S
         Ghq6MHHtIO9Q4G9Ek2WtGmcYxjuUak9wXfMoUpHzXdfVgax/CxO1+Wmuil22tHetEaTg
         hqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007789; x=1793612589;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TwzvTQBZ3iRmYR4nSL+d5hZG9/B6SV8f2yZkBwbDR20=;
        b=pER1igWiFPWZycjy7Ui7RQGKUoHGWYF14zgfVFtTYHg8t2WKROnBHKKDhka/1M2e5g
         039gimszCEuTM6seYd6XV+ikA04NvFxunOB73ePk64j3bhUKR7gXudDeqMsXMqbI1XL8
         Bhqkeh9qGRWBwHR0aLi64DAMd71xiNKaoDQFcS78wMvEiSBEME2IMw1PlMnRw8HXJHtn
         ku0HAFU/6fV/a7Y2REn86+PJidLg0GTZdjfpZGkAe9ubn09ERE65IQkGPOPwlGLLwBhq
         Au+Lvjrni1gxU69l2RS5k2brdPa/XzeouoMf1ix7W+PXFXzBKdcglHLWke4niJOugTw9
         1Qww==
X-Forwarded-Encrypted: i=1; AKwUvBz07JPQQcHo2BpoCZUV2gTYlsJ7fuFmGqQ1VAXx3nds+A2LKiP3ema6OvLsCzdYQSiY0lo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLR2Zu9Yf0xqAoB1dJnmdGKyzKh7401eK9GuPqL+Dg7j3WjFp4l
	Dt+5dR/YsyqCTq3DIjzLdT51/SVoDUG2wsr5VlJB5+skGNNR+ICCZkvc
X-Gm-Gg: AYBFou2Y+/dP/KkHpC9OsrsEs77xrhm2eBWUBvYabyzJfhmGb5LylUeSWmxw6puMn0q
	WDABfDolO7M2a7YovF6i5tIyLdnU1opXqkGZak/yK6NObKYroa8YZGLN8B59+NCDRca/mhQGVbD
	2ZO/vGkU5dZm/vFBckYh7pquZw15EKNQfTX9rEUETxpIp7aKFJKHpQ2YxpxIq65iNoHzr657TI0
	EBROO1IuVJ5dSbuCg70xBKWo3q0hQgOWzVFXlYc52zw2xf1zmGRQrIGluvZ2L3oab9A0Ef97sIN
	HIzXsYAICn3b2HJLGFqpS21BQGpM86AOVcpcma40mEbHPePhmbikN8Vy4fibiYh7NQ/Yzs9xZU5
	2OsOhlXsVdZm1RBO/s3bL9YAM+ioPjZVSXUnpru8SLcppwkYRj1ZJG1jsazWkF8vkrpDQ7u3ZD6
	kW4jFo8tlHW8V8DlrV4QSVJVKXAynTUEcoeDTjU0uZ/TTQiOiLoG5ELUgK+IfM+XHTO48eBwd6e
	wMVoEr1QblexU9T5AQV/fcp2sceZchPg97FRlvdJpZHUrlhY5vW1Y77QBo+XsDiAWWjlwmW4A2p
	3qTjlWC/5GiXhlNOO4qAFdlK/mue7Z4JF7D/B3ugpzxNFJ3jtI5o6Ls=
X-Received: by 2002:a05:6000:4809:b0:488:7787:469d with SMTP id ffacd0b85a97d-48e3eb8ea2emr11315002f8f.25.1793007788616;
        Mon, 26 Oct 2026 02:43:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm15005024f8f.4.2026.10.26.02.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:43:08 -0700 (PDT)
Message-ID: <101723fc-d392-4000-b224-345c610b2aaa@gmail.com>
Date: Mon, 26 Oct 2026 09:43:07 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 0/5] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
 <xmqqcxt02eoa.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqcxt02eoa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2026 00:13, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> This topic seeems fairly well done, without seeing any additional
> comments in the last two rounds, but I am highly disturbed that I
> was practically the only person who reviewd its later iterations.
> Because I am not a target audience of the feature, I would not be
> surprised if I am missing something large.
> 
> I would very much appreciate if somebody else can give the series
> one more read and Ack them, so that we can move it forward.

I've just read through the commit messages and documentation changes and 
I think it is a mistake to use a single config variable to configure 
where fetched refs are stored and which refs are fetched. The problem 
this series tries to solve is that the default refspec fetches all the 
branches from the remote and it's not possible to use that mapping and 
also restrict which branches are fetched. To fix that it introduces a 
new config setting to configure where the refs are stored which is good, 
but it then uses the presence of that setting to implicitly configure 
the default set of refs to fetch. To me that repeats the mistake of the 
existing fetch config.

It would be much more flexible if we had a separate config setting 
(maybe remote.<name>.fetchRefs) to describe which refs are fetched. That 
setting could accept something like "*@{upstream}" to "mean fetch the 
upstream branches of my local branches that live on this remote" which 
would cover what this series wants. I think it would be useful to 
support "+" and "^" prefixes on the refs to fetch as well, so that the 
refmap config controls the mapping and the "what to fetch" config 
handles negation and forced updates on a per-ref basis.

Setting

     remote.<name>.fetchRefmap refs/heads/*:refs/remotes/<name>/*
     remote.<name>.fetchRefs +refs/heads/*

would be equivalent to

     remote.<name>.fetch +refs/heads/*:refs/remotes/<name>/*

Ideally when we're seeing which refs to fetch we'd use the last entry 
that matches so that

    remote.<name>.fetchRefs +refs/head/*
    remote.<name>.fetchRefs refs/heads/master

would refuse non-fast-forward updates for master. Currently we use the 
first refspec we find that matches which goes against the usual "last 
one wins" behavior for config settings and makes it impossible to add 
per-branch refspecs with "git config" because the default setting comes 
first in the config file and matches all branches.

Thanks

Phillip


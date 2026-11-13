Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581852;
	b=cuJqgoMEA7hPQXxUj+o9e+YqzJT+psL6o5r6wQag06+9EwuvZCkyrseUKEZZwRH0mHBl
	 JAEXIkwyJFlv+gyJHTC5aQPLVVReHThM+AE+DuCXpIOfK1nh84ZJRdS6+OqCK5/czh971
	 +uJQZSmTUh1GqftfGM3iR66S/HS0npITQ3kbvoYKqzFb66uXvV40xJNPGu844V9MJzEfN
	 S3HtHV02gW8sXcqxSNAgRXd5ojAZHK5roQRJzy3iUbXAufsry8JZSS63mZqKBWYRwo6kC
	 JbFCZH4OJTfl85sKmUVc1kOJUTK1bx6w+R0EEVatwHagojgfJovAeB2TrLubnitfEJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3YwBChVO2EOyBgmJE2dFTwKFg32qG3NNncsK1tVZML8=;
	b=vPoxHTbk8ePFdYV2ym/t+I7WHFATDRNRUI0FdwpIWJklumEznNbQ5KZXjooKR+M4t2FW
	 uJkDsPQVFjVlf1hVHExF7JqHjEnoCsPC3bAonPzxrQu8NSYX/DYPSnE42qyROu93/ns5+
	 XwsiJsjUl9X2zf8BOEkGqIvr8YpNaJz6MQCgvNIPocDbLxZD1ILYfTWJwsNwqR8nniJOp
	 ya6Xz4i2TkOAQ7GAlq5seh3AuQOUgosF3Mv4TlKsOxPkcUMvNAU9ljA0Bf3X40V+c7QIx
	 Co74U7tVeFAT6eOLgoz7qVGde28ZdKdHR6NqzptHTI7rToxNpuFIUKIaPfHtV6hp5qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uV1QhzHC;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D58606A333
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D58606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uV1QhzHC
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67be6030c9fso664776d50.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794581851; x=1795186651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YwBChVO2EOyBgmJE2dFTwKFg32qG3NNncsK1tVZML8=;
        b=uV1QhzHC0aLCQiw2lgSwxoJhKrYSCSxUO65Q8DtkjbUWQOkvglEdEabN7DHG/y9UHF
         NmWD0xjdE/Qmx0F9+Ma8b04AVMFeF3Poq716b/OKka8UhKCTBTWUFgvEGEbX5Pefr+sI
         Li/mgKIEB3TgRB9TbAvW5Fd76a8j91P3xexcC4Rql/M3nDhmtVwfwozpgw7tt4lgQbPe
         GjTea0CVKG/36jxpaC3G0P88u7KAL5QB1bSQCj5p5ejMdY+kwDpLkWccAIV11me+qTE+
         OXAdxi6Q7kBRmKLlmAnMVEuojXX8lBEfCeF+p4jJ7nINQ+H8fMsdmOwBXp4lhRyFF1kA
         MrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794581851; x=1795186651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3YwBChVO2EOyBgmJE2dFTwKFg32qG3NNncsK1tVZML8=;
        b=mXrbCeUxQ965LwAnC/0vxY7nWJecnJWPJme74njf49ABvJFCzrZGhPYV8VKOhB7uIJ
         VMA2JaLjCsyK0QlW9H4lJtoy9d5FjkNKsDz4GUdAkb7+FokHMVBhoFTetdC4YLB4ymsy
         fVSKOdmEojNDDpELpEhBsSO1mLrMckzQfy3ZFDZXC7Wjv2DVkU5t7AqEE+fJeqSzc6ds
         sJyFnJHOGm/wm/2jEri6tCcIu7/OKq4KWbmS068VTJVyHCbSNbHanFRcZ6fZZySnf8/V
         7OaXjGq/yguLf1EUEvRIiEuxqKH4kWbv5ne6cqx/7E+ybc/8bcPzb6Dq/sKjoohrtFa8
         2ciA==
X-Forwarded-Encrypted: i=1; AL+hErEHls//HW90mPBoy0d33E3Bjujvx9mwWVwNrJWgAN/cv1GkkWDayp9JNDqDocVBcf3Whbo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/g1GPBkkLluchCJq2jQDsJx2owV313EVcIvHM36aGHks/Yas9U
	I6PlM+A7eYu4x2F7YwPrx6ggNoOW6eZUXBAG4+vvxOA/Su+qkyI1J1Ep
X-Gm-Gg: AYBFou2bx3R7QeSVfhUZtRAYobgO76adMP+FsHTOS0kYjSFhPxzWUEN7ahYD179woCN
	BEJ5cfAmiBnqa+wM3O7N4I9eJvdHui1SIPciDaZ4y5MlFdFHYnjMXU+tLWh5EkVUIzzKVqcx0B0
	JrU4gAAjkEKcGbmasXx+Pys53IaG3OrvprVVzCcVSQPJi8asWKz7EMXkoc4uawXxnbW2M+pZCMZ
	e0ogyY6P2JcNlm6H/Uyz90nTA6uACxU4UGBpjdhko7T6vtFcaYxRoues/W6BQzK2Xn0+toHT19T
	7ctdKIYAC0dDcaoDUcpvsV6q9/5n/PQC4RBBDJin+/2Zdh5V/8lkHcUGl0y8x2EEFR8XTC8gObD
	lJ+og00IeXnpOEWAcH/nL6YTUCzMiYyvKPc5fAE+mB/j850d65PBLqXB0aFEzCX7VDbsCMaOfsz
	oenNLJmvz6I7/WAKMOA6t8VPghrwS6QDzKIksZhUsV4UZm594bTxGebMhdtG8L2qVqy4YMWSRcP
	n4JpbjNRorOK6wmzy+7GBBYpToE9k+1/1dvDAeQ4D1T/OXJUwEq41OMcMiAhRHzEbicUo7uUTur
	pWr94G/EtxuH64nq91Mlvs1f7qoaZM8BSw1+j1jaBLFd84DMi64nzQriMS+msHHfBeD/bHtDj2U
	hg+qABAz6CqwEPEBhBIL1xCmBb/TfDNUw7AmsRi4YEPPhm4NdNUjdltRu5jQADBSmRynsgdoPt9
	BhFQNIMCl324NYbGzxTwy9tOsAHlJMxakzuKf81cSfiF972h831jjrOkk=
X-Received: by 2002:a05:690e:1382:b0:67c:1b7b:aa12 with SMTP id 956f58d0204a3-67d8933deaemr1666854d50.7.1794581850752;
        Fri, 13 Nov 2026 06:57:30 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a4359absm2216836d50.1.2026.11.13.06.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 06:57:30 -0800 (PST)
Message-ID: <29490124-5020-42a1-978f-0f5283ba9e11@gmail.com>
Date: Fri, 13 Nov 2026 09:57:29 -0500
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
Subject: Re: [PATCH v2] commit: remove padding from struct commit
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
 <pull.2309.v2.git.1794576606249.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2309.v2.git.1794576606249.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/2026 8:30 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>

>  struct commit {
> +	/*
> +	 * Must be the first member, so that a "struct object *" can be
> +	 * cast to a "struct commit *".
> +	 */
>  	struct object object;

I think your comment is backwards: We cast a commit into an object
and it works. We can't cast an arbitrary object to a commit.

But maybe that direction _does_ happen if we check the object type
and see that it's actually a commit underneath.

> +
> +	/*
> +	 * Index into the commit-slab arrays: unique per in-core commit,
> +	 * and only meaningful within the current process.
> +	 */
> +	unsigned int index;
> +
> +	/*
> +	 * The committer date taken from the commit object, without any
> +	 * adjustment.
> +	 */
>  	timestamp_t date;
> +

Perhaps instead of "taken from the commit object" you could say
"as specified by the commit object" because we may actually load
the date from the commit-graph file instead of parsing a commit
object.

My comments are only nitpicks that _might_ improve the comments.
But they might not, so do what you will.

Thanks,
-Stolee


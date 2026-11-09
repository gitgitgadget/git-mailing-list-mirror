Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231590;
	b=t9e5TbcZaV4BOhwU6H6GzthoYOlDSVzLevZj9YBTpGQ0OdeZZfQRaF8YjMcLLOCjZIM1
	 wD2HzIj0+IuGK6Diao7E4IRJQ68Y2RDXBN3o90LeN/lZkwcwckNUzJzpwp6CwmXZkUaTQ
	 eN9M7pPUfe0OS8TL1D2xtkRhX7ln+sfAldig4UVPY047mqvbhW1suHY8cEsA1lEycTujZ
	 T5As5GcazL9rWiELoSCsdPgHyT2LNvoNEMkxwypjjg9S2aVVForPBu7uIkJzjxH8rqgXd
	 e9xyUbTVhgMvmNzToE0qDx/KuSY/inn5icC5ROR98SJ3OZOjhbaryTm5yLLGus2sr5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ws5CfHXnLxUMtF1lc+aeu2Yg3GfT33j3xpMWg/ddm1Y=;
	b=QBTMbKK/h66UGhi3DXfrUQLtnh9T1hqCwaWguabjrjxfAURLo89nqU7Fdw8KdLm4ACFu
	 GCwvQLY95zhWazarWN7RB/7ZJjNZxgZCii7TGXFLdysxAdXZKPgwOqZ2W/o6v0wMzOjc9
	 SzyhtNAA5JhlPHUktEoHaapkCJOCtm40LoX8CvlCnsoZfnv1WKsFR3oE0cRckLvKbBId/
	 LMIT21AXvQ+wH8XmLCdrkuk86fvAWjCfoARYt+7bx8YyrfF0tnttQrhJPir97gOSVRFbp
	 ex0skBQNWuouvvfzMKhS/AYpNSdBePavMRQNgu3Sl+D0btCU3yEp6bi7mak3Y3La/uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0j4nUxcc;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6A606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE6A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0j4nUxcc
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso8978966d6.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231588; x=1794836388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ws5CfHXnLxUMtF1lc+aeu2Yg3GfT33j3xpMWg/ddm1Y=;
        b=0j4nUxccUEMJE2Qzjmmlzs+AngrKQLIiskxcRhSpe+8yMjGcO/+4TfscL8T/ArbgTW
         9UaNs63iHsiPAao/h6JP8sdjVuUTFbOT8OIY38Xs6fkCREZdYmpoixBXSO3noOdas/EZ
         2H1S2wudtpvIZ078oxhHeAQIS8QGL5uzghDREXZC4MBJ1LibA1TF4yntqteMPoIoMF/Q
         YSrjnb4uWaooedZMotDzia3MWfJzFFrfGYqgwof+tzASjNvvteM2FJyA7CzZiEufnXv6
         hT6vAMq1efJ4iB3NJ7Tm0DNkTRiJYLnWEknnFX13XO1aNl8/3U4xjuAIgoil0B+ke9Kx
         eL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231588; x=1794836388;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ws5CfHXnLxUMtF1lc+aeu2Yg3GfT33j3xpMWg/ddm1Y=;
        b=oHTNb2DJPap1HxgiChEvbKPXRdjin/GK723ERfajWh7XhGcnF1l/+mvKrM6+uXSgIO
         J48Kg+WQipu0bXe7WPqhO6eOMWap4DAbU0JmNmyftqwfDxPiUQ643Af3gijMXPOlDrLm
         Pza9yMZjq1sz2vmW1nOeHsCP5Jy83FJG6xe2l4xXw1iFZYlQU8VIjMh6i5Pxg55NLS/+
         bErurS6ei8h3cHGI0D7Pt2iTrEE8SykmEjvRCX1NlQp7CqropX1GkM6mxK060TT2vq6T
         lAeHMm1HnNDI6VNCLgqMql68IMJJoXM8DDmboBzh4wG18yEforjVI5XuCunmz/ngzEza
         J1sw==
X-Forwarded-Encrypted: i=1; AL+hErHPbkv1I4HLHBxDCXecLMQVlCLag7fVD9l3ohYcQPCZv4dVOkYMsJwiP8ZxMiXnCM59eIU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g4Zt2YU0VN7EejMFFdOOASfK9dSbG52+j7YtihPhKjtomRUhp
	Peg8NSyEAx7g+92PqwOMhRKOWomUjidi/9Njzm4j43GBb8SN5l8WCn/G
X-Gm-Gg: AYBFou2CH6+bECa2AvLvtvnj/AuGFRf0oJ6DvcvdW+R/z8F9FfycWzQvOdBf5v1eXEI
	lsGlAb4axBzpUuVmmo/ev2Nop0Be1j10EIo5DDez32wZM6sYbDOK1b5mITYyRcVuWRsZt5i0lWk
	TeqjSs4ZSIUUeFvBuRpifW/5P1GVon1HlX/VtKdynGK6m2ji3IEnFAivobyGnxifTrhOXthN+VI
	tlGVjAFeE/KH1UltVJQadvj7bvv3cuIht5cp+WDsLrspO2iY2/Rk0075bGAStPvs1QmHYPrcAsa
	mUB5jIniS8swigKEl+QsIzdv001fCnqRPayKvosEGGnZrM1UX62chbXVTJzrMnY56+98rqQA8OX
	itVojbis2roh3pF6+ySIja78+NkQnWIvC8xHesQgHLLxBkOlRmpmnWeV6bGd6CQ+neuEFJSOjA9
	d0RJMmfpzxB5zYmIh8qv2kbUkcASEMP8Wmxd3I8mUf7GAN3/L9/hAvyPAejxrAUwU6FpuAKy+xW
	8PPGHza2vQN9q1TisldzlDvBAGAL2PLAgNGAEWXuRgojNPDhGDdWie+pPCzvTmcJqYOHgkfIg+T
	ENHRduLeNueEbOuF73bk1mQYZ6cR5jDT6iils1G7U2U+UH3J7DEok3fHmY32Nh3GaGxR9jfuMck
	c4/YXv4OwnlJpOoj6k1yU1RsMHeTDOs6zPDaDusFd2UZ03Rb8SdKNeugjUzecRkLPWU8uE/WeNg
	XqfD1pXRyBZyqWyHrLDd4RSn7LXTi8JMCqN/ZLVMuFqn7eB1ULewMNVg==
X-Received: by 2002:a05:620a:394c:b0:93f:633b:ee1f with SMTP id af79cd13be357-9478485d297mr603572085a.28.1794231588348;
        Mon, 09 Nov 2026 05:39:48 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782d649dbsm482918985a.10.2026.11.09.05.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:39:47 -0800 (PST)
Message-ID: <015c2692-0370-49d9-b055-d86301c8138e@gmail.com>
Date: Mon, 9 Nov 2026 08:39:45 -0500
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
Subject: Re: [PATCH 04/15] bundle-uri: handle NULL value for
 fetch.bundleCreationToken
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
 <4eb7085084b880f90705799d523ab554fd1cabd3.1794040968.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <4eb7085084b880f90705799d523ab554fd1cabd3.1794040968.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2026 3:42 AM, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> A fetch.bundleCreationToken without a value makes "git fetch" and
> "git clone --bundle-uri" segfault when the bundle list uses the
> creationToken heuristic: fetch_bundles_by_token() passes the NULL
> value to sscanf().
> 
> The function already treats a token that does not parse as 0, as if
> no bundles had been fetched before, so it downloads them and then
> stores the new token. Treat a missing value the same way.

I agree that this is the correct fallback.

> -		if (sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
> +		if (!creationTokenStr ||
> +		    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
>  			maxCreationToken = 0;

Good.
> +test_expect_success 'fetch treats fetch.bundleCreationToken without a value as 0' '
> +	test_when_finished "rm -rf token-without-value" &&
> +	cat >bundle-list <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = file://$(pwd)/clone-from/bundle-1.bundle
> +		creationToken = 1
> +	EOF

I looked at your patches out-of-order, and you have some later ones that
focus on this bundle list having bad values. However, the real test is
in the fetch:

> +	git clone --no-local clone-from token-without-value &&
> +	git -C token-without-value \
> +		-c fetch.bundleURI="file://$(pwd)/bundle-list" \
> +		-c fetch.bundleCreationToken fetch origin &&

Here, the local creation token is NULL and that causes the problem.

> +	test_cmp_config -C token-without-value 1 fetch.bundlecreationtoken
> +'
> +
Thanks,
-Stolee


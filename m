Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408451;
	b=Vp5zfkJvF/do/VeoyTV1RDcBm2srd3Kc/81AdMfDT6Owmh9yD/hgFapZU6Fgqf7EU5tF
	 BhV0Eh19VJuySPKlqf38ggv7W+i5MT8zhyMhexc0T525y7ViftEFsltgnZqoPVpI6x6gv
	 hkf6IFc5lzhgiFeeefeTyFuEQibGUO7E16Vlg8+edfkpc445OxqAHXBBf7axq0me8a8Ss
	 0QBQyHemOj356Q7yew7YCGdgc9s2JG7ubtGzmVSc/eM3X7/q0cQG1ZuUTQ+OQiB81oM64
	 2YSusxIxavwUsXMt115wNyNJarL5BUbTa1I4Qmalw+X932adkj/BVhf2HapJv9ZkFkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MLwOrVJ7NhlUoshhp894730nRIEDUa3Fn8uQyDL7wSQ=;
	b=0oUZkvP6nnwL6jwGAaykI6imJNxtM5YC/0QQWW/ari5Z/kuji7etRW+fhMqPa58ksj+Y
	 bh6Yo2HOWCxFR4brU8T+HWJlnZjE2IFgnslwV67S7MnbOufup1UWQGUr06coBspR6LrO/
	 vwNgyPkHzVIGiWlwf2uHVyy9l2WXkPzSo/IpFlkc/xX4MfgSiQDkPechteUtmVp1lW2Pj
	 C4GCbDLDaY++He2w+TWbfrhjkWfAVC8HXJU/mrYgnsYZOUjW3HfUakC3g2TBqGOrxwSdk
	 FH77gox9dku8J/ZBx4/vlQSN8gxFGnLkCtdPh/cE6eQB9KwQbOnxFrF+qok3zgcl08w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEQEdZRF;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE85606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE85606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEQEdZRF
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so1608149f8f.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408449; x=1795013249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MLwOrVJ7NhlUoshhp894730nRIEDUa3Fn8uQyDL7wSQ=;
        b=VEQEdZRFyj5j1los8WI968SEz4eDrTAKEbeuNtt3FQaElLwEBzOR2KW4/Np3L4Xebc
         18xEMwJd9pBnMcgkuXePUFjOfgJ1adiWgd9tfKyprQ6YT4fjFq/yCfi4cQqEBmSxSmIp
         2Fy6Ms4jQZjujIbiI46qWz1NvaUw4c3mjcMixs/Z7XwY+iTs/vMDNQDwV4MqWm5zO7BV
         jHy81pNe2tFyqwMLfgjQ1Xyi+QAVR8y88ZjUlXcfqLXGheqThP1QJU89wftmuagek6+K
         6hXIJwX2nY+bqG9zwCQwFfrxUxtGi0SY7ukb4dmPJpBucm1DP/buh5Lq2hpYN8+r8DT2
         PLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408449; x=1795013249;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLwOrVJ7NhlUoshhp894730nRIEDUa3Fn8uQyDL7wSQ=;
        b=QO7aMbnWhn22A0JAQPvfS7rT8fEwWONMhfNzwLWAYP7k5OHpmcw6BlAyjkhjRYYnCJ
         /dxBmMmsCHcS/39x4kYgsuAi1dLrMFpFEOM6DzaoKb/9GHZPqxeOQbeCD9GCFuKbC0eV
         kDbVy9yVchbZQHIrtSv+rSc2BYjFEg6voLWWkZLDd3sWjLqFJE1MF/pz+ODL78HNSHRA
         TaAt/ptyWDrBCBhewuSQSwn8Htc4oibUwuh15xtlPCEo5eWgjB1bYDwWtF3Wfj9wqiVA
         ubxzw578LyVJFMGtjBrvd0t7H43/D9+N60gP1k6StbGanoM8iJ9/SbzHblti2Ro2nl3m
         B30w==
X-Forwarded-Encrypted: i=1; AL+hErG4Cutmt5LEhV/kJW5yB6cSiro0KztotctVzDBWB8R32Q4YbtS36ZD+tYoPyFaoUhvgHzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FEm25yBgf9ntFJfu1WfmbmVkbof/pkzCo6fOAGMx28NripyeI
	WAU6YpDOJKi16ZPL0o9Oqd+YRXERFcex8QXLdoQx2XML+k9n4RulnE1+
X-Gm-Gg: AYBFou2EC/mRMDGjMcsOLfRJO6p45udE3mtZUE2ONPbrLUK+WqfzU0Ma10oD2JeRIJV
	j2x1uIEz3DsrobZugACSquu9B11NfqO8U9yfhrrDAYUdL6NDX9UhKfURTKHSqlMX8S3PCJSeWXL
	iUHYa2E/wYwPT9VMVwcLg2yDSK24EjZxCeeGlCwN5bQgEqpEuafAlNtoohmO6yW1AQxo00887+d
	i3Bv9hDEK2TMT8SF3RVwYtBdCOko3QGfNiQvIMbIeCPW+Fr/Cbs8+FfqmLvk66d2ZGOQtz7yMWO
	LYvC+wqBy3fVjeDfW9/SK3zESpsWhukrWeAQn7yGsrghuwdm4DPVHI9wbUd3jb9jm9Slu5UP/cn
	pcKGZhDzP6Kzj1gxzOYm4GXA6maVUpCJWAuCPmY0HJQDStZMXvta6wAlsOF4jAHKkNdpAvZHQqS
	lss1fK+JCmtxyoH8ZaF2vY9kok6GJ6SlIs037qMoCUbjLcysXO32e1r3QT74zVO3cxrbryC8prT
	Vh75hQ9ptv+R/dh6z+vgxxb31Mi9aO9G2ti7wtKDxSluijw/QDChmCubpi2qh6HE8/K/PkUeukB
	bTU1c5TiUO0CHj50RcTmF7CNGxxiqniIwQmuml4LbIYs7Kc8+CjrnWf8hXU81SMhA8ZA52fa47V
	uqR5qb1U=
X-Received: by 2002:a05:6000:4912:b0:48e:4a8a:e17f with SMTP id ffacd0b85a97d-499c38bafdemr4272657f8f.4.1794408448899;
        Wed, 11 Nov 2026 06:47:28 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498363e0019sm11996769f8f.38.2026.11.11.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:47:28 -0800 (PST)
Message-ID: <b298dd66-49b8-4019-aecd-e6dfffa2f89c@gmail.com>
Date: Wed, 11 Nov 2026 14:47:26 +0000
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
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 08/15] merge: handle NULL value for
 branch.<name>.mergeOptions
To: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Colin Hinton <colinlewishinton@gmail.com>, Matt Hunter <m@lfurio.us>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <e10f1fc0ba4084584e11834ea98b8d8d8e353244.1794040968.git.gitgitgadget@gmail.com>
 <12def237-2d01-404f-b7aa-b4f19e033cdc@gmail.com> <xmqqcxsctyow.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcxsctyow.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2026 16:53, Junio C Hamano wrote:
> 
> Sorry but I do not understand this comment.
> 
> 	[branch "main"] mergeOptions =
> 
> is an explicit "there is no extra options when we make a merge".
> 
> 	[branch "main"] mergeOptions
> 
> is an attempt to set a configuration variable to boolean "true".

Oh, I'd forgotten we treat a missing value as "true" even for config 
settings that expect a non-boolen value.

> I am not sure if it helps users to pretend as if the latter were
> 
> 	[branch "main"] mergeOptions =
> 
> if that is what you are hinting.  It would confuse them when they
> see a true boolean variable
> 
> 	[branch "main"] rebase
> 
> and wonder why
> 
> 	[branch "main"] rebase =
> 
> does not behave the same way, no?

To me confusing thing is that we don't treat those two the same way - 
I'd find it much easier to reason about if empty and missing values were 
always treated the same and booleans required an explicit value, but it 
is too late to change that now.

Thanks

Phillip


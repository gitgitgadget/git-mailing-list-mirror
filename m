Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197764;
	b=qWc10hWkj3kbYYdiytxGue9u/H9nvRKKw2s2zOZNmX5e8IwgkHT/0SoW45HjBUQXJXAl
	 sODZYPS5ULd3jXwvXdxsARIH8PM2n5uDDllFAZkEesupf7RBllgBhBGu5DA6Sv6PRApMo
	 a0YJLJ7YNyHdyzTCsrKwGSzZrpkml6bKrQ4j4wxcDs5U1WEBwaW8k+gnOqwHGlKcEX+MB
	 Xw31gKyqVJCclw7ATf/6q+p2njirLElvSzgRShR0kkpaYGA5O9fJfez5r8sYpMHF74uPM
	 IityC212GmGe6bYHw0TkmRGx7vXKNoMububF1c0lKHEvnMEI6QKRZ5enOjg4ChfWpOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xHOgOLRLi2GgzjAZ9R4kAiwhgP1J+rfmSscDb9d0vRo=;
	b=vsep8bSnURjwsKBKJU4F/za/IowUtXSCi9UpFRsuK8flErkqrRvhpA/pvlXrALg7pQwq
	 HZ6V0RIYyQLVHNuvwqSbksDIpG5e96K/MDpOxmGi5MoxjLkCvm0vtP3D2lt3v+pLIhSlF
	 ESbqlKi1btgmLNiLMPFIpgSLAcUvxcJ+xxXhw+nLg1s4BEj+edqeIbU4QNyYo0frmJYRi
	 g9qyd3jnMlcEXdGCn7iACzfsviuvl1bpldL1t09ecpNdfO4yI3sMyXjocDz5QeJdlUKUq
	 dmj27zWBM+4f6AxarxxB5W7PNXRqBZQe1Y3iOcDM2Ka0mgVBGspZWBBiLKouVD5Cagw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQhhX8gq;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59655606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59655606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQhhX8gq
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so10124305e9.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197763; x=1793802563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xHOgOLRLi2GgzjAZ9R4kAiwhgP1J+rfmSscDb9d0vRo=;
        b=BQhhX8gqHVaWC7N06GbASMUGG6dVq3ardfv8iu2e9xZCuTwToOmBtuePo+Kv/4mzn6
         8d+yLVb7DyZn/9NVPZ263WDz3WHiZOmgeZY3VDr5xz29092s15iUQxmNSLOv6DBklsTj
         9hC6bKPsvSJ/1+mmmiELiD+KreJH6MdXDYdwdfPxUXD2sbWA0O8YS8aVF8o8gmxq0cu5
         uYpY4pEsueVPORZ9FtvYLSq42kWz+ev3pPC+NCPKHBuwjRRRPjqgrLkNgE8Q8TzVSHz/
         YnyMwI3vOaCCYQrrzZNs5bERKfCGn/dsW6LhnXEAG/iq+oMi6drMN+72SU/1ricUTYTc
         Vh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197763; x=1793802563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xHOgOLRLi2GgzjAZ9R4kAiwhgP1J+rfmSscDb9d0vRo=;
        b=Ujl7Wd56NRjjC+SbH4UN9ztNpr8LWB294OiN791ntH+JZwcpG070xHFgI2fLPlUheQ
         3+iQ43QaI09RNmFnqskAWVj/zwYVQ2FYFI6JhyIgcahL/75NhIt7X2pu3hjzc5w3USdW
         Dbc73JB9Gbvw/hag2deuHDO3ahuFNtjbXxfmjoWwHtXZVGX37a5/vKYv77MpehxzklCV
         CjQXa3PDsNUMN0CPQuIvftjQq/ySvTLq38Dxc5BzAJEhdOLQ234UUAGGMdpII2fOLk94
         oMrhphq0l0DIjk0pwtwkvL22GgY4pahJKNMT8l8QvtKaEI9ggOIDQzc4x154Skfx/8Kw
         DZ8A==
X-Forwarded-Encrypted: i=1; AKwUvBzExO41CUoZhHjHqhgMPIWsmaE2retHSUqugS27HZglZGh3hsOD5PeTtEu9fZ04u9Y/w7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+dNV+RKxf5Lvh1CMsYtZ4mcue24f34sPkuEjWImYXe28Z9moR
	yTxZddmJ9zq49f4iKuaD84JWG41a8p/PZRy9UAC2nLwA+pnk84oG8sec
X-Gm-Gg: AYBFou07OC3Fc5mXu1e5zZjpVZqnZkDWdel2uyuViEhQLgrIKVzOZKnTbn/zoegR96Q
	C4kynThAbonkDoKcSJ93t/lcSCN0JplIUYE35L/mcogdAjIbYtdQumhOMvwx9fDGq5H9RF8f/JJ
	Kse5OCQz+CbUL2HSBBd9UF/GkB3I/XMvjz+4Urop3Igfs157C+3I0s2rgaYMn+rdefvHiTZynEX
	dcWRSjlpfFUEj3m3Ob7UfJMcm8n9Zz6Qn1YOd7OCaZ+TC7kNzlq0Nd9tQRy7zuyb1SnoZNeUSn9
	pVzVZMyDAkyMl1QiAA6z7rtIyg3w3qgFhfJ/vH8qMqOLcbkZR+8xPkkng5sqNegGrhR7VPHjAmh
	64wc21xiOhypnb+QXqpqaIqXj1Wls5k28KZCHpjA842XmBh/1ItaYMt0NCq2Qg1Ys2iJM8jgvIu
	rztcIMcv9yiyc0mXbPBK04Hoe3g5+4rhpnFIRruTEhvdBojxA/85BmlFjKW8IKT3CB9LjryK2zY
	DbTfAmhWFYgrEfzXGsc+cdMOtiXIwCuUfCeWpb8IdgdDlxfOZo4LBDgVaL6z8zhD3w2zHD1yWyY
	yMrYOo9o+WkK5D+O1S3JVlwkm80EqgHClWLQY+Q/Xh0UvYZUdKOguJOP6CbKW+4J/XmH7rDfdQ/
	mYBvSQxQ=
X-Received: by 2002:a05:600c:3541:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4a966f20483mr56815425e9.19.1793197762225;
        Wed, 28 Oct 2026 07:29:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a977edc20csm42916725e9.3.2026.10.28.07.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 07:29:21 -0700 (PDT)
Message-ID: <3f939144-d4b3-4bc5-aaea-16422450d638@gmail.com>
Date: Wed, 28 Oct 2026 14:29:19 +0000
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
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same
 signal
To: ian4hu <hu2008yinxiang@163.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <pull.2263.git.1792154272296.gitgitgadget@gmail.com>
 <20261028133755.112476-1-hu2008yinxiang@163.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261028133755.112476-1-hu2008yinxiang@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 13:37, ian4hu wrote:
> Hi,
> 
> Gentle ping on this one.  It is queued in 'seen' as
> iy/sigchain-recover-concurrent-pops, and the latest "What's cooking"
> marks it as "Needs review".
> 
> A short recap: when two copies of the same signal reach two threads
> nearly at the same time, the concurrent sigchain_pop() calls in the
> handlers can unwind the chain by two levels instead of one, leaving
> the process spinning in a handler that keeps re-raising the signal.

It sounds to me like the bug is that we're unwinding the same chain of 
signal handlers in two different threads at the same time. Doesn't that 
mean we're potentially calling the same handler twice, once from each 
thread, which doesn't sound like it'll lead to anything good. I wonder 
how hard it would be to fix the code to ensure that signals are blocked 
when we spawn a new thread so that they are only handled in a single 
thread. It would probably be good idea to start using sigaction() as 
well so that we don't interrupt a signal handler if we receive another 
instance of the same signal while the handler is running.

Thanks

Phillip

> This is reachable with "git clone --depth 1" over ssh receiving two
> SIGTERMs in quick succession, and only SIGKILL gets rid of the
> process.
> 
> The patch leaves the push/pop fast path alone and only teaches the
> "n < 1" guard in sigchain_pop() to fall back to the pre-chain
> disposition, so the stuck handler's raise() terminates the process
> just as a single delivery would.
> 
> Peff, I have Cc'ed you since you wrote the sigchain code.  I would
> appreciate your thoughts on whether this "repair after the fact"
> approach is acceptable, or whether you would rather see the chain
> mutation serialized instead.  I also have a version that uses a
> per-signal spinlock around push/pop, and can send it if that is
> preferred.
> 
> Thanks,
> ian4hu


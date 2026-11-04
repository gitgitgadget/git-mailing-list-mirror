Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809993;
	b=b34SFJkpPDNF3GY79Yt3bvyMoSIX9GjAF1PAhDlHnQjdhHv2TkVL1lgkLR5ya7gtMApK
	 QMB+EcRAc/F5cbcNiZl3DldexqSPf/JuHX8dsW4ez48g5LO6Bx+pdkzyr2P0DoixleKce
	 fir7FxZH7h6LCMeaPABI2WTdjvfT46FuskpUxEYhdiAuFV7voN0jYyGFb0qMMJZJsHARA
	 3q+C5saTMiFBr2XbxboAtzE8+UsYjlhsfWSBj+O2kz2Vs89llwOZ5cI2j3ye4UyyJv5zi
	 0xJb+nG6SquZ6iRYmvQNEAiEykk30UfLS5NqJgL2Nkd6mnlaLx6LEy7/0vdkJWw90ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dMqNS4Zq9+1VDYW+MgkC5/i/I446jAAXuMOMG2PQZR0=;
	b=DQDgKYnBLT5QsGOeWQmpDve6PBxcHcrhhZqizF/u3fZPdzLbRaMi3HdkRDuFiSiprtc+
	 avtyH5JymQagQyvbb7XVWyRLQGk71doz8Ni1b29ai48yvCKwmZBlY9vBEU1B7wwT8ZXQW
	 +KZ/ZROCE6Xc35s5VEqPm7c/1SmvMzSab7kARClr1vuzWwfTR3ZHilZEoaUSzHyFGnh/D
	 56tNmv54BgyBVbLquDzD7poWbDR4zkavGez1aljm8B5s+r9/IXuLLNXhEiOrFfSAkSw2M
	 J8zbEPet8mKSYoFLquQ6A0E2j9kJSTMb7FFJeQenHlO/8q9WDKQ81yyAp624CpJ8Mww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSIgTcxD;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52744606A334
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 16:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52744606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSIgTcxD
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso9555656d6.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793809992; x=1794414792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMqNS4Zq9+1VDYW+MgkC5/i/I446jAAXuMOMG2PQZR0=;
        b=oSIgTcxDWAbyovJdO5AuNaMn7WVxu6/VibqSkdK75RkRwjCItvwfP/AsNQYuDnn+f0
         mWtjfs1lvd/RYWYxLBSSCQhmPjhXn7hqHAPbq425AmyDUcwMg05pGWnEfO3PmquvpeeO
         Wt83jheLZTTRiKxh2uk9kNFeYHXJeTmxyYG2LP5oCTQ+LW8TFN9pDt5Z6ETsffvUVWN4
         4f/Ewu4xXWSh/oUIHlUbDYYJATxIhX4Prt5rFtpEZdbykGMImH+eqholFSjOurGjLIqp
         O0RTl8qFf3ah6fgfizPPZqWRjrHZlbLSj0Rscjso2xqXbIdyrhEFM5i3vExUYMJu9kzl
         9+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809992; x=1794414792;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMqNS4Zq9+1VDYW+MgkC5/i/I446jAAXuMOMG2PQZR0=;
        b=HUBm4gOGOQWVfwAzc++7Er8eaAfVkP5Ih3K6fQwm621GRplzrfNKcHBUi+krkOENSc
         2x9fCl2IpR6CPXrE44qyTaf+u8k7TKn1+225pr1i7QgF5e0GXUTIDSLmgkhSoCACzh+F
         /B2WlGPBZpfH56ZAnzN3loHylhBYe+cq6/uRGL6VXb/CM4IKnysL4pLwldB2xz4KGfni
         +9+7mk+VlGk5RsFcX73CGFrSf/QwhRWwNeRBRgNbbCA2wqukTDv9ktVi5+82mSd0n5/E
         L1bJatQm73EUa+2hTBBxQnyzYZ+wq9mRUc2AtE2QEXDh+ZwIK7xz9JXuJHwy70J4uyfu
         dpXg==
X-Gm-Message-State: APuU4Z+33qrVbFKbr39JWExStki5EWTF8NeYmN6BIRL25hsdQ7CpY20j
	HCaLpWmNhdAV68FIe/AxOspU/zSWsESQYDOLVyQ9+omlaaRjtMUgqzQYoqaH6w==
X-Gm-Gg: AYBFou0yFvdCubMwaz/byN6Ur0SWVPCZErheieYxTSVZHmQ7CqRwT1KOvgyLwUKC8Gk
	1PFGRUhFknbG1a1Fwq8TTNhZLMKuYrkZSjVSz0Lyfj0Ect9FdewRDcHFBdiypioXwCUWQIEzr07
	xQjdhWtmLBt6oqk81H8yVrq4xPbghZ+pkztomxL+LT2Ey6EDoy/KznMdqXCnqv3hnWFyz1UdXht
	4FZNBz90pOJ/xHpApBBStaIVeFltPjccWkA9Zm6kDxjUxsW0+dPfArWWKIOXGiUOtqcSe08q6GI
	pZle2ESyQjaCMbQt1ZxtdxZxQVAQ652s7N1G7g+vecF18NaNJM0K/tmHq0UKYZaoC+ZUdEmKK4i
	5EDmtY4RU9FE3PkJ+wS0Yz3G7xh3msoEqsB0uLRw7kKQcLvqzJxQegELpCkYATo7UH2W7mU75w3
	WF1+Dl9oq7B+kCdnoPddAdrZ2JWvC67xslCvg5cKR+9kaOWGA081ow7hhbTpI/84aDgHI0NsLuK
	+W9uPX1Ddp0gOgwr2FWQI05FPksBAE4bJUu+53EN3v6FYczaQcrR+tAHm9qyd3AiWJtU2paw00N
	LMesKnr78+0iYdqaLrO2gwfZ/xob7Tkfs+a7DhOAWIENF2omZA092Hsu1A+ue0wlOqMJjrGfG6+
	sT9gf1nLq6U4tgBcid8C6jXkWk9HdwTRfMbtjDy+B0ZGpY8C3/YS9BW/B9yIcUZC4mSD/mFZIlk
	npwk+0oTWI8dcWuIDNQC9qv9TmUXeakKtFKhB/1Vz0PAfdp2IO2cPh
X-Received: by 2002:a05:6214:2c0c:b0:91c:8f30:fa3f with SMTP id 6a1803df08f44-91ca4b75870mr284619226d6.46.1793809992060;
        Wed, 04 Nov 2026 08:33:12 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb3aadsm22653556d6.8.2026.11.04.08.33.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:33:11 -0800 (PST)
Message-ID: <9a97d8ca-e7c9-4e57-905b-109df92a9eae@gmail.com>
Date: Wed, 4 Nov 2026 11:33:11 -0500
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
Subject: Re: [PATCH 05/10] commit-graph: merge the two commit graph writers
To: git@vger.kernel.org
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <20261104-pks-commit-graph-write-refactorings-v1-5-d013d9401a59@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-5-d013d9401a59@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 10:57 AM, Patrick Steinhardt wrote:
> We have two entry points for writing commit graphs:
> 
>   - `write_commit_graph()` either writes a commit graph for all commits
>     in the object database, or for the commits specified via its options
>     struct.
> 
>   - `write_commit_graph_reachable()` writes a commit graph for all
>     reachable commits.
> 
> It's somewhat pointless though to have a separate entry point for
> writing a commit graph for reachable commits, as this use case can be
> trivially satisfied via a flag.
> 
> Introduce that flag and drop the separate entry point in favor of
> `write_commit_graph()`. This ensures we have a single entry point for
> writing commit graphs, only, which will make it easier to eventually
> introduce pluggable commit graphs via the object database.
The previous four patches were immediately obvious to be correct. This
one takes a little bit more work, but is a valuable simplification
that will lead to better code reuse in the future.

Thanks,
-Stolee


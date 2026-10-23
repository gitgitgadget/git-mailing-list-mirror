Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768551;
	b=OOCSuwONlDzHMkzKfls7C6llE5rHe49Enq0sN1lxJfuAiv+4J4otp+ttsYWgi8TlOo7h
	 +hRzUajO2Wymm/YHDgYCSqCQLuR3YRgcecWhP/N8P5o8+WddsowKiqXWusjOeb+c+gzhu
	 sQhrXoxjX4MbXrZgQ6ZVR4Us/DSEF6ZdK/c9GvYi1s+KrgIoAUiyFoiV5SxjU/KByzztq
	 oNKP2zKSz55kKFFOQbtdmiJwd2B46cnZ/QNMobZWrYnva9OTf/yu6eB1fPNgLEF64ZS6B
	 C459KYb6lFi2gkBa1T6e26oK13OtqdAywFpHHVI+/2mi83X9EC16rrNgcLXmkgnK3ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Af1SD3SxXi2kUvYl6rKFKxxZFV1FxlkvfAOMYzsHl88=;
	b=ZRQ/+vlTaKosD+dNt9O57F303rcmvq19sIWiU1qq09ccwxI/gsB1JQnCQuNcKAlu3FTb
	 QxlLiMVgKrvWpBbUAPCvXQgiGQI4TNZWusgbHCGxsWkspmyxqg96y5ShXtXRkyneV3fQn
	 xS+Vfosb3QNBmIeOIZFGCUZjKRVIuD4nvEiMygCztwWVPVoUs0S+ZGd0bGAVbPHbzHlro
	 8YwDYo1Q2rmHa7YebB5hkxosujcBrNC/ujhrb9LbLWaSfgC30j9RMMutP+KwO0m7McS8Q
	 MtlIV8ezGXRkcnwjNL4J6SeZHM2fpyxxUnPHoD75dyq7w5uL5b+mTql+5tUiA2dCIfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PcHcpWd6;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAC606A327
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AAAC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PcHcpWd6
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dee593f18so709640f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768549; x=1793373349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Af1SD3SxXi2kUvYl6rKFKxxZFV1FxlkvfAOMYzsHl88=;
        b=PcHcpWd6cO8soHvK0YIloqGC703f7lGg164i+2qtkklQE40lHAr+5H/4sQyGFZRxWj
         eYwZ77Vjc02fEtkOirdh1y1XNtwBFBI/0K1or+I5eisCeK5CYubsUNULxkVCthcma4HV
         Qj5syFgTl0M7ls0zWOBjq5nTRaaCz8ciSQXnV9icdXcOrf33KXJodo7GsnR1QRpO3VXV
         CqxzvfAlVOHOiiI9Ka7m0BIYRIepAFYXDYGieZ7Vf3ZiAoibmu2+mj8QyRwETQxGxl23
         zGjAQARtE/bKRQhihFBkjPk9DK3CuzN1C42pdXhrosTVW2EzuQITy9ti3azudhISqbHR
         9aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768549; x=1793373349;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Af1SD3SxXi2kUvYl6rKFKxxZFV1FxlkvfAOMYzsHl88=;
        b=zj06CGgSWDQHJBitXMuCTz0SiGp5ZBIEUEKn3pVE7K6Kkd9y+CuPrxWX7kNDH9OMrd
         Za6G/P7UiLjofPIe2wana+GgZQQi7aNTbc+MkzpCRj6p2y+Tks3DyJFC30tVWRaEPyD3
         YepNpvvXHMR5hkHI+ZohB+OKJTF42tsuEor6r2VbKphZyYDZzTj+hfN+E2xNNjTtuGaz
         Lkytg23twKHogKDhZ2tdhGmxXXsnpD45KxzOMgXm3F4l3FB2mFtlLZbT2lPXU/8oS66c
         Byfod6N4kWaAzXiRIDLc/vUEysZPE3iM0xKEG/bRUnUhHtkpH1cQWlo+igNcVlQWW09F
         MtJg==
X-Forwarded-Encrypted: i=1; AKwUvBwDt+RC09HFhv+giWUwlFY57jWWZtDx+e5hhfQZxgVufsUcLXFjVhkeNGtuHArc2ahHS1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyKGTzOpyZZh6xhWHtMDxBYwkMAtyLfERh07DtTc1V/vXBYWv9
	unafU42L+SR/qMo40rNg/+a3DXC4DEIYth1qGmBzjEPytVbKTbv1JTYG
X-Gm-Gg: AYBFou1Hf11gQ945LjF0dJ3h7vjbQZ1aX/2rGbSMATRwSTno0MNL+Q3AB8JWRIp7PpV
	eOuIvJgkF4Nyn/0eTkw9kZ8l+E0sB0NfplffooXkCo/7H4PN/Yode8QSVYFqU4RguvDCRm1T3OA
	W+INx4Y5oSQOU9D9Sh2Ws8i+RT5Q9mssRfQkNFgA2dYvhjDt4fvmtuXic9OUvuStn1XosYgFG4M
	rN5mFt07QiaIwG/XqXGrhoSQzBTk4SUMGOC5GdifhtmQf0NX1lfCD+s0hQIUILpdeEhEWZiIJFF
	gDwndBdZcSbzQyjR7tk6DJ/bgd93LYuz8mHyMo42WIrr6Au/SKl03MMqh0sfWCpW93jFHSWf78N
	z5gG1hDAW1GUoXZNSOcj3Z7MTh6u98lgZbgZS95WHopy+7dgvxhiEMZOqxoeKDDaNujvnTAbZIH
	G1oEWylIuKJ4WeIegJH1m+QRqReW76xSTrOUWPXBAoVM7gDslRd1CwG2aqFsrxfyo70qU45mE4U
	9kMVL7Ae4YRxBchtVDu+wxbc8am7GtBLT3RmOZ4CwSVJSr6jonKr3reMAXCD1NbC/DGGgc2L5xq
	isCnPDv7UQH92eakREtvlBZK5ebtL/ib4A==
X-Received: by 2002:a05:6000:184e:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e385896dbmr4220851f8f.18.1792768548805;
        Fri, 23 Oct 2026 08:15:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d40459dsm369026f8f.28.2026.10.23.08.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:15:48 -0700 (PDT)
Message-ID: <fe3d651a-d1af-47a7-9b7b-a4ff242ca303@gmail.com>
Date: Fri, 23 Oct 2026 16:15:47 +0100
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
Subject: Re: [PATCH v2] diff-delta: use safe integer arithmetic
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v2.git.1792734993812.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2276.v2.git.1792734993812.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Srujith

On 23/10/2026 06:56, Srujith A Poojary via GitGitGadget wrote:
> From: Srujith A Poojary <poojarysrujith@gmail.com>
> 
> Replace manual multiplication and addition in create_delta_index()
> with safe integer helpers (st_mult, st_add, st_add3) to prevent
> overflows.

Sounds like a good idea

> diff --git a/diff-delta.c b/diff-delta.c
> index 7cbedeb507..45df070ab9 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
>   	hmask = hsize - 1;
>   
>   	/* allocate lookup index */
> -	memsize = sizeof(*hash) * hsize +
> -		  sizeof(*entry) * entries;
> +	memsize = st_add(st_mult(sizeof(*hash), hsize),
> +				st_mult(sizeof(*entry), entries));

The alignment is off here, see 
https://github.com/gitgitgadget/git/actions/runs/39906906057/job/120260845179?pr=2276 
for a suggested fix from clang-format. I think you should be able to use 
"git clang-format HEAD^" to fix it.
  >   	mem = malloc(memsize);
>   	if (!mem)
>   		return NULL;
> @@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
>   	 * Now create the packed index in array form
>   	 * rather than linked lists.
>   	 */
> -	memsize = sizeof(*index)
> -		+ sizeof(*packed_hash) * (hsize+1)
> -		+ sizeof(*packed_entry) * entries;
> +	memsize = st_add3(sizeof(*index),
> +			st_mult(sizeof(*packed_hash), hsize + 1),

What are the bounds of hsize? Can adding one to it overflow? The 
alignment is off here as well, all the arguments to st_add3() should be 
aligned.

Thanks

Phillip

> +			st_mult(sizeof(*packed_entry), entries));
>   	mem = malloc(memsize);
>   	if (!mem) {
>   		free(hash);
> 
> base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926


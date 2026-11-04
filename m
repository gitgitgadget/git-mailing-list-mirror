Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800708;
	b=2X8wuKTkJv421ENnD3OAMx8savipisudo2N5k18qOzYyyBSwYfIF2DORwSrZOogKMwkt
	 BNCBLu4+SrhqkMs72NubsQRydEJlFvOIPugo3mTIXibgGCU6ypH5N7/l5ieaWh376xKAr
	 98A61wt3YswcGgglAVS2US5KKcbB9G/aLba1bnzoYeZqUesQ0UTYw4OSoT6GheLd2pjie
	 2VYF6G/HI1Oy353wc1SR2ydMEcSgfZWAsZPbXr3tcI3R/U04dMb2RXmYjicB6lYFEPLDE
	 xAfPQn9DEFEF7eF+kaL5CXedZKXl7F3s+z4KsV4ruSbyDgAQ5AWrxQYOuydeaCghaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dBR3M8cKelfU2d2ZLDM3mCKo3H3plqbR2E86jUKoUJM=;
	b=YgW7kLny/M9+Yms1phxowM//o3c3l4B6/L6rO4VEHekcDHxcMRnr5TEhjOnRaX+RTV4S
	 o5fATojx/xVUEsjw7UKYzlQT6P/QWbrGBTOm9uIjUJ3x3V775O+QM1WPpHRNeq0qUNNUh
	 VbWkJ5HJ96BoZOvbL3N2GUjcSoX7wnLSMeCJvFBPPE9boagMDGCecXWvk0SV5OYCsruwe
	 8JFKHWAbitf010i+1rPsuWeqCBDheGTvLdp1GaagzRzNNKVZw3rte3ww1Wu/qBuJJRD7k
	 FTcKU82M7Lp91aCsIsOukpG7a56VuXJVvaq9DnS3r71Fo0qUOfRX8D6+I6H9dgr6Aog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbOoU8Ny;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AB606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbOoU8Ny
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so8656135e9.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 05:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793800707; x=1794405507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dBR3M8cKelfU2d2ZLDM3mCKo3H3plqbR2E86jUKoUJM=;
        b=qbOoU8NyEHXgPmBdbVYX4ITQAOQa9bCdSjOYEd1Y89C0aajSRtzXzq7Kn8jzg3lhUK
         EPTxkMfDtHPzy6lQ3w4J6ntkd3uNiWE7B1loKixRFZlzd4X1DZFNQhhIoS92SsrCSFn8
         MP0AIeOnTEIdQbedOqfsU1zSUsTit3LWkICyPmeoUoHkaXtwgJ8HCeSRwQGmSeaJnRWU
         d424bWgFuyEA9RdjRv576Ao+Ang8KWFbzwDl3Kewyvi+nEQeKG4lvElS/5iwgv0KEdn2
         QX7u7+FdxNfg61bvHGuq/Z/AUI0rIv9miIhWoal5NCODkl18MisE4Xa3O9x4B0v7gOKk
         BRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800707; x=1794405507;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBR3M8cKelfU2d2ZLDM3mCKo3H3plqbR2E86jUKoUJM=;
        b=slBon1CAwRfJf6VtQlkocv5+pNAF7ce+KvxoQ9tM1C1gW7EWR00pkgrRtftP3c4r/0
         30umkRgo1KLuuGKYm7ivCwnvjWCOe4YghYK5bBiJblmS3HxIY4nEkD01G6hBgHbfOlVE
         XYRWsn9k4JX9r6sONPGpP2+hxvaAKFhD5RFrJ6OqUSTtA1zA6yIKnPR99GeQOel/vVX7
         JS06Ps+rSIT0dk/UCRUFNwhCozFgg2ByfLzZTJtaw9eDmKuhvZTIBO48TVtsF4Z0Qi/e
         F8gOaI8WHaGP40+9AduETjZj6Gm4qogLHrBFw9HAONcFrrneW0T6yKj6rigyxp1G4Ycp
         IWZA==
X-Forwarded-Encrypted: i=1; AKwUvBxKeoG9EcAbmPHHnHBQYrpD5vJV4xJZn8lW5YY/qlDCHz4ZPD+2NEDzGnym29c/bb1/R/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z92id/ftzwlC9AADhvvnh7PvQgK2InSC0g+dvueSNWo8aaDpxxd
	GP5w/LAmfiRz93UlyPvnncIgvXugXHc3ufpSjSCVw1s6///IgndAbpy9
X-Gm-Gg: AYBFou1R03S3r+ZozPGgCPy7odUgy9noxmTPXwoI21+oOkv4VJ79ObPaAFUyI0MOgD2
	WqM5XN+m1sc8TLnRWCulii5ASCr5CzJBHzodMqY4ftfNJivQz5WhfeQdCY6g6AKGv31L3tj63kx
	dBa09zwOf+uqUJobiafpgyE4L0cyhh2nMYWJUQ6Wx/ce8DeBM2rORWg6+QHjp2ZIekPbanr0SRQ
	8SZ86pncgT93NYfOwLgUJjI7DspYR1otxF3gMEH8uFCpAbm0MTKrTxxbPCRuPGOa1L1/9BdUKh/
	ue3F2CkmTYGMx4IBTVcrOgFSLUkrnoFuYtEcFoCgJt7i+jNaqiagiePcCc1/OuHibArB7bqOjh2
	ufBs/ypJddssSqkO4rXHEvUxwNLD0wUfU47h0ZipDV/pXbck4wO4YPEkypTgonBGXk8Ld18m0Mm
	1kn8Tl78Gy5BKxYetr8QnVdcsOIlpbk5Y24xBLfWvS5aYw8riUgtQyiJr0GqNG4dd64eWRgLh/4
	AmNI6MAN5Njk4Bw738uAF/fnZFWhvvKFkpRc/KiYOc/aVkUP2CoBMOS2M7An76moSjlYcKjGIpN
	h74vyKIln0ZrE1C0IponyfYfI8eE8+WNY7HQ/NtU2/P7Nzy9Fw2ALckebicwtQ7WH8R6ehk0Jsd
	6S2RrRK3jlBQ=
X-Received: by 2002:a05:600c:1f96:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4ac185bd363mr367808125e9.35.1793800706584;
        Wed, 04 Nov 2026 05:58:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:483d:7f57:1b4d:f762? ([2a0a:ef40:724:6601:483d:7f57:1b4d:f762])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4532916f2sm56991905e9.5.2026.11.04.05.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 05:58:26 -0800 (PST)
Message-ID: <0cb42395-3e62-42e0-bfd3-a4265ed7cc33@gmail.com>
Date: Wed, 4 Nov 2026 13:58:29 +0000
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
Subject: Re: [PATCH 2/3] diff: use size_t for the size passed to count_lines()
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Michael Montalbo <mmontalbo@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
 <2011b90d80c5a823878055fd1016bc38b6a072b7.1793546752.git.gitter.spiros@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2011b90d80c5a823878055fd1016bc38b6a072b7.1793546752.git.gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elia

On 01/11/2026 15:36, Elia Pinto wrote:
> count_lines() takes the size as an "int", whereas callers have "unsigned
> long" or "size_t". It is used for the diffstat of complete rewrites
> ("git diff -B --stat") and in emit_rewrite_diff().
> 
> With a file of 2GiB or more, the "int" becomes negative (or truncated
> above 4GiB), leading to an incorrect line count. This only affects the
> diffstat output, with no memory access issues.
> 
> This was verified using a 16-bit simulation, where "git diff -B --stat"
> reported 0 changed lines instead of the actual count.
> 
 > Make the size parameter a size_t. The line counter remains "int".

That means the counter is subject to overflow as a file can contain as 
many lines as its size.

I don't know what the simulation entailed, but this patch changes the 
return type without changing either the type of the returned value which 
can now overflow, or the types where the return values is stored by callers.

I'm concerned that the preparation of these patches and the others 
you've sent has relied too heavily on a flawed mechanical process, and 
have not enough on manual review reading the code and reasoning about it.

Thanks

Phillip


> Triggering this requires processing a file of 2GiB or more, so no test
> is added.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>   diff.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/diff.c b/diff.c
> index b4ac17f8ef..ed7a931c41 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -655,7 +655,7 @@ struct line_range_callback {
>   	int ret;			/* latched error from orig_line_fn */
>   };
>   
> -static int count_lines(const char *data, int size)
> +static int count_lines(const char *data, size_t size)
>   {
>   	int count, ch, completely_empty = 1, nl_just_seen = 0;
>   	count = 0;


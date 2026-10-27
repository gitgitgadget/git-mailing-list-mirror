Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097233;
	b=qBOxrJ2cYyRrGhZ+okT28awy/cgx2lwBudO1gaDeE7vlOdDuGdGS/YuAnVpPX9ecJPKN
	 1cWaEpGeWwC/aLMwz1MZy89IJOld0uhCG0yAw/KgFBM2F9jJz63MfxJcEc8jvLiAqlsPj
	 mTk9HfXENgeI/6udB+skHr+6746mh5h61lfIlS9rM835DEgGzQfaW9+bsmgCEhZE/an19
	 EpWo0CcqVBVHvUnFx3zVLVVjAatPArB55Sv/n7sDtvWRZp+rOAmhMZ091TQeNuegvrlzn
	 kA2uskYoDxDRFEqWCc/QOTBqd8LQaZ7TkJBQ4fHjj8DrAoimV3j/nCMhE20+gw7r7CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=jWLUFMWK2uBPpg6WENify7MfWel7uxZRHVsqytU1NcA=;
	b=d81wX2krgIxc0ULcMafz/sk7kZ25linIEwcY1PcaokLxHDCq7uygSTydg8xn80dna5o/
	 v4RonK6kF2KQmfKT761olueapQbp3ah8fJQVV0NE31dDl+qwUETyg61ELGiNn4f/WZk1p
	 jY3xk+IOjHSna+DN77WylhecuFdxp9scDFNBb+YFdR0dnZ9F+CVHzUb/pJmNhd4r23Fvo
	 XfjDuloaltVPnSlXGlfg8zQkEj0foFIsEga7IAs6UaFu/LQcKd+5n1uTh42XcehjY/fmx
	 +ki48mr6tDFeus729Y6BWWY43uIGVV7zb+CUqOOuWIAmuCTJvfWIZkqgGqPPO1lBQ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sQwrDlPO;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE35606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE35606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sQwrDlPO
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso21490745e9.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793097231; x=1793702031; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jWLUFMWK2uBPpg6WENify7MfWel7uxZRHVsqytU1NcA=;
        b=sQwrDlPOCpjk03Tx81L5AJ67Eag4qhs9jwICwe744XI1leVXBfzq1vACRp2aFmICEo
         Z+frfGID/gGGeDmQI3XKI5B249MptxeraS3QATDqsqryLyVSjHiODaRErN3WyQYEiHFI
         aHGXAltAYwHCzipjJozWkVYASxQOuQAUabbrZoE/WxsetD/qmAZvOgr9UClCAnrJMkh+
         7ncxjD/Y+0MzBAF4tK+Cc4/hWw2AFyTrOWfHeopMeNMvtV+L9xttjuttLz34r1XJKnEQ
         9AOXZzJLVtoHmgVBKfgiftqZEs32ompO57jNvUs1geA5bIr1qrkpUkJcA8unJDtOySGN
         DD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793097231; x=1793702031;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWLUFMWK2uBPpg6WENify7MfWel7uxZRHVsqytU1NcA=;
        b=p38kG+5yf1GdDYbJ3xge52MhallmD/Qmfg1JDpouq8GFASgsV0lhnT/kWMUtwWqHx6
         mMIgYHolVEF5c4Ztb9nznjJUbaxjKNr8mvLCLR2nB6ZN9OXbVeEaA/LX6LunY3DMW/xY
         TCA/zg/aHXrJ6UWh0+DxOO9Q6KipiIn40+16krXo0jqemAX6NtvgSpKZEsgkWHMtc0j8
         z4Mkpzq/3tWlhX9bam38wa+p/aeCmui74YuU5+/gYfh2gXc36g4yeFfjuMPYOAF+i2r/
         x4DT4HRNA+qgTrV4xs8mevwt48gGWbmVx6YoXLMvprv5ZHLdRZJ8HbMibuAJIlJD4mBK
         J8uQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnJRcEXWTfsvJwgjM/G8jPswVS7OxcoiOR5RUXtMt4InH3DSDwnIXa+fnwSvkIooxSJRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYITkk1M4UA8RXtfqnRT3Aj/Xi2q+U3lnu36t3TOAK0Sa2i/mEMO
	uenwwDJOUBHVJOUDIEUk987m6TZ0KyPUO1/i+39oHGQNa8pUnUtddHmg
X-Gm-Gg: AYBFou37ct+jkoTpLft8W1lE3wPHlRUtBfvJKrlPSJSmeeujah6FXNKsGi8WZ0Gpmjm
	LFGjgiGBVJtLjK/6kNju5OCDPkZtiOGZ6VtVShrVMZdTm6KqpTFrZM0G2vEYUPZI6LzzL5ENNF8
	ZzJ0R8GQUxc4fwyZajvyUO2jlSzggASLgBFPLowu0+O1rP8OgrkTbNo9ZSETnpNxZ514zKJ1loh
	Au7vgy4na6Xfv32zfYZH2NbdVb/G9bWFeiydUZn2fdrtDptt5Qte4yzOlBAU3P4FJxvggUjzZJ0
	e9vIJOELzKv6t/VpqoLB0s+51S6B39KQwikP1o4Uy/xuHJrnrApbngzuS/Q9rfOb/VsQ7zOFWn7
	aWkrpQ6nhp0wlHg4gIn4USqUnBT7TZBurwOqrJO1Ivma/xyTofxdDXmtOXkQ6rOh3jumEJIWTMO
	TaweGadeqHVQPNdq8WuO69LtWiN6VAnv0EFbL+Gz8BPmXgYrPK5Ulxr5eq5maTU16ieY91jfMC1
	hvHTzOdAhKb/Iy0x0EZJ7W7T9iriXbnTvj6EJ1AsYInn4xKxlozBxthrH7ee8LjNj41WXepze5h
	zF9Rc/BIygplKMrHiwc2iF5j8qvLLintgxZTVXXbLP0eoFlfcsv0KtAtEmyh9jvapbjte6gwf9u
	uQvpyis/+mpXp7lzBbNUnJvJZjXLRf5NikWdmHLYmWUGXUk+iQkV+wi5Wyg6WkaR4Bp+VPUqr/H
	wuF//p
X-Received: by 2002:a05:600c:3491:b0:4a2:40:8d2c with SMTP id 5b1f17b1804b1-4a35acbd31amr180539755e9.26.1793097231114;
        Tue, 27 Oct 2026 03:33:51 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:9b4:dea8:96dd:9a68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bae01sm317856355e9.7.2026.10.27.03.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 03:33:50 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 10:33:49 +0000
Message-Id: <DMFJX3GJOXI0.1US2IH6P4LRUR@gmail.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, "Srujith A Poojary"
 <poojarysrujith@gmail.com>
Subject: Re: [PATCH v6] diff-delta: use safe integer arithmetic
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v6.git.1793076683043.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.v6.git.1793076683043.gitgitgadget@gmail.com>

On Tue Oct 27, 2026 at 4:51 AM WET, Srujith A Poojary via GitGitGadget wrot=
e:
> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
[snip]
>
> For the unpacked index allocation:
> - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
>   which may be padded to 16 bytes depending on compiler alignment rules.

	l 117-125 'diff-delta.c'

	struct index_entry {
		const unsigned char *ptr;
		unsigned int val;
	};

	struct unpacked_index_entry {
		struct index_entry entry;
		struct unpacked_index_entry *next;
	};

On 32 bit systems we have 4 bytes ptr + 4 bytes uint + 4 bytes ptr. I=20
don't see how it could be padded to 16.

> - sizeof(struct index_entry *) is 4 bytes.
> - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is 1=
6,
>   limiting entries to 1,048,575.

	l 148-158 'diff-delta.c'

	/* Determine index hash size.  Note that indexing skips the
	   first byte to allow for optimizing the Rabin's polynomial
	   initialization in create_delta(). */
	entries =3D (bufsize - 1) / RABIN_WINDOW;
	if (bufsize >=3D 0xffffffffUL) {
		/*
		 * Current delta format can't encode offsets into
		 * reference buffer with more than 32 bits.
		 */
		entries =3D 0xfffffffeU / RABIN_WINDOW;
	}

entries are capped by 0xfffffffeU so the real limit is:=20
268 435 455 (256 times more)

> - hsize is the smallest power of 2 greater than or equal to entries,
>   capped at 1,048,576.

After the code above we find this:

	l 159-162 'diff-delta.c'

	hsize =3D entries / 4;
	for (i =3D 4; (1u << i) < hsize; i++);
	hsize =3D 1 << i;
	hmask =3D hsize - 1;

What this does is set hsize to the smallest power of 2 >=3D entries / 4
(with a minimum of 16), so it's "capped" at 67 108 864 (2^26).

>
[snip]
>
>  diff-delta.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 7cbedeb507..efebce3aca 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *b=
uf, size_t bufsize)
>  	hmask =3D hsize - 1;
> =20
>  	/* allocate lookup index */
> -	memsize =3D sizeof(*hash) * hsize +
> -		  sizeof(*entry) * entries;
> +	memsize =3D st_add(st_mult(sizeof(*hash), hsize),
> +			 st_mult(sizeof(*entry), entries));
>  	mem =3D malloc(memsize);
>  	if (!mem)
>  		return NULL;
> @@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *b=
uf, size_t bufsize)
>  	 * Now create the packed index in array form
>  	 * rather than linked lists.
>  	 */
> -	memsize =3D sizeof(*index)
> -		+ sizeof(*packed_hash) * (hsize+1)
> -		+ sizeof(*packed_entry) * entries;
> +	memsize =3D st_add3(sizeof(*index),
> +			  st_mult(sizeof(*packed_hash), hsize + 1),
> +			  st_mult(sizeof(*packed_entry), entries));
>  	mem =3D malloc(memsize);
>  	if (!mem) {
>  		free(hash);
>
> base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926

The code looks good.

Good job ;),
Pablo


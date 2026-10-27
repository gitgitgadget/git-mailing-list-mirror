Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101924;
	b=E+XYCtrNTt3o+tDFTnoCZDM4FTGu0FkE5EeEOOssshz6aLLreN2ib7XXZk4on6Ibxdsz
	 IrUP2Im5+4onmThuOEEN1+R6jMqDlIJlXQE2YZMSDT2KI7DX8ABrmH8x8wZ2svDMvm58m
	 HZaGE4c8H1lLCrSs+sVBF9b5uTB3iLnWP8h6tqHKAVcAA0D0dFa3Sre4DvMfZwgBRX6L3
	 zBnQN9NmW8ZWZZLOLJ0pwF5U6Dwx4xuLlth3+0zVxUxjjbckpFPdev6cqzS6bFLHqgY8z
	 3RB7HiiVox5u8ptIfVNVz/dvTdb3UulUJ0W2HasczShFYN+Dk2wcxk9QGezeKTsQl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=3TBRz1WobxQgZs5Z75PwyICASOqiqUX1AC6Hu/tOxB8=;
	b=JUyXS7m12dDwrN07hgB7FftVHNLifcq9XMdaQdRmRVpRZB4fJkv2jwMM3otchZpXP0LV
	 fnRShVRZboxXMYTOtMpyHFIu1j55slQtyj5nnxikDIaa+8nW+NchZ75BEpxN6vV453wF9
	 WCEHZCyjQeDMr6royN1qJUHaVXvNcLnbcwTQ+KXD651VWoABc70Kq3bjQV3+X6fCaZXKg
	 IvIfHIaaTGUreXEcdev1c1rephknekcDxYxyjvCfoYy3dBJbGgtzgR3739YbdyYPKMeYC
	 DIt3eJTLX5EK+Kn8syrNSzCJanzdymPw2jhz4mM1FSSCuXQeUaFbKo0Kjhm3g9tYOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YXvJE+3H;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512E606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9512E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YXvJE+3H
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a208d93758so46286745e9.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793101922; x=1793706722; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3TBRz1WobxQgZs5Z75PwyICASOqiqUX1AC6Hu/tOxB8=;
        b=YXvJE+3HtpnNMP3dofh0DCqu/BeGRI2Pstq0LuZ0Pl6r7LOksRnV7Q44lkidxuoD72
         jUGXfR8+Av3VuUkAw4VeLNaHO51PYqa5WyltRY7yoKoyqcho8dMPwdZWZecF33moAeaR
         k59I7X8XCAhRSV4YhHC9tqho2h7QdFNh/g0o9bvCx4wJazcxs9KxdaODGWqVFUO0+IPW
         zUew4EYh1JCPywcDyhGUywWQItw2rC2Y79jKc2tq/jj19oY+Q19Wbx3Br5P9oxxuauuq
         PAy1TcKx6UfOa4DW81kuxF341TouPPL5LLzsIVBh2DdBKJseFBGFTk1kBoVsmQwajjTq
         q/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101922; x=1793706722;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TBRz1WobxQgZs5Z75PwyICASOqiqUX1AC6Hu/tOxB8=;
        b=CobDbPb236TXib140Yeoh2zDuQ3KQ/PTJKydRgu8LP59XBHkFjyxX0MPI7WrwgtVvT
         exzK7s3FO3IoDAKU7e6UJNw1Y8ubSPMq++wkpMMOOobbrguDPj5OgMl3/TZgxlsdjFPJ
         oDmsZM1dy5BFvDwYBgdQTIbDvFtI8Hu8bwOsj6KB4DIqiAxysW0TLVA8ZXemFxJuTy7r
         EjnNoioX6tdqAD+owiS25WjBRXRI1I5U0hbWqU+zFoKEfgV99NjSWnLpxgvu5YyMZ2TC
         mF5nt6jzL6M5nf0eY/B97cqmj3aXyC9Ok/QI4T7j9EEt93Q8NO8u2ASRWEuhF91ROQlV
         Q1Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxklDs2DbGSgRxSUwyDsy+vHpZ7UafDwYc3v9zE1uMo/6XC1cqpypkppJKmgQAQBAuaabM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLa/gQH1BPDZpx2QnewNcyVUy7CnqvqMRILJWkvjThPjfqchvDK
	njRFNBiUMZHTgnqTYA7bB9b4Z9i3DvPiIFrrjHaMer2PGZnVPKUInmYu
X-Gm-Gg: AYBFou2dWg1vtp+ycUDo9KRviL8sFHFWsux6Gav72YLP3oorwDrXw/5oz/aEhN2CVhT
	QMImSi2Y9zvlQ9HfCOtYIL3sxO5TwHis54LD4shnxfwtJH8ezUPAgb7DAMeZfbSY4Vl6i/YASPW
	HeBF/a3Wj4WVRmu0hQI5g3eyP7I8cvtAC3l+J3JOA04g2pUQbyoQsTA8ZgN2tjaeVFiUlHYCTf8
	bpp8+rzjV6OMgo6o4elc2PF3uGUM9vw/OvFelJGIdU64jKvzvdlapT3u9EricBJzYWfdY6XzgpS
	0c8dIlPnwWUDoH0+nvKieVlnhUIYR3Ya2wa2spc7ayRzVSRkxdo/FESv5CrtEnHhkPM/mIaHZ69
	hwgGmGC2B21d+E9xQ1MGjz4Cy2dnvvu3szwxNoU5N1CbCotKc9gyzxCiJvuOvzSPI69b9+t0Mif
	9QTM6oXi01osteVl4Uho27+NaWGKsow1VMXexzZTexxHOHa8NWrF6Mw/AmxdkT7B7RnB9ZXLcXb
	oOLzICrBvULHkP3HSsDQpMr/Jc9anRTik+dI+Cy5f9Zmr8+XyV7utLp3knpEKWM4nlUnB0gcAnN
	9BjZUKueV7jSxf6v2t5KfUezm/KPoBndBA27QbotDEsPsG9adJg6EWdXgJSn5vPUipJ6SxU/qmJ
	INhU86WbyF9Z+v2/oRa7cZMYrSzBK1pDx39wvZFxHDO4mAjy4muMP/1C9UaCSmecJO3NdPXwpfV
	cXFpPr
X-Received: by 2002:a05:600c:4688:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4a35aca5a1amr176538645e9.22.1793101921695;
        Tue, 27 Oct 2026 04:52:01 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:9b4:dea8:96dd:9a68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0cc374sm275726505e9.9.2026.10.27.04.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 04:52:01 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 11:52:00 +0000
Message-Id: <DMFLKY90144W.2W4T9I9V2PEYO@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, "Srujith A Poojary" <poojarysrujith@gmail.com>
Subject: Re: [PATCH v7] diff-delta: use safe integer arithmetic
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v7.git.1793098852493.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.v7.git.1793098852493.gitgitgadget@gmail.com>

On Tue Oct 27, 2026 at 11:00 AM WET, Srujith A Poojary via GitGitGadget wro=
te:
> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
[snip]
>
> For the unpacked index allocation:
> - sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32-bit syste=
ms
>   (4 bytes for ptr, 4 bytes for val, 4 bytes for inner entry, and 4 bytes
>   for the next pointer).
> - sizeof(struct index_entry *) is 4 bytes.
> - entries is capped by (0xffffffu / RABIN_WINDOW), limiting entries.
> - hsize is determined as the smallest power of 2 >=3D (entries / 4), capp=
ed
>   appropriately.

Hi,

I couldn't help but notice that my review was completely ignored. Instead
of fixing the points I raised, v7 just removes the information, and in
your reply you say 16 bytes when I clearly wrote it couldn't be 16. It
feels like I'm talking to something automated, and that's a bit
frustrating.

If I'm the one who got it wrong and that's why you didn't apply it, I'd
appreciate it if you told me.

[snip]
>
> Range-diff vs v6:
>
>  1:  b91a1ed54b ! 1:  8eb6d31788 diff-delta: use safe integer arithmetic
>      @@ Commit message
>           helpers (st_mult, st_add, st_add3).
>      =20
>           For the unpacked index allocation:
>      -    - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit sys=
tems,
>      -      which may be padded to 16 bytes depending on compiler alignme=
nt rules.
>      +    - sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32=
-bit systems
>      +      (4 bytes for ptr, 4 bytes for val, 4 bytes for inner entry, a=
nd 4 bytes
>      +      for the next pointer).

sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit, not 16.
"inner entry" is ptr + val, it's not a separate 4 bytes field.

>           - sizeof(struct index_entry *) is 4 bytes.
>      -    - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_W=
INDOW is 16,
>      -      limiting entries to 1,048,575.
>      -    - hsize is the smallest power of 2 greater than or equal to ent=
ries,
>      -      capped at 1,048,576.
>      +    - entries is capped by (0xffffffu / RABIN_WINDOW), limiting ent=
ries.

entries is capped by 0xfffffffeU / RABIN_WINDOW (l 157), not 0xffffffu.
Removing the number doesn't fix it.

>      +    - hsize is determined as the smallest power of 2 >=3D (entries =
/ 4), capped
>      +      appropriately.

"capped appropriately" doesn't say anything, hsize is capped at 2^26
(with a minimum of 16).

>      =20
>      -    While entries is bounded in current code, using st_mult() and s=
t_add()
>      -    guarantees that any unexpected growth in struct sizes or bounds=
 changes
>      +    Using st_mult() and st_add() guarantees that any allocation cal=
culations
>           will safely die() on size_t overflow instead of wrapping around=
.
>      =20
>           For the packed index allocation:
>           - (hsize + 1) is passed to st_mult(), which is evaluated as an =
argument
>      -      inside st_add3(), and is safe from overflow because hsize is =
capped at
>      -      1,048,576 early in the function.
>      +      inside st_add3(), and is safe from overflow because hsize is =
capped early
>      +      in the function.
>      =20
>           Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>

I recommend reading the review on v6.

[snip]

-Pablo


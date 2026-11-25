Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795571236;
	b=LIGDO0MRE8RuSaxBpa5WGG684c3Hgv0EzuQA8kTibc2n5erC/xYx401+IwgLbd5Nvf8r
	 si49epFTpfJRd50q6unF8M1ay8v4K/On4LVcBZ0Cy8sy6JERWv6TSO2PMDse/PZv+AAsO
	 VsBlwiHVNwfJxxuJMtmYQrDPviM6dHgcI+97G18ooLKdXZN82SAmhhKHRHIJeAg+2UjeD
	 lE8+fA//BQ7W33Z1Yt+7qVVyHDJ1Cgs4rGLYCPkM1OJ7gCwdsxnf5v9lkYuwooF4cL1SB
	 XWqgZ2M+r1sOaaxjvnmK9u3icBwLmeCn75vwtbuMehENkmGt8ET9kw0HZ0r+dy3Myzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=O/DtyQ8qPRlggL0XcvFMqw/UbqZJ9DY9Ouh4yjHzwtY=;
	b=bHtXgs6B2QTWXw/u26UR/bLVS+fyJmPn6e/AlDMnCYHg8YbzNbbTDRgVKd027NYQ4t/y
	 cBcxnOs+uHxNgJjsCtgEXgDNqGgcCcKwTycs27b9I6YsXxnfaB1j8FP/rOQd28NpDc6CU
	 nWBnOwGCofKXg92YTCtGqfLOZwPI6pxoklgyotUI4eVhrPiR2UdPGEZ0SkI/nxfxIEs5J
	 aX4fdqWHNSkgFlSz8++KvFBbS57rc+yMvsva2uI1ep82gXQZCuznhiF33aFzDDMW3I28u
	 9/8yzIN7dPg1GNCZYkau676zJfbbmWNZF9B3yAWHOKkrNABHqY9JXwijI5osINGSZgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=m8mPyBsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED7606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17ED7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=m8mPyBsu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b8977f2785so6843777a12.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795571232; cv=none;
        d=google.com; s=arc-20260327;
        b=Pe0lG0fDZhQWra7pSkL6LKGUUxWLy0sAEJjRKZjT5yt8RxDnSZMzMmuvOxBOMcC8ji
         vaMrpEy0p9QTTrmm5ItXPHWwfA2k8j3R4wZKCQyUhNsQegIS25q4YHS8XqISm8HK96h0
         DGVGqWXnI98W3ZfXR6key36wYBva4qVCWfCECvz/ZzZ7Mn5xvnWRj4hFpHhYsnK4Nm87
         BUX9xE7nRHkn+VgKLmrOm3LpUg7o8p8HULtrr2e7R2xrsAMYfksM45xVEZpmY8bO4ESb
         k+W0+lvVavz/j5Mi8mHn0BfOU4KL/j6Y69CpxpnxTR09UWdUCIJJgpT5tLh4P5mPqZ2Q
         TJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O/DtyQ8qPRlggL0XcvFMqw/UbqZJ9DY9Ouh4yjHzwtY=;
        fh=Wzr8+y1UwvDYZ0oVU6Huitc9Achc+D9BGCxy+/EJL68=;
        b=mk7PpVcwguHTD2/ypNOimZDAJvurC/YIeeyjuM9eqtoh02m3qoSTzVZ1jngbUMU6HS
         HMOhDiA9YVsdOUgFAMfMeDzg1R4JXSMvXrU0d+1gJYJLH7GzqpZ35H0eojduoN5NBtdm
         gJuUhObxr22s3pSuLOnNOrXLg5RJgqSYR0R15OOI+gPb+S48xt7Wc5rfF44MNBiXgnTC
         Jafwcxn/C2//edEzQ4GGFx0oRqtK76V4pqKILgmf1zaptzbqFaPMdBfu+E/rgo1vgYDA
         EyRAXUWDcgreROYa2JzM6ZRhY1DMOgyz8/TFnLKZRKVz7STnYlDGNcYNl8nah1SgVAOx
         xLZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1795571232; x=1796176032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/DtyQ8qPRlggL0XcvFMqw/UbqZJ9DY9Ouh4yjHzwtY=;
        b=m8mPyBsu6CAF5YGqKw59O4iRceRyJOR36fMRTPKGlNnrc36PlMWvcRiSzkyhNS3gpd
         MP+DbiCgtMrOdslNDSO5aQE8OSdCa9mQLj/yhtVzbd/pobHDSJ1DYvMF4nY1zma3Yojv
         l0Qt2eic9hDyDE3pITJlz+l57qCyNARZVHcYDV2/62PE6RR2EQ7cRtGFEOdzvQkAcUqF
         6HtbDisvn6UTmYgoOF6WruBZPrxrgDdYGw5ng9JLGssjrbhIP8zSv+j758wLBRUqh4Um
         E+I5p2U/Q7jy2numnwTzbXEYPg1ypfx3acWG3BscAFFmHyHuOtV82qsYJCRFGK+Fev3M
         WKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795571232; x=1796176032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/DtyQ8qPRlggL0XcvFMqw/UbqZJ9DY9Ouh4yjHzwtY=;
        b=heUC2na5AgvMyFlTXDB8qFLhluvDXdumhxFR+u1uceQ/8d3DvWHMLtQE8mdQj5p40b
         y8j6/JVhGIcF2vT32AFm+isHT8RKKKQpw2dPMjC1xwQ6PNph7DpmsJBJIRAtYHqcv91J
         ewtczuR+J73YtDuq+/nD+GxScCGX3781Xb03+v1nAp8BKf2oHAWI8y8bT9tarWjdWuWp
         sMz4RjASfkBQD4pwGeDvd+60wRzIKXZ+hBWhnLngCNAzNV4oM8lJPT3lrJbyVUHrp25b
         kzK5WSmpKhud/kVVjiEiXATOcdSC0h2NWRgBsLJYI/FN5uW4AiMcrU6a3DnI6uSDJc7r
         AafA==
X-Forwarded-Encrypted: i=1; AL+hErEgZf+ZQ4VlCciwOJV00YBNgAWDBOZIxXKLmd4R2G050aomm1WAFzyyj+yfrh39okDv04M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IrojPqcMBeJITNmr2xlJrUt3sAH4ywUTzGeZGc+rpvJIBg8/u
	nitkm2haOCNxMhu+o+BDTh0ZITvbZhcqHZ0JMSIwCAsvJ1GiCtRunfB/ZiO/Re1zIF7jBslyeAE
	6IUNPZYVu1VV7pIWiTJCCwE5Cuvh1ZF/YtJXXihiLTw==
X-Gm-Gg: AZFdTZeCmdp4b0xPjhVjCNlBw+MEfi7EZf6ArRLYzqzNmtptAj01vKNz5GAu1jRsRUr
	XgaKX9O9TdeGgiolDFA3ruKUaga2nBkCQpuqhSiUmvTiKmc+rsKQQTttUPuf/gbT8iKy0CDUo3O
	RecIeYsZnLR64qQaL2uNG1Ib08k9VImeUO1dY1O6WMR2RyU+y7QYPH0aKaEpfoogl0/Oz1t/z33
	1+vsWkiFuMP7wKG85QrSjteuCyX1vyGq/eriPg01tpsUa/ME3E4V8MXnQncGWr71cXDOH4J8R5x
	ME/YjVf/G4K6CfuBr4AwfAfcQVz00BoIc5blGGYZxgbiEhjnipYgehE8ZyjaR2bPLioEfRk/CW7
	jT87D6uv7puF6Du/RNZRuF3l0QSkJk468CX7JnEChyVAR/wekGiLOjxCotNb0lpTuEYgOqVk=
X-Received: by 2002:a05:6402:1d4f:b0:6b8:80e3:d58a with SMTP id
 4fb4d7f45d1cf-6ba37d47763mr12051266a12.23.1795571232474; Tue, 24 Nov 2026
 17:47:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2323.git.1795246845186.gitgitgadget@gmail.com>
 <pull.2323.v2.git.1795497145494.gitgitgadget@gmail.com> <xmqq33sqt7xw.fsf@gitster.g>
In-Reply-To: <xmqq33sqt7xw.fsf@gitster.g>
From: Wonseok Oh <wonseok_oh@korea.ac.kr>
Date: Wed, 25 Nov 2026 10:46:59 +0900
X-Gm-Features: Aa3M54pY1t67Pf6d67vPEJ4iTm0ata_wxjEVrfx1DI4yFkUy2ilyWdA-2OwrGDM
Message-ID: <CAD2pp5v4dkHbwxZ9UH0jPeG+3hMaYCQ__QpN9wSUC1L1tZDL=g@mail.gmail.com>
Subject: Re: [PATCH v2] fast-import: die on EOF after an inline M command
To: Junio C Hamano <gitster@pobox.com>
Cc: Wonseok Oh via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Junio,

> This describes the problem accurately, but wouldn't the series at
> https://lore.kernel.org/git/20261122140347.41990-1-gitster@pobox.com/
> solve this infinite loop, together with a few others?

With your series, v1 patch no longer gets stuck
in an infinite loop on the unterminated "cat-blob" input.

If you prefer v1 on top of your series,
I'll go back to it.

Thanks.

2026=EB=85=84 11=EC=9B=94 25=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 3:12, =
Junio C Hamano <gitster@pobox.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Wonseok Oh <marinelay7@gmail.com>
> >
> > After "M <mode> inline <path>", fast-import expects a "data" command.
> > If the input ends there, file_change_m() leaves its read loop without
> > reading any data and writes an uninitialized object ID into the tree.
> > fast-import then exits 0, and "git fsck" reports a missing blob.
>
> This describes the problem accurately, but wouldn't the series at
> https://lore.kernel.org/git/20261122140347.41990-1-gitster@pobox.com/
> solve this infinite loop, together with a few others?
>
> Thanks.

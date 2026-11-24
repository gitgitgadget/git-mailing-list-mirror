Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524677;
	b=VyOZiA+9DVfoneXHcfN6/wxn6uoyhmF0fc4k1UbtVZRgAhtV4Vq3cLGLRZUn9+eSF9bc
	 gTVCn2YJhB1ijdWBCgDyIGAKx0QxBD1HtUQQr1DnV9XPJ8AQJeh/2JkY+qdKGpTLgf5DZ
	 VviRji08wPsaPuPGSN8Q3dMV1TIvYBGXOare5YUyPI7ktlObBEEJP4uQUiukZxosBvQzz
	 IKDa+jvZkXVsS8Ja5TR6/FI6u/rsR3TvUbroJ3ueBH6GolyoOiauouLwU352rh/eV0qAB
	 6xgP3/vpwyWMWBhA+wBIlk9t+Y3IYnUjxr6Akd9o3x//FvZk4g/ZJkGVH5Bst7CNzxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=5mP6pKHMA73GwvUoqmPKV6n/2UbWxSn14NaACtubTOw=;
	b=sNMGx0ZauTiOTyaXqj1MjKv0TFkQgreI3aFXUTPK5IWXDpxTn/vAOvy7b50tIyCHpxNp
	 wXyxtT0DpAHxpDFLNtbLH6Hl8omfaP1ZfxP9U57MC3/T8p53fBI3EjITlissVCSBLq6Vt
	 YNZfiVc/3zp35AWipkFM8MyoNyHBeOIJy9t9+uyL4j/gl3sGYHj0ftBMeM7DCNZvH8eAq
	 gjHSLIxxAe2HquL1yqqrSa8OLExDnMjHA2RS9HFosUsqpPic0noBQGX90/msge0Htf5jW
	 D8rsRDhTKzXMGCjOUSOZPqiZn2/Hw334bIjOdFtiF3GCC1A3ok+xL8HMFxBhSI0v8Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPm9S6Rm;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AD606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 12:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 145AD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPm9S6Rm
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b10d24345dso40202287b3.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795524676; x=1796129476; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mP6pKHMA73GwvUoqmPKV6n/2UbWxSn14NaACtubTOw=;
        b=aPm9S6RmbimMB39CE7wnOT7QZ9xru+MwQkynbspOwX6Krd4b0ufnPh04oILU0vDjHZ
         nS07QAM5QSgv55g4l/T3b+gz3YO9iJlY8bw5ijghpSouizLRGGLWw5i1oLZ20+nl++I9
         74qPDdAn/8pt9Cl9axNKMAJJU39L3E4/EogBK7mqUNO4Zxs1SW3+brVNXr9D7imtImop
         kD4hLWxiK8gV7j1VyPOgYtw5RhI/tcXYsfctegYoQ44deKkvklezJep9f6PdlCdSueA7
         eFhRLy+xs8sc6cFY+jtk1DURCLrNMH23uFcECKaJkgzwBzz5pLlpkZZKaPPCWJPul3ol
         +JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795524676; x=1796129476;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mP6pKHMA73GwvUoqmPKV6n/2UbWxSn14NaACtubTOw=;
        b=d40xxLegaoBldL5VYMAV0akyxJn4bSToMnQx0vmqYGTHXXk+pYuGe9bz4wl+HCM/8Y
         VU1rtabS4wvTzJOdmjfNI1ijCMDglVU00/TpX5wbEwI/C4fi250X93hcVOUi/KwSysd3
         wLg2QggeRLcnQHZpfB0QHe0E8YWz6eQ8zbw0no4vapE7GItu17AL/7qdcXDr/0YQuELX
         q1lgv4ss6vMuTc4ciBJJqitp80eH2GL5wDSfbCC5VSoGufnL6O5KdvW/zXnB04D2H0ac
         qHpqM4s7MZO2HAr+70a+e+i2iwf8dH/EJHGb8Pb3C8De6257kgq9E5arFiQAQJGuo09G
         59Qg==
X-Gm-Message-State: APuU4Z8v3DngwaH3lzgwqB4pGhpcwNAdxSU3s+awwZKGngTMHsQRto+i
	XsHGv17pSQkEsRVrxYt2lCRcveM9DX/ZQVTsmYbb7kfArJMAwtMpHLeQYpcR1w==
X-Gm-Gg: AZFdTZfOrJDu3rNjwntfS7/6eJOVcw/hJxw1kXdDCltyRe7DOS/mYnkJnxlrT4UPldw
	8F6dOlD8TMmNZMF2Oh4Cy+VJ6yycZC6h1zU4iUozTxu8Kpc+BPU0SD8MYj7Rz0b1Qv6G3oOmPeI
	JSSpFu465BAzoOxJh1BHiZEYVRx2nyqtdWNYIE614JYI8YurG4iMTPgudwa6YJqZ7lVMtiAHpwV
	Spz/QXyc5Tn19ydxqRNVDIeIJfeRZCnnBtOViECnlrEUofJehlU5V9eLZomrMT5diuorHfPy9Kl
	KNGqeiJ4ZX+Dd3DF4fDoTuuVaJFIkxLo8S7oA/DBxwXs0+A5SGMeePaRfRk44V52E78eYE7YdBz
	4JJUYW6MyPUSvOWV/T0DNytwSYx/XTHMUVz/7wG/KnqP/H6XVxprdt+nirZFRbSxjBAnZ0I8PWq
	+0o9j2uoyY00Y3WtBNfxPgp9eKOlbdOwGtX48qkcL1bO+GUrkjMXPpTQxpYksbU+jU7jTIncQQd
	DE9bzKmvZWHYGsGNlGiccAl92kD/FwSwhTiqqucCbJE6uf9z1QwiiSmwdWC/PBi/BVkE0JoIcGa
	Poaj9dFH9kmEsso3EYCIMNPgaPVkIb+p0Ea4Pdq8FC8WtN73K+CvaRykShvbWddr04fDUlO8Gta
	jKuU1ADh0A6Tpm711r3fQvL0CzoyMo8qHbZhpp5IzL3C24gzasYCspBc2kmRWh+rgPAdqFmIp13
	YGzQ==
X-Received: by 2002:a05:690c:79a:b0:8b0:d3c7:52e9 with SMTP id 00721157ae682-8b5204aaf3fmr56664207b3.36.1795524675988;
        Tue, 24 Nov 2026 04:51:15 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:f854:fa55:5df9:927f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bef08sm58197337b3.20.2026.11.24.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:51:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] t1501: don't reassign EMPTY_BLOB and EMPTY_TREE
Date: Tue, 24 Nov 2026 07:51:04 -0500
Message-Id: <EFAA4505-5C65-4DF2-984C-C3DC07A44124@gmail.com>
References: <0e64c973-4ad1-4eaa-938e-f9d60418562a@web.de>
Cc: Git List <git@vger.kernel.org>
In-Reply-To: <0e64c973-4ad1-4eaa-938e-f9d60418562a@web.de>
To: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: iPhone Mail (23D8133)


> Le 24 nov. 2026 =C3=A0 04:16, Ren=C3=A9 Scharfe <l.s.r@web.de> a =C3=A9cri=
t :
>=20
> =EF=BB=BFThe variables EMPTY_BLOB AND EMPTY_TREE are already set by test-l=
ib.sh,
> so just use them.

Nit: downcase and?

>=20
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> t/t1501-work-tree.sh | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
> index 8c94ac2e70..e6f43b0fb8 100755
> --- a/t/t1501-work-tree.sh
> +++ b/t/t1501-work-tree.sh
> @@ -5,8 +5,6 @@ test_description=3D'test separate work tree'
> . ./test-lib.sh
>=20
> test_expect_success 'setup' '
> -    EMPTY_TREE=3D$(git write-tree) &&
> -    EMPTY_BLOB=3D$(git hash-object -t blob --stdin </dev/null) &&
>    CHANGED_BLOB=3D$(echo changed | git hash-object -t blob --stdin) &&
>    EMPTY_BLOB7=3D$(echo $EMPTY_BLOB | sed "s/\(.......\).*/\1/") &&
>    CHANGED_BLOB7=3D$(echo $CHANGED_BLOB | sed "s/\(.......\).*/\1/") &&
> --
> 2.56.1

Nice simplification. A future reader may wonder what sets those,
but git-grep turns them up.=

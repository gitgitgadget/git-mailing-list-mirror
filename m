Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792441271;
	b=JyTBU7bEBIOGewD/SWx2rZUDENnJNhcPQ8dtOj2jCOPLgr1p9DFl/dWPD158FwHJn7FV
	 vuA8kAbS4YJQfYe0CncL0wyoMMw71i/zVs1njsUsTOufTmP6DmVGd74HBRx5AgdTzg1yI
	 CaHTEMUMEIt9VHSwWV9N0Kezk9DOGfZne937x0k9MWRMOgt3SjRCU4CdvFVTgBTsxYFQZ
	 TAnXn7yKvuF5oeQIwu65ZTN4Z5/3DxI9rekXnLWOPHX/Pod/KQFKLcYmnZ1YbFPtAQrya
	 7onLvn/ypTK9+j6YcjHBx3zT+CqJ5HcfAICJY9XMYzBqqrntA0GY203RP9rEti8LeiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=dv7V1VIynB40olmQ6FUI+qHaMx8+ue8Ay3UfSv336Hs=;
	b=rySxRA4rIv1RANLySTrUq+6Q3GGevH7GGntP4L8gj5TCj85XZ9z5257IN+6kct7xGLOU
	 DBBe7oD/HG9U+skg9MXA9W+NZl9T0dtLsA0r7x5eFffngVC4PEHi9dYQXPafWJQRa/cYZ
	 bDKMF17PdDsFiOTZEqQU47mSRnPaPocyE2BFeFdyLs+RZZEcUzQYrqqAP/WIt4BBCzoZ3
	 F93bzWzGHxSOLc1njog43WGDmbsffMKXbYsnDYsGzHCrQCzb3/CITuqTay9m9/he/V1Mj
	 w3FAidy0GOVsuXDFWqpOncq4DxGeXZfza9ypzfqrENJmpbFzplC+DYo7+P/futVvtiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iEFmPuXK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E75606A31C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iEFmPuXK
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9906034086cso731759241.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 13:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792441270; cv=none;
        d=google.com; s=arc-20260327;
        b=RIw2tH3Ka8hRW+WGCwLpGIQh8cHc5xyoXL5ef3BAQs47b82BO20PE75ooh1oazfg3a
         8GKHz7gDQOh/iS7XH78mxX61WpLbQfBNPYF8SIA/HUBFD7CSjYZONOcW2wUI94iAS51c
         6bYWFOBUmrCxdJdPGMx0rVJ/7IvvknjUK3qHk+KkBTxAfzXev5Kt/VxGQpvYTSvlab5+
         Yf+rz3uO7busxxS5gKULmW4G+YaLpASkjr6vs2+/vx3dMbQ7UiKTfUV0nZgV/UNBOgYk
         UQc4fYdLsx2DZvT1PLAS1oTaEpNGvLV984Oh8eWOW/drNbD7BR6an91EqqzIGQExdCvN
         pxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=dv7V1VIynB40olmQ6FUI+qHaMx8+ue8Ay3UfSv336Hs=;
        fh=WGDKR+0iJJtfN3CSchtYn/f76Xek9aK5t/xAvE91EcQ=;
        b=p1jFLSDTe8EqbGU0tiBFUP9WJTStEZaALrsqBGAnvPsjXALcBoy13GbHCKlvKVKTA2
         0uKfPO5eB9Ms/U+v8uyDgxNWcnJ2d5BQyAdgRSU5u9hVvmu8Inb46le6Dk3bXhMf09CI
         v8OgJWqA6dTPNVn0blkWwBOPPNOjyXmgg33nc0UmWH2+PAVanAzbZqoYoAr/Uv6YeNwZ
         wL8TG4AtIF5LzThCO+lKGlk1wbU/6OnSGvfP0OKPUCvQItde/OSyFSMCWxbNkbrmz5UN
         3cJ6/XU/cP6ySz4fHv//PCfVMCnM/VI9RytfgiJkPmzosf4lK3abKp9ftzY/WA3/ZTkA
         sDTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792441270; x=1793046070; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dv7V1VIynB40olmQ6FUI+qHaMx8+ue8Ay3UfSv336Hs=;
        b=iEFmPuXKckzz0GoGlj6yFcsyc4KoDHmoHCLeQH/EuL2gAgPtSyiZdN+PESr+KWMJOZ
         eSy3LkZigkcythqPPLVkoI4zqBJ19dz1Hzf9/cAoXXvbQrzgZy/uySHulRtdT/tFupqC
         uwsUYVfKORCpSn26s8AHQ7/IuB9v3zWJE2Nv+92z/gEjp2bMyfV0p7rCDMhCVUwwEEoX
         OFSd6TEreSPwUERVnKgR1QC/QIffcppPnvUMU3zFIdvpDXgLySHGnyjudD05m+uX30LX
         4p0U8ySH3fvfUFmD0WDJXueCKkcWr/ESwHvuaWdaw7Ahoh8afvIbbHa8eMmS+c24OnIl
         BzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441270; x=1793046070;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dv7V1VIynB40olmQ6FUI+qHaMx8+ue8Ay3UfSv336Hs=;
        b=Foo0T2vYWAZ7X4bp/yaTnRV4h0X96lq6AxgJ3xvZICgSxT5BJqcVXn5kKsl8inpJgf
         CvQHJI7zN740G8TlRnLpgBTTMp6owYni3RoROHFs18PTkN3HpO1Mfs1r+Q1Qt6cLig6e
         2SQJS4ShkYROJwFc4w1Wk0zD6hwQDWgw0uggG84Pl6c1Ur3MA6/3XjiZGJ+v8FM12s+G
         KrlqdZgxA1Vn2lD+v+bS9/dNntApJo/tuWGZb6wnIzh8IC/Zn1Sy/JPVmIqsaEdlADfH
         PRc5uGuqz/wr5oEPI2SeZJoUIaoomaAETtQD2WiO434nTECtjy525TB9f53DY6KyUAcy
         cpow==
X-Forwarded-Encrypted: i=1; AKwUvBzn7ibUJsbQLTkFANlbBUYFj8Ha182lsALoDdcZtW4t7ose8e01bn8sjDjXcf6QlgERa/Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9i0U617gi0+sJXx3/9z7T6uR73AE2otEUlGhWrADddkDm7EvR
	PGMDdqJiHcaeWi1M5l0lWGp2x8ZB80ab/IHViH/wdexQUu4R5J62joP49xiaf1U0gbqJwGCiErP
	zkcGX6VtE6cUmKDjk6q+SY+U2cPjKVu5MVw==
X-Gm-Gg: AYBFou25Zr7BMtkqqt1a89tSY53XQmXn2LVxik1k/1ADpyWRG3//YxZOSdnpv0qLH7a
	K34gZeJq0J4vTa3VH1X7e9N2rNT5us7Jqr3K7E/2RUYutNR56KoxyiGTPXYK7Zrum6oRskRXiei
	fDnBLG+hHzscjN85QKNkjlyjEBS0L7xgXUKmeDB4usseIWBfKmBc8E/Uuo4xLRmK95XBLWznZUs
	xEwUJMUiMoTrSzkQBJ85b4fSE9+Vcv6zilem3Jx0vlaHsRQzGlUCcZozv8g7EJS04Md1VE5ZQH/
	5eAG1sOiyFo8EMoEwdJy6RBy0cZs0SJsxewHQrf9alR7OrKNDe2f3VFPOOJ/koxP6BNkibg73yt
	f2Utf/f9txj9aFUb5mM3FSpkPfEGzR7w6Hb/4Jq8T+SXWBcpK8L0UBl+ODw==
X-Received: by 2002:a05:6102:5488:b0:7cc:2bb7:1321 with SMTP id
 ada2fe7eead31-7cc36aba539mr1890574137.31.1792441270235; Mon, 19 Oct 2026
 13:21:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 13:21:08 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 13:21:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-1-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im> <20261019-b4-pks-odb-extension-v1-1-143a5963b77f@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 13:21:08 -0700
X-Gm-Features: AclHuK--fYMeI-kpu1yo6bK-fxHFC-fo1rrgw9al6LmT4gN7bk_TDwBmV0rZFUk
Message-ID: <CAOLa=ZT91C0OZE=h7B0j6mgPhfrGjkRN4bCT9gVEXdXx+bSi1A@mail.gmail.com>
Subject: Re: [PATCH 1/7] loose: drop unused `repo_write_loose_object_map()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000031989a065e374189"

--00000000000031989a065e374189
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `repo_write_loose_object_map()` was introduced in
> 23b2c7e95b (loose: add a mapping between SHA-1 and SHA-256 for loose
> objects, 2023-10-01), but it never had any callers as loose object maps
> are instead written incrementally via `repo_add_loose_object_map()`
> whenever a new loose object is created.
>
> Besides being dead code, the function also hardcodes the location of the
> "loose-object-idx" file as "$GIT_COMMON_DIR/objects", whereas both the
> reader and `repo_add_loose_object_map()` derive the location from the
> loose source's path. The function would thus disagree with everyone else
> where the loose object map is supposed to be located when the object
> directory is using a non-default location.
>
> Remove the function.
>

It's like the function being unused is an insufficient argument by
itself, so we also talk about why its incorrect. Made me chuckle.

The patch obviously makes sense.

[snip]

--00000000000031989a065e374189
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: df0f047d5a3d6d30_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yV2U2MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVlUQy85bjhUcjVXalo4bGJwblMrYlFRV3UydDdwRQpVVHcwZ2JaWEZ1
SVFQRkxQK0pHZkNaU01OQm1zL1JHbWlMM1RFZnh4bFlrbi9lSGxqNndoejFHUVUrYWYyaGV4CkJN
MkpybDZCazEvVWFwUDhXREdVQ2RVdVhVTTc1dGpqSjZwT2xOVDR4NFRVOHR5NjRCSWpISDFrUUY3
dDRTVkkKaXNJeXhUSExrc1pBN0liQ3RVMCtjZ0kvVXlZSjl6Tzc1S0hLMWxqNXBOSm1INXlQSmx6
QUVDMzMzZ3htL1hoQQowaHJDQnl5emxZSDlYYU40SUg3RHB5Slh2M1BRanFWd2ZYU3NpN0d5T2hk
YWtSMDluMldTSjJwZzlCTVhjS09QCjJ4ZjBWaDJuUVRZQ1R5YzhIUHJTeVZraVkyc2NrMWFZV1gy
SFc1a0k2VHAwU1lDN1FUek96YmRqeWhvQXVTdEUKZUZYeHNwbkZoNTF4SCt0dFM0a1FRTlFRUVJK
RXdicnF0L3NYZlI2U3gycFN5OE9ZeGlBN3pmSjcraFdHZDZldgpzZWV6emlGalJSUG8yczV1bExW
VUNyTTE3Z08zTUJLMVhYVDUyaWdvSXZwMEkwSTJubVZhcGZpWTN2bWdzZVZuClNzckdwbDNFcEhL
Q25RVkVKRngrTlpMYkVNRnlJRzgxVXdyRmRsTT0KPTdzTVUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000031989a065e374189--

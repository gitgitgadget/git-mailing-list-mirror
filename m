Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9803F8883
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856997; cv=pass; b=pKjDXnvQbEyE+yNLlu/h5pyKhqVH29ObfqZGr/IDaP4p7ykldO8BEig3HkJ3QV4f6hCy5l6dDcv74ah1IBYW8OKQsDkHGc97WZtBsAxfawfhrnqaYzmAZU3ZU3tbKlQxOIJPVMZIPkpVhRm7ZC+vDNkpG2liy3PcKPzwewcLozc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856997; c=relaxed/simple;
	bh=lrOLo7e+glqFHwTKO1G+eFM0HuFAr5MBGBQmx2NQS2A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCS0OpYJHt46dafjka1/ZlAEstAMCSd/MyWXwzc5WW/GEBAy/yxIVZzAVNlLDrwmgoxzmL77pMxKgR6B2XwODj57YATDxjvbdQx0K6FvetXSXl7buJJCynAxurevCgf0DmJBVdIbJzlOxLd3AlAXGrdfLBm0LvEtcB2Y+qP/xmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETHv8wRW; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETHv8wRW"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-738bcf9a573so1561797137.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 08:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785856995; cv=none;
        d=google.com; s=arc-20260327;
        b=DilLJtGDkaqW2pbfyRzkoTK2MfOAC0KO+2fo9/2xmjcdpg6npOL1Et7Q4icTb5N4o7
         hLZSyIa8SvbfOyNKPS3Q5kGYEjsVTC+y95QFL7oTHOGQhIp7m1nKCX7wdw8t5ZomoHCI
         L1M7lnLNyOvuefykjtuymSYKU/F4SDL6DsQLDumtVh4zp5Yal1xeQ5HFW1myw+XLsOou
         cg88whozIo0rUffDQzHyG/Sk+B4cnlFMHtXUt8Z0wBQp+h6/zHM3iN5xEmtSFJ9rb5YH
         zJoYp2q2JsR8c5a0ATfLDmYqT9sjHXkEzvKcurlA3ac0+c8B0U2675AFxD4aK+qlx1vN
         GGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lrOLo7e+glqFHwTKO1G+eFM0HuFAr5MBGBQmx2NQS2A=;
        fh=1nG1bbBeWcjtZS6hn0Z4n1kHGcNU7MzNe/qxi22xP0U=;
        b=kcg2mJZA25aOr8QE/MCACbubNc3GFbhX7qZ73k94boZmrvcSJw8F+czCC0GOUxBEQ4
         VStJriLfXipXdNvzIUV5Csqzp4dT3x2848hLg2Xwvxtx/jMqPn2lBxXaXzy2q13FQmUK
         Zz7VYWn+8palVJ+7nPDnu117QnF7x/l0OprRnsDQq8Dq1qKw8/m35rAS+PUp7Kd74jV0
         jnjSM2cROrWUw33gxtpEqiYTdoPmqBW0yYxMX7vbWgo5CJb9/oc3X/rfE80TsP2p1hFV
         p58hIRZelVSBj7M9sxSpekcRblSbAUXbczFt493wFR6bU6PijqM2SSbmthU5F71jOy5g
         NxAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785856995; x=1786461795; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lrOLo7e+glqFHwTKO1G+eFM0HuFAr5MBGBQmx2NQS2A=;
        b=ETHv8wRWKeklYQdWdITJf57Eo2Jgq9iIMAmo/dyvQKSZ8qzsI3l+br2TLtLiAVc81T
         WKCWGUatPn/JIgUDOHcbeUIVW6veLx13ikws543t0fthrcCKDEpG5L4aoymanQwE7NQa
         zmEdiV7yc5gfckxEZrW2Z6Zifp3UMpUfNbBolCg8c7GXpxOobpFvSuoq0kFNSC+dLKWa
         11c1MSZlXQDo2oTml9bSu842wA+nm9yCY7NpMD5sImdXoireUFGa793PRVRzmh/05gcS
         oMAFvsGvjsWe5Omnc/BP9QIJaVdAK4mLeyFYKapGY/eqbxVtkVyRqF5gd0JuWu/2B3hU
         C5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785856995; x=1786461795;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrOLo7e+glqFHwTKO1G+eFM0HuFAr5MBGBQmx2NQS2A=;
        b=YiSgs2Ts2Ri4p2jPS+bhwpgUWYI3ZIh6Sve220muYj+g4OSGqMCbK8eySglqO0uATu
         Nznz+jFwSvtXXGjY7j9EOKVLJPgRwf1KxFpuDvUEkUzQ5/vIo0MTHI4GKQeMsWTHwZ5T
         GmDDeAJ95EuvDYdS/raM24WZScgJBzbfhWT0NH7aIZ9xrjx3YfhG/57E0/H/Itp7gCgf
         puDIG+BAvICLWt8RPAGbpEUxE92z3a9acsEsySEmxe3cH0B4zf8EVwpZGxaaadvyv1pn
         GOKUcByaBo4ESVetbqqK2DMELUoPXDcootO1KieR+DAN8aEACVe9dy7hiQexo0Wuq9Rs
         1UBg==
X-Forwarded-Encrypted: i=1; AHgh+RonOptTqvNc7I00kJAHVoH3mv57j8jyiW4q6LtMTSX5MCDNoebDjfiXDB0L24kTrHumQ7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPDYLioAOB3w4rsPcMIr/busrYGz42HcjjYBdqF/0JdDMVUoi
	FETWUIC0cL+HaVJhd+K7uts8TmWF+0ZwHWXCjHzB+iTR+VHCz/CBCvdn+jZcPWYz4pG/BRNnMT3
	fpx7JmuQLMPCHHILCsoV6Hp889ufQUy4=
X-Gm-Gg: AR+sD13x3dxDGC/UR41seSNGXhhb+kJASOkwPotO38wRjnXUBPOlRKtsM8hX/UyE7NS
	WOFychn/AOCmA0obt7vZqc+rOPt9weEi5RvuLOgd4acGJZKzljO0pwOAANUiP/Rl/iOBIKtg9EI
	OJQqwKzxA2o2INjhnJvWcb2kDYHdCbiqwCQ7XJa51CYFSEMwOx6eBZzJhmloS/NMTMCO6plxYC+
	ENoPhnKzm8YhQ1JSoEDWBbbaihxExSKfoYXa/fvYT4vC2A/IG8lMTo0BESctCfdFeXk98nccoGQ
	561VzI6mx8VJLUbT8umvNGjoTMi0H8oQwHVRtVdxaRRlscUnDWO4LS7N2sr/RUjYtx55tw5LM/W
	egSQwTLRbJU8PmX1eeUqU48Oj5KKafS4w8FM=
X-Received: by 2002:a05:6102:1086:b0:760:418c:8a9f with SMTP id
 ada2fe7eead31-760418c96b5mr717927137.13.1785856994889; Tue, 04 Aug 2026
 08:23:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 10:23:14 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 10:23:14 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-3-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com> <20260803-objecttype-support-v3-3-7176fecf7950@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Aug 2026 10:23:14 -0500
X-Gm-Features: AUfX_myw00bsPsmLhS38-AqAS3Ox1X49GGGDWKF8afwJgc3kdTrCtav4zXb6d8Y
Message-ID: <CAOLa=ZQbbziEK8HiPU7Lpsn0NmWfEnh=-L4wSBFt4qHJWAbJHw@mail.gmail.com>
Subject: Re: [PATCH GSoC v3 3/8] fetch-object-info: pass arguments directly
 instead of a struct
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, gitster@pobox.com, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000ccf3db06583a3b5d"

--000000000000ccf3db06583a3b5d
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> struct object_info_args groups three pointers that already live in the
> transport and are given to fetch_object_info().
> Grouping them into a struct reduces the number of parameters, but it
> suggests that fetch_object_info() uses all three of them.
>

But it does use all of them, no? Not sure I follow the reasoning here.

[snip]

--000000000000ccf3db06583a3b5d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2a4cbd4d35a7d50_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1weUErQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGxPQy93SXgwdUU0b2I2ME11dm03eWRIUFcvdXpRZAp0YXZQeUZGWXJE
M2hWdkVWUEZwTTM4RW9xZkNtek5sUVBaVkNXOUV6M0QwalQvTUFwV1AyemhWTDg2SUFKcVJUCnRt
MzBzTkl0SkVhU1kxYkduWmVVanRldjFhbjdCTFFVNWpYeWNWT2IydnJ0VE5aVi84MkRsUCtiSit5
S3RwYjUKcWt6T28rRWJySi9Xc0Z4aTdjUnNSTFZvdGtkSkJqWW1iVWpySUduVXc5ZGJQY21NQkJY
K0s0cDR2eWhpcndMUApPc0tMMlJPNU94cVY2RCtlbEtiZlp4WWE5T29Mei91LzJhWWIrOWpaV3d2
UlVWM1V4MVNlaU54SWY2N1RkaVJLCnFaalJDc3lJMkNicUFJdDgwd2tpTXdvd1ZGRVZSVGM3T2tL
UVQyNmhrVGhyaVB4MkZBSyt6aE00QnBzWFQzNmMKMjZuWGlLNUM2cDF1RjFqUlIwQ0t6YTFZT3ZU
bEt3RllLQVhlb0pxVDdmMk4xTXBubCtYYnlMSk0vaHo1aTM0NQpPemxwTnhHZFpyTVpkTmZlTktH
NjNreDBnOGY3OXVCWnFuUVU0amVoekNDbk5UM3RXZlhlR1JKK2wyajdabmJiCmtlTmQvYklmYWR4
QWpwcWw1TWFab3crOEFFeGdtejRWRkIxUmgyVT0KPStIejgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ccf3db06583a3b5d--

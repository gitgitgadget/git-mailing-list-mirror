Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794396181;
	b=vFuWAUL87sbH1iyd0z7bub5URSFK5hv+8fHTVO2vZaFv2VRm+iz9vbLJsfx3TEam3i8k
	 a5plBX4V59HZo/x7s8+eoV8kMNLdmzptPa//lFk1EyXqhV5lsEWauDPfMTTtr2HGHCFxr
	 MaKN0jcqxJN6thUNAc/UYMo0m8r5Z+8TKB/GJXAvYX/uyZ0PKqWvXjGXNqqgCI/3+pV0r
	 qn86hwlQPP6QafmrYFq2vUdeDriCsWA1OeSrBR0vgGLdOOt7on92PgrUTQVKIjkAzAOWa
	 KJwJisyicHwv9TMCxhPXN26Svo7JR/fAjF3YFAsFhiijI6CCpjDgQQAuLr+ZFBB5mJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/t2vfNxC/YovStVV5P1I8vPlVRScxtu+MI948K4FvVo=;
	b=s7u0D/cKn8lllqV+sg5hT5UeYsZwKZCip7oUZNjceB0Qly9+TZYs4Jl1t/UCw5rBNeF8
	 4vKwwgWh+L+2522nuJtUk8cA9RJfs6WlsFl/N+xw11E/spws1qvakF9Z2NNbSKZKIHURY
	 Lg2BtLVpMuufnJzJ0ENEluP7gix6Yc2OoxDFGlw8pbXIa0YI3ohR8mEJwhcoY9z9uLsMC
	 8+uIUmGC6i+jkig6jcvmbibHNbd8M5aKuDXwzJ9AReWtGIHDVV7ZdrxbSUp7ouUyoePLY
	 /2meATHuyB3Zp8ozGZ3FHnsU1xcWrbCQea/DF2lXfVV6K6uK0vLbAl38+9DvSKJL3HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pxn0zoZ8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EB606A332
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 11:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4EB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pxn0zoZ8
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso1226616e0c.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 03:23:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794396180; cv=none;
        d=google.com; s=arc-20260327;
        b=qbuMfL4T4dww7/B1aoTssIw4y1Avss5zk5rRPOjwu6J3eHQbxyFb+XMKVkrA9Kh0RH
         qZU/9PW8nYpt58Mjn6701+EoRe+Huz7Rgbg0H1ye6nFOBAImhIcanuRKhBpGDYO5DkRA
         2l3Idnz+J8ZrcTp4l7ZvtLjed2RUD6v/BE+7kfEKb64E2hNjNmKuMSLYKYjahQ1KjqYF
         AhDebz0A+MYEMDvlk6G+nk2pMH7TXCqcmb+ivUt6UeEbBsv3w9khHgB18owBzoM1B42t
         riDo6faMa7QtUUVujF4KpaMb8vMxvefB3J719+q9lCjV2qROgur/oVDtpLPjeaZwSdTz
         TvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/t2vfNxC/YovStVV5P1I8vPlVRScxtu+MI948K4FvVo=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=PdKTvV7+JK8nt4u45WgCA1RQHk9yhUZ+hT85YF0fn98Iz2IPtjOpPx8go4pGbCpETB
         GBLmQstYgeBva6XRzBW7FCrszLqre0hXsyR1Bjb+4197l9xJav0eqwmrrX4wMuHD7X+o
         UoMMNCKNfhPLUJKKn26tXUqYRPKLc++FFDphLjnSAwil3mW9W4N2ToTiU7yx0jv0yCbv
         u1DihnxLWBic0XgyMIeuJ178JteGGEzF1Nhrqjf/2ehrOoTtuNg6pEy9hX3Xo2rAl4DW
         1pnphEYQOtooJHoJ5c9LJMtsmnTQbdmCDNmiKNtR45F8U1IB9KVtAuPhgPSNKDo4EsYG
         Xpaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794396180; x=1795000980; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/t2vfNxC/YovStVV5P1I8vPlVRScxtu+MI948K4FvVo=;
        b=Pxn0zoZ89JSaLSJ3dkSbpHu+36bsbn/WIy43a0ayW1l1w98kewN6CS/waE/rH6Ui35
         XP6yER71T8Z2Niseh2XhMzkpcwPVZs2hqgJL5mcSHjcg6gfHoiI32IwemfLIjo9fIJP1
         cz2Q6+Ks8Qc09nU0cjoyTYDVpj4+LiAeHYqM1DwxA2SXznI32O0FY68KzGT+BJsGXI3L
         V1IOZ++QGFL5OB1r1jd7F3ySYR9ew4AljaNGGmVfN5JJ0HcD7fU4/KvOeW+Xb4bEC6cF
         QLYhGP6A+sc0U4BQ28a8HYHVdBQKFV600D5fHyf1D6qDSBFH/DhRg4zeqf5oMr725YET
         2fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396180; x=1795000980;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/t2vfNxC/YovStVV5P1I8vPlVRScxtu+MI948K4FvVo=;
        b=KCCOnbh8da8X2DjDIEIgRO4fQh2PD4r4S/BNUE0lnE6KCSLfWw4liLS9NxVV1bogyV
         pOVfc+TgMj34dz5N/tcHb9Cf9/eVoSpbnHjTCrwiBLqU7Qgac8CeSTSyXJ55fWzu/PYV
         dp5v8L0EJOxWPTTGGS8rq68KUJ9Dk63O27GFpHuYE7K/2Z60cJrus9LmE50H7sqMMfnv
         4Xrb3rmn9cn8x0e5d7+AIjCqEe4N88M6o6sIdipIaU/1jzw0D4BIb76tZF8LKq3+kv4O
         lFFXjK/5YM2MMNuG5yKcXnMkJ91fXRq8/Kgq9r/EQC2iAhbw0XWCTBBcxMzpP74TRixg
         kJmA==
X-Gm-Message-State: APuU4Z/Zp/IWnVkAmTjlqCzmLt2/VNXY3R/aAKVxx8mAQJwSpmiXY7HY
	ybgKQamvc9l5ZHE00zqa1AS7Uok80LYGg+A05HqDs3/47GY+8DCEJJ2F4lWlzE/02zolBxaXBRF
	578e3Rm3CPTdOlGx52/E4rM6DY7srP8oVFA==
X-Gm-Gg: AYBFou2qrifpZIPW93uAbsPZPCHg8RwhwAsVepGWUD8PBiLsd7NpJxCVBEcDyibdVNS
	DkRXAnw0tnHUCbY/5pbZ5V61PFhkM22DdxS9vsO69unl38JFwMWV7vxJiush9z0uJIi4+pz9HYU
	NrwGeplxCAeGQOhleafQBTH8lQcbTpTFMWzSEf+lY8iSL10K8rJ3psJ7Syw3kfteEeO43DrvZ/b
	2Ilz3MUsoYopXok1VdqGMd+uI5JqceKVvkAizyNYKHTrS+RceUUX1vV9BgLWc7kkaZ3/y6EsNrE
	yYrAH4VfVGkL9WFdTaB/hhJsa1rEsonVb7Bu/7I9jj/prUlhPz5G+ijacBM0TiNQPDXZskYyUMm
	6vFmIbJ3aJ763lk5Y5hBX0pwy8xHa0zV/zKZ87G4gZp7c1l6+VavygmjrDgB2HSpnUk9YmC49La
	Kx0KjzaN/f0UZX5TSLJhV8vjyP9Os=
X-Received: by 2002:a05:6122:4690:b0:5ec:3e18:a188 with SMTP id
 71dfb90a1353d-5ee1c2b2478mr679004e0c.1.1794396180055; Wed, 11 Nov 2026
 03:23:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 06:22:59 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfqx8qwmv.fsf@gitster.g>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
 <xmqqik24tz2x.fsf@gitster.g> <xmqqfqx8qwmv.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 06:22:59 -0500
X-Gm-Features: AclHuK_8EDMJFygeoiYgpeYMeJ-2-2RICO1b_wFcMb0aBAdIuMRp6cGPSV_bLP8
Message-ID: <CAOLa=ZRHo810k6dJjYsf2ahkVAidEeXNtXjTXUVyApmFLhus7w@mail.gmail.com>
Subject: Re: [PATCH 00/20] t9300: group and move tests to other files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e64f4b065ffe6aa6"

--000000000000e64f4b065ffe6aa6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> While reading the git-fast-import(1) code, I stumbled upon t9300. The
>>> test file is around 4000 LoC and each test has some dependency on the
>>> state setup by previous tests.
>>>
>>> This long series unwinds some of these tests and moves them into
>>> new/existing tests based on what they exercise. This leaves t9300 in a
>>> better state. I think we can do more here, but I decided to stop before
>>> this series got even longer. Based on the reception of this series, I
>>> will follow up with more cleanups.
>>
>> Wow, cleaning up this script is long overdue.  Thanks for tackling it.
>
> Having said that, there are a few topics in flight that touch this
> age-old script and they are already in 'next'.
>
> (cc/early-scan-options)
> c2b4099f84 fast-import: use early_scan_options() for --allow-unsafe-features
> cc4affc5ee parse-options: add early_scan_options()
> f7fd8656e9 parse-options: extract lookup_long_opt() from parse_long_opt()
> 6aa1fb2271 parse-options: add parse_options_takes_argument()
>
> (tj/drop-no-parseopt)
> 1db50e0e62 t0012: catch builtins that keep NO_PARSEOPT after conversion
> 5d735e50ef git.c: drop NO_PARSEOPT from builtins that use parse-options
> ee68c316a7 parse-options: answer --git-completion-helper before command runs
>
> So you may want to rebase this clean-up on a synthetic base, starting
> at 1891de46f7 (Sync with Git 2.56.1, 2026-11-09) and merging these
> two topics on top.
>
> Thanks.

Ah, that's something I missed checking. I will rebase and check for
conflicts. Will give it a day or two, since reviews can still happen on
this version.

Thanks,
Karthik

--000000000000e64f4b065ffe6aa6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 798b32062c37fd96_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMFVCRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2tEQy85ZFk3VHBvZWNSOFRrb2pOS1B5M0laL1VjeQpZS0M2WjhnYUow
dTNkeHArMnJnY0JlWGxkUEpvR2hJL0pDaWszUWd5Rm1NOGh5TXpiWmRtaEtRS2g4NDlUam9yCjNm
eW5KdHdFVWk3d2MvRXNlMG16eHJhLzl3bGpKZkZudllUdG0wd1RDbDArMTJSeGNOVzhGUW81dzlj
ZThnL0kKMjRUZEkzZlh5NVFCWkhFSkM4dy9tUWhCdjN5SW45bC9lTGZnbTZpRUg2TDRURnNJRG51
ZDFlNDhtWXY1SmhKcgpaOThNRFNZdUc1TG91MHFZU0FWcC9UVWVmdkRLMFNabUVvVDVlMk44cUhO
K1JuLzBlZDhmQ1RGS2gzbVZjRVBOCkRDR2JXVS9nN2w1bW8zbEVIR3Q2WjYyeXlEMGNNUXNNa1ll
bm1pT3ozd2J3V29VcFNiemJUNlo2K0l5RlV2TjkKUTc1bG1aUEJFQWtvUnUwS3NITnhoME9kdjNH
OHZNd2h4Mk04eTZuVW01QUFvbUJpWHFtY2VWMjB2eTJYMTZVUApRbUlpdTZzR0ZJY2ZZN3BZL1A0
eUhCR0JicVpPNGt1cEVuVUhDb2k5OG5ubWdMcHlSTGlINzEvcTU1QTlWUHp5CmNwMHNaRGR5Qmty
bkxIbGs2V3dpNmZKK2x6cXhja0ZNbHlqOTQ3QT0KPTVRdUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e64f4b065ffe6aa6--

Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF53D7D90
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090018; cv=pass; b=Wrt3zmHSkO9C6reQoab7DMnmUG7r/vkfhGoerHT/AX2mkObjh12BrW5FfpeBP1eOVWnExkE2neqjQ7hGz6nt/AneUJJwygyaiVUBXVp2L3JPEngWB4Ptxe82uy2FDen7GzlC38YkjS/l9feqgLDrVAnEX8U3+WTEDLbXvDlhJCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090018; c=relaxed/simple;
	bh=0jl7k0GVuCXXZVVK9Oj0IXUMiR7MtFf7V8QcA+OGMm8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuGcIYSWTjPQY0Fn3lFrsx5PvmlsMB+aWWPZeyMMVn0/giGn1KiZqMkgGZvuSDqKAdRsUgQo5Yz3mRI5d3Wl2lYzxbM5OUBFnnoo7ad9QnOtSfpMhO8BD/+orbh4v7VOw9ytOQztOXWL4lRZkE6PneHU4UntoEhkmVuvfj0wpo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izgmj8Rn; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izgmj8Rn"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6c4a2458683so2525399137.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 04:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781090014; cv=none;
        d=google.com; s=arc-20240605;
        b=YJkxTIbaW3pNwr63Jt4Su9vspYcTcJKqU4a4pGsYxRbviRS19oAvbdX0PRLbHdhhRy
         4c8K6Xt1o2u0zL9qXDK/DCDGv4ADiplh19FP4cq9e8qMaoVHhW592a2JXmNlWPkhScuM
         g1Wf2SSL3W1RyeCUPWElu74pCnf291gJXY/lzz11QI+JRNY9myDwroA5t5gn4uv5qT8u
         ioLUnWVgaayZK0IEUtLZevQZHepvty3qlstAyZMpQesIMGHLoVKxTj5L7XR5u9Ugcfnf
         lowXuv5q/5agFJttjScdwKc8fUNrc6ZQ3EsXYdftNY1+eYDYT7l3xuk+hSaMzVZbltBU
         /bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RiueRF/E0leyiNIphJ7XcGO0R5FWeQ4DFxFreZBdVLA=;
        fh=JP4ZKmb9D/uO/jQatKqh14R6bWrYWauYFwpNs5/71q8=;
        b=EW41PKEmvfoRsluh83ActmMARR+/jeCU+LUokgpqDlkEBehrjXA3RSjI1HncOyzFov
         UJCiy82l5UKJjaplT5WwG2MadExctEtKlds9Bb+wdGTITUakhoLu4mXq5WS7IaczmAv5
         i/gWtFJPtUmZeSHNoa0b0mkh2GmyAve7pDOsr+ufXUP9KPayMcc0RaRXvxLYQfYYwhRZ
         moSW5SgvRIsRuNnaYZf2W7r+t6FA8iQdzFLngRcZXkThNHELGiQl16dyz4A+N17/ONs7
         FtJBTeHOFM/Q1UQfuUn+znAeCl+YZ2v/UHJDqHVjxV7SR6JNmsn3XGW9SJv0m/T//qRy
         S/hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090014; x=1781694814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RiueRF/E0leyiNIphJ7XcGO0R5FWeQ4DFxFreZBdVLA=;
        b=Izgmj8RnYUYLC3oS7M70RkWRH9H1C7PNGNA31JTvtCZVJkCcBoxLsn0sJbq/Nxec6h
         xpTSdiPC+OJRdJzEl9u4ymnTzN6g9YLZDzIDGPpof7Ld6lGEwJKG/ksp4oGy7yl9ayMh
         fv/UxoTAhBOS3OlmojHHaVnkr8bCHInlVJewM55E8VzieEwA037c0nnx2cq14WtmlTYi
         r5tzu5N9zY8opHyR1DaUwGHX8DBMLvQwKZIcoAHnQzXGhkdR5Sbo8maZ1SSGR03qI8sa
         2bSUzXh/wA6nscWw6l75cWD+NEuHdxBVk9UZIBhWvu8okyKNfo2C45O1U0Vzt+vlN1Oe
         Xulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090014; x=1781694814;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiueRF/E0leyiNIphJ7XcGO0R5FWeQ4DFxFreZBdVLA=;
        b=DJBnVdMWXVA2G5pnH5SwYDH3P/QcaLvJkKxfJvZBFqzlNBdK0K2jfDCfa2xNg9WZyI
         T07ZHKDwTPw8UWK6XTIa8z/m60Tphc1d+qD7hpLif6bWlUA8T6j6++NrKtGPD0qY/q+5
         dfet6cxoHE90VYkFuzusVCPC2wAuH3BXaLEQvQwWsUaDBOw9kWTZEAmBmyKNpYVjlGBm
         uV6hRlcSKI04a+JIQBASuqo9uw94BVopGVtzkx7ZiA2y02uZulbbmf0omaEE6LcYKn4k
         6WVAzQ1VMB1Udgllh/2gZfCPWqCT5hdX65lF98Ex/sz8iw5M6v8HDW5w6vqQyI7p2RPE
         IMUg==
X-Forwarded-Encrypted: i=1; AFNElJ956L8MWBjk4TIhWzoktQPRsYEWAwqAQVNf195+Dxv/+tNPM7FD1cobHmaAMIaL4fgoQzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaGiLm0pIeGrlBM8kQRkV7kT5P3tIX1gKzaQG+5rd1gFx52yD
	oaki97aIk/s83PiMxiW53MK9FzNLDm4LuktEI0m1hZF2+VS9z+Ys4ZtMgP4o75xJyFPUf+ADD55
	wge8WB0+R6VPt8kFM9sVVwcAC0rqi7ls=
X-Gm-Gg: Acq92OEXYEmOWEq+YcSUefWjgvN69cXwbGFsbxImqh+8RqK91TvvfGe0BTSjim1s87w
	+VVQtiF5Q1vsOEYzbnTrQSchxfSDRKbRu54VZ1eQX+r3gpMndyogw4ss38SRP8NAdkVmml8FQqB
	O3CsK499kBzgrfg6ps4LYtewoZhKjfs7MIGRumEIQCYbwa2a/UQ1KqCFKke4BF14/n7UEm0pyBm
	LH4akGShoStdsCC2JL+U7Cn665L5/c7icxAwGa0CmhsuNujiFFv4ll0v35lt+RqMag4O1++l7vW
	I2MX2J2sVq4/yeM74w6WyYufIUUQJ545E3COah4dmY+pzODnNUtXtHo+bUDIB1mD/3KmjC3Z9/x
	HlaOmWvpz
X-Received: by 2002:a05:6102:6447:b0:632:29a5:2b27 with SMTP id
 ada2fe7eead31-6ff0294a3f2mr13384512137.3.1781090014413; Wed, 10 Jun 2026
 04:13:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 07:13:33 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 07:13:33 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260608-pks-b4-v3-3-f5e497d10c56@pks.im>
References: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im> <20260608-pks-b4-v3-3-f5e497d10c56@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jun 2026 07:13:33 -0400
X-Gm-Features: AVVi8CeaWZl2lhpFASJP3TMIZThr71K1pp8unidc03ky5C_R024YEczcXDT13NE
Message-ID: <CAOLa=ZQxA52p+9DcZZ=gVTqZ66ETQvZRQYjZNFjzdbsPwTW2iQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] b4: introduce configuration for the Git project
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="0000000000009f97f40653e45568"

--0000000000009f97f40653e45568
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We're about to extend our documentation to recommend b4 for sending

Nit: This is in the past now

> patch series to the mailing list. Prepare for this by introducing a b4
> configuration so that the tool knows to honor our preferences. For now,
> this configuration does two things:
>
>   - It configures "send-same-thread = shallow", which tells b4 to always
>     send subsequent versions of the same patch series as a reply to the
>     cover letter of the first version.
>
>   - It configures "prep-cover-template", which tells b4 to use a custom
>     template for the cover letter. The most important change compared to
>     the default template is that our custom template also includes a
>     range-diff.
>
> There's potentially more things that we may want to configure going
> forward, like for example auto-configuration of folks to Cc on certain
> patches. But these two tweaks feel like a good place to start.
>
> Note that these values only serve as defaults, and users may want to
> tweak those defaults based on their own preference. Luckily, users can
> do that without having to touch `.b4-config` at all, as b4 allows them
> to override values via Git configuration:
>
>     ```
>     $ git config set b4.prep-cover-template /does/not/exist
>     $ b4 send --dry-run
>     ERROR: prep-cover-template says to use x, but it does not exist
>     ```
>
> So this gives users an easy way to override our defaults without having
> to touch ".b4-config", which would dirty the tree.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .b4-config         |  6 ++++++
>  .b4-cover-template | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000..fd4fb56b6d
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,6 @@
> +# Note that these are default values that you can tweak via the typical
> +# git-config(1) machinery. You thus shouldn't ever have to change this file.
> +# See also https://b4.docs.kernel.org/en/latest/config.html.
> +[b4]
> +send-same-thread = shallow
> +prep-cover-template = ./.b4-cover-template
> diff --git a/.b4-cover-template b/.b4-cover-template
> new file mode 100644
> index 0000000000..ab864933b5
> --- /dev/null
> +++ b/.b4-cover-template
> @@ -0,0 +1,11 @@
> +${cover}
> +
> +---
> +${shortlog}
> +
> +${diffstat}
> +
> +${range_diff}
> +---
> +base-commit: ${base_commit}
> +${prerequisites}
>

This looks similar to what I have locally too, happy to see this land.

> --
> 2.54.0.1136.gdb2ca164c4.dirty

--0000000000009f97f40653e45568
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c31887fc61fb4224_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcFJ0d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meE9xQy80bURSaUEwRkFwZjViemJxcjZWVEZnQ0JudworaWFkdTRBcjAv
RGtSVTZtY1l3WEw5QmQ0bFUxUG8rUE4rbEhLQzlQdmd5VjFDUGN3WnB5YWZCanJxOFNtVlFkCnpl
ZEZTT01rSVJOREtCaEpGdzlSd1BhTEZIVkFzK1ZXeUpvZi8wQ1UzVFc5ZnNZekV4ZWpOUVV5bnJZ
NmxWOUgKR3dabzI5Q1E0ZmRIbWpFbnpjMHdEeUJaMG9QTkU4NWNuYS9xVi9SenQyYVpKMVhKVTQ1
TnJIcUJHTDJiNFFJTwp0Z2VweWlyd3Nyc2IyZXN5ajlIZENBTkcyTTNwSzdWcmRaeVIxeVoyWGtI
dDMzOU9EQytFbXBocG5acURtbzZGCmNoZzRtQVdMTk9jTStDMVJFdTJoVHpRL3dCcWR0VHRpSWNB
SDZ0NEZZSzVwYXRUZlFGNERzTzlFdnFaQWJ3ZjMKZ2hlMFgrNTNmNmVEVXdaaXJKZEJwRUY1eXh2
d0Y5ekE0RVR2RjBnMmRySzRTWHBWT2lUSXlxQ3FFemgveXJtWQpqVHlVemxrTUU1Y2JNeE8yNjA4
TmhKV0NvS2s0bW1NSDVOSk9nandTaWhxUThWRGVqOUdQUGErM1R0OVpQQW5FCmlwVXpzMmpqUGZn
SDd5VzhqZ1pDSFFTT21TVEJIZE11eWJ4THBuST0KPTFnaTcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009f97f40653e45568--

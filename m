Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6DD26A1A4
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282339; cv=pass; b=jYmgiw6Yis1JQczmjSTh4SFGLrfFoWEqMrIL9nyN389QgqEOrZqwi2bzv3WFBPchFYSxmzlZj60aiBFENW5ZgfYisvZJvRpWAvch9VCqTfas0+Dlex4UcW3IAa3nG2zKINNAgKwUrIWciEy9XtNM2bpIolcqzYPctIxGHPEDudE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282339; c=relaxed/simple;
	bh=MhRWvbCmoEmPww/YgGvJqOhMXxOjQjnICTjfCIsIsYs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOXehjY6Y7Z3wbIhuULwkD7pXmmFatQ3x/LvjedS1kmPgN+RFlGhuVIWwc+XGfYLgV+A8wCrj9unMMDCnMQIJr7u3/0mRg+6/y1cz2uNq9pmeGQzoaTHKjM3HPaIgqysNR9KlzH412SYn44cYqB9+S3FXJsd8VaybhfJsXdJL7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmcLvJoR; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmcLvJoR"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60fd9b71745so3494273137.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 02:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282337; cv=none;
        d=google.com; s=arc-20240605;
        b=XcHMBg7NXXnFo80x4J6KB70OrNKrwe5mkS3PANo6Eu8iCjDrhfRsrVXmuewPpz70eK
         s0viPt1FiKo8YhHI3+Z/CUDBtSnprebqhWDZpQZrV8F2mUMh9vRQJyt+YK56cIPoCe2s
         f6Oc633PunOy02yDc5HlrPuOnGY3eO4NPYGCojLuzOO6J98Z6/llLnSgkQ40SyuoWgKN
         kO7q5v/OxrHDZjf5f/sj+TZkZKQLnGXdln2DyVx3tJResu6xpmTTl9pduxOIGLNHvAes
         BhdepUZYvsCgw88zvu4CoY+qyQevUfXsYDJ+zpi2kl9FEzINEFmsL0DWOt6c/SYWoPo4
         tH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mnJ5zc1HzAZRcCgf4CA+7NS6a9WkHCXMyfAcmg8RtYE=;
        fh=Gb3KpO9QypOckfjB9mdhPVrdbTb6/d80UGlXTwWnDD4=;
        b=kclgSLqmd1Tb2YoIX+9s0qA40KRBFe1w4oovkwuJbM+4/bXCGRW6MaPl7B37bJjgRl
         b9Yi1mcWZWIw++e6ZA5UWVgwptgIc3Qw7+0yJYUD4Yr6PkCEKm0nAyQJpQuU2SUxg55z
         CoL6WXyS0LoFbInsgdRV6I37HrElf3kQ9Hrk2RZqsITyibBGyzCLor/UAP0dKMXfoOjM
         r7DNPnYTjzwfxqQoQAfTv7/LlnjcCEpb9LiwXnnQZKkbmF4DbjAzOLOugYVzd/Rvp3gf
         DgVlmzYZWkJd6TRJLQUggJKdMxajpd6Mowt90LU6cDRF0Z3fxsoSCxYKlr9OXm2pdi7h
         4abA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282337; x=1777887137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnJ5zc1HzAZRcCgf4CA+7NS6a9WkHCXMyfAcmg8RtYE=;
        b=XmcLvJoRSTq9sg0PByp1z5jFy9Ztl7ersqwlajtuMSiYCs/D4viMv3eusC0t6k1ZQl
         InGV5bwUE74YLfkqW1Kg1wallupPP4tt+dW6TnC9zgfOkaFaCEn61yWs/Mpy5todMR6w
         V6jdBOEW01i9Ap1/653Tu+QahkolsY+mvOIYgCBg3ej0gh+q4Jl/r2Qqnarcm5Ds9c9Q
         Tx5G68g/K+HFGuVQPLrHtRNwEbdI6X1II2mkwrfyv0O8foAGHWZMhFu5fY3hphdgfNUE
         JigD8L5HE1VvfmvfSNiEM9k5CbqMTePTCpE+sMy/ykTEbu2WtRt3UantjkRkCe7vGmEn
         9XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282337; x=1777887137;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnJ5zc1HzAZRcCgf4CA+7NS6a9WkHCXMyfAcmg8RtYE=;
        b=gUamy3jT+XOxn6BehO5GICyjXEEZSrS742FfnHLoXawUuWMcPK0VsZ75mgDNchL3Xq
         tAM3cxqD8Bxc0RC94Al3KU23s1d0kmfwAFT4yTZZI+4FJvYEwcKJ/yjwJtDXKmAKIy/e
         yvn19z6gIkwCCWK24DJ8eCamhgVdopS0G0IIb2RP2FceU889JF5FMWOJEGasFX9i59Aq
         fLFiDFFhoAVAQmfJvjBaoTTalGrXT6MEv7ejG1EJc/m3GwEy5Z4pCWntCFOVmgj/XM0w
         0HTeyVgvE5Y7he7gcNcoxtxbUwVUoe6s2SWXV/gDJJpjgjdszPQ8TbO3AOnjV8qXikNF
         KpHA==
X-Forwarded-Encrypted: i=1; AFNElJ+EhZC3fTanFkLok0KxglrtVinTRM7XFU/eZ+eep4aXUzZchx3T9lk8oVnBpQGC2/5tVbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqqe+IfeQceJeZfWhsINmLsnWt5CWsTaLPhzhOIddTaLVYOOT
	6RaJEcfw1pEz3MSqN9WAOPFijf66xF3cM4YvP66gZ8oO+PX/MpvWzBjvYQv+PtPq/ephqY0t+6y
	M28QZWi8Hmu9FnCPpxxa2OihFMFW0xWw=
X-Gm-Gg: AeBDies11jv5HjF9gCyh91unUz8DIvqd1qQTGTaPDwOBOdDRmFtW+o2LgJrbHEldXqu
	GKRz8j09XY+QtcDh4g4tfmSijaHGTvlzpyLwD42/aYo6XtzaGi7YoTjknZs3lBD2uoQZy7GWFPN
	azJB3KlygTgpda2a9DdHPEivgxHlf/Uw1g/Em839XqCCHId3Gdkpo1U/szTf0EADWrkOUY9Y0Bz
	hSwONiG39hyZK79ghtbBNSoCk7mG+IbNeMVW5cvH6vwBzGtsBY8OfU3nX92d9JLam2EqHSfxOp7
	LitgnNYKOF1gDI1X8E6kq63Ce1tBWdA4ihjG5d26acY77lSPxTD9
X-Received: by 2002:a05:6102:3a0f:b0:610:2912:adcd with SMTP id
 ada2fe7eead31-616f73fb8fdmr19044125137.22.1777282336659; Mon, 27 Apr 2026
 02:32:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 09:32:15 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 09:32:15 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87zf2sd0lb.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-7-ae5a4f146d7d@gmail.com> <87zf2sd0lb.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Apr 2026 09:32:15 +0000
X-Gm-Features: AVHnY4IDHbH4ZDYe0ipCApt4Fg-MS9TLYuQ3oexd6O05bypAPGAlUbpA_yv2WJs
Message-ID: <CAOLa=ZTZhVVgE1e4UN2urO46+cgwY2TratHRcrc3ZQtPsZU=Kw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] refs: move object parsing to the generic layer
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000057b9ea06506dcac8"

--00000000000057b9ea06506dcac8
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

[snip]

>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 878aa7f0ed..0fb3d57de8 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1641,8 +1641,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>>  			ret = NULL; /* good */
>>  		}
>>  		strbuf_release(&err);
>> -	}
>> -	else {
>> +	} else {
>> +		enum ref_transaction_error err_type;
>
> Shall we also use `tx_err` like in builtin/update-ref.c?
>

Makes sense, let's do that.

>> diff --git a/refs.c b/refs.c
>> index efa16b739d..662a9e6f9e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1416,6 +1416,24 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
>>  	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
>>  	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
>>
>> +	if ((flags & REF_HAVE_NEW) && !new_target && !is_null_oid(new_oid) &&
>> +	    !(flags & REF_SKIP_OID_VERIFICATION) && !(flags & REF_LOG_ONLY)) {
>
> Compared to the version we used to have in refs/reftable-backend.c,
> you've added `!new_target`. Why is that? If I understand correctly, that
> only happens when `new_oid` is set. Wouldn't `!is_null_oid(new_oid)`
> guard for that?
>

Since `new_oid` is a pointer here, we don't know if it's NULL or not.
`is_null_oid()` doesn't validate NULL values, so the check must come
before it.

If `REF_HAVE_NEW` is set, it either means that either `new_target` is
set or `new_oid` is set. So we check that `new_target` is NULL.

The reftable check worked as there we operate on top of `struct
ref_update`, which contains `struct object_id new_oid;`, since it is not
a pointer, the value is 0 when `new_target` is set. This works with the
`is_null_oid()` check.

> --
> Cheers,
> Toon

--00000000000057b9ea06506dcac8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c1fb8eabd2d8279b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1udkxSNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFdHQy80b29qRHNIMkE4REJJdmpROThmSDUzTDlKMAovVTNPV1VtWk5h
Tm9CNXBxYzMyY2cxeG5tclRvdWtnU045bHptNG0vTnVRditxUEY1RWFFb0xsNFhIU2dySmxsCkZn
eWY2VHVHUld6YWxJL2dzSFBFOWRBenVVTEF1ZXhrQy9GdVhXWVJUUVRaUHlhSTZUNk10ZDRuWXZ6
U0NUbDkKbVZJR3JKbXZUdm1tRFIxZjFUQWpRRCswekkzeksxcWxpMnM0dE5VN0VFN3lURno0L0JV
SGpVR3R6WDBzSFNsbwpieEJYa1dIU0xTbzZ6YytSSWljSHpmQ3FNWlJHcHF6b2E2MnNHU0dVTHdi
SWVZWXBCSzFQUm14MzFCdjVzMThHCk5RWk51cGxBNjNRNitCU1pDT1RNaGowQ25qLzRTNU05QU50
dGo2VndhdnZHcEFOL2J1UlhBTENCMUlkT3FyOSsKelA2ZUNlNTltVVpnOUw1eHc5YlJMZnJmY2tn
MFA4WWxsRkdkS1pjY1F6S1IyelM0WDJNbm9DdWhrR1dtbGQrZAozYTQrbmhCOHkrV0c1aXNnOTFT
cXJuZFlvaXVHZkdBRlphSng1b1gwUFcxbWp5ZGFGZ1ZQenZQR256amlXdkkxCmhSWXpVQmx6QVdv
bVk1Um83aXpoOWt5NDB3ekR2ZWNyRFRqYUx6dz0KPUxpcUkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000057b9ea06506dcac8--

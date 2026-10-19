Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792435903;
	b=k7mvU7gaaB6e5ZIFsEXf9X3O5Xfv3D74D1jpMbSa3MXu12St3kPMgZdqdCG1vQroV8V2
	 KmbwnEBO9QSLa23cxfOJO6aOw/AGR9Bb2fOgD9Rn+QlVg2VIooUpmMUDOSLo1wj9Bxk34
	 nIL3QKVsst16OHTxRUSjiPBbWrG4x3SJpZHsm3MiKkIcsIDVGI7O7YecsMdLmekXnYOgU
	 PwASK/YQNJEr9IOw0JMWE0Vgzp9/BrjzmlK/dQ9kRD/etjadYLPGY7hctL/QMxUaOvGcP
	 OJm4hT+cuI4gsXucst6a4hKx8xPJadKnTF9Ke+gg6Z5ooE4gVaAAS241me3d90IziBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=skm0CZVBZiIPHHD0bUj2UzYbsD2/T5uhtnG+QjPv7Xo=;
	b=gKAcckoirhWXqzKwJIWV3Od1xu8gOKoSx9gyPsITM5LVJIjKvngVDQECh3jijy3uu720
	 WqTOuqqdXvA/hrKSOuLHp5H1++9b0RRxYtBmmFmMEwXVg/dTza5AIii914W4xs3Vc3RJv
	 7/JhXNJNZnM8Uf9iP10nD9bOoPolK8oHa7TWGdEv9g9wFJdX+4tvcAOoOvHhl5Dvtgmme
	 eSV0tL/QzrvLjBVLurOxTIFTmHkO6P91/Q04R5EPHo0iiSBM82UhB8hSw/99ycAcZHOOh
	 HyCYTucQar09WnagZBTmiKRcwJZNFbtjQDaCIo6SmmkGo7g+Is2Fzaa8fT5mczQbENg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gjnYovs1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7469606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7469606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gjnYovs1
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9909e82513fso1497932241.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792435902; cv=none;
        d=google.com; s=arc-20260327;
        b=XSKcgscH96di28Q6pgA+6Ua9E+iPu6p/MFhBjbvE/m5wHW3khVrE0H9ZGARLgekeAN
         y0x1OWQUEBP7GsZM+0bvmyk6PLylgvfG/FWm8AA4V5g5hUvDTF0gK8jYo/qPAAON7dM0
         1u9QUMRMltsDdglrT9/Ab2RbmbfguZRknStRUD0R98DJ0K49G53H5Y8fRbTUJE6yOk6y
         JIq18b5kFa9VNZGv0RbSHRf6kG2Q2wJywHXSzg1GLhqfLoRfQLdKI2ACcCD3Zv+XoVWL
         aoZTy2YxSN7FjgK/vg17bJQ5opvf/P604tUqgS2vEA3+Mtuxoc2fQ1tyRutg/gHnUTDZ
         AHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=skm0CZVBZiIPHHD0bUj2UzYbsD2/T5uhtnG+QjPv7Xo=;
        fh=WI4fY4Wh2p3m/DGlRVYsTuJuXcSK4F/DOdSbmz2dFno=;
        b=T8Huvy9+vaWAmLmQfUnR2orSsVyvGFLVnqFeVSRYl3NQFbpVHtG8wicrdvQ65zGNeg
         tUua1UrhCQpSbtT7KvxI9X3XKjJ7lYSB6uKFfT4UEr0PInyZyZDyG1+xVok6Bw6HV0gb
         WV5vRRemvlBciXvyEESLD9+bToweIgMIGvqhiC3+AmVhSlyKvhsVXjLparidZjNIWAkg
         +md70aS+Sl9/87EhNOwrbYpHzoGCxQuPnRE8tkHok6KPZQiR2j0NoE46j6z//FZ0ziLY
         VQp49sqm65Dqdw3NUHiA30NhpfFXOZ5lLcslU92SPImVi+/zwuVTKNa+Qj8yrBdI2VyP
         NfcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792435902; x=1793040702; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skm0CZVBZiIPHHD0bUj2UzYbsD2/T5uhtnG+QjPv7Xo=;
        b=gjnYovs1AEzHA2LRRU7Th1HaN4jU79VpeLQ+dF3i1RChn5nohr6ykPlyZ1Z2VV/8oW
         oYkb/54zoD6mZKk3W6tgzapnY3L87caZnkDbh5blybYTs3MN2mmxOl/Xb8ujS5wlMqej
         brQwjgfj3JwaRMLx39yR2Vk0Ml3ub9/aP4tp2y6tTopR2etpdKHJ4sxla53nRS3HsEiK
         VNzqAmJVvz3jTTqqE/jc/B8qjmr5MJTTn0UfzMbMbRHZ8tlhiuq4dcegMIbWQRZybAZC
         MK00qGAmJlTVK8SuCyPSfNPSRMW5Mqy75NXqRqbUVH+PIS9KeaQilnq07RYHKTLsrDQX
         hYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435902; x=1793040702;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skm0CZVBZiIPHHD0bUj2UzYbsD2/T5uhtnG+QjPv7Xo=;
        b=jUlFFvIuV88+l5RXhb6PMDCMEd4gj62lc5Lhw0P08tudIX4OO1IVhvQnQqIl4gQrLb
         WVd2+lBqvN2mK3Kx6WTw+BSzKzyh4NVeHCT+d+bib/123Mt5AV2lwQWEXBwBjds866mQ
         T2o9EGmNoSTzqpmiWwdu8PY4I5OjoHNEyzSKq47RDUYGx32FLPMcEMn9OZNSiBjOvQ01
         juxYH65ZaGyImb8q/iBlBOu8GQYpob2OCWSpDRaqrfot0B88wQHPmbXDzCsUpdTXRoba
         I2Xxg9sxHcLjq6sRF+XwLrI1rbjlxRmupv8NUU/wX29s5Gw/qRrAuECpFcMBIPF/y8gr
         UQMA==
X-Gm-Message-State: AFq9FYJ6eTS6zYzMs9AFuAGRmvpM3P0CRo+cUjPHGqiyuilzGP3aPeoc
	ASoYcsEHqAlcx56yBFU4Efl/M4j98HkIkQGnhUCA7hG7+EtnyeeQpKatR28O4rsm0+SnDycGCI6
	Ub3hWS4EYB5RYYAqubz/khDO82zxzanJf0A==
X-Gm-Gg: AYBFou18wuPwOjgzABMh/Q17oox3O8H+URjzr3gYqkW9OEtTIUYVWleK6YS76nfNkBN
	OgUTwi2rruNWKPzV3b0tRiMdzafh7PgXREGGHuiDUwi3oI7sUVaUgAczTQb2kBG6MSb9zRucanj
	9M0TGgeZAwM60VZwWsc7qLMe8ogiJeq+h5CoURCWHVXjnpB3bqukrDA8RpsdkW5/M73Dj8TFlFP
	aaKn+l5GsWbos0OCN7W8/TJlsQz6gjUObvy5lUaNp93lRfIVnYPPuKyJlyQU+J7yPgopaF4A4OG
	BHr3cEwtOSx9Ti7LJc6McMHY1qvqX7eC9Rniszrq6ZLydERH8/c3/PRuecWWn+7s01kzR9/2Kk/
	+A2drMEr748nV7Az6y443k3LGrrzYtTGOaLOJVYTpa0fY4Q==
X-Received: by 2002:a05:6102:3569:b0:7cc:8e7:bde3 with SMTP id
 ada2fe7eead31-7cc7b9b88b7mr2796137.2.1792435901633; Mon, 19 Oct 2026 11:51:41
 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:51:40 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:51:40 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atW_BmTQhxFRLc0a@pks.im>
References: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
 <xmqqtsmlftwy.fsf@gitster.g> <atW_BmTQhxFRLc0a@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 14:51:40 -0400
X-Gm-Features: AclHuK_0QaP5O18GkURidc0CSFGDP7DhMJ-OgxgiQnLxOTDba1f9IG2N2rWhgpU
Message-ID: <CAOLa=ZTwyGnWFa4U=8UDzEUuyhQ7jT555FCh-CBp_wos9rJG9w@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: fix "check" jobs with large merge requests
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000334403065e360144"

--000000000000334403065e360144
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 16, 2026 at 10:15:57AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > The "check-whitespace" and "check-style" jobs verify that the changes
>> > proposed by a merge request don't introduce whitespace errors or style
>> > violations. To do so, both of them compare against the base commit of
>> > the merge request.
>> >
>> > But both GitHub and GitLab use shallow clones to set up the repository
>> > in CI jobs by default. So if the base commit to compare against is
>> > beyond the shallow boundary then these checks will fail. To avoid that
>> > error we thus configure GitHub CI to disable shallow clones via
>> > `fetch-depth: 0`. But we don't do the equivalent for GitLab, so we see
>> > such errors whenever we have a merge request with more than 50 commits,
>> > which is the configured shallowness for gitlab-org/git.
>> >
>> > Fix these issues by setting GIT_DEPTH to 0 for both jobs so that we
>> > always fetch the full history.

The patch itself looks good.

[snip]

>> How much help are we really getting from these two jobs, by the way?
>> If we disabled them, would we suddenly start seeing uncontrollable
>> amount of crap patches full of whitespace breakages and style
>> violations?
>
> I tend to ignore those myself:
>
>   - "check-style" is not all that useful as we don't fully submit us to
>     clang-format's style, so whatever it generates is not authoritative
>     anyway.
>
>   - "check-whitespace" was quite useless to me because it breaks rather
>     frequently.
>

I've used both as a guidance rather than an enforcement and while
neither have a bunch of false positives, they do help here and there.

> I still think that "check-style" _could_ be useful, but only if we fully
> commit to clang-format. It would remove a whole class of nitpicks
> and thus reduce the burden on both newcomers and reviewers. But that's a
> discussion I don't really want to lead :)
>
> Patrick

Sigh! I've tried to steer this for a while, but there are a bunch of
issues:
1. We need to commit and start enforcing.
2. We need to fixate on a version of clang-format, since we support a
   bunch of CI environments, we end up with the lowest common
   denominator. Older versions do lack a bunch of rules
3. There are certain rules which are written down, but we often allow
   some leeway. Like wrapping long lines.
4. There aren't rules for all the styles we want to enforce, which means
   we still have to do a manual check.

So I'm not sure we can ever come to a conclusion here. That's why the
job is also allowed to fail on both CI platforms.

--000000000000334403065e360144
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7a09dcb9e924e13f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yV1pyc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3NtQy9vQzVtTUx5dnVYdVhXRlVPZDk2WEF1bFdyTQozYXN3US9pSzZF
ZmJHS1JLSUJSZWNZdDl4OURBOHNXSHhmVGM0cG1lcUQ0Y3lSeitSeHg2SkRRLzFDVFBYZUpmCnM2
QndHS05XdEQyT0hURUo1ZFRCR01mMmhzY0FhRVZIRUZNT1Bub2ROQzk0NFR5ZWdGNzR3cjlmMDBM
aDE1RzcKZkdyUzBObjdYOVVCMEdYUk9jcU1rQ1JxWTlxSTVVSjVURUc1SUhpemd0dTI1SEN3SDBR
c1I0bVI3SHhOTUVDQwpvVlJWRGp4WVNiblVOTDAvNkd1WHp3aEVCM3NpaTl2NGZkV1ZXN05NNlBM
RUoxdGIybGJEdFMvOEFGY2JIczMzCnF3OFF0L1hLZjNWMHVGci8xZTczMXB6RURxYmtydWhFU1dy
QW0vbzlPZ05MMmE2Y01qUmowc1owcDk3K29WOGEKSkNEK3hCNm5LdzFSNEljUG5veXByYVRhcTUx
ZTBvcThUNmtiM3RFckNVbGtqOG5QY1dCUHBodmdkajd6U3UzYQo4ZEliV3h6Skw3ZVFLVTkrbDRt
ajhIL3R1WExBaG5jMGtGVkdCT09wN0lWWVcrMGE0WmE0Q0hFdFZNbGc3b0dzCmp5aTI2WGJBcnlt
dkF1UU9TMjk0ZkkxcFkwbGc3bUg1SjNiWEo5Yz0KPXlycmUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000334403065e360144--

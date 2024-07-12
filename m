Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D185C56
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774285; cv=none; b=HkCKfWgPHmYeTDvHdXRs3IfLbdfRlGVy+p+nH1mqcY8rbu24Z+vy/hm9J5u/J9b5bUU8v1mCvwrZ8ixPFVdDAGvs2EcJ/UxpbmOZodSYGGRJvu23OJeYg/NrNlWwomY/kOEW6gBCK2WtdEZWUrl9nY+zcE0etGwey/KGgygChCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774285; c=relaxed/simple;
	bh=AiMEYAQ1OwYIy5q9NZRsbio5MgcnL1DU3cLFZ6YPXpg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idO4WScdW3iUp83zO9FVBSzJJbx25qNopYXqqWKTCjT7oD61vn5cyKuTBJYQ/qryjuYxAj8YnTMVD4/T5sf/VNpV02XApFcuZeldRLv+fUNjhOdyWc36CQUbXItGdVa6Ga1ytUzwy/hlttLYndOLNnxgo5t6tHIxbU+8zdmw65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIzusVVo; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIzusVVo"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e2cc76becso768978fac.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720774283; x=1721379083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgdM/BeIBbGCmo8y/ljrg9A9RjXDxiE3ODwQEINfAFo=;
        b=TIzusVVoXtcDRvh3FnQzqxsyx8pgWg8s2FJzTdldw8dsVPuYK4KM0DiwpquVk/kq/1
         ghkYDzm5GtPZolNWiQKeYmzwiettOQBCcDu1j2gBVdC89mKDkjNJqbKQQp9G116oiwqO
         nLcz1Wcv/0/9ewWqnKZlS+Lm7+reDs1jakOBtgMRcdDR0hpljOEZ141PNBcDyMTyRIXS
         XBq6CeISEGqsVvmWXfo7sV6kn9+EMFvOt3f/iblQirHfjQy6owj0lZVpfBCoOKqsL5hU
         InVhetelGa0bzhIoncGtpC7VC0mH78S3x6RdT5k4p86GnYzKXvTSNIsMoq5Zi9nl0LKd
         C2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720774283; x=1721379083;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgdM/BeIBbGCmo8y/ljrg9A9RjXDxiE3ODwQEINfAFo=;
        b=J7qGjHr/pS1C3kXQp6P/GMKaFtitqqDf3GxMCk04soNvnvs04fAsWz4gUYoyV6wx4x
         lKAj4WHxTX/60oLJ+ndNT5a6yhzUdMz7YiFfuRu2Bm49vTRdB/kX9ckQkEr1KTCFM9EW
         pO+JUZ2ErT160Rae9C1e3aNlqupII3HpoudQMr12swtSdleyXIDMIFAdovTa8lk+v/eH
         fTm01HzyJWZcg5YYBIDA6bSmx+wnB4hDu7D0n020VT5KHzVPx5hnCSMbhndJy/I4QMQJ
         lA8SAGE4OJvZ/DxSiTsXiy8OrG4txM1raAbPwZeE8c8SaKsZ7bQd0bEIM0u2i/G3oHwM
         9fYA==
X-Forwarded-Encrypted: i=1; AJvYcCWEZSYhMY2KWopYbiNk+1Wg+4Hy71azv6rqyGLGpNuzRSJpBqq2BImli5dHCaB+XbewIuO8xFdAyiRbuAdXwaf5i0i2
X-Gm-Message-State: AOJu0YzgWuXwZxp0WoTfST7CaB/5oM+uWG8GX553i5wPLBPLsneg7Ieu
	z04SHUy0dHPsWJyjdKOtONuP73mOxUsqvHC8MNVG2RexO1+CwaOXDC5LOk2V0h7bbtKH36KRWcq
	SNtIHmvBrSzODPOJIQ47NMl407eA=
X-Google-Smtp-Source: AGHT+IFwWRrgQLShRhW5cds1ccfT1r8s6u30dGOMnm2fdlMSq3bWJFyUJm+qE3VDCq3Nb/UiU0rQYxwKGHgxWNtUy80=
X-Received: by 2002:a05:6870:56a6:b0:255:1bb8:85ea with SMTP id
 586e51a60fabf-25eae7a4091mr9601764fac.14.1720774283311; Fri, 12 Jul 2024
 01:51:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jul 2024 04:51:22 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqikxbsy4d.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com> <20240711083043.1732288-9-karthik.188@gmail.com>
 <zq2x3k5gshs5jgx6zglfdzu4kx6vrrzugfvd4w4pjfh6uyjc4r@4x2zt2ftfmsq> <xmqqikxbsy4d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jul 2024 04:51:22 -0400
Message-ID: <CAOLa=ZSR=mMMnYNrpKc9ivOx4vbzJF7c5e3632NpX4XYFdLMmg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] check-whitespace: detect if no base_commit is provided
To: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e559f4061d08fbda"

--000000000000e559f4061d08fbda
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>>> +      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
>>> +        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
>>> +      else
>>> +        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
>>> +      fi
>>
>> Not worth a reroll, but it would be nice to have a comment here
>> explaining why we have this fallback as, to me at least, it is not very
>> obvious.
>
> FWIW, it is not obvious to me, either ;-)
>
> Another thing that I find somewhat disturbing is that the
> conditional seems the other way around.  It shouldn't be saying "If
> B is not available, use A, otherwise use B", as if A is known to be
> usable always.  It should be more like
>
> 	if test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> 	then
> 		ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> 	elif test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> 	then
> 		ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> 	else
> 		... noop?  barf? ...
> 	fi
>
> shouldn't it?
>

Agreed, that a comment would be nice here. Will add if I reroll!

In this case A ("$CI_MERGE_REQUEST_DIFF_BASE_SHA") is known to be usable
always [1].

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html

>>>    rules:
>>>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>>>
>> [snip]
>>
>> Overall the GitLab CI changes look good to me. Thanks :)
>
> Thanks for a review.  Very much appreciated.

Thanks both of you!

--000000000000e559f4061d08fbda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b8e62344803309ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hUTdva1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOU9MQy80cjViUVJRVzF2WG96UkVGeDZYRklFTDJ2RQo5dm9URWV0YjlR
OWZ6YVhJdGozOEY4Nk9KLy9jQUhRUVNWRi9iRnB2TnRuUkxOSG4rWld3OENGSHowbUJ1RUZYCi8v
SWtCVGJJNWRFQnZUcmc3TlUrcU5QQ3RkZTR6d2grU0d1aDNIckM3MCtNdUR0aTBvSUg3bmtlY05Y
LzJuMmUKL05UaHQwcTkzSVp0RFFGc1h5cURzZDdiNGhSVzlJT3VMVFdnQWhMTHF2QWM3WG90U0Z5
QXZ1aTlEaFEzNk0xTgozMW5mUTU2dTR2eGlvU0Vxd2dyNW1Kc2lYdEEyVm82SnlpQjg2d0JncTN6
Wm9qNmo0cFVGQ0FWUkZqdmpoZlB6Ck9PMUZISWdqbE5ZNUtyRk8xbGxQVS95TXI2TTZ6OG95ck1J
QmFiM3V2cDA5SGlUZ1NrRFZzeGZFa0MvMzFaaDQKR1Z3K0x6Z1RXMDlwY3VydjhPZUhyajljSzlT
a1J6RW5mZGRRMEJtNkxNSVBPZGtUdmZ4MEx5UWl2cXZ3ZnMwZwpENlBYOGNkZU5tazd3VFZKZDA0
Qng0TGhLcjczOThBaE8rK3ArNEZXSVcyaFFZY2xTbHZBTGxBVmlYR2Z6YnRDCjJtQjd5Y2s1MitT
Wk5qN2x2WC9mQWZCQTEzcFhadzM0OERJdG9kST0KPVZPeTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e559f4061d08fbda--

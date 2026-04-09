Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D53CFF4A
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739925; cv=pass; b=Js20hG9q/ezt8VqWvG3FYFQerxcBqJuHDC9hWBw4waS56WZgAdwMTQ2uLysv4AVlZ1PyLqmZWTZno69JvTbLL/QPHAW1A6i/0bYgSdxg8v+P0lms1vMxh6EIF9Hs47gwL0uI0CCi1qBzUQzRT+uomM1l9qiRU1l9U4uC19sSekg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739925; c=relaxed/simple;
	bh=mdj0sNJ1t/cJ4wmrF9/h8llw2n3YOWIk8ibBb42x+VE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=r02wF34Rt1HQ5uBgvngWcXlUZkzNg5bc/Wi3x8tB8rnPUhjsLdBP+Qvg5opFP/2PYbmiOAl5i1DzVgJvjGkz2vicO78r9uAWFGlg0cIMD1XuwteC7r2cWKKT/EcsqxmJEXcjHLBCQEo3Iq4tOZ0URyE23pqDbjAeDnBS/P1Joso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFANvJHL; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFANvJHL"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56adf76631cso330334e0c.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 06:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775739922; cv=none;
        d=google.com; s=arc-20240605;
        b=OSB1UebD7XlBRSF5DAYqaobKgd8IlXpObFonkZSP15+bE1qFkv6xE7+z3ztjT/4OkS
         akhDgzo7+Rh1YscUo0J8wEzDCoYajk5QPNrb8jeAK72DsDd5fA+UBVzKlvQdO2zAT4xR
         u+YiWR1ue0DvMZFtTYrEQXwXM3DZjZCxoIYDcV48sYmAGDviYP3AG2wAcX465gUqsGPQ
         X6RsXGmBCN0QEO86Bb7777ACdRP/eFaSNOWePRn+oxG/381Fnb47aKfwDSE9H8Z3/lS/
         O5wj0Ae0mFTTnrF9jSADp0ex9ViKzYm33uZZfvz9BLOg+fQ7Kl3MlJfbdJo8V+hSGNON
         rOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=i8UqC4xIm3ttvqXdI7+m96NxHfF1lmqbOzwgYm49px4=;
        fh=OXZKTseUas6Nocv3iobu4IWGMSeunt+2rBaHMz7u3XA=;
        b=GgKLJyORHrbrEpxBRaDaFrwYt5V2KuosJ9hr8Pv0mlc9VIXc7ddCVfYeQ168iR5msM
         Ga77pkocIm3AdPG7fo2RUq9lLR9FnqvjuHvkvaKUc8K4AIZqMhFaPb1ciCFjHglLXh6Z
         VkVkENdaapfsJovuVxQh4lXSy5iz5sdgbnPuJ0xpRpMxNgzW1ptZ/HJhQzKCN/CfnUYf
         ID9Q6+ay9pPgfbXRLlQRNWJdfSAOr8PuTfauM22W4A5V+M2q4AyRlBMko2YKkOuNl9/O
         RHk5Hh+vL6dhn3SglJwMZl+1QcnScYiFXgTSxU3yPdJMowiCpB1+04fGcQT9ZpoeFg0C
         Lh0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775739922; x=1776344722; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8UqC4xIm3ttvqXdI7+m96NxHfF1lmqbOzwgYm49px4=;
        b=CFANvJHLj3A1MExjdSUmWQOXuB5vJ7L5Nc2WqUWmn5JGUO8SkcJ6YZoSBCPVX4xnGr
         LSezDfFWowu1qR38Tg+9XBdcG21muL8QMzVxgDSDWDZeyyBz6lJu/DOThDCi6ZxaKI+/
         iYtyOp37gCi0kykABqKazhu13zMkCbL1bqGjDWwPILytJ5Y1rGhUb2Chj631AEDcY46w
         LfW1alP52SA+/Y56Jad5VHSs5z5ENASg70BByv+KTekjjAvJzLMivCqTP0XO0FKJjSCd
         a+YtQcgwqSUQHC1jGGzNYkS9SEs6QPILHXv5cN0rpeIqRMeW1Hf+AwMlJaibtpxIVbL/
         n33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775739922; x=1776344722;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8UqC4xIm3ttvqXdI7+m96NxHfF1lmqbOzwgYm49px4=;
        b=eNfkHlQOeODLDpzreHP/RibU4PFeJPFif/1bzPI/oOHV6h1g+RtrFdYnXphlabKDxV
         6WSx9czQD7oDh5Y45xq/a4KKZEY9iv46NF6lFPYMRurgIbmWeqlapaEEtGeH8txBeEd6
         LHuU59mKVevZlpir7dXkUEenCzWIpT7TGyqhTKD8x2HBJ4kYPXU8QImf2PjS717a6Uhl
         40wx7/EdnFqc6ohP0smWA6sJNrlh+wAyB21RKBuQ5vQDTcGMJueGSePwVx2WcHjWWGAy
         F8DSFgqw5oj7dMriVMSr6HY+lTeK8LVRxLWlIfKqd95mTeomcwEHXU0gNiYWJYU0axX7
         Utqg==
X-Forwarded-Encrypted: i=1; AJvYcCWZM+gcl4mgTE9Z1rKKZsvWpOhFs918X4h+PWKZOmPEYShVkJ9OO60dtMDtrRXTimNrQ8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5gIHbkapyfWT4PfBvS9wpbufZVi2uBRCzK9sevs2bPjRLh6i
	Ab12kfNWnXSzKZhKvzG28PPdJ2+RbRatzGjKhRaMaGNRZuUeXmQnEcwCYtPni5gw63DK64dQg8C
	NfRMkeDPLxxeUIR/BxW5obMStMj5bzXHIeg==
X-Gm-Gg: AeBDietrmju0xcNsEZPLQIpFUPVxiBWyiUiBtND5nptYxGi1dh92FibB3JKj5Z1yAIm
	nT5g6gYRYl8nenhIPc0XPHPhS/MCU7uZHYnQ5a4d5UkeptyKl8hvKh8/QGB5dYI40DhLz+IllcC
	7iNxDIQlVpHKthsXsQ0JHutuVmY/VfFb1CcFyHewtxauqCgd5H2f5JhFCSqKJaqgSgi7jke7lHm
	sYUAaKxrbJH3xgBe6+6h/uINjNnUOJEpDGTTtAlNKjW/UBw4avfoBbhcC5yYJ2JvAwe/e7IcbSc
	xKa1u/Cz6glaG34twUh2VdReBlv8eP5A32LmeW4baw==
X-Received: by 2002:a05:6122:6283:b0:56e:e9cf:710e with SMTP id
 71dfb90a1353d-56f27320ffamr2131011e0c.3.1775739922420; Thu, 09 Apr 2026
 06:05:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 09:05:21 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 09:05:21 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 09:05:21 -0400
X-Gm-Features: AQROBzBFoaNz1ZaRHFxUtYBittrU6FqOw3MUa4rmtzwar83TGjA6zQlD0sEVlr0
Message-ID: <CAOLa=ZRrK_5shCZwOar47kODe1kDKzcfXo764o9mE5ZA7xGePw@mail.gmail.com>
Subject: Re: [PATCH 00/18] setup: drop uses of `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004a33cf064f06ab4d"

--0000000000004a33cf064f06ab4d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I've had enough of "setup.c" and its complexities, so I finally decided
> to take the bullet and start refactoring this subsystem. This here is
> the first out of the following three steps:
>
>   1. Drop all uses of `the_repository`. This doesn't yet allow us to get
>      rid of `USE_THE_REPOSITORY_VARIABLE`.
>
>   2. Convert a couple of global variables and drop
>      `is_bare_repository_cfg`, which then allows us to drop
>      `USE_THE_REPOSITORY_VARIABLE`.
>
>   3. Refactor the subsystem a bit so that we stop intermixing repository
>      discovery and repository initialization. This is my original
>      motivation as I want to get rid of `odb_prepare_alternates()`, but
>      due to the way we initialize the repository it has proven to be
>      extremely tedious.
>
> Most of the patches in this series here are rather mechanical. There's
> only a handful of patches that warrant more attention:
>
>   -  2/18: setup: stop using `the_repository` in `is_inside_worktree()`
>   -  3/18: setup: stop using `the_repository` in `is_inside_git_dir()`
>   -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
>   - 10/18: setup: stop using `the_repository` in `set_git_work_tree()`
>
> Those patches don't only mechanical move stuff around, but also change
> some logic to make it work.
>
> The series is based on 5361983c07 (The 22nd batch, 2026-03-27). There is
> a single merge commit with "seen", but it's trivial to resolve.
>

The series looks good to me as is, like mentioned most of the patches
were fairly straight forward where we simply inject the repo variable
into the function. Thanks

[snip]

--0000000000004a33cf064f06ab4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ceb943bda80462e9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWHBBOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2tLQy85R2VKR2pJa01BTGFXcVVEWFZ6ZFpIYm9IdgpUZkFCWFdFZkpm
T1FUY3hYeFhsSU5mbTZGMGtMcGpzRHk4V1lFTUhwT21HdndNamVONVpubjQ5VjlSbUpYQWpSClFp
bEVrU2hmRXdDZkxIR3YrSTRwVHowU3Z2c1N6czJLUEhPWGp1d2cvMnhYWGxvdnMxQUtWWEVGWnFX
MDNnNU8KTUF4azF6ajlTY0xiUlRyNlNVWGZRb3Q2anpOeGEwZFRzVUJVTGh4VjliQ1RDaGtNN00r
cGFJVkIyUzNPSktzOAoxYUdXZ2NlenRoQlk4WCsyNStrRitZeGthd0t1N0pDeUo1cmE0TGpvNXZZ
bzNybWxTSGhaczVFZEZkOStnQ2h5CmNpSTVZd0YyNXBoRGVzeERaT3F6azVnN0x0eDJYVE9xNUFl
OUZ4aWFNUTl0Z09pcTVsTERraTRscUdvRGFoSzgKZEFSZlhJbmRpSnVYanQ2TlV4cDJuUnROUDdM
V2xBRlpJdjcweVRXUTlnSFR0UTM5VHJ6aDdVWENVSjd0QXJueQo2cHVHYUpxMXlTc0Urb2Ezbk5h
R0I2dW5nU2hJV2VNTHoxVnVjRkV3dEVUQVFiRmNDWUV2NENIa2dYbnRTK0g4CkZwYVdZdENTREpK
R0RsSmM0M2lNcVowU3k4Q3VsODd5R1FyUzIzUT0KPUVIcncKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004a33cf064f06ab4d--

Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD791494A8
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826838; cv=none; b=imHaE/MmM04sy6rYc7crXFXbezt00cStYGlgdcTeCNoqsEHKnznyrxLCeoe3hs3cEojytE6miWaXPkghfhjIvZh/8qG1dN56xulf3OLgi5p7SE/6DukrtvA7ghM+VmuEUN3KDP5UUXfjc2022na9uWaR840BBnNTYfJahW7U7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826838; c=relaxed/simple;
	bh=Hc3/ck3nHwV9wFhEK4LOY8UmFO9G8eIE7kUICaAN6sU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEZht/0DQhpVdlEYAbPHOiL1Zf8UaK+njN196l2bWaJw44DbIkY7Hy5u/E9/h6py1/lIk31nvelx7FbgSX5z0U301iwqog5kP/CaRnXzHkuYJyi/C6TleeRhprptetuFy2vg5egWir1jhtLn8zJ3pnSjk9pJpWcXv+9qSvu0vO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUlPUZKL; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUlPUZKL"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-51d14932f27so3039396137.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826836; x=1760431636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5K/OQvBYtF0VuOHVQW2lyqK12jpqpw6TdYUYgKC2Kjw=;
        b=XUlPUZKLsoX023RLUmC0XTmoRF247CAYB3MLwNpKqyZCmZu4EL72uszm0M3vgI6XzG
         dXMZuhvobQwIYeRgeImhZgma//7GMIyBVv6axDiDJpjGVD89sGuJkva6yCDyHWbH9zOn
         Tdtbf8txpgi6d7uxpaEobshZ/+1ahIj/9qkFZ5B1hxWDGc83fPvlHj0rGTMTdwOWNEyO
         OnoHbDKiy897STX9/08ilOhp3I+bQJD0rfvgWW6e/G8Keq0q+KnxbOc36r8fA6F7jW8Q
         Y8Pw7/3OOHsBceEdblsxvS/01Vs7H6Knp0xOs3zlDsISvXpr9nSuyfh01WyesVk084AT
         FJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826836; x=1760431636;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K/OQvBYtF0VuOHVQW2lyqK12jpqpw6TdYUYgKC2Kjw=;
        b=jt3gk1gejIc2YoBK0MEmKVcVAtK9VKKUDxoMTbq7p+dQKogh0+Tx1k8pSRCv7zrYqw
         XjuFgVeEKiSO01FASicUp290RsQ3X6Vi5y4x8bgHJOOCalsj1alNUviP5dGbHDn76NRF
         IegcBJTIlXWvBfxZ5DwWEWL8h28GVBcBjG5PNJkddissemSNjnl41+e4uBlyfih9G9+v
         g8dahn30O9yBkdA5DfaRtVp0uOzNyQkMBfFFgbeUDLRgjHU4fziFuv4aeUGi54M4sy8X
         Z6ZIq02wfKoowEcsE3Pg76IoP7ezn4YLCSpavKATOhj2+I/P9W65QVAsALYR78tL2JHN
         T4Vw==
X-Gm-Message-State: AOJu0Yy4fE0zlMWFB9gEQVjG1N1pZ9SRcJ6UbIKb0uPdit8dsTS3HYfs
	/hZiiiQ15uxbvdUGxjXeoZVpYe+VcOtg9Wasd6fvWEIJTB1YMsCvqTnW3EkdnZ6aSCe/QoePN4M
	aqPqTdcEgxbonqwQ7YOeMp22EueSY4BliRRcf
X-Gm-Gg: ASbGncto9ce8Jw47W6sjYHo9OzxfBD2zU/XmMutbSwX+wckNgdpwp0z17dqIEeanw/d
	DeZplop/sp0dBCXpqWbQab6Wf+aGrv4E2m6pR0SZWV9jj5MhiMX1pGgRxLJh9H3xl0EuO+0TPh7
	y0SjTTntipJvTt4R5NsP/dWeQ51HsWRK6a99m7TR/79r8TtL1fNL1hNZwCDvl4C6rT+xcqJP1yV
	Z6z2JKwixFSEI83SH4Lqrfw+Lu9QDj8fO72IT8Box2hsSRlwPBAnwO//d3roETtqw==
X-Google-Smtp-Source: AGHT+IHpA8z34/Mt2hE+lp7yDU5FN14s26U1Cjr7XS5ek53AQ7PkYUf5UlzbxMdn+anmtaLO6KCxrewQz+Bl+IzBc+8=
X-Received: by 2002:a05:6102:1490:b0:529:1815:ae8f with SMTP id
 ada2fe7eead31-5d41ce40846mr5682413137.0.1759826836000; Tue, 07 Oct 2025
 01:47:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 01:47:14 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 01:47:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xcrof92.fsf@gitster.g>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
 <xmqq5xcrof92.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 01:47:14 -0700
X-Gm-Features: AS18NWBU0jHja7G4yIxenHJydCphG54Ppht6TYWGx_72BpyfRx-ER1CaQ4ISf4Q
Message-ID: <CAOLa=ZRToJOUd_Devs54NfLCJuMZSBEwNcM8J0sbvy7x5Rb=PA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] refs/reftable: add consistency checks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000006d367406408d9d99"

--0000000000006d367406408d9d99
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The reference subsystems allows for adding backend specific consistency
>> checks. These checks are run as part of 'git refs verify'.
>>
>> While the files backend has some consistency checks added, the reftable
>> backend currently has none. This series first tightens the reftable
>> backend to make it a little more strict and then also adds the required
>> infrastructure and some simple consistency checks.
>>
>> Since the reftable backend is treated as a library within the Git
>> codebase, we don't want to spillover our internal fsck implementation
>> into the library. At the same time, the fsck checks need to access
>> internal structures of the reftable library which aren't exposed outside
>> the library.
>>
>> So we solve this by adding a 'reftable/fsck.[ch]' which implements and
>> exposes a checker for the reftable library and returns specific errors
>> as defined by the library. We then add glue code within
>> 'refs/reftable-backend.c' to map these errors to errors which Git's fsck
>> implementation would understand. This allows us to separate concerns.
>>
>> We add the following consistency checks:
>>
>>   1. Check for validating the reftable table name. This is treated as a
>>   warning since the reftable specification only suggests a table name
>>   but doesn't enforce it. Also there is a difference in the table name
>>   used in Git vs that in jGit.
>>
>> We tighten the reftable backend by raising a REFTABLE_FORMAT_ERROR error
>> when:
>>
>> 1. The 'tables.list' file doesn't have a trailing newline.
>>
>> ---
>> Changes in v5:
>> - Added documentation around the return value of 'parse_names()'.
>> - Added a test to validate that 'git refs verify' doesn't barf against
>>   a clean working repository with multiple reftable tables.
>> - Link to v4: https://lore.kernel.org/all/20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com
>
> Looking good.  Shall we declare victory and mark the topic for
> 'next' now?
>
> Thanks.

Peff pointed out a mistake in my test, where I create root refs instead
of branches. This works without issues as we don't yet have reference
level checks on reftables. While it is good as is, I do think it is
confusing, so will send in a new version with a fix. Let's hold out for
that and we can merge that to 'next'.

Thanks,
Karthik

--0000000000006d367406408d9d99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5c69407508930064_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qazA1QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWJjQy85VnNEWFNQT0c4Sit3eVJaYi9qcFdNalFzegpEbE5qSU1CeWZX
MFNoL0dGWXBVdjNGVmNDU3N6OVF1MUI1MFlhNlNjSFZJZUEzcHNRd3MxaHMxVVdJWUJ2ejBNClFl
cU1JQUR1K2tRSS9OaXRvOUlpalN5MXMvMVRiK2M4WWhDVGhnNmx6R3MzeVdHQUR4bU03SGVlSHZZ
L2RqZjYKclNIc090aGcxNnRsckJQWGRnd3h2dlBqd0M2UWo0SWt0RlUzVy9SUlZHeVdyUTRCVFlX
UlVOK0lYeHErRkVpUApudjQvdnVSaEN3dnNWSVk2OUlzWUxoME5MSWZucEE4eEhhSi92TjViY01Q
SGQ2UnpJbkdBZzlWNFgwTGJDb1RJCnFCeFpSY09ZNUIvY2I2Y0plM0JsdVltWEMxQ1dlM28vQ0pi
WnFNU2ovZ0pDWHA3SXVaOUJkV1N3RGo2UzNOUW8KWm5WRGJYUGk0QTdzM0JRNEJidmJ1dFZTS0xw
b3l4MW1lR1hTM21DTTdCa2VuenBsMWhnQzNUVnlGSmR1Vzc1UwpSMjRYcWZLNmlGbjkzdmZpRHJn
L3c4VkdKYmd6TXJVbXUrMG8yMi9UT3FEMHdhbm5qV1ZNeWRnYXhFcUZJQXhRCnpTTnp3cUx5Rzlr
emF5LzQ0ZXk4NlpIT2ZHNWFvOWs3NmpjQ2NYQT0KPWQ0dzYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006d367406408d9d99--

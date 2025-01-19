Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C31401C
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737273822; cv=none; b=DZNrN5LIDlxw7u4r1qJciyi3Fyps25gn5Wu0kSqWI9fGoubjBDP4OWu+y8YmsYpeVpJrPnEemt60nKp1SF8cYkOj6+l6sEeeEemXtv9erbo8jvKBrjFBSkUHxEeDYzfTORunli/lsyIV1X9/fyjJ8M+ATy/Rg5WbM2uc0XcDn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737273822; c=relaxed/simple;
	bh=OqzQESD+xUNxqF1YJzDo7Zx5kLDbCz0VwbIUtvX2RJQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI0e1jFWddF9gH5beJeiu62I/CYyLNTUQB+QqGA7Si6XAR6wsNa/Cy9CWUuJ2yqLn/5UCcZ+kVENy22nrwHDmnMWvlwnznITZz1ESEiND1iCHpTBTGyIIQlbiN4gFTcTi6HIQTH7Hpjca4uBydI0yQBy8+OvFtSFe+/aoSevJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iALwY6NX; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iALwY6NX"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c4d855fafso577147241.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 00:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737273820; x=1737878620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=24DpsBMCIYZXbUEabjAtuPOM70FfjQjluugxqM+3E2Q=;
        b=iALwY6NXsZD8jsa9mOJg5fRt05J7uEniLTrF7vDk2shgQaxw6QfCoDHYj4Y2xqW248
         Dw9DG+Yhe+mjhugaQas1tEGUfNl6CqzNG61rqadugAA8mNdLcm/CS0bbULuRNRcuV7ai
         Q3gIF+CZMDAFdB6R02WQQ63Li+gjrgCmfYe2VihSUlMd2yzg53feITQYx09bAAegewS8
         hjtzX0s5XH/+iJsPJFoHI8gH+3g5jRZKSzQGWHIiHaVwHGZsFpQ9b8KzjRflfrEpTVy6
         CovNEa86G0hn6lzgMkttXNlevt+ia/DnTTpQv6wAoQFwKLXiohK493ef+xbP6UyK4cjM
         OMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737273820; x=1737878620;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24DpsBMCIYZXbUEabjAtuPOM70FfjQjluugxqM+3E2Q=;
        b=cZgyc4lZ6EoTfXOkrfaFJ9ZQJO1Y1Vu7NXB5IRnbklhrFSP8rEEP0FeDAohStg78rM
         lDJfau8ewGMvY+HNpj2/WsuFLA2UXwFJQRxA3gyerrCc/rNIhzI7NXEueVm+mDdUxbWB
         Sf+b3MUZZcsRqwJu7W/Ip9f9H2sRcHLAL2S6mflZ5QbUMpTkYClMuk9gfSu1bvRM/PyY
         tljsOXnNyvRagDkapl4tSpOB64Nmbe8t3drB8eMH+X0lGF1Ic3FCdBRliBAEi09w9Ddf
         lFkuaeq9Soc+Oc+GFqQeY+usBo4IGHCDMNUPu+sgE5/XmUHXyuvJWZ9t041t/w7ue1uy
         khkw==
X-Gm-Message-State: AOJu0YyUh7lNo45MrS0F5f8dtidVh2ERMRAjKRLplGRj2kY+tbklf76n
	N7vQBbyZFR7/LqmJQttR6NgptmJIxWSY1Eb8imc+V5grW0yzKa+WrAsybHwWHxAHfO6kmLrOxNs
	jcQmNuhcQYoOZZU1Q1uyDH13/lM8=
X-Gm-Gg: ASbGncsrYLUm0VLFQCOj4STXmzxkes13ybF2K47HIJkki+SmnWw1ERQJy+wlQb4Y+aS
	khctpIavMn/2C/Ndq0N22qg7L26kYS1Dqmlaw+rjHLKtndjCGRYAB
X-Google-Smtp-Source: AGHT+IGeb/C3QQkUCD0Zumx9aWX7yR3+qVuyoUoYJ9/SzG63h8q6F9MXJNJMtYvQao8jn0PQyJmbMb+vwLhAvDOM1vc=
X-Received: by 2002:a05:6122:16a5:b0:519:fcf2:ef51 with SMTP id
 71dfb90a1353d-51d5b264a91mr7032175e0c.5.1737273819993; Sun, 19 Jan 2025
 00:03:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 19 Jan 2025 02:03:39 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cRsAPp1APNJ7W337UNtunETr+Lnn-RcGrAXEFUhN1APyA@mail.gmail.com>
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qN6C2IpQTdVn_S@ArchLinux>
 <CAOLa=ZQ-cRJeWjP-_6N2v4GS5P7oYVUyb9_tbY26W7MAJfJ6ZQ@mail.gmail.com>
 <Z4pijwANZWAP2XKH@ArchLinux> <CAPig+cRsAPp1APNJ7W337UNtunETr+Lnn-RcGrAXEFUhN1APyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jan 2025 02:03:39 -0600
X-Gm-Features: AbW1kvZidIUllm6rCWlo69J0FboSzanCRyoOfvJTBqjQYVKItuwRaTcCl3ap1FI
Message-ID: <CAOLa=ZSwdk_Vz_8ZMp1+ptjaeEFMWxEwAa8_U1j67fp2PPupSg@mail.gmail.com>
Subject: Re: [PATCH 03/10] packed-backend: check whether the "packed-refs" is regular
To: Eric Sunshine <sunshine@sunshineco.com>, shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="000000000000eb3d5a062c0a94d7"

--000000000000eb3d5a062c0a94d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jan 17, 2025 at 8:59=E2=80=AFAM shejialuo <shejialuo@gmail.com> w=
rote:
>> On Tue, Jan 07, 2025 at 08:33:56AM -0800, Karthik Nayak wrote:
>> > shejialuo <shejialuo@gmail.com> writes:
>> > > +test_expect_success SYMLINKS 'the filetype of packed-refs should be=
 checked' '
>> > > +   test_when_finished "rm -rf repo" &&
>> > > +   git init repo &&
>> > > +   cd repo &&
>> >
>> > This should be in a subshell, so that at the end we can actually remov=
e
>> > the repo. This seems to be applicable to most of the other tests in th=
is
>> > file too. Perhaps, we should clean it up as a precursor commit to this
>> > series?
>>
>> I have searched the usage of "test_when_finished", and I don't know why
>> we need to use subshell. Could you please explain this further here.
>
> Karthik may have been thinking about operating systems, such as
> Microsoft Windows, which won't allow a directory to be deleted if that
> directory is in use. In this case, because the test cd's into "repo"
> and never cd's elsewhere, the directory is still in use when
> test_when_finished() tries to delete "repo".
>

I didn't know this either. I was mostly talking about what you mentioned
below.

> However, there is an even more important reason to use a subshell, and
> that is because a subshell ensures that the current working directory
> is effectively restored to the path which was current before the cd
> command. This is important since it guarantees that subsequent tests
> will be run in the correct directory even if the preceding test bombed
> out part way through. For example:
>
>     test_expect_success 'foo' '
>         git init repo &&
>         cd repo &&
>         ...some more commands... &&
>         cd ..
>     '
>
> If one of the commands in "...some more commands..." fails, then the
> `cd ..` will never be reached, and the current working directory will
> remain "repo" rather than reverting to the path prior to the cd
> command. Thus, any tests which follow this one in the script will end
> up running in the wrong directory. The proper way to protect against
> this is:
>
>     test_expect_success 'foo' '
>         git init repo &&
>         (
>             cd repo &&
>             ...some more commands...
>         )
>     '
>
> Exiting the subshell will correctly restore the current working
> directory to the original path _regardless_ of whether the test
> succeeds or fails somewhere in "...some more commands...". Using a
> subshell also means that you don't have to manually restore the
> working directory via `cd ..` or similar.

This is was a super nice explanation compared to my single sentence.
Thanks!

--000000000000eb3d5a062c0a94d7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3811833788e197f4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lTXNkWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWRYQy80MG1ZTVk5ZXNSU01UZ09lenE1ZHIwOUJ2bQoyZDFaMGlzdCtw
VkVVMkR5ZzNDaExXRytwNU5Kby9IVWpUTUphVnowM1d1NUlPMzhCdnQ1cmpnT3M2Wnh1VUtvCkla
b0pTRzNkUVZIT1NCNGpwb1FUU3lIRXc0VG1jZXpPRUdINjNSdERmdEpvb1ZheDJjdWFQZlhXYTJu
b0h1M3MKOVBSRHJFcjEzTWo4Vm9UZncydy9hN1ZnUjVvR1pLSThSVzB4ZlNobkpDcytyWTdSK3FO
TTlheklBMzIvUlBFMwpDeDBNR1Fndm9iblN0bzJDdDVsRWx2dEZZbmwxdDdKTkh6VThGLzQ0WVI1
UFQ2RkRzd2xDTFRFWE9GZUI1VGc5CjZlUnNIcFJ4TWgrZTNRK0x5RE1IRmpxSjhzL3VIOXJ5cm9r
YjZPWnBjTHdXUFZITUNMN2VqcXd4TXY4bjVHWjgKVjluc2FPVkJKU1NQSHZwWW9ER2dnaHcrSmI4
UTYyL3VPc244ajhraFEwM2dhQjV4RUk1UWRoZHZ3SkJTOCtzcQovSXFNM1U4Ny8yQ3ZWcUNxOUZa
RHAwRGdFeHJCaEVjUlh0RitIZ3RUbVZQaGRJV0d4TjNYWXNuR3B0NUlhWHdKClIrYWFRUTJpclBN
S2FQL1ArVmJrQzRVaStZQlZZRUx6QmpKcS9Tcz0KPU44Z3kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eb3d5a062c0a94d7--

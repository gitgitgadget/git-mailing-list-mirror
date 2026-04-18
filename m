Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F778349AFF
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776514644; cv=none; b=hWdi8zTx43mtN44WSGXe1ibFBkhEaA8GBXWTO20hdimf46t5CDu+Fi0x2U8lRv9liYgd933bgPrivriv2L0vACnUeYaMtoSMyxGIRE+DwOk4olyU6WmE0TlUg5QTdspvojce6tplVQ2jDlVhPSzmGM69FoaBILrNWBMke1Nx7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776514644; c=relaxed/simple;
	bh=W7riqNhaUa+KW7jKj9j3R1FZL69oyPxejkv4b7e0apM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OIFB61NB/3oISjSgVS/ltjboOfwxRYVt33+yUPjcJ7hKp5ZnZmNv82cJ8+uUphSPcuwzGqbL2r07k/Jw7Jv+qo0pf0hjjCvSAYNhD+qR2eM97Knj3Bwg6PUZFt+p2AZJfV72WLEkKDQDDd8pPN9CSaGQPQxuA5WUJs42bbkQqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVJDomNt; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVJDomNt"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a74765703so14070057b3.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776514642; x=1777119442; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkzcGGom1mssS2pwl1OEdBJiIVf7c4B5XgUByXF7gF0=;
        b=kVJDomNt8v+Irj0R8PpwGywdG+TY5hqdHX+yfLNyl3YqcFEBMXhGXvzmzUaxRf7BdW
         2qM+pA1FM4Ur1nKwkBdg9mFW29l3IEDrDjMGLHjFalcVyB580CwUVWi8CMwH3n+HadfC
         9SWpDg+iovAfHvfM3L88Q5xvfYUFp72u5TJMix9ya4pkOopyBw1944z4Xa+a+k+aBTQS
         xLazQ5nInpziarm1D8zQGMW3X2oGMl8xvWJvtJVhHKzoNkSdtWs7DcTUv38O9ra4qPHl
         p9mFmxQ6NK2s13JahapCpW5oEdv4/QYZwPCB6+w2p1C/ipGhWW0B2v4cvbQvkVgOVPcF
         nrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776514642; x=1777119442;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MkzcGGom1mssS2pwl1OEdBJiIVf7c4B5XgUByXF7gF0=;
        b=LVimDqyMtsCUkW/cq6F+KCRaqVpmcyiFetOzFA33Ddo4hYvLCXpDAll6MLJp8xM1VO
         HRKFX91ZTzCC/KXvcYeaeI2RHTqnQpFYGtOqmbECLLZeaWLKOz5j8rEQ2w5BHDpHJH2X
         jBYiaw/JRdSDatjlYStKjgPFQU3GFxK+gQizyFmdWp1eZjQqSL2+ckfyZZ7OD6dGDYLA
         g4hk4MWD5H64Zh4OqPymhC0TyCq7IZfDvLBCdFIOQw5VlwAPJPjBnRhow0L0jjFqyEwW
         Yaz/PVe/YDPcB/OzrpsCuHL4GN4xa4E7CASj+8ygnsKXXmIa6B9HKuqC6TRbmUm1sOVz
         4eXg==
X-Forwarded-Encrypted: i=1; AFNElJ9e0NhWS0F2dNJRWTxBjnWFst1MbpsR1nOOxxIUlpR7Or+2+zcGYGnYZzbXvmB68EVErSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpZa3oN9oksAav3RSmLkn1291DhNT5Kukcy/TPn9dPXAnMmRJ
	AFflZKew3vyUTzuTNhR53DCnhVA2UcGqgwqqsV/ttMxBhJmJNT9fzmum
X-Gm-Gg: AeBDievgonhwGNKHLPgEF2BYursOXTIMROowEc8b13VnvxHVQFxdDP8dBIXsBzfArFF
	iFeAhto61fz46/DH5btw5PoD4ulMCvesc0dGptycjNDP4u7EVZqogV9ILajquYW7FNf05N3qe7q
	YbdAH+dgmjqXirmQd68SQMdgErHfjxS9Qet1IkIFkTY+5nS6Kqkj5v69pSBufFBj8iYUtsgSDvd
	0NClzirYPOG2TrhIDPLXBd+JMvi54OUSqGwwH8gn9BXUMgtW9Zg36GVZ8r1OHsKy99R72kyimmc
	or3a8Tb6rYhf8IzmOb6cz7hBK0U09QIv5pvjr/vMeP5j5/qomFY5iqh6KxPDIW7nXT0JNtmQCdq
	DJgWQMXhxi5kPTOOF8VF0p73zGpDLKoxDOXmrkxiTobVfCRyzGOPBN0G3CJ1ci8ZJZ3KQ+BwCpW
	xruGdakVbCo+DegEIBVYLe1fxrozvHdmLxp8UoxLAF6mXdji73caC+wcuxCiIxK/BE+XS78TJST
	n039dXH9uTHI5+HyBo9bLW9ftmCTF8HWkJ13OcNwJHQq6EZd++inPGykXYZy1ABres=
X-Received: by 2002:a05:690c:c50d:b0:79e:8299:751f with SMTP id 00721157ae682-7b9eceae705mr64974467b3.7.1776514641683;
        Sat, 18 Apr 2026 05:17:21 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:bc38:40a1:74bc:499c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9ccdc4sm18398437b3.43.2026.04.18.05.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 05:17:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Date: Sat, 18 Apr 2026 08:17:10 -0400
Message-Id: <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 =?utf-8?Q?G=C3=A1bor_SZEDER?= <szeder.dev@gmail.com>
In-Reply-To: <20260418065009.GA2619713@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (23D8133)


> Le 18 avr. 2026 =C3=A0 02:50, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> =EF=BB=BFOn Fri, Apr 17, 2026 at 12:50:58PM +0200, Patrick Steinhardt wrot=
e:
>=20
>> --- a/ci/run-build-and-tests.sh
>> +++ b/ci/run-build-and-tests.sh
>> @@ -15,6 +15,11 @@ fedora-breaking-changes-musl|linux-breaking-changes)
>>    MESONFLAGS=3D"$MESONFLAGS -Drust=3Denabled"
>>    ;;
>> linux-TEST-vars)
>> +    # Ubuntu uses Dash by default, but we only enable use of `set -e`
>> +    # when using Bash 5+. Ensure that we have at least one CI job that u=
ses
>> +    # it.
>> +    export TEST_SHELL_PATH=3D/usr/bin/bash
>=20
> Thinking on this a little more, it is a shame we cannot easily enable
> this for dash. That would hit most CI jobs, but also the local builds of
> most developers. And finding problems early and locally often saves a
> lot of time versus finding them in CI.
>=20
> Unfortunately I could not find a way to detect whether we are running
> dash at all, let alone a recent version. But what if we let the user
> tell us? Something like:

I was just wishing for similar! I imagine it would be useful for folks who o=
ccasionally test Zsh=E2=80=99s POSIX mode and want to see how it handles -e

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1f7868c537..a0d07f75fb 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -17,9 +17,10 @@
>=20
> # Enable the use of errexit so that any unexpected failures will cause us t=
o
> # abort tests, even when outside of a specific test case. Note that we onl=
y
> -# enable this on Bash 5 and newer, as `set -e` has wildly different behav=
iour
> -# across shells. The list of allowed shells may be extended going forward=
.
> -if test "${BASH_VERSINFO:=3D0}" -ge 5
> +# enable this by default on Bash 5 and newer, as `set -e` has wildly diff=
erent
> +# behaviour across shells. If you trust your shell's `set -e` implementat=
ion,
> +# you can set GIT_TEST_USE_SET_E manually.
> +if test "$GIT_TEST_USE_SET_E" =3D 1 && test "${BASH_VERSINFO:=3D0}" -ge 5=

> then
>    set -e
> fi

I guess that should be || instead of &&?

>=20
> And then those of us who want to stick:
>=20
>  export GIT_TEST_USE_SET_E =3D 1
>=20
> in our config.mak can do so, and we could even set it in the ci/ scripts
> for all of the ubuntu builds.
>=20
> -Peff

Thanks=

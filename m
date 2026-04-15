Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127C19D8BC
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287888; cv=none; b=aTnUO3diUKZoQljwGUoOFNveRpyA7aEmwbvLwWVty98oOzhXdp5VFsQSiPsPa12LttDKYrQ6RyoSuHX586AIHdRHTs7vjHYICtXJRjH3belh3BuBN8ClboKCT+hTwZ5nzVoVSjtQjfjRekRAei2CF60zXhCi1MxU7nRkS3WWd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287888; c=relaxed/simple;
	bh=/7h+aC6MBVf7J5P9g9R7gehyR6DD6b4VLhU+Yv5wncA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=CAu9+j7bvor7/dkhoQVS5zcBz4K6bFCkptdImrJDS1Vwpxb7pB/79+ziTeeVYFMVMIru3BNAS8zfpL3CYYP835o4t/KuMM6Y6v+bjwYXsJuoZk8T515IKcp+Txu+8J1Vw+lhb9rYEQxFvuSJs9xP0IndX7BNbaqQ5pjirRp10hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O07MEeDK; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O07MEeDK"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79ab3e26cceso71673527b3.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776287887; x=1776892687; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kgJ0J6SBjjvbm9ksIfeedVHQ9OIzSlZLFnyh7lDSN4=;
        b=O07MEeDKGmFidFRryrt0ge4xvF7QBL53SlKJ5bQLcIxWUWp8YZtXvSFKMslMlTSmvS
         oCgTFvnoF23f2cIwK/9cpcnP8wPS2TtJXKMf3tYoQRVXSKBoCpoVWh5DgMhmeKYGdUJe
         ky+hjRO6UezJpdLJCvEm9Sd3P8VxYFZJzTPFL663aleLv7jv+YNcWXVDWp4U9lyFvdkA
         qEA7lGlvJCdlipIxT/c/QRD069GR9Bhci3u7a5JRePBp+xVTnLQtjbdej5QVEybu8KfB
         L5qleEo2KvghCY67eDjxGBcwLJDmb6woycYnUeqE4POEv+xUK2xvH3zej1Eq7Z9Gek7e
         eOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776287887; x=1776892687;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kgJ0J6SBjjvbm9ksIfeedVHQ9OIzSlZLFnyh7lDSN4=;
        b=DqDWDWJjhaPQbn8++aZXcOv88i3cwZYq1VFL73N+fjhh0wyTJx/DTpkgkfxUXzFMg6
         JGMVAiagd4r31cW3vAEe4rTIZko1DjEMQqeew4Kc4yCessEF9Ja/wyEnd/bRMWoA/BYs
         RjGWgBgDLHqGMQTSsKR/jWtDLvq5rKC+q3nG36u9cG0VnTlgDQvIRrJPpNiutGlA+CVe
         nSwCg3lRqULcHkWUa27b4AlpCuKAWxWJ7lL657o/jqBW1Ow+H/33ADPa37OkcV64PU9P
         ZMpds2AQX5UCzwFhsjj9h/5oIA9ogMsEPcMLjDoVKs1NkTdcN/3QA2Apvvt/+qzD/StJ
         Rdmg==
X-Forwarded-Encrypted: i=1; AFNElJ/kwRfl7W0x1K82Wu7cYejzOOdGk7Rb97d9JzyIEKVjjVbPdF9BKUM2HJC73CwjqZ4/09g=@vger.kernel.org
X-Gm-Message-State: AOJu0YycO6idf+7gSyu3qJVTZQyeapA5Qua7TcAAJcS17G5qmd8IJvHG
	lbOD6BiBbBOoxY6rpEscJQKU0Ga4MzaxeAtAkONYQsczsL8JnIH68vyb
X-Gm-Gg: AeBDievtqGOzTYaRhCe8zPAyYuW1xhqJ2PDAsMEsNC4s/1r6CRvNhJ0zvRpYOESXFWL
	nOUfJGZDAKSsV0p46kz4HrpTBDIPFB3MyPVOUnoLY2OoqZJwLfE2vkhXQarr4We5Nxi4K2qCZua
	EPZs7o0sSzRTYu3VAOZ2jAmFR5n3GARJeJpjJp2a3JdoL3+sLMbAUCzOkfglDGTg0aMAnZV6iYY
	KI1w5Wb3P7LOn5iiYfyZCOk/HzbIzm5DK8bsjN5EV8sv1jD3XcCvvjH3kGNMQWnKpzM5yD8kmjM
	4PIjG5d9aE3Wtjef3h1EsDUonkEzY8uc7KNeLDVVfIdaQn/RTiMVBczovgjp84ngT2x+8Z+KTGD
	8motw84xFxuxf8bhDq6ntmGa2m9v/+J+2usjwPdvi/mDqNxHJWSAdj13ozNgV5AqpjrlNwcfDfP
	u8ZzLXkjFABfnm4fQUS7Vt81O458OPCfLcOEw74uJORzz1l69KMNimWYEUvvtfk2xz/W3UufOVv
	kCzcEpMu0BMpx+958e4on1h8RUlGgOYY1AaETrbnKXqK2Enf/IMgfw=
X-Received: by 2002:a05:690c:7108:b0:7b3:f33:35e5 with SMTP id 00721157ae682-7b30f334018mr149384807b3.16.1776287886685;
        Wed, 15 Apr 2026 14:18:06 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:4cb2:f26:96d0:1bb3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b7667f8de7sm14815707b3.19.2026.04.15.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:18:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v15 00/13] fsmonitor: implement filesystem change listener for Linux
Date: Wed, 15 Apr 2026 17:17:55 -0400
Message-Id: <57A4EEF1-6D80-4CCB-9D42-EB919A3A7692@gmail.com>
References: <xmqq5x5s6p3w.fsf@gitster.g>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Paul Tarjan <paul@paultarjan.com>,
 =?utf-8?Q?G=C3=A1bor_SZEDER?= <szeder.dev@gmail.com>,
 Jeff King <peff@peff.net>, Paul Tarjan <github@paulisageek.com>
In-Reply-To: <xmqq5x5s6p3w.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 15 avr. 2026 =C3=A0 14:43, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFBen Knoble <ben.knoble@gmail.com> writes:
>=20
>>>> Le 15 avr. 2026 =C3=A0 09:27, Paul Tarjan via GitGitGadget <gitgitgadge=
t@gmail.com> a =C3=A9crit :
>>>=20
>>> =EF=BB=BFThis series implements the built-in fsmonitor daemon for Linux u=
sing the
>>> inotify API, bringing it to feature parity with the existing Windows and=

>>> macOS implementations. It also fixes two memory leaks in the
>>> platform-independent daemon code and deduplicates the IPC and settings l=
ogic
>>> that is now shared between macOS and Linux.
>>=20
>> Troubleshooting a Gentoo build failure of next has me pretty
>> convinced this topic is in there already. Junio should probably
>> check my math, but I think that means we want to see fixes on top
>> of that base now (unless we are reverting this topic from next and
>> queuing a new version?).
>>=20
>> (The failure is a Gentoo-ism; we carry a patch that stops applying
>> with this series. Not anything this project needs to worry about.)
>=20
> I reverted it yesterday out of 'next'.  I do not recall I had a
> chance to push it out, but my intention is keep this round in 'seen'
> but out of 'next' until people are happy with it (which means folks
> who test diligently like you do would need to peek into 'seen' as
> well as 'next').

Thanks. Hopefully I=E2=80=99ll get to both seen and next soon.=20=

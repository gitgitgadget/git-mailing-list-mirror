Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71A18E20
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720992464; cv=none; b=oqZwjG11P84izlBeyHKAz7e5jYqni6FzGsns29W4OJ0abZOJ2URhfJWZO+4yjxY0w+QFVqqnC1NCXVQQ4p/ptIUI+ugXZcjXoiuWAFCxotnkEFC3jRyODsAQfZrLPvw63qTyH/lKm4lhxLYi2KJyf4ex5oFBp0f8sVLI6btpMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720992464; c=relaxed/simple;
	bh=dNaBhqzkhR2cLgvDYS9nWqKSCToU1nnCRtBcdbJVj8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGZI7uqWTfmj0Xc4/GloT5MwAArUUiVqE/zU9XuWsiI37E8XE6H5UsKCNx3rAX0r08x7O8dSXSW3gX5B1P+/AabTh9SdUdgXHByZi+a2q4SVVQcSf3HlPDxa3i1RJL29WpqDGZd8aMmgzcYKkzSZtqBWdIGcwoO/jk6aEbZ1yIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48fec155a0bso1463552137.1
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 14:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720992461; x=1721597261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6E1enuDL9KPVeyUiNacF8SEPE4fpeBycqKTNQI7icY=;
        b=euATvL/qK05IEFLT9sTnxAZ4iU2OS2ujcuVIn7GbmdbPEtPukII+3XMnou+5RLP/9E
         hvFqjU9qKTpajRRlf0363JEdj6uaSuaP+tyOax+8QaQ3vqQHwtzWEvjZpEWly1h83Vdu
         ZCO7iwMUSQnImq158wN1W725VbPHgyHfFwlWgJsd/NZWDmSLSQ2XPYWML5VnQe87tIwx
         A0VQTjPdSBfArDKuGryHn11l0It+bYkbI2iw39ufXYR2++NMKsPmigNiwfignl5Femp3
         pPNsze6HdcvB4RUzeiJ0fCACOZnVROm1KWvGs5BRRr3uO97OtGO80cWNbiHCbxmPQpaw
         SRkg==
X-Forwarded-Encrypted: i=1; AJvYcCVHlXYLr2JRAjC6fSSzHA9cu0T6PhbtAxCxTmtzgSw1WCyhqBrA354I+ZLG0mOY7Ksf4PcS7aoxyXPd5+re2QbqAz0m
X-Gm-Message-State: AOJu0YzSXNEcmz5foTQaswKkJwXL1/ls9ZxzMGlU1zyHBI6h6FCzOsQv
	SwQG986PzG1EQSYaRN1traxrOGv88SBAUpY3iLt9w0Y/VKXqkVBv2u0l/9xaju8MCdCz7FNnxat
	Ht/k7f1vMZHitPDxHKuHEUuuXTkzygw==
X-Google-Smtp-Source: AGHT+IExrFTJetCu6WVZZ7bKRhtxDslpVWDAxhao8lT50KlFqe7Yu8yZOvoufvqrx1CQQg3ECeirrfW0CJdiBJgOc3c=
X-Received: by 2002:a05:6102:800c:b0:48f:df3b:9827 with SMTP id
 ada2fe7eead31-49032210fa0mr24640364137.31.1720992461296; Sun, 14 Jul 2024
 14:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
 <xmqq8qy4adl4.fsf@gitster.g> <001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com> <xmqqttgr9aeb.fsf@gitster.g>
In-Reply-To: <xmqqttgr9aeb.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 14 Jul 2024 17:27:29 -0400
Message-ID: <CAPig+cS9PbV+o_f0EbHPqtG-azHqzu5CpDgB5h+tZ58iGd_B0g@mail.gmail.com>
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 1:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Subject: doc: guide to use of "local" shell language construct
>
> The scripted Porcelain commands do not allow use of "local" because
> it is not universally supported, but we use it liberally in our test
> scripts, which means some POSIX compliant shells (like "ksh93") can
> not be used to run our tests.
>
> Document the status quo, and hint that we might want to change the
> situation in the fiture.

s/fiture/future/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuideli=
nes
> @@ -186,7 +186,9 @@ For shell scripts specifically (not exhaustive):
>   - Even though "local" is not part of POSIX, we make heavy use of it
>     in our test suite.  We do not use it in scripted Porcelains, and
>     hopefully nobody starts using "local" before they are reimplemented
> -   in C ;-)
> +   in C ;-) Notably, ksh (not just reimplementations but the real one
> +   from AT&T Research) does not support "local" and cannot be used,
> +   which we might want to reconsider.

The last bit ("which we might want to reconsider") probably belongs in
the commit message rather than here in the actual documentation.
Saying "we might want to reconsider" doesn't help people new to the
project who are looking for guidance _today_.

> diff --git c/t/README w/t/README
> @@ -850,6 +850,14 @@ And here are the "don'ts:"
> + - Don't overuse "local"
> +
> +   Because strictly POSIX-compliant shells do not have to support
> +   "local", we avoid using it in our scripted Porcelain scripts, but
> +   we have allowed use of "local" in test scripts.  We may want to
> +   reconsider this and rewrite our tests to also run on shells like
> +   ksh93.  Do not add new use of "local" unnecessarily.

Same comment regarding "We may want to reconsider..."; it probably
belongs in the commit message, not here.

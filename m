Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2C18E02A
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683610; cv=pass; b=q2EdA23fgIWQhOqR9CEGdHKx/ztyifdQngud5jO2vxf0/NOyfLOZOoqfDPXdNoEerKv2PAwVOY5GqrYc0PBIZX4VM2MO8BfvbQKlFf6JHQZDkHd0I3NNg4sE/oD1G6qwKi54PeUEU4GlOAY0qYnl3rjHHpdzSk+Zl8/3dW6fbWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683610; c=relaxed/simple;
	bh=XlmOLv7Fr+1KN1kQmh0rZVeu+ZtGbU2Ssd7fmmZB0+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEjQZWBQf21WPVumIGfgHxaBz5aHa0C4LConTxgSrRb7NOh0dStvAqWM2QqQV2TZYnMqFZTtD/wTWGQ0oIFoqfXZLL/m0JWleyqCwJVJ7M7XUk4a4RjKlb+FNiO8P5AGfnlWD7UkM/Q60EtE6IUKP7shrF8NQTwKNV8QDS8KlzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM1pxY7m; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM1pxY7m"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae1729637so1605072d50.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 16:33:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770683608; cv=none;
        d=google.com; s=arc-20240605;
        b=SM1FXlZ9btc6ue5MXJ2dhDg2EzxqJ6V1gXRjRUbUeD6ju8mSltJHZvvfhGhr4KrHRE
         e+TeOG0QKe56zBzXJEv3P343nwxY9kut50TGqbkZ/Z/MiqgcBnrajSht7yR6qArLQ1am
         SF5hr0YSEBk/eLdruxi5MuzYKnhB3PhbziqXmWa59iVxv5VSJajqK9gqkkvSYMj1tFTZ
         HJ//pSHT2uZvpljvtcniKRdflCsnG8S2cdmnxZ7fJ8+GoB5N/C/2tAV71UGyNCLN8jyb
         gqWferl8pWGKyM8hKPwnx+GmAKdk2LGPeq4dNG5yJVXC2J9527pYvf9Vslnf3jP8ECwu
         HhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UHSrJ+uZZNwmNc+OqKDjKTU0ZeMo1RHYauGycVv7llo=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=UhPZMRrjvTq0mQCUl7knRGInCsWAyqh+UCe0J6gyr5uuntbwFrKarEZ0isZUHTk9WB
         tp4KIxtO9Ffs44TOv4zm2K1XvYmgUFabyqDtnAz5J1JBaSfdxEdZlUnHLgec03lKX4zj
         8d/++SGJCEbB37Qpt+wtwaLeQE7XLTNAsc1dHNBOKCddXhxxel1N+VbKDV9HL8aa90EO
         dIpQDGRMPR+v7Q8PbQPiUmRSJCAAi4zN7PxejEY2K4P79s72BdFF7XL7rFwzBY4gbnSl
         JaBBWgb3E/EFv+7hpluAq+adJbOJeQKeCu9QtD1AXJuKBMpkIwgwFuDe09ljRr1U8C+y
         oCgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683608; x=1771288408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHSrJ+uZZNwmNc+OqKDjKTU0ZeMo1RHYauGycVv7llo=;
        b=LM1pxY7mC5Hw026pPXluEWXl059oUjah5d66S4IHsPhCzRV0pOHVB77vCWCvMy2vvV
         2992CyiFf/3EnySgokgKiXj1bIa8mrtMaI4B76WpmjaR64tmoF5mTrwIB/vfZLK6y4F/
         kqYLaMnPhBw6WKIq4xRCroBv1Udqqb/X9gGRz1N9MVXN25Y7E+M0VRL8lMRPzX5K2btQ
         d+iiX0D8XY5rLWB0XeNPgVnGXbPUrKz26TOkdd+kL23qqAzXacj0QviSnCsBgZMSBdfP
         JSnoWpdx72GxaEnv7B4DAvwYfGyNVVPAHU3a6drejZSYxVSSFAe0kSGX9YaC/5tSXi58
         K+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683608; x=1771288408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHSrJ+uZZNwmNc+OqKDjKTU0ZeMo1RHYauGycVv7llo=;
        b=Q2TdCQIbygWCvRAkWkiNx8Ee+DH34ih+4st7bLvxzbAXSIXF35RdtrjUpUqFG5nzZG
         Pw4vxJLNrMzyPF14+JeD9hiD7OppZIvULWWqoytX1ibDt/WhmCBiyP6ASp2lpqxcvZ4Z
         Yv2nRYmNGk95amGGIdSB3LXY/BFGgyx35b/j5FQM4nz7fn59Ks2i4s6UJ++t9dB7lFAu
         Xtul0OuU9ZApb4fFgBqRq6qzz+MI/NcYYOti/yCQdi/VWEFBDNo/1Qsc9uq28hk1jMEP
         2jqYMogAd8ae0N3Q5MSkQgOBsPXZK7bKMvnTeQ3T6G5QjRBXTce6xgK6b9uYw0xfLvqk
         ICBA==
X-Gm-Message-State: AOJu0YypSpEIh4ZXAyNFjJ2gQdDyTdArBxqei7H7xyO82McSJUNN43hx
	HV2rXBzEXvt+tUEjQqCTVyDf7lA6Jy2HLr43Q0tIsQcrmxXTGrH4yOaF7R9Che9wSxhR4/k/YmB
	msU9h2XelkZBDk0Oc9lZ0G1x6LinSVwQ=
X-Gm-Gg: AZuq6aKW7thUK/c59zJBVzn6p61Ae6qQghHLIrAbwJrxagp28OdJkeTun+qo2HXmNUQ
	JBwcIGxAIqmX0ONH3vRqqMsP96MLJ20GxiyOsRp4pCAO3ZlewpkC36a86box4GfArJVDHsUg63+
	GcE6h7M7RVV0p7XxhVSzixJEnDohENEfU0OHkCAPHlyaoWhBRo4gR8y010aA/OhEZcMLjfyA4wW
	jjB/FfbkePKXRlzdGvLwJ3ZXzAyZQmBD1hABgL9eb1izY+toC06tFdmJQKIPELJo4TwGrn+YxGg
	i7fkZQds60gzKH0=
X-Received: by 2002:a53:d013:0:b0:64a:edf2:e769 with SMTP id
 956f58d0204a3-64aedf2ebdamr2153639d50.10.1770683608535; Mon, 09 Feb 2026
 16:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfuBxwJ_=4mh4gBd3Y98rVRWNZ=xyJAiDxMXb+2TEn6uJM_6g@mail.gmail.com>
 <xmqq7bsl30rv.fsf@gitster.g>
In-Reply-To: <xmqq7bsl30rv.fsf@gitster.g>
From: jim.cromie@gmail.com
Date: Mon, 9 Feb 2026 17:33:02 -0700
X-Gm-Features: AZwV_Qhdnt_Yqnifq6dZANWZkiipmbWOsfSE_8aiNsVY5y2sugK8yNd7vMo9hdI
Message-ID: <CAJfuBxzvkMuV3cNB-GvZRLtZ--sz46eGzSSAE+tHePSL44O4sA@mail.gmail.com>
Subject: Re: --suppress-* options error out, apparently passing to
 format-patch too.
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 5:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> jim.cromie@gmail.com writes:
>
> > [jimc@godzilla wk-test]$ git send-email --to=3D$trybot --no-to
> > --suppress-to --no-cc --dry-run
> > 0001-dyndbg-fix-NULL-ptr-on-i386-due-to-section-alignment.patch
> > fatal: unrecognized argument: --suppress-to
> > format-patch -o /tmp/tXB5tLINzc --suppress-to: command returned error: =
128
> > [jimc@godzilla wk-test]$ git send-email --to=3D$trybot --no-to
> > --suppress-to=3Dall --no-cc --dry-run
> > 0001-dyndbg-fix-NULL-ptr-on-i386-due-to-section-alignment.patch
> > fatal: unrecognized argument: --suppress-to=3Dall
> > format-patch -o /tmp/Y47eIqlSDG --suppress-to=3Dall: command returned e=
rror: 128
> >
> > --no-to --no-cc also doesnt work (as Id expect), it still wants to cc
> > to one given in patch-file.
>
> My findings from a quick read of the send-email script:
>
>  * There are --suppress-cc and --suppress-from but there is no
>    --suppress-to option at all.
>

Indeed.  my brain filled that in.
once I dropped it, the cmd succeeded.

>  * There are --no-cc and --no-to but they suppress cc and to
>    addresses from the command line (and probably from the
>    configuration); addresses a specific patch file lists to be sent
>    are not affected.
>

yes, that explains things.

> Documentation updates might be needed.

       --no-to, --no-cc, --no-bcc
           Clear any list of To:, Cc:, Bcc: addresses previously set via co=
nfig.

I did find "config" somewhat ambiguous. "options" would be clearer.

thank you.

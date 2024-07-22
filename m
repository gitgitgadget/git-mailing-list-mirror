Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F51803D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632703; cv=none; b=H+8Jn3iABig0DC35xC2nHRYgkk9Qq6vybExE7sLiaIvvIplsN/TDsYfpBzsGMygnYS4WPAlscB7ZxzRcxi94tUTLWIEf2/9HrJ3HGNxh6poV+sBZLwR1nN2zNJoPQ4eLMxyHgepbEjmzgi3l6gwLFvX3oTpVpdt0MXdsvUoEvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632703; c=relaxed/simple;
	bh=ZSnTA3vB4W3jw18KkLOrHtR55ZC1VCn1lkulioUBdFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYB5Mi/6m9cny5yi1MsIMjW4I27zt7HNzr26y+PXUV14Lx4QfokIwAmtxsS40ZhRh4fCiAj92F3Zm5ibtgJhMLoizm+TQ3q6nvRlU83Qa2Bk2fr5vUPveFgQBv2lAX0Qbm1ieE4eGI7B4kUv/omNZeIzKYVLz6FXpP9QRYzyBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b797a2384cso23863986d6.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 00:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721632700; x=1722237500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKtSm8eclCJUslpc/V3+21H82zdjnT0qQ/84FPWW8ho=;
        b=rV9LhUjJyQLptGnsTxta8azMwS66gS198s5iFf9ybdwDondghFDgw16K2AaRGEzBoP
         EZdGM98+oPKF/iKs1kzw4FSesqVrGRF4dAVOrbIqZ7a7K9hpbkK+kmPfNZufFo2m2tEJ
         WRxCDu/sLbdr/X1yL6E6kx3RY94CHZBHXHiWUR7DgvZuXsdF3E7vMFgr2BM6fQSLic/4
         7g59szZLOvijHpkTBpCk979uUIU+z4kWgtzt+r31OU4/bW1v2q4lghxHCJqOVFiQDYSR
         I2Gh6ks5WHxgXzTtUrpAm+MES5GXv/j5EN1m/e9XvLj6JfHv6GhBWNcs8w8RAG6lvPY3
         RP1w==
X-Forwarded-Encrypted: i=1; AJvYcCWXSo7KTFi35ULkWNuqksmE3Cov1n5nl0CYTiNBvqm7nVUit7NViq6InGZv0QMKzEsguhL1rq904WavzlVi3bQ+JZ/X
X-Gm-Message-State: AOJu0Yy14TF5nGqwyh2WS8JUWKG8SbSaxN1yAcLn0MrL5bb2fpHFOVfp
	4GMnGsHSORbwCUJktbZ8gp3gy+mG5RiRH4OC8UGn2kfH28K6OYA5QZKQ3qH9kYN72J/Fbz/gc+W
	D8Yz3/+AkHWFNfj1PKuT4eRZ/Bf0=
X-Google-Smtp-Source: AGHT+IEjqJoQCnsUA1KiTGoQ5cvTWDeuPJcfeK5RmrdZWa8jy5VBKrSEXDYtVVUGJ6HuXcfEHHBdTuvcqwpa7cqi4vQ=
X-Received: by 2002:a05:6214:19ce:b0:6b5:ec9e:a815 with SMTP id
 6a1803df08f44-6b95a74e19emr75425676d6.42.1721632699664; Mon, 22 Jul 2024
 00:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com> <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com> <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <xmqqfrs723bp.fsf@gitster.g> <CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com>
 <bc1b9cce-d04d-4a79-8fab-55ec3c8bae30@gmail.com>
In-Reply-To: <bc1b9cce-d04d-4a79-8fab-55ec3c8bae30@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 22 Jul 2024 03:18:07 -0400
Message-ID: <CAPig+cR3BHMyuGOMYdbRxvMfNzZBGQjgsrJU4MOx-e67DOTsdQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>, 
	Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 6:37=E2=80=AFPM Rub=C3=A9n Justo <rjusto@gmail.com>=
 wrote:
> On Wed, Jul 17, 2024 at 04:09:17PM -0400, Eric Sunshine wrote:
> > > >> -    test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal =
git add -p
>
> > It's also curious that t/check-non-portable-shell.pl didn't catch this
> > use of one-shot assignment when calling a shell function[*].
>
> It would have been great if it had caught that error.
>
> As a reference:
>     VAR=3Dvalue func           # this error is caught
>     echo 1 |
>     VAR=3Dvalue func           # this one is also caught
>     echo 1 | VAR=3Dvalue func  # this one isn't

Thanks for providing this summary; it saved me the effort of digging
back through this discussion / patch series.

> Maybe, catch this errors expanding the regular expression we have in
> `check-non-portable-shell.pl` isn't the best approach.  We might need
> something more sophisticated, like what we have in `chainlint.pl`.

The idea has been expressed previously of subsuming all the
check-non-portable-shell.pl checks into chainlint.pl some day, thus
allowing check-non-portable-shell.pl to be retired. In fact, it was
mentioned again quite recently[1].

However, this particular check (detecting `VAR=3Dval shell-func`) poses
an extra complication which would require some specialized additional
mechanism in chainlint.pl. In particular, in `VAR=3Dval symbol`, in
order to distinguish when `symbol` is an external command versus a
shell-function, it is necessary to scan for function definitions not
just in the script being checked, but also in all scripts included
(recursively) by the script being checked. So, it's probably possible
to do but ought to be done carefully.

> Perhaps someone with experience in those scripts could give us this
> capability :-)

I posted a series[2] which addresses this shortcoming by enhancing
check-non-portable-shell.pl.

[1]: https://lore.kernel.org/git/CAPig+cTFZuU7zM7poqk4HeK09zn8bFrO37eUZiaGm=
eJ0yecpiw@mail.gmail.com/
[2]: https://lore.kernel.org/git/20240722065915.80760-1-ericsunshine@charte=
r.net/T/

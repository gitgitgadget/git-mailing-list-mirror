Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D1180A9E
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246974; cv=none; b=drdOu3o1taX9d9Zw2K4AOvtwjsZMv4uLoULdN6WNZCd78wA0ICyaSgut85EwW5bna5fyTNa8KDL+bqDo5xzbAQ1tmvVj65H4dWWClekH2uC65N5/R3DbL8nAknamKP/hmnA0ct4UmitcabUAiLZIWQxi8BLUKAb+D8KSDIhQGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246974; c=relaxed/simple;
	bh=k7207a/g6CoBH+s+Glu+QR3iayDBL+YwISDTaHrKMo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujlbbXtvZPgPqvXqxRAB3VGTDKEozKsNFwDZbpMtsWuopIEQOkLigPkzTI9kN1PGj1MegT9hxwNacfkMfUY0jVF7HS10EgrBtLqcBEByrkLRsjTZHsaRhfRi++U5+eRlrpDfX/x//TtFxrX7iW7cYyiCmrOhpOgAe+nZqzujNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfef5980a69so91214276.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 13:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721246970; x=1721851770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpHl2hGMa9V0YxK8u/K56ydu1b57fFtS5URtub3tNMw=;
        b=m043pi8CUVkla5wYYLBBkuzVlYtwz9UXe5l/1FiTaQTEjm5VdHlG6HXHg0Cr+NemB3
         ZtGxfgbq4Z4jgAUuVIalAtUUxT2+GoA4H8VnNM1mu9AofYiUn15M/bNdVlOX6jgjUqa8
         pvgM03DSfndRcYKXjs6vQvUkkvAmp06jSjYWdXxT+cS9bX8tml/5Nye3obIw6ZmXhDo7
         nzd4L2Hw+g/bvkU+YXFWjcF+qyEfnagK/xZX3bcjL2U7Gf5Q2EAcGeXTSCro08A8n3tT
         aLm3Ei70rSnn3XgW2o0gnH31T4t86pL3Z70OiuPF7BcluB7JITzBe/IRu7sc/BP1vnpa
         k/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVdYUC33wZ1mvppoDiK9OFehmSds4667vLIEgWjvgJGGbOBIrXbh/4xF3+WV3qJrMrbvMWw3Kk5fXvH2fzYrk92ZxEc
X-Gm-Message-State: AOJu0Yxt1GLo3Z3tfOKksNTbsh1Nujv2iAf+pNKOfwU4mB2IlApSQNpI
	qNmpLdXooEpLfsqKAdWgbv4wZ1nrLPW1hDpNZxil7XWC5VVFR1R3ftnm/BLzHbZD1Ft8W/LHO0V
	BZIoAWMZiLp8vvWBHF+WnQ79+7Mc=
X-Google-Smtp-Source: AGHT+IH93h+ExDi0DS2Piy/HyC6EKlyd1liribaSt6PE6vS2KYJdcyL6o1z03f/Zpvdrrdq3eWmwz9e87RdTK60tR+s=
X-Received: by 2002:a05:6902:2489:b0:e03:5edd:99b5 with SMTP id
 3f1490d57ef6-e05ed6b9472mr3205973276.4.1721246969700; Wed, 17 Jul 2024
 13:09:29 -0700 (PDT)
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
 <xmqqfrs723bp.fsf@gitster.g>
In-Reply-To: <xmqqfrs723bp.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Jul 2024 16:09:17 -0400
Message-ID: <CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood123@gmail.com, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> phillip.wood123@gmail.com writes:
> >> -    test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal git =
add -p
> >> +    test_write_lines P q |
> >> +    (
> >> +            GIT_PAGER=3D"head -n 1" &&
> >> +            export GIT_PAGER &&
> >> +            test_terminal git add -p >actual
> >> +    )
> >
> > That's surprising, why does running git in a sub-shell stop it from
> > segfaulting?
>
> Yeah, it indeed is curious.
>
> The rewrite resolves another iffy point in the original---you are
> not supposed to attempt a one-shot assignment to the environment
> variable when you are running a shell function, as that is not
> portable.  And the above rewrite is a common way to fix that.

It's also curious that t/check-non-portable-shell.pl didn't catch this
use of one-shot assignment when calling a shell function[*].

[*] a0a630192d (t/check-non-portable-shell: detect "FOO=3Dbar
shell_func", 2018-07-13)

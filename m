Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AC80635
	for <git@vger.kernel.org>; Wed, 22 May 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368740; cv=none; b=T4WEqWiReiowZbT10c4GXvL/hExdNj5sgIFzOqLXDFzCaWeeTkU8WUg0Zc/pPOn82efidaoL7VKAjS2ql2fVg5WePkM09SnwpYuMXtXd67/+HmsZRsstKQBgkA6YGcmKxJ22yXVUId4qEMBwzheJ3EUjhOlgs0qYwWBpImKB66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368740; c=relaxed/simple;
	bh=k+V+3Vi4DnrGhFWciIPWdMFlZqo/PBPKlPQJ/OEzrC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fED2d+C4juO9TXIM4IjtIhrKLAZtAZ2hZTTb5Cthd/FhQFLMj+Rt0dhQ43VLhlqUEi/RtSu5ct2oRK/zXQnz9lkyp5QJOUOI3LhQ9S1C5EuvfRwCksaxftKRUeGcWKphus6YkSiyPcWNyKrM77xQRFH9JlXoQSqTBwbPwlQCbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792bf1a4f75so420876185a.2
        for <git@vger.kernel.org>; Wed, 22 May 2024 02:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368737; x=1716973537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFbcaCvi+3lQRemSlWr6Gw6qtWbyCJmLxwUZ10BaozA=;
        b=YMZ+KF71giw3QW5c2KKrAUinoIR68zA0ylOodgbyyl3ulkZQ98R5jNPeLG/i65N9cx
         4BAi3z/1KoO6w/He8XmkQ/w8x/Y19Kk4EARXPGx2TMOgpSOlFaa6OjeTojz43+kKFUUs
         6SY8ofQ0omVl9Lii7U1FGK2XcR3eMrBJtcGrDfEd02SxHNXV+qApSWJRXBi8zosTA0rq
         SjTmPseH+TMkmTY7QEhrsUM8Z5kFeuiAvo6O1cf0K/FhGAV2s9Cf7HRuqQjl+Ou9AFAe
         AAbR1HhxWVriXvTtQP5+7D1bAwdQaYbO68r+lK0zPLt7SiMoVlSKfBvNB80XL0isVhDC
         ErqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoIGjAwArekN1HBpCgQiatWt5z59b5cYt5bCBlOyyNxKnjQ0aFYEcangcTg9KMjB+m6ZxZKpUMI6QYnYdxBFlQ9RUc
X-Gm-Message-State: AOJu0Yw4cQX70pWabx+WTEtZVcFewmXlGS480qL7eg3psEAS9VaOYzru
	Svpp8K2xkUybAbvCJtgMEHt3kejg0uwvh6d29cjuyVp4fYVvDHd+QH7XgXp6vQrl8X+zDBfbpNT
	9IuYUf1HPl4Z0qIVG4bE+J8O4yKE=
X-Google-Smtp-Source: AGHT+IEcObLs6as6I+9UKPThTPJk5lqxsG+Bu6wCBA3FibtUiArFbf9S+miEJ1cjJP9BiR4SjESfE98oO1NVqadFh6k=
X-Received: by 2002:a05:6214:2e46:b0:6a0:c339:1ede with SMTP id
 6a1803df08f44-6ab80901482mr15578906d6.40.1716368737372; Wed, 22 May 2024
 02:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net> <20240520190131.94904-3-ericsunshine@charter.net>
 <m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy> <d655399efccfa6219cd982035c0408f9f084e344.camel@physik.fu-berlin.de>
In-Reply-To: <d655399efccfa6219cd982035c0408f9f084e344.camel@physik.fu-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 22 May 2024 05:05:26 -0400
Message-ID: <CAPig+cTfqk+tbTAVyPj8YP1uHx1D1swL84h-4p6OKBV=dDRX_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:47=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2024-05-22 at 01:32 -0700, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > On Mon, May 20, 2024 at 03:01:30PM UTC, Eric Sunshine wrote:
> > > From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > >
> > > On SPARC systems running Linux, individual processors are denoted wit=
h
> > > "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:".
> >
> > not sure if worth a reroll, but the "usual" syntax is "processor  : NN"
> > the regexp used checks for numbers before the colon to account for the
> > syntax used on s390x which is the only one with numbers before the colo=
n.
>
> Good catch. I think this can just be fixed by whoever commits the patches
> or is that done automatically?

Inclusion of the word "usual" is such a minor flaw in the commit
message that I doubt it warrants a reroll and the associated cost on
reviewers and on the maintainer (Junio), especially since it does not
negatively impact the intent conveyed by the commit messages nor the
correctness of the actual patch.

As such, I'm not worried about it. Whether Junio reads this and wants
to correct it in his tree is up to him, of course.

Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B08286D4B
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815500; cv=none; b=KrWhXE2LX/LmEwq6DLzVh+OyAmdOlL66OfVtPlhkunnc9AaTS/B073DtslbllpOZX/+KQVNsNqCj+Q7faego9k+mscowM9VVWZrBc9yI+nQ/Kj23eikCZFInXGFqExGgcF+1XTso/j4JTwz8c0RH94C2btM6cDWG3omT9x7BbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815500; c=relaxed/simple;
	bh=I5EJAeChnESpN/99mZ8WWoHrwmxlq53ijT6+XfqKNwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iw55Lb7N+j8rwMexsRhDpCHQz06twHVUzgptcfRKc/lnTxIYQcYSac3f8kSjIXEDBQQlQp5oFWH6StQMasxvGNWG97BGSzrmh0yjTYN9sEjaoor4Oa48o+rjBqct62GNhA87vwPGbQl5ca+lSZA+yRI2BzDDy0CXWZhf3/FA9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIiZtaB8; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIiZtaB8"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e1a326253so1947474d50.2
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760815498; x=1761420298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eY0Nfy4O+7bhrLoJ7+cKw0cd8T+ypqJ+K+UULUdnEA=;
        b=QIiZtaB8N6xVxh0wLCx3D2DdvQYen61pthT7psWsFBX7Y0kB1AdcXH1Tco2qobvKe1
         dINjkoZWaIybeWrdIiqiw4A8COZj5x1TYbJlH2pciSGLVClaoo64W+9drD8KaBlQwQNz
         E1rJkLrQFnAXRGFvrf2f5lvmwXe9pW9zeiw8CuZtuTihpX99qkEFqMw/DlxBA9j/QWYw
         U307MJYiOa04sgmS+6WvDr+7T9FupXQYRGHD2XoYZT/1Yo8cI+IHMiv/MbIasJQwqK1S
         KEubPmdbisYdKkrkKSaQZOnuLcV2LAbPllBT55rpTUxjuLefKWULo3U/E+nO1VSXxTCd
         VD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760815498; x=1761420298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eY0Nfy4O+7bhrLoJ7+cKw0cd8T+ypqJ+K+UULUdnEA=;
        b=qQwahmoaEZn27B8rqmx18fcxKkygZ7UhjIP2/r1Jyy5yCMQEsrSua75qqYgdO8Fyia
         aCEJsru5HXWOpanryV+N1pJUW6tdSgGvftYnDl4gXheQP6jHw3ObLpIhChZFdN6Rhnun
         RynGpCKwHlhT30SfmhXaZ+CrMk9EfY+XBWuSaVv9rlAjZdxdNGkbnkMV4XKS3i8dIbsI
         UtoRkf4qnOn65ZP5UkzJIIEIf/PXKMqGPDuoRddCfS3TIn98VNhxmLFIkcyelLMsudCC
         79qkOrYO6DOflsvqJ2EJ5hhyQw+Ax3dOVvryUzDpvSpn21kjQnCQvG+qQ0CmVZnh3I/K
         DF7A==
X-Forwarded-Encrypted: i=1; AJvYcCWDmCnQ5/9oRtRCT2MusI9djIVXRRO2f9KsbtSCAuq0PQRPx46+YaL4qSWQp2b853P7ZRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySzziq5aLAbGi0sCvWRjJHPdHsaeR186sxTziWHrLT0haXDnnV
	FxL+kPoERFD2uFepdl+Il03a3q0KOdLucg0uT5H1vrhfLe6VKe1n0hzsRAP2ui7q2H5reo69RLl
	LkshGJUAxyvFqbdY0ClF1z6FGqA9swsU=
X-Gm-Gg: ASbGncvGsxsKUvUHC9W2NB5LAW8nO3LM9A2v5GwZTEQDNQNHOfknixm7qzib21XeIrN
	vaFXAt3AVULqP9ziSQFfyjRMuzi1iGYJ4JfV+LAQG2IXTdQBtaTTtUtGBuKn4ZMWKn+yQjhHR0M
	8R342NDyY6lomi9DD2xM8gGzxtnhRZW3NXAsdKQBjwYegd9tA9akrMic6H+z8OrHPBejKP4PO8R
	iGy9p8SkQoESfIAACPGUIHc++wMRch8alUvlWbiKs/bC9Ga6LqPcuyhxttwze/6PsN26GI3wSw=
X-Google-Smtp-Source: AGHT+IFY/VcIxNn/UntYgZCAF1cPIqr1imYgYLr/5lD8JYNek0Qd8FCPBffQI+TbCeXhv06XEmksT7yb39e2EwntJww=
X-Received: by 2002:a05:690e:4e:b0:63c:f5a7:3d0 with SMTP id
 956f58d0204a3-63e161e09e2mr5136294d50.60.1760815497868; Sat, 18 Oct 2025
 12:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1988.git.1760600313093.gitgitgadget@gmail.com> <xmqqikge4uvd.fsf@gitster.g>
In-Reply-To: <xmqqikge4uvd.fsf@gitster.g>
From: Queen Jessa <qjessa662@gmail.com>
Date: Sat, 18 Oct 2025 20:24:46 +0100
X-Gm-Features: AS18NWDyX7kuaRD_0a_ujkdYAGMUDnXLMN1K09CthTPpUFqsdLZRfzW0szgIVlY
Message-ID: <CA+JX8Fqa39pmqbFi2WezpTnFG1mgg1SpGaTU4qw7PuKukhOT4g@mail.gmail.com>
Subject: Re: [PATCH] docs: fix minor grammar issue in MyFirstContribution.adoc
To: Junio C Hamano <gitster@pobox.com>
Cc: Queen Ediri Jessa via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

I have fixed the overly long lines and resubmitted the patch.
Please let me know if there=E2=80=99s anything else I should adjust.

Thanks,
Queen Ediri Jessa


On Thu, Oct 16, 2025 at 6:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Queen Ediri Jessa via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: QueenJcloud <qjessa662@gmail.com>
> >
> > This commit corrects a small grammatical error in the MyFirstContributi=
on
> > document to improve clarity and readability for new contributors.
> >
> > Signed-off-by: QueenJcloud <qjessa662@gmail.com>
> > ---
> >     doc: fix minor grammar issue in MyFirstContribution.adoc
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1988%=
2FQueenJcloud%2Fdoc-typo-fix-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1988/Que=
enJcloud/doc-typo-fix-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1988
> >
> >  Documentation/MyFirstContribution.adoc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyF=
irstContribution.adoc
> > index 02ba8ba5f6..91c6296ffe 100644
> > --- a/Documentation/MyFirstContribution.adoc
> > +++ b/Documentation/MyFirstContribution.adoc
> > @@ -26,7 +26,7 @@ useful additional context:
> >  [[getting-help]]
> >  =3D=3D=3D Getting Help
> >
> > -If you get stuck, you can seek help in the following places.
> > +If you get stuck, you can ask for help on the mailing list or Git comm=
unity channels listed below.
>
> Please avoid overly long lines.
>
>
> >  =3D=3D=3D=3D git@vger.kernel.org
> >
> >
> > base-commit: b660e2dcb98ed4eafe2781b7ba31b70d2fcbad80

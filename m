Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C949578F3A
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750493394; cv=none; b=dbPJdrFHMvJU7tzOYbNgfzhUQ3vzSxPk3+qU2IfdtuXWfGxi/Lv83S5Gerkl4sm146J0Pk8Zba4Kkx5xGbilQoa1H6awFyd4iShqpEI9LAjpSf/rwVljAXlIKgqzr12LaVL79UNqVv4aX42XHH3+wXKcxPg0QwQr3aw5LGYYsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750493394; c=relaxed/simple;
	bh=uZ5V+0UwpfrFfw8Ri6rrCQDO0IWeVssCymVoDq+s1qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Owrv0OTCMMULSeJgAUP7OLSE+oIqDSQ3UrRnXTUbXiV03Ez8yDTmH0s1M6+AeertjaHv0fUZPJ6vPbIonY4JmRdrJB6G0p81VzShmrnpEZ2giJgiWHtT9dR7tG5R2Hfk3ZQ+k7Bm0Yp5la6yRpG5HC+Uq/bEloSMr4WYSWXA57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d094f67777so56325885a.1
        for <git@vger.kernel.org>; Sat, 21 Jun 2025 01:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750493392; x=1751098192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sorN0CMNuh9nKwQ3R5SGrURog/TQg5Jd0FUnSsJneqg=;
        b=qXCAliYF8CkHuowsuMtB6Iid8sOXhkMtX1042aBaQJ0UDh7MnbZZ4eo8zrtxppkf2x
         NuajkcJsCAGV3ZH7ItzlyY6X4L2fDnjpOzPv9LjOIjYGSlrj6rIhui9RZGFZzFb/oq6Q
         CWpN5yirkAgzjeceAFS9ydaStR+tcCpG2vdRazchVxpI0ESU5Y28lCVVtAzM+vYU9v60
         4lBlsMWdDkTtyHpIz+CpfLz+KZVVgTxS6uvnRzp8ng4Ti0i8SztcF6rlZAqZGIQOwZk7
         muL0u3lDvZUHacYxTwA78ItLaU/RNqekqP3+dzmYNMM1hD9kVIbzmyYEQyW+ddaIAVsK
         ii2g==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZzTNVE0ouqWYk1S3+gszg4d7Y1OANZOnCl1BG7+GqZR2Ym211ETwIb5efOuc1ZGJUQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJWnMAOpwBP8jcDGqlw4ToHX8H5CkPllY2VQtgST2dZ8cTdaV
	14yDvUWW0VQu4SiSkYIX0xrLp0XNvaG92zt7OGoI+6OWhYuGR5pmXd87Vt81qbmcD+3F02KPp7T
	AS8wDp37R8z5TfGk4qtI3TDFE0W9wWZg=
X-Gm-Gg: ASbGncvbaXql/hAoshixn1RC2g9Xi0zKOqcB1j+mlrpqgXutdnukwRbhBabfHoyyKTa
	SATia0G9g+iOqKNzAfGe65e9RmuYwE31nNd+4GMYfAlNla8FV0dHYBchkfGFCp8jNB64JTAUQ/J
	Y0bea4FGBeGU8w9IHhXicI9JcOeqMTyGx7kGBPQ+ChGFzYMZwHUb2TmwpoSiur2E6zWrfMvJCJB
	8bP
X-Google-Smtp-Source: AGHT+IFfgmllpFOgJd4wsrLwRd8flTUpUMQWcRxA4C0yUPBjbCTc3aqI4sejTP/HxzhebUbbOTXPQBBC3wMkfmf7NKs=
X-Received: by 2002:a05:6214:2345:b0:6fa:ed8e:372c with SMTP id
 6a1803df08f44-6fd0a44ef8bmr42705436d6.1.1750493391729; Sat, 21 Jun 2025
 01:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwm97bv7c.fsf@gitster.g> <jyof56xql2c23gyckxzmry4smkt2uk64lyofqxk34olzn7evgf@ltq5tiqo4qyg>
In-Reply-To: <jyof56xql2c23gyckxzmry4smkt2uk64lyofqxk34olzn7evgf@ltq5tiqo4qyg>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 21 Jun 2025 04:09:40 -0400
X-Gm-Features: Ac12FXzKD007EVXfDv6eb-VnYu8ElLN75vTqGfP6tJGVegAJn8vzzB6GVjop9A4
Message-ID: <CAPig+cRtSzjA=P_-WhRw9rRmTmFMGibKuHYn_ZuN935fcffveg@mail.gmail.com>
Subject: Re: [RFC PATCH] coccicheck: fail "make" when it fails
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 2:29=E2=80=AFAM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> On Thu, Jun 19, 2025 at 08:35:35AM -0800, Junio C Hamano wrote:
> >  coccicheck: $(COCCICHECK_PATCHES_INTREE)
> > +     test $$(cat $(COCCICHECK_PATCHES_INTREE) | wc -c) =3D 0
>
> Definitely a nitpick, but I think using `-eq` instead of `=3D`
> and might even come handy from a portability point of view.

Junio has previously expressed[*] a preference for `=3D` over `-eq` in
this sort of situation.

[*]: https://lore.kernel.org/git/7v8v3m50ds.fsf@alter.siamese.dyndns.org/

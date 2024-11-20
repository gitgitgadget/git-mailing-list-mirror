Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C9E545
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072968; cv=none; b=QJncJUw37Croa2NxVgkDV5jxBRh16+2d7xRPMU1+guvxTvhV9nkrAplaIvap4exZobUqQUIAhIUbGkWQLC7GmiGiZS6qs2dwJvToo3Tm6OtU9cD/gsjBDwdfzf+XA3z68z3QLcWAOdlWF0NZG6YWHb2z+PyB/UeCzFmNdUQArts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072968; c=relaxed/simple;
	bh=FEiO0IXHZhWQrSehLRuLaUhbsAeQ7wPL1xhj7Ieqjn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtpClRxQIUnkuPExvMEWz9GxC3LQUawMOo74bxdW1Td5LLoVv8jvOC/eIHnFV2GTuW5Dzb8pBVugNDSEDpCnWgd31kgYrO07OBdGVOUlpHFcV+dMgGqliKsv9R8+3fYoZUVaKiqdZTBx5Zr1DISdf93+Hpkgg1fHih/K8YAGrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmXLyheI; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmXLyheI"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a752be9f4bso14689505ab.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 19:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732072966; x=1732677766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYoWtm/bGolvqyRxro6WWFGOUtfqOl6o4qLO1tNJs0I=;
        b=OmXLyheI0u6PIJ7vETqHmkO25DFFLOpybL3Pg+p3IKiz10SRJ1hU/ooxlPY6trFfZ1
         yiGIlNCp3W+VNIFQUQMZfl7JBFeMzp5Soe3iHTgPzTOi8GtcRDAa6Y7LHj6qRnrRslQh
         5uzARcjhJ2fqMYmdAosSAP0HeZXaCVNIAq3TviMyi+oMkWU7CDU4GmiZYH6Yui+TfWmt
         DhVEex69UxGS8zHpyUxzhXV/v+J5kzrX3WHX3xYZqu6IiCH/4D+a40LoM+2+nGMgyqa+
         qQLiOt1dEUlJFK0lDjmXa9zzR/u1oQMPHp+dFTmK3Ju4e5OaVFak9tTI9hHytKWsIvKp
         W/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732072966; x=1732677766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYoWtm/bGolvqyRxro6WWFGOUtfqOl6o4qLO1tNJs0I=;
        b=U4lpj+e32BrA9omZISvcdnjEElVuRkDiUB9+FvHkyUdj0a6ka0Ee6nA92tGx5wcIQU
         VCMylW/hyZv6ph/lrffU3A/iStYGHZKM0NBVVliicuxpdPXifcdSU2FXK1YUdCzjx6f9
         KqOSmMIP6/LWyq3tBeIsbo2HhCPsmJxaqerqaBZiHzCLokxNcjdCCLfUHQ76A9gTM1v/
         pE/HlKnvQElovUukqci6Y+tEaW7azb2JB3eTl8qJxHm/mE7VS1l/wTmHGUL9TXg4lpfF
         XGVYPcuihctcrXcEXZfM1Qivzu5j9SkxvIJMbFMqmzYvr1Jn30QpuIi0p0k0IUBcjfIF
         ucTg==
X-Gm-Message-State: AOJu0YxbP8rGj4LQWmpafahgFseDETBLHRzowEhVXLbA7k9ciO9iiU8J
	6B2DHMgk4SfBDWsvjfOQ6GKfTcvoBlxp5zZzHKM57hIfBzLBreRkk/QhGPXtcL1dM4CZvEZhGID
	JBJbsZV09ByDVF1rEPTV6+jzYYzqWvMxX
X-Google-Smtp-Source: AGHT+IEiuvWPWLPOWvsoqG7JpY9X+HStROPtJaPqYRSjmozirUP8NKfhN0qMzehgObFORNwgEfI4S3epbvRnYsH2aJo=
X-Received: by 2002:a05:6e02:1caa:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a78640c166mr18911145ab.1.1732072966435; Tue, 19 Nov 2024
 19:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
In-Reply-To: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 19 Nov 2024 19:22:35 -0800
Message-ID: <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
Subject: Re: rev-list --ancestry-path with arg - bug or undocumented requirement
To: Kai Koponen <kaikoponen@google.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:53=E2=80=AFPM Kai Koponen <kaikoponen@google.com>=
 wrote:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Create a toy repo with commits in the following structure:
> A - B - C
>      \
>       D
>
> Run `git rev-list --ancestry-path=3DD A..C`.
>
> What did you expect to happen? (Expected behavior)
> Commits A and B should be listed.
>
> What happened instead? (Actual behavior)
> No commits listed.
>
> What's different between what you expected and what actually happened?
> --ancestry-path with a commit arg seems to return 0 results unless the
> specified commit is itself part of the range. The rev-list documentation
> does not mention that this is a requirement.

Yeah, the commit message that introduced --ancestry-path=3DCOMMIT did
document this in its commit message (see
257418c59040c13bfa839e01922e21833cda6a52257418c59040 (revision: allow
--ancestry-path to take an argument, 2022-08-19)), and I think my
original documentation patch was a little clearer on this point, but
when Jonathan suggested an alternative for the documentation
(https://lore.kernel.org/git/20220818222416.3567602-1-jonathantanmy@google.=
com/),
I didn't think about someone attempting a commit outside the
ancestry-path as the argument.  My bad.

Based on the references above, would you like to suggest a
documentation patch to ensure this requirement is documented?

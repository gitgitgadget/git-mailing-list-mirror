Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21A2E3715
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535590; cv=none; b=pOw1ptPLxa3gPB2cXtJu7iOPec4vXe1TJedubVh/rrYup3XNsGdYqrHS9FLGEhtHwUbOzK+elIbt5MEGyEet6OVNBCU9KTXhCx2mAwnZZ0PH6dQml75+5wMTUZgTN5MgNbQAIHkWUFfnm3Eg63sMvj1SNHcQ/VFTUxRMFHdmZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535590; c=relaxed/simple;
	bh=DMkma4onaBqZP1oDR918f7rn+gZxHoB2HDGpNaIr2dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHs5fkjRqOArcT5rgDzU9nV/1zqVodljjAQlKf6GaGsWUfFKRQUeZ1l9KXiHf2lAd/7XL55lhfYTrNh711S7SOYBlF8zTWtaLSKjfvWNmRdk55ARXJjfdElIIJspn92GQbXaFGcpXcqKt9eAm39gLJnx5JEiQFx+OYvKdwD4QH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY+2VTVb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY+2VTVb"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso537032466b.0
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753535587; x=1754140387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW8Eyw7m38VTeYnTOlZAii4GMKcLAkkAVeiftRnnO68=;
        b=MY+2VTVbCBx0owIMDevr9Q1O7aJ9c+Xjy+DHKh2ABoqeETbFiMlAtZjQUDNhqZ/KQ2
         kd5kj8aveQ0xjuft5BSPcOPNfCYzFhVYXz2FycqIiP1Fj25H95bV1e0XMCXKbyejLo1i
         SloxsE7dL2n3HFpLiZ9pXLfaTWpJajztj5qtyNvrsiFiOz/5ZaFCNXotdzCgG28IbUMf
         TEzboE96ilaWdh9Yv4KT24ncr2Y2bLzUe1YgFeAG/7PjWWjErfWq9Taq7I+UEU92rQIq
         AzrTsY6HaWL+/1bruFY+8BwAS3gAEqhgXO99cTvLlZk2VoJ+uCASpbCijg/PDxGFPImV
         MqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535587; x=1754140387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW8Eyw7m38VTeYnTOlZAii4GMKcLAkkAVeiftRnnO68=;
        b=HMvD/6Ls3KQyBP1kOG+Mo+xfafKYufrxHprLccwBAQpwSsWm+IL1b48SbN/3avTyQm
         QC0ybZSzK4TR7bv5BBkxWEXRkz0gEGRHPzkyGq6DRoXCpMcR9YiSUJcciASlAQQZneWu
         PKQVe2YhHYG84Ppzh7SJ+ReD7NiB3KrtHVJI8MNPstKlJSgEoGPVDrAVHK4nLYJrW5G9
         nL7ce2QnEuLMxXoUA/LAM2nqFnJGc5NjE+VD22zWWPLMA7vZUbUNDYbh1iw+pwLS81wo
         QkuodpoMeirbscc70tAFnGligqLi3MkTVoEsE/6goRpxeqe9jkHcFqxe7Cal1QxURFFl
         bVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpdlEPfX4O9SLPoEv1fzCJm2JLfzkQr7iWe4X2D1eNmcTa0YNRjLhcEdv2cQm5d0i0eck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjmn0vCjXUGXSyef77RJwRY7DEN56IxY2wEj81vJCAYfCzKcjG
	Hf9I+3BL6buFROEaCB49ihCdDpytj9NGNpu4fFuKJ0NZiw73sOIc5t9HsK/EzlYBwowZn45V6QU
	Yvy2M/cLWYD0hgd3QoVyAOZlXRhQFc6M=
X-Gm-Gg: ASbGncsNXAwJmXNUR5mVY4xEQTsCDXXWxt9ToMnh5A7D1/aRg+pyV+6Uwu/9ww0QwFy
	YF83Re8vo+FYo9Jdvd/NUwmPOcyyFK+p13M1aUBjZBDTtUjlTmpUe/cvBsmJdU7ip+GOlvXF1+O
	60oHfbSGf7h3VRGkZhIpr31nJy/B0KOfqjsV1bvfp1wSCH10Eujk3tpPm4gdRUb2w3lRsfuglHk
	dZXNlw2XpecH62kJ76vYp2CfHFwrlfNOsevyROptw==
X-Google-Smtp-Source: AGHT+IF05COLoUERpSXSgYORLckKO05yRJaT7IDKl8/avVLDoT/sK1+wp92J1ZHQVSso62fRdv/feFKMzdQ3WwXQbD4=
X-Received: by 2002:a17:907:948c:b0:ae6:d51a:4ca3 with SMTP id
 a640c23a62f3a-af61eb169fcmr565534666b.25.1753535586917; Sat, 26 Jul 2025
 06:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com> <a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
 <xmqqqzy33k1j.fsf@gitster.g> <20250726081254.GA3042329@coredump.intra.peff.net>
In-Reply-To: <20250726081254.GA3042329@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 09:12:55 -0400
X-Gm-Features: Ac12FXwPO5Qf1OIDtS1hYjfQKoCrootgr7MgpW91QljO34hTPBlIreMSDBMAXmA
Message-ID: <CALnO6CA2qSYePJzqXjdW6c2zC4KQJSKzsCFCzc9si0OJ8E_ohw@mail.gmail.com>
Subject: Re: [PATCH] git: show alias info only with lone -h
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, git@vger.kernel.org, 
	Rasmus Villemoes <ravi@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have a few (unsent) patches I've been working on that touch the help
mechanism, so I have some thoughts below.

On Sat, Jul 26, 2025 at 4:13=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jul 25, 2025 at 04:52:40PM -0700, Junio C Hamano wrote:
>
> > When it redirects to our commands, it is less risky as we aim to
> > make all our commands honor a single "-h" via t0450.
> >
> >    $ git -c alias.c=3Dcheckout c -h
> >    'c' is aliased to 'checkout'
> >    usage: git checkout [<options>] <branch>
> >       or: git checkout [<options>] [<branch>] -- <file>...
> >
> >        -b <branch>           create and checkout a new branch
> >        -B <branch>           create/reset and checkout a branch
> >    ...
> >        --pathspec-from-file <file>
> >                              read pathspec from file
> >        --pathspec-file-nul   with --pathspec-from-file, pathspec elemen=
ts are separated with NUL character
> >
> > But then, it may not be such a good idea to pay attention to "do we
> > have extra '-h'?" when alias expands to our commands, e.g.
>
> Another interesting case: even for our own commands, the alias itself
> may add extra arguments, which confuses things further. So:
>
>   $ git -c alias.gi=3D'grep --cached' gi -h
>   'gi' is aliased to 'grep --cached'
>   fatal: no pattern given
>
> runs git-grep, but even though the user said only "-h" the alias added
> another option which prevents the help-mode from activating.
>
> In this case it is not too harmful, but you can come up with
> pathological cases where it actually runs a real command:
>
>   git -c alias.grep-for-foo=3D'grep -e foo' grep-for-foo -h
>
> which runs a real grep.
>
> I guess one way to deal with it would be if the user runs "foo -h", and
> alias.foo is "bar --other arguments", then we run just "bar -h",
> dropping the extra arguments provided by the alias.

This is intriguing: it would mean that an alias is not purely a
textual replacement? That's true for ! aliases today, but other than
shelling out it's pretty close.

>
> (Another fun corner case: not all git-foo are our commands. But maybe it
> is enough to say "if you make a third-party git-foo it should probably
> respect bare -h as an option").
>
> >    $ git -c alias.c=3Dcheckout c -h main
> >    usage: git checkout [<options>] <branch>
> >       or: git checkout [<options>] [<branch>] -- <file>...
> >
> >        -b <branch>           create and checkout a new branch
> >        -B <branch>           create/reset and checkout a branch
> >    ...
> >        --pathspec-from-file <file>
> >                              read pathspec from file
> >        --pathspec-file-nul   with --pathspec-from-file, pathspec elemen=
ts are separated with NUL character
> >
> > We get the same short-help, without what alias expansion caused this
> > mess, and without any indication that we lost 'main' on the command
> > line.
>
> Yeah, that is the flip side of Ren=C3=A9's patch. Right now we overly gue=
ss
> that "-h" means help. And after the patch, we'd sometimes under-guess
> that it meant help, even for commands which treat it as such. I think
> that may be the lesser of two evils, though; if you are asking for help
> then "git c -h" is the most-strict way to do it.
>
> So IMHO the patch under discussion is a strict improvement, even though
> it leaves many other questionable cases unsolved. I'd also be happy if
> on top we did:
>
>   1. When alias.foo=3D"bar --options", turn "git foo -h" into "git bar
>      -h", dropping "--options".
>
>   2. When alias.foo=3D"!bar", report only the alias and do not run "bar"
>      at all. The collateral damage here would be:
>
>         !git bar $(some_shell_magic_we_need)
>
>      but IMHO that is not all that bad. If we report the alias content,
>      the user can probably figure out which "git help" to run next.

And if the user actually wanted to run `bar -h`, say, because `-h`
didn't mean help for that command? I can't come up with a compelling
example, but this goes back to "textual substitution" vs. "trying to
decide what the user actually wants."

At any rate, a (3) to consider is "--help-all": the patches I've been
working on are to make that flag work more often outside of Git
repositories. I just need to clean things up a bit and get to tests.
But if we do treat "git alias -h" specially, perhaps "--help-all" then
also warrants treatment.

>
> -Peff
>


--=20
D. Ben Knoble

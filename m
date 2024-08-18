Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0117C9B
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723986241; cv=none; b=k/0+NDSTKvFPnRtguD/N3Wss6CWwTVVIF1gAnbQg+SCykhtxJUAg2zoxF/RlJX+mRDN9LH7em47tHeeTcMKCpJGPS1Q52qDn+3M0hYxJ/adhkjHkRwG72LMtYw30K/itgBBzWC8KksRMGd1MJzspCBN+Z4aGLItrW7TskiTCPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723986241; c=relaxed/simple;
	bh=/gT+EcWwq9RpR62QeKyaLgfyelS/AZrzIU06YHJ4v4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4XkzOZWOJLf+942PPFxy/0lBL/kQAAvf/xSBfjP31XU40ww3D3QDIVvL7YsPwRb5x8/6btVRu2t7vbp2Lk+rQBS7+mRMZQogiemRAMBI0Pp3Ea3sfOlBZdskWOGgOqG+j+RTbMCz87zWkum1DPPvUfiVZaW/7hF/oQdoqbMFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNoUE5Md; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNoUE5Md"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8385f38fcdso314041966b.3
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723986237; x=1724591037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4GIiKfNFWLmqGz3sSqGBONiL8ZzwKoNAXChcNNubwc=;
        b=mNoUE5MdfVbVLQ+F10FoxkqgjdwEUbNvx0i7qcQuhSK1goq5QgyjIkRHFNHvo+qjFe
         lFh9NwwvYkjtUGuJvPiqCkczoz3rg4yC69PGFD1CbRhn5JndDOT8reFd6qcV0XNnEC0b
         hyCAIeA7zNEwqtGZLibvqChrNBBezxv6fH4Xd5zq+vlZpqRvmH0hTK6d1VoPJRFoCyt5
         t9x+nLqr0IbZRMdBhHKEfur306McWVMLHKT24mYt1YHlOpmNP1jL4Hfjv/0Z5ziAHFyy
         5lhz1/tvPPhdv/jXtvIJqJkCBjta06tEv9YhxMLLs/n2/o9duYtCpBErJZqx3catVCiK
         wXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723986237; x=1724591037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4GIiKfNFWLmqGz3sSqGBONiL8ZzwKoNAXChcNNubwc=;
        b=r0wT4+CbOFJfmocrJ/RCJIr3xOLebq7nKb4TFTsGguSGA/uPWbkaJr1qIy8FMXEwuG
         LuQJhpFGXsmNNqYxxKSXpFX/1Uz5SuLpve68Vk3RGLkQz2SHIyFsmze5WFbUNJ6PxciM
         iFrud/Dsgc25xWrSX2iCEfqIvZQSS/D3lEXNup4dHPb9SC5H6edEXnWxxxTtwMeYbavJ
         kLng5udIVvX3XIdtD7TInvbMfbfTy0xKSpVUa+14e1HmPkEse4/1XH5i/5C/Bx9ZSTG1
         2V7XrnYwaz8ubtu+HIKfeX/wckMvVLAgQT+qnkKxX4sYM7Ixzb3OPBCFg8VOfn68iEs4
         UE5A==
X-Gm-Message-State: AOJu0YzXENwh5boZ1uZYT/Uv9JuYTmIMFNDwmg7yRfRYqmif4zkori2i
	vD88eABTUi4+M9xqfUD44g1WaDYprkNaQt2PpStXnwq6yN8w1uKhKPlbAYRx4WW4oYuubvX0y7v
	LTIHkgdc4uAyAVxS48rp7PkYEof0=
X-Google-Smtp-Source: AGHT+IEnfpxHULpKTmHo71OOH/NuuEqnZMOqko4bkI3ulcFQDT3tmA/tMU2DKM8u/HZHi2xmnCiQJNS1KIz7y4938b0=
X-Received: by 2002:a17:907:7d90:b0:a7a:9ece:ea68 with SMTP id
 a640c23a62f3a-a83928885f5mr504949266b.10.1723986236910; Sun, 18 Aug 2024
 06:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
 <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
 <xmqq34n3jswh.fsf@gitster.g>
In-Reply-To: <xmqq34n3jswh.fsf@gitster.g>
From: Matheus Tavares Bernardino <matheus.tavb@gmail.com>
Date: Sun, 18 Aug 2024 10:03:45 -0300
Message-ID: <CAGdrTFhZ6KeDPDUoCsV3h5myPuoYf7RR8eFdbFFXGrUGCdEkEw@mail.gmail.com>
Subject: Re: [PATCH v2] rebase -x: don't print "Executing:" msgs with --quiet
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, newren@gmail.com, 
	ps@pks.im, Lincoln Yuji <lincolnyuji@hotmail.com>, 
	Rodrigo Siqueira <siqueirajordao@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 8:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Matheus Tavares <matheus.tavb@gmail.com> writes:
>
> >
> > -     fprintf(stderr, _("Executing: %s\n"), command_line);
> > +     if (!quiet)
> > +             fprintf(stderr, _("Executing: %s\n"), command_line);
>
> This is very much understandable and match what the proposed log
> message explained.
>
> > @@ -4902,7 +4903,7 @@ static int pick_one_commit(struct repository *r,
> >       if (item->command =3D=3D TODO_EDIT) {
> >               struct commit *commit =3D item->commit;
> >               if (!res) {
> > -                     if (!opts->verbose)
> > +                     if (!opts->quiet && !opts->verbose)
> >                               term_clear_line();
>
> This is not, though.  The original says "if not verbose, clear the
> line", so presumably calling the term_clear_line() makes it _less_
> verbose.  The reasoning needs to be explained.

The idea is that, when running in --quiet mode, we don't want to print
anything, not even a line-cleaning char sequence.

Nonetheless, since these are invisible chars (assuming we haven't
printed anything to be "cleaned" before them), printing them doesn't
actually make a difference to the user running rebase in the terminal,
as they won't see the chars anyways.

The actual issue is when piping/redirecting the rebase output, which
will include these invisible chars... So perhaps, instead of modifying
the sequencer.c to use "if (!opts->quiet && !opts->verbose)
term_clean_line()", the correct approach would be to modify
"term_clean_line()" to return earlier "if (!isatty(1))". What do you
think?

> I actually would have expected that this message ...
>
> >                       fprintf(stderr, _("Stopped at %s...  %.*s\n"),
> >                               short_commit_name(r, commit), item->arg_l=
en, arg);
>
> ... goes away when opts->quiet is in effect ;-).

Sure, I can add that :) I was mostly focused on the "Executing ..."
lines, so that's why I haven't seen/touched this one.

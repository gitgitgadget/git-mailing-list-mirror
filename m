Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63E28469F
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409979; cv=pass; b=ea52x3LpQYjeeiBp/vGooBaNL6QTLb3a0mU/LDgdUANADdGUNwSkNiuFDsyatZtr/F1+dYR3kjTHEH4z/5bukOtFJJxX2Goa3Lj+BzkitZmlLH7iWlrqji4oxKrDj38dD1zBPiYO6/gRq5FOOOyWT+YMqDgclbvAKjUHVlG86jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409979; c=relaxed/simple;
	bh=N0A1XexTVRbzGNNjON9QMKrxqds+uraDndttJXAsZyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjAmbCQK/zEDh9DYdmoK1GFhZ5sS52+kfd7BooTkHdsTMUMCs9sB4tqo8Ufi45gz0glBvR9sLJXUiJsJvKFdyYA+npaHmT+tb4knB5/gRnqSrgvmwiQycxfLZiE3sEprb1+/Esda5q2T+mIVWQu4Su7F6MqUkcr0TLta7GrvFak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX2hkFdh; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX2hkFdh"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56379cb870bso697034e0c.2
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 12:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770409978; cv=none;
        d=google.com; s=arc-20240605;
        b=lumUQLSPwb56jwEa/7noXBM5qwXvZBCGXBQClfrfYdFsRxBrdixJ9cfQMuA78SNfji
         f4JR4yaV3ZdyKVkN+7QZUX5fAC/m0qh+D+i5nfcbCgzdXpCyyDAe1mEBN7YsNuHBxJ4i
         7bQKNhEjHamp8BYftIoBQDubitBmkMCIcNhu8gFmhceRq6lXBRCOdmWu7paCU2H8xSFh
         PrC2s94j7ZEi9v4s8HYoC892C0qDpCNkNj2TukwBf4cLSohrbwToweLQksz+O+1sAy9H
         EdKjfAtbrDz7OPmC/As9CcUBbuelfhS7zTklmwKyGesStFRAhUo6Xibkf32P0oTbx480
         mB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HWxvOp/xh661UJpsZPmKOfH7m+uZUR+k1aoff8Ypsj4=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=RrepL+jKTGu9JRwjTP1vAo6eEIyBcXUwU3En6kpzAtpsAK/dRtoWzmOjCcCU+g1/R3
         mLcakRh6GgZlClgQdRGrZAYiVzbZMK+3C/4nj98dcUhFdOL5lfCnm6fXiP4bq+KG5Nk7
         yHghP8Nx5OYxaynQ5RqlygYPPElr+6u2+86GfkJ909WjDofencUswjR1GwWNNJplLAZA
         NWy0Csh9JQ3CNsdp43xgFanKi2jxOpZm6bAXSxUZTCR3nEcZqS2gjn2EaTsFw3jEg99N
         acNfiA2E3PM0wOf9bSp6JT9xw3hCeQwQI1OjPmtnLP6E4yasBRRetd/CMW4MU7ocroUU
         cyGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770409978; x=1771014778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWxvOp/xh661UJpsZPmKOfH7m+uZUR+k1aoff8Ypsj4=;
        b=GX2hkFdh7az8XuHljlGxO0OuRistq3dy0Enmm8dvIEBRKQOBqiWM5IdORrI+4PtiXc
         0KYab5Ujoii2lPGlCJLgA8edpiFCw4O0O9DCE/mHGhjJLe5ZWkjecNg3Vs1rNiKiBUal
         xjj/a/ENvRugAkA5R2I0IqBtA2CPv/7ApV17Kfd3pKNE4GH3R2m7lf9SuF7wE57KhTQo
         25+FqtL7x5RnpthH7MDQZx0sK56D0VHi4M7vB/TcmXQe3eZTAZl6AZf0Bl2xNvbJ58mt
         OTjt2cq//MLwJdF6UYzrk3xpy+Jp73+p9msAHG5nPNFbgml0KdkY6ZAxBGLKeTcOH08Y
         XeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770409978; x=1771014778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWxvOp/xh661UJpsZPmKOfH7m+uZUR+k1aoff8Ypsj4=;
        b=CZ2HCLFjgBwKvWOfXJuYaA5YTHiC/ADat5V17LHopRraRA2s+dRJ4mf3wkZK8mWHJR
         aiGa32LNJWmf17vveAoAIafTXz4w8PGyIiuqybgq8DbmHjLCGvrH4WuOO1cUvC4IMlzm
         FkT7SQn4Nyn1RYvxqyWO1Gw9IC6QrzP76ZdS5U7GWp8BLZ+77HsDXwbfiBZSplhvf3+N
         gaXk0phTBaj1N5WK+gAmWe26/p0nnmrLtVkKcdRj8CjzM/ZwIVAgNcl7DJH544BHKiGs
         59I4IRNY/cJiMI/OtXt686/07IuvmFzUh7x6TWyT73Xh/1bkwgTiGaDa0B9YyrbakFGi
         QGQg==
X-Gm-Message-State: AOJu0YxXpz4JqOkjo3qCGxzJ+8ymO1zMfmdPy9bKAMcVCR4j4S3jfScf
	qZ7rZEBBMs2gSk5RDavH9/H+6wMwnGTPjvemxuEc3/7L2lhqixF//FQu2gdjau3KefG4XjzQbUj
	Y0oi1/6Eaylnb8QiMlnal/k3B8yNZeWlmMkUfqY1GZQ==
X-Gm-Gg: AZuq6aIjbL/jZshxccsdYrl1A7K2HqYmlqBUX4pVtXXfdFXPjNFs84Yxx07nib8Lkp0
	F7dRG0uEcy7P4FsuZYjoyNAv+Dn8QBLOa2yCba/13WOF6rKLr06UZnaxWiBBGxd03zumux0Uq8L
	NtLnDbvXNQOtjcC35uny1Q9yWTpbh46rOC0A/fXhkQc2OesRFnXTNGfbY1iO2KI5UiZ/v4uJHfS
	uBj2JaHW9Gk66GoW1OEkFSlF3EqemmcNFKSz5Tl7idOaPHuA2QPB6YjNj2SodRPivrNKyu0JNQ=
X-Received: by 2002:a05:6122:1da1:b0:563:c3e7:6132 with SMTP id
 71dfb90a1353d-56705fd477bmr1140273e0c.10.1770409978522; Fri, 06 Feb 2026
 12:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqqwm0pem83.fsf@gitster.g>
In-Reply-To: <xmqqwm0pem83.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 6 Feb 2026 21:32:59 +0100
X-Gm-Features: AZwV_QhHy6UNn5B-wH13aZGZ-rRsM523Z5spa2x3V3Y1R0k1AGi3tt_PTtLW_Ek
Message-ID: <CADYq+famEeYR4qRBMAVsdjOCDj0ccOgXRUA_SGX0VuUhNDEaFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 7:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > +     for (i =3D 0; i < s.file_diff_nr;) {
> > +             if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
> >                       binary_count++;
> > +                     i++;
> > +                     continue;
> > +             }
>
> This "continue" is a commonly seen good trick to avoid having the
> nesting go too deep.  As we know the case where the condition holds
> have already been dealt with and moved to the next iteration at this
> point, we can ...
>
> > +             else {
>
> ... omit this extra "else" block and write what is inside for
> everybody (not just "those who did not pass the if condition above",
> which is what "else" tells us).

Yes.

>
> > +                     ret =3D patch_update_file(&s, s.file_diff + i);
> > +                     if (ret =3D=3D NEXT_FILE) {
> > +                             if (s.s.no_auto_advance && i =3D=3D s.fil=
e_diff_nr - 1)
> > +                                     i =3D 0;
> > +                             else
> > +                                     i++;
> > +                             continue;
> > +                     }
> > +                     if (ret =3D=3D QUIT)
> > +                             break;
> > +                     if (s.s.no_auto_advance && ret =3D=3D PREVIOUS_FI=
LE) {
> > +                             if (i =3D=3D 0)
> > +                                     i =3D s.file_diff_nr - 1;
> > +                             else
> > +                                     i--;
> > +                             continue;
> > +                     }
>
> The asymmetry between next/quit and prev feels curious.
>
> The patch_update_file() helper returns QUIT when the user tells us
> to (regardless of auto-advance setting), PREVIOUS when '<' is given
> but that is only possible with auto-advance disabled, and NEXT in
> all other cases.  The check inside the NEXT case for auto-advance is
> to decide if we want to overflow 'i' beyond file_diff_nr to complete
> the session, or we want to wrap-around back to the first file.
>
> But ret can be PREV only under auto-advance disabled, so the check
> there feels totally redundant.
>
> And we want to treat the list of files as a ring buffer only when
> auto-advance is set to false.  This may work in practice but the
> logic feels convoluted.
>
> The patch_update_file() knows how many files there are to decide if
> we want to offer '<' and '>'.  It also knows the file index within
> the file_diff_nr for the file it is handling.  I wonder if it should
> do a bit more with its return value to help the caller?  E.g.,
> perhaps it can return the next 'i' if it wants the caller to advance
> (and decide to do the ring-buffer if needed), or if it wants to tell
> the caller that everything is done by returning some sentinel value
> (e.g., -1)?  Then this part of the caller can just be
>
>         if ((i =3D patch_update_file(&s, i)) < 0)
>                 break; /* all done */
>
> perhaps?

Yes this makes sense.
Thank you

>
> By the way, I just noticed that the new local variable you added to
> patch_update_file() is called "ret" but that is hiding a different
> variable "int ret" that is used to handle the '/' command.  It
> should be renamed to avoid the name collision.
>

Okay thank you

Abraham

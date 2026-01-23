Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EA256C70
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769204590; cv=pass; b=NsH7KT0wpVRy2ev4f+0aodHSzGHJDHV5TpqFECf5OIXUJ0+zhUB5YVSRgkXcOuYqEeNLkgIE8I+bb8FTZxCl3XClGrTPhuDSQOki86Jc2o8lpot6c6ph1ukM6EISgBxkjRadsA4rTqrAdIDJJ5/Noic2H4PWRI2M2TVfNBqCX2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769204590; c=relaxed/simple;
	bh=F2FzTgTBZUOHTiky0JRroANaTRcrSzohepHsLSMscsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqB/0YeYn0lxuWAdrq+k/aXiblijjmm29wz5735XylAPrRuk9yNABoof4xkx89A7UhM4xTfkoFNHxmaxyDmFV05BpR4VV/68O76MsY3d7Hs7GiL0lCGJ3W5VP0NdfO/qzD2vLLfTJyHhdReVxDZcI/CCaAvxS7UlN0zcTri0KoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO3kIjuU; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO3kIjuU"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5664393d409so349396e0c.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 13:43:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769204588; cv=none;
        d=google.com; s=arc-20240605;
        b=O+wXL5IhuQUeeddVeR0lG0EqwCdW9NgxQk5GZrPUOPXQJ6aU89xgeszx7o8z5A6+m4
         aQ4GiQdbnhOGgXMM4yicFloxyGkQaKvjbTJyuJuudZOfpbsqHGH/LangY5ZSJD/3SEYm
         gARmPKPoeRow2sIfXJW6qGoxDD1bfBIFieXqBzE5CCy2Hovh54AHs39nmFJ0WQH7/bN4
         9mFTU+HvN/eOkw2McN+aK+K+WKGT1GViBi5nyIdzPvh+J9UpZHEbuyO1muuMRRrUYhsb
         Z+UvIWgrS0zHKFZc48HWlQCjY3S1U/iKwbkM/SqF+iUxhYVSFb961Z/ECaCAEuiVVraK
         7b9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQVasNpqFh0OalLqxTp7VIFoUfLEwk2vZ5BUYi2sz3o=;
        fh=shWxNb8qA0DxLN80W7Sz7Tg64EW8RLYpEjyr7bUBFds=;
        b=T+DF9zqH44TY2tyv5mcR4qKQ4W+c3iv7zLKmEoHZs8LRkxPnWRz1yCq+dI+LtUjMRe
         sJzS8w08IN55BhXdYlRozwdB+nrd6v8zsCWZwBjGjUBylMZ5hcfJKSoTG9FaduLiUWXo
         VLPTCuEIVebulBnnAIRFmBcVxizuzx/u3rYLJ0EKjJrY0NlSimXcHz6s1G0gh5XW/ekr
         dAOIJoLkFF1dsohCC18o7Rb7guYcXKijAtJ0bz369nkDxUp44cQx2kPe3HNYgXusVTaI
         d6gSdsC/yKdXG70kuSrTyFi9kJ3ZIdN5bhsmR9Q8T9QkNqZZMWt7DToSQIl83WGEXMkT
         Oxfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769204588; x=1769809388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQVasNpqFh0OalLqxTp7VIFoUfLEwk2vZ5BUYi2sz3o=;
        b=XO3kIjuUzRbl5NzvIPN/nSJkjcBzwlIWF9i3nxA1t8v5Y2tqcqx3aCHWgGplJhE8KT
         KooQNjoixAmBoAmKfG2OS0OjuDgJDbQ2v10DWfDoAxV+Z58fQavTe+tX2BmNa+zrs7Jg
         JnyoFZ0rQAKc+zkAia3UA0N1+EJMeK109DGmfHFBzDm3y3CjVq0P0kHGdnYyyujQNE1J
         k9L4H4MbFPV090wSrYsQ+UBULJUr8eNSLojRiSw/a60PgL7Aqa+q6GyIC8ZstSb4TDUz
         DkjjpUF2dvWGQimCsuaJibBa02OqPKYr/TFZnpig6WHMMrpJLQD9EYJPTRA02G0+azi4
         DB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769204588; x=1769809388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQVasNpqFh0OalLqxTp7VIFoUfLEwk2vZ5BUYi2sz3o=;
        b=H9AnLF2SLd8giF3MvYI3sDG+JQkM5hJ6CKsGUczY7f0ub4wYBp44UFD/+5ZiauCLMl
         W7ciVCPhLitBBIrqcYKJ6YSiWXG4zhtTEGqV5KwMPywxHixAhlIVV5sHTGh5M23+n295
         i48LLayixsudZgQV1JK4uvDa6DN0CWOUI82Y0bHlRu+PWev5ntMXQvZUOsVRCeozOYQ1
         I001K5Z7PZLUdlrn10gzxcXz6tBZM547EM5eBcZQ9+gWwBYRNybOs+sBFJFm2480mRoz
         xYX97OGNhxNkgxtJ7wHkc3LJ3fZI6bmMMvSVujUp3tTAKbmr6g+EQM+hZkS0aB2mPk3l
         sRFQ==
X-Gm-Message-State: AOJu0Yxs7rVugS10BoB87kHBZAWdqAj+3DCR3wmWS9tjScNGWaflfuPw
	rRWYTVS9uBDqCuCWlLVNQws6Bv03aqCby5vWf6Cq6V84wo09jqkLoLJ2TIO+31tMQ3oT6OAC7Tu
	rONCJODkM6o9JCLif5wTEC+2ud68r66E=
X-Gm-Gg: AZuq6aIbOmD3X2RRR6slFcNAfd0lgDb7a8V4A5O52xkizEjfQyyurrDAgICeQ+t0J/N
	CHdD8dUWbNMMjWEdPukm4Zt6HNjSxUyUtds2HTOguv7ZUyYlD3a8S5WHF2ha2rcmMpWuqaseYPS
	+rKZ6M6c6wBMFGkOOJtxX/6StpCciQS4h0HbHxsB6fqf4ZaQc84kepCouym72bpLmy7SRZus/zt
	79YR9u54AF0woVA08Kkjv4+9LZDnuQ4MgdWY1c8kEzF6xgKNMPhItu8QMRJjA6JdMW81ZfvHMk5
	d98=
X-Received: by 2002:a05:6122:8b05:b0:566:357b:ef25 with SMTP id
 71dfb90a1353d-56645dcb20bmr659103e0c.15.1769204588296; Fri, 23 Jan 2026
 13:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769164663.git.abrahamadekunle50@gmail.com>
 <e98d8aa20fb4a82b93b9887e38eb8289252b936d.1769164663.git.abrahamadekunle50@gmail.com>
 <xmqqv7gsi8s6.fsf@gitster.g>
In-Reply-To: <xmqqv7gsi8s6.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 23 Jan 2026 22:43:09 +0100
X-Gm-Features: AZwV_QgCNA4w9dmeFIUXqdFIPjiOHDIFD6wX4QjRLAAfSlOuGlufRzPBjMkxhEs
Message-ID: <CADYq+fZ-U-iG==0e24E7ncNcjSUaBJz9qsKKEG6UENjxHnW4pg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] add-patch: Allow reworking with a file after
 deciding on all its hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > After deciding on all hunks in a file, the interactive session
> > advances automatically to the next file if there is another,
> > or the process ends.
> >
> > Allow for reworking with a file by introducing a what_now prompt which
> > allows for navigating with J/K or advancing to the next file if there i=
s one.
>
> Describe "how" you are allowing these new things that users used not
> to be able to do (no, not in the "by adding this variable and
> switching on its value" sense, but in the "now deciding on all the
> hunks in a file does not automatically advance to the next file, and
> the user has to do X to move forward" sense).

Thank you for your feedback Junio.

Okay, this is noted.

>
> > -     int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0;
> > +     int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0, sk=
ip_what_now =3D 0;
>
> This is getting overly long.  Wouldn't it be easier to follow if a
> preliminary patch split these existing variables into three
> independent definitions, and the main patch adds the fourth one?

Yes it will be easier to follow.
I will do that.

>
> > +                     if (s->file_diff_nr > 1)
> > +                             prompt_whatnow =3D _("What now? [J,K,q,>]=
? ");
> > +                     else
> > +                             prompt_whatnow =3D _("What now? [J,K,q]? =
");
>
> I wonder if ">" has to be made so special.  Wouldn't it be easier to
> reason about the logic if ">" (and probably "<" to go back by one
> file) are added to the prompt in the same logic that decides 'g',
> 'k', 's', etc. should be shown using the "permitted" variable?

Yes this makes a lot of sense.
Thank you for the guidance.

>
> And when the inter-file navigation is in the permitted set (i.e.,
> there are multiple files involved), you'd show ">" (or "<", or both
> if you are dealing with the second file among three files) and ask,
> instead of silently moving to the next one, or something like that.

Yes I understand.

>
> Organizing the logic that way will also allow you to move to the
> next file _without_ first having to decide on all hunks in the
> current file.  Just say ">" to deal with the next file first, and
> after you are done, either come back with "<", or the system notices
> that there are undecided hunks in the earlier file and takes you
> back automatically.

This is very insightful.
I will work with this design in mind
Thank you

>
> I also have a hunch that with such a code structure you may not even
> need skip_what_now flag, but I haven't even written the code in my
> head, so if somebody tries to do so, they may discover the reason
> why such a flag is still needed.

Yes

>
> >               strbuf_reset(&s->buf);
> >               if (file_diff->hunk_nr) {
> > -                     if (rendered_hunk_index !=3D hunk_index) {
> > +                     if (rendered_hunk_index !=3D hunk_index || skip_w=
hat_now =3D=3D 1) {
>
> Style (which may become irrelevant, as I just said the variable may
> not be needed after all, but anyway).  Elsewhere skip_what_now is
> used only for "is it zero, or is it not zero?".  Comparing
> explicitly with 1 only here makes readers suspect if assigning 2 or
> 70 to the variable has special meanings and wastes their brain
> cycles.

I will give more thoughtful efforts into the next versions I will send afte=
r
your recommendations.

Thank you very much

Abraham.

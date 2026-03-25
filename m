Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385701EE00A
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466615; cv=pass; b=Ntk+xKMxWlv0tEd3rIAe+iEs8LzkMwiAhdnt3ZEpqSQ8zsK6wZoaaib6eZHYKuipOmC9cQKRkWn8HLtgI7uvt209TSMOUCX9hGBC3bnD76cmBE9nTD4jKa09LeBswSG/BalhTbvNXm7FwINdlogfZMmMLSYpSNTKh8RGslO792E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466615; c=relaxed/simple;
	bh=jsiv7xeAWPGf6mlCMRty2ta4SWcT7+HkoYE4oYJ7kqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joBsA+WydJAMZxRy8TIjmz5DdgF+Zv8b+TKH/zh3KS/AtQndEnpkZo+jGw51OqSL+72pBbIXHP+QP8KLjTsCWmhSQ53nUuEMCFQwalmi1Bb0VmHTBHUFqGMLRmNZ93+8YUviO1sgOcMNXht8FOyN/lu42EbF4SJiqciowzfQAjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5TKPIa2; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5TKPIa2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66ad907833dso283299a12.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774466612; cv=none;
        d=google.com; s=arc-20240605;
        b=lF4SwCHAzYxOMhJMuQNJ720+i7a/5z+9CPV53oJxDQLek8w15OLPbDWlN2A8gwgnUy
         VLt5ndF1B3Et076T8Xg1CvvqgS0NNSJJ9gx1ay/jGM3EpNgO0vWJ1PqK+Qb4keI0x3+v
         1ZkHSJf1fhA4HL75FkgMNwV1rau0dg4+EzGNMv6ReggSZYRt5CfdiFn6iAS79IIZahTQ
         vlyFAj1KDvu5vhOi7Xe1QnJDr8KnBJDLQs3/VIit4SpVVLILUN/GLwha6PF5P5emujdM
         Kpz/UCnv06szC9iC+EsCN6dC7rIbnHQcZadyCSmXK/j80jknu4lgcNk1ofGLsAmhiVvP
         DZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAJqyaO0wFozm/3bRq59IG398UxfQUgDSP4xoKWdLjI=;
        fh=NzcgN3jXytSUsaqO/AXz8UoqXs2kk8M58/YwXy9tVqk=;
        b=YpMGkKiX7QA8HpxwIcBwweq+NUcVUwPJz/a+0s3wK76CciBsA/PaLgADi+2kgFkJ5A
         OJ5l1nuTMJq7nUs1AiW9aV38pmkOkToZpJcLig516FOdIxW31fKyMgylh4+gVYhqiKCD
         YMkRWMZ+Jo7oaMX6NK9tv/70V44Gv4Iy7zSNq1UMKs+zH8FAuiw9b+/4ghSA1ey6sjC+
         4syHwfsZYcRrZfmuzu6M1E0L3ZGbhGeqDpK5ctFKIlbhhM0YuC7uchhzD3Adm2yfoisg
         CFyfSAdCl8w4mwbPvG1TDcF6HPUPHKJiOAaUpKDcTOTkN2sAeR2lfRhwib9OQs+kwL9S
         AX4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774466612; x=1775071412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAJqyaO0wFozm/3bRq59IG398UxfQUgDSP4xoKWdLjI=;
        b=e5TKPIa2cYkE3R2HZPG923Vg0yrlbp0kUMhx24x5VdIsJVeODxPIzh7csAF7P0jPsy
         ukRc3vJeLcC9UqFLw+XsOMqkgO5xg41XW1l/ZOUlKGDy8JVf+0csviqjD/dHMF0krPGw
         KCghbv4pzUMtrUfYVDmNA9ifQscjsg90aoie854f9kLXWytU1ZSB8ev1Pz7b58PO0XVd
         hAUkdcY1O41LwNckxLBPPdOd8u60PIzcS4E12u9P9i4z+eBDc+ThDgzdia12JM6YbakE
         EjkYOVWuVpTbTOjyOhZPJYgjpPNnEgbtzQStZOzUTuo3yTx8LTOWl5K5iTHpvLtGkkLx
         YyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774466612; x=1775071412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAJqyaO0wFozm/3bRq59IG398UxfQUgDSP4xoKWdLjI=;
        b=lzv8N3wucUFFLjrBB6wUxrrM3qRJITvflfoSPWfjG5wKRzysgLhHaPwK5emMYKKdML
         sFq4oJcNsLkMLd0mmEpoMaoQAH3iyQagda9P9pzxyAJFXZq/g0m7ETEPhYmAOwwTZEsM
         QzyWkL32fdNq18QPLCk9tKxpqUkiNPpl1Xj+OLIiPl3SiG3ahy3P3zistxXbgbx8Zwmz
         ql3sFvhxdMobu7WYbXt6O3CB0+gloNy3bRDqvR6WLXorA96AZQSaz+nD1kOf+o5Z8FKG
         UjXyi5yiPDXow0PRq/Uri8I3SE1aM//6aeq+r4xC7wyxaDLR8pGbCdmjfuRNgelZD4+7
         jcTg==
X-Gm-Message-State: AOJu0Yw9thIRJwrvr8MyIy05X8g4CcuQxRV1LcVxAnm3qYR8kWBpKkZG
	ZOBl/45NmPYTgsho9/HSYLKoauPJZN/xX0SH/n+gjFj1wxlqDVX+WA9s0ypYuqn5J2dtuh7pzuP
	nncnIT/Jva8OKLvQbZbPwMU4BrDOvX14=
X-Gm-Gg: ATEYQzwBBki0OcbGSQX6bBovkCd5By64a99JtXSl8X5DKATI42FNy/rHSZs1xdlyJKs
	wwvtaXIDFS2tX284D7057nr5KuckkGBrCn8vG/8UBu53V2zgbKrX+zhrwRmJ5lNpQfv5oJGSx8P
	BTKFGo6QHYHKd1bNOanDT61MxNkk/QCRTJoM6KSE04+QEEaDdaMRdiHtRXACOG+vBPKdPCjJ7ng
	c7TvOkLrWvMrQhn31yB6IrpLqn3m2nd9FGPH7eqjt2yGs+SAYIsBJ8LpjFeqGq2s+ocam/McewX
	00LmIK0cnMNftJ/vm6gIS6NF3vrR3pRw14B8PHtdZxMHhXLh3A1GT5OCWAoiS9iWaoY7lSxVZw=
	=
X-Received: by 2002:a05:6402:5389:b0:665:33eb:22f9 with SMTP id
 4fb4d7f45d1cf-66a82618602mr3344029a12.6.1774466612356; Wed, 25 Mar 2026
 12:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325075055.354709-1-luizedc1@gmail.com> <xmqqcy0rvlao.fsf@gitster.g>
In-Reply-To: <xmqqcy0rvlao.fsf@gitster.g>
From: Luiz Eduardo Campos <luizedc1@gmail.com>
Date: Wed, 25 Mar 2026 16:22:12 -0300
X-Gm-Features: AQROBzAWCtuHfz0-H6ldlSQsfiAd4-5h52s-dmxqaJZ2SgZVNb2s2ZgKQH0aR44
Message-ID: <CAN+A6TtsGGQZ+3Q+MSp_kKzxcwMgmCp1bd+tD6y9U2FfPqSLFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] add -p: support discarding hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, sagotsky@gmail.com, 
	Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks a lot for the detailed feedback.

> "add -p" that touches the working tree feels quite weird.

I understand the concern, and I agree that having `git add -p`
perform destructive changes on the working tree is a significant
departure from its current mental model.

> people trigger "discard" by mistake ... no way to undo

This is a very good point. I had been thinking of this primarily
as a convenience for workflows where users repeatedly skip hunks,
but you are right that making such an operation easy to trigger
in an interactive session could lead to accidental data loss,
and that would be problematic.

> What you want is probably a single command ...

This is a very interesting direction. My original motivation was
exactly to avoid having to switch between `git add -p`,
`git restore -p`, and `git stash -p` when reviewing changes,
but I had not considered approaching it as a single interface with
modes over the different views (HEAD, index, worktree) and
non-destructive flows like stashing.

That does seem like a more coherent model. In the meantime I will
rely on the workflows you mentioned (`stash -p` or `restore -p`
followed by `git add -p`) rather than pursuing discard within
`add -p` alone.

I will step back from the narrow "discard in add -p" RFC while I
think more about this broader direction. One question I would like
guidance on is whether something like what you describe would be
more appropriate as a new top-level command, or as an extension of
an existing one (and if so, which entry point would be the least
surprising).

If a unified tool ever includes a destructive "revert hunk in the
worktree" mode, I agree it would need to be very clearly separated
and hard to trigger by mistake.

Thanks again for the guidance; it is very helpful.

Luiz

Em qua., 25 de mar. de 2026 =C3=A0s 15:03, Junio C Hamano
<gitster@pobox.com> escreveu:
>
> Luiz Campos <luizedc1@gmail.com> writes:
>
> > Hi,
> >
> > This is an RFC for adding a 'discard hunk' action to `git add -p`.
> >
> > Currently, when using `git add -p`, users can stage or skip hunks,
> > but cannot discard unwanted changes directly from the working tree.
> > This often leads to repeatedly skipping the same hunks across
> > multiple passes.
> >
> > This patch introduces a new 'x' action to discard the current hunk
> > by reverse-applying it to the working tree.
> >
> > This idea was previously discussed on the mailing list:
> > https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.ne=
t/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0
> >
> > Open questions:
> > - Should discard happen immediately or be deferred until patch applicat=
ion?
> > - Are there edge cases involving overlapping hunks or edited hunks?
>
> After reading the discussion (by the way, I do not recall seeing it,
> so thank you very much for having a link to it), I agree with what
> Peff said back then.  "add -p" that touches the working tree feels
> quite weird.
>
> In addition to that, letting it make destructive change makes the
> idea even less appetizing.  Once you remove the changes introduced
> by the hunk, it is forever gone.  A "discard" in "add -p" would not
> solve your problem without adding many unhappy users who lost their
> work by mistake.  I do not want to see people trigger "discard" by
> mistake in "add -p" session _and_ find that there is no way to undo
> that mistaken discard.
>
> "stash -p" followed by "add -p" is probably the best we can do that
> is safe.  When the unwanted change is truly unwanted garbage that
> you would never ever want to see again, "restore -p" followed by
> "add -p" would be an alternative.
>
> One reason why they are not satisfying is because during the later
> "add -p" session, we will notice that some unwanted things we failed
> to notice and get rid of (either by sending them to stash or restoring
> it away) are still there, reminding us that we are imperfect human,
> and at that point, it is not easy to switch back to the "stash -p"
> or "restore -p" from there.
>
> What you want is probably a _single_ command that lets you inspect
> the differences among the HEAD, the index, and the working tree, and
> allows you to move things hunk-by-hunk in different directions.
>
>  * You can go through the "git diff --cached" (i.e., changes already in
>    the index), and selectively undo/revert the changes to the index,
>    similar to "git reset -p".
>
>  * You can go through the "git diff" (i.e., changes between the
>    index and the working tree), and selectively apply the changes to
>    the index, similar to "git add -p".
>
>  * You can go through the "git diff HEAD" (i.e. changes since your
>    last commit), and selectively send the changes to a stash entry,
>    similar to "git stash -p".  This is not destructive.
>
> And if the single command lets you switch among working with these
> modes, you no longer need to worry about forgetting to send
> some changes to stash to concentrate on working on the rest.
>
> In addition, optionally you can also have this in the same command:
>
>  * You can go through the "git diff", and selectively revert the
>    changes to the working tree, similar to "git restore -p".
>
> This additional mode *is* destructive, but if you know from the hunk
> that you will never need the change in it, it would be a right tool
> for it.

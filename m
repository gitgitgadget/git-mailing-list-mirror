Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6DB381D5
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705861236; cv=none; b=n1375gsq6MQivIzdi/roqFLc9SKGP9zUl4QD7bMOn+wkF/+yrsgEFhvrb/sBlQvi/1jxA43uuXSH2M4Jd9BH6OxDfMohOi2hm8HGwDAOVkKp7EaYm6OznFTi/WiTRxzB7Vza0Mkh+e5ScexvJM6mhW87vTDGDNrk1/7NsRhRZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705861236; c=relaxed/simple;
	bh=vKUIF+2m7KVlL5Dd0d1IMBc8p0JgJ5aD+nzEYQL6DvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT+ZPmTWh1GD9vJEL2jDxK92C0vTKrzwoIVcN7iDLmY5ugy9CHacTbhlcp+0hHZhCPEwWXyliqwUM9EbJiHbY2/edrX6rZwjP/P1TMorHKXYPh1T+D/nN5BqMTkVNEOgER/e2j/AS2U7O/AT0lW+7VWXfEoVpd1wE2Qw7L5b+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRzG9/5r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRzG9/5r"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so32530775e9.1
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705861233; x=1706466033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZTP8m+MUgIg3uo3+KJe+Hs8IFbiYnMvdjFW+kmf1hE=;
        b=VRzG9/5r/tFuKIy9/TSR6qsfdGIigqh4prRfheG7HsiLaSCDpT1IIwpcWm4jOqSjAx
         N6g/K8EqHaGa1wgnudYVORjdGDfxWTFCmR/cEhmlMFDALhK1mkNuVdXyQxUfghHd3m+g
         i88rZ5TQJHLQKVoe69T4jb+AH8WyBUuQPEuHIJAJ39rQinRljWUTvoRVJ4h6Tj+gELk5
         PhDFjBZQcgirlnVVCQ3fxt8ee8ft2kco5XuiFdoFF3+6fGlG8U2IPEx48e1pN/p1jM5/
         UYGIMQA/uVDISAorGF64hNhMsxweiUtcAOymRT2r12t/kp5/TC/gOb7m8+x4JI/O49Ds
         qKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705861233; x=1706466033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZTP8m+MUgIg3uo3+KJe+Hs8IFbiYnMvdjFW+kmf1hE=;
        b=gZso7UkCiCfLtMmLXW50K1UUTCdzXVFNMscIFJ9Dlnww9A3vimr5zXjfqNtxz9VnaC
         l514cXP9gTFqd7o7EAIbNcC/l3LNR8F5vW+kFJOgSeDLhR63Vim/WpGbN6mxNsS7gCPk
         4Hy8X6HngupoaGrjwsBNNVR2RwuCSFIKcKdWtCy3osDtrmq/SOngxW0F/74pHXbwVXCg
         /qstSlGQ0YEivKVf8eOfh/nRS0b14C18/JgORsJZh1c0OiEgFIUBqXCdEm8SNwabHZv3
         ZmBkWG7gyX/0S/RwS3fSojqFsKZUkPpb6KvAh5a66XTRP7gXcPIxBt6opaTxZCBKnfLv
         r/+Q==
X-Gm-Message-State: AOJu0YyzVsNSnWoxM8BnzSudu7A6boEVRwDZrdBSlnykxF/KqbC5OWRm
	VHx2lBhEvj5kzaYZVBtxOF+6vuJRSAJMCFrL7jpta1XaXPDh7bv1SL/OnUgLkKTDd/s1MA/8uzT
	UDNQL27mS/IfEPUc5qSQjDbbHhzH6C2PGt6k=
X-Google-Smtp-Source: AGHT+IGfzMRJnDAaGrbZICqp5W6Yo8fuPIqBh+80mnG1R2Oxhsi1keS5ElgmbWwB9x/a3FP8W+kOLWhVLSeUxPtAI+g=
X-Received: by 2002:a05:600c:1f91:b0:40e:a8b3:f77d with SMTP id
 je17-20020a05600c1f9100b0040ea8b3f77dmr1081053wmb.171.1705861232597; Sun, 21
 Jan 2024 10:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com> <d6361ecf-82bc-46c6-adfe-3c6ab25d39b2@app.fastmail.com>
In-Reply-To: <d6361ecf-82bc-46c6-adfe-3c6ab25d39b2@app.fastmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sun, 21 Jan 2024 12:19:56 -0600
Message-ID: <CAHPHrSf3-r4G6X-19GMhMzec5kZbopV+ZvmQ5HHBYPNgH6XZCg@mail.gmail.com>
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 3:38=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:

Hi Kristoffer,
Thank you for taking some time to review my patch.

> Initial discussion (proposal): https://lore.kernel.org/git/CAHPHrSevBdQF0=
BisR8VK=3DjM=3Dwj1dTUYEVrv31gLerAzL9=3DCd8Q@mail.gmail.com/

I ought to have included this in a cover letter -- thanks for linking it
here, and I will include this with v2.

> On Fri, Jan 19, 2024, at 06:59, brianmlyles@gmail.com wrote:
> > From: Brian Lyles <brianmlyles@gmail.com>
> >
> > Previously, a consumer of the sequencer that wishes to take advantage o=
f
> > either the `keep_redundant_commits` or `drop_redundant_commits` feature
> > must also specify `allow_empty`.
>
> Previously to this change? It is preferred to describe what the code
> currently does without this change in the present tense.[1] The change
> itself uses the imperative mood.[2]
>
> =E2=80=A0 1: SubmittingPatches, =E2=80=9CThe problem statement that descr=
ibes the status
>     quo =E2=80=A6=E2=80=9D
> =E2=80=A0 2: SubmittingPatches, =E2=80=9CDescribe your changes in imperat=
ive mood [=E2=80=A6] as
>     if you are giving orders to the codebase to change its behavior.=E2=
=80=9D

I appreciate the stylistic feedback here. I will tweak this for v2 of
the patch.

> > In a future commit, an `--empty` option will be added to
> > `git-cherry-pick`, meaning that `drop_redundant_commits` will be
> > available in that command. For that to be possible with the current
> > implementation of the sequencer's `allow_empty()`, `git-cherry-pick`
> > would need to specify `allow_empty` with `drop_redundant_commits` as
> > well, which is an even less intuitive implication of `--allow-empty`: i=
n
> > order to prevent redundant commits automatically, initially-empty
> > commits would need to be kept automatically.
> >
> > Instead, this commit rewrites the `allow_empty()` logic to remove the
> > over-arching requirement that `allow_empty` be specified in order to
> > reach any of the keep/drop behaviors. Only if the commit was originally
> > empty will `allow_empty` have an effect.
>
> In general, phrases like =E2=80=9Cthis commit <verb>=E2=80=9D or =E2=80=
=9Cthis patch <verb>=E2=80=9D can
> be rewritten to the =E2=80=9Ccommanding=E2=80=9D style (see [2]).[3] But =
here you=E2=80=99re
> starting a new paragraph after having talked about a future commit, so
> using the commanding style might be stylistically difficult to pull off
> without breaking the flow of the text.
>
> And =E2=80=9Cthis [commit][patch] <verb>=E2=80=9D seems to be used with s=
ome regularity in
> any case.
>
> =F0=9F=94=97 3: https://lore.kernel.org/git/xmqqedeqienh.fsf@gitster.g/

I think I should be able to adjust this to a more commanding style
without breaking the flow. I'll give that a shot in v2 as well.

> > Disclaimer: This is my first contribution to the git project, and thus
> > my first attempt at submitting a patch via `git-send-email`. It is also
> > the first time I've touched worked in C in over a decade, and I really
> > didn't work with it much before that either. I welcome any and all
> > feedback on what I may have gotten wrong regarding the patch submission
> > process, the code changes, or my commit messages.
>
> This part (after the commit message) looks like the cover letter for the
> series (the four patches). `SubmittingPatches` recommends submitting that
> in a dedicated email message (for series that have more than one
> patch). Maybe this cover letter style is just an alternative that is
> equally accepted. But most series use a separate cover letter message for
> what it=E2=80=99s worth.

That makes sense -- when I send v2, I can pull this part out into a
separate cover letter email.

I will hold off on sending out v2 for a few days to give others a chance
to weigh in on this series.

Thanks again,
Brian Lyles

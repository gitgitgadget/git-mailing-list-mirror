Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABF271A71
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783655273; cv=pass; b=JHaRe/BAKV0B3dpE8BGi6J05Z5F+1EZyN4h4JDN/+AHFQgfyxJ94T/YU/VCgUEZMEDjGvZj0kufXwSOciPFjYAKtG+89+hRBW86jzJlmfJb8X4lVH1jJpLVzG0xxwXLdPUxDL5KNJHFCnjnFDAf1n1B3ANw5FVZUAxqj8KCHGEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783655273; c=relaxed/simple;
	bh=wbhsZekSemgfXLd3e5soDPfIR5j3ilAp9crVMmA+G6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQzHqgxmffsAZQPXO8wE2zohdBk5o4UJPcAPZxbyy4w1alfLF3qPntDgtStsKoJmGIQZXmPpYbAqZVV0uQMYZxGBemJOxtX449o0fzRvbQ/NWeYCeYeHvfJT6GrsPAHhbqVh4Q/OrFuByQHef9a8ORQdjqJKngWaLp7JoSttlPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R05h9usS; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R05h9usS"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48a0ca07c38so292089b6e.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 20:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783655270; cv=none;
        d=google.com; s=arc-20260327;
        b=V2B8+6C57OBRJc7iDjHpQxUIM5NDwVzCUJLcPb5iBA6jFOVluS3kOx4M4xyjwzJwsg
         MRYOYgDSH5fp+fFYOORVkVxJ+2TmfAdPXxOL25irTl2Asa89qAWYHKQpr3o+F0skRKc9
         mY8Z8r3x9X84lzGgXs2NZSxRgT+dg3I7yFO0uVT9khtw8jvqacFTbjh0g3hA4eiv8mcb
         znM4mi602LpY9VTWGufBPe51NVO52hH5tSGFziOGspWxPqRxW7zHclV6+9ahuSZNy+95
         qVYylZD9u8Si5Aipvpopmd6n5+xkWVtCLOSQXCK6oygFE6lbtTkZ/rRwBjXqFtFxdZE8
         yjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PL3q/AhNh0YDkFteRsR2Yb//i83CzvLW0+hHUa0cu9U=;
        fh=YsDP8qhdejPnmdlVXvdly/uN84AbM1az0llqI3pfvq0=;
        b=Xy8J+JS9asUtJLiAzTNCmyU5RvH1gD7ix5oN0R0qBgM4Ne5RvD1VoSSYVXqdfejxKY
         A7YdCe6YLkQBSXBx9YbA+WbKzAw/XbJNCP8bgJ3iPr0KWkUVaVIRqc7oFBd/fzmgyS5o
         Ky5Zy71fIJyRvpwvy228eqgu7sBQsHJZWgkdLVkhbhY9Pj+7pMtQUqE9U4rEMOSIQNa1
         I0t0aokSbGbNYykDqYiwgpS94twQUng+3i7gWMGZrPpx54yXWBi7rIcHFqUhZXUfUifQ
         IHSL95FRRjDXNaDtOx9zGgCU08F7xXME7U4e7qBQ5EMEJBgc97LTiQ5OU2VSn7gEhNUZ
         tzZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783655270; x=1784260070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PL3q/AhNh0YDkFteRsR2Yb//i83CzvLW0+hHUa0cu9U=;
        b=R05h9usSrDwwSVn1K0zeKwUKUlJZ8GRZ5f1Y0TiuZv3qDf2JdactAeeKiQhEOJqmMf
         DeYJyQmaVlueN0GBklc9CkQpVmyVNDvoX6L6QWnK0VccBolRgozU9BWZInEqv6H05KIV
         yshLRkFlNNnIDnyUhpj1abJ+3Z4KnB61kaKSfPuZigBUNAw9NREi41j2aWQFoOTH89rW
         v77Ld7MBpuKgW+yW7hyL3kND2dAlnMav8XJPmw/8Tl+2ncjqZjq8I4Xx1wR6NpkYGkxx
         1jyGLNl7/yvPXlusnF9FCJl2Z0J80yrlad1csDv0tnmEkVyDld/oEBPSfISAG90WGot7
         18DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783655270; x=1784260070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PL3q/AhNh0YDkFteRsR2Yb//i83CzvLW0+hHUa0cu9U=;
        b=mckBSnP8XKhoffzxLZgfezrLkU5SqEco9qaLzg2QjFUQvTF9zXSivI4AYlCCzGlZwi
         Z7cSibOD+d6oZ8JW36/G7d28aUpDahKCeiCU4pa+CRhf47R3Bn2Hk61u3e7DX3PoyPCZ
         zfUy2yG5ot1WG5jwEFwNdnK/9m068wtU65L/Dm4FjtcMmSxa2APd9ZvPuEmkOT85ew/S
         XRSQRtMWuwwIziNZc1kBbKXh91/S2EoDII40YXqilatICvfStZcnfusZ82aRYtBRIHSu
         VEkT+W5/I6DwvFPoL5QMKWc5u9L6P1o9h3wTglEykFZc1W10Iobdj3LExLtEEgMXxw49
         4ixA==
X-Gm-Message-State: AOJu0Yztp8GcG/sLtYWWaCshEUZmFyZfbcq/1EHAuYIs/oKrav10pkKS
	jLpamnkbVza0Qb5Qmbj0nbmJFwkigKa69QE2mtPPUyCANPJFM7SPdJg+EnUteMAeb/pl9FVEume
	pBnmINwFBzzvK7waErqIqxSD9HZGIdJ8=
X-Gm-Gg: AfdE7ck4InN2H0OQdsKazeUw5MkyBVk2F+RMB5F6UDMHx59rhcX/z+7Q7QjIwFaEBZV
	xy/QONZMeHxHdbDvy4uGiEo1jUJsShQm7WuVL9mOn9R0/2rOvgdnHWDUK2yhBAIwDrLk5pTjlZt
	kFHMu4ViT5M4VUzTuBvJgYa9yS05TgxZUbk+eMZXvqHX0uEJLa5F6bco5FZYcqTInzd0GdkUlBh
	jEau6GMmHAXoPdIvWReoMNbWOIK2fQiWACBHnvRVSdmef8RLeYpEr/8InP630wFXHDJ3EYGoYYm
	nw6evU5n8TP+Q03r3yfQSfs4gwRtrUaqofrmX7IejUY1jkdxGA1yfFyJaMgIV0uwGOYeWFMghjv
	aQyFFzf/pFc57UQ==
X-Received: by 2002:a05:6808:13cb:b0:495:e30b:e2d6 with SMTP id
 5614622812f47-4a204e07becmr7697727b6e.37.1783655269974; Thu, 09 Jul 2026
 20:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com> <20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
In-Reply-To: <20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 9 Jul 2026 20:47:37 -0700
X-Gm-Features: AVVi8CdL_eVionAG-DW4QU0VdD6xMOe394hNUmMU2Kyaux4CeMcSEXgVsGxyUYY
Message-ID: <CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] replay: offer an option to linearize the commit topology
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Toon!

Thanks for continuing to work on the series.  Sorry that I've been out
on vacation for 3+ weeks and then playing catch up.  You addressed all
my v2 feedback, and most things in this latest v7 look good.  I do
have one substantive concern with this patch, which I'll cover in
detail below.

On Tue, Jul 7, 2026 at 12:07=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
> One of the stated goals of git-replay(1) is to allow implementing the
> git-rebase(1) functionality on the server side.
>
> The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
> was given. This mode drops merge commits instead of replaying them, and
> linearizes the history into a sequence of regular (single-parent)
> commits.
>
> Add option `--linearize` to git-replay(1) to do the same.

Right, `--linearize` exists to change how merges are handled.  I'd
argue that if there are no merges, then you should get the same
behavior whether or not --linearize appears on your command line.

> Each replayed
> commit is stacked on top of the previously replayed one. When a merge is
> encountered, the commits reachable from all of its sides are replayed
> into the single line and the merge itself is dropped.
>
> If a ref was pointing to a merge commit, that ref is updated to the
> merge's last replayed ancestor.

This is a good description of the net effect of linearizing a single
branch.  I think it describes rebasing multiple branches at once much
less well -- see below.

> git-replay(1) accepts multiple revision ranges, for example:

I think I know what you mean, but this isn't quite right:
git-replay(1) only ever accepts a single revision range.  From
gitrevisions(7) (also in git-rev-parse(1)):

       Commands that are specifically designed to take two distinct ranges
       (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but th=
ey
       are exceptions. Unless otherwise noted, all "git" commands that oper=
ate
       on a set of commits work on a single revision range. In other words,
       writing two "two-dot range notation" next to each other, e.g.

           $ git log A..B C..D

       does not specify two revision ranges for most commands. Instead it w=
ill
       name a single connected set of commits, i.e. those that are reachabl=
e
       from either B or D but are reachable from neither A or C.

You could say that replay accepts multiple branches (references)
within its revision range -- but even then that comes with an "in some
cases" qualifier: `--advance` (and more recently, `--revert`)
specifically reject multiple positive refs, precisely because (a)
simply concatenating branches is surprising, and (b) the resulting
order is ill-defined (or at least looks arbitrary to the user).

>     $ git replay --onto main topic1 topic2
>
> Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
> independently and updates both refs.

And, if there are no merges anywhere in the range, I'd argue that
adding --linearize either ought to do the same thing -- or else error
out that multiple positive refs are not allowed with `--linearize`,
the way `--advance` and `--revert` already do.

> With `--linearize` the whole set is flattened into one line: the ranges
> are stacked on top of each other rather than replayed side by side, so
> both refs end up pointing at different points along that single history.

To me, this is a significant principle of least astonishment violation.

> Replaying all revision ranges into one single linear history is
> intentional and it's the only way to ensure predictable results.

I have to push back on both "only" and "predictable".

Regarding "only", there are at least two other choices:
  * make --linearize incompatible with multiple positive refs
  * More involved implementation (quick sketch): (a) Track a
last_commit per branch specified on the command line, (b) Make the
revision walk keep track of which branches each walked commit is
reachable from, (c) for each commit to be replayed, for each branch
it's reachable from, update the appropriate last_commit[branch].
(Except that when last_commit[branchA] =3D=3D last_commit[branchB] and a
commit is reachable from both branchA & branchB, you only replay the
commit once.)

Regarding "predictable", I'd like to split predictability into two
pieces: guessable by the user, and consistent with other replay
commands.  This behavior gives us neither:
  * guessable by the user:
    * which of the multiple branches specified on the command line is
first in your concatenated linearization?  It's decided by rev-walk,
not what the user wrote.
  * consistent:
    * why does a merge-free topology behave differently with
--linearize than without it?
    * why do `--advance` and `--revert` both refuse multiple positive
refs to avoid exactly this "which branch first" concatenation, while
`--onto --linearize` embraces it?

For what it's worth, looking back at the v5 thread, it seems the `base
=3D last_commit` rule came in to fix the real bug Junio and Phillip
pointed out there -- that without it, only one side of a linearized
merge survived.  That fix is clearly correct for the single-branch
case.  My worry is only that applying it unconditionally reintroduces
the multiple-positive-refs ordering problem we deliberately avoid
elsewhere.  Making `--linearize` reject multiple positive refs would
keep the merge-flattening fix while sidestepping this entirely.

> A user
> who wants to linearize ranges independently is advised to use separate
> git-replay(1) invocations.

Which, to me, is another argument for just disallowing multiple
positive refs under `--linearize`: if the recommended way to do it is
separate invocations anyway, we may as well require them.

> Linearizing is a distinct operation, and flattening merge commits is
> just one aspect of that. Recreating merges would be a separate mode, so
> rather than mirror git-rebase(1)'s `--rebase-merges[=3D<mode>]` interface=
,
> git-replay(1) uses its own `--linearize` option.

No disagreement here on this point.


Thanks,
Elijah

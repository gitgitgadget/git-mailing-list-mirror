Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6191D2F42
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729113193; cv=none; b=PfTIE7y92fj+1FJdn6C20dEv9lN9Nre8W9ywmv9KyZA71WgGvQcZOFJHAUBc/BH7mnRKoJXzFS4elACRn1VcQ4CiB27V2zm69xF7V5oHQnt/mk9Ge0EkKSqT6aKGYkQjfhcnNn0l2AN48cIkUKdWvi8CQP/dyAs38U5nCCZS3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729113193; c=relaxed/simple;
	bh=LTPVeLwZaWrQ95O3WBfsDz7wVAUA68jDP3v3xoDqSq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuoCEcVleWdLelDyzbuEzlZ68Qr/otV2sA+ntsK/NMKeQVsTsRZN4qPxifGb6HH1fcThPJgQtjH1z0W7angUUKJ1UfuUH3enDSmN+03nb0PzQo1RlZd8+nERbDEFLzf2wHCcB/mDWIN4gBJ1kh8/Y+16EgM8H9A4PVlQ3JhXJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbe509817fso302906d6.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729113191; x=1729717991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z23L9wtsGtKsZfIlNUIwny11qxXtz01O6/8wyvEe30=;
        b=uzNqr8KBoz9yfMw190IloFkNUGT2R7sJ0xU7ULXX9zXci4V0mC5h0Xp2CkGj5m5soV
         ZKJPUH8R0K4mKbuyRtxKRX6e1ERaAcOg5RYK2TqHdGQYU5m4KeeZBToU0Nx8Bmj+pclu
         iRUbCLVk0R4Fi8NmRpwirwD9bHd+lxtV7YDI1Oub1xDQvHoCv0NUQ2S1MpxYJhowuI1g
         bEg1+x5z+ON2kPAl8UDHPog89J1/o6igPNP4X1gFyeDkmB+EY68HZw8dScWFdrCBzCmr
         hwWwLd6k7dqwctaJeNr+DNN6X4l+yh9+CAniFVdML86fiMbr/zqutQ3wjN/4B69gM6XR
         SdVw==
X-Forwarded-Encrypted: i=1; AJvYcCUjDi+hxurKr6sRv7R2/tWFAoR2r5zYsdIgczPsIXYofPjG0IuvdQD0qnjnbQIKILbBI2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rmypBbRh48ozGs+dSs9PjbGoKMUOW+wXEhevvAeqGei9ynPl
	U9cqtwKU68bIhD6kcJdHUXvlvOv9AAgvU18z2kqn8izGqqaB245asXlkqFfLQLiXbSj2q9qC2Od
	ZjqtVdNdj6Gq1r1lPN25sj5GfZD0=
X-Google-Smtp-Source: AGHT+IF+mCIKGG95RNQinaWvhYfxk/itxLs/bJrEHnVrgIGa6lL35Ud0eiJAcKBAEX4i971Ku/U6bIcs6d9q/QPL8LQ=
X-Received: by 2002:a05:6214:29ed:b0:6cb:f5d6:3f9d with SMTP id
 6a1803df08f44-6cc2d90c03emr26602976d6.8.1729113190716; Wed, 16 Oct 2024
 14:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local> <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
 <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
 <CAPig+cQ6=HDD447xTHQ84hmsF3SMbC5nH_PXf3rZWvTWmp18ug@mail.gmail.com> <1dc91aa7-04da-4023-bbd5-5b12539477ba@gmail.com>
In-Reply-To: <1dc91aa7-04da-4023-bbd5-5b12539477ba@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 16 Oct 2024 17:12:59 -0400
Message-ID: <CAPig+cQmGXxDshTovdAYaZn5UMr3nvXHyH0q2HvAbaT_fhhiLQ@mail.gmail.com>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: phillip.wood@dunelm.org.uk
Cc: David Moberg <kaddkaka@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:15=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 15/10/2024 21:01, Eric Sunshine wrote:
> >> Den tis 15 okt. 2024 kl 09:11 skrev Eric Sunshine <sunshine@sunshineco=
.com>:
> >>> This looks like unintentional behavior; probably a bug. It seems to b=
e
> >>> triggered by `git rebase -i` setting GIT_DIR. [...]
> >>>      % git -C dir rev-parse --show-toplevel
> >>>      /.../bar
> >>>      % GIT_DIR=3D../../foo/.git/worktrees/bar \
> >>>          git -C dir rev-parse --show-toplevel
> >>>      /.../bar/dir
> >>>
> >>> The `git rev-parse --show-toplevel` invocation with GIT_DIR set is
> >>> incorrectly returning `/.../bar/dir` rather than `/.../bar`.
>
> I'm about to go off the list until the 29th so I wont be working on it
> soon either but I think the problem is that git sets $GIT_DIR when it is
> run from a linked worktree. I've reproduced the commit message from
> ff5b7913f0a (sequencer, stash: fix running from worktree subdir,
> 2022-01-26) below which I think explains the problem we're seeing here.
> Unfortunately the approach of setting $GIT_WORK_TREE used in that commit
> won't work for exec commands as they may be run in a different worktree.

Maybe. Maybe not. exec'ing a command in a worktree other than the
current worktree may be a "don't do it if it hurts" situation. The
same shortcoming you describe would crop up when exec'ing a command in
a foreign repository from the one in which `git rebase -i` is being
run. If we look at it that way ("don't do it if it hurts"), then
perhaps a documentation update is warranted; something along the lines
[1] which gives explains that GIT_* environment variables should be
cleared by a Git hook if it needs to peek into a foreign repository or
other worktree. It's not a perfectly satisfactory answer, but would at
least (somewhat?) allay your concern about `git rebase -i` setting
GIT_WORK_TREE automatically.

[1]: https://lore.kernel.org/git/pull.1457.git.1673171924727.gitgitgadget@g=
mail.com/

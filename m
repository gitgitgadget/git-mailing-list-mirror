Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EC1DFF0
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755998720; cv=none; b=ZwfPSJzRz//qTsNnNwedwhfYPIkeTjFaxALmbmg90JAD8MHNBWm0dwlhETZMb+3pZ2ZbUWB/1m1j6HBJIsiJk4lGRs94twbtokNvBEXg+BZJneWjrtQwENx17DVDJW28NgDsW5oBkhULSH5aZf6hYnfIylUGMWVnbpfH8wJeRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755998720; c=relaxed/simple;
	bh=MVEaK7bchG9zT3m931iLV2m8W7coGK1Y3E8oiZamuIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpciALuWWESlNullFi/6kV+ZGVhmOmZDM/aMXaNR4gDkKXhNIqEX4+Br200WNvKCnVGv3tZvqH5ElS9JVPo/o6rgheMQJwBfDrFyiOovRmG8W64E2Ffn+HGdKXC5PLhoy1xrgGedWEdt08jt9TQwo/m7u56HH2MzmHzwI/E9zGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Flkm6/Dl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Flkm6/Dl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-770522b34d1so274214b3a.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755998718; x=1756603518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nQU/e3IbYVViDaOMDjRL8FsixkUwubdoDwsvM6Hllc=;
        b=Flkm6/DlmZSYPkLFPXotjxzN+aKzdJR//GJ0IUJOJuOLphCdGOgS9MaAIf0B+NTTtf
         rFrJL1l+qEUD33CexhGHVaFFds7uTEddsUGK6eadZRGOjo1koZw1DF3YnAwInp/LUoCm
         d8QSy2jTwlaKQl/Zq1baORhr62efQ8noUC4O0WrXxOw9q1edwQ95L2S/J71u/C6Xg9Ri
         S3OEhv5qaiOaPrIUCBZqM2+X95dl/W+NFcvEAJyGaCbUPzMdIUAKtTM6W0MWz7xyP/Nw
         2F8KOcihu+34LuOMkouuC15PJGD1AqWi1IoRQzGencOLU7ChnrOrPNm//FgHMK/9Boec
         FYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755998718; x=1756603518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nQU/e3IbYVViDaOMDjRL8FsixkUwubdoDwsvM6Hllc=;
        b=CZfW7ZTt5eJ/mcdcYH4MveZUY+xTN2cdZu09QB5fi9ZZu1CKN6a8rwJsfj3mZ+PHru
         Ht2X6ITMxCrw3MH60GIb7htizSUM2RDLW4HBA4VuADx78ww+luvWqj9xzW/A9jjRuv5W
         oDk/pL6E63z+Z3z95LrZvnW7I9kDUoritCe0xTQPSvTYMeDYFhLnrZW50hsHId2yd7ro
         FbO6S0X2ox7M3BCNVwoSCT97b8qYeXdlwPYb1pZWfYQbIl+pQxbPbUFaChVCJArmiwt4
         W8ZdxoYMdPzJSX3fMxoLzms/ji6EouyRmgWXdpoLWcHoz1qayB9OVHi0nd6UTDYqI0yR
         llow==
X-Gm-Message-State: AOJu0YxhdCZP3EVMpm6hSzxkZDnViq3J90QSlJVegymF7nSCHdftPZAZ
	GhlIS0vM4fvX4D4f+i8SjpLrji8NpZXX1O8PnRtGbi2O4kxiZ4D9jfzUjwcbNO2WkRSVYTJ2A5j
	4CpTQSheOXu4NT3VWNuOiCbq0MkWN6fIDyHM5
X-Gm-Gg: ASbGncvg3JQPTfNZxnV89vHNurJJJ98jZJnLtbIKEW4FZybM8yuqpMHGpDFbXdJ4FTi
	fYefJ8WrUWNeNuSZtHRdlWL4+3TslVxN7ddcoYXlmG4HXghrZVZyvtFsIRmg7J3/ZxA+Dv9hWzE
	2kK3q6qJTJeOZYWCqPF9y1OO6JNiNCN5/scjDSRr8DxgKU7p7Dwp5lfRP3H631eqbsaOKdFkdoZ
	ibYSbo=
X-Google-Smtp-Source: AGHT+IFyAo2t59nt2tyoCPEGs8nV9t56xQJx160whxEj28czxjcLoMt5veUKX8ZUy20gUvufCVgygaQnLtdBSD1isvY=
X-Received: by 2002:a05:6a20:3ca8:b0:240:7ed:4018 with SMTP id
 adf61e73a8af0-24340d8bbb7mr10866992637.15.1755998717928; Sat, 23 Aug 2025
 18:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Sat, 23 Aug 2025 18:25:06 -0700
X-Gm-Features: Ac12FXwdqH02BAVlBbRwKYCLzoAHV3Cg2Y7N6S1-_4HwMuHA-rO13TX2nKSoHT0
Message-ID: <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.
>
> A copule of these features relate to history editing. Most importantly,
> I really dig the following commands:
>
>   - jj-abandon(1) to drop a specific commit from your history.

It also rebases all descendants on top of the parent(s) of the
abandoned commit(s). Branches pointing to the rebased commits are also
repointed. So is the working copy if it points to a rebased commit
(the closest equivalent in Git would be HEAD). Do you plan to make all
the `git history` commands behave that way too?

>
>   - jj-absorb(1) to take some changes and automatically apply them to
>     commits in your history that last modified the respective hunks.
>
>   - jj-split(1) to split a commit into two.
>
>   - jj-new(1) to insert a new commit after or before a specific other
>     commit.
>
> Not all of these commands can be ported directly into Git. jj-new(1) for
> example doesn't really make a ton of sense for us, I'd claim. But some
> of these commands _do_ make sense.
>
> I thus had a look at implementing some of these commands in Git itself,
> where the result is this patch series. Specifically, the following
> commands are introduced by this patch series:
>
>   - `git history drop` to drop a specific commit. This is basically the
>     same as jj-abandon(1).
>
>   - `git history reorder` to reorder a specific commit before or after
>     another commit. This is inspired by jj-new(1).

It seems more similar to `jj rebase -r X -A/-B Y`, which rips X out of
the graph and inserts it after/before Y. Just FYI; I'm not asking for
any changes.

>
>   - `git history split` takes a commit and splits it into two. This is
>     basically the same as jj-split(1).

FYI, the default behavior of `jj split` is to split the commit into
parent and child, but there's also `-A/-B X` to take the selected
changes and insert them after/before X, or `-d X` to put them on top
of X.

>
> If this is something we want to have I think it'd be just a starting
> point. There's other commands that I think are quite common and that
> might make sense to introduce eventually:
>
>   - An equivalent to jj-absorb(1) would be awesome to have.
>
>   - `git history reword` to change only the commit message of a specific
>     commit.

FYI, `jj describe` can also change the commit message of multiple
commits at once (e.g. `jj describe main..@` to edit your current chain
of commits). It concatenates each description with some separators
between in that case so you can update them all at once in your
$EDITOR.

I'm letting you know these things in case it impacts planning for the
CLI arguments.

>
>   - `git history squash` to squash together multiple commits into one.
>
> In the end, I'd like us to learn from what people like about Jujutsu and
> apply those learnings to Git. We won't be able to apply all learnings
> from Jujutsu, as the workflow is quite different there due to the lack
> of the index. But other things we certainly can apply to Git directly.

Perhaps the simplest thing to copy is revsets (which we copied from
Mercurial). See https://jj-vcs.github.io/jj/latest/revsets/. It's not
at all simple to implement, but I think it should be relatively simple
from a UX point of view because it can probably be done in a mostly
backwards compatible way.

>
> Note: This patch series currently builds on the cherry-pick infra.
> As such, when one hits a merge conflict one needs to `git cherry-pick
> --continue`, which is quite suboptimal. I didn't want to overpolish this
> series before getting some feedback, but it is something I'll fix in
> subsequent versions. Furthermore, the command for now bails out in the
> case where there's any merge commits in the history that is being
> rewritten. This is another restriction that can be lifted in the future.
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (11):
>       sequencer: optionally skip printing commit summary
>       sequencer: add option to rewind HEAD after picking commits
>       cache-tree: allow writing in-memory index as tree
>       builtin: add new "history" command
>       builtin/history: implement "drop" subcommand
>       builtin/history: implement "reorder" subcommand
>       add-patch: split out header from "add-interactive.h"
>       add-patch: split out `struct interactive_options`
>       add-patch: remove dependency on "add-interactive" subsystem
>       add-patch: add support for in-memory index patching
>       builtin/history: implement "split" subcommand
>
>  .gitignore                     |   1 +
>  Documentation/git-history.adoc | 159 ++++++++++
>  Documentation/meson.build      |   1 +
>  Makefile                       |   1 +
>  add-interactive.c              | 151 +++------
>  add-interactive.h              |  43 +--
>  add-patch.c                    | 271 ++++++++++++++--
>  add-patch.h                    |  61 ++++
>  builtin.h                      |   1 +
>  builtin/add.c                  |  22 +-
>  builtin/checkout.c             |   7 +-
>  builtin/commit.c               |  16 +-
>  builtin/history.c              | 691 +++++++++++++++++++++++++++++++++++=
++++++
>  builtin/reset.c                |  16 +-
>  builtin/stash.c                |  46 +--
>  cache-tree.c                   |   5 +-
>  cache-tree.h                   |   3 +-
>  commit.h                       |   2 +-
>  git.c                          |   1 +
>  meson.build                    |   1 +
>  sequencer.c                    |  36 ++-
>  sequencer.h                    |   4 +
>  t/meson.build                  |   5 +-
>  t/t3450-history-drop.sh        | 127 ++++++++
>  t/t3451-history-reorder.sh     | 218 +++++++++++++
>  t/t3452-history-split.sh       | 304 ++++++++++++++++++
>  26 files changed, 1947 insertions(+), 246 deletions(-)
>
>
> ---
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> change-id: 20250819-b4-pks-history-builtin-83398f9a05f0
>
>

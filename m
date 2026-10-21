Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792568439;
	b=CnJxbTDpCekDv2rGThmT1e5Lx14wScIPl+NKx/jMzH2lrEQdj0WtVRyOxJFwPFdfUXGz
	 xmdJyUjQwqywrO1QpvOcCrrbBPO1vx2kZvcHqEwIvAXX+0Cu7R88Dzs9H756E4jM6+p9c
	 oJpJGm+CqWlh2/7Xp15S42LYa/8CoixKNlgkgfyzSCFJDeWrQm896l9Vm2fsSDbKCsfvY
	 7Dli8766XcWCMYLNmqXtTsvHvUrf2JzuVL/qwQIzWIYUOXaivmU1PgIbh3Hgj97aaX/jS
	 N+Gc//Tlxl5ssxZPFCRBgaXdpRKwBuGadY6St+A1XrsHZknqBsCXfdFnCyQsNyaXOQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qCKLGwlRJFlYeC5i1qeSb6HP1V14v9NpNT4VP3uaH58=;
	b=z1uTNLSLwx3a0mHnW9TsHs9qVXnRK3MLZBZrS2IRx7jURxpjoos5W9gE0TdILZj0J6lv
	 8wV2fXSCGPobOJ7MuBL/79PW2w1QLVjMJlvve3QB4t2gheKaCZB0Abn3qr54cGmUoOQKx
	 moh4sT6IrzgFiWfwxRZWFYAN5ude/uaniCYChXAzc+kqhoMvNtYy+QNoE0akYRLPbdqWY
	 jaSfkCAHxCj22iVL/augv7C8ZW9u4HPwk9do7JeWuayOnUBh6thecJzwGbDi3EB88qruu
	 8nqMs2OKsWurmbwMRuxNwytpf02at4rj+G++BtnEwb/b2bHz4gnQ5nC1q8Zi2lAyj4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="E/2iWoZI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9E606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E9E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E/2iWoZI
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9178510f3bdso5080436d6.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792568437; cv=none;
        d=google.com; s=arc-20260327;
        b=R7bNcXrETidvxxjuvJMAK8g8vqfZMhOh0oLCYYWKrNII2Q/3oPDcx8OSLHJppk+9zG
         tbdbmxgR+A/V5t/M+Ma8zA8e795caSmIeO8xJVL9EE6TdKmrJvihXkq8Plxv1tCHX0w3
         /YlKaMD6/GSLPtWAe6X4I12ehAE/blV+Hn7EaX9JsJyEcZjCys0lty8RGYbqnp3pWkow
         KbMmCbuGMRqwnfEE1X2QQeknQWdzBPub7Omm9+8XuAJhXWYOFmhsaivg7Cl7TknsEWtD
         iSAiFLSThrLTpCfA3mHMFBo5Qi23T/GwdvWYowIU6kpd/t0naOCdYzp9bWwiNhqeQlEW
         jkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qCKLGwlRJFlYeC5i1qeSb6HP1V14v9NpNT4VP3uaH58=;
        fh=pkj7Lgc+e9u7f9xJrXd+bpYncoiJfMIO1yl1nIjQVcM=;
        b=atkW4nnwwOO3vDqxQnTGgWL9L3j92+tXfjWcpq5FG3/VSdwr60+dure1dvPdbimx2e
         mW9339kna8JcrEESnYQ3oqKf4PaXC1tzXuyFmFJv44o788pFNG0AJfxLI3naT5LG6W1i
         a31g3lp1RLFAHASIuahEbp17/aMLOfG2cpW+Z4QDbd6NTdZKmZjDzVwB5tZ9J8EH7D/z
         adAUA85rYy5OenwCiA1J5qxMjbFEKDNFUf7VsGRGsUCFrZ96PA0onVI2mYs2RfPxIXGM
         oW3GKcOJva4U1acM+1yb5EYpt7ofTFLIpA6Z9MygYv7SKDBJfxgJafgLATGhDzifqfxs
         Fylg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792568437; x=1793173237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qCKLGwlRJFlYeC5i1qeSb6HP1V14v9NpNT4VP3uaH58=;
        b=E/2iWoZITUSWA6MQ956x/8qf13xC10Bo33PtPY/5Bra6m4fab5eC3l9w062dCKRmGG
         4kR/R//j+AOxcscrAYjlWwacNIbC1qBe0VP2dCaWBKlGxBkDUnbgtICldUa2QHywd+xg
         QKilHawhFPvlpG+OstLQ7CD29c8qsrz7WZXTOrxR5IJ/3ktdqrokOru2DYLc39Hripi6
         /t0IbBrvKBCZEP3zl3cRFrpZNnfwMT9RC1YJW3a5vgyz4M4yyYdAsqoj6xuaSjcJfc0c
         a1b1/E6GqZPXZJ37IpKL4mNA4paiNQKv/OaJKZIPh/40XWusWSVXvYqUyr5aRyRKmK86
         vLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568437; x=1793173237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCKLGwlRJFlYeC5i1qeSb6HP1V14v9NpNT4VP3uaH58=;
        b=Y1hrIaDIlt8R057DV6xAbSYblWmNbAxRNhdYkvDkG/NLb/zWQnS6rJhoUwXQFnsz7E
         09jNPeQnp8Ol1MP7kYo0ZJrdvaZuPOl2UgAoU2I1cB3sw7t1lik9SsB5NNVMSOFQizPp
         6AdBuu9OKJUwHstxwJqlsfB3jHsXlG4dlFW0RMRKIoo1ynf8kxNqVr59/nqQ9y+YqTDI
         wuErrJ+aAb7I/BXbfD0np2xBNl+YaPY6h1luXhY2qkDtFGnYHFMESz223lqBlYhBLp8P
         ZKq0QUjKqwgZLY+Fsdyggy6ou76ZRuZ57SK8iyAmQV+GtWJfm4ojVTSjYgpEcce++yER
         l97A==
X-Forwarded-Encrypted: i=1; AKwUvBzieKeENbBgqXvYNtclhwWZe+OGbMW9H0P4LeceHEX7FmhC8gUX6rmEvcG8C2RXVwxF+Yc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwOU62VBpmaTyzb09jMefJ5Ot/WEq965qU1zaieobkqBJcCuA2
	HkRNDX+i5hxtV/6TrpGrSmKfQsKpgQ6Np/FgO/3P9/W/uUSIOZqANYZ+t7x/0be231Ol10Ekak6
	1YZTmeQssz3bFWMub4DBmGZFGycStTRw=
X-Gm-Gg: AYBFou3Af7i6z23nVgROQei9bNjeNVWkBLvxHiBaQo5gL3S9DETaFZz2FEtyxiJhdtb
	qQzZ4aiQiT3wfN/e7nwDeW+19D1RzRuPG3aJcgD4yiwE9UfloU4ytTGdWk4skw+MY7BAkEivI7M
	s0NNaGefaTSxDnYC2X4J8eNLqtAaiqtZ+oan2T6Qg2LQ9rO/EkLlxcS0toOWjw2FyOiIBM/lKKS
	0JrhtFQGtPk2s8dPy5y4uugTc3q2HR9a4D+OeHyfh0wpTaKEQBDOVRZauIOaivYfsmiR4lOJPf9
	6DvH/idOznxg9U/yLaDKb3j0RaAuQYgRGqi78i9yzfYwDIH+H9bBJhsz8e1MHYSRw1KWt3gIkfx
	9NLilZcF07Znq+YfxbD924wOUoDUd2GTE8Ye3EI02q7jg/Ta1leVepQtVt8ktj5PAIl00WBeodn
	gC8A/UcemB5QPb
X-Received: by 2002:ad4:4ee5:0:b0:915:eb2c:50d0 with SMTP id
 6a1803df08f44-91c12ee2afamr21837906d6.27.1792568437352; Wed, 21 Oct 2026
 00:40:37 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com> <6e2acdc5e2578da4e915fd2ac541a776349fb23e.1792512249.git.gitgitgadget@gmail.com>
 <CAPig+cRsSN9gY405MGsCQzLuxzBKcfHo2Oc8Z4WB-U3BGd6m_Q@mail.gmail.com>
In-Reply-To: <CAPig+cRsSN9gY405MGsCQzLuxzBKcfHo2Oc8Z4WB-U3BGd6m_Q@mail.gmail.com>
From: Jason Newton <nevion@gmail.com>
Date: Wed, 21 Oct 2026 00:40:08 -0700
X-Gm-Features: AclHuK817-ezTvSxv9PjqBHiA-VCCD-TJ8rd6r3MuXrq9S8bFV70dLY6BcBnC9o
Message-ID: <CAGou9MgdF_xA+e8YYn8ud8TUSmY3j_q9jbUTy2wLibTz1ObJ7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: reap ephemeral branches created by
 "worktree add"
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

--detach and an ephemeral branch differ while the worktree exists.

--detach leaves HEAD with no branch, so status, push, rename,
upstream, and symbolic-ref have nothing to name. An ephemeral
branch is a normal refs/heads/ ref for the life of the worktree.
Commits go on it, and another ref can point at them before
"worktree remove" deletes that branch.

Deleting the branch that "worktree add <path>" creates today
would change the default, so this has to be opt-in. That opt-in
is not --detach: the worktree stays on a branch until removal.

These worktrees might be minutes or they might go on for months;
either way they should be easy to use and not require flags to assist
 in the majority of common case behaviors, moreover detached feels
ike a degraded halfway state, frequently allowing a gotcha to strike or
 a loss of a safety like a gc based reap.

"git worktree remove" does not delete whatever branch a worktree
has checked out. It deletes a branch only when this "git worktree
add" created it by DWIM (the final component of <path>) and recorded
that in worktrees/<id>/owned-branch.

A branch named with -b/-B, a branch that already existed, and a
detached HEAD are not owned and are not removed. A worktree created
by an older Git has no marker, so removing it still leaves its
branch in place.

"Unconditional" in the commit means that this one owned branch is
deleted even if it has unmerged commits. --keep-branch turns that
off. "git branch <name> <tip>" before removal keeps the commits on
an ordinary branch; only the owned ref is deleted.

The call that changes is "git worktree add <path>" with no branch,
followed by "git worktree remove". A caller who wants that branch
to outlive the worktree already has a spelling this series does not
touch: "git worktree add -b <name> <path>", or "git worktree add
<path> <existing>". --detach still creates no branch, so it is not
the same state while the worktree exists.

Ownership is written only when the worktree is created, so I'll confirm
an older worktree still has no marker after an upgrade.  The branch stays.
Upgrading does not mark a worktree you already have so no upgrade
headaches are expected.

-Jason


On Tue, Oct 20, 2026 at 11:52=E2=80=AFPM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Tue, Oct 20, 2026 at 12:09=E2=80=AFPM Jason Newton via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When "git worktree add <path>" is given no branch to check out, it
> > auto-creates one named after the path. Such a branch exists only to bac=
k
> > the new worktree, yet it outlives it: removing the worktree leaves the
> > branch behind, so a fleet of throwaway worktrees fills refs/heads/ with
> > dead branches that have to be cleaned up by hand.
> >
> > Treat an auto-created branch as owned by the worktree. Record it in the
> > worktree's administrative directory (worktrees/<id>/owned-branch) at
> > creation time -- the one moment we can know for certain the branch is
> > worktree-private, since we are the one that created it. "git worktree
> > remove" then deletes the owned branch once the worktree is gone and it
> > is no longer checked out.
> >
> > Ownership is recorded only when "worktree add" itself creates the branc=
h
> > via DWIM auto-naming; a branch named explicitly with -b/-B, or one that
> > already existed, is never owned and never reaped. Deletion is
> > unconditional (even for unmerged commits) because an ephemeral branch i=
s
> > disposable by contract: to keep the work, pass --keep-branch, or anchor
> > the commits with an ordinary branch beforehand -- a normal branch can
> > point at the same commits, after which reaping the ephemeral ref loses
> > nothing. "git branch -m" updates the marker so ownership follows a
> > rename, and the branch stays ephemeral.
> >
> > The marker is just another per-worktree administrative file, so older
> > versions of Git simply ignore it (they keep the branch on removal, as
> > today).
> >
> > Signed-off-by: Jason Newton <nevion@gmail.com>
>
> Sorry, I may be missing something obvious, but this message never
> explains why we should add all this additional complexity for a
> use-case already directly supported by `git worktree add -d <path>`.
> Specifically, worktree's --detach option is exactly what you want when
> creating throwaway worktrees, even "fleets" of them (using terminology
> from this apparently fully or partially LLM-generated message). If
> your tooling or agent is not using -d/--detach for throwaway
> worktrees, then the problem is fixable by modifying the tooling or by
> teaching the agent about --detach, without bulking up the git-worktree
> implementation unnecessarily.
>
> Moreover, a change like this which makes the new behavior
> unconditional is certainly going to break existing tooling and
> workflows, thus it will not go over well, even with the --keep-branch
> escape-hatch. At minimum, to be acceptable, assuming such new
> functionality is even desirable, to avoid breaking existing setups, it
> would have to be opt-in, not opt-out (via --keep-branch). But if it's
> going to be opt-in, then you may as well just use --detach to achieve
> the same effect.

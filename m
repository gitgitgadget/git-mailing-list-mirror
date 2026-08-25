Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A53AD528
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682259; cv=pass; b=XXKvzelNcESiVZisQZXxSsJEL4ieE7CWTgiB9Mau48Vw5DjgUXXSq3aC/MeX2gDIcnh/bPTfv1TfSCLBQIFLPWuehxqXrSBZEvL+AHv+4jLqLUdwlfV1FoduTkdjem0l27QXFe+jqzY0ty4ztW41KF6Loar6LAQyKZdUiz4pHFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682259; c=relaxed/simple;
	bh=GIXeewSIHXiKU+p5e3S6Xm5QuhD7vET0xQrCCMMaiMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtwlFgzg5q4z9lUnmsyDa/jjfatI0LibhSHvTyZkiPN9CrdCiZiWDdB6nWIUkeJawLJIcWrHCT2w4lOd0E9NrveVA74OsBZpvEiS7m4jrJ6EMAGteuQa2wRnX/qczl3Igmokzw7opF7ZnYBV78PZ+wkQg7mfLHt65nLmA7Kpe2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ/RDC7Z; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ/RDC7Z"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso1888673a12.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682255; cv=none;
        d=google.com; s=arc-20260327;
        b=SqOrA5M5rswHpx2lzFkFyl7h+skYefb8hT6utXHX5AfcsDzm691R4dAMBLoRaJwWFl
         cZIjup3smKVHgl8foM8db/Oak8PgDx2bJS8SdMlbhtPE1tmNnGLh6ZGFP+1Butrv9Zcb
         0Ga85jQg4nu/IC+bkxaEJs/qDmN2Eb9HC9UROYyyvd3a73fsHbuB8KiRafHOQgPGLFez
         MjJWZwoF2iEuOz6kOHrJME5TybkDhAhdyIDwagia6zOnCJOF80nCDhHOIXd2p9n6LpY8
         ESqzXhacgzrcR0PDDyRbk510IQG8lam0QU4fEbdI2KDtzHSRs8ecp4ykypklud7N+HtL
         WPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D1UZh0txlSoesqZwfMnB9Bf+qNpqBeoH+LF01nwQBNI=;
        fh=saHboaJJhj8Pw0TXdT6VIkd9OXSgYbFjJUVr/Zg92hM=;
        b=PQOm3Jp7mD0FBp5N4Pi7PEiCDPQqlKWHSs09ODOtXF8TciqK9OatyPpzQhCn6Kwz5L
         +8xGPdfkjfAAbp7cKrFL5d83TKiLhfc2R7Mre7cp7wI+SkIJfsicS7PryyY81d3UkVf6
         G7QC3TZE8Zgzvk5iDGSrNoVnhWq0rK4BZotLGCtzoKjRbFgI/1ag1MV12+pkLJ/XbnKp
         PLvI6969F0eUoHo4c73/vFO7y34pu0Z3icRuK3fAblD5sPaJ9U15C93VMmLNKc5qVeDc
         7AK2OtCQfFe/HxbdO0rWpaOC6LRIzddcIiIQsw2dvrnEisOCVPl9tkzENNynD3/0ftu1
         fnCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682255; x=1788287055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1UZh0txlSoesqZwfMnB9Bf+qNpqBeoH+LF01nwQBNI=;
        b=mZ/RDC7ZTqucZG5VzD/XXZjTi8cMpiy9jZtcYRl/aQ5Qu+8gFKKALFKCZI//R9keB4
         MjZpkRC+xoo7WqmdxlscvKTRTQQFLE842EPjnweIXGtJdI9DFkP/v+Uuer7S5Ecob6rN
         /jscKS3RkWKEAAU4+2/GNc44EmQkC+m/J82Xwt0zUXNO0DmJGZXANBRP9KrqZ4PI7O+v
         TxkwomhUOAeDgIJpx9oHYoxDnlk/y+TgIVibM/j1nVdlMPeyad4ASwEjSKMFjEj6PJzM
         w/88sn8si8Xhto6F95FCg6CKsX41/R/OWH41nHF53/te0/7wPrkHiXtlXaynqKjRMiJA
         N71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682255; x=1788287055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D1UZh0txlSoesqZwfMnB9Bf+qNpqBeoH+LF01nwQBNI=;
        b=tEURdcucVD9jjf4jhSRgZmPR6+a/LXz6bse5M8lZN/PRTj2UZIjEQwu9OL3dHHEenQ
         olqIH3BiXd3XaYZfDvuUYe6mSH0r+IJlxXua8zK808Onw3rxgINM9u5+zRSz+Q/t6yRf
         ceyE6wt7ySmKtdvHsSqtA9J+xdSlXUrSYxpAg2KzyoHBu2hRgJOsLD4c6SbC4TPvExvQ
         dnqra2wV+gDPFKKnL9PfZB8a9kMakaXO0q55AUaHYvjfI/rvnaFDybPZgdVPRQ9qW6kZ
         ajdjvNk+tPLkY11vZd6eKipPtwrMu9Y8Jc4hTjMMVxXpQFfLRKYqWtPVI8W8DYCZMFu1
         3xdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0qUEXpSF2lRgQak3druIDGW0KZPKMuwuzAZttbF6Qqcc155GkjTyMBTt1/mBudoBvN+M=@vger.kernel.org
X-Gm-Message-State: AFuF++mgobL/J74urYw90iHpiK0Sp5656g4sXYOO+DHVr4HmoX7GcZw9
	Wgxj9PGJ8lWKoKnR+WRlY+g7CkY/nC/LpIoMS8OoNzDiOl5EC6hehU2mhOL0OZ1PNxytW1UIyOW
	CyqYsWb5YEtjmnbeeJmsEvUctVao03wk=
X-Gm-Gg: AR+sD10D5cqyQFtzD9MRbv84xXnI2xYzihAiu10OlEsnsdBDHN4guP/80NGJfldP1ZR
	7w+tuLAnLCX00wFnFjfW3H3JkiI6tPT0DJazNofyrq/wQJ0Z9OwhrnVNCCP8D3w+7L9CLUB2+eJ
	pmWrBs2KQ7Rf860UEJF9IGyvthY/JS0DTY7pchFq8ral/oDmkqHTjdQa9vltc36OuQzAsN3Lu2J
	MfWUMalxwyc8uXezjRWPTV6ipTWoW4wU6i7U0XgtA9lkqEw759EUIp3ae36XbqJvfoqdtM87zRS
	HFnoqz1hFnrhncjoKnSsWNSRDko0LtdBrn6BxB9H7vpBdeg=
X-Received: by 2002:a17:906:6a11:b0:c24:d6f0:aa0 with SMTP id
 a640c23a62f3a-c250acf343emr111282566b.11.1787682255274; Tue, 25 Aug 2026
 11:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
 <91feddb6-0d1b-42af-9942-307b98aa747d@gmail.com> <xmqqfr03sgyu.fsf@gitster.g>
 <e3e7d23c-ad66-42de-b959-f9f2fae8d16b@gmail.com> <xmqqecfmm76c.fsf@gitster.g>
In-Reply-To: <xmqqecfmm76c.fsf@gitster.g>
From: Vladimir Sitnikov <sitnikov.vladimir@gmail.com>
Date: Tue, 25 Aug 2026 21:24:03 +0300
X-Gm-Features: AcwNN1W5Bc9LI0pC2_TnoP4Ox5vdZxC30FApWXBiQ_H4h4nQNxjtZgdHTV1FIcs
Message-ID: <CAB=Je-GVyfrP=3kW6hRh8aVnzkKg_6yKZW2LCV=Z1XB=T7KxFg@mail.gmail.com>
Subject: Re: [RFC] stash: let the stash stack live in a configurable ref
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"

Kristoffer Haugsbakk writes:

> To my uninformed, not-using-agents mind, what agents do with the tool
> seems like the least concerning thing. They can be non-deterministically
> instructed to not use the stash.
[...]
> And for determinism you can give them a git(1) wrapper that bans
> git-stash(1).

A wrapper that bans git-stash(1) misses it, because a command that never
mentions the stash still writes to refs/stash:

    git rebase topic --autostash
    Created autostash: 637ca99
    Applying autostash resulted in conflicts.
    Your changes are safe in the stash.
    You can run "git stash pop" or "git stash drop" at any time.

The entry sits in refs/stash afterwards, where every worktree sees it.
rebase.autoStash lives in the shared .git/config, so one worktree can
turn this on for all of them, and the flag then never appears in any
command line to ban.

Having a stash subcommand and forbidding it to execute is fishy.
Agents might miss the instructions and they might still attempt calling stash.

Your point about the bar for a configuration option is well taken, and
so is the one about the framing.  The single confused session justifies
the option on its own; the agents changed how often it happens, not
whether it is worth fixing.

Phillip Wood writes:

> When I'm not trying to move changes between branches I associate a stash
> with the branch that's checked out when it is created, not the worktree
> where that the branch happens to be checked out.  We already record the
> branch name when creating the stash so perhaps we should add an option
> to pop the last stash that was created on the current branch.

That covers more of my case than I expected.  Git refuses to check the
same branch out in two worktrees, so a per-branch filter separates every
worktree that sits on a branch, and the entries stay visible to
`git stash list`, which a private ref gives up.

The gap is a detached HEAD:

    git checkout --detach
    echo v2 >f && git stash push -m "my own text"
    git stash list
    stash@{0}: On (no branch): my own text

Every detached worktree records the same "(no branch)", so a per-branch
filter groups them together rather than separating them.  That is not a
corner case for the tools I have in mind: one repository here has 436
linked worktrees, 23 of them on a detached HEAD, because a worktree
created to look at someone else's commit has no branch to be on.

> If an agent really needs a private stash it can use "git stash create"
> and record the oid of the stash under "refs/worktree/".

That is what I do today, and it works.  It is also what every tool has
to reimplement, and the ones that skip it produce the failure I opened
with.

The two ideas may well be one knob.  If the scope of the stack were
configurable (the shared ref, the current branch, or a per-worktree
ref), then "pop what this branch stashed" and "pop what this worktree
stashed" become two values rather than two features, and a detached
worktree can choose the one that still separates it.

I am happy to write the patch for whichever direction you prefer, or to
test yours.

Thanks,
Vladimir Sitnikov

Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11543A7016
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807602; cv=none; b=prvE4hry/qYptFzlUjVmpfgmrkX2NeBwCR+4TeLGdLpR0qyKwMVPo2mDpzb0W6QwQIKADiDaPJdv20BT9yBQr+D80UTS4FAhPtMCBPpJhDupaf6jwYUpXYjBehZ5OGHB/BM9x/XQrwII+NGoJYXgz2cJCTJLDY9ZglRDt+ooKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807602; c=relaxed/simple;
	bh=yQsgxfV3s5f5SBujFwuSLrIEN2xoCMs77pJkEjJYah4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRuoiYTXhvraZ1ESMaAAWqinp0I4pUcvKPkBN3PUR44cq1mki5UVZvweqbb2iIuhBFH2C3/TNY45dLmKtK7Fdfx6e8W3zehdPcrDK3aiHZchElKDTQqce1ItSyxFl2MfHerv0wcASEiTjSIIg0gMCQ7xGF1DfWzG3TTf7gJ/5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVDhS5Z1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVDhS5Z1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34ccb7ad166so1550881a91.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 09:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767807600; x=1768412400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ3F6cWbijHZXbor3lN5Y6omVZfc2ErvWPaMBqfCYkk=;
        b=aVDhS5Z1e8GkszG0yrdpdnQh2lBpyFk35Axx6dWqBT4TTc98/PSHB6o8U6PblM3mI8
         XPy0vu3hyIDiLjkqDZS6N05sP/Q0lHNaPUel+gd6PgXCq1sauFJkRJQPoY9xqV170NuI
         NbqXyVdgN0ic2xQHAP02Vb1oZrJhbFm8LaIa8tniZFVFKLBYVBk4HHw+9KjD+EuGoyMh
         Fwv1mxpWIG+UQzONr3b/Xgv1+KWJJCBzIvwlt1unZGCJgVBSyG1UI0KZQfYPokW/rn+1
         vxcHT5783BXosNzNJ0n/CGVoZ42Q/7JVW/KY+xykvcmwiLt6j2z2Hk1NzSC75QTXLJ8x
         KCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807600; x=1768412400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZ3F6cWbijHZXbor3lN5Y6omVZfc2ErvWPaMBqfCYkk=;
        b=KHNxjYeU6ZmBX+Hbi+KfIvFGsk4SY/OUTlh5KAG9B7GWRKrNPHlhjQN04VoJ0iMcC5
         PITD0jIl4Iqnpaafgl3FdAJDk/sJC60WZkPcRfXrTb7bBve6MBxkmjWP1xC+aRghEdWg
         FdZFoJlnuiZcw+gnCXNW6T5MiPL5a4B+M1BlxjK3yGqf4p5FPCk5QIs0SEbrmdQUZgz/
         7UwvAJN8xzd1UrNykThqnqsXCQX4iUOsz3Tc8coUbelxoAuhy4LRteLJy3X1pedtXSEf
         mxgCjBsaGLvD45xrfZSJf7vNwoZgYhPKLX9YFXpfHuxuSjZw8QF8tyJEgtL9GvwbCTjd
         adFw==
X-Gm-Message-State: AOJu0YxPwuriNmegb0kuMzSJnPWYN2uh2vVKgLGrVJGdA2AG4roaIO8J
	lSGii836EKNlVRzW/zA8COavLNjxlBRyBaVITy30ooqvo8pMCMrzGqkcAViypvUp9gLBcSGrXiK
	eZbp1EcKfraN86QZF8pyxjz0Hb2jMWUw=
X-Gm-Gg: AY/fxX4YR8q5+f22EOIG1kma8HI3d0VbLQyu7MchrX56O/3nhQvkP0j7RdjT54IaC5N
	2IRXq4I2RDDnJnUhlEpw/ZmqCJy2MMqP7SnO9OlktVFHr2YImK78f5yTGC3TY3gMPNLhTn+fhjE
	ufVHeeMg2Mnk3a8GiLbtkr/ehu2xVhVckH33jjR2vyoESvMqVPc4nH2WaGN4slf5nxeTuSIZKXN
	d3dq0LZdkU6cmzkaa6MQTyEWN1CC7jtkgkj4cGgbcIHonse8al+M9FFiKGasH+1V7w34BT6QL5a
	+e1FvvLYbybDPZbAB5ewrKblJBf0yA==
X-Google-Smtp-Source: AGHT+IE6dYcEWlepG3NzyvJAqa5YAleppVzdBWTONRwYCxruteqYrYzhfOkU9DOboBVJ5B3lJ0DTxnl520AlWvYBzOs=
X-Received: by 2002:a17:90b:2883:b0:341:6164:c27d with SMTP id
 98e67ed59e1d1-34f68b4c5d3mr2583619a91.3.1767807599719; Wed, 07 Jan 2026
 09:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Jan 2026 12:39:47 -0500
X-Gm-Features: AQt7F2qrO26crh9-O0RueKvG9269CdG145qqiC5r3gCsK0uvB5RX24oaeahELO0
Message-ID: <CALnO6CDhDFtz5WY2pd8as5nH-URxzfNUfkouQ2Cf6USuRRTrKw@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Introduce git-history(1) command for easy history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 5:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.

> - I've dropped the patches introducing `git history split` and will
>   send this as a follow-up patch series once this once has been
>   merged. This was done to focus attention on the underlying mechanics
>   as much as possible (and to keep my own sanity with the frequent
>   revamps).

Sane, if sad for my custom build which has enjoyed having "git history" com=
mands
available :) I can wait for other patches, or try to contribute some, thoug=
h.

[reads further]

Oh, it's just split that drops; we still have reword, etc. Cool!

> Range-diff versus v7:
>
>  -:  ---------- >  1:  53a845e874 builtin/replay: extract core logic to r=
eplay revisions
>  -:  ---------- >  2:  3ff1c0bacf builtin/replay: move core logic into "l=
ibgit.a"
>  -:  ---------- >  3:  598df4e186 replay: small set of cleanups
>  -:  ---------- >  4:  fd6a0ec5b8 replay: yield the object ID of the fina=
l rewritten commit
>  1:  0e2d8db69f =3D  5:  04b832320f wt-status: provide function to expose=
 status for trees
>  2:  087c563575 <  -:  ---------- replay: extract logic to pick commits
>  3:  4ab2a6f807 <  -:  ---------- replay: stop using `the_repository`
>  4:  d2138e95d4 !  6:  e223659b86 builtin: add new "history" command
>     @@ Commit message
>
>          While these operations are all doable, it often feels needlessly=
 kludgey
>          to do so by doing an interactive rebase, using the editor to say=
 what
>     -    one wants, and then perform the actions. Furthermore, some opera=
tions
>     -    like splitting up a commit into two are way more involved than t=
hat and
>     +    one wants, and then perform the actions. Also, some operations l=
ike
>     +    splitting up a commit into two are way more involved than that a=
nd
>          require a whole series of commands.
>
>     -    Add a new "history" command to plug this gap. This command will =
have
>     +    Another problem that rebases have is that dependent branches are=
 not
>     +    being updated. The use of stacked branches has grown quite commo=
n with

"[D]ependent branches are not being updated" reads weirdly to me.
"Rebases also do not update dependent branches" perhaps?

>     +    competiting version control systems like Jujutsu though, so it c=
learly

"competing" ;)

>     +    is a need that users have. While rebases _can_ serve this use ca=
se if
>     +    one always works on the latest stacked branch, it is somewhat aw=
kward
>     +    and very easy to get wrong.
>     +
>     +    Add a new "history" command to plug these gaps. This command wil=
l have
>          several different subcommands to imperatively rewrite history fo=
r common
>     -    use cases like the above. Some of these subcommands will be impl=
emented
>     -    in subsequent commits.
>     +    use cases like the above.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>     @@ Documentation/git-history.adoc (new)
>      +
>      +NAME
>      +----
>     -+git-history - EXPERIMENTAL: Rewrite history of the current branch
>     ++git-history - EXPERIMENTAL: Rewrite history
>      +
>      +SYNOPSIS
>      +--------
>     @@ Documentation/git-history.adoc (new)
[snip]
>     ++If you want to reapply a range of commits onto a different base, or=
 interactive
>     ++rebases if you want to edit a range of commits.

Hm? This feels incomplete to me.

Best,
Ben

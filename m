Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882302;
	b=eGKeOYmGTtaOU5OpRHrIjFBWNtg1GigxwK8dUKlZsVQKVZGAxgAHuy6pNXVf9Dm3qy3I
	 KxlCJNvE6aFGB1FOr6r8nN+f52esXlbtbX8+dtmO7z1OitSNjEiib6wCMd3ff1ehnxJZu
	 jjk7X/PXeW7Rw0ZmMGo8JpaeJv5OQyNJt+6e96gySZaMwuYpVW6jYvILdAwHhtHK8qX1c
	 yswfgYfbP3A52wROswiw+8NG+MpQjzsnp6N4T+JRtfKP7JmYl2H++vyCoDrTD8uD4WEYZ
	 p9DOTlZt5mkfIC54RhoEgLdfpJmmIX2D1dC2JpTb5uoun2CuwTeEiilwJWGRrACyhiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:From:In-Reply-To:Cc:
	 Date:Message-Id:References:To:X-Mailer;
	bh=+kBvJsOby6sGUBq0FELD3CzKInFnBdrt5Xfqj1VXRnk=;
	b=VoOp2E8+7XHHqHnM078XrtgqN37cYKU1M3hUAU1BYEn+7LoKSmFiSYXbLsee+SzzH1vb
	 uGYMpRHdFv07KRjuyHweweGgSPNLhiXimIXeXzMFbA5hWM5jlgXIOaPGMT5gB5FADf4A6
	 eT2tZD2XMnnJW/X6gVTisnGf6WsjjK9kM77DQP9DOqZjfyerjKN7i7evw46lkjGkQ9AVi
	 tDjmOcSjItUr7/5n7C2hYvwcUF0QNAyGLTxv3cpCXZc3f9/cRuKAN/4AtamP/2CBPef0F
	 TwqQoodH/TX15Tc4rOTNj/lVT0Fx4iF5pWHsBNbmKC3xjMXJUEKBEtKgdCjrR3GsWNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6AWBdj3;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D19606A339
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46D19606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6AWBdj3
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso540227137.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793882301; x=1794487101; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+kBvJsOby6sGUBq0FELD3CzKInFnBdrt5Xfqj1VXRnk=;
        b=c6AWBdj3oqVYuxhRqMgGqVoHCw+KQl1H/mE7zcdv51n+D2QPBdb/LTTUXUlcjcpXzd
         QRiKAq9US68asC2ItAZ30muRITJzIQ0SEREQ2um6EYWeLdAQQ/xFkw5ccVyXLl+DBgUE
         E4sb5xze2j4np91FULXOMDaEzEGWrkua4i7J06w7saoa+RB+yZ7TMYON4cKxZvI88HXx
         3YK7+CXygDXoJMfnZIKfFs6h+cDD057IybLLJkoeAxqw+VYkh0mnQFTItWR+MotdesUv
         NhzqYlmPo2JMfwPm+bIZnrcwAuxfHnwaViXliio1eeP6PXqil17422RofQy1aP7wf8eT
         RL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882301; x=1794487101;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kBvJsOby6sGUBq0FELD3CzKInFnBdrt5Xfqj1VXRnk=;
        b=hJstCx1qGsOvrOlk2GsPnsjqiZCc/dW7S6K6rTUSjGt9yNszcXao4PqdGkMfGyjglC
         n0csUyQeJq6zApAq7CPcTvkoOlpCJ3Mlg4Cd3OqrlC3Pnjts9OnpwD0WZQEFK04zfeT5
         XXbKOU5UFiWowQ5U7T+iHpDIVfj/sKaVjFusyV4x4iCo4XTOQQcB3xw3L9oVdVoGQbNC
         DbSsCV6Q/WvW5eDO38o/pDFWVs/k6XJyJe5BTF12SaljHXtsJ4G6ZM3mg6szTJ2ZHACY
         L0DehKKKT5v/j+5jF6wFgRjTFj8G9bSncOxjJaOYa3wQ2vvN7kWaNi4r5ozc7hWmTGd8
         HUug==
X-Gm-Message-State: APuU4Z+8o1wMRZeNotCR9rpmAXJkcx6yAgx9oHnP3Y51Yo0uvGBHkNxl
	zc0BEMSsF0rbwf59zjQVRFMx+iAKtk6M6fxFo+bE+WFvYA40caWjIyiI
X-Gm-Gg: AYBFou32HEQQReQo4f0kG481kjSApHcl6AsuZ5twA0WrbY4fZZ1mh+pcIuzrJT2+z/Y
	SQj9bs62gq4vbDPYUalJMzMWyrsOyUj8RQ3yAlJ66rAwtvSkAYQvVEzFjGwtumsJ1iBxzFQhDiW
	UqVdkics+Wxr5kelxYsydbFFOF7cIrxawZomRA45mtpoL3wvnATqiSKfzvKBanBddYtlBYCcEW4
	SA4qFS1OOskFDvQlakjsQpDCxOjjE6qd//vqggQnMLBpKgTwM9Mrv4jA9swH47zCcKju/tjABpm
	+HHKNtxoD0Zv2QOaVkUg3gQxAGkGgOieYmz6+8asbqil4xOf+262ebyiYWYCYAc6u0kYPWI9uT0
	hRBzqYIY/M1JAFHgl19Ypf1UBSE3IU9DMReVarwkIcu/hV5t85XynK7Y1GhQpV/iUGGbYHIiTzD
	IOdCOu8kLB6BMiG1vwmwX6SjR7DwbdqhWQEYDYC6G4qcdvAQa/k6oRSl9nZkppEBt6kQOXNweIZ
	pe5/74i4DiUQwRw9ZIgp1j7pbGaXz42pZz/dDe/H0q6qpiZia7Cy+CzZzS80s1rHra2JRqEgmYy
	n18eAFYihHh/Zqb91rxW4K9sscWKHs/XUloC15kGeIQB5i7WWloPkw==
X-Received: by 2002:a05:6102:370e:b0:7d0:57e3:d495 with SMTP id ada2fe7eead31-7d07223f476mr7829153137.3.1793882301093;
        Thu, 05 Nov 2026 04:38:21 -0800 (PST)
Received: from smtpclient.apple ([204.48.95.75])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fdaf4efsm3808102137.5.2026.11.05.04.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 04:38:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH/RFC 1/5] replay: support replaying 2-parent merges
From: Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <034ab0f83822e6db67baa423d9fcb753b12b5ac8.1778107405.git.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 phillip.wood123@gmail.com
Date: Thu, 5 Nov 2026 07:38:08 -0500
Message-Id: <0107772D-4F64-4F24-9E68-C6709AF264EA@gmail.com>
References: <034ab0f83822e6db67baa423d9fcb753b12b5ac8.1778107405.git.gitgitgadget@gmail.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (22C152)

Hi Dscho,

> Le 4 nov. 2026 =C3=A0 21:19, Johannes Schindelin via GitGitGadget <gitgitg=
adget@gmail.com> a =C3=A9crit :
> =EF=BB=BFFrom: Johannes Schindelin <johannes.schindelin@gmx.de>

=E2=80=948<=E2=80=94

> ---
> builtin/history.c         |  16 ++-
> replay.c                  | 209 ++++++++++++++++++++++++++++++++++++--
> t/t3451-history-reword.sh |  21 ++--
> t/t3452-history-split.sh  |   6 +-
> t/t3650-replay-basics.sh  |  46 ++++++++-
> 5 files changed, 269 insertions(+), 29 deletions(-)
>=20
> diff --git a/replay.c b/replay.c
> index f96f1f6551..3dbce095f9 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -1,6 +1,7 @@
> #define USE_THE_REPOSITORY_VARIABLE
>=20
=E2=80=948<=E2=80=94

> +/*
> + * Replay a 2-parent merge commit by composing three calls into merge-ort=
:
> + *
> + *   R =3D recursive merge of pickme's two original parents (auto-remerge=
 of
> + *       the original merge, accepting any conflicts)
> + *   N =3D recursive merge of the (possibly rewritten) parents
> + *   O =3D pickme's tree (the user's actual merge, including any manual
> + *       resolutions)
> + *
> + * The picked tree comes from a non-recursive merge using R as the base,
> + * O as side1 and N as side2. `git diff R O` is morally `git show
> + * --remerge-diff $oldmerge`, so this layers the user's original manual
> + * resolution on top of the freshly auto-merged rewritten parents (see
> + * `replay-design-notes.txt` on the `replay` branch of newren/git).

Maybe we would want to add these design notes as a technical document when t=
his series is out of RFC ? This way we refer to our own documentation.=20

=E2=80=948<=E2=80=94

> @@ -407,17 +550,63 @@ int replay_revisions(struct rev_info *revs,
>    merge_opt.show_rename_progress =3D 0;
>    last_commit =3D onto;
>    replayed_commits =3D kh_init_oid_map();
> +
> +    /*
> +     * Seed the rewritten-commit map with each negative-side ("BOTTOM")
> +     * cmdline entry pointing at `onto`. This matters for merge replay:
> +     * a 2-parent merge whose first parent is the boundary (e.g. the
> +     * commit being reworded) must replay onto the rewritten boundary,
> +     * yet pick_merge_commit uses a self fallback so the second parent
> +     * (a side branch outside the rewrite range) is preserved as-is.
> +     * Pre-seeding the boundary disambiguates the two: in the map ->
> +     * rewritten, missing -> kept as-is.
> +     *
> +     * Only do this for the pick path; revert mode chains reverts
> +     * through last_commit and a pre-seeded boundary would short-circuit
> +     * that chain.
> +     */
> +    if (mode =3D=3D REPLAY_MODE_PICK) {
> +        for (size_t i =3D 0; i < revs->cmdline.nr; i++) {
> +            struct rev_cmdline_entry *e =3D &revs->cmdline.rev[i];
> +            struct commit *boundary;
> +            khint_t pos;
> +            int hr;
> +
> +            if (!(e->flags & BOTTOM))
> +                continue;
> +            boundary =3D lookup_commit_reference_gently(revs->repo,
> +                                  &e->item->oid, 1);
> +            if (!boundary)
> +                continue;
> +            pos =3D kh_put_oid_map(replayed_commits,
> +                         boundary->object.oid, &hr);
> +            if (hr !=3D 0)
> +                kh_value(replayed_commits, pos) =3D onto;
> +        }
> +    }
> +

I understand the intent here, we seed the replayed commit map with onto for t=
he negative revisions, so that a merge with its first parent at the boundary=
 gets its first parent rewritten to onto, but keeps its second parent.  But I=
 think a further tweak is necessary.=20

I tried the following:=20
- amend the first parent of a merge M (manually, in detached HEAD), changing=
 only the commit message=20
- try to replay the merge. Since none of the trees have changed, and the mer=
ge-base hasn=E2=80=99t changed, I expect replay to succeed and keep manually=
 resolutions from M. I ran this:

git replay --onto HEAD M^!

and because with this syntax M^2 is a negative revision, it gets mapped to o=
nto, whereas from what I understand it should _not_ be mapped and should be l=
eft untouched by replay: the new merge should have M^2 as second parent.=20

Since the second parent gets mapped to onto, the merge-base of the replayed m=
erge is changed, so the fast past is skipped,  the new merge conflicts and t=
he replay fails.=20

Also, I think this pre-seeding should be mentionned in the commit message.=20=


Thank you for working on this,and Elijah for prototyping it.  It=E2=80=99s a=
lready is a massive time saver for me.=20

Philippe.=20


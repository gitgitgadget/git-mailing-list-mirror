Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514848CD77
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808941; cv=pass; b=atb+xoayq+dS1jHWxjNnyTr8jFYkYin/IW8kqqn6LsHwoOLZ/jkVbDHFjr9PN7YOfyc3uFTSIp7/37ORC5Oo2pTS5WsYm4EC0IrWdzannMrmz2ffkhxynBX3tX0R3UAqrhoP8g8cH/ITt/jfBCbfUVV/5x6vIIwXuKqZJ/Du3KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808941; c=relaxed/simple;
	bh=KnJr4O1snjFiJa4MIxoYvURVTcF3ZlErtfvGBrM5xxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fcusl1jBMwGID9WwyTC7E4mIMXkm9w+9bhTF8KLwbysztk+WPrU8GCS1hi5OC3Qa8fM0iNBs2LXIIKNhJhWY6l21T/enQHcgNSCR+s0Wk5YOF6opeha6M00xfwjo9a8vTuB+S06I5xqeXKIA4uj1iWOaCJeTjg6l66pu88tHrDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqbdFwTQ; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqbdFwTQ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so2462699a12.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 05:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791808938; cv=none;
        d=google.com; s=arc-20260327;
        b=SsftZOJt38ZR8Wu4N2DWIDLa+I/2scxuAiupxmZ/n8JBs4qv16hffxfk0Oe44SkrvZ
         8cnxoJMt4kzL2gLWJVeBxJOJZgWzee9mGKtYQN37/PC4t2ktrOy19J2nWKcyHWn0hL2W
         X247ulpa7hRG/T/bOa1riv+sJT6QlJtAbqQVa8jy5r6C5A+/pwNhvnfJr9c9PYzC+FKP
         7MZf29KA9Nn7Ojq3PpOTdG3UmRNP6cJV2QtELNd0uf7ChUvdPaj65EWMJSWM0RuVk0cO
         NEZYbUjGVq88Z6OwLcP2/zuZM7P2mNQI6bjXbYQHu11lgBoV7VczLx6zsoRAgjbUCvF+
         RtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cwAUg6DS5U2JZ1ljt9+MwuRG2vu+RJ52Ziw4F3yJjDU=;
        fh=6mfQT7mgPrz60OV+tptJLOoa/eP4HSgWjSQSbT8BwEQ=;
        b=Sdn9EJmvjP9Ioelj61yG1iP1FbvVeIaDUcXCXeEPuFoaFCSN0HvID5c95o41UijUiQ
         UQDdDuLbxDyq0IDA6w4Ip91Xj4+bVEEJYfuaDvIE8NdpWZfFEWqGjZc5jpkefDd0GwYC
         hXlSPGZOt1RnUEJAc1uGekBjADGqvDPseoY3peEMJ2KTvi2M1Jktcw0urtDJyyDAf7Mo
         o0Bo3z/VRjbhTmdQh+CYY84NYk/tpa/jFIaSGegYfqNl91AGMW1gSW+CrCbq8zeZC6IG
         1EWS5pOPaLb5MY/WleftE4vUHLQ+2Q42fEa9oHOf0AqMgVGEBP+MkB/u86nPNFLbpZdv
         7eEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791808938; x=1792413738; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cwAUg6DS5U2JZ1ljt9+MwuRG2vu+RJ52Ziw4F3yJjDU=;
        b=QqbdFwTQ13EscIAPAjyjKECKTuuiwyEEVRQaN4ZffT3EH4tx1kJz7qWDlKveVRp40/
         7Qhn6vB6ivpchcWdxX0L2YIstjzS7z2GgPZzvPID5lwvBxyyucZ9/7/wgQf9HTX2wZ4J
         wJw0+tP9hxcuEsAZNt18/7XsRnuo/vEZeAutAgq9aKywyM7VInq7B7O/RgDP0D+9dcEO
         sZSTRPBPQ753GkcjgHFdIsbLygJTWYned1dURaLS/sONUKbD772AXqjDdaNL4F6Y8EFL
         +X0sud1Ta7tbYQjsf6ZkfG3OAWKfgstlX796/2N+e5cckjFcs2Q0TQcroflERYBwTQD1
         vWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791808938; x=1792413738;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cwAUg6DS5U2JZ1ljt9+MwuRG2vu+RJ52Ziw4F3yJjDU=;
        b=LLrAe5uMc8xFJW2u9rnYumnnaYzEpyBEZLZt2PXCe+E+2DRd0DOCqpUX2GwnLM0Ylb
         cDuwKjk+YjWCczVQ0Yiz1XVXswcIlgcZkpLiu8NqRZP02rCkJKgUJdDH5TBySdijKVnN
         027fNt3btqeXP8BuBG04pmpIqbeN0ha+Gvo//KRJyDsUgL14rRXY6gcmHfKW62VF81KZ
         +i5UfLfiyhY++F9UR4vmSZeidcqJxtQZC0BSTkVZzc2qXX7+uFv1RpwJjDoHAlPw93y0
         zZM3+JZxJuM4sDPp48fvoPJZDqRdvWW4EgA7iwmiTIiZjBJC6J1+SJbkdPwXq6CsszsR
         qo5w==
X-Forwarded-Encrypted: i=1; AKwUvBytwwoLQjIUWrQi8OE4tZ5c/tS4vjX9TO6NhmTHnCLY05kpt0ILpaPLk+2mNBai9cmL+Fk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLE61p378qMW/Etk4HBDP6A7SACbvyjSMukdJCqscQZfaLcF0Ia
	sRk0B4czUU386gs1sft14xP3OKWTTNJqI0cbL9QP0fpaJHDDW/LiCTzbKuZmQTzFap2GoBjuoWJ
	bIDP+nz1fGVdpjaTU6GSlX5GKiI31FM0=
X-Gm-Gg: AYBFou1u85W7GAeuRBLioeljabUkiIaLYXpWHT+Y7ZIfaa9L/ZKpysj944J6t/J4wwq
	vnELUEFlaHrvuglih3lNVO9ek/3+SteQbV6w7cho5ldRBKM5tTISgpRGqGzJuNRUhYluVnYaKYA
	qrBFAsrIsDAJWtgH8KuTYEfHH55ss4EEEnvYNoVFzsOQrZQ4QKXtWFqTPz43OEPN5K2dXxbLu5f
	qF2BOXE0B+o/MTtZaRaEM9xBDuab8ORCdjiFlSZGhJrkp9g8KlwrPtXlEffYYfp0vaC/c6fhqbv
	xsiLiPXdUr37UgQYnp/U+WzyTt91iMMQ9/pH6K9B2VIjAVgCShjWtjs=
X-Received: by 2002:a05:6402:27cc:b0:6b1:c327:a9d3 with SMTP id
 4fb4d7f45d1cf-6b1c327b823mr2275823a12.38.1791808938306; Mon, 12 Oct 2026
 05:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com> <xmqq1p9vdalz.fsf@gitster.g>
In-Reply-To: <xmqq1p9vdalz.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 12 Oct 2026 14:41:40 +0200
X-Gm-Features: AclHuK8HjovcTHYFibMCfIjGqdbV6aEjpZp4Eq07qdmMAZGa5eCpDc9U-7AMepI
Message-ID: <CAHwyqnV=SBMwTzC74YN7585u_pd525E=tRArL_5z_uLb-FGnhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> After rebasing, you probably can (re)use the same algorithm as used
> in range-diff to match the commits and their rewritten counterparts,
> but I wonder how "squash" would go.  Presumably you can locally make
> a trial squash merge and probe for a similar commit on the upstream
> commit.
>
> On the other hand, unlike deliberate rebasing done during a patch
> iteration, rebase done on the upstream to integrate your changes
> would not rewrite the log messages, so matching the commits based on
> the log message may work better than a range-diff between iteration
> vN and v(N+1) in the submitted patches.

Matching on commit messages sounds very brittle to me (GitHub mangles
them on squash), and also unnecessary when we can compare the files
themselves.

> > Harald Nordgren (2):
> >   branch: let --delete-merged find squash merged branches
> >   branch: add --no-squashed to skip the squash search
>
> This a bit unexpected two-patch organization; I would have expected
> that the cases where our side and upstream side should correspond
> one-to-one (i.e., what you call rebase-and-merge) and other cases
> (i.e., squash merge) to require very different matching algorithm,
> which would lead to two-patch organization where one adds support
> for rebase and the other adds support for squash.

Finding squashes is a superset of finding rebase merges. Although
slower, which is why we need to be able to turn it off. So yes, then
we need separate the code paths for squash and merge finding.

Then I'm thinking 3 commits:

    branch: let --delete-merged find rebase merged branches
    branch: let --delete-merged find squash merged branches
    branch: add --no-squashed to skip the squash merge check


Harald

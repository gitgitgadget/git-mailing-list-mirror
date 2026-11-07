Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794082009;
	b=d3aF+qhftZoGUWVBxYC4IR7VVLLgpacOwfDM7uVFwTyVVgF3JSlHCQYOIN1RFYdqA2eO
	 z9PLbSGI9BrQfBjhbWfVx7hiOukkTPbDur9PYrTLtUymVLbK6ru+Co6nmVqNn8lnH9uyU
	 u25HFjIQ9uvWY75PN+rHMxz7kEc+6VJPSNUj6GuVnLEfnGRMK4M6ACzer5EH+RvlTf6Dq
	 cqBQqI8nyG/vnhebbBOFtMKgx0+b6Qv1z8kqaxi/5qtMEUO3q5h9QR4mG6HS/dF5dX3yV
	 8pbSM3ZVUOB2oYHePsQYyzHMPAqlB6lAYaGSUMDMjSCtWEGkgbcLRFgwCN2ERhX2qmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TROauFANLf+EoJAqtvIR6iSnZvm4gWc3PCBgAvhqFzE=;
	b=Q7dK63FVqUXIvzVcvc1bnTwEj8lEZJ+Jd/E03Ab8xFRFcXNxfg4ZVM3xcvZj2r5nucws
	 ZUiWaSUEi/kxrrf3jrsl7QqVQvds7yQJWSor74k39aTVvmWoKK25U6OCFS2DHxhpzqcvF
	 gEs0WS1bkeQDY6a7JgrdolCvDB0S051zA722k6fu/O7gSrfRz2aSWGdDnmawy/zDqFJWU
	 M15xJFxT/S5tX24vf6UGGAYx/GkG9qSu62CJkUeHb+XmdCWbS1uRr8gxTC52nPglLY2dW
	 2gmx7FKW9K3mzWL+AdTLqNAN4IwXwAG8cYbcAB4Cz/WpPlbHzOjkb40+ePflF5MKHEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cSMEjDy2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F080606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 20:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F080606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cSMEjDy2
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so297680a91.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 12:06:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794082008; cv=none;
        d=google.com; s=arc-20260327;
        b=lOTMP5rJvUYYhZ+ALpsvZHFSNUdvq0lVtpFqic4hHhGvKTHGnKJhWvjq+k5Es52Aw8
         cCKFJcxg/wo9MoNXQurBB28Dxc8npQ5uZ3SHvhCbk7R5KM07Trrx+7feiQpNsDwZqRVR
         dwjlXBbG1DllO1ayKkpIWfKR/aYxLrjKcPjhN9LMR2RA4wYMauao7UF3ghx+LAGDilaK
         0AjJ8rYE0ddTkxST0F4z9o6be9Ae76pBn+oRUlQA0LD3nCdV+MGYRR3HTbZ7L7CBfDk2
         3yYi2JIZO32rVdjaG7wBioYMn+ybaugrfC84h4//4Jw2wb7K6DvLh5o/6LigM33scHrG
         aijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TROauFANLf+EoJAqtvIR6iSnZvm4gWc3PCBgAvhqFzE=;
        fh=dPNcj+0nrTHlkmGYqYmi1rHDDBuzLl06MwvrYw52fXw=;
        b=LN+h+07AWH5HAmOfSEDVGfeC/1jF0wfAGAytj3QHE3BRjLLIkNvPfbW74AwT1Fg7jG
         G5jW0k05Z/n9DMhpRqWp9v4y/XRAkbIfxfqcBfQeaqjG23OSHiv0M8Nt9t9Wr7d6h8/n
         +HQi9RxPpD+5vkYseV8hygBTdmCNUadwbjBkOMO50/vgYm1+n24XbpmPf4/XXlvqsj/R
         xuaValVLLP8DRGJiNBmwI2Yh3hTL+g8HJDzzGq7MV5tosbnnKWW+MZRwLJm5BGTkc4dp
         PPOgEiUwZn2E4H8LPXqHKOr1ZzoBhe9G3fyvTLQiLxXhhZedx/FZurlgaG9r7eqL/opR
         6K5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794082008; x=1794686808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TROauFANLf+EoJAqtvIR6iSnZvm4gWc3PCBgAvhqFzE=;
        b=cSMEjDy2IBNZfUHKJSDmwOo8O29wFCu2nnruhQfAVZsz0Mkpw3vlKZxSzHKdlX4dJf
         SzYFiN9YXK+I6K8cGv5MVSdxW2bLi5bvvQdUasHCCLPFblo3clifhCsOq7QbPV8S/QK3
         +v9qRbwiOfdmlso0Ljyi4LcDQMYMIm5S6LNt8iEJ8OrV68+ZEr/1p36IspReKaIcQQ2V
         gbtlL4g1WXHMFjy4Cx0DE/5Ah1Zgxuh2V9OEDuiL6i0FKU72beIrYCHr324oUGIFgb9O
         SOZip8L/9wXj+78JPp1lKr9yrAh7pYheTl123MwDbbqc+awi6wjRupRxC8J6lUAlZbJ5
         3C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794082008; x=1794686808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TROauFANLf+EoJAqtvIR6iSnZvm4gWc3PCBgAvhqFzE=;
        b=LxVPzL7Ej+WqudwBWRMcREH5hF7e0mOPCuxfzToXqt8krjZOOX0GfGpZR9wNgLTbIN
         GczFjIi6eVgrJLMpntDXWpidr2w/MoR4wEethzl9pZ5aMTzNIRGRrserXCFOYyWueREx
         Ycl1Y2nZ4DuhQl4X95NqaW2zIbopwC+8F3kxXhnN2eKkugIdo1rdU6BEpvGW+kKrbaEB
         n79Ws5LS/lgSStRdAmjld8J3/zx+lpwo70SQX9zigxJysO+33z1uVXM7tQ+HKuUnROnW
         h8Lpz0TKmJUcYY3SkyCMSqXm/ChhWV5wDm0i9AunrNIhvKymYQaPMj4mkTeDqcBVJqDK
         ZdcQ==
X-Forwarded-Encrypted: i=1; AL+hErH0l2IzXU/yGCQmUrfVesxgh6AtmS7FxwjU6a1wFPTbPGodVuShcT1bQjDXO9Fefud3TaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+SuaWjQjkLcq8s2addCltSJOOC66g7iQOeR5K02genr6VcD5m
	3ecsXObo5/vCmjvSBG7Vamg3PNMP6UohmSFCALtH/kem1z1/Dnswqa6tgI4pPXtsXt5DjI2kNmx
	6o6bfxX7033JyYMaCWCIBE35uw+lmalw=
X-Gm-Gg: AYBFou32xHCMUixRqs1yV68mjBJGHNL/p+9h9sLvnp3u9k1p2DhfKnt7G8aGwyE1YMC
	F6IZgiAy/7UC11wSR1C+U6UpZtRKqK4dV8gBr0R6XZJybBXtcVmw8HYf9z708Omvb5yVUmgmZc1
	vPtgk8x95xx9D08ND7BzRyhfPCO2KPi/ANNzysnOKm2sYvHOhfvxoZVdJLALq908A5VJJe16uWT
	4zgU0QjHs8JT7k+CJHczn7PDjMqtrheKjfNo5GPzkEamMjco1qFp45gZCRgPnvho3GF0Qx65P5B
	uBsJMzVcFuEuDCsBRS6SoZdyNG7AOiF/KQGOxCh9ImNY+vfA96ZJha4+Qmmw7br5c6TJPrY8zu6
	8fHYhDaXyPe+4tMjj+4OUNMfPaChBmPREMN79H6Z/6iX6nP1QaQDOHY4S+IF8Gk0LkSefXhSyxo
	qDJ8WQzhw0o6F+dwWJ78RiCrFpfgkgSATjB3nQcXDQbFNo3S5nE5jlvYSiltb0BLKrgVwFy8HKv
	DFljoS9dPOkXF0oVStWOvTh5tsHcMH3OoPU
X-Received: by 2002:a17:90b:4f48:b0:3a4:cf85:aef with SMTP id
 98e67ed59e1d1-3b1069c1b36mr2135942a91.25.1794082008017; Sat, 07 Nov 2026
 12:06:48 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com> <xmqqh5ile4h4.fsf@gitster.g>
In-Reply-To: <xmqqh5ile4h4.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 7 Nov 2026 15:06:36 -0500
X-Gm-Features: AclHuK8pI0q4A6rWvR_eXlqKdlAJmJuKO_8WCfvwdgZujnQdIiq57WHyVhawN1Y
Message-ID: <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I've read through this thread a few times, and I'm still interested in
seeing the detached HEAD manual land. It seems like the following need
to happen?

1. We are waiting on a reroll from Julia with the SQUASH??? commit or
something like it applied
(https://lore.kernel.org/git/xmqqse25cni7.fsf@gitster.g/)
2. The discussion about how to describe HEAD needs resolved.

On Fri, Oct 16, 2026 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Just to leave a record, so that we have better chance remembering
> the suggested improved text, here are what I think the first two
> paragraphs should be replaced with.
>
>     HEAD records the state from which your current changes started.
>     This can be a branch (the "current branch"), or it be a commit,
>     (in which case HEAD is "detached").
>
>     In the detached HEAD state, you can safely build, run, and
>     experiment with any historical version of your codebase, without
>     having to worry about clobbering your branches, and you do not
>     have to clutter your repository with temporary branches.

Here's what Junio suggested^, and here's what v4 has

+`HEAD` is where Git stores your current branch or commit. `HEAD` can eithe=
r be:
+
+1. A branch, which is your current branch.
+2. A commit ID, when you don't have a current branch.
+   This is called "detached HEAD state".
+
+It can sometimes be useful for `HEAD` to be a commit ID, because
+it lets you easily check out an old version of your project. For
+example, a data scientist could use this to run an old version of a
+data pipeline or a programmer could use this to figure out when a bug
+was introduced.

I do not personally think it's worth focusing on "the state from which
your current changes started" (even leaving aside the "what if I have
no changes?" moment), in part because I don't think that's how most
users conceive of HEAD. Other than that detail, I think the first
paragraphs of each option coincide.

There are some quotes which use the "it's the parent of the next
commit" mental model, though, so we could include a comment on that?
It might be distracting, and could make its way into some kind of
admonition/aside if need be?

The second paragraphs differ a bit, with Junio's containing some bits
about clobbering extant branches and not needing temporary branches. I
think we could work something in there, like

    It can sometimes be useful for `HEAD` to be a commit ID,
    because it lets you easily check out an old version of your
    project. For example, a data scientist could use this to run
    an old version of a data pipeline or a programmer could use
    this to figure out when a bug was introduced. By detaching
    `HEAD`, you don't need to worry about clobbering an existing
    branch or creating a temporary branch.

? I suppose we could also be more explicit ("build, run, and
experiment"), if we wanted, but this is a good example to start from.

> Having said all that, the changes between v3 and v4 look OK to me,
> so let me update the previous copy I have with this version.

Otherwise, we're approaching a finish here?

--=20
D. Ben Knoble

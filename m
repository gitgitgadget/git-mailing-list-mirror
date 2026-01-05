Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976C236A8B
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650140; cv=none; b=HgmoHx12Evs7U/kXRyIqtwWsCl8onzcxbkMehIWEPMVx1oZU6mlZPpW7t7xnNTHc/RcgxZeV1HGhUTy1MgABRmcpXwGkqNdSnZDS50AVjajFOJthLjYkzJZs3f++A4W0C/4tBU0Bv6pZpYab8F2dVGWYp7CkHrmbZVcYAUONwKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650140; c=relaxed/simple;
	bh=0d8qAk8f3olkxeKgaxRBT06y4ijCEfh8nsrAyODXUBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EseC1Y924HX9DvmfRQVvSOiONvUk3tiUefOhJdSsHv3kXtfU1ShoOzGUsbTkXMT+quy8w9eEzWuz4WMiZS2g61t6tEfM0XfBxZKkOQLgHvjwaOmb1rVfx6NUG30+6x/OqTMWHqABD6r/C5Q6cXoHfnOceFJveDn5VsiG7CVQEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X78v58bB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X78v58bB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so393251a91.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767650139; x=1768254939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d8qAk8f3olkxeKgaxRBT06y4ijCEfh8nsrAyODXUBo=;
        b=X78v58bB0E6gKg/EUEWOtEG1Jcjp8jrWwVF6jgqUtNJ80Bl03gswMgHIbAoijdKhtz
         +muoPXMZFzulfDh/P7Ov9GkiyoF36lMtXpgh/aUEZ/wL+H65+KpcLaYq5+mGh95Qu/B2
         nql+ad0imxYaPPf0MDNkfoFBVbEHjxaOGH9eVVjYZDaCTZzuunwkPWEq5XKwp5BMSP2k
         Zu/fB+4W3yUGtysjKq8CCmNTw4OOrQqZe2chCJKg7e9+mTRdn5p3gIy9CrY3dM99QHkb
         eoddzhXKU35MZM+Nm7dKOH4Mx/KJdJYqaxZyRNlhjWBpaUQxwg7Jw90l97p14vaD4aeq
         Jr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650139; x=1768254939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0d8qAk8f3olkxeKgaxRBT06y4ijCEfh8nsrAyODXUBo=;
        b=Eap6L5fEpZ5yhtu4De4q2IExh7OzT+Hayuep8HHwkAcE4v0cTcaqzlQDSDt2iLd3aX
         i5gwhPNVjlsREHUxxjKXH7qhb8XXqSmxo10LlxRpExv/D1Mg3Q4Wn1DCDtpHl/Erjy/Q
         Mh+VgTC/JrepSZO9cjgxtQJYSdcVO2lZfVYvuuukFmvFiIldoH9YoSvtsOvMFtmJE/j9
         Lvkcgq+wI04AI0BIfQZGWPieDa2nBXPzS62QBzdrfvqWCOEIdnI3S6CX8z7tl3kRCao4
         p6E5N56VNjS5L3RuY9HmsqCTktAv+GoTxGNkO5mD4I+MsmXVvZG62yoBEq5YYrF6P8Vs
         HzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwiJYMEQUYCAYpYN8yHxg/mtUG7P//Ke9ppqAe1/0lY20TXDcPO6/mkoxRc5Hae9PSv/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/xMC/RQtl/7/02j7Uvnl6MYc9O3s7yLEk/cdw27SunI2YEJV
	rsaqCAobfH+5z12pdWygh2NAXla3qoFUwgVexfNXdXgtI7NShsdn7Mi4RPladXIxgHxY+aMQiHR
	cMx3W9Fbbu3k4uGh68ZhjdM0Ms2cSqoE=
X-Gm-Gg: AY/fxX4SRPigLqMNnt03CWqnhCZ4uPKixwmDpVM2zIXOBaqBDx/0gbCTdtWITs+9Ino
	O7EDz4YEuUMvLxigcKGw9RjAWUMNdqDSbcWHLJTTs7Uwx46culSK6yKBaLqdukYTkngFntMf1v3
	0WWXmKpuBo/4484uvifybSAefD9xju6YNwsAO4xz3wjquBMEMDsziDjw2ijSwwRKhWYpLkiRiyU
	w0hu51P2UT0FoqkvwRo+4l2MLP1pz4h3BBXb+yywtYrPRydISW/VUDA1DkKKh9US40hZy1wdYrp
	YyIf96w=
X-Google-Smtp-Source: AGHT+IGqSXPAQ3ATloYf4rQLgt85WuJ5ygD9MlXijk9G7gQa0UsBwr3XH5H0AR3/+GyJXnLEs9ArBsRRX7asC4tXC7c=
X-Received: by 2002:a17:90b:3908:b0:34c:fbf0:fa55 with SMTP id
 98e67ed59e1d1-34f5f2f6929mr510371a91.21.1767650138686; Mon, 05 Jan 2026
 13:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqh5t5c4lj.fsf@gitster.g> <20260101233839.17639-1-haraldnordgren@gmail.com>
In-Reply-To: <20260101233839.17639-1-haraldnordgren@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 5 Jan 2026 16:55:26 -0500
X-Gm-Features: AQt7F2phm_E9O7Mdeasi7Vi8pQw41TU9ohAF3tHtE1DjQAJFyta6KPmR7m6IzJ0
Message-ID: <CALnO6CCw-LiFa6kx7C6xRyZOTr_AkAzWQz4UZasT=kWX=-vSXQ@mail.gmail.com>
Subject: Re: Another look?
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 6:38=E2=80=AFPM Harald Nordgren <haraldnordgren@gmai=
l.com> wrote:
>
> > Again this seems to do a "step 1 goes in a direction, step 2 fixes
> > its mistake, step 3 changes course" drunken-man's walk.
> >
> > The same advice to restructure them into a logical incremental
> > progression that moves the codebase in one consistent direction to
> > eventually reach the goal at the end applies.
>
> Isn't programming always bit of drunken-man's walk?
>
> I'm very hesitant to restructure my history before I am confident I will
> not need any of the old work later -- I would hate to lose history if I
> make a mistake.
>
> One option is to keep my code backed up on a separate branch locally, but

Git will already do this, more or less! See "git reflog". No need to worry =
:)

I don't fear-driven development to lead to optimal results ;)

> As a side-note: In my day job we only allow "squash and merge" on our
> GitHub. This gives devs the flexibility to treat their branches as a WIP
> area before merging, but still gives a pristine git history after merge.
> This feels to me like a good trade-offs. But again, happy to take
> instructions on how to do better.

I think others have covered this, but you can both "branch is WIP" and
"clean history" by iterating within a PR. The GitHub UI does not make
this particularly nice [1], but my recipe is essentially

1. Make changes
2. Post range-diff [2] and force-push

[1]: https://benknoble.github.io/blog/2025/03/17/more-range-diff/
[2]: https://benknoble.github.io/blog/2024/10/04/copy-range-diff/

--=20
D. Ben Knoble

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792673314;
	b=WeISuNUQS8yo7QUx7cmuVUQyS3F3PjUWfYZ9S3vrbTtoYtOKh0E30fWU4tATkYJ+JVNw
	 6umxl2TDPm3QG0Dc6X0l9Sh7Ny7r8ioqRNkXe+wfLD8x/dqjhArMdtesD3bylPOxjePBO
	 shVlHg+0ERkL9SiBtlEGh66SJkzhhP5bcVaiaYaEYWtY2wXVnF3U+d9DdIZ8XDdSbblch
	 oEO0n3LiM+VRZT7WczXc5dr3com1tPz/hfVbf/jVpYUopUk7nyGqj64hyMBIxrc+qA3RL
	 dFWFGl7Xm9tnB956IEgNUaYzObTgUE1EKEV58LJtnzOgUXePbURZJn/7THco1+5hH+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=03JjpGkD3aas2Uyg2Pc6B1U7hA4KgjSs9ZqIg4XIgWk=;
	b=tX34w2j06RYRFJKpYsSNIML/FWjqGF7frEc8o9MgDN7YZROEHwjktv3+YcyA9UVt8Rj6
	 WTuvGZH6hzBLqprcNijeLLhdpRZYs4qwP3el/FWBiBPpO2SazCre52mH+wM7pN9/CH5cI
	 je60FbFT+Akac9AfDSd4cEhvcMD54DdUIpW7xTq74ZPZnmF/0viQRnpI2Edv0YzPowK2E
	 J+SXdfTdbZtr5BQhyzCwyHgLFa8p5sbqpIkMNfrP6Lp+0i6SCgNmCewsC35x5R/3zZYnG
	 9gMN1I+vXmE2VJ49VL5xMNg6sUMMrlyGkxq7qIkkXw142krwbj9ry3lemYnNVPgYTTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhSxhdb4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC09606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC09606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhSxhdb4
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9f6a16aedso10595665ad.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673314; cv=none;
        d=google.com; s=arc-20260327;
        b=gmqo8N/0pyo5PZnYUIu2lbANHQ4nOtoRPT6vNoF6QnZuR8v87y7ydbJ+2rzpGIgf10
         D4q5sqzF6IkHgAgd4QhQQvMN/QLutNe7nFNTP/XB69ikI30WDnJAq0Q39eEWqTQeiZN4
         SXCAXC5SNmDZWcn6YVPZGGQ3BDBes9GbmY1qhSf6PXs1YOQ/nP1tZQx6HU3soeUNRs4s
         9Ikg+DniJOJrsHzmQV+rGQJFrVRsFt5iSpVrmBUFLaJaCGbbMKx9a53bOjgsj5K8ClZ6
         qJ1MbbIvmEo8jegkCJMb9XcN9hKNMxNLtBGbOom8M0Wmn65bS9EzPBI3zIxAQzbdUY1W
         aB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03JjpGkD3aas2Uyg2Pc6B1U7hA4KgjSs9ZqIg4XIgWk=;
        fh=C8x1jbBNU+DKOqoqrXxOAn87PXmNIVITM0I9/YsGSr4=;
        b=ljBDu2Vu0DL7jRXrSNb8CrTpAZ18Rsue/dLjW9Y3SoX6vOFW28eBNYa3LDZRB23uCU
         1HhuWwdllUkiJ+b3QDIwrptOjcJLDQBCkFGqU1nJNzRzEwbgL5XRXYb+QTSek9ahxQGd
         ykzPJHDH/BZ9QnYrcAB09SDZGOiIVhM4gfWF/sOpEL1aKvBe0diAESGVs8axerPZOvwh
         +LvIc8xY5y6loKSbb2el5H//kauHSjHenAfnyr/Vjd53f+MjynhuPUG97sC8n36yqR3T
         uqryd8t3SR5AZAdsayNS6ipKFCaDRjXSM57RKja2y0m7ElBSXE/VdDWx//OOZ8mPHted
         Cssg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792673314; x=1793278114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03JjpGkD3aas2Uyg2Pc6B1U7hA4KgjSs9ZqIg4XIgWk=;
        b=qhSxhdb4YB/cic3f1kGFLWJDFCpBILVjl3CV0lmm7g78VyYHPf24lNfWo49/5Xl3kP
         wGnGCxzFRMpV9NZpA8ca4thqpM9zj8Z7V8CfjRU/nMka162trFyK4vsFrnxqoaKbbEKF
         QTWFdWO48f82o9elQRI1y84joqd/FsFZS90A7wWw1pxo8vu0fXWLfqbt+KItW8i42ghg
         sdXS004hnfWdZP1EwZZGTY8vaqMLmCPWDfTjEsw4ncoyeN5ZRuoKVZzNi417MyJz9VvY
         vp93SdrrVtilxkXkW1UMzEr8MbK32gCQnDdL7euCMckGOEes5R7eLMHny/gaH5d10deg
         hO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673314; x=1793278114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03JjpGkD3aas2Uyg2Pc6B1U7hA4KgjSs9ZqIg4XIgWk=;
        b=BA+hbx8EbB7/MwrZRiXolfiky2igP8GwAJqbi/aGcj5KtE6WaEqIJ2yKIbkpGQf4Ig
         BmQWuCM9FBPrzmspOBIXxs7bZve00AVtsL5QvH0ZB6vBs+85AekYGABcipn5bLInUfIi
         yy+qCInL66XnNgusmTNaRCz4OjmRuTII42rp0TtXqi2Qjinn+Wl5gc3feNG/j/8E7+NH
         Yu0AHi3ajAA079s8amALSd2+6MU2sn6aerlhJRXvO1YL/uJRuX7OhXogV3CdyK35fJFu
         4E3SfsuFrlEaVe9CHkC0yC21ZN14YwOcM+1eCHGBEFhdUS2VaRXjY7hQ2dwiiAfYclIg
         3XuQ==
X-Gm-Message-State: AFq9FYJGWOmje/+iUUsZhN+sX7SATJnrJVLEr5Qab0qMspXoc+ZJqPIz
	gs4o/WW0G2uWgdgiwMgIzGJ0IfaCGXIrZxK1ZWlRdeDx+dxtu4ugirm86D10Z9o3WzmOSg3mkxo
	wNVXEbGL2UmfnL5qpHV05GFveU1HAwOoPKw==
X-Gm-Gg: AYBFou3nCo5snqfbYrg+rwq1BJxwrbde7BNM3zZRgq5qwwBUhfDTQWS19IJrYqYJSp7
	ESS++PvRB1IPGCg3VMCALBTd0tspw4VMtuEUoMpoGO2D3YEcg+sj/zuxWIsQjoYo0nkogsNu6bv
	x4UkpeSzhBT1SZQI5SkvAza2YZn3aepJZcuFjVOHJwFRqWfYWdxxHX12m7VDjrL9MEp7SjCz4XC
	f9AbGxNT21lljOzXlgu3u1tf7yK1j7XBC0VlJ5JW4oP+pXMRFG0tTiTcFj1AOa912okAL+Vx6bt
	HQ4calJasVu7YajjVwCLrY4cR/XOeqvUZnyImtJdC8oZZq3Arcc7+9zABpvPUigEZulEkCRboxN
	U993Q9G4Xgx/8Jkjiz6oa7OXOY0XkfEcHxj3mA4Zmf+JeGmMBFRqWDIqINCWWl51mP2UEeWc7Yb
	aZIOrnzDp4lfzVRc+5sDnK4EMkMqhYMcpIQyBwxvvTBtVQNQDr0rLiv881DHZZThItQA==
X-Received: by 2002:a17:903:182:b0:2e8:21ee:f196 with SMTP id
 d9443c01a7336-2ea43e259bcmr44923665ad.29.1792673313713; Thu, 22 Oct 2026
 05:48:33 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
 <CALnO6CCFfd3VcZkFGmc6kYHqEwsafa7UbOg-6cN0jEfsipQm5Q@mail.gmail.com> <CAP8tz2+CQcQyTdj3YFpEaiVh=hVoK5Xo8WFxGZNMJoCCM-u=hQ@mail.gmail.com>
In-Reply-To: <CAP8tz2+CQcQyTdj3YFpEaiVh=hVoK5Xo8WFxGZNMJoCCM-u=hQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 22 Oct 2026 08:48:19 -0400
X-Gm-Features: AclHuK-PXnKLFzEdLI2QvSjcVwcfCa8iUZ8nnH0VoloWgrqnLMOLo0VHqadOSm0
Message-ID: <CALnO6CB=tmTrNKcWOanb79Bm9gPT5H_dntNGRJGp6iEYHe_aBg@mail.gmail.com>
Subject: Re: switch/checkout stops halfway when it fails to write tracking config
To: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 11:09=E2=80=AFAM =E4=BA=95=E4=B8=8A=E5=8F=B8 <inoue=
.tsukasa.4@gmail.com> wrote:
>
> > I can see where create_branch() is called prior to setting up HEAD,
> > but I'm mildly confused about the index/wt updates prior to either! It
> > seems to me that should be one of the last steps, hm. Unfortunately,
> > I'm having a hard time finding the responsible code outside of the
> > "merge" case (which probably has a similar issue).
>
>
> - merge_working_tree() updates the worktree and the index. It is called
>   from switch_branches() on every branch switch, not only with -m,
>   because do_merge starts at 1.

Ah, thanks, I think that's what I overlooked. I wonder if it's a royal
pain to make that step and the index step come later in the sequence?
But that is more of a band-aid than a proper atomicity fix.

> - The "merge" here is not -m. It is the 2-way merge in unpack_trees().
>   -m only adds an autostash step for when that 2-way merge fails.
> - The order is: update the worktree, create the ref, write the tracking
>   config (which fails), then update HEAD. As you noticed, the worktree
>   and index are updated before the ref and HEAD, so a failure later
>   leaves those changes in place.
> - As you guessed, the -m case has the same problem. I tried
>   "git switch -m -c y origin/main" with the lock present (v2.56.0 plus
>   my hint patch, which only changes the hint text). It stops in the same
>   place. If local changes conflict, HEAD stays on main, the file is left
>   conflicted, and the changes remain in the stash.
> - Running the same command again in that conflicted state stops with
>   "a branch named 'y' already exists". Switching to the existing branch
>   y stops with "you need to resolve your current index first"
>   (checkout.c:887 in v2.56.0). Neither run changes the state.

[trimmed repeated quoted content]

--=20
D. Ben Knoble

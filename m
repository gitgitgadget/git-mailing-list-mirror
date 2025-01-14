Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FDC26AC3
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894433; cv=none; b=qqEZhPP9e2uKpUxNsSfduw6w6nrJ9rUCyxj3Lr7SAHyytC1yYp9+OZLoeH/AHgF6dTfDTroOo8OSIgIisSrDb2Fb3dYcM773a3F/hBMa1gwgmqcU0Lktj0u6V9v+CXJpWP9tOHrrkKQdHtz/Qo3NY/2BzkMRre0254T+lft8eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894433; c=relaxed/simple;
	bh=ssSrwb+n/Y9B/dGjKoddFAzDzLr1UoSXUxovzOS6TH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbzFNMXYNG9RBX8jXl9Ri0ce1m2xGdbnsEXnTC7BMlSj53gdRm71QNTkZ0hr+o5tRR5mN0KawwK7tB5F2B2kVlVbA4ZQhLZH+7zYXR6yzBLB8P9qVn1BAfHocrK4tECFVfcCfzHz4xSH1lQMDka3dHqk4rvZcxQN6f5T+lGj80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxXFjOAL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxXFjOAL"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46c6547266so9098472276.3
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 14:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736894431; x=1737499231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6yDmAcfiTCpeWIB/r59vL10lL6xjOABuVj4sKeN2GM=;
        b=MxXFjOALbrZbpOO/kodfIeuPsbhFMOkagmycRVeeEL3VmsvV+1H15NRCV2kHiAMq8Z
         86Fs1OVe1VnBnlJ8sUA49h2NVppTDTdiXGgwxchjnSjEg3xKnoeGAoVgtqdd2ojQXq3W
         MUv7yiuwC3ppBXJTTlUs7M8EokZ3eb5YXgUbJ0eVBwbuGg2dZu5bC/w7rK61yneQx//S
         p25kbY6iGRNqPoDd3/tQ8b+++pQ+EHtot8qSIR8+h2om9GfUyfDhEPosa2Hb592cO7+q
         b1j8R7E2Ou7GaFNOAWRTMv94JRtPSnxkY4IUKjUTYD6+CLYQ70d85CzV2dLZ3Il6eDli
         Hq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894431; x=1737499231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6yDmAcfiTCpeWIB/r59vL10lL6xjOABuVj4sKeN2GM=;
        b=Y6IvEqjtBR3jemzgWAf/jTxvSsrkTV5W3OQZT9rAGLOVUe39lnLxPU1Fx0RRkVcgpF
         9KzE7d7Ku/5+jrZhRbCsyIsLkb/W6PwtvO627+pt4fVf8tm1FYfksGfW4l3jxx0urazJ
         8kO4LK9ufsXyFHDefbhea+gwOOIsbe078VTnm5yfvwhOAnhWJ5HOomQmfJQ0nkobc5IJ
         +jMOLAABMIc0H4qItd9FmFKbyxR7WWO5kbZ49sRKkJOhnoUZvk2aW+U1PyBTexkCELq8
         +89XopJqOgQlZSYmXekstnchOevl72MympLKT9c6wa/MysWF2XyKsMgO//oMBddugMlA
         aAGA==
X-Gm-Message-State: AOJu0YxKqxhpb4kaxl+UbyYpQSMbJbg9qd3jhHdvA0KQi68e9iAqx+p5
	3qz+eZxort7iRHOClCAcFWeC7a1eeJ3c2JAClHMPvUQZgkAqfQuQit5FUeEKuOB0vbyjLdnzd2X
	QbuYdZsnAZG7fjP+qsvWxvmtmslQgEazA
X-Gm-Gg: ASbGncuo2GpqGzVxUV+wLF9PAtdKqd2wESLQCph93g4t2IsQsUbkKwPTYlXzuIcswAY
	fsmd9cB6wIJVaMrWTpiyI1cWvreo28RO5kbdzhIVGNv9KW22Qb+Bbzx+Mba82BT8ST1HwDA==
X-Google-Smtp-Source: AGHT+IFJm1dTHwoDL5uhSU6nAuZVNiMAedjxuJD0uvonPIYVR6VzbNuMJ6ogJS2JZ+WpZRypSPB6G2AAOBe1UsZIa2o=
X-Received: by 2002:a05:690c:4d06:b0:6ef:a5bf:510b with SMTP id
 00721157ae682-6f5311f87bemr215731537b3.1.1736894431026; Tue, 14 Jan 2025
 14:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFAcib9rWO8WFmaAwf+1Ng85+N7O3Y=QM6wG5xEz0r4tGXJ8TQ@mail.gmail.com>
 <CAP8UFD206mL+CYxOUKOPWFj7tX1Y79Moc7UjvH4BsLVLbAk-JA@mail.gmail.com>
In-Reply-To: <CAP8UFD206mL+CYxOUKOPWFj7tX1Y79Moc7UjvH4BsLVLbAk-JA@mail.gmail.com>
From: Josh Bleecher Snyder <josharian@gmail.com>
Date: Tue, 14 Jan 2025 14:39:55 -0800
X-Gm-Features: AbW1kvaKVsMaEc1-jZD5fYZDTrBqEZv7CDCTKNJqvpByNeC3UYb6N_vX_3Hw79Q
Message-ID: <CAFAcib9cJOp26J=PxU3XwmLT0hQVqCb8vcS7MdGpFd5TNVfDzw@mail.gmail.com>
Subject: Re: Should 'git replace' respect GIT_NAMESPACE?
To: Christian Couder <christian.couder@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > I was hoping it would, so I could have different replacements in
> > different namespaces, but it doesn't look like it does as of ~now:
>
> It might be interesting to know what you wanted to do with different
> replacements in different namespaces.
>
> When replace refs were introduced, there were discussions about
> extending replace refs to be able to have different sets of replace
> refs used at different times, so that it would be possible to have
> different "views" of a repository. For example there could be the
> following views:
>
>   - the "default" or "canonical" view where no replace refs are used,
>   - the "timestamp fixed" view where some replace refs to fix
> timestamp issues are used,
>   - the "authorship fixed" view where some replace refs to fix
> authorship and committership issues are used,
>   - the "build fixed" view where some replace refs are used so that
> the build work on all commits (which should help with bisecting),
>   - the "old history" view where some old history of the code (that
> was not imported when Git started to be used) is linked by some
> replace refs,
> etc.

That is indeed roughly what I had in mind: a bunch of different views
of the repo.


> > $ git version
> > git version 2.47.1
> >
> > $ GIT_NAMESPACE=foo git replace
> > 751eeb3b4d23c7fbde919aedde8c091f04f4f819
> > a9dfd084086ee4d6bf00a33b0976f28c0997457e
> >
> > $ git rev-parse refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
> > a9dfd084086ee4d6bf00a33b0976f28c0997457e
> >
> > $ git rev-parse
> > refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
> > refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819
> > fatal: ambiguous argument
> > 'refs/namespaces/foo/refs/replace/751eeb3b4d23c7fbde919aedde8c091f04f4f819':
> > unknown revision or path not in the working tree.
> >
> > $ git log -n 1 --oneline 751eeb3b4d23c7fbde919aedde8c091f04f4f819
> > 751eeb3 (replaced) add go.mod
> >
> > $ GIT_NAMESPACE=foo git log -n 1 --oneline
> > 751eeb3b4d23c7fbde919aedde8c091f04f4f819
> > 751eeb3 (replaced) add go.mod
> >
> > Is this a bug in which case I might hope for a fix, or is it working
> > as intended?
>
> I don't think anyone mentioned using both namespaces and replace refs
> together before, so it's hard to say.
>
> I think namespaces are considered a server side thing to avoid
> duplicating objects in the common case where different users have
> different forks of the same original repo. And namespaces might not
> even be used much on the server side as there is the "alternates"
> mechanism that can be used for the same purpose. Also on the server
> side, you generally want to disable ref replacement entirely as it's
> just simpler, and most often what users want, to use the default view
> without any replacement. So it might just happen very rarely that
> people want to use both namespaces and replace refs together.

Got it. Thanks.

Do you have suggestions for alternative mechanisms I might use?

I want to be able to easily enable/disable a set of replace directives
for the purposes of running other git commands, without globally
altering the repository. Otherwise I have to worry about locking,
cleanup when something goes wrong, and state visibility and
management. All possible to fix, but messy compared with something
like namespaces.

-josh

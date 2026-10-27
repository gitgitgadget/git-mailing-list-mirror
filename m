Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793103784;
	b=uynfWzWKUxCDp5eH13eFDtxa/HUdi0V6INNjTzGmpva2a6Wwl0GrAu5lByjjDJVTFzK8
	 sF/KjTr0/4mX/ycfYPkoU6Bcc4Mkf37GLBjPztXjNP3hgnCsiPzBi7ud4pUVJS5GIJPdG
	 rTQtoiRqiDTUTnvxivz3cJjg8qvkSgfUHAt6oy5cO8kHkjCOzR3z3D+48t0HpSk8lx3xG
	 pUjERPx8Zvzj3GPbvvoF0bmEc9VkWehYqawQXGe5feWUtaOnkma1yzi+c65Mhvq+PMLba
	 4xyufaivvl8Zb0YtCf1hIyPMVQCTMtGt5LpL/3yeoqbiKlwBHBr0zmhEpu2dSocu8RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3xCfNdkVVtM+wYM93mmTHLbWeKwspenQEOInWBozDks=;
	b=fYZacfE/XfP/7jZ7AJQP/vw53HpaWUXHupJDimcmyNbFN7bD2tfLMo0q2ue6Wrz/dqyi
	 A48uG31t/0Sb7Y/umHQdkaDsM/f1p+faEKk2Sy0oF6zDPfl0wyrqBivH4KkSyXgmN0/hd
	 s9We3KD/m7g77zstMEKAHTdF/4XPCI06aXt91ZEuQUyq/bOOk/cpjeIzM+9bzZHkRWA6g
	 6slYZKCnM+oYSZqd0ITE64g1COuiuefZhdiS2py0lTWoM7b7HwD+FMmG90715ZvGkKI3p
	 aqw7V5/VB3RxkTfA2tEqTOJjyV43cs/+iuMLoqolvZQhfbbchl3fxyNKrjQTqm1EW0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q1AhNksz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74516606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74516606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q1AhNksz
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso5866573a12.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793103783; cv=none;
        d=google.com; s=arc-20260327;
        b=AOm0zrZNKDpO9SC75vFiNO/0t2bWpwZ3WjBsvGNlEvVwAfaJeJ4VhcYheZ+hwniGIf
         KrlY7GG/aMnWEWCpTSwnDnOHGAGN/8mD9MW24EkjISsoG8+sYNGJaofcGBptMGWoR1TA
         jfdxGXekkNeg2X3SxclI8E/t7QfaeLgVOV0vzUoDmrz179jrKlkYiAxTuNUraf0+1PHo
         ZTzcn61IR7Isn09aNVf4gMFtRYSOAlcDg5ffArjPzzkS6RgtLbv3vlxURxsQv34YoVBX
         wGdlVZfhGHIAbDLbGOXW+5ODrs38UkRBn0xvd0aKreUomZfv3+g/EOUWFJGxUu6sANoa
         AGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3xCfNdkVVtM+wYM93mmTHLbWeKwspenQEOInWBozDks=;
        fh=FsUzaFgOBcI4DI0P5jLFcaWFtuEmS1+U4biXc0luaY0=;
        b=HtZ3jloWWu1LyOHa23moyl60OyjFjcanTHdaxQOOa1lx7CK+nYdR2XeN1My7p6OXrR
         ky4q8tZM7ASQMqyXKNqmR8MfJ3V7XZP4rQGTpJEh/Ckzg3OCOS54pVzQOk9dMZiNR8F9
         mtPyj5v1X3lpJusGC9f08JLTVsmv2tgMZO0/FA7SrdJFEJgZNeW5i0l2JaHjyAMfJS9i
         rtJkOiTcVn7JvUczKgKEteOtqkF+ynIX6UTn7Td8bIfIHTvJI8rK3pOHQ5UVxc1aB+2+
         PbYAOOcWc509k+7Hrq/WGeERGYgAV2tTS0qkmN+k5eY9nTXf1UZ1dyUENhsB9LXXNlC7
         BH4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103783; x=1793708583; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xCfNdkVVtM+wYM93mmTHLbWeKwspenQEOInWBozDks=;
        b=Q1AhNkszVoWvoXD7bPoCdvWAmwndRWdQQhvkJdYGBPCopGmTaL/OGKd21eCkHkASmx
         Ju0/0towIKAD27I20/CQJc3YfitsHYCT6B/2XYSPoBTllWJMxOMgvvuAK8wk6Wp8xWL3
         CuAIg1ZGHyk9eTUDHtDAPZ3rC8sm9AjVxXjLBpl/NDf0tbqDgzoTqOHR+8vIpZAKEe8J
         frIMjyCJvXBhw0Z3HiOL7hQq2qxLtK288lgLVFBTI6Z2OKzsl0bBvE7pIzhAAni+73t4
         C8Up/7HLaEsBaZKiekfjnbnwRgS628WfB+Tsqif0HBSS3zrWI0fIsvrZlbWHXqKoXAnM
         xkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103783; x=1793708583;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3xCfNdkVVtM+wYM93mmTHLbWeKwspenQEOInWBozDks=;
        b=b+dRtWmbyecgEPtn0Qh1vZ0TrNPnhXfM7u+CkEtNjJkF0LcVxKhnEmY4nZ/vnbQ2er
         R/t7ZpQnIMREYeaq6+Jz+VpP7GFc29Fjj8enlJtsuKbF1glzewDACPaChoCL5mButu5v
         73fOYpv1KPjYFilbJBepXyEUhC6e9YbAzzHaZBb/Ai8eSSIu8yOLX9vgKH6jg9v+FTPT
         doPed/qLRXtY/LdKyz/F72Jjjq43ssmmKAJFWEr94kjoR9EylEFjHCph5ex1m9fzgkg3
         5FwWFdCffOngEGLvkb1wD3iIodu+Z0uOpO7PD8jrXylAxGjkan/eBlRKjPhGwsWMUTt3
         pF/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxBK0Wh9vywwS663+XLaIo0VQi4d+fqsca2wzT6ZzSg/Qk2ksyUTiekymILRLqxJQn7A/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc0waK+r08prpJV/SBHub1hixVggdomn5PY+eAG0kNBTKoNqAB
	EwAygVvpk7j9wb6yBtDa1Mus2ujb2jdorXkzXcFma73agkqyeiPcLj+0IBHWe/MIM2VreSghYw6
	0hS9iGQMWxoh/WImAW9ZsRcNi8M1B5fs=
X-Gm-Gg: AYBFou0uPBfmAi7Z1lBBWaWgLj7dNPNUK+XngXVtIgphyPnH551uzu1/eKpsYYipH6A
	oe2H9EXEPNgWYNpTanH9+dYz9ierVbkDIJ7g/QHaZlygmNuUEGgPYQp3qLiFyi0tpZq3rUi+52F
	UFBQukT3fssq+GD78zn0dmukOEyt7SMJeZ8KU7ti/QvMEBEwYCFzfYBzj5hrNHqxLcrXlkik3zd
	OFtU1UmNbWjv18thtuvCKOVkP2bfwr2vrPr+YHiMSq2ZCfx4OJjhqKpI2usLphmGj6hBUhZtUQL
	nan4POtOe3Y6Ui4Qnd81sES3ROXHzbRp1pwZsY2nJNwOJPuiDatridnnlTXiwFOHxxgkJ3v9zBS
	OzTdkKd9u2oQqfB1vdAI9v3KjgHaiy/tPX0erlFVzYyKqirsdBvZEAJ9Dg79cKOfNSF75Cg==
X-Received: by 2002:a05:6402:4410:b0:6b4:203:a182 with SMTP id
 4fb4d7f45d1cf-6b442a89b98mr11314786a12.3.1793103782707; Tue, 27 Oct 2026
 05:23:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <xmqqcxt02eoa.fsf@gitster.g>
 <101723fc-d392-4000-b224-345c610b2aaa@gmail.com> <xmqqh5i8tqjx.fsf@gitster.g>
In-Reply-To: <xmqqh5i8tqjx.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 27 Oct 2026 14:22:25 +0200
X-Gm-Features: AclHuK_tycNNO87lm7yU85YibqO6NngX3jElZvbJfLjid19UKiCxG6W1DYbxITM
Message-ID: <CAHwyqnWBzrj=OVzRWWTwbSU-zG-t_2wbfg+cdTaCWgYstV78mA@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > I've just read through the commit messages and documentation changes and
> > I think it is a mistake to use a single config variable to configure
> > where fetched refs are stored and which refs are fetched. The problem
> > this series tries to solve is that the default refspec fetches all the
> > branches from the remote and it's not possible to use that mapping and
> > also restrict which branches are fetched. To fix that it introduces a
> > new config setting to configure where the refs are stored which is good,
> > but it then uses the presence of that setting to implicitly configure
> > the default set of refs to fetch. To me that repeats the mistake of the
> > existing fetch config.
> >
> > It would be much more flexible if we had a separate config setting
> > (maybe remote.<name>.fetchRefs) to describe which refs are fetched.
>
> Good point.

Ok.

> When I wrote the refmap feature (without configuration variable)
> long time ago, one of the goals was to allow me to say
>
>     $ git fetch cabal \
>         --refmap="+refs/heads/*:refs/remotes/cabal/*" \
>         maint master next
>
> That is, "here is the place I grab from there are stored" and
> "maint master next are the things I grab from there" are specified
> separately.  With the configuration variable added in this series,
>
>     $ git config set remote.cabal.refmap "+refs/heads/*:refs/remotes/cabal/*"
>     $ git fetch cabal master next seen
>
> should become possible with the same behaviour.  I am not sure
> offhand if this series does that, but I would consider it a bug if
> it does not.

It will do that in my next version and I added a test specifically for this.


Harald

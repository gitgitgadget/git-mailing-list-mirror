Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3523F4856
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429929; cv=pass; b=StSygA3FrW3QBC+1VvHxCjrVXYVndrWwK32oXgsCRqh+RqzPGTZOTxe5gUmwub84hyTifvVitiw1YbkuI2Y9jbauaVKQJ25Z4eXTceNLs69GAQ2wGC4T+xERSBBYUWgYPVhme/kZgtlTDxfHYo3ogRZ3qencXEZYpUNbKpdpMxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429929; c=relaxed/simple;
	bh=7bwJUKVb/VyYE4NqLrk/P8b2uQXO6PCZr9/Ub1qAxTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNAUYJqteJz5ghwZfJ70mhcxg3+R/KuPhij4glcO0lwXDO4uRgQFiIzot8vqHKo0NJCLMxwAwkU2T+p7Ey8O8tN2fmC5sOkR+OtqAXn9EFfQSJ2HEaiN74PN4iC13hiRPKNWOvMNqBsBoAHsyaszOsU9Aarj2zhMQOqXRhGzYZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8N2Kkas; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8N2Kkas"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so4900796d6.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 23:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786429926; cv=none;
        d=google.com; s=arc-20260327;
        b=IDyphZiL+qKNALLzXCicAxoyXM4IrDyDNwvJzUgB0L2NHHqoVFAf2yy4Yd5NSoQBSh
         dR3tDQou2qWXQMWkSMZXGoHOtpfYRBVfO+d4XdjR5wkdOOk/rVCV0Un8EJKiNvgMgr7V
         r66ivE4d/u+b9LxycqECLPvAFs2HfyzcOXkop+jBOUYpBrgqjIidd8Vh5wEA1bMKuh8/
         7eBA3XyVGrodoZeszi4MGtP3hrHEWyxxDW8NRoXuQjBqyA83T3mRTBtATYfq8KUTZhfv
         8qkGTLDDS4uoxMAIqrAonLxozeLucCcIo7LkemEZqn/8RoMU4+IN+eqdrCqjwuiLGuO2
         12gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v3WAFxdxHe6O6T5vfRiUCDdPz7Y2MMUbxYT/+UJMcfQ=;
        fh=xRAW8XV+Fzn3jwemuFKPoaqCRQW03L7hLrMQohPey74=;
        b=o5zYicb6ZLE0oSaTKvDB71SPOnwHy0a2lrZLLoHmx8O+THRMRZdGPVWM8aTb4n5hBN
         +WIpRlkqnYZ7wYehnLqHFgyFo3TxHQz5gkZl0wfl6iBdTiD7Ph1zdtkn9L+Cl+i9ivC1
         +VmynOgxfW9Fsu/ZUOzHQ9BcPMh1Z4GPH1qa72kXMaVk4JkDY09yhdPZgawqJ3OC/lJl
         HmU0S5UB17an+7ScYIZU8+oLE1avmtv9LpmMGq13llOKCHokndS5SGtkRK2sU9SuNziO
         H3wPs2ZZO5bPSf/fQACLHlaMSEf5bzhfwX5C9AvhySiz3Kw52LvsHk5lgnzABog5a7/J
         PHig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786429926; x=1787034726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3WAFxdxHe6O6T5vfRiUCDdPz7Y2MMUbxYT/+UJMcfQ=;
        b=q8N2KkasTDCCikQyly/1BN25grwkIfvP17kEsemde8BMs6bt1OYl76Ly7ioBPDZ3MS
         akJbAdX9ldtVP5kIak6YS+/JqJkZonyTQOvprY6t+2RCeV1sCAkU+jrzReFGlIsIgEdM
         55NXWW8neLr3ST2r6C0utnsBXnxr0nFHZDRvYzeNdXfSMCvgRXFnHo5tv4FkTQDO0TK+
         pE22RBrQ0DUjrhuh0STGF7X5sjIrXpK+l1vCCZr169zDgncQJLoq+zmA+KUA2ppstcQ4
         LLB6xtLiqcdBLOXFTKLFQSC9xSnBsff436uwnjfv38NGMNjBwcD2wDQ2+Gz6Yayjb0Um
         LOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786429926; x=1787034726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3WAFxdxHe6O6T5vfRiUCDdPz7Y2MMUbxYT/+UJMcfQ=;
        b=LzFBdOt8OyhCZZkZNthgcMEjzD90S4KfCuIgqOSNouSCjSH+krWVRQeGjrfwZlHW+o
         FO4aPStMFda6fVO7xGCEfg7VzY7z/kidOXITFMSoUt/M0f1RFb+6PK1yU2vkfWAXC1Km
         2MuFSKUoCWzku8g68K1ciooFEvJmE1locvxohlBaraHPtRIzbpGX1RdsK0wbLjfeuQni
         QUMP19rhUo7JB92No5DWwhiGLv1oW/Wulz/l1iNPIfqFwsr0SU6tPbpdJDk2ZLH4gZ8O
         U9e0/D3XlSeTAblP+A2EDCHRaJ5BxpJka/OzC6kQKqc+bgUDhhme5wI6vNNOOzFSHPAB
         4kUA==
X-Forwarded-Encrypted: i=1; AHgh+RpoR0HaawVm8UR6BQwf3h2i2dVuqt66zOvsb/3pLo4JBg9YESTUMBgCy7i30YuSXnP+iFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvM/Vj1hAeETXyMAEbp5aqj+AyVWBFX3Lc5lK5shyMi+2/tVka
	stHgTEcdtugWhlZs9DxasRgq1AQA0PtMzixyunvQTxsa/wGW83faiqPdwaViM1cTViSSD8TaZ3T
	YY4cgNPBCYX6lxh15eHDp+YQbIJDI4Ck=
X-Gm-Gg: AR+sD11uYGuPO1pc3EwW2as+p+hiOJSJFUfCbD/vfRUShEUQeL1hxkp4bdraOtoUnj7
	HwCr+FIpkrZ2pxePXuHklk52OMC8AD9Nw7xSXRH37uGcjBOFTd5JMrgtEvoWtfnhvyGjmvnKwas
	/oITkns1ukD8CFW03X/GvqL5peKu8nH7zlPt541yW+Tp0QBS6Cr88BiM2jVYDTRIpzRCWTAx3Al
	Pwtz1tc2RgOsknWAwNbzX5uM0vipPAqhoB/a0GMPfqA1tmbOylvHGG8AvTgajfBXhyK9eDRdmy9
	Gz4Z+15b5k96pLg6tZsnQD9bO8tKuj70GtMx5l+yPGdbhvGVzL8YUIutibs/8Wqs+NePuKIimHn
	Peg0wetdqzN/mezIXblN752jHK6rGVItfOA==
X-Received: by 2002:a05:6214:3906:b0:8fd:2dff:3f49 with SMTP id
 6a1803df08f44-90a671a674fmr6712786d6.10.1786429926368; Mon, 10 Aug 2026
 23:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <pull.2197.v3.git.1786395305884.gitgitgadget@gmail.com> <xmqqecg55xqq.fsf@gitster.g>
In-Reply-To: <xmqqecg55xqq.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Tue, 11 Aug 2026 15:31:54 +0900
X-Gm-Features: AUfX_mxd1p3XjWs5Q8scQwFH_dkLAgGo__Pk3RDgZ8XtfmBhxabiKC9OTZeHphg
Message-ID: <CAF5D8-uCjA-MFtdBCa0+5PDb-LFJ7JJ0yK1AtuWCKEN+tKQa_Q@mail.gmail.com>
Subject: Re: [PATCH v3] worktree add: improve message for ambiguous remote
 branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> >
> > When the user runs 'git worktree add x y' command that does not
> > exactly say which remote they want to work with, and there is no local
> > branch named y, we try to guess which remote by passing y then create
> > a new branch named y which tracks the remote branch.
>
> I used x and y as placeholders.  The readers would be helped if you
> used a more plausible sounding names, e.g., naming directory as
> something like foo-dir (the point being 'dir' somewhere in its name)
> and naming a branch as something like bar-topic.  If this were 'git
> worktree add', it is probably more than likely that the destination
> directory would begin with ../ to have the new worktree next to the
> primary repository we are running in, no?
>
> > If there are multiple remotes that have branch named y, we silently
> > gave up, leaving the variable branch intact.  This later causes
> > creating local branch and worktree not happen, and we end up with
> > passing an non-existing branch to lookup_commit_reference_by_name(),
> > triggering "invalid reference" error and die.
>
> "This later causes" part still seems a bit too sketchy to help a
> totally new reader, even though I've stared at this code long enough
> so it would be sufficient for me personally.  But these logs are not
> about helping me, but helping other developers, so...
>
> > +#define WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT \
> > +     _("Matched multiple remote tracking branches, you can list them b=
y:\n" \
> > +     "\n" \
> > +     "    git branch -r --list \"*/%s\"\n" \
> > +     "\n" \
> > +     "If you meant to create a worktree from a remote tracking branch =
on,\n" \
> > +     "e.g. 'origin', you can do so by:\n" \
> > +     "\n" \
> > +     "    git worktree add -b %s %s origin/%s\n" \
> > +     "\n" \
> > +     "If you'd like to always prefer some remote, e.g. 'origin',\n" \
> > +     "consider setting checkout.defaultRemote=3Dorigin in your config.=
")
>
> Instead of throwing the problem back to the user with four extra
> lines of message telling them how to run 'git branch', I would have
> expected this patch to teach unique_tracking_name() to optionally
> return the list of remotes with that branch name, and to use that
> result in this message.  However, if the goal is simply to provide
> something better than 'invalid reference', we do not even need to
> go that far.  Just stating that branch 'y' appears on multiple
> remotes and asking them to clarify which one they mean might be a
> sufficient improvement.

Extending `unique_tracking_name()` would also affect the implementation
in `checkout.c`, and since the goal here is to improve the messages
(making them as helpful as those in `checkout`), I will hold off on doing
that for now.

I will rewrite the log messages a bit.


> Could the original request be aiming to create a new worktree with
> the HEAD detached at the commit pointed at by the remote-tracking
> branch, instead of creating a local branch forked from it?  I am
> just wondering if "-b %s" is too specific to one possible
> interpretation that may contradict to what the user actually wanted
> to do.

If the user is aiming to create a new worktree with the HEAD detached,
one would specify a fully qualified branch name like origin/bar-topic,
starting with a remote name.  If a branch name starts with a remote name,
multiple matches (condition to show this hint) rarely occur.

Thanks,
--=20
Yoichi NAKAYAMA

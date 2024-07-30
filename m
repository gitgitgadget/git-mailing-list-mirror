Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE26184547
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362233; cv=none; b=Y1z5E/eaRliyBRAkwxJdxNzlDAg2XVRC7Cd9SS0BdUaI3qJNw+bCb3pAlR49fxXrF9wIoRMf+ta4zXkn0SK4t+CnsUwMUa/lvkepbwbCawWydFf780qafzcUzyFYW1Ok6NHkuIfz8fblk+EzyVb3MGrxqXTE8EehHdqwkf/3WqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362233; c=relaxed/simple;
	bh=QHCzbGhuose0LVPAyQBD9XnP2nOb/P/hNz3p8dWOBWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTcW0bQcDqYK6fYxJPvq/vhBhw0rKQdFongVlJrTPOs4MQBD27/qWwiOoTQ4Lz54Zqku45Mih02weNLzEYu8mAPOwoXqHkZJD973MUZLT3/TUR0xeveEoaWE8r/OZgS1z+/gb6/lTqI+Rv0YMKe+8MOf8JduuWcON/iSE+srKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b7acf213a3so25543586d6.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 10:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362230; x=1722967030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTQ9HkgXmWDkDk1qSeAMDxeKJwojMdaaRkR/DPSc6BI=;
        b=UKEMlEcSq/9snhG5OusZtP6oArRKHeaj4b6Oy3o6AIEKO3x996axfbJZV3e+ozG2Cj
         28k8t7kpg6tJYlYELLG/UuzEgFATjXTh3JUpTFoz5fLCuo+6cwW4lVPFT7SaYixJ9LvU
         O14uCU7eTtwchX2aYLsNClQYyUIWNW1wgZPJA+JlEAOArSFgO0OIrziJt00NQXRWXeYv
         +7R5+DS1iqouKUqlnC8AAMJaOF+tpnJqylcpaUA3A7JiGBONyorhzM713zx9ISxl6+CQ
         wM4RcO5fkx1ccbLRQGzr/JwVScu+fc5c/NHcZz8cS+JHDGZ+rorwcxsM+3+OP1Hwr7Mu
         PKVg==
X-Forwarded-Encrypted: i=1; AJvYcCWW2HtHp/vpPyHVJ67gI5f4CCoS/k5pjc/mIH1kOpseY+IvitX4U58TRXRmUm4rIRdX6XYpCudUqhT2QtEBg5UWkUlB
X-Gm-Message-State: AOJu0YwfoadRhSuAZKossVkgi32/wW75fLupvbc8q7G4e3xSYUANoTtl
	mJvJQzswXEDWhD49li3V+KfKABzLYL7u4kMOTVfP7u3TOFD2+rKeYew9eoMsziGuTdAiXSLrWpw
	Vyh2DQv59kXdVapKzUhEGLSPxRkk=
X-Google-Smtp-Source: AGHT+IHe55JwqMFrOXB7UE69NDTGsLJm4SI853xteHi8xYjLX6J4qpr4R2rOQC0fvu/iim83/LfHLzanR1YKq6eiCTk=
X-Received: by 2002:ad4:5ba4:0:b0:6b5:7ee:1d79 with SMTP id
 6a1803df08f44-6bb55a751a9mr136094646d6.26.1722362229767; Tue, 30 Jul 2024
 10:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZqeXrPROpEg_pRS2@ArchLinux> <ZqeYsNtl90N1fVDy@ArchLinux>
 <Zqik6cgm_6HYVUKy@tanuki> <ZqkN4wNK0PIRyNky@ArchLinux>
In-Reply-To: <ZqkN4wNK0PIRyNky@ArchLinux>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 30 Jul 2024 13:56:58 -0400
Message-ID: <CAPig+cRD3F-QHneC+0bEUcWt4ep8hXgjg4OT_MvfLjQKNE54iA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v13 06/10] git refs: add verify subcommand
To: shejialuo <shejialuo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:59=E2=80=AFAM shejialuo <shejialuo@gmail.com> wr=
ote:
> On Tue, Jul 30, 2024 at 10:31:37AM +0200, Patrick Steinhardt wrote:
> > On Mon, Jul 29, 2024 at 09:27:12PM +0800, shejialuo wrote:
> > > +   /*
> > > +    * Explicitly free the allocated array and "skip_oids" set
> > > +    */
> > > +   free(fsck_refs_options.msg_type);
> > > +   oidset_clear(&fsck_refs_options.skip_oids);
> >
> > Should we provide a `fsck_options_clear()` function that does this for
> > us? Otherwise we'll have to adapt callsites of `refs_fsck` whenever
> > internal implementation details of the subsystem add newly allocated
> > members.
> [...]
> But how does "fsck.c" free "skip_oids", actually "fsck.c" never frees
> "skip_oids". This is because "git-fsck(1)" defines the following:
>
>   static struct fsck_options fsck_walk_options =3D FSCK_OPTIONS_DEFAULT;
>   static struct fsck_options fsck_obj_options =3D FSCK_OPTIONS_DEFAULT;
>
> Because these two options are "static", so there is no memory leak. We
> leave it to the operating system. So maybe a more simple way is just to
> add "static" identifier in "cmd_refs_verify" which means:
>
>   - struct fsck_options fsck_refs_options =3D FSCK_REFS_OPTIONS_DEFAULT;
>   + static struct fsck_options fsck_refs_options =3D FSCK_REFS_OPTIONS_DE=
FAULT;
>
> But I don't think we should use `static`, because Eric has told me that
> making a variable "static" will make the code harder to "libfy". So
> let's use "fsck_options_clear" function instead.

I haven't been following this topic closely and I'm not familiar with
this code (and don't have much time now to dig into it), but I suspect
the context here is rather different from the one[*] in which I was
highly skeptical of the use of `static`. The `static` in that earlier
case was suspicious/questionable for two reasons. First, it was a case
of premature optimization (which, by definition, is frowned upon).
Second, it was in a "library" function (namely, top-level
fsck.c:fsck_refs_error_function()) which may someday become a linkable
library which other programs (aside from `git` itself) may utilize.
Having a static strbuf in the library function makes the function
non-reentrant and takes memory management out of the hands of the
client.

In the case under discussion here (namely `builtin/fsck.c`), it is a
Git-specific command, not library code. As such, "libification" is
much less of an issue since Git-specific command code is less likely
to be reused by some other project. (However, that's not to say that
we shouldn't worry about unnecessary use of `static` even in builtin
commands; code from those commands does periodically migrate from
`builtin/*.c` to top-level library oriented `*.c`.)

So, considering that the variable under discussion:

    struct fsck_options fsck_refs_options =3D FSCK_REFS_OPTIONS_DEFAULT;

is part of a builtin command rather than library code, we don't have
to worry about "libification" so much, thus making it `static` would
be a workable approach. However, doing so merely to avoid complaint by
the leak-checker does not seem like good justification. Hence, keeping
this variable non-static and freeing it explicitly seems a better idea
(which is what this code does presently).

I do agree with Patrick that adding fsck_options_clear() to top-level
`fsck.h` would be sensible since it frees callers from having to know
implementation details of `fsck_options`.

By the way, regarding the static `fsck_walk_options` and
`fsck_obj_options` those are probably global static for convenience
rather than out of necessity. It might very well be possible to make
those local variables in builtin/fsck.c:cmd_fsck() and then plumb them
through to called functions so that they don't have to be static, and
then they would be freed manually by cmd_fsck(), as well. However,
that sort of change is well outside the scope of this topic.

[*] https://lore.kernel.org/git/CAPig+cR=3DRgMeaAy1PRGgHu6_Ak+7=3D_-5tGvBZR=
ekKRxi7GtdHw@mail.gmail.com/

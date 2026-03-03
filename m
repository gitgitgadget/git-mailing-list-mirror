Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8763976B7
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568687; cv=pass; b=Uc0psYyW+cm49/fk9aWA9379iDjg8VP/WrsTWe7rJJEOiD3yjol2Z0qDAsTh8TCLgyWKaPfJ8wPcK8/2uIYK/sbZeQ5DqdG5PgADmYGeRbosFrvY5vq4Q6cUMpFjhdAOef0Td2TenC8jul/9UH3Jx1Txr8WK3lKDtuIWYX1bH8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568687; c=relaxed/simple;
	bh=RilWaPy1vri29JoeRKSu+R1/vnoMNAl2A5cQoppW5w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSWaochaWAVffoonXTCBaGNsvLUlO8iQ7p99qljaUJvwAZ9/8Y1IO0RCvdEKMRmIW8AiCcgdlDVD51+68WzGiaxCwmiAAbPccLmt2sb/NIQ/3Bypf5+X0smUFHAMjlk9NK3al0nVO7Qlwr8PkKI2sqXsZ3QyvGpLOx/ayp4uxsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea3s/Ndr; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea3s/Ndr"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad9fabd08so5076561d50.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 12:11:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772568684; cv=none;
        d=google.com; s=arc-20240605;
        b=SiSicK08x/nE1pLDTTULGf0suxFbDvBzHaES8RlaJ3np83bii7v2JTSI9zkZRJ5E11
         JfMV4Y1Ol8gw/zy93HejRZ4WKfEvNf77FqPaOhh+64vuPSyps5MhMtIEHuVOXnINbzhy
         N7Vba4/Q9pBsEJdaNm93nocmTfvi9Cny9T8oOlGofIZ1cTBbz1/jZU61qmE8+/mWce4X
         bABXMw6EZZjvCl3pKd1lb9VjHhB6/HAt/B1r5dKG/kFlViMb/M9deT350RmR3iYCauzR
         FOxIwKHaAKcXVQyTJpoA8Zk+Rhi6jPKZ2HBkq68MYBdO5TmCuYsbDcHZJ6DHhC8n3Pkc
         ojKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qZNldSthFPzL8iE7//mEcENC1uRhLUgm3zIPeT/shbI=;
        fh=48Fm+PP1hp60xpWNBz70JiKjDrmCDSeEPLJp27/iW+g=;
        b=QR6zGjPFJKW+m4l2rRDHq+Na7qVD5gXZrmgdB0WzDEXzXpPttHVLad9ORRr4flde8B
         /NQY4CTCmka42k3MTKvyNKQYbrpm9W22UIhPGaBZbvNaVcjn/ipSLxp6rNEHctlwOXHT
         oQpMfmxtp3KbEXvhgJT6J6aPdZcEU4cN3E643GpMtkSs8kxZnefhNeuPya+XCEnu4otD
         nUCul+4ygyK0YX84/Sx49ncx1vWfwJe92HDJMgBtbMpt8SmuqkPCRGGBGdc3bnnU5GTl
         wQxL8sthjFKwrYbP739WiRmzAnIWZOmmWtjYnuIITsZu1r5sJpCEIXAI79fzQt4C1HlK
         TN5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772568684; x=1773173484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZNldSthFPzL8iE7//mEcENC1uRhLUgm3zIPeT/shbI=;
        b=ea3s/NdrYZCrxPphy9NsnZXFXqif5B+Q1HG/ujfJ6dapmGQGAbsL4rO+1uR06HvkTC
         ofwE8BWifEjQfPMTKnfRLsREiMVf0ASyavASePHzSgTB1w4lSWPqQ7s6ytFn6w8cvVVM
         Oc9RAhAvoWLh7suvLUZZj86CiwPj2L5dVZI5gbPT8A+2n519XLfYWxSSBdVx0Y5DILsL
         S8JcZS/zhHPM4sNKaJDKEunmMLN7UaOZ+3VCzrBoxTpu707ODFQap/aNYxJblh6+f2xT
         5qZscSMJ2gKMS+KuFjnydYpMoArrdCdO4DpBPNMS+DnqXwI9aKYB8DmORMxGabRZipSf
         NZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568684; x=1773173484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZNldSthFPzL8iE7//mEcENC1uRhLUgm3zIPeT/shbI=;
        b=J44Nwh9kEMVpEeSR4zWoKOtqr+TEBsKUj3u3ZwsLoBzzDlW7CQzJqA74issrHgThqd
         q8Vvb8yi7r+fRSpQ8DtzkQ1FEHU7QT6lOvQxOrmk60/3LW8Gdqsxo1yAlUAzYdi+FNj4
         KIp5FO0JvWaaKk1AuVJuSGYfn0+jkpM3djvr3tkyy/1DJh4PivVLrpT8X1Tr9njlDd1L
         EGUOKlKFovxnlzA1Hpybmm5c3aaCqQO8pPiIqFCQQE8hkdSK3dkyFKHCu8voqVei2M3F
         o5NAtJ1WAU+cSyFTR98dZXTVt3Ms9gsOu1FodL/JYZ9lvsGR55bqnPU9vFuGSYjl5OQw
         8AJg==
X-Forwarded-Encrypted: i=1; AJvYcCWkJeOy4h+0emj+Q9qUBSPxZsuVss0TsE1Z+W/82oLz55sN6nnmewxfi57XiWVzKUss+zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+by1FmxzrFrMbc2m4RYcrE8dvoEp38hZ5fZVTFQve2VCvwFB
	rbv9CSbAPlBeXQcoYFS9UtJWpSuK7QGN03xSkgWDPCeI80HmP6VsMQcilPDU/jWSUrEuooFmPMX
	A3CaMLYA5Sn8VrsWuZfsMQuOe01uJtnc=
X-Gm-Gg: ATEYQzyovqSQdMhrHEWNMCi0dr2Bhib/cbKVmpffkPZO/NKPozLXJl23P7M8EOPJB5i
	QxT3V9WexzncPx1V0IvTaEfp6hPapkaMZLFQP7UTsE0SwoWEitP3qQfQdpHnsU9w6At6Z6RUPNo
	EkcjCTAqPdlPNzGIGGnfoOKcIgpp5xgKqidprFdSZf1s8zla1atlLYxXhluiSpYNoVTNZx0+npC
	FIWeR9A4QjyIWk3XhH2fZH8uj53Is19UyrsFSt7c5tsf3cbaLWoq5mIhWrqgYY/GeTH+xRRHqw2
	4DqOJyy3UbTtCig=
X-Received: by 2002:a53:ee55:0:b0:64c:b81d:2cd0 with SMTP id
 956f58d0204a3-64cc20862b8mr11729296d50.20.1772568684318; Tue, 03 Mar 2026
 12:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2220.v2.git.git.1772557925670.gitgitgadget@gmail.com>
 <pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com> <xmqqh5qwdaeh.fsf@gitster.g>
In-Reply-To: <xmqqh5qwdaeh.fsf@gitster.g>
From: Omri Sarig <omri.sarig13@gmail.com>
Date: Tue, 3 Mar 2026 21:11:13 +0100
X-Gm-Features: AaiRm50LmFbounqxp_7qvzifomiSkcVBU1c46EuaLGRc1P2WaGbr-zP1jw8RXmE
Message-ID: <CAP9es6uT4xE2+h6mCXgYVcibutVOah1xKyS8cKaV1u=VHBpLZw@mail.gmail.com>
Subject: Re: [PATCH v3] doc: add information regarding external commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Omri Sarig via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the help!

I fully understand this is something you can just do in a few minutes, so I
really appreciate the support and the welcoming attitude.

On Tue, Mar 3, 2026 at 7:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> Thanks.  Almost there.
>
> The usual way to compose a log message of this project is to
>
>  - Give an observation on how the current system works in the
>    present tense (so no need to say "Currently X is Y", or
>    "Previously X was Y" to describe the state before your change;
>    just "X is Y" is enough), and discuss what you perceive as a
>    problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to somebody editing the codebase to "make it so",
>    instead of saying "This commit does X".
>
> in this order.

Understood, I'll fix accordingly.

>
> > From: Omri Sarig <omri.sarig13@gmail.com>
> >
> > Git supports running external commands in the user's PATH as if they
> > were built-in commands (see execv_dashed_external in git.c).
> >
> > This feature was not fully documented in Git's user-facing
> > documentation.
>
> Your description of the problem above is excellent.
>
> > This commit adds a short documentation of this feature, making it easie=
r
> > for users to discover and use.
>
> There is nothing incorrect in the above, but we would write it more
> like
>
>     Add a short documentation to describe how PATH is used to find a
>     custom subcommand.
>
> > Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
>
> > diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> > index ce099e78b8..903d11c530 100644
> > --- a/Documentation/git.adoc
> > +++ b/Documentation/git.adoc
> > @@ -487,6 +487,13 @@ System
> >       `$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
> >       otherwise `$USERPROFILE` if `$USERPROFILE` exists.
> >
> > +`PATH`::
> > +     When a user runs 'git <command>' that is not part of the core Git=
 programs
> > +     (installed in GIT_EXEC_PATH), 'git-<command>' that is runnable by=
 the user
> > +     in a directory on `$PATH` is invoked. Argument passed after the c=
ommand
>
> OK.
>
> > +     name are passed as-is to the runnable program. These commands pre=
cedes
> > +     alias expansion.
>
> We are not going to try running a program that is not runnable
> anyway, so "the runnable program" -> "the program", probably?

Completely agree, will fix.

> I am not sure what the last sentence wants to say, especially the
> "alias expansion" part.  Do you mean that your "git foo" alias (not
> just its expansion but its presence as a whole) is ignored if you
> have a "git-foo" program on your $PATH?

This is exactly what I tried to write there.
Personally, I had expected aliases to take precedence over external command=
s,
so I was surprised to see that it is reversed (so the program "git-foo" run=
s
before Git looks for the alias "git foo"). I thought it'll make sense to
mention in the documentation, to save possible headaches for future develop=
ers.

I'm not sure it's too much information, or should just be described better?

Maybe adding a second paragraph with something like this can be clearer:

    External commands precedes aliases. For example, running "git foo" will
    execute "git-foo" from PATH; only if "git-foo" does not exist, will Git
    look for the alias "foo".

What do you think?

> Speaking of "alias", I have always felt that it was suboptimal to
> make users refer to "git help config" to find out about it.  I
> wonder if "git help git" should be the first place users would look
> for a help about them?
>
> We have "GIT COMMANDS" section in "git help git" that says "We
> divide GIt into porcelain and plumbing" and then have two
> subsections there that list commands that belong to these two
> categories.  Perhaps leaving some breadcrumbs to redirect them would
> be a good start, something like this?
>
>  Documentation/git.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git c/Documentation/git.adoc w/Documentation/git.adoc
> index ce099e78b8..fb5b477eda 100644
> --- c/Documentation/git.adoc
> +++ w/Documentation/git.adoc
> @@ -235,7 +235,10 @@ GIT COMMANDS
>  ------------
>
>  We divide Git into high level ("porcelain") commands and low level
> -("plumbing") commands.
> +("plumbing") commands.  For defining command aliases, see
> +linkgit:gitconfig[1] and look for descriptions of `alias.*`.
> +For installing custom "git" subcommands, see the description for
> +the 'PATH' environment variable in this manual.
>
>  High-level commands (porcelain)
>  -------------------------------

I agree - that makes good sense to me too.

Do you see it as belonging in the same commit, or in a subsequent commit? I=
'm
not fully clear about the rules for splitting such commits in the repo.

Thanks,
With Kind Regards,
Omri

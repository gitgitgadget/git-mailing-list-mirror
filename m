Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15CC1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDYKns (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:43:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38347 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDYKns (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:43:48 -0400
Received: by mail-it1-f195.google.com with SMTP id q19so11389573itk.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/QRAid7cYd9QO4l6gA+JnhvGRgCw7MK0V7bzL+IlT0A=;
        b=blcQCiOFAWuz5yV4ClGgMWTbkvAYegbndpaeQB6m1+iVSGKLs9XrsI4mvPsJZhTeoh
         Kxdl8T1QXfc8lzkrh+zYp9N+OH0o+IVD8u+xIfN9vVoAerOdirYnQEEfJnDU+g718dyF
         Q4vX2qwaE7kf/VXTiB+Hu6Ij6o8Iejl9ekAl3sYMMS6cXcy0rndX0zLtIjCu9m7XQod+
         BBqcwxulCAASbn0WmaExbfBILgWL9/W4lmEMx79KIUFerUIEopBBr0y4ZaQjvCbHY7ON
         MPjJgveMR5PJjxZAEkxNbrimd3IpNbE4Foxe7vWqzaltLAbt/c9Cu0g8u26a1lbGI9VC
         GqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/QRAid7cYd9QO4l6gA+JnhvGRgCw7MK0V7bzL+IlT0A=;
        b=tjOKO7E0K466MigVaN8HX27CnGjrxcR1NoumzLfi7zjBg7vIrqygYVmdRAvSIMVSi9
         GIawOL9IT5Sl3LoSxY0qNp+1M3Lz501H+lMOcpwz8Ii8KFJbvi93t6vjQ/czcmh7B1Xp
         3a+71nZjgrLg7BlY1G9IedZuopQQLCS6baUHY6AN+8gx6P5SOXuG94k3FhjEKbebOlfm
         +0+F7tJN8M8/wJK3C34YIfxzstajKcBayIIL7yq6n/h1WR/zrzHI4RFWSFlZ7GHd5VMc
         hfBEJYkE3v8CyqgXIC2G6WV1Sp4hkradcKDsL/XJPp5niE+6tistenLUckd622Cz6fxC
         lQcQ==
X-Gm-Message-State: APjAAAU/4jjG+J+vap2KndrrceqqugNmx82+cXbrbk7XZ0vIOSUCubED
        vmPH5GL9Uda1zehpm7pPEcBPUqJ8PWXGRcUoEIk=
X-Google-Smtp-Source: APXvYqxQhMHyd5fzxHb7YY9144wnAYkn7ccaiqbgIb58pfFeqdV1XITut7y3NyOFYTba9y9bUZ0nYGzfRgNuXEGoccc=
X-Received: by 2002:a02:c64a:: with SMTP id k10mr18804347jan.30.1556189027591;
 Thu, 25 Apr 2019 03:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com>
In-Reply-To: <87k1fis8gq.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 Apr 2019 17:43:21 +0700
Message-ID: <CACsJy8DSvEPfqJVGBL=G147B-mqoXd-XDeNK7jQZLQgRftWRpQ@mail.gmail.com>
Subject: Re: How to undo previously set configuration? (again)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> Solving (1) without (2) feels like a bit of a missed opportunity to
> >> me.  Ideally, what I would like is
> >>
> >>    i. A central registry of trustworthy Git hooks that can be upgraded
> >>       using the system package manager to address (2).  Perhaps just
> >>       git-hook-* commands on the $PATH.
> >>
> >>   ii. Instead of putting hooks in .git/hooks, put a list of hooks to
> >>       run for each event in .git/config.
> >
> > The problem I had with this when discussing it was that our
> > configuration system lacks a good way to control inheritance from outer
> > files. I recently was working with a system-wide gitconfig file that
> > referred to files I didn't have, and my Git installation was subtly
> > broken in a variety of ways.
> >
> > If I have a system-wide hook to run for company code, but I have a
> > checkout for my personal dotfiles on my machine where I don't want to
> > run that hook, our configuration lacks a way for me to disable that
> > system-wide configuration. However, using our current system, I can
> > override core.hooksPath in this case and everything works fine.
> >
> > I mentioned this for completeness, and because I hope that some of thos=
e
> > people will get some time to chime in here, but I think without that
> > feature, we end up with a worse experience than we have now.
>
> I sent a proposal for this last year "How to undo previously set
> configuration?":
> https://public-inbox.org/git/874lkq11ug.fsf@evledraar.gmail.com/

While reading that mail, it occurs to me that perhaps we can reuse the
.gitignore idea.

Instead of having a list of untracked files, we have a list of config
keys. Instead of having .gitignore files associated to different
directories to apply the rules to those dirs only, we have ignore
rules that should apply on certain config files (probably based on
path).

A few differences from your reject/accept/priority example:

- we don't redefine priority, inheritance rules apply the same way
- reject/accept is handled the same way as positive/negative ignore
rules. If we're lucky, we could even reuse the exclude code.
- instead of special section names like

    [config "section"]

we have something more like

    [config "/this/path"] # (or pattern)

this lets us handle even other config files included by [include] or [inclu=
deIf]

So, some examples

[exclude]            # exclude from all inherited files
    key =3D core.*     # exclude core.*
    key =3D !core.bar  # but keep core.bar

[excludeIf "path:/etc/config"] # rules apply for only this file
   key =3D ...

[excludeIf "glob:/home/*"]     # rules apply for these config paths
   key =3D ...

[excludeIf "system"]           # special names for convenience maybe
   key =3D ...

> Obviously the main bottleneck is someone like me working on patching it,

Yes, manpower is always the problem.

> but in this case it would be very useful if those who are interested in
> this could look that proposal over and bikeshed it / point out issues I
> may have missed, i.e. "no, this categorically won't work with this
> proposed syntax due to XYZ you haven't thought of...".
--=20
Duy

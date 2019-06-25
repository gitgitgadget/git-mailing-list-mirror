Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68E11F461
	for <e@80x24.org>; Tue, 25 Jun 2019 01:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfFYBih (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 21:38:37 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35721 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfFYBih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 21:38:37 -0400
Received: by mail-vs1-f65.google.com with SMTP id u124so9842153vsu.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YW/z+A+WVb9sh4NhFCLMuwhDALL/PCa8CM3V4kDLUno=;
        b=Z2qRTFI/GeFwC01GqunES6LGWkFxSLaRWWrq8pbgOR/qG4RAinnovfc3gxGn18jmBn
         To1mOGaHWaIKIeATnA/pOERIZbH1evNLR29ZCEEFtcKu1nuFABJAMnXZ/4utqCmmRVVJ
         tZkUiCHvmHZZvSxWFZMCqBG+X8qdmhya/0LR0Pli3nvBEqwOewikQpr3IbAh14LrOXan
         qYXcX7rfPSWiz5MkSxradlwVPXcnZ0vQrshyDr98Nr9uf+GV8qng/03qPCYKnPWZH0Y/
         +/7oSWstfa+Q2/v7EoBMyV8e5xJxqAgNzvV/jPt78v9/YlP1vznrxQck3fPmtc+dJ/AR
         7HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YW/z+A+WVb9sh4NhFCLMuwhDALL/PCa8CM3V4kDLUno=;
        b=Mz6rErYoVCOpL4ZwbHxmaENq2sP1JPzGbk5XjPvsmuzKtaGbb0F3ArFBu5gfSLYljv
         w25kxSvvNs8ICwWzwzD+3dfU5nXhGo4pQ96b5+3VwP6O+WcOegDXEPfxysgv9f7zjM+F
         lvK/0/sYYDR2JfnLdW+R0BnN8uwWBgntgVJtW05EJL505OWrqydcGC8AaDbsKIxqGc+x
         6++aGPoAUrk0jhDEE7pB72MNTUpUTs138SmLS4NxjgIfFCEchlQSfypGT45AnIwxSlcX
         3vpgv3gax8TZg+93EQc9N8Sm25Fn1R4Yr+InOGf9FtB3bR/hIogWupIkZspLuji10oXK
         kwfw==
X-Gm-Message-State: APjAAAX6Dy9w1ai2b9tRVQIuo67MmXRZTIT0NWu1gre/O/PeU2dnIEtx
        335NozAcuIql+HI53rcVQdgDliZzXIutm1nfG961l/86tAU=
X-Google-Smtp-Source: APXvYqw/XIS5koPe0w+Uz8w6tIsuzBwiYl91pSJWaXeC1bvbGUYdQm43UfBHjRlIGs5dL4+pE+QzqE1/lmDGlDq+1+U=
X-Received: by 2002:a67:df8a:: with SMTP id x10mr14905422vsk.220.1561426716303;
 Mon, 24 Jun 2019 18:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <20190621223107.8022-14-felipe.contreras@gmail.com> <CACsJy8AATA-7Z+HsA80NQ2j4Z9JeuSYXiBZLi=7FopzfLY1R+w@mail.gmail.com>
 <xmqqa7e6j3u1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7e6j3u1.fsf@gitster-ct.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 24 Jun 2019 20:38:25 -0500
Message-ID: <CAMP44s1hJZs3z=6aHJPzrbW05S=hmVE4RrcRBETzz7iCCqEPPg@mail.gmail.com>
Subject: Re: [PATCH 13/14] completion: add default options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 12:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Sat, Jun 22, 2019 at 5:31 AM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >>
> >> Versions of Git older than v2.17 don't know about
> >> --git-completion-helper, so provide some defaults for them.
> > ...
> >> +__gitcomp_builtin_add_default=" --dry-run --verbose --interactive --patch --edit --force --update --renormalize --intent-to-add --all --ignore-
> > removal --refresh --ignore-errors --ignore-missing --chmod=
> > --no-dry-run -- --no-verbose --no-interactive --no-patch --no-edit
> > --no-force --no-update --no-renormalize --no-intent-to-add --no-all
> > --no-ignore-removal --no-refresh --no-ignore-errors
> > --no-ignore-missing --no-chmod"
> >
> > And who's going to keep these uptodate? If you do this, might as well
> > delete --git-completion-helper
> >
> > A more acceptable option might be regenerate git-completion.bash and
> > run --git-completion-helper to generate these, or make
> > git-completion.bash source a generated file.
>
> Nicely analysed and summarized.  What kind of target audience are we
> talking about?

The people that install their completion independently of their
distribution. A quick search in Stack Overflow shows hundreds of
questions, many related to Homebrew and Cygwin.

> What's the payoff vs cost comparison trying to
> catering to those who install more recent completion script that
> requires the --git-completion-helper option without using antient
> Git?

You use the adjective "ancient", but is it really? The current Ubuntu
LTS release uses
2.17.1, the previous one (supported until 2021) uses 2.7.4, the
current Debian stable uses 2.11.0, and the previous RHEL uses 2.3.5.

Travis CI runs 2.15.1 by default.

If you are going to call these "ancient" what would you call the
current version in Debian oldstable? 2.1.4.

Not everyone is a privileged as us.

> If the cutoff boundary is 2.17, that is more than year ago, and the
> boundary gets further and further in the past as time goes by. Also,
> depending on how old the version of Git the target user runs, these
> hardcoded and manually listed options may not yet even exist in
> their binary.

Indeed, the need for these defaults will diminish over time, but
*right now* people are running versions of Git older than 2.17, for
sure.

And yes, it's possible that the completion will return an option that
doesn't exist yet in the user's version of Git, but historically that
has always been the case regarding Git completions (at least until
git-completion-helper).

So what would you rather have? a) return potentially non-existent
completions, or b) don't complete anything?

Another idea I had is to have a separate 'git completion-helper'
command that could act as a proxy for `git cmd
--git-completion-helper` and `git --list-cmds`. The completion would
throw a warning if such command is missing, then, the person that
installed the completion would have to find a suitable `git
completion-helper` command. We could provide an "example" script that
contains all these defaults. People could modify this to generate the
correct options for different Git versions. Realistically though, most
people will just use the defaults for the latest version, but at least
the responsibility is not on your side.

Cheers.

-- 
Felipe Contreras

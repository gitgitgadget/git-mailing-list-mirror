Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D60C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9569D613B3
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFXU2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:28:09 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:46710 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhFXU2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 16:28:08 -0400
Received: by mail-qk1-f173.google.com with SMTP id 19so6457560qky.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 13:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHWhBCAOAQJSieu8HGp52SqfWmBaHHS/y26d5DrXQ30=;
        b=HmDU3hmRmKYyOp5Qgk1gg06i/Whzu220+I9UBLanOewVsDWUXQAJQ11wa/v4hla0JH
         7d098VQBZ+B5ndUmWaVYX4PQkto7OjhfZJBYR4idmyMYrgQax9xV86M/wV/pB2Q7lkNI
         YaqkV6dm4FAUS0PHy/+HlBLbhLGv0yhtBTBXX/dMAmS8kSwAVrMMQ8g6EY7Rcppcmdcp
         9N3hmPHLYXAsNgvx6OPf5xgH3UCshqA/gtngAPmyhR11JG11tBlbqEH+A9YIljZ2Snnh
         unzPYXWj3GDYhHg8EOr+HXZNu3n7HDP4MARr8dOpnoE9ZjkXzEje2Ny1q7MVRtun3/QZ
         FIVA==
X-Gm-Message-State: AOAM531cg6fLDl63SCuxy0+ubijUP6y8vztPqwvxYZM84B9lQuK3G1JD
        9Z3U4am57b9sv66dQHm1qU+J9VUtgqc=
X-Google-Smtp-Source: ABdhPJzMjSo/gSAq9WL8ywLObGI5TqbnJVGQeeT/o4fD/eFxJ2zZgYyuBkXYXuy28Cgel31u/vvVxA==
X-Received: by 2002:a37:f502:: with SMTP id l2mr7592398qkk.195.1624566347480;
        Thu, 24 Jun 2021 13:25:47 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id t185sm3347754qkh.95.2021.06.24.13.25.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 13:25:47 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id x21so5843585qtq.9
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 13:25:47 -0700 (PDT)
X-Received: by 2002:ac8:5f93:: with SMTP id j19mr6444331qta.298.1624566346799;
 Thu, 24 Jun 2021 13:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <077d147c-c22f-6463-6545-3aa991e7868b@gmail.com> <b5462f20-5d9d-4775-ad5c-c8de686167af@gmail.com>
In-Reply-To: <b5462f20-5d9d-4775-ad5c-c8de686167af@gmail.com>
From:   Avishay Matayev <me@avishay.dev>
Date:   Thu, 24 Jun 2021 23:25:35 +0300
X-Gmail-Original-Message-ID: <CAJ-0Osy9JhGD0=6eF3jgZuoHJEzymksCWZZZC+A4FtHxzOrdhA@mail.gmail.com>
Message-ID: <CAJ-0Osy9JhGD0=6eF3jgZuoHJEzymksCWZZZC+A4FtHxzOrdhA@mail.gmail.com>
Subject: Re: Forcing git to use a pager without a tty
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Phillip!


On Wed, 23 Jun 2021 at 12:29, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 23/06/2021 10:05, Phillip Wood wrote:
> > Hi Avishay
> >
> > On 22/06/2021 23:40, Avishay Matayev wrote:
> >> Hi there!
> >>
> >> Fugitive[1] is a vim plugin that wraps git and many of its commands
> >> into the editor in a really awesome way, I won't meddle into it too
> >> much as you can read about it in its README, but as you understand, it
> >> uses git, a lot.
> >>
> >> Some git commands use a pager, which is usually a program that needs a
> >> pty to function properly (`less`, for example). Fugitive can't really
> >> use a pty for the pager as vim runs its subprocesses without a pty.
> >> Therefore Fugitive just creates its own pager (which is a simple
> >> window in vim) and pastes the git command output there.
> >
> > If I understand correctly fugitive is reading the output of the git
> > command over a pipe and putting it into a vim buffer?
> >
AFAIK, no. It could read the output through vim's jobstart API (that calls a
callback when there's activity on stdout for example) or by
redirecting the output
to a temporary file and reading it.

> >> The only problem left is that Fugitive can't reliably know when git
> >> decides to use the pager, for example `git reflog show` does raise the
> >> pager while `git reflog expire` does not. Fugitive currently maintains
> >> an (very possibly) incomplete list of commands that need a pager but
> >> maintaining it manually isn't ideal.
> >
> > I don't understand, if as you say above there isn't a pty then git wont
> > use a pager unless GIT_PAGER_IN_USE is set which Fugitive does not seem
> > to,
>
> Sorry that is confused. GIT_PAGER_IN_USE only causes git to act as if a
> pager is being used (for example so it colors things as if it was
> outputting to a tty), it does not invoke the pager
>
>   so I'm not sure what you mean by 'Fugitive can't reliably know when
> > git decides to use the pager'
>
> I'm still confused by this - if there is no tty git wont use a pager.
>
That's the problem, git doesn't tell whoever calls it if it is going
to use the pager,
and that information is useful for Fugitive. Why? Because even if
fugitive just naively
reads git's output, it doesn't know whether it needs to open a pager.

i.e If the user calls `git log`, the log is printed through the pager.
However, if a user
calls the exact same command through Fugitive. Fugitive needs to know
ahead if the
resulting command is going to need a pager (AKA a new window in vim) and prepare
accordingly. However, since git does not tell us when it's going to
open a page, we
have to book-keep commands and whether they are going to use the pager or not.

> Best Wishes
>
> Phillip
>
> >> I started discussing this on an issue in Fugitive's github page[2] and
> >> Tim Pope (the creator and maintainer of Fugitive, thank you!)
> >> explained that `git` doesn't use a pager if there is no pty so it's
> >> impossible to override its behavior.
> >>
> >> We had some ideas how to make this feasible (as you can read on the
> >> thread) but for brevity's sake I'll present the best (IMO) idea:
> >> Essentially, at `pager.c`, don't short-circuit in `git_pager` (or
> >> `setup_pager`?) due to pty absence if a new environment variable is
> >> present, perhaps something like `GIT_PAGER_FORCE` which will override
> >> the `PAGER` and `GIT_PAGER` variables. This will allow Fugitive to
> >> apply custom logic through to pager to know if one exists and present
> >> the window in vim.
> >
> > I note that the latest comment [1] on the github issue talks about a
> > different solution that would cause all git commands to behave as if
> > there was a pty present.
> >
I hadn't seen that comment when I submitted the initial mail, and in fact - this
might actually be a better solution for this problem (and several others). If we
can force git to think that it has a pty stdout, even though it
doesn't. We can just
read its output and convert it to the way we want it displayed in vim.

> > [1]
> > https://github.com/tpope/vim-fugitive/issues/1772#issuecomment-866401942
> >
> > Best Wishes
> >
> > Phillip
> >
> >> I will appreciate any written thoughts on the matter, thank you :)
> >>
> >> P.S. I am a complete newbie in regards to mailing lists etiquette,
> >> pardon me if I've done anything incorrect
> >> P.P.S. I CC'd Junio C Hamano because he signed off on (almost?) all
> >> changes to `pager.c`, sorry if that was wrong of me (You probably got
> >> this mail twice because of a misconfiguration, oops)
> >>
> >>
> >> 1. https://github.com/tpope/vim-fugitive
> >> 2. https://github.com/tpope/vim-fugitive/issues/1772
> >>
>

1. https://github.com/tpope/vim-fugitive/blob/79e2bd381ad6e7f3d70ce4a8ec9f3f107b40f053/autoload/fugitive.vim#L2951-L2956

This is the current proposal:

--- a/pager.c
+++ b/pager.c
@@ -45,7 +45,8 @@ const char *git_pager(int stdout_is_tty)
 {
        const char *pager;

-       if (!stdout_is_tty)
+
+       if (!stdout_is_tty && !(is_terminal_dumb() &&
git_env_bool("GIT_FORCE_TTY_DUMB", 0)))
                return NULL;

        pager = getenv("GIT_PAGER");


Avishay

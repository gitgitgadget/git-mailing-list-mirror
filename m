Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B693F1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBAWqA (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:46:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36252 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfBAWqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:46:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so5145143qkf.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4avqAN++2NzbM58LCQjB7XDA1MHW1YiaiH7T1LaPnI=;
        b=sCDWermIb7d7A400gUHnynba9LExecfZRRoFgoA9OyWjKy5yMC5xGJmyhapwn4/qDt
         nlWD4xgstKlDCqkOp37W+SFyYzq9QLU5uMWSBdBcYJYQizDGll8pQ3KaYkp2RcUqRnTG
         3b+H7xk/PaJEq5fsEC1omPX2CJUqhfJwt3qBxWMtFfwf+bMpi6gFlZOv9VDD5l+PcaV6
         PY5EhQZ2HqWVx75e2fJEz+dUyI4eSYgPV+u1FQOy4bkNX628bEVD6CcoKv8e34gsocSC
         Ni5kOvu8LGzQbhf3FTnS2BnUeVZ0v/yXrR0ziyAfpSqjXTiLcMqnW/6CoRHEtADIklNQ
         2TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4avqAN++2NzbM58LCQjB7XDA1MHW1YiaiH7T1LaPnI=;
        b=ORT7D3vFDpEX0hgfZPaGUWAlqrDygdDctMGUCpZKznaJAIBvqTLSc8YE6ZjLYDDcGM
         cnn5cLzjn4HJeSVcLtYSQVeszDqW8XKtgY+eK8LqanzNGKhamxQgJB0Qk3aA1hqi7Yx0
         7ZN+1nXKLyDgw3TS3ZtuC3qeVwPvoQwcjukkjni1ie5+bKxM3/RDEBQOJudnhiAkaluX
         nypiOKFWsCBWvVFvzYnCLrzRRmvOWtPUkiCKAES9ZSBdAPITDQCZCL5RfoUDz30YLzxz
         TX0/inkPqWLjScdObtrO6/4CdXFTAa+6FBW1NW+5ERbCc4RASceATe84537RVszdTQSb
         3Wew==
X-Gm-Message-State: AJcUukdFwxHeHymRKARAWEOJCxUn/+76LHZk1/L5UUKi3Jc97GGZ6AhG
        TtesVqTqiNIV87qpoGi6rYcbvbWUiePzkw4siT0=
X-Google-Smtp-Source: ALg8bN5s0UdKF2ae+fvvCDeq8Sw2+tUoTVzI/OAe3XSTkEb5UICcoDvjiIMasz6ad67+pdN8hA4Ygdtu3FLQS8Xv66M=
X-Received: by 2002:a05:620a:151a:: with SMTP id i26mr37494333qkk.281.1549061159371;
 Fri, 01 Feb 2019 14:45:59 -0800 (PST)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-1-nbelakovski@gmail.com> <20190201220420.36216-4-nbelakovski@gmail.com>
 <CAPig+cT0OY3vcjjoMUjaZ9JhJ2nKqyqbv4qL1ExiDw3h5GUw4Q@mail.gmail.com>
In-Reply-To: <CAPig+cT0OY3vcjjoMUjaZ9JhJ2nKqyqbv4qL1ExiDw3h5GUw4Q@mail.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 1 Feb 2019 14:45:31 -0800
Message-ID: <CAC05385Kr7Sg7fwNx+EUkfTKoPHBiguE0HTP4faFwvAQYnKckA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] branch: Add an extra verbose output displaying
 worktree path for refs checked out in a linked worktree
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 2:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Feb 1, 2019 at 5:04 PM <nbelakovski@gmail.com> wrote:
> > Subject: branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
>
> Overlong subject. Perhaps shorten it to:
>
>     branch: display worktree path in -v -v mode
>
> or something, and use the longer description as the rest of the body
> of the commit message.

OK

>
> > Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> > ---
> > diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> > @@ -167,8 +167,10 @@ This option is only applicable in non-verbose mode.
> >         When in list mode,
> >         show sha1 and commit subject line for each head, along with
> >         relationship to upstream branch (if any). If given twice, print
> > -       the name of the upstream branch, as well (see also `git remote
> > -       show <remote>`).
> > +       the path of the linked worktree, if applicable (not applicable
> > +       for main worktree since user's path will already be in main
> > +       worktree) and the name of the upstream branch, as well (see also
> > +       `git remote show <remote>`).
>
> I'm not sure I understand the "not applicable" explanation. When you
> say "user's path", do you mean the current working directory? What
> happens if the command is invoked from within one of the linked
> worktrees (not from within the main worktree)?

I should correct that to say "current worktree" as opposed to main,
since that's what HEAD will give. And yes user's path means cwd. Does
that make more sense?

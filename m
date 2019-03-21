Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737E020248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfCUN6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:58:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40321 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUN6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:58:45 -0400
Received: by mail-ua1-f66.google.com with SMTP id b8so1941249uaq.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EZjxbw6XOsmy2EFz9Vp5+XgpS8MaH9Hbz+7k36voKKg=;
        b=Klv/kb4VQ5lNCm4yjdjiDFPTZXiII0/NxxKUGMSDrFo+2741C8mCNvkbp26N4AKdqr
         qw1SijmwretO5at8LThq1mUdP0eLLcRPVgHI+P/5jsxYRpT9P2wnwHb84DhhzfrTvkdT
         x4aOCMAGPggX/SOJRDxsUshlZaqWv/aAZzYhAcgc5MMrlsSiQ9SztNsnV7ncEchnDqGC
         pgFFs7cMxvDt8W/qsCb/QERhkOlaEptE1XHL1i7Ylxkpn5W81xi0ddXqC3/O4UApAD65
         eRuKarD/0Uqc0GSGRwIwsEJtr0RL2igDV25M/4IFau64uHguEgin0SwjyZaGZhrEj4Ca
         g3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EZjxbw6XOsmy2EFz9Vp5+XgpS8MaH9Hbz+7k36voKKg=;
        b=SBgIHV+w8Cex2+gCEpyOfQhK7mbIUPEGlOc/AREqfVKdGDDw4HTiBMWWr4a7IQbDSB
         I+nJPabQehdwVjdmIWf3M36uLL6DcKNpoY+4L6sZN0hasLB3BoQcSnKc11Az35Y2Hu20
         FaMgatCZsz+3b/mBJH+HPbosRja6rPabp34ROf+t5ug4pna3JbHiv7xxu8Tl/3A0KdGN
         9JGZKLi0LKl2VdsDp7zMxe2ooRs47RAt34ik8jQfza+g2EQOkd4sVgzsVWuwlRWr+Zy5
         qxbWCFT4dI6eZH3ZNajYcgqiEj3aPNyaWQpN9YpsyGo2/1zGlB82hIAIlc5Cg4hZQW9q
         3OrQ==
X-Gm-Message-State: APjAAAVdxBJKIJflHXUFfrB1nNByKo2lAdhEHgzZwm5vWfCLG4e1A+r6
        4/Cvx9Nv7ulNCM9hgXI7BJPCRg6dP6bGKd3NV2k=
X-Google-Smtp-Source: APXvYqzgLZ5F1MZSkW4YFJvh9gwFdE42jWg2X13t5MDnzUFaxiHREbMHChkBfAsmf5BanAq8GACIVIQH/6A6bbjXVt4=
X-Received: by 2002:ab0:85e:: with SMTP id b30mr1875420uaf.108.1553176723469;
 Thu, 21 Mar 2019 06:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
 <CABPp-BEy9nN=aV8Y+ueYqv299umHoF2E=8D7heJARM4Qa7P5JQ@mail.gmail.com> <20190320172809.GA17593@dev-l>
In-Reply-To: <20190320172809.GA17593@dev-l>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Mar 2019 06:58:31 -0700
Message-ID: <CABPp-BGg_iSx3QMc-J4Fov97v9NnAtfxZGMrm3WfrGugOThjmA@mail.gmail.com>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, Mar 20, 2019 at 10:28 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Elijah,
>
> Sorry for the late reply, I've been mulling over it for the past couple
> of days.

No worries; thanks for thinking about it.

> On Mon, Mar 18, 2019 at 10:59:56AM -0700, Elijah Newren wrote:
> > On Sun, Mar 17, 2019 at 4:09 AM Denton Liu <liu.denton@gmail.com> wrote=
:
> > >
> > > The documentation used to consider
> > >
> > >         git diff <commit> <commit>
> > >
> > > and
> > >
> > >         git diff <commit>..<commit>
> > >
> > > to be equal counterparts. However, rev-list-ish commands also use the
> > > <commit>..<commit> notation, but in a logically conflicting manner wh=
ich
> > > was confusing for some users (including me!).
> > >
> > > Deprecating the notation entirely is not really an option because it
> > > would be an arduous process without much end-value. In addition, ther=
e
> > > are some valid use-cases that we don't want to break.
> >
> > Yes, there were multiple people who commented that they liked to
> > copy-paste the "A..B" output from fetch/pull in combination with diff
> > and log (even though one suggested that this gave the wrong output and
> > what they really wanted was "diff A...B").
> >
> > However, "removal of functionality" isn't the only form of
> > deprecation/warning.  Updating the manpage is another one which you
> > implemented, but I'd like to suggest yet another: Prefix the diff with
> > a warning message, e.g.
> >
> > "WARNING: You ran 'git diff A..B' (which means the same thing as 'git
> > diff A B').  Many users confuse 'git diff A..B' and 'git diff A...B'.
> > Please see 'git diff --help' for more details."
> >
> > Having extra text (e.g. commit message or warning) at the beginning of
> > the diff does not prevent tools like patch(1) or git-apply(1) from
> > successfully applying it, it still makes sense to humans (and who as
> > an added bonus happen to be really good at filtering out common
> > messages if they do encounter them more than a few times), and gives
> > us a chance in the future to figure out how to potentially extend the
> > message to make it a deprecation warning and/or provide details about
> > how to change the behavior of '..' to either be an error or behave
> > like triple dots or just not warn.
>
> I was originally planning on doing something like this (by warning to
> stderr, but your idea actually gets to the user ;) ). The only thing I'm
> worried about for a change like this is that it'll be very controversial
> since, as we could see anecdotally, a lot of people have trained
> themselves to use the .. form.
>
> In terms of backwards compatibility, I think that there's the
> possibility of breaking some scripts by doing this change but we could
> mitigate this by detecting if we're outputting to a terminal and only
> print the message in that case.

I don't see why anything would break if we just always showed the
warning.  git diff's purpose is to create a "patch", and as such can
be used by the patch(1) command.  We added additional headers in 'git
diff' relative to diff(1), but it's still understandable by patch.  We
also created git-apply because it could potentially make use of the
extra headers to do slightly smarter stuff than patch.  But both allow
arbitrary extra initial text as long as it doesn't have the relevant
start-of-next-diff-hunk characters.  Extra text at the beginning (an
explanation or a commit message or a warning or whatever) thus doesn't
change it from being a valid patch.

Human beings will see a little extra text by default, but they already
usually skip right over the diff headers when reading; this is
essentially just another diff header.  And we could provide them with
a config option to turn it off if they used it all the time and found
the two extra lines of text annoying.

Since both =C3=86var and I noted that even among people who use '..' lots
of them use it erroneously, it seems like a worthwhile warning to add,
to me at least.  That is, unless I've misunderstood my purpose of
'git-diff' as creating a patch or missed something else important.


Anyway, just my $0.02.  (And I'd be happy to take this on later if you
don't want to).
Elijah

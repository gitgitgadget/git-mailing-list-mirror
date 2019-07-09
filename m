Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57801F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGIXfv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:35:51 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33425 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGIXfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:35:51 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so316004vsj.0
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XKJpus/7loaH4KVi7h8DjtIaANhK7FGlTRvRjTzT14=;
        b=ZT6uVUZA+kXRxUBXD/Kw/HpAQu5kBC3lAtLM/Htxk+ZXVLn6QQONMbs+U5otIJUBvp
         Sa5676xVSH3RQ4BX/fVFnOxd9lII/FJYkuxrHTZFkLEaHO4D5X9RQOyy0z4xoAhpZ6tB
         MXK8AsT2bU91FTdnJtFUrti+mKMizaCL8f/KOIcI2b+Ul+H+VGXl3wwzouYXbuc4NxD0
         rQrQ2Ocgb+0vAgXfoOEqBkNfrATHNwPWZvlWHuGUnN3oIBPoKDaFjcCvxssHXC5x3iXc
         ocO/l7ZrrXuSZAnCP4Y/18N84DRxOpMwqsSEIvWApp/Pq4GUxk41wwN9le0R57OrSxyo
         5xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XKJpus/7loaH4KVi7h8DjtIaANhK7FGlTRvRjTzT14=;
        b=Y6eQdF2LlB+gIvIiw5SD4HRT0tlUkS+YtwAI6hAbJHfxLKMApHJE3UJdWzKV9rt49V
         2k/RppDEZLU+7fip0uwl7RXcups7eDphTKxCwbS1CvkHkX4rwP4ZCYdgeWaJIHs6PYHm
         tRYAHZrYvx+oDiryYIXCF5bxJdyLvvIRRuSdHybb6+/rdFmfbkMnPviEIz03xsNnjGXc
         3GFDlLDU4F4MdPpwTpKFtvndw+UnSLTfGOvamkaDZi9sEH0OjDU9L1HhZWmgd7cZqlj7
         JHegXL3IcDeC2kLdwXjAQKS2iSHQJJuW5e3Cp1J/w6f7QyF3WahScS+uWUetOjt9GO+b
         KNrQ==
X-Gm-Message-State: APjAAAWQml9g5qTeh71uh7L2p3ruIgSxkoITNdgl9BX4iF9XB5mbMhA2
        PDUZl1DtJBE8WsRXJOV8kvCIENmPnt7n+ONyPik=
X-Google-Smtp-Source: APXvYqy54mw4DJcOfbYvL21h4zqKPIZKjTt+mqGmyZnwqjDfrYLNREg3gr4D5ST7A9jxiyEEPiPQBqmSRRMMbJbOosI=
X-Received: by 2002:a05:6102:252:: with SMTP id a18mr16193647vsq.53.1562715350231;
 Tue, 09 Jul 2019 16:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <1288734232ea45e0be655668ac60d98f@ASGEXCPWP07.ga.com>
 <CABPp-BE1fQs99ipi9Y8gfQO3QHkxzQhn1uriEbj6YjdYH839eQ@mail.gmail.com> <CAGyf7-FeAJwWuhu-Zkccsfrcbbf3tuuOWwobsa4OOK1=hWackg@mail.gmail.com>
In-Reply-To: <CAGyf7-FeAJwWuhu-Zkccsfrcbbf3tuuOWwobsa4OOK1=hWackg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Jul 2019 16:35:38 -0700
Message-ID: <CABPp-BETbfzjUyYu9g83=u+HN9r3jwpK538EcOEiawBLG=uwDA@mail.gmail.com>
Subject: Re: Problem with git diff
To:     Bryan Turner <bturner@atlassian.com>
Cc:     "McRoberts, John" <John.McRoberts@ga.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 9, 2019 at 4:30 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Tue, Jul 9, 2019 at 4:13 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > Hi John,
> >
> > On Tue, Jul 9, 2019 at 3:57 PM McRoberts, John <John.McRoberts@ga.com> wrote:
> > >
> > > I am responsible for generating a list of all files changed between two
> > > successive releases of software. I was using 'git diff' but have run into a
> > > problem.
> > >
> > > Consider the following situation: A development branch comes off of commit A
> > > and files are changed three times.  A tag (REL1) is placed on the third
> > > commit.  Then the branch is merged back to master.  At this point, master's
> > > HEAD is at C (and it remains there).  Two development branches are created
> > > off of master, the first of which is not important here.  In the second one,
> > > there are files changed and a tag (REL2) applied.
> > >
> > >
> > > ---------------------[I]
> > >
> > > /      {dev branch}
> > >
> > > /
> > >
> > > /
> > >              {master branch}
> > > /
> > >  [A] ---------------------------------[B]------------------------------->[C]
> > > master <HEAD>
> > >    \                               filelist 6                           /  \
> > >     \                                                                  /
> > > \
> > >      \                                                                /
> > > \
> > >       \                                                              /
> > > \
> > >        \                {development branch}                        /
> > > \
> > >         \------->[D]----------------------->[E]-------------------[F]
> > > \------[G]--------[H]
> > >                                                                  REL1
> > > REL2
> > >                 fileset 1               fileset 2           fileset 3
> > > fileset 4    fileset 5
> > >
> > > At this point, I run
> > >     'git diff  -m --first-parent --pretty=fuller --decorate=short
> > > --name-only REL2..REL2'
> >
> > Wow, we really, really need to throw errors and warnings when people
> > use crazy range operators with diff.[1][2]  What version of git are
> > you using that accepts --decorate=short as an argument to `git diff`?
> > And why in the world does git diff accept --first-parent or
> > --pretty=fuller?!?  That's insane for git-diff to swallow that.
> > (#leftoverbits?)  Also, I think you meant `REL1` one of the two times
> > you wrote `REL2`, which makes me suspect you may have done some
> > copy-edit-paste and didn't try this actual command.
> >
> > > I expect to see only filesets 4 and 5 listed.  I also see filesets 1, 2 and
> > > 3 showing up.  This means that the git diff command is showing files that,in
> > > fact, did not change between the two tags.  By the way, I verified with a
> > > file by file comparison that under REL2 and REL1, the files represented by
> > > filesets 1, 2 and 3 had identical contents.
> >
> > From your description, I assume you actually ran something like
> >   git diff --name-only REL1..REL2
>
> Did you mean REL1...REL2 (3 dots)? 2 dots (REL1..REL2) is identical to
> no dots (REL1 REL2), per the documentation for "git diff":
>
>        git diff [<options>] <commit> <commit> [--] [<path>...]
>
>            This is to view the changes between two arbitrary <commit>.
>
>        git diff [<options>] <commit>..<commit> [--] [<path>...]
>
>            This is synonymous to the previous form. If <commit> on one
> side is omitted, it will have the same effect
>            as using HEAD instead.
>
> (Forgive me if I'm mistaken here!)

Yes, thanks.  In trying to explain how two and three dots behave
contrary to expectation for git diff, I mess up two versus three dots.
That's kind of embarrassing...

> > which compares REL2 to the merge base of REL1 and REL2 (yes, this is
> > totally counter-intuitive to a large percentage of the git userbase,
> > but it is well documented and hard to change).  Also from your
> > description, what you seem to want is
> >   git diff --name-only REL1 REL2

...though at least I was smart enough to suggest something without
dots, which is the only sane way to use git-diff.  ;-)

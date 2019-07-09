Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646741F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfGIXaH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:30:07 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:40369 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGIXaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:30:07 -0400
Received: by mail-io1-f48.google.com with SMTP id h6so682124iom.7
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtbJEyLC8x305jOVN6jEjAagLcySg7/bYUGm0eVd6TI=;
        b=RRQr/rfh5pNXrXy0KJI1xfCp64c7xkjVdgxp7XElxku2O/8vZh50Mo52GElUnt0GVs
         8ARubx5nk3PxB6JBjmQzcnxsTKTJLPUbHN9Jtl3maWT7msHBVhMmKgcfjZxgLvfVfgOF
         d+8Aqfm7400KuwGaG28VnOEjPb7BpK+IXAiPznAY8JnhLKVI96Hm3QJriWhrPKfUKFO5
         5WELaOjpI4x9AiV5ZNZhUH5l6b7nFdUZ/zwzPoGtIG6Hzmp/hocKaDiGyT7fmC6wMnyX
         /fIGdAEzqVfg3BGWO5PcvzpKIAPkt8YFIDSSWW8+uO3gY4wOZGh9hVX57Qs8VM7tXFS9
         IfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtbJEyLC8x305jOVN6jEjAagLcySg7/bYUGm0eVd6TI=;
        b=PXESwBxqxUmsQKCX29+IZOdLIs6Oi7iEFUK28boD0vsHRWw7gTxi/DRzNVSEeL3JoN
         iID/ARYXhG+RGipHZaWwSowm5Y6ES8qdhjcXRxIcKNLGa5LT1RffSoU12HLcWXmLw0Ev
         w/Dw8+J88kh2EEj3MTISpB+VN42KoS9RZUP1Fuc+qNiuhTeHOplmUIjYBMyb33zlcclq
         VUL6ml3S8fXlw5PB+ujSPDyh8k3IQhxKt3O/xE7Xk6jN4lIAYdz20AAqreWCYdYNvo4g
         5iNyPKlzrI9F+t4BWbM4ZeljNut5a3G/FHsKvbW67Y+KJpnJgvcRtPN8wfShs6Z1n6++
         EwFg==
X-Gm-Message-State: APjAAAUYMwlIOt3lP9+EEb4nT5ZkvymSMXJ/vd5uNOixwDf4Uf5SD6JT
        TfgiB9VURWW03RH9GtI1czYWKKCFNjyjFBgkmbz6zg==
X-Google-Smtp-Source: APXvYqzMi1O8B1u5hHCTFiFft6LxVPKr+1Z8PbhPdxsL8pYu/NT/iAAuhDo+7P8yImX+7S1DTfflTvF/plvZzrncJP0=
X-Received: by 2002:a6b:5106:: with SMTP id f6mr616631iob.15.1562715005841;
 Tue, 09 Jul 2019 16:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <1288734232ea45e0be655668ac60d98f@ASGEXCPWP07.ga.com> <CABPp-BE1fQs99ipi9Y8gfQO3QHkxzQhn1uriEbj6YjdYH839eQ@mail.gmail.com>
In-Reply-To: <CABPp-BE1fQs99ipi9Y8gfQO3QHkxzQhn1uriEbj6YjdYH839eQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 9 Jul 2019 16:29:55 -0700
Message-ID: <CAGyf7-FeAJwWuhu-Zkccsfrcbbf3tuuOWwobsa4OOK1=hWackg@mail.gmail.com>
Subject: Re: Problem with git diff
To:     Elijah Newren <newren@gmail.com>
Cc:     "McRoberts, John" <John.McRoberts@ga.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 9, 2019 at 4:13 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi John,
>
> On Tue, Jul 9, 2019 at 3:57 PM McRoberts, John <John.McRoberts@ga.com> wrote:
> >
> > I am responsible for generating a list of all files changed between two
> > successive releases of software. I was using 'git diff' but have run into a
> > problem.
> >
> > Consider the following situation: A development branch comes off of commit A
> > and files are changed three times.  A tag (REL1) is placed on the third
> > commit.  Then the branch is merged back to master.  At this point, master's
> > HEAD is at C (and it remains there).  Two development branches are created
> > off of master, the first of which is not important here.  In the second one,
> > there are files changed and a tag (REL2) applied.
> >
> >
> > ---------------------[I]
> >
> > /      {dev branch}
> >
> > /
> >
> > /
> >              {master branch}
> > /
> >  [A] ---------------------------------[B]------------------------------->[C]
> > master <HEAD>
> >    \                               filelist 6                           /  \
> >     \                                                                  /
> > \
> >      \                                                                /
> > \
> >       \                                                              /
> > \
> >        \                {development branch}                        /
> > \
> >         \------->[D]----------------------->[E]-------------------[F]
> > \------[G]--------[H]
> >                                                                  REL1
> > REL2
> >                 fileset 1               fileset 2           fileset 3
> > fileset 4    fileset 5
> >
> > At this point, I run
> >     'git diff  -m --first-parent --pretty=fuller --decorate=short
> > --name-only REL2..REL2'
>
> Wow, we really, really need to throw errors and warnings when people
> use crazy range operators with diff.[1][2]  What version of git are
> you using that accepts --decorate=short as an argument to `git diff`?
> And why in the world does git diff accept --first-parent or
> --pretty=fuller?!?  That's insane for git-diff to swallow that.
> (#leftoverbits?)  Also, I think you meant `REL1` one of the two times
> you wrote `REL2`, which makes me suspect you may have done some
> copy-edit-paste and didn't try this actual command.
>
> > I expect to see only filesets 4 and 5 listed.  I also see filesets 1, 2 and
> > 3 showing up.  This means that the git diff command is showing files that,in
> > fact, did not change between the two tags.  By the way, I verified with a
> > file by file comparison that under REL2 and REL1, the files represented by
> > filesets 1, 2 and 3 had identical contents.
>
> From your description, I assume you actually ran something like
>   git diff --name-only REL1..REL2

Did you mean REL1...REL2 (3 dots)? 2 dots (REL1..REL2) is identical to
no dots (REL1 REL2), per the documentation for "git diff":

       git diff [<options>] <commit> <commit> [--] [<path>...]

           This is to view the changes between two arbitrary <commit>.

       git diff [<options>] <commit>..<commit> [--] [<path>...]

           This is synonymous to the previous form. If <commit> on one
side is omitted, it will have the same effect
           as using HEAD instead.

(Forgive me if I'm mistaken here!)

>
> which compares REL2 to the merge base of REL1 and REL2 (yes, this is
> totally counter-intuitive to a large percentage of the git userbase,
> but it is well documented and hard to change).  Also from your
> description, what you seem to want is
>   git diff --name-only REL1 REL2
>
> since you want to compare the two endpoints.  Does that help get what you want?
>
> Hope that helps,
> Elijah
>
> [1] https://public-inbox.org/git/CABPp-BECj___HneAYviE3SB=wU6OTcBi3S=+Un1sP6L4WJ7agA@mail.gmail.com/
> [2] https://public-inbox.org/git/CABPp-BGg_iSx3QMc-J4Fov97v9NnAtfxZGMrm3WfrGugOThjmA@mail.gmail.com/

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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFFB1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 00:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfI0AMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 20:12:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35306 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfI0AMg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 20:12:36 -0400
Received: by mail-vs1-f66.google.com with SMTP id s7so687088vsl.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYoEquyzPFgsWJAOU7RO7/9E5L4zFnoKuN55p1rQmtw=;
        b=PGBQWVdmuBKzFnuz6/jhRxYNO0tddWxhw7nAQBnngTGGs1u6Nk36TzGlAI9mdnjNoX
         +6cOi4HYFFQ8KYXdfeCTG3dddbNX9xbVCxPUjpyWOk+WGgVzB3dAji51em3nwflaMdfW
         rIG/Sbvj0NwJ2d2bDMy+IPBPUNR1+d6ouIzMY3uplgBW/W+6fDCJfvYLigblhRGXgnsh
         jBF1V/6qYxrcds8QvvOd0qtcOwUD4uhGMJYosELjmsXUOGqyjumRNdEq0Y1+dKMdL66N
         PdHAm5ck+po5hKTWO9fP7MpYq10cCGREJGqI1Ghx0pGDXmjl0DUTK0ipNAhqppwVgdxI
         3wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYoEquyzPFgsWJAOU7RO7/9E5L4zFnoKuN55p1rQmtw=;
        b=bAkNeVuJFytADHffuCgeC0ik8INNJffjnza+cPsRQzuMu9xC6Lv0fxa4Wf0hsZ1tsD
         +fe+sSSAQF6WFjiuGatABZxRFSiRJsvPN9o4DbUKTM1nNCQdpm5d8FNKcnVUY6776CjI
         JapQWFljN6GGGQmaczRCs+d0DAqjJHXr7E0J+BWarZILy3OHNEmSK/CQCZJQerGKV+pV
         SFHfWxyVglgi+RSg8Z51LYNzXUUrmxZ8McC7wjKgR5Vwwsv4XfG9RtY4B269/xUeA5V7
         hTtk5j6UxEqslhaixJ8hB+k5gAj2ogFa8rMJVX3hKNn0Gy7tc2k8zCFa1vdSeew28kXj
         s6QA==
X-Gm-Message-State: APjAAAUCoBz2kYpHxUtSf2PDJ5YyNxUzb7ehRtvvA293Q7R6CHZIWjkN
        UGx+3258JdIND4v63LorDr+Gr4vmWPSlWfS2MHKLBJVuZqI=
X-Google-Smtp-Source: APXvYqzMJ4iAaR6blARCgdWSQuIbk6dlPIvK17lhJdDTRAHcVsX9XvAqSGzkniX0Qa6UiFvZ6RydWTa+Som7wmcT5io=
X-Received: by 2002:a67:1bc2:: with SMTP id b185mr459033vsb.116.1569543154654;
 Thu, 26 Sep 2019 17:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190912221240.18057-1-newren@gmail.com> <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com> <20190925203919.GA89135@generichostname>
 <CABPp-BHyjVSD6_S_dYgPiXM=GVEpT97FqJJearzg4hvKHXfNVA@mail.gmail.com>
 <20190925215530.GA9013@generichostname> <20190926203509.GA61514@generichostname>
In-Reply-To: <20190926203509.GA61514@generichostname>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Sep 2019 17:12:23 -0700
Message-ID: <CABPp-BGWG-HExZSwzOL75-9Oi0Cs1c8dc6Hq9TotgpQa0XmNvg@mail.gmail.com>
Subject: Re: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Thu, Sep 26, 2019 at 1:35 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> On Wed, Sep 25, 2019 at 02:55:30PM -0700, Denton Liu wrote:
> > Looks correct to me. I don't see why this wouldn't reproduce. I'll send
> > you more information if I figure anything else out.
>
> I looked into it a little more and I think I know why it's being
> triggered.
>
> When we checkout 'todo' from 'master', since they're completely
> different trees, all of git's source files need to be removed. As a
> result, the checkout process at some point invokes check_ok_to_remove().
>
> This kicks off the following call chain:
>
>         check_ok_to_remove()
>         verify_clean_subdirectory()
>         read_directory()
>         read_directory_recursive() (this is called recursively, of course)
>         match_pathspec()
>         do_match_pathspec()
>
> Where we segfault in do_match_pathspec() because ps is NULL:
>
>         GUARD_PATHSPEC(ps,
>                            PATHSPEC_FROMTOP |
>                            PATHSPEC_MAXDEPTH |
>                            PATHSPEC_LITERAL |
>                            PATHSPEC_GLOB |
>                            PATHSPEC_ICASE |
>                            PATHSPEC_EXCLUDE |
>                            PATHSPEC_ATTR);
>
> So why is ps == NULL? In verify_clean_subdirectory(), we call
> read_directory() like this:
>
>         i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
>
> where we explictly pass in a NULL and it is handed down the callstack. I
> guess this means that we should be expecting that pathspecs can be NULL
> in this path. So I've applied the patch at the bottom and it fixes the
> problem.
>
> I was wondering if we should stick a
>
>         if (!ps)
>                 BUG("ps is NULL");
>
> into do_match_pathspec(), though, so we can avoid these situations in
> the future.
>
> Also, I'm still not sure why the issue wasn't reproducible on your
> side... I'm not too familiar with this area of the code, though.
>
> -- >8 --
> diff --git a/dir.c b/dir.c
> index 76a3c3894b..b7a6de58c6 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1952,7 +1952,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>                         if (subdir_state > dir_state)
>                                 dir_state = subdir_state;
>
> -                       if (!match_pathspec(istate, pathspec, path.buf, path.len,
> +                       if (pathspec && !match_pathspec(istate, pathspec, path.buf, path.len,
>                                             0 /* prefix */, NULL,
>                                             0 /* do NOT special case dirs */))
>                                 state = path_none;

The patch makes sense...but I'd really like to add a test, and
understand it better so I can check to see if there are any other bad
codepaths.  Sadly, I still have no idea how to reproduce the bug.  I
can put

    char *oopsies = NULL;
    printf("oopsies = %s\n", oopsies);

at the beginning of check_ok_to_remove() to verify that function is
never called and run the steps you gave with no problem.  However, I
do notice that your reproduction steps involve 'master' which may have
local changes for you that I don't have.  Is there any chance you can
reproduce this using a commit id that is already upstream instead of
'master'?  I've been poking around unpack-trees.c for a bit but I'm
having a hard time reversing out of it what's different about our
setups and how to trigger.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2540F1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 08:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfFSINu (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 04:13:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39897 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFSINu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 04:13:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so723577wma.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 01:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bhhs+Claj1UYr/9m+PBmP8wEc2GFvGnoLj1NBtvSng=;
        b=uAV2eqf+XxCENFAfkZaOoiM5CHvKRe1o6nxdtytKHVyFKM9ulE9QQZUyCxLRR24y+C
         OSwYWnNJUlc4ztI+XLHEN/LIP9b7nIJR9zVfqIfFioV59TJ+k2yEOykrI2zo+Xrl6QfE
         2yRxz4SDaGM8VouJmbOyRK9rU3amEVC2TG9X68XteuTiFUl4DVTU4zfo3711v0hsrN3B
         ZEdHRjTTd7BBsXsIMZi3wzcnPo/FrOGg00Y5s1IZnknkmD5zEHG2cRhQJ61S+7fIW2+Y
         BNOpGKW8fx9Txdl74cVc/6ouAGZefJ8F3PYqhwuyYWOVOvCkRDFpOh4pDhXXORWmBM19
         5S1w==
X-Gm-Message-State: APjAAAW3LYCxioWF+7DOE9RjQkmzg28GUwDJ/bA4yQHoWHGFFmZj9Ks0
        Zm6Nmt4+Cob1lAqjfKr3TKhj1dxf0KyClOHZoyBtTc/v
X-Google-Smtp-Source: APXvYqx0DOhuR6pXUtmY1mlk1HywNqzQfelK/w1j5zcxEgWYmT+DXjpNDiRo0npP4l/a6Z8E/b4WT/LiZI86VD2RCUQ=
X-Received: by 2002:a1c:480a:: with SMTP id v10mr6985073wma.120.1560932026440;
 Wed, 19 Jun 2019 01:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <CAPig+cTZFL=GzM_-S2JMWWxRU7poJ87f3a9ZcFjjUe1T131eEQ@mail.gmail.com> <20190617231959.GB100487@google.com>
In-Reply-To: <20190617231959.GB100487@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Jun 2019 04:13:35 -0400
Message-ID: <CAPig+cSyEHUvx39stA0kx1c6kKYO7jk7Sk_Q=etEro_h=3ucOw@mail.gmail.com>
Subject: Re: [PATCH] documentation: add tutorial for revision walking
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 17, 2019 at 7:20 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Fri, Jun 07, 2019 at 02:21:07AM -0400, Eric Sunshine wrote:
> > On Thu, Jun 6, 2019 at 9:08 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > > +int cmd_walken(int argc, const char **argv, const char *prefix)
> > > +{
> > > +       struct option options[] = {
> > > +               OPT_END()
> > > +       };
> > > +
> > > +       argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
> > > +
> > > +       ...
> >
> > Perhaps comment out the "..." or remove it altogether to avoid having
> > the compiler barf when the below instructions tell the reader to build
> > the command.
>
> Hmm. That part I'm not so sure about. I like to use the "..." to
> indicate where the code in the snippet should be added around the other
> code already in the file - which I suppose it does just as clearly if
> it's commented - but I also hope folks are not simply copy-pasting
> blindly from the tutorial.
>
> It seems like including uncommented "..." in code tutorials is pretty
> common.

You're right, and that's not what I was "complaining" about. Looking
back at your original email, I see that I somehow got confused and
didn't realize or (quickly) forgot that you had already presented a
_complete_ cmd_walken() snippet just above that spot, and that the
cmd_walken() snippet upon which I was commenting was _incomplete_,
thus the "..." was perfectly justified. Not realizing that the
incomplete cmd_walken() example was just that (incomplete), I
"complained" that the following "compile the project" instructions
would barf on "...".

Maybe I got confused because the tiny cmd_walken() snippets followed
one another so closely (or because I got interrupted several times
during the review), but one way to avoid that would be to present a
single _complete_ snippet from the start, followed by a bit of
explanation. That is, something like this:

    Open up a new file `builtin/walken.c` and set up the command handler:

    ----
    /* "git walken" -- Part of the "My First Revision Walk" tutorial. */
    #include "builtin.h"

    int cmd_walken(int argc, const char **argv, const char *prefix)
    {
        const char * const usage[] = {
            N_("git walken"),
            NULL,
        }
        struct option options[] = {
            OPT_END()
        };

        argc = parse_options(argc, argv, prefix, options, usage, 0);

        printf(_("cmd_walken incoming...\n"));
        return 0;
    }
    ----

    `usage` is the usage message presented by `git -h walken`, and
    `options` will eventually specify command-line options.

> I don't think I have a good reason to push back on this except that I
> think "/* ... */" is ugly :)
>
> I'll go through and replace "..." with some actual hints about what's
> supposed to go there; for example, here I'll replace with "/* print and
> return */".

Seeing as my initial review comment was in error, I'm not sure that
you ought to replace "..." with anything else.

> > "invoke anything" is pretty nebulous, as is the earlier "components
> > you may invoke". A newcomer is unlikely to know what this means, so
> > perhaps it needs an example (even if just a short parenthetical
> > comment).
>
> I have tried to reword this; I hope this is a little clearer.
>
>   Before you begin to examine user configuration for your revision walk, it's
>   common practice for you to initialize to default any switches that your command
>   may have, as well as ask any other components you may invoke to initialize as
>   well (for example, how `git log` also uses the `grep` and `diff` components).
>   `git log` does this in `init_log_defaults()`; in that case, one global
>   `decoration_style` is initialized, as well as the grep and diff-UI components.

By trying to express too many things at once, it's still difficult to
follow. Perhaps use shorter, more easily digestible sentences, like
this:

    Before examining configuration files which may modify command
    behavior, set up default state for switches or options your
    command may have. If your command utilizes other Git components,
    ask them to set up their default states, as well. For instance,
    `git log` takes advantage of `grep` and `diff` functionality; its
    init_log_defaults() sets its own state (`decoration_style`) and
    asks `grep` and `diff` to initialize themselves by calling their
    initialization functions.

> > > +static int walken_commit_walk(struct rev_info *rev)
> > > +{
> > > +       /* prepare_revision_walk() gets the final steps ready for a revision
> > > +        * walk. We check the return value for errors. */
> >
> > Not at all sure what this comment is trying to say. Also, the second
> > sentence adds no value to what the code itself already says clearly by
> > actually checking the return value.
>
> Attempted to rephrase. I ended up with:
>
>   /*
>    * prepare_revision_walk() does the final setup needed by revision.h
>    * before a walk. It may return an error if there is a problem.
>    */
>
> Maybe the second sentence still doesn't serve a purpose, but I was
> trying to express that prepare_revision_walk() won't die() on its own.
>
> >
> > > +       if (prepare_revision_walk(rev))
> > > +               die(_("revision walk setup failed"));

As this is just a toy example, I don't care too strongly about the
unnecessary second sentence. On the other hand, the tutorial is trying
to teach people how to contribute to this project, and on this
project, that sort of pointless comment is likely to be called out in
review. In fact, given that view, the entire comment block is
unnecessary (it doesn't add any value for anyone reviewing or reading
the code), so it might make more sense to drop the comment from the
code entirely, and just do a better job explaining in prose above the
snippet why you are calling that function. For instance:

    ... Let's start the helper with the call to `prepare_revision_walk()`,
    which does the final setup of the `rev_info` structure before it can
    be used.

The above observation may be more widely applicable than to just this
one instance. Don't use in-code comments for what should be explained
in prose if the in-code comment adds no value to the code itself (to
wit, if a reviewer would say "don't repeat in a comment what the code
already says clearly" or "don't use a comment to state the obvious").

> > > +This display is an indicator for the latency between publishing a commit for
> > > +review the first time, and getting it actually merged into master.
> >
> > Perhaps: s/master/`&`/
> >
> > Even as a long-time contributor to the project, I had to pause over
> > this statement for several seconds before figuring out what it was
> > talking about. Without a long-winded explanation of how topics
> > progress from submission through 'pu' through 'next' through 'master'
> > and finally into a release, the above statement is likely to be
> > mystifying to a newcomer. Perhaps it should be dropped.
>
> Such an explanation exists in MyFirstContribution.txt. I will include a
> shameless plug to that document here. :)

I found that this sort of tangential reference disturbed the flow of
the tutorial, leading the mind astray from the otherwise natural
progression of the presentation. So, I'm not convinced that talking
about the migration of a topic in the Git project itself adds value to
this tutorial. The same effect could be seen when commits have been
re-ordered via git-rebase, too, right? Perhaps mention that instead?

> > > +       printf(_("Object walk completed. Found %d commits, %d blobs, %d tags, "
> > > +                "and %d trees.\n"), commit_count, blob_count, tag_count,
> > > +              tree_count);
> >
> > Or make the output more useful by having it be machine-parseable (and
> > not localized):
> >
> >     printf("commits %d\nblobs %d\ntags %d\ntrees %d\n",
> >         commit_count, blob_count, tag_cont, tree_count);
>
> I'm not sure whether I agree, since it's a useless toy command only for human
> parsing.

True, it's not a big deal, and I don't insist upon it. But, if you
mention in prose that this output is easily machine-parseable, then
perhaps that nudges the reader a bit in the direction of thinking
about porcelain vs. plumbing, which is something a contributor to this
project eventually has to be concerned with (the sooner, the better).

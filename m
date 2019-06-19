Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441241F462
	for <e@80x24.org>; Wed, 19 Jun 2019 23:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSXgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 19:36:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38870 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSXgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 19:36:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so510006pfa.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vm1/8eN3IYUGfHnDzXV+y9Qr+1S3LqZ32cdLueW5I4Q=;
        b=Qy6ZMl+KHjugpF4DyWmN+C178a2/sd92wiZmn5BvAkcJxjVOMekyB58wyLlGTcWxtl
         /eLLL/bNOeHnGXP+nIP87x6QdhIq7DJu68EZpvXnBN4QaFgnseH8jX1GYY3vqOiwEVhF
         zA3S99LGcmdXUTDFQIzpiE7I4OG/wajgKQmFXKwlTollLXphZuRtEFqrL0feV9EnIdRH
         j8O7rmSVMem9kpxBNmH4WTQ4KNxYp8DC3FEYJZJwSyvhV7Ca55wLWqS4hWM+pvI2WJoe
         qc4EpcjSirkfhgbOoSjVOnz8GpuduDz+UW+zaRIn3lFbAwjTpcbF/4KLuiZdgQ60bQit
         n0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vm1/8eN3IYUGfHnDzXV+y9Qr+1S3LqZ32cdLueW5I4Q=;
        b=WzPOYymTKLGlcTrrpAMUy8tbwNH5sQHW6qz4gQVXI6KpK4sUa8+2qv2T60nbr5jMXC
         y0nA8af0Zu0F8T6yHM7997HvfsT1GDYAAw23dZsUlc2EgYnPxtT/2Nn88OhHPtO4AXAn
         BlWS1E3XvGknQcur4VzJt8mIPAuFDNkDHegLIODFttXw+3tSEvKUg4oPioR3VbHg4CAJ
         xhI2iqVw1uoPUGK6eBP9P/5wtbWzph0XQT6V3rxCnP+vRcnG3/epHApUwbkcbFHFdmPC
         QUUgMrPsx87eK+scA5BOjpjkghooAprmaBS1WEnGOU+iEek/jOPrihXfPfnln5enieQd
         CH4A==
X-Gm-Message-State: APjAAAWsbcPDph/FhbKTPK8vcKWMjMhsiHqGB4elI1tEDwQpg9YiYqnw
        op1y9Y6rAmcLLTLSz5sBm/4sbpB2VMM=
X-Google-Smtp-Source: APXvYqzsTNkdzkmYtPk6hjQeuWBa+aqqY8v4GYPrnsHbafikyitl0M/U9V0tQcztceGN95o4JaiUUQ==
X-Received: by 2002:a17:90a:342c:: with SMTP id o41mr13870725pjb.1.1560987362094;
        Wed, 19 Jun 2019 16:36:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id k3sm19075966pgo.81.2019.06.19.16.36.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 16:36:01 -0700 (PDT)
Date:   Wed, 19 Jun 2019 16:35:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] documentation: add tutorial for revision walking
Message-ID: <20190619233556.GH100487@google.com>
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <CAPig+cTZFL=GzM_-S2JMWWxRU7poJ87f3a9ZcFjjUe1T131eEQ@mail.gmail.com>
 <20190617231959.GB100487@google.com>
 <CAPig+cSyEHUvx39stA0kx1c6kKYO7jk7Sk_Q=etEro_h=3ucOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSyEHUvx39stA0kx1c6kKYO7jk7Sk_Q=etEro_h=3ucOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 04:13:35AM -0400, Eric Sunshine wrote:
> On Mon, Jun 17, 2019 at 7:20 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > On Fri, Jun 07, 2019 at 02:21:07AM -0400, Eric Sunshine wrote:
> > > On Thu, Jun 6, 2019 at 9:08 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > > > +int cmd_walken(int argc, const char **argv, const char *prefix)
> > > > +{
> > > > +       struct option options[] = {
> > > > +               OPT_END()
> > > > +       };
> > > > +
> > > > +       argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
> > > > +
> > > > +       ...
> > >
> > > Perhaps comment out the "..." or remove it altogether to avoid having
> > > the compiler barf when the below instructions tell the reader to build
> > > the command.
> >
> > Hmm. That part I'm not so sure about. I like to use the "..." to
> > indicate where the code in the snippet should be added around the other
> > code already in the file - which I suppose it does just as clearly if
> > it's commented - but I also hope folks are not simply copy-pasting
> > blindly from the tutorial.
> >
> > It seems like including uncommented "..." in code tutorials is pretty
> > common.
> 
> You're right, and that's not what I was "complaining" about. Looking
> back at your original email, I see that I somehow got confused and
> didn't realize or (quickly) forgot that you had already presented a
> _complete_ cmd_walken() snippet just above that spot, and that the
> cmd_walken() snippet upon which I was commenting was _incomplete_,
> thus the "..." was perfectly justified. Not realizing that the
> incomplete cmd_walken() example was just that (incomplete), I
> "complained" that the following "compile the project" instructions
> would barf on "...".
> 
> Maybe I got confused because the tiny cmd_walken() snippets followed
> one another so closely (or because I got interrupted several times
> during the review), but one way to avoid that would be to present a
> single _complete_ snippet from the start, followed by a bit of
> explanation. That is, something like this:
> 
>     Open up a new file `builtin/walken.c` and set up the command handler:
> 
>     ----
>     /* "git walken" -- Part of the "My First Revision Walk" tutorial. */
>     #include "builtin.h"
> 
>     int cmd_walken(int argc, const char **argv, const char *prefix)
>     {
>         const char * const usage[] = {
>             N_("git walken"),
>             NULL,
>         }
>         struct option options[] = {
>             OPT_END()
>         };
> 
>         argc = parse_options(argc, argv, prefix, options, usage, 0);
> 
>         printf(_("cmd_walken incoming...\n"));
>         return 0;
>     }
>     ----
> 
>     `usage` is the usage message presented by `git -h walken`, and
>     `options` will eventually specify command-line options.

Hmm. I can say that I personally would find that much more difficult to
follow interactively, and I'd be tempted to copy-and-paste and skim
through the wall of text if I was presented with such a snippet.
However, I could also imagine the reverse - someone becoming tired of
having their hand held through a fairly straightforward implementation,
when they're perfectly capable of reading a long description and would
just like to get on with it.

I'm really curious about what others think in this scenario, since I
imagine it boils down to individual learning styles.

(Maybe we can split the difference and present a complete patch or new
function, followed by a breakdown? That would end up even more verbose
than the current approach, though.)

... Now that I'm thinking more about this, and reading some of your
later comments on this mail, I think it might be valuable to lean on the
sample patchset for complete code samples, especially if we figure a
good way to distribute the patchset near the tutorial (as Junio and I
are discussing in another branch of this thread). Then we can keep the
tutorial concise, but have the complete code available for those who
prefer to look there.

> 
> > I don't think I have a good reason to push back on this except that I
> > think "/* ... */" is ugly :)
> >
> > I'll go through and replace "..." with some actual hints about what's
> > supposed to go there; for example, here I'll replace with "/* print and
> > return */".
> 
> Seeing as my initial review comment was in error, I'm not sure that
> you ought to replace "..." with anything else.
> 
> > > "invoke anything" is pretty nebulous, as is the earlier "components
> > > you may invoke". A newcomer is unlikely to know what this means, so
> > > perhaps it needs an example (even if just a short parenthetical
> > > comment).
> >
> > I have tried to reword this; I hope this is a little clearer.
> >
> >   Before you begin to examine user configuration for your revision walk, it's
> >   common practice for you to initialize to default any switches that your command
> >   may have, as well as ask any other components you may invoke to initialize as
> >   well (for example, how `git log` also uses the `grep` and `diff` components).
> >   `git log` does this in `init_log_defaults()`; in that case, one global
> >   `decoration_style` is initialized, as well as the grep and diff-UI components.
> 
> By trying to express too many things at once, it's still difficult to
> follow. Perhaps use shorter, more easily digestible sentences, like
> this:
> 
>     Before examining configuration files which may modify command
>     behavior, set up default state for switches or options your
>     command may have. If your command utilizes other Git components,
>     ask them to set up their default states, as well. For instance,
>     `git log` takes advantage of `grep` and `diff` functionality; its
>     init_log_defaults() sets its own state (`decoration_style`) and
>     asks `grep` and `diff` to initialize themselves by calling their
>     initialization functions.

Yeah, I like this a lot. Thanks! I took it word for word; will be adding
you to the Helped-by line of the commit.

> As this is just a toy example, I don't care too strongly about the
> unnecessary second sentence. On the other hand, the tutorial is trying
> to teach people how to contribute to this project, and on this
> project, that sort of pointless comment is likely to be called out in
> review. In fact, given that view, the entire comment block is
> unnecessary (it doesn't add any value for anyone reviewing or reading
> the code), so it might make more sense to drop the comment from the
> code entirely, and just do a better job explaining in prose above the
> snippet why you are calling that function. For instance:
> 
>     ... Let's start the helper with the call to `prepare_revision_walk()`,
>     which does the final setup of the `rev_info` structure before it can
>     be used.
> 
> The above observation may be more widely applicable than to just this
> one instance. Don't use in-code comments for what should be explained
> in prose if the in-code comment adds no value to the code itself (to
> wit, if a reviewer would say "don't repeat in a comment what the code
> already says clearly" or "don't use a comment to state the obvious").

I'm of two minds about this. On the one hand, I'm somewhat in favor of
leaving contextual, informational comments in the sample code, so the
sample code can teach on its own without the tutorial (specifically, I
mean the patchset that was sent alongside this one as RFC). On the other
hand, you're right that adding these informational comments doesn't
model best practices for real commits.

I don't have a strong opposition to removing those comments from the
in-place samples in the tutorial itself. But I do think it's useful to
include them in the sample patchset, which is intended as an additional
learning tool, rather than as a pristine code example - especially if we
make it clear in the commit messages there.

> 
> > > > +This display is an indicator for the latency between publishing a commit for
> > > > +review the first time, and getting it actually merged into master.
> > >
> > > Perhaps: s/master/`&`/
> > >
> > > Even as a long-time contributor to the project, I had to pause over
> > > this statement for several seconds before figuring out what it was
> > > talking about. Without a long-winded explanation of how topics
> > > progress from submission through 'pu' through 'next' through 'master'
> > > and finally into a release, the above statement is likely to be
> > > mystifying to a newcomer. Perhaps it should be dropped.
> >
> > Such an explanation exists in MyFirstContribution.txt. I will include a
> > shameless plug to that document here. :)
> 
> I found that this sort of tangential reference disturbed the flow of
> the tutorial, leading the mind astray from the otherwise natural
> progression of the presentation. So, I'm not convinced that talking
> about the migration of a topic in the Git project itself adds value to
> this tutorial. The same effect could be seen when commits have been
> re-ordered via git-rebase, too, right? Perhaps mention that instead?

Yeah, that's a good point. I'll try to mention it in a more
universally-applicable way, like you suggested.

> 
> > > > +       printf(_("Object walk completed. Found %d commits, %d blobs, %d tags, "
> > > > +                "and %d trees.\n"), commit_count, blob_count, tag_count,
> > > > +              tree_count);
> > >
> > > Or make the output more useful by having it be machine-parseable (and
> > > not localized):
> > >
> > >     printf("commits %d\nblobs %d\ntags %d\ntrees %d\n",
> > >         commit_count, blob_count, tag_cont, tree_count);
> >
> > I'm not sure whether I agree, since it's a useless toy command only for human
> > parsing.
> 
> True, it's not a big deal, and I don't insist upon it. But, if you
> mention in prose that this output is easily machine-parseable, then
> perhaps that nudges the reader a bit in the direction of thinking
> about porcelain vs. plumbing, which is something a contributor to this
> project eventually has to be concerned with (the sooner, the better).

Oh, that's a very good point. I'll frame it that way - that's a handy
place to slip in some bonus context about Git. Thanks.

  NOTE: We aren't localizing the printf here because we have purposefully
  formatted it in a machine-parseable way. Commands in Git are divided into
  "plumbing" and "porcelain"; the "plumbing" commands are machine-parseable and
  intended for use in scripts, while the "porcelain" commands are intended for
  human interaction. Output intended for script usage doesn't need to be
  localized; output intended for humans does.


Thanks again for the review effort.

 - Emily

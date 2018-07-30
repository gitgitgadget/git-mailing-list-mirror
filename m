Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF8A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeG3XDD (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:03:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34596 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3XDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:03:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so9377834wme.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SiYB/dCj69TW00oceaxuM0WzpgXHBI4fbIwJRv3iods=;
        b=X3Np72lvBTAPGSgwDVadX6hru2mKHjMHKKDJXQ6UXLqev6lRbUXy1JsV4S1gy5vvQX
         6UZTCgkYpBc6U0YnpGQnf7YEy1RN53bpsbQoR63r9+uvZL3jaxqXL2LYSTjz6sLdVYjY
         8dt5ZaZIr/c13HikjLrc57NzA7MxtCro9wYOr55TnzSztRdbUUJJFgOdl1NfSJzTYQ3o
         cpDotgvneZLgErZm+ZSJv4gfJK9Qda0vRmUULcIYVDnY1O7bQxR4xmG82nEYHg0JtdZr
         gFfcVD7VMlaC2ygltwbHyzMLxYpv15yDHMeimxWG0y6/FiXU5SDPIhl6yY+41I00i9+Q
         u2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SiYB/dCj69TW00oceaxuM0WzpgXHBI4fbIwJRv3iods=;
        b=fU23r2oDMibl9J30k0HZjIhIbiBJ9HknNe1EIk9Z5h4HNRiD1xi1NV7dhyzjW7wZFg
         b+0JJ13eaJIwAa0Fn8uFdUmcA8IU2zY2Cu/61PEiNB7zniA9wF6VLeNOtlQufOOj0NuK
         1jLi65pg0dL6QKz7x3q29WOnPPQf+X7Mya7xEhPCCXGul/jSTvNbexNc2N+dZpkbsEoz
         KQ8edn+zrGtgPVWJshUQcrgwOdgM+1yjig2mk7EDENjZ8wIMhZvyheONh6IohSz1rP25
         dnwXqMBG/MjxAOriMTKtN/b73v1Zp/MogokbOl9OSXY3j7PePNcRCsJ0q6b0cCg+kdqU
         oOcw==
X-Gm-Message-State: AOUpUlG8OvUhzaGrBGRmW5eErtTkkWuDikTL+MOdtKjpEZn0BlRlQeKX
        JKHRLXsRh8QjxBzhAW7j+z0=
X-Google-Smtp-Source: AAOMgpd1ycazSnQ5fHJHaKGfadsKB08t7JnPk8Qud+4C8782iwJB2FHu3BMXu+8+yyzui6yVI4huQQ==
X-Received: by 2002:a1c:228b:: with SMTP id i133-v6mr551125wmi.69.1532985968199;
        Mon, 30 Jul 2018 14:26:08 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id q8-v6sm18426989wrj.97.2018.07.30.14.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:26:07 -0700 (PDT)
Date:   Mon, 30 Jul 2018 22:26:06 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between patches
Message-ID: <20180730212606.GL9955@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
 <20180729190359.GD2734@hank.intra.tgummerer.com>
 <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
 <20180729214543.GD9955@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Johannes Schindelin wrote:
> Hi Thomas & Eric,
> 
> On Sun, 29 Jul 2018, Thomas Gummerer wrote:
> 
> > On 07/29, Eric Sunshine wrote:
> > > On Sun, Jul 29, 2018 at 3:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > > On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > > > > Just like tbdiff, we now show the diff between matching patches. This is
> > > > > a "diff of two diffs", so it can be a bit daunting to read for the
> > > > > beginner.
> > > > > [...]
> > > > > Note also: while tbdiff accepts the `--no-patches` option to suppress
> > > > > these diffs between patches, we prefer the `-s` option that is
> > > > > automatically supported via our use of diff_opt_parse().
> > > >
> > > > One slightly unfortunate thing here is that we don't show these
> > > > options in 'git range-diff -h', which would be nice to have.  I don't
> > > > know if that's possible in git right now, if it's not easily possible,
> > > > I definitely wouldn't want to delay this series for that, and we could
> > > > just add it to the list of possible future enhancements that other
> > > > people mentioned.
> > > 
> > > This issue is not specific to git-range-diff; it's shared by other
> > > commands which inherit diff options via diff_opt_parse(). For
> > > instance, "git log -h" doesn't show diff-related options either, yet
> > > it accepts them.
> > 
> > Fair enough, that makes sense.  Thanks for the pointer!
> > 
> > There's one more thing that I noticed here:
> > 
> >     git range-diff --no-patches
> >     fatal: single arg format requires a symmetric range
> > 
> > Which is a slightly confusing error message.  In contrast git log does
> > the following on an unrecognized argument:
> > 
> >     git log --no-patches
> >     fatal: unrecognized argument: --no-patches
> > 
> > which is a little better I think.  I do however also thing the "fatal:
> > single arg format requires a symmetric range" is useful when someone
> > genuinely tries to use the single argument version of the command.  So
> > I don't know what a good solution for this would be.
> 
> I immediately thought of testing for a leading `-` of the remaining
> argument, but I could imagine that somebody enterprisey uses
> 
> 	git range-diff -- -my-first-attempt...-my-second-attempt
> 
> and I do not really want to complexify the code... Ideas?

Good point.  I can't really come up with a good option right now
either.  It's not too bad, as users just typed the command, so it
should be easy enough to see from the previous line what went wrong.

One potential option may be to turn "die(_("single arg format requires
a symmetric range"));" into an 'error()', and show the usage?  I think
that may be nice anyway, as "symmetric range" may not be immediately
obvious to everyone, but together with the usage it may be clearer?

> > > > > diff --git a/range-diff.c b/range-diff.c
> > > > > @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
> > > > >                       printf("%d: %s ! %d: %s\n",
> > > > >                              b_util->matching + 1, short_oid(a_util),
> > > > >                              j + 1, short_oid(b_util));
> > > > > +                     if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
> > > >
> > > > Looking at this line, it looks like it would be easy to support
> > > > '--no-patches' as well, which may be slightly easier to understand that
> > > > '-s' to someone new to the command.  But again that can be added later
> > > > if someone actually cares about it.
> > > 
> > > What wasn't mentioned (but was implied) by the commit message is that
> > > "-s" is short for "--no-patch", which also comes for free via
> > > diff_opt_parse(). True, "--no-patch" isn't spelled exactly the same as
> > > "--no-patches", but git-range-diff isn't exactly a perfect tbdiff
> > > clone, so hopefully not a git problem. Moreover, "--no-patch" is
> > > internally consistent within the Git builtin commands.
> > 
> > Makes sense, thanks!  "--no-patch" does make sense to me.  There's
> > still a lot of command line flags in git to learn for me, even after
> > all this time using it ;)  Might be nice to spell it out in the commit
> > message for someone like me, especially as "--no-patches" is already
> > mentioned.  Though I guess most regulars here would know about
> > "--no-patch", so maybe it's not worth it.  Anyway that is definitely
> > not worth another round here.
> 
> Sure, but not many users learn from reading the commit history...
> 
> :-)
> 
> Ciao,
> Dscho

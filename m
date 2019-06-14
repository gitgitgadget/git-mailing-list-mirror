Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A671F462
	for <e@80x24.org>; Fri, 14 Jun 2019 00:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfFNAap (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 20:30:45 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:47089 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNAap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 20:30:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id l125so642142vsl.13
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfZdVSu7EsE1gl3lmx1Dy/vnJbrFAOejf54Sr1adv0Q=;
        b=J0yVbkaSTkvUTtBnIHxTGn81NaaNCR6nzyjwxaPpDm7XDuBh5W+ls1EbkZ4kFx43Dk
         QfL8h4WYLzCzfM0vwE5bk9pyC+DlliFPlTWX+tnxHil0tRbIzvfQWtAAkaYvac6Gw2sX
         BWY4LPpdKCUi6NrB7Ju5igrc56WBQfTlZR4Uo0kXHBjQtSoIUNz1WZI0CdNMN5Rn5w6b
         na8s+WsYgPFbm5oAhXQFAJJr5ibMfj1FHSCwx1rBJIgz4WfhxBcpLOFccN5S6MgFgmJB
         OhibQm8oClFP3b9UP1RZ3A7BWYSB/vscA9eqXADDFUEj4ZfnvGOhBxHarIoRN8x42UXb
         B4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfZdVSu7EsE1gl3lmx1Dy/vnJbrFAOejf54Sr1adv0Q=;
        b=jS2LU6K8fQUoq+8gxygDN+6FudfiDEIVBuh/3csVUQ21t0Txuz0P6+j6TYsZrJ+sa8
         pifAgetM6OFIsNaab+9zr8wQ/zXj3qta/ygsOIHCCd3Ac5sxemKL7lGbpWsog07II5Fu
         QacefIlnxxcQO8NAKjOtZIPx85w5KArjtmqCTc5bkdlImW1G4UJjOMaIxWM7IDoOVOS+
         /S1dMcIQQ1uW3Cz6onXcZ4LT22fhc3Ecs7FKjBddQn38DNnYIHpYZ9uKWw256KxtzHis
         SXv/JI/BU/+aah/ktBfrgfcQV/KZDzDKRwrH0XFSukUWwCnI/qv3RYD92IjdCS7j/3QU
         8WLQ==
X-Gm-Message-State: APjAAAVcTIj/DlVH3jCUI+Vnju5Mhmoxskq1S98nBTEYlPO0szHdCHMs
        iV5E6h+roG6/v1XlOqzKt2ioa3IvE5t9ugj3p3V8p22P434=
X-Google-Smtp-Source: APXvYqxjDh9AhRA4J8+jrYUtjaE8/hURbA93L5GSg+dVdUHFnHUSx2ZHDq/ZetdMzg5PSYFd7klI01IMReZElNGXRuo=
X-Received: by 2002:a67:fc50:: with SMTP id p16mr31964369vsq.79.1560472244252;
 Thu, 13 Jun 2019 17:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
 <20190607093034.816-1-pclouds@gmail.com> <20190607100252.GA24208@szeder.dev>
 <CAMP44s3EsNzBtt_pG8HVp_RTMTTArk7Twhty4_tzf2iiZ7TKUQ@mail.gmail.com> <CACsJy8CGtZMn0aa7QRj7Dz-jZS2K2fviUJ_Lii48FRY4E84i5Q@mail.gmail.com>
In-Reply-To: <CACsJy8CGtZMn0aa7QRj7Dz-jZS2K2fviUJ_Lii48FRY4E84i5Q@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 13 Jun 2019 19:30:33 -0500
Message-ID: <CAMP44s2ewOJNYSqQ+8EiBJ8ik7rWMj9yaxWwzYk9nUO+A1gwcg@mail.gmail.com>
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 3:52 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Jun 8, 2019 at 12:33 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > Something like this should work:
> >
> > struct command checkout_command = {
> > .name = "checkout",
> > .function = cmd_checkout,
> > .run_options = RUN_SETUP | NEED_WORK_TREE,
> > .help = N_("Switch branches or restore working tree files"),
> > .options = {
> > OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
> > ...
> > },
> > }
> >
> > This way we could run parse_options_show_gitcomp() from git.c and not
> > worry about whatever cmd_checkout() needs.
>
> This only works for a few commands. Those with subcommands already
> have struct option[] array scattered in different places. And some new
> ones also have struct option array dynamically created.
>
> It's not impossible to do. But I feel there's a lot of reorganizing
> for little gain. Maybe when we pass 'struct repository *' to all
> commands, which means we hit all commmands at once anyway, we can
> reconsider this (and having config parser in a more declarative form
> like cmd option parser).

Well yes, there is little *functional* gain at the moment, but this
(or some version of this) must be done eventually.

For the moment we still have an issue, but I see there's already a
hack present for '-h', maybe we can re-utilize it. Something like
this:

--- a/git.c
+++ b/git.c
@@ -408,6 +408,8 @@ static int run_builtin(struct cmd_struct *p, int
argc, const char **argv)

        prefix = NULL;
        help = argc == 2 && !strcmp(argv[1], "-h");
+       if (!help)
+               help = argc == 2 && !strcmp(argv[1], "--git-completion-helper");
        if (!help) {
                if (p->option & RUN_SETUP)
                        prefix = setup_git_directory();

One way or the other, shouldn't my tests be merged? The issue is still
there, and it's nice to have tests for that.

-- 
Felipe Contreras

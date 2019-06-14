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
	by dcvr.yhbt.net (Postfix) with ESMTP id 63AD61F462
	for <e@80x24.org>; Fri, 14 Jun 2019 02:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfFNCxY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 22:53:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43448 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfFNCxY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 22:53:24 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so2485742ios.10
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 19:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voHx74/sc+RbwWmV0PvJjEwybpoBnAk21SB8GW2Csr8=;
        b=OSbJBHqKJSFKiLp0pznNKhhetdhLak20AVYWNs9pkRU6HKw/jIIcMj8MqBp8oUANHG
         WtxwYufcqsvrGvuaVu40umB9U1R9q8AmB8f+/ovdWGh6NoVpPO2cTfvzAC+tBd8ONaV0
         xF1Ux/roEk7xeydVGxnvgMdrVWk+CmkExmehNQ9QTORKkgMf2yHgsyIBzYds4rZ2BxfG
         dVnHVYcRZybufYYh2OcBAO97SIMD3CnP4bIzyJu2YOFIlrzcGXEhoEijAqUK1wNs7Zfi
         PR7eJch0m+l7S2PvpD1RL0cue/wzCNKdGOyfJGRKeP8dehjTN3h7p+RKzCeLn8fp7tc5
         Xfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voHx74/sc+RbwWmV0PvJjEwybpoBnAk21SB8GW2Csr8=;
        b=cT9huApbOx6dhm9r14Bvfz+yFMnCGPtFOy3CmmIoFGmYzBBT8zueLTPtAZvsQDlbr9
         EPhgp5f6sOvFRj0glW9g2FmWCY5CaMfpOGF1IMMAeHvC7G3H95w+6e2LZkQiJDl1II4w
         To+xxJsHBT2sMHJFCu2nYyKvHz6yJaYpEXlisqJv8Y2yIKWUdcUQsokr7uTfw0+reIhs
         9YfgYeUDvM53eYu5mxX5Ihq+Qa5VrolkY8SMwgd8fBswNFbf4FDjL9RsG8T2SCZ8tasA
         KV3P0TdoSEWx7PD5FzuQMA1qSIhLZf4cSoN/n09+hnYOgPpdHk80kdmD9zdI01SvziRl
         LT/Q==
X-Gm-Message-State: APjAAAXew1FvXKmk5xgJTlermRrNo9UQOnsP+qcCz40oCEHCmv5nJeJ6
        G8aLVw7C8Btyr743rIRh476ioC6bxMj+GzDORKM=
X-Google-Smtp-Source: APXvYqwwyVE/eAyiJaukA/aKE+L4X2zMlfmEJ8yTVv6CImwuZhlIB2/rSyXiCgrXO076lqjpdD/35cIdCLrC7may2rk=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr16250771ioh.40.1560480803158;
 Thu, 13 Jun 2019 19:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
 <20190607093034.816-1-pclouds@gmail.com> <20190607100252.GA24208@szeder.dev>
 <CAMP44s3EsNzBtt_pG8HVp_RTMTTArk7Twhty4_tzf2iiZ7TKUQ@mail.gmail.com>
 <CACsJy8CGtZMn0aa7QRj7Dz-jZS2K2fviUJ_Lii48FRY4E84i5Q@mail.gmail.com> <CAMP44s2ewOJNYSqQ+8EiBJ8ik7rWMj9yaxWwzYk9nUO+A1gwcg@mail.gmail.com>
In-Reply-To: <CAMP44s2ewOJNYSqQ+8EiBJ8ik7rWMj9yaxWwzYk9nUO+A1gwcg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 14 Jun 2019 09:52:56 +0700
Message-ID: <CACsJy8DThHXksARSM32fQ_8fdYqpQYnR5SQmC0i1oVZVc58fPw@mail.gmail.com>
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 7:30 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Wed, Jun 12, 2019 at 3:52 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Sat, Jun 8, 2019 at 12:33 AM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
>
> > > Something like this should work:
> > >
> > > struct command checkout_command = {
> > > .name = "checkout",
> > > .function = cmd_checkout,
> > > .run_options = RUN_SETUP | NEED_WORK_TREE,
> > > .help = N_("Switch branches or restore working tree files"),
> > > .options = {
> > > OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
> > > ...
> > > },
> > > }
> > >
> > > This way we could run parse_options_show_gitcomp() from git.c and not
> > > worry about whatever cmd_checkout() needs.
> >
> > This only works for a few commands. Those with subcommands already
> > have struct option[] array scattered in different places. And some new
> > ones also have struct option array dynamically created.
> >
> > It's not impossible to do. But I feel there's a lot of reorganizing
> > for little gain. Maybe when we pass 'struct repository *' to all
> > commands, which means we hit all commmands at once anyway, we can
> > reconsider this (and having config parser in a more declarative form
> > like cmd option parser).
>
> Well yes, there is little *functional* gain at the moment, but this
> (or some version of this) must be done eventually.
>
> For the moment we still have an issue, but I see there's already a
> hack present for '-h', maybe we can re-utilize it. Something like
> this:
>
> --- a/git.c
> +++ b/git.c
> @@ -408,6 +408,8 @@ static int run_builtin(struct cmd_struct *p, int
> argc, const char **argv)
>
>         prefix = NULL;
>         help = argc == 2 && !strcmp(argv[1], "-h");
> +       if (!help)
> +               help = argc == 2 && !strcmp(argv[1], "--git-completion-helper");
>         if (!help) {
>                 if (p->option & RUN_SETUP)
>                         prefix = setup_git_directory();
>
> One way or the other, shouldn't my tests be merged? The issue is still
> there, and it's nice to have tests for that.

Is there any good reason to complete options when they are not going
to work anyway (e.g. like checkout which needs $GIT_DIR)? Besides "it
used to work before --git-completion-helper" which I don't consider a
good reason given the maintenance tradeoff of --git-completion-helper.
-- 
Duy

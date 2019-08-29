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
	by dcvr.yhbt.net (Postfix) with ESMTP id 245271F461
	for <e@80x24.org>; Thu, 29 Aug 2019 09:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfH2JcB (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 05:32:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45364 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2JcA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 05:32:00 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so5504053ioj.12
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gg2tVwkpAb5Qz6Uyx6VShxK2QDrsQdwQSQY2lB6ayWw=;
        b=mY6q+sOiC2TkOH0M1Z0Hy8EQf3ZB3FbRnt95p8bYEJgj5aQyaaj1goeJuJy9AGz8tK
         RIsnT8LwFxLdcql5qtKdHkfLGZS8MQfQgCxYGbclLmAtsQBfRv34fTkskGzSW0EadQ+n
         tZKMlHvwe3wx/p45sPvJRbTGe3W3+4ldC+04/ESw3+dEoDvWP3TbGlZJCqPOYEmmqSIQ
         CEsPKady1EhAim7Xj7vHsxkzfMKOR+O5JzuYN63cumHU1AKmbEiYZ+7MJBzJoKiGvlnF
         Uh3VlJnqR6qn5UlqIEZV3pQ3yqPEC/axpUBJjHnFuqIxs2YT9Fw/enellQ4HZOYOmq/Q
         QVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gg2tVwkpAb5Qz6Uyx6VShxK2QDrsQdwQSQY2lB6ayWw=;
        b=HxshME076G2XgcGyIoIVIp/nMcBpyMRHV2E5rDmN8yMXEENVHUb514r63Kzlicg+Uc
         4IGgV7GflueZshXdcjoZua0VhblyGKT7iYspV974rCVrxwW7IEMcCSKVLu3cahdm6Iu7
         bp3NJuKPrSGB/+KZIQatCig5pw9dNu7GR5nxbsMh/tZ5rI3dvoztcTHbaloJIHmFlPdg
         ojv9x+zF5ogqzY3OdZAgWOfO2SvMBvR2AX1I0bRfTG9eid8ElPq9IpdsxPq33qJvailk
         wrn9UuATaKdP41OkH8lS2o6DiseSo1UWlZZ3yDzyRVXOZ69tM5+d5rqMK0eph09j+1Xq
         l5pg==
X-Gm-Message-State: APjAAAW4KNmy2eP4pq8INmGsq5aRVviT0DoPnfxUELZmkvH9e8VxBrBl
        mhAP1crMm9j5RnMNt18roQxbIRcE0BAmdp3Ds/c=
X-Google-Smtp-Source: APXvYqwQpazupEK1lUqW+PIAlcd0wR6J/4u+is5KD58mYYB6fNUMp9uwm0ewpqGSNzjhBG4KmqAvacUCn8T2KASzFFI=
X-Received: by 2002:a5d:8253:: with SMTP id n19mr10091294ioo.274.1567071120125;
 Thu, 29 Aug 2019 02:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566863604.git.matheus.bernardino@usp.br>
 <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
 <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com>
 <CAHd-oW4h80xrp6y65dqZbq_a67ncArC9rrNq7F7rAhBbrALOkA@mail.gmail.com> <CAHd-oW6doh=06nxUkMLWZOwNMyUOogLRbLstD0bJVQxLauR_Aw@mail.gmail.com>
In-Reply-To: <CAHd-oW6doh=06nxUkMLWZOwNMyUOogLRbLstD0bJVQxLauR_Aw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Aug 2019 16:31:34 +0700
Message-ID: <CACsJy8DpTxpejkOHCYPnt3saC-h-3Ez0TthAPnPvHHThaG64bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: allow config_with_options() to handle any repo
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 11:24 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Aug 27, 2019 at 8:46 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > Hi, Duy
> >
> > On Tue, Aug 27, 2019 at 6:26 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Tue, Aug 27, 2019 at 6:57 AM Matheus Tavares
> > > <matheus.bernardino@usp.br> wrote:
> > > >
> > > > Currently, config_with_options() relies on the global the_repository
> > > > when it has to configure from a blob.
> > >
> > > Not really reading the patch, but my last experience with moving
> > > config.c away from the_repo [1] shows that there are more hidden
> > > dependencies, in git_path() and particularly the git_config_clear()
> > > call in git_config_set_multivar_... Not really sure if those deps
> > > really affect your goals or not. Have a look at that branch, filtering
> > > on config.c for more info (and if you want to pick up some patches
> > > from that, you have my sign-off).
> >
> > Thanks for the advice. Indeed, I see now that do_git_config_sequence()
> > may call git_pathdup(), which relies on the_repo. For my use in patch
> > 2/2, repo_config_with_options() won't ever get to call
> > do_git_config_sequence(), so that's fine. But in other use cases it
> > may have to, so I'll need to check that.
>
> While working on this, I think I may have found a bug: The
> repo_read_config() function takes a repository R as parameter and
> calls this chain of functions:
>
> repo_read_config(struct repository *R) > config_with_options() >
> do_git_config_sequence() > git_pathdup("config.worktree")
>
> Shouldn't, however, the last call consider R instead of using
> the_repository? i.e., use repo_git_path(R, "config.worktree"),
> instead?

Yes. You just found one of the plenty traps because the_repository is
still hidden in many core functions.

> If so, how could we get R there? I mean, we could pass it through this
> chain, but the chain already passes a "struct config_options", which
> carries the "commondir" and "git_dir" fields. So it would probably be
> confusing to have them and an extra repository parameter (which also
> has "commondir" and "git_dir"), right? Any ideas on how to better
> approach this?

I would change 'struct config_options' to carry 'struct repository'
which also contains git_dir and other info inside. Though I have no
idea how big that change would be (didn't check the code). Config code
relies on plenty callbacks without "void *cb_data" so relying on
global state is the only way in some cases.
-- 
Duy

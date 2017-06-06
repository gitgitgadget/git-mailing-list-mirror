Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F285209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdFFSTM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:19:12 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36043 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdFFSTL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:19:11 -0400
Received: by mail-ua0-f170.google.com with SMTP id h39so42305280uaa.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wekn4Vk1Dn/CRhyqHmkXV1PxPmD6Xb3/N1acrzHNDH0=;
        b=rog2EPoYCsaCsJnBC4JFJaGJpE791QX5TwdD061Mf+1XPMCGhM8IHbAGB7lw5pJ64J
         L1OTN+4igcYBd9u4ZbdlJ//d0O2DFOVzm1Zcy7pvMzT/oHPjOG1bhI9HrHmt1bm9ae3C
         iYkRqBAYI7RFTBut6XCLUVD8XMQYxgsAyfxA8eModTxY+mZvgTqSJL0w5rIlTPZlgk73
         mqKbVoIcBbTp38z5Ig9eARjDq55udG3JY+Whst0h13/hg77Gp0zxAgGSSsoqIiWrHGXD
         KPrV1W+GKFoQ7LZLJKBxYf2Vc3LHgfouRPWUAhxI23UimFSB+dVtacYDJsIUfpKdTBAL
         Kbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wekn4Vk1Dn/CRhyqHmkXV1PxPmD6Xb3/N1acrzHNDH0=;
        b=ixaeQB+Ij3L8YC/yTk10y3tXK+wAGcuj67Sr1qIJBUM7VJczDgmJnp+Ja77yTGO7BX
         hieG+mAqTLrM2wuXyLNUjQoNHJT0urkC/dqxfeggSQhaXA0NWAMsWcdHA9fSdvosWqJ+
         epLRDJvjXU+0TgeHhcLWtb1GzM+OGDlwbXgEJonIv1WdHoUYCulr1QbFVa6VMkVT/Z3e
         koqqIVetm5FoSaooARG3d0yMdVZZl9Jlp9sW2oosNlhETamLXSVXHDvl/dm+2wZzmIPP
         LdDZ+wt3AeWk7IZDWtZQxy+YRqoMT/JMk87C5XuOBbCXyKZL5R06IbwvUtmwh2iNiXZ6
         tT0A==
X-Gm-Message-State: AODbwcDsGfCdfgSNtJ+KIfzc6dGRk1oQmjjb6jd9la3CTPqYPx1osQ4d
        qt7sMbH1bGzLp1r5fRdvxyZVfpd1sg==
X-Received: by 10.176.25.207 with SMTP id r15mr13788080uai.45.1496773150012;
 Tue, 06 Jun 2017 11:19:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Tue, 6 Jun 2017 11:19:09 -0700 (PDT)
In-Reply-To: <20170605081845.tvzidc5nblbnuner@sigill.intra.peff.net>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com> <20170531042304.unkxkuw6s3tcpzkm@sigill.intra.peff.net>
 <CAM0VKjkfuyBzZmpJL47xmK24EOh6X5OjrxtxVdsgGupAseT_wQ@mail.gmail.com> <20170605081845.tvzidc5nblbnuner@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 6 Jun 2017 20:19:09 +0200
Message-ID: <CAM0VKjngnRv6iAozvhY_c61CyWhQP2khcr0bs1=7G_-MDNu4kg@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch refspecs
 during initial fetch
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 10:18 AM, Jeff King <peff@peff.net> wrote:
> Yeah, I agree it is safe now. I'm just worried about some function in
> remote.c later doing:
>
>    read_config();
>    add_and_parse_fetch_refspec(remotes[0], whatever);
>
> which leaves the struct in an inconsistent state (we realloc NULL which
> allocates from scratch, and all of the other entries in remote->fetch
> end up uninitialized).  Can we at least add an assertion like:
>
>   if (!remote->fetch)
>         BUG("cannot add refspec to an unparsed remote");
>
> ?

But as mentioned before, remote->fetch being NULL is not a bug in
itself, it's a perfectly valid value even in a fully parsed remote
when the remote has no fetch refspecs.
Therefore, I think, the condition should instead be:

  remote->fetch_refspec_nr && !remote->fetch

We could even try to be extra helpful by checking this condition and
calling parse_fetch_refspec() to initialize remote->fetch instead of
BUG()ing out.  However, that would mask the real issue, namely not
using remote_get() to get the remote, so I don't actually think that's
a good thing to do.

OTOH, having remote->fetch so closely related to, yet separate from
remote->fetch_refspec{,_nr,_alloc} will always inherently be error
prone.  This assertion would catch one case where a less than careful
dev could cause trouble, sure, but there will be still others left,
e.g. he could still do:

  add_fetch_refspec(remote, ...);    // this doesn't update remote->fetch
  for (i = 0; i < remote->fetch_refspec_nr; i++)
        func(remote->fetch[i]);

and watch the array indexing blow up in the last iteration.

Or a non-hypothetical one: when I first tried to use remote_get() for
an earlier version of this patch, I ALLOC_GROW()-ed remote->fetch to
create room for the default refspec, because in struct remote not
**fetch_refspec but *fetch is listed right above
fetch_refspec_{nr,alloc}, being way past my bedtime may be my only
excuse...  It didn't work :) [1]

To put your worries to rest we should eliminate remote->fetch_refspec
altogether and parse refspecs into remote->fetch right away, I'd
think.  After all, that's what's used in most places anyway, and it
can be easily turned back to a single string where needed (I think in
only 3 places in builtin/remote.c).


[1] - Though in the end this could be considered beneficial, because
      commits 53c5de29 (pickaxe: fix segfault with '-S<...>
      --pickaxe-regex', 2017-03-18), 59210dd56 (tests: make the
      'test_pause' helper work in non-verbose mode, 2017-03-18), and
      4ecae3c8c (tests: create an interactive gdb session with the
      'debug' helper, 2017-03-18) were all fallouts from the ensuing
      debugging session :)

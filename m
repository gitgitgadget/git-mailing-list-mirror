Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D1C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 22:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeLKWA1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 17:00:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38329 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKWAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 17:00:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so3894210wml.3
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JMTB9CuYvQMwWzPc+80EP81BDLiI+ypnxZp0Y9rgga4=;
        b=P3ERjWoIrPR0bzgZE9lXEhwdP6knN5i6Srnr8N9KZKuGZx963ifXYlPQTofT2BUQMg
         tfPAvBJejq4RM3/8ycLERLNfCPEthJvXBtqUT/PjkgOgBHdpgttjkz1YsJEfqOzZ4KWo
         /JHwxK9ccwmolS0NTJxJ07GWUWpGdDra5SwGkPmOaWook2kBp2KTGLv0Tt1E/b/aWbF+
         mhjUdAv9aV9kvxGx+afl4vTyA0DRpE3pliZERe7kOR7fKJlLAPMLIFZO4wFdqbvjr9oi
         H/K6B19Y3hVZwQ658ybVIhYFaSVstiGX2uOE4fc9GDpOLg5WqYFwIVN8AQttKgFxUcjA
         40Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMTB9CuYvQMwWzPc+80EP81BDLiI+ypnxZp0Y9rgga4=;
        b=qoCgkZAYLtAQxpd7/h0jB9Y3ET+5ZdymouiGX64j0BPiw6zBXuGHMMueCVEBVTJzWN
         ITiqXA3m3x8PxKmVQQ9zeLOAa89CCDU4AuTAgLF6g/IiKOdZ0SqwQ/2XEM+F1a2yDF5s
         r0mSAufjn3MBJbisCl2wT77oYfVm+kCpna60JYlkNdjHB/snlX7QZqjGxju77oOT16FV
         l07/nNa6TILeJfQ5i4UMrkVt1QaC24KTpOgGVdXXJSssfxSIQQD+bFCN9QzN6PhxNakT
         VXC+KYSntxBNBDI51YT3s7djpXBe26PLSF8vBscUnc8uU783IoU4KTAgotFygdvoqhaI
         nLBA==
X-Gm-Message-State: AA+aEWalMBiu1kAHQikslIfToKYwB7EurecjaKSgYnl2IOelHNb9iJ5o
        GR+b1QMZ2kr5pe8L9hYR+oCirxee
X-Google-Smtp-Source: AFSGD/VNaC/9yQAf0gZdymx4VGE//yNjo4UnUmbIDOCwNnTJC0y//eQG5qO608hFcsR2Avrwo0e3VA==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr4028132wma.109.1544565623886;
        Tue, 11 Dec 2018 14:00:23 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id 60sm28378069wrb.81.2018.12.11.14.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:00:22 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:00:22 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [PATCH 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
Message-ID: <20181211220021.GQ4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-4-t.gummerer@gmail.com>
 <CABPp-BHO7UmAm14HWf2tc+SVEZuWBqyvvrQg625fDsiDYPEL8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHO7UmAm14HWf2tc+SVEZuWBqyvvrQg625fDsiDYPEL8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Elijah Newren wrote:
> On Sun, Dec 9, 2018 at 12:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > 'checkout_entry()' currently only supports creating new entries in the
> > working tree, but not deleting them.  Add the ability to remove
> > entries at the same time if the entry is marked with the CE_WT_REMOVE
> > flag.
> >
> > Currently this doesn't have any effect, as the CE_WT_REMOVE flag is
> > only used in unpack-tree, however we will make use of this in a
> > subsequent step in the series.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  entry.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/entry.c b/entry.c
> > index 3ec148ceee..cd1c6601b6 100644
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -441,6 +441,13 @@ int checkout_entry(struct cache_entry *ce,
> >         static struct strbuf path = STRBUF_INIT;
> >         struct stat st;
> >
> > +       if (ce->ce_flags & CE_WT_REMOVE) {
> > +               if (topath)
> > +                       BUG("Can't remove entry to a path");
> 
> Minor nit: This error message is kinda hard to parse, for someone not
> that familiar with all the *_entry functions, like myself.  Maybe add
> a comment before this line:
>     /* No content and thus no path to create, so we have no pathname
> to return */
> or reword the error slightly?  Or maybe it's fine and I was just
> confused from lack of code familiarity, but I'll throw it out there
> since I stumbled on it a bit.

I'll try to make it more clear in the new round, thanks!

> > +               unlink_entry(ce);
> > +               return 0;
> > +       }
> > +
> >         if (topath)
> >                 return write_entry(ce, topath, state, 1);
> >
> > --
> > 2.20.0.405.gbc1bbc6f85

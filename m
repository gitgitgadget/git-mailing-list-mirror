Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62C41F462
	for <e@80x24.org>; Wed, 29 May 2019 20:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2UK4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 16:10:56 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:53187 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfE2UKz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 16:10:55 -0400
Received: by mail-it1-f176.google.com with SMTP id t184so6123444itf.2
        for <git@vger.kernel.org>; Wed, 29 May 2019 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ru96lpPFEcOSkXqq7PC7HTysyFH77/+ZCRqDYWGQY5w=;
        b=WPzVffRD+zAF50IIMYkikvIUUm9X7jOT4UwMMTW9A90NZd++gQqX7vAlS43cJFtDXn
         tQmMxGRRWxuynRSL/ZvSEZKrIrU9/Cpf/VjMaWzh+WWo7uoQNo1zyYFadLfOsBcKQRnw
         fYuItQaguDiYtFv2Ap6w5XDDPEFZKZ1ns2MY5P0AWUqFMcIBuOCbbqccNYXyUdEd76ub
         KyprCEeLMXLsBt7Yt9dg1ndTF9Lxrxh2gJssvoj1eaC1qdoiR8SNt3mShspTdqKTciHX
         KB/QDC4x9cuq5eyois6N6Iz5UGdUKiVmZlQjqmzAmnKcs2f065It6r5nZ2iPIWkZ/0Jz
         X5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ru96lpPFEcOSkXqq7PC7HTysyFH77/+ZCRqDYWGQY5w=;
        b=ThUt7j4+VC+6Q+1uDe3O5bV6bUBmoiPNWNM3Y1oMUeMeborVpR5pPzj/3ZpIOwJsUE
         QQ0sxIW0SVES/dS9Yk0sqR7Y8d4qeYMysQTPIsE2QroA+p+bjIVtnmFTXtgHZKy6Mm9D
         7JLt99wxb/3nV/G+VloGJf8650Qq6tK5e8nxR9d7gcJTL8PiEGjnkA7bBykkCUE6E+jW
         NNlwSye5n1T8R7SmMefVxySjcK6f3nxVd960/BYRqyrn3jGD7r5tMkmD+NsUu6H6wHqc
         r44LNmT+Aqy5FknQuo0VlVIhJsBdG4o4OEIhA2m6nVtyHsPXmOujVhxt8aALp2a2trFw
         gL2Q==
X-Gm-Message-State: APjAAAXL5O+TTkCN3ZDnm96NfCMm9FkC2r6OpCZ/GsIb1L6RSzyudlGV
        ngmYAN93hOlU/XfuU9vtxE+gR5jGJUm1L79g2a4=
X-Google-Smtp-Source: APXvYqxqu5YYP7qx5bPvnLgWrJNZSE+7k7N6KIKy/SuQTYD+NSWJu1q0l1V+oMrfRQ05jmcXYudg97KO1qVZENdwiqo=
X-Received: by 2002:a02:5488:: with SMTP id t130mr42829403jaa.20.1559160654566;
 Wed, 29 May 2019 13:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet> <20190528063451.GG7946@sigill.intra.peff.net>
 <CAKkfZL30QuBM6vT69OSS_keNuGi1U-bJ+jDiyDfhZmnr9L9xvA@mail.gmail.com>
 <20190528204051.GA24650@sigill.intra.peff.net> <CAKkfZL3ZNgNFzxrYbjbhCF5BR12vQPy2sNuYdxmQgmuG+mo9Gw@mail.gmail.com>
 <20190528205608.GC24650@sigill.intra.peff.net> <CAKkfZL1BmOjzJ1QrQ43gJx89si3-M_1KMz=EWXN=pK6HSjCEkQ@mail.gmail.com>
 <20190528213912.GH24650@sigill.intra.peff.net>
In-Reply-To: <20190528213912.GH24650@sigill.intra.peff.net>
From:   Brendan Boerner <bboerner.biz@gmail.com>
Date:   Wed, 29 May 2019 15:10:43 -0500
Message-ID: <CAKkfZL385B99fJ10V-yXVK3KpHNNA-fpM31zwvsBrfr02pD3jw@mail.gmail.com>
Subject: Re: 'git stash list' => Segmentation fault
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Jeff,

Yes, if I install gettext build from source envsubst and gettext no
segfaults. tset from ncurses segfaults as well unless I install from
source.

So weird breakage which manifested as a red herring. :-(

Thanks for your help helping me sort it out.

Regards,
Brendan



On Tue, May 28, 2019 at 4:39 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, May 28, 2019 at 04:29:13PM -0500, Brendan Boerner wrote:
>
> > To answer your previous question I'm using git v2.21.0. I'm using the
> > Ubuntu 14.04 PPA as well as Linuxbew (also v2.21.0).
> >
> > Your help helped me narrow this down to linuxbrew. Take it out of my
> > path no segfault.
> >
> > Uninstall linuxbrew git, linuxbrew still in PATH, use PPA git, segfault.
> >
> > Narrowed down further to be the "gettext" package - remove it from
> > linuxbrew and PPA git stash list => no segfault.
> >
> > I'll ping the Linuxbrew folks.
>
> Ah, that makes sense. You're indeed running the shell version, and it's
> invoking "gettext" for messages, which is probably what's segfaulting.
> And that explains the multiple segfaults and the fact that they didn't
> actually cause the overall operation to fail.
>
> So probably nothing here for Git to fix. Thanks for following up with
> the resolution!
>
> -Peff

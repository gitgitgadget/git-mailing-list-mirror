Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65E31F462
	for <e@80x24.org>; Tue, 28 May 2019 21:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfE1V3Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:29:25 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39173 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1V3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:29:24 -0400
Received: by mail-io1-f51.google.com with SMTP id r185so12163007iod.6
        for <git@vger.kernel.org>; Tue, 28 May 2019 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ty+MmHJ+K3HR6QGCDeoo5qLSsDPPU8w0HOKHjNrWXhk=;
        b=KPPG3tKKb+6ct8bRkbdi7IlYCXRPuQRmVhSj5gsjcyC9tp9yI6nmAf0kyEUnCPAiTz
         xwheG9v9+piEjRZ/w9GYvtqVD9LYr1CJJirextZfN4rxW0JYgpLNsuI1ErMQq1tff25R
         BXyv1moN51IeEcbUn3IT/siJSLh+iyrBXZNLaKJzbutIC4Mf/W66aSGTGtwKCmCItPpN
         g2tBko1LRfUwo3xJn/74bLoF0jfjo/6LUu/B8rSkA12xk86OHwLRROAUJLYCfFggIS3x
         +GmW3TcDyYeX4vS9LlsRnweokzPvvKwwPsmVkThFAxK2byM7JNp7uloYKXpQxghV4tL9
         bUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ty+MmHJ+K3HR6QGCDeoo5qLSsDPPU8w0HOKHjNrWXhk=;
        b=px6uQq2tyKJVAZneR2Rh7dZ2Eu/mpjYpjBuNiv578wIcoS/StmZtYZaOmbqYC5aeSy
         POnY5RgbmxUJUogltgn8q1Ny+nwIKNnmeELDjAECwxMT8NALFeJ+/LxIdv+fZRF0pb2Z
         OAkMT9oYqcgpW7hjs8iN0IgmsJCsAVf6FSoUTd8ngY6H+wfo9DmQIqcZ7GUqLb9nOwqT
         c6Cl5R9mK6pJeKbbtRZBt8M3m7Cp1ni84v0WOKCjYdk7+dto/dhjH3afqSiBvqdEkN7O
         KRIGQ2hhIxQitK/kbkM7sd5rq2AifAkEwG+COD8Mf+8ec6ct0TPp1Ki1/E2a3CKU+RRU
         q/vw==
X-Gm-Message-State: APjAAAXmqknYL3vJvDoExpIfCR/Q1p1ADJcIhoJWPZFCF70EOMtY+t1+
        kVLksO+5b11fjln6sfZm6yLDBg+QF2tNWI2douA=
X-Google-Smtp-Source: APXvYqzZYgQc01vpVRF4rq9DiGXkOT0+X22scyryJOQRo7hAQUCcQnjsoui8Db5XNaxTMufAihIK4y7Puy6gvrONSuA=
X-Received: by 2002:a5d:84ce:: with SMTP id z14mr20934976ior.107.1559078963982;
 Tue, 28 May 2019 14:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet> <20190528063451.GG7946@sigill.intra.peff.net>
 <CAKkfZL30QuBM6vT69OSS_keNuGi1U-bJ+jDiyDfhZmnr9L9xvA@mail.gmail.com>
 <20190528204051.GA24650@sigill.intra.peff.net> <CAKkfZL3ZNgNFzxrYbjbhCF5BR12vQPy2sNuYdxmQgmuG+mo9Gw@mail.gmail.com>
 <20190528205608.GC24650@sigill.intra.peff.net>
In-Reply-To: <20190528205608.GC24650@sigill.intra.peff.net>
From:   Brendan Boerner <bboerner.biz@gmail.com>
Date:   Tue, 28 May 2019 16:29:13 -0500
Message-ID: <CAKkfZL1BmOjzJ1QrQ43gJx89si3-M_1KMz=EWXN=pK6HSjCEkQ@mail.gmail.com>
Subject: Re: 'git stash list' => Segmentation fault
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff.

To answer your previous question I'm using git v2.21.0. I'm using the
Ubuntu 14.04 PPA as well as Linuxbew (also v2.21.0).

Your help helped me narrow this down to linuxbrew. Take it out of my
path no segfault.

Uninstall linuxbrew git, linuxbrew still in PATH, use PPA git, segfault.

Narrowed down further to be the "gettext" package - remove it from
linuxbrew and PPA git stash list => no segfault.

I'll ping the Linuxbrew folks.

Thanks for you help!
Brendan

On Tue, May 28, 2019 at 3:56 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, May 28, 2019 at 03:53:51PM -0500, Brendan Boerner wrote:
>
> > Lot of good tips for debugging for me to work on - I'll work on that.
> >
> > Both to avoid spamming the list and if sending large files e.g. strace
> > is it ok if I continue correspondence with you directly? (And
> > Johannes?)
>
> In general, please keep substantive responses on the list, so everybody
> can follow along. Adding to the list volume is fine. :)
>
> But certainly if there are sensitive bits, feel free to send them
> directly off-list.
>
> -Peff

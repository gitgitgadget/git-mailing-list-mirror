Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9E220A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 00:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeLIAH4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 19:07:56 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:46133 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLIAH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 19:07:56 -0500
Received: by mail-qk1-f169.google.com with SMTP id q1so4596929qkf.13
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgxJYijxk8cUhfY9Pqg3JeivLF2A7Y3Q33t5YeY0tjk=;
        b=iuzDBU+5gYYUHAO+8UG8r4aczaTAz2YgbVHfvBOM86Xj+mDJFOVTmRZQOtH5dh3fiq
         09PVtj1SlNFOYi8GnkhGQT+5Gitj0SlDTgWes8dGJgawhWLtdAqUrXuIBixRnO8rf5+0
         3r0nBJAhZRFg1EsR+30T1xwaqQ3DnyU3AkTPvGKo5u86+B/fgnxAhF5UMShkndHOC93f
         C8TQrjaE3+RU6B417vOjXeByUyie6kg6/HDhrrvtxoteG9fVhrj+rIiZFz76lQhNmsbT
         odMTLalgipOpEP38lPJTpLbCA6FybEEaFQIXsX/uVWuM+KNo8IdmoIW9ap7qAS5L/2sE
         is7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgxJYijxk8cUhfY9Pqg3JeivLF2A7Y3Q33t5YeY0tjk=;
        b=X0IU3xnHyDmAwMnhfJvwVaR7p8K4LfLXq6Q/dLTpBTm8h2adJFjvKcoKJ6MKq1uKeh
         463hvhSu+8yPnQxnMaejYrGnXBadDd9wjIhGdppzxYbLyTGmHduZixwcfhNLW0saOyTp
         tZgj82kKRopgi8WDPljj2Mc9BmFifpZLhkNwAdG7aMXf3K1dF+fmgdA/cMDvPLZBl67P
         F+PilWNIt1h3kumPBHtGTyWWIw1Dd81iA72U4eQs8yf7yUX40XTu6IsYAQvWJSyPzNHC
         Mtl04TpA41a8uCeg4v8dtuJROdmK+V1YPvgpmixk3Xm7UkXGnOl7QDNdI45iYjft7ArQ
         FBnw==
X-Gm-Message-State: AA+aEWYpXix8PbgUSktfCoFomEachh8L1K6iCnJ5v6k/9fSAhwQ3HY6f
        g8dbY4OngEwL4dnIM6s0gCtW40uPTf6n410Js2mI6wc=
X-Google-Smtp-Source: AFSGD/UjRcrob8/NQ4HrUF7GB74bG5yYkqh9UugyqMiRKv1JktD4up6qYUaPjibmtpgDZBnFxcEIflCXxBkUBZApOmw=
X-Received: by 2002:a37:e406:: with SMTP id y6mr6563194qkf.216.1544314074939;
 Sat, 08 Dec 2018 16:07:54 -0800 (PST)
MIME-Version: 1.0
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
 <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
 <20181207072004.GA32603@sigill.intra.peff.net> <CAGyf7-EkyGOi02fqMcCPBzj-=wpsH4zCgvP5VhOoKMdG+wfoLw@mail.gmail.com>
 <CADHAf1bH5Aaw3-5WvoHawjXUXL9B-YNvh+AYU1fpGbUe=c0E+A@mail.gmail.com> <20181208072915.GA20697@sigill.intra.peff.net>
In-Reply-To: <20181208072915.GA20697@sigill.intra.peff.net>
From:   biswaranjan panda <biswaranjan.nitrkl@gmail.com>
Date:   Sat, 8 Dec 2018 16:07:43 -0800
Message-ID: <CADHAf1Z=L2CeHax3nsP108yQr9G9xp+mhr+_F_zBcukr0kEFpQ@mail.gmail.com>
Subject: Re: Retrieving a file in git that was deleted and committed
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>You can feed a set of revisions to git-blame with the "-S" option, but I
>don't offhand know how it handles diffs (I think it would have to still
>diff each commit against its parent, since history is non-linear, and a
>list is inherently linear). You might want to experiment with that.

>Other than that, you can play with git-replace to produce a fake
>history, as if the deletion never happened. But note that will affect
>all commands, not just one particular blame. It might be a neat way to
>play with blame, but I doubt I'd leave the replacement in place in the
>long term.

> -Peff

Ah I see. Will try git-replace. Thanks!

On Fri, Dec 7, 2018 at 11:29 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Dec 07, 2018 at 01:50:57PM -0800, biswaranjan panda wrote:
>
> > Thanks Jeff and Bryan! However, I am curious that if there were a way
> > to tell git blame to skip a commit (the one which added the file again
> > and maybe the one which deleted it originally) while it walks back
> > through history, then it should just get back the
> > entire history right ?
>
> Not easily. ;)
>
> You can feed a set of revisions to git-blame with the "-S" option, but I
> don't offhand know how it handles diffs (I think it would have to still
> diff each commit against its parent, since history is non-linear, and a
> list is inherently linear). You might want to experiment with that.
>
> Other than that, you can play with git-replace to produce a fake
> history, as if the deletion never happened. But note that will affect
> all commands, not just one particular blame. It might be a neat way to
> play with blame, but I doubt I'd leave the replacement in place in the
> long term.
>
> -Peff



-- 
Thanks,
-Biswa

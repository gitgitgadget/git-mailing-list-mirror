Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34BC1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbfGZPgs (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:36:48 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36960 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbfGZPa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:59 -0400
Received: by mail-vs1-f68.google.com with SMTP id v6so36387811vsq.4
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCe9QET7dGGtL02Cy/9cpENQ9yYZiJ6RAyBlOBbN8b4=;
        b=MPz8U+9jdRGRkgH+CLcy6m7Ux7oT26fCilFzuE06gGMc5+DM6TOEvCQKGAux2RPfxJ
         Xc9jP7I8eu61iFvD33CLskwViPWKhXubLFqq+aS5oDCGREGgg2wMJWeyttcWlcwx37Zj
         gQHx6L/tGCUdtQcnS5Bk7VR2Cy5yepQMN+X61Z0DUPIEiSghnJ1/Rz5uVNMgcmPF4CLm
         erB6GparllLwfA2RdEc7Zvq1QYnBUBkIo6++luAeMK/CSIsB5M6kR/s1RZ4NAD/Nxin7
         tTvEfVf7mCewh9H1QzN644/l6hTXtOkONpz6n6IkxRkJPJEFtKHgdfpqtx19lVd2Qu9s
         lgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCe9QET7dGGtL02Cy/9cpENQ9yYZiJ6RAyBlOBbN8b4=;
        b=d0wX//vJFC4GPH4JkvJMc7u8At1wp6hUehwTHLckBqs+8mNO7v6tX4KpfXUz3/Ftam
         y49j9KABN7rrUGKoduMnvfbN/ypepjI2gNI/0+IAWcgVogPFDSzO3b695MHyfmeN9WPa
         +tbkW8oFaiSIAUf4PawSzJzJ002NtXKf9SYdiaGNjFhV7tMKOV9PeI6nv539mhcL636b
         /MLN6FxAgOG+6OLdSxqErStvVqMVKnsacDo3mo1p1oQPrjB+whs2Fg1esu+B9gbEqgqA
         m+s04JkxH0KHtd9d2zteSIItvdFUDOb/3CH3Y1/PtstCScRtVEkncRctmuzS/zTmT2vJ
         5ztw==
X-Gm-Message-State: APjAAAWLk6vVRV83UElKpiYIyqZ3BXiT1N97Oj3CqeiHQk99D5+VyK05
        C5sYLbLWKVb1ozxjUDF6djFINhPHvHuqmDosWR4=
X-Google-Smtp-Source: APXvYqwYQGApp/ClcG5kuxGRjDSlk7uOrwakewJn6vy2Ushxy5i2VPZbf0Ei+V4aIKZmfn2UrYmE7tKj8hNYvUHgk+Q=
X-Received: by 2002:a67:c419:: with SMTP id c25mr60161655vsk.136.1564155057886;
 Fri, 26 Jul 2019 08:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-16-newren@gmail.com>
 <nycvar.QRO.7.76.6.1907252206180.21907@tvgsbejvaqbjf.bet> <CABPp-BGpCEZ-40_SsT_vU+hCP=MiKzhky6yBr6G=UMnwLNR2Ow@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907261325120.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907261325120.21907@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jul 2019 08:30:46 -0700
Message-ID: <CABPp-BFRftNf8hoj8nTDiw+akci=w2qVAgamVDyRw1NUk-QCNA@mail.gmail.com>
Subject: Re: [PATCH 15/19] merge-recursive: split internal fields into a
 separate struct
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Jul 26, 2019 at 4:25 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Thu, 25 Jul 2019, Elijah Newren wrote:
>
> > On Thu, Jul 25, 2019 at 1:12 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:

> > But, more importantly:
> >   * I want to write an alternative merge strategy providing drop-in
> > replacement functions for merge_trees(), merge_recursive(), and
> > merge_recursive_generic(). Defining merge_options_internal inside
> > merge-recursive.h would mean that I have to have _exactly_ the same
> > internal options in my implementation of merge-ort.c.  That doesn't
> > make sense.
>
> Fair enough.
>
> I'm curious: what merge strategy are you planning on implementing?

recursive, done right[1].  For now, I'm calling it "Ostensibly
Recursive's Twin", or "ort" for short.  At first, people shouldn't be
able to notice any difference between it and the current recursive
strategy, other than the fact that I think I can make it a bit faster
(especially for big repos).  But it should allow me to fix some
(admittedly corner case) bugs that are harder to handle in the current
design, and I think that a merge that doesn't touch $GIT_WORK_TREE or
$GIT_INDEX_FILE will allow for some fun new features.  That's the hope
anyway.

[1] https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/

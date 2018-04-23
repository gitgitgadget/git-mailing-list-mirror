Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5B01F424
	for <e@80x24.org>; Mon, 23 Apr 2018 18:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeDWSuF (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 14:50:05 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43498 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeDWSuD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 14:50:03 -0400
Received: by mail-wr0-f174.google.com with SMTP id v15-v6so25939800wrm.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQnow9kyrp0ImgrrGENVXrpG6seHRrTSkA34Irmg07E=;
        b=LRfi/WVvfoe23Ujn/ol3UFcZL367uUjgovQ/9GHz0CVWYocAQLfnIWn3U3Itpdbzl1
         iL9sotmjMjYbIhvzWqwwboLPbvhg1exIfhrnP2Ftagt0tfEjPGq1Pt8TjYyrtwF4omQn
         3kdr3FetVWRRYz4yPyimqXxCZ+dxpfloOycCMgQmdcTtUAXus+8bkZgLbh9Txov42B4O
         hNnTsh0AACvvCNju1iZObqcMKwXwPhqRDobYPeTTkTeKq/l1lOXOwRQHCHD7QFN2+pmg
         tRG/vXDnHtG0BDA04ZtjkvBctaAqv6QEPE+PFsG+YjJ4TZGx9oCJR3jP6F0ApAUheMc/
         PQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQnow9kyrp0ImgrrGENVXrpG6seHRrTSkA34Irmg07E=;
        b=sHP2Se46ASkmqojvcjXK5FUgSCcYUpX4GwhsWTBEQpQ3IQn4q5yKF8Zg2NoA0a9fs1
         fzEHAv9Dvi5b8C+lh9PSPNhEXf7dQbTfIh3exUDsKiPKcdNofWiAJBveORvWyQTefIz6
         McRbhjO2Mmn03bZZV5CQ+ynSb1Onr48Kekf2H6iQP23Mzpax2lQgC1rFA2EP9saR3PV6
         mj2hhvIIPlRoeifwHpZ4BkYxqm7cV0Sg4ccfwmAT06vuAaV0lDyU2HHRkYq1mTurkn4Y
         1ARXnFA0bu8fY1XrUsDHvGgdvhWv6+bmQqSIx32mee/E1sLeA0q0yKZAfKbvsIhuxkv9
         7vUg==
X-Gm-Message-State: ALQs6tD2kGD9hsTSQSpwMpVT9CVR1MF+lC+FcrcPfr2LpNesDG/hPZ+Q
        1Cbq1llL0MaLfPWj1zfRm82Nj2Op
X-Google-Smtp-Source: AIpwx4/D/GFQtVw/tLO8iE6LxK8sTdIMFD2C6bHQxqEnviLwjFQ3bHoaKpB55rxZhfcj3aiR17PCxw==
X-Received: by 10.28.94.210 with SMTP id s201mr10852357wmb.140.1524509401824;
        Mon, 23 Apr 2018 11:50:01 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f10-v6sm12581058wrg.0.2018.04.23.11.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 11:50:00 -0700 (PDT)
Date:   Mon, 23 Apr 2018 19:50:08 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/4] worktree: improve message when creating a new
 worktree
Message-ID: <20180423185008.GB25294@hank>
References: <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180415202917.4360-3-t.gummerer@gmail.com>
 <CAPig+cQSgY3yqYtZwTCY7Mq1e66WczbV3vM7=KsKH4b7peDw+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQSgY3yqYtZwTCY7Mq1e66WczbV3vM7=KsKH4b7peDw+Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/23, Eric Sunshine wrote:
> On Sun, Apr 15, 2018 at 4:29 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Currently 'git worktree add' produces output like the following:
> >
> >     Preparing ../foo (identifier foo)
> >     HEAD is now at 26da330922 <title>
> > [...]
> > Instead of this message, print a message that gives the user a bit more
> > detail of what exactly 'git worktree' is doing.  There are various dwim
> > modes which are perform some magic under the hood, which should be
> > helpful to users.  Just from the output of the command it is not always
> > visible to users what exactly has happened.
> >
> > Help the users a bit more by modifying the "Preparing ..." message and
> > adding some additional information of what 'git worktree add' did under
> > the hood, while not displaying the identifier anymore.
> >
> > Currently this ends up in three different cases:
> >
> >   - 'git worktree add -b ...' or 'git worktree add <path>' [...]
> >
> >   - 'git worktree add -B ...', which may either create a new branch if
> >     the branch with the given name does not exist yet, or resets an
> >     existing branch to the current HEAD, or the commit-ish given.
> >     Depending on which action is taken, we'll end up with the following
> >     output:
> >
> >       Preparing worktree (resetting branch 'next' (was at caa68db14))
> >       HEAD is now at 26da330922 <title>
> 
> The (...) embedded inside another (...) is ugly and hard to read.
> Better perhaps:
> 
>     Preparing worktree (resetting branch 'next'; was at caa68db14)
> 
> Not necessarily worth a re-roll. It would be nice to see this series
> land; perhaps this can be tweaked later.

I'll tweak it while fixing the other bit.

> >     or:
> >
> >       Preparing worktree (new branch '<branch>')
> >       HEAD is now at 26da330922 <title>
> >
> >   - 'git worktree add --detach' or 'git worktree add <path> <branch>',
> >     both of which create a new worktree with a detached HEAD, for which
> >     we will print the following output:
> >
> >       Preparing worktree (detached HEAD 26da330922)
> >       HEAD is now at 26da330922 <title>
> 
> This is inaccurate, isn't it? Certainly, specifying something like
> "origin/floop" for <branch> ends up detached:

Ah indeed, this was the case I missed.  I thought I managed to go
through all of them, but this one slipped through the cracks.  Thanks
for catching this, will fix in a re-roll.

>     % git worktree add w1 origin/floop
>     ...
>     % git worktree list
>     /proj     fe0a9eaf31 [master]
>     /proj/w1  b46fe60e1d (detached HEAD)
> 
> but specifying an existing local branch (say "wip") does not end up detached:
> 
>     % git worktree add w2 wip
>     ...
>     % git worktree list
>     /proj     fe0a9eaf31 [master]
>     /proj/w1  b46fe60e1d (detached HEAD)
>     /proj/w2  820ed2a513 [wip]
> 
> > Additionally currently the "Preparing ..." line is printed to stderr,
> > while the "HEAD is now at ..." line is printed to stdout by 'git reset
> > --hard', which is used internally by 'git worktree add'.  Fix this
> > inconsistency by printing the "Preparing ..." message to stdout as
> > well.  As "Preparing ..." is not an error, stdout also seems like the
> > more appropriate output stream.
> >
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

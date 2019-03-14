Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F256220248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCNFqB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:46:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42705 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCNFqB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:46:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id u7so4749773qtg.9
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zm3h2YtewRU2/nPyvhL8OojvC/yQXSdj6mz0StvjS3o=;
        b=AAh+d+GQ/09Hsf0IzR9cAT2uRV//IH36JwEM8dpyqonuxi8jEPlECCIQnxwrQUg81S
         IckjqnxTojyBc2arptxz/oG/82hmAqJghBClIK1bLDL9hSwr+nIRaTEXalcqDvpIEYLU
         2x5A3NrHLaq86kNZcotRgHwDySB/1XVAc0ZTeXGgQ2T8Svku8OeJpiZ9ggEP48JMFG3k
         GYCbozFM2ll+NZ7iM//h+WpMqI8bCKHydzqwhueb2nysQFQvTog/MpKCEWlNBuD9It9C
         T1pvHVgmJhn0dsm9jn2QQ438qJsWZV+JQafaVI1r6H0hiDvi/Q8LVsAJs1v0OOjNlaFb
         xOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zm3h2YtewRU2/nPyvhL8OojvC/yQXSdj6mz0StvjS3o=;
        b=dDuZdMiTKHsYA68PsKRDOsGpOJ3MgByUA8ey9UyjyfdxVp83E5zTzM+cQCiz433/ku
         3kSvtwWhfd94DYGiCpKaE5ZdTa28hMqfR3OK6zEDQflCIxIMk5EvKwEzUZjRtjZjkYtM
         4UhDJ35z/aVuCKs5aY/mNixhxrqJINGtHewuK/eYjVq/3qN5M/Z7ctYw/Hns/JAQ6x/D
         t6R3UB5b9VZDDoNbMfpi/kNSCkHa++jxDrhp3BZGveaemb3K3s56Ue2QeKqhGV32oqXO
         YQNIJf3VQ6O/Vof4oa3Io0b+tf1BcOndbYTir/gVRgsFlH06Klz/m8MDAKlh/KQqwjT7
         G2lw==
X-Gm-Message-State: APjAAAXef42D4pNZyVSFhqySU+IOnWpHWbAYvR4AlNAZD9I6W7NdE1FM
        7Q3YPATxgm/RpavaN0fAk9v/KQCUFzrojZUOgOA=
X-Google-Smtp-Source: APXvYqyPtP1duVJ9XB8lu2XCVHccaZkwUv/h41KEHBW0ien7LrDV1HQj7kQCHkUTb3PI68DYthDTu45w0h/JWtm3Wu4=
X-Received: by 2002:ac8:2961:: with SMTP id z30mr36650784qtz.283.1552542359966;
 Wed, 13 Mar 2019 22:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-3-nbelakovski@gmail.com> <20190221124408.GA13403@sigill.intra.peff.net>
In-Reply-To: <20190221124408.GA13403@sigill.intra.peff.net>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 13 Mar 2019 22:45:33 -0700
Message-ID: <CAC05385ECz0=zfBHungpFHqPT5Wr0PviduEBraUWbBVrwHMzaA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] branch: update output to include worktree info
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 4:44 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 19, 2019 at 05:31:22PM +0900, nbelakovski@gmail.com wrote:
>
> > From: Nickolai Belakovski <nbelakovski@gmail.com>
> >
> > The output of git branch is modified to mark branches checkout out in a
>
> s/checkout out/checked out/ ?
>
Yes, thanks
>
> > -     strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
> > -                 branch_get_color(BRANCH_COLOR_CURRENT),
> > -                 branch_get_color(BRANCH_COLOR_LOCAL));
> > +     strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
> > +                     branch_get_color(BRANCH_COLOR_CURRENT),
> > +                     branch_get_color(BRANCH_COLOR_WORKTREE),
> > +                     branch_get_color(BRANCH_COLOR_LOCAL));
>
> Makes sense. The long line is ugly. Our format does not support breaking
> long lines, though we could break the C string, I think, like:
>
>   strbuf_add(&local,
>              "%%(if)%%(HEAD)"
>                "%%(then)* %s"
>              "%%(else)%(if)%%(worktreepath)"
>                "%%(then)+ %s"
>              "%%(else)"
>                "%%(then)  %s"
>              "%%(end)%%(end)");
>
> That's pretty ugly, too, but it at least shows the conditional
> structure.
True, but other lines within that file are about as long. I'd feel
that I should make all of them reflect the conditional structure if
I'm going to make one of them reflect it. Granted none of the others
have nested if's, but personally I think it's OK as is. The nested if
is short enough.
>
> >
> > +test_expect_success '"add" a worktree' '
> > +     mkdir worktree_dir &&
> > +     git worktree add -b master_worktree worktree_dir master
> > +'
>
> This mkdir gets deleted in the next patch. It should just not be added
> here.
Whoops, removed
>
> > +cat >expect <<'EOF'
> > +* <GREEN>(HEAD detached from fromtag)<RESET>
> > +  ambiguous<RESET>
> > +  branch-one<RESET>
> > +  branch-two<RESET>
> > +  master<RESET>
> > ++ <CYAN>master_worktree<RESET>
> > +  ref-to-branch<RESET> -> branch-one
> > +  ref-to-remote<RESET> -> origin/branch-one
> > +EOF
> > +test_expect_success TTY 'worktree colors correct' '
> > +     test_terminal git branch >actual.raw &&
> > +     test_decode_color <actual.raw >actual &&
> > +     test_cmp expect actual
> > +'
>
> We are not testing the auto-color behavior here, so I think you could
> just use "git branch --color >actual.raw" and drop the TTY prerequisite.
> That's shorter and simpler, and will let your test run on more
> platforms.
>
Done locally, will be part of v9

> -Peff

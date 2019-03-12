Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1537720248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfCLRFU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:05:20 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33828 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLRFU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:05:20 -0400
Received: by mail-ua1-f65.google.com with SMTP id a42so1055306uad.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6svxEh3ixwz/Ttx/WY+8gdFAIMWzWF78O2UTg5HJb3c=;
        b=bo2oSmTtwD0xJnlHawWJoJteI9Mrtm3a8BPsRrP1IU+ncof1GGVQQSJuWRd7945W2m
         he5s8cejl6TYrVsCfEmg+emRDNIXplC9Q97lM00N0FaL4I2BOWbLnJ0+3T9atx9okEOM
         eppgKZsVH1V3cgWS7SYycGolKwTCdIOX27SrRNmqXQfVCi0k5eHH9j0AAzMhLhdOyfmM
         bl812420hA2dIYJWigUQ8cn4q4UUOwyfv9QeELRkaBLL4+2VOn9m7hUYcrq5M1kSjXSg
         nZygTuC0BCW/pRj09xQORia4G+2gH2yzW1Sh8pZNuxIE0vqfWQB+94EJ6eG6I8kgnyQS
         I44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6svxEh3ixwz/Ttx/WY+8gdFAIMWzWF78O2UTg5HJb3c=;
        b=m/RpXWfRFYkVUWb9ctXWK0DUnpWH6SRsMDYLdsoAtd/sx6Yx3uPSz647hqECNtrKO2
         L0F7ZJLklpPPYfnNc/idJV4RZp1w1fDjyhLtXFcvhZW9ynrSz7IMLCbEjoMhaOTmIJm9
         K4wkMy7yPlOB+zQaLmwDaA3k4dAWzbhOH8gGPsJXnkSPulY6dxQrAVnGWsKhi0xzIIQ6
         9FGqK3WltNC8f4vbEFiioQz2kKAfEtOeMlFQnckqjtBPNotuykMT3c7J/8vANRHgBg+Y
         1mtaI234xsi2ncAG42LhUZOjPeI4y8w5onb3ef97KytOdIjccZfLXAoT25qSP/cKV4nk
         PyqQ==
X-Gm-Message-State: APjAAAVHkVMcKJr0ddGT7hs0v7BVn/njyHOxSFwRfhleddA9wSXoTOM4
        lHrB1m3J4YeF0O9opWvSyXU/F8wCYh6Bh66Y+MY=
X-Google-Smtp-Source: APXvYqydj9bqqczdKHMeah+Lo0o3mXSWLCS/e2R/5no0IaQEz5pbTNiLm22a8V3chze/o1HgWDX1rCkKknZsN9g1sMA=
X-Received: by 2002:ab0:6513:: with SMTP id w19mr20488279uam.19.1552410318808;
 Tue, 12 Mar 2019 10:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com> <CACsJy8Ax0nt1zt9eqNs6QM4gCS-PFfXH9woxd81X-_zywQRnVw@mail.gmail.com>
In-Reply-To: <CACsJy8Ax0nt1zt9eqNs6QM4gCS-PFfXH9woxd81X-_zywQRnVw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Mar 2019 10:05:06 -0700
Message-ID: <CABPp-BFw2O_N8bYz8DDSj5RWhn-TNh7Z8ww4joKYvL4CQrOO4g@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 4:58 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 12, 2019 at 12:25 AM Elijah Newren <newren@gmail.com> wrote:
> > On Mon, Mar 11, 2019 at 4:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > > On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.c=
om> wrote:

> > > > On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrot=
e:
> > > > > "git checkout" doing too many things is a source of confusion for=
 many
> > > > > users (and it even bites old timers sometimes). To remedy that, t=
he
> > > > > command will be split into two new ones: switch and
> > > > > something-to-checkout-paths.
> > > >
> > > > I think this is a good idea, thanks for working on it. I wonder if =
it
> > > > would be a good idea to have the new command refuse to checkout a n=
ew
> > > > branch if there is a cherry-pick/revert/merge/rebase in progress (w=
ith
> > > > an option to override the check) as switching branches in the middl=
e of
> > > > one of those is likely to be confusing to users (if I do it it is
> > > > normally because I've forgotten that I've not run 'git whatever
> > > > --continue').
> > >
> > > Interesting. I think this would be a good default if we have an escap=
e
> > > hatch (which could even come later). I often wander off to some other
> > > branch and go back. But then half the time I end up forgetting I'm in
> > > a middle of something and just "git rebase --quit" :P
> > >
> > > Of course with git-stash (*) and git-worktree, I guess there's little
> > > reason to just switch away from a something-in-progress worktree. I'l=
l
> > > try to implement this in the next round, unless someone objects.
> >
> > No objection here; I like this idea.
>
> One last thing. What about --detach? Should it have the same
> protection or should we let the user doing --detach (experiments) take
> the responsibity to not screw themselves up?

My intuition here is a bit weaker; it would be nice to hear others'
opinions.  My best guess thinking it over a bit is that while someone
doing --detach is more likely to know what they are doing than other
users of the 'switch' command, they may also be the kind of person who
is more likely to run interactive rebases and thus had more
opportunities to forget that they are still in the middle of one.  I
think I've been guilty of that a few times.  So, while this would be
less critical for this case, I lean towards saying that it may still
be helpful anyway, and if nothing else the consistency of handling all
switching cases the same seems beneficial.

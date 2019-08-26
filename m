Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAD11F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfHZT1P (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:27:15 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46524 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbfHZT1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:27:15 -0400
Received: by mail-vk1-f194.google.com with SMTP id m195so2160914vke.13
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ET16NCwDIWa5mRdfJBc+Y0ed5a39W9F7fOlTS366+Q=;
        b=p6iEnz9Rbk4cQ3CIdOkazkN1AyTi+MW3qbPfh+evxrzgnwcfqdq+yuNz/313s5wf2e
         y/wM541eYgv2C9xMrxrlgiD/sH48oV+HfbMqCKE05u06ITNIEXxXNBt4p7PxA8G1o6wU
         94SFdyEUw7NARzjTXNAkvdxlDcBadu799a85EkJHhCj5JZtsREA7LtW0uX1AcwOzXM3S
         HyTjPw0afhs8kigvbSs35czEXQ8M834EwZxNTJJV5HC8Og5U7t/XaICTTKPINYIwLuU/
         YDW1pdjCr/vu3oNLvWdLTBEiEmepWpNFG3Db6rmRi6h0CH1ifvV0qd2/QrfumLee2qoU
         WJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ET16NCwDIWa5mRdfJBc+Y0ed5a39W9F7fOlTS366+Q=;
        b=dPrI2h6ovstjE86tW+4D9GlYF2A+9H4q8SgD8JnRQPxvBvoC21J3ZN9iAFJn6QzPxu
         E6pQUlY5DzlLtD8PZPP76Q+oxmIyd3t14DWuBlr0zMAVgVB1X/w/QYvsrc6LflvO968Y
         xrUlYd+XyTZ4dtnIZKSUy21u0fkrebW5U4tj/XRncd9yLaShrcfktqEDzgXoisBT/QoS
         6mr1uimIbWIgi/eF03c/mKLiVZPMPGpL1tliFICVa6YbEkGbr8jsJPbGUs2i1bY68ePd
         wKYzF2BBDOnK+CHSqufCmwnCvB0I+3blrppqr2QLzdtLYcawerL+JGoMQODRB6jFu9B+
         X6/Q==
X-Gm-Message-State: APjAAAUArMctukDr2W3hqX0fgKP7HOzRNek6l3OdN3MDwHrPRiCrCy2a
        oX0N7udKozy1MtBMXGrb/QF7uNA6I7ywxO8Jmrs=
X-Google-Smtp-Source: APXvYqzw7ECWtNZX9+OxXEN0pYO2z7DzgjEZb5rlHpwOkmKr+HCTAGtU/sWu1IeI2xAH3+yJCqQj7K78Hnw1MgcGj0w=
X-Received: by 2002:a1f:4bc5:: with SMTP id y188mr8577048vka.92.1566847634320;
 Mon, 26 Aug 2019 12:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <005f01d55a1f$88e2ab20$9aa80160$@rogers.com> <CAGyf7-HyJGVX51YMH0uqah4dkwkwfs6pLR5eSVBCeRQ1Ou=ZjQ@mail.gmail.com>
 <006001d55c18$e6def6c0$b49ce440$@rogers.com> <20190826182134.GA23399@sigill.intra.peff.net>
In-Reply-To: <20190826182134.GA23399@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Aug 2019 12:27:03 -0700
Message-ID: <CABPp-BHHPBJLxV=_Y3Vu9cG1x1Vg-fdfadud9w5FA+aeAWTaKw@mail.gmail.com>
Subject: Re: [Question] clone performance
To:     Jeff King <peff@peff.net>
Cc:     randall.s.becker@rogers.com, Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 12:04 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 26, 2019 at 10:16:48AM -0400, randall.s.becker@rogers.com wrote:
>
> > On August 24, 2019 5:00 PM, Bryan Turner wrote:
> > > On Fri, Aug 23, 2019 at 6:59 PM <randall.s.becker@rogers.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > I'm trying to answer a question for a customer on clone performance.
> > > > They are doing at least 2-3 clones a day, of repositories with about
> > > > 2500 files and 10Gb of content. This is stressing the file system.
> > >
> > > Can you go into a bit more detail about what "stress" means? Using too
> > > much disk space? Too many IOPS reading/packing? Since you specifically
> > > called out the filesystem, does that mean the CPU/memory usage is
> > > acceptable?
> >
> > The upstream is BitBucket, which does a gc frequently. I'm not sure
> > any of this is relating to the pack structure. Git is spending most of
> > its time writing the large number of large files into the working
> > directory - it is stress mostly the disk, with a bit on the CPU
> > (neither is acceptable to the customer). I am really unsure there is
> > any way to make things better. The core issue is that the customer
> > insists on doing a clone for every feature branch instead of using
> > pull/checkout. I have been unable to change their mind - to this point
> > anyway.
>
> Yeah, at the point of checkout there's basically no impact from anything
> the server is doing or has done (technically it could make things worse
> for you by returning a pack with absurdly long delta chains or
> something, but that would be CPU and not disk stress).
>
> I doubt there's much to optimize in Git here. It's literally just
> writing files to disk as quickly as it can, and it sounds like disk
> performance is your bottleneck.

Well, if it's just checkout, Stolee's sparse-checkout series he just
posted may be of interest to them...once it's polished up and included
in git, of course.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADA51F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeIKVfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:35:22 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:42046 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeIKVfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:35:22 -0400
Received: by mail-ua1-f49.google.com with SMTP id w7-v6so21193013uan.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaC29Hnv73gFJg420H7xxYBOswGdMHgw0JpWyX4qBno=;
        b=lwYHaB0bccbyjJ9tIrEQr2Y/Kw1Y4LUgKLnU4lrAuRCMgpzaCmYQ9x3GFzdh95wICD
         vyv0vvk535N6VoM7B5O1AJj951ekWkqTukxpT8zEPDF0ZaqF5RIhcYSfK9M1nmqekW2H
         Hkc85bvBhDrj0bpnRnKH+MZXQYBBf+WCmIBG7oArnj/A0Eb0I72twud9zoZyy3P643ab
         o5Np7jhZJEdFxoqTuZzHqSHOPKunWQPPxLEKuqKDxcQTptBNXgrCnJ7iNap/7jgF198M
         VCFH03V7JPojVlGaftEjYsy20J24lyP7A0soA3jLHrAuYbCdtoKzqRv/PUsA7HnFteKc
         PQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaC29Hnv73gFJg420H7xxYBOswGdMHgw0JpWyX4qBno=;
        b=FJpDSsJT1T34C/QOYKQ9RfsqYskqiy/CP6cD1cCPYpW/8Dyrt+T8g08ozpW8/WW8dy
         wm9DVjC33u6gUdeZSTV73Doyhekacpb/3ipg7qKTm7CMEjgNtUXMrgGIxcB/8jYAQ6Nu
         rAdIdp45Qjjm1RdhgYby1Yiyo96EXoCrZgVMSW1maqLNcRzowzcX9uWzOSMyafGacPle
         9ElBuAY/xk2sCj8TjVZWxrke/tuzcr80UodjDdrThLaiAtfvPq/DTp58LN1bclG8CZbm
         vsI+h1MJGJb/jtt5PgBhS9LXny6dxqf6lKjps6EVIDjyOoAXvk9Goei4ETdrK/4oP1qg
         /7Gw==
X-Gm-Message-State: APzg51CaZ/iDJdw4PncQBmDEf7sf/IOT6CqNEhA/T9B/JKpArndU2YHX
        3p8jc/6G0Y5filYQviTcaeSIb9vQyQs0sarKw7n773OG
X-Google-Smtp-Source: ANB0VdZXWVeF//+xBmFsixfr3NT+7ReDHobY2tVnnawTC2Rz2FLdFFyfC1MLGFWeHLATnXBRAm2lvoPJum+tqOYn5to=
X-Received: by 2002:ab0:5339:: with SMTP id x54-v6mr8542437uax.187.1536683715390;
 Tue, 11 Sep 2018 09:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <20180911154906.GA4865@hank.intra.tgummerer.com> <CAKkAvaw4QTMzKXpkpAaMhZaz68=OdS_AmrMXyu6C9td2P+XmTg@mail.gmail.com>
In-Reply-To: <CAKkAvaw4QTMzKXpkpAaMhZaz68=OdS_AmrMXyu6C9td2P+XmTg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Sep 2018 09:35:03 -0700
Message-ID: <CABPp-BG7YJF=m0Z82wp_JVXn3fiHW4FeL6WK2FdOOkdFx9LguA@mail.gmail.com>
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
To:     ryenus@gmail.com
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 9:07 AM ryenus <ryenus@gmail.com> wrote:
> On Tue, 11 Sep 2018 at 23:49, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Hi,
> >
> > thanks for your bug report!
> >
> > On 09/11, ryenus wrote:
> > > I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
> > > only got a Segmentation fault: 11
> > >
> > >     $ git version; git range-diff origin/master  HEAD@{2} HEAD
> >
> > Unfortunately the HEAD@{2} syntax needs your reflog, which is not
> > available when just cloning the repository (the reflog is only local
> > and not pushed to the remote repository).  Would it be possible to
> > create a short script to create the repository where you're
> > experiencing the behaviour, or replacing 'origin/master', 'HEAD@{2}'
> > and 'HEAD' with the actual commit ids?
>
> so `HEAD~2` should be used instead of `HEAD@{2}`, right?
> I just tried the following and got same error:
>
>     $ git range-diff master patch~2 patch
>     Segmentation fault: 11

After cloning the repo and running
$ git range-diff master origin/patch~2 origin/patch

I cannot reproduce on either Linux or Mac OS X.  On Mac OS X, I tried
both with a locally built git-2.19 from sources, as well as an
homebrew-installed version of git-2.19.0.

For reference here's what I get running git rev-parse on those arguments:
$ git rev-parse master origin/patch~2 origin/patch
f14d571887c1b98fd22c60bc21c11700456162fa
5c7e07ebfbc7de5304deab6a04b476e6fa082d0e
ad8a185de38bfe546dd64fe37ae566de260d73c2

Is there any chance I'm misunderstanding or the repo doesn't have the
commits you were actually using to reproduce the bug?

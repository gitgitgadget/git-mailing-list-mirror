Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406031F404
	for <e@80x24.org>; Thu, 30 Aug 2018 17:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeH3VZf (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 17:25:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45821 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeH3VZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 17:25:34 -0400
Received: by mail-ua1-f65.google.com with SMTP id q7-v6so6137840uam.12
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJmeWA9+voERjJ2xqdUlS0IYBo2qdJkxPF1JpGMd9Is=;
        b=MlA5pUp0Abxw0dQ5IjQK/lqEehnfKb/41H/T0alBVlygku5XXBui3RVgNI5Wz+AlRC
         +uwGD6hPBmIPZweZSyFwGrWlvGo4c4+pzSJLA0JFNQhApls/MudkdJw8PrSSSpSx0R1O
         +S2zqT32F5AWQY/XU618Uv1Sr8GrCKGkIc70NfyNEPqiFoF6Ctbm0ZYdXJuhteLPCEfF
         +eJMZu1SS4MeZISf1h5u9kHqOXwdhdeQ0x1LWYOcoes/MVZ2l2umAsS+wm5VAI4L1Nes
         LPMxYPFtWyQrEKhxF3QqL0gxpOjzDN8oqHtu8fq1gSrGOiEZyjbUE4ogLf6aWZjgzY+3
         djfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJmeWA9+voERjJ2xqdUlS0IYBo2qdJkxPF1JpGMd9Is=;
        b=K28wQ3j1q+WQmxKfGM+onhsYdATf6CNsFlIezI+JPwTcwFs2oQU1mFwtqdQo1eDc95
         V4y85OSW2KQ08O9BbsMDiPbzUcrBThYd5NcMIzFUtHx0b0827KZRED0954nUoGg3O2AQ
         ytkmorr6sBr2DqlF2FTn++vLZJ6Uqf1qMaW0EnwZ9xTMBBcXoDmE/jfjXfP6YwtDlCrK
         7A0fHf5hkkcnTXrofgxaSPqX4zY9j82d6RJGgvICKNPETlm5yiMy9Gq+FIgdwl8/d0Ju
         UJImyB8Pq4EK44P6xYklugMUMLDNKb79BDoY0CsxOOOyXOzW1Zvcp6hrrvCRTpzUKoxJ
         jCCg==
X-Gm-Message-State: APzg51ChqnuXWwtiAI6kiH9BgTk7PneeGMoUqQaks5y0wHN0xVJ+akb1
        E8RKHA1gKPzpjS3vQXzBoW91wrLsLGTCAwL6dbU=
X-Google-Smtp-Source: ANB0VdZ/xsGZ5mWq3Hk8xA1UaSnCLageqDiZWJUD+6DZm1TZ3qcvQUodqUSc06fcL/yDpSioL8qfvW2t6D3zrC3P2OI=
X-Received: by 2002:ab0:5339:: with SMTP id x54-v6mr7313526uax.187.1535649744437;
 Thu, 30 Aug 2018 10:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180816182653.15580-1-benpeart@microsoft.com> <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
 <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com> <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
 <f88299c5-1697-a7ef-87d6-69f5c19d5a68@gmail.com> <CABPp-BFKf2N6TYzCCneRwWUektMzRMnHLZ8JT64q=MGj5WQZkA@mail.gmail.com>
 <CACsJy8ArUXD0cF2vQAVnzM_AGto2k2yQTFuTO7PhP4ffHM8dVQ@mail.gmail.com>
In-Reply-To: <CACsJy8ArUXD0cF2vQAVnzM_AGto2k2yQTFuTO7PhP4ffHM8dVQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Aug 2018 10:22:12 -0700
Message-ID: <CABPp-BGE-m_UFfUt_moXG-YR=ZW8hMzMwraD7fkFV-+sEHw36w@mail.gmail.com>
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, Aug 21, 2018 at 7:52 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Aug 20, 2018 at 8:16 PM Elijah Newren <newren@gmail.com> wrote:
> > Playing with sparse-checkout, it feels to me like a half-baked
> > feature.  It seems like it required too much manual work, and it was
> > sometimes hard to tell if I was misunderstanding configuration rules
> > or I was just running into bugs in the code.  I think I hit both but I
> > didn't really want to get side-tracked further, yet.  (I do want to
> > eventually come back to it.)  The only reason someone would go through
> > that pain is if it provided massive performance benefits.
>
> In my defense it was one of my first contribution when I was naiver
> and basically an evolution of "git update-index --assume-unchanged". I
> have something in the queue to improve/complement sparse-checkout but
> my last update on that branch was 2.5 years ago, so it's not coming
> soon.
>
> I'd love to year how sparse checkout could be improved, or even
> replaced. I think we still have to have some configuration rules, and
> yes the flexibility of sparse checkout (or gitignore to be precise)
> rules is a double-edged sword.

Sorry for taking a while to respond, and if what I said came across
harshly.  I agree that the flexibility of the rules makes it more
complicated, though I think a bigger issue may be that the feature is
hard to make smooth unless coupled to something like partial clones.
Work on that is ongoing.  Anyway, in an attempt to be helpful, here
were some of the pain points I ran across:

- The fact that documentation could only be found in a low-level
plumbing command like read-tree made discoverability hard.  Why would
folks think to look there?  (I can't remember if I had to google it or
just grepped around the git source code to find it.)

- Needing to use read-tree, which isn't something most users are
familiar with, makes for a learning curve.  I may know what some of
the flags in read-tree do, but users will puzzle over which things on
the page happen to be relevant to them -- especially since the section
on sparse checkouts don't specify how read-tree should be invoked
after .git/info/sparse-checkout is populated.  Even I couldn't guess
what I was supposed to ran and just googled for hints.  Here's some
possible failures, as users guess which flags to pass:

$ git read-tree
warning: read-tree: emptying the index with no arguments is
deprecated; use --empty

$ git read-tree HEAD  # Oops, doesn't update the working directory

$ git read-tree -u HEAD  # Doesn't do any updates either

$ git read-tree -mu HEAD  # Works...but make user think "Why/what am I
merging?!?"

- I actually misunderstood or misread the documentation about undoing
sparse checkouts and failed multiple times.  I think I nuked the index
then did a 'git reset --hard HEAD'.  Re-reading, it looks like you did
explain it, and I don't remember why/how I missed it the first time
around, but I did.

- I either failed to grasp how to specify negative refs or botched
something else up.  I tried digging for a while to figure out how to
exclude my massive directory, but was always met with:
    error: Sparse checkout leaves no entry on working directory
I spent a while trying to figure out what I did wrong, but gave up
after half an hour or so since I wasn't trying to use the feature for
real and just specified the files I wanted to keep instead.
Re-reading the docs, it looks like you specified how to do this, and
re-trying now it works, but I repeatedly passed over the '/*' in the
docs and read it as either bad formatting or a highlight of the next
line rather than as important literal text.  So, maybe part of my
problem is that I just can't read.  :-)

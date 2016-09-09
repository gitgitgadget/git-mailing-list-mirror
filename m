Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845EE207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 23:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbcIIXhe (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 19:37:34 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36391 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbcIIXhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 19:37:32 -0400
Received: by mail-ua0-f176.google.com with SMTP id b7so80494556uab.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AP7W6AFyoD+6uVBU6YhSndKhmvwgytkfkHlInZ7HXes=;
        b=n7xQSRz0K5cTA93eHYb7Pkgru5fQwFQNNFHZQN80lfFgjvTdw0nLo482Dm+25mWt3d
         pK7wr3DPD6ucLW3C0Isemill/iTMNPsiQJoOs/XbJqeHcLc5v1DV7KABUV8It7IWLUyo
         4CinmvFenkXq0j9+dDdGlX78CKLcrfBctltyMj/btTx+j+iXuyVlPWq9p5IcdkheCtuM
         UI2GBD42vU7k+9LaOafForAHd53uqQ2ACt4OZ7zg0Zr39jt3Hj5FjMW1Y8Cjgn8tEg84
         LJEkVXzKO0XWRZsPcuRTJvLRfXFzTRUFmznwFfUUNnHHiF1/5e6Z8yfSDIykIyiF9wFD
         Wo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AP7W6AFyoD+6uVBU6YhSndKhmvwgytkfkHlInZ7HXes=;
        b=i1LmHaVe/iaw4zuRykGpCU6n+X9AF9W+D1isbdZoi/4gOK76gegnGI0CYUr6Uzi1Ql
         JKaoa+t4dLZ/YG96WpsYByzkzmv1DeZXnY7WUbhgDpuZx0QBxFPyreskkn4la979Dc40
         TuXGskHJmJkr12JAm3wPwg5DQDTvHdiXLmVNo4RR/QrVCoJY5dIX5P9El6U7b67igmKC
         flSg36Li3sJZ2NcSTOgmlRMOLUeIu2218GJp0fsOtJcQxcGHzdmrdZumsQqmmlTZ5clJ
         CgKlBJmIT/KtTBgN1R4G8hGILfrGXEa3eIVaiOLYodWDPkNwRNt1fphm6pfMsbZDVzbZ
         jGgg==
X-Gm-Message-State: AE9vXwPR6fSTweZDWvQ7ineH4ofDI4RVbh4S2KMBpw5fbGqWMTywr3EdoE7ye/ce/GEbNdY7PWkoih5JFPQxyg==
X-Received: by 10.159.40.38 with SMTP id c35mr3958697uac.70.1473464251854;
 Fri, 09 Sep 2016 16:37:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.50.213 with HTTP; Fri, 9 Sep 2016 16:37:31 -0700 (PDT)
In-Reply-To: <CAG0BQX=FFWqR=45g6buujzK2jknx8aZnQoiV_m-QZhcx4Dd52g@mail.gmail.com>
References: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
 <CAGZ79kb=LyusFH6tGirGP9qK1k-cov2UubEbKPfeyPRThUsa-Q@mail.gmail.com> <CAG0BQX=FFWqR=45g6buujzK2jknx8aZnQoiV_m-QZhcx4Dd52g@mail.gmail.com>
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Fri, 9 Sep 2016 19:37:31 -0400
Message-ID: <CAG0BQXmyW-Hzdyj4rTviToEVbJ73d94P9GcfFVR6P2XCsA2t-g@mail.gmail.com>
Subject: Re: If a branch moves a submodule, "merge --ff[-only]" succeeds while
 "merge --no-ff" fails with conflicts
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, mwitte@ara.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any ideas on this anywhere?

In my opinion if a merge can fast-forward without conflict it should
trivially be able to non-fast-forward without conflict.

Also, I'm not too familiar/comfortable with mailing list etiquette,
and I don't want to be a bother by continuing to ping this thread.

Thanks,

Dakota

On Tue, Sep 6, 2016 at 4:02 PM, Dakota Hawkins <dakotahawkins@gmail.com> wrote:
> On Tue, Sep 6, 2016 at 3:00 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Fri, Sep 2, 2016 at 12:22 PM, Dakota Hawkins <dakotahawkins@gmail.com> wrote:
>>> Below is a simple reproduction of the issue.
>>>
>>> The _real_ problem is that this is how our pull request merges work,
>>
>> So your workflow is the problem or is the actual bug just exposed in
>> your workflow?
>
> I believe the workflow just exposes the problem, which is that
> generically for this case a fast-forward merge works without conflicts
> while a non-fast-forward merge fails with conflicts. Sorry if this
> confuses the issue, it's just how we experienced it so I wanted to add
> that background.
>
>>> ## Test fast-forward merge, this will work
>>> git checkout -b merge-ff-test master # warning: unable to rmdir
>>> submodule-location-2: Directory not empty
>>> rm -rf ./submodule-location-2
>>> git merge --ff-only move-submodule
>>>
>>
>> And no reset/rm in between, i.e. we still have
>> submodule-location-2 from  merge-ff-test still around?
>
> That is true in that example, but somewhat immaterial. The first merge
> was only to demonstrate that a fast-forward merge works without
> conflict. The simplest reproduction is to skip that and get straight
> to the failure case:
>
> ## Clone and setup branches
> git clone https://github.com/dakotahawkins/submodule-move-merge-bug-main-repo.git
> cd submodule-move-merge-bug-main-repo
> git branch move-submodule origin/move-submodule
> git checkout -b merge-no-ff-test master
>
> ## This will fail
> git merge --no-ff move-submodule
> # Auto-merging submodule-location-2
> # Adding as submodule-location-2~move-submodule instead
> # Automatic merge failed; fix conflicts and then commit the result.
>
> Does that make things a little bit clearer?
>
> Dakota

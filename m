Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4AE1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 10:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBIKhS (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 05:37:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38759 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIKhS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 05:37:18 -0500
Received: by mail-it1-f196.google.com with SMTP id z20so15428678itc.3
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QC4q6+qic9M+nuRzJ5UpWW8Bi3MkflRjmtO8O+hufr8=;
        b=psrvXSVkWywvEOf0YqtlY0bZk4wXTlZUtimbaHMvTApoxXs7BQEyxa6mf+8AWVEZWG
         aeKjHiMxovj3yTr+UQ9RTe+gqG30LgwwHgI+DeCy4fvLXV9ZDUb1N/+Ma6nUlsw9UEth
         DFbm0iVlYR9vDbtk2aIdoM3RlFVRg31gQiB7hag63vjjrW6Pfebnmde/JnjiPYPfPZVR
         O4Q2B5Nb6wYNCMNOLPolWwU0f+wxOE9Em/Jxofl+6vKAT3WByKlNtnaQthD1OJixgPXJ
         0TM6sSn7LXfldq4nyPJN3SnhPjUaI1gzo5TfJ/eywCxNzYHsQAdeY8K2XJjXZay5TEu7
         AufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC4q6+qic9M+nuRzJ5UpWW8Bi3MkflRjmtO8O+hufr8=;
        b=h5Kp3SKSfC/eNPvg+a9sLAiiYwrwR5vN4iA33EpnHXt/4cF5A/+TP+1ea5zCcREpGV
         4atYKqLoDbrPDyUNidKitYJ2uJ2hHEMf9LCL87jM3j6NHeUKxiLR/VQkWNOsw4R0Y7HB
         6QUBmjNiUlGTobtdkXr8w/fwBnrxD1T4KB8g8+TLgBs02dAvkM9L4PXA1DBX+gFEYMM2
         rzzj86sDgAptHAd946en7QPnXP2gUMzYrR+/9AmpqWeBmCUCEJ2vdscl0RNRQN/5iF1w
         SN45yfuIFXhTRNmYuZ3n99HC1NJ6aIQZWwq+eDVkcak7ZdRp25auZH1I4+Da01/d4ZSS
         f44A==
X-Gm-Message-State: AHQUAuZtNw3Frk4V+7Y+DDxtVabNTkg0FEd+/lueXqvf8nN0uG4IoeYs
        kNwh5X1b24yOuf6co7JagwEbk3aYzvvwjnHb/Mk7vQ==
X-Google-Smtp-Source: AHgI3IayNxjdwSTMLOP1+XQOrprrSIt0l5qYO663lN+QOvTcF1V/3NL6QhZgkJVcLGilORnruHLV+7U5Imz5r7bFBEE=
X-Received: by 2002:a24:2fd0:: with SMTP id j199mr1429634itj.123.1549708637349;
 Sat, 09 Feb 2019 02:37:17 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
 <20190208100221.GA22283@ash> <CAE5ih7_b_LXfPp5eMcrr4iSuyzaiKxvQqN73Osw+ck9CPrfdqw@mail.gmail.com>
 <CACsJy8CeRFyhkdohwU_KtXtgmkOzNsQPb4oKFcn+R210MpS1KA@mail.gmail.com> <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
In-Reply-To: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Feb 2019 17:36:50 +0700
Message-ID: <CACsJy8A7A+Fu=5PWGuQsxtdJLBP_2Ueb-1MCKGHwKHGoQ7J2GA@mail.gmail.com>
Subject: Re: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 9, 2019 at 4:58 PM Luke Diamand <luke@diamand.org> wrote:
>
> On Sat, 9 Feb 2019 at 05:01, Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Fri, Feb 8, 2019 at 11:39 PM Luke Diamand <luke@diamand.org> wrote:
> > >
> > > On Fri, 8 Feb 2019 at 10:02, Duy Nguyen <pclouds@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 06, 2019 at 10:25:25AM +0000, Luke Diamand wrote:
> > > > > I've recently started seeing a lot of this message when doing a rebase:
> > > > >
> > > > >    warning: could not freshen shared index
> > > > > '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'
> > > >
> > > > There are only two places in the code that could print this. The one
> > > > in read_index_from() can't happen unless is_null_oid() is broken (very
> > > > very unlikely).
> > > >
> > > > The other one is in write_locked_index() which could happen in theory
> > > > but I don't understand how it got there. If you could build git, could
> > > > you try this patch and see if it helps?
> > >
> > > They've gone away!
> >
> > Great! Since you seem able to reproduce this (and can build git!)
> > could you try bisect to pin point the commit that causes this problem?
> > That would help a lot. I think you could start maybe from v2.19.0
>
> The first bad commit was d658196f3c4b2478ebdff638e2c3e4fb2f9cbba2.

Thanks! I could reproduce it and I think I know what the problem is
now. Patches coming soon.

>
> $ git show d658196f3c4b2478ebdff638e2c3e4fb2f9cbba2
> commit d658196f3c4b2478ebdff638e2c3e4fb2f9cbba2 (refs/bisect/bad)
> Merge: 6b0f1d9c47 7db118303a
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Wed May 23 14:38:22 2018 +0900
>
>     Merge branch 'en/unpack-trees-split-index-fix'
>
>     The split-index feature had a long-standing and dormant bug in
>     certain use of the in-core merge machinery, which has been fixed.
>
>     * en/unpack-trees-split-index-fix:
>       unpack_trees: fix breakage when o->src_index != o->dst_index
>
> The test I'm doing is just:
>
> 1. git checkout some_tag
> 2. git rebase -i HEAD~5
> 3. Swap the top and bottom commit
> 4. repeat
>
> I just chose "5" as my first wild guess, other numbers are also available.
>
> With "5" I get 3 lots of:
>    warning: could not freshen shared index
> '.git/sharedindex.0000000000000000000000000000000000000000'
>
> As far as I can tell the actual rebasing is fine.



-- 
Duy

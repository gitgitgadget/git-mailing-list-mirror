Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5C81F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 02:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJKKNq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 06:13:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39621 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJKKNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 06:13:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so7844508wrb.6
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 19:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=YCD6T23HEfVqwCeB3BdNW/fxI/sKwDh0EsdHc5lfNW0=;
        b=sCszbE6rnaqejphgqCWQghsUGzHnqFD0D8ycTLoo2z93oLwVEbz82UPdhuHHRiGA1o
         3EQesfPmFZS6Eg7kCKONKsMCO0jwfxpjTGTBBIL5kySihWf1bK9JyDGmrc/Eb9vXySVR
         9AaRFDyIkRJJ4DvFWbjKS6nZovit2teHT7/8f+TytzUhlS2US4D4vkFtfqPBdnCyFUM0
         uc86WsCL2R9CEBZpoc9IPwU/JexLhHPMOeB1aQo5qyi1hBe1V6veez12iWe/d8G8aWPd
         sCz9/erh9IqcbgujrmlzxuQakiI5LEHPl1s9NAeC8rcMjZJdx60s9miLyv1hBb6Bu2k8
         vJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=YCD6T23HEfVqwCeB3BdNW/fxI/sKwDh0EsdHc5lfNW0=;
        b=k4MuBtNganWkHUkdBvLzZE3RIVlwwysB9Bm3B6Uv3PPUE2X2N5lz2M4fP7SNzDIoIj
         UtDSPPcycwzSHLOhCg/jhxdTgw/jIxsYhNrFQXmCfC5w2sOw7oB5sWkA6C/3m+mGGsQV
         XfEI86rSedyAopH0qcLtYiDHee5wnOuxYH2rTTdYYS0NRDD1Y89n01TDmaaj/xq24oVm
         TR9HVbQXXmjbJn5Zpy2Oy92LfWKTI49M6qPa2dEVSO9DROstRIlKyI0MeGawzri3J+Q/
         HKE/l8J+vdD91qb1zoDB6AiaheO8egLxK3cxskG0zR78mJl4eW377vK9KHaQHlYUFqUU
         HksQ==
X-Gm-Message-State: ABuFfojrHiDKnjwV6Kpb/M0Ry5HXxM+5RqvuvE26WFsE5DN//wLLhg2l
        F7AW6tmAa9UHBrB2e+yzJMc=
X-Google-Smtp-Source: ACcGV61oicNUZmlaPy5+wNG6lw1F308WdJZg6Dwiwn9F0QPUXrntw6iFnzDIaDKa62AL0DrMPUpWxw==
X-Received: by 2002:adf:e681:: with SMTP id r1-v6mr26148284wrm.294.1539226119502;
        Wed, 10 Oct 2018 19:48:39 -0700 (PDT)
Received: from gmail.com ([216.218.222.12])
        by smtp.gmail.com with ESMTPSA id j6-v6sm19109102wru.20.2018.10.10.19.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 19:48:38 -0700 (PDT)
Subject: Re: `--rebase-merges' still failing badly
Date:   Thu, 11 Oct 2018 02:44:20 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Message-ID: <9a2bd0246038424ab1cdfa68f07cdd4d-mfwitten@gmail.com>
In-Reply-To: <xmqqsh1djtij.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
            <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com>
            <xmqqsh1djtij.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Oct 2018 08:01:40 +0900, Junio wrote:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> On Wed, 10 Oct 2018 14:43:46 +0900, Junio wrote:
>>
>>> We haven't seen  much complaints and breakages  reported against the
>>> two big "rewrite in C" topics  around "rebase"; perhaps it is a good
>>> time to merge  them to 'next' soonish  to cook them for  a few weeks
>>> before moving them to 'master'?
>>
>> In my opinion, the `--rebase-merges' feature has been broken since the
>> beginning, and the builtin version should  be fixed before it is moved
>> ahead.
>
> [...]
>
> If "rebase-merges" has been broken since  the beginning, as long as the
> "rewrite in C" topics  around "rebase" do not make it  even worse, I do
> not think it is a good move  to block the topics moving forward. If the
> feature were so  broken that it is not practically  useful, then people
> wouldn't be using it  in the versions of Git before  the rewrite, so it
> won't harm  anybody if  the same  feature in  the rewritten  version is
> equally (or even  more severely) broken, as long as  the other parts of
> the feature works at least equally well compared to the older version.
>
> We are not in the business of hostage taking.
>
> What  *should*  block  the  rewrited  version  is  a  regression,  i.e.
> something that used  to work well no longer works  or works differently
> in such a way that established workflows need to be adjusted.
>
> [...] I do not think that is a reason to keep "rewrite in C" waiting in
> 'pu'.

* Your logic  is appealing,  and I  nearly pursuaded  myself by  the same
  reasoning to submit my email as  a separate discussion, as you suggest.
  However, what convinced me otherwise is the following:

      The  closer you  move  the rewrite  to  a fast-forward-only  public
      branch  name, the  more  likely downstream  projects  are going  to
      set  up  new,  long-lived  releases around  this  very  useful  but
      nevertheless broken feature.

  The moment you announce a new release, there are going to be a bunch of
  people who grab that release and then  NEVER look back, and so the rest
  of us will be stuck with this problem for who knows how long.

  So, not only is this an appeal  to the authors to fix this problem, but
  its also  an appeal  to you to  make sure that the  next  major release
  includes the fix.

* Also, I say the following without irony or tongue in cheek:

      Maybe, no one  has complained  because  few people  are using  this
      feature yet, or  their commit summaries are  simplistic, or they've
      got workarounds (as I've got).

  Not  only must  this feature  be turned  on explicitly,  but `git'  has
  existed for  over a decade  *without* it;  users who are  interested in
  sophisticated management of commit history have already developed other
  ways  to achieve  the  same result  (I  know I  did),  or their  commit
  messages are  so simplistic that  the bug  is never triggered,  or they
  just plan around it by automatically running a quick search/replace for
  the offending characters or for the irritating "labels".

  If the last decade has shown  us anything, it's that git's fundamentals
  are  so good  that programmers  can get  around any  bug on  their own,
  without having to appeal to others  for help. And, what is a programmer
  if not someone who is used to making things Just Work [Damnit]?

  As an illustration,  consider the recent `break' command  that is being
  added to the repertoire of `git  rebase -i'. Hell, I (and probably many
  others) have been doing that for YEARS with:

      x false

  No need for a "new" command. I bet that 10 years from now,  people will
  *still* be using their own ways,  and will *still* be totally oblivious
  to the existence of `break'.

  That is to say, I wouldn't put much faith in the degree to which people
  report issues. The programming world has a lot of itchy backs, and just
  as many personal inventions for scratching them.

As always, thanks for taking the time to review everyone's input.

Sincerely,
Michael Witten

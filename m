Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7362036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdKUToa (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:44:30 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36648 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKUTo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:44:26 -0500
Received: by mail-it0-f66.google.com with SMTP id 187so3463566iti.1
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DlhUjvbVRGA8iEmYTL35040FNdJcQRIasakkcOgcWoQ=;
        b=NvXakQcUZ5tju7/2yFuc1dhShrw6E4BtcfcXjIZpBdKDKe5MCdm0ZIv084ocHbbzqu
         2ff7c0tjNnqRdDy1r8FGYsCDIzuWKDydIyrQFzdKE+5cGg74h/qo966WKWrSa0X2xuO2
         zV4YkiN38B+BEz2StdWhDhUjFe/J8PnY6hCN1wv48qFt2zP9X6kIsIkQGctCmXhU3ESD
         RwCd1XzBH30bb0ucRxlsK164zLqYkgcpwKZ2LEsYlZaKEdzub7U7B5X6Paht7VI90V8Y
         ZLbh7Bs2U0e0bRB8h2/NYLharbtj1vYD6injU8Fa5AoeTr6BZHdvsdZGWPWkcVenkG4y
         hFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DlhUjvbVRGA8iEmYTL35040FNdJcQRIasakkcOgcWoQ=;
        b=sWxjhwtpToWJR0QG85gNhpOLjO7A0ru+1tAFFj09edTfNt6CWOXv1Xayhurf+d4s6V
         xKUs7Ptw+OIkrUYEAQOADQ0O0/IaDhwttWso76Dq0aB/mapdGlO8pzaLK3Qp4cjMMZrQ
         CZBNORYkqa5pmB9hQTkanURkU7lf45aQmQVJy8RVsySLLsPFYy+XliCcQX20Q5yx/mnu
         2KJ9IR/Lnw9X5f2QZjOj6NSrVnW28MEg+qNJ9tzK8FJJtLevKBu3uuJldzcW84d9RnMa
         bEh8DknTOTeqow1XqzpNHBh2sJojXGUJMeMYxDtFXDICcbP/6wwICRfb1Ubt/9j5QJ0Q
         RUKg==
X-Gm-Message-State: AJaThX6NEnYiWic7LnkjtVxLc2djJNhTB4h0iMDp9UOG0IR0grnfbrLb
        4OcNoyvzxbn3RN3kbep7R9o=
X-Google-Smtp-Source: AGs4zMbvXdNRT6sQx2DHvOKTVHq+OgbwaP+aewX6nVFkqsvOjnWMfVE13x7jo8KK5HTqNRuz7K6jPA==
X-Received: by 10.36.74.135 with SMTP id k129mr3561493itb.147.1511293465936;
        Tue, 21 Nov 2017 11:44:25 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v8sm1012559itc.5.2017.11.21.11.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 11:44:25 -0800 (PST)
Date:   Tue, 21 Nov 2017 11:44:23 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: some apparent inaccuracies in "man git-worktree"
Message-ID: <20171121194423.GH3429@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1711140324580.12112@localhost.localdomain>
 <CAPig+cRc7Yqeys=oPEgPnyR4qT7qKYLbH1ifnp+6F6N+mSzNVA@mail.gmail.com>
 <alpine.LFD.2.21.1711141509280.3970@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711141509280.3970@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:
> On Tue, 14 Nov 2017, Eric Sunshine wrote:
>> On Tue, Nov 14, 2017 at 3:43 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:

>>> from "man git-worktree", there seem to be some inaccuracies in the
>>> SYNOPSIS regarding the "add" subcommand:
>>>
>>>   git worktree add \
>>>     [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]
>>>
>>>   first, there's no mention of "-B" in that SYNOPSIS, even though it's
>>> explained further down the man page.
>>
>> Omission of "-B" from the synopsis was intentional. From cbdf60fa18
>> (worktree: add -b/-B options, 2015-07-06):
[...]
>> Whether or not the omission was actually a good decision is
>> questionable.
[...]
>>>   next, the SYNOPSIS seems misleading as it doesn't make clear that
>>> the options -b, -B and --detach are mutually exclusive, which is made
>>> clear in the worktree.c source:
[...]
>> Failure to update the synopsis to indicate mutual exclusion appears to
>> be a simple oversight in ab0b2c53ed (worktree: make --detach mutually
>> exclusive with -b/-B, 2015-07-17)
[...]
>>>   finally (and maybe i'm just not reading carefully enough), it's not
>>> clear what happens if you add a worktree at a given commit without
>>> specifying *any* of -b, -B or --detach. the obvious result should be a
>>> new worktree checked out at a detached HEAD and, interestingly, if i
>>> do that, then from the main tree, i see:
>>>
>>>   $ git worktree list
>>>   /home/rpjday/k/git   516fb7f2e73d [master]
>>>   /home/rpjday/k/temp  c470abd4fde4 (detached HEAD)
>>>   $
>>>
>>> but from within the worktree, if i ask for the status, i see only:
>>>
>>>   $ git status
>>>   Not currently on any branch.
>>>   nothing to commit, working tree clean
>>>   $
>>>
>>> where i would normally have expected to see "detached HEAD", is there
>>> a reason that's not displayed?
>>
>> Someone more familiar with this bit can correct me if I'm wrong, but I
>> believe that the "HEAD detached at/from <branch>" you normally see
>> with 'git status' is derived from the reflog,
[...]
>   i'm not sure what i can add to this, but i'm going to leave it to
> folks higher up the food chain than me to resolve any of the above.

For what it's worth, the folks higher up the food chain you're
referring to don't exist, so the most likely outcome here is that
nothing happens.  People working on patches (suggesting wording,
formatting as a patch, reviewing, testing, etc) are as high on the
food chain as it gets. :)

One thing we've discussed on this list before is setting up a bug
tracker to allow people another way to collaborate (filing a clear
summary of a problem for interested people to work on).  More on that
subject later today --- feel free to poke me if I don't get such a
message out.

Thanks,
Jonathan

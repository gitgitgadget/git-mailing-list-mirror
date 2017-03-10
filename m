Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC25202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 03:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbdCJDbD (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 22:31:03 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36480 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbdCJDbC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 22:31:02 -0500
Received: by mail-pg0-f66.google.com with SMTP id 25so8775667pgy.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 19:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rJ3dCnKc9BVE82Yut/605OeUa5KNdFu5v869MpLOX1w=;
        b=eoZpEBWz5mD1qmDqikSdwv7HYl+LGm9xpXxATS38iKS06AQIEVcN8YMqb03TWbISKC
         WmwIZbWToOMMqRjjSM1w4Z/xia8EgwdfiA6xX/jcDXM3yrj++deTXjHFhnJR7/sgZdBz
         a16ZJVSx8JZtSn0PeyEpG1DiNsCanb3D6BWDdZaxtjQeZmc82vo1Nu1s4IsUV3oFEvvX
         fnzU1INNrnHnCVOHSW9JGvoQnULsOHi8zA9vIOiMMhX40dlQbJ2nCK0dbhGvGuzTTzoW
         VqykB6o2QshX62LXWhFUTrjaLooVKlXtCWLqunHTqqNKjWFMeYS2IztYI7TQ+x8pTBtl
         P61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rJ3dCnKc9BVE82Yut/605OeUa5KNdFu5v869MpLOX1w=;
        b=FMKQn95yVMFWTXxACHm/0TahHeWVRQg9oOQECGc/fXV42SOd+vpqn0xfgR8ugSHk/W
         Y+FTeGv0gGiXne8RjyXcPtEqI0wTCtEJMbJ4PCpZbxQQgAMzc/Q3VMgik/+8kCVqbSPo
         mk4sMJPHQ1IVMt23fvNkDLjkkRcCR9OWmpWj9mOQDq5p2S1wnNfUWDaYf/TX9WrbY7ck
         WWDKPZTFhKmR5Jszdm83fH/NzMV6JUXrmnHTE3xdoOolVF7GeAiYIGIshABvJelAN6S1
         wdFxsLNA4iWg1a0mr76eUiu0NK2qBfvapNKw/XCySE72QEwmQZ21np5IpMeLeQQMlvej
         bIRQ==
X-Gm-Message-State: AMke39kcN14kMZapPeqU8Ec6ss3rcoB3aFpjfeSjydnqWyUaT7uyjzHqYuNZ+iSTT6GA1g==
X-Received: by 10.84.216.81 with SMTP id f17mr22096014plj.170.1489116661281;
        Thu, 09 Mar 2017 19:31:01 -0800 (PST)
Received: from localhost (37.147.199.104.bc.googleusercontent.com. [104.199.147.37])
        by smtp.gmail.com with ESMTPSA id r12sm15160500pgn.26.2017.03.09.19.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 19:31:00 -0800 (PST)
Date:   Fri, 10 Mar 2017 03:30:58 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Shuyang Shi <shuyang790@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH GSoC] Allow "-" as a short-hand for "@{-1}" in branch
 deletions
Message-ID: <20170310033058.GA1984@instance-1.c.mfqp-source.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102015ab11ee091-f9f11bb5-559a-4c92-b5f6-9f7755e8f4b9-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Shuyang,
On Thu, Mar 09, 2017 at 09:47:12AM -0800, Stefan Beller wrote:
> > The "-" shorthand that stands for "the branch we were previously on",
> > like we did for "git merge -" sometime after we introduced "git checkout -".
> > Now I am introducing this shorthand to branch delete, i.e.
> > "git branch -d -".
> >
> > More reference:
> >   https://public-inbox.org/git/7vppuewl6h.fsf@alter.siamese.dyndns.org/
> 

1. I have already worked on this project, and my patch is in the
"Needs review" section in "What's cooking". It implements this change
inside sha1_name.c and doesn't touch git branch. So, your patch is
mutually exclusive to my previous patch.

2. Matthieu made an argument against enabling commands like "git
branch -D -" even by mistake [1]. The way that I have implemented
ensured that not a lot of "rm"-like commands were enabled.

My patch that would enable this shorthand for other projects is
here[2].

[1]: http://public-inbox.org/git/vpqh944eof7.fsf@anie.imag.fr/
[2]: http://public-inbox.org/git/1488007487-12965-5-git-send-email-kannan.siddharth12@gmail.com/

Thanks,
Siddharth.

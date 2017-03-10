Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A25202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 04:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754731AbdCJEw3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 23:52:29 -0500
Received: from crossperf.com ([5.39.84.17]:33883 "EHLO crossperf.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753633AbdCJEw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 23:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crossperf.com; s=rsa2048; h=Message-ID:Sender:Content-Transfer-Encoding:
        Content-Type:Mime-Version:Subject:References:In-Reply-To:Cc:To:From:Date:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O+O7yx9hftMJMYSslaLQrMjT6CBels4XcanFdwamttM=; b=dQOUXaEt/aAQj9ZxdUhyJVp3sw
        8xktnzyEERMsTrHagdLB3CtqgCx32DaF9I2NSJxv8Jo2jueaQeA9qrHUzuAWDDvPtI+cUm6PSnQIn
        cccXpfB1rJWVezszDYHoLftJHJMrpf8z9m6ha6Yy9NBkuqGLH/mSCLlWusU3bNJP0KiRNjR+1T4U1
        gPYQs5d0d5vzufYJvOG6T/GXlfAf5T0syR15ZfAIEjOkdnRhjXT7it47kcGn02FApNYfBpCEEku7Z
        xM1dkIYe20fSuUDduoAgAhnPJg9rFs2X6rVecJjm9erbxg05Q3Ozdfvon3A5sclbEE8xwIy4iFrgW
        foa4w0YA==;
Date:   Fri, 10 Mar 2017 04:52:07 +0000
From:   mash <mash+git@crossperf.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, stepnem@gmail.com,
        Stefan Beller <sbeller@google.com>,
        Vedant Bassi <sharababy.dev@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git Mailing List <git@vger.kernel.org>
In-Reply-To: <1cm4dm-0007OE-MZ@crossperf.com>
References: <1cm4dm-0007OE-MZ@crossperf.com>,
 <20170310034106.GB1984@instance-1.c.mfqp-source.internal>
Subject: RE: [PATCH v2 GSoC RFC] diff: allow "-" as a short-hand for "last
 branch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Message-ID: <1cmCXH-0000ND-9K@crossperf.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From the discussion over the different versions of my patch, I get
> the feeling that enabling this shorthand for all the commands is the
> direction that git wants to move in.

Interesting.

> Sorry about the time you spent on this patch.

Don't worry about it. I just seem to be too stupid to search through the
mailing list archive properly.

Maybe you can reuse the diff tests. I'll do another microproject then.

mash

The original message doesn't seem to cc the mailing list:
> Hey, I have already worked on this, and I made the change inside
> sha1_name.c.

> The final version of my patch is here[1].

> > Handling the dash in sha1_name:get_sha1_basic is not an issue but git
> > was designed with the dash in mind for options not for this weird
> > short-hand so as long as there's no decision made that git should
> > actually have this short-hand everywhere it does not seem like a good
> > idea to change anything in there because it would probably have
> > unwanted side-effects.

> Actually, this was discussed even when I was working on this patch.

> I said [2]

> > Making a change in sha1_name.c will touch a lot of commands
> > (setup_revisions is called from everywhere in the codebase), so, I am
> > still trying to figure out how to do this such that the rest of the
> > codepath remains unchanged.

> Matthieu replied to this [3]

> > I don't have strong opinion on this: I tend to favor consistency and
> > supporting "-" everywhere goes in this direction, but I think the
> > downsides should be considered too. A large part of the exercice here
> > is to write a good commit message!

> From the discussion over the different versions of my patch, I get
> the feeling that enabling this shorthand for all the commands is the
> direction that git wants to move in.

> Sorry about the time you spent on this patch.

> [1]: http://public-inbox.org/git/1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com/
> [2]: https://public-inbox.org/git/20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain/
> [3]: https://public-inbox.org/git/vpqh944eof7.fsf@anie.imag.fr/

> Thanks,
> Siddharth.

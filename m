Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6095201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbdBYBCQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:02:16 -0500
Received: from lang.hm ([66.167.227.134]:42219 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbdBYBCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:02:15 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1P10tD0022859;
        Fri, 24 Feb 2017 17:00:55 -0800
Date:   Fri, 24 Feb 2017 17:00:55 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
In-Reply-To: <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk> <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Feb 2017, Jeff King wrote:

>
> So I'd much rather see strong rules like:
>
>  1. Once a repo has flag-day switched over to the new hash format[1],
>     new references are _always_ done with the new hash. Even ones that
>     point to pre-flag-day objects!

how do you define when a repo has "switched over" to the new format in a 
distributed environment?

so you have one person working on a project that switches their version of git 
to the new one that uses the new format.

But other people they interact with still use older versions of git

what happens when you have someone working on two different projects where one 
has switched and the other hasn't?

what if they are forks of each other? (LEDE and OpenWRT, or just linux-kernel 
and linux-kernel-stable)


>     So you get a "commit-v2" object instead of a "commit", and it has a
>     distinct hash identity from its "commit" counterpart. You can point
>     to a classic "commit", but you do so by its new-hash.
>
>     The flag-day switch would probably be a repo config flag based on
>     repositoryformatversion (so old versions would just punt if they
>     see it). Let's call this flag "newhash" for lack of a better term.

so how do you interact with someone who only expects the old commit instead of 
the commit-v2?

David Lang

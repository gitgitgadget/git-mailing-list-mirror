Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22AD201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdBYBmB (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:42:01 -0500
Received: from lang.hm ([66.167.227.134]:37150 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdBYBmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:42:00 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1P1dhJF023069;
        Fri, 24 Feb 2017 17:39:43 -0800
Date:   Fri, 24 Feb 2017 17:39:43 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
In-Reply-To: <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.75.62.1702241733250.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk> <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net> <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
 <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Feb 2017, Jeff King wrote:

>> what if they are forks of each other? (LEDE and OpenWRT, or just
>> linux-kernel and linux-kernel-stable)
>
> Once one flips, the other one needs to flip to, or can't interact with
> them. I know that's harsh, and is likely to create headaches. But in the
> long run, I think once everything has converged the resulting system is
> less insane.
>
> For that reason I _wouldn't_ recommend projects like the kernel flip the
> flag immediately. Ideally we write the code and the new versions
> permeate the community. Then somebody (per-project) decides that it's
> time for the community to start switching.

can you 'un-flip' the flag? or if you have someone who is a developer flip their 
repo (because they heard that sha1 is unsafe, and they want to be safe), they 
can't contribute to the kernel. We don't want to have them loose all their work, 
so how can they convert their local repo back to somthing that's compatible?

how would submodules work if one module flips and another (or the parent) 
doesn't?

OpenWRT/LEDE have their core repo, and they pull from many other (unrelated) 
projects into that repo (and then have 'feeds', which is sort-of-like-submodules 
to pull in other software that's maintained completely independently)

Microsoft has made lots of money with people being forced to upgrade Word 
because one person got a new version and everyone else needed to upgrade to be 
compatible. There's a LOT of pain during that process. Is that really the best 
way to go?

David Lang


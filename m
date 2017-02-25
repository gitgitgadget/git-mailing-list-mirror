Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53B0201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdBYB7A (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:59:00 -0500
Received: from lang.hm ([66.167.227.134]:34081 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbdBYB7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:59:00 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1P1uS6N023197;
        Fri, 24 Feb 2017 17:56:28 -0800
Date:   Fri, 24 Feb 2017 17:56:27 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
In-Reply-To: <20170225014747.f36j2ctlszpebpsy@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.75.62.1702241752350.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk> <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net> <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
 <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net> <nycvar.QRO.7.75.62.1702241733250.6590@qynat-yncgbc> <20170225014747.f36j2ctlszpebpsy@sigill.intra.peff.net>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Feb 2017, Jeff King wrote:

>> OpenWRT/LEDE have their core repo, and they pull from many other (unrelated)
>> projects into that repo (and then have 'feeds', which is
>> sort-of-like-submodules to pull in other software that's maintained
>> completely independently)
>
> I think with submodules this should probably still work.  If they are
> pulling in with a subtree-ish strategy, then they'd convert the incoming
> trees to the newhash format as part of that.

as I understand things, they have two categories of things

1. Feeds, which are completely independent, separate maintainers

2. core, which gets pulled into one repo, I don't know if they use submodules in 
the process. I know that what downstream users see is a single repo.

I understand and agree with the idea of trying to converge rapidly. I'm just 
looking at cases where this may be hard (or where there may be holdouts for 
whatever reason)

David Lang

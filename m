Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316371FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbdCJVS4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 16:18:56 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:48321 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932908AbdCJVSz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 16:18:55 -0500
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v2ALIQFc031126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2017 21:18:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v2ALIQh2031129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2017 21:18:26 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v2ALIP6q008591;
        Fri, 10 Mar 2017 21:18:25 GMT
Received: from [10.175.181.186] (/10.175.181.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Mar 2017 13:18:25 -0800
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
To:     Jeff King <peff@peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
 <eec5ab2a-7fe7-b47f-8073-a8212a9634f1@oracle.com>
 <20170310194245.p37w6mew4que6oya@sigill.intra.peff.net>
Cc:     gitster@pobox.com, git@vger.kernel.org
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <3a09226f-6749-6956-6fb9-265383cd4d66@oracle.com>
Date:   Fri, 10 Mar 2017 22:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170310194245.p37w6mew4que6oya@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/03/2017 20:42, Jeff King wrote:
>>> That's something I guess, but I'm not enthused by the idea of just
>>> dumping a bunch of binary test cases that nobody, not even the author,
>>> understands.
[...]

> My real concern is that this is the tip of the ice berg. So we increased
> coverage in one program by a few percent. But wouldn't this procedure be
> applicable to lots of _other_ parts of Git, too?

I think that index-pack is in a special position given its role as the
verifier for packs received over the network, which you also wrote here:
https://www.spinics.net/lists/git/msg265118.html

I also think increased coverage for other parts of git which are not
considered security-sensitive is less valuable without testing for an
actual expected result.


Vegard

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9348A1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 13:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeHVRGK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 13:06:10 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:45642 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728624AbeHVRGK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Aug 2018 13:06:10 -0400
X-Greylist: delayed 2409 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 13:06:09 EDT
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 7AE5717759E
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 06:42:22 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id sSSsfijxjak7tsSSsflvMs; Wed, 22 Aug 2018 06:42:22 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UK7XQhTPkx2ED8zzvIEkOt+lymEB/i40mhgIN/KA1mg=; b=axkRUaEjmXgG8TsyClhU2NMdmp
        LSTNGyqA+4Hq0K8M+ui4g0m7n1yc+tX8/hZhY4pbkdVSTdAtEcGPCr3fStftNAEmjsIa9+nBu6thN
        P4nrOU7XYn7BV2MXZMreUDPCo;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:48358 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fsSSr-000rxV-Si; Wed, 22 Aug 2018 06:42:22 -0600
Message-ID: <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Date:   Wed, 22 Aug 2018 08:42:20 -0400
In-Reply-To: <20180822030344.GA14684@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
         <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
         <20180821212923.GB24431@sigill.intra.peff.net>
         <20180822004815.GA535143@genre.crustytoothpaste.net>
         <20180822030344.GA14684@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 72.70.58.227
X-Source-L: No
X-Exim-ID: 1fsSSr-000rxV-Si
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase) [72.70.58.227]:48358
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2018-08-21 at 23:03 -0400, Jeff King wrote:
>  static inline int hashcmp(const unsigned char *sha1, const unsigned
> char *sha2)
>  {
> +       assert(the_hash_algo->rawsz == 20);
>         return memcmp(sha1, sha2, the_hash_algo->rawsz);
>  }

I'm not familiar with Git code, but for most environments assert() is a
macro which is compiled out when built for "release mode" (whatever
that might mean).  If that's the case for Git too, then relying on
assert() to provide a side-effect (even an optimizer hint side-effect)
won't work and this will actually get slower when built for "release
mode".

Just a thought...

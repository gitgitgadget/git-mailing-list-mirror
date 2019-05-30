Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438EB1F462
	for <e@80x24.org>; Thu, 30 May 2019 11:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfE3L5o (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 07:57:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:42186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727026AbfE3L5o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 07:57:44 -0400
Received: (qmail 946 invoked by uid 109); 30 May 2019 11:57:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 May 2019 11:57:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4005 invoked by uid 111); 30 May 2019 11:58:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 May 2019 07:58:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 May 2019 07:57:42 -0400
Date:   Thu, 30 May 2019 07:57:42 -0400
From:   Jeff King <peff@peff.net>
To:     "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Message-ID: <20190530115742.GC31607@sigill.intra.peff.net>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
 <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 29, 2019 at 09:06:18AM +0000, Vanak, Ibrahim wrote:

> After cloning when I tried to checkout a branch on HPUX and Linux, I
> still significant time difference there as well even though network is
> not involve here. Do you suspect anything with HPUX OS? Do you have
> any mechanism to find out who is the causing gigantic delay ?

If it's happening for just a local checkout operation, I'd suspect very
poor filesystem performance. On Linux, I'd run it under "perf" to see
where the time is going. Or possibly "strace -T" to time system calls. I
don't know what tools are available under HP-UX for that kind of
profiling.

-Peff

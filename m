Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31F61F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 21:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfJYVYZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 17:24:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:58724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725283AbfJYVYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 17:24:25 -0400
Received: (qmail 20187 invoked by uid 109); 25 Oct 2019 21:24:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Oct 2019 21:24:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14283 invoked by uid 111); 25 Oct 2019 21:27:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2019 17:27:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Oct 2019 17:24:24 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Hesse <mail@eworm.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: cgit and global configuration
Message-ID: <20191025212424.GB25625@sigill.intra.peff.net>
References: <20190611170401.15d43623@leda>
 <1cdb3444-fb39-66a4-fb27-01e1617e538a@jeffhostetler.com>
 <20190612190845.GA14949@sigill.intra.peff.net>
 <20191025181015.50bf2b92@leda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025181015.50bf2b92@leda>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 25, 2019 at 06:10:15PM +0200, Christian Hesse wrote:

> We decided to go another way and introduced a constructor function which does
> initial environment setup:
> 
> https://git.zx2c4.com/cgit/commit/?id=034e3c7d56ba71ce281886fe8525b16d4559fac1
> 
> Everything (including tests) is happy with that.

Thanks for following up. I think that should be a fine solution. We'd
perhaps have considered using __attribute__((constructor)) ourselves
(which would presumably have a non-deterministic run order), but it's
not sufficiently portable for our purposes. So I don't think you'll run
into any issues going forward with that approach.

-Peff

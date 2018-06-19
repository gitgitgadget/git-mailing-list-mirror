Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36421F403
	for <e@80x24.org>; Tue, 19 Jun 2018 19:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030608AbeFST4w (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 15:56:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:48896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1030472AbeFST4w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 15:56:52 -0400
Received: (qmail 6808 invoked by uid 109); 19 Jun 2018 19:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 19:56:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16897 invoked by uid 111); 19 Jun 2018 19:57:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 15:57:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 15:56:50 -0400
Date:   Tue, 19 Jun 2018 15:56:50 -0400
From:   Jeff King <peff@peff.net>
To:     "Dyer, Edwin" <Edwin.Dyer@alliancedata.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: security: potential out-of-bound read at ewah_io.c
 |ewah_read_mmap|
Message-ID: <20180619195649.GA1499@sigill.intra.peff.net>
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
 <CO2PR01MB20383AC645BE4FD6BF47C697F1700@CO2PR01MB2038.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO2PR01MB20383AC645BE4FD6BF47C697F1700@CO2PR01MB2038.prod.exchangelabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 07:00:48PM +0000, Dyer, Edwin wrote:

> Just curious if there was any additional comment on this potential
> OOB? I may have missed it and if so, apologies for the ask.

The fix is in master, and should be part of the upcoming v2.18. See
commit 9d2e330b17 (ewah_read_mmap: bounds-check mmap reads, 2018-06-14).

-Peff

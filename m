Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9B1208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbdHIKUo (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 06:20:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:33076 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751927AbdHIKUn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 06:20:43 -0400
Received: (qmail 28538 invoked by uid 109); 9 Aug 2017 10:20:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 10:20:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25767 invoked by uid 111); 9 Aug 2017 10:21:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 06:21:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 06:20:41 -0400
Date:   Wed, 9 Aug 2017 06:20:41 -0400
From:   Jeff King <peff@peff.net>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] filter-branch: Handle rewritting (very) old style
 tags which lack tagger
Message-ID: <20170809102040.l5sb6ukqh2225zqm@sigill.intra.peff.net>
References: <1502179560.2735.22.camel@hellion.org.uk>
 <20170808080620.9536-2-ijc@hellion.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808080620.9536-2-ijc@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 09:06:20AM +0100, Ian Campbell wrote:

> Such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel source tree.
> 
> Insert a fake tag header, since newer `git mktag` wont accept the input
> otherwise:

Hmm. Now your resulting tag will have this crufty "unknown@example.com"
header baked into it, won't it?

Should we instead make git-mktag more lenient (possibly with a
command-line option to reduce accidental omissions)?

-Peff

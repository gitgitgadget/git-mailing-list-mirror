Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBFEE1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfKNGfM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:35:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:47150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725807AbfKNGfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:35:12 -0500
Received: (qmail 22366 invoked by uid 109); 14 Nov 2019 06:35:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 06:35:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1234 invoked by uid 111); 14 Nov 2019 06:38:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 01:38:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 01:35:11 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7004: check existence of correct tag
Message-ID: <20191114063511.GE10643@sigill.intra.peff.net>
References: <20191113193902.29263-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113193902.29263-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 08:39:02PM +0100, Martin Ågren wrote:

> We try to delete the non-existing tag "anothertag", but for the
> verifications, we check that the tag "myhead" doesn't exist. "myhead"
> isn't used in this test except for this checking. Comparing to the test
> two tests earlier, it looks like a copy-paste mistake.

Thanks, the description and patch look good to me.

> Perhaps it's overkill to check that `git tag -d` didn't decide to
> *create* a tag. But since we're trying to be this careful, let's
> actually check the correct tag. While we're doing this, let's use a more
> descriptive tag name instead -- "nonexistingtag" should be obvious.

Yes, that would be a spectacular bug indeed. :)

I think it's fine to keep it in, though, as it communicates the
expectations pretty clearly.

-Peff

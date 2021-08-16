Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80355C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615C060F35
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhHPSvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:51:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:48786 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhHPSvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:51:37 -0400
Received: (qmail 22542 invoked by uid 109); 16 Aug 2021 18:51:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 18:51:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17321 invoked by uid 111); 16 Aug 2021 18:51:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 14:51:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 14:51:04 -0400
From:   Jeff King <peff@peff.net>
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clone corrupts file.
Message-ID: <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRqYD+SszvhhySwl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 12:53:36PM -0400, Jeff King wrote:

> But an alternative workflow, if you really want UTF-16 in the working
> tree, is to convert between UTF-8 and UTF-16 as the files go in and out
> o the working tree. There's no built-in support for that, but you could
> do it with a custom clean/smudge filter. That would let Git store UTF-8
> internally, do diffs, etc.

Oh, by the way, I totally forgot that we added an internal version of
this, which is easier to configure and much more efficient. See the
"working-tree-encoding" attribute in "git help attributes".

Just in case you do want to go that route.

-Peff

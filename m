Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C296E20248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfB1Vdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:33:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:33506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727775AbfB1Vdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:33:53 -0500
Received: (qmail 31302 invoked by uid 109); 28 Feb 2019 21:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:33:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23960 invoked by uid 111); 28 Feb 2019 21:34:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:34:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:33:51 -0500
Date:   Thu, 28 Feb 2019 16:33:51 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 10/20] cat-file: inline stream_blob
Message-ID: <20190228213351.GJ12723@sigill.intra.peff.net>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a5c-cbf0d726-b7dd-4da8-9cdb-5cc78dc449e9-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102016915f49a5c-cbf0d726-b7dd-4da8-9cdb-5cc78dc449e9-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:

> Inline function stream_blob, it simplifies further
> migrating process.

I'd have to see what exactly gets simplified later on, but I'm mildly
negative on this by itself. The reason this function was added in
98f425b453 (cat-file: handle streaming failures consistently,
2018-10-30) was to keep the outcomes consistent.

The function right now isn't _too_ long, so we're really just
duplicating the message text. But I wonder if it might eventually get
more complicated, if we ever do the "future work" discussed in
98f425b453. So this seems like a step in the wrong direction.

-Peff

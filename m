Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4645E1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfAJGu7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:50:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:60436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725536AbfAJGu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 01:50:59 -0500
Received: (qmail 2850 invoked by uid 109); 10 Jan 2019 06:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Jan 2019 06:50:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29501 invoked by uid 111); 10 Jan 2019 06:50:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 Jan 2019 01:50:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2019 01:50:57 -0500
Date:   Thu, 10 Jan 2019 01:50:57 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
Message-ID: <20190110065056.GD20497@sigill.intra.peff.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-6-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110042551.915769-6-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 04:25:51AM +0000, brian m. carlson wrote:

> Since oidcpy and hashcpy are no longer functionally identical, remove
> the Cocinelle object_id transformations that convert from one into the
> other.

Unfortunately this means we'll no longer automatically find cases where
"foo" got converted into "struct object_id" and could be updated. I
guess at some point we assume that most everything has been converted
anyway, and that coccinelle rule loses its usefulness.

-Peff

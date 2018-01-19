Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B33C1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756501AbeASVq6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:46:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:50132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755307AbeASVq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:46:57 -0500
Received: (qmail 25690 invoked by uid 109); 19 Jan 2018 21:46:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jan 2018 21:46:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24952 invoked by uid 111); 19 Jan 2018 21:47:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jan 2018 16:47:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jan 2018 16:46:55 -0500
Date:   Fri, 19 Jan 2018 16:46:55 -0500
From:   Jeff King <peff@peff.net>
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        olyatelezhnaya@gmail.com
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20180119214655.GB12074@sigill.intra.peff.net>
References: <1516067185-1087-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516067185-1087-1-git-send-email-gs051095@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 15, 2018 at 08:46:25PM -0500, Gargi Sharma wrote:

> Replace the custom calls to mru.[ch] with calls to list.h. This patch is the
> final step in removing the mru API completely and inlining the logic.
> 
> Another discussion, here
> (https://public-inbox.org/git/CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com/)
> was on what has to be done with the next pointer of packed git type
> inside the
> packed_git structure. It can be removed _given_ that no one needs to
> access the list in order and can be sent as another patch.

Thanks for picking this up again. I agree that this is probably a good
stopping point for now, as I think just combining this with the 'next'
pointer may carry more side effects.

Aside from the braces thing that Christian mentioned (and the missing
signoff), this all looks good to me.

-Peff

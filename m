Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80ABF20A29
	for <e@80x24.org>; Wed, 20 Sep 2017 20:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbdITUPf (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:15:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:45108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751378AbdITUPe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:15:34 -0400
Received: (qmail 11636 invoked by uid 109); 20 Sep 2017 20:15:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 20:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15934 invoked by uid 111); 20 Sep 2017 20:16:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 16:16:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 16:15:32 -0400
Date:   Wed, 20 Sep 2017 16:15:32 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: fix memory leak in `reduce_heads()`
Message-ID: <20170920201532.paynyzq7ln7cadqc@sigill.intra.peff.net>
References: <1505936846-2195-3-git-send-email-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1505936846-2195-3-git-send-email-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 09:47:25PM +0200, Martin Ågren wrote:

> We don't free the temporary scratch space we use with
> `remove_redundant()`. Free it similar to how we do it in
> `get_merge_bases_many_0()`.

Yep, seems very straightforward, and there are no code paths where we
wouldn't want this.

-Peff

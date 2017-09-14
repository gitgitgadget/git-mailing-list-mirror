Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0DC209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 14:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdINOht (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 10:37:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:38824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751133AbdINOhs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 10:37:48 -0400
Received: (qmail 21884 invoked by uid 109); 14 Sep 2017 14:37:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 14:37:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28870 invoked by uid 111); 14 Sep 2017 14:38:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 10:38:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 10:37:46 -0400
Date:   Thu, 14 Sep 2017 10:37:46 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] merge-base: find fork-point outside partial reflog
Message-ID: <20170914143746.nnl27a7r4spklooj@sigill.intra.peff.net>
References: <cover.1505394278.git.git@grubix.eu>
 <f16c671b268432199a0b2e0d22bb1b786a44bb2a.1505394278.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f16c671b268432199a0b2e0d22bb1b786a44bb2a.1505394278.git.git@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 03:15:20PM +0200, Michael J Gruber wrote:

> In fork-point mode, merge-base adds the commit at refname to a list of
> candidates to walk from only when the reflog is empty. Therefore, it
> fails to find merge bases that are descendants of the most recent reflog
> entry.
> 
> Add the commit at the tip unconditionally so that a merge base on the
> history of refname is found in any case, independent of the state of the
> reflog.

OK, so the reflog we are interested in here is one where the tip commit
is not mentioned. I'm not sure how one gets into that state, but I agree
it makes sense to act as if it's there.

-Peff

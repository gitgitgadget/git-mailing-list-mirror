Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B5D1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeKKQff (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:35:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:47618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727376AbeKKQff (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:35:35 -0500
Received: (qmail 32533 invoked by uid 109); 11 Nov 2018 06:47:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 06:47:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31832 invoked by uid 111); 11 Nov 2018 06:47:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 01:47:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 01:47:51 -0500
Date:   Sun, 11 Nov 2018 01:47:51 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 05/10] fast-export: move commit rewriting logic into a
 function for reuse
Message-ID: <20181111064751.GE30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-6-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-6-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:07PM -0800, Elijah Newren wrote:

> Logic to replace a filtered commit with an unfiltered ancestor is useful
> elsewhere; put it into a function we can call.

OK. I had to stare at it for a minute to make sure there was not an
edge case with looking at "p" versus "p->parents", but I think it is a
faithful conversion.

-Peff

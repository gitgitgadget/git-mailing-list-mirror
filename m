Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026A51F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbeGKMgW (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 08:36:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:55034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387471AbeGKMgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 08:36:22 -0400
Received: (qmail 5810 invoked by uid 109); 11 Jul 2018 12:32:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 12:32:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6610 invoked by uid 111); 11 Jul 2018 12:32:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 08:32:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 08:32:13 -0400
Date:   Wed, 11 Jul 2018 08:32:13 -0400
From:   Jeff King <peff@peff.net>
To:     William Chargin <wchargin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
Message-ID: <20180711123213.GA23835@sigill.intra.peff.net>
References: <20180710154106.5356-1-wchargin@gmail.com>
 <xmqqwou26hcv.fsf@gitster-ct.c.googlers.com>
 <CAFW+GMAP6hwU1frm-FUVqx4pokpSQajWz7N6mGtMC-EO+01m2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFW+GMAP6hwU1frm-FUVqx4pokpSQajWz7N6mGtMC-EO+01m2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 11:18:22PM -0700, William Chargin wrote:

> > Also, I am not sure if "or from HEAD" is even needed when we say
> > "from ANY ref" already, as we count things like HEAD as part of the
> > ref namespace.
> 
> My two cents: with the docs as is, I wasn't sure whether HEAD was
> intended to count as a ref for this purpose. The gitglossary man page
> defines a ref as a "name that begins with refs/" (seemingly excluding
> HEAD), though it later says that HEAD is a "special-purpose ref". In my
> opinion, the change adds clarity without any particular downside---but
> I'm happy to revert it if you'd prefer. I'd also be happy to change the
> wording to something like "any ref, including HEAD" if we want to
> emphasize that HEAD really is a ref.

FWIW, I think the clarification to include HEAD is helpful here, since
it took me a few minutes of thinking to decide whether the current
behavior was a bug or just a subtlety. Your "including HEAD" suggestion
seems like the best route to me. But I can live with it either way.

> After reaching consensus on the change to the docs, should I send in a
> [PATCH v2] In-Reply-To this thread?

Yes.

> Peff, should I add your
> Signed-off-by to the commit message, or is that not how things are done?

Yes, you can add in any sign-offs that have been explicitly given. It's
normal to order them chronologically, too (so mine would come first,
then yours, showing that the patch flowed through me to you; Junio will
add his at the end).

-Peff

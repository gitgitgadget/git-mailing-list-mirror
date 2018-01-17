Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23F51F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeAQVtJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:49:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:47074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750931AbeAQVtI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:49:08 -0500
Received: (qmail 19927 invoked by uid 109); 17 Jan 2018 21:49:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 21:49:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5933 invoked by uid 111); 17 Jan 2018 21:49:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 16:49:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 16:49:06 -0500
Date:   Wed, 17 Jan 2018 16:49:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
Message-ID: <20180117214906.GC13128@sigill.intra.peff.net>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <20180115213335.GB4778@sigill.intra.peff.net>
 <20180115220946.GF4778@sigill.intra.peff.net>
 <CAL21BmmmX5-uisj+_=sDHwJO=fpXc41Wriw+uuxtR=gOio-HZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21BmmmX5-uisj+_=sDHwJO=fpXc41Wriw+uuxtR=gOio-HZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 10:22:23AM +0300, Оля Тележная wrote:

> >> In other words, I think the endgame is that expand_atom() isn't there at
> >> all, and we're calling the equivalent of format_ref_item() for each
> >> object (except that in a unified formatting world, it probably doesn't
> >> have the word "ref" in it, since that's just one of the items a caller
> >> might pass in).
> 
> Agree! I want to merge current edits, then create format.h file and
> make some renames, then finish migrating process to new format.h and
> support all new meaningful tags.

I think we have a little bit of chicken and egg there, though. I'm
having trouble reviewing the current work, because it's hard to evaluate
whether it's doing the right thing without seeing the end state. So what
I was suggesting in my earlier mails was that we actually _not_ try to
merge this series, but use its components and ideas to build a new
series that does things in a bit different order.

Some of the patches here would end up thrown out, and some would get
cherry-picked into the new series. And some would have some conflicts
and need to get parts rewritten to fit into the new order.

-Peff

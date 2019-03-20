Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCB520248
	for <e@80x24.org>; Wed, 20 Mar 2019 05:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbfCTFW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 01:22:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725300AbfCTFW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 01:22:28 -0400
Received: (qmail 18730 invoked by uid 109); 20 Mar 2019 05:22:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 05:22:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5376 invoked by uid 111); 20 Mar 2019 05:22:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 01:22:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 01:22:26 -0400
Date:   Wed, 20 Mar 2019 01:22:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: how can i "gc" or "prune" objects related to a deleted remote?
Message-ID: <20190320052226.GA9650@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1903081029510.25426@localhost.localdomain>
 <20190319063904.GC31801@sigill.intra.peff.net>
 <878sxbdx51.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878sxbdx51.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 19, 2019 at 10:35:54AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > My guess is you forgot the tag? There's not a general solution there,
> > because the tags all get intermingled. Git has no idea which ones came
> > from which remote. However, if you have the commit id of an object you
> > expect to be going away, you can use:
> >
> >   git for-each-ref --contains=$that_commit
> 
> Not a general solution, but if you know you have one remote left, and
> you don't have unpushed locally created tags, you can do a:
> 
>     git fetch origin --prune --prune-tags

Good call. I forgot that we even had --prune-tags.

-Peff

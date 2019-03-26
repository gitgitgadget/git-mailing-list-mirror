Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2192020248
	for <e@80x24.org>; Tue, 26 Mar 2019 16:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfCZQSZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 12:18:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:36708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729693AbfCZQSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 12:18:25 -0400
Received: (qmail 15359 invoked by uid 109); 26 Mar 2019 16:18:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 16:18:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20444 invoked by uid 111); 26 Mar 2019 16:18:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 12:18:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 12:18:18 -0400
Date:   Tue, 26 Mar 2019 12:18:18 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: [PATCH 0/3] tag: prevent recursive tags
Message-ID: <20190326161818.GA29627@sigill.intra.peff.net>
References: <20190325233723.GD23728@sigill.intra.peff.net>
 <cover.1553586707.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1553586707.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 12:53:14AM -0700, Denton Liu wrote:

> Peff said:
> > Yeah, that's probably a good idea. Now we just need somebody to write
> > the patch...
> 
> Hey would you look at that, somebody wrote the patch!

The system works. :)

> Earlier in the mailing list[1], Robert Dailey reported confusion over
> some recursive tags.
> 
> Peff noted that he hasn't seen a tag-to-a-tag in the wild so in most
> cases, it'd probably be a mistake on the part of a user. He also
> suggested we error out on a recursive tag unless "--allow-recursive-tag"
> is provided.
> 
> This patchset implements those suggestions.

Thanks. I agree with all of the comments Ævar left, but other than that
this looks pretty good to me.

The only hesitation I'd have is that turning this case into a hard error
(rather than just an informative warning) may be too sudden for some
people's tastes. I'm on the fence myself; I'll be curious what Junio
thinks when he gets back.

-Peff

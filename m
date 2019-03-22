Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B782C202BB
	for <e@80x24.org>; Fri, 22 Mar 2019 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfCVJbf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:31:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:60532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727713AbfCVJbf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:31:35 -0400
Received: (qmail 10807 invoked by uid 109); 22 Mar 2019 09:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Mar 2019 09:31:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18443 invoked by uid 111); 22 Mar 2019 09:31:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Mar 2019 05:31:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2019 05:31:32 -0400
Date:   Fri, 22 Mar 2019 05:31:32 -0400
From:   Jeff King <peff@peff.net>
To:     Wolfgang Denk <wd@denx.de>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
Message-ID: <20190322093132.GA17498@sigill.intra.peff.net>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
 <20190322071231.GA26114@sigill.intra.peff.net>
 <20190322082114.BC19924013C@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190322082114.BC19924013C@gemini.denx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 09:21:14AM +0100, Wolfgang Denk wrote:

> Dear Jeff,
> 
> In message <20190322071231.GA26114@sigill.intra.peff.net> you wrote:
> >
> > However, so does the parent of 17966c0a63d. So I don't know if the
> > u-boot-efi repo is just broken, or if there's some other different bug
> > at play.
> 
> git fsck reports a number of dangling tags, but no other issues:

Weird. I had set http.maxrequests to "1" to give more readable output
from GIT_CURL_VERBOSE, etc. It fails with that setting, but not with the
default of 5. Which certainly seems like a bug, but one that has been
there for a while (at least since v2.9.x, which I tested).

-Peff

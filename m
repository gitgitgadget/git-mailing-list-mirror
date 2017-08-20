Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F49208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 09:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbdHTJ3k (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 05:29:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:43960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751019AbdHTJ3k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 05:29:40 -0400
Received: (qmail 26572 invoked by uid 109); 20 Aug 2017 09:29:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 09:29:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12913 invoked by uid 111); 20 Aug 2017 09:30:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 05:30:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 05:29:38 -0400
Date:   Sun, 20 Aug 2017 05:29:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #04; Fri, 18)
Message-ID: <20170820092937.7u3wshb44bai6kka@sigill.intra.peff.net>
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 02:26:14PM -0700, Junio C Hamano wrote:

> * jk/drop-ancient-curl (2017-08-09) 5 commits
>  - http: #error on too-old curl
>  - curl: remove ifdef'd code never used with curl >=7.19.4
>  - http: drop support for curl < 7.19.4
>  - http: drop support for curl < 7.16.0
>  - http: drop support for curl < 7.11.1
> 
>  Some code in http.c that has bitrot is being removed.
> 
>  What is the status of the discussion around this area????

This definitely should not be merged to 'next'; there were a few minor
issues people pointed out. I haven't re-rolled because I was trying to
figure out if we were interested in moving forward with this or not.

I'm still inclined in that direction, though I agree the information
from Tom (and his series) does weaken my argument somewhat.

> * tc/curl-with-backports (2017-08-11) 2 commits
>  - http: use a feature check to enable GSSAPI delegation control
>  - http: fix handling of missing CURLPROTO_*
> 
>  Updates to the HTTP layer we made recently unconditionally used
>  features of libCurl without checking the existence of them, causing
>  compilation errors, which has been fixed.  Also migrate the code to
>  check feature macros, not version numbers, to cope better with
>  libCurl that vendor ships with backported features.
> 
>  What is the doneness of this topic????

These look OK to me, and I just dropped a few comments in the thread.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B093D1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 22:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeC2WaD (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:30:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:48152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752021AbeC2W3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:51 -0400
Received: (qmail 31763 invoked by uid 109); 29 Mar 2018 22:29:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 22:29:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23267 invoked by uid 111); 29 Mar 2018 22:30:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 18:30:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 18:29:49 -0400
Date:   Thu, 29 Mar 2018 18:29:49 -0400
From:   Jeff King <peff@peff.net>
To:     "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] credential: ignore SIGPIPE when writing to credential
 helpers
Message-ID: <20180329222949.GA13017@sigill.intra.peff.net>
References: <20180329175501.GE31833@sigill.intra.peff.net>
 <20180329180056.9941-1-brady@cisco.com>
 <20180329215153.GJ2939@sigill.intra.peff.net>
 <E29A3311-D880-4872-835B-EF082EB2F70C@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E29A3311-D880-4872-835B-EF082EB2F70C@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 10:20:40PM +0000, Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco) wrote:

> I appreciate your time.  Quick Q... is there a way to track the patch
> through to release?  If not I can just scan release notes/etc so no
> worries.

When the maintainer picks up the patch, he usually says something like
"thanks, will queue". Then you can track its progress either by:

 - fetching from https://github.com/gitster/git, which has all of the
   topic branches. Yours will be "eb/something", depending what Junio
   names it. And then you can periodically "git branch -a --contains
   eb/something" to see it progress through the various integration
   branches ('pu', 'next', 'master'). The branches are described in the
   "note from the maintainer" that's sent to the list periodically.
   E.g.:

     https://public-inbox.org/git/xmqqy3nt40pq.fsf@gitster.mtv.corp.google.com/

 - alternatively, you can read the "What's cooking in git.git" messages
   sent out by the maintainer a few times a week. E.g.:

     https://public-inbox.org/git/xmqqefkm6s06.fsf@gitster-ct.c.googlers.com/

   There your eb/something topic will be mentioned, along with the
   status (where it is in the graduation cycle, what's coming next, and
   if it's stalled, why).

We're in a release freeze right for v2.17 right now, so I'd expect your
patch to probably go to the 'maint' track and end up in v2.17.1.

Of course somebody else may see something wrong I didn't and ask you to
correct it, which would be in a reply to this thread. :)

-Peff

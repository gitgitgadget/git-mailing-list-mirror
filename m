Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BCD1FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 05:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935228AbdJRFKR (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 01:10:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:56222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933260AbdJRFKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 01:10:17 -0400
Received: (qmail 8437 invoked by uid 109); 18 Oct 2017 05:10:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 05:10:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29334 invoked by uid 111); 18 Oct 2017 05:10:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 01:10:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2017 01:10:14 -0400
Date:   Wed, 18 Oct 2017 01:10:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] check-ref-format doc: --branch validates and expands
 <branch>
Message-ID: <20171018051014.kfwq2ayeorr5jpc3@sigill.intra.peff.net>
References: <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
 <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
 <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
 <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
 <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
 <20171017071234.m6j4rqn6izdvla6d@aiede.mtv.corp.google.com>
 <xmqq60bdo5op.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60bdo5op.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 05:55:18AM +0900, Junio C Hamano wrote:

> I'll take these three to replace what I tentatively queued, not
> necessarily because I like the change in 1/3 better, but because
> these are explained much better; besides I prefer a version that at
> least two people deeply looked at.

These look good to me. Between your two versions, I think the code in
Jonathan's is slightly preferable. It's possible that some other caller
of strbuf_check_branch_name() may run into the same thing and be fixed
(I am trying to think of a hypothetical caller that would be
inconvenienced by the new behavior, but I can't come up with one; and
certainly the existing code would BUG(), so this is an improvement).

-Peff

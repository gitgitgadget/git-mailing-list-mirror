Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF44A208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757400AbdHYRgd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:36:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:49324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755568AbdHYRgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:36:32 -0400
Received: (qmail 1271 invoked by uid 109); 25 Aug 2017 17:36:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 17:36:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20146 invoked by uid 111); 25 Aug 2017 17:37:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 13:37:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Aug 2017 10:36:27 -0700
Date:   Fri, 25 Aug 2017 10:36:27 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170825173627.gic5gdu7dv7zxucj@sigill.intra.peff.net>
References: <20170824225328.8174-1-bmwill@google.com>
 <xmqq7exsv3yu.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZ3NDsAQ4zVrUN8Ab3=f5RT63G16a_gCPm3Poe47BCMvg@mail.gmail.com>
 <xmqqbmn3tvru.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmn3tvru.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 10:14:13AM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > For now I would suggest we put a protocol v2 in place that is
> > the current protocol + a version number coming through the
> > poked hole at the beginning; the goal and review of this series
> > ought to focus on getting the version handshake right...
> 
> Oh, we are in absolute agreement on that.  It would be nice if we
> can have new tests to demonostrate three combinations working well
> (i.e. use 'installed git' whose path is given externally on one end
> of the connection, while the just-built binary sits on the other
> end, in addition to making sure just-built binary successfully talks
> with itself).

The harness in t/interop can perhaps help with that (at least between
existing git versions; testing across other implementations makes the
setup a lot tricker).

-Peff

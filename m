Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0986C208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdHQKYB (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 06:24:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:41536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752092AbdHQKYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 06:24:01 -0400
Received: (qmail 7385 invoked by uid 109); 17 Aug 2017 10:24:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 10:24:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25899 invoked by uid 111); 17 Aug 2017 10:24:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 06:24:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 06:23:59 -0400
Date:   Thu, 17 Aug 2017 06:23:59 -0400
From:   Jeff King <peff@peff.net>
To:     Marko Kungla <marko.kungla@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20170817102358.yiugmv5je6sfw4lo@sigill.intra.peff.net>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <CAKY_R-vsZo_OsA8F6DVx_4zi5=RpBfOn-w1Ou7pq-F7HTtptzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKY_R-vsZo_OsA8F6DVx_4zi5=RpBfOn-w1Ou7pq-F7HTtptzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 11:18:43PM +0200, Marko Kungla wrote:

> I guess that should only be about that it should not hit a (BUG).
> In my case in the example I gave I scan trough the directories to
> check repository status one of the tasks make use of check-ref-format.
> Since it may hit directory which is not a git repository it should not
> expose error (BUG) right.

Right. The BUG should definitely be corrected. Between what Jonathan is
suggesting and my patch, either would be fine for the case you described
originally ("--branch @{-1}" would always fail in a non-repo).

-Peff

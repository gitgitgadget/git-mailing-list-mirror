Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8245720954
	for <e@80x24.org>; Thu, 23 Nov 2017 00:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdKWADt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 19:03:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:38250 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751494AbdKWADs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 19:03:48 -0500
Received: (qmail 8670 invoked by uid 109); 23 Nov 2017 00:03:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Nov 2017 00:03:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5951 invoked by uid 111); 23 Nov 2017 00:04:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 19:04:04 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 19:03:46 -0500
Date:   Wed, 22 Nov 2017 19:03:46 -0500
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171123000346.GA8718@sigill>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
 <20171121214552.GB16418@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171121214552.GB16418@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 10:45:52PM +0100, Kevin Daudt wrote:

> > - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> > -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> > + * Without a disambiguating `--`, Git makes a reasonable guess, but can
> > +   error out, asking you to disambiguate when ambiguous.  E.g. if you have a
> 
> 'Can' error out implies that it sometimes would not error out when there
> is ambiguity. Are there situation where git does not error out in that
> case?

I read the rest of the thread, and I think the question here is not
about Git's behavior, but about parsing this sentence.

Without a "--" Git can sometimes do what you want. Or it may error out,
if what you asked for is ambiguous. And that sentence is trying to cover
those cases separately, and the "can" only applies to the ambiguous
case.

It's pretty clear to me as it is, but maybe we can write it differently.
Like:

  Without a disambiguating `--`, Git makes a reasonable guess. If it
  cannot guess (because your request is ambiguous), then it will error
  out.

-Peff

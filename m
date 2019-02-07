Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BAEE1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfBGUpE (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:45:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:36588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726764AbfBGUpE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:45:04 -0500
Received: (qmail 13406 invoked by uid 109); 7 Feb 2019 20:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Feb 2019 20:45:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19027 invoked by uid 111); 7 Feb 2019 20:45:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Feb 2019 15:45:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2019 15:45:02 -0500
Date:   Thu, 7 Feb 2019 15:45:02 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190207204502.GA28893@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
 <20190204233444.GC2366@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
 <20190206184903.GC10231@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902071518340.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902071518340.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 03:26:21PM +0100, Johannes Schindelin wrote:

> > So IMHO this isn't really a show-stopper problem, so much as something
> > that is a sign of the maturing test/CI setup (I say "maturing", not
> > "mature", as it seems we've probably still got a ways to go). As far as
> > notifications go, it probably makes sense for them to be something that
> > requires the user to sign up for anyway, so at that point they're making
> > their own choice about whether the signal to noise ratio is acceptable.
> 
> Maybe. I do not even know whether there is an option for that in Azure
> Pipelines, maybe GitHub offers that?

No, I don't think so. Probably the route there would be to make a
comment on the commit or PR that would then go to the user as a
notification (from which they can then decide on email delivery, etc).

> In any case, I just wanted to corroborate with a real-world example what I
> mentioned at the Contributors' Summit: that I would like to not script
> that thing yet where contributors are automatically notified when their
> branches don't pass.

Fair enough. As an alternative, do you know offhand if there's an easy
machine-readable way to get the CI results? If I could poll it with curl
and generate my own notifications, that would be fine for me.

> > I also think there are ways to automate away some of these problems
> > (e.g., flake detection by repeating test failures, re-running failures
> > on parent commits to check whether a patch actually introduced the
> > problem). But implementing those is non-trivial work, so I am certainly
> > not asking you to do it.
> 
> Indeed. It might be a lot more common than just Git, too, in which case I
> might catch the interest of some of my colleagues who could then implement
> a solid solution that works not only for us, but for everybody using Azure
> Pipelines.

Yes, agreed. :)

> Speaking of which... can we hook it up with https://github.com/git/git,
> now that the Azure Pipelines support is in `master`? I sent you and Junio
> an invitation to https://dev.azure.com/git/git, so that either you or
> Junio (who are the only owners of the GitHub repository) can set it up. If
> you want me to help, please do not hesitate to ping me on IRC.

I'm happy to. I walked through the Azure setup/login procedure, but I'm
not sure what to do next.

-Peff

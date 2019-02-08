Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A45B1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 02:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBHCxU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 21:53:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:36984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726911AbfBHCxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 21:53:20 -0500
Received: (qmail 18914 invoked by uid 109); 8 Feb 2019 02:53:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 02:53:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21239 invoked by uid 111); 8 Feb 2019 02:53:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Feb 2019 21:53:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2019 21:53:18 -0500
Date:   Thu, 7 Feb 2019 21:53:18 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190208025318.GC11392@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
 <20190204233444.GC2366@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
 <20190206184903.GC10231@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902071518340.41@tvgsbejvaqbjf.bet>
 <20190207204502.GA28893@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902072245020.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902072245020.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 10:57:48PM +0100, Johannes Schindelin wrote:

> > Fair enough. As an alternative, do you know offhand if there's an easy
> > machine-readable way to get the CI results? If I could poll it with curl
> > and generate my own notifications, that would be fine for me.
> 
> There is a REST API:
> 
> https://docs.microsoft.com/en-us/rest/api/azure/devops/build/builds/list?view=azure-devops-rest-5.0
> 
> So this would give you the latest 5 failed builds:
> 
> curl "https://dev.azure.com/gitgitgadget/git/_apis/build/builds?definitions=6&resultFilter=failed&\$top=5"
> 
> I did not find a way to filter by user, or by branch name with wildcards,
> though.

Thanks. I'll play around with that. If I can get the data out at all,
I'm sure I can massage it into some useful form with perl. That's what
it's for, after all. :)

> > I'm happy to. I walked through the Azure setup/login procedure, but I'm
> > not sure what to do next.
> 
> The next step would be to install Azure Pipelines from the Marketplace and
> activate it for git/git. There *should* be a wizard or something to walk
> you through...

OK, I'll take a look (but probably not until tomorrow).

-Peff

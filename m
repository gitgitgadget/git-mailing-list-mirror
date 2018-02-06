Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20541F576
	for <e@80x24.org>; Tue,  6 Feb 2018 11:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeBFLXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 06:23:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:42030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752647AbeBFLW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 06:22:57 -0500
Received: (qmail 31784 invoked by uid 109); 6 Feb 2018 11:22:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Feb 2018 11:22:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17022 invoked by uid 111); 6 Feb 2018 11:23:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Feb 2018 06:23:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2018 06:22:55 -0500
Date:   Tue, 6 Feb 2018 06:22:55 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/2] minor GETTEXT_POISON fixes
Message-ID: <20180206112255.GB32319@sigill.intra.peff.net>
References: <20180206084226.GA26237@sigill.intra.peff.net>
 <FA353B2B-A5D1-4E2C-A016-38066F611BDB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FA353B2B-A5D1-4E2C-A016-38066F611BDB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 06, 2018 at 10:06:53AM +0100, Lars Schneider wrote:

> 
> > On 06 Feb 2018, at 09:42, Jeff King <peff@peff.net> wrote:
> > 
> > I set NO_GETTEXT=1 in my config.mak, and happened to notice that running
> > the tests with GETTEXT_POISON fails. I think this has been broken for
> > years, but I don't generally play with GETTEXT_POISON. ;)
> 
> On Travis we run GETTEXT_POISON with gettext installed.
> What do you think about an additional job with GETTEXT_POISON and NO_GETTEXT=1?

I think it's probably a waste of CPU. ;)

It would be running the whole test suite to fix this one particular bug,
which I don't think is pretty likely to regress (at least not more than
any other bug). Whereas running with GETTEXT_POISON is meant to shake
out strings that maybe shouldn't be translated, which is a very likely
bug to get introduced.

-Peff

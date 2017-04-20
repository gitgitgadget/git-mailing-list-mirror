Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8A61FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 16:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033098AbdDTQpl (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 12:45:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:36925 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971203AbdDTQpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 12:45:39 -0400
Received: (qmail 18571 invoked by uid 109); 20 Apr 2017 16:45:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:45:39 +0000
Received: (qmail 5024 invoked by uid 111); 20 Apr 2017 16:46:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 12:46:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 12:45:36 -0400
Date:   Thu, 20 Apr 2017 12:45:36 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
Message-ID: <20170420164536.mcbmgfzhsrjqi24f@sigill.intra.peff.net>
References: <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net>
 <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net>
 <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
 <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net>
 <CAM0VKjmK0ib+sjf0sMPeiK7DrwHq1dJ58ZhDdp6HZsuQdb-eRw@mail.gmail.com>
 <20170413191236.3usecfgkjujhblo6@sigill.intra.peff.net>
 <CAM0VKjkVUPPsvpAu1WXeNg7sv1_V=Uxhhevf9fVkZvk9WERwwQ@mail.gmail.com>
 <20170414200829.ahqignx3pkhbuepg@sigill.intra.peff.net>
 <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 06:42:59PM +0200, SZEDER Gábor wrote:

> > I suppose so. It might be worth being picky just on the principle that
> > if it _is_ gone that's unexpected and we'd prefer somebody notice and
> > figure out why.
> 
> OK, agreed.
> 
> However, we do need the above 'test -d' for this to work, because 'rm
> -rf' doesn't consider non-existing paths as errors, so we wouldn't
> notice that the trash directory is already gone.

Right, that makes sense.

> >> > Replacing it the "exit 1" with a "die" that has a message is probably a
> >> > good idea, though.
> 
> test-lib.sh has a special 'die', different from git-sh-setup.sh's
> 'die'.  I'll use 'error "uh-oh"' instead.

Yeah, sorry, error() is the right function in this instance.

-Peff

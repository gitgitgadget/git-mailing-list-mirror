Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473951F453
	for <e@80x24.org>; Thu, 17 Jan 2019 16:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfAQQHz (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 11:07:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:39894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727584AbfAQQHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 11:07:55 -0500
Received: (qmail 27784 invoked by uid 109); 17 Jan 2019 16:07:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Jan 2019 16:07:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1544 invoked by uid 111); 17 Jan 2019 16:07:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 17 Jan 2019 11:07:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2019 11:07:52 -0500
Date:   Thu, 17 Jan 2019 11:07:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Change on check-attr behavior
Message-ID: <20190117160752.GA29375@sigill.intra.peff.net>
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 03:47:09PM +0000, Sérgio Peixoto wrote:

> I think there is a bug on the check-attr behavior of git when asking
> for the "allowed-ext" attribute.  Check the logs below to see that
> with version  2.20.1.windows.1 we get unspecified even the attribute
> is there as you can see when asking for all the attributes.
> 
> === OLD VERSION ===
> > git version
> git version 2.8.1.windows.1
> 
> > git check-attr -a test.py
> test.py: text: set
> test.py: allowed-ext: 100
> 
> > git check-attr allowed-ext test.py
> test.py: allowed-ext: 100
> 
> === NEW VERSION ===
> > git --version
> git version 2.20.1.windows.1
> 
> > git check-attr -a test.py
> test.py: text: set
> test.py: allowed-ext: 100
> 
> > git check-attr allowed-ext test.py
> test.py: allowed-ext: unspecified

I can't reproduce here (on Linux, but I don't think the attr code is
particularly Windows-specific).  Can you show us what's in your
.gitattributes file(s)?

-Peff

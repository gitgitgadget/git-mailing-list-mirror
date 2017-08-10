Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1BD208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbdHJSbK (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:31:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752639AbdHJSbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:31:09 -0400
Received: (qmail 21138 invoked by uid 109); 10 Aug 2017 18:31:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 18:31:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7300 invoked by uid 111); 10 Aug 2017 18:31:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 14:31:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 14:31:07 -0400
Date:   Thu, 10 Aug 2017 14:31:07 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] interpret-trailers: add an option to show only
 the trailers
Message-ID: <20170810183107.fykw6w3ypxnxzcy4@sigill.intra.peff.net>
References: <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
 <20170810180404.yg3jdzhquregh4ta@sigill.intra.peff.net>
 <CAGZ79kZY1ifks_TAniR+diHOKWVQpRVFeS=XEBGW+7LT=Js5RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZY1ifks_TAniR+diHOKWVQpRVFeS=XEBGW+7LT=Js5RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:28:52AM -0700, Stefan Beller wrote:

> > +test_expect_success 'only trailers' '
> > +       git config trailer.sign.command "echo config-value" &&
> 
> You may want to use 'test_config' here, which keeps the config
> only for one test. The subsequent tests seem to overwrite the
> config, so this is not wrong, just not the best style.

Yeah, I actually considered that but decided to keep style with the rest
of the script. I agree the whole thing could possibly switch to
test_config, but I suspect there may be some fallouts (the style of the
rest of the script seems to assume some continuity between the tests).

-Peff

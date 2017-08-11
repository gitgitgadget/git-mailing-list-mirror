Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919ED208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 09:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbdHKJGU (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 05:06:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:35846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752169AbdHKJGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 05:06:18 -0400
Received: (qmail 29973 invoked by uid 109); 11 Aug 2017 09:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 09:06:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14744 invoked by uid 111); 11 Aug 2017 09:06:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 05:06:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Aug 2017 05:06:16 -0400
Date:   Fri, 11 Aug 2017 05:06:16 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
Message-ID: <20170811090615.ds3qlgudhdyxggpv@sigill.intra.peff.net>
References: <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
 <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
 <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
 <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
 <20170810211039.okpwglvcmkngzri2@sigill.intra.peff.net>
 <98b14604-33f1-6d91-8c9e-ddfa0c5cb0e7@ramsayjones.plus.com>
 <20170810231038.4s2btsotoq76atuu@sigill.intra.peff.net>
 <CAP8UFD3RWByUBZf=E_EBCW2Zk7voogfB+Qpsx4U2YNq0T0Hqag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3RWByUBZf=E_EBCW2Zk7voogfB+Qpsx4U2YNq0T0Hqag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 09:02:24AM +0200, Christian Couder wrote:

> > But I really don't want callers to think of it as "unfold". I want it to
> > be "turn this into something I can parse simply". Hence if we were to
> > find another case where the output is irregular, I'd feel comfortable
> > calling that a bug and fixing it (one that I suspect but haven't tested
> > is that alternate separators probably should all be converted to
> > colons).
> 
> Though "fixing" this after a release has been made might introduce a
> regression for people who would already use the option on trailers
> with different separators. That's also why I don't like --normalize.
> We just don't know if we will need to "fix" it a lot to make sure
> scripts using it will work in all cases.
> 
> If we use --no-fold or --oneline instead, we don't promise too much
> from this option, so users cannot say that they expect it to work for
> them in all cases.

But promising a normalized form is exactly what I want from the option.

That said, I'm OK to promise that via "--parse", and call this --unfold,
if you really feel strongly.

-Peff

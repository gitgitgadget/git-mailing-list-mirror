Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8E920A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 12:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeLLMtL (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 07:49:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:39404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727204AbeLLMtL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 07:49:11 -0500
Received: (qmail 14069 invoked by uid 109); 12 Dec 2018 12:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Dec 2018 12:49:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15766 invoked by uid 111); 12 Dec 2018 12:48:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Dec 2018 07:48:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2018 07:49:09 -0500
Date:   Wed, 12 Dec 2018 07:49:09 -0500
From:   Jeff King <peff@peff.net>
To:     George King <george.w.king@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Difficulty with parsing colorized diff output
Message-ID: <20181212124908.GA5380@sigill.intra.peff.net>
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
 <20181208071634.GA18272@sigill.intra.peff.net>
 <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
 <20181211101742.GE31588@sigill.intra.peff.net>
 <871s6oni3a.fsf@evledraar.gmail.com>
 <EB1AF739-F97B-4905-9736-2A003722AD9A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EB1AF739-F97B-4905-9736-2A003722AD9A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 11:41:18AM -0500, George King wrote:

> I first started playing around with terminal colors about 5 years ago,
> and I recall learning the hard way that Apple Terminal at least
> behaves very strangely when you have background colors cross line
> boundaries: background colors disappeared when I scrolled lines back
> into view. I filed a bug thinking it couldn't be right and Apple
> closed it as behaving according to compatibility expectations. I never
> figured out whether they had misunderstood my report or if old
> terminals were just that crazy. Instead I decided that the safe thing
> to do was reset after every line. Perhaps some git author reached the
> same conclusion.

Yes, that's exactly it. Certain codes do not do well as they cross
lines. It's been long enough that I don't remember the details, and a
quick grep of the archive found too many results for me to bother wading
through.

-Peff

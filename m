Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E350A1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeJZF6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:58:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:54986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726142AbeJZF6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:58:20 -0400
Received: (qmail 10034 invoked by uid 109); 25 Oct 2018 21:24:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 21:24:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22772 invoked by uid 111); 25 Oct 2018 21:23:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 17:23:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 17:23:58 -0400
Date:   Thu, 25 Oct 2018 17:23:58 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
Message-ID: <20181025212358.GA23257@sigill.intra.peff.net>
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
 <20181023210154.32507-1-avarab@gmail.com>
 <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
 <20181024074400.GA31239@sigill.intra.peff.net>
 <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com>
 <20181025010905.GA4458@sigill.intra.peff.net>
 <a5535030-65c1-613c-e4ea-d4379b243b87@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5535030-65c1-613c-e4ea-d4379b243b87@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 02:24:41AM +0100, Ramsay Jones wrote:

> >> Yeah, my thinko.  The latter would be closer to what this patch
> >> wants to have, but obviously the former would be more flexible and
> >> useful in wider context.  Both have the "Huh?" factor---what they
> >> are doing has little to do with "config", but I did not think of a
> >> better kitchen-sink (and our default kitchen-sink "rev-parse" is
> >> even further than "config", I would think, for this one).
> > 
> > Heh, I thought through the exact sequence in your paragraph when writing
> > my other message. That's probably a good sign that we should probably
> > not pursue this further unless we see the use case come up again a few
> > more times (and if we do, then consider "config" the least-bad place to
> > do it).
> 
> I was thinking:
> 
>   $ git var -e GIT_WHATEVER_ENV
> 
> [-e for environment].
> 
> ... but that is really no different than git-config. ;-)

Actually, "git var" already does pull bits from the environment. It
doesn't know about all of the type-specific parsing that git-config
does, but it might be a reasonable path forward to teach it that. (But I
still think we should do nothing for now and see how often this comes
up).

-Peff

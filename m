Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAABD202AA
	for <e@80x24.org>; Sat, 23 Feb 2019 13:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfBWNWr (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 08:22:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:55442 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726326AbfBWNWr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 08:22:47 -0500
Received: (qmail 22469 invoked by uid 109); 23 Feb 2019 13:22:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Feb 2019 13:22:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4016 invoked by uid 111); 23 Feb 2019 13:23:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 23 Feb 2019 08:23:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2019 08:22:45 -0500
Date:   Sat, 23 Feb 2019 08:22:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 0/6] Makefile: allow for combining DEVELOPER= and
 CFLAGS="..."
Message-ID: <20190223132245.GA22403@sigill.intra.peff.net>
References: <20190222105658.26831-1-avarab@gmail.com>
 <20190222144127.32248-1-avarab@gmail.com>
 <20190222151607.GD5090@sigill.intra.peff.net>
 <87zhqn4h8n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhqn4h8n.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 10:59:20PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > My personal complaint is that you cannot override DEVELOPER flags via
> > config.mak, because of the ordering. But it looks like your patch 6
> > specifically addresses that (yay!).
> 
> Do you mean DEVOPTS? That works for me.

No, I meant overriding a developer CFLAG with a later one on the command
line. I.e., putting this in your config.mak:

  DEVELOPER = 1
  CFLAGS += -Wno-foo

doesn't work, because the user CFLAGS comes first. Your patch 6 does the
right thing.

-Peff

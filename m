Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297E21F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 17:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933326AbeGJRM1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 13:12:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:54026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933267AbeGJRM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 13:12:26 -0400
Received: (qmail 26785 invoked by uid 109); 10 Jul 2018 17:12:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 17:12:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28679 invoked by uid 111); 10 Jul 2018 17:12:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 13:12:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 13:12:24 -0400
Date:   Tue, 10 Jul 2018 13:12:24 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/9] X509 (gpgsm) commit signing support
Message-ID: <20180710171224.GI23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:52:22AM +0200, Henning Schild wrote:

> This series adds support for signing commits with gpgsm.

Thanks for working on this. I left a bunch of comments, but overall the
direction looks good.

We talked about this a bit off-list, but just for the public record:

> This series can be seen as a follow up of a series that appeared under
> the name "gpg-interface: Multiple signing tools" in april 2018 [1]. After
> that series was not merged i decided to get my patches ready. The
> original series aimed at being generic for any sort of signing tool, while
> this series just introduced the X509 variant of gpg. (gpgsm)
> I collected authors and reviewers of that first series and already put them
> on cc.

This series is a fine replacement for that earlier work. It's flexible
enough to allow what we really wanted out of that series (gpgsm support,
or another drop-in tool that uses the same interface). It doesn't lay
any groundwork for further tools (like signify), but I think the
consensus on the list was to punt on that until somebody had more
concrete plans for adding such a tool.

-Peff

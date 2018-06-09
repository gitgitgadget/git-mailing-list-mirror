Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E1F1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 06:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeFIG4i (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 02:56:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752858AbeFIG4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 02:56:37 -0400
Received: (qmail 21536 invoked by uid 109); 9 Jun 2018 06:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 06:56:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1044 invoked by uid 111); 9 Jun 2018 06:56:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 02:56:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 02:56:35 -0400
Date:   Sat, 9 Jun 2018 02:56:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180609065635.GE30224@sigill.intra.peff.net>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
 <87bmck4gip.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmck4gip.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 08:31:58AM +0200, Ævar Arnfjörð Bjarmason wrote:

> 1) I really don't see the basis for this argument that they'd need to
>    patch it out, they're not patching out e.g. GIT_TRACE now, which has
>    all the same sort of concerns, it's just a format that's more of a
>    hassle to parse than this proposed format.
> 
> 2) I think you and Johannes are just seeing the "telemetry" part of
>    this, but if you look past that all this *really* is is "GIT_TRACE
>    facility that doesn't suck to parse".

So that actually takes me to another question, which is: instead of
introducing a new "telemetry" feature, could we make GIT_TRACE suck less
to parse?

E.g., could we have a flag or environment variable to have the existing
traces output JSON? I guess right now they're inherently free-form via
trace_printf, so it would involve adding some structured interface
calls. Which is more or less what I guess JeffH's proposed feature to
look like.

-Peff

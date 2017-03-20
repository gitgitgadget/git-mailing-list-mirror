Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEA320958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbdCTQMo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:12:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:47657 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753137AbdCTQL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 12:11:58 -0400
Received: (qmail 5311 invoked by uid 109); 20 Mar 2017 16:11:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 16:11:38 +0000
Received: (qmail 1411 invoked by uid 111); 20 Mar 2017 16:11:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 12:11:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 12:11:34 -0400
Date:   Mon, 20 Mar 2017 12:11:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 3/8] tag: Change misleading --list <pattern> documentation
Message-ID: <20170320161134.7g5ljysunwsjiz3l@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com>
 <20170318103256.27141-4-avarab@gmail.com>
 <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
 <20170320034443.wq2uf4yabsxh2nji@sigill.intra.peff.net>
 <CACBZZX5V3fMpwUCFr8vXMsxkXpz353-BOtaANYvnu9Qnz1GSQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5V3fMpwUCFr8vXMsxkXpz353-BOtaANYvnu9Qnz1GSQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 05:09:02PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I think it's expected to work under the usual last-one-wins option
> > parsing. A more subtle case is that:
> >
> >   git tag -l -d foo
> >
> > would override "-l" with "-d". That's reasonable under the same rule as
> > long as the user knows that the two are mode-selectors. I don't think we
> > make that explicit in the documentation, though, so perhaps it isn't
> > something users should rely on.
> 
> That hasn't been the case since v1.8.5 (v1.8.4-rc0-12-g1158826394).
> Now supplying multiple CMDMODE invocations will die.
> 
> It is the case that we still need to manually check any pseudo-cmdmode
> switches like "tag -a" (bool) v.s. "tag -l" (cmdmode). We check that
> particular combination, but we doubtless have bugs like that in other
> commands.

Yeah, you're right. I didn't look past the options[] array to see that
we handled this specially. I guess there's nothing to document, then.

-Peff

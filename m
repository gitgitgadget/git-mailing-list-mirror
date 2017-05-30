Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D2A20D0A
	for <e@80x24.org>; Tue, 30 May 2017 03:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbdE3Dze (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 23:55:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:59564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdE3Dzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 23:55:33 -0400
Received: (qmail 7096 invoked by uid 109); 30 May 2017 03:55:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 03:55:33 +0000
Received: (qmail 20273 invoked by uid 111); 30 May 2017 03:56:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 23:56:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 May 2017 23:55:31 -0400
Date:   Mon, 29 May 2017 23:55:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv3 1/4] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170530035530.s2uqeityyhrdp5sx@sigill.intra.peff.net>
References: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
 <20170526100403.19270-1-szeder.dev@gmail.com>
 <20170526133024.g5rztiv3lea37n72@sigill.intra.peff.net>
 <xmqq8tlfdmpg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8tlfdmpg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 12:53:47PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, May 26, 2017 at 12:04:03PM +0200, SZEDER Gábor wrote:
> >
> >> Unfortunately, putting the default refspec into this temporary
> >> configuration environment breaks a few submodule tests
> >> (t5614-clone-submodules or t5614-clone-submodules-shallow (it's got
> >> renamed between this topic and master), t7407-submodule-foreach,
> >> t7410-submodule-checkout-to), because it "leaks" to the submodule
> >> environment.
> >
> > Doh, of course. I didn't think of that. That's probably a bad direction,
> > then, as there's no "just for this process" global config.
> 
> Yuck, right.  So... do we have a further plan for this topic, or are
> the patches more or less good as they are?

I was hoping we'd see one more iteration with the abstracted function
for adding to the "struct remote". Gábor, let me know if you're too sick
of the topic, and I can try to re-spin it.

-Peff

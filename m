Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4F31F461
	for <e@80x24.org>; Thu, 16 May 2019 03:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEPDmX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 23:42:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726190AbfEPDmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 23:42:22 -0400
Received: (qmail 4664 invoked by uid 109); 16 May 2019 03:42:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 03:42:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27025 invoked by uid 111); 16 May 2019 03:43:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 15 May 2019 23:43:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2019 23:42:20 -0400
Date:   Wed, 15 May 2019 23:42:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
Message-ID: <20190516034220.GE4596@sigill.intra.peff.net>
References: <pull.192.git.gitgitgadget@gmail.com>
 <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
 <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet>
 <20190514144305.GA28530@sigill.intra.peff.net>
 <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1905151234370.44@tvgsbejvaqbjf.bet>
 <xmqq36lf5e7a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36lf5e7a.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 11:24:25AM +0900, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> lacked the "const" for that reason, but apparently some compilers
> >> complain about the parameter type mismatch.
> >
> > We could be more explicit, as we know exactly that it is MS Visual C 2017
> > that is complaining.
> 
> We could be, but I do not see a point of shaming one particular
> compiler vendor.

I'd slightly disagree. If 10 years from now we decide that MSVC is not a
supported compiler anymore, that information would be useful for
somebody digging into the history to say "ah, we can probably use this
pattern once more". I say probably because while it was the only
complainer, once the pattern is removed we wouldn't know if anybody in
the interim _would_ have complained. But it still seems like something
that _could_ be useful to an archaeologist in the future.

-Peff

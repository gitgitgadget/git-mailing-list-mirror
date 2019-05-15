Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9822D1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEOBon (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:44:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:57766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726174AbfEOBon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:44:43 -0400
Received: (qmail 14085 invoked by uid 109); 15 May 2019 01:44:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 May 2019 01:44:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18486 invoked by uid 111); 15 May 2019 01:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 21:45:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 21:44:41 -0400
Date:   Tue, 14 May 2019 21:44:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
Message-ID: <20190515014440.GA13255@sigill.intra.peff.net>
References: <pull.192.git.gitgitgadget@gmail.com>
 <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
 <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet>
 <20190514144305.GA28530@sigill.intra.peff.net>
 <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 10:42:35AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do have a slight preference for going the _other_ way. There is no
> > need to mark the parameter as const in the definition. It is passed by
> > value, so nobody except the function body cares either way. And we have
> > many function bodies where value-passed parameters (or local variables!)
> > are not marked as const, even though they are only assigned to once.
> 
> That would be more like this patch, then?
> 
> -- >8 --
> Subject: pkt-line: drop 'const'-ness of a param to set_packet_header() 
> [..]

Yes, exactly.

-Peff

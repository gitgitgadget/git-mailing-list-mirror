Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390691F404
	for <e@80x24.org>; Tue, 20 Mar 2018 03:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeCTDps (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 23:45:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:35374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750968AbeCTDps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 23:45:48 -0400
Received: (qmail 27398 invoked by uid 109); 20 Mar 2018 03:45:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 03:45:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28730 invoked by uid 111); 20 Mar 2018 03:46:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Mar 2018 23:46:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2018 23:45:46 -0400
Date:   Mon, 19 Mar 2018 23:45:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180320034545.GA12938@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <xmqq8tanto90.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tanto90.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 08:33:15PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The best you can probably do is:
> >
> >   /.readme-docs/* diff=foo
> >
> > Since you have no diff.foo.* config, that will behave in the default way
> > (including respecting the usual "is it binary" checks). So a bit hacky,
> > but I think it would work as "ignore prior diff".
> 
> You can say
> 
> 	/.readme-docs/* !diff
> 
> I think.  Thre is a difference between setting it to "false"
> (i.e. Unset) and reverting it to unspecified state.
> 
> Isn't that what you want here?

Ah, yes, I totally forgot that existed. That's much better than the
hackery I proposed.

-Peff

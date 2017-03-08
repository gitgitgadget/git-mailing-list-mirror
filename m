Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69D1202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 12:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbdCHMwU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 07:52:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:40403 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbdCHMwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 07:52:18 -0500
Received: (qmail 21637 invoked by uid 109); 8 Mar 2017 05:45:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 05:45:35 +0000
Received: (qmail 19883 invoked by uid 111); 8 Mar 2017 05:45:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 00:45:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 00:45:33 -0500
Date:   Wed, 8 Mar 2017 00:45:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Horst Schirmeier <horst@schirmeier.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] send-pack: improve unpack-status error messages
Message-ID: <20170308054533.7wy52myrbpovyoet@sigill.intra.peff.net>
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
 <20170307133736.4lpn7mgme26dqs3m@sigill.intra.peff.net>
 <xmqq37eo66hw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37eo66hw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 07, 2017 at 02:56:27PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When the remote tells us that the "unpack" step failed, we
> > show an error message. However, unless you are familiar with
> > the internals of send-pack and receive-pack, it was not
> > clear that this represented an error on the remote side.
> > Let's re-word to make that more obvious.
> >
> > Likewise, when we got an unexpected packet from the other
> > end, we complained with a vague message but did not actually
> > show the packet.  Let's fix that.
> 
> Both make sense.
> 
> > And finally, neither message was marked for translation. The
> > message from the remote probably won't be translated, but
> > there's no reason we can't do better for the local half.
> 
> Hmm, OK.

I'll admit that I don't actually use the translations myself, being a
native English speaker.  So I am just guessing that somebody for whom
English is a second language would rather see the first half in a more
intelligible format. That at least tells them what the second half _is_,
so they might be able to search for the error with more context.

If my guess is wrong, though, I'm happy to retract that part or bump it
out to a separate patch.

-Peff

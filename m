Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1253C20756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdAQVBN (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:01:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:40477 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbdAQVBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:01:12 -0500
Received: (qmail 25697 invoked by uid 109); 17 Jan 2017 20:53:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 20:53:57 +0000
Received: (qmail 21347 invoked by uid 111); 17 Jan 2017 20:54:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:54:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 15:53:54 -0500
Date:   Tue, 17 Jan 2017 15:53:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/6] t1450: clean up sub-objects in duplicate-entry test
Message-ID: <20170117205354.wiczgyplbgsurn6e@sigill.intra.peff.net>
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
 <20170116212403.l7ca7crmt47id3mu@sigill.intra.peff.net>
 <xmqqlgu9e7dw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgu9e7dw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 12:52:43PM -0800, Junio C Hamano wrote:

> > Since the setup code happens inside a subshell, we can't
> > just set a variable for each object. However, we can stuff
> > all of the sha1s into the $T output variable, which is not
> > used for anything except cleanup.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  t/t1450-fsck.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Thanks.  
> 
> It is tempting to move this loop to remove_object, but that is not
> necessary while the user is only this one.

I agree it would be less gross. I avoided it because I knew that I
hacked up remove_object() in the other topic.

-Peff

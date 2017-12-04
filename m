Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5922720954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdLDR00 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:26:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:47604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751283AbdLDR0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:26:25 -0500
Received: (qmail 946 invoked by uid 109); 4 Dec 2017 17:26:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 17:26:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24904 invoked by uid 111); 4 Dec 2017 17:26:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 12:26:45 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 12:26:23 -0500
Date:   Mon, 4 Dec 2017 12:26:23 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171204172623.GD13332@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
 <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
 <20171201182924.GB27688@sigill.intra.peff.net>
 <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
 <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 03, 2017 at 05:39:10PM +0100, Lars Schneider wrote:

> >>> +                       fprintf(stderr, _("hint: Waiting for your editor input..."));
> >> I found "waiting for editor input" to be a funny way of saying this. I
> >> input to the editor, the editor does not input to Git. :)
> >> Maybe "waiting for your editor finish" or something would make more
> >> sense?
> > 
> > May be the good "Launched editor. Waiting ..." message, that was used in a previous version, itself makes sense?
> 
> Perfect bikeshed topic :-)
> 
> I would like to add "for your input" or "for you" to convey 
> that Git is not waiting for the machine but for the user.
> 
>     "hint: Launched editor. Waiting for your input..."
> 
> Would that work for you?

I guess "input" was the part that I found funny/confusing. The only
thing we know is that we're waiting on the editor process to finish, and
everything else is making assumptions about what's happening in the
editor.

-Peff

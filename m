Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0591120229
	for <e@80x24.org>; Sat, 22 Oct 2016 01:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755854AbcJVBJW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 21:09:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:60969 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755846AbcJVBJW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 21:09:22 -0400
Received: (qmail 32399 invoked by uid 109); 22 Oct 2016 01:09:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 01:09:21 +0000
Received: (qmail 8287 invoked by uid 111); 22 Oct 2016 01:09:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 21:09:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 21:09:19 -0400
Date:   Fri, 21 Oct 2016 21:09:19 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>, GitList <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] doc: fix merge-base ASCII art tab spacing
Message-ID: <20161022010918.knvbxwlnjdqedwni@sigill.intra.peff.net>
References: <20161020234009.1768-1-philipoakley@iee.org>
 <xmqqa8dyeebj.fsf@gitster.mtv.corp.google.com>
 <D861234B3E78496DBA70EE63B2BCDB96@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D861234B3E78496DBA70EE63B2BCDB96@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 10:26:29PM +0100, Philip Oakley wrote:

> > updating the source they work on.  Otherwise, the broken "doc-tool
> > stack" will keep producing broken output next time a source that
> > respects "tab is to skip to the next multiple of 8" rule is fed to
> > it, no?
> 
> By avoiding tabs *within the art* we would also be tolerant of those who may
> not have a set their tab spacing to 8 when viewing the raw text.
> 
> It's particularly the criss-cross diagram that needs fixed one way or
> another (for the doc/doctor differences).

I think the new asciidoctor correctly handles tabs within the art. The
earlier diagrams begin each line with a tab (to mark the pre-formatted
block), and then only some of the lines have additional tabs, and expect
those tabs to expand to 8 characters to line up with the other bits
(which is what caused a problem with earlier asciidoctor).

What is funny about that criss-cross diagram is that it actually chooses
different markers on each line to start the art: sometimes tabs and
sometimes spaces. And that seems to confuse even recent versions of
asciidoctor.

It may be that asciidoctor is wrong here, but I have to admit we are
venturing well into "what happens to work with asciidoc" territory, and
the right solution is just fixing the diagram (i.e., your patch).

-Peff

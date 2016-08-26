Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56351FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbcHZRX1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:23:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:33628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752051AbcHZRX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:23:27 -0400
Received: (qmail 24226 invoked by uid 109); 26 Aug 2016 17:23:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Aug 2016 17:23:26 +0000
Received: (qmail 25935 invoked by uid 111); 26 Aug 2016 17:23:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Aug 2016 13:23:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Aug 2016 13:23:23 -0400
Date:   Fri, 26 Aug 2016 13:23:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com
Subject: Re: [PATCH v6 03/13] pkt-line: add packet_write_fmt_gently()
Message-ID: <20160826172323.t2b56zrwbl7jw5p6@sigill.intra.peff.net>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-4-larsxschneider@gmail.com>
 <xmqq8tvkle6o.fsf@gitster.mtv.corp.google.com>
 <6A26AA14-E393-492C-ADE0-3206DF78AFF6@gmail.com>
 <xmqqinunihgl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinunihgl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 10:10:50AM -0700, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > I agree with your criticism of the code duplication. 
> >
> > However, I thought it would be OK, as Peff already 
> > tried to refactor it...
> > http://public-inbox.org/git/20160810150139.lpxyrqkr53s5f4sx@sigill.intra.peff.net/
> >
> > ... and I got the impression you agreed with Peff:
> > http://public-inbox.org/git/xmqqvaz84g9y.fsf@gitster.mtv.corp.google.com/
> 
> The former does not exactly show how ugly it was, but I do not have
> to see it.  It is talking about eliminating the need for memcpy()
> and duplicated header generation code, which the suggestion you are
> responding to didn't even attempt.  If Peff said he tried an even
> more aggressive refactoring and it ended up too ugly to live, I
> believe him and agree with his assessment.

Right, what I found difficulty with was factoring out format_packet(). I
think the "gently" part is easy.

-Peff

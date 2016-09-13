Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A379E20984
	for <e@80x24.org>; Tue, 13 Sep 2016 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757812AbcIMSO0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 14:14:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42727 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754638AbcIMSO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 14:14:26 -0400
Received: (qmail 5433 invoked by uid 109); 13 Sep 2016 18:14:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 18:14:25 +0000
Received: (qmail 24617 invoked by uid 111); 13 Sep 2016 18:14:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 14:14:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 11:14:21 -0700
Date:   Tue, 13 Sep 2016 11:14:21 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: use valid pointer in strbuf_remove()
Message-ID: <20160913181420.ebsiscqk3sbc7axl@sigill.intra.peff.net>
References: <408af1a3-6867-2ff5-c97f-3eb884412ad8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <408af1a3-6867-2ff5-c97f-3eb884412ad8@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 06:40:22PM +0200, René Scharfe wrote:

> The fourth argument of strbuf_splice() is passed to memcpy(3), which is
> not supposed to handle NULL pointers.  Let's be extra careful and use a
> valid empty string instead.  It even shortens the source code. :)

Heh. Looks obviously correct and like a good thing to do.

-Peff

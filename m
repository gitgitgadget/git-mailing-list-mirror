Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6886E2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbcIOSo4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:44:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:43821 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbcIOSoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:44:54 -0400
Received: (qmail 21624 invoked by uid 109); 15 Sep 2016 18:44:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 18:44:53 +0000
Received: (qmail 11047 invoked by uid 111); 15 Sep 2016 18:45:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 14:45:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 11:44:48 -0700
Date:   Thu, 15 Sep 2016 11:44:48 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a
 strbuf, part 2
Message-ID: <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net>
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 08:31:00PM +0200, René Scharfe wrote:

> Replace uses of strbuf_addf() for adding strings with more lightweight
> strbuf_addstr() calls.  This makes the intent clearer and avoids
> potential issues with printf format specifiers.
> 
> 02962d36845b89145cd69f8bc65e015d78ae3434 already converted six cases,
> this patch covers eleven more.

Great, these all look obviously correct.

> A semantic patch for Coccinelle is included for easier checking for
> new cases that might be introduced in the future.

I think there was some discussion in brian's object_id patches about
whether we wanted to carry Coccinelle transformations in the tree, but I
don't remember the outcome. I don't have an opinion myself.

> Silly question: Is there a natural language that uses percent signs
> as letters or e.g. instead of commas? :)

I don't know, but if they do, they'd better get used to escaping them.
:)

-Peff

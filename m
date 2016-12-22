Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AEBD1FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 22:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764171AbcLVWTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 17:19:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:59805 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbcLVWTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 17:19:15 -0500
Received: (qmail 18593 invoked by uid 109); 22 Dec 2016 22:19:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Dec 2016 22:19:15 +0000
Received: (qmail 21518 invoked by uid 111); 22 Dec 2016 22:19:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Dec 2016 17:19:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Dec 2016 17:19:12 -0500
Date:   Thu, 22 Dec 2016 17:19:12 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/2] t5615-alternate-env: double-quotes in file names do
 not work on Windows
Message-ID: <20161222221912.2q722cnrl2hnz6pi@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
 <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
 <00b6235d-c1bc-30c2-6539-6c78c4ce9eb0@kdbg.org>
 <20161221224222.6fn6irefmd6li6oa@sigill.intra.peff.net>
 <4e66fba1-d881-6a96-1e4d-da9c897353ac@kdbg.org>
 <54ba9cff-b6f7-7660-261f-393cd5181da6@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54ba9cff-b6f7-7660-261f-393cd5181da6@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2016 at 08:06:02PM +0100, Johannes Sixt wrote:

> Am 22.12.2016 um 07:13 schrieb Johannes Sixt:
> > Am 21.12.2016 um 23:42 schrieb Jeff King:
> > > Hmph. I explicitly avoided a colon in the filename so that it would run
> > > on MINGW. Is a double-quote also not allowed?
> > 
> > It is not allowed; that was my conclusion. But now that you ask, I'll
> > double-check.
> 
> Ok, the point is that I get this error:
> 
> mv: cannot move `one.git' to `"one.git'
> 
> I don't feel inclined to find out which of 'mv' or the Windows API or the
> NTFS driver prevents the double-quotes and come up with a work-around just
> to get the test to run in some form. Let's leave it at the !MINGW
> prerequisite.

Thank you for double-checking (and sorry if my initial question was
confusing; I somehow missed the mention of dq in your subject line, and
just read the message body).

Your patch seems like the best solution.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250D7203EA
	for <e@80x24.org>; Wed, 21 Dec 2016 03:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756801AbcLUDWZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 22:22:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:59234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753083AbcLUDWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 22:22:25 -0500
Received: (qmail 16857 invoked by uid 109); 21 Dec 2016 03:22:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 03:22:24 +0000
Received: (qmail 8823 invoked by uid 111); 21 Dec 2016 03:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Dec 2016 22:23:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Dec 2016 22:22:21 -0500
Date:   Tue, 20 Dec 2016 22:22:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
Message-ID: <20161221032221.s7jmgnfrr6tyuyuk@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
 <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
 <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
 <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
 <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
 <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com>
 <xmqqvauejvnr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvauejvnr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 10:35:36AM -0800, Junio C Hamano wrote:

> -- >8 --
> Subject: SQUASH???
> 
> Make sure the test does not depend on the result of the previous
> tests; with MINGW prerequisite satisfied, a "reset to original and
> rebuild" in an earlier test was skipped, resulting in different
> history being tested with this and the next tests.

Yeah, this looks good, and obviously correct.

I do wonder if in general it should be the responsibility of skippable
tests to make sure we end up with the same state whether they are run or
not. That might manage the complexity more. But I certainly don't mind
tests being defensive like you have here.

-Peff

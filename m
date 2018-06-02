Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F201F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 00:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeFBACz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 20:02:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:59804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750974AbeFBACy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 20:02:54 -0400
Received: (qmail 15532 invoked by uid 109); 2 Jun 2018 00:02:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Jun 2018 00:02:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29777 invoked by uid 111); 2 Jun 2018 00:03:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 20:03:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 20:02:52 -0400
Date:   Fri, 1 Jun 2018 20:02:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
Message-ID: <20180602000252.GA25016@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
 <20180601210731.GA20974@sigill.intra.peff.net>
 <xmqq36y685vx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36y685vx.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 02, 2018 at 08:05:22AM +0900, Junio C Hamano wrote:

> > This has been deprecated since 2011. Maybe it's time to finally get rid
> > of it.
> 
> Sure, but is it worth the transition noise?
> 
> The way we lightly utter the word "deprecated" around here probably
> does not align well with the way how end-users perceive the word.
> Just marking something deprecated in a corner of the documentation
> set, without actively making an effort to wean the existing users
> off, while happily accepting the existing "deprecated" practice, is
> what we've done.
> 
> In those repositories people have with "[foo.bar] key" syntax that
> were created before or after 2011, we first should start issuing a
> "that syntax will no longer be valid---I'll update it for you if you
> want (y/n)?" warning and keep it for a release or three before
> finally removing the "feature".

Yeah, sorry to be unclear: I meant that we should actually start moving
forward on the removal, and I agree that the first step is issuing a
warning.

It may not be worth the transition noise. For the most part historical
oddities like these aren't hurting anybody. On the other hand, people
read the documentation and go "huh?". These kinds of vestigial options
and special cases can add up to clutter the explanations. So I dunno.

-Peff

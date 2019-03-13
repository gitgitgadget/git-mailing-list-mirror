Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0EE120248
	for <e@80x24.org>; Wed, 13 Mar 2019 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCMVAo (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 17:00:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:49604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727126AbfCMVAn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 17:00:43 -0400
Received: (qmail 23956 invoked by uid 109); 13 Mar 2019 21:00:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 21:00:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15998 invoked by uid 111); 13 Mar 2019 20:59:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 16:59:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 16:59:26 -0400
Date:   Wed, 13 Mar 2019 16:59:26 -0400
From:   Jeff King <peff@peff.net>
To:     Sergio Durigan Junior <sergiodj@sergiodj.net>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
Message-ID: <20190313205926.GB5397@sigill.intra.peff.net>
References: <87k1h55bx0.fsf@sergiodj.net>
 <CACsJy8ANLkz=3cj1dAuHdUCkrgQzos=90EEG0n901o3QAp3PUQ@mail.gmail.com>
 <877ed459eh.fsf@sergiodj.net>
 <CABPp-BFnxhiXfvZUZndD-_htMEw0bZzrLRFpAF9u5YV3wi6qnA@mail.gmail.com>
 <8736nr6g94.fsf@sergiodj.net>
 <e0e1e159-844d-c9bf-e1cc-ada05384ef76@gmail.com>
 <87pnqu4i1n.fsf@sergiodj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnqu4i1n.fsf@sergiodj.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 04:48:36PM -0400, Sergio Durigan Junior wrote:

> Huh, I do have some of the files opened in Emacs!  They're in
> background, but indeed, now that you mentioned I remember that Emacs
> keeps track of changes and invokes "git status" sometimes.  Next time I
> see the bug, I'll try closing the files and see if it happens again.

If Emacs (I guess maybe magit?) is running "git status" behind the
scenes, you might benefit from teaching it to use "git
--no-optional-locks status" instead. See the section "BACKGROUND
REFRESH" in "git help status" for more discussion.

-Peff

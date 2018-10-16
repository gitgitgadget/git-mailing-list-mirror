Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5441F454
	for <e@80x24.org>; Tue, 16 Oct 2018 06:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeJPO3r (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 10:29:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:41826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727094AbeJPO3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 10:29:46 -0400
Received: (qmail 19317 invoked by uid 109); 16 Oct 2018 06:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 16 Oct 2018 06:40:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7896 invoked by uid 111); 16 Oct 2018 06:40:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Oct 2018 02:40:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2018 02:40:49 -0400
Date:   Tue, 16 Oct 2018 02:40:49 -0400
From:   Jeff King <peff@peff.net>
To:     Per Lundberg <per.lundberg@hibox.tv>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Ignored files being silently overwritten when switching branches
Message-ID: <20181016064049.GB25933@sigill.intra.peff.net>
References: <7d6858c8-aa84-aa05-6c69-22dbbff7dfaa@hibox.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d6858c8-aa84-aa05-6c69-22dbbff7dfaa@hibox.tv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 01:01:50PM +0000, Per Lundberg wrote:

> Sorry if this question has been asked before; I skimmed through the list 
> archives and the FAQ but couldn't immediately find it - please point me 
> in the right direction if it has indeed been discussed before.

It is a frequently asked question, but it doesn't seem to be in any FAQ
that I could find. The behavior you're seeing is intended. See this
message (and the rest of the thread) for discussion:

  https://public-inbox.org/git/7viq39avay.fsf@alter.siamese.dyndns.org/

> So my question is: is this by design or should this be considered a bug 
> in git? Of course, it depends largely on what .gitignore is being used 
> for - if we are talking about files which can easily be regenerated 
> (build artifacts, node_modules folders etc.) I can totally understand 
> the current behavior, but when dealing with more sensitive & important 
> content it's a bit inconvenient.

Basically: yes. It would be nice to have that "do not track this, but do
not trash it either" state for a file, but Git does not currently
support that.

-Peff

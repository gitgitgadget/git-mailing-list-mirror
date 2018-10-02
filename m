Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574891F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeJBVa1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:30:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:38562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726787AbeJBVa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:30:26 -0400
Received: (qmail 918 invoked by uid 109); 2 Oct 2018 14:46:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 14:46:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28739 invoked by uid 111); 2 Oct 2018 14:46:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 10:46:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 10:46:40 -0400
Date:   Tue, 2 Oct 2018 10:46:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jayesh Badwaik <badwaik.jayesh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Display a commit in red if it is not signed.
Message-ID: <20181002144639.GC24480@sigill.intra.peff.net>
References: <CAGiqTF47fu85XCFnEbfMEF96v6U=N_Ferr56qAji4eLuBpyxjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGiqTF47fu85XCFnEbfMEF96v6U=N_Ferr56qAji4eLuBpyxjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 11:26:19AM +0200, Jayesh Badwaik wrote:

> Is there a way to create git pretty format that sets the color to one
> color (say red) only when the commit is unsigned or the signature
> cannot be verified?

Not currently. There are placeholders to show the signing information
(e.g., %G?). But the log --format language does not yet have any kind of
conditional, and I think you'd want something like "if G? is 'G', then
show this color".

The for-each-ref format language does have this. We'd like to unify them
in the long run, but it hasn't happened yet.

-Peff

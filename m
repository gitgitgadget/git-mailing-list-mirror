Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5A81F406
	for <e@80x24.org>; Thu, 10 May 2018 14:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965379AbeEJOWp (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:22:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:34844 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965078AbeEJOWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:22:44 -0400
Received: (qmail 5415 invoked by uid 109); 10 May 2018 14:22:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 14:22:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24757 invoked by uid 111); 10 May 2018 14:22:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 10:22:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 10:22:42 -0400
Date:   Thu, 10 May 2018 10:22:42 -0400
From:   Jeff King <peff@peff.net>
To:     kelly elton <its.the.doc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Missing --relative documentation
Message-ID: <20180510142242.GA25617@sigill.intra.peff.net>
References: <CALVfKe9K+qoDNXf1PbnvXWdYn-Vtv8xUJF-1PctC8uN1p4gyiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALVfKe9K+qoDNXf1PbnvXWdYn-Vtv8xUJF-1PctC8uN1p4gyiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 12:24:26PM -0500, kelly elton wrote:

> git format-patch is missing documentation for --relative.
> There is also no auto complete(or tab complete, whatever it's called)
> for the --relative switch/argument.

The missing documentation is due to the ancient d4cb003fff (format-patch
documentation: Remove diff options that are not useful, 2009-11-07).
Unfortunately I couldn't find any discussion on why those options were
thought to be useless.

I assume the notion was that the point of format-patch is to generate
full text patches for somebody else to apply, and thus something like
--relative usually wouldn't make sense. I could see it being useful if
you are doing something funny, though, like generating patches for a
subset of the repository as if they were at the top level.

I'm not sure if it would make sense to add the option back to the
documentation, though, since the point was to try to de-clutter the
format-patch manpage. I wonder if we could say something like "this
command supports all the diff options; see git-diff[1] for the full
list".

-Peff

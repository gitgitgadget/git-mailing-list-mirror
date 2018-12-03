Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67389211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeLCWOo (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:14:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:57768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725848AbeLCWOn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 17:14:43 -0500
Received: (qmail 5278 invoked by uid 109); 3 Dec 2018 22:14:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 22:14:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14606 invoked by uid 111); 3 Dec 2018 22:14:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 17:14:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 17:14:41 -0500
Date:   Mon, 3 Dec 2018 17:14:41 -0500
From:   Jeff King <peff@peff.net>
To:     Robert White <rjwhite2453@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Confusing inconsistent option syntax
Message-ID: <20181203221441.GB11883@sigill.intra.peff.net>
References: <20181202100747.GA5019@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181202100747.GA5019@laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 02, 2018 at 09:07:47PM +1100, Robert White wrote:

> `git log --pretty short` gives the error message "ambiguous argument
> 'short'". To get the expected result, you need to use `git log
> --pretty=short`. However, `git log --since yesterday` and `git log
> --since=yesterday` both work as expected.
> 
> When is an = needed? What is the reason for these inconsistencies?

As Duy mentioned, this has to do with optional arguments for some flags.
This is discussed in more detail in "git help cli". Notably (and as
advised in that manpage), you should always use the "stuck" form (with
the "=") in scripts, in case a flag grows an optional value later.

-Peff

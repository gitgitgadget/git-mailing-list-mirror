Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526811F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 17:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeJLBTy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 21:19:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726886AbeJLBTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 21:19:54 -0400
Received: (qmail 29421 invoked by uid 109); 11 Oct 2018 17:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 17:51:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 569 invoked by uid 111); 11 Oct 2018 17:50:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 13:50:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 13:51:36 -0400
Date:   Thu, 11 Oct 2018 13:51:36 -0400
From:   Jeff King <peff@peff.net>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011175136.GA8825@sigill.intra.peff.net>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <20181011003440.GD13853@sigill.intra.peff.net>
 <20181011154319.GA6386@rigel>
 <1409ebd2-d72c-fbd6-bf5c-777342723ca2@umanovskis.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1409ebd2-d72c-fbd6-bf5c-777342723ca2@umanovskis.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 06:36:02PM +0200, Daniels Umanovskis wrote:

> On 10/11/18 5:43 PM, Rafael Ascensão wrote:
> > I agree it feels a bit out of place, and still think that
> > 
> >     $ git branch --list HEAD
> > 
> > would be a good candidate to be taught how to print the current branch.
> 
> I am not a fan because it would be yet another inconsistency in the Git
> command interface. An argument given after git branch --list means a
> pattern for the branches to list. Making HEAD print the current branch
> would be an exception to what an argument in that place means. Yes, HEAD
> itself is a very special string in git, but I'm not a fan of syntax
> where a specific argument value does something very different from any
> other value in that place.

Yeah, I agree. If we were to go this route, it should probably be:

  git branch --list-head

Which sounds a lot like what you are proposing, but I think the name
implies more strongly "show --list, but only for the HEAD". I.e., for
the detached case, show the "HEAD detached at..." text.

-Peff

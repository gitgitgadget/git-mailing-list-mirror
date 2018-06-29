Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E180D1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 20:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeF2UjH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 16:39:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:54732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754453AbeF2UjG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 16:39:06 -0400
Received: (qmail 18990 invoked by uid 109); 29 Jun 2018 20:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Jun 2018 20:39:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7660 invoked by uid 111); 29 Jun 2018 20:39:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 29 Jun 2018 16:39:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jun 2018 16:39:04 -0400
Date:   Fri, 29 Jun 2018 16:39:04 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Mike Hommey <mh@glandium.org>,
        Jameson Miller <jamill@microsoft.com>,
        git <git@vger.kernel.org>
Subject: Re: fast-import slowness when importing large files with small
 differences
Message-ID: <20180629203904.GA27566@sigill.intra.peff.net>
References: <20180629094413.bgltep6ntlza6vhz@glandium.org>
 <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 01:14:52PM -0700, Stefan Beller wrote:

> Interesting pieces regarding performance:
> 
> c420792217c8 xdiff: reduce indent heuristic overhead
> https://phab.mercurial-scm.org/rHGc420792217c89622482005c99e959b9071c109c5
> 
> f33a87cf60cc xdiff: add a preprocessing step that trims files
> https://phab.mercurial-scm.org/rHGf33a87cf60ccb8b46e06b85e60bc5031420707d6
> 
> I'll see if I can make that into patches.

Apparently the second one is not so trivial as you might hope; see
https://public-inbox.org/git/1520337165-sup-4504@x1c/.

-Peff

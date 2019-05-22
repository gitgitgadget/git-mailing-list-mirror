Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0775C1F462
	for <e@80x24.org>; Wed, 22 May 2019 05:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfEVFP0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 01:15:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:35784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725808AbfEVFPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 01:15:25 -0400
Received: (qmail 15955 invoked by uid 109); 22 May 2019 05:15:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 May 2019 05:15:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20310 invoked by uid 111); 22 May 2019 05:16:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 May 2019 01:16:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 May 2019 01:15:23 -0400
Date:   Wed, 22 May 2019 01:15:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] hash-object doc: point to ls-files and rev-parse
Message-ID: <20190522051523.GC29933@sigill.intra.peff.net>
References: <20190520215312.10363-1-avarab@gmail.com>
 <20190520215312.10363-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520215312.10363-4-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 11:53:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Amend the intro to note that it's better to ask the index about files
> already tracked by it.
> 
> I've seen uses of this in the wild where the use-case was finding
> object IDs for files found in a freshly cloned repo, i.e. something
> like "git ls-files | git hash-object --stdin-paths".

This example left me scratching my head, because it seems like such a
bad way to accomplish the goal that I had trouble figuring out what the
goal was in the first place.

Of course I am pretty familiar with Git, so my mindset is not
necessarily the same as the average reader of the manpage. But the
suggested documentation really seems to me to be warning about a
convoluted use case that most people would not come up with in the first
place.

And adding it in the introductory text means that people are more likely
to read and be confused by it, when they are really just looking to find
details on more mundane usage.

Or put another way: I could come up with a hundred bad ways to script
Git, but we are probably better off enumerating the _good_ ways to do
so, rather than listing the bad ways and leaving the user to figure out
what's left.

So I'm mildly negative on this patch.

-Peff

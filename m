Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBE31F453
	for <e@80x24.org>; Mon,  4 Feb 2019 23:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBDXcl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 18:32:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:32842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725900AbfBDXck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 18:32:40 -0500
Received: (qmail 10078 invoked by uid 109); 4 Feb 2019 23:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Feb 2019 23:32:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24119 invoked by uid 111); 4 Feb 2019 23:32:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Feb 2019 18:32:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2019 00:32:36 +0100
Date:   Tue, 5 Feb 2019 00:32:36 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] core.abbrev doc: document and test the abbreviation
 length
Message-ID: <20190204233235.GB2366@sigill.intra.peff.net>
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
 <20190204161217.20047-1-avarab@gmail.com>
 <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 04, 2019 at 12:04:21PM -0800, Junio C Hamano wrote:

> Instead of exposing this pretty-much "test-only" feature as a new
> option to t/helper/test-tool, I think it is OK, if not even better,
> to have it in rev-parse proper like this patch does.
> 
> I however have a mildly strong suspition that people would expect
> "rev-parse --abbrev-len=<num>" to be a synonym of "--short=<num>"
> 
> As this is pretty-much a test-only option, perhaps going longer but
> more descriptive would make sense?  
> 
> 	git rev-parse --compute-abbrev-length-for <object-count>
> 
> may be an overkill, but something along those lines.

You could even default <object-count> to the number of objects in the
repository. Which implies that perhaps the best spot is the command
where we already count the number of objects, git-count-objects.

-Peff

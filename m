Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E46B1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 07:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfAVHYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 02:24:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:43594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfAVHYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 02:24:02 -0500
Received: (qmail 6407 invoked by uid 109); 22 Jan 2019 07:24:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 07:24:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3534 invoked by uid 111); 22 Jan 2019 07:24:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 02:24:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 02:23:59 -0500
Date:   Tue, 22 Jan 2019 02:23:59 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH/RFC] fsck: complain when .gitignore and .gitattributes
 are symlinks
Message-ID: <20190122072359.GE28555@sigill.intra.peff.net>
References: <20190114230902.GG162110@google.com>
 <20190117170005.GA27667@sigill.intra.peff.net>
 <xmqq1s5bniuf.fsf@gitster-ct.c.googlers.com>
 <20190117212448.GA13100@sigill.intra.peff.net>
 <a0aef5a7-eb69-8dd8-abb7-4db6d1de4a26@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0aef5a7-eb69-8dd8-abb7-4db6d1de4a26@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 01:41:08AM +0000, Ramsay Jones wrote:

> I don't do this "from time to time", but *every* build on all
> platforms! :-D
> 
> As I have mentioned before, I run the script on 'master', 'next'
> and 'pu', but I don't look at the results for 'master', I simply
> look at the diffs master->next and next->pu.

Ah, ok, that explains it, then. As you noted, these made it straight to
master because of the security embargo.

Thanks for satisfying my curiosity (and for running your script!).

I do wonder if you might be better off comparing master@{1} to master to
see if anything new appears (since I assume the whole point is ignoring
historical false positives, and just looking at patches under active
development).

-Peff

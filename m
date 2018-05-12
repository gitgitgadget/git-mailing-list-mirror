Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796961F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750799AbeELJz0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:55:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37166 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750735AbeELJzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:55:25 -0400
Received: (qmail 25803 invoked by uid 109); 12 May 2018 09:55:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:55:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13894 invoked by uid 111); 12 May 2018 09:55:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:55:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:55:23 -0400
Date:   Sat, 12 May 2018 05:55:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v14 4/4] ls-remote: create '--sort' option
Message-ID: <20180512095523.GA2234@sigill.intra.peff.net>
References: <20180409014226.2647-1-haraldnordgren@gmail.com>
 <20180409014226.2647-4-haraldnordgren@gmail.com>
 <b5555929-9f7c-1c4a-78e8-708ebdaaa9d2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5555929-9f7c-1c4a-78e8-708ebdaaa9d2@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:45:23AM +0200, René Scharfe wrote:

> Why is fetch called outside of the test?  Its output is shown among the
> test messages, where it doesn't belong:
> 
>     ok 23 - overrides work between mixed transfer/upload-pack hideRefs
>     From /home/lsr/src/git/t/trash directory.t5512-ls-remote/
>      * [new branch]      master     -> origin/master
>     ok 24 - ls-remote --symref

Heh, I just noticed this yesterday, too, but ran out of time before
writing up the patch.

> -- >8 --
> Subject: [PATCH] t5512: run git fetch inside test
> 
> Do the preparatory fetch inside the test of ls-remote --symref to avoid
> cluttering the test output and to be able to catch unexpected fetch
> failures.

Yep, this looks obviously correct.

-Peff

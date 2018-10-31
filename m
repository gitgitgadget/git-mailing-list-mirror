Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DA51F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeKAF3K (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:29:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725780AbeKAF3J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:29:09 -0400
Received: (qmail 16083 invoked by uid 109); 31 Oct 2018 20:29:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 20:29:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14482 invoked by uid 111); 31 Oct 2018 20:28:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 16:28:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 16:29:30 -0400
Date:   Wed, 31 Oct 2018 16:29:30 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 3/3] cat-file: handle streaming failures consistently
Message-ID: <20181031202930.GB13021@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
 <20181030232337.GC32038@sigill.intra.peff.net>
 <20181031173859.GA717@flurp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031173859.GA717@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 01:38:59PM -0400, Eric Sunshine wrote:

> On Tue, Oct 30, 2018 at 07:23:38PM -0400, Jeff King wrote:
> > There are three ways to convince cat-file to stream a blob:
> > 
> >   - cat-file -p $blob
> > 
> >   - cat-file blob $blob
> > 
> >   - echo $batch | cat-file --batch
> > 
> > In the first two, we simply exit with the error code of
> > streaw_blob_to_fd(). That means that an error will cause us
> 
> Your "m" got confused and ended up upside-down.

Heh. I'm not sure how I managed that. They're not exactly next to each
other on a qwerty keyboard.

-Peff

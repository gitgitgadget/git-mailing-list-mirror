Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F62D1FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 22:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424829AbdDUWFE (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 18:05:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:38021 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423680AbdDUWFD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 18:05:03 -0400
Received: (qmail 26045 invoked by uid 109); 21 Apr 2017 22:05:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 22:05:02 +0000
Received: (qmail 20901 invoked by uid 111); 21 Apr 2017 22:05:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 18:05:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 18:05:00 -0400
Date:   Fri, 21 Apr 2017 18:05:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] t/perf: correctly align non-ASCII descriptions in output
Message-ID: <20170421220500.7ovz3dqintcyfhb5@sigill.intra.peff.net>
References: <20170421194428.1377-1-avarab@gmail.com>
 <20170421204154.c5mvmnccxkxdm5aw@sigill.intra.peff.net>
 <CACBZZX4oMFkZ93YxXrByh-jCK-eVxNBj+UgF77zm5Pq1mzf+WQ@mail.gmail.com>
 <20170421213553.6vqcmnwolwtieqo4@sigill.intra.peff.net>
 <CACBZZX5ERL4ecLL9AvPVKZGXhAS+RQsSSBQEEK7w3yR86A_tMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5ERL4ecLL9AvPVKZGXhAS+RQsSSBQEEK7w3yR86A_tMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2017 at 12:02:02AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Yeah, I know "use utf8" doesn't work for that, but I was thinking there
> > was some other trick. Digging...ah, here it is:
> >
> >   use open ':encoding(utf8)'
> >
> > No clue how portable that is. For such a small script it may be better
> > to just stick with vanilla binmode().
> 
> Yeah that would work, but doesn't work on 5.8.0, which is the lowest
> version we support.

Thanks for looking that up.

For the benefit of the maintainer, I'll summarize: Ævar's original patch
is fine as-is.

-Peff

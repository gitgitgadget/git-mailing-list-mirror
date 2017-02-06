Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CD91FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbdBFUcS (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 15:32:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:50082 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbdBFUcR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 15:32:17 -0500
Received: (qmail 30030 invoked by uid 109); 6 Feb 2017 20:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 20:32:17 +0000
Received: (qmail 18062 invoked by uid 111); 6 Feb 2017 20:32:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 15:32:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 21:32:15 +0100
Date:   Mon, 6 Feb 2017 21:32:15 +0100
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: warning in tree xxx: contains zero-padded file modes
Message-ID: <20170206203214.5y6ynn5co7davtrj@sigill.intra.peff.net>
References: <CAJZjrdWq+xSEoTypA_hWdQJgioGOHJd3V7djeQ0YxpzvhuoM=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdWq+xSEoTypA_hWdQJgioGOHJd3V7djeQ0YxpzvhuoM=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2017 at 02:23:37PM -0600, Samuel Lijin wrote:

> >> There are some discussions in the past [1] [2] about this.
> 
> I think you forgot to link to [2] :p

I think the [1] [2] there were recursive quotes from Duy's email. Those
footnotes were:

[1] http://public-inbox.org/git/%3CCAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com%3E/
[2] http://public-inbox.org/git/%3C20100326215600.GA10910@spearce.org%3E/

> The linked issue on bugs.debian.org has seen activity recently, which
> is the main reason I mentioned it separately as still relevant:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=743227

Yeah. I think that's not quite solvable with Git as we have it now.  We
have fsck.* and receive.fsck.* to tweak severity levels, but no matching
fetch.fsck.* for handling a push (and presumably a transfer.fsck.* to
cover both fetching and pushing). So there's a potential patch series
for anybody interested.

-Peff

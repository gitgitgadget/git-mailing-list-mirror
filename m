Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF3A1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbeKOTsH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 14:48:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:40266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728609AbeKOTsH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 14:48:07 -0500
Received: (qmail 11131 invoked by uid 109); 15 Nov 2018 09:41:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 09:41:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13897 invoked by uid 111); 15 Nov 2018 09:40:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 04:40:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 04:41:01 -0500
Date:   Thu, 15 Nov 2018 04:41:01 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v4] commit: add a commit.allowEmpty config variable
Message-ID: <20181115094101.GA15279@sigill.intra.peff.net>
References: <87d0rm7zeo.fsf@evledraar.gmail.com>
 <20181113155656.22975-1-tanushreetumane@gmail.com>
 <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet>
 <87zhuc1xcx.fsf@evledraar.gmail.com>
 <xmqqzhucpa37.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811150938070.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811150938070.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 09:40:38AM +0100, Johannes Schindelin wrote:

> From @chucklu:
> 
> > my user case is like this :
> >
> > When I want to cherr-pick commits from A to G (ABCDEFG), image C and E
> > are merge commits.  Then I will get lots of popup like:
> >
> >    The previous cherry-pick is now empty, possibly due to conflict
> >    resolution.
> >    If you wish to commit it anyway, use:
> >
> >        git commit --allow-empty
> >
> >    If you wish to skip this commit, use:
> >
> >        git reset
> >
> >    Then "git cherry-pick --continue" will resume cherry-picking
> >    the remaining commits.
> 
> My quick interpretation of this is that the user actually needs a way to
> skip silently commits which are now empty.

If it's always intended to be used with cherry-pick, shouldn't
cherry-pick learn a --keep-empty (like rebase has)? That would avoid
even stopping for this case in the first place.

-Peff

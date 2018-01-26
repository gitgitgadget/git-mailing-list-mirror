Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB101F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeAZScc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:32:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:59042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751212AbeAZScc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:32:32 -0500
Received: (qmail 15505 invoked by uid 109); 26 Jan 2018 18:32:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:32:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17344 invoked by uid 111); 26 Jan 2018 18:33:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:33:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:32:30 -0500
Date:   Fri, 26 Jan 2018 13:32:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 07/10] t: move 'test_i18ncmp' and 'test_i18ngrep' to
 'test-lib-functions.sh'
Message-ID: <20180126183229.GC27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-8-szeder.dev@gmail.com>
 <xmqq607o8ouy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq607o8ouy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 10:19:17AM -0800, Junio C Hamano wrote:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Both 'test_i18ncmp' and 'test_i18ngrep' helper functions are supposed
> > to be called from our test scripts, so they should be in
> > 'test-lib-functions.sh'.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
> >  t/test-lib.sh           | 26 --------------------------
> >  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> Hmph.  I do not care too much either way, but I had an impression
> that test-lib-functions.sh is meant to be more generic (i.e. those
> who want can steal it from us and use it in their project without
> dragging too much of the local convention we employ in this project)
> than what is in test-lib.sh, which can heavily be specific to Git,
> and I also had an impression that gettext-poison build is quite a
> local convention we use in this project, not applicable to other
> people.

I had a similar notion, but I thought it was the other way around:
test-lib.sh was supposed to be the harness, and test-lib-functions.sh
was our own stuff. But I do not think we have really kept to that over
the years. TBH I have generally been confused by the distinction and
just use ctags to find the right source file. ;)

-Peff

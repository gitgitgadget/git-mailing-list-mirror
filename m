Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617552036C
	for <e@80x24.org>; Wed,  4 Oct 2017 05:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdJDF0n (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 01:26:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:60042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750909AbdJDF0m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 01:26:42 -0400
Received: (qmail 9341 invoked by uid 109); 4 Oct 2017 05:26:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 05:26:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14942 invoked by uid 111); 4 Oct 2017 05:26:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 01:26:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 01:26:40 -0400
Date:   Wed, 4 Oct 2017 01:26:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH 2/3] http-push: fix construction of hex value from path
Message-ID: <20171004052640.3sxpluokhcyh4c2y@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-3-t.gummerer@gmail.com>
 <20171003225315.GE19555@aiede.mtv.corp.google.com>
 <20171003233638.fq6lgls2qsucfbn3@sigill.intra.peff.net>
 <xmqqbmlnecxd.fsf@gitster.mtv.corp.google.com>
 <xmqqy3orcwvu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3orcwvu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 02:20:05PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >>> Moreover, this is in the webdav-based "dumb http" push code path,
> >>> which I do not trust much at all.  I wonder if we could retire it
> >>> completely (or at least provide an option to turn it off).
> >>
> >> I would really like that, too. It has been the cause of a lot of pain
> >> when working with the smart code, and I am not at all surprised to find
> >> a bug of this magnitude lurking in it. I'd _hoped_ this could show that
> >> the system has been unusably broken for years, which would give us
> >> confidence to turn it off. :) But per your paragraph above, people could
> >> very easily still have been happily using it in the meantime.
> >
> > Same here.  Perhaps we should deliberately and silently break it and
> > see who screams?
> 
> Hopefully it should be obvious but just for people with unreasonable
> expectations, I should clarify that the above needs a smiley ;-).

Yes, I was surprised to see it without one. :)

More seriously, is there any interest in marking it as deprecated in the
release notes and issuing a warning when it's used for a few cycles?

-Peff

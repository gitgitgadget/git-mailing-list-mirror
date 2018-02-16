Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B681F404
	for <e@80x24.org>; Fri, 16 Feb 2018 19:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeBPT1b (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 14:27:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:55510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750864AbeBPT13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 14:27:29 -0500
Received: (qmail 18208 invoked by uid 109); 16 Feb 2018 19:27:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Feb 2018 19:27:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21353 invoked by uid 111); 16 Feb 2018 19:28:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Feb 2018 14:28:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Feb 2018 14:27:27 -0500
Date:   Fri, 16 Feb 2018 14:27:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180216192727.GA23249@sigill.intra.peff.net>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
 <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
 <20180215220952.GA23970@sigill.intra.peff.net>
 <xmqq606w7oht.fsf@gitster-ct.c.googlers.com>
 <20180216192541.GA22993@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216192541.GA22993@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 02:25:41PM -0500, Jeff King wrote:

> On Fri, Feb 16, 2018 at 10:55:58AM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > So a full proposal would support both cases: "check this out in the
> > > local platform's preferred encoding" and "always check this out in
> > > _this_ encoding". And Lars's proposal is just the second half of that.
> > 
> > Actually, what you seem to take as a whole is just half of the
> > story.  The other half that is an ability to say "what is in the
> > repository for this path is stored in this encoding".  I agree that
> > "check it out in this encoding" is a useful thing to have, and using
> > the in-tree .gitattributes as a place to state the project-wide
> > preference may be OK (and .git/info/attributes should be able to
> > override it if needed -- this probably deserves to be added to a
> > test somewhere by this series).
> 
> If we are just talking about a check-out feature, I'm not sure that the
> in-repository encoding is all that interesting. As with CRLFs, we would
> be declaring UTF-8 as the "canonical" in-repo encoding for such
> conversions. Is there a reason you'd want something else?

Maybe answering my own question: because your encoding of choice does
not round-trip to UTF-8?

In which case yeah, I could see choosing an in-repo encoding to possibly
be useful (but it also seems like a feature that could easily be tacked
on later if somebody cares).

-Peff

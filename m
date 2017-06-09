Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E487A1FAEB
	for <e@80x24.org>; Fri,  9 Jun 2017 05:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbdFIFgr (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 01:36:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:36944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdFIFgq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 01:36:46 -0400
Received: (qmail 1177 invoked by uid 109); 9 Jun 2017 05:36:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 05:36:46 +0000
Received: (qmail 18785 invoked by uid 111); 9 Jun 2017 05:36:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 01:36:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jun 2017 01:36:44 -0400
Date:   Fri, 9 Jun 2017 01:36:44 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: There are too many unreachable loose objects
Message-ID: <20170609053643.k2skjxf55xtjty2q@sigill.intra.peff.net>
References: <CAE1pOi3bpL0zTS9w2QCOrXcWk5pHj=xthxo2nYi8KEwJ=TgXfA@mail.gmail.com>
 <CA+P7+xqWoUBOoFSiOTT5U-9aoqESUMnZeSGfvhGte2LqF18gmw@mail.gmail.com>
 <20170216225710.6nnbw65qoeb6lrw5@sigill.intra.peff.net>
 <987153C6-2F10-4229-8E59-B106604896DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <987153C6-2F10-4229-8E59-B106604896DF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 02:52:42PM +0200, Lars Schneider wrote:

> >> It may be that it's the server side that needs to git-prune, and not
> >> your local side? I'm not really certain but you're doing a push which
> >> talks to a remote server.
> > 
> > Yes, certainly the position in the output implies that. These days you
> > should see:
> > 
> >  remote: warning: There are too many...
> > 
> > to make it more clear. Perhaps the server is too old to have 860a2ebec
> > (receive-pack: send auto-gc output over sideband 2, 2016-06-05).
> 
> Do you know if GHE 2.9.4 has this fix? (Is it OK to ask this here?)
> Context: http://public-inbox.org/git/9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com/

It's probably not the best place to ask, as I don't think there is an
easy way to find the answer unless you have the GHE source code. But the
answer is no, it's in GHE 2.10.0.

Actually, I guess you could run "git version" on the GHE box; the
version numbers show the latest version of upstream Git that has been
merged. This particular commit is in Git v2.10.0 (coincidental to the
GHE version above; the versions are totally independent).

-Peff

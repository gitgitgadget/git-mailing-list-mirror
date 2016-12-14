Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D401FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 11:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbcLNLTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 06:19:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:56287 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755411AbcLNLTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 06:19:33 -0500
Received: (qmail 19972 invoked by uid 109); 14 Dec 2016 11:18:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 11:18:59 +0000
Received: (qmail 24046 invoked by uid 111); 14 Dec 2016 11:19:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 06:19:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 06:18:57 -0500
Date:   Wed, 14 Dec 2016 06:18:57 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>, Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add cppcheck target
Message-ID: <20161214111856.nhtq4l3ntrhy2fhv@sigill.intra.peff.net>
References: <20161213092225.15299-1-judge.packham@gmail.com>
 <20161213121510.5o5axuwzztbxcvfd@sigill.intra.peff.net>
 <CAFOYHZBRq=5FGswQZSYbn0JdrEv+xqLm6gdpD_nE+1L_CfPHEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFOYHZBRq=5FGswQZSYbn0JdrEv+xqLm6gdpD_nE+1L_CfPHEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 09:33:59PM +1300, Chris Packham wrote:

> > I do see a few real problems, but many false positives, too.
> > Unfortunately, one of the false positives is:
> >
> >   int foo = foo;
> 
> On I side note I have often wondered how this actually works to avoid
> the uninitialised-ness of foo. I can see how some compilers may be
> fooled into thinking that foo has been set but that doesn't actually
> end up with foo having a deterministic value.

Right, this is only used to shut up the compiler when it incorrectly
thinks the variable is uninitialized.

-Peff

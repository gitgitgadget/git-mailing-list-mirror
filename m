Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7081FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757815AbdJKSAS (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:00:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757803AbdJKSAS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:00:18 -0400
Received: (qmail 29016 invoked by uid 109); 11 Oct 2017 18:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Oct 2017 18:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8220 invoked by uid 111); 11 Oct 2017 18:00:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Oct 2017 14:00:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Oct 2017 14:00:15 -0400
Date:   Wed, 11 Oct 2017 14:00:15 -0400
From:   Jeff King <peff@peff.net>
To:     Ayush Goel <ayushgoel111@gmail.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: Unable to use --patch with git add
Message-ID: <20171011180015.mqn5xkj5z4yjdrhm@sigill.intra.peff.net>
References: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
 <20171011174952.almye3qa2tmyrmol@LykOS.localdomain>
 <CAEBs8jKAsb3B-6WJ=ptL2AsGvDRFVPYLCsztpdTN6KCBLOo1XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEBs8jKAsb3B-6WJ=ptL2AsGvDRFVPYLCsztpdTN6KCBLOo1XA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 11:25:52PM +0530, Ayush Goel wrote:

> On Wed, Oct 11, 2017 at 11:19 PM, Santiago Torres <santiago@nyu.edu> wrote:
> > It'd be helpful to know:
> >
> > - What did you do?
> 
> I have recently updated to git version 2.14.2. The problem started
> happening after that.
> Made changes to a file. Tried `git add -p`.

This is a known issue in v2.14.2 with having "color.ui" set to "always"
in your config.

There's a fix in v2.15.0-rc1. You can either upgrade to that, or as a
workaround set "color.ui" to "auto" (or remove it completely from your
config, as "auto" is the default).

-Peff

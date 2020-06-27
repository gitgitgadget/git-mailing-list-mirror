Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B4C433DF
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 03:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432172081A
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 03:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgF0DOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 23:14:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:44502 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgF0DOO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 23:14:14 -0400
Received: (qmail 13970 invoked by uid 109); 27 Jun 2020 03:14:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Jun 2020 03:14:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1286 invoked by uid 111); 27 Jun 2020 03:14:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jun 2020 23:14:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Jun 2020 23:14:12 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Craig H Maynard <chmaynard@me.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Regarding Git and Branch Naming
Message-ID: <20200627031412.GC1187031@coredump.intra.peff.net>
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
 <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
 <20200626203539.GA1173768@coredump.intra.peff.net>
 <CABPp-BE7y5YD4A+QTn-2Vu5aS8c_pzQ2096Y7GRqeOOSJKwJHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE7y5YD4A+QTn-2Vu5aS8c_pzQ2096Y7GRqeOOSJKwJHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 02:58:17PM -0700, Elijah Newren wrote:

> The error doesn't need to come that late; it could come at the "init"
> step when no branch name is specified.  If that's desirable, a
> necessary first step towards that would be making a plain "git init"
> throw a warning that we are creating a repo with a default branch name
> of <whatever> since the user didn't specify one.
> 
> Of course, we could decide to only take that first step and never
> escalate it to an error.  It'd still leave us with some default name,
> but would de-emphasize it some.
> 
> Not sure if I'm in favor of either of these ideas or not, but just
> thought I'd point out alternate possibilities towards
> removing/de-emphasizing the default initial branch name.

Yeah, I agree those are all possible options. My issue is that not
picking a default means the user is forced to do so before continuing,
which seems fundamentally unfriendly to me. It's putting more friction
between the user and their goal.

The warning version doesn't force that choice, but then I don't think
that's it really accomplished that much. We've still got to have a
default, and now we have an annoying warning on top. :)

-Peff

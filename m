Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4A020958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdCWTR0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:17:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:50468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbdCWTR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:17:26 -0400
Received: (qmail 13282 invoked by uid 109); 23 Mar 2017 19:17:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 19:17:24 +0000
Received: (qmail 9627 invoked by uid 111); 23 Mar 2017 19:17:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 15:17:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 15:17:21 -0400
Date:   Thu, 23 Mar 2017 15:17:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
Message-ID: <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
References: <20170322065612.18797-1-larsxschneider@gmail.com>
 <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231716320.3767@virtualbox>
 <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
 <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 12:12:15PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For instance, if it's in the environment, can I push up a branch that
> > does "set | grep GFW_CI_TOKEN", open a PR, and see it? I don't know the
> > answer.
> 
> I think the documentation said
> 
>     Variables defined in repository settings are the same for all
>     builds, and when you restart an old build, it uses the latest
>     values. These variables are not automatically available to
>     forks.
> 
> so we should be safe as long as we do not build against PRs.

I think we do build against PRs now. E.g.:

  https://travis-ci.org/git/git/builds/213896051

But it looks like we can turn that off.

> On the other hand, perhaps a contributor may want to build and test
> his own PR that may affect Windows platform, and such a contributor
> may be helped if the main repository sets things up to build against
> PRs.
> 
> I personally think it is a separate issue and we shouldn't set it up
> to build against PRs.  If Windows CI wants to help these
> contributors, it can give out the token to them, without relying on
> the travis setup for the main repository.

Hrm, it does mean that people have no way to test on Windows until the
branch hits pu. Which is not ideal.

-Peff

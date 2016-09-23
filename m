Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9161F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 04:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbcIWEqi (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 00:46:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:47023 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbcIWEqh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 00:46:37 -0400
Received: (qmail 28374 invoked by uid 109); 23 Sep 2016 04:46:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 04:46:37 +0000
Received: (qmail 14647 invoked by uid 111); 23 Sep 2016 04:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 00:46:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2016 00:46:34 -0400
Date:   Fri, 23 Sep 2016 00:46:34 -0400
From:   Jeff King <peff@peff.net>
To:     Luciano Schillagi <luko.web@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: error
Message-ID: <20160923044634.mkqyal4cgss5js2p@sigill.intra.peff.net>
References: <15EA3A56-BAE8-4FAF-B277-9628307899AF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15EA3A56-BAE8-4FAF-B277-9628307899AF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 08:02:35PM -0300, Luciano Schillagi wrote:

> please, what should I do to fix this error? thanks
> 
> Luko ~ $ git init
> error: malformed value for push.default: aguas
> error: Must be one of nothing, matching, simple, upstream or current.
> fatal: bad config variable 'push.default' in file '/Users/imac/.gitconfig' at line 16
> -bash: __git_ps1: command not found

Your config file has a bogus value in it.  Try:

  git config --global --unset push.default

Or you may want to simply edit /Users/imac/.gitconfig by hand. It is not
clear where the bogus value came from, but possibly the file is
corrupted in some way (so you are better off examining it first before
asking git to blindly change it).

-Peff

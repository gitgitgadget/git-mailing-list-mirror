Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B6F2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdBOV0M (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:26:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:55980 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdBOV0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:26:11 -0500
Received: (qmail 22745 invoked by uid 109); 15 Feb 2017 21:26:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:26:11 +0000
Received: (qmail 17568 invoked by uid 111); 15 Feb 2017 21:26:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:26:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:26:09 -0500
Date:   Wed, 15 Feb 2017 16:26:09 -0500
From:   Jeff King <peff@peff.net>
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: enhance git-add to avoid password being staged or committed?
Message-ID: <20170215212608.whrcgjfwycrrblx3@sigill.intra.peff.net>
References: <CAKkAvawFJwAcn_360O101vvtbUL3Cwfqx_8VLQg_PjWzFVwDVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkAvawFJwAcn_360O101vvtbUL3Cwfqx_8VLQg_PjWzFVwDVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 10:36:32PM +0800, ryenus wrote:

> This can be an optional feature, once enabled, git-add would check the
> hunk(s) to stage for sensitive information, such as passwords, secret
> tokens, then ask the user for confirmation.
> 
> The implementation for secret detection could be regexp pattern(s),
> and/or (trusted?) commands
> 
> Alternative solutions might be hooks during commit, push or recieve,
> but it should be the best to do this in the first place during git-add.

There are already hooks for commit and receive to catch things locally
and at publishing time, respectively. It's possible that an "add" hook
could be more useful, but I'd be a lot more convinced if people were
actively doing secret-detection in their commit hooks and had some
specific complaint that could be addressed by having an "add" hook.

-Peff

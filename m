Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231AEC48BC2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 00:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAADA61263
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 00:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFXAZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 20:25:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhFXAZb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 20:25:31 -0400
Received: (qmail 8757 invoked by uid 109); 24 Jun 2021 00:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 00:22:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8470 invoked by uid 111); 24 Jun 2021 00:23:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 20:23:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 20:23:12 -0400
From:   Jeff King <peff@peff.net>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Where does the variable GIT_HOSTING comes?
Message-ID: <YNPQcAnIh8APLFxk@coredump.intra.peff.net>
References: <CAGP6PO+hnvAdYuMKQG15-fhRVdDBCCn2xfnLP5=exPcs4GHJVQ@mail.gmail.com>
 <YNPPkQrK8PtPAr8C@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNPPkQrK8PtPAr8C@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 08:19:30PM -0400, Jeff King wrote:

> On Thu, Jun 24, 2021 at 07:30:29AM +0800, Hongyi Zhao wrote:
> 
> > On Ubuntu 20.04, see my following relevant git variables settings:
> > 
> > $ env |grep GIT
> > GIT_SSL_NO_VERIFY=1
> > GIT_HOSTING=git@git.domain.com
> > GIT_DISCOVERY_ACROSS_FILESYSTEM=true
> > 
> > I don't set the `GIT_HOSTING' variable at all. Then where does it come
> > from and what's the function of it?
> 
> This variable is neither set by nor respected by Git. It may be set by a
> system file, or perhaps a snippet you copied into your user setup at
> some point. Try:
> 
>   grep GIT_HOSTING ~/.bash* /etc/bash*
> 
> (that's not an exhaustive list of places the environment may get set up,
> but it contains the likely ones).

Looks like you might have "bash-it" set up:

  https://github.com/Bash-it/bash-it/search?q=GIT_HOSTING

-Peff

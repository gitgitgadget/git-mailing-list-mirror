Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C67A1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbcFPJ7v (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:59:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:55578 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753846AbcFPJ7u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:59:50 -0400
Received: (qmail 11154 invoked by uid 102); 16 Jun 2016 09:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:59:50 -0400
Received: (qmail 14941 invoked by uid 107); 16 Jun 2016 10:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 06:00:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:59:47 -0400
Date:	Thu, 16 Jun 2016 05:59:47 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Tauner <stefan.tauner@gmx.at>
Cc:	git@vger.kernel.org
Subject: Re: Un-paged commit messages in git filter-branch's commit-filter?
Message-ID: <20160616095947.GA15988@sigill.intra.peff.net>
References: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 13, 2016 at 08:28:18AM +0200, Stefan Tauner wrote:

> I am trying to do a major cleanup of the repository in one of my
> projects (and switch from git-svn to native git). I have developed a
> commit-filter script over the last months that massages partially
> dreadful commit messages into something acceptable. While I am not 100%
> sure I think that upgrading git has broken it partially. AFAICT since
> the update the commit-filter does not get the original message anymore
> but at least the subject/first paragraph is run through a pager or
> something similar:
> The first line is broken into multiple lines (i.e. some line breaks are
> inserted about every 72 characters where none have been before).

There are some output formats that will wrap lines, but by default,
filter-branch should not be using them (and I could not reproduce the
issue in a simple test). Can you show us what your commit-filter looks
like?

-Peff

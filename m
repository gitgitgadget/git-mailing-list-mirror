Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8913520357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755483AbdGKHij (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:38:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:36662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755270AbdGKHii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:38:38 -0400
Received: (qmail 28335 invoked by uid 109); 11 Jul 2017 07:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 07:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13712 invoked by uid 111); 11 Jul 2017 07:38:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 03:38:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 03:38:36 -0400
Date:   Tue, 11 Jul 2017 03:38:36 -0400
From:   Jeff King <peff@peff.net>
To:     kinchit raja <kinchit15@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Git checkout case Insensitive branch name compare
Message-ID: <20170711073836.3nclljuzqgwdg6t5@sigill.intra.peff.net>
References: <CAKvSMhhO7RwiZfpcLR3cK2TXF-v9MrO1N33t8BqX=8f9z=Gd0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKvSMhhO7RwiZfpcLR3cK2TXF-v9MrO1N33t8BqX=8f9z=Gd0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 01:15:40PM -0700, kinchit raja wrote:

> Bugs Details:
> 
> Git checkout case Insensitive branch name compare

Right, this is known. Branch names (and all ref names) are case
sensitive in Git. Storage on a case-insensitive filesystem may lead to
confusion if you mix the cases. Sometimes it will work, and sometimes it
will create quite confusing results. One suggested path forward is to
encode characters in the filesystem. See:

  http://public-inbox.org/git/20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net/

and further down-thread:

  http://public-inbox.org/git/xmqqo9sxdwjp.fsf@gitster.mtv.corp.google.com/

for some recent discussion.

-Peff

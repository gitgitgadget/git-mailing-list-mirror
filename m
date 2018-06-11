Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799261F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeFKVJm (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:09:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:41848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933194AbeFKVJl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:09:41 -0400
Received: (qmail 13596 invoked by uid 109); 11 Jun 2018 21:09:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 21:09:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18728 invoked by uid 111); 11 Jun 2018 21:09:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 17:09:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 17:09:38 -0400
Date:   Mon, 11 Jun 2018 17:09:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sean Hunt <seandhunt_7@icloud.com>, git@vger.kernel.org
Subject: Re: Where is git checkout --orphan implemented at.
Message-ID: <20180611210938.GA26235@sigill.intra.peff.net>
References: <2ED916AA-3E6A-4E22-9B9B-13C3B687B357@icloud.com>
 <20180605175435.GA22321@sigill.intra.peff.net>
 <xmqqa7s1cjkj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7s1cjkj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 10:35:40AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If you don't even have symbolic-ref handy, you can do:
> >
> >   echo "ref: refs/heads/new-branch" >.git/HEAD
> >
> > That's not generally recommended, since future versions of Git may
> > change the ref storage format, but it would work with any current
> > version of Git.
> 
> Makes one wonder if it really "works" if .git/HEAD was created by
> older version of Git or in a repository where prefer-symlink-refs is
> enabled, though ;-)

Heh, true. I guess "rm -f .git/HEAD" before would "fix" it.

-Peff

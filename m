Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9460B1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 22:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933231AbeAKWWD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 17:22:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:41642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933147AbeAKWWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 17:22:02 -0500
Received: (qmail 25552 invoked by uid 109); 11 Jan 2018 22:21:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 22:21:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26884 invoked by uid 111); 11 Jan 2018 22:22:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 17:22:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 17:21:55 -0500
Date:   Thu, 11 Jan 2018 17:21:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Andreas G. Schacker" <andreas.schacker@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc/read-tree: remove obsolete remark
Message-ID: <20180111222155.GA13570@sigill.intra.peff.net>
References: <20180109153034.22970-1-andreas.schacker@gmail.com>
 <20180111104914.GA5897@sigill.intra.peff.net>
 <xmqqbmi0z0b7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmi0z0b7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 11:02:04AM -0800, Junio C Hamano wrote:

> >> ---prefix=<prefix>/::
> >> +--prefix=<prefix>::
> >>  	Keep the current index contents, and read the contents
> >>  	of the named tree-ish under the directory at `<prefix>`.
> >>  	The command will refuse to overwrite entries that already
> >> -	existed in the original index file. Note that the `<prefix>/`
> >> -	value must end with a slash.
> >> +	existed in the original index file.
> >
> > Is it worth mentioning in the new world order that the slash is not
> > implied? I.e., that you probably do want to say "--prefix=foo/" if you
> > want the subdirectory "foo", but do not want to match "foobar"?
> 
> Doesn't "git read-tree --prefix=previous HEAD^" add paths like
> "previous/Documentation/Makefile" to the index, i.e. instead of
> forcing you to have the required slash at the end, we give one for
> free when it is missing?

Yes, I think it does what you'd want with that path. But it would not do
what you want by adding "previous-file". Which seems like a gotcha that
should be mentioned.

-Peff

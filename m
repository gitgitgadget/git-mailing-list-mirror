From: Jeff King <peff@peff.net>
Subject: Re: [Opinions] Integrated tickets
Date: Thu, 6 Nov 2014 00:53:48 -0500
Message-ID: <20141106055348.GC22835@peff.net>
References: <20141105124429.GF15384@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 06:53:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmG14-00028d-4H
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 06:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbaKFFxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 00:53:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:37180 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750902AbaKFFxt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 00:53:49 -0500
Received: (qmail 21298 invoked by uid 102); 6 Nov 2014 05:53:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Nov 2014 23:53:49 -0600
Received: (qmail 31882 invoked by uid 107); 6 Nov 2014 05:53:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Nov 2014 00:53:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Nov 2014 00:53:48 -0500
Content-Disposition: inline
In-Reply-To: <20141105124429.GF15384@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 05, 2014 at 01:44:29PM +0100, Fredrik Gustafsson wrote:

> So my question is:
> 
> what's your opinions on building an integrated ticket system on top of git?

I think it's a nice concept, but there have been several
implementations, and AFAIK none of them is incredibly popular. I do not
know offhand if the problem is the concept or the implementations (I
looked at them long ago but don't remember enough to provide any sort of
reasonable critique).

I started to assemble a list of pointers, but I realized that 4 out of 5
of the projects that I had looked at a few years ago no longer exist. ;)

Here's an article from last year with a nice overview of the (non-)state
and links to other sources:

  https://www.stationary-traveller.eu/distributed-bug-trackers.html

> and (maybe mostly for Junio)
> 
> Would such system possible be included in git.git?

I am not Junio, but I would have to say: probably not. This seems like
something that can very easily sit on _top_ of git and use the git
plumbing. In the long-term git may want to grow features to make
integration more seamless, but we'd probably want to add them in a more
functionality-agnostic way (e.g., don't grow an option to attach bug
information to a commit; grow an option to attach arbitrary information
to a commit. We already have this part in the form of "git notes", but
there are likely other opportunities for integration).

-Peff

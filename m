From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] filter-branch: add new --blob-filter option.
Date: Fri, 13 Jun 2008 02:25:46 -0400
Message-ID: <20080613062546.GD26768@sigill.intra.peff.net>
References: <1213318344-26013-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 08:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72ka-0008OF-2a
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 08:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYFMGZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 02:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYFMGZt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 02:25:49 -0400
Received: from peff.net ([208.65.91.99]:1204 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbYFMGZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 02:25:48 -0400
Received: (qmail 29938 invoked by uid 111); 13 Jun 2008 06:25:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 02:25:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 02:25:46 -0400
Content-Disposition: inline
In-Reply-To: <1213318344-26013-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84840>

On Thu, Jun 12, 2008 at 08:52:22PM -0400, Avery Pennarun wrote:

> It was easy enough to work up the patch below, which allows
> 
>   git filter-branch --blob-filter 'tr a-z A-Z'

First, two procedural complaints:

  1. We're supposed to be in rc freeze, so this is not a great time to
     publish a new feature. ;)

  2. When bringing back an old patch, please please please give at least
     a little bit of cover letter context. "Here is what happened last
     time, here are the reasons this patch was not accepted before, and
     here is {why I think it that decision was wrong, what I have done
     to improve the patch, etc}.

IIRC, the situation last time had two issues:

  1. it was a one-off "we're not sure if this is really useful" patch

  2. it was unclear whether paths should be available, and if they were,
     there was an issue of encountering the same hash at two different
     paths.

I assume your answer to '1' is "I have been using this and it is
useful". And for '2', it looks like you have extended the cache
mechanism to take into account the sha1 and the path, which I think is
the right solution (and I am pleased to see it looks like the final test
covers the exact situation I was concerned about).

So:

(for 1/3):
Signed-off-by: Jeff King <peff@peff.net>

(for the others (and for 1/3, do I get to ack my own patch?)):
Acked-by: Jeff King <peff@peff.net>

-Peff

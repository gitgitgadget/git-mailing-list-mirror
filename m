From: Jeff King <peff@peff.net>
Subject: Re: Strange, can't push
Date: Wed, 22 Apr 2009 11:39:51 -0400
Message-ID: <20090422153951.GB12881@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE04E4@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 17:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LweZq-0006zR-9B
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 17:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbZDVPj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 11:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbZDVPj4
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 11:39:56 -0400
Received: from peff.net ([208.65.91.99]:50795 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbZDVPjz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 11:39:55 -0400
Received: (qmail 16125 invoked by uid 107); 22 Apr 2009 15:40:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 11:40:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 11:39:51 -0400
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE04E4@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117207>

On Tue, Apr 21, 2009 at 05:21:15PM -0400, John Dlugosz wrote:

> Locally, the view in gitk, after fetching, is that branch B is one
> commit ahead of remotes/pub/B.  But doing a push doesn't advance it.
> Pushing to another label did get it there, under that name.

It's possible that the remote _is_ up-to-date, and your tracking refs
are simply behind.  Did you try fetching? If so, are you sure your fetch
refspec will update the tracking ref appropriately?

Through what protocol are you pushing? Only the git protocol will
update local tracking refs on push; http will not.

How are you invoking push? Are you using the remote name, so that it can
find the tracking ref (pushing directly to the URL, even if you have a
remote matching that URL, will not update tracking refs).

Finally, what version of git are you using? Recent versions of send-pack
will update tracking refs for pushed _and_ up-to-date refs, but versions
prior to 1.6.0.4 would only do so for things that actually got pushed.

-Peff

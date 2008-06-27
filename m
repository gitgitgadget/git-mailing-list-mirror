From: Jeff King <peff@peff.net>
Subject: Re: bug related to branches using / in name
Date: Thu, 26 Jun 2008 23:04:23 -0400
Message-ID: <20080627030422.GB7144@sigill.intra.peff.net>
References: <1214509350.28344.31.camel@odie.local> <20080627030245.GA7144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>
X-From: git-owner@vger.kernel.org Fri Jun 27 05:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC4H3-0006Gl-Jt
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 05:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYF0DEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 23:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYF0DEZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 23:04:25 -0400
Received: from peff.net ([208.65.91.99]:1657 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbYF0DEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 23:04:25 -0400
Received: (qmail 31306 invoked by uid 111); 27 Jun 2008 03:04:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 23:04:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 23:04:23 -0400
Content-Disposition: inline
In-Reply-To: <20080627030245.GA7144@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86518>

On Thu, Jun 26, 2008 at 11:02:46PM -0400, Jeff King wrote:

> So to summarize, the problem is that you have an old tracking branch
> "refs/remotes/sched" that exists on the client, but upstream has since
> removed it in favor of "sched/devel", which you are now trying to fetch.
> And of course there is a conflict, because of the ref naming rules.
> 
> This doesn't work seamlessly because git-fetch never removes old
> tracking branches, even if they have been deleted upstream. And normally
> there is no conflict; leaving the old branches means they don't
> disappear from under you.

BTW, you can get the opposite problem, too. If you have
"refs/remotes/origin/foo/bar", and then the remote removes "foo/bar" in
favor of "foo", you will have a conflict on fetch.

-Peff

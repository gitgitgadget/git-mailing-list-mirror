From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Thu, 25 Aug 2011 16:23:26 -0400
Message-ID: <20110825202326.GC6165@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075232.GJ12341@sigill.intra.peff.net>
 <7vr55k4mxn.fsf@alter.siamese.dyndns.org>
 <20110722204749.GC11922@sigill.intra.peff.net>
 <7vbowmx9da.fsf@alter.siamese.dyndns.org>
 <20110722221337.GA15753@sigill.intra.peff.net>
 <87d3g1k3u6.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 22:23:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwgSd-0001iG-5p
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab1HYUXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:23:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46757
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab1HYUX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:23:29 -0400
Received: (qmail 18601 invoked by uid 107); 25 Aug 2011 20:24:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 16:24:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 16:23:26 -0400
Content-Disposition: inline
In-Reply-To: <87d3g1k3u6.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180109>

On Fri, Aug 19, 2011 at 07:01:21AM -0500, Ted Zlatanov wrote:

> I see some info in "What's Cooking" about this patch but it's unclear to
> me whether the hostname issue (where it's hard to have multiple
> identities on a single server, which I think is all right) is blocking
> the inclusion of the patch into the next release, or if it will be
> included eventually if no one complains about that issue, or something
> else...

Junio and I discussed it a bit in another thread. I think the ability to
use "user@hostname" to disambiguate means the problem is dealt with at a
high level. And the "cache" helper handles that just fine. But the
"store" helper will conflate two entries for the same host. I'll see if
I can work on a patch for that.

It looks like Junio is planning to hold the series off until 1.7.8. Have
you been working on a Secrets API helper? If so, I'd love to get
feedback on how well the interface is serving your needs.

-Peff

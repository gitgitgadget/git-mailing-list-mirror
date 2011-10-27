From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] credential-cache--daemon.c: Don't leave stale socket
 on --exit
Date: Thu, 27 Oct 2011 10:42:08 -0700
Message-ID: <20111027174208.GB1967@sigill.intra.peff.net>
References: <4EA2FC63.9060602@ramsay1.demon.co.uk>
 <20111022191711.GC1785@sigill.intra.peff.net>
 <4EA9950A.9020208@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTy3-0003TD-UM
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab1J0RmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:42:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56730
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab1J0RmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 13:42:11 -0400
Received: (qmail 3801 invoked by uid 107); 27 Oct 2011 17:47:58 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 13:47:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 10:42:08 -0700
Content-Disposition: inline
In-Reply-To: <4EA9950A.9020208@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184307>

On Thu, Oct 27, 2011 at 06:29:46PM +0100, Ramsay Jones wrote:

> Jeff King wrote:
> > On Sat, Oct 22, 2011 at 06:24:51PM +0100, Ramsay Jones wrote:
> > 
> >> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> >> ---
> >>  credential-cache--daemon.c |   23 ++++++++++++-----------
> >>  1 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > Looks sane, and I'll probably squash it in. Alternatively, we could also
> > set a signal/exit handler to clean up our socket when we die. That would
> > also cover the error exit cases.
> 
> I considered this, *very* briefly, but decided it wasn't worth the effort
> or complexity.

Actually, I think with the sigchain code, it would only end up as a few
lines. I'll probably take a look when I re-roll.

Thanks for your patches.

-Peff

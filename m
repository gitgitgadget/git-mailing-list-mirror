From: Jeff King <peff@peff.net>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment
 variables sets putty = true
Date: Wed, 22 Apr 2015 19:23:06 -0400
Message-ID: <20150422232306.GA32705@peff.net>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
 <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
 <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
 <20150422202910.GB26917@peff.net>
 <20150422211915.GB827497@vauxhall.crustytoothpaste.net>
 <20150422212904.GA32043@peff.net>
 <20150422214445.GC827497@vauxhall.crustytoothpaste.net>
 <20150422220053.GA32268@peff.net>
 <20150422222455.GA274681@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl3z8-0002NV-R1
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758512AbbDVXXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:23:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:48952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756573AbbDVXXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 19:23:09 -0400
Received: (qmail 31174 invoked by uid 102); 22 Apr 2015 23:23:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 18:23:09 -0500
Received: (qmail 15427 invoked by uid 107); 22 Apr 2015 23:23:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 19:23:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 19:23:06 -0400
Content-Disposition: inline
In-Reply-To: <20150422222455.GA274681@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267651>

On Wed, Apr 22, 2015 at 10:24:55PM +0000, brian m. carlson wrote:

> On Wed, Apr 22, 2015 at 06:00:54PM -0400, Jeff King wrote:
> > Yeah, that looks right to me. You might want to represent the "are we
> > tortoise" check as a separate flag, though, and reuse it a few lines
> > later.
> 
> Sounds like a good idea.  I'll send a more formal patch a bit later
> today.

Thanks.

> > Also, not related to your patch, but I notice the "putty" declaration is
> > in a different scope than I would have expected, which made me wonder if
> > it gets initialized in all code paths. I think is from the recent
> > addition of CONNECT_DIAG_URL, which pushes the bulk of the code into its
> > own else clause, even though the first part of the "if" always returns
> > early.  I wonder if it would be simpler to read like:
> [...]
> 
> I can drop this in as a preparatory patch if I can have your sign-off.

Definitely, thanks.

Signed-off-by: Jeff King <peff@peff.net>

-Peff

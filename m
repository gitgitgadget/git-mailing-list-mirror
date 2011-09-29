From: Jeff King <peff@peff.net>
Subject: Re: Annotated branch =?utf-8?B?4omIIGFu?= =?utf-8?Q?notated?= tag?
Date: Thu, 29 Sep 2011 02:44:04 -0400
Message-ID: <20110929064404.GA14022@sigill.intra.peff.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <4E7C49CF.60508@drmicha.warpmail.net>
 <20110923201824.GA27999@sigill.intra.peff.net>
 <4E7DEC4A.3050900@drmicha.warpmail.net>
 <20110927215843.GE5176@sigill.intra.peff.net>
 <4E82A13B.2080509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 29 08:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9ALt-0000bV-EL
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 08:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab1I2GoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 02:44:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47919
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab1I2GoI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 02:44:08 -0400
Received: (qmail 17274 invoked by uid 107); 29 Sep 2011 06:49:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Sep 2011 02:49:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2011 02:44:04 -0400
Content-Disposition: inline
In-Reply-To: <4E82A13B.2080509@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182386>

On Wed, Sep 28, 2011 at 06:23:23AM +0200, Michael Haggerty wrote:

> It seems to me that an annotated branch is very much like an (unsigned)
> annotated tag, except that it is movable and disposable like a normal
> branch.  What would be the ramifications of using an annotated-tag-like
> object to record metainformation about a branch?  (Let's just call it an
> "annotation object" for this discussion.)
> 
> * The branch would point not at a commit but at an annotation object
> that points at a commit.
> 
> * Obviously, a new annotation object would have to be written every time
> the branch is updated.

Leaving aside for a moment whether this is a good system or not, I think
it's infeasible at this point simply because it is so far from what
current git does, and in such a visible way.

Consider the interactions between this system and older versions of git.
Won't all of the older clients see this annotation cruft at the tip of
each branch? How will they react? It would no longer be correct to make
commits with "git commit-tree $tree `git rev-parse HEAD`", would it?

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Wed, 10 Dec 2014 02:11:19 -0500
Message-ID: <20141210071119.GA18104@peff.net>
References: <5485D03F.3060008@fu-berlin.de>
 <20141209141457.GA18544@peff.net>
 <CAFY1edaEG040jnfTJA4G9a0bAkFJHc3N5sHjtwOOdXmndsu9YQ@mail.gmail.com>
 <20141209161133.GA17756@peff.net>
 <CAFY1edY=Ren9krK1-yFoxt92AAushUyqnbt=69hdXMeiBFAK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Scherer <m.scherer@fu-berlin.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 08:11:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XybQk-0002qM-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 08:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbaLJHLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 02:11:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:50900 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753054AbaLJHLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 02:11:22 -0500
Received: (qmail 20648 invoked by uid 102); 10 Dec 2014 07:11:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 01:11:22 -0600
Received: (qmail 7079 invoked by uid 107); 10 Dec 2014 07:11:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 02:11:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 02:11:19 -0500
Content-Disposition: inline
In-Reply-To: <CAFY1edY=Ren9krK1-yFoxt92AAushUyqnbt=69hdXMeiBFAK=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261190>

On Tue, Dec 09, 2014 at 10:15:31PM +0000, Roberto Tyley wrote:

> > Not that I expect you to want to work on filter-branch. :) But maybe
> > food for thought for a BFG feature.
> 
> I haven't heard much demand for a recover/restore feature on the BFG
> (I think by the time people get to the BFG, they're pretty sure they
> want to go ahead with the procedure!) but I'll bear it in mind. Mind
> you, to make the post-rewrite clean-up easier, I'd be happy to
> contribute a patch that gives 'gc' a flag to do the equivalent of:
> 
> git reflog expire --expire=now --all && git gc --prune=now --aggressive
> 
> Maybe:
> 
> git gc --purge

Yeah, that is common enough that it might be worthwhile (you probably
want --expire-unreachable in the reflog invocation, though).

-Peff

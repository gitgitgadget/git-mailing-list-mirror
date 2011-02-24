From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 11:09:33 -0500
Message-ID: <20110224160932.GC30275@sigill.intra.peff.net>
References: <20110224112246.3f811ac2@glyph>
 <4D6672F7.4020101@drmicha.warpmail.net>
 <20110224154908.GA29309@sigill.intra.peff.net>
 <4D667F1A.5060408@drmicha.warpmail.net>
 <20110224160027.GA30275@sigill.intra.peff.net>
 <4D6680F3.1000205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:09:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psdl5-0003Og-Qs
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab1BXQJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:09:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306Ab1BXQJe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 11:09:34 -0500
Received: (qmail 25495 invoked by uid 111); 24 Feb 2011 16:09:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 16:09:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 11:09:33 -0500
Content-Disposition: inline
In-Reply-To: <4D6680F3.1000205@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167832>

On Thu, Feb 24, 2011 at 05:01:55PM +0100, Michael J Gruber wrote:

> >> - hom. interface: allow "-a pathspec" for commit
> > 
> > What would it do? It would just behave like "git commit -i
> > pathspec"?
> 
> It should do what "-u pathspec" does for add: limit "all tracked" to the
> pathspec. I know it's the same as without "-a", but why bail out on it?

Without "-a", we do "git commit -o", which is slightly different with
respect to stuff in the index.  In the case of:

  git add -u <path> && git commit

we will add new changes from <path>, and then commit them along with
whatever was already in the index.

With:

  git commit <path>

We will commit _just_ the changes in <path>, regardless of what is in
the index.

I assumed that:

 git commit -a <path>

would behave more like the "git add -u <path>" case; add new stuff to
the index from <path>, and then commit those changes plus whatever was
already in the index.

> I've done all the careful planning already, laid out in nice steps. Now
> it's your time ;)

Heh. Transitioning to management, I see.

-Peff

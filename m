From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 14:36:43 -0500
Message-ID: <20110216193643.GB22045@sigill.intra.peff.net>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net>
 <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net>
 <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 <20110216095415.GA12578@sigill.intra.peff.net>
 <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com>
 <20110216100622.GA12971@sigill.intra.peff.net>
 <7vpqqrke30.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 20:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpnBE-0005kA-BU
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 20:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab1BPTgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 14:36:47 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab1BPTgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 14:36:46 -0500
Received: (qmail 13227 invoked by uid 111); 16 Feb 2011 19:36:45 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 19:36:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Feb 2011 14:36:43 -0500
Content-Disposition: inline
In-Reply-To: <7vpqqrke30.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166992>

On Wed, Feb 16, 2011 at 10:51:31AM -0800, Junio C Hamano wrote:

> > OK, so how precious is it? :)
> 
> The world is not that black-and-white, but is full of different shades of
> gray.
> 
> If you made mistakes with a second "git add", you can "reset --mixed"
> everything away and restart from scratch.  The same thing can be said for
> a mistaken "git commit -a" that can be "reset HEAD^" (or --amend).  So
> there is not much difference at the technical level.

Sure. The problem there is that "scratch" may involve losing some work
you did picking apart changes.

> I don't think this is primarily about "protecting the index".  It is more
> about making the user feel better.  Compared to a mistaken second "add", a
> mistaken "commit -a" feels like a lot heavier point-of-no-return.

I guess. I have very occasionally run into the second-add problem and
wanted to be able to return to an earlier index state, but I admit it
doesn't come up that much. I just see them as the same problem.

I think I am also a little turned off by the config option solution
because it seems very un-git to me. Our usual approach is to give the
user a lot of flexibility, let them shoot their own foot off, and then
let them know that their intact foot is waiting in the reflog, ready to
be sewn back on.

Yes, we try to limit uselessly destructive actions before they happen.
But this is not one of those cases. The exact command set that is being
listed as dangerous is also part of a very reasonable workflow. It just
depends on what the user's intention was.

But as I said, I am not against a config option if it is such a common
problem. I certainly would not turn it on. And I don't think it should
be on by default.

-Peff

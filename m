From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 14:48:55 -0500
Message-ID: <20110216194855.GC22045@sigill.intra.peff.net>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net>
 <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net>
 <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 <20110216095415.GA12578@sigill.intra.peff.net>
 <vpqbp2cmfy6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 16 20:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpnN5-0006YM-5H
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 20:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab1BPTtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 14:49:01 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49695 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab1BPTtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 14:49:00 -0500
Received: (qmail 13360 invoked by uid 111); 16 Feb 2011 19:48:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 19:48:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Feb 2011 14:48:55 -0500
Content-Disposition: inline
In-Reply-To: <vpqbp2cmfy6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166993>

On Wed, Feb 16, 2011 at 11:28:17AM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So? Your question was whether index state is precious. If it's precious,
> > shouldn't we be keeping a history of it?
> 
> If it's really precious, it probably means you should be commit
> --amend instead. You'd get the reflog, and essentially the same
> functionalities.

Yeah, that is good advice, and I do actually end up doing a lot of
intermediate commits and then either amending or sorting them out at the
end. And that helps with sorting out big changes.

But it does sort of feel like saying "we don't need a safety valve. You
just need to back up your work before doing anything dangerous". I have
to remember to do it. Which is fine if my workflow is
add-amend-add-amend. But maybe I have some half-saved index state and I
am about to try doing a merge checkout or stash apply.

Anyway, I'm not convinced it is all that precious (at least not enough
to merit working on the reflog). Yes, there have been times I've wished
I could go back to the index state of a minute ago, and had to re-sort
changes. But it usually doesn't take all that much time (thanks to "git
add -p"). My main objection is that I just don't see those cases as
different from "git commit -a". Either it is worth protecting, or it
isn't.

-Peff

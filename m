From: Jeff King <peff@peff.net>
Subject: Re: Qgit performance and maintain CVS environment with GIT
	repository
Date: Thu, 18 Oct 2007 20:41:59 -0400
Message-ID: <20071019004159.GB3290@coredump.intra.peff.net>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <47159779.6010502@bluelane.com> <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com> <200710171800.37345.robin.rosenberg.lists@dewire.com> <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com> <4717EF40.6000509@bluelane.com> <Pine.LNX.4.64.0710190054570.25221@racer.site> <4717F8CF.9060103@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Pete/Piet Delaney <pete@bluelane.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iifxd-00021d-KM
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758560AbXJSAmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbXJSAmD
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:42:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1463 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbXJSAmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:42:03 -0400
Received: (qmail 5874 invoked by uid 111); 19 Oct 2007 00:42:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 20:42:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 20:41:59 -0400
Content-Disposition: inline
In-Reply-To: <4717F8CF.9060103@bluelane.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61584>

On Thu, Oct 18, 2007 at 05:22:39PM -0700, Pete/Piet Delaney wrote:

> I've got root access on the CVS server and want to switch to git without
> disturbing the environment more than is necessary to make the switch.
> I think developers will want to us git and git-cvsserver looks like
> the more likely desirable path.

Depending on the environment and the willingness of people to change to
git, it might be worth moving slowly and keeping the backend as CVS at
first.  I.e., keep the "official" repository as CVS, and let some devs
start moving to access through git-cvsimport and git-cvsexportcommit
(and maybe even provide an official git repo which is backed by the CVS
repo, so that all of the import/export happens in one place).  That will
give them time to get used to git, give those who are resistant to the
change their original interface, and if anything goes wrong, you can
always fall back to the "old" way.

And then when everything seems to be going well, swap it. Make git the
official repo, but provide a "legacy" CVS access for the die-hards
(using git-cvsserver).

And then eventually just shut off CVS access entirely (when everyone is
happier using git).

Of course none of that is necessary, but one of the nice things about
git is how it can integrate with existing setups, so you can really ease
into a transition without investing a lot of resources.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Mon, 2 Feb 2009 08:16:11 -0500
Message-ID: <20090202131611.GB8487@sigio.peff.net>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de> <20090130050925.GA18809@coredump.intra.peff.net> <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de> <20090130162258.GA7065@sigill.intra.peff.net> <alpine.DEB.1.00.0901301804030.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 02 14:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTyhE-0003va-RK
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 14:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbZBBNQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 08:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbZBBNQA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 08:16:00 -0500
Received: from peff.net ([208.65.91.99]:43189 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbZBBNQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 08:16:00 -0500
Received: (qmail 8543 invoked by uid 1000); 2 Feb 2009 13:16:11 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901301804030.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108082>

On Fri, Jan 30, 2009 at 06:05:30PM +0100, Johannes Schindelin wrote:

> > I think the right thing to do is:
> > 
> >   1. factor out "generic" routines from send-pack, including status
> >      output formatting and tracking ref updating
> > 
> >   2. refactor http-push to use those routines, bringing it in line with
> >      send-pack
> > 
> >   3. add --track support in the same generic way, and hook it from both
> >      transports
> 
> Now we're thinking along the same lines!

OK, good.

> > I can try to work on this, but I'm not excited about major surgery to 
> > http-push, which I don't have a working test setup for.
> 
> You don't have an apache installed?

No, though "apt-get install apache" is easy enough. I was more concerned
about wading through the mess of apache configuration to turn on webdave
support. But that is just my empty grumbling and complaining; it's not a
real stumbling block to doing this patch.

And when I wrote that, I was fully intending to pick up this topic and
work on the steps outlined above.

_But_.

It looks like the consensus is to add a branch.master config section
even when cloning an empty repo. And that should address my concern in
the 99% of cases where people use the default "master" setup. Which kind
of takes away the main use case for this topic.

So it doesn't make much sense to me to put effort into it now.  The
http-push cleanups might be nice for http-push users, but I don't
remember even seeing a single user request or complaint about it. So I
am not too keen to go cleaning up code that _I_ don't care about, and
that I am not sure anyone _else_ even cares about.

-Peff

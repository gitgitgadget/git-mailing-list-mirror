From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Tue, 20 Jan 2009 19:15:51 -0500
Message-ID: <20090121001551.GB18169@coredump.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQmV-0006lN-3D
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbZAUAPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756875AbZAUAPy
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:15:54 -0500
Received: from peff.net ([208.65.91.99]:51835 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371AbZAUAPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:15:53 -0500
Received: (qmail 5592 invoked by uid 107); 21 Jan 2009 00:15:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 19:15:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 19:15:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901210105470.19014@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106546>

On Wed, Jan 21, 2009 at 01:10:22AM +0100, Johannes Schindelin wrote:

> > Hmm. I suppose that would work, since every test run is trying to create 
> > the same state.
> 
> Yep, that's what I meant with "no race".

Right, but it is still possible to screw it up, if your creation process
does a delete-create. But it looks like you did it correctly in your
patch (try to create, and if you fail because it's there, assume it's
right).

> Heh.  Okay.  I was convinced that your valgrind patch predated my -j<n> 
> patch...

I think I did an early version that did predate it, but then another
round afterwards.

> In any case, I already found a bug in the nth_last series, thanks to your 
> work, which I'll send in a minute.

Yay! It's nice when infrastructure work like this actually pays off.

Thanks for picking up this topic...I can drop the size of my
ever-growing git todo list by one. :)

-Peff

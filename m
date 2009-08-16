From: Jeff King <peff@peff.net>
Subject: Re: How to stop sharing objects between repositories
Date: Sun, 16 Aug 2009 08:28:43 -0400
Message-ID: <20090816122842.GA942@sigill.intra.peff.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 14:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcerh-00032n-Ab
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 14:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbZHPM2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 08:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbZHPM2o
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 08:28:44 -0400
Received: from peff.net ([208.65.91.99]:51493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbZHPM2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 08:28:43 -0400
Received: (qmail 24693 invoked by uid 107); 16 Aug 2009 12:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 16 Aug 2009 08:28:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Aug 2009 08:28:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126056>

On Sun, Aug 16, 2009 at 10:43:11AM +0200, Johannes Schindelin wrote:

> > If there's a better or built-in way to do this with Git tools, I'd like 
> > to learn it, and I'd be happy to update the wiki accordingly.
> 
> I think what you need is done by
> 
> 	git repack -l
> 
> (I agree it is not well documented, and I'd welcome a documentation 
> patch.)

I think it is the opposite; packing _without_ "-l" will create a pack
with objects from the alternate; using "-l" suppresses them. Running
"git repack -a" should do the trick, I believe (and you need the "-a" to
ensure that objects already packed in the repo are re-packed).

-Peff

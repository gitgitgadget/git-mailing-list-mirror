From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 17:37:28 -0400
Message-ID: <20060629213728.GB15604@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain> <20060629185335.GA6704@coredump.intra.peff.net> <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain> <20060629195201.GA10786@coredump.intra.peff.net> <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:38:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4Dh-0000TU-2k
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWF2Vh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWF2Vhp
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:37:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:7880 "HELO
	peff.net") by vger.kernel.org with SMTP id S932758AbWF2Vh3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 17:37:29 -0400
Received: (qmail 11097 invoked from network); 29 Jun 2006 17:37:07 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 17:37:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 17:37:28 -0400
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22911>

On Thu, Jun 29, 2006 at 04:24:01PM -0400, Nicolas Pitre wrote:

> > Obviously the kernel repo is doing better, but x=500 is only 4 days ago.
> > Trying with --before=2.weeks.ago yields only 31505 matches.
> 
> What does this prove?  I fail to see the relation between those results 
> and a possible git-pack-objects improvement.

My point is that the window cache gets invalidated over time, whereas a
sha1 by sha1 cache doesn't.  However, the point is moot, as I think
Linus has come up with a much better solution.

> The negative delta cache concept is certainly attractive even for normal 
> repositories, especially for public servers, since when used in 
> conjonction with delta reuse it makes the creation of a pack basically 
> free.  So I think this idea really has merits, as long as the cache 
> remains small.

Yes, if you're talking about a situation in which you make many packs
for a given set of commits, then it does make more sense (what I was
really trying to eliminate was a 10 minute repack followed by another 10
minute repack to push to the server).

-Peff

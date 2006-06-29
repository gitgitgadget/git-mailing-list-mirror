From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:58:00 -0400
Message-ID: <20060629185759.GB6704@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <20060629035849.GA30749@coredump.intra.peff.net> <Pine.LNX.4.64.0606291154510.1213@localhost.localdomain> <20060629180719.GB4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291444370.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 20:58:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1iI-0005Sb-Ir
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWF2S6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWF2S6D
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:58:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11966 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751270AbWF2S6B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 14:58:01 -0400
Received: (qmail 4938 invoked from network); 29 Jun 2006 14:57:39 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 14:57:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 14:58:00 -0400
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291444370.1213@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22890>

On Thu, Jun 29, 2006 at 02:48:23PM -0400, Nicolas Pitre wrote:

> Dare to test it?  I provided you with most of the code difference 
> already.

See my other mail. Unless I did something horribly wrong, caching full
windows is largely useless.

> And what do you mean by "semantically correct"?

I mean that right now the cache means "calling create_delta on content
that has sha1_a against content that has sha1_b will not produce a
useful delta." That makes sense since the content is never going to
change for a given sha1. However, covering the whole window takes into
account depth and preferred base. We just need to be sure that it is
correct to be including those in our cache calculation (I don't know,
and I'll defer to your judgement on that, since you clearly know more
about the delta logic than I do).

-Peff

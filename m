From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sun, 29 Jul 2007 07:38:51 -0400
Message-ID: <20070729113850.GA17796@coredump.intra.peff.net>
References: <20070729002427.GA1566@coredump.intra.peff.net> <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org> <20070729041159.GA5544@coredump.intra.peff.net> <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org> <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> <7vwswjmu08.fsf@assigned-by-dhcp.cox.net> <20070729094955.GA14915@coredump.intra.peff.net> <Pine.LNX.4.64.0707291214060.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 13:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF76u-0003lQ-Pv
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 13:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761554AbXG2Lix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 07:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761479AbXG2Lix
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 07:38:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4754 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761402AbXG2Lix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 07:38:53 -0400
Received: (qmail 27604 invoked from network); 29 Jul 2007 11:38:53 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 11:38:53 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2007 07:38:51 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707291214060.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54106>

On Sun, Jul 29, 2007 at 12:14:49PM +0100, Johannes Schindelin wrote:

> How about
> 
> 	if (!rev.diffopt.quiet)
> 		rev.diffopt.recursive = 1;
> 
> instead?

Can you explain?

My assumption is that you want the diff machinery to exit as quickly as
possible. But the "recursive" option is _already_ turned on for most
output formats in that case, so I had assumed that it was the quiet
option itself which caused the early return, not a failure to set
"recursive".

If you don't want recursive set for quiet runs, I think there is an
error in diff.c, which sets the output format from quiet to NO_FORMAT
only _after_ having set recursive based on the output format.

-Peff

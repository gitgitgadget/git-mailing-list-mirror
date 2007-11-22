From: Jeff King <peff@peff.net>
Subject: Re: Temporary directories getting errantly added into trees
Date: Thu, 22 Nov 2007 06:16:00 -0500
Message-ID: <20071122111600.GF10389@sigill.intra.peff.net>
References: <4744FCD9.7020102@vilain.net> <Pine.LNX.4.64.0711221052280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvA2k-0005t8-RW
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbXKVLQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbXKVLQE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:16:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3528 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbXKVLQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:16:03 -0500
Received: (qmail 22525 invoked by uid 111); 22 Nov 2007 11:16:01 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 06:16:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 06:16:00 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711221052280.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65791>

On Thu, Nov 22, 2007 at 10:55:00AM +0000, Johannes Schindelin wrote:

> While we're at it, could we change the name so that it is .git/rebase, and 
> not .dotest or .git/.dotest-merge?

I totally agree.

> Yes, I know, existing tools could rely on the location.  But then, I do 
> not think that tools should be allowed to be _that_ married to particular 
> implementations.  And indeed, I see no reason why a tool should access 
> .dotest, except for accessing .dotest/patch, and then it will be very 
> obvious where it fails.

Another reason might be something like:

  test -d .dotest && die "rebase or am already in progress"

which some of the git tools do, and which third party scripts might care
about.

-Peff

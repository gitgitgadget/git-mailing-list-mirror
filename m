From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff --check: use colour
Date: Thu, 25 Jan 2007 23:31:20 -0500
Message-ID: <20070126043120.GA6111@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6tkdnee.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vk5za925w.fsf@assigned-by-dhcp.cox.net> <17849.13327.527531.262943@lisa.zopyra.com> <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17849.17947.645022.282882@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 05:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAIkK-0004hi-NI
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 05:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030741AbXAZEbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 23:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030743AbXAZEbY
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 23:31:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2722 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030741AbXAZEbX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 23:31:23 -0500
Received: (qmail 9216 invoked from network); 25 Jan 2007 23:31:44 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 25 Jan 2007 23:31:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jan 2007 23:31:20 -0500
Content-Disposition: inline
In-Reply-To: <17849.17947.645022.282882@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37795>

On Thu, Jan 25, 2007 at 06:06:51PM -0600, Bill Lear wrote:

> >The easiest way to find out what it does is to execute:
> >	git log -S--check diff.c
> 
> Hmm, using 1.5.0-rc2, I created a test repo, and did this:

I think you misunderstood Johannes. The -S option is used to find
revisions that include the given string in their changes. So he was
suggesting running that command in the _git_ repository, to show you the
commit that introduced the --check option (from which you would get some
material for writing the docs...)

> echo foo > foo
> git add foo
> git commit -a -m foo
> echo bar > foo
> git commit -a -m bar
> git log -S--check foo
> 
> and nothing happened.

Right. You never put the word --check into your repository content. :)

> git log -S --check foo
> 
> and the thing went off into outer space.  Now at over 2 1/2 minutes of
> CPU time on my 2 Ghz Opteron box...

This appears to be a bug. I will look into it.

-Peff

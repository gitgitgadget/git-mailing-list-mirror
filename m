From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Temporary directories getting errantly added into trees
Date: Thu, 22 Nov 2007 11:32:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221130510.27959@racer.site>
References: <4744FCD9.7020102@vilain.net> <Pine.LNX.4.64.0711221052280.27959@racer.site>
 <20071122111600.GF10389@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:33:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAJ3-0002q5-Ig
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbXKVLdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbXKVLdA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:33:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:44200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751719AbXKVLdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:33:00 -0500
Received: (qmail invoked by alias); 22 Nov 2007 11:32:58 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp020) with SMTP; 22 Nov 2007 12:32:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lEhJYUS1lPovqatx2H6ranwBJYb4QBNeK9BLmut
	oJdItAi7WFjOLj
X-X-Sender: gene099@racer.site
In-Reply-To: <20071122111600.GF10389@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65801>

Hi.

On Thu, 22 Nov 2007, Jeff King wrote:

> On Thu, Nov 22, 2007 at 10:55:00AM +0000, Johannes Schindelin wrote:
> 
> > Yes, I know, existing tools could rely on the location.  But then, I 
> > do not think that tools should be allowed to be _that_ married to 
> > particular implementations.  And indeed, I see no reason why a tool 
> > should access .dotest, except for accessing .dotest/patch, and then it 
> > will be very obvious where it fails.
> 
> Another reason might be something like:
> 
>   test -d .dotest && die "rebase or am already in progress"
> 
> which some of the git tools do, and which third party scripts might care 
> about.

Yep, for example this nice bash-completion addendum which changes the 
prompt according to the current repository's state.

I hope that a symlink .dotest -> .git/rebase (as I suggested in a reply to 
Martin) would help that, but in the long run I'd appreciate losing even 
that.

Ciao,
Dscho

P.S.: note that even a symlink would already help the situation described 
by Sam.

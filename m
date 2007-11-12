From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix rev-list when showing objects involving submodules
Date: Mon, 12 Nov 2007 21:25:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711122124500.4362@racer.site>
References: <Pine.LNX.4.64.0711112335020.4362@racer.site> <4738AF60.90207@vilain.net>
 <Pine.LNX.4.64.0711122020270.4362@racer.site>
 <alpine.LFD.0.9999.0711121231570.3062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:26:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgnT-0003Um-HS
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbXKLVZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbXKLVZi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:25:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:41780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751961AbXKLVZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:25:37 -0500
Received: (qmail invoked by alias); 12 Nov 2007 21:25:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 12 Nov 2007 22:25:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ApDAA7w5AzOThAXdBGRlg1gXCsk8FNKCVVcNB9D
	VpeV37t1GuEExd
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0711121231570.3062@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64710>

Hi,

On Mon, 12 Nov 2007, Linus Torvalds wrote:

> On Mon, 12 Nov 2007, Johannes Schindelin wrote:
> > 
> > You mean something like
> > 
> > 		else if (S_ISREG(entry.mod) || S_ISLNK(entry.mod))
> > 
> > Hmm?  Sure, I have no preference there.
> 
> Maybe more along the line of something like this?
> 
> In general, I suspect we should try to start moving away from using the 
> "S_ISLNK()" like things for internal git state. It was a mistake to just 
> assume the numbers all were same across all systems in the first place.
> 
> So this just converts to the "object_type", and then uses a case 
> statement.

Sure.  Just add the test from my patch, and we're fixed.

Ciao,
Dscho

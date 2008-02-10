From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 01:29:30 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100127160.11591@racer.site>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <alpine.LSU.1.00.0802100110450.11591@racer.site> <alpine.LFD.1.00.0802091720010.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO11B-0001Bh-Ad
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYBJB32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYBJB32
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:29:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:59009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751202AbYBJB31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:29:27 -0500
Received: (qmail invoked by alias); 10 Feb 2008 01:29:26 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 10 Feb 2008 02:29:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18t97ReTdItGzgm9QGpt1Q/pM4xtPalHgAPKyidA6
	khvHz1IMG13gix
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802091720010.2896@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73286>

Hi,

On Sat, 9 Feb 2008, Linus Torvalds wrote:

> On Sun, 10 Feb 2008, Johannes Schindelin wrote:
> > 
> > I was thinking the other night why I did not like the generation 
> > header.  And I found out why: it is redundant information.
> 
> Actually, that's not the real issue.
> 
> The real issue is that it doesn't work. I thought about it, and with 
> multiple roots (which _can_ get merged together) it just isn't something 
> that actually helps.

I don't see it.  If G(c) >= 1 + max(G(c^) | c^ is a parent of c), then it 
_should_ work.  And then, I think it is _much_ better to just cache it 
locally (if you care enough about it, i.e. if you set a certain config 
option that triggers possibly expensive one-shot caching) than have it in 
the commit object (where the information could be just plain wrong).

Ciao,
Dscho

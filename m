From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 15:39:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021537490.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
 <vpq4pji3zwm.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021315510.14781@racer.site>
 <vpqir7y15sr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:39:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGbqF-0001SB-4J
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 16:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbXHBOju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbXHBOju
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 10:39:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:60733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753500AbXHBOjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 10:39:48 -0400
Received: (qmail invoked by alias); 02 Aug 2007 14:39:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 02 Aug 2007 16:39:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Nd884uTmN389mvOT39+/SJQD59tOHPXnESjO/0s
	CoE2vNOJx+418w
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqir7y15sr.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54553>

Hi,

On Thu, 2 Aug 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I fully agree that git should be optimized for the common case. But
> >> even for the common case, I also find the feature strange. You didn't
> >> answer that part of my message, but I still fail to see a rationale
> >> for making "git-diff; git-status" different from "git-status; git-diff".
> >
> > For performance reasons, git always compares the files' stat information 
> > with that stored in the index.
> 
> I know that, but how does it answer the part of my message that you
> are citing?

You _acknowledge_ that git is optimized for performance!  And therefore 
you should also acknowledge that you _throw that away_ if you let your 
index go out of sync.

> > So when you do "git diff" and it tells you all those diff lines, while no 
> > file was really changed, it tells you "get your act together!  You just 
> > _willfully_ slowed down git's performance".
> 
> The question remains: why should someone running git-diff get this,
> and someone running git-status not get this?

Because git-status is an index-updating operation.  That's why.

Ciao,
Dscho

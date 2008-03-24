From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-init: set receive.guardCurrentBranch = true for
 non-bare repositories
Date: Mon, 24 Mar 2008 23:31:34 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803242329550.4353@racer.site>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site> <alpine.LSU.1.00.0803232144070.4353@racer.site> <7v4pax3r6l.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241158301.4353@racer.site> <7v4pawvzgg.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803241807210.4353@racer.site> <alpine.LNX.1.00.0803241714520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:32:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvDM-0005Du-Ke
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbYCXWbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYCXWbj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:31:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:60047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753537AbYCXWbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 18:31:38 -0400
Received: (qmail invoked by alias); 24 Mar 2008 22:31:34 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp015) with SMTP; 24 Mar 2008 23:31:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+3V5F3YL+XU3QCgVxgLGWJqwZoZ0+57gKu7BUdX
	Lf/ezVab7raKeU
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803241714520.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78111>

Hi,

On Mon, 24 Mar 2008, Daniel Barkalow wrote:

> On Mon, 24 Mar 2008, Johannes Schindelin wrote:
> 
> > How about
> > 
> > 	receive.localBranches = (refuse | allow)
> > 
> > with a default "allow"?  Then we could add more rope later with the 
> > "update" option, which would run "git read-tree -u -m HEAD" if the 
> > current branch is updated, and simply allow all other branches being 
> > updated.
> 
> The use cases I've seen for pushing into a non-bare repository seem to 
> be cases in which "refs/heads/" isn't really local; it's only updated by 
> push from elsewhere, and it's named "refs/heads/" because that's where 
> public branches are served from. This suggests we could have:
> 
> 	core.noLocalBranches: true
> 
> with the implications:
> 
>  - it's definitely okay to push to refs/heads/
>  - HEAD is always detached.
> 
> That seems to me to accurately describe a repository used to hold 
> branches for public consumption and where there's a work tree for 
> testing and building, rather than development. (I.e., work tree 
> operations only read the repository.)

Funny.  I thought bare repositories were meant for public consumption.  
And for testing, you still can have a (non-public) repository with a 
work-tree.

I'd rather not try to tell users that it is okay to mix the two.

Ciao,
Dscho

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Non-http dumb protocols
Date: Sun, 1 Jul 2007 14:47:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707011444300.14638@iabervon.org>
References: <Pine.LNX.4.64.0706301613410.14638@iabervon.org>
 <7vbqewakz8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707011527590.4438@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 20:47:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I54SQ-0001E4-5m
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 20:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbXGASrf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 14:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbXGASrf
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 14:47:35 -0400
Received: from iabervon.org ([66.92.72.58]:1061 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381AbXGASre (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 14:47:34 -0400
Received: (qmail 8334 invoked by uid 1000); 1 Jul 2007 18:47:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Jul 2007 18:47:33 -0000
In-Reply-To: <Pine.LNX.4.64.0707011527590.4438@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51318>

On Sun, 1 Jul 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 30 Jun 2007, Junio C Hamano wrote:
> 
> > Having said that, I have a feeling that many people do not build
> > any of the commit walkers, and especially the http walker,
> > because they have no need for dumb protocols, and libcurl-dev is
> > just another piece of dependency they do not have to have.
> 
> Interestingly, I just was involved in a discussion on IRC, where somebody 
> (out of quotat concerns) wants to use sftp to push to a bare repository, 
> which is served via HTTP.
> 
> Unfortunately, it seems that all persons wanting to have some support for 
> that, expect others to do the work for them.
> 
> However, there is a miniscule non-zero chance that eventually somebody 
> might want to realise an sftp push protocol (where you basically need the 
> ls-remote part of the fetcher, too, to determine what to pack and send). 
> And to complete a dumb sftp fetch protocol, you'd need a commit walker,
> so I'd like to have at least a minimal interface for commit walkers 
> waiting for that saviour.

Okay, I think I'll go for ditching ssh-fetch/-push, making the 
commit-walker code more modular, and possibly moving more of the smarts of 
http-fetch into the common code so that local-fetch is a better test for 
it and sftp fetch would be possible.

	-Daniel
*This .sig left intentionally blank*

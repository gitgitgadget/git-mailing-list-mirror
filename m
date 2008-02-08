From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 23:14:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082312520.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802081905580.11591@racer.site> <foihu9$110$1@ger.gmane.org> <alpine.LSU.1.00.0802082151570.11591@racer.site> <20080208220356.GA22064@glandium.org> <alpine.LSU.1.00.0802082234170.11591@racer.site>
 <20080208225024.GA26975@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 00:15:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNcR2-0001g6-35
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 00:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbYBHXOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYBHXOf
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 18:14:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:51337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751630AbYBHXOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 18:14:34 -0500
Received: (qmail invoked by alias); 08 Feb 2008 23:14:32 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp050) with SMTP; 09 Feb 2008 00:14:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wdzYaF9Bwz8AysUmQ2q7CTLlLfrfkt5lBLR+l2F
	Q172tAOt9zAkgq
X-X-Sender: gene099@racer.site
In-Reply-To: <20080208225024.GA26975@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73172>

Hi,

On Fri, 8 Feb 2008, Mike Hommey wrote:

> On Fri, Feb 08, 2008 at 10:34:55PM +0000, Johannes Schindelin wrote:
> 
> > On Fri, 8 Feb 2008, Mike Hommey wrote:
> > 
> > > Also note that the http transport uses info/http-alternates for 
> > > http:// urls. By the way, it doesn't make much sense that only 
> > > http-fetch uses it.
> > 
> > I think it does make sense: nobody else needs http-alternates.
> 
> If you're setting an http-alternate, it means objects are missing in the 
> repo. If they are missing in the repo and are not in alternates, how can 
> any other command needing objects out there work on the repo ?

The point is: if you have a bare repository on a server that uses 
alternates, that path stored in info/alternates is usable by git-daemon.  
But it is not usable by git-http-fetch, since that does not have a 
git-aware server side.  So if you want to reuse the _same_ bare repository 
_with_ alternates for both git:// transport and http:// transport, you 
_need_ to _different_ alternates: one being a path on the server, and 
another being an http:// url for http-fetch.

Hth,
Dscho

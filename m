From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 19:23:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509141901020.23242@iabervon.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
 <Pine.LNX.4.63.0509121633480.23242@iabervon.org> <43284368.8010004@citi.umich.edu>
 <Pine.LNX.4.63.0509141214490.23242@iabervon.org> <43287ECB.8090308@citi.umich.edu>
 <Pine.LNX.4.63.0509141622340.23242@iabervon.org> <4328A3F9.1010506@citi.umich.edu>
 <Pine.LNX.4.58.0509141549270.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chuck Lever <cel@citi.umich.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 01:19:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFgX6-0005ev-Ff
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 01:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVINXTN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVINXTN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 19:19:13 -0400
Received: from iabervon.org ([66.92.72.58]:12805 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965092AbVINXTM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 19:19:12 -0400
Received: (qmail 9155 invoked by uid 1000); 14 Sep 2005 19:23:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 19:23:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509141549270.26803@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8574>

On Wed, 14 Sep 2005, Linus Torvalds wrote:

> On Wed, 14 Sep 2005, Chuck Lever wrote:
> > 
> > oh, i see.  the hash table won't help cache_find_name find an insertion 
> > point quickly if the name isn't already in the cache.
> 
> Note that almost all insertion tends to happen linearly.
> 
> In particular, read-tree always inserts things in order.

read-tree (with Chuck's latest work) should actually only append entries 
to an initially-empty list, which is even easier. Dunno about the other 
stuff, but I'd guess inserting into a cursor would handle a lot of it.

	-Daniel
*This .sig left intentionally blank*

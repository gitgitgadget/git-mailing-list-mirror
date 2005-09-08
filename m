From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Multi-ancestor read-tree notes
Date: Thu, 8 Sep 2005 17:39:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509081727560.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
 <1126199765.3984.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 23:38:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDU3k-0005Oe-Jx
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 23:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVIHVfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 17:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVIHVfu
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 17:35:50 -0400
Received: from iabervon.org ([66.92.72.58]:10508 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965010AbVIHVft (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 17:35:49 -0400
Received: (qmail 32024 invoked by uid 1000); 8 Sep 2005 17:39:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Sep 2005 17:39:47 -0400
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1126199765.3984.1.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8220>

On Thu, 8 Sep 2005, Darrin Thompson wrote:

> On Mon, 2005-09-05 at 01:41 -0400, Daniel Barkalow wrote:
> > I've got a version of read-tree which accepts multiple ancestors and does 
> > a merge using information from all of them.
> 
> Do the multiple ancestors have to share a common parent? More to the
> point, is this read-tree any more friendly to baseless merges?

read-tree doesn't care about the relationships between its inputs; it's 
only interested in the trees. But using ancestors which aren't common is 
unlikely to give you desired results. I think, if you do read-tree a^ b^ a 
b, you will get everything into the index, but it'll all going to be 
conflicts.

I assume that what you want is something to include everything from two 
commits, which would give conflicts if a name is reused?

	-Daniel
*This .sig left intentionally blank*

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Bug in merge-base
Date: Tue, 19 Apr 2005 19:07:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504191853310.30848-100000@iabervon.org>
References: <20050419223420.GF9305@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 01:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1kL-00017Q-8J
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVDSXHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDSXHP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:07:15 -0400
Received: from iabervon.org ([66.92.72.58]:40709 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261735AbVDSXHJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:07:09 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DO1oQ-00003N-00; Tue, 19 Apr 2005 19:07:22 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419223420.GF9305@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Petr Baudis wrote:

> Dear diary, on Wed, Apr 20, 2005 at 12:17:12AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> 
> > I can think of. Are you sure there isn't another path to 5b53d3?
> 
> I'm not. Actually there well might be.
> 
> I think merge-base should never take a path which is effectively
> "upside-down" when a straight "upside" one is available.
> 
> Hmm. So what I depended on for merge-base was that when doing it on A
> and B and A is predecessor of B, then it will always just return A.  I
> will perhaps need to abuse rev-tree somehow for this then, it looks.

It is currently optimizing for the shortest longer path, but I guess it
should optimize for the shortest shorter path (i.e., the 0-length path
from A to itself always wins).

On the other hand, the date-based comparison (which you'd get with the
version I sent yesterday with [2/4] and [4/4]) would give you the most
recent common ancestor, which would necessarily avoid this situation.

Do you want to go with the date-based approach, or should I work out a 
shortest shorter path algorithm?

	-Daniel
*This .sig left intentionally blank*


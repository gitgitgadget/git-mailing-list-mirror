From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: unseeking?
Date: Sun, 24 Apr 2005 14:38:42 -0700
Message-ID: <20050424213841.GD11094@tumblerings.org>
References: <20050424180116.GC11094@tumblerings.org> <Pine.LNX.4.21.0504241418190.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 23:36:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPom0-0002Ht-G8
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVDXVky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVDXVky
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:40:54 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:61094 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262442AbVDXVkK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 17:40:10 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DPooM-0007ua-1Q; Sun, 24 Apr 2005 14:38:42 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504241418190.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2005 at 02:47:30PM -0400, Daniel Barkalow wrote:
> On Sun, 24 Apr 2005, Zack Brown wrote:
> > 4) In normal work-flow, when would forks be created, as opposed to other ways
> > of getting a tree?
> 
> I have a tree that I want to modify, but I want to keep the original, and
> I may want to update the original from an upstream source (and then sync
> my work with it).

So why not just do 'git init URL' to get the upstream sources, make your edits,
do 'git pull' to track the upstream sources every once in awhile, and do 'git
diff' when you're ready to send your changes to the upstream maintainer.

I think I've understood your explanation of what's actually happening, but I
still don't see its significance. What do you get from a fork that you don't get
from a regular old init and pull?

Be well,
Zack

> I start with the original:
> 
>   cd original
>   git init URL
>   git addremote remote-source URL
>   git track remote-source
> 
> I make my own working directory:
> 
>   git fork my-changes ../my-changes
>   cd ../my-changes
> 
> Then I do my changes, and commit whenever I feel like I've gotten
> somewhere (or when I think I'm about to mess something up and might want
> to undo changes). Periodically, I check on the mainline:
> 
>   cd ../original
>   git pull
> 
> I also merge changes from the mainline:
> 
>   cd ../my-changes
>   git merge remote-source
> 
> When I'm done, I make a patch for my work:
> 
>   cd ../my-changes
>   git patch remote-source
> 
> I generally then fork the original again, split the patch, apply each
> section in the new fork, committing after each one, generate patches for
> each of these commits, and send those out. Then I discard my old branch
> and continue from the new one. If, at some point, all of the changes I
> want to keep have been put into the mainline, I discard all my branches
> and fork again from the mainline.
> 
> (My personal style is to discard the history of how the changes got made
> in favor of the history of how the changes got into the mainline, since I
> don't really need to keep all of my debugged mistakes that nobody else
> saw.)
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown

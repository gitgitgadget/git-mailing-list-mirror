From: Petr Baudis <pasky@suse.cz>
Subject: Unnamed branches
Date: Thu, 28 Jul 2005 21:19:59 +0200
Message-ID: <20050728191959.GB24948@pasky.ji.cz>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <200507282053.56786.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 21:27:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyE1L-00048L-V3
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 21:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVG1TZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVG1TVO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 15:21:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37394 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262133AbVG1TUB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 15:20:01 -0400
Received: (qmail 32075 invoked by uid 2001); 28 Jul 2005 19:19:59 -0000
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200507282053.56786.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 08:53:56PM CEST, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> told me that...
> So why not put the name of the remote repository into the local branch name?
> A remote branch "host1:path#branch1" could be named "host1:path#branch1".
> The shorthand specified with "cg-add-branch" would be a local alias, i.e.
> 	(cd .git/refs/heads; ln -s host1:path#branch1 mylocalalias)
> 
> I even would find it handy to be able to say
> 	cg-pull host1:path#branch1
> , and
> 	cg-push mylocalbranch host2:path#branch2
> should create the alias "mylocalbranch"="host2:path#branch2"
> and create a entry in .git/branches.

  This is a sensible argument, and I initially disallowed this mainly to
save some work. ;-) But I agree that something like this would be nice.
The issues:

  * How to name the unnamed branches? You need some way to normalize
URLs like http://www.kernel.org/pub/s%63m//cogito/ to something which is
unique for a given location (http://www.kernel.org/pub/scm/cogito) and
usable as filename - at least substituting the slashes for something,
like underscores, and encoding underscored by % sequences.

  * Have all named remote branches as symlinks to their URLs (thus
effectively also eliminating the need for .git/branches/), or keep them
as they are? One disadvantage of the symlinks is that the refs/
directory would become quite messy.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox

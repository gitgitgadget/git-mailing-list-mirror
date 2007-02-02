From: Nicolas Pitre <nico@cam.org>
Subject: Re: Instructions concerning detached head lead to lost local changes
Date: Fri, 02 Feb 2007 02:14:07 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702020206480.3021@xanadu.home>
References: <87mz3xa3vr.wl%cworth@cworth.org>
 <7v1wl9mj48.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702012135550.3021@xanadu.home>
 <20070202065949.GI18880@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 02 08:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCsdn-0000wT-0B
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 08:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993AbXBBHOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 02:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422982AbXBBHOf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 02:14:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40387 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422971AbXBBHOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 02:14:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCT0014HQRJQ6E0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Feb 2007 02:14:08 -0500 (EST)
In-reply-to: <20070202065949.GI18880@thunk.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38468>

On Fri, 2 Feb 2007, Theodore Tso wrote:

> On Thu, Feb 01, 2007 at 09:49:27PM -0500, Nicolas Pitre wrote:
> > It might be some work to get to a given position with a detached head 
> > and this very position might be valuable information, but if you then do 
> > "checkout HEAD^" you will still be detached but your previous position 
> > is lost just like it would be if you moved to master.  Yet you're not 
> > prevented from going to HEAD^ but you are prevented from going to 
> > master.
> 
> Exactly.  With Junio's reasoning, then why aren't we forcing -f in this sequence:
> 
> git checkout HEAD^
> git checkout HEAD^^
> git checkout HEAD^^^
> git checkout -f master
> 
> The first three are just as likely to "lose" information as the last.
> Personally, I don't think any of this is "losing" information, any
> more than I "lose" information in the following sequence of commands:
> 
> cd /usr/src/linux/drivers/net
> cd /usr/src/linux/drivers/char
> cd /usr/src/linux/fs/ext3
> cd /home/tytso
> 
> The current working directory is just like the detached HEAD.  If I'm
> moving it around, there is no loss of data.  cd != rm.

It's just that moving around amongst thousands of commits to pin point a 
particular commit might require some digging work.  This is why there 
might be some value in a particular position and why there is an attempt 
at protecting that "work".

But since moving to another position while still remaining detached from 
any branch has the same potential for losing the important position and 
so without any kind of protection then it makes no sense to have such a 
protection when moving back to a branch.


Nicolas

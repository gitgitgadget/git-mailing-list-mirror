From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git-prune-script eats data
Date: Thu, 23 Jun 2005 01:25:01 -0400
Message-ID: <42BA47AD.3000508@pobox.com>
References: <42B8B629.1040208@pobox.com> <Pine.LNX.4.58.0506221857410.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 07:19:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlK7Q-0007Jn-K7
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 07:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVFWFZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 01:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVFWFZT
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 01:25:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10930 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262186AbVFWFZD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 01:25:03 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlKD1-00035w-4L; Thu, 23 Jun 2005 05:25:03 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221857410.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> And now I realize what the problem is. It's _not_ that "git prune" has 
> removed too much, like the obvious implication would be: it's that "git 
> prune" has not removed _enough_.

Makes a lot of sense.  Looking at the repo, I did indeed forget to copy 
the tags.


> So the trivial fix is to just remove the lines from fsck-cache.c that say
> 
> 	/* Don't bother with tag reachability. */
> 	if (obj->type == tag_type)
> 		continue;
> 
> and that will fix it for you.

Sounds good, thanks.


> It's exactly the same thing that Jens had. You have a tag object for the 
> v2.6.11-tree thing, but you don't have the reference to the tag.

Ref email just sent:  Kernel hackers expect tags to come with the pull. 
  Four kernel hackers, and counting.

Just accept that our brains are wired that way ;-)  We like having 
Linus-blessed-and-pushed-to-kernel.org tags from linux-2.6.git public 
tree follow us around.

	git-pull-script --tags $url

should accomplish that.

	Jeff



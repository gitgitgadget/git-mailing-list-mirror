From: Len Brown <lenb@kernel.org>
Subject: Re: merge weirdness
Date: Fri, 13 Jun 2008 01:00:33 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806130049420.8340@localhost.localdomain>
References: <alpine.LFD.1.10.0806130028080.8340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 08:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72MO-0000yx-Nw
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 08:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYFMGBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 02:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYFMGBJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 02:01:09 -0400
Received: from vms173001pub.verizon.net ([206.46.173.1]:42009 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYFMGBI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 02:01:08 -0400
X-Greylist: delayed 3622 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jun 2008 02:01:08 EDT
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2D00LHDXWZ1ML4@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 13 Jun 2008 00:00:35 -0500 (CDT)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id m5D50Y5T015750; Fri,
 13 Jun 2008 01:00:34 -0400
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id m5D50Xj2015745;
 Fri, 13 Jun 2008 01:00:34 -0400
In-reply-to: <alpine.LFD.1.10.0806130028080.8340@localhost.localdomain>
X-X-Sender: lenb@localhost.localdomain
X-Authentication-warning: localhost.localdomain: lenb owned process doing -bs
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84837>


On Fri, 13 Jun 2008, Len Brown wrote:

> I merged about a dozen small branches earlier this week and sent the batch 
> to Linus, who pulled them upstream with 
> da50ccc6a0f32ad29c1168837330a78e6e2e2923
> 
> I pulled Linus' tree and then went to compare which of my branches had 
> made it upstream, and my topic branches "git.status" script (pasted 
> below) said that none of them had!
> 
> Looking at Linus' history, it seems that my merge is gone.  Instead there 
> is a series of patches that look like they've been cherry-picked -- same 
> commit but different commit id.
> 
> I run the top-of-tree version of git.
> Did something strange happen with git a few days ago in this department?
> 
> I still had my merge in command history so I checked out an old branch and 
> did the same merge using today's git (git version 1.5.6.rc2.26.g8c37)
> and gitk shows it as an octopus, as expected.

I think I figured out what happened.

I prepared the original history, as shown in the commit-id's
in this shortlog:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.26/acpi-release-20080321-2.6.26-rc5.diff.bz2

Then some time passed and Linus pushed a few more things
into his tree.

I figured I'd merge with his latest to avoid any last minute merge
conflicts for him.

But instead of "git pull" to merge linus into release, for some reason I 
did a "git rebase linus release" -- which re-checked in my commits
and flattened all of my branches into a random sequence of patches.

I'll not do that again...

sorry for the noise.

thanks,
-Len

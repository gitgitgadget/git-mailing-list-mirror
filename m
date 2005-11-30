From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 13:11:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511301302310.25300@iabervon.org>
References: <20051130001503.28498.qmail@science.horizon.com>
 <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, junkio@cox.net, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 19:34:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhWPf-0001r4-Hm
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 19:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVK3SKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 13:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVK3SKg
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 13:10:36 -0500
Received: from iabervon.org ([66.92.72.58]:34061 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751493AbVK3SKf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 13:10:35 -0500
Received: (qmail 30100 invoked by uid 1000); 30 Nov 2005 13:11:06 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Nov 2005 13:11:06 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13010>

On Tue, 29 Nov 2005, Linus Torvalds wrote:

> If we left things in the index in an unmerged state, we'd be guaranteed to 
> either _fail_ that git commit unless somebody has done the 
> git-update-index (or names the files specifically on the commit command 
> line, which will do it for you).

At this point, we could have a "git-merged-by-hand" script that would take 
filenames, check that they're unmerged now, and, if so, call 
git-update-index for them. And it could have a -a to do all of the 
unmerged entries (i.e., "I'm done merging by hand"), and maybe also have a 
flag to git-commit that does this, so you can say, "Commit the merge I did 
by hand, whatever filenames it used, but not any other changes I may have 
had beforehand."

The "merged-by-hand" script would probably be a sensible place to complain 
about leftover conflict markers (unless you force it).

	-Daniel
*This .sig left intentionally blank*

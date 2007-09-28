From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Merge non-first refs that match first refspec
Date: Fri, 28 Sep 2007 01:12:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709280108060.5926@iabervon.org>
References: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
 <20070928041509.GU3099@spearce.org> <Pine.LNX.4.64.0709280026240.5926@iabervon.org>
 <20070928044824.GV3099@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 07:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib896-0004Nj-T5
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 07:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbXI1FMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 01:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbXI1FMF
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 01:12:05 -0400
Received: from iabervon.org ([66.92.72.58]:53648 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbXI1FME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 01:12:04 -0400
Received: (qmail 25453 invoked by uid 1000); 28 Sep 2007 05:12:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 05:12:02 -0000
In-Reply-To: <20070928044824.GV3099@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59365>

On Fri, 28 Sep 2007, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > Beats me; Junio, what's your test case?
> 
> If I understood him correctly it is this:
> 
> 	mkdir foo; cd foo; git init
> 	git config remote.origin.url git://repo.or.cz/alt-git.git
> 	git config remote.origin.fetch refs/heads/master:refs/remotes/origin/master
> 	git config --add remote.origin.fetch refs/heads/maint:refs/remotes/origin/maint
> 	git pull
> 
> We should see "master" listed in .git/FETCH_HEAD as a "for-merge"
> and "maint" listed as a "not-for-merge"...
> 
> But if that remote.origin.fetch was a wildcard spec this shouldn't
> happen as the results are unpredictable.  But above the user
> explicitly put master first, so it should be defaulted to.

But after that sequence, the right thing does happen. So I'm guessing that 
he has some different sequence that triggers a bug.

	-Daniel
*This .sig left intentionally blank*

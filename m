From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn set-tree
Date: Wed, 11 Jul 2007 00:45:53 +0200
Message-ID: <000901c7c344$12b431a0$02ac10ac@Jocke>
References: <20070709054541.GA2301@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Eric Wong'" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 00:46:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8OTE-0001Hn-1g
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 00:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbXGJWqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756083AbXGJWqI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 18:46:08 -0400
Received: from mail.transmode.se ([83.241.175.147]:37450 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755819AbXGJWqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 18:46:07 -0400
Received: from Jocke ([84.217.3.187]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 11 Jul 2007 00:46:00 +0200
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcfB7xztBdWT5nBoTQmX8IJRBzXHmgAOYKNA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
In-Reply-To: <20070709054541.GA2301@mayonaise>
X-OriginalArrivalTime: 10 Jul 2007 22:46:00.0940 (UTC) FILETIME=[16B372C0:01C7C344]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52117>

 

> -----Original Message-----
> From: Eric Wong [mailto:normalperson@yhbt.net] 
> Sent: den 9 juli 2007 07:46
> To: Tjernlund
> Cc: git@vger.kernel.org
> Subject: Re: git-svn set-tree
> 
> Tjernlund <tjernlund@tjernlund.se> wrote:
> > I have noticed that if I do a git-svn set-tree, remotes/git-svn
> > retains the parent from the branch where set-tree was performed.
> > 
> > If a coworker wants recreate my tree by using git-svn init 
> && git-svn
> > fetch he looses the parent I have in my tree.
> > 
> > I wonder if not git-svn set-tree can record the parent 
> information in
> > the svn repos log, so that git-svn init/fetch can recreate 
> the parent
> > relationship?
> 
> We could at yet another non-standardized property into SVN to handle
> merges.  Currently there are at least two properties used in 
> the SVN/SVK
> world to represent merges (Sam Vilain can give you the fun details of
> each one!).

I have read his page, quite informative.

> 
> I'm afraid adding a third incompatible yet similair property 
> for git-svn
> would just confuse people. 
> 
> I've become very much against crazy stuff like set-tree which ends up
> creating a M:N history mapping between git and svn.  1:1 is 
> the simplest
> and easiest.  I'm more than willing to sacrifice multi-parent 
> histories
> in git for easier compatibility with other systems.

set-tree is needed for starting a SVN tree from a git tree, I don't
know of any other way to do that. I got both linux and u-boot
git trees in which I do custom mods. I then use git-svn 
to maintain a svn tree which I start with set-tree to commit
the initial tree, then I dcommit my local mods. 

Maybe maybe an option to git-svn init/clone where you can specify the git
parent for a certain svn revision? 

> 
> Heck, linear history is just easier to deal with and probably 
> preferable
> in most/many cases.  I'm sure that the rising popularity of 
> git-rebase,
> quilt, stgit, guilt, mq and other like tools is a testament to that.
>

git rebase is a bit annoying as you loose the old tree if you don't take precations.
Also, I am not sure what will be committed to SVN if I rebase my local mods on top
of linus latest.

 Jocke
 
> -- 
> Eric Wong
> 

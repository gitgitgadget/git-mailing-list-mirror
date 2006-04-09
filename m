From: Peter Baumann <peter.baumann@gmail.com>
Subject: Re: How to create independent branches
Date: Sun, 9 Apr 2006 10:11:05 +0200
Message-ID: <20060409081105.GA4798@xp.machine.de>
References: <20060407184701.GA6686@xp.machine.de> <7vr749i48s.fsf@assigned-by-dhcp.cox.net> <20060408180244.GA4807@xp.machine.de> <e18vcv$rhf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 09 10:10:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSV0c-0007dr-Fp
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 10:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWDIIKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 04:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWDIIKc
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 04:10:32 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:54148 "HELO
	mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id S1750700AbWDIIKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 04:10:32 -0400
Received: (qmail 13913 invoked by uid 0); 9 Apr 2006 08:10:23 -0000
Received: from pd9f80998.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@217.248.9.152)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 9 Apr 2006 08:10:23 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e18vcv$rhf$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18540>

On Sat, Apr 08, 2006 at 08:28:58PM +0200, Jakub Narebski wrote:
> Peter Baumann wrote:
> 
> > Another question. I'd like to create a totaly independent branch (like
> > the "todo" branch in git). Is there a more user friendly way than doing
> > 
> > git-checkout -b todo
> > rm .git/refs/heads/todo
> > rm .git/index
> > rm <all_files_in_your_workdir>
> > 
> > ... hack hack hack ...
> > git-commit -a
> 
> Wouldn't it be better and more natural to go back to first commit? > 

If I go back to the first commit, I'll get the following:

	first
	 / \
	/   \
   master    todo

That's not what I want, because in the near future I want to merge
master and todo, but in my case, todo consists of only of one file (lets
call it file_a), and the master branch has severeal files (file_{a..z}).
If I go back to first, I have to delete all files file_{b..z}.
Further file_a from todo and file_a from master are not equal, the share
just the same name. But in the near future, they will be merged
together, so they are equal.

If I go with the above branching, I'll _think_ (I may be wrong, please
correct me if I am) I get a merge conflict or worse, all my other files
file_a{b..z} are merged as "deleted", wich is wrong.

> Or even empty repository state at the beginning, and branch there?

This isn't possible because the repository already exists and I don't
know how to go back to the empty repository state. Even 

	git-init-db
	git branch todo master

didn't work.

> Or make separate repository?

Ok. You got it. In fact, the todo branch alread exists as a seperate
repository and I'd like to integrate this in my master repository for
easier handling (diff etc.)

To import todo as a subproject doesn't seem right, because it's not
something really independent in the view of the master repo and I'am
going to merge todo _into_ master in the near future.

Any further suggestions?

-Peter

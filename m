From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: deleting a branch
Date: Tue, 13 Sep 2005 12:23:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509131217490.23242@iabervon.org>
References: <4326F2AE.50108@citi.umich.edu> <7v4q8p3qd8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cel@citi.umich.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 18:22:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFDVY-000827-QI
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 18:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVIMQTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 12:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVIMQTb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 12:19:31 -0400
Received: from iabervon.org ([66.92.72.58]:50192 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964849AbVIMQTa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 12:19:30 -0400
Received: (qmail 32469 invoked by uid 1000); 13 Sep 2005 12:23:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2005 12:23:37 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q8p3qd8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8470>

On Tue, 13 Sep 2005, Junio C Hamano wrote:

> "rm -f .git/refs/heads/no-longer-needed".  Make sure your
> working tree is not on that branch (i.e. .git/HEAD should not be
> pointing at it).
> 
> I have not introduced "git branch -d no-longer-needed" because
> I think that should do a bit more than "rm -f".  For example:
> 
>  - making sure you are not on that branch (obvious),
> 
>  - check if all changes on that branch are included in the
>    master branch or some other branch (easy if we hardcode "master";
>    checking all other branches might be nicer but expensive).

You could check HEAD. I think the most common cases would either be that 
you just created a branch from HEAD and changed your mind, or that you've 
just merged the branch into something. Other that that, I think the common 
case is that you've made patches, sent them off, and they were accepted. 
In the first two, you're probably on the branch that includes or matches 
the one you're deleting; on the third, we want user confirmation, since 
it's external to the system.

	-Daniel
*This .sig left intentionally blank*

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase conflict help?
Date: Thu, 17 Nov 2005 15:21:26 -0800
Message-ID: <7voe4isvwp.fsf@assigned-by-dhcp.cox.net>
References: <33D6F7FB-7864-471B-A111-9991C768577A@desertsol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:23:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ect4M-0002hp-Jz
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVKQXV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVKQXV2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:21:28 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11723 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965107AbVKQXV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 18:21:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117232056.FUTE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 18:20:56 -0500
To: Kevin Geiss <kevin@desertsol.com>
In-Reply-To: <33D6F7FB-7864-471B-A111-9991C768577A@desertsol.com> (Kevin
	Geiss's message of "Thu, 17 Nov 2005 15:20:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12171>

Kevin Geiss <kevin@desertsol.com> writes:

> I fetched my origin branch, then tried to run 'git rebase origin'.  
> one of my commits from master which is not yet in origin got a  
> conflict, so git rebase origin told me that the Simple cherry-pick  
> failed, and the Automatic cherry-pick got conflicts. and it saved the  
> commit message for me in .msg and my offending commit's id in .rebase- 
> tmp32409.

Sorry, the tool support for this situation is very poor in the
original rebase code.

With the tool you have, you need to make sure that the working
tree matches the (halfway) rebased master's head, and run
"git-cherry-pick --replay $commit" on the offending commits
stored in .rebase-tmp$$, one by one.

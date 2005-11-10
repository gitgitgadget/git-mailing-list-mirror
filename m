From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 00:40:29 +0100
Message-ID: <20051110234029.GE30496@pasky.or.cz>
References: <1124832796.23795.9.camel@dv> <200511110026.18324.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 00:41:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaM1z-0003rl-UK
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 00:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVKJXkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 18:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKJXkc
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 18:40:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28860 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751237AbVKJXkb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 18:40:31 -0500
Received: (qmail 23888 invoked by uid 2001); 11 Nov 2005 00:40:29 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200511110026.18324.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11537>

Dear diary, on Fri, Nov 11, 2005 at 12:26:18AM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> On Tuesday 23 August 2005 23:33, Pavel Roskin wrote:
> > Hello!
> > 
> > This patch changes cg-pull so that if the branch is not specified, it
> > takes origin's .git/HEAD without first trying .git/refs/heads/master.
> > This removes preferential treatment of the "master" branch, allowing the
> > upstream to use another name for the default branch.  To get the master
> > branch, users would have to append "#master" to the URL.
> 
> I think this is wrong.
> 
> Why would anybody want to fetch the current upstream HEAD at cg-pull
> time? If you do this, and you have no control on the upstream
> repository, "origin" will jump randomly around after cg-pull, depending
> on the current HEAD of the origin repository.

In public repositories, you usually set the HEAD once and it stays
there, or when you switch it, you are really careful about it.

> Besides, this is a incompatible change in cg-pull behavior: I am sure that
> a lot of people did a cg-clone in the past without any specific remote branch,
> and expect that cg-pull will update their origin to the remote "master".
> Now, if they update to a new Cogito with this patch, the next cg-pull
> sometimes will rebase their origin to another random branch, depending
> on remote HEAD ?!

See above. The remote HEAD is supposed to be generally stable for public
repositories, pointing to the _default_ head for public consumption.
If you want something specific, specify it by the #branchname.

> Or am I missing something here?

That this is from 23 August and this change was in Cogito for several
major releases and noone ever complained. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.

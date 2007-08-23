From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-svnimport: what to do after -i?
Date: Thu, 23 Aug 2007 09:00:31 -0400
Message-ID: <20070823130031.GA17092@falcon.digizenstudio.com>
References: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com> <20070823012836.GA18796@falcon.digizenstudio.com> <Pine.LNX.4.64.0708230827440.26254@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 23 15:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOCJa-0008Al-1M
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 15:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760661AbXHWNBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 09:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760594AbXHWNB3
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 09:01:29 -0400
Received: from k2smtpout03-02.prod.mesa1.secureserver.net ([64.202.189.172]:35401
	"HELO k2smtpout03-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758182AbXHWNB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 09:01:29 -0400
Received: (qmail 8020 invoked from network); 23 Aug 2007 13:01:28 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-02.prod.mesa1.secureserver.net (64.202.189.172) with ESMTP; 23 Aug 2007 13:01:28 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id B8629100A0E;
	Thu, 23 Aug 2007 13:01:28 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xy2nP5Nml6Qa; Thu, 23 Aug 2007 09:01:28 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 0A54D1000A2;
	Thu, 23 Aug 2007 09:01:28 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 49A9E7B51B; Thu, 23 Aug 2007 09:00:31 -0400 (EDT)
Mail-Followup-To: Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708230827440.26254@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56498>

On Thu, Aug 23, 2007 at 08:29:54AM +0100, Julian Phillips wrote:
> 
> I haven't used svnimport in a while (and never with subprojects), but you 
> seem to be specifying that projectFoo is your trunk - which doesn't seem 
> right.
> 
> I would have expected the command to be:
> 
> git svnimport -C projectFoo -r -A svn-authors -I .gitignore svn://jabba 
> projectFoo

Thanks for bringing it up. :)

My svn structure (see my last email) is somewhat reversed from what
svnimport assumes, which seems to be more along the lines of:

repoRoot
  -trunk
    -projectFoo
    -projectBar
  -tags
    -projectFoo
    -projectBar
  -branches
    -projectFoo
    -projectBar

So in my case I had to kind of cheat svnimport into thinking
'projectFoo' is the name of the "trunk" directory, and 'trunk' is the
actually project name. And I had to create 'dummytags' and
'dummybranches' at repoRoot level (following somebody else's tip found
on this list).

Of course doing so has two problems:

1. I can only import one project at one time, but my plan is to have
separated git repo for each project going forward, so this works out
just fine.

2. I can't actually import any tags and branches because my real tags
and branches are under projectFoo/tags and projectFoo/branches. This is
somewhat a loss, but we can cope with it by having the svn repo around
as the history book.

But then if there is any better way to achieve this, I would certainly
be interested and eager to learn. Thanks.

-- 
Jing Xue

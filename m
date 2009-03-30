From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn init --username ignored
Date: Sun, 29 Mar 2009 20:54:53 -0700
Message-ID: <20090330035453.GA4403@dcvr.yhbt.net>
References: <9FB623A2-03A6-4B35-B631-DF4745971DB9@gmail.com> <20090329224137.GA20675@dcvr.yhbt.net> <FB93BF8D-836A-4A40-8B82-E32561007A52@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 05:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo8ca-0001nO-0P
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 05:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbZC3Dy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 23:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756199AbZC3Dy4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 23:54:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45608 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755794AbZC3Dyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 23:54:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D941F7A3;
	Mon, 30 Mar 2009 03:54:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <FB93BF8D-836A-4A40-8B82-E32561007A52@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115058>

Lachlan Deck <lachlan.deck@gmail.com> wrote:
> On 30/03/2009, at 9:41 AM, Eric Wong wrote:
>
>> Lachlan Deck <lachlan.deck@gmail.com> wrote:
>>> Hi there,
>>>
>>> Is it a bug that the when specifying --username=foo for either git- 
>>> svn
>>> init or git-svn clone  that this isn't stored in .git/config?
>>>
>>> It means that for http[s] urls you need to specify it each time for
>>> git-svn fetch, for example.
>>>
>>> Is there any way to specify it manually in the config file - or would
>>> that have some bad consequences?
>>
>> Subversion already stores credential information in ~/.subversion/  
>> which
>> git svn should respect and use if available and allowed to.  Did you
>> disable set "store-auth-creds = no" in your ~/.subversion/config ?
>
> No, it's still commented out.
>
> I simply started by doing:
> git svn clone https://somedomain/repo repo --username=lachlan -s
> cd repo
> git svn fetch // failed without --username
>
> In case the initial passing of --username is tripping it up, I'm trying 
> again without specifying it.

Does "svn ls https://somedomain/repo" prompt you for a username?  Does
repeating that command (after successfully running it once) still prompt
you? (it shouldn't prompt you again if you have auth caching on).

If "svn ls" is prompting you every time, then SVN auth caching is
somehow disabled/broken on you system.  You can try poking around inside
your ~/.subversion/ directory and see if there's permissions problems
or such...

-- 
Eric Wong

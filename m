From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-svnimport: what to do after -i?
Date: Fri, 24 Aug 2007 01:18:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708240113360.32194@beast.quantumfyre.co.uk>
References: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
 <20070823012836.GA18796@falcon.digizenstudio.com>
 <Pine.LNX.4.64.0708230827440.26254@beast.quantumfyre.co.uk>
 <20070823130031.GA17092@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 02:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOMtZ-0008Cu-Rn
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 02:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934018AbXHXAS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 20:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934439AbXHXASx
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 20:18:53 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:48053 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934425AbXHXASv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 20:18:51 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E61D0C65C9
	for <git@vger.kernel.org>; Fri, 24 Aug 2007 01:18:49 +0100 (BST)
Received: (qmail 12066 invoked by uid 103); 24 Aug 2007 01:18:49 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/4032. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.030997 secs); 24 Aug 2007 00:18:49 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 24 Aug 2007 01:18:49 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070823130031.GA17092@falcon.digizenstudio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56541>

On Thu, 23 Aug 2007, Jing Xue wrote:

> On Thu, Aug 23, 2007 at 08:29:54AM +0100, Julian Phillips wrote:
>>
>> I haven't used svnimport in a while (and never with subprojects), but you
>> seem to be specifying that projectFoo is your trunk - which doesn't seem
>> right.
>>
>> I would have expected the command to be:
>>
>> git svnimport -C projectFoo -r -A svn-authors -I .gitignore svn://jabba
>> projectFoo
>
> Thanks for bringing it up. :)
>
> My svn structure (see my last email) is somewhat reversed from what
> svnimport assumes, which seems to be more along the lines of:
>
> repoRoot
>  -trunk
>    -projectFoo
>    -projectBar
>  -tags
>    -projectFoo
>    -projectBar
>  -branches
>    -projectFoo
>    -projectBar
>
> So in my case I had to kind of cheat svnimport into thinking
> 'projectFoo' is the name of the "trunk" directory, and 'trunk' is the
> actually project name. And I had to create 'dummytags' and
> 'dummybranches' at repoRoot level (following somebody else's tip found
> on this list).

Ah, yes ... sorry.  I've actually ended up using a homebrew script for 
parsing svn dump files and feeding git-fast-import for a number of 
reasons, so I'm a bit rusty with svnimport, and never looked at multiple 
projects in one repo anyway.  (One of which was that svnimport wasn't 
creating a correct import actually - some files and directories were 
simply missing).

> Of course doing so has two problems:
>
> 1. I can only import one project at one time, but my plan is to have
> separated git repo for each project going forward, so this works out
> just fine.
>
> 2. I can't actually import any tags and branches because my real tags
> and branches are under projectFoo/tags and projectFoo/branches. This is
> somewhat a loss, but we can cope with it by having the svn repo around
> as the history book.
>
> But then if there is any better way to achieve this, I would certainly
> be interested and eager to learn. Thanks.

I guess you've tried including projectFoo in the url?  Other than that, 
perhaps git-svn may have better luck?

-- 
Julian

  ---
I'm not a real movie star -- I've still got the same wife I started out
with twenty-eight years ago.
 		-- Will Rogers

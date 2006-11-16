X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 08:30:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611160824040.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <20061116042639.GA23026@thunk.org>
 <455C5079.3010701@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 16:32:50 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455C5079.3010701@op5.se>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31596>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkk9Q-0005A6-TQ for gcvg-git@gmane.org; Thu, 16 Nov
 2006 17:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030701AbWKPQbl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 11:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030712AbWKPQbl
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 11:31:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39101 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030701AbWKPQbl (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 11:31:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGGV1oZ011466
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 08:31:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGGUu3F029699; Thu, 16 Nov
 2006 08:30:58 -0800
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Andreas Ericsson wrote:
> 
> * Mentioning git-fetch before git-pull in all documentation newborn gitizens
> are likely to come across.

However, I also think it might make sense to talk about the _simple_ form 
of "git pull" first.

The form I use is actually a lot simpler (conceptually) than the "short" 
form.

When you do

	git pull <reponame> <branchname>

there are very few things that can confuse you (although trying to do it 
without a current branch at all is apparently one such thing ;). 

There are no local branches to worry about, and there aren't any issues 
about what the default repository or branchname on the remote side would 
be either.

So in many ways, if you use this format, you simply never have to worry. 
You may have to _type_ a bit more, so it's not the short or concise 
format, but it sure is the _simple_ format. There simply isn't anything to 
be confused about.

And yes, I actually tend to use this even for project that I don't develop 
on, partly because the defaults for the short and concise formats are bad. 
For example, I follow the "modesetting" branch on the xorg intel graphics 
driver tree, and because I'm always on that branch, what I do is

	git pull origin modesetting

which works correctly (while "git pull" would _not_ have done the right 
thing: it would have picked the right repository, but it would have picked 
the "master" branch of that repository, not the "modesetting" branch).

And notice how I don't do _any_ development there, I just follow that 
branch. The "merge" will obviously always be a fast-forward, but that's 
exactly what I want. 

> Most git-users aren't Linus, and for every successful project the 
> maintainers are outnumbered 100 to 1 by the contributors.

Well, as mentioned, I think even for non-developers, doing pulls with 
explicit branchnames is actually perfectly sane.


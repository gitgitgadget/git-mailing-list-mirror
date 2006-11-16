X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Thu, 16 Nov 2006 15:08:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611161452430.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 23:09:08 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31634>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkqLh-0005Eq-Pu for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754897AbWKPXIi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbWKPXIi
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:08:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12525 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1754897AbWKPXIh (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:08:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGN8VoZ011693
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 15:08:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGN8UBX010714; Thu, 16 Nov
 2006 15:08:30 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Linus Torvalds wrote:
>
> 	git merge "$(git fmt-merge-msg < .git/FETCH_HEAD)" HEAD FETCH_HEAD

Btw, I'd like to claim that this is a _great_ user interface.

Yeah, it's different from other SCM's. I don't think you'd really want to 
script a merge like this in CVS, especially not using standard UNIX 
pipelines etc. But it's an example of how a lot of git operations - even 
the "high level ones" are pretty scriptable, using very basic and very 
simple standard UNIX shell scripting.

So even though I'd not actually _do_ the above one-liner, I think it's a 
great example of how git really works, and how scriptable it can be, 
without a lot of huge problems.

So considering that "FETCH_HEAD" works pretty much everywhere, and that 
you can also use the totally non-scripting approach of doing "standard" 
SCM things like

	git diff ..FETCH_HEAD

or 

	gitk HEAD...FETCH_HEAD

to look at what got fetched (and in the latter case look at both the 
current HEAD _and_ FETCH_HEAD, and what was in one but not the other), I 
really think it's unfair to say that "git fetch" does not have a nice UI.

It's just that "git fetch" can be used two totally different ways:

 - "git fetch" to get something temporary: use FETCH_HEAD, and do _not_ 
   specify a destination branch

 - "git fetch" as a way to update the branches you already have, by either 
   using explicit branch specifiers (which would be unusual, but works), 
   or by just having the branch relationships listed in your .git/remotes/ 
   file or .git/config file.

both are actually very natural things to do.

What is probably _not_ that natural is to do the explicit branch 
specifier, ie

	git fetch somerepo remotebranch:localbranch

which obviously works, but you wouldn't want to actually do this very 
often. Either you do something once (and use FETCH_HEAD, which is actually 
nicer than a real branch in some respects: it also tells you were you 
fetched _from_, and it can contain data on merging from _multiple_ 
branches), or you set up a "real translation" in your configuration files.

So I would say that the natural thing to do is:

 - "git pull somerepo"

   This will _also_ fetch all the branches you've said you want to track, 
   of course.

 - "git fetch somerepo somebranch"

   Look at FETCH_HEAD, and be happy

 - "git fetch somerepo"

   This is kind of strange, but it can be useful if you are basically just 
   mirroring another repo, and want to fetch all the branches you've said 
   you want to track, but don't actually want to check them out.

while the "complicated" scenario like the following is something you 
should generally _avoid_, because it's just confusing and complex:

 - "git fetch somerepo branch1:mybranch1 branch2:mybranch2"

   This works, and I'm sure it's useful, and I've even used it (usually 
   with just one branch, though), but let's face it - it's too damn 
   complicated to be anything you want to do _normally_.

So git is definitely powerful, but I think some people have looked at the 
_complicated_ cases more than the simple cases (ie maybe people have 
looked too much at that last case, not realizing that there really isn't 
much reason to use it - and FETCH_HEAD is one big reason why you seldom 
need the complicated format).


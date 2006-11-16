X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 15:22:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 23:22:37 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31635>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkqYn-0007Q5-Ed for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162301AbWKPXWR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162302AbWKPXWR
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:22:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32389 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162301AbWKPXWQ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:22:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGNM9oZ013058
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 15:22:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGNM8TI011262; Thu, 16 Nov
 2006 15:22:09 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Fri, 17 Nov 2006, Johannes Schindelin wrote:
> 
> Never ever underestimate pet peeves. If we give many people an obvious 
> reason (however trivial and bike-shed-coloured) to complain, they will 
> complain.

I do actually think that this discussion has been informative, partly 
because I never even realized that some people would ever think to do 
"init-db" + "pull". 

Making things like that work is easy enough, it's just that I never saw 
any point until people complained. And when they complained, the initial 
complaint wasn't actually obvious. Only when Han-Wen actually gave 
something that didn't work, was it clear that the real issue wasn't so 
much _naming_, as just expectations about the _work_flow_.

> And hopefully you also agree that enhancing the syntax of git-merge to 
> grok "git-merge [-m message] <branch>" and "git-merge [-m message] 
> <url-or-remote> <branch>" would be a lovely thing, luring even more 
> people into using git.

I definitely think we can make "git merge" have a more pleasant syntax. 
I'm just still not sure that people should actually use it ;)

My real point was/is that usually it's really not the "naming details" 
that people _really_ have problems with. The real problems tend to be in 
learning a new workflow.

We can make some of those workflows easier, but I would heartily recommend 
that people not worry about naming of "pull" vs "fetch", because that's 
almost certainly not really the issue. Instead, if you have a problem, 
rather than concentrating on the names of the programs, say:

 - what do you want to get done.

   Most likely it's _trivial_ to do with git, it's just that somebody used 
   the wrong approach, and then it didn't work at all.

 - give actual examples of a workflow that didn't work or was complex.

   (again, the "init-db" + "pull" example). 

   And yes, in many cases, it might well be a case of "sure, we can make 
   that _other_ workflow work too". But somebody like me, who has used git 
   for a year and a half, and used BK before it, probably simply uses a 
   different workflow than somebody who comes from CVS. 

For example, I suspect that your gripe with "git fetch" was just from 
using it in a really awkward manner. Maybe we could make your workflow 
work with git too, but maybe it really already (and always) did, you just 
used a particular tool in a way that made the use be really really 
painful.

Sometimes it's just a question of "ok, use it like _this_, and now it's 
actually really simple". Other times it's "ok, I didn't even realize that 
you wanted to use it like _that_, and yeah, that's incredibly 
inconvenient, and we can change it".

I just got involved in this discussion because I thought people were 
talking about all the wrong things. Command naming really can't be _that_ 
big of a deal. I really don't believe that we should have some people use 
"gh" instead of "git" just because they think "pull" should mean not to 
merge or something.


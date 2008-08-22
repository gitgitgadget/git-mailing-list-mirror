From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 13:33:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808221330090.3487@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org>  <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>  <20080822182718.GQ23334@one.firstfloor.org>  <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
 <4d8e3fd30808221311w7c507abboecd0893def85a073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdMI-0002ah-3F
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbYHVUe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756919AbYHVUe0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:34:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47159 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758233AbYHVUeY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 16:34:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MKXpea032125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Aug 2008 13:33:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MKXoVq015211;
	Fri, 22 Aug 2008 13:33:51 -0700
In-Reply-To: <4d8e3fd30808221311w7c507abboecd0893def85a073@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93358>



On Fri, 22 Aug 2008, Paolo Ciarrocchi wrote:
> 
> since tip/master is often rebased (as pu or linux-next) what I do is
> the following:
> git branch -D tip-latest
> git checkout -b tip-latest tip/master
> 
> but I guess lot of people would expect to "throw away" and "checkout
> again" with a single git command.

I would literally suggest not using a branch at all. Yes, it works, but 
this is the perfect usage case for "no branch" aka "detached head" usage, 
because "git status" will nicely tell you "Not currently on any branch" 
and "git branch" will point it out too.

So instead of using a real branch "tip-latest", just do

	git checkout tip/master

to not create a branch at all, since all you will eventually have to do is 
to delete it anyway, and saving the state for later would be actively 
wrong.

The "git checkout" will also have a nice message like

	Note: moving to "tip/master" which isn't a local branch

and about how you _can_ save the state later if you want to (even if you 
don't), which may look a bit scary, but once you get used to it it's 
actually not scary at all, but just reminds you that you did the right 
thing.

		Linus

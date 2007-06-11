From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: That improved git-gui blame viewer..
Date: Mon, 11 Jun 2007 08:46:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
 <20070611064203.GG6073@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:47:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxm6y-0003N4-SD
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 17:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbXFKPqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 11:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825AbXFKPqp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 11:46:45 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32864 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754984AbXFKPqm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2007 11:46:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5BFkUjo019092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2007 08:46:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5BFkPVN022764;
	Mon, 11 Jun 2007 08:46:25 -0700
In-Reply-To: <20070611064203.GG6073@spearce.org>
X-Spam-Status: No, hits=-2.712 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49859>



On Mon, 11 Jun 2007, Shawn O. Pearce wrote:
> 
> Thanks!  I'm glad at least one other person on this planet finds
> my work on the blame viewer at least partially useful.

I think a lot of people are going to enjoy the git-gui blame viewer..

I don't generally do "git blame" very much at all, and I've found that any 
time I do it (even historically - when I've used bk annotate and even 
CVS), I have invariably _always_ wanted to go back in history to see the 
blame of the *previous* version (because the commit that gets blamed 
initially is simply not interesting, and is just whitespace cleanups or 
whatever!).

Now, this was something I knew very well on an intellectual level, and I 
tried to explain in one of my early discourses on why "annotate" is such a 
horribly interface, and why git could do so much better, but it's 
something that I think "git-gui blame" is showing that could really be 
done.

Now, admittedly, git-gui seems buggy in this regard (I *think* you meant 
that the two commits that show up listed to the left of each line are the 
"before and after" commit, but they end both being the "after" commit for 
me, but I can almost *taste* git-gui doing the right thing here. And once 
it does that, I think a lot of people will start to realize how useful 
this kind of interactive "drill down into the history of a line" thing can 
be.

So I think git-gui isn't quite there yet, but I think it's getting pretty 
close. It would need

 - the afore-mentioned bug fixed (I _think_ it is a bug, but maybe you had 
   some other reason for having two separate columns of commits per line), 
   so that you can literally click on the *previous* version of a line and 
   say "I don't care about this commit, I want to see the previous one".

 - I'd love to see a "go to most recent change" thing (the way _I_ work, I 
   tend to peel history, so I often look at recent changes, but if that 
   one isn't interesting, I'd go to the "previous version" and then again 
   ask for "go to the most recent change".

 - I like the floating tooltip showing what the commit was, but I think it 
   could be extended a bit more to perhaps literally show what the 
   previous contents of that chunk were (again, that's useful for the "am 
   I interested in _this_ commit, or should I just dig down to the 
   previous one")

But yes, the current git-gui blame is already quite interesting. It's not 
"all that it could be", but it has gone from "Whee, that looks so ugly 
that I need to find me a couple of spoons to dig out my eyeballs with" to 
"Hey, I can see this being _really_ good".

		Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mtimes of working files
Date: Fri, 13 Jul 2007 17:10:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707131704000.20061@woody.linux-foundation.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> 
 <Pine.LNX.4.64.0707111940080.4516@racer.site>  <20070711202615.GE3069@efreet.light.src>
  <200707120857.53090.andyparkins@gmail.com>  <1184261246.31598.139.camel@pmac.infradead.org>
  <20070713003700.GA21304@thunk.org>  <1184367619.2785.58.camel@shinybook.infradead.org>
  <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
 <1184370414.2785.79.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 02:11:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9VE6-0006RH-J6
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 02:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763944AbXGNALH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 20:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763970AbXGNALH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 20:11:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48552 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758376AbXGNALD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2007 20:11:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6E0ALpH028206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2007 17:10:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6E0AG2K030721;
	Fri, 13 Jul 2007 17:10:16 -0700
In-Reply-To: <1184370414.2785.79.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=-2.609 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52425>



On Sat, 14 Jul 2007, David Woodhouse wrote:
> 
> On the occasions I actually try to _use_ branches, I find it very
> suboptimal.

This seems to be very personal.

I tend to use just temporary branches, but I love just going on another 
branch, fixing something up, and working on that without having to set up 
a whole new tree. It's *much* faster to just switch branches than to do 
even a local clone, because I usually would work on something that is 
pretty close to the HEAD anyway, so the cost of rewriting a few hundred 
files is much less than checking out the 22,000 files all over again.

But I literally tend to just use branches for something small. I don't 
personally tend to have any long-term live branches (apart from the remove 
ones, obviously). I create a branch, do something in it, merge it, and 
go back to master.

The last example of this for me was just re-doing a pull by Ingo, because 
he had created some really strange commit in his tree, so I fetched his 
stuff, re-created his branch locally without the thing, and then merged 
it. And then I just deleted the branch.

> But having to rebuild (even with ccache) after changing branches is a 
> PITA.

I don't even use ccache, and I don't care. Probably because most of the 
time the rebuild time really isn't that long for me, and for the kernel, 
the much more painful part is actually the rebooting part.

But the place where branches *really* rock is when you don't even switch 
to them, but use the data from them locally (cherry-picking from them, 
or doing something like "git show origin/pu:builtin-blame.c" etc).

And for that to work, you have to get used to having multiple branches in 
the tree, even if you don't check them out - and once you do that, 
switching between them isn't really that confusing any more, because it's 
already part of your "mind map" of how the repo works.

			Linus

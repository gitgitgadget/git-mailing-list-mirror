From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 09:38:32 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <Pine.LNX.4.64.0711072309380.4362@racer.site> 
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> 
 <Pine.LNX.4.64.0711080003080.4362@racer.site> 
 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com> 
 <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
 <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:39:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXpS-0003Qk-7X
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbXKIRjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbXKIRjL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:39:11 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46029 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754638AbXKIRjK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 12:39:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9HcXTV014785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 09:38:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9HcXPO024550;
	Fri, 9 Nov 2007 09:38:33 -0800
In-Reply-To: <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64228>



On Fri, 9 Nov 2007, Jon Smirl wrote:
> 
> The summary of this is that new users do not expect "git log" to give
> them the whole log when the command is executed in a subdirectory.
> This causes a training burden because of the unexpected behavior. They
> try 'git log' and then I have to tell them to use "git log ."

No. The summary is that *you* are confused.

The fact is, "git log" always has given the whole log, and there is no 
confusion at all. The only people who may be confused are people who 
misread the documentation on purpose, or who came from some broken other 
SCM, and are confused just because of *that*.

Git makes it very clear indeed at all points that it tracks whole history. 
It's a big deal. We *make* a big deal about it, and "git log" follows that 
very consistently.

In fact, even at the top-of-tree, "git log" and "git log ." are two 
totally different things, even if in practice the differences are often 
hard to see. But one gives the "full history", and the other gives the 
"simplified history for the pathnames given", and the two are REALLY 
REALLY different.

Try it. Do

	git log origin/pu > full
	git log origin/pu . > limited

in the git tree, and look at the differences (it might be useful to use 
gitk instead, and look at where the differences start! That visual 
difference is going to give you a lot more of an "Ahaa!" moment when you 
understand it). When you can explain and understand those differences, 
then you *really* understand git (and quite frankly, it's actually rather 
simple, but you have to really *think* about what those things things 
are).

Now, for normal use you never need to really to care. Git does a lot of 
things, and some random user will seldom need the full power of git, nor 
do they need to really care about why "git log ." and "git log" are 
actually not the same thing at all, even at the top level.

But you're blaming git for your *own* confusion, which probably comes from 
crap systems that don't even know what "history" is because they can't 
really track it right anyway.

		Linus

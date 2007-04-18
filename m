From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 09:07:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>
 <Pine.LNX.4.64.0704181130150.12094@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeChw-00029p-AX
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbXDRQII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbXDRQII
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:08:08 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36825 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbXDRQIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:08:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IG7uYC019145
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 09:07:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IG7t86028721;
	Wed, 18 Apr 2007 09:07:55 -0700
In-Reply-To: <Pine.LNX.4.64.0704181130150.12094@racer.site>
X-Spam-Status: No, hits=-0.464 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44905>



On Wed, 18 Apr 2007, Johannes Schindelin wrote:
> 
> On Tue, 17 Apr 2007, Marcin Kasperski wrote:
> > 
> > a) Windows are unsupported
> 
> Wrong.

It's a bit more work to set up though, and it has a lot less mindshare, 
and testing, obviously.

So yes, windows is a step-child. I'd love for it to not be one, and we'll 
get there, but it's clearly not as supported as the unix side. We still 
use a fair number of shell scripts (which in turn use unix commands and 
pipelines).

We'll get away from it. I think GSoC will help here.

> > b) Learning curve is too steep. Unclear relationship git-vs-cogito makes it
> > even worse.
> 
> Not so wrong. But then, it is clear that git is git is git. If you find it 
> too complicated, soon enough somebody says "use cogito instead" and you'll 
> find out about that.

Actually, at this stage, I really think cogito just *complicates* git 
usage. It hasn't been well-supported lately, and asking for help with 
cogito means that a lot of people can't help you. And you still end up 
using git commands for anything fancier.

So I don't think it's even true that new people should be pointed at cg 
any more.

What _is_ true is that git is simply different from CVS. I don't think 
it's necessarily harder to understand or use (in fact, I would argue that 
git is a lot _easier_ to understand), but it is *different*, and it has a 
ton more capabilities.

But compare setting up a git repository with setting up a CVS repository.
With git, it's literally "git init", and you're done. No need to worry 
about CVSROOT issues etc. Everything is self-contained. CVS is *hard* to 
get into, by comparison.

But being different means that *if* you already know CVS, you actually 
have a lot of unlearning of idiotic and bad habits, _and_ you need to 
learn that things that were so hard and scary under CVS that you either 
never learnt them, or quickly learnt to avoid ("branches" and "merging") 
are just so _easy_ under git, that they are discussed in the very first 
chapters of "getting started".

I can pretty much guarantee that 95% of all CVS users have never done a 
branch or a merge, even if they have used it for *years*. And yet, in git, 
we kind of take both of those for granted, and make them visible pretty 
much from day one. 

Git is just *easier*. But it is also different, and people are used to 
things being so hard that you'd never use them.

In a CVS world, you never even *need* to learn about branches and merging, 
because no normal user is ever actually expected to use either. In 
contrast, in the git world, pretty much every project uses multiple 
branches, and you are introduced to them at a minimum as the "origin" 
branches even for projects that just have one. So you're getting all these 
concepts that were so hard in CVS that you never ever even learnt to do 
them!

So people coming from CVS/SVN have a double shock: they are supposed to 
learn things that they "know" are hard (because CVS/SVN made them so damn 
hard - don't tell me that SVN branching is easy, because it is *not* easy. 
It may be cheaper to create a branch, but it has _all_ the same idiocies 
that CVS has once it's created). And on top of that, they have to re-learn 
something new.

So I really don't think cogito is the answer any more. The answer simply 
is: you have to learn that branches are *simple*. That's a big hurdle for 
some people. It's not the learning part that is hard, it's the 
*unlearning*. CVS/SVN has taught people that some things are complicated, 
and git uses those "complicated" things every day.

People who come from a CVS background would be *shocked* to learn that I 
do multiple merges a day. In fact, in the two years we've used git, we've 
had 3300 merges - and that's just counting the *nontrivial* ones that 
didn't just fast-forward. That's roughly an *average* of 4.5 merges a day. 
EVERY DAY. For two years.

In the CVS/SVN kind of mindset, a merge is something you do once a month, 
and you gird your loins for it. And it's usually just an expert, and only 
used for complex projects. A normal user would _never_ do a merge!

			Linus

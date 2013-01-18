From: David Lang <david@lang.hm>
Subject: RE: Question re. git remote repository
Date: Fri, 18 Jan 2013 12:27:51 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301181127590.21503@nftneq.ynat.uz>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca> <20130116220615.48c159546bccfa5b9cd9028e@domain007.com> <20130116182156.GB4426@sigill.intra.peff.net> <20130116233744.7d0775eaec98ce154a9de180@domain007.com> <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>,<201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca> <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com> <201301181833.r0IIXNGb027544@smtpb02.one-mail.on.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Lang, David" <David.Lang@uhn.ca>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:30:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwIZb-0000xz-EU
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 21:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab3ARU3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 15:29:33 -0500
Received: from mail.lang.hm ([64.81.33.126]:50572 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888Ab3ARU3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 15:29:32 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0IKTGFx013974;
	Fri, 18 Jan 2013 12:29:16 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201301181833.r0IIXNGb027544@smtpb02.one-mail.on.ca>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213934>

What I would do is to have each developer have their own local copy that they 
are working on.

I would then find a machine that is going to be on all the time (which could be 
a developer's desktop), and create a master repository there. Note that if this 
is on a developers desktop, this needs to be a different repository (or at the 
very least a different branch) from what they use to do their work.

developers then do their work locally, and after a change has been reviewed, 
pull it into the master repository.


This can even be done if you only have one developer (although then you may just 
use branches instead of a separate repository)

The idea is that when you start working on a new feature, you create a new 
branch from the master, implement your new feature, and then (after testing) 
merge the completed feature into the master branch/repository.

If developers are working on multiple things at once, they should have multiple 
branches. This is a hard habit to get into.

The tendancy is that while you are in changing code, you see something unrelated 
that needs fixing, so you fix it and go back to what you were doing.

You should try to get into the habit of not fixing unrelated things in one 
branch (or having a separate branch you use only for trivial fixes)

The idea is that each feature branch should have one set of related changes in 
it, so that you can merge in a branch when it's ready and not end up with one 
fix being tied in to another one,

David Lang



On Fri, 18 Jan 2013, Lang, David wrote:

> Hi Matt and David,
>
> Your responses have been very helpful for this newbie...thanks very much! I have a good sense now of the difference btw a CVCS and a DVCS. Here are two more questions...
>
> 1. I now get the sense that there's quite a few options in regards to the way that any one group implements their "origin"/"master"/<fill in your favourite name> repository. But ultimately, there shouldn't be a question of "if" you have a master repository but "where" you have the master repository, correct? Or in other words, it doesn't seem like you'd want to designate any one developer's local repository as also being the master repository, right? My sense is that would defeat the purpose of the DVCS.
>
> 2. Assuming I'm right about question #1, our first hurdle is where to host the master repository. Could you provide any suggestions for a setup based on our VERY simple department model? I work for a small IT department with a grand total of TWO developers (who sit five feet apart from one another)! The reason we're looking at a VCS is because I was hired a few months ago and the dept never needed one before now. We realize that git will be overkill for what we need but frankly anything will be overkill for what we need, and since git seems to be so well regarded in the community (and free) it looks like a good choice.
>
> So the question is, how would either of you recommend we set up our master repository? We definitely want to keep everything "in house" so off-site hosting isn't something we'd consider. We have access to many servers on our company's network, some of which we have full rights to, so there's no issue in regards to storage space. I suppose another idea would be to have the master simply reside on one of the two developers local machines, so one of us would have both a local rep and the master rep and the other of us would have just a local rep. This would simplify the model. What do you think? Or is it best to always have the master hosted on a machine with no other local reps?
>
> David

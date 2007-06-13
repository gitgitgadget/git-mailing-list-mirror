From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 22:17:56 +0200
Message-ID: <200706132217.57075.robin.rosenberg.lists@dewire.com>
References: <1HyUO6-04z4yG0@fwd28.aul.t-online.de> <Pine.LNX.4.64.0706131929020.4059@racer.site> <18032.15862.835008.22589@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZIb-0001kO-QP
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbXFMURn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753771AbXFMURn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:17:43 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28489 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754947AbXFMURm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 16:17:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 62A65802650;
	Wed, 13 Jun 2007 22:11:02 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06256-03; Wed, 13 Jun 2007 22:11:01 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id C9C90800783;
	Wed, 13 Jun 2007 22:11:01 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <18032.15862.835008.22589@lisa.zopyra.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50125>

onsdag 13 juni 2007 skrev Bill Lear:
> On Wednesday, June 13, 2007 at 19:30:23 (+0100) Johannes Schindelin writes:
> >Hi,
> >
> >On Wed, 13 Jun 2007, Bill Lear wrote:
> >
> >> Not completely: they don't want to commit, as this will then "pollute"
> >> the history in their working repository (which is just temporarily
> >> being used to play with a new feature, idea, bug fix, optimization,
> >> etc.).  This pollution with a handful of garbage would then have to be
> >> undone were they to say "ok, that's really not a good idea".  If a
> >> pull into a dirty tree were possible, that last step could be just a
> >> simple reset, or continuing to explore with the code, etc.
> >
> >Notice that I am _not_ saying that CVS is bad. I am saying that their 
> >workflow is likely bad (and yes, they should change that workflow, since 
> >they now _can_).
> 
> Yes, I have urged this.  But, they are stubborn, smart people, and if
> they see tool X allow something, they wonder why tool Y does not
> support it.
> 
> >Two things do they risk happily, which they should not do:
> >
> >- they test their new feature against different references. For example, 
> >  it might well be that they tested cases A, B, and C before pull, and D, 
> >  E and F after that. It is really easy to get lost in what you have, and 
> >  what not. Now, guess what. Merges are known to break things sometimes. 
> >  Even the best merge algorithm. Now your developers say "we tested it, 
> >  and the merge broke it, it's not our fault". But it is.
> 
> Well, their testing is something along the line of "I'm going to hack
> something here, and then I want to see if Joe's latest changes work
> with it".  Then, they want to pull in Joe's changes, run a test, and
> if their changes don't work, fix them, discard them, etc.
> 
> >- That new feature will have to be committed at some stage. Either your 
> >  devs commit at the end, which makes it a monster commit, which is bad. 
> >  Or they are _already_ using the suggested workflow "commit && pull", 
> >  which makes your whole complaint moot.
> 
> Perhaps: again, they may just be taking stabs that they know are wild,
> and will likely not be committed.
> 
> I'm not trying to argue for their point: I do most of my new work
> on branches, very rarely on the master branch, and can handle
> the git pull not working in a dirty tree with merge issues.
> 
> Some of the people we work with are not developers per se: they are
> engineers who sometimes like to fiddle (say, with a compiler
> optimization setting) and who never push into our company repo.
> They only see CVS and compare git to it.  When git prevents you
> from doing something they see as perfectly reasonable, they get
> annoyed and say "git sucks".  I'm battling in the git corner against
> this, but there is only so much I can do.

A typical case I recognize is a few printfs or disabling a feature that makes 
it harder to debug with no intentions whatsoever to commit them. What we see 
when the tools more or less forces people to "temporarily" commit stuff is 
that that stuff is often left there. "Oh, I forgot". Gah.

Git has this ability when checking out, so why not on pull or merge?

With stacked git I typically create a new patch, then I can push it whenever I 
want to have some more tracing.

-- robin

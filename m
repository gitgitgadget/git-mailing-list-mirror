X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 02:19:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
References: <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
 <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
 <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
 <20061025084810.GA26618@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 25 Oct 2006 09:19:46 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authentication-Warning: attu1.cs.washington.edu: rientjes owned process doing -bs
In-Reply-To: <20061025084810.GA26618@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30039>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcev5-0004Gh-W0 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 11:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423059AbWJYJT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 05:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423150AbWJYJT2
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 05:19:28 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:63119 "EHLO
 mx1.cs.washington.edu") by vger.kernel.org with ESMTP id S1423059AbWJYJT1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 05:19:27 -0400
Received: from attu1.cs.washington.edu (attu1.cs.washington.edu
 [128.208.1.137]) by mx1.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id
 k9P9JGlw018538 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NOT); Wed, 25 Oct 2006 02:19:16 -0700 (envelope-from
 rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost) by attu1.cs.washington.edu
 (8.13.7/8.13.7/Submit/1.2) with ESMTP id k9P9JFkP004681; Wed, 25 Oct 2006
 02:19:15 -0700 (envelope-from rientjes@cs.washington.edu)
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

On Wed, 25 Oct 2006, Jeff King wrote:

> I don't understand how converting shell scripts to C has any impact
> whatsoever on the usage of git. The plumbing shell scripts didn't go
> away; you can still call them and they behave identically.
> 
> Is there some specific change in functionality that you're lamenting?
> 

No, my criticism is against the added complexity which makes the 
modification of git increasingly difficult with every new release.  It's a 
pretty limited use case of the entire package, I'm sure, but one of the 
major advantages that I saw in git early on was the ability to tailor it 
to your own personal needs very easily with some simple shell knowledge 
and enough C that was required at the time.

> Some C->shell conversions may have made the code "longer and less
> traceable." However, many of those conversions caused the code to be
> shorter (because communication between C functions is simpler than going
> over pipes, and because anything involving a data structure more complex
> than a string is difficult in the shell) and more robust (fewer
> opportunities for quoting/parsing errors, and none of the shell gotchas
> like missing the error code in "foo | bar").
> 

You're ignoring the advantageous nature of the shell with regard to git.  
The shell is so much better prepared to deal with information managers by 
nature than the C programming language.  It's not a matter of shorter 
code, per se, it's about the developer's ability to make small changes to 
the operation of the information manager on demand to tailor to his or her 
_current_ needs.  For any experienced shell programmer it is so much 
easier to go in and change an option or pipe to a different command or 
comment out a simple shell command in a .sh file than editing the C code.  
And sometimes it's necessary to have several different variations of that 
command which is very easy with slightly renamed .sh files instead of 
adding on more and more flags to commands that have become so complex at 
this point that it's difficult to know the basics of how to manage a 
project.

This all became very obvious when the tutorials came out on "how to use 
git in 20 commands or less" effectively.  These tutorials shouldn't need 
to exist with an information manager that started as a quick, efficient, 
and _simple_ project.  You're treating git development in the same light 
as you treat Linux development; let's be honest and say that 99% of the 
necessary git functionality was there almost a year ago and ever since 
nothing of absolute necessity has been added that serious developers care 
about in a revision control system.  Look at LKML, nobody is waiting on 
these new releases and upgrading to them when they're announced.  And this 
is the community that git has _targeted_.  Most other projects don't care 
about the syntactics of sign-off lines and acked-by lines and format-patch 
like the git community does.

> Do you have any specific reason to believe that the git code is of worse
> quality now than it was before?
> 

Absolutely.  I think I've actually documented that fairly well.  Back in 
the day git was a very concise, well-written package.  Today, a tour 
through the source code for the latest release leaves a lot to be desired 
for any serious C programmer.

> Is there something you used to do with git that you no longer can? Is
> there a reason you can't ignore the newer commands?
> 

Functionality wise, no.  But in terms of being able to _customize_ my 
version of git depending on how I want to use it, I've lost hope on the 
whole idea.  It's a shame too because it appears as though the original 
vision was one of efficiency and simplicity.  I would say that git-1.2.4 
is my package of preference with some slight tweaking in the branching 
department.

I really do miss the old git.


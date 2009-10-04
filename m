Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: (qmail 10585 invoked by uid 107); 4 Oct 2009 12:11:55 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 08:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZJDMH2 (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 08:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbZJDMH2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 08:07:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:48042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752686AbZJDMH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 08:07:27 -0400
Received: (qmail invoked by alias); 04 Oct 2009 12:06:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 04 Oct 2009 14:06:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AfAZFOtmAiPlPpEC/3GkCn4Yz0J67E1QC/Uau6v
	ul5E1phGS04Xvs
Date:	Sun, 4 Oct 2009 14:09:01 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: schindelin@pacific.mpi-cbg.de
To:	git@vger.kernel.org, msysgit@googlegroups.com
Subject: Alles wurde Git
Message-ID: <alpine.DEB.1.00.0910041310520.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

we had much fun yesterday!  Just a few quotes so you know what I mean:

"Mac's your mistress, Windows' your wife" (Michael)

"I'm your user base" (Thorsten)

"We have 3 maintainers working on one master branch, and it is...
working" (Steffen)

[inappropriate joke censored]

"Yes, it is possible. But it will be hard." (Sverre)

"I am the ambassador of the ugly and the stupid" (Michael)

"Michael talked about what Subversion can do that Git cannot" -- "And I 
wasn't even hurt!"


Wrap-up:

We were kindly offered hosting by the Zuse-Institut Berlin (thanks 
Steffen) and there was always a ready supply of coffee and snacks, as well 
as a pretty fast internet connection.

After a round of introductions (apart from this developer, there were 
Michael Haggerty, Jens Lehmann, Heiko Voigt, Thorsten (I did not catch the 
surname), Sebastian Schuberth, Steffen Prohaska, Christian Halstrick and 
Sverre Rabbelier; Gitzilla and his friend Kristen joined us in the late 
afternoon), I started out with a few (hopefully interesting) tidbits and 
trivia about msysGit.  I also discussed the relationship between Cygwin, 
MSys, MinGW32 and msysGit, as well as why git-svn is so slow on Windows 
(and what one can do about it).

Then Michael talked a little bit about the versioning and the branching as 
well as common merging techniques in CVS, and how Subversion handles 
similar scenarios.  I was stunned to hear that Subversion allows you to 
cherry-pick commits, and even parts of a commit, from other branches, and 
keep track of it (i.e. remember at a later merge that this was already 
merged, and take that into account).  This is definitely something Git 
cannot do, and I can see that people could miss this feature after a 
SVN->Git switch.  I was also suprised to learn that Subversion allows you 
to edit commit messages and even authorship after the fact, but not 
patches.

Sverre went on to describe his work on hg-git and his plans to integrate 
it as a foreign vcs, which was when we had quite a few words on the 
current state of affairs of the foreign vcs support.  You all know what I 
mean.  We also discussed the possibility of git-remote-svn, which was seen 
as the natural way to integrate Subversion repositories as proper Git 
submodules... _iff_ we will be able to specify the clone URL together with 
the type as one line (i.e. optimizing for the common case instead of the 
obscure one).  One important outcome of that discussion was that we 
_cannot_ imitate git-svn there, as the commit messages and authorships can 
be edited (see above), so we would need to record the commits with a 
standard author and only the revision number as commit message, and put 
the mutable information into notes.  Git-svn can get away with the way it 
does things because it is meant to be single-user only, but with 
remote-svn submodules, you have to make sure that _every_ user will get 
the same SHA-1s regardless of when they happened to clone the Subversion 
repository.

Then Thorsten, who described himself as "probably the only person in the 
room without commits in git.git, so I guess I'm your user base" let us 
have some glimpses of real-world problems with Git.  One thing that was 
pretty obvious after thinking about it is the naming of branches.  Git is 
way too liberal, e.g. it allows "git checkout -b origin/master", when 
clearly "-t" was meant (and a look around told me that _everybody_ had 
this problem at some stage).  Unfortunately, it did not occur to us to 
discuss what can be done about these issues, let alone to make a list of 
them.

Jens offered some inside-stories of a company switching from RCS(!) to 
Git.  He also described himself and Heiko as heavy users of submodules, 
and took some time to explain in how many ways submodules are the 
neglected ugly duckling of Git.  He also showed us some of his 
work-in-progress to do something about it.  Another part of the 
presentation was an in-depth account how important msysGit was to the 
adoption of Git in the company.

Christian, who is working for SAP, and recently got involved in the 
eGit/JGit story, related a few interesting facts about the company he 
works for.  Already in 2001, they had a strong need for distributed 
version control, and came up with their own tool.  When they realized just 
how far Git advanced, a rather surprising change in policy allowed him not 
only to look into eGit/JGit, but also to work on it.  Which he did later 
that day, too, finding a bug in my diff implementation ;-)

Steffen and Sebastian then told us about another example of Git in a 
corporate setting.  What some of the Open Source guys did not appreciate 
fully before that presentation was that some things that cannot happen in 
Open Source are unavoidable in a company.  For example, you will always 
find people who work actively against having their patches reviewed.  
Another example is that accountability, and therefore code ownership, can 
be really necessary.  Steffen also described some of the issues with 
working on a large number of topic branches that need to be 
integrated/cleaned up/rebased:  Git lacks good tools for working 
collaboratively with topic branches that need to be rebased frequently.  
He also showed a rather complicated script that is necessary to coordinate 
work between 3 different maintainers (at 3 different locations).

We also got some hacking done, e.g. Heiko, Sebastian and me on 
Git-Cheetah, and of course the utterly useful "mispel" patch (that has not 
made it into git.git yet, much to my chagrin).  But most of the time we 
just had a good time and talked about what we love.

Oh, and Gitzilla entertained the whole party by recounting a few of the 
most hilarious emails authored by yours truly.

The unanimous consensus at the end of the day, after we were for dinner, 
was that we should do this more often: Git together.

Ciao,
Dscho




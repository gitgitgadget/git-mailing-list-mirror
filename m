From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Sanity Check: scrum teams, shared 'story branches', rebasing
	shared branches
Date: Sun, 10 Jun 2012 17:48:12 +0200
Message-ID: <20120610154810.GA2427@book.hvoigt.net>
References: <3EA7D039-9D6E-4945-A982-43DB53AAE43A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christofer Jennings <boz.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 17:48:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdkNI-0007iT-Da
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 17:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2FJPsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 11:48:16 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:41687 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab2FJPsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 11:48:15 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SdkNA-00005Q-RZ; Sun, 10 Jun 2012 17:48:12 +0200
Content-Disposition: inline
In-Reply-To: <3EA7D039-9D6E-4945-A982-43DB53AAE43A@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199608>

Hi,

On Sat, Jun 09, 2012 at 04:51:28PM -0700, Christofer Jennings wrote:
> I've been using Git and GitHub for ~6 months. Working on a SCM plan
> for a Scrum project with 50+ developers in ~8 dev. teams. Each team
> will be working on one or two stories simultaneously, so expect ~16
> 'story branches' (and master) at any given time. We've got GitHub
> Enterprise and are working out how to manage story development on
> shared branches that get merged to master only after going through
> acceptance & peer review. We hope stories will only be 3 - 5 days to
> complete, but may take 2 weeks. We're promoting frequent pushes to
> story branches.
> 
> After a number of experiments and doing online research, we're
> thinking to use rebase to keep the story branches up-to-date with
> master while the story branches are in development. This seems to be
> the best approach because it will allow us to use bisect to isolate
> issues, and it will give us the most linear history graph. 

In my experience rebasing branches does only work seamlessly when one
developer (or one machine for a pair programming setup) is working on
the branch being rebased. Having a one branch per story for multiple
developers which will be frequently rebased sounds like it will
introduce a lot of branch management work.

IMO, even though branching and merging is cheap in git the goal to merge
as early as possible still applies. Having long lived seperate branches
has the potential to introduce a lot of conflicts.

If you are doing scrum you probably will divide the user story into
tasks. I would suggest to do short task branches which can be reviewed
and merged into one main branch (probably master) after one or two days.
That way you minimize the risk of a big integration hell when all teams
want to merge their changes after their story is done.

Just my ideas how things can work best.

Cheers Heiko

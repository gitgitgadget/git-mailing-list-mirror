From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git svn dcommit crashed -- how do I resume?
Date: Wed, 26 Nov 2008 11:42:11 +0200
Message-ID: <87k5aqlt70.fsf@iki.fi>
References: <E8293DEF-109A-4F57-BD4F-7F189976DA79@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Neuhalfen <JensNeuhalfen@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 10:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Gvi-000095-Oq
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 10:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbYKZJmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 04:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbYKZJmP
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 04:42:15 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:46482 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbYKZJmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 04:42:14 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A8801B802AF; Wed, 26 Nov 2008 11:42:12 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1L5GuR-00018A-Ui; Wed, 26 Nov 2008 11:42:11 +0200
In-Reply-To: <E8293DEF-109A-4F57-BD4F-7F189976DA79@gmx.de> (Jens Neuhalfen's message of "Wed\, 26 Nov 2008 09\:22\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101717>

Jens Neuhalfen (2008-11-26 09:22 +0100) wrote:

> I am using git as a frontend to my SVN-Repository. When I tried to
> "git svn dcommit" several changes from my local git-repository, git
> crashed (SEGFAULT, AFAIR).

> I am confused (an slightly panicked), because my old commits seem to
> be "gone", my WC does not contain the most recent files and there
> seems to be no "backup-branch" with my old HEAD.

I don't know why the the dcommit crashed but I'm certain that you can
find your previous commits through the reflog. Try (one of) these
commands:

    git log --walk-reflogs [branchname]
    git log --walk-reflogs HEAD

They will show a list of commits about where [branchname] or HEAD has
been previously in _your_ repository. If/when you find the correct
commit (where you think the branch's head should be) copy its SHA1 and
create a new branch from it (git branch new-branch [SHA1]) - or just
reset the broken branch to that commit (git reset --hard [SHA1]).

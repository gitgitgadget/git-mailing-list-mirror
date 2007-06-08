From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk highlighting commits
Date: Fri, 8 Jun 2007 02:57:39 -0400
Message-ID: <20070608065739.GC18521@spearce.org>
References: <20070608084501.1b66f16a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: picca <picca@synchrotron-soleil.Fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 08:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwYPu-0003ut-Ab
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 08:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761020AbXFHG5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 02:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761000AbXFHG5o
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 02:57:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38736 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760950AbXFHG5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 02:57:43 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1HwYPk-0003bx-4P; Fri, 08 Jun 2007 02:57:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9404E20FBAE; Fri,  8 Jun 2007 02:57:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070608084501.1b66f16a@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49444>

picca <picca@synchrotron-soleil.Fr> wrote:
> I am using git to follow the wine development. And I wondering if it
> is possible to highlight all the commit since my last git pull ?

If you do it *right after* the pull, you can see those commits that
are new to you with:

	gitk ORIG_HEAD..

ORIG_HEAD is a special name for the commit that you had just before
you pulled.  So you are asking gitk to show you all commits that
are now in your current branch (implied by nothing to the right of
the ..) that were not in your branch before the pull (ORIG_HEAD).
That is the stuff you just pullled.

If its many days later that you want to look at this and you have
done some things that overwrite ORIG_HEAD (git reset; git rebase;
etc.)  then this becomes more difficult.  But you can also do by
time:

  gitk HEAD@{2.days.ago}..

This shows you everything that is new *to you* in the past two days.
Even if the changes were created months ago and just recently were
pulled by you yesterday, they will appear in gitk, because you asked
for *your* history over the past two days, not the project history.

These same tricks also work with git-log of course:

  git log ORIG_HEAD...
  git log HEAD@{2.days.ago}..

You could also take a look at the manual page for git-rev-parse,
there are some more details covered there I think.
 
-- 
Shawn.

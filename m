From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: New JGit project history
Date: Tue, 29 Sep 2009 17:28:12 -0700
Message-ID: <20090930002812.GA14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: egit-dev@eclipse.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 02:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msn3L-0008Gu-Dt
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 02:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbZI3A2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 20:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbZI3A2J
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 20:28:09 -0400
Received: from george.spearce.org ([209.20.77.23]:60546 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbZI3A2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 20:28:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8509B381FE; Wed, 30 Sep 2009 00:28:12 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129329>

As the JGit project is moving to eclipse.org (but is retaining
its current BSD license) we have to start the project history all
over again.  The Eclipse Foundation won't permit the project to
host the older LGPL history before our switch to the BSD license,
so we have had to filter it out.

I have posted the new JGit history for the new eclipse.org based
repository to the existing repo.or.cz/jgit repository, in the
branch eclipse.org-post.

In theory, you can migrate a topic branch that is a still in progress
by rebasing with the proper split points:

  git rebase -m --onto origin/eclipse.org-post origin/eclipse.org-pre

A complication is the packages were renamed from 'org.spearce' to
'org.eclipse', which means the rename detection stuff is going to
have some fun trying to perform a merge here, and new source files
will need to be adjusted manually.

In the new history the shell script tools/graft-old-history.sh
can be used to create a graft point to pick up the old history,
for use by data mining history tools like log and blame.

Going forward, all pending contributions should be targeting the
new history, and the new package namespace.

-- 
Shawn.

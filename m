From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial
	poms  from Jasons branch Signed-off-by: Mark Struberg
	<struberg@yahoo.de>
Date: Wed, 30 Sep 2009 14:16:46 -0700
Message-ID: <20090930211646.GM14660@spearce.org>
References: <2c6b72b30909280546l62a6ef9cm21112ca071cdef4c@mail.gmail.com> <287437.36328.qm@web27806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, Jason van Zyl <jvanzyl@sonatype.com>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Wed Sep 30 23:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt6Xb-0008Ue-UL
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 23:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbZI3VQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 17:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbZI3VQn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 17:16:43 -0400
Received: from george.spearce.org ([209.20.77.23]:37237 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZI3VQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 17:16:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 55994381FE; Wed, 30 Sep 2009 21:16:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <287437.36328.qm@web27806.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129360>

Mark Struberg <struberg@yahoo.de> wrote:
> > From: Jonas Fonseca <jonas.fonseca@gmail.com>
> > actually
> > removes features (by not keeping the JGit specific
> > settings), which
> > you then try to amend later in the patch series.
> 
> I'm not sure what JGit specific settings you speak about?

I think he's talking about the Eclipse settings files?  Or is it
something else?
 
> > In terms of making the patch series more manageable for
> > you, I think
> > the best approach is to start with the patches not relevant
> > to the
> > mavenizing (renaming PathSuffixTestCase). 
> 
> In fact the fix of the PathSuffixTestCase came a few days later
> after I found the reason why I miss a few tests. This should be
> fixed in the current master anyway and has not so much todo with
> the mavenization itself.

But it should be earlier in the series because its easier to apply.
Use rebase -i to swap the order of the patches.

> I had the following in mind: every single commit should be
>  compileable and working. So it's not easily manageable to move the
> directory structure in one patch and apply all the changes into
> the poms in another commit.

Well, you need to edit the pom to change the source directory and do
the move in one commit, and then edit the pom further in another,
possibly removing the source directory directories once it is the
standard maven layout.

> We could for sure squash the later few commits, but I didn't
> liked to rebase and push since there have been a few forks of the
> mavenize branch and I hoped I could pull back a few commits from
> others and later do a rebase -i.

True.

At this point we need to rebase the patches on the new history in
the eclipse.org-post branch, which contains a massive rename of
org.spearce to org.eclipse.  That may make the tree reorg patch in
your Maven series harder to bring over to the new history, sorry.

Worse, we now have to start following the Eclipse IP process[1]
for submissions to JGit...

[1] http://www.eclipse.org/projects/dev_process/ip-process-in-cartoons.php

-- 
Shawn.

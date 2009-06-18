From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Rename org.spearce.egit -> org.eclipse.egit
Date: Thu, 18 Jun 2009 16:24:31 -0700
Message-ID: <20090618232431.GR11191@spearce.org>
References: <1245253576-13324-1-git-send-email-spearce@spearce.org> <200906190120.29915.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: egit-dev@eclipse.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 01:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHQyE-00015i-JB
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 01:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZFRXYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 19:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZFRXY3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 19:24:29 -0400
Received: from george.spearce.org ([209.20.77.23]:52320 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbZFRXY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 19:24:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9A889381FD; Thu, 18 Jun 2009 23:24:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906190120.29915.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121878>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> 
> Need an idea on how to proceed here. There is a problem related to updating
> plugins here. We have renamed feature with one unrenamed plugin. How
> to we avoid problem when switching from org.spearce to org.eclipse
> 
> One option is to release a v0.4.1 (which we should do anyway), which is the last
> version from master before the split. For technical reasons this will be
> a branch since the split occurred already.
> 
> That 0.4.1 feature should require jgit < 0.5. Then we jgit to v0.5 and
> make org.eclipse.egit require jgit >= 0.5
> 
> Having two EGit features will be confusing. You get two of everything. E.g.
> Team>Share will have two Git's to choose from, but you cannot tell which
> is which.
> 
> That said, having both could be a feature, since it (didn't really try it), would
> be possible to switch between new and old workspaces and get the plugin
> configured for that workspace. The wierdness make me suggest we do
> not do this. If we really want it we could choose to create a proxy plugin
> for attaching old workspaces to the new plugins.

Yikes.  I didn't even consider this.  My own workspaces freaked out
at the change, but I just deleted the projects from the workspace,
re-imported them, and re-attached them to the new team provider.
I never even gave it a second thought.

You're right, we should have a better plan for existing deployments.

Its a good thing I didn't just shove this into the tree, even though
it seemed simple on the surface.  Too simple.  :-)

I like the 0.5 cut to define jgit versions pre/post split.  But I'm
really not sure what to do about the rename on the EGit team provider
for existing workspaces.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit] Git repository with multiple eclipse projects ?
Date: Wed, 25 Nov 2009 16:48:17 -0800
Message-ID: <20091126004817.GL11919@spearce.org>
References: <20091125164734.GF21347@linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSX1-0002Rz-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935210AbZKZAsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935117AbZKZAsM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:48:12 -0500
Received: from george.spearce.org ([209.20.77.23]:44070 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935116AbZKZAsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:48:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D19933842F; Thu, 26 Nov 2009 00:48:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091125164734.GF21347@linagora.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133743>

Yann Dirson <ydirson@linagora.com> wrote:
> I am investigating whether it is possible at all to have several
> eclipse projects in a single git repo, and have those projects
> correctly seen as managed by git.

As Robin said, it should work.  EGit and JGit both use this layout.
 
> When importing a git repo into eclipse, we get a list of projects to
> import, but that list is empty.  What is expected by egit to get this
> list filled ?

There should be .project files in the repository.  I think we scan
the entire checkout tree for .project files, but maybe we are doing
something stupid and only looking at the top level directory of
the checkout.

> It also does not look like it would be possible to use the "share"
> functionnality to setup such a repository from multiple projects (or
> from a project set), right ?

Nope, I don't think this is supported right now.  You need to
initialize the git repository by hand in the higher level directory
that holds the projects.

-- 
Shawn.

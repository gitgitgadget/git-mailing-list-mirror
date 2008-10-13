From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 07:09:38 -0700
Message-ID: <20081013140938.GM4856@spearce.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 16:11:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpO8J-0007Nr-Ef
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 16:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbYJMOJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 10:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbYJMOJj
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 10:09:39 -0400
Received: from george.spearce.org ([209.20.77.23]:55428 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbYJMOJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 10:09:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 428073835F; Mon, 13 Oct 2008 14:09:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98113>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Some confusing tutorials suggested that it would be a good idea to fetch
> into the current branch with something like this:
> 
> 	git fetch origin master:master
> 
> (or even worse: the same command line with "pull" instead of "fetch").
> While it might make sense to store what you want to pull, it typically
> is plain wrong when the current branch is "master".
> 
> As noticed by Junio, this behavior should be triggered by _not_ passing
> the --update-head-ok option, but somewhere along the lines we lost that
> behavior.
> 
> NOTE: this patch does not completely resurrect the original behavior
> without --update-head-ok: the check for the current branch is now _only_
> performed in non-bare repositories.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> 	Strangely, some more tests refused to pass this time, because they
> 	did not use --update-head-ok; this was fixed, too.

Not strange, --update-head-ok was busted and the tests took advantage
of it.  :-\
 
-- 
Shawn.

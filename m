From: David Watson <dwatson@mimvista.com>
Subject: Re: how do you "force a pull"?
Date: Sat, 25 Aug 2007 07:37:47 -0400
Message-ID: <20070825113747.GA21030@mimvista.com>
References: <20070825111946.GA7122@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 13:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOtwi-0006Up-37
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 13:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbXHYLgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 07:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764904AbXHYLgk
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 07:36:40 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:45463
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754613AbXHYLgk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2007 07:36:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 93C91517D3
	for <git@vger.kernel.org>; Sat, 25 Aug 2007 07:35:21 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: 1.029
X-Spam-Level: *
X-Spam-Status: No, score=1.029 tagged_above=-10 required=6.6
	tests=[AWL=-0.364, BAYES_00=-2.599, RCVD_IN_NJABL_DUL=1.946,
	RCVD_IN_SORBS_DUL=2.046]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8KhVXbcPs-5b for <git@vger.kernel.org>;
	Sat, 25 Aug 2007 07:35:17 -0400 (EDT)
Received: from localhost (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by zimbra.mimvista.com (Postfix) with ESMTP id 174945189C
	for <git@vger.kernel.org>; Sat, 25 Aug 2007 07:35:17 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070825111946.GA7122@falcon.digizenstudio.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56632>

The commit you pulled should still be in your local repository (repo2),
unless you've done something to deliberately remove it.

If you're using the default repository setup when cloning, then master
branch of repo1 should be available as origin/master, so you can do the
following:

$ git reset --hard origin/master

or log:

$ git log origin/master

If you want to see all your branches, local or remote:

$ git branch -r

Note that you shouldn't checkout origin/master and work on it, but rather
you'll want to make a branch, and work on that:

$ git co -b fancy_branch origin/master

You may be getting the "cannot merge message" if you have uncommitted
changes, as git won't let you merge when the working copy is changed.
git-pull is really git-fetch + git-merge.

On Sat, Aug 25, 2007 at 07:19:46AM -0400, Jing Xue wrote:
> I am working in repo1, and make a savepoint commit and pack up and leave.
> 
> On another machine, I have a clone of repo1 (repo2). So I pull from
> repo1, "git reset --soft HEAD" to get rid of the savepoint commit, and start working in repo2.
> 
> A while later I realize the earlier commit was actually a good commit
> point. But I can no longer pull it again from repo1. It keeps giving me
> the "Cannot merge" fatal error. "-f" doesn't help.
> 
> So in general my question is "how do you force pulling from a remote
> repository?"  (short of, you know, recloning the repo...)
> 
> I have a feeling that either I'm still stuck in the traditional central-repository
> mentality, or missing something real simple.
> 
> Thanks.
> -- 
> Jing Xue
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dave Watson

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: "git svn reset" only resets current branch ?
Date: Tue, 7 Jul 2009 13:28:27 -0700
Message-ID: <20090707202826.GA8618@dcvr.yhbt.net>
References: <46974.10.0.0.1.1246953668.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Jackson <ben@ben.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHHH-0005fU-49
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbZGGU23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbZGGU22
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:28:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34091 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876AbZGGU22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:28:28 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF051F4EA;
	Tue,  7 Jul 2009 20:28:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <46974.10.0.0.1.1246953668.squirrel@intranet.linagora.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122873>

Yann Dirson <ydirson@linagora.com> wrote:
> > I think the current behavior is a reasonable default; it's least
> > surprising to me and the user could more easily rerun with "--all" if
> > needed.  If --all were the default, the user could potentially
> > have to refetch a lot of data they didn't want to.
> 
> As an alternative, we could also allow "git svn reset" to take us back
> into the future to undo any such mistake without refetching.
> 
> I'm not sure it would be the best to keep reset act on a single branch,
> where eg. fetch acts on all branches, and already has a --all flag, which
> is not yet documented, and seems to have a different meaning (if that
> wasn't obvious, I have still not had a look at what it really does ;)

fetch with --all fetches from all "svn-remotes" defined in the config
(it's rare to have more than one).  It's roughly equivalent to:

  git remote | xargs -n1 git fetch

As far as reset behavior goes, I'll leave you and Ben to decide how/what
to do since I've never used it myself (I rarely even use git svn
nowadays).

-- 
Eric Wong

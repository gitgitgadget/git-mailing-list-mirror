From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] git-svn: Make following parents atomic
Date: Mon, 8 Dec 2008 15:35:23 -0800
Message-ID: <20081208233523.GB21675@hand.yhbt.net>
References: <20081207222444.GA10881@euler> <1228717252-1016-1-git-send-email-deskinm@umich.edu> <7v1vwj83sd.fsf@gitster.siamese.dyndns.org> <20081208133131.GA9190@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Tue Dec 09 00:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9pec-00069P-MX
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 00:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbYLHXfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYLHXfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 18:35:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60695 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbYLHXfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 18:35:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 076A52DC01A;
	Mon,  8 Dec 2008 23:35:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081208133131.GA9190@euler>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102591>

Deskin Miller <deskinm@umich.edu> wrote:
> find_parent_branch generates branch@rev type branches when one has to
> look back through SVN history to properly get the history for a branch
> copied from somewhere not already being tracked by git-svn.  If in the
> process of fetching this history, git-svn is interrupted, then when one
> fetches again, it will use whatever was last fetched as the parent
> commit and fail to fetch any more history which it didn't get to before
> being terminated.  This is especially troubling in that different
> git-svn copies of the same SVN repository can end up with different
> commit sha1s, incorrectly showing the history as divergent and
> precluding easy collaboration using git push and fetch.
> 
> To fix this, when we initialise the Git::SVN object $gs to search for
> and perhaps fetch history, we check if there are any commits in SVN in
> the range between the current revision $gs is at, and the top revision
> for which we were asked to fill history.  If there are commits we're
> missing in that range, we continue the fetch from the current revision
> to the top, properly getting all history before using it as the parent
> for the branch we're trying to create.
> 
> Signed-off-by: Deskin Miller <deskinm@umich.edu>

Looks good Deskin, thanks

Acked-by: Eric Wong <normalperson@yhbt.net>

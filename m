From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-new-workdir: Share SVN meta data between work dirs and the repository
Date: Fri, 14 Mar 2008 21:51:51 -0700
Message-ID: <20080315045151.GC3107@hand.yhbt.net>
References: <87ejaczoxu.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Sat Mar 15 05:52:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaONl-0007dH-94
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 05:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYCOEvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 00:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbYCOEvx
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 00:51:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33709 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbYCOEvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 00:51:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 131437F4153;
	Fri, 14 Mar 2008 21:51:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87ejaczoxu.fsf@gollum.intra.norang.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77306>

Bernt Hansen <bernt@norang.ca> wrote:
> Multiple work dirs with git svn caused each work dir to have its own
> stale copy of the SVN meta data in .git/svn
> 
> git svn rebase updates commits with git-svn-id: in the repository and
> stores the SVN meta data information only in that work dir.  Attempting to
> git svn rebase in other work dirs for the same branch would fail because
> the last revision fetched according to the git-svn-id is greater than the
> revision in the SVN meta data for that work directory.
> 
> Signed-off-by: Bernt Hansen <bernt@norang.ca>

Thanks, I've been meaning to add this myself

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  contrib/workdir/git-new-workdir |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> index 2838546..7959eab 100755
> --- a/contrib/workdir/git-new-workdir
> +++ b/contrib/workdir/git-new-workdir
> @@ -63,7 +63,7 @@ mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
>  # create the links to the original repo.  explictly exclude index, HEAD and
>  # logs/HEAD from the list since they are purely related to the current working
>  # directory, and should not be shared.
> -for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache
> +for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
>  do
>  	case $x in
>  	*/*)
> -- 
> 1.5.4.4.537.gb75aa

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Document git-svn's first-parent rule
Date: Mon, 16 Nov 2009 15:14:55 -0800
Message-ID: <20091116231455.GA13460@dcvr.yhbt.net>
References: <ea845c8757a629d692bb6cd3827887f0e811c044.1258366486.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAAml-00043g-AM
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 00:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbZKPXOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 18:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbZKPXOt
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 18:14:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54309 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026AbZKPXOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 18:14:49 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270161F449;
	Mon, 16 Nov 2009 23:14:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ea845c8757a629d692bb6cd3827887f0e811c044.1258366486.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133036>

Thomas Rast <trast@student.ethz.ch> wrote:
> git-svn has the following rule to detect the SVN base for its
> operations: find the first git-svn-id line reachable through
> first-parent ancestry.  IOW,
> 
>   git log --grep=^git-svn-id: --first-parent -1
> 
> Document this, as it is very important when using merges with git-svn.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Thanks Thomas,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  Documentation/git-svn.txt |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 1812890..6da4151 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -735,6 +735,16 @@ merges you've made.  Furthermore, if you merge or pull from a git branch
>  that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
>  branch.
>  
> +If you do merge, note the following rule: 'git svn dcommit' will
> +attempt to commit on top of the SVN commit named in
> +------------------------------------------------------------------------
> +git log --grep=^git-svn-id: --first-parent -1
> +------------------------------------------------------------------------
> +You 'must' therefore ensure that the most recent commit of the branch
> +you want to dcommit to is the 'first' parent of the merge.  Chaos will
> +ensue otherwise, especially if the first parent is an older commit on
> +the same SVN branch.
> +
>  'git clone' does not clone branches under the refs/remotes/ hierarchy or
>  any 'git svn' metadata, or config.  So repositories created and managed with
>  using 'git svn' should use 'rsync' for cloning, if cloning is to be done
> -- 

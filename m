From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: always initialize with core.autocrlf=false
Date: Thu, 9 Apr 2009 09:59:20 -0700
Message-ID: <20090409165920.GA6311@dcvr.yhbt.net>
References: <cover.1239276588u.git.johannes.schindelin@gmx.de> <560e98ae1d5350c6ff8db56d41089900dbaab08a.1239276588u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:01:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrxcb-0007Wd-Mf
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762832AbZDIQ7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 12:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761096AbZDIQ7W
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 12:59:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60943 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759691AbZDIQ7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 12:59:22 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6811F794;
	Thu,  9 Apr 2009 16:59:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <560e98ae1d5350c6ff8db56d41089900dbaab08a.1239276588u.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116181>

Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> It has been reported time and time again in relation to msysGit that
> git-svn does not work well when core.autocrlf has any value other than
> 'false'.  So let's make it so by default.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 8be6be0..d4e8fc8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -325,6 +325,7 @@ sub do_git_init_db {
>  		command_noisy(@init_db);
>  		$_repository = Git->repository(Repository => ".git");
>  	}
> +	command_noisy('config', 'core.autocrlf', 'false');
>  	my $set;
>  	my $pfx = "svn-remote.$Git::SVN::default_repo_id";
>  	foreach my $i (keys %icv) {
> -- 
> 1.6.2.1.613.g25746

-- 
Eric Wong

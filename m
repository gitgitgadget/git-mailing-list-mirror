From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Make create-ignore use git add -f
Date: Sun, 4 May 2008 21:04:33 -0700
Message-ID: <20080505040433.GB13122@untitled>
References: <1209940390-22622-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon May 05 06:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsrxc-0003eO-1o
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 06:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYEEEEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 00:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYEEEEg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 00:04:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40670 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbYEEEEg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 00:04:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C00692DC08B;
	Sun,  4 May 2008 21:04:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1209940390-22622-1-git-send-email-hendeby@isy.liu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81224>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> When having a svn:ignore that ignores the .gitignore file the -f
> option to git add must be used to avoid git complaining about adding
> an ignored file and hence stop the process of creating .gitignores.
> 
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

Acked-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 81afb5c..d6d7b1a 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -612,7 +612,7 @@ sub cmd_create_ignore {
>  		print GITIGNORE "$s\n";
>  		close(GITIGNORE)
>  		  or fatal("Failed to close `$ignore': $!");
> -		command_noisy('add', $ignore);
> +		command_noisy('add', '-f', $ignore);
>  	});
>  }
>  
> -- 
> 1.5.5.1.246.gafa4

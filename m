From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/5] git-instaweb: If firefox was not found, just print the URL
Date: Wed, 26 Jul 2006 15:40:50 -0700
Message-ID: <20060726224049.GA16645@localdomain>
References: <Pine.LNX.4.63.0607261634200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jul 27 00:41:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5s3k-0003Rk-HQ
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 00:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWGZWkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 18:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWGZWkw
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 18:40:52 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42656 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751263AbWGZWkw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 18:40:52 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 499387DC023;
	Wed, 26 Jul 2006 15:40:50 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 26 Jul 2006 15:40:50 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607261634200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24256>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  git-instaweb.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 242b55e..340ab98 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -245,4 +245,5 @@ esac
>  
>  start_httpd
>  test -z "$browser" && browser=echo
> +which "$browser" >/dev/null 2>&1 || browser=echo
>  $browser http://127.0.0.1:$port

>From what I hear, 'which' isn't portable on some platforms.

Now this isn't the only place 'which' is used in instaweb, and I've been
meaning to get rid of the other 'which' call in there for a while, but I
haven't had much time to devote to git the past few weeks.  Help here
would be good.

-- 
Eric Wong

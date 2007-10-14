From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] instaweb: allow for use of auto-generated scripts
Date: Sun, 14 Oct 2007 02:49:22 -0700
Message-ID: <20071014094922.GA20297@soma>
References: <7vodfztviv.fsf@gitster.siamese.dyndns.org> <55e906d58f15c79c61d83ad4c52ef085de8ad736.1191687881.git.mike@csa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mike@csa.net
X-From: git-owner@vger.kernel.org Sun Oct 14 11:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih06H-0005u7-SD
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbXJNJtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 05:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbXJNJtX
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:49:23 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44761 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754988AbXJNJtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:49:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5CD007DC0FE;
	Sun, 14 Oct 2007 02:49:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55e906d58f15c79c61d83ad4c52ef085de8ad736.1191687881.git.mike@csa.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60822>

mike@csa.net wrote:
> this patch allows scripts that reside in $fqgitdir/gitweb to be used
> for firing up an instaweb server. this lays the groundwork for
> extending instaweb support to non-standard web servers, which may
> require a script for proper invocation.
> 
> Signed-off-by: Mike Dalessio <mike@csa.net>

Thanks, sorry for the late reply, it slipped my mind for a while.

Both patches in this series:
Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-instaweb.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index b79c6b6..42d9c34 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -37,7 +37,9 @@ start_httpd () {
>  	else
>  		# many httpds are installed in /usr/sbin or /usr/local/sbin
>  		# these days and those are not in most users $PATHs
> -		for i in /usr/local/sbin /usr/sbin
> +		# in addition, we may have generated a server script
> +		# in $fqgitdir/gitweb.
> +		for i in /usr/local/sbin /usr/sbin "$fqgitdir/gitweb"
>  		do
>  			if test -x "$i/$httpd_only"
>  			then
> -- 
-- 
Eric Wong

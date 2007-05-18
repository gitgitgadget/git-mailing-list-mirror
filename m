From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 05/16] unpack-trees.c: verify_uptodate: remove dead code
Date: Fri, 18 May 2007 15:33:11 -0700
Message-ID: <7vsl9t4va0.fsf@assigned-by-dhcp.cox.net>
References: <11795163053812-git-send-email-skimo@liacs.nl>
	<11795163061911-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpB0i-00059X-50
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbXERWdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbXERWdN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:33:13 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65467 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbXERWdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:33:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518223313.NMVU19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 18:33:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0mZB1X00Z1kojtg0000000; Fri, 18 May 2007 18:33:12 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47671>

skimo@liacs.nl writes:

> From: Sven Verdoolaege <skimo@kotnet.org>
>
> This code was killed by commit fcc387db9bc453dc7e07a262873481af2ee9e5c8.
>
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> ---
>  unpack-trees.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 906ce69..cac2411 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -414,10 +414,6 @@ static void verify_uptodate(struct cache_entry *ce,
>  			return;
>  		errno = 0;
>  	}
> -	if (o->reset) {
> -		ce->ce_flags |= htons(CE_UPDATE);
> -		return;
> -	}
>  	if (errno == ENOENT)
>  		return;
>  	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
> -- 
> 1.5.2.rc3.783.gc7476-dirty

Hmmm.

I am not absolutely sure if the fcc387db change was correct
anymore, but in any case, this removal of dead code should not
break anything.

But this does not belong to your series either.

Perhaps I should apply this to 'master' regardless of the rest
of the series.

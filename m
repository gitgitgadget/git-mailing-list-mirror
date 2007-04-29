From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] Call send-pack with --remote option
Date: Sat, 28 Apr 2007 22:51:53 -0700
Message-ID: <7vps5ng22u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304430.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 07:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi2KE-0002T6-KR
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 07:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbXD2Fvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 01:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223AbXD2Fvz
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 01:51:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62816 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbXD2Fvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 01:51:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429055154.GNOC22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 01:51:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id strt1W00f1kojtg0000000; Sun, 29 Apr 2007 01:51:54 -0400
In-Reply-To: <Pine.LNX.4.64.0704281304430.28708@iabervon.org> (Daniel
	Barkalow's message of "Sat, 28 Apr 2007 13:05:22 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45812>

Daniel Barkalow <barkalow@iabervon.org> writes:

> diff --git a/builtin-push.c b/builtin-push.c
> index 2e944cd..d4734be 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -158,7 +158,7 @@ static int do_push(const char *repo)
>  		refspec = remote->push_refspec;
>  	}
>  
> -	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
> +	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
>  	argv[0] = "dummy-send-pack";
>  	argc = 1;
>  	if (all)

I somehow thought this 10 was there not because we counted but
we know 10 gives us enough slop.  Adding one because we give an
extra parameter, while it is logically correct, feels somewhat
funny.  But I do not have a better suggestion (unless we count
exactly which we cannot do).

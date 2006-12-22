From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-tag: support -F <file> option
Date: Thu, 21 Dec 2006 22:47:42 -0800
Message-ID: <7vvek45svl.fsf@assigned-by-dhcp.cox.net>
References: <emdsi9$ecm$1@sea.gmane.org>
	<Pine.LNX.4.63.0612211512160.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 07:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxeCC-0002xy-J9
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 07:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423179AbWLVGro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 01:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423181AbWLVGro
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 01:47:44 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51341 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423179AbWLVGrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 01:47:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222064742.QAFF9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 01:47:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1in01W0031kojtg0000000; Fri, 22 Dec 2006 01:47:00 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612211512160.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Dec 2006 15:13:02 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35134>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This imitates the behaviour of git-commit.
>
> Noticed by Han-Wen Nienhuys.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ok, but what the **** is "die ...; exit 2" sequence?

> @@ -45,6 +45,17 @@ do
>  	    message_given=1
>  	fi
>  	;;
> +    -F)
> +	annotate=1
> +	shift
> +	if test "$#" = "0"; then
> +	    die "error: option -F needs an argument"
> +	    exit 2
> +	else
> +	    message="$(cat "$1")"
> +	    message_given=1
> +	fi
> +	;;

I know it was copied from Han-Wen's aabd7693, but was this
somehow to catch the case where die can fail???

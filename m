From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, nitpickingly final version] git-branch, git-checkout: autosetup for remote branch tracking
Date: Thu, 08 Mar 2007 02:22:37 -0800
Message-ID: <7vabyo9gr6.fsf@assigned-by-dhcp.cox.net>
References: <45EFB205.4000604@lu.unisi.ch>
	<7vzm6o9ie1.fsf@assigned-by-dhcp.cox.net>
	<45EFDE4B.3010408@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFlj-0007pp-Bm
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 11:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXCHKWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbXCHKWj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 05:22:39 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55820 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXCHKWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 05:22:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308102239.ZSAU2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 05:22:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YANe1W0021kojtg0000000; Thu, 08 Mar 2007 05:22:38 -0500
In-Reply-To: <45EFDE4B.3010408@lu.unisi.ch> (Paolo Bonzini's message of "Thu,
	08 Mar 2007 10:58:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41735>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> 	This fixes all the nits you pointed out. :-D
> 	Now, this was an experience to make...

Thanks.

Will apply after reviewing once more tomorrow, with fix-ups
locally if needed.  No need to resend.

> +
> +	colon = strchr(value, ':');
> +        if (!colon)

s/^\040{8}/\011/;

> diff --git a/trace.c b/trace.c
> index 27fef86..27b2e85 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -41,13 +41,15 @@ static in...
> +int nfasprintf(char **str, const char *fmt, ...)
>  {
> +	int rc;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	rc = nfvasprintf(str, fmt, args);
> +	va_end(args);
> +	return args;
>  }

s/return args/return rc/;

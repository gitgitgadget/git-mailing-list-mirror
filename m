From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: detached HEAD
Date: Thu, 25 Jan 2007 16:16:51 -0800
Message-ID: <7vireu63rg.fsf@assigned-by-dhcp.cox.net>
References: <87zm875d9u.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 01:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEm1-0002LP-Ge
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 01:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030668AbXAZAQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 25 Jan 2007 19:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030669AbXAZAQy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 19:16:54 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38274 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030668AbXAZAQx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jan 2007 19:16:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126001653.OXCV15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 19:16:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FcFv1W00J1kojtg0000000; Thu, 25 Jan 2007 19:15:56 -0500
In-Reply-To: <87zm875d9u.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Thu, 25
	Jan 2007 16:36:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37787>

Santi B=E9jar <sbejar@gmail.com> writes:

> Do not say 'Merge ... into HEAD' when detached.
>
> Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
> ---
>  builtin-fmt-merge-msg.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
> index 87d3d63..8cef425 100644
> --- a/builtin-fmt-merge-msg.c
> +++ b/builtin-fmt-merge-msg.c
> @@ -331,7 +331,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv=
, const char *prefix)
>  			printf(" of %s", srcs.list[i]);
>  	}
> =20
> -	if (!strcmp("master", current_branch))
> +	if (!strcmp("master", current_branch) ||
> +	    !strcmp("HEAD", current_branch))
>  		putchar('\n');
>  	else
>  		printf(" into %s\n", current_branch);

Hmph.

The reason is?

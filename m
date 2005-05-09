From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] Add cg-printenv command.
Date: Sun, 8 May 2005 21:25:28 -0600
Message-ID: <200505082125.28521.elenstev@mesatop.com>
References: <200505081911.10371.elenstev@mesatop.com> <1115601540.8949.104.camel@pegasus> <7vpsw115v0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marcel Holtmann <marcel@holtmann.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 05:23:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUyrc-0000p5-1I
	for gcvg-git@gmane.org; Mon, 09 May 2005 05:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVEIDa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 23:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVEIDa2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 23:30:28 -0400
Received: from nacho.zianet.com ([216.234.192.105]:13577 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S263032AbVEIDaT
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 23:30:19 -0400
Received: (qmail 84369 invoked from network); 9 May 2005 03:30:17 -0000
Received: from 216-31-65-49.zianet.com (216.31.65.49)
  by 0 with SMTP; 9 May 2005 03:30:17 -0000
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.6.1
In-Reply-To: <7vpsw115v0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 08 May 2005 08:38 pm, Junio C Hamano wrote:
> MH> Hi Steven,
> >> The cg-printenv command will print exported git environment variables.
> SC> +echo "AUTHOR_NAME="$AUTHOR_NAME
> SC> +echo "AUTHOR_EMAIL="$AUTHOR_EMAIL
> SC> +echo "AUTHOR_DATE="$AUTHOR_DATE
> SC> +echo "COMMIT_AUTHOR_NAME="$COMMIT_AUTHOR_NAME
> SC> +echo "COMMIT_AUTHOR_EMAIL="$COMMIT_AUTHOR_EMAIL
> 
> MH> I like that idea. It is much more handy then using env and grep for the
> MH> variable names.
> 
> I wonder what this command is used for?  In a script to be
> "eval"ed?  Or just interactively by the end-user?

I had intended it only as a quick check by an end-user before doing
a commit that the values had been set as desired.

> 
> Even if it is just for human consumption, I think the echo
> commands I quoted above have double quotes backwards.  Wouldn't
> it make more sense to quote the variables so shell expansion
> would not lose whitespaces inside of variable values, like this?
> 
>     echo AUTHOR_NAME="$AUTHOR_NAME"
>     echo AUTHOR_EMAIL="$AUTHOR_EMAIL"
>     echo AUTHOR_DATE="$AUTHOR_DATE"
>     echo COMMIT_AUTHOR_NAME="$COMMIT_AUTHOR_NAME"
>     echo COMMIT_AUTHOR_EMAIL="$COMMIT_AUTHOR_EMAIL"
> 
My simple testing didn't result in any meaningful whitespace loss,
but I only had a single blank character inside my test strings.  Your
method is better.

[steven@spc cogito]$ echo "AUTHOR_NAME="$AUTHOR_NAME
AUTHOR_NAME=Homer Simpson
[steven@spc cogito]$ echo COMMIT_AUTHOR_NAME="$COMMIT_AUTHOR_NAME"
COMMIT_AUTHOR_NAME=Two  Spaces  Here

> If it is for eval consumption of course they have to be much
> more careful.
> 

If Petr wants to add this command, he can either move the double quotes
or I can submit a modified patch.

Thanks,
Steven

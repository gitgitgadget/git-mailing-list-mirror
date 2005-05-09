From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add cg-printenv command.
Date: Sun, 08 May 2005 19:38:11 -0700
Message-ID: <7vpsw115v0.fsf@assigned-by-dhcp.cox.net>
References: <200505081911.10371.elenstev@mesatop.com>
	<1115601540.8949.104.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Cole <elenstev@mesatop.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 04:31:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUy3H-0006KZ-0D
	for gcvg-git@gmane.org; Mon, 09 May 2005 04:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVEICiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 22:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbVEICiT
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 22:38:19 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14268 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263024AbVEICiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 22:38:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050509023812.HRWK20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 22:38:12 -0400
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1115601540.8949.104.camel@pegasus> (Marcel Holtmann's message
 of "Mon, 09 May 2005 03:19:00 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

MH> Hi Steven,
>> The cg-printenv command will print exported git environment variables.
SC> +echo "AUTHOR_NAME="$AUTHOR_NAME
SC> +echo "AUTHOR_EMAIL="$AUTHOR_EMAIL
SC> +echo "AUTHOR_DATE="$AUTHOR_DATE
SC> +echo "COMMIT_AUTHOR_NAME="$COMMIT_AUTHOR_NAME
SC> +echo "COMMIT_AUTHOR_EMAIL="$COMMIT_AUTHOR_EMAIL

MH> I like that idea. It is much more handy then using env and grep for the
MH> variable names.

I wonder what this command is used for?  In a script to be
"eval"ed?  Or just interactively by the end-user?

Even if it is just for human consumption, I think the echo
commands I quoted above have double quotes backwards.  Wouldn't
it make more sense to quote the variables so shell expansion
would not lose whitespaces inside of variable values, like this?

    echo AUTHOR_NAME="$AUTHOR_NAME"
    echo AUTHOR_EMAIL="$AUTHOR_EMAIL"
    echo AUTHOR_DATE="$AUTHOR_DATE"
    echo COMMIT_AUTHOR_NAME="$COMMIT_AUTHOR_NAME"
    echo COMMIT_AUTHOR_EMAIL="$COMMIT_AUTHOR_EMAIL"

If it is for eval consumption of course they have to be much
more careful.


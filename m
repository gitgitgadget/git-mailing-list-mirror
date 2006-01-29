From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-{list,parse}: allow -n<n> as shorthand for --max-count=<n>
Date: Sun, 29 Jan 2006 12:15:27 -0800
Message-ID: <7vbqxukcyo.fsf@assigned-by-dhcp.cox.net>
References: <20060124072946.GA9468@Muzzle>
	<7vd5iicauh.fsf@assigned-by-dhcp.cox.net>
	<20060125063325.GA7953@mail.yhbt.net> <20060129134056.GA3428@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 21:15:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3IxQ-0000Qg-C6
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWA2UP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWA2UP3
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:15:29 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:18862 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751154AbWA2UP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:15:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129201430.IUGT3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 15:14:30 -0500
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15240>

Eric Wong <normalperson@yhbt.net> writes:

> Both -n<n> and -n <n> are supported.  POSIX versions of head(1) and
> tail(1) allow their line limits to be parsed this way.  I find
> --max-count to be a commonly used option, and also similar in spirit to
> head/tail, so I decided to make life easier on my worn out (and lazy :)
> fingers with this patch.

I agree with this in principle.

> diff --git a/rev-parse.c b/rev-parse.c
> index 7abad35..3790463 100644
> --- a/rev-parse.c
> +++ b/rev-parse.c
> @@ -21,6 +21,7 @@ static char *def = NULL;
>  static int show_type = NORMAL;
>  static int symbolic = 0;
>  static int output_sq = 0;
> +static int next_arg_is_rev = 0;

Do you need this here, or can it be made auto in main()?

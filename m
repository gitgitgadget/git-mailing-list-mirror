From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-zip-tree to .gitignore
Date: Sun, 27 Aug 2006 15:04:58 -0700
Message-ID: <7vlkp9x2b9.fsf@assigned-by-dhcp.cox.net>
References: <44F17FD5.2030000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 00:04:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSk4-0006i4-QM
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 00:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWH0WEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 18:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWH0WEa
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 18:04:30 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:931 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751201AbWH0WE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 18:04:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827220428.XWZB6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 18:04:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FA4R1V0074Noztg0000000
	Sun, 27 Aug 2006 18:04:26 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F17FD5.2030000@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sun, 27 Aug 2006 13:19:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26122>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>
> diff --git a/.gitignore b/.gitignore
> index 55cd984..58a7c92 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -124,6 +124,7 @@ git-verify-pack
>  git-verify-tag
>  git-whatchanged
>  git-write-tree
> +git-zip-tree
>  git-core-*/?*
>  gitweb/gitweb.cgi
>  test-date

That is sensible.

Although it was my fault applying it already to "master" without
asking this question first, I started to wonder how many more
archive format people would want, and if it might make more
sense to consolidate git-*-tree into a single frontend with an
option to specify the archiver.

We would obviously need to keep git-tar-tree as a backward
compatibility alias for "git archive-tree -f tar", but doing
things that way we do not have to introduce unbounded number of
new git-{zip,rar,...}-tree programs.

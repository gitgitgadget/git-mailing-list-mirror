From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Sat, 26 Aug 2006 23:12:22 -0700
Message-ID: <7vfyfiyaex.fsf@assigned-by-dhcp.cox.net>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
	<115637597423-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 08:12:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHDsP-0004Ey-6O
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 08:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWH0GL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 02:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWH0GL6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 02:11:58 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58543 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750737AbWH0GL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 02:11:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827061157.IQFY27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 02:11:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EuBu1V00v4Noztg0000000
	Sun, 27 Aug 2006 02:11:55 -0400
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <115637597423-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Thu, 24 Aug 2006 01:32:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26088>

Pierre Habouzit <madcoder@debian.org> writes:

> Allow a form of virtualhosting, when %h format is used.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>     This is intended to be a more flexible solution, that also gives virtual
>     hosting as a bonus.

Nicely done, almost.

Having to have the distinction between %p and %P formats feels
somewhat unwieldy, though.  Not that I have a better suggestion.

> +int is_base_path_fmt;
> +int is_user_path_fmt;

I prefer these to be of type "static int".

Although I am not an authority of variable naming, these sound
funny to me.  "is_XXX()" as a function name feels natural,
"is_XXX" as a variable name does not --- it is not clear what
the predicate is talking about.

Maybe "use_fmt_for_base_path" is easier to understand?  I dunno.
Or "user_path_is_fmt"?  That's more logical but still somewhat
feels funny.

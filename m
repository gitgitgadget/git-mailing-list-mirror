From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Nice error message for empty idents
Date: Sat, 18 Feb 2006 10:55:02 -0800
Message-ID: <7vpslko5tl.fsf@assigned-by-dhcp.cox.net>
References: <7vzmkpqco1.fsf@assigned-by-dhcp.cox.net>
	<20060218172731.GV31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 19:55:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAXEc-00010w-97
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 19:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWBRSzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 13:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWBRSzG
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 13:55:06 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9643 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932116AbWBRSzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 13:55:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218185330.FIBX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 13:53:30 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060218172731.GV31278@pasky.or.cz> (Petr Baudis's message of
	"Sat, 18 Feb 2006 18:27:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16420>

Petr Baudis <pasky@suse.cz> writes:

> 	$ git-rev-list --help
> 	fatal: Not a git repository

Hmph, true.  Ideas?

> I agree that the error message itself is bad.

> -	if (!*name || !*email)
> -		die("empty ident %s <%s> not allowed",
> -		    name, email);
> +	if (!*name)
> +		die("empty realname not allowed - please set a realname for your login or use GIT_AUTHOR_NAME");
> +	if (!*email)
> +		die("empty email not allowed - please set your GIT_AUTHOR_EMAIL to a non-empty value");

I've considered doing this, but didn't do it that way, because I
could not figure out what to do with GIT_COMMITTER_NAME.  Also
it might make sense to suggest user.name configuration item in
the error/help message.  Ideas?

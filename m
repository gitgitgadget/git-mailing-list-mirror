From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Sun, 30 Jul 2006 18:20:26 -0700
Message-ID: <7vzmeqa7tx.fsf@assigned-by-dhcp.cox.net>
References: <20060730223754.GA16364@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 03:20:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7MSN-00087s-92
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 03:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWGaBU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 21:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGaBU2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 21:20:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61080 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932504AbWGaBU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 21:20:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731012026.XJTR2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Jul 2006 21:20:26 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060730223754.GA16364@admingilde.org> (Martin Waitz's message
	of "Mon, 31 Jul 2006 00:37:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24487>

Martin Waitz <tali@admingilde.org> writes:

> diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.pl
> similarity index 100%
> rename from gitweb/gitweb.cgi
> rename to gitweb/gitweb.pl
> index 243a2921f849568260e848201d238b3b9fe7e1f2..8e05c335f801d4c52a9b348fa56fccfae36ce621 100755
> --- a/gitweb/gitweb.cgi
> +++ b/gitweb/gitweb.pl
> @@ -24,14 +24,14 @@ our $rss_link = "";
>  
>  # core git executable to use
>  # this can just be "git" if your webserver has a sensible PATH
> -our $GIT = "/usr/bin/git";
> +our $GIT = "@@GIT_BINDIR@@/git";
>  
>  # absolute fs-path which will be prepended to the project path
>  #our $projectroot = "/pub/scm";
> -our $projectroot = "/home/kay/public_html/pub/scm";
> +our $projectroot = "@@GITWEB_PROJECTROOT@@";
>  
>  # version of the core git binary
> -our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
> +our $git_version = "@@GIT_VERSION@@";

I think the other parts are sensible but I am not sure if we
want to report the version of git distribution (your patch), or
the version of git binary the cgi script happens to use (the
current implementation).

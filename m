From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fetch: get the remote branches to merge from the branch properties.
Date: Fri, 22 Sep 2006 17:45:50 -0700
Message-ID: <7vac4rxvep.fsf@assigned-by-dhcp.cox.net>
References: <874puza2qq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 02:45:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQveU-0005dC-Qz
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 02:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWIWApw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 20:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWIWApw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 20:45:52 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14038 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964979AbWIWApv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 20:45:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923004551.XBFT12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 20:45:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rclt1V0041kojtg0000000
	Fri, 22 Sep 2006 20:45:53 -0400
To: Santi <sbejar@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27551>

> If in branch "foo" and this in config:
>
> [branch "foo"]
>        merge=3Dbar
>
> "git fetch": fetch from the default repository and program the "bar"
>              branch to be merged with pull.
>

Your patch has a very strange whitespace damage in it, and I am
not talking about quoted-printable encoding.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fa20e28..b4de243 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -122,6 +122,10 @@ apply.whitespace::
>  branch.<name>.remote::
>         When in branch <name>, it tells `git pull` which remote to fetc=
> h.
>

A tab in context before "When" is expanded into spaces, and the
empty line in the context does not have the leading SP.

> +branch.<name>.merge::
> +       When in branch <name>, it tells `git fetch` the remote branch t=
> o be
> +       merged.
> +

I suspect you wanted to start the new line with a leading tab
before "When" but it is expanded into spaces here.

However, the diff for the other file in the same patch does not
have this problem.

No need to resend, as I hand-applied it to a new topic, but I am
a bit curious why one diff is broken when the other one is not
in the same e-mail message.

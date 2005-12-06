From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Mon, 05 Dec 2005 19:35:15 -0800
Message-ID: <7vslt67v9o.fsf@assigned-by-dhcp.cox.net>
References: <7vr78sebp8.fsf@assigned-by-dhcp.cox.net>
	<14404.1133806037@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 04:36:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjTc5-0002xm-B2
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 04:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbVLFDfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 22:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbVLFDfS
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 22:35:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9106 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751500AbVLFDfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 22:35:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206033435.SICX20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 22:34:35 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13251>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And Junio C Hamano writes:
>  - putenv(3) says
>  - 	The string pointed to by string becomes part of the environment,
>  - 	so altering the string changes the environment.
>
> Good catch, thanks.  The Solaris man page first says the 
> string space is "no longer used", but at the very end warns 
> against using an automatic variable.  Chalk one up for lousy 
> docs.

Same thing for 5.9.

With the "compat update" patch from last night, I managed to
build on a borrowed sparc with Solaris 5.9, but I needed
NO_SETENV myself.  I'd like to throw in another Makefile patch
to catch both 5.8 and 5.9 for this, but would appreciate if
people with various vintage of Solaris boxes can give some
inputs before doing that.

This was done with somewhat stripped down configuration.  I had
to say NO_EXPAT, libiconv was needed but iconv and openssl were
installed at nonstandard places, python was 2.3 so I also said
PYTHON_PATH and WITH_OWN_SUBPROCESS_PY from the make command
line.  But the borrowed box is not what I administer myself, so
I declare victory for now.

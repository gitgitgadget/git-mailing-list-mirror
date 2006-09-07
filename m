From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] autoconf: Add checking for BSD-compatibile 'install' program
Date: Thu, 07 Sep 2006 13:21:36 -0700
Message-ID: <7v8xkvxwa7.fsf@assigned-by-dhcp.cox.net>
References: <200609071431.18343.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 22:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLQNP-0001MD-7s
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 22:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWIGUVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 16:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWIGUVZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 16:21:25 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37797 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751833AbWIGUVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 16:21:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907202123.YCYW18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 16:21:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KYMC1V00f1kojtg0000000
	Thu, 07 Sep 2006 16:21:16 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609071431.18343.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 7 Sep 2006 14:31:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26654>

Jakub Narebski <jnareb@gmail.com> writes:

> Uncomment `AC_PROG_INSTALL' macro in configure.ac, and setting
> `INSTALL' variable in config.mak.in
>
> Add `install-sh' shell script (required when using `AC_PROG_INSTALL'
> macro) scriptversion=2005-11-07.23, taken from KDE SDK 3.5.3.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Perhaps `install-sh' script should be replaced by something simplier,
> for example by script which was sent to git mailing list, but AFAIK
> not accepted.

That somehow sounds like whining.  I do not think it was never
proposed for inclusion but was just offered as a friendly
"somebody else might find it useful".

In any case, I have two issues, but one non-issue first.  I am
not opposed to including install-sh that is maintained somewhere
upstream and GPLv2 compatible.

 - I do not particularly like to have too many autoconf related
   cruft at the toplevel, and I am wondering if we can move it
   to say compat/install-sh.

 - I suspect this fall-back would set "INSTALL = ./install-sh"
   (if you have it in compat, "INSTALL = compat/install-sh").  I
   wonder if it breaks builds in subdirectories
   (i.e. Documentation/ and templates/).

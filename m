From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add uninstall target to Makefile
Date: Fri, 16 Sep 2005 11:01:19 -0700
Message-ID: <7v1x3oopsg.fsf@assigned-by-dhcp.cox.net>
References: <20050916125814.GA8084@igloo.ds.co.ug>
	<7vfys5ndor.fsf@assigned-by-dhcp.cox.net>
	<12c511ca0509161021249c89a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 20:01:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGKWa-00058W-Ua
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbVIPSBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbVIPSBW
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:01:22 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9430 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161209AbVIPSBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 14:01:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916180120.ZQOX6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 14:01:20 -0400
To: tony.luck@gmail.com
In-Reply-To: <12c511ca0509161021249c89a9@mail.gmail.com> (Tony Luck's message
	of "Fri, 16 Sep 2005 10:21:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8698>

Tony Luck <tony.luck@gmail.com> writes:

> Perhaps it would be easier[1] to support "make obsolete-uninstall"
> that would remove
> objects installed by previous generations of git?
>
> -Tony
>
> [1] easier, nicer, cleaner, less detestable, whatever.

And how far back a release should we keep track of the name of
obsolete versions?  /usr/bin/git-uninstall for each particular
version that knows what that version ships _might_ make some
sense, but I do not see much point in having uninstall target in
the Makefile.  Should one be allowed to run make uninstall with
bindir or DESTDIR set to different values from the ones used
when 'make install' was run the last time?  What about things
like "make WITH_SEND_MAIL=YesPlease install"?

Guys, packaged distributions know how to remove obsolete
binaries.  OTOH if you are building from the source and
installing, you are the only one who knows what you are
installing and where.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push refspec URL weirdness
Date: Fri, 24 Mar 2006 22:22:05 -0800
Message-ID: <7vslp7xcvm.fsf@assigned-by-dhcp.cox.net>
References: <E1FMzfr-0006xT-Uq@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 25 07:22:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN2A7-0008M7-Hv
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 07:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWCYGWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 01:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWCYGWI
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 01:22:08 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:3232 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWCYGWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 01:22:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325062206.CGLB17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 01:22:06 -0500
To: git@vger.kernel.org
In-Reply-To: <E1FMzfr-0006xT-Uq@jdl.com> (Jon Loeliger's message of "Fri, 24
	Mar 2006 21:42:47 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17957>

Jon Loeliger <jdl@jdl.com> writes:

> So Junio suggested taking advantage of the fact that the
> default refspec uses git+ssh and use this instead:
>
>     URL: www.example.com:/pub/software/linux-2.6-86xx.git
>     Push: my-branch:public-branch
>
> Which just worked.
>
> So this is either a bug report or google food. :-)

Actually, I did not suggest it as a workaround (I've never used
git+ssh:// URL myself -- I'm old fashioned -- and always used
host:path syntax).  If git+ssh:// insists on the fixed port, it
surely is broken, but I do not see how it would make a
difference.  In either case, connect.c::git_connect() goes
PROTO_SSH codepath which never opens a tcp connection itself --
it just calls the same "ssh" command.

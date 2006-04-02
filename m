From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] pack-objects: be incredibly anal about stdio semantics
Date: Sun, 02 Apr 2006 14:09:02 -0700
Message-ID: <7vmzf3k7m9.fsf@assigned-by-dhcp.cox.net>
References: <824.1144007555@lotus.CS.Berkeley.EDU>
	<Pine.LNX.4.64.0604021312510.3050@g5.osdl.org>
	<Pine.LNX.4.64.0604021328380.3050@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 23:09:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ9ow-0001yn-0p
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 23:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWDBVJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWDBVJG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 17:09:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54927 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932413AbWDBVJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 17:09:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402210903.UMUI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Apr 2006 17:09:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18285>

Linus Torvalds <torvalds@osdl.org> writes:

> This is the "letter of the law" version of using fgets() properly in the
> face of incredibly broken stdio implementations.  We can work around the
> Solaris breakage with SA_RESTART, but in case anybody else is ever that
> stupid, here's the "safe" (read: "insanely anal") way to use fgets.

Thanks.

It's good that I can say "Oh, I think this is the part that is
broken, but I am going to bed" to find the problem solved by
capable others when I wake up the next day.  Global distributed
development process at the finest, although I suspect Jason,
Linus and myself are all in the same timezone ;-)

Did you mean this as a real change or a demonstration?  The
sigaction change is a real fix, but somehow I find this one
similar to the "(void*) NULL" thing you objected earlier (which
was not merged because I agreed with your argument)...

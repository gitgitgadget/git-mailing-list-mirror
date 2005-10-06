From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Write .editmsg in GIT_DIR to avoid being in git-status.
Date: Thu, 06 Oct 2005 13:19:45 -0700
Message-ID: <7vpsqi8kke.fsf@assigned-by-dhcp.cox.net>
References: <87achnq4z7.fsf@gmail.com>
	<7vk6griq8d.fsf@assigned-by-dhcp.cox.net>
	<8aa486160510060630m2afb18ffx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 22:21:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENcDX-0007vM-W9
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 22:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVJFUTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVJFUTs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 16:19:48 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55538 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751346AbVJFUTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 16:19:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006201941.HOLC4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 16:19:41 -0400
To: Santi Bejar <sbejar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9782>

Santi Bejar <sbejar@gmail.com> writes:

>> If a working tree is read-only, I wonder what you are committing.
>
> I keep my /etc modifications in git, and I want to commit as a
> user not as root.

OK.  Your /etc/.git is writable by you but /etc is not.
Although I personally would do it a bit differently (my /etc
sources would live in a different area which is a source tree
and 'make install' as root would install the latest to /etc; no
need for anything user writable under /etc, including
/etc/.git/), I do not think your set-up is wrong -- we should
support it.

>> ... If the working tree root level is not writable for you,
>> is it valid/reasonable to assume that $GIT_DIR is?

I changed my mind about this.  $GIT_DIR by definition should be
writable by you since we are talking about committing -- I think
moving them to $GIT_DIR/ is a good change.

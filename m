From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Mon, 09 May 2005 19:29:10 -0700
Message-ID: <7v64xru83t.fsf@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 04:22:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVKOV-0006Se-92
	for gcvg-git@gmane.org; Tue, 10 May 2005 04:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVEJC3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 22:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVEJC3Y
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 22:29:24 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10636 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261438AbVEJC3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 22:29:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510022911.WOZY26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 22:29:11 -0400
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc05050911255e601fc@mail.gmail.com> (Morten Welinder's
 message of "Mon, 9 May 2005 14:25:29 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MW" == Morten Welinder <mwelinder@gmail.com> writes:

MW> git-checkout-cache is having problems when files change from directories to
MW> plain files or vice versa.

Changing files vs directories _is_ a big change and happens
rarely in practice; I think the current behaviour is
justified---it makes the user take notice and the user _should_
take notice.

Porcelain layer, if it wanted to, should be able to hide this
from the user, but it depends on which Porcelain layer command
is involved.  My understanding of cg-seek is to switch the work
tree to a completely different state, so in that case it
probably should hide this (still it makes me feel a bit nervous
to realize that I am advocating for the tool to silently remove
a whole subtree to make room for a file, though).


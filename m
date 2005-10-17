From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-merge should use git-merge
Date: Mon, 17 Oct 2005 02:26:06 -0700
Message-ID: <7vach81olt.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510161644l35119401rdc05c081506ae715@mail.gmail.com>
	<46a038f90510161744m7e95303eu8a9942363ffc58a6@mail.gmail.com>
	<7vzmp81r4n.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510170203ndee2b2bi913b62014614f68e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 17 11:27:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERRGH-0007t6-E9
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 11:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVJQJ0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 05:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVJQJ0J
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 05:26:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17036 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932218AbVJQJ0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 05:26:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051017092557.FQNQ19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Oct 2005 05:25:57 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510170203ndee2b2bi913b62014614f68e@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 17 Oct 2005 22:03:02 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10183>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Something like a manual merge that I could force to happen on command
>
>    git-doarbitrarymergeontree -r fromtree:totree  [ victimtree ]
>

That essentially is a simple one-liner:

     git-read-tree -m -u fromtree HEAD totree

which is more or less what git-cherry-pick and git-revert do,
except fromtree always is totree^ in git-cherry-pick.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unexpected behavior in git-rev-list
Date: Wed, 21 Sep 2005 11:34:01 -0700
Message-ID: <7vfyryw9ra.fsf@assigned-by-dhcp.cox.net>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
	<Pine.LNX.4.58.0509181013250.26803@g5.osdl.org>
	<20050918175847.GA10427@ebar091.ebar.dtu.dk>
	<20050921164948.GB23525@ebar091.ebar.dtu.dk>
	<Pine.LNX.4.58.0509211022180.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 20:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI9Q2-0005bR-IX
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 20:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVIUSeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 14:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVIUSeF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 14:34:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:1949 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751367AbVIUSeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 14:34:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921183402.IGEE28168.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 14:34:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509211022180.2553@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 21 Sep 2005 10:40:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9067>

Linus Torvalds <torvalds@osdl.org> writes:

> It might be best not being done by git-rev-list, but by a specialized 
> program. However, the advantage of doing it in git-rev-list is that then 
> things like "git log" and "gitk" would automatically take advantage of it, 
> ie you could say
>
> 	gitk v2.6.12.. drivers/char/
>
> and it would show a "cut-down" revision tree that only contained the stuff 
> that changed anything in drivers/char/.

Wouldn't gitk get confused by the sparse set of commits your
rev-list feeds it, when it tries to draw ancestry lines and find
many commits missing in between them?

Ah, you told him to use 'rev-list --parents' and you can rewrite
the list of parents there -- clever.

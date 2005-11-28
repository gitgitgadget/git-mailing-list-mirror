From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Mon, 28 Nov 2005 00:32:42 -0800
Message-ID: <7v64qdyxxx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511260855560.13959@g5.osdl.org>
	<7vr792fnta.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
	<20051127182244.GK22159@pasky.or.cz>
	<Pine.LNX.4.64.0511271049090.13959@g5.osdl.org>
	<7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511271742520.13959@g5.osdl.org>
	<7vpsol1ett.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511272219420.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 09:34:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgeRQ-0004R1-Ms
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 09:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVK1Ico (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVK1Ico
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 03:32:44 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35258 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751243AbVK1Icn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 03:32:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128083116.ECVI17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 03:31:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511272219420.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Nov 2005 22:48:08 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12859>

Linus Torvalds <torvalds@osdl.org> writes:

> BTW! It fails a few of the tests, but it does so because now, with "-r", 
> it will never show the tree entries, and because of the difference between
>
> 	git-ls-tree $tree path
>
> and
>
> 	git-ls-tree $tree path/
>
> that it didn't use to have (oh, and if you give multiple paths, it will 
> now always consider them a "union pathspec", not an "iteration of paths"). 
> But I _think_ the new behaviour is pretty useful and while not the same as 
> "ls", it's perhaps still intuitive enough..

The difference between path and path/ is very cute ;-).  I do
not do Porcelain myself, so I am OK with this change, but this
would involve some changes to the Porcelain.

So let's cook this for a while and have Porcelain people holler
if they find something lacking.  I'll put this in the proposed
updates tonight, and we will plan to push everything in the
proposed updates branch to the master branch on Wednesday, with
any fixes and updates necessary.

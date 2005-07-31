From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 13:33:58 -0700
Message-ID: <7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0507311305170.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 22:34:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzKVg-000260-Gy
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 22:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVGaUeC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 16:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVGaUeC
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 16:34:02 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38555 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261993AbVGaUeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 16:34:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731203358.EOLX15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 16:33:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507311305170.29650@g5.osdl.org> (Linus Torvalds's message of "Sun, 31 Jul 2005 13:11:58 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> This looks sane. However, I also get the strong feeling that
> git-update-server-info should be run as part of a hook and not be built 
> into receive-pack..

> Personally, I simply don't want to update any dumb server info stuff for 
> my own local repositories - it's not like I'm actually serving those out 
> anyway.

But you are.  I can run this just fine:

 $ git clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/ linus

I agree in principle that you should be able to disable the call
to update_server_info() from there, but on the other hand once
we start doing it, we need to explain people which repo is http
capable and which repo is not and why.

I was actually thinking about a call to git-update-server-info
at the end of git-repack-script.  Again, great minds think the
opposite way sometimes ;-).

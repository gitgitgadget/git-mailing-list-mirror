From: Junio C Hamano <junkio@cox.net>
Subject: Re: Allow one-way tree merge to remove old files
Date: Sun, 14 May 2006 10:51:19 -0700
Message-ID: <7vy7x41omg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 19:51:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfKkS-0000PV-UD
	for gcvg-git@gmane.org; Sun, 14 May 2006 19:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWENRvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWENRvR
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 13:51:17 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29428 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751307AbWENRvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 13:51:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514175116.GBSC24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 13:51:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 14 May 2006 10:43:50 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19974>

Linus Torvalds <torvalds@osdl.org> writes:

> For some random reason (probably just because nobody noticed), the one-way 
> merge strategy didn't mark deleted files as deleted, so if you used
>
> 	git-read-tree -m -u <newtree>
>
> it would update the files that got changed in the index, but it would not 
> delete the files that got deleted.

Good catch.  I think it is a leftover from the days we did not
have -u there; returning 0 was a way to say "there is no cache
entry resulting from this round of path-merge".

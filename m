From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Sat, 02 Sep 2006 14:27:28 -0700
Message-ID: <7vwt8mx8lb.fsf@assigned-by-dhcp.cox.net>
References: <44F977C0.4060901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 02 23:27:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJd1j-00044C-Cc
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 23:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWIBV1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWIBV1X
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 17:27:23 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7850 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751611AbWIBV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 17:27:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902212722.XEAA21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Sep 2006 17:27:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HZTN1V00c1kojtg0000000
	Sat, 02 Sep 2006 17:27:23 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F977C0.4060901@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sat, 02 Sep 2006 14:23:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26359>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Currently git-archive-tree -f tar is slower than git-tar-tree.  This is
> because it is welded to the side of the existing code to minimize patch
> size, and I also suspect read_tree_recursive() to be quite a bit slower
> than builtin-tar-tree.c::traverse_tree().

Yes, I suspect "struct object" and friends are very inefficient
to use for things like this.  "struct tree_desc" based traverser
is much preferred.



-- 
VGER BF report: U 0.772588

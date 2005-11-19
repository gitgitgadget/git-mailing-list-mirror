From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: moving all three panes if clicking on an arrow.
Date: Sat, 19 Nov 2005 00:31:47 -0800
Message-ID: <7vfyptavik.fsf@assigned-by-dhcp.cox.net>
References: <20051105195529.GB6081@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 09:33:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdO8m-0001iU-Rx
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 09:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVKSIbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 03:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVKSIbu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 03:31:50 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34222 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750953AbVKSIbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 03:31:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119083117.GJJI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 03:31:17 -0500
To: paulus@samba.org
In-Reply-To: <20051105195529.GB6081@scotty.home> (Stefan-W. Hahn's message of
	"Sat, 5 Nov 2005 20:55:29 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12323>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> [PATCH] gitk: moving all three panes if clicking on an arrow.
>
> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>

Obviously correct and much more pleasant to use.

Acked-by: Junio C Hamano <junkio@cox.net>

Paul, I earlier sent a pull request; I included this patch there
as well.  So you will find the following four.

commit e3fe532ddce7311cfbbdc98d2e157d33f6275231
Author: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
Date:   Sat Nov 5 20:55:29 2005 +0100

    gitk: moving all three panes if clicking on an arrow.
    
    Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

commit fd913b39101c6ff185e76e459479621c9b475fa1
Author: Pavel Roskin <proski@gnu.org>
Date:   Fri Nov 11 10:09:12 2005 -0500

    gitk: use git-diff-tree --no-commit-id
    
    gitk switched to use git-diff-tree with one argument in gettreediffs and
    getblobdiffs.  git-diff-tree with one argument outputs commit ID in from
    of the patch.  This causes an empty line after "Comments" in the lower
    right pane.  Also, the diff in the lower left pane has the commit ID,
    which is useless there.
    
    This patch makes git use the newly added -no-commit-id option for
    git-diff-tree to suppress commit ID.  It also removes the p variable in
    both functions, since it has become useless after switching to the
    one-argument invocation for git-diff-tree.
    
    Signed-off-by: Pavel Roskin <proski@gnu.org>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

commit e246483dc5b56d7deb04a93b0aa08aba4cde0625
Author: Frank Sorenson <frank@tuxrocks.com>
Date:   Sun Oct 30 02:06:46 2005 -0700

    gitk: Specify line hover font
    
    Hovering over a line in gitk displays the commit one-liner in a
    box, but the text usually overflows the box.  The box size is
    computed with a specified font, so this patch sets the text font
    as well.
    
    Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

commit 36a7cad6e4ae8a331731666d985a7619a76bb4fb
Author: Junio C Hamano <junkio@cox.net>
Date:   Fri Nov 18 23:54:17 2005 -0800

    readrefs: grab all refs with one call to ls-remote.
    
    Instead of reading refs/heads/* and refs/tags/* files ourselves
    and missing files in subdirectories of heads/ and tags/, use
    ls-remote on local repository and grab all of them.  This lets us
    also remove the procedure readotherrefs.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add "-f" option to git-commit-script to force commit
 withoutchanges
Date: Fri, 29 Jul 2005 13:06:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507291300340.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507281646340.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vslxypcw6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:12:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DySmT-0002P9-QM
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 13:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVG2LLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 07:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVG2LIc
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 07:08:32 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19075 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262453AbVG2LGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 07:06:07 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7C8B5E1313; Fri, 29 Jul 2005 13:06:06 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 59D07A873C; Fri, 29 Jul 2005 13:06:06 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 15F7EA873D; Fri, 29 Jul 2005 13:06:06 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 06EB4E1313; Fri, 29 Jul 2005 13:06:06 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslxypcw6.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Junio C Hamano wrote:

> While I agree there should be a graceful way to go back to the
> original head from a failed merge situation, I do not think
> "committing the current HEAD" is the right model for the end
> user to think about it.
>
> Wouldn't using "checkout -f" to revert to the version you would
> want to go back work as expected?

I had the following situation: in a throw away tree I made some changes.
The last conflicted with a change I pulled from somewhere else into the
master, and the best solution was to revert that last change from the
throw away tree. Basically, the result of the merge was identical to
master, i.e. git-status says "nothing to commit". I wanted to document,
however, that I do not want that change from the throw away tree in my
master, even if I keep it in the throw away tree.

I am no longer sure if that was a good thing to do, maybe I should have
fixed it in the throw away tree by merging master there. Or, alternatively
git-commit could check for "nothing to commit" OR "MERGE_HEAD exists".
Dunno.

Ciao,
Dscho

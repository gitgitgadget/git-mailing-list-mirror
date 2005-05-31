From: Zack Brown <zbrown@tumblerings.org>
Subject: cg-seek messed me up
Date: Tue, 31 May 2005 07:33:18 -0700
Message-ID: <20050531143318.GB27047@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 31 16:33:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd7n3-0001lA-Pp
	for gcvg-git@gmane.org; Tue, 31 May 2005 16:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVEaOet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 10:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEaOe3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 10:34:29 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:8383 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261674AbVEaOda
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 10:33:30 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1Dd7ny-0005jO-Ik
	for git@vger.kernel.org; Tue, 31 May 2005 07:33:18 -0700
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm not positive, but I *think* I shot myself in the foot by doing a cg-seek
when there were uncommitted changes in my working file set. The patching process
created duplicate areas in the files, while losing other areas and giving
patch rejects. Before I figured out the problem, I wasn't even able to seek to a
known state because of this, so I ended up having to recreate the files as best
as I could from the mess I was left with in the working directory. I realize I
could have gotten a clean tree by cloning, but this didn't occur to me at the
time. It seemed like the whole repository was just corrupt.

I think I recovered everything, and I know it was my own mistake, but it
seems like this will be a common blunder by users. Maybe cg-seek should
first do a comparison between the working tree and the most recent known
state. If the two differ, it should exit with an error.

Be well,
Zack

-- 
Zack Brown

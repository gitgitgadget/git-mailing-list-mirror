From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Multiple pulls from the same branch in .git/remotes/origin
Date: Mon, 7 Aug 2006 15:51:16 +0300
Message-ID: <20060807125116.GA28658@mellanox.co.il>
References: <20060727140343.GS9411@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 07 14:51:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA4Zm-0000W1-My
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 14:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWHGMvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 08:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHGMvT
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 08:51:19 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:56745 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932096AbWHGMvS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 08:51:18 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 64737d44.2392038320.32212.00-002.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 06:51:18 -0600 (MDT)
Received: from mellanox.co.il ([10.4.3.68]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 7 Aug 2006 15:57:11 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  7 Aug 2006 15:51:16 +0300
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060727140343.GS9411@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 12:57:11.0421 (UTC) FILETIME=[FF74EAD0:01C6BA20]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25011>

Hi, all!
I have
> git --version
git version 1.4.2.rc3.g0d95
and I have put the following in .git/remotes/origin

>cat .git/remotes/origin
URL: ssh://mst@frodo/scm/git/linux-2.6
Pull: refs/heads/linus_master:refs/heads/origin
Pull: refs/heads/linus_master:refs/heads/linus_master_branch

now I get:

>git fetch origin
error: no such remote ref refs/heads/linus_master
Fetch failure: ssh://mst@frodo/scm/git/linux-2.6

However, if I remove the second line, like this:

>cat .git/remotes/origin
URL: ssh://mst@frodo/scm/git/linux-2.6
Pull: refs/heads/linus_master:refs/heads/origin

I get remote linus_master properly fetched into local origin.
Two questions:
1. Isn't is possible to pull from the same remote branch into multiple local
   branches?
2. Even if not, isn't the error message above a bit strange?
   After all, the remote branch *does* exist.

Thanks,

-- 
MST

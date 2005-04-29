From: David Lang <david.lang@digitalinsight.com>
Subject: git network protocol
Date: Fri, 29 Apr 2005 13:42:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504291333550.7439@qynat.qvtvafvgr.pbz>
References: <20050429194753.GA14222@uglybox.localnet> <200504291954.MAA27561@emf.net>
 <20050429202117.GA15417@uglybox.localnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri Apr 29 22:39:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcFr-00005L-Ls
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVD2Unz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVD2Uns
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:43:48 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:8373 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262940AbVD2Umu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:42:50 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Fri, 29 Apr 2005 13:37:38 -0700
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <JRMQ70CN>; Fri, 29 Apr 2005 16:42:23 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id JR4TYVWG; Fri, 29 Apr 2005 13:41:35 -0700
To: git@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20050429202117.GA15417@uglybox.localnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

would it make sense for the network git protocol to be something along the 
lines of

client contacts server and sends
the tag you want to sync with (defaults to head)
the local index file

then the server can use the git tools locally to figure out what objects 
need to be sent to do the merge and only send those objects.

no this isn't as efficiant as only sending diffs, but it avoids sending 
any objects that aren't needed (which would be sent if you just did a 
straight rsync)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

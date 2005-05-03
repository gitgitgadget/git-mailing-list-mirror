From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: questions about cg-update, cg-pull, and cg-clone.
Date: Tue, 3 May 2005 10:20:57 -0700
Message-ID: <20050503172057.GW4747@ca-server1.us.oracle.com>
References: <20050430005322.GA5408@tumblerings.org> <20050502195846.GC20818@pasky.ji.cz> <20050503152214.GA1704@tumblerings.org> <20050503155915.GV4747@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 19:16:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT0zG-00012z-QL
	for gcvg-git@gmane.org; Tue, 03 May 2005 19:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVECRVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVECRVQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 13:21:16 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:14247 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261426AbVECRVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 13:21:06 -0400
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.191.12])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j43HKwlx007039;
	Tue, 3 May 2005 12:20:58 -0500
Received: from rgmgw3.us.oracle.com (localhost [127.0.0.1])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j43HKvXq031274;
	Tue, 3 May 2005 11:20:57 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j43HKvwX031269;
	Tue, 3 May 2005 11:20:57 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.50)
	id 1DT14r-0000cH-8O; Tue, 03 May 2005 10:20:57 -0700
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050503155915.GV4747@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 08:59:15AM -0700, Joel Becker wrote:
> 	Then you change the first file, adding a few functions.  You
> commit it, and it now has the hash 111111.  This change means the tree
> hash becomes 222222.  So, HEAD contains 222222.
> 	You then update from Petr again.  He's changed the second file.
> It's hash is no longer cccccc, it's eeeeee.  In his tree, the hash of
> the tree is 333333 (from file 1's aaaaaa and file 2's eeeeee).  But the
> hash of your tree is 444444 (from your local file 1's 111111 and file 2's eeeeee).  So, the hash of the your tree becomes 444444.  Your HEAD contains 444444.
> This does _not_ match his 333333 HEAD.  You are committing the
> combination of his change and yours.  He is saying that this work, which
> may have required hand-merging or commit resolution, is "interesting"
> information.

	Actually, it is more than interesting.  The tree has gone from a
HEAD of 222222 to a HEAD of 444444.  When HEAD changes, you need a
commit to describe the path.  Otherwise, you have a breakdown in the
history.  cg-log (or any other command) would have no way to get back
from 444444 to 222222 (or Petr's 333333) without the commit object
specifying its parent(s).
	If you have made no commits on your side, then the old HEAD is
Petr's old HEAD, the new HEAD is Petr's new 333333, and he's already
created a commit object describing this.  You're just fast-forwarding.

Joel

-- 

"The nice thing about egotists is that they don't talk about other
 people."
         - Lucille S. Harper

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
